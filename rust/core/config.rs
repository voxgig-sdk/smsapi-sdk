// Generated API configuration (mirrors go core/config.go).

use std::cell::RefCell;
use std::rc::Rc;

use crate::core::types::FeatureRef;
use crate::utility::voxgigstruct::Value;

pub fn make_config() -> Value {
    Value::map_of([
        ("main".to_string(), Value::map_of([
            ("name".to_string(), Value::str("Smsapi")),
            ("slug".to_string(), Value::str("smsapi")),
            ("version".to_string(), Value::str("0.0.1")),
            ("target".to_string(), Value::str("rust")),
        ])),
        ("feature".to_string(), Value::map_of([
            ("audit".to_string(), Value::map_of([
                ("options".to_string(), Value::map_of([
                    ("active".to_string(), Value::Bool(false)),
                    ("actor".to_string(), Value::str("anonymous")),
                    ("max".to_string(), Value::Num(1000f64)),
                ])),
                ("optspec".to_string(), Value::map_of([
                    ("now".to_string(), Value::str("`$FUNCTION`")),
                    ("sink".to_string(), Value::str("`$FUNCTION`")),
                ])),
                ("strict".to_string(), Value::Bool(false)),
                ("transport".to_string(), Value::str("none")),
            ])),
            ("cache".to_string(), Value::map_of([
                ("options".to_string(), Value::map_of([
                    ("active".to_string(), Value::Bool(false)),
                    ("max".to_string(), Value::Num(256f64)),
                    ("methods".to_string(), Value::list(vec![
                        Value::str("GET"),
                    ])),
                    ("ttl".to_string(), Value::Num(5000f64)),
                ])),
                ("optspec".to_string(), Value::map_of([
                    ("now".to_string(), Value::str("`$FUNCTION`")),
                ])),
                ("strict".to_string(), Value::Bool(false)),
                ("transport".to_string(), Value::str("wrap")),
            ])),
            ("clienttrack".to_string(), Value::map_of([
                ("options".to_string(), Value::map_of([
                    ("active".to_string(), Value::Bool(false)),
                    ("clientVersion".to_string(), Value::str("0.0.1")),
                ])),
                ("optspec".to_string(), Value::map_of([
                    ("clientName".to_string(), Value::str("`$STRING`")),
                    ("clientVersion".to_string(), Value::str("`$STRING`")),
                    ("headers".to_string(), Value::str("`$MAP`")),
                    ("idgen".to_string(), Value::str("`$FUNCTION`")),
                    ("sessionId".to_string(), Value::str("`$STRING`")),
                ])),
                ("strict".to_string(), Value::Bool(false)),
                ("transport".to_string(), Value::str("none")),
            ])),
            ("cost".to_string(), Value::map_of([
                ("options".to_string(), Value::map_of([
                    ("active".to_string(), Value::Bool(false)),
                    ("budget".to_string(), Value::Num(0f64)),
                    ("currency".to_string(), Value::str("USD")),
                    ("header".to_string(), Value::str("")),
                    ("onBudget".to_string(), Value::str("warn")),
                    ("path".to_string(), Value::str("")),
                    ("perUnit".to_string(), Value::Num(0f64)),
                    ("rates".to_string(), Value::empty_map()),
                    ("unit".to_string(), Value::Num(0f64)),
                ])),
                ("optspec".to_string(), Value::map_of([
                    ("actor".to_string(), Value::str("`$STRING`")),
                    ("sink".to_string(), Value::str("`$FUNCTION`")),
                ])),
                ("strict".to_string(), Value::Bool(false)),
                ("transport".to_string(), Value::str("wrap")),
            ])),
            ("debug".to_string(), Value::map_of([
                ("options".to_string(), Value::map_of([
                    ("active".to_string(), Value::Bool(false)),
                    ("max".to_string(), Value::Num(100f64)),
                    ("redact".to_string(), Value::list(vec![
                        Value::str("authorization"),
                        Value::str("cookie"),
                        Value::str("set-cookie"),
                        Value::str("api-key"),
                        Value::str("apikey"),
                        Value::str("x-api-key"),
                        Value::str("idempotency-key"),
                    ])),
                ])),
                ("optspec".to_string(), Value::map_of([
                    ("now".to_string(), Value::str("`$FUNCTION`")),
                    ("onEntry".to_string(), Value::str("`$FUNCTION`")),
                ])),
                ("strict".to_string(), Value::Bool(false)),
                ("transport".to_string(), Value::str("none")),
            ])),
            ("idempotency".to_string(), Value::map_of([
                ("options".to_string(), Value::map_of([
                    ("active".to_string(), Value::Bool(false)),
                    ("header".to_string(), Value::str("Idempotency-Key")),
                    ("methods".to_string(), Value::list(vec![
                        Value::str("POST"),
                        Value::str("PUT"),
                        Value::str("PATCH"),
                        Value::str("DELETE"),
                    ])),
                    ("ops".to_string(), Value::list(vec![
                        Value::str("create"),
                        Value::str("update"),
                        Value::str("remove"),
                    ])),
                ])),
                ("optspec".to_string(), Value::map_of([
                    ("keygen".to_string(), Value::str("`$FUNCTION`")),
                ])),
                ("strict".to_string(), Value::Bool(false)),
                ("transport".to_string(), Value::str("none")),
            ])),
            ("log".to_string(), Value::map_of([
                ("options".to_string(), Value::map_of([
                    ("active".to_string(), Value::Bool(true)),
                ])),
                ("optspec".to_string(), Value::map_of([
                    ("level".to_string(), Value::str("`$STRING`")),
                    ("logger".to_string(), Value::str("`$ANY`")),
                ])),
                ("strict".to_string(), Value::Bool(false)),
                ("transport".to_string(), Value::str("none")),
            ])),
            ("metrics".to_string(), Value::map_of([
                ("options".to_string(), Value::map_of([
                    ("active".to_string(), Value::Bool(false)),
                ])),
                ("optspec".to_string(), Value::map_of([
                    ("now".to_string(), Value::str("`$FUNCTION`")),
                ])),
                ("strict".to_string(), Value::Bool(false)),
                ("transport".to_string(), Value::str("none")),
            ])),
            ("netsim".to_string(), Value::map_of([
                ("options".to_string(), Value::map_of([
                    ("active".to_string(), Value::Bool(false)),
                    ("errorTimes".to_string(), Value::Num(0f64)),
                    ("failEvery".to_string(), Value::Num(0f64)),
                    ("failRate".to_string(), Value::Num(0f64)),
                    ("failStatus".to_string(), Value::Num(503f64)),
                    ("failTimes".to_string(), Value::Num(0f64)),
                    ("latency".to_string(), Value::Num(0f64)),
                    ("offline".to_string(), Value::Bool(false)),
                    ("rateLimitTimes".to_string(), Value::Num(0f64)),
                    ("retryAfter".to_string(), Value::Num(0f64)),
                    ("seed".to_string(), Value::Num(1f64)),
                ])),
                ("optspec".to_string(), Value::map_of([
                    ("latency".to_string(), Value::list(vec![
                        Value::str("`$ONE`"),
                        Value::str("`$NUMBER`"),
                        Value::str("`$MAP`"),
                    ])),
                    ("sleep".to_string(), Value::str("`$FUNCTION`")),
                ])),
                ("strict".to_string(), Value::Bool(false)),
                ("transport".to_string(), Value::str("wrap")),
            ])),
            ("paging".to_string(), Value::map_of([
                ("options".to_string(), Value::map_of([
                    ("active".to_string(), Value::Bool(false)),
                    ("afterVar".to_string(), Value::str("after")),
                    ("cursorParam".to_string(), Value::str("cursor")),
                    ("firstVar".to_string(), Value::str("first")),
                    ("limitParam".to_string(), Value::str("limit")),
                    ("pageParam".to_string(), Value::str("page")),
                    ("startPage".to_string(), Value::Num(1f64)),
                ])),
                ("optspec".to_string(), Value::map_of([
                    ("limit".to_string(), Value::str("`$NUMBER`")),
                    ("ops".to_string(), Value::str("`$LIST`")),
                ])),
                ("strict".to_string(), Value::Bool(false)),
                ("transport".to_string(), Value::str("none")),
            ])),
            ("proxy".to_string(), Value::map_of([
                ("options".to_string(), Value::map_of([
                    ("active".to_string(), Value::Bool(false)),
                    ("fromEnv".to_string(), Value::Bool(false)),
                    ("noProxy".to_string(), Value::empty_list()),
                    ("url".to_string(), Value::str("")),
                ])),
                ("optspec".to_string(), Value::map_of([
                    ("agent".to_string(), Value::str("`$FUNCTION`")),
                ])),
                ("strict".to_string(), Value::Bool(false)),
                ("transport".to_string(), Value::str("wrap")),
            ])),
            ("ratelimit".to_string(), Value::map_of([
                ("options".to_string(), Value::map_of([
                    ("active".to_string(), Value::Bool(false)),
                    ("burst".to_string(), Value::Num(5f64)),
                    ("rate".to_string(), Value::Num(5f64)),
                ])),
                ("optspec".to_string(), Value::map_of([
                    ("now".to_string(), Value::str("`$FUNCTION`")),
                    ("sleep".to_string(), Value::str("`$FUNCTION`")),
                ])),
                ("strict".to_string(), Value::Bool(false)),
                ("transport".to_string(), Value::str("wrap")),
            ])),
            ("rbac".to_string(), Value::map_of([
                ("options".to_string(), Value::map_of([
                    ("active".to_string(), Value::Bool(false)),
                    ("deny".to_string(), Value::Bool(false)),
                    ("permissions".to_string(), Value::empty_list()),
                    ("rules".to_string(), Value::empty_map()),
                ])),
                ("optspec".to_string(), Value::empty_map()),
                ("strict".to_string(), Value::Bool(false)),
                ("transport".to_string(), Value::str("none")),
            ])),
            ("retry".to_string(), Value::map_of([
                ("options".to_string(), Value::map_of([
                    ("active".to_string(), Value::Bool(false)),
                    ("factor".to_string(), Value::Num(2f64)),
                    ("maxDelay".to_string(), Value::Num(2000f64)),
                    ("minDelay".to_string(), Value::Num(50f64)),
                    ("retries".to_string(), Value::Num(2f64)),
                    ("statuses".to_string(), Value::list(vec![
                        Value::Num(408f64),
                        Value::Num(425f64),
                        Value::Num(429f64),
                        Value::Num(500f64),
                        Value::Num(502f64),
                        Value::Num(503f64),
                        Value::Num(504f64),
                    ])),
                ])),
                ("optspec".to_string(), Value::map_of([
                    ("jitter".to_string(), Value::str("`$BOOLEAN`")),
                    ("sleep".to_string(), Value::str("`$FUNCTION`")),
                ])),
                ("strict".to_string(), Value::Bool(false)),
                ("transport".to_string(), Value::str("wrap")),
            ])),
            ("secrets".to_string(), Value::map_of([
                ("options".to_string(), Value::map_of([
                    ("active".to_string(), Value::Bool(false)),
                    ("cache".to_string(), Value::Bool(true)),
                    ("exchange".to_string(), Value::map_of([
                        ("active".to_string(), Value::Bool(false)),
                        ("method".to_string(), Value::str("POST")),
                        ("path".to_string(), Value::str("auth/token")),
                        ("refresh".to_string(), Value::str("")),
                        ("request".to_string(), Value::str("refresh_token")),
                        ("response".to_string(), Value::str("access_token")),
                        ("retries".to_string(), Value::Num(1f64)),
                        ("statuses".to_string(), Value::list(vec![
                            Value::Num(401f64),
                        ])),
                    ])),
                    ("name".to_string(), Value::str("apikey")),
                    ("providers".to_string(), Value::empty_list()),
                ])),
                ("optspec".to_string(), Value::empty_map()),
                ("strict".to_string(), Value::Bool(false)),
                ("transport".to_string(), Value::str("wrap")),
            ])),
            ("streaming".to_string(), Value::map_of([
                ("options".to_string(), Value::map_of([
                    ("active".to_string(), Value::Bool(false)),
                    ("chunkDelay".to_string(), Value::Num(0f64)),
                    ("chunkSize".to_string(), Value::Num(0f64)),
                ])),
                ("optspec".to_string(), Value::map_of([
                    ("ops".to_string(), Value::str("`$LIST`")),
                    ("sleep".to_string(), Value::str("`$FUNCTION`")),
                ])),
                ("strict".to_string(), Value::Bool(false)),
                ("transport".to_string(), Value::str("none")),
            ])),
            ("telemetry".to_string(), Value::map_of([
                ("options".to_string(), Value::map_of([
                    ("active".to_string(), Value::Bool(false)),
                ])),
                ("optspec".to_string(), Value::map_of([
                    ("exporter".to_string(), Value::str("`$FUNCTION`")),
                    ("headers".to_string(), Value::str("`$MAP`")),
                    ("idgen".to_string(), Value::str("`$FUNCTION`")),
                    ("now".to_string(), Value::str("`$FUNCTION`")),
                ])),
                ("strict".to_string(), Value::Bool(false)),
                ("transport".to_string(), Value::str("none")),
            ])),
            ("test".to_string(), Value::map_of([
                ("options".to_string(), Value::map_of([
                    ("active".to_string(), Value::Bool(false)),
                ])),
                ("optspec".to_string(), Value::map_of([
                    ("entity".to_string(), Value::str("`$MAP`")),
                    ("net".to_string(), Value::str("`$MAP`")),
                ])),
                ("strict".to_string(), Value::Bool(false)),
                ("transport".to_string(), Value::str("base")),
            ])),
            ("timeout".to_string(), Value::map_of([
                ("options".to_string(), Value::map_of([
                    ("active".to_string(), Value::Bool(false)),
                    ("ms".to_string(), Value::Num(30000f64)),
                ])),
                ("optspec".to_string(), Value::map_of([
                    ("clearTimer".to_string(), Value::str("`$FUNCTION`")),
                    ("setTimer".to_string(), Value::str("`$FUNCTION`")),
                ])),
                ("strict".to_string(), Value::Bool(false)),
                ("transport".to_string(), Value::str("wrap")),
            ])),
            ("validate".to_string(), Value::map_of([
                ("options".to_string(), Value::map_of([
                    ("active".to_string(), Value::Bool(false)),
                    ("mode".to_string(), Value::str("throw")),
                    ("request".to_string(), Value::Bool(true)),
                    ("response".to_string(), Value::Bool(false)),
                    ("strict".to_string(), Value::Bool(false)),
                ])),
                ("optspec".to_string(), Value::map_of([
                    ("mode".to_string(), Value::list(vec![
                        Value::str("`$ONE`"),
                        Value::list(vec![
                            Value::str("`$EXACT`"),
                            Value::str("throw"),
                        ]),
                        Value::list(vec![
                            Value::str("`$EXACT`"),
                            Value::str("report"),
                        ]),
                    ])),
                    ("onInvalid".to_string(), Value::str("`$FUNCTION`")),
                ])),
                ("strict".to_string(), Value::Bool(false)),
                ("transport".to_string(), Value::str("none")),
            ])),
        ])),
        ("options".to_string(), Value::map_of([
            ("base".to_string(), Value::str("https://api.smsapi.com")),
            ("auth".to_string(), Value::map_of([
                ("prefix".to_string(), Value::str("Bearer")),
            ])),
            ("headers".to_string(), Value::map_of([
                ("content-type".to_string(), Value::str("application/json")),
            ])),
            ("entity".to_string(), Value::map_of([
                ("available".to_string(), Value::empty_map()),
                ("blacklist".to_string(), Value::empty_map()),
                ("callback".to_string(), Value::empty_map()),
                ("contact".to_string(), Value::empty_map()),
                ("contacts_field".to_string(), Value::empty_map()),
                ("contacts_field_option".to_string(), Value::empty_map()),
                ("contactsgroup".to_string(), Value::empty_map()),
                ("contactstrash".to_string(), Value::empty_map()),
                ("field_available".to_string(), Value::empty_map()),
                ("group".to_string(), Value::empty_map()),
                ("mfa_code".to_string(), Value::empty_map()),
                ("opt_out".to_string(), Value::empty_map()),
                ("opt_out_setting".to_string(), Value::empty_map()),
                ("permission".to_string(), Value::empty_map()),
                ("ping".to_string(), Value::empty_map()),
                ("profile".to_string(), Value::empty_map()),
                ("rcs".to_string(), Value::empty_map()),
                ("sendername".to_string(), Value::empty_map()),
                ("sendername_statement".to_string(), Value::empty_map()),
                ("sent_rcs_message".to_string(), Value::empty_map()),
                ("shipment_country_volume".to_string(), Value::empty_map()),
                ("short_url".to_string(), Value::empty_map()),
                ("smsdo".to_string(), Value::empty_map()),
                ("smssendername".to_string(), Value::empty_map()),
                ("smstemplate".to_string(), Value::empty_map()),
                ("subuser".to_string(), Value::empty_map()),
                ("template".to_string(), Value::empty_map()),
                ("user_rcs_sender_collection".to_string(), Value::empty_map()),
            ])),
        ])),
        ("entity".to_string(), Value::map_of([
            ("available".to_string(), Value::map_of([
                ("fields".to_string(), Value::list(vec![
                    Value::map_of([
                        ("name".to_string(), Value::str("name")),
                        ("title".to_string(), Value::str("Name")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("normalize")),
                        ("title".to_string(), Value::str("Normalize")),
                        ("type".to_string(), Value::str("`$BOOLEAN`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("template")),
                        ("title".to_string(), Value::str("Template")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                ])),
                ("name".to_string(), Value::str("available")),
                ("op".to_string(), Value::map_of([
                    ("list".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("list")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("GET")),
                                ("orig".to_string(), Value::str("/sms/templates/available")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("sms")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("templates")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("available")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("sms"),
                                    Value::str("templates"),
                                    Value::str("available"),
                                ])),
                                ("rename".to_string(), Value::empty_map()),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body.collection`")),
                                ])),
                                ("args".to_string(), Value::empty_map()),
                                ("select".to_string(), Value::empty_map()),
                            ]),
                        ])),
                    ])),
                ])),
                ("relations".to_string(), Value::map_of([
                    ("ancestors".to_string(), Value::empty_list()),
                ])),
            ])),
            ("blacklist".to_string(), Value::map_of([
                ("fields".to_string(), Value::list(vec![
                    Value::map_of([
                        ("name".to_string(), Value::str("id")),
                        ("title".to_string(), Value::str("Id")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                ])),
                ("id".to_string(), Value::map_of([
                    ("field".to_string(), Value::str("id")),
                    ("name".to_string(), Value::str("id")),
                ])),
                ("name".to_string(), Value::str("blacklist")),
                ("op".to_string(), Value::map_of([
                    ("create".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("create")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("POST")),
                                ("orig".to_string(), Value::str("/blacklist/phone_numbers")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("blacklist")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("phone_numbers")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("blacklist"),
                                    Value::str("phone_numbers"),
                                ])),
                                ("rename".to_string(), Value::empty_map()),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("args".to_string(), Value::empty_map()),
                                ("select".to_string(), Value::map_of([
                                    ("$action".to_string(), Value::str("phone_number")),
                                ])),
                            ]),
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("POST")),
                                ("orig".to_string(), Value::str("/blacklist/phone_numbers/imports")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("blacklist")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("phone_numbers")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("imports")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("blacklist"),
                                    Value::str("phone_numbers"),
                                    Value::str("imports"),
                                ])),
                                ("rename".to_string(), Value::empty_map()),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("args".to_string(), Value::empty_map()),
                                ("select".to_string(), Value::empty_map()),
                            ]),
                        ])),
                    ])),
                    ("load".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("load")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("GET")),
                                ("orig".to_string(), Value::str("/blacklist/phone_numbers")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("blacklist")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("phone_numbers")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("blacklist"),
                                    Value::str("phone_numbers"),
                                ])),
                                ("rename".to_string(), Value::empty_map()),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("args".to_string(), Value::map_of([
                                    ("header".to_string(), Value::list(vec![
                                        Value::map_of([
                                            ("name".to_string(), Value::str("accept")),
                                            ("orig".to_string(), Value::str("Accept")),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                            ("kind".to_string(), Value::str("header")),
                                            ("example".to_string(), Value::str("application/json")),
                                        ]),
                                        Value::map_of([
                                            ("name".to_string(), Value::str("x_async")),
                                            ("orig".to_string(), Value::str("x-async")),
                                            ("type".to_string(), Value::str("`$BOOLEAN`")),
                                            ("kind".to_string(), Value::str("header")),
                                            ("example".to_string(), Value::Bool(false)),
                                        ]),
                                    ])),
                                    ("query".to_string(), Value::list(vec![
                                        Value::map_of([
                                            ("name".to_string(), Value::str("limit")),
                                            ("orig".to_string(), Value::str("limit")),
                                            ("type".to_string(), Value::str("`$INTEGER`")),
                                            ("kind".to_string(), Value::str("query")),
                                            ("example".to_string(), Value::Num(5f64)),
                                        ]),
                                        Value::map_of([
                                            ("name".to_string(), Value::str("offset")),
                                            ("orig".to_string(), Value::str("offset")),
                                            ("type".to_string(), Value::str("`$INTEGER`")),
                                            ("kind".to_string(), Value::str("query")),
                                            ("example".to_string(), Value::Num(0f64)),
                                        ]),
                                        Value::map_of([
                                            ("name".to_string(), Value::str("q")),
                                            ("orig".to_string(), Value::str("q")),
                                            ("type".to_string(), Value::str("`$INTEGER`")),
                                            ("kind".to_string(), Value::str("query")),
                                            ("example".to_string(), Value::Num(0f64)),
                                        ]),
                                    ])),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("$action".to_string(), Value::str("phone_number")),
                                    ("exist".to_string(), Value::list(vec![
                                        Value::str("accept"),
                                        Value::str("limit"),
                                        Value::str("offset"),
                                        Value::str("q"),
                                        Value::str("x_async"),
                                    ])),
                                ])),
                            ]),
                        ])),
                    ])),
                    ("remove".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("remove")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("DELETE")),
                                ("orig".to_string(), Value::str("/blacklist/phone_numbers/{id}")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("blacklist")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("phone_numbers")),
                                    ]),
                                    Value::map_of([
                                        ("var".to_string(), Value::str("id")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("blacklist"),
                                    Value::str("phone_numbers"),
                                    Value::str("{id}"),
                                ])),
                                ("rename".to_string(), Value::empty_map()),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("args".to_string(), Value::map_of([
                                    ("params".to_string(), Value::list(vec![
                                        Value::map_of([
                                            ("name".to_string(), Value::str("id")),
                                            ("orig".to_string(), Value::str("id")),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                            ("kind".to_string(), Value::str("param")),
                                            ("reqd".to_string(), Value::Bool(true)),
                                            ("example".to_string(), Value::str("0f0f0f0f0f0f0f0f0f0f0f0f")),
                                        ]),
                                    ])),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("exist".to_string(), Value::list(vec![
                                        Value::str("id"),
                                    ])),
                                ])),
                            ]),
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("DELETE")),
                                ("orig".to_string(), Value::str("/blacklist/phone_numbers")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("blacklist")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("phone_numbers")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("blacklist"),
                                    Value::str("phone_numbers"),
                                ])),
                                ("rename".to_string(), Value::empty_map()),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("args".to_string(), Value::map_of([
                                    ("query".to_string(), Value::list(vec![
                                        Value::map_of([
                                            ("name".to_string(), Value::str("phone_number")),
                                            ("orig".to_string(), Value::str("phone_number")),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                            ("kind".to_string(), Value::str("query")),
                                        ]),
                                    ])),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("$action".to_string(), Value::str("phone_number")),
                                    ("exist".to_string(), Value::list(vec![
                                        Value::str("phone_number"),
                                    ])),
                                ])),
                            ]),
                        ])),
                    ])),
                ])),
                ("relations".to_string(), Value::map_of([
                    ("ancestors".to_string(), Value::empty_list()),
                ])),
            ])),
            ("callback".to_string(), Value::map_of([
                ("fields".to_string(), Value::list(vec![
                    Value::map_of([
                        ("name".to_string(), Value::str("active")),
                        ("title".to_string(), Value::str("Active")),
                        ("type".to_string(), Value::str("`$BOOLEAN`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("api_version")),
                        ("title".to_string(), Value::str("Api Version")),
                        ("type".to_string(), Value::str("`$INTEGER`")),
                        ("short".to_string(), Value::str("Version of the callback output format.")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("id")),
                        ("title".to_string(), Value::str("Id")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("short".to_string(), Value::str("Object ID")),
                        ("format".to_string(), Value::str("oid")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("invalid")),
                        ("title".to_string(), Value::str("Invalid")),
                        ("type".to_string(), Value::str("`$BOOLEAN`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("receiver")),
                        ("title".to_string(), Value::str("Receiver")),
                        ("type".to_string(), Value::str("`$OBJECT`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("receiver_type")),
                        ("title".to_string(), Value::str("Receiver Type")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("type")),
                        ("title".to_string(), Value::str("Type")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("url")),
                        ("title".to_string(), Value::str("Url")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("op".to_string(), Value::map_of([
                            ("update".to_string(), Value::map_of([
                                ("req".to_string(), Value::Bool(true)),
                                ("type".to_string(), Value::str("`$STRING`")),
                            ])),
                        ])),
                        ("short".to_string(), Value::str("WHATWG URL compliant")),
                        ("format".to_string(), Value::str("url")),
                    ]),
                ])),
                ("id".to_string(), Value::map_of([
                    ("field".to_string(), Value::str("id")),
                    ("name".to_string(), Value::str("id")),
                ])),
                ("name".to_string(), Value::str("callback")),
                ("op".to_string(), Value::map_of([
                    ("create".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("create")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("POST")),
                                ("orig".to_string(), Value::str("/callbacks")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("callbacks")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("callbacks"),
                                ])),
                                ("rename".to_string(), Value::empty_map()),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("args".to_string(), Value::empty_map()),
                                ("select".to_string(), Value::empty_map()),
                            ]),
                        ])),
                    ])),
                    ("list".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("list")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("GET")),
                                ("orig".to_string(), Value::str("/callbacks")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("callbacks")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("callbacks"),
                                ])),
                                ("rename".to_string(), Value::empty_map()),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body.collection`")),
                                ])),
                                ("args".to_string(), Value::empty_map()),
                                ("select".to_string(), Value::empty_map()),
                            ]),
                        ])),
                    ])),
                    ("load".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("load")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("GET")),
                                ("orig".to_string(), Value::str("/callbacks/{id}")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("callbacks")),
                                    ]),
                                    Value::map_of([
                                        ("var".to_string(), Value::str("id")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("callbacks"),
                                    Value::str("{id}"),
                                ])),
                                ("rename".to_string(), Value::empty_map()),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("args".to_string(), Value::map_of([
                                    ("params".to_string(), Value::list(vec![
                                        Value::map_of([
                                            ("name".to_string(), Value::str("id")),
                                            ("orig".to_string(), Value::str("id")),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                            ("kind".to_string(), Value::str("param")),
                                            ("reqd".to_string(), Value::Bool(true)),
                                            ("example".to_string(), Value::str("0f0f0f0f0f0f0f0f0f0f0f0f")),
                                        ]),
                                    ])),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("exist".to_string(), Value::list(vec![
                                        Value::str("id"),
                                    ])),
                                ])),
                            ]),
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("GET")),
                                ("orig".to_string(), Value::str("/callbacks/{id}/commands/test")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("callbacks")),
                                    ]),
                                    Value::map_of([
                                        ("var".to_string(), Value::str("id")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("commands")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("test")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("callbacks"),
                                    Value::str("{id}"),
                                    Value::str("commands"),
                                    Value::str("test"),
                                ])),
                                ("rename".to_string(), Value::empty_map()),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("args".to_string(), Value::map_of([
                                    ("params".to_string(), Value::list(vec![
                                        Value::map_of([
                                            ("name".to_string(), Value::str("id")),
                                            ("orig".to_string(), Value::str("id")),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                            ("kind".to_string(), Value::str("param")),
                                            ("reqd".to_string(), Value::Bool(true)),
                                            ("example".to_string(), Value::str("0f0f0f0f0f0f0f0f0f0f0f0f")),
                                        ]),
                                    ])),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("$action".to_string(), Value::str("command_test")),
                                    ("exist".to_string(), Value::list(vec![
                                        Value::str("id"),
                                    ])),
                                ])),
                            ]),
                        ])),
                    ])),
                    ("remove".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("remove")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("DELETE")),
                                ("orig".to_string(), Value::str("/callbacks/{id}")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("callbacks")),
                                    ]),
                                    Value::map_of([
                                        ("var".to_string(), Value::str("id")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("callbacks"),
                                    Value::str("{id}"),
                                ])),
                                ("rename".to_string(), Value::empty_map()),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("args".to_string(), Value::map_of([
                                    ("params".to_string(), Value::list(vec![
                                        Value::map_of([
                                            ("name".to_string(), Value::str("id")),
                                            ("orig".to_string(), Value::str("id")),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                            ("kind".to_string(), Value::str("param")),
                                            ("reqd".to_string(), Value::Bool(true)),
                                            ("example".to_string(), Value::str("0f0f0f0f0f0f0f0f0f0f0f0f")),
                                        ]),
                                    ])),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("exist".to_string(), Value::list(vec![
                                        Value::str("id"),
                                    ])),
                                ])),
                            ]),
                        ])),
                    ])),
                    ("update".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("update")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("PUT")),
                                ("orig".to_string(), Value::str("/callbacks/{id}")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("callbacks")),
                                    ]),
                                    Value::map_of([
                                        ("var".to_string(), Value::str("id")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("callbacks"),
                                    Value::str("{id}"),
                                ])),
                                ("rename".to_string(), Value::empty_map()),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("args".to_string(), Value::map_of([
                                    ("params".to_string(), Value::list(vec![
                                        Value::map_of([
                                            ("name".to_string(), Value::str("id")),
                                            ("orig".to_string(), Value::str("id")),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                            ("kind".to_string(), Value::str("param")),
                                            ("reqd".to_string(), Value::Bool(true)),
                                            ("example".to_string(), Value::str("0f0f0f0f0f0f0f0f0f0f0f0f")),
                                        ]),
                                    ])),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("exist".to_string(), Value::list(vec![
                                        Value::str("id"),
                                    ])),
                                ])),
                            ]),
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("PUT")),
                                ("orig".to_string(), Value::str("/callbacks/{id}/commands/activate")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("callbacks")),
                                    ]),
                                    Value::map_of([
                                        ("var".to_string(), Value::str("id")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("commands")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("activate")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("callbacks"),
                                    Value::str("{id}"),
                                    Value::str("commands"),
                                    Value::str("activate"),
                                ])),
                                ("rename".to_string(), Value::empty_map()),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("args".to_string(), Value::map_of([
                                    ("params".to_string(), Value::list(vec![
                                        Value::map_of([
                                            ("name".to_string(), Value::str("id")),
                                            ("orig".to_string(), Value::str("id")),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                            ("kind".to_string(), Value::str("param")),
                                            ("reqd".to_string(), Value::Bool(true)),
                                            ("example".to_string(), Value::str("0f0f0f0f0f0f0f0f0f0f0f0f")),
                                        ]),
                                    ])),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("$action".to_string(), Value::str("command_activate")),
                                    ("exist".to_string(), Value::list(vec![
                                        Value::str("id"),
                                    ])),
                                ])),
                            ]),
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("PUT")),
                                ("orig".to_string(), Value::str("/callbacks/{id}/commands/deactivate")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("callbacks")),
                                    ]),
                                    Value::map_of([
                                        ("var".to_string(), Value::str("id")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("commands")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("deactivate")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("callbacks"),
                                    Value::str("{id}"),
                                    Value::str("commands"),
                                    Value::str("deactivate"),
                                ])),
                                ("rename".to_string(), Value::empty_map()),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("args".to_string(), Value::map_of([
                                    ("params".to_string(), Value::list(vec![
                                        Value::map_of([
                                            ("name".to_string(), Value::str("id")),
                                            ("orig".to_string(), Value::str("id")),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                            ("kind".to_string(), Value::str("param")),
                                            ("reqd".to_string(), Value::Bool(true)),
                                            ("example".to_string(), Value::str("0f0f0f0f0f0f0f0f0f0f0f0f")),
                                        ]),
                                    ])),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("$action".to_string(), Value::str("command_deactivate")),
                                    ("exist".to_string(), Value::list(vec![
                                        Value::str("id"),
                                    ])),
                                ])),
                            ]),
                        ])),
                    ])),
                ])),
                ("relations".to_string(), Value::map_of([
                    ("ancestors".to_string(), Value::empty_list()),
                ])),
            ])),
            ("contact".to_string(), Value::map_of([
                ("fields".to_string(), Value::list(vec![
                    Value::map_of([
                        ("name".to_string(), Value::str("birthday_date")),
                        ("title".to_string(), Value::str("Birthday Date")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("format".to_string(), Value::str("date")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("city")),
                        ("title".to_string(), Value::str("City")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("collection")),
                        ("title".to_string(), Value::str("Collection")),
                        ("type".to_string(), Value::str("`$ARRAY`")),
                        ("req".to_string(), Value::Bool(true)),
                        ("op".to_string(), Value::map_of([
                            ("update".to_string(), Value::map_of([
                                ("type".to_string(), Value::str("`$ARRAY`")),
                            ])),
                        ])),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("contact_expire_after")),
                        ("title".to_string(), Value::str("Contact Expire After")),
                        ("type".to_string(), Value::str("`$INTEGER`")),
                        ("req".to_string(), Value::Bool(true)),
                        ("short".to_string(), Value::str("Contact expire after days")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("contacts_count")),
                        ("title".to_string(), Value::str("Contacts Count")),
                        ("type".to_string(), Value::str("`$INTEGER`")),
                        ("req".to_string(), Value::Bool(true)),
                        ("op".to_string(), Value::map_of([
                            ("list".to_string(), Value::map_of([
                                ("type".to_string(), Value::str("`$INTEGER`")),
                            ])),
                        ])),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("country")),
                        ("title".to_string(), Value::str("Country")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("created_by")),
                        ("title".to_string(), Value::str("Created By")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("req".to_string(), Value::Bool(true)),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("date_created")),
                        ("title".to_string(), Value::str("Date Created")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("req".to_string(), Value::Bool(true)),
                        ("format".to_string(), Value::str("date-time")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("date_updated")),
                        ("title".to_string(), Value::str("Date Updated")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("req".to_string(), Value::Bool(true)),
                        ("format".to_string(), Value::str("date-time")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("description")),
                        ("title".to_string(), Value::str("Description")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("op".to_string(), Value::map_of([
                            ("load".to_string(), Value::map_of([
                                ("req".to_string(), Value::Bool(true)),
                                ("type".to_string(), Value::str("`$STRING`")),
                            ])),
                        ])),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("email")),
                        ("title".to_string(), Value::str("Email")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("format".to_string(), Value::str("email")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("first_name")),
                        ("title".to_string(), Value::str("First Name")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("gender")),
                        ("title".to_string(), Value::str("Gender")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("req".to_string(), Value::Bool(true)),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("group_id")),
                        ("title".to_string(), Value::str("Group Id")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("short".to_string(), Value::str("Object ID")),
                        ("format".to_string(), Value::str("oid")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("groups")),
                        ("title".to_string(), Value::str("Groups")),
                        ("type".to_string(), Value::str("`$ARRAY`")),
                        ("req".to_string(), Value::Bool(true)),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("id")),
                        ("title".to_string(), Value::str("Id")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("req".to_string(), Value::Bool(true)),
                        ("short".to_string(), Value::str("Object ID")),
                        ("format".to_string(), Value::str("oid")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("idx")),
                        ("title".to_string(), Value::str("Idx")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("short".to_string(), Value::str("User provided resource id")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("last_name")),
                        ("title".to_string(), Value::str("Last Name")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("name")),
                        ("title".to_string(), Value::str("Name")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("req".to_string(), Value::Bool(true)),
                        ("op".to_string(), Value::map_of([
                            ("list".to_string(), Value::map_of([
                                ("type".to_string(), Value::str("`$STRING`")),
                            ])),
                        ])),
                        ("short".to_string(), Value::str("Group name")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("permissions")),
                        ("title".to_string(), Value::str("Permissions")),
                        ("type".to_string(), Value::str("`$ARRAY`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("phone_number")),
                        ("title".to_string(), Value::str("Phone Number")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("read")),
                        ("title".to_string(), Value::str("Read")),
                        ("type".to_string(), Value::str("`$BOOLEAN`")),
                        ("short".to_string(), Value::str("Has read permission")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("send")),
                        ("title".to_string(), Value::str("Send")),
                        ("type".to_string(), Value::str("`$BOOLEAN`")),
                        ("short".to_string(), Value::str("Has send permission")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("size")),
                        ("title".to_string(), Value::str("Size")),
                        ("type".to_string(), Value::str("`$INTEGER`")),
                        ("req".to_string(), Value::Bool(true)),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("source")),
                        ("title".to_string(), Value::str("Source")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("type")),
                        ("title".to_string(), Value::str("Type")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("username")),
                        ("title".to_string(), Value::str("Username")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("value")),
                        ("title".to_string(), Value::str("Value")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("write")),
                        ("title".to_string(), Value::str("Write")),
                        ("type".to_string(), Value::str("`$BOOLEAN`")),
                        ("short".to_string(), Value::str("Has write permission")),
                    ]),
                ])),
                ("id".to_string(), Value::map_of([
                    ("field".to_string(), Value::str("id")),
                    ("name".to_string(), Value::str("id")),
                ])),
                ("name".to_string(), Value::str("contact")),
                ("op".to_string(), Value::map_of([
                    ("create".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("create")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("POST")),
                                ("orig".to_string(), Value::str("/contacts/{contactId}/groups")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("contacts")),
                                    ]),
                                    Value::map_of([
                                        ("var".to_string(), Value::str("id")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("groups")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("contacts"),
                                    Value::str("{id}"),
                                    Value::str("groups"),
                                ])),
                                ("rename".to_string(), Value::map_of([
                                    ("param".to_string(), Value::map_of([
                                        ("contactId".to_string(), Value::str("id")),
                                    ])),
                                ])),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("args".to_string(), Value::map_of([
                                    ("params".to_string(), Value::list(vec![
                                        Value::map_of([
                                            ("name".to_string(), Value::str("id")),
                                            ("orig".to_string(), Value::str("contactId")),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                            ("kind".to_string(), Value::str("param")),
                                            ("reqd".to_string(), Value::Bool(true)),
                                            ("example".to_string(), Value::str("0f0f0f0f0f0f0f0f0f0f0f0f")),
                                        ]),
                                    ])),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("$action".to_string(), Value::str("group")),
                                    ("exist".to_string(), Value::list(vec![
                                        Value::str("id"),
                                    ])),
                                ])),
                            ]),
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("POST")),
                                ("orig".to_string(), Value::str("/contacts")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("contacts")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("contacts"),
                                ])),
                                ("rename".to_string(), Value::empty_map()),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("args".to_string(), Value::empty_map()),
                                ("select".to_string(), Value::empty_map()),
                            ]),
                        ])),
                    ])),
                    ("list".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("list")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("GET")),
                                ("orig".to_string(), Value::str("/contacts")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("contacts")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("contacts"),
                                ])),
                                ("rename".to_string(), Value::empty_map()),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body.collection`")),
                                ])),
                                ("args".to_string(), Value::map_of([
                                    ("query".to_string(), Value::list(vec![
                                        Value::map_of([
                                            ("name".to_string(), Value::str("birthday_date")),
                                            ("orig".to_string(), Value::str("birthday_date")),
                                            ("type".to_string(), Value::str("`$ARRAY`")),
                                            ("kind".to_string(), Value::str("query")),
                                            ("example".to_string(), Value::str("2022-06-24")),
                                        ]),
                                        Value::map_of([
                                            ("name".to_string(), Value::str("email")),
                                            ("orig".to_string(), Value::str("email")),
                                            ("type".to_string(), Value::str("`$ARRAY`")),
                                            ("kind".to_string(), Value::str("query")),
                                        ]),
                                        Value::map_of([
                                            ("name".to_string(), Value::str("first_name")),
                                            ("orig".to_string(), Value::str("first_name")),
                                            ("type".to_string(), Value::str("`$ARRAY`")),
                                            ("kind".to_string(), Value::str("query")),
                                        ]),
                                        Value::map_of([
                                            ("name".to_string(), Value::str("gender")),
                                            ("orig".to_string(), Value::str("gender")),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                            ("kind".to_string(), Value::str("query")),
                                        ]),
                                        Value::map_of([
                                            ("name".to_string(), Value::str("group_id")),
                                            ("orig".to_string(), Value::str("group_id")),
                                            ("type".to_string(), Value::str("`$ARRAY`")),
                                            ("kind".to_string(), Value::str("query")),
                                        ]),
                                        Value::map_of([
                                            ("name".to_string(), Value::str("last_name")),
                                            ("orig".to_string(), Value::str("last_name")),
                                            ("type".to_string(), Value::str("`$ARRAY`")),
                                            ("kind".to_string(), Value::str("query")),
                                        ]),
                                        Value::map_of([
                                            ("name".to_string(), Value::str("limit")),
                                            ("orig".to_string(), Value::str("limit")),
                                            ("type".to_string(), Value::str("`$INTEGER`")),
                                            ("kind".to_string(), Value::str("query")),
                                            ("example".to_string(), Value::Num(5f64)),
                                        ]),
                                        Value::map_of([
                                            ("name".to_string(), Value::str("offset")),
                                            ("orig".to_string(), Value::str("offset")),
                                            ("type".to_string(), Value::str("`$INTEGER`")),
                                            ("kind".to_string(), Value::str("query")),
                                            ("example".to_string(), Value::Num(0f64)),
                                        ]),
                                        Value::map_of([
                                            ("name".to_string(), Value::str("order_by")),
                                            ("orig".to_string(), Value::str("order_by")),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                            ("kind".to_string(), Value::str("query")),
                                        ]),
                                        Value::map_of([
                                            ("name".to_string(), Value::str("phone_number")),
                                            ("orig".to_string(), Value::str("phone_number")),
                                            ("type".to_string(), Value::str("`$ARRAY`")),
                                            ("kind".to_string(), Value::str("query")),
                                        ]),
                                        Value::map_of([
                                            ("name".to_string(), Value::str("q")),
                                            ("orig".to_string(), Value::str("q")),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                            ("kind".to_string(), Value::str("query")),
                                        ]),
                                    ])),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("exist".to_string(), Value::list(vec![
                                        Value::str("birthday_date"),
                                        Value::str("email"),
                                        Value::str("first_name"),
                                        Value::str("gender"),
                                        Value::str("group_id"),
                                        Value::str("last_name"),
                                        Value::str("limit"),
                                        Value::str("offset"),
                                        Value::str("order_by"),
                                        Value::str("phone_number"),
                                        Value::str("q"),
                                    ])),
                                ])),
                            ]),
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("GET")),
                                ("orig".to_string(), Value::str("/contacts/{contactId}/groups")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("contacts")),
                                    ]),
                                    Value::map_of([
                                        ("var".to_string(), Value::str("id")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("groups")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("contacts"),
                                    Value::str("{id}"),
                                    Value::str("groups"),
                                ])),
                                ("rename".to_string(), Value::map_of([
                                    ("param".to_string(), Value::map_of([
                                        ("contactId".to_string(), Value::str("id")),
                                    ])),
                                ])),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body.collection`")),
                                ])),
                                ("args".to_string(), Value::map_of([
                                    ("params".to_string(), Value::list(vec![
                                        Value::map_of([
                                            ("name".to_string(), Value::str("id")),
                                            ("orig".to_string(), Value::str("contactId")),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                            ("kind".to_string(), Value::str("param")),
                                            ("reqd".to_string(), Value::Bool(true)),
                                            ("example".to_string(), Value::str("0f0f0f0f0f0f0f0f0f0f0f0f")),
                                        ]),
                                    ])),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("$action".to_string(), Value::str("group")),
                                    ("exist".to_string(), Value::list(vec![
                                        Value::str("id"),
                                    ])),
                                ])),
                            ]),
                        ])),
                    ])),
                    ("load".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("load")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("GET")),
                                ("orig".to_string(), Value::str("/contacts/groups/{groupId}/members/{contactId}")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("contacts")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("groups")),
                                    ]),
                                    Value::map_of([
                                        ("var".to_string(), Value::str("group_id")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("members")),
                                    ]),
                                    Value::map_of([
                                        ("var".to_string(), Value::str("contact_id")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("contacts"),
                                    Value::str("groups"),
                                    Value::str("{group_id}"),
                                    Value::str("members"),
                                    Value::str("{contact_id}"),
                                ])),
                                ("rename".to_string(), Value::map_of([
                                    ("param".to_string(), Value::map_of([
                                        ("contactId".to_string(), Value::str("contact_id")),
                                        ("groupId".to_string(), Value::str("group_id")),
                                    ])),
                                ])),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("args".to_string(), Value::map_of([
                                    ("params".to_string(), Value::list(vec![
                                        Value::map_of([
                                            ("name".to_string(), Value::str("contact_id")),
                                            ("orig".to_string(), Value::str("contactId")),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                            ("kind".to_string(), Value::str("param")),
                                            ("reqd".to_string(), Value::Bool(true)),
                                            ("example".to_string(), Value::str("0f0f0f0f0f0f0f0f0f0f0f0f")),
                                        ]),
                                        Value::map_of([
                                            ("name".to_string(), Value::str("group_id")),
                                            ("orig".to_string(), Value::str("groupId")),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                            ("kind".to_string(), Value::str("param")),
                                            ("reqd".to_string(), Value::Bool(true)),
                                            ("example".to_string(), Value::str("0f0f0f0f0f0f0f0f0f0f0f0f")),
                                        ]),
                                    ])),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("exist".to_string(), Value::list(vec![
                                        Value::str("contact_id"),
                                        Value::str("group_id"),
                                    ])),
                                ])),
                            ]),
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("GET")),
                                ("orig".to_string(), Value::str("/contacts/{contactId}/groups/{groupId}")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("contacts")),
                                    ]),
                                    Value::map_of([
                                        ("var".to_string(), Value::str("id")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("groups")),
                                    ]),
                                    Value::map_of([
                                        ("var".to_string(), Value::str("group_id")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("contacts"),
                                    Value::str("{id}"),
                                    Value::str("groups"),
                                    Value::str("{group_id}"),
                                ])),
                                ("rename".to_string(), Value::map_of([
                                    ("param".to_string(), Value::map_of([
                                        ("contactId".to_string(), Value::str("id")),
                                        ("groupId".to_string(), Value::str("group_id")),
                                    ])),
                                ])),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("args".to_string(), Value::map_of([
                                    ("params".to_string(), Value::list(vec![
                                        Value::map_of([
                                            ("name".to_string(), Value::str("group_id")),
                                            ("orig".to_string(), Value::str("groupId")),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                            ("kind".to_string(), Value::str("param")),
                                            ("reqd".to_string(), Value::Bool(true)),
                                            ("example".to_string(), Value::str("0f0f0f0f0f0f0f0f0f0f0f0f")),
                                        ]),
                                        Value::map_of([
                                            ("name".to_string(), Value::str("id")),
                                            ("orig".to_string(), Value::str("contactId")),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                            ("kind".to_string(), Value::str("param")),
                                            ("reqd".to_string(), Value::Bool(true)),
                                            ("example".to_string(), Value::str("0f0f0f0f0f0f0f0f0f0f0f0f")),
                                        ]),
                                    ])),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("exist".to_string(), Value::list(vec![
                                        Value::str("group_id"),
                                        Value::str("id"),
                                    ])),
                                ])),
                            ]),
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("GET")),
                                ("orig".to_string(), Value::str("/contacts/{contactId}")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("contacts")),
                                    ]),
                                    Value::map_of([
                                        ("var".to_string(), Value::str("id")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("contacts"),
                                    Value::str("{id}"),
                                ])),
                                ("rename".to_string(), Value::map_of([
                                    ("param".to_string(), Value::map_of([
                                        ("contactId".to_string(), Value::str("id")),
                                    ])),
                                ])),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("args".to_string(), Value::map_of([
                                    ("params".to_string(), Value::list(vec![
                                        Value::map_of([
                                            ("name".to_string(), Value::str("id")),
                                            ("orig".to_string(), Value::str("contactId")),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                            ("kind".to_string(), Value::str("param")),
                                            ("reqd".to_string(), Value::Bool(true)),
                                            ("example".to_string(), Value::str("0f0f0f0f0f0f0f0f0f0f0f0f")),
                                        ]),
                                    ])),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("exist".to_string(), Value::list(vec![
                                        Value::str("id"),
                                    ])),
                                ])),
                            ]),
                        ])),
                    ])),
                    ("remove".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("remove")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("DELETE")),
                                ("orig".to_string(), Value::str("/contacts/{contactId}/groups/{groupId}")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("contacts")),
                                    ]),
                                    Value::map_of([
                                        ("var".to_string(), Value::str("id")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("groups")),
                                    ]),
                                    Value::map_of([
                                        ("var".to_string(), Value::str("group_id")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("contacts"),
                                    Value::str("{id}"),
                                    Value::str("groups"),
                                    Value::str("{group_id}"),
                                ])),
                                ("rename".to_string(), Value::map_of([
                                    ("param".to_string(), Value::map_of([
                                        ("contactId".to_string(), Value::str("id")),
                                        ("groupId".to_string(), Value::str("group_id")),
                                    ])),
                                ])),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("args".to_string(), Value::map_of([
                                    ("params".to_string(), Value::list(vec![
                                        Value::map_of([
                                            ("name".to_string(), Value::str("group_id")),
                                            ("orig".to_string(), Value::str("groupId")),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                            ("kind".to_string(), Value::str("param")),
                                            ("reqd".to_string(), Value::Bool(true)),
                                            ("example".to_string(), Value::str("0f0f0f0f0f0f0f0f0f0f0f0f")),
                                        ]),
                                        Value::map_of([
                                            ("name".to_string(), Value::str("id")),
                                            ("orig".to_string(), Value::str("contactId")),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                            ("kind".to_string(), Value::str("param")),
                                            ("reqd".to_string(), Value::Bool(true)),
                                            ("example".to_string(), Value::str("0f0f0f0f0f0f0f0f0f0f0f0f")),
                                        ]),
                                    ])),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("exist".to_string(), Value::list(vec![
                                        Value::str("group_id"),
                                        Value::str("id"),
                                    ])),
                                ])),
                            ]),
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("DELETE")),
                                ("orig".to_string(), Value::str("/contacts/{contactId}")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("contacts")),
                                    ]),
                                    Value::map_of([
                                        ("var".to_string(), Value::str("id")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("contacts"),
                                    Value::str("{id}"),
                                ])),
                                ("rename".to_string(), Value::map_of([
                                    ("param".to_string(), Value::map_of([
                                        ("contactId".to_string(), Value::str("id")),
                                    ])),
                                ])),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("args".to_string(), Value::map_of([
                                    ("params".to_string(), Value::list(vec![
                                        Value::map_of([
                                            ("name".to_string(), Value::str("id")),
                                            ("orig".to_string(), Value::str("contactId")),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                            ("kind".to_string(), Value::str("param")),
                                            ("reqd".to_string(), Value::Bool(true)),
                                            ("example".to_string(), Value::str("0f0f0f0f0f0f0f0f0f0f0f0f")),
                                        ]),
                                    ])),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("exist".to_string(), Value::list(vec![
                                        Value::str("id"),
                                    ])),
                                ])),
                            ]),
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("DELETE")),
                                ("orig".to_string(), Value::str("/contacts")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("contacts")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("contacts"),
                                ])),
                                ("rename".to_string(), Value::empty_map()),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("args".to_string(), Value::empty_map()),
                                ("select".to_string(), Value::empty_map()),
                            ]),
                        ])),
                    ])),
                    ("update".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("update")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("PUT")),
                                ("orig".to_string(), Value::str("/contacts/groups/{groupId}/members/{contactId}")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("contacts")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("groups")),
                                    ]),
                                    Value::map_of([
                                        ("var".to_string(), Value::str("group_id")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("members")),
                                    ]),
                                    Value::map_of([
                                        ("var".to_string(), Value::str("contact_id")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("contacts"),
                                    Value::str("groups"),
                                    Value::str("{group_id}"),
                                    Value::str("members"),
                                    Value::str("{contact_id}"),
                                ])),
                                ("rename".to_string(), Value::map_of([
                                    ("param".to_string(), Value::map_of([
                                        ("contactId".to_string(), Value::str("contact_id")),
                                        ("groupId".to_string(), Value::str("group_id")),
                                    ])),
                                ])),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("args".to_string(), Value::map_of([
                                    ("params".to_string(), Value::list(vec![
                                        Value::map_of([
                                            ("name".to_string(), Value::str("contact_id")),
                                            ("orig".to_string(), Value::str("contactId")),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                            ("kind".to_string(), Value::str("param")),
                                            ("reqd".to_string(), Value::Bool(true)),
                                            ("example".to_string(), Value::str("0f0f0f0f0f0f0f0f0f0f0f0f")),
                                        ]),
                                        Value::map_of([
                                            ("name".to_string(), Value::str("group_id")),
                                            ("orig".to_string(), Value::str("groupId")),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                            ("kind".to_string(), Value::str("param")),
                                            ("reqd".to_string(), Value::Bool(true)),
                                            ("example".to_string(), Value::str("0f0f0f0f0f0f0f0f0f0f0f0f")),
                                        ]),
                                    ])),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("exist".to_string(), Value::list(vec![
                                        Value::str("contact_id"),
                                        Value::str("group_id"),
                                    ])),
                                ])),
                            ]),
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("PUT")),
                                ("orig".to_string(), Value::str("/contacts/{contactId}/groups/{groupId}")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("contacts")),
                                    ]),
                                    Value::map_of([
                                        ("var".to_string(), Value::str("id")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("groups")),
                                    ]),
                                    Value::map_of([
                                        ("var".to_string(), Value::str("group_id")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("contacts"),
                                    Value::str("{id}"),
                                    Value::str("groups"),
                                    Value::str("{group_id}"),
                                ])),
                                ("rename".to_string(), Value::map_of([
                                    ("param".to_string(), Value::map_of([
                                        ("contactId".to_string(), Value::str("id")),
                                        ("groupId".to_string(), Value::str("group_id")),
                                    ])),
                                ])),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("args".to_string(), Value::map_of([
                                    ("params".to_string(), Value::list(vec![
                                        Value::map_of([
                                            ("name".to_string(), Value::str("group_id")),
                                            ("orig".to_string(), Value::str("groupId")),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                            ("kind".to_string(), Value::str("param")),
                                            ("reqd".to_string(), Value::Bool(true)),
                                            ("example".to_string(), Value::str("0f0f0f0f0f0f0f0f0f0f0f0f")),
                                        ]),
                                        Value::map_of([
                                            ("name".to_string(), Value::str("id")),
                                            ("orig".to_string(), Value::str("contactId")),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                            ("kind".to_string(), Value::str("param")),
                                            ("reqd".to_string(), Value::Bool(true)),
                                            ("example".to_string(), Value::str("0f0f0f0f0f0f0f0f0f0f0f0f")),
                                        ]),
                                    ])),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("exist".to_string(), Value::list(vec![
                                        Value::str("group_id"),
                                        Value::str("id"),
                                    ])),
                                ])),
                            ]),
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("PUT")),
                                ("orig".to_string(), Value::str("/contacts/{contactId}")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("contacts")),
                                    ]),
                                    Value::map_of([
                                        ("var".to_string(), Value::str("id")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("contacts"),
                                    Value::str("{id}"),
                                ])),
                                ("rename".to_string(), Value::map_of([
                                    ("param".to_string(), Value::map_of([
                                        ("contactId".to_string(), Value::str("id")),
                                    ])),
                                ])),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("args".to_string(), Value::map_of([
                                    ("params".to_string(), Value::list(vec![
                                        Value::map_of([
                                            ("name".to_string(), Value::str("id")),
                                            ("orig".to_string(), Value::str("contactId")),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                            ("kind".to_string(), Value::str("param")),
                                            ("reqd".to_string(), Value::Bool(true)),
                                            ("example".to_string(), Value::str("0f0f0f0f0f0f0f0f0f0f0f0f")),
                                        ]),
                                    ])),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("exist".to_string(), Value::list(vec![
                                        Value::str("id"),
                                    ])),
                                ])),
                            ]),
                        ])),
                    ])),
                ])),
                ("relations".to_string(), Value::map_of([
                    ("ancestors".to_string(), Value::list(vec![
                        Value::list(vec![
                            Value::str("$.main.kit.entity.group"),
                        ]),
                        Value::list(vec![
                            Value::str("$.main.kit.entity.group"),
                        ]),
                    ])),
                ])),
            ])),
            ("contacts_field".to_string(), Value::map_of([
                ("fields".to_string(), Value::list(vec![
                    Value::map_of([
                        ("name".to_string(), Value::str("birthday_date")),
                        ("title".to_string(), Value::str("Birthday Date")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("format".to_string(), Value::str("date")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("city")),
                        ("title".to_string(), Value::str("City")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("contact_expire_after")),
                        ("title".to_string(), Value::str("Contact Expire After")),
                        ("type".to_string(), Value::str("`$INTEGER`")),
                        ("req".to_string(), Value::Bool(true)),
                        ("short".to_string(), Value::str("Contact expire after days")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("contacts_count")),
                        ("title".to_string(), Value::str("Contacts Count")),
                        ("type".to_string(), Value::str("`$INTEGER`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("country")),
                        ("title".to_string(), Value::str("Country")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("created_by")),
                        ("title".to_string(), Value::str("Created By")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("req".to_string(), Value::Bool(true)),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("date_created")),
                        ("title".to_string(), Value::str("Date Created")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("req".to_string(), Value::Bool(true)),
                        ("format".to_string(), Value::str("date-time")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("date_updated")),
                        ("title".to_string(), Value::str("Date Updated")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("req".to_string(), Value::Bool(true)),
                        ("format".to_string(), Value::str("date-time")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("description")),
                        ("title".to_string(), Value::str("Description")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("email")),
                        ("title".to_string(), Value::str("Email")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("format".to_string(), Value::str("email")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("first_name")),
                        ("title".to_string(), Value::str("First Name")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("gender")),
                        ("title".to_string(), Value::str("Gender")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("req".to_string(), Value::Bool(true)),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("group_id")),
                        ("title".to_string(), Value::str("Group Id")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("short".to_string(), Value::str("Object ID")),
                        ("format".to_string(), Value::str("oid")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("groups")),
                        ("title".to_string(), Value::str("Groups")),
                        ("type".to_string(), Value::str("`$ARRAY`")),
                        ("req".to_string(), Value::Bool(true)),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("id")),
                        ("title".to_string(), Value::str("Id")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("op".to_string(), Value::map_of([
                            ("list".to_string(), Value::map_of([
                                ("req".to_string(), Value::Bool(true)),
                                ("type".to_string(), Value::str("`$STRING`")),
                            ])),
                        ])),
                        ("short".to_string(), Value::str("Object ID")),
                        ("format".to_string(), Value::str("oid")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("idx")),
                        ("title".to_string(), Value::str("Idx")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("short".to_string(), Value::str("User provided resource id")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("last_name")),
                        ("title".to_string(), Value::str("Last Name")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("name")),
                        ("title".to_string(), Value::str("Name")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("short".to_string(), Value::str("Group name")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("permissions")),
                        ("title".to_string(), Value::str("Permissions")),
                        ("type".to_string(), Value::str("`$ARRAY`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("phone_number")),
                        ("title".to_string(), Value::str("Phone Number")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("read")),
                        ("title".to_string(), Value::str("Read")),
                        ("type".to_string(), Value::str("`$BOOLEAN`")),
                        ("short".to_string(), Value::str("Has read permission")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("send")),
                        ("title".to_string(), Value::str("Send")),
                        ("type".to_string(), Value::str("`$BOOLEAN`")),
                        ("short".to_string(), Value::str("Has send permission")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("source")),
                        ("title".to_string(), Value::str("Source")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("type")),
                        ("title".to_string(), Value::str("Type")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("username")),
                        ("title".to_string(), Value::str("Username")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("value")),
                        ("title".to_string(), Value::str("Value")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("write")),
                        ("title".to_string(), Value::str("Write")),
                        ("type".to_string(), Value::str("`$BOOLEAN`")),
                        ("short".to_string(), Value::str("Has write permission")),
                    ]),
                ])),
                ("id".to_string(), Value::map_of([
                    ("field".to_string(), Value::str("id")),
                    ("name".to_string(), Value::str("id")),
                ])),
                ("name".to_string(), Value::str("contacts_field")),
                ("op".to_string(), Value::map_of([
                    ("create".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("create")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("POST")),
                                ("orig".to_string(), Value::str("/contacts/fields")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("contacts")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("fields")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("contacts"),
                                    Value::str("fields"),
                                ])),
                                ("rename".to_string(), Value::empty_map()),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("args".to_string(), Value::empty_map()),
                                ("select".to_string(), Value::empty_map()),
                            ]),
                        ])),
                    ])),
                    ("list".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("list")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("GET")),
                                ("orig".to_string(), Value::str("/contacts/fields")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("contacts")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("fields")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("contacts"),
                                    Value::str("fields"),
                                ])),
                                ("rename".to_string(), Value::empty_map()),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body.collection`")),
                                ])),
                                ("args".to_string(), Value::empty_map()),
                                ("select".to_string(), Value::empty_map()),
                            ]),
                        ])),
                    ])),
                    ("remove".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("remove")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("DELETE")),
                                ("orig".to_string(), Value::str("/contacts/fields/{fieldId}")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("contacts")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("fields")),
                                    ]),
                                    Value::map_of([
                                        ("var".to_string(), Value::str("id")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("contacts"),
                                    Value::str("fields"),
                                    Value::str("{id}"),
                                ])),
                                ("rename".to_string(), Value::map_of([
                                    ("param".to_string(), Value::map_of([
                                        ("fieldId".to_string(), Value::str("id")),
                                    ])),
                                ])),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("args".to_string(), Value::map_of([
                                    ("params".to_string(), Value::list(vec![
                                        Value::map_of([
                                            ("name".to_string(), Value::str("id")),
                                            ("orig".to_string(), Value::str("fieldId")),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                            ("kind".to_string(), Value::str("param")),
                                            ("reqd".to_string(), Value::Bool(true)),
                                            ("example".to_string(), Value::str("0f0f0f0f0f0f0f0f0f0f0f0f")),
                                        ]),
                                    ])),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("exist".to_string(), Value::list(vec![
                                        Value::str("id"),
                                    ])),
                                ])),
                            ]),
                        ])),
                    ])),
                    ("update".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("update")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("PUT")),
                                ("orig".to_string(), Value::str("/contacts/fields/{fieldId}")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("contacts")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("fields")),
                                    ]),
                                    Value::map_of([
                                        ("var".to_string(), Value::str("id")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("contacts"),
                                    Value::str("fields"),
                                    Value::str("{id}"),
                                ])),
                                ("rename".to_string(), Value::map_of([
                                    ("param".to_string(), Value::map_of([
                                        ("fieldId".to_string(), Value::str("id")),
                                    ])),
                                ])),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("args".to_string(), Value::map_of([
                                    ("params".to_string(), Value::list(vec![
                                        Value::map_of([
                                            ("name".to_string(), Value::str("id")),
                                            ("orig".to_string(), Value::str("fieldId")),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                            ("kind".to_string(), Value::str("param")),
                                            ("reqd".to_string(), Value::Bool(true)),
                                            ("example".to_string(), Value::str("0f0f0f0f0f0f0f0f0f0f0f0f")),
                                        ]),
                                    ])),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("exist".to_string(), Value::list(vec![
                                        Value::str("id"),
                                    ])),
                                ])),
                            ]),
                        ])),
                    ])),
                ])),
                ("relations".to_string(), Value::map_of([
                    ("ancestors".to_string(), Value::empty_list()),
                ])),
            ])),
            ("contacts_field_option".to_string(), Value::map_of([
                ("fields".to_string(), Value::list(vec![
                    Value::map_of([
                        ("name".to_string(), Value::str("birthday_date")),
                        ("title".to_string(), Value::str("Birthday Date")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("format".to_string(), Value::str("date")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("city")),
                        ("title".to_string(), Value::str("City")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("contact_expire_after")),
                        ("title".to_string(), Value::str("Contact Expire After")),
                        ("type".to_string(), Value::str("`$INTEGER`")),
                        ("req".to_string(), Value::Bool(true)),
                        ("short".to_string(), Value::str("Contact expire after days")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("contacts_count")),
                        ("title".to_string(), Value::str("Contacts Count")),
                        ("type".to_string(), Value::str("`$INTEGER`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("country")),
                        ("title".to_string(), Value::str("Country")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("created_by")),
                        ("title".to_string(), Value::str("Created By")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("req".to_string(), Value::Bool(true)),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("date_created")),
                        ("title".to_string(), Value::str("Date Created")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("req".to_string(), Value::Bool(true)),
                        ("format".to_string(), Value::str("date-time")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("date_updated")),
                        ("title".to_string(), Value::str("Date Updated")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("req".to_string(), Value::Bool(true)),
                        ("format".to_string(), Value::str("date-time")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("description")),
                        ("title".to_string(), Value::str("Description")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("email")),
                        ("title".to_string(), Value::str("Email")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("format".to_string(), Value::str("email")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("first_name")),
                        ("title".to_string(), Value::str("First Name")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("gender")),
                        ("title".to_string(), Value::str("Gender")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("req".to_string(), Value::Bool(true)),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("group_id")),
                        ("title".to_string(), Value::str("Group Id")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("short".to_string(), Value::str("Object ID")),
                        ("format".to_string(), Value::str("oid")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("groups")),
                        ("title".to_string(), Value::str("Groups")),
                        ("type".to_string(), Value::str("`$ARRAY`")),
                        ("req".to_string(), Value::Bool(true)),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("id")),
                        ("title".to_string(), Value::str("Id")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("req".to_string(), Value::Bool(true)),
                        ("short".to_string(), Value::str("Object ID")),
                        ("format".to_string(), Value::str("oid")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("idx")),
                        ("title".to_string(), Value::str("Idx")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("short".to_string(), Value::str("User provided resource id")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("last_name")),
                        ("title".to_string(), Value::str("Last Name")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("name")),
                        ("title".to_string(), Value::str("Name")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("short".to_string(), Value::str("Group name")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("permissions")),
                        ("title".to_string(), Value::str("Permissions")),
                        ("type".to_string(), Value::str("`$ARRAY`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("phone_number")),
                        ("title".to_string(), Value::str("Phone Number")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("read")),
                        ("title".to_string(), Value::str("Read")),
                        ("type".to_string(), Value::str("`$BOOLEAN`")),
                        ("short".to_string(), Value::str("Has read permission")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("send")),
                        ("title".to_string(), Value::str("Send")),
                        ("type".to_string(), Value::str("`$BOOLEAN`")),
                        ("short".to_string(), Value::str("Has send permission")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("source")),
                        ("title".to_string(), Value::str("Source")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("type")),
                        ("title".to_string(), Value::str("Type")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("username")),
                        ("title".to_string(), Value::str("Username")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("value")),
                        ("title".to_string(), Value::str("Value")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("write")),
                        ("title".to_string(), Value::str("Write")),
                        ("type".to_string(), Value::str("`$BOOLEAN`")),
                        ("short".to_string(), Value::str("Has write permission")),
                    ]),
                ])),
                ("id".to_string(), Value::map_of([
                    ("field".to_string(), Value::str("id")),
                    ("name".to_string(), Value::str("id")),
                ])),
                ("name".to_string(), Value::str("contacts_field_option")),
                ("op".to_string(), Value::map_of([
                    ("list".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("list")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("GET")),
                                ("orig".to_string(), Value::str("/contacts/fields/{fieldId}/options")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("contacts")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("fields")),
                                    ]),
                                    Value::map_of([
                                        ("var".to_string(), Value::str("field_id")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("options")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("contacts"),
                                    Value::str("fields"),
                                    Value::str("{field_id}"),
                                    Value::str("options"),
                                ])),
                                ("rename".to_string(), Value::map_of([
                                    ("param".to_string(), Value::map_of([
                                        ("fieldId".to_string(), Value::str("field_id")),
                                    ])),
                                ])),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body.collection`")),
                                ])),
                                ("args".to_string(), Value::map_of([
                                    ("params".to_string(), Value::list(vec![
                                        Value::map_of([
                                            ("name".to_string(), Value::str("field_id")),
                                            ("orig".to_string(), Value::str("fieldId")),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                            ("kind".to_string(), Value::str("param")),
                                            ("reqd".to_string(), Value::Bool(true)),
                                            ("example".to_string(), Value::str("0f0f0f0f0f0f0f0f0f0f0f0f")),
                                        ]),
                                    ])),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("exist".to_string(), Value::list(vec![
                                        Value::str("field_id"),
                                    ])),
                                ])),
                            ]),
                        ])),
                    ])),
                ])),
                ("relations".to_string(), Value::map_of([
                    ("ancestors".to_string(), Value::empty_list()),
                ])),
            ])),
            ("contactsgroup".to_string(), Value::map_of([
                ("fields".to_string(), Value::list(vec![
                    Value::map_of([
                        ("name".to_string(), Value::str("birthday_date")),
                        ("title".to_string(), Value::str("Birthday Date")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("format".to_string(), Value::str("date")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("city")),
                        ("title".to_string(), Value::str("City")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("contact_expire_after")),
                        ("title".to_string(), Value::str("Contact Expire After")),
                        ("type".to_string(), Value::str("`$INTEGER`")),
                        ("req".to_string(), Value::Bool(true)),
                        ("short".to_string(), Value::str("Contact expire after days")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("contacts_count")),
                        ("title".to_string(), Value::str("Contacts Count")),
                        ("type".to_string(), Value::str("`$INTEGER`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("country")),
                        ("title".to_string(), Value::str("Country")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("created_by")),
                        ("title".to_string(), Value::str("Created By")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("req".to_string(), Value::Bool(true)),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("date_created")),
                        ("title".to_string(), Value::str("Date Created")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("req".to_string(), Value::Bool(true)),
                        ("format".to_string(), Value::str("date-time")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("date_updated")),
                        ("title".to_string(), Value::str("Date Updated")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("req".to_string(), Value::Bool(true)),
                        ("format".to_string(), Value::str("date-time")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("description")),
                        ("title".to_string(), Value::str("Description")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("email")),
                        ("title".to_string(), Value::str("Email")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("format".to_string(), Value::str("email")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("first_name")),
                        ("title".to_string(), Value::str("First Name")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("gender")),
                        ("title".to_string(), Value::str("Gender")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("req".to_string(), Value::Bool(true)),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("group_id")),
                        ("title".to_string(), Value::str("Group Id")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("req".to_string(), Value::Bool(true)),
                        ("op".to_string(), Value::map_of([
                            ("list".to_string(), Value::map_of([
                                ("type".to_string(), Value::str("`$STRING`")),
                            ])),
                        ])),
                        ("short".to_string(), Value::str("Object ID")),
                        ("format".to_string(), Value::str("oid")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("groups")),
                        ("title".to_string(), Value::str("Groups")),
                        ("type".to_string(), Value::str("`$ARRAY`")),
                        ("req".to_string(), Value::Bool(true)),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("id")),
                        ("title".to_string(), Value::str("Id")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("req".to_string(), Value::Bool(true)),
                        ("short".to_string(), Value::str("Object ID")),
                        ("format".to_string(), Value::str("oid")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("idx")),
                        ("title".to_string(), Value::str("Idx")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("short".to_string(), Value::str("User provided resource id")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("last_name")),
                        ("title".to_string(), Value::str("Last Name")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("name")),
                        ("title".to_string(), Value::str("Name")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("short".to_string(), Value::str("Group name")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("permissions")),
                        ("title".to_string(), Value::str("Permissions")),
                        ("type".to_string(), Value::str("`$ARRAY`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("phone_number")),
                        ("title".to_string(), Value::str("Phone Number")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("read")),
                        ("title".to_string(), Value::str("Read")),
                        ("type".to_string(), Value::str("`$BOOLEAN`")),
                        ("req".to_string(), Value::Bool(true)),
                        ("op".to_string(), Value::map_of([
                            ("list".to_string(), Value::map_of([
                                ("type".to_string(), Value::str("`$BOOLEAN`")),
                            ])),
                        ])),
                        ("short".to_string(), Value::str("Has read permission")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("send")),
                        ("title".to_string(), Value::str("Send")),
                        ("type".to_string(), Value::str("`$BOOLEAN`")),
                        ("req".to_string(), Value::Bool(true)),
                        ("op".to_string(), Value::map_of([
                            ("list".to_string(), Value::map_of([
                                ("type".to_string(), Value::str("`$BOOLEAN`")),
                            ])),
                        ])),
                        ("short".to_string(), Value::str("Has send permission")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("source")),
                        ("title".to_string(), Value::str("Source")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("type")),
                        ("title".to_string(), Value::str("Type")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("username")),
                        ("title".to_string(), Value::str("Username")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("req".to_string(), Value::Bool(true)),
                        ("op".to_string(), Value::map_of([
                            ("list".to_string(), Value::map_of([
                                ("type".to_string(), Value::str("`$STRING`")),
                            ])),
                        ])),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("value")),
                        ("title".to_string(), Value::str("Value")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("write")),
                        ("title".to_string(), Value::str("Write")),
                        ("type".to_string(), Value::str("`$BOOLEAN`")),
                        ("req".to_string(), Value::Bool(true)),
                        ("op".to_string(), Value::map_of([
                            ("list".to_string(), Value::map_of([
                                ("type".to_string(), Value::str("`$BOOLEAN`")),
                            ])),
                        ])),
                        ("short".to_string(), Value::str("Has write permission")),
                    ]),
                ])),
                ("id".to_string(), Value::map_of([
                    ("field".to_string(), Value::str("id")),
                    ("name".to_string(), Value::str("id")),
                ])),
                ("name".to_string(), Value::str("contactsgroup")),
                ("op".to_string(), Value::map_of([
                    ("create".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("create")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("POST")),
                                ("orig".to_string(), Value::str("/contacts/groups/{groupId}/members")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("contacts")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("groups")),
                                    ]),
                                    Value::map_of([
                                        ("var".to_string(), Value::str("group_id")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("members")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("contacts"),
                                    Value::str("groups"),
                                    Value::str("{group_id}"),
                                    Value::str("members"),
                                ])),
                                ("rename".to_string(), Value::map_of([
                                    ("param".to_string(), Value::map_of([
                                        ("groupId".to_string(), Value::str("group_id")),
                                    ])),
                                ])),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("args".to_string(), Value::map_of([
                                    ("params".to_string(), Value::list(vec![
                                        Value::map_of([
                                            ("name".to_string(), Value::str("group_id")),
                                            ("orig".to_string(), Value::str("groupId")),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                            ("kind".to_string(), Value::str("param")),
                                            ("reqd".to_string(), Value::Bool(true)),
                                            ("example".to_string(), Value::str("0f0f0f0f0f0f0f0f0f0f0f0f")),
                                        ]),
                                    ])),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("exist".to_string(), Value::list(vec![
                                        Value::str("group_id"),
                                    ])),
                                ])),
                            ]),
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("POST")),
                                ("orig".to_string(), Value::str("/contacts/groups")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("contacts")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("groups")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("contacts"),
                                    Value::str("groups"),
                                ])),
                                ("rename".to_string(), Value::empty_map()),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("args".to_string(), Value::empty_map()),
                                ("select".to_string(), Value::empty_map()),
                            ]),
                        ])),
                    ])),
                    ("list".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("list")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("GET")),
                                ("orig".to_string(), Value::str("/contacts/groups")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("contacts")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("groups")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("contacts"),
                                    Value::str("groups"),
                                ])),
                                ("rename".to_string(), Value::empty_map()),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body.collection`")),
                                ])),
                                ("args".to_string(), Value::map_of([
                                    ("query".to_string(), Value::list(vec![
                                        Value::map_of([
                                            ("name".to_string(), Value::str("name")),
                                            ("orig".to_string(), Value::str("name")),
                                            ("type".to_string(), Value::str("`$OBJECT`")),
                                            ("kind".to_string(), Value::str("query")),
                                            ("example".to_string(), Value::str("{\"name\" : \"group name\"}")),
                                        ]),
                                        Value::map_of([
                                            ("name".to_string(), Value::str("with")),
                                            ("orig".to_string(), Value::str("with")),
                                            ("type".to_string(), Value::str("`$ARRAY`")),
                                            ("kind".to_string(), Value::str("query")),
                                        ]),
                                    ])),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("exist".to_string(), Value::list(vec![
                                        Value::str("name"),
                                        Value::str("with"),
                                    ])),
                                ])),
                            ]),
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("GET")),
                                ("orig".to_string(), Value::str("/contacts/groups/{groupId}/permissions")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("contacts")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("groups")),
                                    ]),
                                    Value::map_of([
                                        ("var".to_string(), Value::str("group_id")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("permissions")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("contacts"),
                                    Value::str("groups"),
                                    Value::str("{group_id}"),
                                    Value::str("permissions"),
                                ])),
                                ("rename".to_string(), Value::map_of([
                                    ("param".to_string(), Value::map_of([
                                        ("groupId".to_string(), Value::str("group_id")),
                                    ])),
                                ])),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body.collection`")),
                                ])),
                                ("args".to_string(), Value::map_of([
                                    ("params".to_string(), Value::list(vec![
                                        Value::map_of([
                                            ("name".to_string(), Value::str("group_id")),
                                            ("orig".to_string(), Value::str("groupId")),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                            ("kind".to_string(), Value::str("param")),
                                            ("reqd".to_string(), Value::Bool(true)),
                                            ("example".to_string(), Value::str("0f0f0f0f0f0f0f0f0f0f0f0f")),
                                        ]),
                                    ])),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("exist".to_string(), Value::list(vec![
                                        Value::str("group_id"),
                                    ])),
                                ])),
                            ]),
                        ])),
                    ])),
                    ("remove".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("remove")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("DELETE")),
                                ("orig".to_string(), Value::str("/contacts/groups/{groupId}/members/{contactId}")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("contacts")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("groups")),
                                    ]),
                                    Value::map_of([
                                        ("var".to_string(), Value::str("group_id")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("members")),
                                    ]),
                                    Value::map_of([
                                        ("var".to_string(), Value::str("contact_id")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("contacts"),
                                    Value::str("groups"),
                                    Value::str("{group_id}"),
                                    Value::str("members"),
                                    Value::str("{contact_id}"),
                                ])),
                                ("rename".to_string(), Value::map_of([
                                    ("param".to_string(), Value::map_of([
                                        ("contactId".to_string(), Value::str("contact_id")),
                                        ("groupId".to_string(), Value::str("group_id")),
                                    ])),
                                ])),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("args".to_string(), Value::map_of([
                                    ("params".to_string(), Value::list(vec![
                                        Value::map_of([
                                            ("name".to_string(), Value::str("contact_id")),
                                            ("orig".to_string(), Value::str("contactId")),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                            ("kind".to_string(), Value::str("param")),
                                            ("reqd".to_string(), Value::Bool(true)),
                                            ("example".to_string(), Value::str("0f0f0f0f0f0f0f0f0f0f0f0f")),
                                        ]),
                                        Value::map_of([
                                            ("name".to_string(), Value::str("group_id")),
                                            ("orig".to_string(), Value::str("groupId")),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                            ("kind".to_string(), Value::str("param")),
                                            ("reqd".to_string(), Value::Bool(true)),
                                            ("example".to_string(), Value::str("0f0f0f0f0f0f0f0f0f0f0f0f")),
                                        ]),
                                    ])),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("exist".to_string(), Value::list(vec![
                                        Value::str("contact_id"),
                                        Value::str("group_id"),
                                    ])),
                                ])),
                            ]),
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("DELETE")),
                                ("orig".to_string(), Value::str("/contacts/groups/{groupId}/permissions/{username}")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("contacts")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("groups")),
                                    ]),
                                    Value::map_of([
                                        ("var".to_string(), Value::str("group_id")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("permissions")),
                                    ]),
                                    Value::map_of([
                                        ("var".to_string(), Value::str("username")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("contacts"),
                                    Value::str("groups"),
                                    Value::str("{group_id}"),
                                    Value::str("permissions"),
                                    Value::str("{username}"),
                                ])),
                                ("rename".to_string(), Value::map_of([
                                    ("param".to_string(), Value::map_of([
                                        ("groupId".to_string(), Value::str("group_id")),
                                    ])),
                                ])),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("args".to_string(), Value::map_of([
                                    ("params".to_string(), Value::list(vec![
                                        Value::map_of([
                                            ("name".to_string(), Value::str("group_id")),
                                            ("orig".to_string(), Value::str("groupId")),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                            ("kind".to_string(), Value::str("param")),
                                            ("reqd".to_string(), Value::Bool(true)),
                                            ("example".to_string(), Value::str("0f0f0f0f0f0f0f0f0f0f0f0f")),
                                        ]),
                                        Value::map_of([
                                            ("name".to_string(), Value::str("username")),
                                            ("orig".to_string(), Value::str("username")),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                            ("kind".to_string(), Value::str("param")),
                                            ("reqd".to_string(), Value::Bool(true)),
                                        ]),
                                    ])),
                                    ("query".to_string(), Value::list(vec![
                                        Value::map_of([
                                            ("name".to_string(), Value::str("username")),
                                            ("orig".to_string(), Value::str("username")),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                            ("kind".to_string(), Value::str("query")),
                                            ("reqd".to_string(), Value::Bool(true)),
                                            ("example".to_string(), Value::str("example_username")),
                                        ]),
                                    ])),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("exist".to_string(), Value::list(vec![
                                        Value::str("group_id"),
                                        Value::str("username"),
                                    ])),
                                ])),
                            ]),
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("DELETE")),
                                ("orig".to_string(), Value::str("/contacts/groups/{groupId}")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("contacts")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("groups")),
                                    ]),
                                    Value::map_of([
                                        ("var".to_string(), Value::str("group_id")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("contacts"),
                                    Value::str("groups"),
                                    Value::str("{group_id}"),
                                ])),
                                ("rename".to_string(), Value::map_of([
                                    ("param".to_string(), Value::map_of([
                                        ("groupId".to_string(), Value::str("group_id")),
                                    ])),
                                ])),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("args".to_string(), Value::map_of([
                                    ("params".to_string(), Value::list(vec![
                                        Value::map_of([
                                            ("name".to_string(), Value::str("group_id")),
                                            ("orig".to_string(), Value::str("groupId")),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                            ("kind".to_string(), Value::str("param")),
                                            ("reqd".to_string(), Value::Bool(true)),
                                            ("example".to_string(), Value::str("0f0f0f0f0f0f0f0f0f0f0f0f")),
                                        ]),
                                    ])),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("exist".to_string(), Value::list(vec![
                                        Value::str("group_id"),
                                    ])),
                                ])),
                            ]),
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("DELETE")),
                                ("orig".to_string(), Value::str("/contacts/groups/{groupId}/members")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("contacts")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("groups")),
                                    ]),
                                    Value::map_of([
                                        ("var".to_string(), Value::str("group_id")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("members")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("contacts"),
                                    Value::str("groups"),
                                    Value::str("{group_id}"),
                                    Value::str("members"),
                                ])),
                                ("rename".to_string(), Value::map_of([
                                    ("param".to_string(), Value::map_of([
                                        ("groupId".to_string(), Value::str("group_id")),
                                    ])),
                                ])),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("args".to_string(), Value::map_of([
                                    ("params".to_string(), Value::list(vec![
                                        Value::map_of([
                                            ("name".to_string(), Value::str("group_id")),
                                            ("orig".to_string(), Value::str("groupId")),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                            ("kind".to_string(), Value::str("param")),
                                            ("reqd".to_string(), Value::Bool(true)),
                                            ("example".to_string(), Value::str("0f0f0f0f0f0f0f0f0f0f0f0f")),
                                        ]),
                                    ])),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("exist".to_string(), Value::list(vec![
                                        Value::str("group_id"),
                                    ])),
                                ])),
                            ]),
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("DELETE")),
                                ("orig".to_string(), Value::str("/contacts/groups")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("contacts")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("groups")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("contacts"),
                                    Value::str("groups"),
                                ])),
                                ("rename".to_string(), Value::empty_map()),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("args".to_string(), Value::empty_map()),
                                ("select".to_string(), Value::empty_map()),
                            ]),
                        ])),
                    ])),
                    ("update".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("update")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("PUT")),
                                ("orig".to_string(), Value::str("/contacts/groups/{groupId}/permissions/{username}")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("contacts")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("groups")),
                                    ]),
                                    Value::map_of([
                                        ("var".to_string(), Value::str("group_id")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("permissions")),
                                    ]),
                                    Value::map_of([
                                        ("var".to_string(), Value::str("username")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("contacts"),
                                    Value::str("groups"),
                                    Value::str("{group_id}"),
                                    Value::str("permissions"),
                                    Value::str("{username}"),
                                ])),
                                ("rename".to_string(), Value::map_of([
                                    ("param".to_string(), Value::map_of([
                                        ("groupId".to_string(), Value::str("group_id")),
                                    ])),
                                ])),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("args".to_string(), Value::map_of([
                                    ("params".to_string(), Value::list(vec![
                                        Value::map_of([
                                            ("name".to_string(), Value::str("group_id")),
                                            ("orig".to_string(), Value::str("groupId")),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                            ("kind".to_string(), Value::str("param")),
                                            ("reqd".to_string(), Value::Bool(true)),
                                            ("example".to_string(), Value::str("0f0f0f0f0f0f0f0f0f0f0f0f")),
                                        ]),
                                        Value::map_of([
                                            ("name".to_string(), Value::str("username")),
                                            ("orig".to_string(), Value::str("username")),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                            ("kind".to_string(), Value::str("param")),
                                            ("reqd".to_string(), Value::Bool(true)),
                                        ]),
                                    ])),
                                    ("query".to_string(), Value::list(vec![
                                        Value::map_of([
                                            ("name".to_string(), Value::str("username")),
                                            ("orig".to_string(), Value::str("username")),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                            ("kind".to_string(), Value::str("query")),
                                            ("reqd".to_string(), Value::Bool(true)),
                                            ("example".to_string(), Value::str("example_username")),
                                        ]),
                                    ])),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("exist".to_string(), Value::list(vec![
                                        Value::str("group_id"),
                                        Value::str("username"),
                                    ])),
                                ])),
                            ]),
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("PUT")),
                                ("orig".to_string(), Value::str("/contacts/groups/{groupId}/members")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("contacts")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("groups")),
                                    ]),
                                    Value::map_of([
                                        ("var".to_string(), Value::str("group_id")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("members")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("contacts"),
                                    Value::str("groups"),
                                    Value::str("{group_id}"),
                                    Value::str("members"),
                                ])),
                                ("rename".to_string(), Value::map_of([
                                    ("param".to_string(), Value::map_of([
                                        ("groupId".to_string(), Value::str("group_id")),
                                    ])),
                                ])),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("args".to_string(), Value::map_of([
                                    ("params".to_string(), Value::list(vec![
                                        Value::map_of([
                                            ("name".to_string(), Value::str("group_id")),
                                            ("orig".to_string(), Value::str("groupId")),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                            ("kind".to_string(), Value::str("param")),
                                            ("reqd".to_string(), Value::Bool(true)),
                                            ("example".to_string(), Value::str("0f0f0f0f0f0f0f0f0f0f0f0f")),
                                        ]),
                                    ])),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("exist".to_string(), Value::list(vec![
                                        Value::str("group_id"),
                                    ])),
                                ])),
                            ]),
                        ])),
                    ])),
                ])),
                ("relations".to_string(), Value::map_of([
                    ("ancestors".to_string(), Value::list(vec![
                        Value::list(vec![
                            Value::str("$.main.kit.entity.group"),
                        ]),
                        Value::list(vec![
                            Value::str("$.main.kit.entity.group"),
                        ]),
                        Value::list(vec![
                            Value::str("$.main.kit.entity.group"),
                            Value::str("$.main.kit.entity.permission"),
                        ]),
                    ])),
                ])),
            ])),
            ("contactstrash".to_string(), Value::map_of([
                ("fields".to_string(), Value::empty_list()),
                ("name".to_string(), Value::str("contactstrash")),
                ("op".to_string(), Value::map_of([
                    ("remove".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("remove")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("DELETE")),
                                ("orig".to_string(), Value::str("/contacts/trash")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("contacts")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("trash")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("contacts"),
                                    Value::str("trash"),
                                ])),
                                ("rename".to_string(), Value::empty_map()),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("args".to_string(), Value::empty_map()),
                                ("select".to_string(), Value::empty_map()),
                            ]),
                        ])),
                    ])),
                    ("update".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("update")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("PUT")),
                                ("orig".to_string(), Value::str("/contacts/trash/restore")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("contacts")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("trash")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("restore")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("contacts"),
                                    Value::str("trash"),
                                    Value::str("restore"),
                                ])),
                                ("rename".to_string(), Value::empty_map()),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("args".to_string(), Value::empty_map()),
                                ("select".to_string(), Value::empty_map()),
                            ]),
                        ])),
                    ])),
                ])),
                ("relations".to_string(), Value::map_of([
                    ("ancestors".to_string(), Value::empty_list()),
                ])),
            ])),
            ("field_available".to_string(), Value::map_of([
                ("fields".to_string(), Value::list(vec![
                    Value::map_of([
                        ("name".to_string(), Value::str("built_in")),
                        ("title".to_string(), Value::str("Built In")),
                        ("type".to_string(), Value::str("`$BOOLEAN`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("id")),
                        ("title".to_string(), Value::str("Id")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("short".to_string(), Value::str("Object ID")),
                        ("format".to_string(), Value::str("oid")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("name")),
                        ("title".to_string(), Value::str("Name")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("options")),
                        ("title".to_string(), Value::str("Options")),
                        ("type".to_string(), Value::str("`$ARRAY`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("type")),
                        ("title".to_string(), Value::str("Type")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                ])),
                ("id".to_string(), Value::map_of([
                    ("field".to_string(), Value::str("id")),
                    ("name".to_string(), Value::str("id")),
                ])),
                ("name".to_string(), Value::str("field_available")),
                ("op".to_string(), Value::map_of([
                    ("list".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("list")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("GET")),
                                ("orig".to_string(), Value::str("/contacts/fields/available")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("contacts")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("fields")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("available")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("contacts"),
                                    Value::str("fields"),
                                    Value::str("available"),
                                ])),
                                ("rename".to_string(), Value::empty_map()),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("args".to_string(), Value::empty_map()),
                                ("select".to_string(), Value::empty_map()),
                            ]),
                        ])),
                    ])),
                ])),
                ("relations".to_string(), Value::map_of([
                    ("ancestors".to_string(), Value::empty_list()),
                ])),
            ])),
            ("group".to_string(), Value::map_of([
                ("fields".to_string(), Value::list(vec![
                    Value::map_of([
                        ("name".to_string(), Value::str("contact_expire_after")),
                        ("title".to_string(), Value::str("Contact Expire After")),
                        ("type".to_string(), Value::str("`$INTEGER`")),
                        ("req".to_string(), Value::Bool(true)),
                        ("short".to_string(), Value::str("Contact expire after days")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("contacts_count")),
                        ("title".to_string(), Value::str("Contacts Count")),
                        ("type".to_string(), Value::str("`$INTEGER`")),
                        ("req".to_string(), Value::Bool(true)),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("created_by")),
                        ("title".to_string(), Value::str("Created By")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("req".to_string(), Value::Bool(true)),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("date_created")),
                        ("title".to_string(), Value::str("Date Created")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("req".to_string(), Value::Bool(true)),
                        ("format".to_string(), Value::str("date-time")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("date_updated")),
                        ("title".to_string(), Value::str("Date Updated")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("req".to_string(), Value::Bool(true)),
                        ("format".to_string(), Value::str("date-time")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("description")),
                        ("title".to_string(), Value::str("Description")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("req".to_string(), Value::Bool(true)),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("id")),
                        ("title".to_string(), Value::str("Id")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("req".to_string(), Value::Bool(true)),
                        ("short".to_string(), Value::str("Object ID")),
                        ("format".to_string(), Value::str("oid")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("idx")),
                        ("title".to_string(), Value::str("Idx")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("short".to_string(), Value::str("User provided resource id")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("name")),
                        ("title".to_string(), Value::str("Name")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("req".to_string(), Value::Bool(true)),
                        ("short".to_string(), Value::str("Group name")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("permissions")),
                        ("title".to_string(), Value::str("Permissions")),
                        ("type".to_string(), Value::str("`$ARRAY`")),
                    ]),
                ])),
                ("id".to_string(), Value::map_of([
                    ("field".to_string(), Value::str("id")),
                    ("name".to_string(), Value::str("id")),
                ])),
                ("name".to_string(), Value::str("group")),
                ("op".to_string(), Value::map_of([
                    ("load".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("load")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("GET")),
                                ("orig".to_string(), Value::str("/contacts/groups/{groupId}")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("contacts")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("groups")),
                                    ]),
                                    Value::map_of([
                                        ("var".to_string(), Value::str("id")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("contacts"),
                                    Value::str("groups"),
                                    Value::str("{id}"),
                                ])),
                                ("rename".to_string(), Value::map_of([
                                    ("param".to_string(), Value::map_of([
                                        ("groupId".to_string(), Value::str("id")),
                                    ])),
                                ])),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("args".to_string(), Value::map_of([
                                    ("params".to_string(), Value::list(vec![
                                        Value::map_of([
                                            ("name".to_string(), Value::str("id")),
                                            ("orig".to_string(), Value::str("groupId")),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                            ("kind".to_string(), Value::str("param")),
                                            ("reqd".to_string(), Value::Bool(true)),
                                            ("example".to_string(), Value::str("0f0f0f0f0f0f0f0f0f0f0f0f")),
                                        ]),
                                    ])),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("exist".to_string(), Value::list(vec![
                                        Value::str("id"),
                                    ])),
                                ])),
                            ]),
                        ])),
                    ])),
                    ("update".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("update")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("PUT")),
                                ("orig".to_string(), Value::str("/contacts/groups/{groupId}")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("contacts")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("groups")),
                                    ]),
                                    Value::map_of([
                                        ("var".to_string(), Value::str("id")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("contacts"),
                                    Value::str("groups"),
                                    Value::str("{id}"),
                                ])),
                                ("rename".to_string(), Value::map_of([
                                    ("param".to_string(), Value::map_of([
                                        ("groupId".to_string(), Value::str("id")),
                                    ])),
                                ])),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("args".to_string(), Value::map_of([
                                    ("params".to_string(), Value::list(vec![
                                        Value::map_of([
                                            ("name".to_string(), Value::str("id")),
                                            ("orig".to_string(), Value::str("groupId")),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                            ("kind".to_string(), Value::str("param")),
                                            ("reqd".to_string(), Value::Bool(true)),
                                            ("example".to_string(), Value::str("0f0f0f0f0f0f0f0f0f0f0f0f")),
                                        ]),
                                    ])),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("exist".to_string(), Value::list(vec![
                                        Value::str("id"),
                                    ])),
                                ])),
                            ]),
                        ])),
                    ])),
                ])),
                ("relations".to_string(), Value::map_of([
                    ("ancestors".to_string(), Value::empty_list()),
                ])),
            ])),
            ("mfa_code".to_string(), Value::map_of([
                ("fields".to_string(), Value::list(vec![
                    Value::map_of([
                        ("name".to_string(), Value::str("content")),
                        ("title".to_string(), Value::str("Content")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("short".to_string(), Value::str("Custom content that must contain placeholder [%code%]")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("fast")),
                        ("title".to_string(), Value::str("Fast")),
                        ("type".to_string(), Value::str("`$ANY`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("from")),
                        ("title".to_string(), Value::str("From")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("short".to_string(), Value::str("Sendername")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("phone_number")),
                        ("title".to_string(), Value::str("Phone Number")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("req".to_string(), Value::Bool(true)),
                    ]),
                ])),
                ("name".to_string(), Value::str("mfa_code")),
                ("op".to_string(), Value::map_of([
                    ("create".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("create")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("POST")),
                                ("orig".to_string(), Value::str("/mfa/codes")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("mfa")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("codes")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("mfa"),
                                    Value::str("codes"),
                                ])),
                                ("rename".to_string(), Value::empty_map()),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("args".to_string(), Value::empty_map()),
                                ("select".to_string(), Value::empty_map()),
                            ]),
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("POST")),
                                ("orig".to_string(), Value::str("/mfa/codes/verifications")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("mfa")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("codes")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("verifications")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("mfa"),
                                    Value::str("codes"),
                                    Value::str("verifications"),
                                ])),
                                ("rename".to_string(), Value::empty_map()),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("args".to_string(), Value::empty_map()),
                                ("select".to_string(), Value::map_of([
                                    ("$action".to_string(), Value::str("verification")),
                                ])),
                            ]),
                        ])),
                    ])),
                ])),
                ("relations".to_string(), Value::map_of([
                    ("ancestors".to_string(), Value::empty_list()),
                ])),
            ])),
            ("opt_out".to_string(), Value::map_of([
                ("fields".to_string(), Value::list(vec![
                    Value::map_of([
                        ("name".to_string(), Value::str("date")),
                        ("title".to_string(), Value::str("Date")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("format".to_string(), Value::str("date-time")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("id")),
                        ("title".to_string(), Value::str("Id")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("links")),
                        ("title".to_string(), Value::str("Links")),
                        ("type".to_string(), Value::str("`$ARRAY`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("phoneNumber")),
                        ("title".to_string(), Value::str("Phone Number")),
                        ("type".to_string(), Value::str("`$INTEGER`")),
                    ]),
                ])),
                ("id".to_string(), Value::map_of([
                    ("field".to_string(), Value::str("id")),
                    ("name".to_string(), Value::str("id")),
                ])),
                ("name".to_string(), Value::str("opt_out")),
                ("op".to_string(), Value::map_of([
                    ("list".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("list")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("GET")),
                                ("orig".to_string(), Value::str("/opt_outs")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("opt_outs")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("opt_outs"),
                                ])),
                                ("rename".to_string(), Value::empty_map()),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body.collection`")),
                                ])),
                                ("args".to_string(), Value::map_of([
                                    ("header".to_string(), Value::list(vec![
                                        Value::map_of([
                                            ("name".to_string(), Value::str("accept")),
                                            ("orig".to_string(), Value::str("Accept")),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                            ("kind".to_string(), Value::str("header")),
                                            ("example".to_string(), Value::str("application/json")),
                                        ]),
                                        Value::map_of([
                                            ("name".to_string(), Value::str("x_async")),
                                            ("orig".to_string(), Value::str("x-async")),
                                            ("type".to_string(), Value::str("`$BOOLEAN`")),
                                            ("kind".to_string(), Value::str("header")),
                                            ("example".to_string(), Value::Bool(false)),
                                        ]),
                                    ])),
                                    ("query".to_string(), Value::list(vec![
                                        Value::map_of([
                                            ("name".to_string(), Value::str("limit")),
                                            ("orig".to_string(), Value::str("limit")),
                                            ("type".to_string(), Value::str("`$INTEGER`")),
                                            ("kind".to_string(), Value::str("query")),
                                            ("example".to_string(), Value::Num(5f64)),
                                        ]),
                                        Value::map_of([
                                            ("name".to_string(), Value::str("offset")),
                                            ("orig".to_string(), Value::str("offset")),
                                            ("type".to_string(), Value::str("`$INTEGER`")),
                                            ("kind".to_string(), Value::str("query")),
                                            ("example".to_string(), Value::Num(0f64)),
                                        ]),
                                        Value::map_of([
                                            ("name".to_string(), Value::str("phone_number")),
                                            ("orig".to_string(), Value::str("phone_number")),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                            ("kind".to_string(), Value::str("query")),
                                        ]),
                                    ])),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("exist".to_string(), Value::list(vec![
                                        Value::str("accept"),
                                        Value::str("limit"),
                                        Value::str("offset"),
                                        Value::str("phone_number"),
                                        Value::str("x_async"),
                                    ])),
                                ])),
                            ]),
                        ])),
                    ])),
                    ("remove".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("remove")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("DELETE")),
                                ("orig".to_string(), Value::str("/opt_outs/{optOutId}")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("opt_outs")),
                                    ]),
                                    Value::map_of([
                                        ("var".to_string(), Value::str("id")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("opt_outs"),
                                    Value::str("{id}"),
                                ])),
                                ("rename".to_string(), Value::map_of([
                                    ("param".to_string(), Value::map_of([
                                        ("optOutId".to_string(), Value::str("id")),
                                    ])),
                                ])),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("args".to_string(), Value::map_of([
                                    ("params".to_string(), Value::list(vec![
                                        Value::map_of([
                                            ("name".to_string(), Value::str("id")),
                                            ("orig".to_string(), Value::str("optOutId")),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                            ("kind".to_string(), Value::str("param")),
                                            ("reqd".to_string(), Value::Bool(true)),
                                        ]),
                                    ])),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("exist".to_string(), Value::list(vec![
                                        Value::str("id"),
                                    ])),
                                ])),
                            ]),
                        ])),
                    ])),
                ])),
                ("relations".to_string(), Value::map_of([
                    ("ancestors".to_string(), Value::empty_list()),
                ])),
            ])),
            ("opt_out_setting".to_string(), Value::map_of([
                ("fields".to_string(), Value::list(vec![
                    Value::map_of([
                        ("name".to_string(), Value::str("brand")),
                        ("title".to_string(), Value::str("Brand")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                ])),
                ("name".to_string(), Value::str("opt_out_setting")),
                ("op".to_string(), Value::map_of([
                    ("load".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("load")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("GET")),
                                ("orig".to_string(), Value::str("/opt_outs/settings")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("opt_outs")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("settings")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("opt_outs"),
                                    Value::str("settings"),
                                ])),
                                ("rename".to_string(), Value::empty_map()),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("args".to_string(), Value::empty_map()),
                                ("select".to_string(), Value::empty_map()),
                            ]),
                        ])),
                    ])),
                    ("update".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("update")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("PUT")),
                                ("orig".to_string(), Value::str("/opt_outs/settings")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("opt_outs")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("settings")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("opt_outs"),
                                    Value::str("settings"),
                                ])),
                                ("rename".to_string(), Value::empty_map()),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("args".to_string(), Value::empty_map()),
                                ("select".to_string(), Value::empty_map()),
                            ]),
                        ])),
                    ])),
                ])),
                ("relations".to_string(), Value::map_of([
                    ("ancestors".to_string(), Value::empty_list()),
                ])),
            ])),
            ("permission".to_string(), Value::map_of([
                ("fields".to_string(), Value::list(vec![
                    Value::map_of([
                        ("name".to_string(), Value::str("group_id")),
                        ("title".to_string(), Value::str("Group Id")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("req".to_string(), Value::Bool(true)),
                        ("short".to_string(), Value::str("Object ID")),
                        ("format".to_string(), Value::str("oid")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("id")),
                        ("title".to_string(), Value::str("Id")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("read")),
                        ("title".to_string(), Value::str("Read")),
                        ("type".to_string(), Value::str("`$BOOLEAN`")),
                        ("req".to_string(), Value::Bool(true)),
                        ("short".to_string(), Value::str("Has read permission")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("send")),
                        ("title".to_string(), Value::str("Send")),
                        ("type".to_string(), Value::str("`$BOOLEAN`")),
                        ("req".to_string(), Value::Bool(true)),
                        ("short".to_string(), Value::str("Has send permission")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("username")),
                        ("title".to_string(), Value::str("Username")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("req".to_string(), Value::Bool(true)),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("write")),
                        ("title".to_string(), Value::str("Write")),
                        ("type".to_string(), Value::str("`$BOOLEAN`")),
                        ("req".to_string(), Value::Bool(true)),
                        ("short".to_string(), Value::str("Has write permission")),
                    ]),
                ])),
                ("id".to_string(), Value::map_of([
                    ("field".to_string(), Value::str("id")),
                    ("name".to_string(), Value::str("id")),
                ])),
                ("name".to_string(), Value::str("permission")),
                ("op".to_string(), Value::map_of([
                    ("create".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("create")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("POST")),
                                ("orig".to_string(), Value::str("/contacts/groups/{groupId}/permissions")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("contacts")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("groups")),
                                    ]),
                                    Value::map_of([
                                        ("var".to_string(), Value::str("group_id")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("permissions")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("contacts"),
                                    Value::str("groups"),
                                    Value::str("{group_id}"),
                                    Value::str("permissions"),
                                ])),
                                ("rename".to_string(), Value::map_of([
                                    ("param".to_string(), Value::map_of([
                                        ("groupId".to_string(), Value::str("group_id")),
                                    ])),
                                ])),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("args".to_string(), Value::map_of([
                                    ("params".to_string(), Value::list(vec![
                                        Value::map_of([
                                            ("name".to_string(), Value::str("group_id")),
                                            ("orig".to_string(), Value::str("groupId")),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                            ("kind".to_string(), Value::str("param")),
                                            ("reqd".to_string(), Value::Bool(true)),
                                            ("example".to_string(), Value::str("0f0f0f0f0f0f0f0f0f0f0f0f")),
                                        ]),
                                    ])),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("exist".to_string(), Value::list(vec![
                                        Value::str("group_id"),
                                    ])),
                                ])),
                            ]),
                        ])),
                    ])),
                    ("load".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("load")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("GET")),
                                ("orig".to_string(), Value::str("/contacts/groups/{groupId}/permissions/{username}")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("contacts")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("groups")),
                                    ]),
                                    Value::map_of([
                                        ("var".to_string(), Value::str("group_id")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("permissions")),
                                    ]),
                                    Value::map_of([
                                        ("var".to_string(), Value::str("id")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("contacts"),
                                    Value::str("groups"),
                                    Value::str("{group_id}"),
                                    Value::str("permissions"),
                                    Value::str("{id}"),
                                ])),
                                ("rename".to_string(), Value::map_of([
                                    ("param".to_string(), Value::map_of([
                                        ("groupId".to_string(), Value::str("group_id")),
                                        ("username".to_string(), Value::str("id")),
                                    ])),
                                ])),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("args".to_string(), Value::map_of([
                                    ("params".to_string(), Value::list(vec![
                                        Value::map_of([
                                            ("name".to_string(), Value::str("group_id")),
                                            ("orig".to_string(), Value::str("groupId")),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                            ("kind".to_string(), Value::str("param")),
                                            ("reqd".to_string(), Value::Bool(true)),
                                            ("example".to_string(), Value::str("0f0f0f0f0f0f0f0f0f0f0f0f")),
                                        ]),
                                        Value::map_of([
                                            ("name".to_string(), Value::str("id")),
                                            ("orig".to_string(), Value::str("username")),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                            ("kind".to_string(), Value::str("param")),
                                            ("reqd".to_string(), Value::Bool(true)),
                                        ]),
                                    ])),
                                    ("query".to_string(), Value::list(vec![
                                        Value::map_of([
                                            ("name".to_string(), Value::str("username")),
                                            ("orig".to_string(), Value::str("username")),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                            ("kind".to_string(), Value::str("query")),
                                            ("reqd".to_string(), Value::Bool(true)),
                                            ("example".to_string(), Value::str("example_username")),
                                        ]),
                                    ])),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("exist".to_string(), Value::list(vec![
                                        Value::str("group_id"),
                                        Value::str("id"),
                                        Value::str("username"),
                                    ])),
                                ])),
                            ]),
                        ])),
                    ])),
                ])),
                ("relations".to_string(), Value::map_of([
                    ("ancestors".to_string(), Value::list(vec![
                        Value::list(vec![
                            Value::str("$.main.kit.entity.group"),
                        ]),
                    ])),
                ])),
            ])),
            ("ping".to_string(), Value::map_of([
                ("fields".to_string(), Value::list(vec![
                    Value::map_of([
                        ("name".to_string(), Value::str("authorized")),
                        ("title".to_string(), Value::str("Authorized")),
                        ("type".to_string(), Value::str("`$BOOLEAN`")),
                        ("req".to_string(), Value::Bool(true)),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("unavailable")),
                        ("title".to_string(), Value::str("Unavailable")),
                        ("type".to_string(), Value::str("`$ARRAY`")),
                        ("req".to_string(), Value::Bool(true)),
                    ]),
                ])),
                ("name".to_string(), Value::str("ping")),
                ("op".to_string(), Value::map_of([
                    ("list".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("list")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("GET")),
                                ("orig".to_string(), Value::str("/ping")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("ping")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("ping"),
                                ])),
                                ("rename".to_string(), Value::empty_map()),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body.unavailable`")),
                                ])),
                                ("args".to_string(), Value::empty_map()),
                                ("select".to_string(), Value::empty_map()),
                            ]),
                        ])),
                    ])),
                ])),
                ("relations".to_string(), Value::map_of([
                    ("ancestors".to_string(), Value::empty_list()),
                ])),
            ])),
            ("profile".to_string(), Value::map_of([
                ("fields".to_string(), Value::list(vec![
                    Value::map_of([
                        ("name".to_string(), Value::str("email")),
                        ("title".to_string(), Value::str("Email")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("req".to_string(), Value::Bool(true)),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("name")),
                        ("title".to_string(), Value::str("Name")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("req".to_string(), Value::Bool(true)),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("payment_type")),
                        ("title".to_string(), Value::str("Payment Type")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("req".to_string(), Value::Bool(true)),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("phone_number")),
                        ("title".to_string(), Value::str("Phone Number")),
                        ("type".to_string(), Value::str("`$INTEGER`")),
                        ("req".to_string(), Value::Bool(true)),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("points")),
                        ("title".to_string(), Value::str("Points")),
                        ("type".to_string(), Value::str("`$NUMBER`")),
                        ("format".to_string(), Value::str("float")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("user_type")),
                        ("title".to_string(), Value::str("User Type")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("req".to_string(), Value::Bool(true)),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("username")),
                        ("title".to_string(), Value::str("Username")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("req".to_string(), Value::Bool(true)),
                    ]),
                ])),
                ("name".to_string(), Value::str("profile")),
                ("op".to_string(), Value::map_of([
                    ("list".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("list")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("GET")),
                                ("orig".to_string(), Value::str("/profile/prices")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("profile")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("prices")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("profile"),
                                    Value::str("prices"),
                                ])),
                                ("rename".to_string(), Value::empty_map()),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body.collection`")),
                                ])),
                                ("args".to_string(), Value::map_of([
                                    ("query".to_string(), Value::list(vec![
                                        Value::map_of([
                                            ("name".to_string(), Value::str("type")),
                                            ("orig".to_string(), Value::str("type")),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                            ("kind".to_string(), Value::str("query")),
                                            ("example".to_string(), Value::str("eco")),
                                        ]),
                                    ])),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("$action".to_string(), Value::str("price")),
                                    ("exist".to_string(), Value::list(vec![
                                        Value::str("type"),
                                    ])),
                                ])),
                            ]),
                        ])),
                    ])),
                    ("load".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("load")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("GET")),
                                ("orig".to_string(), Value::str("/profile")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("profile")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("profile"),
                                ])),
                                ("rename".to_string(), Value::empty_map()),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("args".to_string(), Value::empty_map()),
                                ("select".to_string(), Value::empty_map()),
                            ]),
                        ])),
                    ])),
                ])),
                ("relations".to_string(), Value::map_of([
                    ("ancestors".to_string(), Value::empty_list()),
                ])),
            ])),
            ("rcs".to_string(), Value::map_of([
                ("fields".to_string(), Value::empty_list()),
                ("name".to_string(), Value::str("rcs")),
                ("op".to_string(), Value::map_of([
                    ("list".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("list")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("GET")),
                                ("orig".to_string(), Value::str("/rcs/messages")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("rcs")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("messages")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("rcs"),
                                    Value::str("messages"),
                                ])),
                                ("rename".to_string(), Value::empty_map()),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body.collection`")),
                                ])),
                                ("args".to_string(), Value::empty_map()),
                                ("select".to_string(), Value::map_of([
                                    ("$action".to_string(), Value::str("message")),
                                ])),
                            ]),
                        ])),
                    ])),
                ])),
                ("relations".to_string(), Value::map_of([
                    ("ancestors".to_string(), Value::empty_list()),
                ])),
            ])),
            ("sendername".to_string(), Value::map_of([
                ("fields".to_string(), Value::list(vec![
                    Value::map_of([
                        ("name".to_string(), Value::str("created_at")),
                        ("title".to_string(), Value::str("Created At")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("format".to_string(), Value::str("date-time")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("id")),
                        ("title".to_string(), Value::str("Id")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("is_default")),
                        ("title".to_string(), Value::str("Is Default")),
                        ("type".to_string(), Value::str("`$BOOLEAN`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("sender")),
                        ("title".to_string(), Value::str("Sender")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("short".to_string(), Value::str("Sendername")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("status")),
                        ("title".to_string(), Value::str("Status")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                ])),
                ("id".to_string(), Value::map_of([
                    ("field".to_string(), Value::str("id")),
                    ("name".to_string(), Value::str("id")),
                ])),
                ("name".to_string(), Value::str("sendername")),
                ("op".to_string(), Value::map_of([
                    ("create".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("create")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("POST")),
                                ("orig".to_string(), Value::str("/sms/sendernames")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("sms")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("sendernames")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("sms"),
                                    Value::str("sendernames"),
                                ])),
                                ("rename".to_string(), Value::empty_map()),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("args".to_string(), Value::empty_map()),
                                ("select".to_string(), Value::empty_map()),
                            ]),
                        ])),
                    ])),
                    ("list".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("list")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("GET")),
                                ("orig".to_string(), Value::str("/sms/sendernames")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("sms")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("sendernames")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("sms"),
                                    Value::str("sendernames"),
                                ])),
                                ("rename".to_string(), Value::empty_map()),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body.collection`")),
                                ])),
                                ("args".to_string(), Value::empty_map()),
                                ("select".to_string(), Value::empty_map()),
                            ]),
                        ])),
                    ])),
                    ("load".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("load")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("GET")),
                                ("orig".to_string(), Value::str("/sms/sendernames/{sender}")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("sms")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("sendernames")),
                                    ]),
                                    Value::map_of([
                                        ("var".to_string(), Value::str("id")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("sms"),
                                    Value::str("sendernames"),
                                    Value::str("{id}"),
                                ])),
                                ("rename".to_string(), Value::map_of([
                                    ("param".to_string(), Value::map_of([
                                        ("sender".to_string(), Value::str("id")),
                                    ])),
                                ])),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("args".to_string(), Value::map_of([
                                    ("params".to_string(), Value::list(vec![
                                        Value::map_of([
                                            ("name".to_string(), Value::str("id")),
                                            ("orig".to_string(), Value::str("sender")),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                            ("kind".to_string(), Value::str("param")),
                                            ("reqd".to_string(), Value::Bool(true)),
                                        ]),
                                    ])),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("exist".to_string(), Value::list(vec![
                                        Value::str("id"),
                                    ])),
                                ])),
                            ]),
                        ])),
                    ])),
                ])),
                ("relations".to_string(), Value::map_of([
                    ("ancestors".to_string(), Value::empty_list()),
                ])),
            ])),
            ("sendername_statement".to_string(), Value::map_of([
                ("fields".to_string(), Value::list(vec![
                    Value::map_of([
                        ("name".to_string(), Value::str("content")),
                        ("title".to_string(), Value::str("Content")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("statements")),
                        ("title".to_string(), Value::str("Statements")),
                        ("type".to_string(), Value::str("`$ARRAY`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("title")),
                        ("title".to_string(), Value::str("Title")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                ])),
                ("name".to_string(), Value::str("sendername_statement")),
                ("op".to_string(), Value::map_of([
                    ("list".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("list")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("GET")),
                                ("orig".to_string(), Value::str("/sms/sendernames/statement")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("sms")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("sendernames")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("statement")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("sms"),
                                    Value::str("sendernames"),
                                    Value::str("statement"),
                                ])),
                                ("rename".to_string(), Value::empty_map()),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body.sections`")),
                                ])),
                                ("args".to_string(), Value::empty_map()),
                                ("select".to_string(), Value::empty_map()),
                            ]),
                        ])),
                    ])),
                ])),
                ("relations".to_string(), Value::map_of([
                    ("ancestors".to_string(), Value::empty_list()),
                ])),
            ])),
            ("sent_rcs_message".to_string(), Value::map_of([
                ("fields".to_string(), Value::list(vec![
                    Value::map_of([
                        ("name".to_string(), Value::str("content")),
                        ("title".to_string(), Value::str("Content")),
                        ("type".to_string(), Value::str("`$OBJECT`")),
                        ("short".to_string(), Value::str("RCS message content in RCS JSON format.")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("phone_number")),
                        ("title".to_string(), Value::str("Phone Number")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("req".to_string(), Value::Bool(true)),
                        ("short".to_string(), Value::str("Recipient phone number (e.g.")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("sender")),
                        ("title".to_string(), Value::str("Sender")),
                        ("type".to_string(), Value::str("`$ANY`")),
                        ("req".to_string(), Value::Bool(true)),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("text")),
                        ("title".to_string(), Value::str("Text")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("short".to_string(), Value::str("Plain text message content.")),
                    ]),
                ])),
                ("name".to_string(), Value::str("sent_rcs_message")),
                ("op".to_string(), Value::map_of([
                    ("create".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("create")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("POST")),
                                ("orig".to_string(), Value::str("/rcs/messages")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("rcs")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("messages")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("rcs"),
                                    Value::str("messages"),
                                ])),
                                ("rename".to_string(), Value::empty_map()),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("args".to_string(), Value::empty_map()),
                                ("select".to_string(), Value::empty_map()),
                            ]),
                        ])),
                    ])),
                ])),
                ("relations".to_string(), Value::map_of([
                    ("ancestors".to_string(), Value::empty_list()),
                ])),
            ])),
            ("shipment_country_volume".to_string(), Value::map_of([
                ("fields".to_string(), Value::list(vec![
                    Value::map_of([
                        ("name".to_string(), Value::str("country_code")),
                        ("title".to_string(), Value::str("Country Code")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("country_limit")),
                        ("title".to_string(), Value::str("Country Limit")),
                        ("type".to_string(), Value::str("`$INTEGER`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("country_name")),
                        ("title".to_string(), Value::str("Country Name")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("usage")),
                        ("title".to_string(), Value::str("Usage")),
                        ("type".to_string(), Value::str("`$INTEGER`")),
                    ]),
                ])),
                ("name".to_string(), Value::str("shipment_country_volume")),
                ("op".to_string(), Value::map_of([
                    ("list".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("list")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("GET")),
                                ("orig".to_string(), Value::str("/shipment/country_volumes")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("shipment")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("country_volumes")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("shipment"),
                                    Value::str("country_volumes"),
                                ])),
                                ("rename".to_string(), Value::empty_map()),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body.collection`")),
                                ])),
                                ("args".to_string(), Value::map_of([
                                    ("header".to_string(), Value::list(vec![
                                        Value::map_of([
                                            ("name".to_string(), Value::str("accept")),
                                            ("orig".to_string(), Value::str("Accept")),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                            ("kind".to_string(), Value::str("header")),
                                            ("example".to_string(), Value::str("application/json")),
                                        ]),
                                    ])),
                                    ("query".to_string(), Value::list(vec![
                                        Value::map_of([
                                            ("name".to_string(), Value::str("month")),
                                            ("orig".to_string(), Value::str("month")),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                            ("kind".to_string(), Value::str("query")),
                                        ]),
                                        Value::map_of([
                                            ("name".to_string(), Value::str("year")),
                                            ("orig".to_string(), Value::str("year")),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                            ("kind".to_string(), Value::str("query")),
                                        ]),
                                    ])),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("exist".to_string(), Value::list(vec![
                                        Value::str("accept"),
                                        Value::str("month"),
                                        Value::str("year"),
                                    ])),
                                ])),
                            ]),
                        ])),
                    ])),
                ])),
                ("relations".to_string(), Value::map_of([
                    ("ancestors".to_string(), Value::empty_list()),
                ])),
            ])),
            ("short_url".to_string(), Value::map_of([
                ("fields".to_string(), Value::list(vec![
                    Value::map_of([
                        ("name".to_string(), Value::str("description")),
                        ("title".to_string(), Value::str("Description")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("expire")),
                        ("title".to_string(), Value::str("Expire")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("format".to_string(), Value::str("date-time")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("filename")),
                        ("title".to_string(), Value::str("Filename")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("hits")),
                        ("title".to_string(), Value::str("Hits")),
                        ("type".to_string(), Value::str("`$INTEGER`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("hits_unique")),
                        ("title".to_string(), Value::str("Hits Unique")),
                        ("type".to_string(), Value::str("`$INTEGER`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("id")),
                        ("title".to_string(), Value::str("Id")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("name")),
                        ("title".to_string(), Value::str("Name")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("short_url")),
                        ("title".to_string(), Value::str("Short Url")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("short".to_string(), Value::str("WHATWG URL compliant")),
                        ("format".to_string(), Value::str("url")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("type")),
                        ("title".to_string(), Value::str("Type")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("url")),
                        ("title".to_string(), Value::str("Url")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("short".to_string(), Value::str("WHATWG URL compliant")),
                        ("format".to_string(), Value::str("url")),
                    ]),
                ])),
                ("id".to_string(), Value::map_of([
                    ("field".to_string(), Value::str("id")),
                    ("name".to_string(), Value::str("id")),
                ])),
                ("name".to_string(), Value::str("short_url")),
                ("op".to_string(), Value::map_of([
                    ("create".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("create")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("POST")),
                                ("orig".to_string(), Value::str("/short_url/links")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("short_url")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("links")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("short_url"),
                                    Value::str("links"),
                                ])),
                                ("rename".to_string(), Value::empty_map()),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("args".to_string(), Value::empty_map()),
                                ("select".to_string(), Value::map_of([
                                    ("$action".to_string(), Value::str("link")),
                                ])),
                            ]),
                        ])),
                    ])),
                    ("list".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("list")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("GET")),
                                ("orig".to_string(), Value::str("/short_url/links")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("short_url")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("links")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("short_url"),
                                    Value::str("links"),
                                ])),
                                ("rename".to_string(), Value::empty_map()),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body.collection`")),
                                ])),
                                ("args".to_string(), Value::empty_map()),
                                ("select".to_string(), Value::map_of([
                                    ("$action".to_string(), Value::str("link")),
                                ])),
                            ]),
                        ])),
                    ])),
                    ("load".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("load")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("GET")),
                                ("orig".to_string(), Value::str("/short_url/links/{id}")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("short_url")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("links")),
                                    ]),
                                    Value::map_of([
                                        ("var".to_string(), Value::str("id")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("short_url"),
                                    Value::str("links"),
                                    Value::str("{id}"),
                                ])),
                                ("rename".to_string(), Value::empty_map()),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("args".to_string(), Value::map_of([
                                    ("params".to_string(), Value::list(vec![
                                        Value::map_of([
                                            ("name".to_string(), Value::str("id")),
                                            ("orig".to_string(), Value::str("id")),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                            ("kind".to_string(), Value::str("param")),
                                            ("reqd".to_string(), Value::Bool(true)),
                                            ("example".to_string(), Value::str("123")),
                                        ]),
                                    ])),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("exist".to_string(), Value::list(vec![
                                        Value::str("id"),
                                    ])),
                                ])),
                            ]),
                        ])),
                    ])),
                    ("remove".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("remove")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("DELETE")),
                                ("orig".to_string(), Value::str("/short_url/links/{id}")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("short_url")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("links")),
                                    ]),
                                    Value::map_of([
                                        ("var".to_string(), Value::str("id")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("short_url"),
                                    Value::str("links"),
                                    Value::str("{id}"),
                                ])),
                                ("rename".to_string(), Value::empty_map()),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("args".to_string(), Value::map_of([
                                    ("params".to_string(), Value::list(vec![
                                        Value::map_of([
                                            ("name".to_string(), Value::str("id")),
                                            ("orig".to_string(), Value::str("id")),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                            ("kind".to_string(), Value::str("param")),
                                            ("reqd".to_string(), Value::Bool(true)),
                                            ("example".to_string(), Value::str("123")),
                                        ]),
                                    ])),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("exist".to_string(), Value::list(vec![
                                        Value::str("id"),
                                    ])),
                                ])),
                            ]),
                        ])),
                    ])),
                    ("update".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("update")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("PUT")),
                                ("orig".to_string(), Value::str("/short_url/links/{id}")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("short_url")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("links")),
                                    ]),
                                    Value::map_of([
                                        ("var".to_string(), Value::str("id")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("short_url"),
                                    Value::str("links"),
                                    Value::str("{id}"),
                                ])),
                                ("rename".to_string(), Value::empty_map()),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("args".to_string(), Value::map_of([
                                    ("params".to_string(), Value::list(vec![
                                        Value::map_of([
                                            ("name".to_string(), Value::str("id")),
                                            ("orig".to_string(), Value::str("id")),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                            ("kind".to_string(), Value::str("param")),
                                            ("reqd".to_string(), Value::Bool(true)),
                                            ("example".to_string(), Value::str("123")),
                                        ]),
                                    ])),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("exist".to_string(), Value::list(vec![
                                        Value::str("id"),
                                    ])),
                                ])),
                            ]),
                        ])),
                    ])),
                ])),
                ("relations".to_string(), Value::map_of([
                    ("ancestors".to_string(), Value::empty_list()),
                ])),
            ])),
            ("smsdo".to_string(), Value::map_of([
                ("fields".to_string(), Value::list(vec![
                    Value::map_of([
                        ("name".to_string(), Value::str("allow_duplicates")),
                        ("title".to_string(), Value::str("Allow Duplicates")),
                        ("type".to_string(), Value::str("`$INTEGER`")),
                        ("short".to_string(), Value::str("When parameter allow_duplicates is set to \"1\" allows to send message to duplicated numbers in one request (useful i.e.")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("check_idx")),
                        ("title".to_string(), Value::str("Check Idx")),
                        ("type".to_string(), Value::str("`$ANY`")),
                        ("short".to_string(), Value::str("When parameter check_idx is set to „1” prevents from sending more than one message with the same idx in last 24h.")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("date")),
                        ("title".to_string(), Value::str("Date")),
                        ("type".to_string(), Value::str("`$ANY`")),
                        ("short".to_string(), Value::str("Date in UNIX timestamp (&date=1287734110) or in ISO 8601 (&date=2012-05-10T08:40:27+00:00) when message will be sent (&date=1287734110).")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("date_validate")),
                        ("title".to_string(), Value::str("Date Validate")),
                        ("type".to_string(), Value::str("`$INTEGER`")),
                        ("short".to_string(), Value::str("When parameter date_validate is set to \"1\" checks if date if given in proper format.")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("details")),
                        ("title".to_string(), Value::str("Details")),
                        ("type".to_string(), Value::str("`$ANY`")),
                        ("short".to_string(), Value::str("When details parameter is set to \"1\" more details in response will be displayed (message length and sms count).")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("encoding")),
                        ("title".to_string(), Value::str("Encoding")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("short".to_string(), Value::str("This parameter describes the encoding of the message text.")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("expiration_date")),
                        ("title".to_string(), Value::str("Expiration Date")),
                        ("type".to_string(), Value::str("`$ANY`")),
                        ("short".to_string(), Value::str("Message expiration date (in UNIX timestamp or in ISO 8601) is a date after which message won't be delivered if it wasn't delivered yet.")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("fallback")),
                        ("title".to_string(), Value::str("Fallback")),
                        ("type".to_string(), Value::str("`$ARRAY`")),
                        ("short".to_string(), Value::str("Enable fallback in case sms sending fails")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("fast")),
                        ("title".to_string(), Value::str("Fast")),
                        ("type".to_string(), Value::str("`$INTEGER`")),
                        ("short".to_string(), Value::str("Setting this parameter to „1” will result in sending message with the highest priority which ensures the quickest possible time of delivery.")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("flash")),
                        ("title".to_string(), Value::str("Flash")),
                        ("type".to_string(), Value::str("`$INTEGER`")),
                        ("short".to_string(), Value::str("Sending a message in flash mode can be activated by setting this parameter to \"1\".")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("format")),
                        ("title".to_string(), Value::str("Format")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("short".to_string(), Value::str("Parameter &format=json causes, that response is sending in JSON format.")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("from")),
                        ("title".to_string(), Value::str("From")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("short".to_string(), Value::str("Name of the sender.")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("group")),
                        ("title".to_string(), Value::str("Group")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("short".to_string(), Value::str("Name of the group from the contacts database to which message should be sent to.")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("idx")),
                        ("title".to_string(), Value::str("Idx")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("short".to_string(), Value::str("Optional custom value sent with SMS and sent back in CALLBACK.")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("max_parts")),
                        ("title".to_string(), Value::str("Max Parts")),
                        ("type".to_string(), Value::str("`$INTEGER`")),
                        ("short".to_string(), Value::str("Defines maximum message parts allowed, maximum value allowed is 6.")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("message")),
                        ("title".to_string(), Value::str("Message")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("short".to_string(), Value::str("The message text.")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("normalize")),
                        ("title".to_string(), Value::str("Normalize")),
                        ("type".to_string(), Value::str("`$INTEGER`")),
                        ("short".to_string(), Value::str("When parameter normalize is set to „1” special chars in message will be replaced with their equivalents (ê-e, ñ-n, ý-y ...).")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("notify_url")),
                        ("title".to_string(), Value::str("Notify Url")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("short".to_string(), Value::str("Parameter allows to set CALLBACK URL for message from request.")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("test")),
                        ("title".to_string(), Value::str("Test")),
                        ("type".to_string(), Value::str("`$ANY`")),
                        ("short".to_string(), Value::str("When parameter test is set to \"1\" message won't be sent but response will be displayed, there is no charge for such test messages.")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("time_restriction")),
                        ("title".to_string(), Value::str("Time Restriction")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("short".to_string(), Value::str("Sets the behavior when you try to ship in hours / dates that do not match the settings in your account.")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("to")),
                        ("title".to_string(), Value::str("To")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("short".to_string(), Value::str("Recipients' mobile phone numbers (i.e.")),
                    ]),
                ])),
                ("name".to_string(), Value::str("smsdo")),
                ("op".to_string(), Value::map_of([
                    ("create".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("create")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("POST")),
                                ("orig".to_string(), Value::str("/sms.do")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("sms.do")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("sms.do"),
                                ])),
                                ("rename".to_string(), Value::empty_map()),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("args".to_string(), Value::empty_map()),
                                ("select".to_string(), Value::empty_map()),
                            ]),
                        ])),
                    ])),
                ])),
                ("relations".to_string(), Value::map_of([
                    ("ancestors".to_string(), Value::empty_list()),
                ])),
            ])),
            ("smssendername".to_string(), Value::map_of([
                ("fields".to_string(), Value::empty_list()),
                ("name".to_string(), Value::str("smssendername")),
                ("op".to_string(), Value::map_of([
                    ("create".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("create")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("POST")),
                                ("orig".to_string(), Value::str("/sms/sendernames/{sender}/commands/make_default")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("sms")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("sendernames")),
                                    ]),
                                    Value::map_of([
                                        ("var".to_string(), Value::str("sendername_id")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("commands")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("make_default")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("sms"),
                                    Value::str("sendernames"),
                                    Value::str("{sendername_id}"),
                                    Value::str("commands"),
                                    Value::str("make_default"),
                                ])),
                                ("rename".to_string(), Value::map_of([
                                    ("param".to_string(), Value::map_of([
                                        ("sender".to_string(), Value::str("sendername_id")),
                                    ])),
                                ])),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("args".to_string(), Value::map_of([
                                    ("params".to_string(), Value::list(vec![
                                        Value::map_of([
                                            ("name".to_string(), Value::str("sendername_id")),
                                            ("orig".to_string(), Value::str("sender")),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                            ("kind".to_string(), Value::str("param")),
                                            ("reqd".to_string(), Value::Bool(true)),
                                        ]),
                                    ])),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("exist".to_string(), Value::list(vec![
                                        Value::str("sendername_id"),
                                    ])),
                                ])),
                            ]),
                        ])),
                    ])),
                    ("remove".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("remove")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("DELETE")),
                                ("orig".to_string(), Value::str("/sms/sendernames/{sender}")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("sms")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("sendernames")),
                                    ]),
                                    Value::map_of([
                                        ("var".to_string(), Value::str("sender")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("sms"),
                                    Value::str("sendernames"),
                                    Value::str("{sender}"),
                                ])),
                                ("rename".to_string(), Value::empty_map()),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("args".to_string(), Value::map_of([
                                    ("params".to_string(), Value::list(vec![
                                        Value::map_of([
                                            ("name".to_string(), Value::str("sender")),
                                            ("orig".to_string(), Value::str("sender")),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                            ("kind".to_string(), Value::str("param")),
                                            ("reqd".to_string(), Value::Bool(true)),
                                        ]),
                                    ])),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("exist".to_string(), Value::list(vec![
                                        Value::str("sender"),
                                    ])),
                                ])),
                            ]),
                        ])),
                    ])),
                ])),
                ("relations".to_string(), Value::map_of([
                    ("ancestors".to_string(), Value::list(vec![
                        Value::list(vec![
                            Value::str("$.main.kit.entity.sendername"),
                        ]),
                    ])),
                ])),
            ])),
            ("smstemplate".to_string(), Value::map_of([
                ("fields".to_string(), Value::list(vec![
                    Value::map_of([
                        ("name".to_string(), Value::str("id")),
                        ("title".to_string(), Value::str("Id")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                ])),
                ("id".to_string(), Value::map_of([
                    ("field".to_string(), Value::str("id")),
                    ("name".to_string(), Value::str("id")),
                ])),
                ("name".to_string(), Value::str("smstemplate")),
                ("op".to_string(), Value::map_of([
                    ("remove".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("remove")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("DELETE")),
                                ("orig".to_string(), Value::str("/sms/templates/{id}")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("sms")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("templates")),
                                    ]),
                                    Value::map_of([
                                        ("var".to_string(), Value::str("id")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("sms"),
                                    Value::str("templates"),
                                    Value::str("{id}"),
                                ])),
                                ("rename".to_string(), Value::empty_map()),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("args".to_string(), Value::map_of([
                                    ("params".to_string(), Value::list(vec![
                                        Value::map_of([
                                            ("name".to_string(), Value::str("id")),
                                            ("orig".to_string(), Value::str("id")),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                            ("kind".to_string(), Value::str("param")),
                                            ("reqd".to_string(), Value::Bool(true)),
                                        ]),
                                    ])),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("exist".to_string(), Value::list(vec![
                                        Value::str("id"),
                                    ])),
                                ])),
                            ]),
                        ])),
                    ])),
                ])),
                ("relations".to_string(), Value::map_of([
                    ("ancestors".to_string(), Value::empty_list()),
                ])),
            ])),
            ("subuser".to_string(), Value::map_of([
                ("fields".to_string(), Value::list(vec![
                    Value::map_of([
                        ("name".to_string(), Value::str("active")),
                        ("title".to_string(), Value::str("Active")),
                        ("type".to_string(), Value::str("`$BOOLEAN`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("credentials")),
                        ("title".to_string(), Value::str("Credentials")),
                        ("type".to_string(), Value::str("`$OBJECT`")),
                        ("req".to_string(), Value::Bool(true)),
                        ("op".to_string(), Value::map_of([
                            ("update".to_string(), Value::map_of([
                                ("type".to_string(), Value::str("`$OBJECT`")),
                            ])),
                        ])),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("description")),
                        ("title".to_string(), Value::str("Description")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("id")),
                        ("title".to_string(), Value::str("Id")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("short".to_string(), Value::str("Object ID")),
                        ("format".to_string(), Value::str("oid")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("points")),
                        ("title".to_string(), Value::str("Points")),
                        ("type".to_string(), Value::str("`$OBJECT`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("username")),
                        ("title".to_string(), Value::str("Username")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                ])),
                ("id".to_string(), Value::map_of([
                    ("field".to_string(), Value::str("id")),
                    ("name".to_string(), Value::str("id")),
                ])),
                ("name".to_string(), Value::str("subuser")),
                ("op".to_string(), Value::map_of([
                    ("create".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("create")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("POST")),
                                ("orig".to_string(), Value::str("/subusers")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("subusers")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("subusers"),
                                ])),
                                ("rename".to_string(), Value::empty_map()),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("args".to_string(), Value::empty_map()),
                                ("select".to_string(), Value::empty_map()),
                            ]),
                        ])),
                    ])),
                    ("list".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("list")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("GET")),
                                ("orig".to_string(), Value::str("/subusers/{id}/shares/sendernames")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("subusers")),
                                    ]),
                                    Value::map_of([
                                        ("var".to_string(), Value::str("id")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("shares")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("sendernames")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("subusers"),
                                    Value::str("{id}"),
                                    Value::str("shares"),
                                    Value::str("sendernames"),
                                ])),
                                ("rename".to_string(), Value::empty_map()),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body.senders`")),
                                ])),
                                ("args".to_string(), Value::map_of([
                                    ("params".to_string(), Value::list(vec![
                                        Value::map_of([
                                            ("name".to_string(), Value::str("id")),
                                            ("orig".to_string(), Value::str("id")),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                            ("kind".to_string(), Value::str("param")),
                                            ("reqd".to_string(), Value::Bool(true)),
                                            ("example".to_string(), Value::str("0f0f0f0f0f0f0f0f0f0f0f0f")),
                                        ]),
                                    ])),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("$action".to_string(), Value::str("share_sendername")),
                                    ("exist".to_string(), Value::list(vec![
                                        Value::str("id"),
                                    ])),
                                ])),
                            ]),
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("GET")),
                                ("orig".to_string(), Value::str("/subusers/{id}/shares/templates")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("subusers")),
                                    ]),
                                    Value::map_of([
                                        ("var".to_string(), Value::str("id")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("shares")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("templates")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("subusers"),
                                    Value::str("{id}"),
                                    Value::str("shares"),
                                    Value::str("templates"),
                                ])),
                                ("rename".to_string(), Value::empty_map()),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body.templates`")),
                                ])),
                                ("args".to_string(), Value::map_of([
                                    ("params".to_string(), Value::list(vec![
                                        Value::map_of([
                                            ("name".to_string(), Value::str("id")),
                                            ("orig".to_string(), Value::str("id")),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                            ("kind".to_string(), Value::str("param")),
                                            ("reqd".to_string(), Value::Bool(true)),
                                            ("example".to_string(), Value::str("0f0f0f0f0f0f0f0f0f0f0f0f")),
                                        ]),
                                    ])),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("$action".to_string(), Value::str("share_template")),
                                    ("exist".to_string(), Value::list(vec![
                                        Value::str("id"),
                                    ])),
                                ])),
                            ]),
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("GET")),
                                ("orig".to_string(), Value::str("/subusers")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("subusers")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("subusers"),
                                ])),
                                ("rename".to_string(), Value::empty_map()),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body.collection`")),
                                ])),
                                ("args".to_string(), Value::map_of([
                                    ("query".to_string(), Value::list(vec![
                                        Value::map_of([
                                            ("name".to_string(), Value::str("q")),
                                            ("orig".to_string(), Value::str("q")),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                            ("kind".to_string(), Value::str("query")),
                                        ]),
                                    ])),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("exist".to_string(), Value::list(vec![
                                        Value::str("q"),
                                    ])),
                                ])),
                            ]),
                        ])),
                    ])),
                    ("load".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("load")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("GET")),
                                ("orig".to_string(), Value::str("/subusers/{id}")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("subusers")),
                                    ]),
                                    Value::map_of([
                                        ("var".to_string(), Value::str("id")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("subusers"),
                                    Value::str("{id}"),
                                ])),
                                ("rename".to_string(), Value::empty_map()),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("args".to_string(), Value::map_of([
                                    ("params".to_string(), Value::list(vec![
                                        Value::map_of([
                                            ("name".to_string(), Value::str("id")),
                                            ("orig".to_string(), Value::str("id")),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                            ("kind".to_string(), Value::str("param")),
                                            ("reqd".to_string(), Value::Bool(true)),
                                            ("example".to_string(), Value::str("0f0f0f0f0f0f0f0f0f0f0f0f")),
                                        ]),
                                    ])),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("exist".to_string(), Value::list(vec![
                                        Value::str("id"),
                                    ])),
                                ])),
                            ]),
                        ])),
                    ])),
                    ("remove".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("remove")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("DELETE")),
                                ("orig".to_string(), Value::str("/subusers/{id}")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("subusers")),
                                    ]),
                                    Value::map_of([
                                        ("var".to_string(), Value::str("id")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("subusers"),
                                    Value::str("{id}"),
                                ])),
                                ("rename".to_string(), Value::empty_map()),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("args".to_string(), Value::map_of([
                                    ("params".to_string(), Value::list(vec![
                                        Value::map_of([
                                            ("name".to_string(), Value::str("id")),
                                            ("orig".to_string(), Value::str("id")),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                            ("kind".to_string(), Value::str("param")),
                                            ("reqd".to_string(), Value::Bool(true)),
                                            ("example".to_string(), Value::str("0f0f0f0f0f0f0f0f0f0f0f0f")),
                                        ]),
                                    ])),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("exist".to_string(), Value::list(vec![
                                        Value::str("id"),
                                    ])),
                                ])),
                            ]),
                        ])),
                    ])),
                    ("update".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("update")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("PUT")),
                                ("orig".to_string(), Value::str("/subusers/{id}")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("subusers")),
                                    ]),
                                    Value::map_of([
                                        ("var".to_string(), Value::str("id")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("subusers"),
                                    Value::str("{id}"),
                                ])),
                                ("rename".to_string(), Value::empty_map()),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("args".to_string(), Value::map_of([
                                    ("params".to_string(), Value::list(vec![
                                        Value::map_of([
                                            ("name".to_string(), Value::str("id")),
                                            ("orig".to_string(), Value::str("id")),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                            ("kind".to_string(), Value::str("param")),
                                            ("reqd".to_string(), Value::Bool(true)),
                                            ("example".to_string(), Value::str("0f0f0f0f0f0f0f0f0f0f0f0f")),
                                        ]),
                                    ])),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("exist".to_string(), Value::list(vec![
                                        Value::str("id"),
                                    ])),
                                ])),
                            ]),
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("PUT")),
                                ("orig".to_string(), Value::str("/subusers/{id}/shares/sendernames")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("subusers")),
                                    ]),
                                    Value::map_of([
                                        ("var".to_string(), Value::str("id")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("shares")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("sendernames")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("subusers"),
                                    Value::str("{id}"),
                                    Value::str("shares"),
                                    Value::str("sendernames"),
                                ])),
                                ("rename".to_string(), Value::empty_map()),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("args".to_string(), Value::map_of([
                                    ("params".to_string(), Value::list(vec![
                                        Value::map_of([
                                            ("name".to_string(), Value::str("id")),
                                            ("orig".to_string(), Value::str("id")),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                            ("kind".to_string(), Value::str("param")),
                                            ("reqd".to_string(), Value::Bool(true)),
                                            ("example".to_string(), Value::str("0f0f0f0f0f0f0f0f0f0f0f0f")),
                                        ]),
                                    ])),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("$action".to_string(), Value::str("share_sendername")),
                                    ("exist".to_string(), Value::list(vec![
                                        Value::str("id"),
                                    ])),
                                ])),
                            ]),
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("PUT")),
                                ("orig".to_string(), Value::str("/subusers/{id}/shares/templates")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("subusers")),
                                    ]),
                                    Value::map_of([
                                        ("var".to_string(), Value::str("id")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("shares")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("templates")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("subusers"),
                                    Value::str("{id}"),
                                    Value::str("shares"),
                                    Value::str("templates"),
                                ])),
                                ("rename".to_string(), Value::empty_map()),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("args".to_string(), Value::map_of([
                                    ("params".to_string(), Value::list(vec![
                                        Value::map_of([
                                            ("name".to_string(), Value::str("id")),
                                            ("orig".to_string(), Value::str("id")),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                            ("kind".to_string(), Value::str("param")),
                                            ("reqd".to_string(), Value::Bool(true)),
                                            ("example".to_string(), Value::str("0f0f0f0f0f0f0f0f0f0f0f0f")),
                                        ]),
                                    ])),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("$action".to_string(), Value::str("share_template")),
                                    ("exist".to_string(), Value::list(vec![
                                        Value::str("id"),
                                    ])),
                                ])),
                            ]),
                        ])),
                    ])),
                ])),
                ("relations".to_string(), Value::map_of([
                    ("ancestors".to_string(), Value::empty_list()),
                ])),
            ])),
            ("template".to_string(), Value::map_of([
                ("fields".to_string(), Value::list(vec![
                    Value::map_of([
                        ("name".to_string(), Value::str("id")),
                        ("title".to_string(), Value::str("Id")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("name")),
                        ("title".to_string(), Value::str("Name")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("normalize")),
                        ("title".to_string(), Value::str("Normalize")),
                        ("type".to_string(), Value::str("`$BOOLEAN`")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("template")),
                        ("title".to_string(), Value::str("Template")),
                        ("type".to_string(), Value::str("`$STRING`")),
                    ]),
                ])),
                ("id".to_string(), Value::map_of([
                    ("field".to_string(), Value::str("id")),
                    ("name".to_string(), Value::str("id")),
                ])),
                ("name".to_string(), Value::str("template")),
                ("op".to_string(), Value::map_of([
                    ("create".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("create")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("POST")),
                                ("orig".to_string(), Value::str("/sms/templates")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("sms")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("templates")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("sms"),
                                    Value::str("templates"),
                                ])),
                                ("rename".to_string(), Value::empty_map()),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("args".to_string(), Value::empty_map()),
                                ("select".to_string(), Value::empty_map()),
                            ]),
                        ])),
                    ])),
                    ("list".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("list")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("GET")),
                                ("orig".to_string(), Value::str("/sms/templates")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("sms")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("templates")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("sms"),
                                    Value::str("templates"),
                                ])),
                                ("rename".to_string(), Value::empty_map()),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body.collection`")),
                                ])),
                                ("args".to_string(), Value::empty_map()),
                                ("select".to_string(), Value::empty_map()),
                            ]),
                        ])),
                    ])),
                    ("load".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("load")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("GET")),
                                ("orig".to_string(), Value::str("/sms/templates/{id}")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("sms")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("templates")),
                                    ]),
                                    Value::map_of([
                                        ("var".to_string(), Value::str("id")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("sms"),
                                    Value::str("templates"),
                                    Value::str("{id}"),
                                ])),
                                ("rename".to_string(), Value::empty_map()),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("args".to_string(), Value::map_of([
                                    ("params".to_string(), Value::list(vec![
                                        Value::map_of([
                                            ("name".to_string(), Value::str("id")),
                                            ("orig".to_string(), Value::str("id")),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                            ("kind".to_string(), Value::str("param")),
                                            ("reqd".to_string(), Value::Bool(true)),
                                        ]),
                                    ])),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("exist".to_string(), Value::list(vec![
                                        Value::str("id"),
                                    ])),
                                ])),
                            ]),
                        ])),
                    ])),
                    ("update".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("update")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("PUT")),
                                ("orig".to_string(), Value::str("/sms/templates/{id}")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("sms")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("templates")),
                                    ]),
                                    Value::map_of([
                                        ("var".to_string(), Value::str("id")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("sms"),
                                    Value::str("templates"),
                                    Value::str("{id}"),
                                ])),
                                ("rename".to_string(), Value::empty_map()),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("args".to_string(), Value::map_of([
                                    ("params".to_string(), Value::list(vec![
                                        Value::map_of([
                                            ("name".to_string(), Value::str("id")),
                                            ("orig".to_string(), Value::str("id")),
                                            ("type".to_string(), Value::str("`$STRING`")),
                                            ("kind".to_string(), Value::str("param")),
                                            ("reqd".to_string(), Value::Bool(true)),
                                        ]),
                                    ])),
                                ])),
                                ("select".to_string(), Value::map_of([
                                    ("exist".to_string(), Value::list(vec![
                                        Value::str("id"),
                                    ])),
                                ])),
                            ]),
                        ])),
                    ])),
                ])),
                ("relations".to_string(), Value::map_of([
                    ("ancestors".to_string(), Value::empty_list()),
                ])),
            ])),
            ("user_rcs_sender_collection".to_string(), Value::map_of([
                ("fields".to_string(), Value::list(vec![
                    Value::map_of([
                        ("name".to_string(), Value::str("deliveredAt")),
                        ("title".to_string(), Value::str("Delivered At")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("format".to_string(), Value::str("date-time")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("expiredAt")),
                        ("title".to_string(), Value::str("Expired At")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("format".to_string(), Value::str("date-time")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("id")),
                        ("title".to_string(), Value::str("Id")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("short".to_string(), Value::str("Object ID")),
                        ("format".to_string(), Value::str("oid")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("interface")),
                        ("title".to_string(), Value::str("Interface")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("short".to_string(), Value::str("Interface through which the message was sent (www, api, ...).")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("messageType")),
                        ("title".to_string(), Value::str("Message Type")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("short".to_string(), Value::str("RCS message type (basic, single, ...).")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("readAt")),
                        ("title".to_string(), Value::str("Read At")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("format".to_string(), Value::str("date-time")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("recipient")),
                        ("title".to_string(), Value::str("Recipient")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("short".to_string(), Value::str("Recipient phone number (without +).")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("sender")),
                        ("title".to_string(), Value::str("Sender")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("short".to_string(), Value::str("Sender name")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("senderId")),
                        ("title".to_string(), Value::str("Sender Id")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("short".to_string(), Value::str("Sender id")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("sentAt")),
                        ("title".to_string(), Value::str("Sent At")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("format".to_string(), Value::str("date-time")),
                    ]),
                ])),
                ("id".to_string(), Value::map_of([
                    ("field".to_string(), Value::str("id")),
                    ("name".to_string(), Value::str("id")),
                ])),
                ("name".to_string(), Value::str("user_rcs_sender_collection")),
                ("op".to_string(), Value::map_of([
                    ("list".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("list")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("GET")),
                                ("orig".to_string(), Value::str("/rcs/senders")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("rcs")),
                                    ]),
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("senders")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("rcs"),
                                    Value::str("senders"),
                                ])),
                                ("rename".to_string(), Value::empty_map()),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body.collection`")),
                                ])),
                                ("args".to_string(), Value::empty_map()),
                                ("select".to_string(), Value::empty_map()),
                            ]),
                        ])),
                    ])),
                ])),
                ("relations".to_string(), Value::map_of([
                    ("ancestors".to_string(), Value::empty_list()),
                ])),
            ])),
        ])),
    ])
}

// SHARED CONFIG (sdkgen rung L2).
//
// The SDK reads the config on every request and never writes to it, so one
// instance is shared by every client rather than rebuilt per client. Above the
// size threshold make_config re-parses the whole embedded JSON, so this is the
// difference between parsing the model once and once per client.
//
// THREAD-LOCAL, not a global: Value is Rc/RefCell-backed and so is neither
// Send nor Sync. One config per thread is the widest scope that is sound here,
// and the clone is an Rc bump, not a deep copy.
thread_local! {
    static SHARED_CONFIG: Value = make_config();
}

/// The per-thread config, built once on first use.
///
/// The returned Value SHARES its nodes: treat it as read-only. Callers that
/// need to mutate should use make_config, which always returns a fresh copy.
pub fn shared_config() -> Value {
    SHARED_CONFIG.with(|c| c.clone())
}

pub fn make_feature(name: &str) -> FeatureRef {
    match name {
        "audit" => Rc::new(RefCell::new(crate::feature::audit::AuditFeature::new())),
        "cache" => Rc::new(RefCell::new(crate::feature::cache::CacheFeature::new())),
        "clienttrack" => Rc::new(RefCell::new(crate::feature::clienttrack::ClienttrackFeature::new())),
        "cost" => Rc::new(RefCell::new(crate::feature::cost::CostFeature::new())),
        "debug" => Rc::new(RefCell::new(crate::feature::debug::DebugFeature::new())),
        "idempotency" => Rc::new(RefCell::new(crate::feature::idempotency::IdempotencyFeature::new())),
        "log" => Rc::new(RefCell::new(crate::feature::log::LogFeature::new())),
        "metrics" => Rc::new(RefCell::new(crate::feature::metrics::MetricsFeature::new())),
        "netsim" => Rc::new(RefCell::new(crate::feature::netsim::NetsimFeature::new())),
        "paging" => Rc::new(RefCell::new(crate::feature::paging::PagingFeature::new())),
        "proxy" => Rc::new(RefCell::new(crate::feature::proxy::ProxyFeature::new())),
        "ratelimit" => Rc::new(RefCell::new(crate::feature::ratelimit::RatelimitFeature::new())),
        "rbac" => Rc::new(RefCell::new(crate::feature::rbac::RbacFeature::new())),
        "retry" => Rc::new(RefCell::new(crate::feature::retry::RetryFeature::new())),
        "secrets" => Rc::new(RefCell::new(crate::feature::secrets::SecretsFeature::new())),
        "streaming" => Rc::new(RefCell::new(crate::feature::streaming::StreamingFeature::new())),
        "telemetry" => Rc::new(RefCell::new(crate::feature::telemetry::TelemetryFeature::new())),
        "test" => Rc::new(RefCell::new(crate::feature::test::TestFeature::new())),
        "timeout" => Rc::new(RefCell::new(crate::feature::timeout::TimeoutFeature::new())),
        "validate" => Rc::new(RefCell::new(crate::feature::validate::ValidateFeature::new())),
        _ => Rc::new(RefCell::new(crate::feature::base::BaseFeature::new())),
    }
}
