
const { BaseFeature } = require('./feature/base/BaseFeature')
const { AuditFeature } = require('./feature/audit/AuditFeature')
const { CacheFeature } = require('./feature/cache/CacheFeature')
const { ClienttrackFeature } = require('./feature/clienttrack/ClienttrackFeature')
const { CostFeature } = require('./feature/cost/CostFeature')
const { DebugFeature } = require('./feature/debug/DebugFeature')
const { IdempotencyFeature } = require('./feature/idempotency/IdempotencyFeature')
const { LogFeature } = require('./feature/log/LogFeature')
const { MetricsFeature } = require('./feature/metrics/MetricsFeature')
const { NetsimFeature } = require('./feature/netsim/NetsimFeature')
const { PagingFeature } = require('./feature/paging/PagingFeature')
const { ProxyFeature } = require('./feature/proxy/ProxyFeature')
const { RatelimitFeature } = require('./feature/ratelimit/RatelimitFeature')
const { RbacFeature } = require('./feature/rbac/RbacFeature')
const { RetryFeature } = require('./feature/retry/RetryFeature')
const { SecretsFeature } = require('./feature/secrets/SecretsFeature')
const { StreamingFeature } = require('./feature/streaming/StreamingFeature')
const { TelemetryFeature } = require('./feature/telemetry/TelemetryFeature')
const { TestFeature } = require('./feature/test/TestFeature')
const { TimeoutFeature } = require('./feature/timeout/TimeoutFeature')
const { ValidateFeature } = require('./feature/validate/ValidateFeature')



const FEATURE_CLASS = {
   audit: AuditFeature,
 cache: CacheFeature,
 clienttrack: ClienttrackFeature,
 cost: CostFeature,
 debug: DebugFeature,
 idempotency: IdempotencyFeature,
 log: LogFeature,
 metrics: MetricsFeature,
 netsim: NetsimFeature,
 paging: PagingFeature,
 proxy: ProxyFeature,
 ratelimit: RatelimitFeature,
 rbac: RbacFeature,
 retry: RetryFeature,
 secrets: SecretsFeature,
 streaming: StreamingFeature,
 telemetry: TelemetryFeature,
 test: TestFeature,
 timeout: TimeoutFeature,
 validate: ValidateFeature,

}


// Per-feature plugin DEFINITIONS (voxgig/plugin `Definition` values), from
// the model's active plugin groups. A feature that takes a `plugins` option
// (secrets over sekreto) reads its own entry; a feature with no plugins has
// none. Named requires above make each definition statically reachable, so
// an SDK carries exactly the plugin modules its model selects — the same
// leanness the old side-effect registry imports bought, without a registry.
//
// Read by SecretsFeature through a DEFERRED require of this module: the
// requires above make the pair circular, and this file replaces
// module.exports at the end of its body, so anything reading the map at
// module load would get undefined. See tm/js/src/feature/secrets.
const FEATURE_PLUGINS = {
  
}


class Config {

  makeFeature(fn) {
    const fc = FEATURE_CLASS[fn]
    const fi = new fc()
    // TODO: errors etc
    return fi
  }

  // False for a feature added at runtime via options.extend (station's
  // adopt path) - the constructor uses this to skip makeFeature for names
  // no generated class backs.
  hasFeature(fn) {
    return null != FEATURE_CLASS[fn]
  }


  main = {
    name: 'Smsapi',
        slug: "smsapi",
    version: "0.0.1",
    target: "js",

  }


  feature = {
     audit:     {
      "options": {
        "active": false,
        "actor": "anonymous",
        "max": 1000
      },
      "optspec": {
        "now": "`$FUNCTION`",
        "sink": "`$FUNCTION`"
      },
      "strict": false,
      "transport": "none"
    },
 cache:     {
      "options": {
        "active": false,
        "max": 256,
        "methods": [
          "GET"
        ],
        "ttl": 5000
      },
      "optspec": {
        "now": "`$FUNCTION`"
      },
      "strict": false,
      "transport": "wrap"
    },
 clienttrack:     {
      "options": {
        "active": false,
        "clientVersion": "0.0.1"
      },
      "optspec": {
        "clientName": "`$STRING`",
        "clientVersion": "`$STRING`",
        "headers": "`$MAP`",
        "idgen": "`$FUNCTION`",
        "sessionId": "`$STRING`"
      },
      "strict": false,
      "transport": "none"
    },
 cost:     {
      "options": {
        "active": false,
        "budget": 0,
        "currency": "USD",
        "header": "",
        "onBudget": "warn",
        "path": "",
        "perUnit": 0,
        "rates": {},
        "unit": 0
      },
      "optspec": {
        "actor": "`$STRING`",
        "sink": "`$FUNCTION`"
      },
      "strict": false,
      "transport": "wrap"
    },
 debug:     {
      "options": {
        "active": false,
        "max": 100,
        "redact": [
          "authorization",
          "cookie",
          "set-cookie",
          "api-key",
          "apikey",
          "x-api-key",
          "idempotency-key"
        ]
      },
      "optspec": {
        "now": "`$FUNCTION`",
        "onEntry": "`$FUNCTION`"
      },
      "strict": false,
      "transport": "none"
    },
 idempotency:     {
      "options": {
        "active": false,
        "header": "Idempotency-Key",
        "methods": [
          "POST",
          "PUT",
          "PATCH",
          "DELETE"
        ],
        "ops": [
          "create",
          "update",
          "remove"
        ]
      },
      "optspec": {
        "keygen": "`$FUNCTION`"
      },
      "strict": false,
      "transport": "none"
    },
 log:     {
      "options": {
        "active": true
      },
      "optspec": {
        "level": "`$STRING`",
        "logger": "`$ANY`"
      },
      "strict": false,
      "transport": "none"
    },
 metrics:     {
      "options": {
        "active": false
      },
      "optspec": {
        "now": "`$FUNCTION`"
      },
      "strict": false,
      "transport": "none"
    },
 netsim:     {
      "options": {
        "active": false,
        "errorTimes": 0,
        "failEvery": 0,
        "failRate": 0,
        "failStatus": 503,
        "failTimes": 0,
        "latency": 0,
        "offline": false,
        "rateLimitTimes": 0,
        "retryAfter": 0,
        "seed": 1
      },
      "optspec": {
        "latency": [
          "`$ONE`",
          "`$NUMBER`",
          "`$MAP`"
        ],
        "sleep": "`$FUNCTION`"
      },
      "strict": false,
      "transport": "wrap"
    },
 paging:     {
      "options": {
        "active": false,
        "afterVar": "after",
        "cursorParam": "cursor",
        "firstVar": "first",
        "limitParam": "limit",
        "pageParam": "page",
        "startPage": 1
      },
      "optspec": {
        "limit": "`$NUMBER`",
        "ops": "`$LIST`"
      },
      "strict": false,
      "transport": "none"
    },
 proxy:     {
      "options": {
        "active": false,
        "fromEnv": false,
        "noProxy": [],
        "url": ""
      },
      "optspec": {
        "agent": "`$FUNCTION`"
      },
      "strict": false,
      "transport": "wrap"
    },
 ratelimit:     {
      "options": {
        "active": false,
        "burst": 5,
        "rate": 5
      },
      "optspec": {
        "now": "`$FUNCTION`",
        "sleep": "`$FUNCTION`"
      },
      "strict": false,
      "transport": "wrap"
    },
 rbac:     {
      "options": {
        "active": false,
        "deny": false,
        "permissions": [],
        "rules": {}
      },
      "optspec": {},
      "strict": false,
      "transport": "none"
    },
 retry:     {
      "options": {
        "active": false,
        "factor": 2,
        "maxDelay": 2000,
        "minDelay": 50,
        "retries": 2,
        "statuses": [
          408,
          425,
          429,
          500,
          502,
          503,
          504
        ]
      },
      "optspec": {
        "jitter": "`$BOOLEAN`",
        "sleep": "`$FUNCTION`"
      },
      "strict": false,
      "transport": "wrap"
    },
 secrets:     {
      "options": {
        "active": false,
        "cache": true,
        "exchange": {
          "active": false,
          "method": "POST",
          "path": "auth/token",
          "refresh": "",
          "request": "refresh_token",
          "response": "access_token",
          "retries": 1,
          "statuses": [
            401
          ]
        },
        "name": "apikey",
        "providers": []
      },
      "optspec": {},
      "strict": false,
      "transport": "wrap"
    },
 streaming:     {
      "options": {
        "active": false,
        "chunkDelay": 0,
        "chunkSize": 0
      },
      "optspec": {
        "ops": "`$LIST`",
        "sleep": "`$FUNCTION`"
      },
      "strict": false,
      "transport": "none"
    },
 telemetry:     {
      "options": {
        "active": false
      },
      "optspec": {
        "exporter": "`$FUNCTION`",
        "headers": "`$MAP`",
        "idgen": "`$FUNCTION`",
        "now": "`$FUNCTION`"
      },
      "strict": false,
      "transport": "none"
    },
 test:     {
      "options": {
        "active": false
      },
      "optspec": {
        "entity": "`$MAP`",
        "net": "`$MAP`"
      },
      "strict": false,
      "transport": "base"
    },
 timeout:     {
      "options": {
        "active": false,
        "ms": 30000
      },
      "optspec": {
        "clearTimer": "`$FUNCTION`",
        "setTimer": "`$FUNCTION`"
      },
      "strict": false,
      "transport": "wrap"
    },
 validate:     {
      "options": {
        "active": false,
        "mode": "throw",
        "request": true,
        "response": false,
        "strict": false
      },
      "optspec": {
        "mode": [
          "`$ONE`",
          [
            "`$EXACT`",
            "throw"
          ],
          [
            "`$EXACT`",
            "report"
          ]
        ],
        "onInvalid": "`$FUNCTION`"
      },
      "strict": false,
      "transport": "none"
    },

  }


  options = {
    base: "https://api.smsapi.com",

    auth: {
      prefix: 'Bearer',
    },

    headers: {
      "content-type": "application/json"
    },

    entity: {
      
        available: {
        },
  
        blacklist: {
        },
  
        callback: {
        },
  
        contact: {
        },
  
        contacts_field: {
        },
  
        contacts_field_option: {
        },
  
        contactsgroup: {
        },
  
        contactstrash: {
        },
  
        field_available: {
        },
  
        group: {
        },
  
        mfa_code: {
        },
  
        opt_out: {
        },
  
        opt_out_setting: {
        },
  
        permission: {
        },
  
        ping: {
        },
  
        profile: {
        },
  
        rcs: {
        },
  
        sendername: {
        },
  
        sendername_statement: {
        },
  
        sent_rcs_message: {
        },
  
        shipment_country_volume: {
        },
  
        short_url: {
        },
  
        smsdo: {
        },
  
        smssendername: {
        },
  
        smstemplate: {
        },
  
        subuser: {
        },
  
        template: {
        },
  
        user_rcs_sender_collection: {
        },
  
    }
  }


