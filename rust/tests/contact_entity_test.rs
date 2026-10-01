// Generated basic-flow test for the contact entity (model-driven;
// mirrors the go TestEntity generator).

#![allow(unused_variables, unused_mut, unused_imports)]

mod common;

use std::rc::Rc;

use common::*;

use smsapi_sdk::core::helpers::{getp, getpath, ja, jo, now_ms, setp, to_map};
use smsapi_sdk::utility::voxgigstruct as vs;
use smsapi_sdk::{test_sdk, Entity, SmsapiEntity, SmsapiSDK, Value};

#[test]
fn contact_entity_instance() {
    let testsdk = test_sdk(Value::Noval, Value::Noval);
    let ent = testsdk.contact(Value::Noval);
    assert_eq!(ent.get_name(), "contact");
}

#[test]
fn contact_entity_stream() {
    // stream() runs the list op through the full pipeline and yields each
    // result item. Seed two entities via test mode; with the `streaming`
    // feature active it yields the feature's incremental items, else it
    // falls back to the materialised items — either way every item yields.
    let seed = jo(vec![(
        "entity",
        jo(vec![(
            "contact",
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
    let ent = testsdk.contact(Value::Noval);
    let items: Vec<Value> = ent
        .stream("list", Value::empty_map(), Value::empty_map())
        .expect("stream failed")
        .collect();
    assert_eq!(items.len(), 2, "stream should yield both seeded items");

    // Fallback: streaming inactive still yields both materialised items.
    let plainsdk = test_sdk(seed, Value::Noval);
    let plainent = plainsdk.contact(Value::Noval);
    let plain_items: Vec<Value> = plainent
        .stream("list", Value::empty_map(), Value::empty_map())
        .expect("stream failed")
        .collect();
    assert_eq!(plain_items.len(), 2, "fallback stream should yield both items");
}

#[test]
fn contact_entity_basic() {
    let setup = contact_basic_setup(Value::Noval);
    // Per-op sdk-test-control.json skip — the basic test exercises a flow
    // with multiple ops; skipping any op skips the whole flow.
    let mode = if setup.live { "live" } else { "unit" };
    for op in ["create", "list", "update", "load", "remove"] {
        let (skip, reason) = is_control_skipped("entityOp", &format!("contact.{}", op), mode);
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
        eprintln!("skip: live entity test uses synthetic IDs from fixture — set SMSAPI_TEST_CONTACT_ENTID JSON to run live");
        return;
    }
    let client = setup.client.clone();
    // CREATE
    let contact_ref01_ent = client.contact(Value::Noval);
    let contact_ref01_data = to_map(&getp(
        &getpath(&["new", "contact"], &setup.data),
        "contact_ref01",
    ));
    setp(&contact_ref01_data, "group_id", getp(&setup.idmap, "group01"));

    let contact_ref01_data_result = contact_ref01_ent
        .create(contact_ref01_data.clone(), Value::Noval)
        .expect("create failed");
    let contact_ref01_data = to_map(&contact_ref01_data_result.data(None));
    assert!(
        matches!(contact_ref01_data, Value::Map(_)),
        "expected create result to be a map"
    );
    assert!(
        !getp(&contact_ref01_data, "id").is_noval(),
        "expected created entity to have an id"
    );

    // LIST
    let contact_ref01_match = Value::empty_map();
    setp(&contact_ref01_match, "contact_id", getp(&setup.idmap, "contact01"));

    let contact_ref01_list = contact_ref01_ent
        .list(contact_ref01_match.clone(), Value::Noval)
        .expect("list failed");
    // list resolves to one ENTITY per record; the flow asserts on the
    // records, so map each through data().
    let contact_ref01_list = ja(contact_ref01_list.iter().map(|e| e.data(None)).collect::<Vec<Value>>());

    let found_item = vs::select(
        &entity_list_to_data(&contact_ref01_list),
        &jo(vec![("id", getp(&contact_ref01_data, "id"))]),
    );
    assert!(
        !vs::is_empty(&found_item),
        "expected to find created entity in list"
    );

    // UPDATE
    let contact_ref01_data_up0_up = Value::empty_map();
    setp(&contact_ref01_data_up0_up, "id", getp(&contact_ref01_data, "id"));

    let contact_ref01_markdef_up0_name = "birthday_date";
    let contact_ref01_markdef_up0_value = format!("Mark01-contact_ref01_{}", setup.now);
    setp(
        &contact_ref01_data_up0_up,
        contact_ref01_markdef_up0_name,
        Value::str(contact_ref01_markdef_up0_value.clone()),
    );

    let contact_ref01_resdata_up0_result = contact_ref01_ent
        .update(contact_ref01_data_up0_up.clone(), Value::Noval)
        .expect("update failed");
    let contact_ref01_resdata_up0 = to_map(&contact_ref01_resdata_up0_result.data(None));
    assert!(
        matches!(contact_ref01_resdata_up0, Value::Map(_)),
        "expected update result to be a map"
    );
    assert_eq!(
        getp(&contact_ref01_resdata_up0, "id"),
        getp(&contact_ref01_data_up0_up, "id"),
        "expected update result id to match"
    );
    assert_eq!(
        getp(&contact_ref01_resdata_up0, contact_ref01_markdef_up0_name),
        Value::str(contact_ref01_markdef_up0_value.clone()),
        "expected {} to be updated",
        contact_ref01_markdef_up0_name
    );

    // LOAD
    let contact_ref01_match_dt0 = jo(vec![("id", getp(&contact_ref01_data, "id"))]);
    let contact_ref01_data_dt0_loaded = contact_ref01_ent
        .load(contact_ref01_match_dt0.clone(), Value::Noval)
        .expect("load failed");
    let contact_ref01_data_dt0_load_result = to_map(&contact_ref01_data_dt0_loaded.data(None));
    assert!(
        matches!(contact_ref01_data_dt0_load_result, Value::Map(_)),
        "expected load result to be a map"
    );
    assert_eq!(
        getp(&contact_ref01_data_dt0_load_result, "id"),
        getp(&contact_ref01_data, "id"),
        "expected load result id to match"
    );

    // REMOVE
    let contact_ref01_match_rm0 = jo(vec![("id", getp(&contact_ref01_data, "id"))]);
    contact_ref01_ent
        .remove(contact_ref01_match_rm0.clone(), Value::Noval)
        .expect("remove failed");

    // LIST
    let contact_ref01_match_rt0 = Value::empty_map();
    setp(&contact_ref01_match_rt0, "contact_id", getp(&setup.idmap, "contact01"));

    let contact_ref01_list_rt0 = contact_ref01_ent
        .list(contact_ref01_match_rt0.clone(), Value::Noval)
        .expect("list failed");
    // list resolves to one ENTITY per record; the flow asserts on the
    // records, so map each through data().
    let contact_ref01_list_rt0 = ja(contact_ref01_list_rt0.iter().map(|e| e.data(None)).collect::<Vec<Value>>());

    let not_found_item = vs::select(
        &entity_list_to_data(&contact_ref01_list_rt0),
        &jo(vec![("id", getp(&contact_ref01_data, "id"))]),
    );
    assert!(
        vs::is_empty(&not_found_item),
        "expected removed entity to not be in list"
    );

}

fn contact_basic_setup(extra: Value) -> EntityTestSetup {
    load_env_local();

    let mut entity_data_file = manifest_dir();
    entity_data_file.push("..");
    entity_data_file.push(".sdk");
    entity_data_file.push("test");
    entity_data_file.push("entity");
    entity_data_file.push("contact");
    entity_data_file.push("ContactTestData.json");

    let entity_data = read_json(&entity_data_file);

    let options = jo(vec![("entity", getp(&entity_data, "existing"))]);

    let client = test_sdk(options, extra.clone());

    // Generate idmap via transform, matching the TS pattern.
    let idmap = vs::transform(
        &ja(vec![Value::str("contact01"), Value::str("contact02"), Value::str("contact03"), Value::str("group01"), Value::str("group02"), Value::str("group03")]),
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
    let entid_env_raw = std::env::var("SMSAPI_TEST_CONTACT_ENTID").unwrap_or_default();
    let idmap_overridden =
        !entid_env_raw.trim().is_empty() && entid_env_raw.trim().starts_with('{');

    let env = env_override(jo(vec![
        ("SMSAPI_TEST_CONTACT_ENTID", idmap.clone()),
        ("SMSAPI_TEST_LIVE", Value::str("FALSE")),
        ("SMSAPI_TEST_EXPLAIN", Value::str("FALSE")),
        ("SMSAPI_APIKEY", Value::str("")),
    ]));

    let idmap_resolved = match to_map(&getp(&env, "SMSAPI_TEST_CONTACT_ENTID")) {
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
