// Generated API configuration (mirrors go/rust core/config).

const std = @import("std");
const h = @import("helpers.zig");
const types = @import("types.zig");
const Value = h.Value;
const Feature = types.Feature;

pub fn make_config() Value {
    return h.jo(&.{
        .{ "main", h.jo(&.{
            .{ "name", h.vstr("Smsapi") },
            .{ "slug", h.vstr("smsapi") },
            .{ "version", h.vstr("0.0.1") },
            .{ "target", h.vstr("zig") },
        }) },
        .{ "feature", h.jo(&.{
            .{ "audit", h.jo(&.{
                .{ "options", h.jo(&.{
                    .{ "active", h.vbool(false) },
                    .{ "actor", h.vstr("anonymous") },
                    .{ "max", h.vnum(1000) },
                }) },
                .{ "optspec", h.jo(&.{
                    .{ "now", h.vstr("`$FUNCTION`") },
                    .{ "sink", h.vstr("`$FUNCTION`") },
                }) },
                .{ "strict", h.vbool(false) },
                .{ "transport", h.vstr("none") },
            }) },
            .{ "cache", h.jo(&.{
                .{ "options", h.jo(&.{
                    .{ "active", h.vbool(false) },
                    .{ "max", h.vnum(256) },
                    .{ "methods", h.ja(&.{
                        h.vstr("GET"),
                    }) },
                    .{ "ttl", h.vnum(5000) },
                }) },
                .{ "optspec", h.jo(&.{
                    .{ "now", h.vstr("`$FUNCTION`") },
                }) },
                .{ "strict", h.vbool(false) },
                .{ "transport", h.vstr("wrap") },
            }) },
            .{ "clienttrack", h.jo(&.{
                .{ "options", h.jo(&.{
                    .{ "active", h.vbool(false) },
                    .{ "clientVersion", h.vstr("0.0.1") },
                }) },
                .{ "optspec", h.jo(&.{
                    .{ "clientName", h.vstr("`$STRING`") },
                    .{ "clientVersion", h.vstr("`$STRING`") },
                    .{ "headers", h.vstr("`$MAP`") },
                    .{ "idgen", h.vstr("`$FUNCTION`") },
                    .{ "sessionId", h.vstr("`$STRING`") },
                }) },
                .{ "strict", h.vbool(false) },
                .{ "transport", h.vstr("none") },
            }) },
            .{ "cost", h.jo(&.{
                .{ "options", h.jo(&.{
                    .{ "active", h.vbool(false) },
                    .{ "budget", h.vnum(0) },
                    .{ "currency", h.vstr("USD") },
                    .{ "header", h.vstr("") },
                    .{ "onBudget", h.vstr("warn") },
                    .{ "path", h.vstr("") },
                    .{ "perUnit", h.vnum(0) },
                    .{ "rates", h.omap() },
                    .{ "unit", h.vnum(0) },
                }) },
                .{ "optspec", h.jo(&.{
                    .{ "actor", h.vstr("`$STRING`") },
                    .{ "sink", h.vstr("`$FUNCTION`") },
                }) },
                .{ "strict", h.vbool(false) },
                .{ "transport", h.vstr("wrap") },
            }) },
            .{ "debug", h.jo(&.{
                .{ "options", h.jo(&.{
                    .{ "active", h.vbool(false) },
                    .{ "max", h.vnum(100) },
                    .{ "redact", h.ja(&.{
                        h.vstr("authorization"),
                        h.vstr("cookie"),
                        h.vstr("set-cookie"),
                        h.vstr("api-key"),
                        h.vstr("apikey"),
                        h.vstr("x-api-key"),
                        h.vstr("idempotency-key"),
                    }) },
                }) },
                .{ "optspec", h.jo(&.{
                    .{ "now", h.vstr("`$FUNCTION`") },
                    .{ "onEntry", h.vstr("`$FUNCTION`") },
                }) },
                .{ "strict", h.vbool(false) },
                .{ "transport", h.vstr("none") },
            }) },
            .{ "idempotency", h.jo(&.{
                .{ "options", h.jo(&.{
                    .{ "active", h.vbool(false) },
                    .{ "header", h.vstr("Idempotency-Key") },
                    .{ "methods", h.ja(&.{
                        h.vstr("POST"),
                        h.vstr("PUT"),
                        h.vstr("PATCH"),
                        h.vstr("DELETE"),
                    }) },
                    .{ "ops", h.ja(&.{
                        h.vstr("create"),
                        h.vstr("update"),
                        h.vstr("remove"),
                    }) },
                }) },
                .{ "optspec", h.jo(&.{
                    .{ "keygen", h.vstr("`$FUNCTION`") },
                }) },
                .{ "strict", h.vbool(false) },
                .{ "transport", h.vstr("none") },
            }) },
            .{ "log", h.jo(&.{
                .{ "options", h.jo(&.{
                    .{ "active", h.vbool(true) },
                }) },
                .{ "optspec", h.jo(&.{
                    .{ "level", h.vstr("`$STRING`") },
                    .{ "logger", h.vstr("`$ANY`") },
                }) },
                .{ "strict", h.vbool(false) },
                .{ "transport", h.vstr("none") },
            }) },
            .{ "metrics", h.jo(&.{
                .{ "options", h.jo(&.{
                    .{ "active", h.vbool(false) },
                }) },
                .{ "optspec", h.jo(&.{
                    .{ "now", h.vstr("`$FUNCTION`") },
                }) },
                .{ "strict", h.vbool(false) },
                .{ "transport", h.vstr("none") },
            }) },
            .{ "netsim", h.jo(&.{
                .{ "options", h.jo(&.{
                    .{ "active", h.vbool(false) },
                    .{ "errorTimes", h.vnum(0) },
                    .{ "failEvery", h.vnum(0) },
                    .{ "failRate", h.vnum(0) },
                    .{ "failStatus", h.vnum(503) },
                    .{ "failTimes", h.vnum(0) },
                    .{ "latency", h.vnum(0) },
                    .{ "offline", h.vbool(false) },
                    .{ "rateLimitTimes", h.vnum(0) },
                    .{ "retryAfter", h.vnum(0) },
                    .{ "seed", h.vnum(1) },
                }) },
                .{ "optspec", h.jo(&.{
                    .{ "latency", h.ja(&.{
                        h.vstr("`$ONE`"),
                        h.vstr("`$NUMBER`"),
                        h.vstr("`$MAP`"),
                    }) },
                    .{ "sleep", h.vstr("`$FUNCTION`") },
                }) },
                .{ "strict", h.vbool(false) },
                .{ "transport", h.vstr("wrap") },
            }) },
            .{ "paging", h.jo(&.{
                .{ "options", h.jo(&.{
                    .{ "active", h.vbool(false) },
                    .{ "afterVar", h.vstr("after") },
                    .{ "cursorParam", h.vstr("cursor") },
                    .{ "firstVar", h.vstr("first") },
                    .{ "limitParam", h.vstr("limit") },
                    .{ "pageParam", h.vstr("page") },
                    .{ "startPage", h.vnum(1) },
                }) },
                .{ "optspec", h.jo(&.{
                    .{ "limit", h.vstr("`$NUMBER`") },
                    .{ "ops", h.vstr("`$LIST`") },
                }) },
                .{ "strict", h.vbool(false) },
                .{ "transport", h.vstr("none") },
            }) },
            .{ "proxy", h.jo(&.{
                .{ "options", h.jo(&.{
                    .{ "active", h.vbool(false) },
                    .{ "fromEnv", h.vbool(false) },
                    .{ "noProxy", h.olist() },
                    .{ "url", h.vstr("") },
                }) },
                .{ "optspec", h.jo(&.{
                    .{ "agent", h.vstr("`$FUNCTION`") },
                }) },
                .{ "strict", h.vbool(false) },
                .{ "transport", h.vstr("wrap") },
            }) },
            .{ "ratelimit", h.jo(&.{
                .{ "options", h.jo(&.{
                    .{ "active", h.vbool(false) },
                    .{ "burst", h.vnum(5) },
                    .{ "rate", h.vnum(5) },
                }) },
                .{ "optspec", h.jo(&.{
                    .{ "now", h.vstr("`$FUNCTION`") },
                    .{ "sleep", h.vstr("`$FUNCTION`") },
                }) },
                .{ "strict", h.vbool(false) },
                .{ "transport", h.vstr("wrap") },
            }) },
            .{ "rbac", h.jo(&.{
                .{ "options", h.jo(&.{
                    .{ "active", h.vbool(false) },
                    .{ "deny", h.vbool(false) },
                    .{ "permissions", h.olist() },
                    .{ "rules", h.omap() },
                }) },
                .{ "optspec", h.omap() },
                .{ "strict", h.vbool(false) },
                .{ "transport", h.vstr("none") },
            }) },
            .{ "retry", h.jo(&.{
                .{ "options", h.jo(&.{
                    .{ "active", h.vbool(false) },
                    .{ "factor", h.vnum(2) },
                    .{ "maxDelay", h.vnum(2000) },
                    .{ "minDelay", h.vnum(50) },
                    .{ "retries", h.vnum(2) },
                    .{ "statuses", h.ja(&.{
                        h.vnum(408),
                        h.vnum(425),
                        h.vnum(429),
                        h.vnum(500),
                        h.vnum(502),
                        h.vnum(503),
                        h.vnum(504),
                    }) },
                }) },
                .{ "optspec", h.jo(&.{
                    .{ "jitter", h.vstr("`$BOOLEAN`") },
                    .{ "sleep", h.vstr("`$FUNCTION`") },
                }) },
                .{ "strict", h.vbool(false) },
                .{ "transport", h.vstr("wrap") },
            }) },
            .{ "secrets", h.jo(&.{
                .{ "options", h.jo(&.{
                    .{ "active", h.vbool(false) },
                    .{ "cache", h.vbool(true) },
                    .{ "exchange", h.jo(&.{
                        .{ "active", h.vbool(false) },
                        .{ "method", h.vstr("POST") },
                        .{ "path", h.vstr("auth/token") },
                        .{ "refresh", h.vstr("") },
                        .{ "request", h.vstr("refresh_token") },
                        .{ "response", h.vstr("access_token") },
                        .{ "retries", h.vnum(1) },
                        .{ "statuses", h.ja(&.{
                            h.vnum(401),
                        }) },
                    }) },
                    .{ "name", h.vstr("apikey") },
                    .{ "providers", h.olist() },
                }) },
                .{ "optspec", h.omap() },
                .{ "strict", h.vbool(false) },
                .{ "transport", h.vstr("wrap") },
            }) },
            .{ "streaming", h.jo(&.{
                .{ "options", h.jo(&.{
                    .{ "active", h.vbool(false) },
                    .{ "chunkDelay", h.vnum(0) },
                    .{ "chunkSize", h.vnum(0) },
                }) },
                .{ "optspec", h.jo(&.{
                    .{ "ops", h.vstr("`$LIST`") },
                    .{ "sleep", h.vstr("`$FUNCTION`") },
                }) },
                .{ "strict", h.vbool(false) },
                .{ "transport", h.vstr("none") },
            }) },
            .{ "telemetry", h.jo(&.{
                .{ "options", h.jo(&.{
                    .{ "active", h.vbool(false) },
                }) },
                .{ "optspec", h.jo(&.{
                    .{ "exporter", h.vstr("`$FUNCTION`") },
                    .{ "headers", h.vstr("`$MAP`") },
                    .{ "idgen", h.vstr("`$FUNCTION`") },
                    .{ "now", h.vstr("`$FUNCTION`") },
                }) },
                .{ "strict", h.vbool(false) },
                .{ "transport", h.vstr("none") },
            }) },
            .{ "test", h.jo(&.{
                .{ "options", h.jo(&.{
                    .{ "active", h.vbool(false) },
                }) },
                .{ "optspec", h.jo(&.{
                    .{ "entity", h.vstr("`$MAP`") },
                    .{ "net", h.vstr("`$MAP`") },
                }) },
                .{ "strict", h.vbool(false) },
                .{ "transport", h.vstr("base") },
            }) },
            .{ "timeout", h.jo(&.{
                .{ "options", h.jo(&.{
                    .{ "active", h.vbool(false) },
                    .{ "ms", h.vnum(30000) },
                }) },
                .{ "optspec", h.jo(&.{
                    .{ "clearTimer", h.vstr("`$FUNCTION`") },
                    .{ "setTimer", h.vstr("`$FUNCTION`") },
                }) },
                .{ "strict", h.vbool(false) },
                .{ "transport", h.vstr("wrap") },
            }) },
            .{ "validate", h.jo(&.{
                .{ "options", h.jo(&.{
                    .{ "active", h.vbool(false) },
                    .{ "mode", h.vstr("throw") },
                    .{ "request", h.vbool(true) },
                    .{ "response", h.vbool(false) },
                    .{ "strict", h.vbool(false) },
                }) },
                .{ "optspec", h.jo(&.{
                    .{ "mode", h.ja(&.{
                        h.vstr("`$ONE`"),
                        h.ja(&.{
                            h.vstr("`$EXACT`"),
                            h.vstr("throw"),
                        }),
                        h.ja(&.{
                            h.vstr("`$EXACT`"),
                            h.vstr("report"),
                        }),
                    }) },
                    .{ "onInvalid", h.vstr("`$FUNCTION`") },
                }) },
                .{ "strict", h.vbool(false) },
                .{ "transport", h.vstr("none") },
            }) },
        }) },
        .{ "options", h.jo(&.{
            .{ "base", h.vstr("https://api.smsapi.com") },
            .{ "auth", h.jo(&.{
                .{ "prefix", h.vstr("Bearer") },
            }) },
            .{ "headers", h.jo(&.{
                .{ "content-type", h.vstr("application/json") },
            }) },
            .{ "entity", h.jo(&.{
                .{ "available", h.omap() },
                .{ "blacklist", h.omap() },
                .{ "callback", h.omap() },
                .{ "contact", h.omap() },
                .{ "contacts_field", h.omap() },
                .{ "contacts_field_option", h.omap() },
                .{ "contactsgroup", h.omap() },
                .{ "contactstrash", h.omap() },
                .{ "field_available", h.omap() },
                .{ "group", h.omap() },
                .{ "mfa_code", h.omap() },
                .{ "opt_out", h.omap() },
                .{ "opt_out_setting", h.omap() },
                .{ "permission", h.omap() },
                .{ "ping", h.omap() },
                .{ "profile", h.omap() },
                .{ "rcs", h.omap() },
                .{ "sendername", h.omap() },
                .{ "sendername_statement", h.omap() },
                .{ "sent_rcs_message", h.omap() },
                .{ "shipment_country_volume", h.omap() },
                .{ "short_url", h.omap() },
                .{ "smsdo", h.omap() },
                .{ "smssendername", h.omap() },
                .{ "smstemplate", h.omap() },
                .{ "subuser", h.omap() },
                .{ "template", h.omap() },
                .{ "user_rcs_sender_collection", h.omap() },
            }) },
        }) },
        .{ "entity", h.jo(&.{
            .{ "available", h.jo(&.{
                .{ "fields", h.ja(&.{
                    h.jo(&.{
                        .{ "name", h.vstr("name") },
                        .{ "title", h.vstr("Name") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("normalize") },
                        .{ "title", h.vstr("Normalize") },
                        .{ "type", h.vstr("`$BOOLEAN`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("template") },
                        .{ "title", h.vstr("Template") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                }) },
                .{ "name", h.vstr("available") },
                .{ "op", h.jo(&.{
                    .{ "list", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("list") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("GET") },
                                .{ "orig", h.vstr("/sms/templates/available") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("sms") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("templates") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("available") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("sms"),
                                    h.vstr("templates"),
                                    h.vstr("available"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body.collection`") },
                                }) },
                                .{ "args", h.omap() },
                                .{ "select", h.omap() },
                            }),
                        }) },
                    }) },
                }) },
                .{ "relations", h.jo(&.{
                    .{ "ancestors", h.olist() },
                }) },
            }) },
            .{ "blacklist", h.jo(&.{
                .{ "fields", h.ja(&.{
                    h.jo(&.{
                        .{ "name", h.vstr("id") },
                        .{ "title", h.vstr("Id") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                }) },
                .{ "id", h.jo(&.{
                    .{ "field", h.vstr("id") },
                    .{ "name", h.vstr("id") },
                }) },
                .{ "name", h.vstr("blacklist") },
                .{ "op", h.jo(&.{
                    .{ "create", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("create") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("POST") },
                                .{ "orig", h.vstr("/blacklist/phone_numbers") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("blacklist") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("phone_numbers") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("blacklist"),
                                    h.vstr("phone_numbers"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.omap() },
                                .{ "select", h.jo(&.{
                                    .{ "$action", h.vstr("phone_number") },
                                }) },
                            }),
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("POST") },
                                .{ "orig", h.vstr("/blacklist/phone_numbers/imports") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("blacklist") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("phone_numbers") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("imports") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("blacklist"),
                                    h.vstr("phone_numbers"),
                                    h.vstr("imports"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.omap() },
                                .{ "select", h.omap() },
                            }),
                        }) },
                    }) },
                    .{ "load", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("load") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("GET") },
                                .{ "orig", h.vstr("/blacklist/phone_numbers") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("blacklist") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("phone_numbers") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("blacklist"),
                                    h.vstr("phone_numbers"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.jo(&.{
                                    .{ "header", h.ja(&.{
                                        h.jo(&.{
                                            .{ "name", h.vstr("accept") },
                                            .{ "orig", h.vstr("Accept") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("header") },
                                            .{ "example", h.vstr("application/json") },
                                        }),
                                        h.jo(&.{
                                            .{ "name", h.vstr("x_async") },
                                            .{ "orig", h.vstr("x-async") },
                                            .{ "type", h.vstr("`$BOOLEAN`") },
                                            .{ "kind", h.vstr("header") },
                                            .{ "example", h.vbool(false) },
                                        }),
                                    }) },
                                    .{ "query", h.ja(&.{
                                        h.jo(&.{
                                            .{ "name", h.vstr("limit") },
                                            .{ "orig", h.vstr("limit") },
                                            .{ "type", h.vstr("`$INTEGER`") },
                                            .{ "kind", h.vstr("query") },
                                            .{ "example", h.vnum(5) },
                                        }),
                                        h.jo(&.{
                                            .{ "name", h.vstr("offset") },
                                            .{ "orig", h.vstr("offset") },
                                            .{ "type", h.vstr("`$INTEGER`") },
                                            .{ "kind", h.vstr("query") },
                                            .{ "example", h.vnum(0) },
                                        }),
                                        h.jo(&.{
                                            .{ "name", h.vstr("q") },
                                            .{ "orig", h.vstr("q") },
                                            .{ "type", h.vstr("`$INTEGER`") },
                                            .{ "kind", h.vstr("query") },
                                            .{ "example", h.vnum(0) },
                                        }),
                                    }) },
                                }) },
                                .{ "select", h.jo(&.{
                                    .{ "$action", h.vstr("phone_number") },
                                    .{ "exist", h.ja(&.{
                                        h.vstr("accept"),
                                        h.vstr("limit"),
                                        h.vstr("offset"),
                                        h.vstr("q"),
                                        h.vstr("x_async"),
                                    }) },
                                }) },
                            }),
                        }) },
                    }) },
                    .{ "remove", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("remove") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("DELETE") },
                                .{ "orig", h.vstr("/blacklist/phone_numbers/{id}") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("blacklist") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("phone_numbers") },
                                    }),
                                    h.jo(&.{
                                        .{ "var", h.vstr("id") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("blacklist"),
                                    h.vstr("phone_numbers"),
                                    h.vstr("{id}"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.jo(&.{
                                    .{ "params", h.ja(&.{
                                        h.jo(&.{
                                            .{ "name", h.vstr("id") },
                                            .{ "orig", h.vstr("id") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("param") },
                                            .{ "reqd", h.vbool(true) },
                                            .{ "example", h.vstr("0f0f0f0f0f0f0f0f0f0f0f0f") },
                                        }),
                                    }) },
                                }) },
                                .{ "select", h.jo(&.{
                                    .{ "exist", h.ja(&.{
                                        h.vstr("id"),
                                    }) },
                                }) },
                            }),
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("DELETE") },
                                .{ "orig", h.vstr("/blacklist/phone_numbers") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("blacklist") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("phone_numbers") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("blacklist"),
                                    h.vstr("phone_numbers"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.jo(&.{
                                    .{ "query", h.ja(&.{
                                        h.jo(&.{
                                            .{ "name", h.vstr("phone_number") },
                                            .{ "orig", h.vstr("phone_number") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("query") },
                                        }),
                                    }) },
                                }) },
                                .{ "select", h.jo(&.{
                                    .{ "$action", h.vstr("phone_number") },
                                    .{ "exist", h.ja(&.{
                                        h.vstr("phone_number"),
                                    }) },
                                }) },
                            }),
                        }) },
                    }) },
                }) },
                .{ "relations", h.jo(&.{
                    .{ "ancestors", h.olist() },
                }) },
            }) },
            .{ "callback", h.jo(&.{
                .{ "fields", h.ja(&.{
                    h.jo(&.{
                        .{ "name", h.vstr("active") },
                        .{ "title", h.vstr("Active") },
                        .{ "type", h.vstr("`$BOOLEAN`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("api_version") },
                        .{ "title", h.vstr("Api Version") },
                        .{ "type", h.vstr("`$INTEGER`") },
                        .{ "short", h.vstr("Version of the callback output format.") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("id") },
                        .{ "title", h.vstr("Id") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "short", h.vstr("Object ID") },
                        .{ "format", h.vstr("oid") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("invalid") },
                        .{ "title", h.vstr("Invalid") },
                        .{ "type", h.vstr("`$BOOLEAN`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("receiver") },
                        .{ "title", h.vstr("Receiver") },
                        .{ "type", h.vstr("`$OBJECT`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("receiver_type") },
                        .{ "title", h.vstr("Receiver Type") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("type") },
                        .{ "title", h.vstr("Type") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("url") },
                        .{ "title", h.vstr("Url") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "op", h.jo(&.{
                            .{ "update", h.jo(&.{
                                .{ "req", h.vbool(true) },
                                .{ "type", h.vstr("`$STRING`") },
                            }) },
                        }) },
                        .{ "short", h.vstr("WHATWG URL compliant") },
                        .{ "format", h.vstr("url") },
                    }),
                }) },
                .{ "id", h.jo(&.{
                    .{ "field", h.vstr("id") },
                    .{ "name", h.vstr("id") },
                }) },
                .{ "name", h.vstr("callback") },
                .{ "op", h.jo(&.{
                    .{ "create", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("create") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("POST") },
                                .{ "orig", h.vstr("/callbacks") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("callbacks") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("callbacks"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.omap() },
                                .{ "select", h.omap() },
                            }),
                        }) },
                    }) },
                    .{ "list", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("list") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("GET") },
                                .{ "orig", h.vstr("/callbacks") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("callbacks") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("callbacks"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body.collection`") },
                                }) },
                                .{ "args", h.omap() },
                                .{ "select", h.omap() },
                            }),
                        }) },
                    }) },
                    .{ "load", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("load") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("GET") },
                                .{ "orig", h.vstr("/callbacks/{id}") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("callbacks") },
                                    }),
                                    h.jo(&.{
                                        .{ "var", h.vstr("id") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("callbacks"),
                                    h.vstr("{id}"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.jo(&.{
                                    .{ "params", h.ja(&.{
                                        h.jo(&.{
                                            .{ "name", h.vstr("id") },
                                            .{ "orig", h.vstr("id") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("param") },
                                            .{ "reqd", h.vbool(true) },
                                            .{ "example", h.vstr("0f0f0f0f0f0f0f0f0f0f0f0f") },
                                        }),
                                    }) },
                                }) },
                                .{ "select", h.jo(&.{
                                    .{ "exist", h.ja(&.{
                                        h.vstr("id"),
                                    }) },
                                }) },
                            }),
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("GET") },
                                .{ "orig", h.vstr("/callbacks/{id}/commands/test") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("callbacks") },
                                    }),
                                    h.jo(&.{
                                        .{ "var", h.vstr("id") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("commands") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("test") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("callbacks"),
                                    h.vstr("{id}"),
                                    h.vstr("commands"),
                                    h.vstr("test"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.jo(&.{
                                    .{ "params", h.ja(&.{
                                        h.jo(&.{
                                            .{ "name", h.vstr("id") },
                                            .{ "orig", h.vstr("id") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("param") },
                                            .{ "reqd", h.vbool(true) },
                                            .{ "example", h.vstr("0f0f0f0f0f0f0f0f0f0f0f0f") },
                                        }),
                                    }) },
                                }) },
                                .{ "select", h.jo(&.{
                                    .{ "$action", h.vstr("command_test") },
                                    .{ "exist", h.ja(&.{
                                        h.vstr("id"),
                                    }) },
                                }) },
                            }),
                        }) },
                    }) },
                    .{ "remove", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("remove") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("DELETE") },
                                .{ "orig", h.vstr("/callbacks/{id}") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("callbacks") },
                                    }),
                                    h.jo(&.{
                                        .{ "var", h.vstr("id") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("callbacks"),
                                    h.vstr("{id}"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.jo(&.{
                                    .{ "params", h.ja(&.{
                                        h.jo(&.{
                                            .{ "name", h.vstr("id") },
                                            .{ "orig", h.vstr("id") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("param") },
                                            .{ "reqd", h.vbool(true) },
                                            .{ "example", h.vstr("0f0f0f0f0f0f0f0f0f0f0f0f") },
                                        }),
                                    }) },
                                }) },
                                .{ "select", h.jo(&.{
                                    .{ "exist", h.ja(&.{
                                        h.vstr("id"),
                                    }) },
                                }) },
                            }),
                        }) },
                    }) },
                    .{ "update", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("update") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("PUT") },
                                .{ "orig", h.vstr("/callbacks/{id}") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("callbacks") },
                                    }),
                                    h.jo(&.{
                                        .{ "var", h.vstr("id") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("callbacks"),
                                    h.vstr("{id}"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.jo(&.{
                                    .{ "params", h.ja(&.{
                                        h.jo(&.{
                                            .{ "name", h.vstr("id") },
                                            .{ "orig", h.vstr("id") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("param") },
                                            .{ "reqd", h.vbool(true) },
                                            .{ "example", h.vstr("0f0f0f0f0f0f0f0f0f0f0f0f") },
                                        }),
                                    }) },
                                }) },
                                .{ "select", h.jo(&.{
                                    .{ "exist", h.ja(&.{
                                        h.vstr("id"),
                                    }) },
                                }) },
                            }),
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("PUT") },
                                .{ "orig", h.vstr("/callbacks/{id}/commands/activate") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("callbacks") },
                                    }),
                                    h.jo(&.{
                                        .{ "var", h.vstr("id") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("commands") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("activate") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("callbacks"),
                                    h.vstr("{id}"),
                                    h.vstr("commands"),
                                    h.vstr("activate"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.jo(&.{
                                    .{ "params", h.ja(&.{
                                        h.jo(&.{
                                            .{ "name", h.vstr("id") },
                                            .{ "orig", h.vstr("id") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("param") },
                                            .{ "reqd", h.vbool(true) },
                                            .{ "example", h.vstr("0f0f0f0f0f0f0f0f0f0f0f0f") },
                                        }),
                                    }) },
                                }) },
                                .{ "select", h.jo(&.{
                                    .{ "$action", h.vstr("command_activate") },
                                    .{ "exist", h.ja(&.{
                                        h.vstr("id"),
                                    }) },
                                }) },
                            }),
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("PUT") },
                                .{ "orig", h.vstr("/callbacks/{id}/commands/deactivate") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("callbacks") },
                                    }),
                                    h.jo(&.{
                                        .{ "var", h.vstr("id") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("commands") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("deactivate") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("callbacks"),
                                    h.vstr("{id}"),
                                    h.vstr("commands"),
                                    h.vstr("deactivate"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.jo(&.{
                                    .{ "params", h.ja(&.{
                                        h.jo(&.{
                                            .{ "name", h.vstr("id") },
                                            .{ "orig", h.vstr("id") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("param") },
                                            .{ "reqd", h.vbool(true) },
                                            .{ "example", h.vstr("0f0f0f0f0f0f0f0f0f0f0f0f") },
                                        }),
                                    }) },
                                }) },
                                .{ "select", h.jo(&.{
                                    .{ "$action", h.vstr("command_deactivate") },
                                    .{ "exist", h.ja(&.{
                                        h.vstr("id"),
                                    }) },
                                }) },
                            }),
                        }) },
                    }) },
                }) },
                .{ "relations", h.jo(&.{
                    .{ "ancestors", h.olist() },
                }) },
            }) },
            .{ "contact", h.jo(&.{
                .{ "fields", h.ja(&.{
                    h.jo(&.{
                        .{ "name", h.vstr("birthday_date") },
                        .{ "title", h.vstr("Birthday Date") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "format", h.vstr("date") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("city") },
                        .{ "title", h.vstr("City") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("collection") },
                        .{ "title", h.vstr("Collection") },
                        .{ "type", h.vstr("`$ARRAY`") },
                        .{ "req", h.vbool(true) },
                        .{ "op", h.jo(&.{
                            .{ "update", h.jo(&.{
                                .{ "type", h.vstr("`$ARRAY`") },
                            }) },
                        }) },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("contact_expire_after") },
                        .{ "title", h.vstr("Contact Expire After") },
                        .{ "type", h.vstr("`$INTEGER`") },
                        .{ "req", h.vbool(true) },
                        .{ "short", h.vstr("Contact expire after days") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("contacts_count") },
                        .{ "title", h.vstr("Contacts Count") },
                        .{ "type", h.vstr("`$INTEGER`") },
                        .{ "req", h.vbool(true) },
                        .{ "op", h.jo(&.{
                            .{ "list", h.jo(&.{
                                .{ "type", h.vstr("`$INTEGER`") },
                            }) },
                        }) },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("country") },
                        .{ "title", h.vstr("Country") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("created_by") },
                        .{ "title", h.vstr("Created By") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "req", h.vbool(true) },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("date_created") },
                        .{ "title", h.vstr("Date Created") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "req", h.vbool(true) },
                        .{ "format", h.vstr("date-time") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("date_updated") },
                        .{ "title", h.vstr("Date Updated") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "req", h.vbool(true) },
                        .{ "format", h.vstr("date-time") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("description") },
                        .{ "title", h.vstr("Description") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "op", h.jo(&.{
                            .{ "load", h.jo(&.{
                                .{ "req", h.vbool(true) },
                                .{ "type", h.vstr("`$STRING`") },
                            }) },
                        }) },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("email") },
                        .{ "title", h.vstr("Email") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "format", h.vstr("email") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("first_name") },
                        .{ "title", h.vstr("First Name") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("gender") },
                        .{ "title", h.vstr("Gender") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "req", h.vbool(true) },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("group_id") },
                        .{ "title", h.vstr("Group Id") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "short", h.vstr("Object ID") },
                        .{ "format", h.vstr("oid") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("groups") },
                        .{ "title", h.vstr("Groups") },
                        .{ "type", h.vstr("`$ARRAY`") },
                        .{ "req", h.vbool(true) },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("id") },
                        .{ "title", h.vstr("Id") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "req", h.vbool(true) },
                        .{ "short", h.vstr("Object ID") },
                        .{ "format", h.vstr("oid") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("idx") },
                        .{ "title", h.vstr("Idx") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "short", h.vstr("User provided resource id") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("last_name") },
                        .{ "title", h.vstr("Last Name") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("name") },
                        .{ "title", h.vstr("Name") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "req", h.vbool(true) },
                        .{ "op", h.jo(&.{
                            .{ "list", h.jo(&.{
                                .{ "type", h.vstr("`$STRING`") },
                            }) },
                        }) },
                        .{ "short", h.vstr("Group name") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("permissions") },
                        .{ "title", h.vstr("Permissions") },
                        .{ "type", h.vstr("`$ARRAY`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("phone_number") },
                        .{ "title", h.vstr("Phone Number") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("read") },
                        .{ "title", h.vstr("Read") },
                        .{ "type", h.vstr("`$BOOLEAN`") },
                        .{ "short", h.vstr("Has read permission") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("send") },
                        .{ "title", h.vstr("Send") },
                        .{ "type", h.vstr("`$BOOLEAN`") },
                        .{ "short", h.vstr("Has send permission") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("size") },
                        .{ "title", h.vstr("Size") },
                        .{ "type", h.vstr("`$INTEGER`") },
                        .{ "req", h.vbool(true) },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("source") },
                        .{ "title", h.vstr("Source") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("type") },
                        .{ "title", h.vstr("Type") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("username") },
                        .{ "title", h.vstr("Username") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("value") },
                        .{ "title", h.vstr("Value") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("write") },
                        .{ "title", h.vstr("Write") },
                        .{ "type", h.vstr("`$BOOLEAN`") },
                        .{ "short", h.vstr("Has write permission") },
                    }),
                }) },
                .{ "id", h.jo(&.{
                    .{ "field", h.vstr("id") },
                    .{ "name", h.vstr("id") },
                }) },
                .{ "name", h.vstr("contact") },
                .{ "op", h.jo(&.{
                    .{ "create", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("create") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("POST") },
                                .{ "orig", h.vstr("/contacts/{contactId}/groups") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("contacts") },
                                    }),
                                    h.jo(&.{
                                        .{ "var", h.vstr("id") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("groups") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("contacts"),
                                    h.vstr("{id}"),
                                    h.vstr("groups"),
                                }) },
                                .{ "rename", h.jo(&.{
                                    .{ "param", h.jo(&.{
                                        .{ "contactId", h.vstr("id") },
                                    }) },
                                }) },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.jo(&.{
                                    .{ "params", h.ja(&.{
                                        h.jo(&.{
                                            .{ "name", h.vstr("id") },
                                            .{ "orig", h.vstr("contactId") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("param") },
                                            .{ "reqd", h.vbool(true) },
                                            .{ "example", h.vstr("0f0f0f0f0f0f0f0f0f0f0f0f") },
                                        }),
                                    }) },
                                }) },
                                .{ "select", h.jo(&.{
                                    .{ "$action", h.vstr("group") },
                                    .{ "exist", h.ja(&.{
                                        h.vstr("id"),
                                    }) },
                                }) },
                            }),
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("POST") },
                                .{ "orig", h.vstr("/contacts") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("contacts") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("contacts"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.omap() },
                                .{ "select", h.omap() },
                            }),
                        }) },
                    }) },
                    .{ "list", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("list") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("GET") },
                                .{ "orig", h.vstr("/contacts") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("contacts") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("contacts"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body.collection`") },
                                }) },
                                .{ "args", h.jo(&.{
                                    .{ "query", h.ja(&.{
                                        h.jo(&.{
                                            .{ "name", h.vstr("birthday_date") },
                                            .{ "orig", h.vstr("birthday_date") },
                                            .{ "type", h.vstr("`$ARRAY`") },
                                            .{ "kind", h.vstr("query") },
                                            .{ "example", h.vstr("2022-06-24") },
                                        }),
                                        h.jo(&.{
                                            .{ "name", h.vstr("email") },
                                            .{ "orig", h.vstr("email") },
                                            .{ "type", h.vstr("`$ARRAY`") },
                                            .{ "kind", h.vstr("query") },
                                        }),
                                        h.jo(&.{
                                            .{ "name", h.vstr("first_name") },
                                            .{ "orig", h.vstr("first_name") },
                                            .{ "type", h.vstr("`$ARRAY`") },
                                            .{ "kind", h.vstr("query") },
                                        }),
                                        h.jo(&.{
                                            .{ "name", h.vstr("gender") },
                                            .{ "orig", h.vstr("gender") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("query") },
                                        }),
                                        h.jo(&.{
                                            .{ "name", h.vstr("group_id") },
                                            .{ "orig", h.vstr("group_id") },
                                            .{ "type", h.vstr("`$ARRAY`") },
                                            .{ "kind", h.vstr("query") },
                                        }),
                                        h.jo(&.{
                                            .{ "name", h.vstr("last_name") },
                                            .{ "orig", h.vstr("last_name") },
                                            .{ "type", h.vstr("`$ARRAY`") },
                                            .{ "kind", h.vstr("query") },
                                        }),
                                        h.jo(&.{
                                            .{ "name", h.vstr("limit") },
                                            .{ "orig", h.vstr("limit") },
                                            .{ "type", h.vstr("`$INTEGER`") },
                                            .{ "kind", h.vstr("query") },
                                            .{ "example", h.vnum(5) },
                                        }),
                                        h.jo(&.{
                                            .{ "name", h.vstr("offset") },
                                            .{ "orig", h.vstr("offset") },
                                            .{ "type", h.vstr("`$INTEGER`") },
                                            .{ "kind", h.vstr("query") },
                                            .{ "example", h.vnum(0) },
                                        }),
                                        h.jo(&.{
                                            .{ "name", h.vstr("order_by") },
                                            .{ "orig", h.vstr("order_by") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("query") },
                                        }),
                                        h.jo(&.{
                                            .{ "name", h.vstr("phone_number") },
                                            .{ "orig", h.vstr("phone_number") },
                                            .{ "type", h.vstr("`$ARRAY`") },
                                            .{ "kind", h.vstr("query") },
                                        }),
                                        h.jo(&.{
                                            .{ "name", h.vstr("q") },
                                            .{ "orig", h.vstr("q") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("query") },
                                        }),
                                    }) },
                                }) },
                                .{ "select", h.jo(&.{
                                    .{ "exist", h.ja(&.{
                                        h.vstr("birthday_date"),
                                        h.vstr("email"),
                                        h.vstr("first_name"),
                                        h.vstr("gender"),
                                        h.vstr("group_id"),
                                        h.vstr("last_name"),
                                        h.vstr("limit"),
                                        h.vstr("offset"),
                                        h.vstr("order_by"),
                                        h.vstr("phone_number"),
                                        h.vstr("q"),
                                    }) },
                                }) },
                            }),
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("GET") },
                                .{ "orig", h.vstr("/contacts/{contactId}/groups") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("contacts") },
                                    }),
                                    h.jo(&.{
                                        .{ "var", h.vstr("id") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("groups") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("contacts"),
                                    h.vstr("{id}"),
                                    h.vstr("groups"),
                                }) },
                                .{ "rename", h.jo(&.{
                                    .{ "param", h.jo(&.{
                                        .{ "contactId", h.vstr("id") },
                                    }) },
                                }) },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body.collection`") },
                                }) },
                                .{ "args", h.jo(&.{
                                    .{ "params", h.ja(&.{
                                        h.jo(&.{
                                            .{ "name", h.vstr("id") },
                                            .{ "orig", h.vstr("contactId") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("param") },
                                            .{ "reqd", h.vbool(true) },
                                            .{ "example", h.vstr("0f0f0f0f0f0f0f0f0f0f0f0f") },
                                        }),
                                    }) },
                                }) },
                                .{ "select", h.jo(&.{
                                    .{ "$action", h.vstr("group") },
                                    .{ "exist", h.ja(&.{
                                        h.vstr("id"),
                                    }) },
                                }) },
                            }),
                        }) },
                    }) },
                    .{ "load", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("load") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("GET") },
                                .{ "orig", h.vstr("/contacts/groups/{groupId}/members/{contactId}") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("contacts") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("groups") },
                                    }),
                                    h.jo(&.{
                                        .{ "var", h.vstr("group_id") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("members") },
                                    }),
                                    h.jo(&.{
                                        .{ "var", h.vstr("contact_id") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("contacts"),
                                    h.vstr("groups"),
                                    h.vstr("{group_id}"),
                                    h.vstr("members"),
                                    h.vstr("{contact_id}"),
                                }) },
                                .{ "rename", h.jo(&.{
                                    .{ "param", h.jo(&.{
                                        .{ "contactId", h.vstr("contact_id") },
                                        .{ "groupId", h.vstr("group_id") },
                                    }) },
                                }) },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.jo(&.{
                                    .{ "params", h.ja(&.{
                                        h.jo(&.{
                                            .{ "name", h.vstr("contact_id") },
                                            .{ "orig", h.vstr("contactId") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("param") },
                                            .{ "reqd", h.vbool(true) },
                                            .{ "example", h.vstr("0f0f0f0f0f0f0f0f0f0f0f0f") },
                                        }),
                                        h.jo(&.{
                                            .{ "name", h.vstr("group_id") },
                                            .{ "orig", h.vstr("groupId") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("param") },
                                            .{ "reqd", h.vbool(true) },
                                            .{ "example", h.vstr("0f0f0f0f0f0f0f0f0f0f0f0f") },
                                        }),
                                    }) },
                                }) },
                                .{ "select", h.jo(&.{
                                    .{ "exist", h.ja(&.{
                                        h.vstr("contact_id"),
                                        h.vstr("group_id"),
                                    }) },
                                }) },
                            }),
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("GET") },
                                .{ "orig", h.vstr("/contacts/{contactId}/groups/{groupId}") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("contacts") },
                                    }),
                                    h.jo(&.{
                                        .{ "var", h.vstr("id") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("groups") },
                                    }),
                                    h.jo(&.{
                                        .{ "var", h.vstr("group_id") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("contacts"),
                                    h.vstr("{id}"),
                                    h.vstr("groups"),
                                    h.vstr("{group_id}"),
                                }) },
                                .{ "rename", h.jo(&.{
                                    .{ "param", h.jo(&.{
                                        .{ "contactId", h.vstr("id") },
                                        .{ "groupId", h.vstr("group_id") },
                                    }) },
                                }) },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.jo(&.{
                                    .{ "params", h.ja(&.{
                                        h.jo(&.{
                                            .{ "name", h.vstr("group_id") },
                                            .{ "orig", h.vstr("groupId") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("param") },
                                            .{ "reqd", h.vbool(true) },
                                            .{ "example", h.vstr("0f0f0f0f0f0f0f0f0f0f0f0f") },
                                        }),
                                        h.jo(&.{
                                            .{ "name", h.vstr("id") },
                                            .{ "orig", h.vstr("contactId") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("param") },
                                            .{ "reqd", h.vbool(true) },
                                            .{ "example", h.vstr("0f0f0f0f0f0f0f0f0f0f0f0f") },
                                        }),
                                    }) },
                                }) },
                                .{ "select", h.jo(&.{
                                    .{ "exist", h.ja(&.{
                                        h.vstr("group_id"),
                                        h.vstr("id"),
                                    }) },
                                }) },
                            }),
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("GET") },
                                .{ "orig", h.vstr("/contacts/{contactId}") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("contacts") },
                                    }),
                                    h.jo(&.{
                                        .{ "var", h.vstr("id") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("contacts"),
                                    h.vstr("{id}"),
                                }) },
                                .{ "rename", h.jo(&.{
                                    .{ "param", h.jo(&.{
                                        .{ "contactId", h.vstr("id") },
                                    }) },
                                }) },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.jo(&.{
                                    .{ "params", h.ja(&.{
                                        h.jo(&.{
                                            .{ "name", h.vstr("id") },
                                            .{ "orig", h.vstr("contactId") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("param") },
                                            .{ "reqd", h.vbool(true) },
                                            .{ "example", h.vstr("0f0f0f0f0f0f0f0f0f0f0f0f") },
                                        }),
                                    }) },
                                }) },
                                .{ "select", h.jo(&.{
                                    .{ "exist", h.ja(&.{
                                        h.vstr("id"),
                                    }) },
                                }) },
                            }),
                        }) },
                    }) },
                    .{ "remove", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("remove") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("DELETE") },
                                .{ "orig", h.vstr("/contacts/{contactId}/groups/{groupId}") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("contacts") },
                                    }),
                                    h.jo(&.{
                                        .{ "var", h.vstr("id") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("groups") },
                                    }),
                                    h.jo(&.{
                                        .{ "var", h.vstr("group_id") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("contacts"),
                                    h.vstr("{id}"),
                                    h.vstr("groups"),
                                    h.vstr("{group_id}"),
                                }) },
                                .{ "rename", h.jo(&.{
                                    .{ "param", h.jo(&.{
                                        .{ "contactId", h.vstr("id") },
                                        .{ "groupId", h.vstr("group_id") },
                                    }) },
                                }) },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.jo(&.{
                                    .{ "params", h.ja(&.{
                                        h.jo(&.{
                                            .{ "name", h.vstr("group_id") },
                                            .{ "orig", h.vstr("groupId") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("param") },
                                            .{ "reqd", h.vbool(true) },
                                            .{ "example", h.vstr("0f0f0f0f0f0f0f0f0f0f0f0f") },
                                        }),
                                        h.jo(&.{
                                            .{ "name", h.vstr("id") },
                                            .{ "orig", h.vstr("contactId") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("param") },
                                            .{ "reqd", h.vbool(true) },
                                            .{ "example", h.vstr("0f0f0f0f0f0f0f0f0f0f0f0f") },
                                        }),
                                    }) },
                                }) },
                                .{ "select", h.jo(&.{
                                    .{ "exist", h.ja(&.{
                                        h.vstr("group_id"),
                                        h.vstr("id"),
                                    }) },
                                }) },
                            }),
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("DELETE") },
                                .{ "orig", h.vstr("/contacts/{contactId}") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("contacts") },
                                    }),
                                    h.jo(&.{
                                        .{ "var", h.vstr("id") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("contacts"),
                                    h.vstr("{id}"),
                                }) },
                                .{ "rename", h.jo(&.{
                                    .{ "param", h.jo(&.{
                                        .{ "contactId", h.vstr("id") },
                                    }) },
                                }) },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.jo(&.{
                                    .{ "params", h.ja(&.{
                                        h.jo(&.{
                                            .{ "name", h.vstr("id") },
                                            .{ "orig", h.vstr("contactId") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("param") },
                                            .{ "reqd", h.vbool(true) },
                                            .{ "example", h.vstr("0f0f0f0f0f0f0f0f0f0f0f0f") },
                                        }),
                                    }) },
                                }) },
                                .{ "select", h.jo(&.{
                                    .{ "exist", h.ja(&.{
                                        h.vstr("id"),
                                    }) },
                                }) },
                            }),
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("DELETE") },
                                .{ "orig", h.vstr("/contacts") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("contacts") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("contacts"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.omap() },
                                .{ "select", h.omap() },
                            }),
                        }) },
                    }) },
                    .{ "update", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("update") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("PUT") },
                                .{ "orig", h.vstr("/contacts/groups/{groupId}/members/{contactId}") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("contacts") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("groups") },
                                    }),
                                    h.jo(&.{
                                        .{ "var", h.vstr("group_id") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("members") },
                                    }),
                                    h.jo(&.{
                                        .{ "var", h.vstr("contact_id") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("contacts"),
                                    h.vstr("groups"),
                                    h.vstr("{group_id}"),
                                    h.vstr("members"),
                                    h.vstr("{contact_id}"),
                                }) },
                                .{ "rename", h.jo(&.{
                                    .{ "param", h.jo(&.{
                                        .{ "contactId", h.vstr("contact_id") },
                                        .{ "groupId", h.vstr("group_id") },
                                    }) },
                                }) },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.jo(&.{
                                    .{ "params", h.ja(&.{
                                        h.jo(&.{
                                            .{ "name", h.vstr("contact_id") },
                                            .{ "orig", h.vstr("contactId") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("param") },
                                            .{ "reqd", h.vbool(true) },
                                            .{ "example", h.vstr("0f0f0f0f0f0f0f0f0f0f0f0f") },
                                        }),
                                        h.jo(&.{
                                            .{ "name", h.vstr("group_id") },
                                            .{ "orig", h.vstr("groupId") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("param") },
                                            .{ "reqd", h.vbool(true) },
                                            .{ "example", h.vstr("0f0f0f0f0f0f0f0f0f0f0f0f") },
                                        }),
                                    }) },
                                }) },
                                .{ "select", h.jo(&.{
                                    .{ "exist", h.ja(&.{
                                        h.vstr("contact_id"),
                                        h.vstr("group_id"),
                                    }) },
                                }) },
                            }),
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("PUT") },
                                .{ "orig", h.vstr("/contacts/{contactId}/groups/{groupId}") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("contacts") },
                                    }),
                                    h.jo(&.{
                                        .{ "var", h.vstr("id") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("groups") },
                                    }),
                                    h.jo(&.{
                                        .{ "var", h.vstr("group_id") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("contacts"),
                                    h.vstr("{id}"),
                                    h.vstr("groups"),
                                    h.vstr("{group_id}"),
                                }) },
                                .{ "rename", h.jo(&.{
                                    .{ "param", h.jo(&.{
                                        .{ "contactId", h.vstr("id") },
                                        .{ "groupId", h.vstr("group_id") },
                                    }) },
                                }) },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.jo(&.{
                                    .{ "params", h.ja(&.{
                                        h.jo(&.{
                                            .{ "name", h.vstr("group_id") },
                                            .{ "orig", h.vstr("groupId") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("param") },
                                            .{ "reqd", h.vbool(true) },
                                            .{ "example", h.vstr("0f0f0f0f0f0f0f0f0f0f0f0f") },
                                        }),
                                        h.jo(&.{
                                            .{ "name", h.vstr("id") },
                                            .{ "orig", h.vstr("contactId") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("param") },
                                            .{ "reqd", h.vbool(true) },
                                            .{ "example", h.vstr("0f0f0f0f0f0f0f0f0f0f0f0f") },
                                        }),
                                    }) },
                                }) },
                                .{ "select", h.jo(&.{
                                    .{ "exist", h.ja(&.{
                                        h.vstr("group_id"),
                                        h.vstr("id"),
                                    }) },
                                }) },
                            }),
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("PUT") },
                                .{ "orig", h.vstr("/contacts/{contactId}") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("contacts") },
                                    }),
                                    h.jo(&.{
                                        .{ "var", h.vstr("id") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("contacts"),
                                    h.vstr("{id}"),
                                }) },
                                .{ "rename", h.jo(&.{
                                    .{ "param", h.jo(&.{
                                        .{ "contactId", h.vstr("id") },
                                    }) },
                                }) },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.jo(&.{
                                    .{ "params", h.ja(&.{
                                        h.jo(&.{
                                            .{ "name", h.vstr("id") },
                                            .{ "orig", h.vstr("contactId") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("param") },
                                            .{ "reqd", h.vbool(true) },
                                            .{ "example", h.vstr("0f0f0f0f0f0f0f0f0f0f0f0f") },
                                        }),
                                    }) },
                                }) },
                                .{ "select", h.jo(&.{
                                    .{ "exist", h.ja(&.{
                                        h.vstr("id"),
                                    }) },
                                }) },
                            }),
                        }) },
                    }) },
                }) },
                .{ "relations", h.jo(&.{
                    .{ "ancestors", h.ja(&.{
                        h.ja(&.{
                            h.vstr("$.main.kit.entity.group"),
                        }),
                        h.ja(&.{
                            h.vstr("$.main.kit.entity.group"),
                        }),
                    }) },
                }) },
            }) },
            .{ "contacts_field", h.jo(&.{
                .{ "fields", h.ja(&.{
                    h.jo(&.{
                        .{ "name", h.vstr("birthday_date") },
                        .{ "title", h.vstr("Birthday Date") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "format", h.vstr("date") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("city") },
                        .{ "title", h.vstr("City") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("contact_expire_after") },
                        .{ "title", h.vstr("Contact Expire After") },
                        .{ "type", h.vstr("`$INTEGER`") },
                        .{ "req", h.vbool(true) },
                        .{ "short", h.vstr("Contact expire after days") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("contacts_count") },
                        .{ "title", h.vstr("Contacts Count") },
                        .{ "type", h.vstr("`$INTEGER`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("country") },
                        .{ "title", h.vstr("Country") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("created_by") },
                        .{ "title", h.vstr("Created By") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "req", h.vbool(true) },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("date_created") },
                        .{ "title", h.vstr("Date Created") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "req", h.vbool(true) },
                        .{ "format", h.vstr("date-time") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("date_updated") },
                        .{ "title", h.vstr("Date Updated") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "req", h.vbool(true) },
                        .{ "format", h.vstr("date-time") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("description") },
                        .{ "title", h.vstr("Description") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("email") },
                        .{ "title", h.vstr("Email") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "format", h.vstr("email") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("first_name") },
                        .{ "title", h.vstr("First Name") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("gender") },
                        .{ "title", h.vstr("Gender") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "req", h.vbool(true) },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("group_id") },
                        .{ "title", h.vstr("Group Id") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "short", h.vstr("Object ID") },
                        .{ "format", h.vstr("oid") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("groups") },
                        .{ "title", h.vstr("Groups") },
                        .{ "type", h.vstr("`$ARRAY`") },
                        .{ "req", h.vbool(true) },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("id") },
                        .{ "title", h.vstr("Id") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "op", h.jo(&.{
                            .{ "list", h.jo(&.{
                                .{ "req", h.vbool(true) },
                                .{ "type", h.vstr("`$STRING`") },
                            }) },
                        }) },
                        .{ "short", h.vstr("Object ID") },
                        .{ "format", h.vstr("oid") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("idx") },
                        .{ "title", h.vstr("Idx") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "short", h.vstr("User provided resource id") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("last_name") },
                        .{ "title", h.vstr("Last Name") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("name") },
                        .{ "title", h.vstr("Name") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "short", h.vstr("Group name") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("permissions") },
                        .{ "title", h.vstr("Permissions") },
                        .{ "type", h.vstr("`$ARRAY`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("phone_number") },
                        .{ "title", h.vstr("Phone Number") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("read") },
                        .{ "title", h.vstr("Read") },
                        .{ "type", h.vstr("`$BOOLEAN`") },
                        .{ "short", h.vstr("Has read permission") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("send") },
                        .{ "title", h.vstr("Send") },
                        .{ "type", h.vstr("`$BOOLEAN`") },
                        .{ "short", h.vstr("Has send permission") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("source") },
                        .{ "title", h.vstr("Source") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("type") },
                        .{ "title", h.vstr("Type") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("username") },
                        .{ "title", h.vstr("Username") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("value") },
                        .{ "title", h.vstr("Value") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("write") },
                        .{ "title", h.vstr("Write") },
                        .{ "type", h.vstr("`$BOOLEAN`") },
                        .{ "short", h.vstr("Has write permission") },
                    }),
                }) },
                .{ "id", h.jo(&.{
                    .{ "field", h.vstr("id") },
                    .{ "name", h.vstr("id") },
                }) },
                .{ "name", h.vstr("contacts_field") },
                .{ "op", h.jo(&.{
                    .{ "create", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("create") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("POST") },
                                .{ "orig", h.vstr("/contacts/fields") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("contacts") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("fields") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("contacts"),
                                    h.vstr("fields"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.omap() },
                                .{ "select", h.omap() },
                            }),
                        }) },
                    }) },
                    .{ "list", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("list") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("GET") },
                                .{ "orig", h.vstr("/contacts/fields") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("contacts") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("fields") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("contacts"),
                                    h.vstr("fields"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body.collection`") },
                                }) },
                                .{ "args", h.omap() },
                                .{ "select", h.omap() },
                            }),
                        }) },
                    }) },
                    .{ "remove", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("remove") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("DELETE") },
                                .{ "orig", h.vstr("/contacts/fields/{fieldId}") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("contacts") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("fields") },
                                    }),
                                    h.jo(&.{
                                        .{ "var", h.vstr("id") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("contacts"),
                                    h.vstr("fields"),
                                    h.vstr("{id}"),
                                }) },
                                .{ "rename", h.jo(&.{
                                    .{ "param", h.jo(&.{
                                        .{ "fieldId", h.vstr("id") },
                                    }) },
                                }) },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.jo(&.{
                                    .{ "params", h.ja(&.{
                                        h.jo(&.{
                                            .{ "name", h.vstr("id") },
                                            .{ "orig", h.vstr("fieldId") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("param") },
                                            .{ "reqd", h.vbool(true) },
                                            .{ "example", h.vstr("0f0f0f0f0f0f0f0f0f0f0f0f") },
                                        }),
                                    }) },
                                }) },
                                .{ "select", h.jo(&.{
                                    .{ "exist", h.ja(&.{
                                        h.vstr("id"),
                                    }) },
                                }) },
                            }),
                        }) },
                    }) },
                    .{ "update", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("update") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("PUT") },
                                .{ "orig", h.vstr("/contacts/fields/{fieldId}") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("contacts") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("fields") },
                                    }),
                                    h.jo(&.{
                                        .{ "var", h.vstr("id") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("contacts"),
                                    h.vstr("fields"),
                                    h.vstr("{id}"),
                                }) },
                                .{ "rename", h.jo(&.{
                                    .{ "param", h.jo(&.{
                                        .{ "fieldId", h.vstr("id") },
                                    }) },
                                }) },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.jo(&.{
                                    .{ "params", h.ja(&.{
                                        h.jo(&.{
                                            .{ "name", h.vstr("id") },
                                            .{ "orig", h.vstr("fieldId") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("param") },
                                            .{ "reqd", h.vbool(true) },
                                            .{ "example", h.vstr("0f0f0f0f0f0f0f0f0f0f0f0f") },
                                        }),
                                    }) },
                                }) },
                                .{ "select", h.jo(&.{
                                    .{ "exist", h.ja(&.{
                                        h.vstr("id"),
                                    }) },
                                }) },
                            }),
                        }) },
                    }) },
                }) },
                .{ "relations", h.jo(&.{
                    .{ "ancestors", h.olist() },
                }) },
            }) },
            .{ "contacts_field_option", h.jo(&.{
                .{ "fields", h.ja(&.{
                    h.jo(&.{
                        .{ "name", h.vstr("birthday_date") },
                        .{ "title", h.vstr("Birthday Date") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "format", h.vstr("date") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("city") },
                        .{ "title", h.vstr("City") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("contact_expire_after") },
                        .{ "title", h.vstr("Contact Expire After") },
                        .{ "type", h.vstr("`$INTEGER`") },
                        .{ "req", h.vbool(true) },
                        .{ "short", h.vstr("Contact expire after days") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("contacts_count") },
                        .{ "title", h.vstr("Contacts Count") },
                        .{ "type", h.vstr("`$INTEGER`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("country") },
                        .{ "title", h.vstr("Country") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("created_by") },
                        .{ "title", h.vstr("Created By") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "req", h.vbool(true) },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("date_created") },
                        .{ "title", h.vstr("Date Created") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "req", h.vbool(true) },
                        .{ "format", h.vstr("date-time") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("date_updated") },
                        .{ "title", h.vstr("Date Updated") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "req", h.vbool(true) },
                        .{ "format", h.vstr("date-time") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("description") },
                        .{ "title", h.vstr("Description") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("email") },
                        .{ "title", h.vstr("Email") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "format", h.vstr("email") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("first_name") },
                        .{ "title", h.vstr("First Name") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("gender") },
                        .{ "title", h.vstr("Gender") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "req", h.vbool(true) },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("group_id") },
                        .{ "title", h.vstr("Group Id") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "short", h.vstr("Object ID") },
                        .{ "format", h.vstr("oid") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("groups") },
                        .{ "title", h.vstr("Groups") },
                        .{ "type", h.vstr("`$ARRAY`") },
                        .{ "req", h.vbool(true) },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("id") },
                        .{ "title", h.vstr("Id") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "req", h.vbool(true) },
                        .{ "short", h.vstr("Object ID") },
                        .{ "format", h.vstr("oid") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("idx") },
                        .{ "title", h.vstr("Idx") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "short", h.vstr("User provided resource id") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("last_name") },
                        .{ "title", h.vstr("Last Name") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("name") },
                        .{ "title", h.vstr("Name") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "short", h.vstr("Group name") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("permissions") },
                        .{ "title", h.vstr("Permissions") },
                        .{ "type", h.vstr("`$ARRAY`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("phone_number") },
                        .{ "title", h.vstr("Phone Number") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("read") },
                        .{ "title", h.vstr("Read") },
                        .{ "type", h.vstr("`$BOOLEAN`") },
                        .{ "short", h.vstr("Has read permission") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("send") },
                        .{ "title", h.vstr("Send") },
                        .{ "type", h.vstr("`$BOOLEAN`") },
                        .{ "short", h.vstr("Has send permission") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("source") },
                        .{ "title", h.vstr("Source") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("type") },
                        .{ "title", h.vstr("Type") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("username") },
                        .{ "title", h.vstr("Username") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("value") },
                        .{ "title", h.vstr("Value") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("write") },
                        .{ "title", h.vstr("Write") },
                        .{ "type", h.vstr("`$BOOLEAN`") },
                        .{ "short", h.vstr("Has write permission") },
                    }),
                }) },
                .{ "id", h.jo(&.{
                    .{ "field", h.vstr("id") },
                    .{ "name", h.vstr("id") },
                }) },
                .{ "name", h.vstr("contacts_field_option") },
                .{ "op", h.jo(&.{
                    .{ "list", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("list") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("GET") },
                                .{ "orig", h.vstr("/contacts/fields/{fieldId}/options") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("contacts") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("fields") },
                                    }),
                                    h.jo(&.{
                                        .{ "var", h.vstr("field_id") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("options") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("contacts"),
                                    h.vstr("fields"),
                                    h.vstr("{field_id}"),
                                    h.vstr("options"),
                                }) },
                                .{ "rename", h.jo(&.{
                                    .{ "param", h.jo(&.{
                                        .{ "fieldId", h.vstr("field_id") },
                                    }) },
                                }) },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body.collection`") },
                                }) },
                                .{ "args", h.jo(&.{
                                    .{ "params", h.ja(&.{
                                        h.jo(&.{
                                            .{ "name", h.vstr("field_id") },
                                            .{ "orig", h.vstr("fieldId") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("param") },
                                            .{ "reqd", h.vbool(true) },
                                            .{ "example", h.vstr("0f0f0f0f0f0f0f0f0f0f0f0f") },
                                        }),
                                    }) },
                                }) },
                                .{ "select", h.jo(&.{
                                    .{ "exist", h.ja(&.{
                                        h.vstr("field_id"),
                                    }) },
                                }) },
                            }),
                        }) },
                    }) },
                }) },
                .{ "relations", h.jo(&.{
                    .{ "ancestors", h.olist() },
                }) },
            }) },
            .{ "contactsgroup", h.jo(&.{
                .{ "fields", h.ja(&.{
                    h.jo(&.{
                        .{ "name", h.vstr("birthday_date") },
                        .{ "title", h.vstr("Birthday Date") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "format", h.vstr("date") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("city") },
                        .{ "title", h.vstr("City") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("contact_expire_after") },
                        .{ "title", h.vstr("Contact Expire After") },
                        .{ "type", h.vstr("`$INTEGER`") },
                        .{ "req", h.vbool(true) },
                        .{ "short", h.vstr("Contact expire after days") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("contacts_count") },
                        .{ "title", h.vstr("Contacts Count") },
                        .{ "type", h.vstr("`$INTEGER`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("country") },
                        .{ "title", h.vstr("Country") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("created_by") },
                        .{ "title", h.vstr("Created By") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "req", h.vbool(true) },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("date_created") },
                        .{ "title", h.vstr("Date Created") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "req", h.vbool(true) },
                        .{ "format", h.vstr("date-time") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("date_updated") },
                        .{ "title", h.vstr("Date Updated") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "req", h.vbool(true) },
                        .{ "format", h.vstr("date-time") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("description") },
                        .{ "title", h.vstr("Description") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("email") },
                        .{ "title", h.vstr("Email") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "format", h.vstr("email") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("first_name") },
                        .{ "title", h.vstr("First Name") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("gender") },
                        .{ "title", h.vstr("Gender") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "req", h.vbool(true) },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("group_id") },
                        .{ "title", h.vstr("Group Id") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "req", h.vbool(true) },
                        .{ "op", h.jo(&.{
                            .{ "list", h.jo(&.{
                                .{ "type", h.vstr("`$STRING`") },
                            }) },
                        }) },
                        .{ "short", h.vstr("Object ID") },
                        .{ "format", h.vstr("oid") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("groups") },
                        .{ "title", h.vstr("Groups") },
                        .{ "type", h.vstr("`$ARRAY`") },
                        .{ "req", h.vbool(true) },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("id") },
                        .{ "title", h.vstr("Id") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "req", h.vbool(true) },
                        .{ "short", h.vstr("Object ID") },
                        .{ "format", h.vstr("oid") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("idx") },
                        .{ "title", h.vstr("Idx") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "short", h.vstr("User provided resource id") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("last_name") },
                        .{ "title", h.vstr("Last Name") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("name") },
                        .{ "title", h.vstr("Name") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "short", h.vstr("Group name") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("permissions") },
                        .{ "title", h.vstr("Permissions") },
                        .{ "type", h.vstr("`$ARRAY`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("phone_number") },
                        .{ "title", h.vstr("Phone Number") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("read") },
                        .{ "title", h.vstr("Read") },
                        .{ "type", h.vstr("`$BOOLEAN`") },
                        .{ "req", h.vbool(true) },
                        .{ "op", h.jo(&.{
                            .{ "list", h.jo(&.{
                                .{ "type", h.vstr("`$BOOLEAN`") },
                            }) },
                        }) },
                        .{ "short", h.vstr("Has read permission") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("send") },
                        .{ "title", h.vstr("Send") },
                        .{ "type", h.vstr("`$BOOLEAN`") },
                        .{ "req", h.vbool(true) },
                        .{ "op", h.jo(&.{
                            .{ "list", h.jo(&.{
                                .{ "type", h.vstr("`$BOOLEAN`") },
                            }) },
                        }) },
                        .{ "short", h.vstr("Has send permission") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("source") },
                        .{ "title", h.vstr("Source") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("type") },
                        .{ "title", h.vstr("Type") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("username") },
                        .{ "title", h.vstr("Username") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "req", h.vbool(true) },
                        .{ "op", h.jo(&.{
                            .{ "list", h.jo(&.{
                                .{ "type", h.vstr("`$STRING`") },
                            }) },
                        }) },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("value") },
                        .{ "title", h.vstr("Value") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("write") },
                        .{ "title", h.vstr("Write") },
                        .{ "type", h.vstr("`$BOOLEAN`") },
                        .{ "req", h.vbool(true) },
                        .{ "op", h.jo(&.{
                            .{ "list", h.jo(&.{
                                .{ "type", h.vstr("`$BOOLEAN`") },
                            }) },
                        }) },
                        .{ "short", h.vstr("Has write permission") },
                    }),
                }) },
                .{ "id", h.jo(&.{
                    .{ "field", h.vstr("id") },
                    .{ "name", h.vstr("id") },
                }) },
                .{ "name", h.vstr("contactsgroup") },
                .{ "op", h.jo(&.{
                    .{ "create", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("create") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("POST") },
                                .{ "orig", h.vstr("/contacts/groups/{groupId}/members") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("contacts") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("groups") },
                                    }),
                                    h.jo(&.{
                                        .{ "var", h.vstr("group_id") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("members") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("contacts"),
                                    h.vstr("groups"),
                                    h.vstr("{group_id}"),
                                    h.vstr("members"),
                                }) },
                                .{ "rename", h.jo(&.{
                                    .{ "param", h.jo(&.{
                                        .{ "groupId", h.vstr("group_id") },
                                    }) },
                                }) },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.jo(&.{
                                    .{ "params", h.ja(&.{
                                        h.jo(&.{
                                            .{ "name", h.vstr("group_id") },
                                            .{ "orig", h.vstr("groupId") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("param") },
                                            .{ "reqd", h.vbool(true) },
                                            .{ "example", h.vstr("0f0f0f0f0f0f0f0f0f0f0f0f") },
                                        }),
                                    }) },
                                }) },
                                .{ "select", h.jo(&.{
                                    .{ "exist", h.ja(&.{
                                        h.vstr("group_id"),
                                    }) },
                                }) },
                            }),
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("POST") },
                                .{ "orig", h.vstr("/contacts/groups") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("contacts") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("groups") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("contacts"),
                                    h.vstr("groups"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.omap() },
                                .{ "select", h.omap() },
                            }),
                        }) },
                    }) },
                    .{ "list", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("list") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("GET") },
                                .{ "orig", h.vstr("/contacts/groups") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("contacts") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("groups") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("contacts"),
                                    h.vstr("groups"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body.collection`") },
                                }) },
                                .{ "args", h.jo(&.{
                                    .{ "query", h.ja(&.{
                                        h.jo(&.{
                                            .{ "name", h.vstr("name") },
                                            .{ "orig", h.vstr("name") },
                                            .{ "type", h.vstr("`$OBJECT`") },
                                            .{ "kind", h.vstr("query") },
                                            .{ "example", h.vstr("{\"name\" : \"group name\"}") },
                                        }),
                                        h.jo(&.{
                                            .{ "name", h.vstr("with") },
                                            .{ "orig", h.vstr("with") },
                                            .{ "type", h.vstr("`$ARRAY`") },
                                            .{ "kind", h.vstr("query") },
                                        }),
                                    }) },
                                }) },
                                .{ "select", h.jo(&.{
                                    .{ "exist", h.ja(&.{
                                        h.vstr("name"),
                                        h.vstr("with"),
                                    }) },
                                }) },
                            }),
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("GET") },
                                .{ "orig", h.vstr("/contacts/groups/{groupId}/permissions") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("contacts") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("groups") },
                                    }),
                                    h.jo(&.{
                                        .{ "var", h.vstr("group_id") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("permissions") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("contacts"),
                                    h.vstr("groups"),
                                    h.vstr("{group_id}"),
                                    h.vstr("permissions"),
                                }) },
                                .{ "rename", h.jo(&.{
                                    .{ "param", h.jo(&.{
                                        .{ "groupId", h.vstr("group_id") },
                                    }) },
                                }) },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body.collection`") },
                                }) },
                                .{ "args", h.jo(&.{
                                    .{ "params", h.ja(&.{
                                        h.jo(&.{
                                            .{ "name", h.vstr("group_id") },
                                            .{ "orig", h.vstr("groupId") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("param") },
                                            .{ "reqd", h.vbool(true) },
                                            .{ "example", h.vstr("0f0f0f0f0f0f0f0f0f0f0f0f") },
                                        }),
                                    }) },
                                }) },
                                .{ "select", h.jo(&.{
                                    .{ "exist", h.ja(&.{
                                        h.vstr("group_id"),
                                    }) },
                                }) },
                            }),
                        }) },
                    }) },
                    .{ "remove", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("remove") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("DELETE") },
                                .{ "orig", h.vstr("/contacts/groups/{groupId}/members/{contactId}") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("contacts") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("groups") },
                                    }),
                                    h.jo(&.{
                                        .{ "var", h.vstr("group_id") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("members") },
                                    }),
                                    h.jo(&.{
                                        .{ "var", h.vstr("contact_id") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("contacts"),
                                    h.vstr("groups"),
                                    h.vstr("{group_id}"),
                                    h.vstr("members"),
                                    h.vstr("{contact_id}"),
                                }) },
                                .{ "rename", h.jo(&.{
                                    .{ "param", h.jo(&.{
                                        .{ "contactId", h.vstr("contact_id") },
                                        .{ "groupId", h.vstr("group_id") },
                                    }) },
                                }) },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.jo(&.{
                                    .{ "params", h.ja(&.{
                                        h.jo(&.{
                                            .{ "name", h.vstr("contact_id") },
                                            .{ "orig", h.vstr("contactId") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("param") },
                                            .{ "reqd", h.vbool(true) },
                                            .{ "example", h.vstr("0f0f0f0f0f0f0f0f0f0f0f0f") },
                                        }),
                                        h.jo(&.{
                                            .{ "name", h.vstr("group_id") },
                                            .{ "orig", h.vstr("groupId") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("param") },
                                            .{ "reqd", h.vbool(true) },
                                            .{ "example", h.vstr("0f0f0f0f0f0f0f0f0f0f0f0f") },
                                        }),
                                    }) },
                                }) },
                                .{ "select", h.jo(&.{
                                    .{ "exist", h.ja(&.{
                                        h.vstr("contact_id"),
                                        h.vstr("group_id"),
                                    }) },
                                }) },
                            }),
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("DELETE") },
                                .{ "orig", h.vstr("/contacts/groups/{groupId}/permissions/{username}") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("contacts") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("groups") },
                                    }),
                                    h.jo(&.{
                                        .{ "var", h.vstr("group_id") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("permissions") },
                                    }),
                                    h.jo(&.{
                                        .{ "var", h.vstr("username") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("contacts"),
                                    h.vstr("groups"),
                                    h.vstr("{group_id}"),
                                    h.vstr("permissions"),
                                    h.vstr("{username}"),
                                }) },
                                .{ "rename", h.jo(&.{
                                    .{ "param", h.jo(&.{
                                        .{ "groupId", h.vstr("group_id") },
                                    }) },
                                }) },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.jo(&.{
                                    .{ "params", h.ja(&.{
                                        h.jo(&.{
                                            .{ "name", h.vstr("group_id") },
                                            .{ "orig", h.vstr("groupId") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("param") },
                                            .{ "reqd", h.vbool(true) },
                                            .{ "example", h.vstr("0f0f0f0f0f0f0f0f0f0f0f0f") },
                                        }),
                                        h.jo(&.{
                                            .{ "name", h.vstr("username") },
                                            .{ "orig", h.vstr("username") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("param") },
                                            .{ "reqd", h.vbool(true) },
                                        }),
                                    }) },
                                    .{ "query", h.ja(&.{
                                        h.jo(&.{
                                            .{ "name", h.vstr("username") },
                                            .{ "orig", h.vstr("username") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("query") },
                                            .{ "reqd", h.vbool(true) },
                                            .{ "example", h.vstr("example_username") },
                                        }),
                                    }) },
                                }) },
                                .{ "select", h.jo(&.{
                                    .{ "exist", h.ja(&.{
                                        h.vstr("group_id"),
                                        h.vstr("username"),
                                    }) },
                                }) },
                            }),
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("DELETE") },
                                .{ "orig", h.vstr("/contacts/groups/{groupId}") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("contacts") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("groups") },
                                    }),
                                    h.jo(&.{
                                        .{ "var", h.vstr("group_id") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("contacts"),
                                    h.vstr("groups"),
                                    h.vstr("{group_id}"),
                                }) },
                                .{ "rename", h.jo(&.{
                                    .{ "param", h.jo(&.{
                                        .{ "groupId", h.vstr("group_id") },
                                    }) },
                                }) },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.jo(&.{
                                    .{ "params", h.ja(&.{
                                        h.jo(&.{
                                            .{ "name", h.vstr("group_id") },
                                            .{ "orig", h.vstr("groupId") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("param") },
                                            .{ "reqd", h.vbool(true) },
                                            .{ "example", h.vstr("0f0f0f0f0f0f0f0f0f0f0f0f") },
                                        }),
                                    }) },
                                }) },
                                .{ "select", h.jo(&.{
                                    .{ "exist", h.ja(&.{
                                        h.vstr("group_id"),
                                    }) },
                                }) },
                            }),
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("DELETE") },
                                .{ "orig", h.vstr("/contacts/groups/{groupId}/members") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("contacts") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("groups") },
                                    }),
                                    h.jo(&.{
                                        .{ "var", h.vstr("group_id") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("members") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("contacts"),
                                    h.vstr("groups"),
                                    h.vstr("{group_id}"),
                                    h.vstr("members"),
                                }) },
                                .{ "rename", h.jo(&.{
                                    .{ "param", h.jo(&.{
                                        .{ "groupId", h.vstr("group_id") },
                                    }) },
                                }) },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.jo(&.{
                                    .{ "params", h.ja(&.{
                                        h.jo(&.{
                                            .{ "name", h.vstr("group_id") },
                                            .{ "orig", h.vstr("groupId") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("param") },
                                            .{ "reqd", h.vbool(true) },
                                            .{ "example", h.vstr("0f0f0f0f0f0f0f0f0f0f0f0f") },
                                        }),
                                    }) },
                                }) },
                                .{ "select", h.jo(&.{
                                    .{ "exist", h.ja(&.{
                                        h.vstr("group_id"),
                                    }) },
                                }) },
                            }),
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("DELETE") },
                                .{ "orig", h.vstr("/contacts/groups") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("contacts") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("groups") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("contacts"),
                                    h.vstr("groups"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.omap() },
                                .{ "select", h.omap() },
                            }),
                        }) },
                    }) },
                    .{ "update", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("update") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("PUT") },
                                .{ "orig", h.vstr("/contacts/groups/{groupId}/permissions/{username}") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("contacts") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("groups") },
                                    }),
                                    h.jo(&.{
                                        .{ "var", h.vstr("group_id") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("permissions") },
                                    }),
                                    h.jo(&.{
                                        .{ "var", h.vstr("username") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("contacts"),
                                    h.vstr("groups"),
                                    h.vstr("{group_id}"),
                                    h.vstr("permissions"),
                                    h.vstr("{username}"),
                                }) },
                                .{ "rename", h.jo(&.{
                                    .{ "param", h.jo(&.{
                                        .{ "groupId", h.vstr("group_id") },
                                    }) },
                                }) },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.jo(&.{
                                    .{ "params", h.ja(&.{
                                        h.jo(&.{
                                            .{ "name", h.vstr("group_id") },
                                            .{ "orig", h.vstr("groupId") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("param") },
                                            .{ "reqd", h.vbool(true) },
                                            .{ "example", h.vstr("0f0f0f0f0f0f0f0f0f0f0f0f") },
                                        }),
                                        h.jo(&.{
                                            .{ "name", h.vstr("username") },
                                            .{ "orig", h.vstr("username") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("param") },
                                            .{ "reqd", h.vbool(true) },
                                        }),
                                    }) },
                                    .{ "query", h.ja(&.{
                                        h.jo(&.{
                                            .{ "name", h.vstr("username") },
                                            .{ "orig", h.vstr("username") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("query") },
                                            .{ "reqd", h.vbool(true) },
                                            .{ "example", h.vstr("example_username") },
                                        }),
                                    }) },
                                }) },
                                .{ "select", h.jo(&.{
                                    .{ "exist", h.ja(&.{
                                        h.vstr("group_id"),
                                        h.vstr("username"),
                                    }) },
                                }) },
                            }),
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("PUT") },
                                .{ "orig", h.vstr("/contacts/groups/{groupId}/members") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("contacts") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("groups") },
                                    }),
                                    h.jo(&.{
                                        .{ "var", h.vstr("group_id") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("members") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("contacts"),
                                    h.vstr("groups"),
                                    h.vstr("{group_id}"),
                                    h.vstr("members"),
                                }) },
                                .{ "rename", h.jo(&.{
                                    .{ "param", h.jo(&.{
                                        .{ "groupId", h.vstr("group_id") },
                                    }) },
                                }) },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.jo(&.{
                                    .{ "params", h.ja(&.{
                                        h.jo(&.{
                                            .{ "name", h.vstr("group_id") },
                                            .{ "orig", h.vstr("groupId") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("param") },
                                            .{ "reqd", h.vbool(true) },
                                            .{ "example", h.vstr("0f0f0f0f0f0f0f0f0f0f0f0f") },
                                        }),
                                    }) },
                                }) },
                                .{ "select", h.jo(&.{
                                    .{ "exist", h.ja(&.{
                                        h.vstr("group_id"),
                                    }) },
                                }) },
                            }),
                        }) },
                    }) },
                }) },
                .{ "relations", h.jo(&.{
                    .{ "ancestors", h.ja(&.{
                        h.ja(&.{
                            h.vstr("$.main.kit.entity.group"),
                        }),
                        h.ja(&.{
                            h.vstr("$.main.kit.entity.group"),
                        }),
                        h.ja(&.{
                            h.vstr("$.main.kit.entity.group"),
                            h.vstr("$.main.kit.entity.permission"),
                        }),
                    }) },
                }) },
            }) },
            .{ "contactstrash", h.jo(&.{
                .{ "fields", h.olist() },
                .{ "name", h.vstr("contactstrash") },
                .{ "op", h.jo(&.{
                    .{ "remove", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("remove") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("DELETE") },
                                .{ "orig", h.vstr("/contacts/trash") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("contacts") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("trash") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("contacts"),
                                    h.vstr("trash"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.omap() },
                                .{ "select", h.omap() },
                            }),
                        }) },
                    }) },
                    .{ "update", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("update") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("PUT") },
                                .{ "orig", h.vstr("/contacts/trash/restore") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("contacts") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("trash") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("restore") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("contacts"),
                                    h.vstr("trash"),
                                    h.vstr("restore"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.omap() },
                                .{ "select", h.omap() },
                            }),
                        }) },
                    }) },
                }) },
                .{ "relations", h.jo(&.{
                    .{ "ancestors", h.olist() },
                }) },
            }) },
            .{ "field_available", h.jo(&.{
                .{ "fields", h.ja(&.{
                    h.jo(&.{
                        .{ "name", h.vstr("built_in") },
                        .{ "title", h.vstr("Built In") },
                        .{ "type", h.vstr("`$BOOLEAN`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("id") },
                        .{ "title", h.vstr("Id") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "short", h.vstr("Object ID") },
                        .{ "format", h.vstr("oid") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("name") },
                        .{ "title", h.vstr("Name") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("options") },
                        .{ "title", h.vstr("Options") },
                        .{ "type", h.vstr("`$ARRAY`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("type") },
                        .{ "title", h.vstr("Type") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                }) },
                .{ "id", h.jo(&.{
                    .{ "field", h.vstr("id") },
                    .{ "name", h.vstr("id") },
                }) },
                .{ "name", h.vstr("field_available") },
                .{ "op", h.jo(&.{
                    .{ "list", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("list") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("GET") },
                                .{ "orig", h.vstr("/contacts/fields/available") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("contacts") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("fields") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("available") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("contacts"),
                                    h.vstr("fields"),
                                    h.vstr("available"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.omap() },
                                .{ "select", h.omap() },
                            }),
                        }) },
                    }) },
                }) },
                .{ "relations", h.jo(&.{
                    .{ "ancestors", h.olist() },
                }) },
            }) },
            .{ "group", h.jo(&.{
                .{ "fields", h.ja(&.{
                    h.jo(&.{
                        .{ "name", h.vstr("contact_expire_after") },
                        .{ "title", h.vstr("Contact Expire After") },
                        .{ "type", h.vstr("`$INTEGER`") },
                        .{ "req", h.vbool(true) },
                        .{ "short", h.vstr("Contact expire after days") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("contacts_count") },
                        .{ "title", h.vstr("Contacts Count") },
                        .{ "type", h.vstr("`$INTEGER`") },
                        .{ "req", h.vbool(true) },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("created_by") },
                        .{ "title", h.vstr("Created By") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "req", h.vbool(true) },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("date_created") },
                        .{ "title", h.vstr("Date Created") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "req", h.vbool(true) },
                        .{ "format", h.vstr("date-time") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("date_updated") },
                        .{ "title", h.vstr("Date Updated") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "req", h.vbool(true) },
                        .{ "format", h.vstr("date-time") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("description") },
                        .{ "title", h.vstr("Description") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "req", h.vbool(true) },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("id") },
                        .{ "title", h.vstr("Id") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "req", h.vbool(true) },
                        .{ "short", h.vstr("Object ID") },
                        .{ "format", h.vstr("oid") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("idx") },
                        .{ "title", h.vstr("Idx") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "short", h.vstr("User provided resource id") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("name") },
                        .{ "title", h.vstr("Name") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "req", h.vbool(true) },
                        .{ "short", h.vstr("Group name") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("permissions") },
                        .{ "title", h.vstr("Permissions") },
                        .{ "type", h.vstr("`$ARRAY`") },
                    }),
                }) },
                .{ "id", h.jo(&.{
                    .{ "field", h.vstr("id") },
                    .{ "name", h.vstr("id") },
                }) },
                .{ "name", h.vstr("group") },
                .{ "op", h.jo(&.{
                    .{ "load", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("load") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("GET") },
                                .{ "orig", h.vstr("/contacts/groups/{groupId}") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("contacts") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("groups") },
                                    }),
                                    h.jo(&.{
                                        .{ "var", h.vstr("id") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("contacts"),
                                    h.vstr("groups"),
                                    h.vstr("{id}"),
                                }) },
                                .{ "rename", h.jo(&.{
                                    .{ "param", h.jo(&.{
                                        .{ "groupId", h.vstr("id") },
                                    }) },
                                }) },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.jo(&.{
                                    .{ "params", h.ja(&.{
                                        h.jo(&.{
                                            .{ "name", h.vstr("id") },
                                            .{ "orig", h.vstr("groupId") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("param") },
                                            .{ "reqd", h.vbool(true) },
                                            .{ "example", h.vstr("0f0f0f0f0f0f0f0f0f0f0f0f") },
                                        }),
                                    }) },
                                }) },
                                .{ "select", h.jo(&.{
                                    .{ "exist", h.ja(&.{
                                        h.vstr("id"),
                                    }) },
                                }) },
                            }),
                        }) },
                    }) },
                    .{ "update", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("update") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("PUT") },
                                .{ "orig", h.vstr("/contacts/groups/{groupId}") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("contacts") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("groups") },
                                    }),
                                    h.jo(&.{
                                        .{ "var", h.vstr("id") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("contacts"),
                                    h.vstr("groups"),
                                    h.vstr("{id}"),
                                }) },
                                .{ "rename", h.jo(&.{
                                    .{ "param", h.jo(&.{
                                        .{ "groupId", h.vstr("id") },
                                    }) },
                                }) },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.jo(&.{
                                    .{ "params", h.ja(&.{
                                        h.jo(&.{
                                            .{ "name", h.vstr("id") },
                                            .{ "orig", h.vstr("groupId") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("param") },
                                            .{ "reqd", h.vbool(true) },
                                            .{ "example", h.vstr("0f0f0f0f0f0f0f0f0f0f0f0f") },
                                        }),
                                    }) },
                                }) },
                                .{ "select", h.jo(&.{
                                    .{ "exist", h.ja(&.{
                                        h.vstr("id"),
                                    }) },
                                }) },
                            }),
                        }) },
                    }) },
                }) },
                .{ "relations", h.jo(&.{
                    .{ "ancestors", h.olist() },
                }) },
            }) },
            .{ "mfa_code", h.jo(&.{
                .{ "fields", h.ja(&.{
                    h.jo(&.{
                        .{ "name", h.vstr("content") },
                        .{ "title", h.vstr("Content") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "short", h.vstr("Custom content that must contain placeholder [%code%]") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("fast") },
                        .{ "title", h.vstr("Fast") },
                        .{ "type", h.vstr("`$ANY`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("from") },
                        .{ "title", h.vstr("From") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "short", h.vstr("Sendername") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("phone_number") },
                        .{ "title", h.vstr("Phone Number") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "req", h.vbool(true) },
                    }),
                }) },
                .{ "name", h.vstr("mfa_code") },
                .{ "op", h.jo(&.{
                    .{ "create", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("create") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("POST") },
                                .{ "orig", h.vstr("/mfa/codes") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("mfa") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("codes") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("mfa"),
                                    h.vstr("codes"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.omap() },
                                .{ "select", h.omap() },
                            }),
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("POST") },
                                .{ "orig", h.vstr("/mfa/codes/verifications") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("mfa") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("codes") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("verifications") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("mfa"),
                                    h.vstr("codes"),
                                    h.vstr("verifications"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.omap() },
                                .{ "select", h.jo(&.{
                                    .{ "$action", h.vstr("verification") },
                                }) },
                            }),
                        }) },
                    }) },
                }) },
                .{ "relations", h.jo(&.{
                    .{ "ancestors", h.olist() },
                }) },
            }) },
            .{ "opt_out", h.jo(&.{
                .{ "fields", h.ja(&.{
                    h.jo(&.{
                        .{ "name", h.vstr("date") },
                        .{ "title", h.vstr("Date") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "format", h.vstr("date-time") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("id") },
                        .{ "title", h.vstr("Id") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("links") },
                        .{ "title", h.vstr("Links") },
                        .{ "type", h.vstr("`$ARRAY`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("phoneNumber") },
                        .{ "title", h.vstr("Phone Number") },
                        .{ "type", h.vstr("`$INTEGER`") },
                    }),
                }) },
                .{ "id", h.jo(&.{
                    .{ "field", h.vstr("id") },
                    .{ "name", h.vstr("id") },
                }) },
                .{ "name", h.vstr("opt_out") },
                .{ "op", h.jo(&.{
                    .{ "list", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("list") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("GET") },
                                .{ "orig", h.vstr("/opt_outs") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("opt_outs") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("opt_outs"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body.collection`") },
                                }) },
                                .{ "args", h.jo(&.{
                                    .{ "header", h.ja(&.{
                                        h.jo(&.{
                                            .{ "name", h.vstr("accept") },
                                            .{ "orig", h.vstr("Accept") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("header") },
                                            .{ "example", h.vstr("application/json") },
                                        }),
                                        h.jo(&.{
                                            .{ "name", h.vstr("x_async") },
                                            .{ "orig", h.vstr("x-async") },
                                            .{ "type", h.vstr("`$BOOLEAN`") },
                                            .{ "kind", h.vstr("header") },
                                            .{ "example", h.vbool(false) },
                                        }),
                                    }) },
                                    .{ "query", h.ja(&.{
                                        h.jo(&.{
                                            .{ "name", h.vstr("limit") },
                                            .{ "orig", h.vstr("limit") },
                                            .{ "type", h.vstr("`$INTEGER`") },
                                            .{ "kind", h.vstr("query") },
                                            .{ "example", h.vnum(5) },
                                        }),
                                        h.jo(&.{
                                            .{ "name", h.vstr("offset") },
                                            .{ "orig", h.vstr("offset") },
                                            .{ "type", h.vstr("`$INTEGER`") },
                                            .{ "kind", h.vstr("query") },
                                            .{ "example", h.vnum(0) },
                                        }),
                                        h.jo(&.{
                                            .{ "name", h.vstr("phone_number") },
                                            .{ "orig", h.vstr("phone_number") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("query") },
                                        }),
                                    }) },
                                }) },
                                .{ "select", h.jo(&.{
                                    .{ "exist", h.ja(&.{
                                        h.vstr("accept"),
                                        h.vstr("limit"),
                                        h.vstr("offset"),
                                        h.vstr("phone_number"),
                                        h.vstr("x_async"),
                                    }) },
                                }) },
                            }),
                        }) },
                    }) },
                    .{ "remove", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("remove") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("DELETE") },
                                .{ "orig", h.vstr("/opt_outs/{optOutId}") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("opt_outs") },
                                    }),
                                    h.jo(&.{
                                        .{ "var", h.vstr("id") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("opt_outs"),
                                    h.vstr("{id}"),
                                }) },
                                .{ "rename", h.jo(&.{
                                    .{ "param", h.jo(&.{
                                        .{ "optOutId", h.vstr("id") },
                                    }) },
                                }) },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.jo(&.{
                                    .{ "params", h.ja(&.{
                                        h.jo(&.{
                                            .{ "name", h.vstr("id") },
                                            .{ "orig", h.vstr("optOutId") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("param") },
                                            .{ "reqd", h.vbool(true) },
                                        }),
                                    }) },
                                }) },
                                .{ "select", h.jo(&.{
                                    .{ "exist", h.ja(&.{
                                        h.vstr("id"),
                                    }) },
                                }) },
                            }),
                        }) },
                    }) },
                }) },
                .{ "relations", h.jo(&.{
                    .{ "ancestors", h.olist() },
                }) },
            }) },
            .{ "opt_out_setting", h.jo(&.{
                .{ "fields", h.ja(&.{
                    h.jo(&.{
                        .{ "name", h.vstr("brand") },
                        .{ "title", h.vstr("Brand") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                }) },
                .{ "name", h.vstr("opt_out_setting") },
                .{ "op", h.jo(&.{
                    .{ "load", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("load") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("GET") },
                                .{ "orig", h.vstr("/opt_outs/settings") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("opt_outs") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("settings") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("opt_outs"),
                                    h.vstr("settings"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.omap() },
                                .{ "select", h.omap() },
                            }),
                        }) },
                    }) },
                    .{ "update", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("update") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("PUT") },
                                .{ "orig", h.vstr("/opt_outs/settings") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("opt_outs") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("settings") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("opt_outs"),
                                    h.vstr("settings"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.omap() },
                                .{ "select", h.omap() },
                            }),
                        }) },
                    }) },
                }) },
                .{ "relations", h.jo(&.{
                    .{ "ancestors", h.olist() },
                }) },
            }) },
            .{ "permission", h.jo(&.{
                .{ "fields", h.ja(&.{
                    h.jo(&.{
                        .{ "name", h.vstr("group_id") },
                        .{ "title", h.vstr("Group Id") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "req", h.vbool(true) },
                        .{ "short", h.vstr("Object ID") },
                        .{ "format", h.vstr("oid") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("id") },
                        .{ "title", h.vstr("Id") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("read") },
                        .{ "title", h.vstr("Read") },
                        .{ "type", h.vstr("`$BOOLEAN`") },
                        .{ "req", h.vbool(true) },
                        .{ "short", h.vstr("Has read permission") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("send") },
                        .{ "title", h.vstr("Send") },
                        .{ "type", h.vstr("`$BOOLEAN`") },
                        .{ "req", h.vbool(true) },
                        .{ "short", h.vstr("Has send permission") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("username") },
                        .{ "title", h.vstr("Username") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "req", h.vbool(true) },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("write") },
                        .{ "title", h.vstr("Write") },
                        .{ "type", h.vstr("`$BOOLEAN`") },
                        .{ "req", h.vbool(true) },
                        .{ "short", h.vstr("Has write permission") },
                    }),
                }) },
                .{ "id", h.jo(&.{
                    .{ "field", h.vstr("id") },
                    .{ "name", h.vstr("id") },
                }) },
                .{ "name", h.vstr("permission") },
                .{ "op", h.jo(&.{
                    .{ "create", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("create") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("POST") },
                                .{ "orig", h.vstr("/contacts/groups/{groupId}/permissions") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("contacts") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("groups") },
                                    }),
                                    h.jo(&.{
                                        .{ "var", h.vstr("group_id") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("permissions") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("contacts"),
                                    h.vstr("groups"),
                                    h.vstr("{group_id}"),
                                    h.vstr("permissions"),
                                }) },
                                .{ "rename", h.jo(&.{
                                    .{ "param", h.jo(&.{
                                        .{ "groupId", h.vstr("group_id") },
                                    }) },
                                }) },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.jo(&.{
                                    .{ "params", h.ja(&.{
                                        h.jo(&.{
                                            .{ "name", h.vstr("group_id") },
                                            .{ "orig", h.vstr("groupId") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("param") },
                                            .{ "reqd", h.vbool(true) },
                                            .{ "example", h.vstr("0f0f0f0f0f0f0f0f0f0f0f0f") },
                                        }),
                                    }) },
                                }) },
                                .{ "select", h.jo(&.{
                                    .{ "exist", h.ja(&.{
                                        h.vstr("group_id"),
                                    }) },
                                }) },
                            }),
                        }) },
                    }) },
                    .{ "load", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("load") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("GET") },
                                .{ "orig", h.vstr("/contacts/groups/{groupId}/permissions/{username}") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("contacts") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("groups") },
                                    }),
                                    h.jo(&.{
                                        .{ "var", h.vstr("group_id") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("permissions") },
                                    }),
                                    h.jo(&.{
                                        .{ "var", h.vstr("id") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("contacts"),
                                    h.vstr("groups"),
                                    h.vstr("{group_id}"),
                                    h.vstr("permissions"),
                                    h.vstr("{id}"),
                                }) },
                                .{ "rename", h.jo(&.{
                                    .{ "param", h.jo(&.{
                                        .{ "groupId", h.vstr("group_id") },
                                        .{ "username", h.vstr("id") },
                                    }) },
                                }) },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.jo(&.{
                                    .{ "params", h.ja(&.{
                                        h.jo(&.{
                                            .{ "name", h.vstr("group_id") },
                                            .{ "orig", h.vstr("groupId") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("param") },
                                            .{ "reqd", h.vbool(true) },
                                            .{ "example", h.vstr("0f0f0f0f0f0f0f0f0f0f0f0f") },
                                        }),
                                        h.jo(&.{
                                            .{ "name", h.vstr("id") },
                                            .{ "orig", h.vstr("username") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("param") },
                                            .{ "reqd", h.vbool(true) },
                                        }),
                                    }) },
                                    .{ "query", h.ja(&.{
                                        h.jo(&.{
                                            .{ "name", h.vstr("username") },
                                            .{ "orig", h.vstr("username") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("query") },
                                            .{ "reqd", h.vbool(true) },
                                            .{ "example", h.vstr("example_username") },
                                        }),
                                    }) },
                                }) },
                                .{ "select", h.jo(&.{
                                    .{ "exist", h.ja(&.{
                                        h.vstr("group_id"),
                                        h.vstr("id"),
                                        h.vstr("username"),
                                    }) },
                                }) },
                            }),
                        }) },
                    }) },
                }) },
                .{ "relations", h.jo(&.{
                    .{ "ancestors", h.ja(&.{
                        h.ja(&.{
                            h.vstr("$.main.kit.entity.group"),
                        }),
                    }) },
                }) },
            }) },
            .{ "ping", h.jo(&.{
                .{ "fields", h.ja(&.{
                    h.jo(&.{
                        .{ "name", h.vstr("authorized") },
                        .{ "title", h.vstr("Authorized") },
                        .{ "type", h.vstr("`$BOOLEAN`") },
                        .{ "req", h.vbool(true) },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("unavailable") },
                        .{ "title", h.vstr("Unavailable") },
                        .{ "type", h.vstr("`$ARRAY`") },
                        .{ "req", h.vbool(true) },
                    }),
                }) },
                .{ "name", h.vstr("ping") },
                .{ "op", h.jo(&.{
                    .{ "list", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("list") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("GET") },
                                .{ "orig", h.vstr("/ping") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("ping") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("ping"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body.unavailable`") },
                                }) },
                                .{ "args", h.omap() },
                                .{ "select", h.omap() },
                            }),
                        }) },
                    }) },
                }) },
                .{ "relations", h.jo(&.{
                    .{ "ancestors", h.olist() },
                }) },
            }) },
            .{ "profile", h.jo(&.{
                .{ "fields", h.ja(&.{
                    h.jo(&.{
                        .{ "name", h.vstr("email") },
                        .{ "title", h.vstr("Email") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "req", h.vbool(true) },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("name") },
                        .{ "title", h.vstr("Name") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "req", h.vbool(true) },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("payment_type") },
                        .{ "title", h.vstr("Payment Type") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "req", h.vbool(true) },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("phone_number") },
                        .{ "title", h.vstr("Phone Number") },
                        .{ "type", h.vstr("`$INTEGER`") },
                        .{ "req", h.vbool(true) },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("points") },
                        .{ "title", h.vstr("Points") },
                        .{ "type", h.vstr("`$NUMBER`") },
                        .{ "format", h.vstr("float") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("user_type") },
                        .{ "title", h.vstr("User Type") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "req", h.vbool(true) },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("username") },
                        .{ "title", h.vstr("Username") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "req", h.vbool(true) },
                    }),
                }) },
                .{ "name", h.vstr("profile") },
                .{ "op", h.jo(&.{
                    .{ "list", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("list") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("GET") },
                                .{ "orig", h.vstr("/profile/prices") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("profile") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("prices") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("profile"),
                                    h.vstr("prices"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body.collection`") },
                                }) },
                                .{ "args", h.jo(&.{
                                    .{ "query", h.ja(&.{
                                        h.jo(&.{
                                            .{ "name", h.vstr("type") },
                                            .{ "orig", h.vstr("type") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("query") },
                                            .{ "example", h.vstr("eco") },
                                        }),
                                    }) },
                                }) },
                                .{ "select", h.jo(&.{
                                    .{ "$action", h.vstr("price") },
                                    .{ "exist", h.ja(&.{
                                        h.vstr("type"),
                                    }) },
                                }) },
                            }),
                        }) },
                    }) },
                    .{ "load", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("load") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("GET") },
                                .{ "orig", h.vstr("/profile") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("profile") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("profile"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.omap() },
                                .{ "select", h.omap() },
                            }),
                        }) },
                    }) },
                }) },
                .{ "relations", h.jo(&.{
                    .{ "ancestors", h.olist() },
                }) },
            }) },
            .{ "rcs", h.jo(&.{
                .{ "fields", h.olist() },
                .{ "name", h.vstr("rcs") },
                .{ "op", h.jo(&.{
                    .{ "list", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("list") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("GET") },
                                .{ "orig", h.vstr("/rcs/messages") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("rcs") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("messages") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("rcs"),
                                    h.vstr("messages"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body.collection`") },
                                }) },
                                .{ "args", h.omap() },
                                .{ "select", h.jo(&.{
                                    .{ "$action", h.vstr("message") },
                                }) },
                            }),
                        }) },
                    }) },
                }) },
                .{ "relations", h.jo(&.{
                    .{ "ancestors", h.olist() },
                }) },
            }) },
            .{ "sendername", h.jo(&.{
                .{ "fields", h.ja(&.{
                    h.jo(&.{
                        .{ "name", h.vstr("created_at") },
                        .{ "title", h.vstr("Created At") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "format", h.vstr("date-time") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("id") },
                        .{ "title", h.vstr("Id") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("is_default") },
                        .{ "title", h.vstr("Is Default") },
                        .{ "type", h.vstr("`$BOOLEAN`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("sender") },
                        .{ "title", h.vstr("Sender") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "short", h.vstr("Sendername") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("status") },
                        .{ "title", h.vstr("Status") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                }) },
                .{ "id", h.jo(&.{
                    .{ "field", h.vstr("id") },
                    .{ "name", h.vstr("id") },
                }) },
                .{ "name", h.vstr("sendername") },
                .{ "op", h.jo(&.{
                    .{ "create", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("create") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("POST") },
                                .{ "orig", h.vstr("/sms/sendernames") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("sms") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("sendernames") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("sms"),
                                    h.vstr("sendernames"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.omap() },
                                .{ "select", h.omap() },
                            }),
                        }) },
                    }) },
                    .{ "list", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("list") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("GET") },
                                .{ "orig", h.vstr("/sms/sendernames") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("sms") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("sendernames") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("sms"),
                                    h.vstr("sendernames"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body.collection`") },
                                }) },
                                .{ "args", h.omap() },
                                .{ "select", h.omap() },
                            }),
                        }) },
                    }) },
                    .{ "load", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("load") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("GET") },
                                .{ "orig", h.vstr("/sms/sendernames/{sender}") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("sms") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("sendernames") },
                                    }),
                                    h.jo(&.{
                                        .{ "var", h.vstr("id") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("sms"),
                                    h.vstr("sendernames"),
                                    h.vstr("{id}"),
                                }) },
                                .{ "rename", h.jo(&.{
                                    .{ "param", h.jo(&.{
                                        .{ "sender", h.vstr("id") },
                                    }) },
                                }) },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.jo(&.{
                                    .{ "params", h.ja(&.{
                                        h.jo(&.{
                                            .{ "name", h.vstr("id") },
                                            .{ "orig", h.vstr("sender") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("param") },
                                            .{ "reqd", h.vbool(true) },
                                        }),
                                    }) },
                                }) },
                                .{ "select", h.jo(&.{
                                    .{ "exist", h.ja(&.{
                                        h.vstr("id"),
                                    }) },
                                }) },
                            }),
                        }) },
                    }) },
                }) },
                .{ "relations", h.jo(&.{
                    .{ "ancestors", h.olist() },
                }) },
            }) },
            .{ "sendername_statement", h.jo(&.{
                .{ "fields", h.ja(&.{
                    h.jo(&.{
                        .{ "name", h.vstr("content") },
                        .{ "title", h.vstr("Content") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("statements") },
                        .{ "title", h.vstr("Statements") },
                        .{ "type", h.vstr("`$ARRAY`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("title") },
                        .{ "title", h.vstr("Title") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                }) },
                .{ "name", h.vstr("sendername_statement") },
                .{ "op", h.jo(&.{
                    .{ "list", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("list") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("GET") },
                                .{ "orig", h.vstr("/sms/sendernames/statement") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("sms") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("sendernames") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("statement") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("sms"),
                                    h.vstr("sendernames"),
                                    h.vstr("statement"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body.sections`") },
                                }) },
                                .{ "args", h.omap() },
                                .{ "select", h.omap() },
                            }),
                        }) },
                    }) },
                }) },
                .{ "relations", h.jo(&.{
                    .{ "ancestors", h.olist() },
                }) },
            }) },
            .{ "sent_rcs_message", h.jo(&.{
                .{ "fields", h.ja(&.{
                    h.jo(&.{
                        .{ "name", h.vstr("content") },
                        .{ "title", h.vstr("Content") },
                        .{ "type", h.vstr("`$OBJECT`") },
                        .{ "short", h.vstr("RCS message content in RCS JSON format.") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("phone_number") },
                        .{ "title", h.vstr("Phone Number") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "req", h.vbool(true) },
                        .{ "short", h.vstr("Recipient phone number (e.g.") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("sender") },
                        .{ "title", h.vstr("Sender") },
                        .{ "type", h.vstr("`$ANY`") },
                        .{ "req", h.vbool(true) },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("text") },
                        .{ "title", h.vstr("Text") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "short", h.vstr("Plain text message content.") },
                    }),
                }) },
                .{ "name", h.vstr("sent_rcs_message") },
                .{ "op", h.jo(&.{
                    .{ "create", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("create") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("POST") },
                                .{ "orig", h.vstr("/rcs/messages") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("rcs") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("messages") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("rcs"),
                                    h.vstr("messages"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.omap() },
                                .{ "select", h.omap() },
                            }),
                        }) },
                    }) },
                }) },
                .{ "relations", h.jo(&.{
                    .{ "ancestors", h.olist() },
                }) },
            }) },
            .{ "shipment_country_volume", h.jo(&.{
                .{ "fields", h.ja(&.{
                    h.jo(&.{
                        .{ "name", h.vstr("country_code") },
                        .{ "title", h.vstr("Country Code") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("country_limit") },
                        .{ "title", h.vstr("Country Limit") },
                        .{ "type", h.vstr("`$INTEGER`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("country_name") },
                        .{ "title", h.vstr("Country Name") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("usage") },
                        .{ "title", h.vstr("Usage") },
                        .{ "type", h.vstr("`$INTEGER`") },
                    }),
                }) },
                .{ "name", h.vstr("shipment_country_volume") },
                .{ "op", h.jo(&.{
                    .{ "list", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("list") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("GET") },
                                .{ "orig", h.vstr("/shipment/country_volumes") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("shipment") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("country_volumes") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("shipment"),
                                    h.vstr("country_volumes"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body.collection`") },
                                }) },
                                .{ "args", h.jo(&.{
                                    .{ "header", h.ja(&.{
                                        h.jo(&.{
                                            .{ "name", h.vstr("accept") },
                                            .{ "orig", h.vstr("Accept") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("header") },
                                            .{ "example", h.vstr("application/json") },
                                        }),
                                    }) },
                                    .{ "query", h.ja(&.{
                                        h.jo(&.{
                                            .{ "name", h.vstr("month") },
                                            .{ "orig", h.vstr("month") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("query") },
                                        }),
                                        h.jo(&.{
                                            .{ "name", h.vstr("year") },
                                            .{ "orig", h.vstr("year") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("query") },
                                        }),
                                    }) },
                                }) },
                                .{ "select", h.jo(&.{
                                    .{ "exist", h.ja(&.{
                                        h.vstr("accept"),
                                        h.vstr("month"),
                                        h.vstr("year"),
                                    }) },
                                }) },
                            }),
                        }) },
                    }) },
                }) },
                .{ "relations", h.jo(&.{
                    .{ "ancestors", h.olist() },
                }) },
            }) },
            .{ "short_url", h.jo(&.{
                .{ "fields", h.ja(&.{
                    h.jo(&.{
                        .{ "name", h.vstr("description") },
                        .{ "title", h.vstr("Description") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("expire") },
                        .{ "title", h.vstr("Expire") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "format", h.vstr("date-time") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("filename") },
                        .{ "title", h.vstr("Filename") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("hits") },
                        .{ "title", h.vstr("Hits") },
                        .{ "type", h.vstr("`$INTEGER`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("hits_unique") },
                        .{ "title", h.vstr("Hits Unique") },
                        .{ "type", h.vstr("`$INTEGER`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("id") },
                        .{ "title", h.vstr("Id") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("name") },
                        .{ "title", h.vstr("Name") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("short_url") },
                        .{ "title", h.vstr("Short Url") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "short", h.vstr("WHATWG URL compliant") },
                        .{ "format", h.vstr("url") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("type") },
                        .{ "title", h.vstr("Type") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("url") },
                        .{ "title", h.vstr("Url") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "short", h.vstr("WHATWG URL compliant") },
                        .{ "format", h.vstr("url") },
                    }),
                }) },
                .{ "id", h.jo(&.{
                    .{ "field", h.vstr("id") },
                    .{ "name", h.vstr("id") },
                }) },
                .{ "name", h.vstr("short_url") },
                .{ "op", h.jo(&.{
                    .{ "create", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("create") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("POST") },
                                .{ "orig", h.vstr("/short_url/links") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("short_url") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("links") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("short_url"),
                                    h.vstr("links"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.omap() },
                                .{ "select", h.jo(&.{
                                    .{ "$action", h.vstr("link") },
                                }) },
                            }),
                        }) },
                    }) },
                    .{ "list", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("list") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("GET") },
                                .{ "orig", h.vstr("/short_url/links") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("short_url") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("links") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("short_url"),
                                    h.vstr("links"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body.collection`") },
                                }) },
                                .{ "args", h.omap() },
                                .{ "select", h.jo(&.{
                                    .{ "$action", h.vstr("link") },
                                }) },
                            }),
                        }) },
                    }) },
                    .{ "load", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("load") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("GET") },
                                .{ "orig", h.vstr("/short_url/links/{id}") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("short_url") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("links") },
                                    }),
                                    h.jo(&.{
                                        .{ "var", h.vstr("id") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("short_url"),
                                    h.vstr("links"),
                                    h.vstr("{id}"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.jo(&.{
                                    .{ "params", h.ja(&.{
                                        h.jo(&.{
                                            .{ "name", h.vstr("id") },
                                            .{ "orig", h.vstr("id") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("param") },
                                            .{ "reqd", h.vbool(true) },
                                            .{ "example", h.vstr("123") },
                                        }),
                                    }) },
                                }) },
                                .{ "select", h.jo(&.{
                                    .{ "exist", h.ja(&.{
                                        h.vstr("id"),
                                    }) },
                                }) },
                            }),
                        }) },
                    }) },
                    .{ "remove", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("remove") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("DELETE") },
                                .{ "orig", h.vstr("/short_url/links/{id}") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("short_url") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("links") },
                                    }),
                                    h.jo(&.{
                                        .{ "var", h.vstr("id") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("short_url"),
                                    h.vstr("links"),
                                    h.vstr("{id}"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.jo(&.{
                                    .{ "params", h.ja(&.{
                                        h.jo(&.{
                                            .{ "name", h.vstr("id") },
                                            .{ "orig", h.vstr("id") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("param") },
                                            .{ "reqd", h.vbool(true) },
                                            .{ "example", h.vstr("123") },
                                        }),
                                    }) },
                                }) },
                                .{ "select", h.jo(&.{
                                    .{ "exist", h.ja(&.{
                                        h.vstr("id"),
                                    }) },
                                }) },
                            }),
                        }) },
                    }) },
                    .{ "update", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("update") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("PUT") },
                                .{ "orig", h.vstr("/short_url/links/{id}") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("short_url") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("links") },
                                    }),
                                    h.jo(&.{
                                        .{ "var", h.vstr("id") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("short_url"),
                                    h.vstr("links"),
                                    h.vstr("{id}"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.jo(&.{
                                    .{ "params", h.ja(&.{
                                        h.jo(&.{
                                            .{ "name", h.vstr("id") },
                                            .{ "orig", h.vstr("id") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("param") },
                                            .{ "reqd", h.vbool(true) },
                                            .{ "example", h.vstr("123") },
                                        }),
                                    }) },
                                }) },
                                .{ "select", h.jo(&.{
                                    .{ "exist", h.ja(&.{
                                        h.vstr("id"),
                                    }) },
                                }) },
                            }),
                        }) },
                    }) },
                }) },
                .{ "relations", h.jo(&.{
                    .{ "ancestors", h.olist() },
                }) },
            }) },
            .{ "smsdo", h.jo(&.{
                .{ "fields", h.ja(&.{
                    h.jo(&.{
                        .{ "name", h.vstr("allow_duplicates") },
                        .{ "title", h.vstr("Allow Duplicates") },
                        .{ "type", h.vstr("`$INTEGER`") },
                        .{ "short", h.vstr("When parameter allow_duplicates is set to \"1\" allows to send message to duplicated numbers in one request (useful i.e.") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("check_idx") },
                        .{ "title", h.vstr("Check Idx") },
                        .{ "type", h.vstr("`$ANY`") },
                        .{ "short", h.vstr("When parameter check_idx is set to „1” prevents from sending more than one message with the same idx in last 24h.") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("date") },
                        .{ "title", h.vstr("Date") },
                        .{ "type", h.vstr("`$ANY`") },
                        .{ "short", h.vstr("Date in UNIX timestamp (&date=1287734110) or in ISO 8601 (&date=2012-05-10T08:40:27+00:00) when message will be sent (&date=1287734110).") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("date_validate") },
                        .{ "title", h.vstr("Date Validate") },
                        .{ "type", h.vstr("`$INTEGER`") },
                        .{ "short", h.vstr("When parameter date_validate is set to \"1\" checks if date if given in proper format.") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("details") },
                        .{ "title", h.vstr("Details") },
                        .{ "type", h.vstr("`$ANY`") },
                        .{ "short", h.vstr("When details parameter is set to \"1\" more details in response will be displayed (message length and sms count).") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("encoding") },
                        .{ "title", h.vstr("Encoding") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "short", h.vstr("This parameter describes the encoding of the message text.") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("expiration_date") },
                        .{ "title", h.vstr("Expiration Date") },
                        .{ "type", h.vstr("`$ANY`") },
                        .{ "short", h.vstr("Message expiration date (in UNIX timestamp or in ISO 8601) is a date after which message won't be delivered if it wasn't delivered yet.") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("fallback") },
                        .{ "title", h.vstr("Fallback") },
                        .{ "type", h.vstr("`$ARRAY`") },
                        .{ "short", h.vstr("Enable fallback in case sms sending fails") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("fast") },
                        .{ "title", h.vstr("Fast") },
                        .{ "type", h.vstr("`$INTEGER`") },
                        .{ "short", h.vstr("Setting this parameter to „1” will result in sending message with the highest priority which ensures the quickest possible time of delivery.") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("flash") },
                        .{ "title", h.vstr("Flash") },
                        .{ "type", h.vstr("`$INTEGER`") },
                        .{ "short", h.vstr("Sending a message in flash mode can be activated by setting this parameter to \"1\".") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("format") },
                        .{ "title", h.vstr("Format") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "short", h.vstr("Parameter &format=json causes, that response is sending in JSON format.") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("from") },
                        .{ "title", h.vstr("From") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "short", h.vstr("Name of the sender.") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("group") },
                        .{ "title", h.vstr("Group") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "short", h.vstr("Name of the group from the contacts database to which message should be sent to.") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("idx") },
                        .{ "title", h.vstr("Idx") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "short", h.vstr("Optional custom value sent with SMS and sent back in CALLBACK.") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("max_parts") },
                        .{ "title", h.vstr("Max Parts") },
                        .{ "type", h.vstr("`$INTEGER`") },
                        .{ "short", h.vstr("Defines maximum message parts allowed, maximum value allowed is 6.") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("message") },
                        .{ "title", h.vstr("Message") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "short", h.vstr("The message text.") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("normalize") },
                        .{ "title", h.vstr("Normalize") },
                        .{ "type", h.vstr("`$INTEGER`") },
                        .{ "short", h.vstr("When parameter normalize is set to „1” special chars in message will be replaced with their equivalents (ê-e, ñ-n, ý-y ...).") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("notify_url") },
                        .{ "title", h.vstr("Notify Url") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "short", h.vstr("Parameter allows to set CALLBACK URL for message from request.") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("test") },
                        .{ "title", h.vstr("Test") },
                        .{ "type", h.vstr("`$ANY`") },
                        .{ "short", h.vstr("When parameter test is set to \"1\" message won't be sent but response will be displayed, there is no charge for such test messages.") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("time_restriction") },
                        .{ "title", h.vstr("Time Restriction") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "short", h.vstr("Sets the behavior when you try to ship in hours / dates that do not match the settings in your account.") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("to") },
                        .{ "title", h.vstr("To") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "short", h.vstr("Recipients' mobile phone numbers (i.e.") },
                    }),
                }) },
                .{ "name", h.vstr("smsdo") },
                .{ "op", h.jo(&.{
                    .{ "create", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("create") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("POST") },
                                .{ "orig", h.vstr("/sms.do") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("sms.do") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("sms.do"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.omap() },
                                .{ "select", h.omap() },
                            }),
                        }) },
                    }) },
                }) },
                .{ "relations", h.jo(&.{
                    .{ "ancestors", h.olist() },
                }) },
            }) },
            .{ "smssendername", h.jo(&.{
                .{ "fields", h.olist() },
                .{ "name", h.vstr("smssendername") },
                .{ "op", h.jo(&.{
                    .{ "create", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("create") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("POST") },
                                .{ "orig", h.vstr("/sms/sendernames/{sender}/commands/make_default") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("sms") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("sendernames") },
                                    }),
                                    h.jo(&.{
                                        .{ "var", h.vstr("sendername_id") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("commands") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("make_default") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("sms"),
                                    h.vstr("sendernames"),
                                    h.vstr("{sendername_id}"),
                                    h.vstr("commands"),
                                    h.vstr("make_default"),
                                }) },
                                .{ "rename", h.jo(&.{
                                    .{ "param", h.jo(&.{
                                        .{ "sender", h.vstr("sendername_id") },
                                    }) },
                                }) },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.jo(&.{
                                    .{ "params", h.ja(&.{
                                        h.jo(&.{
                                            .{ "name", h.vstr("sendername_id") },
                                            .{ "orig", h.vstr("sender") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("param") },
                                            .{ "reqd", h.vbool(true) },
                                        }),
                                    }) },
                                }) },
                                .{ "select", h.jo(&.{
                                    .{ "exist", h.ja(&.{
                                        h.vstr("sendername_id"),
                                    }) },
                                }) },
                            }),
                        }) },
                    }) },
                    .{ "remove", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("remove") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("DELETE") },
                                .{ "orig", h.vstr("/sms/sendernames/{sender}") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("sms") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("sendernames") },
                                    }),
                                    h.jo(&.{
                                        .{ "var", h.vstr("sender") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("sms"),
                                    h.vstr("sendernames"),
                                    h.vstr("{sender}"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.jo(&.{
                                    .{ "params", h.ja(&.{
                                        h.jo(&.{
                                            .{ "name", h.vstr("sender") },
                                            .{ "orig", h.vstr("sender") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("param") },
                                            .{ "reqd", h.vbool(true) },
                                        }),
                                    }) },
                                }) },
                                .{ "select", h.jo(&.{
                                    .{ "exist", h.ja(&.{
                                        h.vstr("sender"),
                                    }) },
                                }) },
                            }),
                        }) },
                    }) },
                }) },
                .{ "relations", h.jo(&.{
                    .{ "ancestors", h.ja(&.{
                        h.ja(&.{
                            h.vstr("$.main.kit.entity.sendername"),
                        }),
                    }) },
                }) },
            }) },
            .{ "smstemplate", h.jo(&.{
                .{ "fields", h.ja(&.{
                    h.jo(&.{
                        .{ "name", h.vstr("id") },
                        .{ "title", h.vstr("Id") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                }) },
                .{ "id", h.jo(&.{
                    .{ "field", h.vstr("id") },
                    .{ "name", h.vstr("id") },
                }) },
                .{ "name", h.vstr("smstemplate") },
                .{ "op", h.jo(&.{
                    .{ "remove", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("remove") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("DELETE") },
                                .{ "orig", h.vstr("/sms/templates/{id}") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("sms") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("templates") },
                                    }),
                                    h.jo(&.{
                                        .{ "var", h.vstr("id") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("sms"),
                                    h.vstr("templates"),
                                    h.vstr("{id}"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.jo(&.{
                                    .{ "params", h.ja(&.{
                                        h.jo(&.{
                                            .{ "name", h.vstr("id") },
                                            .{ "orig", h.vstr("id") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("param") },
                                            .{ "reqd", h.vbool(true) },
                                        }),
                                    }) },
                                }) },
                                .{ "select", h.jo(&.{
                                    .{ "exist", h.ja(&.{
                                        h.vstr("id"),
                                    }) },
                                }) },
                            }),
                        }) },
                    }) },
                }) },
                .{ "relations", h.jo(&.{
                    .{ "ancestors", h.olist() },
                }) },
            }) },
            .{ "subuser", h.jo(&.{
                .{ "fields", h.ja(&.{
                    h.jo(&.{
                        .{ "name", h.vstr("active") },
                        .{ "title", h.vstr("Active") },
                        .{ "type", h.vstr("`$BOOLEAN`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("credentials") },
                        .{ "title", h.vstr("Credentials") },
                        .{ "type", h.vstr("`$OBJECT`") },
                        .{ "req", h.vbool(true) },
                        .{ "op", h.jo(&.{
                            .{ "update", h.jo(&.{
                                .{ "type", h.vstr("`$OBJECT`") },
                            }) },
                        }) },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("description") },
                        .{ "title", h.vstr("Description") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("id") },
                        .{ "title", h.vstr("Id") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "short", h.vstr("Object ID") },
                        .{ "format", h.vstr("oid") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("points") },
                        .{ "title", h.vstr("Points") },
                        .{ "type", h.vstr("`$OBJECT`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("username") },
                        .{ "title", h.vstr("Username") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                }) },
                .{ "id", h.jo(&.{
                    .{ "field", h.vstr("id") },
                    .{ "name", h.vstr("id") },
                }) },
                .{ "name", h.vstr("subuser") },
                .{ "op", h.jo(&.{
                    .{ "create", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("create") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("POST") },
                                .{ "orig", h.vstr("/subusers") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("subusers") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("subusers"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.omap() },
                                .{ "select", h.omap() },
                            }),
                        }) },
                    }) },
                    .{ "list", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("list") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("GET") },
                                .{ "orig", h.vstr("/subusers/{id}/shares/sendernames") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("subusers") },
                                    }),
                                    h.jo(&.{
                                        .{ "var", h.vstr("id") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("shares") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("sendernames") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("subusers"),
                                    h.vstr("{id}"),
                                    h.vstr("shares"),
                                    h.vstr("sendernames"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body.senders`") },
                                }) },
                                .{ "args", h.jo(&.{
                                    .{ "params", h.ja(&.{
                                        h.jo(&.{
                                            .{ "name", h.vstr("id") },
                                            .{ "orig", h.vstr("id") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("param") },
                                            .{ "reqd", h.vbool(true) },
                                            .{ "example", h.vstr("0f0f0f0f0f0f0f0f0f0f0f0f") },
                                        }),
                                    }) },
                                }) },
                                .{ "select", h.jo(&.{
                                    .{ "$action", h.vstr("share_sendername") },
                                    .{ "exist", h.ja(&.{
                                        h.vstr("id"),
                                    }) },
                                }) },
                            }),
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("GET") },
                                .{ "orig", h.vstr("/subusers/{id}/shares/templates") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("subusers") },
                                    }),
                                    h.jo(&.{
                                        .{ "var", h.vstr("id") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("shares") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("templates") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("subusers"),
                                    h.vstr("{id}"),
                                    h.vstr("shares"),
                                    h.vstr("templates"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body.templates`") },
                                }) },
                                .{ "args", h.jo(&.{
                                    .{ "params", h.ja(&.{
                                        h.jo(&.{
                                            .{ "name", h.vstr("id") },
                                            .{ "orig", h.vstr("id") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("param") },
                                            .{ "reqd", h.vbool(true) },
                                            .{ "example", h.vstr("0f0f0f0f0f0f0f0f0f0f0f0f") },
                                        }),
                                    }) },
                                }) },
                                .{ "select", h.jo(&.{
                                    .{ "$action", h.vstr("share_template") },
                                    .{ "exist", h.ja(&.{
                                        h.vstr("id"),
                                    }) },
                                }) },
                            }),
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("GET") },
                                .{ "orig", h.vstr("/subusers") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("subusers") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("subusers"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body.collection`") },
                                }) },
                                .{ "args", h.jo(&.{
                                    .{ "query", h.ja(&.{
                                        h.jo(&.{
                                            .{ "name", h.vstr("q") },
                                            .{ "orig", h.vstr("q") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("query") },
                                        }),
                                    }) },
                                }) },
                                .{ "select", h.jo(&.{
                                    .{ "exist", h.ja(&.{
                                        h.vstr("q"),
                                    }) },
                                }) },
                            }),
                        }) },
                    }) },
                    .{ "load", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("load") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("GET") },
                                .{ "orig", h.vstr("/subusers/{id}") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("subusers") },
                                    }),
                                    h.jo(&.{
                                        .{ "var", h.vstr("id") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("subusers"),
                                    h.vstr("{id}"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.jo(&.{
                                    .{ "params", h.ja(&.{
                                        h.jo(&.{
                                            .{ "name", h.vstr("id") },
                                            .{ "orig", h.vstr("id") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("param") },
                                            .{ "reqd", h.vbool(true) },
                                            .{ "example", h.vstr("0f0f0f0f0f0f0f0f0f0f0f0f") },
                                        }),
                                    }) },
                                }) },
                                .{ "select", h.jo(&.{
                                    .{ "exist", h.ja(&.{
                                        h.vstr("id"),
                                    }) },
                                }) },
                            }),
                        }) },
                    }) },
                    .{ "remove", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("remove") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("DELETE") },
                                .{ "orig", h.vstr("/subusers/{id}") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("subusers") },
                                    }),
                                    h.jo(&.{
                                        .{ "var", h.vstr("id") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("subusers"),
                                    h.vstr("{id}"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.jo(&.{
                                    .{ "params", h.ja(&.{
                                        h.jo(&.{
                                            .{ "name", h.vstr("id") },
                                            .{ "orig", h.vstr("id") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("param") },
                                            .{ "reqd", h.vbool(true) },
                                            .{ "example", h.vstr("0f0f0f0f0f0f0f0f0f0f0f0f") },
                                        }),
                                    }) },
                                }) },
                                .{ "select", h.jo(&.{
                                    .{ "exist", h.ja(&.{
                                        h.vstr("id"),
                                    }) },
                                }) },
                            }),
                        }) },
                    }) },
                    .{ "update", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("update") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("PUT") },
                                .{ "orig", h.vstr("/subusers/{id}") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("subusers") },
                                    }),
                                    h.jo(&.{
                                        .{ "var", h.vstr("id") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("subusers"),
                                    h.vstr("{id}"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.jo(&.{
                                    .{ "params", h.ja(&.{
                                        h.jo(&.{
                                            .{ "name", h.vstr("id") },
                                            .{ "orig", h.vstr("id") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("param") },
                                            .{ "reqd", h.vbool(true) },
                                            .{ "example", h.vstr("0f0f0f0f0f0f0f0f0f0f0f0f") },
                                        }),
                                    }) },
                                }) },
                                .{ "select", h.jo(&.{
                                    .{ "exist", h.ja(&.{
                                        h.vstr("id"),
                                    }) },
                                }) },
                            }),
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("PUT") },
                                .{ "orig", h.vstr("/subusers/{id}/shares/sendernames") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("subusers") },
                                    }),
                                    h.jo(&.{
                                        .{ "var", h.vstr("id") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("shares") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("sendernames") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("subusers"),
                                    h.vstr("{id}"),
                                    h.vstr("shares"),
                                    h.vstr("sendernames"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.jo(&.{
                                    .{ "params", h.ja(&.{
                                        h.jo(&.{
                                            .{ "name", h.vstr("id") },
                                            .{ "orig", h.vstr("id") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("param") },
                                            .{ "reqd", h.vbool(true) },
                                            .{ "example", h.vstr("0f0f0f0f0f0f0f0f0f0f0f0f") },
                                        }),
                                    }) },
                                }) },
                                .{ "select", h.jo(&.{
                                    .{ "$action", h.vstr("share_sendername") },
                                    .{ "exist", h.ja(&.{
                                        h.vstr("id"),
                                    }) },
                                }) },
                            }),
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("PUT") },
                                .{ "orig", h.vstr("/subusers/{id}/shares/templates") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("subusers") },
                                    }),
                                    h.jo(&.{
                                        .{ "var", h.vstr("id") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("shares") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("templates") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("subusers"),
                                    h.vstr("{id}"),
                                    h.vstr("shares"),
                                    h.vstr("templates"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.jo(&.{
                                    .{ "params", h.ja(&.{
                                        h.jo(&.{
                                            .{ "name", h.vstr("id") },
                                            .{ "orig", h.vstr("id") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("param") },
                                            .{ "reqd", h.vbool(true) },
                                            .{ "example", h.vstr("0f0f0f0f0f0f0f0f0f0f0f0f") },
                                        }),
                                    }) },
                                }) },
                                .{ "select", h.jo(&.{
                                    .{ "$action", h.vstr("share_template") },
                                    .{ "exist", h.ja(&.{
                                        h.vstr("id"),
                                    }) },
                                }) },
                            }),
                        }) },
                    }) },
                }) },
                .{ "relations", h.jo(&.{
                    .{ "ancestors", h.olist() },
                }) },
            }) },
            .{ "template", h.jo(&.{
                .{ "fields", h.ja(&.{
                    h.jo(&.{
                        .{ "name", h.vstr("id") },
                        .{ "title", h.vstr("Id") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("name") },
                        .{ "title", h.vstr("Name") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("normalize") },
                        .{ "title", h.vstr("Normalize") },
                        .{ "type", h.vstr("`$BOOLEAN`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("template") },
                        .{ "title", h.vstr("Template") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                }) },
                .{ "id", h.jo(&.{
                    .{ "field", h.vstr("id") },
                    .{ "name", h.vstr("id") },
                }) },
                .{ "name", h.vstr("template") },
                .{ "op", h.jo(&.{
                    .{ "create", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("create") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("POST") },
                                .{ "orig", h.vstr("/sms/templates") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("sms") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("templates") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("sms"),
                                    h.vstr("templates"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.omap() },
                                .{ "select", h.omap() },
                            }),
                        }) },
                    }) },
                    .{ "list", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("list") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("GET") },
                                .{ "orig", h.vstr("/sms/templates") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("sms") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("templates") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("sms"),
                                    h.vstr("templates"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body.collection`") },
                                }) },
                                .{ "args", h.omap() },
                                .{ "select", h.omap() },
                            }),
                        }) },
                    }) },
                    .{ "load", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("load") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("GET") },
                                .{ "orig", h.vstr("/sms/templates/{id}") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("sms") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("templates") },
                                    }),
                                    h.jo(&.{
                                        .{ "var", h.vstr("id") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("sms"),
                                    h.vstr("templates"),
                                    h.vstr("{id}"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.jo(&.{
                                    .{ "params", h.ja(&.{
                                        h.jo(&.{
                                            .{ "name", h.vstr("id") },
                                            .{ "orig", h.vstr("id") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("param") },
                                            .{ "reqd", h.vbool(true) },
                                        }),
                                    }) },
                                }) },
                                .{ "select", h.jo(&.{
                                    .{ "exist", h.ja(&.{
                                        h.vstr("id"),
                                    }) },
                                }) },
                            }),
                        }) },
                    }) },
                    .{ "update", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("update") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("PUT") },
                                .{ "orig", h.vstr("/sms/templates/{id}") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("sms") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("templates") },
                                    }),
                                    h.jo(&.{
                                        .{ "var", h.vstr("id") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("sms"),
                                    h.vstr("templates"),
                                    h.vstr("{id}"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.jo(&.{
                                    .{ "params", h.ja(&.{
                                        h.jo(&.{
                                            .{ "name", h.vstr("id") },
                                            .{ "orig", h.vstr("id") },
                                            .{ "type", h.vstr("`$STRING`") },
                                            .{ "kind", h.vstr("param") },
                                            .{ "reqd", h.vbool(true) },
                                        }),
                                    }) },
                                }) },
                                .{ "select", h.jo(&.{
                                    .{ "exist", h.ja(&.{
                                        h.vstr("id"),
                                    }) },
                                }) },
                            }),
                        }) },
                    }) },
                }) },
                .{ "relations", h.jo(&.{
                    .{ "ancestors", h.olist() },
                }) },
            }) },
            .{ "user_rcs_sender_collection", h.jo(&.{
                .{ "fields", h.ja(&.{
                    h.jo(&.{
                        .{ "name", h.vstr("deliveredAt") },
                        .{ "title", h.vstr("Delivered At") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "format", h.vstr("date-time") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("expiredAt") },
                        .{ "title", h.vstr("Expired At") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "format", h.vstr("date-time") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("id") },
                        .{ "title", h.vstr("Id") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "short", h.vstr("Object ID") },
                        .{ "format", h.vstr("oid") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("interface") },
                        .{ "title", h.vstr("Interface") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "short", h.vstr("Interface through which the message was sent (www, api, ...).") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("messageType") },
                        .{ "title", h.vstr("Message Type") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "short", h.vstr("RCS message type (basic, single, ...).") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("readAt") },
                        .{ "title", h.vstr("Read At") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "format", h.vstr("date-time") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("recipient") },
                        .{ "title", h.vstr("Recipient") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "short", h.vstr("Recipient phone number (without +).") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("sender") },
                        .{ "title", h.vstr("Sender") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "short", h.vstr("Sender name") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("senderId") },
                        .{ "title", h.vstr("Sender Id") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "short", h.vstr("Sender id") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("sentAt") },
                        .{ "title", h.vstr("Sent At") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "format", h.vstr("date-time") },
                    }),
                }) },
                .{ "id", h.jo(&.{
                    .{ "field", h.vstr("id") },
                    .{ "name", h.vstr("id") },
                }) },
                .{ "name", h.vstr("user_rcs_sender_collection") },
                .{ "op", h.jo(&.{
                    .{ "list", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("list") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("GET") },
                                .{ "orig", h.vstr("/rcs/senders") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("rcs") },
                                    }),
                                    h.jo(&.{
                                        .{ "lit", h.vstr("senders") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("rcs"),
                                    h.vstr("senders"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body.collection`") },
                                }) },
                                .{ "args", h.omap() },
                                .{ "select", h.omap() },
                            }),
                        }) },
                    }) },
                }) },
                .{ "relations", h.jo(&.{
                    .{ "ancestors", h.olist() },
                }) },
            }) },
        }) },
    });
}

// SHARED CONFIG (sdkgen rung L2).
//
// The SDK reads the config on every request and never writes to it, so one
// instance is shared by every client rather than rebuilt per client. Above the
// size threshold make_config re-parses the whole embedded JSON, so this is the
// difference between parsing the model once and once per client.
//
// Value nodes are arena-allocated and reference-stable, so the shared value is
// genuinely one structure, not a copy.
var shared_config_val: ?Value = null;

/// The process-wide config, built once on first use.
///
/// The returned Value SHARES its nodes: treat it as read-only. Callers that
/// need to mutate should use make_config, which always returns a fresh copy.
pub fn shared_config() Value {
    if (shared_config_val) |c| return c;
    const c = make_config();
    shared_config_val = c;
    return c;
}

pub fn make_feature(name: []const u8) Feature {
    if (std.mem.eql(u8, name, "audit")) return @import("../feature/audit.zig").AuditFeature.make();
    if (std.mem.eql(u8, name, "cache")) return @import("../feature/cache.zig").CacheFeature.make();
    if (std.mem.eql(u8, name, "clienttrack")) return @import("../feature/clienttrack.zig").ClienttrackFeature.make();
    if (std.mem.eql(u8, name, "cost")) return @import("../feature/cost.zig").CostFeature.make();
    if (std.mem.eql(u8, name, "debug")) return @import("../feature/debug.zig").DebugFeature.make();
    if (std.mem.eql(u8, name, "idempotency")) return @import("../feature/idempotency.zig").IdempotencyFeature.make();
    if (std.mem.eql(u8, name, "log")) return @import("../feature/log.zig").LogFeature.make();
    if (std.mem.eql(u8, name, "metrics")) return @import("../feature/metrics.zig").MetricsFeature.make();
    if (std.mem.eql(u8, name, "netsim")) return @import("../feature/netsim.zig").NetsimFeature.make();
    if (std.mem.eql(u8, name, "paging")) return @import("../feature/paging.zig").PagingFeature.make();
    if (std.mem.eql(u8, name, "proxy")) return @import("../feature/proxy.zig").ProxyFeature.make();
    if (std.mem.eql(u8, name, "ratelimit")) return @import("../feature/ratelimit.zig").RatelimitFeature.make();
    if (std.mem.eql(u8, name, "rbac")) return @import("../feature/rbac.zig").RbacFeature.make();
    if (std.mem.eql(u8, name, "retry")) return @import("../feature/retry.zig").RetryFeature.make();
    if (std.mem.eql(u8, name, "streaming")) return @import("../feature/streaming.zig").StreamingFeature.make();
    if (std.mem.eql(u8, name, "telemetry")) return @import("../feature/telemetry.zig").TelemetryFeature.make();
    if (std.mem.eql(u8, name, "test")) return @import("../feature/test.zig").TestFeature.make();
    if (std.mem.eql(u8, name, "timeout")) return @import("../feature/timeout.zig").TimeoutFeature.make();
    if (std.mem.eql(u8, name, "secrets")) return @import("../feature/secrets.zig").SecretsFeature.make();
    if (std.mem.eql(u8, name, "validate")) return @import("../feature/validate.zig").ValidateFeature.make();
    return @import("../feature/base.zig").BaseFeature.make();
}