  entity = {
    "available": {
      "fields": [
        {
          "name": "name",
          "title": "Name",
          "type": "`$STRING`"
        },
        {
          "name": "normalize",
          "title": "Normalize",
          "type": "`$BOOLEAN`"
        },
        {
          "name": "template",
          "title": "Template",
          "type": "`$STRING`"
        }
      ],
      "name": "available",
      "op": {
        "list": {
          "input": "data",
          "name": "list",
          "points": [
            {
              "kind": "http",
              "method": "GET",
              "orig": "/sms/templates/available",
              "segments": [
                {
                  "lit": "sms"
                },
                {
                  "lit": "templates"
                },
                {
                  "lit": "available"
                }
              ],
              "parts": [
                "sms",
                "templates",
                "available"
              ],
              "rename": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body.collection`"
              },
              "args": {},
              "select": {}
            }
          ]
        }
      },
      "relations": {
        "ancestors": []
      }
    },
    "blacklist": {
      "fields": [
        {
          "name": "id",
          "title": "Id",
          "type": "`$STRING`"
        }
      ],
      "id": {
        "field": "id",
        "name": "id"
      },
      "name": "blacklist",
      "op": {
        "create": {
          "input": "data",
          "name": "create",
          "points": [
            {
              "kind": "http",
              "method": "POST",
              "orig": "/blacklist/phone_numbers",
              "segments": [
                {
                  "lit": "blacklist"
                },
                {
                  "lit": "phone_numbers"
                }
              ],
              "parts": [
                "blacklist",
                "phone_numbers"
              ],
              "rename": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {},
              "select": {
                "$action": "phone_number"
              }
            },
            {
              "kind": "http",
              "method": "POST",
              "orig": "/blacklist/phone_numbers/imports",
              "segments": [
                {
                  "lit": "blacklist"
                },
                {
                  "lit": "phone_numbers"
                },
                {
                  "lit": "imports"
                }
              ],
              "parts": [
                "blacklist",
                "phone_numbers",
                "imports"
              ],
              "rename": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {},
              "select": {}
            }
          ]
        },
        "load": {
          "input": "data",
          "name": "load",
          "points": [
            {
              "kind": "http",
              "method": "GET",
              "orig": "/blacklist/phone_numbers",
              "segments": [
                {
                  "lit": "blacklist"
                },
                {
                  "lit": "phone_numbers"
                }
              ],
              "parts": [
                "blacklist",
                "phone_numbers"
              ],
              "rename": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {
                "header": [
                  {
                    "name": "accept",
                    "orig": "Accept",
                    "type": "`$STRING`",
                    "kind": "header",
                    "example": "application/json"
                  },
                  {
                    "name": "x_async",
                    "orig": "x-async",
                    "type": "`$BOOLEAN`",
                    "kind": "header",
                    "example": false
                  }
                ],
                "query": [
                  {
                    "name": "limit",
                    "orig": "limit",
                    "type": "`$INTEGER`",
                    "kind": "query",
                    "example": 5
                  },
                  {
                    "name": "offset",
                    "orig": "offset",
                    "type": "`$INTEGER`",
                    "kind": "query",
                    "example": 0
                  },
                  {
                    "name": "q",
                    "orig": "q",
                    "type": "`$INTEGER`",
                    "kind": "query",
                    "example": 0
                  }
                ]
              },
              "select": {
                "$action": "phone_number",
                "exist": [
                  "accept",
                  "limit",
                  "offset",
                  "q",
                  "x_async"
                ]
              }
            }
          ]
        },
        "remove": {
          "input": "data",
          "name": "remove",
          "points": [
            {
              "kind": "http",
              "method": "DELETE",
              "orig": "/blacklist/phone_numbers/{id}",
              "segments": [
                {
                  "lit": "blacklist"
                },
                {
                  "lit": "phone_numbers"
                },
                {
                  "var": "id"
                }
              ],
              "parts": [
                "blacklist",
                "phone_numbers",
                "{id}"
              ],
              "rename": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {
                "params": [
                  {
                    "name": "id",
                    "orig": "id",
                    "type": "`$STRING`",
                    "kind": "param",
                    "reqd": true,
                    "example": "0f0f0f0f0f0f0f0f0f0f0f0f"
                  }
                ]
              },
              "select": {
                "exist": [
                  "id"
                ]
              }
            },
            {
              "kind": "http",
              "method": "DELETE",
              "orig": "/blacklist/phone_numbers",
              "segments": [
                {
                  "lit": "blacklist"
                },
                {
                  "lit": "phone_numbers"
                }
              ],
              "parts": [
                "blacklist",
                "phone_numbers"
              ],
              "rename": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {
                "query": [
                  {
                    "name": "phone_number",
                    "orig": "phone_number",
                    "type": "`$STRING`",
                    "kind": "query"
                  }
                ]
              },
              "select": {
                "$action": "phone_number",
                "exist": [
                  "phone_number"
                ]
              }
            }
          ]
        }
      },
      "relations": {
        "ancestors": []
      }
    },
    "callback": {
      "fields": [
        {
          "name": "active",
          "title": "Active",
          "type": "`$BOOLEAN`"
        },
        {
          "name": "api_version",
          "title": "Api Version",
          "type": "`$INTEGER`",
          "short": "Version of the callback output format."
        },
        {
          "name": "id",
          "title": "Id",
          "type": "`$STRING`",
          "short": "Object ID",
          "format": "oid"
        },
        {
          "name": "invalid",
          "title": "Invalid",
          "type": "`$BOOLEAN`"
        },
        {
          "name": "receiver",
          "title": "Receiver",
          "type": "`$OBJECT`"
        },
        {
          "name": "receiver_type",
          "title": "Receiver Type",
          "type": "`$STRING`"
        },
        {
          "name": "type",
          "title": "Type",
          "type": "`$STRING`"
        },
        {
          "name": "url",
          "title": "Url",
          "type": "`$STRING`",
          "op": {
            "update": {
              "req": true,
              "type": "`$STRING`"
            }
          },
          "short": "WHATWG URL compliant",
          "format": "url"
        }
      ],
      "id": {
        "field": "id",
        "name": "id"
      },
      "name": "callback",
      "op": {
        "create": {
          "input": "data",
          "name": "create",
          "points": [
            {
              "kind": "http",
              "method": "POST",
              "orig": "/callbacks",
              "segments": [
                {
                  "lit": "callbacks"
                }
              ],
              "parts": [
                "callbacks"
              ],
              "rename": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {},
              "select": {}
            }
          ]
        },
        "list": {
          "input": "data",
          "name": "list",
          "points": [
            {
              "kind": "http",
              "method": "GET",
              "orig": "/callbacks",
              "segments": [
                {
                  "lit": "callbacks"
                }
              ],
              "parts": [
                "callbacks"
              ],
              "rename": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body.collection`"
              },
              "args": {},
              "select": {}
            }
          ]
        },
        "load": {
          "input": "data",
          "name": "load",
          "points": [
            {
              "kind": "http",
              "method": "GET",
              "orig": "/callbacks/{id}",
              "segments": [
                {
                  "lit": "callbacks"
                },
                {
                  "var": "id"
                }
              ],
              "parts": [
                "callbacks",
                "{id}"
              ],
              "rename": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {
                "params": [
                  {
                    "name": "id",
                    "orig": "id",
                    "type": "`$STRING`",
                    "kind": "param",
                    "reqd": true,
                    "example": "0f0f0f0f0f0f0f0f0f0f0f0f"
                  }
                ]
              },
              "select": {
                "exist": [
                  "id"
                ]
              }
            },
            {
              "kind": "http",
              "method": "GET",
              "orig": "/callbacks/{id}/commands/test",
              "segments": [
                {
                  "lit": "callbacks"
                },
                {
                  "var": "id"
                },
                {
                  "lit": "commands"
                },
                {
                  "lit": "test"
                }
              ],
              "parts": [
                "callbacks",
                "{id}",
                "commands",
                "test"
              ],
              "rename": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {
                "params": [
                  {
                    "name": "id",
                    "orig": "id",
                    "type": "`$STRING`",
                    "kind": "param",
                    "reqd": true,
                    "example": "0f0f0f0f0f0f0f0f0f0f0f0f"
                  }
                ]
              },
              "select": {
                "$action": "command_test",
                "exist": [
                  "id"
                ]
              }
            }
          ]
        },
        "remove": {
          "input": "data",
          "name": "remove",
          "points": [
            {
              "kind": "http",
              "method": "DELETE",
              "orig": "/callbacks/{id}",
              "segments": [
                {
                  "lit": "callbacks"
                },
                {
                  "var": "id"
                }
              ],
              "parts": [
                "callbacks",
                "{id}"
              ],
              "rename": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {
                "params": [
                  {
                    "name": "id",
                    "orig": "id",
                    "type": "`$STRING`",
                    "kind": "param",
                    "reqd": true,
                    "example": "0f0f0f0f0f0f0f0f0f0f0f0f"
                  }
                ]
              },
              "select": {
                "exist": [
                  "id"
                ]
              }
            }
          ]
        },
        "update": {
          "input": "data",
          "name": "update",
          "points": [
            {
              "kind": "http",
              "method": "PUT",
              "orig": "/callbacks/{id}",
              "segments": [
                {
                  "lit": "callbacks"
                },
                {
                  "var": "id"
                }
              ],
              "parts": [
                "callbacks",
                "{id}"
              ],
              "rename": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {
                "params": [
                  {
                    "name": "id",
                    "orig": "id",
                    "type": "`$STRING`",
                    "kind": "param",
                    "reqd": true,
                    "example": "0f0f0f0f0f0f0f0f0f0f0f0f"
                  }
                ]
              },
              "select": {
                "exist": [
                  "id"
                ]
              }
            },
            {
              "kind": "http",
              "method": "PUT",
              "orig": "/callbacks/{id}/commands/activate",
              "segments": [
                {
                  "lit": "callbacks"
                },
                {
                  "var": "id"
                },
                {
                  "lit": "commands"
                },
                {
                  "lit": "activate"
                }
              ],
              "parts": [
                "callbacks",
                "{id}",
                "commands",
                "activate"
              ],
              "rename": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {
                "params": [
                  {
                    "name": "id",
                    "orig": "id",
                    "type": "`$STRING`",
                    "kind": "param",
                    "reqd": true,
                    "example": "0f0f0f0f0f0f0f0f0f0f0f0f"
                  }
                ]
              },
              "select": {
                "$action": "command_activate",
                "exist": [
                  "id"
                ]
              }
            },
            {
              "kind": "http",
              "method": "PUT",
              "orig": "/callbacks/{id}/commands/deactivate",
              "segments": [
                {
                  "lit": "callbacks"
                },
                {
                  "var": "id"
                },
                {
                  "lit": "commands"
                },
                {
                  "lit": "deactivate"
                }
              ],
              "parts": [
                "callbacks",
                "{id}",
                "commands",
                "deactivate"
              ],
              "rename": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {
                "params": [
                  {
                    "name": "id",
                    "orig": "id",
                    "type": "`$STRING`",
                    "kind": "param",
                    "reqd": true,
                    "example": "0f0f0f0f0f0f0f0f0f0f0f0f"
                  }
                ]
              },
              "select": {
                "$action": "command_deactivate",
                "exist": [
                  "id"
                ]
              }
            }
          ]
        }
      },
      "relations": {
        "ancestors": []
      }
    },
    "contact": {
      "fields": [
        {
          "name": "birthday_date",
          "title": "Birthday Date",
          "type": "`$STRING`",
          "format": "date"
        },
        {
          "name": "city",
          "title": "City",
          "type": "`$STRING`"
        },
        {
          "name": "collection",
          "title": "Collection",
          "type": "`$ARRAY`",
          "req": true,
          "op": {
            "update": {
              "type": "`$ARRAY`"
            }
          }
        },
        {
          "name": "contact_expire_after",
          "title": "Contact Expire After",
          "type": "`$INTEGER`",
          "req": true,
          "short": "Contact expire after days"
        },
        {
          "name": "contacts_count",
          "title": "Contacts Count",
          "type": "`$INTEGER`",
          "req": true,
          "op": {
            "list": {
              "type": "`$INTEGER`"
            }
          }
        },
        {
          "name": "country",
          "title": "Country",
          "type": "`$STRING`"
        },
        {
          "name": "created_by",
          "title": "Created By",
          "type": "`$STRING`",
          "req": true
        },
        {
          "name": "date_created",
          "title": "Date Created",
          "type": "`$STRING`",
          "req": true,
          "format": "date-time"
        },
        {
          "name": "date_updated",
          "title": "Date Updated",
          "type": "`$STRING`",
          "req": true,
          "format": "date-time"
        },
        {
          "name": "description",
          "title": "Description",
          "type": "`$STRING`",
          "op": {
            "load": {
              "req": true,
              "type": "`$STRING`"
            }
          }
        },
        {
          "name": "email",
          "title": "Email",
          "type": "`$STRING`",
          "format": "email"
        },
        {
          "name": "first_name",
          "title": "First Name",
          "type": "`$STRING`"
        },
        {
          "name": "gender",
          "title": "Gender",
          "type": "`$STRING`",
          "req": true
        },
        {
          "name": "group_id",
          "title": "Group Id",
          "type": "`$STRING`",
          "short": "Object ID",
          "format": "oid"
        },
        {
          "name": "groups",
          "title": "Groups",
          "type": "`$ARRAY`",
          "req": true
        },
        {
          "name": "id",
          "title": "Id",
          "type": "`$STRING`",
          "req": true,
          "short": "Object ID",
          "format": "oid"
        },
        {
          "name": "idx",
          "title": "Idx",
          "type": "`$STRING`",
          "short": "User provided resource id"
        },
        {
          "name": "last_name",
          "title": "Last Name",
          "type": "`$STRING`"
        },
        {
          "name": "name",
          "title": "Name",
          "type": "`$STRING`",
          "req": true,
          "op": {
            "list": {
              "type": "`$STRING`"
            }
          },
          "short": "Group name"
        },
        {
          "name": "permissions",
          "title": "Permissions",
          "type": "`$ARRAY`"
        },
        {
          "name": "phone_number",
          "title": "Phone Number",
          "type": "`$STRING`"
        },
        {
          "name": "read",
          "title": "Read",
          "type": "`$BOOLEAN`",
          "short": "Has read permission"
        },
        {
          "name": "send",
          "title": "Send",
          "type": "`$BOOLEAN`",
          "short": "Has send permission"
        },
        {
          "name": "size",
          "title": "Size",
          "type": "`$INTEGER`",
          "req": true
        },
        {
          "name": "source",
          "title": "Source",
          "type": "`$STRING`"
        },
        {
          "name": "type",
          "title": "Type",
          "type": "`$STRING`"
        },
        {
          "name": "username",
          "title": "Username",
          "type": "`$STRING`"
        },
        {
          "name": "value",
          "title": "Value",
          "type": "`$STRING`"
        },
        {
          "name": "write",
          "title": "Write",
          "type": "`$BOOLEAN`",
          "short": "Has write permission"
        }
      ],
      "id": {
        "field": "id",
        "name": "id"
      },
      "name": "contact",
      "op": {
        "create": {
          "input": "data",
          "name": "create",
          "points": [
            {
              "kind": "http",
              "method": "POST",
              "orig": "/contacts/{contactId}/groups",
              "segments": [
                {
                  "lit": "contacts"
                },
                {
                  "var": "id"
                },
                {
                  "lit": "groups"
                }
              ],
              "parts": [
                "contacts",
                "{id}",
                "groups"
              ],
              "rename": {
                "param": {
                  "contactId": "id"
                }
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {
                "params": [
                  {
                    "name": "id",
                    "orig": "contactId",
                    "type": "`$STRING`",
                    "kind": "param",
                    "reqd": true,
                    "example": "0f0f0f0f0f0f0f0f0f0f0f0f"
                  }
                ]
              },
              "select": {
                "$action": "group",
                "exist": [
                  "id"
                ]
              }
            },
            {
              "kind": "http",
              "method": "POST",
              "orig": "/contacts",
              "segments": [
                {
                  "lit": "contacts"
                }
              ],
              "parts": [
                "contacts"
              ],
              "rename": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {},
              "select": {}
            }
          ]
        },
        "list": {
          "input": "data",
          "name": "list",
          "points": [
            {
              "kind": "http",
              "method": "GET",
              "orig": "/contacts",
              "segments": [
                {
                  "lit": "contacts"
                }
              ],
              "parts": [
                "contacts"
              ],
              "rename": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body.collection`"
              },
              "args": {
                "query": [
                  {
                    "name": "birthday_date",
                    "orig": "birthday_date",
                    "type": "`$ARRAY`",
                    "kind": "query",
                    "example": "2022-06-24"
                  },
                  {
                    "name": "email",
                    "orig": "email",
                    "type": "`$ARRAY`",
                    "kind": "query"
                  },
                  {
                    "name": "first_name",
                    "orig": "first_name",
                    "type": "`$ARRAY`",
                    "kind": "query"
                  },
                  {
                    "name": "gender",
                    "orig": "gender",
                    "type": "`$STRING`",
                    "kind": "query"
                  },
                  {
                    "name": "group_id",
                    "orig": "group_id",
                    "type": "`$ARRAY`",
                    "kind": "query"
                  },
                  {
                    "name": "last_name",
                    "orig": "last_name",
                    "type": "`$ARRAY`",
                    "kind": "query"
                  },
                  {
                    "name": "limit",
                    "orig": "limit",
                    "type": "`$INTEGER`",
                    "kind": "query",
                    "example": 5
                  },
                  {
                    "name": "offset",
                    "orig": "offset",
                    "type": "`$INTEGER`",
                    "kind": "query",
                    "example": 0
                  },
                  {
                    "name": "order_by",
                    "orig": "order_by",
                    "type": "`$STRING`",
                    "kind": "query"
                  },
                  {
                    "name": "phone_number",
                    "orig": "phone_number",
                    "type": "`$ARRAY`",
                    "kind": "query"
                  },
                  {
                    "name": "q",
                    "orig": "q",
                    "type": "`$STRING`",
                    "kind": "query"
                  }
                ]
              },
              "select": {
                "exist": [
                  "birthday_date",
                  "email",
                  "first_name",
                  "gender",
                  "group_id",
                  "last_name",
                  "limit",
                  "offset",
                  "order_by",
                  "phone_number",
                  "q"
                ]
              }
            },
            {
              "kind": "http",
              "method": "GET",
              "orig": "/contacts/{contactId}/groups",
              "segments": [
                {
                  "lit": "contacts"
                },
                {
                  "var": "id"
                },
                {
                  "lit": "groups"
                }
              ],
              "parts": [
                "contacts",
                "{id}",
                "groups"
              ],
              "rename": {
                "param": {
                  "contactId": "id"
                }
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body.collection`"
              },
              "args": {
                "params": [
                  {
                    "name": "id",
                    "orig": "contactId",
                    "type": "`$STRING`",
                    "kind": "param",
                    "reqd": true,
                    "example": "0f0f0f0f0f0f0f0f0f0f0f0f"
                  }
                ]
              },
              "select": {
                "$action": "group",
                "exist": [
                  "id"
                ]
              }
            }
          ]
        },
        "load": {
          "input": "data",
          "name": "load",
          "points": [
            {
              "kind": "http",
              "method": "GET",
              "orig": "/contacts/groups/{groupId}/members/{contactId}",
              "segments": [
                {
                  "lit": "contacts"
                },
                {
                  "lit": "groups"
                },
                {
                  "var": "group_id"
                },
                {
                  "lit": "members"
                },
                {
                  "var": "contact_id"
                }
              ],
              "parts": [
                "contacts",
                "groups",
                "{group_id}",
                "members",
                "{contact_id}"
              ],
              "rename": {
                "param": {
                  "contactId": "contact_id",
                  "groupId": "group_id"
                }
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {
                "params": [
                  {
                    "name": "contact_id",
                    "orig": "contactId",
                    "type": "`$STRING`",
                    "kind": "param",
                    "reqd": true,
                    "example": "0f0f0f0f0f0f0f0f0f0f0f0f"
                  },
                  {
                    "name": "group_id",
                    "orig": "groupId",
                    "type": "`$STRING`",
                    "kind": "param",
                    "reqd": true,
                    "example": "0f0f0f0f0f0f0f0f0f0f0f0f"
                  }
                ]
              },
              "select": {
                "exist": [
                  "contact_id",
                  "group_id"
                ]
              }
            },
            {
              "kind": "http",
              "method": "GET",
              "orig": "/contacts/{contactId}/groups/{groupId}",
              "segments": [
                {
                  "lit": "contacts"
                },
                {
                  "var": "id"
                },
                {
                  "lit": "groups"
                },
                {
                  "var": "group_id"
                }
              ],
              "parts": [
                "contacts",
                "{id}",
                "groups",
                "{group_id}"
              ],
              "rename": {
                "param": {
                  "contactId": "id",
                  "groupId": "group_id"
                }
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {
                "params": [
                  {
                    "name": "group_id",
                    "orig": "groupId",
                    "type": "`$STRING`",
                    "kind": "param",
                    "reqd": true,
                    "example": "0f0f0f0f0f0f0f0f0f0f0f0f"
                  },
                  {
                    "name": "id",
                    "orig": "contactId",
                    "type": "`$STRING`",
                    "kind": "param",
                    "reqd": true,
                    "example": "0f0f0f0f0f0f0f0f0f0f0f0f"
                  }
                ]
              },
              "select": {
                "exist": [
                  "group_id",
                  "id"
                ]
              }
            },
            {
              "kind": "http",
              "method": "GET",
              "orig": "/contacts/{contactId}",
              "segments": [
                {
                  "lit": "contacts"
                },
                {
                  "var": "id"
                }
              ],
              "parts": [
                "contacts",
                "{id}"
              ],
              "rename": {
                "param": {
                  "contactId": "id"
                }
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {
                "params": [
                  {
                    "name": "id",
                    "orig": "contactId",
                    "type": "`$STRING`",
                    "kind": "param",
                    "reqd": true,
                    "example": "0f0f0f0f0f0f0f0f0f0f0f0f"
                  }
                ]
              },
              "select": {
                "exist": [
                  "id"
                ]
              }
            }
          ]
        },
        "remove": {
          "input": "data",
          "name": "remove",
          "points": [
            {
              "kind": "http",
              "method": "DELETE",
              "orig": "/contacts/{contactId}/groups/{groupId}",
              "segments": [
                {
                  "lit": "contacts"
                },
                {
                  "var": "id"
                },
                {
                  "lit": "groups"
                },
                {
                  "var": "group_id"
                }
              ],
              "parts": [
                "contacts",
                "{id}",
                "groups",
                "{group_id}"
              ],
              "rename": {
                "param": {
                  "contactId": "id",
                  "groupId": "group_id"
                }
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {
                "params": [
                  {
                    "name": "group_id",
                    "orig": "groupId",
                    "type": "`$STRING`",
                    "kind": "param",
                    "reqd": true,
                    "example": "0f0f0f0f0f0f0f0f0f0f0f0f"
                  },
                  {
                    "name": "id",
                    "orig": "contactId",
                    "type": "`$STRING`",
                    "kind": "param",
                    "reqd": true,
                    "example": "0f0f0f0f0f0f0f0f0f0f0f0f"
                  }
                ]
              },
              "select": {
                "exist": [
                  "group_id",
                  "id"
                ]
              }
            },
            {
              "kind": "http",
              "method": "DELETE",
              "orig": "/contacts/{contactId}",
              "segments": [
                {
                  "lit": "contacts"
                },
                {
                  "var": "id"
                }
              ],
              "parts": [
                "contacts",
                "{id}"
              ],
              "rename": {
                "param": {
                  "contactId": "id"
                }
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {
                "params": [
                  {
                    "name": "id",
                    "orig": "contactId",
                    "type": "`$STRING`",
                    "kind": "param",
                    "reqd": true,
                    "example": "0f0f0f0f0f0f0f0f0f0f0f0f"
                  }
                ]
              },
              "select": {
                "exist": [
                  "id"
                ]
              }
            },
            {
              "kind": "http",
              "method": "DELETE",
              "orig": "/contacts",
              "segments": [
                {
                  "lit": "contacts"
                }
              ],
              "parts": [
                "contacts"
              ],
              "rename": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {},
              "select": {}
            }
          ]
        },
        "update": {
          "input": "data",
          "name": "update",
          "points": [
            {
              "kind": "http",
              "method": "PUT",
              "orig": "/contacts/groups/{groupId}/members/{contactId}",
              "segments": [
                {
                  "lit": "contacts"
                },
                {
                  "lit": "groups"
                },
                {
                  "var": "group_id"
                },
                {
                  "lit": "members"
                },
                {
                  "var": "contact_id"
                }
              ],
              "parts": [
                "contacts",
                "groups",
                "{group_id}",
                "members",
                "{contact_id}"
              ],
              "rename": {
                "param": {
                  "contactId": "contact_id",
                  "groupId": "group_id"
                }
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {
                "params": [
                  {
                    "name": "contact_id",
                    "orig": "contactId",
                    "type": "`$STRING`",
                    "kind": "param",
                    "reqd": true,
                    "example": "0f0f0f0f0f0f0f0f0f0f0f0f"
                  },
                  {
                    "name": "group_id",
                    "orig": "groupId",
                    "type": "`$STRING`",
                    "kind": "param",
                    "reqd": true,
                    "example": "0f0f0f0f0f0f0f0f0f0f0f0f"
                  }
                ]
              },
              "select": {
                "exist": [
                  "contact_id",
                  "group_id"
                ]
              }
            },
            {
              "kind": "http",
              "method": "PUT",
              "orig": "/contacts/{contactId}/groups/{groupId}",
              "segments": [
                {
                  "lit": "contacts"
                },
                {
                  "var": "id"
                },
                {
                  "lit": "groups"
                },
                {
                  "var": "group_id"
                }
              ],
              "parts": [
                "contacts",
                "{id}",
                "groups",
                "{group_id}"
              ],
              "rename": {
                "param": {
                  "contactId": "id",
                  "groupId": "group_id"
                }
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {
                "params": [
                  {
                    "name": "group_id",
                    "orig": "groupId",
                    "type": "`$STRING`",
                    "kind": "param",
                    "reqd": true,
                    "example": "0f0f0f0f0f0f0f0f0f0f0f0f"
                  },
                  {
                    "name": "id",
                    "orig": "contactId",
                    "type": "`$STRING`",
                    "kind": "param",
                    "reqd": true,
                    "example": "0f0f0f0f0f0f0f0f0f0f0f0f"
                  }
                ]
              },
              "select": {
                "exist": [
                  "group_id",
                  "id"
                ]
              }
            },
            {
              "kind": "http",
              "method": "PUT",
              "orig": "/contacts/{contactId}",
              "segments": [
                {
                  "lit": "contacts"
                },
                {
                  "var": "id"
                }
              ],
              "parts": [
                "contacts",
                "{id}"
              ],
              "rename": {
                "param": {
                  "contactId": "id"
                }
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {
                "params": [
                  {
                    "name": "id",
                    "orig": "contactId",
                    "type": "`$STRING`",
                    "kind": "param",
                    "reqd": true,
                    "example": "0f0f0f0f0f0f0f0f0f0f0f0f"
                  }
                ]
              },
              "select": {
                "exist": [
                  "id"
                ]
              }
            }
          ]
        }
      },
      "relations": {
        "ancestors": [
          [
            "$.main.kit.entity.group"
          ],
          [
            "$.main.kit.entity.group"
          ]
        ]
      }
    },
    "contacts_field": {
      "fields": [
        {
          "name": "birthday_date",
          "title": "Birthday Date",
          "type": "`$STRING`",
          "format": "date"
        },
        {
          "name": "city",
          "title": "City",
          "type": "`$STRING`"
        },
        {
          "name": "contact_expire_after",
          "title": "Contact Expire After",
          "type": "`$INTEGER`",
          "req": true,
          "short": "Contact expire after days"
        },
        {
          "name": "contacts_count",
          "title": "Contacts Count",
          "type": "`$INTEGER`"
        },
        {
          "name": "country",
          "title": "Country",
          "type": "`$STRING`"
        },
        {
          "name": "created_by",
          "title": "Created By",
          "type": "`$STRING`",
          "req": true
        },
        {
          "name": "date_created",
          "title": "Date Created",
          "type": "`$STRING`",
          "req": true,
          "format": "date-time"
        },
        {
          "name": "date_updated",
          "title": "Date Updated",
          "type": "`$STRING`",
          "req": true,
          "format": "date-time"
        },
        {
          "name": "description",
          "title": "Description",
          "type": "`$STRING`"
        },
        {
          "name": "email",
          "title": "Email",
          "type": "`$STRING`",
          "format": "email"
        },
        {
          "name": "first_name",
          "title": "First Name",
          "type": "`$STRING`"
        },
        {
          "name": "gender",
          "title": "Gender",
          "type": "`$STRING`",
          "req": true
        },
        {
          "name": "group_id",
          "title": "Group Id",
          "type": "`$STRING`",
          "short": "Object ID",
          "format": "oid"
        },
        {
          "name": "groups",
          "title": "Groups",
          "type": "`$ARRAY`",
          "req": true
        },
        {
          "name": "id",
          "title": "Id",
          "type": "`$STRING`",
          "op": {
            "list": {
              "req": true,
              "type": "`$STRING`"
            }
          },
          "short": "Object ID",
          "format": "oid"
        },
        {
          "name": "idx",
          "title": "Idx",
          "type": "`$STRING`",
          "short": "User provided resource id"
        },
        {
          "name": "last_name",
          "title": "Last Name",
          "type": "`$STRING`"
        },
        {
          "name": "name",
          "title": "Name",
          "type": "`$STRING`",
          "short": "Group name"
        },
        {
          "name": "permissions",
          "title": "Permissions",
          "type": "`$ARRAY`"
        },
        {
          "name": "phone_number",
          "title": "Phone Number",
          "type": "`$STRING`"
        },
        {
          "name": "read",
          "title": "Read",
          "type": "`$BOOLEAN`",
          "short": "Has read permission"
        },
        {
          "name": "send",
          "title": "Send",
          "type": "`$BOOLEAN`",
          "short": "Has send permission"
        },
        {
          "name": "source",
          "title": "Source",
          "type": "`$STRING`"
        },
        {
          "name": "type",
          "title": "Type",
          "type": "`$STRING`"
        },
        {
          "name": "username",
          "title": "Username",
          "type": "`$STRING`"
        },
        {
          "name": "value",
          "title": "Value",
          "type": "`$STRING`"
        },
        {
          "name": "write",
          "title": "Write",
          "type": "`$BOOLEAN`",
          "short": "Has write permission"
        }
      ],
      "id": {
        "field": "id",
        "name": "id"
      },
      "name": "contacts_field",
      "op": {
        "create": {
          "input": "data",
          "name": "create",
          "points": [
            {
              "kind": "http",
              "method": "POST",
              "orig": "/contacts/fields",
              "segments": [
                {
                  "lit": "contacts"
                },
                {
                  "lit": "fields"
                }
              ],
              "parts": [
                "contacts",
                "fields"
              ],
              "rename": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {},
              "select": {}
            }
          ]
        },
        "list": {
          "input": "data",
          "name": "list",
          "points": [
            {
              "kind": "http",
              "method": "GET",
              "orig": "/contacts/fields",
              "segments": [
                {
                  "lit": "contacts"
                },
                {
                  "lit": "fields"
                }
              ],
              "parts": [
                "contacts",
                "fields"
              ],
              "rename": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body.collection`"
              },
              "args": {},
              "select": {}
            }
          ]
        },
        "remove": {
          "input": "data",
          "name": "remove",
          "points": [
            {
              "kind": "http",
              "method": "DELETE",
              "orig": "/contacts/fields/{fieldId}",
              "segments": [
                {
                  "lit": "contacts"
                },
                {
                  "lit": "fields"
                },
                {
                  "var": "id"
                }
              ],
              "parts": [
                "contacts",
                "fields",
                "{id}"
              ],
              "rename": {
                "param": {
                  "fieldId": "id"
                }
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {
                "params": [
                  {
                    "name": "id",
                    "orig": "fieldId",
                    "type": "`$STRING`",
                    "kind": "param",
                    "reqd": true,
                    "example": "0f0f0f0f0f0f0f0f0f0f0f0f"
                  }
                ]
              },
              "select": {
                "exist": [
                  "id"
                ]
              }
            }
          ]
        },
        "update": {
          "input": "data",
          "name": "update",
          "points": [
            {
              "kind": "http",
              "method": "PUT",
              "orig": "/contacts/fields/{fieldId}",
              "segments": [
                {
                  "lit": "contacts"
                },
                {
                  "lit": "fields"
                },
                {
                  "var": "id"
                }
              ],
              "parts": [
                "contacts",
                "fields",
                "{id}"
              ],
              "rename": {
                "param": {
                  "fieldId": "id"
                }
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {
                "params": [
                  {
                    "name": "id",
                    "orig": "fieldId",
                    "type": "`$STRING`",
                    "kind": "param",
                    "reqd": true,
                    "example": "0f0f0f0f0f0f0f0f0f0f0f0f"
                  }
                ]
              },
              "select": {
                "exist": [
                  "id"
                ]
              }
            }
          ]
        }
      },
      "relations": {
        "ancestors": []
      }
    },
    "contacts_field_option": {
      "fields": [
        {
          "name": "birthday_date",
          "title": "Birthday Date",
          "type": "`$STRING`",
          "format": "date"
        },
        {
          "name": "city",
          "title": "City",
          "type": "`$STRING`"
        },
        {
          "name": "contact_expire_after",
          "title": "Contact Expire After",
          "type": "`$INTEGER`",
          "req": true,
          "short": "Contact expire after days"
        },
        {
          "name": "contacts_count",
          "title": "Contacts Count",
          "type": "`$INTEGER`"
        },
        {
          "name": "country",
          "title": "Country",
          "type": "`$STRING`"
        },
        {
          "name": "created_by",
          "title": "Created By",
          "type": "`$STRING`",
          "req": true
        },
        {
          "name": "date_created",
          "title": "Date Created",
          "type": "`$STRING`",
          "req": true,
          "format": "date-time"
        },
        {
          "name": "date_updated",
          "title": "Date Updated",
          "type": "`$STRING`",
          "req": true,
          "format": "date-time"
        },
        {
          "name": "description",
          "title": "Description",
          "type": "`$STRING`"
        },
        {
          "name": "email",
          "title": "Email",
          "type": "`$STRING`",
          "format": "email"
        },
        {
          "name": "first_name",
          "title": "First Name",
          "type": "`$STRING`"
        },
        {
          "name": "gender",
          "title": "Gender",
          "type": "`$STRING`",
          "req": true
        },
        {
          "name": "group_id",
          "title": "Group Id",
          "type": "`$STRING`",
          "short": "Object ID",
          "format": "oid"
        },
        {
          "name": "groups",
          "title": "Groups",
          "type": "`$ARRAY`",
          "req": true
        },
        {
          "name": "id",
          "title": "Id",
          "type": "`$STRING`",
          "req": true,
          "short": "Object ID",
          "format": "oid"
        },
        {
          "name": "idx",
          "title": "Idx",
          "type": "`$STRING`",
          "short": "User provided resource id"
        },
        {
          "name": "last_name",
          "title": "Last Name",
          "type": "`$STRING`"
        },
        {
          "name": "name",
          "title": "Name",
          "type": "`$STRING`",
          "short": "Group name"
        },
        {
          "name": "permissions",
          "title": "Permissions",
          "type": "`$ARRAY`"
        },
        {
          "name": "phone_number",
          "title": "Phone Number",
          "type": "`$STRING`"
        },
        {
          "name": "read",
          "title": "Read",
          "type": "`$BOOLEAN`",
          "short": "Has read permission"
        },
        {
          "name": "send",
          "title": "Send",
          "type": "`$BOOLEAN`",
          "short": "Has send permission"
        },
        {
          "name": "source",
          "title": "Source",
          "type": "`$STRING`"
        },
        {
          "name": "type",
          "title": "Type",
          "type": "`$STRING`"
        },
        {
          "name": "username",
          "title": "Username",
          "type": "`$STRING`"
        },
        {
          "name": "value",
          "title": "Value",
          "type": "`$STRING`"
        },
        {
          "name": "write",
          "title": "Write",
          "type": "`$BOOLEAN`",
          "short": "Has write permission"
        }
      ],
      "id": {
        "field": "id",
        "name": "id"
      },
      "name": "contacts_field_option",
      "op": {
        "list": {
          "input": "data",
          "name": "list",
          "points": [
            {
              "kind": "http",
              "method": "GET",
              "orig": "/contacts/fields/{fieldId}/options",
              "segments": [
                {
                  "lit": "contacts"
                },
                {
                  "lit": "fields"
                },
                {
                  "var": "field_id"
                },
                {
                  "lit": "options"
                }
              ],
              "parts": [
                "contacts",
                "fields",
                "{field_id}",
                "options"
              ],
              "rename": {
                "param": {
                  "fieldId": "field_id"
                }
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body.collection`"
              },
              "args": {
                "params": [
                  {
                    "name": "field_id",
                    "orig": "fieldId",
                    "type": "`$STRING`",
                    "kind": "param",
                    "reqd": true,
                    "example": "0f0f0f0f0f0f0f0f0f0f0f0f"
                  }
                ]
              },
              "select": {
                "exist": [
                  "field_id"
                ]
              }
            }
          ]
        }
      },
      "relations": {
        "ancestors": []
      }
    },
    "contactsgroup": {
      "fields": [
        {
          "name": "birthday_date",
          "title": "Birthday Date",
          "type": "`$STRING`",
          "format": "date"
        },
        {
          "name": "city",
          "title": "City",
          "type": "`$STRING`"
        },
        {
          "name": "contact_expire_after",
          "title": "Contact Expire After",
          "type": "`$INTEGER`",
          "req": true,
          "short": "Contact expire after days"
        },
        {
          "name": "contacts_count",
          "title": "Contacts Count",
          "type": "`$INTEGER`"
        },
        {
          "name": "country",
          "title": "Country",
          "type": "`$STRING`"
        },
        {
          "name": "created_by",
          "title": "Created By",
          "type": "`$STRING`",
          "req": true
        },
        {
          "name": "date_created",
          "title": "Date Created",
          "type": "`$STRING`",
          "req": true,
          "format": "date-time"
        },
        {
          "name": "date_updated",
          "title": "Date Updated",
          "type": "`$STRING`",
          "req": true,
          "format": "date-time"
        },
        {
          "name": "description",
          "title": "Description",
          "type": "`$STRING`"
        },
        {
          "name": "email",
          "title": "Email",
          "type": "`$STRING`",
          "format": "email"
        },
        {
          "name": "first_name",
          "title": "First Name",
          "type": "`$STRING`"
        },
        {
          "name": "gender",
          "title": "Gender",
          "type": "`$STRING`",
          "req": true
        },
        {
          "name": "group_id",
          "title": "Group Id",
          "type": "`$STRING`",
          "req": true,
          "op": {
            "list": {
              "type": "`$STRING`"
            }
          },
          "short": "Object ID",
          "format": "oid"
        },
        {
          "name": "groups",
          "title": "Groups",
          "type": "`$ARRAY`",
          "req": true
        },
        {
          "name": "id",
          "title": "Id",
          "type": "`$STRING`",
          "req": true,
          "short": "Object ID",
          "format": "oid"
        },
        {
          "name": "idx",
          "title": "Idx",
          "type": "`$STRING`",
          "short": "User provided resource id"
        },
        {
          "name": "last_name",
          "title": "Last Name",
          "type": "`$STRING`"
        },
        {
          "name": "name",
          "title": "Name",
          "type": "`$STRING`",
          "short": "Group name"
        },
        {
          "name": "permissions",
          "title": "Permissions",
          "type": "`$ARRAY`"
        },
        {
          "name": "phone_number",
          "title": "Phone Number",
          "type": "`$STRING`"
        },
        {
          "name": "read",
          "title": "Read",
          "type": "`$BOOLEAN`",
          "req": true,
          "op": {
            "list": {
              "type": "`$BOOLEAN`"
            }
          },
          "short": "Has read permission"
        },
        {
          "name": "send",
          "title": "Send",
          "type": "`$BOOLEAN`",
          "req": true,
          "op": {
            "list": {
              "type": "`$BOOLEAN`"
            }
          },
          "short": "Has send permission"
        },
        {
          "name": "source",
          "title": "Source",
          "type": "`$STRING`"
        },
        {
          "name": "type",
          "title": "Type",
          "type": "`$STRING`"
        },
        {
          "name": "username",
          "title": "Username",
          "type": "`$STRING`",
          "req": true,
          "op": {
            "list": {
              "type": "`$STRING`"
            }
          }
        },
        {
          "name": "value",
          "title": "Value",
          "type": "`$STRING`"
        },
        {
          "name": "write",
          "title": "Write",
          "type": "`$BOOLEAN`",
          "req": true,
          "op": {
            "list": {
              "type": "`$BOOLEAN`"
            }
          },
          "short": "Has write permission"
        }
      ],
      "id": {
        "field": "id",
        "name": "id"
      },
      "name": "contactsgroup",
      "op": {
        "create": {
          "input": "data",
          "name": "create",
          "points": [
            {
              "kind": "http",
              "method": "POST",
              "orig": "/contacts/groups/{groupId}/members",
              "segments": [
                {
                  "lit": "contacts"
                },
                {
                  "lit": "groups"
                },
                {
                  "var": "group_id"
                },
                {
                  "lit": "members"
                }
              ],
              "parts": [
                "contacts",
                "groups",
                "{group_id}",
                "members"
              ],
              "rename": {
                "param": {
                  "groupId": "group_id"
                }
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {
                "params": [
                  {
                    "name": "group_id",
                    "orig": "groupId",
                    "type": "`$STRING`",
                    "kind": "param",
                    "reqd": true,
                    "example": "0f0f0f0f0f0f0f0f0f0f0f0f"
                  }
                ]
              },
              "select": {
                "exist": [
                  "group_id"
                ]
              }
            },
            {
              "kind": "http",
              "method": "POST",
              "orig": "/contacts/groups",
              "segments": [
                {
                  "lit": "contacts"
                },
                {
                  "lit": "groups"
                }
              ],
              "parts": [
                "contacts",
                "groups"
              ],
              "rename": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {},
              "select": {}
            }
          ]
        },
        "list": {
          "input": "data",
          "name": "list",
          "points": [
            {
              "kind": "http",
              "method": "GET",
              "orig": "/contacts/groups",
              "segments": [
                {
                  "lit": "contacts"
                },
                {
                  "lit": "groups"
                }
              ],
              "parts": [
                "contacts",
                "groups"
              ],
              "rename": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body.collection`"
              },
              "args": {
                "query": [
                  {
                    "name": "name",
                    "orig": "name",
                    "type": "`$OBJECT`",
                    "kind": "query",
                    "example": "{\"name\" : \"group name\"}"
                  },
                  {
                    "name": "with",
                    "orig": "with",
                    "type": "`$ARRAY`",
                    "kind": "query"
                  }
                ]
              },
              "select": {
                "exist": [
                  "name",
                  "with"
                ]
              }
            },
            {
              "kind": "http",
              "method": "GET",
              "orig": "/contacts/groups/{groupId}/permissions",
              "segments": [
                {
                  "lit": "contacts"
                },
                {
                  "lit": "groups"
                },
                {
                  "var": "group_id"
                },
                {
                  "lit": "permissions"
                }
              ],
              "parts": [
                "contacts",
                "groups",
                "{group_id}",
                "permissions"
              ],
              "rename": {
                "param": {
                  "groupId": "group_id"
                }
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body.collection`"
              },
              "args": {
                "params": [
                  {
                    "name": "group_id",
                    "orig": "groupId",
                    "type": "`$STRING`",
                    "kind": "param",
                    "reqd": true,
                    "example": "0f0f0f0f0f0f0f0f0f0f0f0f"
                  }
                ]
              },
              "select": {
                "exist": [
                  "group_id"
                ]
              }
            }
          ]
        },
        "remove": {
          "input": "data",
          "name": "remove",
          "points": [
            {
              "kind": "http",
              "method": "DELETE",
              "orig": "/contacts/groups/{groupId}/members/{contactId}",
              "segments": [
                {
                  "lit": "contacts"
                },
                {
                  "lit": "groups"
                },
                {
                  "var": "group_id"
                },
                {
                  "lit": "members"
                },
                {
                  "var": "contact_id"
                }
              ],
              "parts": [
                "contacts",
                "groups",
                "{group_id}",
                "members",
                "{contact_id}"
              ],
              "rename": {
                "param": {
                  "contactId": "contact_id",
                  "groupId": "group_id"
                }
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {
                "params": [
                  {
                    "name": "contact_id",
                    "orig": "contactId",
                    "type": "`$STRING`",
                    "kind": "param",
                    "reqd": true,
                    "example": "0f0f0f0f0f0f0f0f0f0f0f0f"
                  },
                  {
                    "name": "group_id",
                    "orig": "groupId",
                    "type": "`$STRING`",
                    "kind": "param",
                    "reqd": true,
                    "example": "0f0f0f0f0f0f0f0f0f0f0f0f"
                  }
                ]
              },
              "select": {
                "exist": [
                  "contact_id",
                  "group_id"
                ]
              }
            },
            {
              "kind": "http",
              "method": "DELETE",
              "orig": "/contacts/groups/{groupId}/permissions/{username}",
              "segments": [
                {
                  "lit": "contacts"
                },
                {
                  "lit": "groups"
                },
                {
                  "var": "group_id"
                },
                {
                  "lit": "permissions"
                },
                {
                  "var": "username"
                }
              ],
              "parts": [
                "contacts",
                "groups",
                "{group_id}",
                "permissions",
                "{username}"
              ],
              "rename": {
                "param": {
                  "groupId": "group_id"
                }
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {
                "params": [
                  {
                    "name": "group_id",
                    "orig": "groupId",
                    "type": "`$STRING`",
                    "kind": "param",
                    "reqd": true,
                    "example": "0f0f0f0f0f0f0f0f0f0f0f0f"
                  },
                  {
                    "name": "username",
                    "orig": "username",
                    "type": "`$STRING`",
                    "kind": "param",
                    "reqd": true
                  }
                ],
                "query": [
                  {
                    "name": "username",
                    "orig": "username",
                    "type": "`$STRING`",
                    "kind": "query",
                    "reqd": true,
                    "example": "example_username"
                  }
                ]
              },
              "select": {
                "exist": [
                  "group_id",
                  "username"
                ]
              }
            },
            {
              "kind": "http",
              "method": "DELETE",
              "orig": "/contacts/groups/{groupId}",
              "segments": [
                {
                  "lit": "contacts"
                },
                {
                  "lit": "groups"
                },
                {
                  "var": "group_id"
                }
              ],
              "parts": [
                "contacts",
                "groups",
                "{group_id}"
              ],
              "rename": {
                "param": {
                  "groupId": "group_id"
                }
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {
                "params": [
                  {
                    "name": "group_id",
                    "orig": "groupId",
                    "type": "`$STRING`",
                    "kind": "param",
                    "reqd": true,
                    "example": "0f0f0f0f0f0f0f0f0f0f0f0f"
                  }
                ]
              },
              "select": {
                "exist": [
                  "group_id"
                ]
              }
            },
            {
              "kind": "http",
              "method": "DELETE",
              "orig": "/contacts/groups/{groupId}/members",
              "segments": [
                {
                  "lit": "contacts"
                },
                {
                  "lit": "groups"
                },
                {
                  "var": "group_id"
                },
                {
                  "lit": "members"
                }
              ],
              "parts": [
                "contacts",
                "groups",
                "{group_id}",
                "members"
              ],
              "rename": {
                "param": {
                  "groupId": "group_id"
                }
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {
                "params": [
                  {
                    "name": "group_id",
                    "orig": "groupId",
                    "type": "`$STRING`",
                    "kind": "param",
                    "reqd": true,
                    "example": "0f0f0f0f0f0f0f0f0f0f0f0f"
                  }
                ]
              },
              "select": {
                "exist": [
                  "group_id"
                ]
              }
            },
            {
              "kind": "http",
              "method": "DELETE",
              "orig": "/contacts/groups",
              "segments": [
                {
                  "lit": "contacts"
                },
                {
                  "lit": "groups"
                }
              ],
              "parts": [
                "contacts",
                "groups"
              ],
              "rename": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {},
              "select": {}
            }
          ]
        },
        "update": {
          "input": "data",
          "name": "update",
          "points": [
            {
              "kind": "http",
              "method": "PUT",
              "orig": "/contacts/groups/{groupId}/permissions/{username}",
              "segments": [
                {
                  "lit": "contacts"
                },
                {
                  "lit": "groups"
                },
                {
                  "var": "group_id"
                },
                {
                  "lit": "permissions"
                },
                {
                  "var": "username"
                }
              ],
              "parts": [
                "contacts",
                "groups",
                "{group_id}",
                "permissions",
                "{username}"
              ],
              "rename": {
                "param": {
                  "groupId": "group_id"
                }
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {
                "params": [
                  {
                    "name": "group_id",
                    "orig": "groupId",
                    "type": "`$STRING`",
                    "kind": "param",
                    "reqd": true,
                    "example": "0f0f0f0f0f0f0f0f0f0f0f0f"
                  },
                  {
                    "name": "username",
                    "orig": "username",
                    "type": "`$STRING`",
                    "kind": "param",
                    "reqd": true
                  }
                ],
                "query": [
                  {
                    "name": "username",
                    "orig": "username",
                    "type": "`$STRING`",
                    "kind": "query",
                    "reqd": true,
                    "example": "example_username"
                  }
                ]
              },
              "select": {
                "exist": [
                  "group_id",
                  "username"
                ]
              }
            },
            {
              "kind": "http",
              "method": "PUT",
              "orig": "/contacts/groups/{groupId}/members",
              "segments": [
                {
                  "lit": "contacts"
                },
                {
                  "lit": "groups"
                },
                {
                  "var": "group_id"
                },
                {
                  "lit": "members"
                }
              ],
              "parts": [
                "contacts",
                "groups",
                "{group_id}",
                "members"
              ],
              "rename": {
                "param": {
                  "groupId": "group_id"
                }
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {
                "params": [
                  {
                    "name": "group_id",
                    "orig": "groupId",
                    "type": "`$STRING`",
                    "kind": "param",
                    "reqd": true,
                    "example": "0f0f0f0f0f0f0f0f0f0f0f0f"
                  }
                ]
              },
              "select": {
                "exist": [
                  "group_id"
                ]
              }
            }
          ]
        }
      },
      "relations": {
        "ancestors": [
          [
            "$.main.kit.entity.group"
          ],
          [
            "$.main.kit.entity.group"
          ],
          [
            "$.main.kit.entity.group",
            "$.main.kit.entity.permission"
          ]
        ]
      }
    },
    "contactstrash": {
      "fields": [],
      "name": "contactstrash",
      "op": {
        "remove": {
          "input": "data",
          "name": "remove",
          "points": [
            {
              "kind": "http",
              "method": "DELETE",
              "orig": "/contacts/trash",
              "segments": [
                {
                  "lit": "contacts"
                },
                {
                  "lit": "trash"
                }
              ],
              "parts": [
                "contacts",
                "trash"
              ],
              "rename": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {},
              "select": {}
            }
          ]
        },
        "update": {
          "input": "data",
          "name": "update",
          "points": [
            {
              "kind": "http",
              "method": "PUT",
              "orig": "/contacts/trash/restore",
              "segments": [
                {
                  "lit": "contacts"
                },
                {
                  "lit": "trash"
                },
                {
                  "lit": "restore"
                }
              ],
              "parts": [
                "contacts",
                "trash",
                "restore"
              ],
              "rename": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {},
              "select": {}
            }
          ]
        }
      },
      "relations": {
        "ancestors": []
      }
    },
    "field_available": {
      "fields": [
        {
          "name": "built_in",
          "title": "Built In",
          "type": "`$BOOLEAN`"
        },
        {
          "name": "id",
          "title": "Id",
          "type": "`$STRING`",
          "short": "Object ID",
          "format": "oid"
        },
        {
          "name": "name",
          "title": "Name",
          "type": "`$STRING`"
        },
        {
          "name": "options",
          "title": "Options",
          "type": "`$ARRAY`"
        },
        {
          "name": "type",
          "title": "Type",
          "type": "`$STRING`"
        }
      ],
      "id": {
        "field": "id",
        "name": "id"
      },
      "name": "field_available",
      "op": {
        "list": {
          "input": "data",
          "name": "list",
          "points": [
            {
              "kind": "http",
              "method": "GET",
              "orig": "/contacts/fields/available",
              "segments": [
                {
                  "lit": "contacts"
                },
                {
                  "lit": "fields"
                },
                {
                  "lit": "available"
                }
              ],
              "parts": [
                "contacts",
                "fields",
                "available"
              ],
              "rename": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {},
              "select": {}
            }
          ]
        }
      },
      "relations": {
        "ancestors": []
      }
    },
    "group": {
      "fields": [
        {
          "name": "contact_expire_after",
          "title": "Contact Expire After",
          "type": "`$INTEGER`",
          "req": true,
          "short": "Contact expire after days"
        },
        {
          "name": "contacts_count",
          "title": "Contacts Count",
          "type": "`$INTEGER`",
          "req": true
        },
        {
          "name": "created_by",
          "title": "Created By",
          "type": "`$STRING`",
          "req": true
        },
        {
          "name": "date_created",
          "title": "Date Created",
          "type": "`$STRING`",
          "req": true,
          "format": "date-time"
        },
        {
          "name": "date_updated",
          "title": "Date Updated",
          "type": "`$STRING`",
          "req": true,
          "format": "date-time"
        },
        {
          "name": "description",
          "title": "Description",
          "type": "`$STRING`",
          "req": true
        },
        {
          "name": "id",
          "title": "Id",
          "type": "`$STRING`",
          "req": true,
          "short": "Object ID",
          "format": "oid"
        },
        {
          "name": "idx",
          "title": "Idx",
          "type": "`$STRING`",
          "short": "User provided resource id"
        },
        {
          "name": "name",
          "title": "Name",
          "type": "`$STRING`",
          "req": true,
          "short": "Group name"
        },
        {
          "name": "permissions",
          "title": "Permissions",
          "type": "`$ARRAY`"
        }
      ],
      "id": {
        "field": "id",
        "name": "id"
      },
      "name": "group",
      "op": {
        "load": {
          "input": "data",
          "name": "load",
          "points": [
            {
              "kind": "http",
              "method": "GET",
              "orig": "/contacts/groups/{groupId}",
              "segments": [
                {
                  "lit": "contacts"
                },
                {
                  "lit": "groups"
                },
                {
                  "var": "id"
                }
              ],
              "parts": [
                "contacts",
                "groups",
                "{id}"
              ],
              "rename": {
                "param": {
                  "groupId": "id"
                }
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {
                "params": [
                  {
                    "name": "id",
                    "orig": "groupId",
                    "type": "`$STRING`",
                    "kind": "param",
                    "reqd": true,
                    "example": "0f0f0f0f0f0f0f0f0f0f0f0f"
                  }
                ]
              },
              "select": {
                "exist": [
                  "id"
                ]
              }
            }
          ]
        },
        "update": {
          "input": "data",
          "name": "update",
          "points": [
            {
              "kind": "http",
              "method": "PUT",
              "orig": "/contacts/groups/{groupId}",
              "segments": [
                {
                  "lit": "contacts"
                },
                {
                  "lit": "groups"
                },
                {
                  "var": "id"
                }
              ],
              "parts": [
                "contacts",
                "groups",
                "{id}"
              ],
              "rename": {
                "param": {
                  "groupId": "id"
                }
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {
                "params": [
                  {
                    "name": "id",
                    "orig": "groupId",
                    "type": "`$STRING`",
                    "kind": "param",
                    "reqd": true,
                    "example": "0f0f0f0f0f0f0f0f0f0f0f0f"
                  }
                ]
              },
              "select": {
                "exist": [
                  "id"
                ]
              }
            }
          ]
        }
      },
      "relations": {
        "ancestors": []
      }
    },
    "mfa_code": {
      "fields": [
        {
          "name": "content",
          "title": "Content",
          "type": "`$STRING`",
          "short": "Custom content that must contain placeholder [%code%]"
        },
        {
          "name": "fast",
          "title": "Fast",
          "type": "`$ANY`"
        },
        {
          "name": "from",
          "title": "From",
          "type": "`$STRING`",
          "short": "Sendername"
        },
        {
          "name": "phone_number",
          "title": "Phone Number",
          "type": "`$STRING`",
          "req": true
        }
      ],
      "name": "mfa_code",
      "op": {
        "create": {
          "input": "data",
          "name": "create",
          "points": [
            {
              "kind": "http",
              "method": "POST",
              "orig": "/mfa/codes",
              "segments": [
                {
                  "lit": "mfa"
                },
                {
                  "lit": "codes"
                }
              ],
              "parts": [
                "mfa",
                "codes"
              ],
              "rename": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {},
              "select": {}
            },
            {
              "kind": "http",
              "method": "POST",
              "orig": "/mfa/codes/verifications",
              "segments": [
                {
                  "lit": "mfa"
                },
                {
                  "lit": "codes"
                },
                {
                  "lit": "verifications"
                }
              ],
              "parts": [
                "mfa",
                "codes",
                "verifications"
              ],
              "rename": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {},
              "select": {
                "$action": "verification"
              }
            }
          ]
        }
      },
      "relations": {
        "ancestors": []
      }
    },
    "opt_out": {
      "fields": [
        {
          "name": "date",
          "title": "Date",
          "type": "`$STRING`",
          "format": "date-time"
        },
        {
          "name": "id",
          "title": "Id",
          "type": "`$STRING`"
        },
        {
          "name": "links",
          "title": "Links",
          "type": "`$ARRAY`"
        },
        {
          "name": "phoneNumber",
          "title": "Phone Number",
          "type": "`$INTEGER`"
        }
      ],
      "id": {
        "field": "id",
        "name": "id"
      },
      "name": "opt_out",
      "op": {
        "list": {
          "input": "data",
          "name": "list",
          "points": [
            {
              "kind": "http",
              "method": "GET",
              "orig": "/opt_outs",
              "segments": [
                {
                  "lit": "opt_outs"
                }
              ],
              "parts": [
                "opt_outs"
              ],
              "rename": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body.collection`"
              },
              "args": {
                "header": [
                  {
                    "name": "accept",
                    "orig": "Accept",
                    "type": "`$STRING`",
                    "kind": "header",
                    "example": "application/json"
                  },
                  {
                    "name": "x_async",
                    "orig": "x-async",
                    "type": "`$BOOLEAN`",
                    "kind": "header",
                    "example": false
                  }
                ],
                "query": [
                  {
                    "name": "limit",
                    "orig": "limit",
                    "type": "`$INTEGER`",
                    "kind": "query",
                    "example": 5
                  },
                  {
                    "name": "offset",
                    "orig": "offset",
                    "type": "`$INTEGER`",
                    "kind": "query",
                    "example": 0
                  },
                  {
                    "name": "phone_number",
                    "orig": "phone_number",
                    "type": "`$STRING`",
                    "kind": "query"
                  }
                ]
              },
              "select": {
                "exist": [
                  "accept",
                  "limit",
                  "offset",
                  "phone_number",
                  "x_async"
                ]
              }
            }
          ]
        },
        "remove": {
          "input": "data",
          "name": "remove",
          "points": [
            {
              "kind": "http",
              "method": "DELETE",
              "orig": "/opt_outs/{optOutId}",
              "segments": [
                {
                  "lit": "opt_outs"
                },
                {
                  "var": "id"
                }
              ],
              "parts": [
                "opt_outs",
                "{id}"
              ],
              "rename": {
                "param": {
                  "optOutId": "id"
                }
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {
                "params": [
                  {
                    "name": "id",
                    "orig": "optOutId",
                    "type": "`$STRING`",
                    "kind": "param",
                    "reqd": true
                  }
                ]
              },
              "select": {
                "exist": [
                  "id"
                ]
              }
            }
          ]
        }
      },
      "relations": {
        "ancestors": []
      }
    },
    "opt_out_setting": {
      "fields": [
        {
          "name": "brand",
          "title": "Brand",
          "type": "`$STRING`"
        }
      ],
      "name": "opt_out_setting",
      "op": {
        "load": {
          "input": "data",
          "name": "load",
          "points": [
            {
              "kind": "http",
              "method": "GET",
              "orig": "/opt_outs/settings",
              "segments": [
                {
                  "lit": "opt_outs"
                },
                {
                  "lit": "settings"
                }
              ],
              "parts": [
                "opt_outs",
                "settings"
              ],
              "rename": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {},
              "select": {}
            }
          ]
        },
        "update": {
          "input": "data",
          "name": "update",
          "points": [
            {
              "kind": "http",
              "method": "PUT",
              "orig": "/opt_outs/settings",
              "segments": [
                {
                  "lit": "opt_outs"
                },
                {
                  "lit": "settings"
                }
              ],
              "parts": [
                "opt_outs",
                "settings"
              ],
              "rename": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {},
              "select": {}
            }
          ]
        }
      },
      "relations": {
        "ancestors": []
      }
    },
    "permission": {
      "fields": [
        {
          "name": "group_id",
          "title": "Group Id",
          "type": "`$STRING`",
          "req": true,
          "short": "Object ID",
          "format": "oid"
        },
        {
          "name": "id",
          "title": "Id",
          "type": "`$STRING`"
        },
        {
          "name": "read",
          "title": "Read",
          "type": "`$BOOLEAN`",
          "req": true,
          "short": "Has read permission"
        },
        {
          "name": "send",
          "title": "Send",
          "type": "`$BOOLEAN`",
          "req": true,
          "short": "Has send permission"
        },
        {
          "name": "username",
          "title": "Username",
          "type": "`$STRING`",
          "req": true
        },
        {
          "name": "write",
          "title": "Write",
          "type": "`$BOOLEAN`",
          "req": true,
          "short": "Has write permission"
        }
      ],
      "id": {
        "field": "id",
        "name": "id"
      },
      "name": "permission",
      "op": {
        "create": {
          "input": "data",
          "name": "create",
          "points": [
            {
              "kind": "http",
              "method": "POST",
              "orig": "/contacts/groups/{groupId}/permissions",
              "segments": [
                {
                  "lit": "contacts"
                },
                {
                  "lit": "groups"
                },
                {
                  "var": "group_id"
                },
                {
                  "lit": "permissions"
                }
              ],
              "parts": [
                "contacts",
                "groups",
                "{group_id}",
                "permissions"
              ],
              "rename": {
                "param": {
                  "groupId": "group_id"
                }
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {
                "params": [
                  {
                    "name": "group_id",
                    "orig": "groupId",
                    "type": "`$STRING`",
                    "kind": "param",
                    "reqd": true,
                    "example": "0f0f0f0f0f0f0f0f0f0f0f0f"
                  }
                ]
              },
              "select": {
                "exist": [
                  "group_id"
                ]
              }
            }
          ]
        },
        "load": {
          "input": "data",
          "name": "load",
          "points": [
            {
              "kind": "http",
              "method": "GET",
              "orig": "/contacts/groups/{groupId}/permissions/{username}",
              "segments": [
                {
                  "lit": "contacts"
                },
                {
                  "lit": "groups"
                },
                {
                  "var": "group_id"
                },
                {
                  "lit": "permissions"
                },
                {
                  "var": "id"
                }
              ],
              "parts": [
                "contacts",
                "groups",
                "{group_id}",
                "permissions",
                "{id}"
              ],
              "rename": {
                "param": {
                  "groupId": "group_id",
                  "username": "id"
                }
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {
                "params": [
                  {
                    "name": "group_id",
                    "orig": "groupId",
                    "type": "`$STRING`",
                    "kind": "param",
                    "reqd": true,
                    "example": "0f0f0f0f0f0f0f0f0f0f0f0f"
                  },
                  {
                    "name": "id",
                    "orig": "username",
                    "type": "`$STRING`",
                    "kind": "param",
                    "reqd": true
                  }
                ],
                "query": [
                  {
                    "name": "username",
                    "orig": "username",
                    "type": "`$STRING`",
                    "kind": "query",
                    "reqd": true,
                    "example": "example_username"
                  }
                ]
              },
              "select": {
                "exist": [
                  "group_id",
                  "id",
                  "username"
                ]
              }
            }
          ]
        }
      },
      "relations": {
        "ancestors": [
          [
            "$.main.kit.entity.group"
          ]
        ]
      }
    },
    "ping": {
      "fields": [
        {
          "name": "authorized",
          "title": "Authorized",
          "type": "`$BOOLEAN`",
          "req": true
        },
        {
          "name": "unavailable",
          "title": "Unavailable",
          "type": "`$ARRAY`",
          "req": true
        }
      ],
      "name": "ping",
      "op": {
        "list": {
          "input": "data",
          "name": "list",
          "points": [
            {
              "kind": "http",
              "method": "GET",
              "orig": "/ping",
              "segments": [
                {
                  "lit": "ping"
                }
              ],
              "parts": [
                "ping"
              ],
              "rename": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body.unavailable`"
              },
              "args": {},
              "select": {}
            }
          ]
        }
      },
      "relations": {
        "ancestors": []
      }
    },
    "profile": {
      "fields": [
        {
          "name": "email",
          "title": "Email",
          "type": "`$STRING`",
          "req": true
        },
        {
          "name": "name",
          "title": "Name",
          "type": "`$STRING`",
          "req": true
        },
        {
          "name": "payment_type",
          "title": "Payment Type",
          "type": "`$STRING`",
          "req": true
        },
        {
          "name": "phone_number",
          "title": "Phone Number",
          "type": "`$INTEGER`",
          "req": true
        },
        {
          "name": "points",
          "title": "Points",
          "type": "`$NUMBER`",
          "format": "float"
        },
        {
          "name": "user_type",
          "title": "User Type",
          "type": "`$STRING`",
          "req": true
        },
        {
          "name": "username",
          "title": "Username",
          "type": "`$STRING`",
          "req": true
        }
      ],
      "name": "profile",
      "op": {
        "list": {
          "input": "data",
          "name": "list",
          "points": [
            {
              "kind": "http",
              "method": "GET",
              "orig": "/profile/prices",
              "segments": [
                {
                  "lit": "profile"
                },
                {
                  "lit": "prices"
                }
              ],
              "parts": [
                "profile",
                "prices"
              ],
              "rename": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body.collection`"
              },
              "args": {
                "query": [
                  {
                    "name": "type",
                    "orig": "type",
                    "type": "`$STRING`",
                    "kind": "query",
                    "example": "eco"
                  }
                ]
              },
              "select": {
                "$action": "price",
                "exist": [
                  "type"
                ]
              }
            }
          ]
        },
        "load": {
          "input": "data",
          "name": "load",
          "points": [
            {
              "kind": "http",
              "method": "GET",
              "orig": "/profile",
              "segments": [
                {
                  "lit": "profile"
                }
              ],
              "parts": [
                "profile"
              ],
              "rename": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {},
              "select": {}
            }
          ]
        }
      },
      "relations": {
        "ancestors": []
      }
    },
    "rcs": {
      "fields": [],
      "name": "rcs",
      "op": {
        "list": {
          "input": "data",
          "name": "list",
          "points": [
            {
              "kind": "http",
              "method": "GET",
              "orig": "/rcs/messages",
              "segments": [
                {
                  "lit": "rcs"
                },
                {
                  "lit": "messages"
                }
              ],
              "parts": [
                "rcs",
                "messages"
              ],
              "rename": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body.collection`"
              },
              "args": {},
              "select": {
                "$action": "message"
              }
            }
          ]
        }
      },
      "relations": {
        "ancestors": []
      }
    },
    "sendername": {
      "fields": [
        {
          "name": "created_at",
          "title": "Created At",
          "type": "`$STRING`",
          "format": "date-time"
        },
        {
          "name": "id",
          "title": "Id",
          "type": "`$STRING`"
        },
        {
          "name": "is_default",
          "title": "Is Default",
          "type": "`$BOOLEAN`"
        },
        {
          "name": "sender",
          "title": "Sender",
          "type": "`$STRING`",
          "short": "Sendername"
        },
        {
          "name": "status",
          "title": "Status",
          "type": "`$STRING`"
        }
      ],
      "id": {
        "field": "id",
        "name": "id"
      },
      "name": "sendername",
      "op": {
        "create": {
          "input": "data",
          "name": "create",
          "points": [
            {
              "kind": "http",
              "method": "POST",
              "orig": "/sms/sendernames",
              "segments": [
                {
                  "lit": "sms"
                },
                {
                  "lit": "sendernames"
                }
              ],
              "parts": [
                "sms",
                "sendernames"
              ],
              "rename": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {},
              "select": {}
            }
          ]
        },
        "list": {
          "input": "data",
          "name": "list",
          "points": [
            {
              "kind": "http",
              "method": "GET",
              "orig": "/sms/sendernames",
              "segments": [
                {
                  "lit": "sms"
                },
                {
                  "lit": "sendernames"
                }
              ],
              "parts": [
                "sms",
                "sendernames"
              ],
              "rename": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body.collection`"
              },
              "args": {},
              "select": {}
            }
          ]
        },
        "load": {
          "input": "data",
          "name": "load",
          "points": [
            {
              "kind": "http",
              "method": "GET",
              "orig": "/sms/sendernames/{sender}",
              "segments": [
                {
                  "lit": "sms"
                },
                {
                  "lit": "sendernames"
                },
                {
                  "var": "id"
                }
              ],
              "parts": [
                "sms",
                "sendernames",
                "{id}"
              ],
              "rename": {
                "param": {
                  "sender": "id"
                }
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {
                "params": [
                  {
                    "name": "id",
                    "orig": "sender",
                    "type": "`$STRING`",
                    "kind": "param",
                    "reqd": true
                  }
                ]
              },
              "select": {
                "exist": [
                  "id"
                ]
              }
            }
          ]
        }
      },
      "relations": {
        "ancestors": []
      }
    },
    "sendername_statement": {
      "fields": [
        {
          "name": "content",
          "title": "Content",
          "type": "`$STRING`"
        },
        {
          "name": "statements",
          "title": "Statements",
          "type": "`$ARRAY`"
        },
        {
          "name": "title",
          "title": "Title",
          "type": "`$STRING`"
        }
      ],
      "name": "sendername_statement",
      "op": {
        "list": {
          "input": "data",
          "name": "list",
          "points": [
            {
              "kind": "http",
              "method": "GET",
              "orig": "/sms/sendernames/statement",
              "segments": [
                {
                  "lit": "sms"
                },
                {
                  "lit": "sendernames"
                },
                {
                  "lit": "statement"
                }
              ],
              "parts": [
                "sms",
                "sendernames",
                "statement"
              ],
              "rename": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body.sections`"
              },
              "args": {},
              "select": {}
            }
          ]
        }
      },
      "relations": {
        "ancestors": []
      }
    },
    "sent_rcs_message": {
      "fields": [
        {
          "name": "content",
          "title": "Content",
          "type": "`$OBJECT`",
          "short": "RCS message content in RCS JSON format."
        },
        {
          "name": "phone_number",
          "title": "Phone Number",
          "type": "`$STRING`",
          "req": true,
          "short": "Recipient phone number (e.g."
        },
        {
          "name": "sender",
          "title": "Sender",
          "type": "`$ANY`",
          "req": true
        },
        {
          "name": "text",
          "title": "Text",
          "type": "`$STRING`",
          "short": "Plain text message content."
        }
      ],
      "name": "sent_rcs_message",
      "op": {
        "create": {
          "input": "data",
          "name": "create",
          "points": [
            {
              "kind": "http",
              "method": "POST",
              "orig": "/rcs/messages",
              "segments": [
                {
                  "lit": "rcs"
                },
                {
                  "lit": "messages"
                }
              ],
              "parts": [
                "rcs",
                "messages"
              ],
              "rename": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {},
              "select": {}
            }
          ]
        }
      },
      "relations": {
        "ancestors": []
      }
    },
    "shipment_country_volume": {
      "fields": [
        {
          "name": "country_code",
          "title": "Country Code",
          "type": "`$STRING`"
        },
        {
          "name": "country_limit",
          "title": "Country Limit",
          "type": "`$INTEGER`"
        },
        {
          "name": "country_name",
          "title": "Country Name",
          "type": "`$STRING`"
        },
        {
          "name": "usage",
          "title": "Usage",
          "type": "`$INTEGER`"
        }
      ],
      "name": "shipment_country_volume",
      "op": {
        "list": {
          "input": "data",
          "name": "list",
          "points": [
            {
              "kind": "http",
              "method": "GET",
              "orig": "/shipment/country_volumes",
              "segments": [
                {
                  "lit": "shipment"
                },
                {
                  "lit": "country_volumes"
                }
              ],
              "parts": [
                "shipment",
                "country_volumes"
              ],
              "rename": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body.collection`"
              },
              "args": {
                "header": [
                  {
                    "name": "accept",
                    "orig": "Accept",
                    "type": "`$STRING`",
                    "kind": "header",
                    "example": "application/json"
                  }
                ],
                "query": [
                  {
                    "name": "month",
                    "orig": "month",
                    "type": "`$STRING`",
                    "kind": "query"
                  },
                  {
                    "name": "year",
                    "orig": "year",
                    "type": "`$STRING`",
                    "kind": "query"
                  }
                ]
              },
              "select": {
                "exist": [
                  "accept",
                  "month",
                  "year"
                ]
              }
            }
          ]
        }
      },
      "relations": {
        "ancestors": []
      }
    },
    "short_url": {
      "fields": [
        {
          "name": "description",
          "title": "Description",
          "type": "`$STRING`"
        },
        {
          "name": "expire",
          "title": "Expire",
          "type": "`$STRING`",
          "format": "date-time"
        },
        {
          "name": "filename",
          "title": "Filename",
          "type": "`$STRING`"
        },
        {
          "name": "hits",
          "title": "Hits",
          "type": "`$INTEGER`"
        },
        {
          "name": "hits_unique",
          "title": "Hits Unique",
          "type": "`$INTEGER`"
        },
        {
          "name": "id",
          "title": "Id",
          "type": "`$STRING`"
        },
        {
          "name": "name",
          "title": "Name",
          "type": "`$STRING`"
        },
        {
          "name": "short_url",
          "title": "Short Url",
          "type": "`$STRING`",
          "short": "WHATWG URL compliant",
          "format": "url"
        },
        {
          "name": "type",
          "title": "Type",
          "type": "`$STRING`"
        },
        {
          "name": "url",
          "title": "Url",
          "type": "`$STRING`",
          "short": "WHATWG URL compliant",
          "format": "url"
        }
      ],
      "id": {
        "field": "id",
        "name": "id"
      },
      "name": "short_url",
      "op": {
        "create": {
          "input": "data",
          "name": "create",
          "points": [
            {
              "kind": "http",
              "method": "POST",
              "orig": "/short_url/links",
              "segments": [
                {
                  "lit": "short_url"
                },
                {
                  "lit": "links"
                }
              ],
              "parts": [
                "short_url",
                "links"
              ],
              "rename": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {},
              "select": {
                "$action": "link"
              }
            }
          ]
        },
        "list": {
          "input": "data",
          "name": "list",
          "points": [
            {
              "kind": "http",
              "method": "GET",
              "orig": "/short_url/links",
              "segments": [
                {
                  "lit": "short_url"
                },
                {
                  "lit": "links"
                }
              ],
              "parts": [
                "short_url",
                "links"
              ],
              "rename": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body.collection`"
              },
              "args": {},
              "select": {
                "$action": "link"
              }
            }
          ]
        },
        "load": {
          "input": "data",
          "name": "load",
          "points": [
            {
              "kind": "http",
              "method": "GET",
              "orig": "/short_url/links/{id}",
              "segments": [
                {
                  "lit": "short_url"
                },
                {
                  "lit": "links"
                },
                {
                  "var": "id"
                }
              ],
              "parts": [
                "short_url",
                "links",
                "{id}"
              ],
              "rename": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {
                "params": [
                  {
                    "name": "id",
                    "orig": "id",
                    "type": "`$STRING`",
                    "kind": "param",
                    "reqd": true,
                    "example": "123"
                  }
                ]
              },
              "select": {
                "exist": [
                  "id"
                ]
              }
            }
          ]
        },
        "remove": {
          "input": "data",
          "name": "remove",
          "points": [
            {
              "kind": "http",
              "method": "DELETE",
              "orig": "/short_url/links/{id}",
              "segments": [
                {
                  "lit": "short_url"
                },
                {
                  "lit": "links"
                },
                {
                  "var": "id"
                }
              ],
              "parts": [
                "short_url",
                "links",
                "{id}"
              ],
              "rename": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {
                "params": [
                  {
                    "name": "id",
                    "orig": "id",
                    "type": "`$STRING`",
                    "kind": "param",
                    "reqd": true,
                    "example": "123"
                  }
                ]
              },
              "select": {
                "exist": [
                  "id"
                ]
              }
            }
          ]
        },
        "update": {
          "input": "data",
          "name": "update",
          "points": [
            {
              "kind": "http",
              "method": "PUT",
              "orig": "/short_url/links/{id}",
              "segments": [
                {
                  "lit": "short_url"
                },
                {
                  "lit": "links"
                },
                {
                  "var": "id"
                }
              ],
              "parts": [
                "short_url",
                "links",
                "{id}"
              ],
              "rename": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {
                "params": [
                  {
                    "name": "id",
                    "orig": "id",
                    "type": "`$STRING`",
                    "kind": "param",
                    "reqd": true,
                    "example": "123"
                  }
                ]
              },
              "select": {
                "exist": [
                  "id"
                ]
              }
            }
          ]
        }
      },
      "relations": {
        "ancestors": []
      }
    },
    "smsdo": {
      "fields": [
        {
          "name": "allow_duplicates",
          "title": "Allow Duplicates",
          "type": "`$INTEGER`",
          "short": "When parameter allow_duplicates is set to \"1\" allows to send message to duplicated numbers in one request (useful i.e."
        },
        {
          "name": "check_idx",
          "title": "Check Idx",
          "type": "`$ANY`",
          "short": "When parameter check_idx is set to „1” prevents from sending more than one message with the same idx in last 24h."
        },
        {
          "name": "date",
          "title": "Date",
          "type": "`$ANY`",
          "short": "Date in UNIX timestamp (&date=1287734110) or in ISO 8601 (&date=2012-05-10T08:40:27+00:00) when message will be sent (&date=1287734110)."
        },
        {
          "name": "date_validate",
          "title": "Date Validate",
          "type": "`$INTEGER`",
          "short": "When parameter date_validate is set to \"1\" checks if date if given in proper format."
        },
        {
          "name": "details",
          "title": "Details",
          "type": "`$ANY`",
          "short": "When details parameter is set to \"1\" more details in response will be displayed (message length and sms count)."
        },
        {
          "name": "encoding",
          "title": "Encoding",
          "type": "`$STRING`",
          "short": "This parameter describes the encoding of the message text."
        },
        {
          "name": "expiration_date",
          "title": "Expiration Date",
          "type": "`$ANY`",
          "short": "Message expiration date (in UNIX timestamp or in ISO 8601) is a date after which message won't be delivered if it wasn't delivered yet."
        },
        {
          "name": "fallback",
          "title": "Fallback",
          "type": "`$ARRAY`",
          "short": "Enable fallback in case sms sending fails"
        },
        {
          "name": "fast",
          "title": "Fast",
          "type": "`$INTEGER`",
          "short": "Setting this parameter to „1” will result in sending message with the highest priority which ensures the quickest possible time of delivery."
        },
        {
          "name": "flash",
          "title": "Flash",
          "type": "`$INTEGER`",
          "short": "Sending a message in flash mode can be activated by setting this parameter to \"1\"."
        },
        {
          "name": "format",
          "title": "Format",
          "type": "`$STRING`",
          "short": "Parameter &format=json causes, that response is sending in JSON format."
        },
        {
          "name": "from",
          "title": "From",
          "type": "`$STRING`",
          "short": "Name of the sender."
        },
        {
          "name": "group",
          "title": "Group",
          "type": "`$STRING`",
          "short": "Name of the group from the contacts database to which message should be sent to."
        },
        {
          "name": "idx",
          "title": "Idx",
          "type": "`$STRING`",
          "short": "Optional custom value sent with SMS and sent back in CALLBACK."
        },
        {
          "name": "max_parts",
          "title": "Max Parts",
          "type": "`$INTEGER`",
          "short": "Defines maximum message parts allowed, maximum value allowed is 6."
        },
        {
          "name": "message",
          "title": "Message",
          "type": "`$STRING`",
          "short": "The message text."
        },
        {
          "name": "normalize",
          "title": "Normalize",
          "type": "`$INTEGER`",
          "short": "When parameter normalize is set to „1” special chars in message will be replaced with their equivalents (ê-e, ñ-n, ý-y ...)."
        },
        {
          "name": "notify_url",
          "title": "Notify Url",
          "type": "`$STRING`",
          "short": "Parameter allows to set CALLBACK URL for message from request."
        },
        {
          "name": "test",
          "title": "Test",
          "type": "`$ANY`",
          "short": "When parameter test is set to \"1\" message won't be sent but response will be displayed, there is no charge for such test messages."
        },
        {
          "name": "time_restriction",
          "title": "Time Restriction",
          "type": "`$STRING`",
          "short": "Sets the behavior when you try to ship in hours / dates that do not match the settings in your account."
        },
        {
          "name": "to",
          "title": "To",
          "type": "`$STRING`",
          "short": "Recipients' mobile phone numbers (i.e."
        }
      ],
      "name": "smsdo",
      "op": {
        "create": {
          "input": "data",
          "name": "create",
          "points": [
            {
              "kind": "http",
              "method": "POST",
              "orig": "/sms.do",
              "segments": [
                {
                  "lit": "sms.do"
                }
              ],
              "parts": [
                "sms.do"
              ],
              "rename": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {},
              "select": {}
            }
          ]
        }
      },
      "relations": {
        "ancestors": []
      }
    },
    "smssendername": {
      "fields": [],
      "name": "smssendername",
      "op": {
        "create": {
          "input": "data",
          "name": "create",
          "points": [
            {
              "kind": "http",
              "method": "POST",
              "orig": "/sms/sendernames/{sender}/commands/make_default",
              "segments": [
                {
                  "lit": "sms"
                },
                {
                  "lit": "sendernames"
                },
                {
                  "var": "sendername_id"
                },
                {
                  "lit": "commands"
                },
                {
                  "lit": "make_default"
                }
              ],
              "parts": [
                "sms",
                "sendernames",
                "{sendername_id}",
                "commands",
                "make_default"
              ],
              "rename": {
                "param": {
                  "sender": "sendername_id"
                }
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {
                "params": [
                  {
                    "name": "sendername_id",
                    "orig": "sender",
                    "type": "`$STRING`",
                    "kind": "param",
                    "reqd": true
                  }
                ]
              },
              "select": {
                "exist": [
                  "sendername_id"
                ]
              }
            }
          ]
        },
        "remove": {
          "input": "data",
          "name": "remove",
          "points": [
            {
              "kind": "http",
              "method": "DELETE",
              "orig": "/sms/sendernames/{sender}",
              "segments": [
                {
                  "lit": "sms"
                },
                {
                  "lit": "sendernames"
                },
                {
                  "var": "sender"
                }
              ],
              "parts": [
                "sms",
                "sendernames",
                "{sender}"
              ],
              "rename": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {
                "params": [
                  {
                    "name": "sender",
                    "orig": "sender",
                    "type": "`$STRING`",
                    "kind": "param",
                    "reqd": true
                  }
                ]
              },
              "select": {
                "exist": [
                  "sender"
                ]
              }
            }
          ]
        }
      },
      "relations": {
        "ancestors": [
          [
            "$.main.kit.entity.sendername"
          ]
        ]
      }
    },
    "smstemplate": {
      "fields": [
        {
          "name": "id",
          "title": "Id",
          "type": "`$STRING`"
        }
      ],
      "id": {
        "field": "id",
        "name": "id"
      },
      "name": "smstemplate",
      "op": {
        "remove": {
          "input": "data",
          "name": "remove",
          "points": [
            {
              "kind": "http",
              "method": "DELETE",
              "orig": "/sms/templates/{id}",
              "segments": [
                {
                  "lit": "sms"
                },
                {
                  "lit": "templates"
                },
                {
                  "var": "id"
                }
              ],
              "parts": [
                "sms",
                "templates",
                "{id}"
              ],
              "rename": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {
                "params": [
                  {
                    "name": "id",
                    "orig": "id",
                    "type": "`$STRING`",
                    "kind": "param",
                    "reqd": true
                  }
                ]
              },
              "select": {
                "exist": [
                  "id"
                ]
              }
            }
          ]
        }
      },
      "relations": {
        "ancestors": []
      }
    },
    "subuser": {
      "fields": [
        {
          "name": "active",
          "title": "Active",
          "type": "`$BOOLEAN`"
        },
        {
          "name": "credentials",
          "title": "Credentials",
          "type": "`$OBJECT`",
          "req": true,
          "op": {
            "update": {
              "type": "`$OBJECT`"
            }
          }
        },
        {
          "name": "description",
          "title": "Description",
          "type": "`$STRING`"
        },
        {
          "name": "id",
          "title": "Id",
          "type": "`$STRING`",
          "short": "Object ID",
          "format": "oid"
        },
        {
          "name": "points",
          "title": "Points",
          "type": "`$OBJECT`"
        },
        {
          "name": "username",
          "title": "Username",
          "type": "`$STRING`"
        }
      ],
      "id": {
        "field": "id",
        "name": "id"
      },
      "name": "subuser",
      "op": {
        "create": {
          "input": "data",
          "name": "create",
          "points": [
            {
              "kind": "http",
              "method": "POST",
              "orig": "/subusers",
              "segments": [
                {
                  "lit": "subusers"
                }
              ],
              "parts": [
                "subusers"
              ],
              "rename": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {},
              "select": {}
            }
          ]
        },
        "list": {
          "input": "data",
          "name": "list",
          "points": [
            {
              "kind": "http",
              "method": "GET",
              "orig": "/subusers/{id}/shares/sendernames",
              "segments": [
                {
                  "lit": "subusers"
                },
                {
                  "var": "id"
                },
                {
                  "lit": "shares"
                },
                {
                  "lit": "sendernames"
                }
              ],
              "parts": [
                "subusers",
                "{id}",
                "shares",
                "sendernames"
              ],
              "rename": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body.senders`"
              },
              "args": {
                "params": [
                  {
                    "name": "id",
                    "orig": "id",
                    "type": "`$STRING`",
                    "kind": "param",
                    "reqd": true,
                    "example": "0f0f0f0f0f0f0f0f0f0f0f0f"
                  }
                ]
              },
              "select": {
                "$action": "share_sendername",
                "exist": [
                  "id"
                ]
              }
            },
            {
              "kind": "http",
              "method": "GET",
              "orig": "/subusers/{id}/shares/templates",
              "segments": [
                {
                  "lit": "subusers"
                },
                {
                  "var": "id"
                },
                {
                  "lit": "shares"
                },
                {
                  "lit": "templates"
                }
              ],
              "parts": [
                "subusers",
                "{id}",
                "shares",
                "templates"
              ],
              "rename": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body.templates`"
              },
              "args": {
                "params": [
                  {
                    "name": "id",
                    "orig": "id",
                    "type": "`$STRING`",
                    "kind": "param",
                    "reqd": true,
                    "example": "0f0f0f0f0f0f0f0f0f0f0f0f"
                  }
                ]
              },
              "select": {
                "$action": "share_template",
                "exist": [
                  "id"
                ]
              }
            },
            {
              "kind": "http",
              "method": "GET",
              "orig": "/subusers",
              "segments": [
                {
                  "lit": "subusers"
                }
              ],
              "parts": [
                "subusers"
              ],
              "rename": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body.collection`"
              },
              "args": {
                "query": [
                  {
                    "name": "q",
                    "orig": "q",
                    "type": "`$STRING`",
                    "kind": "query"
                  }
                ]
              },
              "select": {
                "exist": [
                  "q"
                ]
              }
            }
          ]
        },
        "load": {
          "input": "data",
          "name": "load",
          "points": [
            {
              "kind": "http",
              "method": "GET",
              "orig": "/subusers/{id}",
              "segments": [
                {
                  "lit": "subusers"
                },
                {
                  "var": "id"
                }
              ],
              "parts": [
                "subusers",
                "{id}"
              ],
              "rename": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {
                "params": [
                  {
                    "name": "id",
                    "orig": "id",
                    "type": "`$STRING`",
                    "kind": "param",
                    "reqd": true,
                    "example": "0f0f0f0f0f0f0f0f0f0f0f0f"
                  }
                ]
              },
              "select": {
                "exist": [
                  "id"
                ]
              }
            }
          ]
        },
        "remove": {
          "input": "data",
          "name": "remove",
          "points": [
            {
              "kind": "http",
              "method": "DELETE",
              "orig": "/subusers/{id}",
              "segments": [
                {
                  "lit": "subusers"
                },
                {
                  "var": "id"
                }
              ],
              "parts": [
                "subusers",
                "{id}"
              ],
              "rename": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {
                "params": [
                  {
                    "name": "id",
                    "orig": "id",
                    "type": "`$STRING`",
                    "kind": "param",
                    "reqd": true,
                    "example": "0f0f0f0f0f0f0f0f0f0f0f0f"
                  }
                ]
              },
              "select": {
                "exist": [
                  "id"
                ]
              }
            }
          ]
        },
        "update": {
          "input": "data",
          "name": "update",
          "points": [
            {
              "kind": "http",
              "method": "PUT",
              "orig": "/subusers/{id}",
              "segments": [
                {
                  "lit": "subusers"
                },
                {
                  "var": "id"
                }
              ],
              "parts": [
                "subusers",
                "{id}"
              ],
              "rename": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {
                "params": [
                  {
                    "name": "id",
                    "orig": "id",
                    "type": "`$STRING`",
                    "kind": "param",
                    "reqd": true,
                    "example": "0f0f0f0f0f0f0f0f0f0f0f0f"
                  }
                ]
              },
              "select": {
                "exist": [
                  "id"
                ]
              }
            },
            {
              "kind": "http",
              "method": "PUT",
              "orig": "/subusers/{id}/shares/sendernames",
              "segments": [
                {
                  "lit": "subusers"
                },
                {
                  "var": "id"
                },
                {
                  "lit": "shares"
                },
                {
                  "lit": "sendernames"
                }
              ],
              "parts": [
                "subusers",
                "{id}",
                "shares",
                "sendernames"
              ],
              "rename": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {
                "params": [
                  {
                    "name": "id",
                    "orig": "id",
                    "type": "`$STRING`",
                    "kind": "param",
                    "reqd": true,
                    "example": "0f0f0f0f0f0f0f0f0f0f0f0f"
                  }
                ]
              },
              "select": {
                "$action": "share_sendername",
                "exist": [
                  "id"
                ]
              }
            },
            {
              "kind": "http",
              "method": "PUT",
              "orig": "/subusers/{id}/shares/templates",
              "segments": [
                {
                  "lit": "subusers"
                },
                {
                  "var": "id"
                },
                {
                  "lit": "shares"
                },
                {
                  "lit": "templates"
                }
              ],
              "parts": [
                "subusers",
                "{id}",
                "shares",
                "templates"
              ],
              "rename": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {
                "params": [
                  {
                    "name": "id",
                    "orig": "id",
                    "type": "`$STRING`",
                    "kind": "param",
                    "reqd": true,
                    "example": "0f0f0f0f0f0f0f0f0f0f0f0f"
                  }
                ]
              },
              "select": {
                "$action": "share_template",
                "exist": [
                  "id"
                ]
              }
            }
          ]
        }
      },
      "relations": {
        "ancestors": []
      }
    },
    "template": {
      "fields": [
        {
          "name": "id",
          "title": "Id",
          "type": "`$STRING`"
        },
        {
          "name": "name",
          "title": "Name",
          "type": "`$STRING`"
        },
        {
          "name": "normalize",
          "title": "Normalize",
          "type": "`$BOOLEAN`"
        },
        {
          "name": "template",
          "title": "Template",
          "type": "`$STRING`"
        }
      ],
      "id": {
        "field": "id",
        "name": "id"
      },
      "name": "template",
      "op": {
        "create": {
          "input": "data",
          "name": "create",
          "points": [
            {
              "kind": "http",
              "method": "POST",
              "orig": "/sms/templates",
              "segments": [
                {
                  "lit": "sms"
                },
                {
                  "lit": "templates"
                }
              ],
              "parts": [
                "sms",
                "templates"
              ],
              "rename": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {},
              "select": {}
            }
          ]
        },
        "list": {
          "input": "data",
          "name": "list",
          "points": [
            {
              "kind": "http",
              "method": "GET",
              "orig": "/sms/templates",
              "segments": [
                {
                  "lit": "sms"
                },
                {
                  "lit": "templates"
                }
              ],
              "parts": [
                "sms",
                "templates"
              ],
              "rename": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body.collection`"
              },
              "args": {},
              "select": {}
            }
          ]
        },
        "load": {
          "input": "data",
          "name": "load",
          "points": [
            {
              "kind": "http",
              "method": "GET",
              "orig": "/sms/templates/{id}",
              "segments": [
                {
                  "lit": "sms"
                },
                {
                  "lit": "templates"
                },
                {
                  "var": "id"
                }
              ],
              "parts": [
                "sms",
                "templates",
                "{id}"
              ],
              "rename": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {
                "params": [
                  {
                    "name": "id",
                    "orig": "id",
                    "type": "`$STRING`",
                    "kind": "param",
                    "reqd": true
                  }
                ]
              },
              "select": {
                "exist": [
                  "id"
                ]
              }
            }
          ]
        },
        "update": {
          "input": "data",
          "name": "update",
          "points": [
            {
              "kind": "http",
              "method": "PUT",
              "orig": "/sms/templates/{id}",
              "segments": [
                {
                  "lit": "sms"
                },
                {
                  "lit": "templates"
                },
                {
                  "var": "id"
                }
              ],
              "parts": [
                "sms",
                "templates",
                "{id}"
              ],
              "rename": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              },
              "args": {
                "params": [
                  {
                    "name": "id",
                    "orig": "id",
                    "type": "`$STRING`",
                    "kind": "param",
                    "reqd": true
                  }
                ]
              },
              "select": {
                "exist": [
                  "id"
                ]
              }
            }
          ]
        }
      },
      "relations": {
        "ancestors": []
      }
    },
    "user_rcs_sender_collection": {
      "fields": [
        {
          "name": "deliveredAt",
          "title": "Delivered At",
          "type": "`$STRING`",
          "format": "date-time"
        },
        {
          "name": "expiredAt",
          "title": "Expired At",
          "type": "`$STRING`",
          "format": "date-time"
        },
        {
          "name": "id",
          "title": "Id",
          "type": "`$STRING`",
          "short": "Object ID",
          "format": "oid"
        },
        {
          "name": "interface",
          "title": "Interface",
          "type": "`$STRING`",
          "short": "Interface through which the message was sent (www, api, ...)."
        },
        {
          "name": "messageType",
          "title": "Message Type",
          "type": "`$STRING`",
          "short": "RCS message type (basic, single, ...)."
        },
        {
          "name": "readAt",
          "title": "Read At",
          "type": "`$STRING`",
          "format": "date-time"
        },
        {
          "name": "recipient",
          "title": "Recipient",
          "type": "`$STRING`",
          "short": "Recipient phone number (without +)."
        },
        {
          "name": "sender",
          "title": "Sender",
          "type": "`$STRING`",
          "short": "Sender name"
        },
        {
          "name": "senderId",
          "title": "Sender Id",
          "type": "`$STRING`",
          "short": "Sender id"
        },
        {
          "name": "sentAt",
          "title": "Sent At",
          "type": "`$STRING`",
          "format": "date-time"
        }
      ],
      "id": {
        "field": "id",
        "name": "id"
      },
      "name": "user_rcs_sender_collection",
      "op": {
        "list": {
          "input": "data",
          "name": "list",
          "points": [
            {
              "kind": "http",
              "method": "GET",
              "orig": "/rcs/senders",
              "segments": [
                {
                  "lit": "rcs"
                },
                {
                  "lit": "senders"
                }
              ],
              "parts": [
                "rcs",
                "senders"
              ],
              "rename": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body.collection`"
              },
              "args": {},
              "select": {}
            }
          ]
        }
      },
      "relations": {
        "ancestors": []
      }
    }
  }
}


const config = new Config()

module.exports = {
  config,
  FEATURE_PLUGINS,
}

