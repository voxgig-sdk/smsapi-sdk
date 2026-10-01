# Blacklist entity test

import json
import os
import time

import pytest

from smsapi_sdk.utility.voxgig_struct import voxgig_struct as vs
from smsapi_sdk import SmsapiSDK
from smsapi_sdk.core import helpers

_TEST_DIR = os.path.dirname(os.path.abspath(__file__))
from test import runner


class TestBlacklistEntity:

    def test_should_create_instance(self):
        testsdk = SmsapiSDK.test(None, None)
        ent = testsdk.Blacklist(None)
        assert ent is not None

    def test_should_run_basic_flow(self):
        setup = _blacklist_basic_setup(None)
        # Per-op sdk-test-control.json skip — basic test exercises a flow with
        # multiple ops; skipping any one skips the whole flow (steps depend
        # on each other).
        _live = setup.get("live", False)
        for _op in ["create", "load", "remove"]:
            _skip, _reason = runner.is_control_skipped("entityOp", "blacklist." + _op, "live" if _live else "unit")
            if _skip:
                pytest.skip(_reason or "skipped via sdk-test-control.json")
                return
        # The basic flow consumes synthetic IDs from the fixture. In live mode
        # without an *_ENTID env override, those IDs hit the live API and 4xx.
        if setup.get("synthetic_only"):
            pytest.skip("live entity test uses synthetic IDs from fixture — "
                        "set SMSAPI_TEST_BLACKLIST_ENTID JSON to run live")
        client = setup["client"]

        # CREATE
        blacklist_ref01_ent = client.Blacklist(None)
        blacklist_ref01_data = helpers.to_map(vs.getprop(
            vs.getpath(setup["data"], "new.blacklist"), "blacklist_ref01"))

        blacklist_ref01_data = helpers.to_map(runner.entity_data(blacklist_ref01_ent.create(blacklist_ref01_data, None)))
        assert blacklist_ref01_data is not None
        assert blacklist_ref01_data["id"] is not None

        # LOAD
        blacklist_ref01_match_dt0 = {
            "id": blacklist_ref01_data["id"],
        }
        blacklist_ref01_data_dt0_loaded = blacklist_ref01_ent.load(blacklist_ref01_match_dt0, None)
        blacklist_ref01_data_dt0_load_result = helpers.to_map(runner.entity_data(blacklist_ref01_data_dt0_loaded))
        assert blacklist_ref01_data_dt0_load_result is not None
        assert blacklist_ref01_data_dt0_load_result["id"] == blacklist_ref01_data["id"]

        # REMOVE
        blacklist_ref01_match_rm0 = {
            "id": blacklist_ref01_data["id"],
        }
        blacklist_ref01_ent.remove(blacklist_ref01_match_rm0, None)



def _blacklist_basic_setup(extra):
    runner.load_env_local()

    entity_data_file = os.path.join(_TEST_DIR, "../../.sdk/test/entity/blacklist/BlacklistTestData.json")
    with open(entity_data_file, "r") as f:
        entity_data_source = f.read()

    entity_data = json.loads(entity_data_source)

    options = {}
    options["entity"] = entity_data.get("existing")

    client = SmsapiSDK.test(options, extra)

    # Generate idmap via transform.
    idmap = vs.transform(
        ["blacklist01", "blacklist02", "blacklist03"],
        {
            "`$PACK`": ["", {
                "`$KEY`": "`$COPY`",
                "`$VAL`": ["`$FORMAT`", "upper", "`$COPY`"],
            }],
        }
    )

    # Detect ENTID env override before envOverride consumes it. When live
    # mode is on without a real override, the basic test runs against synthetic
    # IDs from the fixture and 4xx's. We surface this so the test can skip.
    _entid_env_raw = os.environ.get(
        "SMSAPI_TEST_BLACKLIST_ENTID")
    _idmap_overridden = _entid_env_raw is not None and _entid_env_raw.strip().startswith("{")

    env = runner.env_override({
        "SMSAPI_TEST_BLACKLIST_ENTID": idmap,
        "SMSAPI_TEST_LIVE": "FALSE",
        "SMSAPI_TEST_EXPLAIN": "FALSE",
        "SMSAPI_APIKEY": "",
    })

    idmap_resolved = helpers.to_map(
        env.get("SMSAPI_TEST_BLACKLIST_ENTID"))
    if idmap_resolved is None:
        idmap_resolved = helpers.to_map(idmap)

    if env.get("SMSAPI_TEST_LIVE") == "TRUE":
        merged_opts = vs.merge([
            # FIRST, so the generated fields below win: sdk-test-control.json's
            # test.client.options adds to the live client, it does not
            # redirect it.
            runner.live_client_options(),
            {
                "apikey": env.get("SMSAPI_APIKEY"),
            },
            extra or {},
        ])
        client = SmsapiSDK(helpers.to_map(merged_opts))

    _live = env.get("SMSAPI_TEST_LIVE") == "TRUE"
    return {
        "client": client,
        "data": entity_data,
        "idmap": idmap_resolved,
        "env": env,
        "explain": env.get("SMSAPI_TEST_EXPLAIN") == "TRUE",
        "live": _live,
        "synthetic_only": _live and not _idmap_overridden,
        "now": int(time.time() * 1000),
    }
