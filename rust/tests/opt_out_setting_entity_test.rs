// Generated basic-flow test for the opt_out_setting entity (model-driven;
// mirrors the go TestEntity generator).

#![allow(unused_variables, unused_mut, unused_imports)]

mod common;

use std::rc::Rc;

use common::*;

use smsapi_sdk::core::helpers::{getp, getpath, ja, jo, now_ms, setp, to_map};
use smsapi_sdk::utility::voxgigstruct as vs;
use smsapi_sdk::{test_sdk, Entity, SmsapiEntity, SmsapiSDK, Value};

#[test]
fn opt_out_setting_entity_instance() {
    let testsdk = test_sdk(Value::Noval, Value::Noval);
    let ent = testsdk.opt_out_setting(Value::Noval);
    assert_eq!(ent.get_name(), "opt_out_setting");
}

#[test]
fn opt_out_setting_entity_basic() {
    let setup = opt_out_setting_basic_setup(Value::Noval);
    // Per-op sdk-test-control.json skip — the basic test exercises a flow
    // with multiple ops; skipping any op skips the whole flow.
    let mode = if setup.live { "live" } else { "unit" };
    for op in ["update", "load"] {
        let (skip, reason) = is_control_skipped("entityOp", &format!("opt_out_setting.{}", op), mode);
        if skip {
            let reason = if reason.is_empty() {
                "skipped via sdk-test-control.json".to_string()
            } else {
                reason
            };
            eprintln!("skip: {}", reason);
            return;
        }
    }
    // The basic flow consumes synthetic IDs from the fixture. In live mode
    // without an *_ENTID env override, those IDs hit the live API and 4xx.
    if setup.synthetic_only {
        eprintln!("skip: live entity test uses synthetic IDs from fixture — set SMSAPI_TEST_OPT_OUT_SETTING_ENTID JSON to run live");
        return;
    }
    let client = setup.client.clone();

    // Bootstrap entity data from existing test data (no create step in flow).
    let opt_out_setting_ref01_data_raw = vs::items(&to_map(&getpath(&["existing", "opt_out_setting"], &setup.data)));
    let opt_out_setting_ref01_data = to_map(&vs::get_elem(
        &vs::get_elem(&opt_out_setting_ref01_data_raw, &Value::Num(0.0), Value::Noval),
        &Value::Num(1.0),
        Value::Noval,
    ));
    // UPDATE
    let opt_out_setting_ref01_ent = client.opt_out_setting(Value::Noval);
    let opt_out_setting_ref01_data_up0_up = Value::empty_map();

    let opt_out_setting_ref01_markdef_up0_name = "brand";
    let opt_out_setting_ref01_markdef_up0_value = format!("Mark01-opt_out_setting_ref01_{}", setup.now);
    setp(
        &opt_out_setting_ref01_data_up0_up,
        opt_out_setting_ref01_markdef_up0_name,
        Value::str(opt_out_setting_ref01_markdef_up0_value.clone()),
    );

    let opt_out_setting_ref01_resdata_up0_result = opt_out_setting_ref01_ent
        .update(opt_out_setting_ref01_data_up0_up.clone(), Value::Noval)
        .expect("update failed");
    let opt_out_setting_ref01_resdata_up0 = to_map(&opt_out_setting_ref01_resdata_up0_result.data(None));
    assert!(
        matches!(opt_out_setting_ref01_resdata_up0, Value::Map(_)),
        "expected update result to be a map"
    );
    assert_eq!(
        getp(&opt_out_setting_ref01_resdata_up0, opt_out_setting_ref01_markdef_up0_name),
        Value::str(opt_out_setting_ref01_markdef_up0_value.clone()),
        "expected {} to be updated",
        opt_out_setting_ref01_markdef_up0_name
    );

    // LOAD
    let opt_out_setting_ref01_match_dt0 = Value::empty_map();
    let opt_out_setting_ref01_data_dt0_loaded = opt_out_setting_ref01_ent
        .load(opt_out_setting_ref01_match_dt0.clone(), Value::Noval)
        .expect("load failed");
    // load resolves to the ENTITY; the record is reached through data().
    assert!(
        !opt_out_setting_ref01_data_dt0_loaded.data(None).is_noval(),
        "expected load result to carry data"
    );

}

