// Generated direct-call tests for the sendername entity (mirrors the
// go TestDirect generator; the live-mode path uses idmap-provided IDs).

#![allow(unused_variables, unused_imports, dead_code)]

mod common;

use std::cell::RefCell;
use std::rc::Rc;

use common::*;

use smsapi_sdk::core::helpers::{getp, ja, jo, json_thunk, setp, to_int, to_map};
use smsapi_sdk::utility::voxgigstruct as vs;
use smsapi_sdk::{Value, SmsapiSDK};

struct SendernameDirectSetup {
    client: Rc<SmsapiSDK>,
    calls: Rc<RefCell<Vec<Value>>>,
    live: bool,
    idmap: Value,
}

fn sendername_direct_setup(mockres: Value) -> SendernameDirectSetup {
    load_env_local();

    let calls: Rc<RefCell<Vec<Value>>> = Rc::new(RefCell::new(Vec::new()));

    let env = env_override(jo(vec![
        ("SMSAPI_TEST_SENDERNAME_ENTID", Value::empty_map()),
        ("SMSAPI_TEST_LIVE", Value::str("FALSE")),
        ("SMSAPI_APIKEY", Value::str("")),
    ]));

    let live = getp(&env, "SMSAPI_TEST_LIVE") == Value::str("TRUE");

    if live {
        // live_client_options() FIRST, so the generated entries below win:
        // sdk-test-control.json's test.client.options adds to the live
        // client, it does not redirect it.
        let client = SmsapiSDK::new(to_map(&vs::merge(
            &ja(vec![
                live_client_options(),
                jo(vec![("apikey", getp(&env, "SMSAPI_APIKEY"))]),
            ]),
            None,
        )));
        let idmap = match to_map(&getp(&env, "SMSAPI_TEST_SENDERNAME_ENTID")) {
            Value::Map(m) => Value::Map(m),
            _ => Value::empty_map(),
        };
        return SendernameDirectSetup {
            client,
            calls,
            live: true,
            idmap,
        };
    }

    let c = calls.clone();
    let mock_fetch = Value::func(move |_inj, args, _r, _s| {
        let url = vs::get_elem(args, &Value::Num(0.0), Value::Noval);
        let init = vs::get_elem(args, &Value::Num(1.0), Value::Noval);
        c.borrow_mut().push(jo(vec![("url", url), ("init", init)]));
        let data = if mockres.is_noval() || mockres.is_null() {
            jo(vec![("id", Value::str("direct01"))])
        } else {
            mockres.clone()
        };
        jo(vec![
            ("status", Value::Num(200.0)),
            ("statusText", Value::str("OK")),
            ("headers", Value::empty_map()),
            ("json", json_thunk(data)),
        ])
    });

    let client = SmsapiSDK::new(jo(vec![
        ("base", Value::str("http://localhost:8080")),
        ("system", jo(vec![("fetch", mock_fetch)])),
    ]));

    SendernameDirectSetup {
        client,
        calls,
        live: false,
        idmap: Value::empty_map(),
    }
}

#[test]
fn sendername_direct_list() {
    let setup = sendername_direct_setup(ja(vec![
        jo(vec![("id", Value::str("direct01"))]),
        jo(vec![("id", Value::str("direct02"))]),
    ]));
    let mode = if setup.live { "live" } else { "unit" };
    let (skip, reason) = is_control_skipped("direct", "direct-list-sendername", mode);
    if skip {
        eprintln!(
            "skip: {}",
            if reason.is_empty() {
                "skipped via sdk-test-control.json".to_string()
            } else {
                reason
            }
        );
        return;
    }
    let client = setup.client.clone();

    let params = Value::empty_map();

    let result = client
        .direct(jo(vec![
            ("path", Value::str("sms/sendernames")),
            ("method", Value::str("GET")),
            ("params", params.clone()),
        ]))
        .expect("direct failed");

    if setup.live {
        // Live mode is lenient: synthetic IDs frequently 4xx and the
        // list-response shape varies wildly across public APIs.
        if getp(&result, "ok") != Value::Bool(true) {
            eprintln!("skip: list call not ok (likely synthetic IDs against live API)");
            return;
        }
        let status = to_int(&getp(&result, "status"));
        if !(200..300).contains(&status) {
            eprintln!("skip: expected 2xx status, got {}", status);
            return;
        }
    } else {
        assert_eq!(getp(&result, "ok"), Value::Bool(true), "expected ok true");
        assert_eq!(to_int(&getp(&result, "status")), 200, "expected status 200");

        let data = getp(&result, "data");
        assert!(
            matches!(data, Value::List(_)),
            "expected data to be an array"
        );
        assert_eq!(vs::size(&data), 2, "expected 2 items");

        assert_eq!(setup.calls.borrow().len(), 1, "expected 1 call");
    }
}

#[test]
fn sendername_direct_load() {
    let setup = sendername_direct_setup(jo(vec![("id", Value::str("direct01"))]));
    let mode = if setup.live { "live" } else { "unit" };
    let (skip, reason) = is_control_skipped("direct", "direct-load-sendername", mode);
    if skip {
        eprintln!(
            "skip: {}",
            if reason.is_empty() {
                "skipped via sdk-test-control.json".to_string()
            } else {
                reason
            }
        );
        return;
    }
    if setup.live {
        for live_key in ["sendername01"] {
            if getp(&setup.idmap, live_key).is_noval() {
                eprintln!("skip: live test needs {} via *_ENTID env var (synthetic IDs only)", live_key);
                return;
            }
        }
    }
    let client = setup.client.clone();

    let params = Value::empty_map();
    if setup.live {
        setp(&params, "id", getp(&setup.idmap, "sendername01"));
    } else {
        setp(&params, "id", Value::str("direct01"));
    }

    let result = client
        .direct(jo(vec![
            ("path", Value::str("sms/sendernames/{id}")),
            ("method", Value::str("GET")),
            ("params", params.clone()),
        ]))
        .expect("direct failed");

    if setup.live {
        // Live mode is lenient: synthetic IDs frequently 4xx.
        if getp(&result, "ok") != Value::Bool(true) {
            eprintln!("skip: load call not ok (likely synthetic IDs against live API)");
            return;
        }
        let status = to_int(&getp(&result, "status"));
        if !(200..300).contains(&status) {
            eprintln!("skip: expected 2xx status, got {}", status);
            return;
        }
    } else {
        assert_eq!(getp(&result, "ok"), Value::Bool(true), "expected ok true");
        assert_eq!(to_int(&getp(&result, "status")), 200, "expected status 200");
        assert!(
            !getp(&result, "data").is_noval(),
            "expected data to be non-nil"
        );

        let data = getp(&result, "data");
        if let Value::Map(_) = data {
            assert_eq!(
                getp(&data, "id"),
                Value::str("direct01"),
                "expected data.id to be direct01"
            );
        }

        assert_eq!(setup.calls.borrow().len(), 1, "expected 1 call");
        let call = setup.calls.borrow()[0].clone();
        assert_eq!(
            getp(&getp(&call, "init"), "method"),
            Value::str("GET"),
            "expected method GET"
        );
        let url = match getp(&call, "url") {
            Value::Str(u) => u,
            _ => String::new(),
        };
        assert!(
            url.contains("direct01"),
            "expected url to contain direct01, got {}",
            url
        );
    }
}
