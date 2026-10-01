// Generated basic-flow test for the template entity (model-driven;
// mirrors the go TestEntity generator).

#![allow(unused_variables, unused_mut, unused_imports)]

mod common;

use std::rc::Rc;

use common::*;

use smsapi_sdk::core::helpers::{getp, getpath, ja, jo, now_ms, setp, to_map};
use smsapi_sdk::utility::voxgigstruct as vs;
use smsapi_sdk::{test_sdk, Entity, SmsapiEntity, SmsapiSDK, Value};

#[test]
fn template_entity_instance() {
    let testsdk = test_sdk(Value::Noval, Value::Noval);
    let ent = testsdk.template(Value::Noval);
    assert_eq!(ent.get_name(), "template");
}

#[test]
fn template_entity_stream() {
    // stream() runs the list op through the full pipeline and yields each
    // result item. Seed two entities via test mode; with the `streaming`
    // feature active it yields the feature's incremental items, else it
    // falls back to the materialised items — either way every item yields.
    let seed = jo(vec![(
        "entity",
        jo(vec![(
            "template",
            jo(vec![
                ("strm01", jo(vec![("id", Value::str("strm01"))])),
                ("strm02", jo(vec![("id", Value::str("strm02"))])),
            ]),
        )]),
    )]);

    let sdkopts = jo(vec![(
        "feature",
        jo(vec![("streaming", jo(vec![("active", Value::Bool(true))]))]),
    )]);

    let testsdk = test_sdk(seed.clone(), sdkopts);
    let ent = testsdk.template(Value::Noval);
    let items: Vec<Value> = ent
        .stream("list", Value::empty_map(), Value::empty_map())
        .expect("stream failed")
        .collect();
    assert_eq!(items.len(), 2, "stream should yield both seeded items");

    // Fallback: streaming inactive still yields both materialised items.
    let plainsdk = test_sdk(seed, Value::Noval);
    let plainent = plainsdk.template(Value::Noval);
    let plain_items: Vec<Value> = plainent
        .stream("list", Value::empty_map(), Value::empty_map())
        .expect("stream failed")
        .collect();
    assert_eq!(plain_items.len(), 2, "fallback stream should yield both items");
}

#[test]
fn template_entity_basic() {
    let setup = template_basic_setup(Value::Noval);
    // Per-op sdk-test-control.json skip — the basic test exercises a flow
    // with multiple ops; skipping any op skips the whole flow.
    let mode = if setup.live { "live" } else { "unit" };
    for op in ["create", "list", "update", "load"] {
        let (skip, reason) = is_control_skipped("entityOp", &format!("template.{}", op), mode);
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
        eprintln!("skip: live entity test uses synthetic IDs from fixture — set SMSAPI_TEST_TEMPLATE_ENTID JSON to run live");
        return;
    }
    let client = setup.client.clone();
    // CREATE
    let template_ref01_ent = client.template(Value::Noval);
    let template_ref01_data = to_map(&getp(
        &getpath(&["new", "template"], &setup.data),
        "template_ref01",
    ));

    let template_ref01_data_result = template_ref01_ent
        .create(template_ref01_data.clone(), Value::Noval)
        .expect("create failed");
    let template_ref01_data = to_map(&template_ref01_data_result.data(None));
    assert!(
        matches!(template_ref01_data, Value::Map(_)),
        "expected create result to be a map"
    );
    assert!(
        !getp(&template_ref01_data, "id").is_noval(),
        "expected created entity to have an id"
    );

    // LIST
    let template_ref01_match = Value::empty_map();

    let template_ref01_list = template_ref01_ent
        .list(template_ref01_match.clone(), Value::Noval)
        .expect("list failed");
    // list resolves to one ENTITY per record; the flow asserts on the
    // records, so map each through data().
    let template_ref01_list = ja(template_ref01_list.iter().map(|e| e.data(None)).collect::<Vec<Value>>());

    let found_item = vs::select(
        &entity_list_to_data(&template_ref01_list),
        &jo(vec![("id", getp(&template_ref01_data, "id"))]),
    );
    assert!(
        !vs::is_empty(&found_item),
        "expected to find created entity in list"
    );

    // UPDATE
    let template_ref01_data_up0_up = Value::empty_map();
    setp(&template_ref01_data_up0_up, "id", getp(&template_ref01_data, "id"));

    let template_ref01_markdef_up0_name = "name";
    let template_ref01_markdef_up0_value = format!("Mark01-template_ref01_{}", setup.now);
    setp(
        &template_ref01_data_up0_up,
        template_ref01_markdef_up0_name,
        Value::str(template_ref01_markdef_up0_value.clone()),
    );

    let template_ref01_resdata_up0_result = template_ref01_ent
        .update(template_ref01_data_up0_up.clone(), Value::Noval)
        .expect("update failed");
    let template_ref01_resdata_up0 = to_map(&template_ref01_resdata_up0_result.data(None));
    assert!(
        matches!(template_ref01_resdata_up0, Value::Map(_)),
        "expected update result to be a map"
    );
    assert_eq!(
        getp(&template_ref01_resdata_up0, "id"),
        getp(&template_ref01_data_up0_up, "id"),
        "expected update result id to match"
    );
    assert_eq!(
        getp(&template_ref01_resdata_up0, template_ref01_markdef_up0_name),
        Value::str(template_ref01_markdef_up0_value.clone()),
        "expected {} to be updated",
        template_ref01_markdef_up0_name
    );

    // LOAD
    let template_ref01_match_dt0 = jo(vec![("id", getp(&template_ref01_data, "id"))]);
    let template_ref01_data_dt0_loaded = template_ref01_ent
        .load(template_ref01_match_dt0.clone(), Value::Noval)
        .expect("load failed");
    let template_ref01_data_dt0_load_result = to_map(&template_ref01_data_dt0_loaded.data(None));
    assert!(
        matches!(template_ref01_data_dt0_load_result, Value::Map(_)),
        "expected load result to be a map"
    );
    assert_eq!(
        getp(&template_ref01_data_dt0_load_result, "id"),
        getp(&template_ref01_data, "id"),
        "expected load result id to match"
    );

}

fn template_basic_setup(extra: Value) -> EntityTestSetup {
    load_env_local();

    let mut entity_data_file = manifest_dir();
    entity_data_file.push("..");
    entity_data_file.push(".sdk");
    entity_data_file.push("test");
    entity_data_file.push("entity");
    entity_data_file.push("template");
    entity_data_file.push("TemplateTestData.json");

    let entity_data = read_json(&entity_data_file);

    let options = jo(vec![("entity", getp(&entity_data, "existing"))]);

    let client = test_sdk(options, extra.clone());

    // Generate idmap via transform, matching the TS pattern.
    let idmap = vs::transform(
        &ja(vec![Value::str("template01"), Value::str("template02"), Value::str("template03")]),
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
    let entid_env_raw = std::env::var("SMSAPI_TEST_TEMPLATE_ENTID").unwrap_or_default();
    let idmap_overridden =
        !entid_env_raw.trim().is_empty() && entid_env_raw.trim().starts_with('{');

    let env = env_override(jo(vec![
        ("SMSAPI_TEST_TEMPLATE_ENTID", idmap.clone()),
        ("SMSAPI_TEST_LIVE", Value::str("FALSE")),
        ("SMSAPI_TEST_EXPLAIN", Value::str("FALSE")),
        ("SMSAPI_APIKEY", Value::str("")),
    ]));

    let idmap_resolved = match to_map(&getp(&env, "SMSAPI_TEST_TEMPLATE_ENTID")) {
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