fn opt_out_setting_basic_setup(extra: Value) -> EntityTestSetup {
    load_env_local();

    let mut entity_data_file = manifest_dir();
    entity_data_file.push("..");
    entity_data_file.push(".sdk");
    entity_data_file.push("test");
    entity_data_file.push("entity");
    entity_data_file.push("opt_out_setting");
    entity_data_file.push("OptOutSettingTestData.json");

    let entity_data = read_json(&entity_data_file);

    let options = jo(vec![("entity", getp(&entity_data, "existing"))]);

    let client = test_sdk(options, extra.clone());

    // Generate idmap via transform, matching the TS pattern.
    let idmap = vs::transform(
        &ja(vec![Value::str("opt_out_setting01"), Value::str("opt_out_setting02"), Value::str("opt_out_setting03")]),
        &jo(vec![(
            "`$PACK`",
            ja(vec![
                Value::str(""),
                jo(vec![
                    ("`$KEY`", Value::str("`$COPY`")),
                    (
                        "`$VAL`",
                        ja(vec![
                            Value::str("`$FORMAT`"),
                            Value::str("upper"),
                            Value::str("`$COPY`"),
                        ]),
                    ),
                ]),
            ]),
        )]),
        None,
    )
    .unwrap_or_else(|_| Value::empty_map());

    // Detect ENTID env override before env_override consumes it. When live
    // mode is on without a real override, the basic test runs against
    // synthetic IDs from the fixture and 4xx's.
    let entid_env_raw = std::env::var("SMSAPI_TEST_OPT_OUT_SETTING_ENTID").unwrap_or_default();
    let idmap_overridden =
        !entid_env_raw.trim().is_empty() && entid_env_raw.trim().starts_with('{');

    let env = env_override(jo(vec![
        ("SMSAPI_TEST_OPT_OUT_SETTING_ENTID", idmap.clone()),
        ("SMSAPI_TEST_LIVE", Value::str("FALSE")),
        ("SMSAPI_TEST_EXPLAIN", Value::str("FALSE")),
        ("SMSAPI_APIKEY", Value::str("")),
    ]));

    let idmap_resolved = match to_map(&getp(&env, "SMSAPI_TEST_OPT_OUT_SETTING_ENTID")) {
        Value::Map(m) => Value::Map(m),
        _ => to_map(&idmap),
    };

    let live = getp(&env, "SMSAPI_TEST_LIVE") == Value::str("TRUE");

    let client = if live {
        let merged = vs::merge(
            // live_client_options() FIRST, so the generated entries below win:
            // sdk-test-control.json's test.client.options adds to the live
            // client, it does not redirect it.
            &ja(vec![
                live_client_options(),
                jo(vec![("apikey", getp(&env, "SMSAPI_APIKEY"))]),
                // A NON-NODE later entry REPLACES the accumulated map in
                // vs::merge, and the normal call passes Value::Noval - so a
                // a bare extra discarded live_client_options() and the
                // apikey/server map above it, and the live client was
                // constructed with nothing.
                match extra {
                    Value::Map(m) => Value::Map(m),
                    _ => Value::empty_map(),
                },
            ]),
            None,
        );
        SmsapiSDK::new(to_map(&merged))
    } else {
        client
    };

    EntityTestSetup {
        client,
        data: entity_data,
        idmap: idmap_resolved,
        env: env.clone(),
        explain: getp(&env, "SMSAPI_TEST_EXPLAIN") == Value::str("TRUE"),
        live,
        synthetic_only: live && !idmap_overridden,
        now: now_ms(),
    }
}
