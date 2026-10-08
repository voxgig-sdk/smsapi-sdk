# Smsapi SDK configuration


# The sekreto plugin DEFINITIONS the model selected per feature, imported
# above by name from the modules the catalogue's active `plugin.def`
# entries declare. Handed to each feature (secrets builds its Sekreto
# with them): a provider kind not listed here is unknown to that SDK.
FEATURE_PLUGINS = {
}


_shared_config = None


def shared_config():
    """Return the process-wide config, built once on first use.

    The SDK reads the config on every request and never writes to it, so one
    instance is shared by every client rather than rebuilt per client.

    The returned dict is shared: treat it as read-only. Callers that need to
    mutate should use make_config, which always returns a fresh copy.
    """
    global _shared_config
    if _shared_config is None:
        _shared_config = make_config()
    return _shared_config


def make_config():
    """Build a fresh, fully materialised config dict.

    Every call rebuilds the whole structure, so prefer shared_config unless
    you need a private copy you intend to mutate.
    """
    return {
        "main": {
            "name": "Smsapi",
            "slug": "smsapi",
            "version": "0.0.1",
            "target": "py",
        },
        "feature": {
            "audit": {
        "options": {
          "active": False,
          "actor": "anonymous",
          "max": 1000,
        },
        "optspec": {
          "now": "`$FUNCTION`",
          "sink": "`$FUNCTION`",
        },
        "strict": False,
        "transport": "none",
      },
            "cache": {
        "options": {
          "active": False,
          "max": 256,
          "methods": [
            "GET",
          ],
          "ttl": 5000,
        },
        "optspec": {
          "now": "`$FUNCTION`",
        },
        "strict": False,
        "transport": "wrap",
      },
            "clienttrack": {
        "options": {
          "active": False,
          "clientVersion": "0.0.1",
        },
        "optspec": {
          "clientName": "`$STRING`",
          "clientVersion": "`$STRING`",
          "headers": "`$MAP`",
          "idgen": "`$FUNCTION`",
          "sessionId": "`$STRING`",
        },
        "strict": False,
        "transport": "none",
      },
            "cost": {
        "options": {
          "active": False,
          "budget": 0,
          "currency": "USD",
          "header": "",
          "onBudget": "warn",
          "path": "",
          "perUnit": 0,
          "rates": {},
          "unit": 0,
        },
        "optspec": {
          "actor": "`$STRING`",
          "sink": "`$FUNCTION`",
        },
        "strict": False,
        "transport": "wrap",
      },
            "debug": {
        "options": {
          "active": False,
          "max": 100,
          "redact": [
            "authorization",
            "cookie",
            "set-cookie",
            "api-key",
            "apikey",
            "x-api-key",
            "idempotency-key",
          ],
        },
        "optspec": {
          "now": "`$FUNCTION`",
          "onEntry": "`$FUNCTION`",
        },
        "strict": False,
        "transport": "none",
      },
            "idempotency": {
        "options": {
          "active": False,
          "header": "Idempotency-Key",
          "methods": [
            "POST",
            "PUT",
            "PATCH",
            "DELETE",
          ],
          "ops": [
            "create",
            "update",
            "remove",
          ],
        },
        "optspec": {
          "keygen": "`$FUNCTION`",
        },
        "strict": False,
        "transport": "none",
      },
            "log": {
        "options": {
          "active": True,
        },
        "optspec": {
          "level": "`$STRING`",
          "logger": "`$ANY`",
        },
        "strict": False,
        "transport": "none",
      },
            "metrics": {
        "options": {
          "active": False,
        },
        "optspec": {
          "now": "`$FUNCTION`",
        },
        "strict": False,
        "transport": "none",
      },
            "netsim": {
        "options": {
          "active": False,
          "errorTimes": 0,
          "failEvery": 0,
          "failRate": 0,
          "failStatus": 503,
          "failTimes": 0,
          "latency": 0,
          "offline": False,
          "rateLimitTimes": 0,
          "retryAfter": 0,
          "seed": 1,
        },
        "optspec": {
          "latency": [
            "`$ONE`",
            "`$NUMBER`",
            "`$MAP`",
          ],
          "sleep": "`$FUNCTION`",
        },
        "strict": False,
        "transport": "wrap",
      },
            "paging": {
        "options": {
          "active": False,
          "afterVar": "after",
          "cursorParam": "cursor",
          "firstVar": "first",
          "limitParam": "limit",
          "pageParam": "page",
          "startPage": 1,
        },
        "optspec": {
          "limit": "`$NUMBER`",
          "ops": "`$LIST`",
        },
        "strict": False,
        "transport": "none",
      },
            "proxy": {
        "options": {
          "active": False,
          "fromEnv": False,
          "noProxy": [],
          "url": "",
        },
        "optspec": {
          "agent": "`$FUNCTION`",
        },
        "strict": False,
        "transport": "wrap",
      },
            "ratelimit": {
        "options": {
          "active": False,
          "burst": 5,
          "rate": 5,
        },
        "optspec": {
          "now": "`$FUNCTION`",
          "sleep": "`$FUNCTION`",
        },
        "strict": False,
        "transport": "wrap",
      },
            "rbac": {
        "options": {
          "active": False,
          "deny": False,
          "permissions": [],
          "rules": {},
        },
        "optspec": {},
        "strict": False,
        "transport": "none",
      },
            "retry": {
        "options": {
          "active": False,
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
            504,
          ],
        },
        "optspec": {
          "jitter": "`$BOOLEAN`",
          "sleep": "`$FUNCTION`",
        },
        "strict": False,
        "transport": "wrap",
      },
            "secrets": {
        "options": {
          "active": False,
          "cache": True,
          "exchange": {
            "active": False,
            "method": "POST",
            "path": "auth/token",
            "refresh": "",
            "request": "refresh_token",
            "response": "access_token",
            "retries": 1,
            "statuses": [
              401,
            ],
          },
          "name": "apikey",
          "providers": [],
        },
        "optspec": {},
        "strict": False,
        "transport": "wrap",
      },
            "streaming": {
        "options": {
          "active": False,
          "chunkDelay": 0,
          "chunkSize": 0,
        },
        "optspec": {
          "ops": "`$LIST`",
          "sleep": "`$FUNCTION`",
        },
        "strict": False,
        "transport": "none",
      },
            "telemetry": {
        "options": {
          "active": False,
        },
        "optspec": {
          "exporter": "`$FUNCTION`",
          "headers": "`$MAP`",
          "idgen": "`$FUNCTION`",
          "now": "`$FUNCTION`",
        },
        "strict": False,
        "transport": "none",
      },
            "test": {
        "options": {
          "active": False,
        },
        "optspec": {
          "entity": "`$MAP`",
          "net": "`$MAP`",
        },
        "strict": False,
        "transport": "base",
      },
            "timeout": {
        "options": {
          "active": False,
          "ms": 30000,
        },
        "optspec": {
          "clearTimer": "`$FUNCTION`",
          "now": "`$FUNCTION`",
          "setTimer": "`$FUNCTION`",
        },
        "strict": False,
        "transport": "wrap",
      },
            "validate": {
        "options": {
          "active": False,
          "mode": "throw",
          "request": True,
          "response": False,
          "strict": False,
        },
        "optspec": {
          "mode": [
            "`$ONE`",
            [
              "`$EXACT`",
              "throw",
            ],
            [
              "`$EXACT`",
              "report",
            ],
          ],
          "onInvalid": "`$FUNCTION`",
        },
        "strict": False,
        "transport": "none",
      },
        },
        "options": {
            "base": "https://api.smsapi.com",
            "auth": {
                "prefix": "Bearer",
            },
            "headers": {
        "content-type": "application/json",
      },
            "entity": {
                "available": {},
                "blacklist": {},
                "callback": {},
                "contact": {},
                "contacts_field": {},
                "contacts_field_option": {},
                "contactsgroup": {},
                "contactstrash": {},
                "field_available": {},
                "group": {},
                "mfa_code": {},
                "opt_out": {},
                "opt_out_setting": {},
                "permission": {},
                "ping": {},
                "profile": {},
                "rcs": {},
                "sendername": {},
                "sendername_statement": {},
                "sent_rcs_message": {},
                "shipment_country_volume": {},
                "short_url": {},
                "smsdo": {},
                "smssendername": {},
                "smstemplate": {},
                "subuser": {},
                "template": {},
                "user_rcs_sender_collection": {},
            },
        },
        "entity": {
      "available": {
        "fields": [
          {
            "name": "name",
            "title": "Name",
            "type": "`$STRING`",
          },
          {
            "name": "normalize",
            "title": "Normalize",
            "type": "`$BOOLEAN`",
          },
          {
            "name": "template",
            "title": "Template",
            "type": "`$STRING`",
          },
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
                    "lit": "sms",
                  },
                  {
                    "lit": "templates",
                  },
                  {
                    "lit": "available",
                  },
                ],
                "parts": [
                  "sms",
                  "templates",
                  "available",
                ],
                "rename": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body.collection`",
                },
                "args": {},
                "select": {},
                "response": {
                  "kind": "json",
                  "media": "application/json",
                },
              },
            ],
          },
        },
        "relations": {
          "ancestors": [],
        },
      },
      "blacklist": {
        "fields": [
          {
            "name": "id",
            "title": "Id",
            "type": "`$STRING`",
          },
        ],
        "id": {
          "field": "id",
          "name": "id",
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
                    "lit": "blacklist",
                  },
                  {
                    "lit": "phone_numbers",
                  },
                ],
                "parts": [
                  "blacklist",
                  "phone_numbers",
                ],
                "rename": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "args": {},
                "select": {
                  "$action": "phone_number",
                },
                "body": {
                  "alternatives": [
                    {
                      "fields": [
                        {
                          "name": "expire_at",
                        },
                        {
                          "name": "phone_number",
                        },
                      ],
                      "kind": "form",
                      "media": "application/x-www-form-urlencoded",
                    },
                  ],
                  "kind": "json",
                  "media": "application/json",
                },
                "response": {
                  "kind": "json",
                  "media": "application/json",
                },
              },
              {
                "kind": "http",
                "method": "POST",
                "orig": "/blacklist/phone_numbers/imports",
                "segments": [
                  {
                    "lit": "blacklist",
                  },
                  {
                    "lit": "phone_numbers",
                  },
                  {
                    "lit": "imports",
                  },
                ],
                "parts": [
                  "blacklist",
                  "phone_numbers",
                  "imports",
                ],
                "rename": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "args": {},
                "select": {},
                "body": {
                  "alternatives": [
                    {
                      "kind": "raw",
                      "media": "text/csv",
                    },
                  ],
                  "fields": [
                    {
                      "name": "import",
                    },
                  ],
                  "kind": "multipart",
                  "media": "multipart/form-data",
                },
              },
            ],
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
                    "lit": "blacklist",
                  },
                  {
                    "lit": "phone_numbers",
                  },
                ],
                "parts": [
                  "blacklist",
                  "phone_numbers",
                ],
                "rename": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "args": {
                  "header": [
                    {
                      "name": "accept",
                      "orig": "Accept",
                      "type": "`$STRING`",
                      "kind": "header",
                      "example": "application/json",
                    },
                    {
                      "name": "x_async",
                      "orig": "x-async",
                      "type": "`$BOOLEAN`",
                      "kind": "header",
                      "example": False,
                    },
                  ],
                  "query": [
                    {
                      "name": "limit",
                      "orig": "limit",
                      "type": "`$INTEGER`",
                      "kind": "query",
                      "example": 5,
                    },
                    {
                      "name": "offset",
                      "orig": "offset",
                      "type": "`$INTEGER`",
                      "kind": "query",
                      "example": 0,
                    },
                    {
                      "name": "q",
                      "orig": "q",
                      "type": "`$INTEGER`",
                      "kind": "query",
                      "example": 0,
                    },
                  ],
                },
                "select": {
                  "$action": "phone_number",
                },
                "response": {
                  "alternatives": [
                    {
                      "kind": "raw",
                      "media": "text/csv",
                    },
                  ],
                  "kind": "json",
                  "media": "application/json",
                },
              },
            ],
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
                    "lit": "blacklist",
                  },
                  {
                    "lit": "phone_numbers",
                  },
                  {
                    "var": "id",
                  },
                ],
                "parts": [
                  "blacklist",
                  "phone_numbers",
                  "{id}",
                ],
                "rename": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "args": {
                  "params": [
                    {
                      "name": "id",
                      "orig": "id",
                      "type": "`$STRING`",
                      "kind": "param",
                      "reqd": True,
                      "example": "0f0f0f0f0f0f0f0f0f0f0f0f",
                    },
                  ],
                },
                "select": {
                  "exist": [
                    "id",
                  ],
                },
              },
              {
                "kind": "http",
                "method": "DELETE",
                "orig": "/blacklist/phone_numbers",
                "segments": [
                  {
                    "lit": "blacklist",
                  },
                  {
                    "lit": "phone_numbers",
                  },
                ],
                "parts": [
                  "blacklist",
                  "phone_numbers",
                ],
                "rename": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "args": {
                  "query": [
                    {
                      "name": "phone_number",
                      "orig": "phone_number",
                      "type": "`$STRING`",
                      "kind": "query",
                    },
                  ],
                },
                "select": {
                  "$action": "phone_number",
                },
              },
            ],
          },
        },
        "relations": {
          "ancestors": [],
        },
      },
      "callback": {
        "fields": [
          {
            "name": "active",
            "title": "Active",
            "type": "`$BOOLEAN`",
          },
          {
            "name": "api_version",
            "title": "Api Version",
            "type": "`$INTEGER`",
            "short": "Version of the callback output format.",
          },
          {
            "name": "id",
            "title": "Id",
            "type": "`$STRING`",
            "short": "Object ID",
            "format": "oid",
          },
          {
            "name": "invalid",
            "title": "Invalid",
            "type": "`$BOOLEAN`",
          },
          {
            "name": "receiver",
            "title": "Receiver",
            "type": "`$OBJECT`",
          },
          {
            "name": "receiver_type",
            "title": "Receiver Type",
            "type": "`$STRING`",
          },
          {
            "name": "type",
            "title": "Type",
            "type": "`$STRING`",
          },
          {
            "name": "url",
            "title": "Url",
            "type": "`$STRING`",
            "op": {
              "update": {
                "req": True,
                "type": "`$STRING`",
              },
            },
            "short": "WHATWG URL compliant",
            "format": "url",
          },
        ],
        "id": {
          "field": "id",
          "name": "id",
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
                    "lit": "callbacks",
                  },
                ],
                "parts": [
                  "callbacks",
                ],
                "rename": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "args": {},
                "select": {},
                "response": {
                  "kind": "json",
                  "media": "application/json",
                },
              },
            ],
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
                    "lit": "callbacks",
                  },
                ],
                "parts": [
                  "callbacks",
                ],
                "rename": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body.collection`",
                },
                "args": {},
                "select": {},
                "response": {
                  "kind": "json",
                  "media": "application/json",
                },
              },
            ],
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
                    "lit": "callbacks",
                  },
                  {
                    "var": "id",
                  },
                ],
                "parts": [
                  "callbacks",
                  "{id}",
                ],
                "rename": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "args": {
                  "params": [
                    {
                      "name": "id",
                      "orig": "id",
                      "type": "`$STRING`",
                      "kind": "param",
                      "reqd": True,
                      "example": "0f0f0f0f0f0f0f0f0f0f0f0f",
                    },
                  ],
                },
                "select": {
                  "exist": [
                    "id",
                  ],
                },
                "response": {
                  "kind": "json",
                  "media": "application/json",
                },
              },
              {
                "kind": "http",
                "method": "GET",
                "orig": "/callbacks/{id}/commands/test",
                "segments": [
                  {
                    "lit": "callbacks",
                  },
                  {
                    "var": "id",
                  },
                  {
                    "lit": "commands",
                  },
                  {
                    "lit": "test",
                  },
                ],
                "parts": [
                  "callbacks",
                  "{id}",
                  "commands",
                  "test",
                ],
                "rename": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "args": {
                  "params": [
                    {
                      "name": "id",
                      "orig": "id",
                      "type": "`$STRING`",
                      "kind": "param",
                      "reqd": True,
                      "example": "0f0f0f0f0f0f0f0f0f0f0f0f",
                    },
                  ],
                },
                "select": {
                  "$action": "command_test",
                  "exist": [
                    "id",
                  ],
                },
                "response": {
                  "kind": "json",
                  "media": "application/json",
                },
              },
            ],
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
                    "lit": "callbacks",
                  },
                  {
                    "var": "id",
                  },
                ],
                "parts": [
                  "callbacks",
                  "{id}",
                ],
                "rename": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "args": {
                  "params": [
                    {
                      "name": "id",
                      "orig": "id",
                      "type": "`$STRING`",
                      "kind": "param",
                      "reqd": True,
                      "example": "0f0f0f0f0f0f0f0f0f0f0f0f",
                    },
                  ],
                },
                "select": {
                  "exist": [
                    "id",
                  ],
                },
              },
            ],
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
                    "lit": "callbacks",
                  },
                  {
                    "var": "id",
                  },
                ],
                "parts": [
                  "callbacks",
                  "{id}",
                ],
                "rename": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "args": {
                  "params": [
                    {
                      "name": "id",
                      "orig": "id",
                      "type": "`$STRING`",
                      "kind": "param",
                      "reqd": True,
                      "example": "0f0f0f0f0f0f0f0f0f0f0f0f",
                    },
                  ],
                },
                "select": {
                  "exist": [
                    "id",
                  ],
                },
                "response": {
                  "kind": "json",
                  "media": "application/json",
                },
              },
              {
                "kind": "http",
                "method": "PUT",
                "orig": "/callbacks/{id}/commands/activate",
                "segments": [
                  {
                    "lit": "callbacks",
                  },
                  {
                    "var": "id",
                  },
                  {
                    "lit": "commands",
                  },
                  {
                    "lit": "activate",
                  },
                ],
                "parts": [
                  "callbacks",
                  "{id}",
                  "commands",
                  "activate",
                ],
                "rename": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "args": {
                  "params": [
                    {
                      "name": "id",
                      "orig": "id",
                      "type": "`$STRING`",
                      "kind": "param",
                      "reqd": True,
                      "example": "0f0f0f0f0f0f0f0f0f0f0f0f",
                    },
                  ],
                },
                "select": {
                  "$action": "command_activate",
                  "exist": [
                    "id",
                  ],
                },
              },
              {
                "kind": "http",
                "method": "PUT",
                "orig": "/callbacks/{id}/commands/deactivate",
                "segments": [
                  {
                    "lit": "callbacks",
                  },
                  {
                    "var": "id",
                  },
                  {
                    "lit": "commands",
                  },
                  {
                    "lit": "deactivate",
                  },
                ],
                "parts": [
                  "callbacks",
                  "{id}",
                  "commands",
                  "deactivate",
                ],
                "rename": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "args": {
                  "params": [
                    {
                      "name": "id",
                      "orig": "id",
                      "type": "`$STRING`",
                      "kind": "param",
                      "reqd": True,
                      "example": "0f0f0f0f0f0f0f0f0f0f0f0f",
                    },
                  ],
                },
                "select": {
                  "$action": "command_deactivate",
                  "exist": [
                    "id",
                  ],
                },
              },
            ],
          },
        },
        "relations": {
          "ancestors": [],
        },
      },
      "contact": {
        "fields": [
          {
            "name": "birthday_date",
            "title": "Birthday Date",
            "type": "`$STRING`",
            "format": "date",
          },
          {
            "name": "city",
            "title": "City",
            "type": "`$STRING`",
          },
          {
            "name": "collection",
            "title": "Collection",
            "type": "`$ARRAY`",
            "req": True,
          },
          {
            "name": "contact_expire_after",
            "title": "Contact Expire After",
            "type": "`$INTEGER`",
            "req": True,
            "short": "Contact expire after days",
          },
          {
            "name": "contacts_count",
            "title": "Contacts Count",
            "type": "`$INTEGER`",
            "req": True,
          },
          {
            "name": "country",
            "title": "Country",
            "type": "`$STRING`",
          },
          {
            "name": "created_by",
            "title": "Created By",
            "type": "`$STRING`",
            "req": True,
          },
          {
            "name": "date_created",
            "title": "Date Created",
            "type": "`$STRING`",
            "req": True,
            "format": "date-time",
          },
          {
            "name": "date_updated",
            "title": "Date Updated",
            "type": "`$STRING`",
            "req": True,
            "format": "date-time",
          },
          {
            "name": "description",
            "title": "Description",
            "type": "`$STRING`",
            "op": {
              "load": {
                "req": True,
                "type": "`$STRING`",
              },
            },
          },
          {
            "name": "email",
            "title": "Email",
            "type": "`$STRING`",
            "format": "email",
          },
          {
            "name": "first_name",
            "title": "First Name",
            "type": "`$STRING`",
          },
          {
            "name": "gender",
            "title": "Gender",
            "type": "`$STRING`",
            "req": True,
          },
          {
            "name": "groups",
            "title": "Groups",
            "type": "`$ARRAY`",
            "req": True,
          },
          {
            "name": "id",
            "title": "Id",
            "type": "`$STRING`",
            "req": True,
            "short": "Object ID",
            "format": "oid",
          },
          {
            "name": "idx",
            "title": "Idx",
            "type": "`$STRING`",
            "short": "User provided resource id",
          },
          {
            "name": "last_name",
            "title": "Last Name",
            "type": "`$STRING`",
          },
          {
            "name": "name",
            "title": "Name",
            "type": "`$STRING`",
            "req": True,
            "short": "Group name",
          },
          {
            "name": "permissions",
            "title": "Permissions",
            "type": "`$ARRAY`",
          },
          {
            "name": "phone_number",
            "title": "Phone Number",
            "type": "`$STRING`",
          },
          {
            "name": "size",
            "title": "Size",
            "type": "`$INTEGER`",
            "req": True,
          },
          {
            "name": "source",
            "title": "Source",
            "type": "`$STRING`",
          },
        ],
        "id": {
          "field": "id",
          "name": "id",
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
                    "lit": "contacts",
                  },
                  {
                    "var": "id",
                  },
                  {
                    "lit": "groups",
                  },
                ],
                "parts": [
                  "contacts",
                  "{id}",
                  "groups",
                ],
                "rename": {
                  "param": {
                    "contactId": "id",
                  },
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "args": {
                  "params": [
                    {
                      "name": "id",
                      "orig": "contactId",
                      "type": "`$STRING`",
                      "kind": "param",
                      "reqd": True,
                      "example": "0f0f0f0f0f0f0f0f0f0f0f0f",
                    },
                  ],
                },
                "select": {
                  "$action": "group",
                  "exist": [
                    "id",
                  ],
                },
                "body": {
                  "kind": "form",
                  "media": "application/x-www-form-urlencoded",
                },
                "response": {
                  "kind": "json",
                  "media": "application/json",
                },
              },
              {
                "kind": "http",
                "method": "POST",
                "orig": "/contacts",
                "segments": [
                  {
                    "lit": "contacts",
                  },
                ],
                "parts": [
                  "contacts",
                ],
                "rename": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "args": {},
                "select": {},
                "body": {
                  "fields": [
                    {
                      "name": "birthday_date",
                    },
                    {
                      "name": "browser",
                    },
                    {
                      "name": "city",
                    },
                    {
                      "name": "country",
                    },
                    {
                      "name": "description",
                    },
                    {
                      "name": "device",
                    },
                    {
                      "name": "email",
                    },
                    {
                      "name": "first_name",
                    },
                    {
                      "name": "gender",
                    },
                    {
                      "name": "idx",
                    },
                    {
                      "name": "last_name",
                    },
                    {
                      "name": "operating_system",
                    },
                    {
                      "name": "phone_number",
                    },
                    {
                      "name": "source",
                    },
                    {
                      "name": "undelivered_messages",
                    },
                  ],
                  "kind": "form",
                  "media": "application/x-www-form-urlencoded",
                },
                "response": {
                  "kind": "json",
                  "media": "application/json",
                },
              },
            ],
          },
          "list": {
            "input": "data",
            "name": "list",
            "points": [
              {
                "kind": "http",
                "method": "GET",
                "orig": "/contacts/{contactId}/groups",
                "segments": [
                  {
                    "lit": "contacts",
                  },
                  {
                    "var": "id",
                  },
                  {
                    "lit": "groups",
                  },
                ],
                "parts": [
                  "contacts",
                  "{id}",
                  "groups",
                ],
                "rename": {
                  "param": {
                    "contactId": "id",
                  },
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body.collection`",
                },
                "args": {
                  "params": [
                    {
                      "name": "id",
                      "orig": "contactId",
                      "type": "`$STRING`",
                      "kind": "param",
                      "reqd": True,
                      "example": "0f0f0f0f0f0f0f0f0f0f0f0f",
                    },
                  ],
                },
                "select": {
                  "$action": "group",
                  "exist": [
                    "id",
                  ],
                },
                "response": {
                  "kind": "json",
                  "media": "application/json",
                },
              },
              {
                "kind": "http",
                "method": "GET",
                "orig": "/contacts",
                "segments": [
                  {
                    "lit": "contacts",
                  },
                ],
                "parts": [
                  "contacts",
                ],
                "rename": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body.collection`",
                },
                "args": {
                  "query": [
                    {
                      "name": "birthday_date",
                      "orig": "birthday_date",
                      "type": "`$ARRAY`",
                      "kind": "query",
                      "example": "2022-06-24",
                      "field": True,
                    },
                    {
                      "name": "email",
                      "orig": "email",
                      "type": "`$ARRAY`",
                      "kind": "query",
                      "field": True,
                    },
                    {
                      "name": "first_name",
                      "orig": "first_name",
                      "type": "`$ARRAY`",
                      "kind": "query",
                      "field": True,
                    },
                    {
                      "name": "gender",
                      "orig": "gender",
                      "type": "`$STRING`",
                      "kind": "query",
                      "field": True,
                    },
                    {
                      "name": "group_id",
                      "orig": "group_id",
                      "type": "`$ARRAY`",
                      "kind": "query",
                    },
                    {
                      "name": "last_name",
                      "orig": "last_name",
                      "type": "`$ARRAY`",
                      "kind": "query",
                      "field": True,
                    },
                    {
                      "name": "limit",
                      "orig": "limit",
                      "type": "`$INTEGER`",
                      "kind": "query",
                      "example": 5,
                    },
                    {
                      "name": "offset",
                      "orig": "offset",
                      "type": "`$INTEGER`",
                      "kind": "query",
                      "example": 0,
                    },
                    {
                      "name": "order_by",
                      "orig": "order_by",
                      "type": "`$STRING`",
                      "kind": "query",
                    },
                    {
                      "name": "phone_number",
                      "orig": "phone_number",
                      "type": "`$ARRAY`",
                      "kind": "query",
                      "field": True,
                    },
                    {
                      "name": "q",
                      "orig": "q",
                      "type": "`$STRING`",
                      "kind": "query",
                    },
                  ],
                },
                "select": {},
                "response": {
                  "kind": "json",
                  "media": "application/json",
                },
              },
            ],
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
                    "lit": "contacts",
                  },
                  {
                    "lit": "groups",
                  },
                  {
                    "var": "group_id",
                  },
                  {
                    "lit": "members",
                  },
                  {
                    "var": "contact_id",
                  },
                ],
                "parts": [
                  "contacts",
                  "groups",
                  "{group_id}",
                  "members",
                  "{contact_id}",
                ],
                "rename": {
                  "param": {
                    "contactId": "contact_id",
                    "groupId": "group_id",
                  },
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "args": {
                  "params": [
                    {
                      "name": "contact_id",
                      "orig": "contactId",
                      "type": "`$STRING`",
                      "kind": "param",
                      "reqd": True,
                      "example": "0f0f0f0f0f0f0f0f0f0f0f0f",
                    },
                    {
                      "name": "group_id",
                      "orig": "groupId",
                      "type": "`$STRING`",
                      "kind": "param",
                      "reqd": True,
                      "example": "0f0f0f0f0f0f0f0f0f0f0f0f",
                    },
                  ],
                },
                "select": {
                  "exist": [
                    "contact_id",
                    "group_id",
                  ],
                },
                "response": {
                  "kind": "json",
                  "media": "application/json",
                },
              },
              {
                "kind": "http",
                "method": "GET",
                "orig": "/contacts/{contactId}/groups/{groupId}",
                "segments": [
                  {
                    "lit": "contacts",
                  },
                  {
                    "var": "id",
                  },
                  {
                    "lit": "groups",
                  },
                  {
                    "var": "group_id",
                  },
                ],
                "parts": [
                  "contacts",
                  "{id}",
                  "groups",
                  "{group_id}",
                ],
                "rename": {
                  "param": {
                    "contactId": "id",
                    "groupId": "group_id",
                  },
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "args": {
                  "params": [
                    {
                      "name": "group_id",
                      "orig": "groupId",
                      "type": "`$STRING`",
                      "kind": "param",
                      "reqd": True,
                      "example": "0f0f0f0f0f0f0f0f0f0f0f0f",
                    },
                    {
                      "name": "id",
                      "orig": "contactId",
                      "type": "`$STRING`",
                      "kind": "param",
                      "reqd": True,
                      "example": "0f0f0f0f0f0f0f0f0f0f0f0f",
                    },
                  ],
                },
                "select": {
                  "exist": [
                    "group_id",
                    "id",
                  ],
                },
                "response": {
                  "kind": "json",
                  "media": "application/json",
                },
              },
              {
                "kind": "http",
                "method": "GET",
                "orig": "/contacts/{contactId}",
                "segments": [
                  {
                    "lit": "contacts",
                  },
                  {
                    "var": "id",
                  },
                ],
                "parts": [
                  "contacts",
                  "{id}",
                ],
                "rename": {
                  "param": {
                    "contactId": "id",
                  },
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "args": {
                  "params": [
                    {
                      "name": "id",
                      "orig": "contactId",
                      "type": "`$STRING`",
                      "kind": "param",
                      "reqd": True,
                      "example": "0f0f0f0f0f0f0f0f0f0f0f0f",
                    },
                  ],
                },
                "select": {
                  "exist": [
                    "id",
                  ],
                },
                "response": {
                  "kind": "json",
                  "media": "application/json",
                },
              },
            ],
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
                    "lit": "contacts",
                  },
                  {
                    "var": "id",
                  },
                  {
                    "lit": "groups",
                  },
                  {
                    "var": "group_id",
                  },
                ],
                "parts": [
                  "contacts",
                  "{id}",
                  "groups",
                  "{group_id}",
                ],
                "rename": {
                  "param": {
                    "contactId": "id",
                    "groupId": "group_id",
                  },
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "args": {
                  "params": [
                    {
                      "name": "group_id",
                      "orig": "groupId",
                      "type": "`$STRING`",
                      "kind": "param",
                      "reqd": True,
                      "example": "0f0f0f0f0f0f0f0f0f0f0f0f",
                    },
                    {
                      "name": "id",
                      "orig": "contactId",
                      "type": "`$STRING`",
                      "kind": "param",
                      "reqd": True,
                      "example": "0f0f0f0f0f0f0f0f0f0f0f0f",
                    },
                  ],
                },
                "select": {
                  "exist": [
                    "group_id",
                    "id",
                  ],
                },
              },
              {
                "kind": "http",
                "method": "DELETE",
                "orig": "/contacts/{contactId}",
                "segments": [
                  {
                    "lit": "contacts",
                  },
                  {
                    "var": "id",
                  },
                ],
                "parts": [
                  "contacts",
                  "{id}",
                ],
                "rename": {
                  "param": {
                    "contactId": "id",
                  },
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "args": {
                  "params": [
                    {
                      "name": "id",
                      "orig": "contactId",
                      "type": "`$STRING`",
                      "kind": "param",
                      "reqd": True,
                      "example": "0f0f0f0f0f0f0f0f0f0f0f0f",
                    },
                  ],
                },
                "select": {
                  "exist": [
                    "id",
                  ],
                },
              },
              {
                "kind": "http",
                "method": "DELETE",
                "orig": "/contacts",
                "segments": [
                  {
                    "lit": "contacts",
                  },
                ],
                "parts": [
                  "contacts",
                ],
                "rename": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "args": {},
                "select": {},
              },
            ],
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
                    "lit": "contacts",
                  },
                  {
                    "lit": "groups",
                  },
                  {
                    "var": "group_id",
                  },
                  {
                    "lit": "members",
                  },
                  {
                    "var": "contact_id",
                  },
                ],
                "parts": [
                  "contacts",
                  "groups",
                  "{group_id}",
                  "members",
                  "{contact_id}",
                ],
                "rename": {
                  "param": {
                    "contactId": "contact_id",
                    "groupId": "group_id",
                  },
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "args": {
                  "params": [
                    {
                      "name": "contact_id",
                      "orig": "contactId",
                      "type": "`$STRING`",
                      "kind": "param",
                      "reqd": True,
                      "example": "0f0f0f0f0f0f0f0f0f0f0f0f",
                    },
                    {
                      "name": "group_id",
                      "orig": "groupId",
                      "type": "`$STRING`",
                      "kind": "param",
                      "reqd": True,
                      "example": "0f0f0f0f0f0f0f0f0f0f0f0f",
                    },
                  ],
                },
                "select": {
                  "exist": [
                    "contact_id",
                    "group_id",
                  ],
                },
                "response": {
                  "kind": "json",
                  "media": "application/json",
                },
              },
              {
                "kind": "http",
                "method": "PUT",
                "orig": "/contacts/{contactId}/groups/{groupId}",
                "segments": [
                  {
                    "lit": "contacts",
                  },
                  {
                    "var": "id",
                  },
                  {
                    "lit": "groups",
                  },
                  {
                    "var": "group_id",
                  },
                ],
                "parts": [
                  "contacts",
                  "{id}",
                  "groups",
                  "{group_id}",
                ],
                "rename": {
                  "param": {
                    "contactId": "id",
                    "groupId": "group_id",
                  },
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "args": {
                  "params": [
                    {
                      "name": "group_id",
                      "orig": "groupId",
                      "type": "`$STRING`",
                      "kind": "param",
                      "reqd": True,
                      "example": "0f0f0f0f0f0f0f0f0f0f0f0f",
                    },
                    {
                      "name": "id",
                      "orig": "contactId",
                      "type": "`$STRING`",
                      "kind": "param",
                      "reqd": True,
                      "example": "0f0f0f0f0f0f0f0f0f0f0f0f",
                    },
                  ],
                },
                "select": {
                  "exist": [
                    "group_id",
                    "id",
                  ],
                },
                "response": {
                  "kind": "json",
                  "media": "application/json",
                },
              },
              {
                "kind": "http",
                "method": "PUT",
                "orig": "/contacts/{contactId}",
                "segments": [
                  {
                    "lit": "contacts",
                  },
                  {
                    "var": "id",
                  },
                ],
                "parts": [
                  "contacts",
                  "{id}",
                ],
                "rename": {
                  "param": {
                    "contactId": "id",
                  },
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "args": {
                  "params": [
                    {
                      "name": "id",
                      "orig": "contactId",
                      "type": "`$STRING`",
                      "kind": "param",
                      "reqd": True,
                      "example": "0f0f0f0f0f0f0f0f0f0f0f0f",
                    },
                  ],
                },
                "select": {
                  "exist": [
                    "id",
                  ],
                },
                "body": {
                  "fields": [
                    {
                      "name": "birthday_date",
                    },
                    {
                      "name": "city",
                    },
                    {
                      "name": "description",
                    },
                    {
                      "name": "email",
                    },
                    {
                      "name": "first_name",
                    },
                    {
                      "name": "gender",
                    },
                    {
                      "name": "last_name",
                    },
                    {
                      "name": "phone_number",
                    },
                    {
                      "name": "source",
                    },
                  ],
                  "kind": "form",
                  "media": "application/x-www-form-urlencoded",
                },
                "response": {
                  "kind": "json",
                  "media": "application/json",
                },
              },
            ],
          },
        },
        "relations": {
          "ancestors": [
            [
              "$.main.kit.entity.group",
            ],
            [
              "$.main.kit.entity.group",
            ],
          ],
        },
      },
      "contacts_field": {
        "fields": [
          {
            "name": "id",
            "title": "Id",
            "type": "`$STRING`",
            "short": "Object ID",
            "format": "oid",
          },
          {
            "name": "name",
            "title": "Name",
            "type": "`$STRING`",
          },
          {
            "name": "type",
            "title": "Type",
            "type": "`$STRING`",
          },
        ],
        "id": {
          "field": "id",
          "name": "id",
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
                    "lit": "contacts",
                  },
                  {
                    "lit": "fields",
                  },
                ],
                "parts": [
                  "contacts",
                  "fields",
                ],
                "rename": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "args": {},
                "select": {},
                "body": {
                  "fields": [
                    {
                      "name": "name",
                    },
                    {
                      "name": "type",
                    },
                  ],
                  "kind": "form",
                  "media": "application/x-www-form-urlencoded",
                },
                "response": {
                  "kind": "json",
                  "media": "application/json",
                },
              },
            ],
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
                    "lit": "contacts",
                  },
                  {
                    "lit": "fields",
                  },
                ],
                "parts": [
                  "contacts",
                  "fields",
                ],
                "rename": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body.collection`",
                },
                "args": {},
                "select": {},
                "response": {
                  "kind": "json",
                  "media": "application/json",
                },
              },
            ],
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
                    "lit": "contacts",
                  },
                  {
                    "lit": "fields",
                  },
                  {
                    "var": "id",
                  },
                ],
                "parts": [
                  "contacts",
                  "fields",
                  "{id}",
                ],
                "rename": {
                  "param": {
                    "fieldId": "id",
                  },
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "args": {
                  "params": [
                    {
                      "name": "id",
                      "orig": "fieldId",
                      "type": "`$STRING`",
                      "kind": "param",
                      "reqd": True,
                      "example": "0f0f0f0f0f0f0f0f0f0f0f0f",
                    },
                  ],
                },
                "select": {
                  "exist": [
                    "id",
                  ],
                },
              },
            ],
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
                    "lit": "contacts",
                  },
                  {
                    "lit": "fields",
                  },
                  {
                    "var": "id",
                  },
                ],
                "parts": [
                  "contacts",
                  "fields",
                  "{id}",
                ],
                "rename": {
                  "param": {
                    "fieldId": "id",
                  },
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "args": {
                  "params": [
                    {
                      "name": "id",
                      "orig": "fieldId",
                      "type": "`$STRING`",
                      "kind": "param",
                      "reqd": True,
                      "example": "0f0f0f0f0f0f0f0f0f0f0f0f",
                    },
                  ],
                },
                "select": {
                  "exist": [
                    "id",
                  ],
                },
                "body": {
                  "fields": [
                    {
                      "name": "name",
                    },
                  ],
                  "kind": "form",
                  "media": "application/x-www-form-urlencoded",
                },
                "response": {
                  "kind": "json",
                  "media": "application/json",
                },
              },
            ],
          },
        },
        "relations": {
          "ancestors": [],
        },
      },
      "contacts_field_option": {
        "fields": [],
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
                    "lit": "contacts",
                  },
                  {
                    "lit": "fields",
                  },
                  {
                    "var": "field_id",
                  },
                  {
                    "lit": "options",
                  },
                ],
                "parts": [
                  "contacts",
                  "fields",
                  "{field_id}",
                  "options",
                ],
                "rename": {
                  "param": {
                    "fieldId": "field_id",
                  },
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body.collection`",
                },
                "args": {
                  "params": [
                    {
                      "name": "field_id",
                      "orig": "fieldId",
                      "type": "`$STRING`",
                      "kind": "param",
                      "reqd": True,
                      "example": "0f0f0f0f0f0f0f0f0f0f0f0f",
                    },
                  ],
                },
                "select": {
                  "exist": [
                    "field_id",
                  ],
                },
                "response": {
                  "kind": "json",
                  "media": "application/json",
                },
              },
            ],
          },
        },
        "relations": {
          "ancestors": [],
        },
      },
      "contactsgroup": {
        "fields": [
          {
            "name": "group_id",
            "title": "Group Id",
            "type": "`$STRING`",
            "req": True,
            "short": "Object ID",
            "format": "oid",
          },
          {
            "name": "read",
            "title": "Read",
            "type": "`$BOOLEAN`",
            "req": True,
            "short": "Has read permission",
          },
          {
            "name": "send",
            "title": "Send",
            "type": "`$BOOLEAN`",
            "req": True,
            "short": "Has send permission",
          },
          {
            "name": "username",
            "title": "Username",
            "type": "`$STRING`",
            "req": True,
          },
          {
            "name": "write",
            "title": "Write",
            "type": "`$BOOLEAN`",
            "req": True,
            "short": "Has write permission",
          },
        ],
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
                    "lit": "contacts",
                  },
                  {
                    "lit": "groups",
                  },
                  {
                    "var": "group_id",
                  },
                  {
                    "lit": "members",
                  },
                ],
                "parts": [
                  "contacts",
                  "groups",
                  "{group_id}",
                  "members",
                ],
                "rename": {
                  "param": {
                    "groupId": "group_id",
                  },
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "args": {
                  "params": [
                    {
                      "name": "group_id",
                      "orig": "groupId",
                      "type": "`$STRING`",
                      "kind": "param",
                      "reqd": True,
                      "example": "0f0f0f0f0f0f0f0f0f0f0f0f",
                    },
                  ],
                },
                "select": {
                  "exist": [
                    "group_id",
                  ],
                },
                "body": {
                  "fields": [
                    {
                      "list": True,
                      "name": "birthday_date",
                    },
                    {
                      "list": True,
                      "name": "email",
                    },
                    {
                      "list": True,
                      "name": "first_name",
                    },
                    {
                      "name": "gender",
                    },
                    {
                      "list": True,
                      "name": "group_id",
                    },
                    {
                      "list": True,
                      "name": "last_name",
                    },
                    {
                      "list": True,
                      "name": "phone_number",
                    },
                    {
                      "name": "q",
                    },
                  ],
                  "kind": "form",
                  "media": "application/x-www-form-urlencoded",
                },
              },
              {
                "kind": "http",
                "method": "POST",
                "orig": "/contacts/groups",
                "segments": [
                  {
                    "lit": "contacts",
                  },
                  {
                    "lit": "groups",
                  },
                ],
                "parts": [
                  "contacts",
                  "groups",
                ],
                "rename": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "args": {},
                "select": {},
                "body": {
                  "fields": [
                    {
                      "name": "contact_expire_after",
                    },
                    {
                      "name": "description",
                    },
                    {
                      "name": "idx",
                    },
                    {
                      "name": "name",
                    },
                  ],
                  "kind": "form",
                  "media": "application/x-www-form-urlencoded",
                },
                "response": {
                  "kind": "json",
                  "media": "application/json",
                },
              },
            ],
          },
          "list": {
            "input": "data",
            "name": "list",
            "points": [
              {
                "kind": "http",
                "method": "GET",
                "orig": "/contacts/groups/{groupId}/permissions",
                "segments": [
                  {
                    "lit": "contacts",
                  },
                  {
                    "lit": "groups",
                  },
                  {
                    "var": "group_id",
                  },
                  {
                    "lit": "permissions",
                  },
                ],
                "parts": [
                  "contacts",
                  "groups",
                  "{group_id}",
                  "permissions",
                ],
                "rename": {
                  "param": {
                    "groupId": "group_id",
                  },
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body.collection`",
                },
                "args": {
                  "params": [
                    {
                      "name": "group_id",
                      "orig": "groupId",
                      "type": "`$STRING`",
                      "kind": "param",
                      "reqd": True,
                      "example": "0f0f0f0f0f0f0f0f0f0f0f0f",
                    },
                  ],
                },
                "select": {
                  "exist": [
                    "group_id",
                  ],
                },
                "response": {
                  "kind": "json",
                  "media": "application/json",
                },
              },
              {
                "kind": "http",
                "method": "GET",
                "orig": "/contacts/groups",
                "segments": [
                  {
                    "lit": "contacts",
                  },
                  {
                    "lit": "groups",
                  },
                ],
                "parts": [
                  "contacts",
                  "groups",
                ],
                "rename": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body.collection`",
                },
                "args": {
                  "query": [
                    {
                      "name": "name",
                      "orig": "name",
                      "type": "`$OBJECT`",
                      "kind": "query",
                      "example": "{\"name\" : \"group name\"}",
                    },
                    {
                      "name": "with",
                      "orig": "with",
                      "type": "`$ARRAY`",
                      "kind": "query",
                    },
                  ],
                },
                "select": {},
                "response": {
                  "kind": "json",
                  "media": "application/json",
                },
              },
            ],
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
                    "lit": "contacts",
                  },
                  {
                    "lit": "groups",
                  },
                  {
                    "var": "group_id",
                  },
                  {
                    "lit": "members",
                  },
                  {
                    "var": "contact_id",
                  },
                ],
                "parts": [
                  "contacts",
                  "groups",
                  "{group_id}",
                  "members",
                  "{contact_id}",
                ],
                "rename": {
                  "param": {
                    "contactId": "contact_id",
                    "groupId": "group_id",
                  },
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "args": {
                  "params": [
                    {
                      "name": "contact_id",
                      "orig": "contactId",
                      "type": "`$STRING`",
                      "kind": "param",
                      "reqd": True,
                      "example": "0f0f0f0f0f0f0f0f0f0f0f0f",
                    },
                    {
                      "name": "group_id",
                      "orig": "groupId",
                      "type": "`$STRING`",
                      "kind": "param",
                      "reqd": True,
                      "example": "0f0f0f0f0f0f0f0f0f0f0f0f",
                    },
                  ],
                },
                "select": {
                  "exist": [
                    "contact_id",
                    "group_id",
                  ],
                },
              },
              {
                "kind": "http",
                "method": "DELETE",
                "orig": "/contacts/groups/{groupId}/permissions/{username}",
                "segments": [
                  {
                    "lit": "contacts",
                  },
                  {
                    "lit": "groups",
                  },
                  {
                    "var": "group_id",
                  },
                  {
                    "lit": "permissions",
                  },
                  {
                    "var": "username",
                  },
                ],
                "parts": [
                  "contacts",
                  "groups",
                  "{group_id}",
                  "permissions",
                  "{username}",
                ],
                "rename": {
                  "param": {
                    "groupId": "group_id",
                  },
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "args": {
                  "params": [
                    {
                      "name": "group_id",
                      "orig": "groupId",
                      "type": "`$STRING`",
                      "kind": "param",
                      "reqd": True,
                      "example": "0f0f0f0f0f0f0f0f0f0f0f0f",
                    },
                    {
                      "name": "username",
                      "orig": "username",
                      "type": "`$STRING`",
                      "kind": "param",
                      "reqd": True,
                      "example": "example_username",
                    },
                  ],
                },
                "select": {
                  "exist": [
                    "group_id",
                    "username",
                  ],
                },
              },
              {
                "kind": "http",
                "method": "DELETE",
                "orig": "/contacts/groups/{groupId}",
                "segments": [
                  {
                    "lit": "contacts",
                  },
                  {
                    "lit": "groups",
                  },
                  {
                    "var": "group_id",
                  },
                ],
                "parts": [
                  "contacts",
                  "groups",
                  "{group_id}",
                ],
                "rename": {
                  "param": {
                    "groupId": "group_id",
                  },
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "args": {
                  "params": [
                    {
                      "name": "group_id",
                      "orig": "groupId",
                      "type": "`$STRING`",
                      "kind": "param",
                      "reqd": True,
                      "example": "0f0f0f0f0f0f0f0f0f0f0f0f",
                    },
                  ],
                },
                "select": {
                  "exist": [
                    "group_id",
                  ],
                },
                "body": {
                  "fields": [
                    {
                      "name": "delete_contacts",
                    },
                  ],
                  "kind": "form",
                  "media": "application/x-www-form-urlencoded",
                },
              },
              {
                "kind": "http",
                "method": "DELETE",
                "orig": "/contacts/groups/{groupId}/members",
                "segments": [
                  {
                    "lit": "contacts",
                  },
                  {
                    "lit": "groups",
                  },
                  {
                    "var": "group_id",
                  },
                  {
                    "lit": "members",
                  },
                ],
                "parts": [
                  "contacts",
                  "groups",
                  "{group_id}",
                  "members",
                ],
                "rename": {
                  "param": {
                    "groupId": "group_id",
                  },
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "args": {
                  "params": [
                    {
                      "name": "group_id",
                      "orig": "groupId",
                      "type": "`$STRING`",
                      "kind": "param",
                      "reqd": True,
                      "example": "0f0f0f0f0f0f0f0f0f0f0f0f",
                    },
                  ],
                },
                "select": {
                  "exist": [
                    "group_id",
                  ],
                },
                "body": {
                  "fields": [
                    {
                      "list": True,
                      "name": "birthday_date",
                    },
                    {
                      "list": True,
                      "name": "email",
                    },
                    {
                      "list": True,
                      "name": "first_name",
                    },
                    {
                      "name": "gender",
                    },
                    {
                      "list": True,
                      "name": "group_id",
                    },
                    {
                      "list": True,
                      "name": "last_name",
                    },
                    {
                      "list": True,
                      "name": "phone_number",
                    },
                    {
                      "name": "q",
                    },
                  ],
                  "kind": "form",
                  "media": "application/x-www-form-urlencoded",
                },
              },
              {
                "kind": "http",
                "method": "DELETE",
                "orig": "/contacts/groups",
                "segments": [
                  {
                    "lit": "contacts",
                  },
                  {
                    "lit": "groups",
                  },
                ],
                "parts": [
                  "contacts",
                  "groups",
                ],
                "rename": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "args": {},
                "select": {},
              },
            ],
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
                    "lit": "contacts",
                  },
                  {
                    "lit": "groups",
                  },
                  {
                    "var": "group_id",
                  },
                  {
                    "lit": "permissions",
                  },
                  {
                    "var": "username",
                  },
                ],
                "parts": [
                  "contacts",
                  "groups",
                  "{group_id}",
                  "permissions",
                  "{username}",
                ],
                "rename": {
                  "param": {
                    "groupId": "group_id",
                  },
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "args": {
                  "params": [
                    {
                      "name": "group_id",
                      "orig": "groupId",
                      "type": "`$STRING`",
                      "kind": "param",
                      "reqd": True,
                      "example": "0f0f0f0f0f0f0f0f0f0f0f0f",
                    },
                    {
                      "name": "username",
                      "orig": "username",
                      "type": "`$STRING`",
                      "kind": "param",
                      "reqd": True,
                      "example": "example_username",
                    },
                  ],
                },
                "select": {
                  "exist": [
                    "group_id",
                    "username",
                  ],
                },
                "body": {
                  "fields": [
                    {
                      "name": "read",
                    },
                    {
                      "name": "send",
                    },
                    {
                      "name": "write",
                    },
                  ],
                  "kind": "form",
                  "media": "application/x-www-form-urlencoded",
                },
                "response": {
                  "kind": "json",
                  "media": "application/json",
                },
              },
              {
                "kind": "http",
                "method": "PUT",
                "orig": "/contacts/groups/{groupId}/members",
                "segments": [
                  {
                    "lit": "contacts",
                  },
                  {
                    "lit": "groups",
                  },
                  {
                    "var": "group_id",
                  },
                  {
                    "lit": "members",
                  },
                ],
                "parts": [
                  "contacts",
                  "groups",
                  "{group_id}",
                  "members",
                ],
                "rename": {
                  "param": {
                    "groupId": "group_id",
                  },
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "args": {
                  "params": [
                    {
                      "name": "group_id",
                      "orig": "groupId",
                      "type": "`$STRING`",
                      "kind": "param",
                      "reqd": True,
                      "example": "0f0f0f0f0f0f0f0f0f0f0f0f",
                    },
                  ],
                },
                "select": {
                  "exist": [
                    "group_id",
                  ],
                },
                "body": {
                  "fields": [
                    {
                      "list": True,
                      "name": "birthday_date",
                    },
                    {
                      "list": True,
                      "name": "email",
                    },
                    {
                      "list": True,
                      "name": "first_name",
                    },
                    {
                      "name": "gender",
                    },
                    {
                      "list": True,
                      "name": "group_id",
                    },
                    {
                      "list": True,
                      "name": "last_name",
                    },
                    {
                      "list": True,
                      "name": "phone_number",
                    },
                    {
                      "name": "q",
                    },
                  ],
                  "kind": "form",
                  "media": "application/x-www-form-urlencoded",
                },
              },
            ],
          },
        },
        "relations": {
          "ancestors": [
            [
              "$.main.kit.entity.group",
            ],
            [
              "$.main.kit.entity.group",
            ],
            [
              "$.main.kit.entity.group",
              "$.main.kit.entity.permission",
            ],
          ],
        },
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
                    "lit": "contacts",
                  },
                  {
                    "lit": "trash",
                  },
                ],
                "parts": [
                  "contacts",
                  "trash",
                ],
                "rename": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "args": {},
                "select": {},
              },
            ],
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
                    "lit": "contacts",
                  },
                  {
                    "lit": "trash",
                  },
                  {
                    "lit": "restore",
                  },
                ],
                "parts": [
                  "contacts",
                  "trash",
                  "restore",
                ],
                "rename": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "args": {},
                "select": {},
              },
            ],
          },
        },
        "relations": {
          "ancestors": [],
        },
      },
      "field_available": {
        "fields": [
          {
            "name": "built_in",
            "title": "Built In",
            "type": "`$BOOLEAN`",
          },
          {
            "name": "id",
            "title": "Id",
            "type": "`$STRING`",
            "short": "Object ID",
            "format": "oid",
          },
          {
            "name": "name",
            "title": "Name",
            "type": "`$STRING`",
          },
          {
            "name": "options",
            "title": "Options",
            "type": "`$ARRAY`",
          },
          {
            "name": "type",
            "title": "Type",
            "type": "`$STRING`",
          },
        ],
        "id": {
          "field": "id",
          "name": "id",
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
                    "lit": "contacts",
                  },
                  {
                    "lit": "fields",
                  },
                  {
                    "lit": "available",
                  },
                ],
                "parts": [
                  "contacts",
                  "fields",
                  "available",
                ],
                "rename": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "args": {},
                "select": {},
                "response": {
                  "kind": "json",
                  "media": "application/json",
                },
              },
            ],
          },
        },
        "relations": {
          "ancestors": [],
        },
      },
      "group": {
        "fields": [
          {
            "name": "contact_expire_after",
            "title": "Contact Expire After",
            "type": "`$INTEGER`",
            "req": True,
            "short": "Contact expire after days",
          },
          {
            "name": "contacts_count",
            "title": "Contacts Count",
            "type": "`$INTEGER`",
            "req": True,
          },
          {
            "name": "created_by",
            "title": "Created By",
            "type": "`$STRING`",
            "req": True,
          },
          {
            "name": "date_created",
            "title": "Date Created",
            "type": "`$STRING`",
            "req": True,
            "format": "date-time",
          },
          {
            "name": "date_updated",
            "title": "Date Updated",
            "type": "`$STRING`",
            "req": True,
            "format": "date-time",
          },
          {
            "name": "description",
            "title": "Description",
            "type": "`$STRING`",
            "req": True,
          },
          {
            "name": "id",
            "title": "Id",
            "type": "`$STRING`",
            "req": True,
            "short": "Object ID",
            "format": "oid",
          },
          {
            "name": "idx",
            "title": "Idx",
            "type": "`$STRING`",
            "short": "User provided resource id",
          },
          {
            "name": "name",
            "title": "Name",
            "type": "`$STRING`",
            "req": True,
            "short": "Group name",
          },
          {
            "name": "permissions",
            "title": "Permissions",
            "type": "`$ARRAY`",
          },
        ],
        "id": {
          "field": "id",
          "name": "id",
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
                    "lit": "contacts",
                  },
                  {
                    "lit": "groups",
                  },
                  {
                    "var": "id",
                  },
                ],
                "parts": [
                  "contacts",
                  "groups",
                  "{id}",
                ],
                "rename": {
                  "param": {
                    "groupId": "id",
                  },
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "args": {
                  "params": [
                    {
                      "name": "id",
                      "orig": "groupId",
                      "type": "`$STRING`",
                      "kind": "param",
                      "reqd": True,
                      "example": "0f0f0f0f0f0f0f0f0f0f0f0f",
                    },
                  ],
                },
                "select": {
                  "exist": [
                    "id",
                  ],
                },
                "response": {
                  "kind": "json",
                  "media": "application/json",
                },
              },
            ],
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
                    "lit": "contacts",
                  },
                  {
                    "lit": "groups",
                  },
                  {
                    "var": "id",
                  },
                ],
                "parts": [
                  "contacts",
                  "groups",
                  "{id}",
                ],
                "rename": {
                  "param": {
                    "groupId": "id",
                  },
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "args": {
                  "params": [
                    {
                      "name": "id",
                      "orig": "groupId",
                      "type": "`$STRING`",
                      "kind": "param",
                      "reqd": True,
                      "example": "0f0f0f0f0f0f0f0f0f0f0f0f",
                    },
                  ],
                },
                "select": {
                  "exist": [
                    "id",
                  ],
                },
                "body": {
                  "fields": [
                    {
                      "name": "contact_expire_after",
                    },
                    {
                      "name": "description",
                    },
                    {
                      "name": "idx",
                    },
                    {
                      "name": "name",
                    },
                  ],
                  "kind": "form",
                  "media": "application/x-www-form-urlencoded",
                },
                "response": {
                  "kind": "json",
                  "media": "application/json",
                },
              },
            ],
          },
        },
        "relations": {
          "ancestors": [],
        },
      },
      "mfa_code": {
        "fields": [
          {
            "name": "content",
            "title": "Content",
            "type": "`$STRING`",
            "short": "Custom content that must contain placeholder [%code%]",
          },
          {
            "name": "fast",
            "title": "Fast",
            "type": "`$ANY`",
          },
          {
            "name": "from",
            "title": "From",
            "type": "`$STRING`",
            "short": "Sendername",
          },
          {
            "name": "phone_number",
            "title": "Phone Number",
            "type": "`$STRING`",
            "req": True,
          },
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
                    "lit": "mfa",
                  },
                  {
                    "lit": "codes",
                  },
                ],
                "parts": [
                  "mfa",
                  "codes",
                ],
                "rename": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "args": {},
                "select": {},
                "response": {
                  "kind": "json",
                  "media": "application/json",
                },
              },
              {
                "kind": "http",
                "method": "POST",
                "orig": "/mfa/codes/verifications",
                "segments": [
                  {
                    "lit": "mfa",
                  },
                  {
                    "lit": "codes",
                  },
                  {
                    "lit": "verifications",
                  },
                ],
                "parts": [
                  "mfa",
                  "codes",
                  "verifications",
                ],
                "rename": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "args": {},
                "select": {
                  "$action": "verification",
                },
                "body": {
                  "fields": [
                    {
                      "name": "code",
                    },
                    {
                      "name": "phone_number",
                    },
                  ],
                  "kind": "form",
                  "media": "application/x-www-form-urlencoded",
                },
              },
            ],
          },
        },
        "relations": {
          "ancestors": [],
        },
      },
      "opt_out": {
        "fields": [
          {
            "name": "date",
            "title": "Date",
            "type": "`$STRING`",
            "format": "date-time",
          },
          {
            "name": "id",
            "title": "Id",
            "type": "`$STRING`",
          },
          {
            "name": "links",
            "title": "Links",
            "type": "`$ARRAY`",
          },
          {
            "name": "phoneNumber",
            "title": "Phone Number",
            "type": "`$INTEGER`",
          },
        ],
        "id": {
          "field": "id",
          "name": "id",
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
                    "lit": "opt_outs",
                  },
                ],
                "parts": [
                  "opt_outs",
                ],
                "rename": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body.collection`",
                },
                "args": {
                  "header": [
                    {
                      "name": "accept",
                      "orig": "Accept",
                      "type": "`$STRING`",
                      "kind": "header",
                      "example": "application/json",
                    },
                    {
                      "name": "x_async",
                      "orig": "x-async",
                      "type": "`$BOOLEAN`",
                      "kind": "header",
                      "example": False,
                    },
                  ],
                  "query": [
                    {
                      "name": "limit",
                      "orig": "limit",
                      "type": "`$INTEGER`",
                      "kind": "query",
                      "example": 5,
                    },
                    {
                      "name": "offset",
                      "orig": "offset",
                      "type": "`$INTEGER`",
                      "kind": "query",
                      "example": 0,
                    },
                    {
                      "name": "phone_number",
                      "orig": "phone_number",
                      "type": "`$STRING`",
                      "kind": "query",
                    },
                  ],
                },
                "select": {},
                "response": {
                  "alternatives": [
                    {
                      "kind": "raw",
                      "media": "text/csv",
                    },
                  ],
                  "kind": "json",
                  "media": "application/json",
                },
              },
            ],
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
                    "lit": "opt_outs",
                  },
                  {
                    "var": "id",
                  },
                ],
                "parts": [
                  "opt_outs",
                  "{id}",
                ],
                "rename": {
                  "param": {
                    "optOutId": "id",
                  },
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "args": {
                  "params": [
                    {
                      "name": "id",
                      "orig": "optOutId",
                      "type": "`$STRING`",
                      "kind": "param",
                      "reqd": True,
                    },
                  ],
                },
                "select": {
                  "exist": [
                    "id",
                  ],
                },
              },
            ],
          },
        },
        "relations": {
          "ancestors": [],
        },
      },
      "opt_out_setting": {
        "fields": [
          {
            "name": "brand",
            "title": "Brand",
            "type": "`$STRING`",
          },
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
                    "lit": "opt_outs",
                  },
                  {
                    "lit": "settings",
                  },
                ],
                "parts": [
                  "opt_outs",
                  "settings",
                ],
                "rename": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "args": {},
                "select": {},
                "response": {
                  "kind": "json",
                  "media": "application/json",
                },
              },
            ],
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
                    "lit": "opt_outs",
                  },
                  {
                    "lit": "settings",
                  },
                ],
                "parts": [
                  "opt_outs",
                  "settings",
                ],
                "rename": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "args": {},
                "select": {},
                "response": {
                  "kind": "json",
                  "media": "application/json",
                },
              },
            ],
          },
        },
        "relations": {
          "ancestors": [],
        },
      },
      "permission": {
        "fields": [
          {
            "name": "group_id",
            "title": "Group Id",
            "type": "`$STRING`",
            "req": True,
            "short": "Object ID",
            "format": "oid",
          },
          {
            "name": "id",
            "title": "Id",
            "type": "`$STRING`",
          },
          {
            "name": "read",
            "title": "Read",
            "type": "`$BOOLEAN`",
            "req": True,
            "short": "Has read permission",
          },
          {
            "name": "send",
            "title": "Send",
            "type": "`$BOOLEAN`",
            "req": True,
            "short": "Has send permission",
          },
          {
            "name": "username",
            "title": "Username",
            "type": "`$STRING`",
            "req": True,
          },
          {
            "name": "write",
            "title": "Write",
            "type": "`$BOOLEAN`",
            "req": True,
            "short": "Has write permission",
          },
        ],
        "id": {
          "field": "id",
          "name": "id",
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
                    "lit": "contacts",
                  },
                  {
                    "lit": "groups",
                  },
                  {
                    "var": "group_id",
                  },
                  {
                    "lit": "permissions",
                  },
                ],
                "parts": [
                  "contacts",
                  "groups",
                  "{group_id}",
                  "permissions",
                ],
                "rename": {
                  "param": {
                    "groupId": "group_id",
                  },
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "args": {
                  "params": [
                    {
                      "name": "group_id",
                      "orig": "groupId",
                      "type": "`$STRING`",
                      "kind": "param",
                      "reqd": True,
                      "example": "0f0f0f0f0f0f0f0f0f0f0f0f",
                    },
                  ],
                },
                "select": {
                  "exist": [
                    "group_id",
                  ],
                },
                "body": {
                  "fields": [
                    {
                      "name": "read",
                    },
                    {
                      "name": "send",
                    },
                    {
                      "name": "username",
                    },
                    {
                      "name": "write",
                    },
                  ],
                  "kind": "form",
                  "media": "application/x-www-form-urlencoded",
                },
                "response": {
                  "kind": "json",
                  "media": "application/json",
                },
              },
            ],
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
                    "lit": "contacts",
                  },
                  {
                    "lit": "groups",
                  },
                  {
                    "var": "group_id",
                  },
                  {
                    "lit": "permissions",
                  },
                  {
                    "var": "id",
                  },
                ],
                "parts": [
                  "contacts",
                  "groups",
                  "{group_id}",
                  "permissions",
                  "{id}",
                ],
                "rename": {
                  "param": {
                    "groupId": "group_id",
                    "username": "id",
                  },
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "args": {
                  "params": [
                    {
                      "name": "group_id",
                      "orig": "groupId",
                      "type": "`$STRING`",
                      "kind": "param",
                      "reqd": True,
                      "example": "0f0f0f0f0f0f0f0f0f0f0f0f",
                    },
                    {
                      "name": "id",
                      "orig": "username",
                      "type": "`$STRING`",
                      "kind": "param",
                      "reqd": True,
                      "example": "example_username",
                    },
                  ],
                },
                "select": {
                  "exist": [
                    "group_id",
                    "id",
                  ],
                },
                "response": {
                  "kind": "json",
                  "media": "application/json",
                },
              },
            ],
          },
        },
        "relations": {
          "ancestors": [
            [
              "$.main.kit.entity.group",
            ],
          ],
        },
      },
      "ping": {
        "fields": [
          {
            "name": "authorized",
            "title": "Authorized",
            "type": "`$BOOLEAN`",
            "req": True,
          },
          {
            "name": "unavailable",
            "title": "Unavailable",
            "type": "`$ARRAY`",
            "req": True,
          },
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
                    "lit": "ping",
                  },
                ],
                "parts": [
                  "ping",
                ],
                "rename": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body.unavailable`",
                },
                "args": {},
                "select": {},
                "response": {
                  "kind": "json",
                  "media": "application/json",
                },
              },
            ],
          },
        },
        "relations": {
          "ancestors": [],
        },
      },
      "profile": {
        "fields": [
          {
            "name": "email",
            "title": "Email",
            "type": "`$STRING`",
            "req": True,
          },
          {
            "name": "name",
            "title": "Name",
            "type": "`$STRING`",
            "req": True,
          },
          {
            "name": "payment_type",
            "title": "Payment Type",
            "type": "`$STRING`",
            "req": True,
          },
          {
            "name": "phone_number",
            "title": "Phone Number",
            "type": "`$INTEGER`",
            "req": True,
          },
          {
            "name": "points",
            "title": "Points",
            "type": "`$NUMBER`",
            "format": "float",
          },
          {
            "name": "user_type",
            "title": "User Type",
            "type": "`$STRING`",
            "req": True,
          },
          {
            "name": "username",
            "title": "Username",
            "type": "`$STRING`",
            "req": True,
          },
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
                    "lit": "profile",
                  },
                  {
                    "lit": "prices",
                  },
                ],
                "parts": [
                  "profile",
                  "prices",
                ],
                "rename": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body.collection`",
                },
                "args": {
                  "query": [
                    {
                      "name": "type",
                      "orig": "type",
                      "type": "`$STRING`",
                      "kind": "query",
                      "example": "eco",
                    },
                  ],
                },
                "select": {
                  "$action": "price",
                },
                "response": {
                  "kind": "json",
                  "media": "application/json",
                },
              },
            ],
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
                    "lit": "profile",
                  },
                ],
                "parts": [
                  "profile",
                ],
                "rename": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "args": {},
                "select": {},
                "response": {
                  "kind": "json",
                  "media": "application/json",
                },
              },
            ],
          },
        },
        "relations": {
          "ancestors": [],
        },
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
                    "lit": "rcs",
                  },
                  {
                    "lit": "messages",
                  },
                ],
                "parts": [
                  "rcs",
                  "messages",
                ],
                "rename": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body.collection`",
                },
                "args": {},
                "select": {
                  "$action": "message",
                },
                "response": {
                  "kind": "json",
                  "media": "application/json",
                },
              },
            ],
          },
        },
        "relations": {
          "ancestors": [],
        },
      },
      "sendername": {
        "fields": [
          {
            "name": "created_at",
            "title": "Created At",
            "type": "`$STRING`",
            "format": "date-time",
          },
          {
            "name": "id",
            "title": "Id",
            "type": "`$STRING`",
          },
          {
            "name": "is_default",
            "title": "Is Default",
            "type": "`$BOOLEAN`",
          },
          {
            "name": "sender",
            "title": "Sender",
            "type": "`$STRING`",
            "short": "Sendername",
          },
          {
            "name": "status",
            "title": "Status",
            "type": "`$STRING`",
          },
        ],
        "id": {
          "field": "id",
          "name": "id",
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
                    "lit": "sms",
                  },
                  {
                    "lit": "sendernames",
                  },
                ],
                "parts": [
                  "sms",
                  "sendernames",
                ],
                "rename": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "args": {},
                "select": {},
                "body": {
                  "fields": [
                    {
                      "name": "sender",
                    },
                  ],
                  "kind": "form",
                  "media": "application/x-www-form-urlencoded",
                },
                "response": {
                  "kind": "json",
                  "media": "application/json",
                },
              },
            ],
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
                    "lit": "sms",
                  },
                  {
                    "lit": "sendernames",
                  },
                ],
                "parts": [
                  "sms",
                  "sendernames",
                ],
                "rename": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body.collection`",
                },
                "args": {},
                "select": {},
                "response": {
                  "kind": "json",
                  "media": "application/json",
                },
              },
            ],
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
                    "lit": "sms",
                  },
                  {
                    "lit": "sendernames",
                  },
                  {
                    "var": "id",
                  },
                ],
                "parts": [
                  "sms",
                  "sendernames",
                  "{id}",
                ],
                "rename": {
                  "param": {
                    "sender": "id",
                  },
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "args": {
                  "params": [
                    {
                      "name": "id",
                      "orig": "sender",
                      "type": "`$STRING`",
                      "kind": "param",
                      "reqd": True,
                    },
                  ],
                },
                "select": {
                  "exist": [
                    "id",
                  ],
                },
                "response": {
                  "kind": "json",
                  "media": "application/json",
                },
              },
            ],
          },
        },
        "relations": {
          "ancestors": [],
        },
      },
      "sendername_statement": {
        "fields": [
          {
            "name": "content",
            "title": "Content",
            "type": "`$STRING`",
          },
          {
            "name": "statements",
            "title": "Statements",
            "type": "`$ARRAY`",
          },
          {
            "name": "title",
            "title": "Title",
            "type": "`$STRING`",
          },
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
                    "lit": "sms",
                  },
                  {
                    "lit": "sendernames",
                  },
                  {
                    "lit": "statement",
                  },
                ],
                "parts": [
                  "sms",
                  "sendernames",
                  "statement",
                ],
                "rename": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body.sections`",
                },
                "args": {},
                "select": {},
                "response": {
                  "kind": "json",
                  "media": "application/json",
                },
              },
            ],
          },
        },
        "relations": {
          "ancestors": [],
        },
      },
      "sent_rcs_message": {
        "fields": [
          {
            "name": "content",
            "title": "Content",
            "type": "`$OBJECT`",
            "short": "RCS message content in RCS JSON format.",
          },
          {
            "name": "phone_number",
            "title": "Phone Number",
            "type": "`$STRING`",
            "req": True,
            "short": "Recipient phone number (e.g.",
          },
          {
            "name": "sender",
            "title": "Sender",
            "type": "`$STRING`",
            "req": True,
            "short": "RCS sender ID (object ID of the agent/sender the user has access to).",
            "format": "oid",
          },
          {
            "name": "text",
            "title": "Text",
            "type": "`$STRING`",
            "short": "Plain text message content.",
          },
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
                    "lit": "rcs",
                  },
                  {
                    "lit": "messages",
                  },
                ],
                "parts": [
                  "rcs",
                  "messages",
                ],
                "rename": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "args": {},
                "select": {},
                "body": {
                  "alternatives": [
                    {
                      "fields": [
                        {
                          "name": "content",
                        },
                        {
                          "name": "phone_number",
                        },
                        {
                          "name": "sender",
                        },
                        {
                          "name": "text",
                        },
                      ],
                      "kind": "form",
                      "media": "application/x-www-form-urlencoded",
                    },
                  ],
                  "kind": "json",
                  "media": "application/json",
                },
                "response": {
                  "kind": "json",
                  "media": "application/json",
                },
              },
            ],
          },
        },
        "relations": {
          "ancestors": [],
        },
      },
      "shipment_country_volume": {
        "fields": [
          {
            "name": "country_code",
            "title": "Country Code",
            "type": "`$STRING`",
          },
          {
            "name": "country_limit",
            "title": "Country Limit",
            "type": "`$INTEGER`",
          },
          {
            "name": "country_name",
            "title": "Country Name",
            "type": "`$STRING`",
          },
          {
            "name": "usage",
            "title": "Usage",
            "type": "`$INTEGER`",
          },
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
                    "lit": "shipment",
                  },
                  {
                    "lit": "country_volumes",
                  },
                ],
                "parts": [
                  "shipment",
                  "country_volumes",
                ],
                "rename": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body.collection`",
                },
                "args": {
                  "header": [
                    {
                      "name": "accept",
                      "orig": "Accept",
                      "type": "`$STRING`",
                      "kind": "header",
                      "example": "application/json",
                    },
                  ],
                  "query": [
                    {
                      "name": "month",
                      "orig": "month",
                      "type": "`$STRING`",
                      "kind": "query",
                    },
                    {
                      "name": "year",
                      "orig": "year",
                      "type": "`$STRING`",
                      "kind": "query",
                    },
                  ],
                },
                "select": {},
                "response": {
                  "alternatives": [
                    {
                      "kind": "raw",
                      "media": "text/csv",
                    },
                  ],
                  "kind": "json",
                  "media": "application/json",
                },
              },
            ],
          },
        },
        "relations": {
          "ancestors": [],
        },
      },
      "short_url": {
        "fields": [
          {
            "name": "description",
            "title": "Description",
            "type": "`$STRING`",
          },
          {
            "name": "expire",
            "title": "Expire",
            "type": "`$STRING`",
            "format": "date-time",
          },
          {
            "name": "filename",
            "title": "Filename",
            "type": "`$STRING`",
          },
          {
            "name": "hits",
            "title": "Hits",
            "type": "`$INTEGER`",
          },
          {
            "name": "hits_unique",
            "title": "Hits Unique",
            "type": "`$INTEGER`",
          },
          {
            "name": "id",
            "title": "Id",
            "type": "`$STRING`",
          },
          {
            "name": "name",
            "title": "Name",
            "type": "`$STRING`",
          },
          {
            "name": "short_url",
            "title": "Short Url",
            "type": "`$STRING`",
            "short": "WHATWG URL compliant",
            "format": "url",
          },
          {
            "name": "type",
            "title": "Type",
            "type": "`$STRING`",
          },
          {
            "name": "url",
            "title": "Url",
            "type": "`$STRING`",
            "short": "WHATWG URL compliant",
            "format": "url",
          },
        ],
        "id": {
          "field": "id",
          "name": "id",
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
                    "lit": "short_url",
                  },
                  {
                    "lit": "links",
                  },
                ],
                "parts": [
                  "short_url",
                  "links",
                ],
                "rename": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "args": {},
                "select": {
                  "$action": "link",
                },
                "body": {
                  "alternatives": [
                    {
                      "kind": "form",
                      "media": "application/x-www-form-urlencoded",
                    },
                  ],
                  "kind": "json",
                  "media": "application/json",
                },
                "response": {
                  "kind": "json",
                  "media": "application/json",
                },
              },
            ],
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
                    "lit": "short_url",
                  },
                  {
                    "lit": "links",
                  },
                ],
                "parts": [
                  "short_url",
                  "links",
                ],
                "rename": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body.collection`",
                },
                "args": {},
                "select": {
                  "$action": "link",
                },
                "response": {
                  "kind": "json",
                  "media": "application/json",
                },
              },
            ],
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
                    "lit": "short_url",
                  },
                  {
                    "lit": "links",
                  },
                  {
                    "var": "id",
                  },
                ],
                "parts": [
                  "short_url",
                  "links",
                  "{id}",
                ],
                "rename": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "args": {
                  "params": [
                    {
                      "name": "id",
                      "orig": "id",
                      "type": "`$STRING`",
                      "kind": "param",
                      "reqd": True,
                      "example": "123",
                    },
                  ],
                },
                "select": {
                  "exist": [
                    "id",
                  ],
                },
                "response": {
                  "kind": "json",
                  "media": "application/json",
                },
              },
            ],
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
                    "lit": "short_url",
                  },
                  {
                    "lit": "links",
                  },
                  {
                    "var": "id",
                  },
                ],
                "parts": [
                  "short_url",
                  "links",
                  "{id}",
                ],
                "rename": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "args": {
                  "params": [
                    {
                      "name": "id",
                      "orig": "id",
                      "type": "`$STRING`",
                      "kind": "param",
                      "reqd": True,
                      "example": "123",
                    },
                  ],
                },
                "select": {
                  "exist": [
                    "id",
                  ],
                },
              },
            ],
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
                    "lit": "short_url",
                  },
                  {
                    "lit": "links",
                  },
                  {
                    "var": "id",
                  },
                ],
                "parts": [
                  "short_url",
                  "links",
                  "{id}",
                ],
                "rename": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "args": {
                  "params": [
                    {
                      "name": "id",
                      "orig": "id",
                      "type": "`$STRING`",
                      "kind": "param",
                      "reqd": True,
                      "example": "123",
                    },
                  ],
                },
                "select": {
                  "exist": [
                    "id",
                  ],
                },
                "body": {
                  "fields": [
                    {
                      "name": "description",
                    },
                    {
                      "name": "name",
                    },
                    {
                      "name": "url",
                    },
                  ],
                  "kind": "form",
                  "media": "application/x-www-form-urlencoded",
                },
                "response": {
                  "kind": "json",
                  "media": "application/json",
                },
              },
            ],
          },
        },
        "relations": {
          "ancestors": [],
        },
      },
      "smsdo": {
        "fields": [
          {
            "name": "allow_duplicates",
            "title": "Allow Duplicates",
            "type": "`$INTEGER`",
            "short": "When parameter allow_duplicates is set to \"1\" allows to send message to duplicated numbers in one request (useful i.e.",
          },
          {
            "name": "check_idx",
            "title": "Check Idx",
            "type": "`$ANY`",
            "short": "When parameter check_idx is set to „1” prevents from sending more than one message with the same idx in last 24h.",
          },
          {
            "name": "date",
            "title": "Date",
            "type": "`$ANY`",
            "short": "Date in UNIX timestamp (&date=1287734110) or in ISO 8601 (&date=2012-05-10T08:40:27+00:00) when message will be sent (&date=1287734110).",
          },
          {
            "name": "date_validate",
            "title": "Date Validate",
            "type": "`$INTEGER`",
            "short": "When parameter date_validate is set to \"1\" checks if date if given in proper format.",
          },
          {
            "name": "details",
            "title": "Details",
            "type": "`$ANY`",
            "short": "When details parameter is set to \"1\" more details in response will be displayed (message length and sms count).",
          },
          {
            "name": "encoding",
            "title": "Encoding",
            "type": "`$STRING`",
            "short": "This parameter describes the encoding of the message text.",
          },
          {
            "name": "expiration_date",
            "title": "Expiration Date",
            "type": "`$ANY`",
            "short": "Message expiration date (in UNIX timestamp or in ISO 8601) is a date after which message won't be delivered if it wasn't delivered yet.",
          },
          {
            "name": "fallback",
            "title": "Fallback",
            "type": "`$ARRAY`",
            "short": "Enable fallback in case sms sending fails",
          },
          {
            "name": "fast",
            "title": "Fast",
            "type": "`$INTEGER`",
            "short": "Setting this parameter to „1” will result in sending message with the highest priority which ensures the quickest possible time of delivery.",
          },
          {
            "name": "flash",
            "title": "Flash",
            "type": "`$INTEGER`",
            "short": "Sending a message in flash mode can be activated by setting this parameter to \"1\".",
          },
          {
            "name": "format",
            "title": "Format",
            "type": "`$STRING`",
            "short": "Parameter &format=json causes, that response is sending in JSON format.",
          },
          {
            "name": "from",
            "title": "From",
            "type": "`$STRING`",
            "short": "Name of the sender.",
          },
          {
            "name": "group",
            "title": "Group",
            "type": "`$STRING`",
            "short": "Name of the group from the contacts database to which message should be sent to.",
          },
          {
            "name": "idx",
            "title": "Idx",
            "type": "`$STRING`",
            "short": "Optional custom value sent with SMS and sent back in CALLBACK.",
          },
          {
            "name": "max_parts",
            "title": "Max Parts",
            "type": "`$INTEGER`",
            "short": "Defines maximum message parts allowed, maximum value allowed is 6.",
          },
          {
            "name": "message",
            "title": "Message",
            "type": "`$STRING`",
            "short": "The message text.",
          },
          {
            "name": "normalize",
            "title": "Normalize",
            "type": "`$INTEGER`",
            "short": "When parameter normalize is set to „1” special chars in message will be replaced with their equivalents (ê-e, ñ-n, ý-y ...).",
          },
          {
            "name": "notify_url",
            "title": "Notify Url",
            "type": "`$STRING`",
            "short": "Parameter allows to set CALLBACK URL for message from request.",
          },
          {
            "name": "test",
            "title": "Test",
            "type": "`$ANY`",
            "short": "When parameter test is set to \"1\" message won't be sent but response will be displayed, there is no charge for such test messages.",
          },
          {
            "name": "time_restriction",
            "title": "Time Restriction",
            "type": "`$STRING`",
            "short": "Sets the behavior when you try to ship in hours / dates that do not match the settings in your account.",
          },
          {
            "name": "to",
            "title": "To",
            "type": "`$STRING`",
            "short": "Recipients' mobile phone numbers (i.e.",
          },
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
                    "lit": "sms.do",
                  },
                ],
                "parts": [
                  "sms.do",
                ],
                "rename": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "args": {},
                "select": {},
                "body": {
                  "alternatives": [
                    {
                      "fields": [
                        {
                          "name": "allow_duplicates",
                        },
                        {
                          "name": "check_idx",
                        },
                        {
                          "name": "date",
                        },
                        {
                          "name": "date_validate",
                        },
                        {
                          "name": "details",
                        },
                        {
                          "name": "encoding",
                        },
                        {
                          "name": "expiration_date",
                        },
                        {
                          "list": True,
                          "name": "fallback",
                        },
                        {
                          "name": "fast",
                        },
                        {
                          "name": "flash",
                        },
                        {
                          "name": "format",
                        },
                        {
                          "name": "from",
                        },
                        {
                          "name": "group",
                        },
                        {
                          "name": "idx",
                        },
                        {
                          "name": "max_parts",
                        },
                        {
                          "name": "message",
                        },
                        {
                          "name": "normalize",
                        },
                        {
                          "name": "notify_url",
                        },
                        {
                          "name": "test",
                        },
                        {
                          "name": "time_restriction",
                        },
                        {
                          "name": "to",
                        },
                      ],
                      "kind": "form",
                      "media": "application/x-www-form-urlencoded",
                    },
                  ],
                  "kind": "json",
                  "media": "application/json",
                },
                "response": {
                  "alternatives": [
                    {
                      "kind": "raw",
                      "media": "text/plain",
                    },
                  ],
                  "kind": "json",
                  "media": "application/json",
                },
              },
            ],
          },
        },
        "relations": {
          "ancestors": [],
        },
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
                    "lit": "sms",
                  },
                  {
                    "lit": "sendernames",
                  },
                  {
                    "var": "sender",
                  },
                  {
                    "lit": "commands",
                  },
                  {
                    "lit": "make_default",
                  },
                ],
                "parts": [
                  "sms",
                  "sendernames",
                  "{sender}",
                  "commands",
                  "make_default",
                ],
                "rename": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "args": {
                  "params": [
                    {
                      "name": "sender",
                      "orig": "sender",
                      "type": "`$STRING`",
                      "kind": "param",
                      "reqd": True,
                    },
                  ],
                },
                "select": {
                  "exist": [
                    "sender",
                  ],
                },
              },
            ],
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
                    "lit": "sms",
                  },
                  {
                    "lit": "sendernames",
                  },
                  {
                    "var": "sender",
                  },
                ],
                "parts": [
                  "sms",
                  "sendernames",
                  "{sender}",
                ],
                "rename": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "args": {
                  "params": [
                    {
                      "name": "sender",
                      "orig": "sender",
                      "type": "`$STRING`",
                      "kind": "param",
                      "reqd": True,
                    },
                  ],
                },
                "select": {
                  "exist": [
                    "sender",
                  ],
                },
              },
            ],
          },
        },
        "relations": {
          "ancestors": [
            [
              "$.main.kit.entity.sendername",
            ],
          ],
        },
      },
      "smstemplate": {
        "fields": [
          {
            "name": "id",
            "title": "Id",
            "type": "`$STRING`",
          },
        ],
        "id": {
          "field": "id",
          "name": "id",
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
                    "lit": "sms",
                  },
                  {
                    "lit": "templates",
                  },
                  {
                    "var": "id",
                  },
                ],
                "parts": [
                  "sms",
                  "templates",
                  "{id}",
                ],
                "rename": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "args": {
                  "params": [
                    {
                      "name": "id",
                      "orig": "id",
                      "type": "`$STRING`",
                      "kind": "param",
                      "reqd": True,
                    },
                  ],
                },
                "select": {
                  "exist": [
                    "id",
                  ],
                },
              },
            ],
          },
        },
        "relations": {
          "ancestors": [],
        },
      },
      "subuser": {
        "fields": [
          {
            "name": "active",
            "title": "Active",
            "type": "`$BOOLEAN`",
          },
          {
            "name": "credentials",
            "title": "Credentials",
            "type": "`$OBJECT`",
            "req": True,
            "op": {
              "update": {
                "type": "`$OBJECT`",
              },
            },
          },
          {
            "name": "description",
            "title": "Description",
            "type": "`$STRING`",
          },
          {
            "name": "id",
            "title": "Id",
            "type": "`$STRING`",
            "short": "Object ID",
            "format": "oid",
          },
          {
            "name": "points",
            "title": "Points",
            "type": "`$OBJECT`",
          },
          {
            "name": "username",
            "title": "Username",
            "type": "`$STRING`",
          },
        ],
        "id": {
          "field": "id",
          "name": "id",
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
                    "lit": "subusers",
                  },
                ],
                "parts": [
                  "subusers",
                ],
                "rename": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "args": {},
                "select": {},
                "response": {
                  "kind": "json",
                  "media": "application/json",
                },
              },
            ],
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
                    "lit": "subusers",
                  },
                  {
                    "var": "id",
                  },
                  {
                    "lit": "shares",
                  },
                  {
                    "lit": "sendernames",
                  },
                ],
                "parts": [
                  "subusers",
                  "{id}",
                  "shares",
                  "sendernames",
                ],
                "rename": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body.senders`",
                },
                "args": {
                  "params": [
                    {
                      "name": "id",
                      "orig": "id",
                      "type": "`$STRING`",
                      "kind": "param",
                      "reqd": True,
                      "example": "0f0f0f0f0f0f0f0f0f0f0f0f",
                    },
                  ],
                },
                "select": {
                  "$action": "share_sendername",
                  "exist": [
                    "id",
                  ],
                },
                "response": {
                  "kind": "json",
                  "media": "application/json",
                },
              },
              {
                "kind": "http",
                "method": "GET",
                "orig": "/subusers/{id}/shares/templates",
                "segments": [
                  {
                    "lit": "subusers",
                  },
                  {
                    "var": "id",
                  },
                  {
                    "lit": "shares",
                  },
                  {
                    "lit": "templates",
                  },
                ],
                "parts": [
                  "subusers",
                  "{id}",
                  "shares",
                  "templates",
                ],
                "rename": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body.templates`",
                },
                "args": {
                  "params": [
                    {
                      "name": "id",
                      "orig": "id",
                      "type": "`$STRING`",
                      "kind": "param",
                      "reqd": True,
                      "example": "0f0f0f0f0f0f0f0f0f0f0f0f",
                    },
                  ],
                },
                "select": {
                  "$action": "share_template",
                  "exist": [
                    "id",
                  ],
                },
                "response": {
                  "kind": "json",
                  "media": "application/json",
                },
              },
              {
                "kind": "http",
                "method": "GET",
                "orig": "/subusers",
                "segments": [
                  {
                    "lit": "subusers",
                  },
                ],
                "parts": [
                  "subusers",
                ],
                "rename": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body.collection`",
                },
                "args": {
                  "query": [
                    {
                      "name": "q",
                      "orig": "q",
                      "type": "`$STRING`",
                      "kind": "query",
                    },
                  ],
                },
                "select": {},
                "response": {
                  "kind": "json",
                  "media": "application/json",
                },
              },
            ],
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
                    "lit": "subusers",
                  },
                  {
                    "var": "id",
                  },
                ],
                "parts": [
                  "subusers",
                  "{id}",
                ],
                "rename": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "args": {
                  "params": [
                    {
                      "name": "id",
                      "orig": "id",
                      "type": "`$STRING`",
                      "kind": "param",
                      "reqd": True,
                      "example": "0f0f0f0f0f0f0f0f0f0f0f0f",
                    },
                  ],
                },
                "select": {
                  "exist": [
                    "id",
                  ],
                },
                "response": {
                  "kind": "json",
                  "media": "application/json",
                },
              },
            ],
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
                    "lit": "subusers",
                  },
                  {
                    "var": "id",
                  },
                ],
                "parts": [
                  "subusers",
                  "{id}",
                ],
                "rename": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "args": {
                  "params": [
                    {
                      "name": "id",
                      "orig": "id",
                      "type": "`$STRING`",
                      "kind": "param",
                      "reqd": True,
                      "example": "0f0f0f0f0f0f0f0f0f0f0f0f",
                    },
                  ],
                },
                "select": {
                  "exist": [
                    "id",
                  ],
                },
              },
            ],
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
                    "lit": "subusers",
                  },
                  {
                    "var": "id",
                  },
                ],
                "parts": [
                  "subusers",
                  "{id}",
                ],
                "rename": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "args": {
                  "params": [
                    {
                      "name": "id",
                      "orig": "id",
                      "type": "`$STRING`",
                      "kind": "param",
                      "reqd": True,
                      "example": "0f0f0f0f0f0f0f0f0f0f0f0f",
                    },
                  ],
                },
                "select": {
                  "exist": [
                    "id",
                  ],
                },
                "response": {
                  "kind": "json",
                  "media": "application/json",
                },
              },
              {
                "kind": "http",
                "method": "PUT",
                "orig": "/subusers/{id}/shares/sendernames",
                "segments": [
                  {
                    "lit": "subusers",
                  },
                  {
                    "var": "id",
                  },
                  {
                    "lit": "shares",
                  },
                  {
                    "lit": "sendernames",
                  },
                ],
                "parts": [
                  "subusers",
                  "{id}",
                  "shares",
                  "sendernames",
                ],
                "rename": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "args": {
                  "params": [
                    {
                      "name": "id",
                      "orig": "id",
                      "type": "`$STRING`",
                      "kind": "param",
                      "reqd": True,
                      "example": "0f0f0f0f0f0f0f0f0f0f0f0f",
                    },
                  ],
                },
                "select": {
                  "$action": "share_sendername",
                  "exist": [
                    "id",
                  ],
                },
              },
              {
                "kind": "http",
                "method": "PUT",
                "orig": "/subusers/{id}/shares/templates",
                "segments": [
                  {
                    "lit": "subusers",
                  },
                  {
                    "var": "id",
                  },
                  {
                    "lit": "shares",
                  },
                  {
                    "lit": "templates",
                  },
                ],
                "parts": [
                  "subusers",
                  "{id}",
                  "shares",
                  "templates",
                ],
                "rename": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "args": {
                  "params": [
                    {
                      "name": "id",
                      "orig": "id",
                      "type": "`$STRING`",
                      "kind": "param",
                      "reqd": True,
                      "example": "0f0f0f0f0f0f0f0f0f0f0f0f",
                    },
                  ],
                },
                "select": {
                  "$action": "share_template",
                  "exist": [
                    "id",
                  ],
                },
              },
            ],
          },
        },
        "relations": {
          "ancestors": [],
        },
      },
      "template": {
        "fields": [
          {
            "name": "id",
            "title": "Id",
            "type": "`$STRING`",
          },
          {
            "name": "name",
            "title": "Name",
            "type": "`$STRING`",
          },
          {
            "name": "normalize",
            "title": "Normalize",
            "type": "`$BOOLEAN`",
          },
          {
            "name": "template",
            "title": "Template",
            "type": "`$STRING`",
          },
        ],
        "id": {
          "field": "id",
          "name": "id",
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
                    "lit": "sms",
                  },
                  {
                    "lit": "templates",
                  },
                ],
                "parts": [
                  "sms",
                  "templates",
                ],
                "rename": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "args": {},
                "select": {},
                "body": {
                  "fields": [
                    {
                      "name": "name",
                    },
                    {
                      "name": "normalize",
                    },
                    {
                      "name": "template",
                    },
                  ],
                  "kind": "form",
                  "media": "application/x-www-form-urlencoded",
                },
                "response": {
                  "kind": "json",
                  "media": "application/json",
                },
              },
            ],
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
                    "lit": "sms",
                  },
                  {
                    "lit": "templates",
                  },
                ],
                "parts": [
                  "sms",
                  "templates",
                ],
                "rename": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body.collection`",
                },
                "args": {},
                "select": {},
                "response": {
                  "kind": "json",
                  "media": "application/json",
                },
              },
            ],
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
                    "lit": "sms",
                  },
                  {
                    "lit": "templates",
                  },
                  {
                    "var": "id",
                  },
                ],
                "parts": [
                  "sms",
                  "templates",
                  "{id}",
                ],
                "rename": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "args": {
                  "params": [
                    {
                      "name": "id",
                      "orig": "id",
                      "type": "`$STRING`",
                      "kind": "param",
                      "reqd": True,
                    },
                  ],
                },
                "select": {
                  "exist": [
                    "id",
                  ],
                },
                "response": {
                  "kind": "json",
                  "media": "application/json",
                },
              },
            ],
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
                    "lit": "sms",
                  },
                  {
                    "lit": "templates",
                  },
                  {
                    "var": "id",
                  },
                ],
                "parts": [
                  "sms",
                  "templates",
                  "{id}",
                ],
                "rename": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "args": {
                  "params": [
                    {
                      "name": "id",
                      "orig": "id",
                      "type": "`$STRING`",
                      "kind": "param",
                      "reqd": True,
                    },
                  ],
                },
                "select": {
                  "exist": [
                    "id",
                  ],
                },
                "body": {
                  "fields": [
                    {
                      "name": "name",
                    },
                    {
                      "name": "normalize",
                    },
                    {
                      "name": "template",
                    },
                  ],
                  "kind": "form",
                  "media": "application/x-www-form-urlencoded",
                },
                "response": {
                  "kind": "json",
                  "media": "application/json",
                },
              },
            ],
          },
        },
        "relations": {
          "ancestors": [],
        },
      },
      "user_rcs_sender_collection": {
        "fields": [],
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
                    "lit": "rcs",
                  },
                  {
                    "lit": "senders",
                  },
                ],
                "parts": [
                  "rcs",
                  "senders",
                ],
                "rename": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body.collection`",
                },
                "args": {},
                "select": {},
                "response": {
                  "kind": "json",
                  "media": "application/json",
                },
              },
            ],
          },
        },
        "relations": {
          "ancestors": [],
        },
      },
    },
    }
