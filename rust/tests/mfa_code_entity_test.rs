// Generated basic-flow test for the mfa_code entity (model-driven;
// mirrors the go TestEntity generator).

#![allow(unused_variables, unused_mut, unused_imports)]

mod common;

use std::rc::Rc;

use common::*;

use smsapi_sdk::core::helpers::{getp, getpath, ja, jo, now_ms, setp, to_map};
use smsapi_sdk::utility::voxgigstruct as vs;
use smsapi_sdk::{test_sdk, Entity, SmsapiEntity, SmsapiSDK, Value};

#[test]
fn mfa_code_entity_instance() {
    let testsdk = test_sdk(Value::Noval, Value::Noval);
    let ent = testsdk.mfa_code(Value::Noval);
    assert_eq!(ent.get_name(), "mfa_code");
}

#[test]
fn mfa_code_entity_basic() {
    let setup = mfa_code_basic_setup(Value::Noval);
    // Per-op sdk-test-control.json skip — the basic test exercises a flow
    // with multiple ops; skipping any op skips the whole flow.
    let mode = if setup.live { "live" } else { "unit" };
    for op in ["create"] {
        let (skip, reason) = is_control_skipped("entityOp", &format!("mfa_code.{}", op), mode);
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
        eprintln!("skip: live entity test uses synthetic IDs from fixture — set SMSAPI_TEST_MFA_CODE_ENTID JSON to run live");
        return;
    }
    let client = setup.client.clone();
    // CREATE
    let mfa_code_ref01_ent = client.mfa_code(Value::Noval);
    let mfa_code_ref01_data = to_map(&getp(
        &getpath(&["new", "mfa_code"], &setup.data),
        "mfa_code_ref01",
    ));

    let mfa_code_ref01_data_result = mfa_code_ref01_ent
        .create(mfa_code_ref01_data.clone(), Value::Noval)
        .expect("create failed");
    let mfa_code_ref01_data = to_map(&mfa_code_ref01_data_result.data(None));
    assert!(
        matches!(mfa_code_ref01_data, Value::Map(_)),
        "expected create result to be a map"
    );

}

fn mfa_code_basic_setup(extra: Value) -> EntityTestSetup {
    load_env_local();

    let mut entity_data_file = manifest_dir();
    entity_data_file.push("..");
    entity_data_file.push(".sdk");
    entity_data_file.push("test");
    entity_data_file.push("entity");
    entity_data_file.push("mfa_code");
    entity_data_file.push("MfaCodeTestData.json");

    let entity_data = read_json(&entity_data_file);

    let options = jo(vec![("entity", getp(&entity_data, "existing"))]);

    let client = test_sdk(options, extra.clone());

    // Generate idmap via transform, matching the TS pattern.
    let idmap = vs::transform(
        &ja(vec![Value::str("mfa_code01"), Value::str("mfa_code02"), Value::str("mfa_code03")]),
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
    let entid_env_raw = std::env::var("SMSAPI_TEST_MFA_CODE_ENTID").unwrap_or_default();
    let idmap_overridden =
        !entid_env_raw.trim().is_empty() && entid_env_raw.trim().starts_with('{');

    let env = env_override(jo(vec![
        ("SMSAPI_TEST_MFA_CODE_ENTID", idmap.clone()),
        ("SMSAPI_TEST_LIVE", Value::str("FALSE")),
        ("SMSAPI_TEST_EXPLAIN", Value::str("FALSE")),
        ("SMSAPI_APIKEY", Value::str("")),
    ]));

    let idmap_resolved = match to_map(&getp(&env, "SMSAPI_TEST_MFA_CODE_ENTID")) {
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
