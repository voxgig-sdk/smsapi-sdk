# Contact entity test

import json
import os
import time

import pytest

from smsapi_sdk.utility.voxgig_struct import voxgig_struct as vs
from smsapi_sdk import SmsapiSDK
from smsapi_sdk.core import helpers

_TEST_DIR = os.path.dirname(os.path.abspath(__file__))
from test import runner


class TestContactEntity:

    def test_should_create_instance(self):
        testsdk = SmsapiSDK.test(None, None)
        ent = testsdk.Contact(None)
        assert ent is not None

    def test_should_stream(self):
        # Feature #4: the entity stream(action, ...) method runs the op
        # pipeline and yields result items. With the streaming feature active
        # it yields the feature's incremental output; otherwise it falls back
        # to the materialised list so stream always yields.
        seed = {
            "entity": {
                "contact": {
                    "s1": {"id": "s1"},
                    "s2": {"id": "s2"},
                    "s3": {"id": "s3"},
                }
            }
        }

        # Fallback: streaming inactive -> yields the materialised list items.
        base = SmsapiSDK.test(seed, None)
        seen = list(base.Contact(None).stream("list", None, None))
        assert len(seen) == 3

        # Inbound: streaming active -> yields each item from the feature.
        from smsapi_sdk.config import shared_config
        cfg = shared_config()
        if isinstance(cfg.get("feature"), dict) and "streaming" in cfg["feature"]:
            sdk = SmsapiSDK.test(
                seed, {"feature": {"streaming": {"active": True}}})
            got = []
            for item in sdk.Contact(None).stream("list", None, None):
                if isinstance(item, list):
                    got.extend(item)
                else:
                    got.append(item)
            assert len(got) == 3

    def test_should_run_basic_flow(self):
        setup = _contact_basic_setup(None)
        # Per-op sdk-test-control.json skip — basic test exercises a flow with
        # multiple ops; skipping any one skips the whole flow (steps depend
        # on each other).
        _live = setup.get("live", False)
        for _op in ["create", "list", "update", "load", "remove"]:
            _skip, _reason = runner.is_control_skipped("entityOp", "contact." + _op, "live" if _live else "unit")
            if _skip:
                pytest.skip(_reason or "skipped via sdk-test-control.json")
                return
        # The basic flow consumes synthetic IDs from the fixture. In live mode
        # without an *_ENTID env override, those IDs hit the live API and 4xx.
        if setup.get("synthetic_only"):
            pytest.skip("live entity test uses synthetic IDs from fixture — "
                        "set SMSAPI_TEST_CONTACT_ENTID JSON to run live")
        client = setup["client"]

        # CREATE
        contact_ref01_ent = client.Contact(None)
        contact_ref01_data = helpers.to_map(vs.getprop(
            vs.getpath(setup["data"], "new.contact"), "contact_ref01"))
        contact_ref01_data["group_id"] = setup["idmap"]["group01"]

        contact_ref01_data = helpers.to_map(runner.entity_data(contact_ref01_ent.create(contact_ref01_data, None)))
        assert contact_ref01_data is not None
        assert contact_ref01_data["id"] is not None

        # LIST
        contact_ref01_match = {
            "contact_id": setup["idmap"]["contact01"],
        }

        contact_ref01_list_result = contact_ref01_ent.list(contact_ref01_match, None)
        assert isinstance(contact_ref01_list_result, list)

        found_item = vs.select(
            runner.entity_list_to_data(contact_ref01_list_result),
            {"id": contact_ref01_data["id"]})
        assert not vs.isempty(found_item)

        # UPDATE
        contact_ref01_data_up0_up = {
            "id": contact_ref01_data["id"],
        }

        contact_ref01_markdef_up0_name = "birthday_date"
        contact_ref01_markdef_up0_value = "Mark01-contact_ref01_" + str(setup["now"])
        contact_ref01_data_up0_up[contact_ref01_markdef_up0_name] = contact_ref01_markdef_up0_value

        contact_ref01_resdata_up0 = helpers.to_map(runner.entity_data(contact_ref01_ent.update(contact_ref01_data_up0_up, None)))
        assert contact_ref01_resdata_up0 is not None
        assert contact_ref01_resdata_up0["id"] == contact_ref01_data_up0_up["id"]
        assert contact_ref01_resdata_up0[contact_ref01_markdef_up0_name] == contact_ref01_markdef_up0_value

        # LOAD
        contact_ref01_match_dt0 = {
            "id": contact_ref01_data["id"],
        }
        contact_ref01_data_dt0_loaded = contact_ref01_ent.load(contact_ref01_match_dt0, None)
        contact_ref01_data_dt0_load_result = helpers.to_map(runner.entity_data(contact_ref01_data_dt0_loaded))
        assert contact_ref01_data_dt0_load_result is not None
        assert contact_ref01_data_dt0_load_result["id"] == contact_ref01_data["id"]

        # REMOVE
        contact_ref01_match_rm0 = {
            "id": contact_ref01_data["id"],
        }
        contact_ref01_ent.remove(contact_ref01_match_rm0, None)

        # LIST
        contact_ref01_match_rt0 = {
            "contact_id": setup["idmap"]["contact01"],
        }

        contact_ref01_list_rt0_result = contact_ref01_ent.list(contact_ref01_match_rt0, None)
        assert isinstance(contact_ref01_list_rt0_result, list)

        not_found_item = vs.select(
            runner.entity_list_to_data(contact_ref01_list_rt0_result),
            {"id": contact_ref01_data["id"]})
        assert vs.isempty(not_found_item)



def _contact_basic_setup(extra):
    runner.load_env_local()

    entity_data_file = os.path.join(_TEST_DIR, "../../.sdk/test/entity/contact/ContactTestData.json")
    with open(entity_data_file, "r") as f:
        entity_data_source = f.read()

    entity_data = json.loads(entity_data_source)

    options = {}
    options["entity"] = entity_data.get("existing")

    client = SmsapiSDK.test(options, extra)

    # Generate idmap via transform.
    idmap = vs.transform(
        ["contact01", "contact02", "contact03", "group01", "group02", "group03"],
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
        "SMSAPI_TEST_CONTACT_ENTID")
    _idmap_overridden = _entid_env_raw is not None and _entid_env_raw.strip().startswith("{")

    env = runner.env_override({
        "SMSAPI_TEST_CONTACT_ENTID": idmap,
        "SMSAPI_TEST_LIVE": "FALSE",
        "SMSAPI_TEST_EXPLAIN": "FALSE",
        "SMSAPI_APIKEY": "",
    })

    idmap_resolved = helpers.to_map(
        env.get("SMSAPI_TEST_CONTACT_ENTID"))
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
