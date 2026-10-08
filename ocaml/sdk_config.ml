(* Generated API configuration (mirrors go core/config.go).
 *
 * make_config () — the embedded API model as a voxgig struct value.
 * make_feature name — the N-feature-safe factory the client uses. *)

open Voxgig_struct
open Sdk_types
open Sdk_helpers
open Sdk_features

let make_config () : value =
  (jo [
    ("main", (jo [
      ("name", (Str "Smsapi"));
      ("slug", (Str "smsapi"));
      ("version", (Str "0.0.1"));
      ("target", (Str "ocaml")) ]));
    ("feature", (jo [
      ("audit", (jo [
        ("options", (jo [
          ("active", (Bool false));
          ("actor", (Str "anonymous"));
          ("max", (Num (1000.))) ]));
        ("optspec", (jo [
          ("now", (Str "`$FUNCTION`"));
          ("sink", (Str "`$FUNCTION`")) ]));
        ("strict", (Bool false));
        ("transport", (Str "none")) ]));
      ("cache", (jo [
        ("options", (jo [
          ("active", (Bool false));
          ("max", (Num (256.)));
          ("methods", (ja [
            (Str "GET") ]));
          ("ttl", (Num (5000.))) ]));
        ("optspec", (jo [
          ("now", (Str "`$FUNCTION`")) ]));
        ("strict", (Bool false));
        ("transport", (Str "wrap")) ]));
      ("clienttrack", (jo [
        ("options", (jo [
          ("active", (Bool false));
          ("clientVersion", (Str "0.0.1")) ]));
        ("optspec", (jo [
          ("clientName", (Str "`$STRING`"));
          ("clientVersion", (Str "`$STRING`"));
          ("headers", (Str "`$MAP`"));
          ("idgen", (Str "`$FUNCTION`"));
          ("sessionId", (Str "`$STRING`")) ]));
        ("strict", (Bool false));
        ("transport", (Str "none")) ]));
      ("cost", (jo [
        ("options", (jo [
          ("active", (Bool false));
          ("budget", (Num (0.)));
          ("currency", (Str "USD"));
          ("header", (Str ""));
          ("onBudget", (Str "warn"));
          ("path", (Str ""));
          ("perUnit", (Num (0.)));
          ("rates", (empty_map ()));
          ("unit", (Num (0.))) ]));
        ("optspec", (jo [
          ("actor", (Str "`$STRING`"));
          ("sink", (Str "`$FUNCTION`")) ]));
        ("strict", (Bool false));
        ("transport", (Str "wrap")) ]));
      ("debug", (jo [
        ("options", (jo [
          ("active", (Bool false));
          ("max", (Num (100.)));
          ("redact", (ja [
            (Str "authorization");
            (Str "cookie");
            (Str "set-cookie");
            (Str "api-key");
            (Str "apikey");
            (Str "x-api-key");
            (Str "idempotency-key") ])) ]));
        ("optspec", (jo [
          ("now", (Str "`$FUNCTION`"));
          ("onEntry", (Str "`$FUNCTION`")) ]));
        ("strict", (Bool false));
        ("transport", (Str "none")) ]));
      ("idempotency", (jo [
        ("options", (jo [
          ("active", (Bool false));
          ("header", (Str "Idempotency-Key"));
          ("methods", (ja [
            (Str "POST");
            (Str "PUT");
            (Str "PATCH");
            (Str "DELETE") ]));
          ("ops", (ja [
            (Str "create");
            (Str "update");
            (Str "remove") ])) ]));
        ("optspec", (jo [
          ("keygen", (Str "`$FUNCTION`")) ]));
        ("strict", (Bool false));
        ("transport", (Str "none")) ]));
      ("log", (jo [
        ("options", (jo [
          ("active", (Bool true)) ]));
        ("optspec", (jo [
          ("level", (Str "`$STRING`"));
          ("logger", (Str "`$ANY`")) ]));
        ("strict", (Bool false));
        ("transport", (Str "none")) ]));
      ("metrics", (jo [
        ("options", (jo [
          ("active", (Bool false)) ]));
        ("optspec", (jo [
          ("now", (Str "`$FUNCTION`")) ]));
        ("strict", (Bool false));
        ("transport", (Str "none")) ]));
      ("netsim", (jo [
        ("options", (jo [
          ("active", (Bool false));
          ("errorTimes", (Num (0.)));
          ("failEvery", (Num (0.)));
          ("failRate", (Num (0.)));
          ("failStatus", (Num (503.)));
          ("failTimes", (Num (0.)));
          ("latency", (Num (0.)));
          ("offline", (Bool false));
          ("rateLimitTimes", (Num (0.)));
          ("retryAfter", (Num (0.)));
          ("seed", (Num (1.))) ]));
        ("optspec", (jo [
          ("latency", (ja [
            (Str "`$ONE`");
            (Str "`$NUMBER`");
            (Str "`$MAP`") ]));
          ("sleep", (Str "`$FUNCTION`")) ]));
        ("strict", (Bool false));
        ("transport", (Str "wrap")) ]));
      ("paging", (jo [
        ("options", (jo [
          ("active", (Bool false));
          ("afterVar", (Str "after"));
          ("cursorParam", (Str "cursor"));
          ("firstVar", (Str "first"));
          ("limitParam", (Str "limit"));
          ("pageParam", (Str "page"));
          ("startPage", (Num (1.))) ]));
        ("optspec", (jo [
          ("limit", (Str "`$NUMBER`"));
          ("ops", (Str "`$LIST`")) ]));
        ("strict", (Bool false));
        ("transport", (Str "none")) ]));
      ("proxy", (jo [
        ("options", (jo [
          ("active", (Bool false));
          ("fromEnv", (Bool false));
          ("noProxy", (empty_list ()));
          ("url", (Str "")) ]));
        ("optspec", (jo [
          ("agent", (Str "`$FUNCTION`")) ]));
        ("strict", (Bool false));
        ("transport", (Str "wrap")) ]));
      ("ratelimit", (jo [
        ("options", (jo [
          ("active", (Bool false));
          ("burst", (Num (5.)));
          ("rate", (Num (5.))) ]));
        ("optspec", (jo [
          ("now", (Str "`$FUNCTION`"));
          ("sleep", (Str "`$FUNCTION`")) ]));
        ("strict", (Bool false));
        ("transport", (Str "wrap")) ]));
      ("rbac", (jo [
        ("options", (jo [
          ("active", (Bool false));
          ("deny", (Bool false));
          ("permissions", (empty_list ()));
          ("rules", (empty_map ())) ]));
        ("optspec", (empty_map ()));
        ("strict", (Bool false));
        ("transport", (Str "none")) ]));
      ("retry", (jo [
        ("options", (jo [
          ("active", (Bool false));
          ("factor", (Num (2.)));
          ("maxDelay", (Num (2000.)));
          ("minDelay", (Num (50.)));
          ("retries", (Num (2.)));
          ("statuses", (ja [
            (Num (408.));
            (Num (425.));
            (Num (429.));
            (Num (500.));
            (Num (502.));
            (Num (503.));
            (Num (504.)) ])) ]));
        ("optspec", (jo [
          ("jitter", (Str "`$BOOLEAN`"));
          ("sleep", (Str "`$FUNCTION`")) ]));
        ("strict", (Bool false));
        ("transport", (Str "wrap")) ]));
      ("secrets", (jo [
        ("options", (jo [
          ("active", (Bool false));
          ("cache", (Bool true));
          ("exchange", (jo [
            ("active", (Bool false));
            ("method", (Str "POST"));
            ("path", (Str "auth/token"));
            ("refresh", (Str ""));
            ("request", (Str "refresh_token"));
            ("response", (Str "access_token"));
            ("retries", (Num (1.)));
            ("statuses", (ja [
              (Num (401.)) ])) ]));
          ("name", (Str "apikey"));
          ("providers", (empty_list ())) ]));
        ("optspec", (empty_map ()));
        ("strict", (Bool false));
        ("transport", (Str "wrap")) ]));
      ("streaming", (jo [
        ("options", (jo [
          ("active", (Bool false));
          ("chunkDelay", (Num (0.)));
          ("chunkSize", (Num (0.))) ]));
        ("optspec", (jo [
          ("ops", (Str "`$LIST`"));
          ("sleep", (Str "`$FUNCTION`")) ]));
        ("strict", (Bool false));
        ("transport", (Str "none")) ]));
      ("telemetry", (jo [
        ("options", (jo [
          ("active", (Bool false)) ]));
        ("optspec", (jo [
          ("exporter", (Str "`$FUNCTION`"));
          ("headers", (Str "`$MAP`"));
          ("idgen", (Str "`$FUNCTION`"));
          ("now", (Str "`$FUNCTION`")) ]));
        ("strict", (Bool false));
        ("transport", (Str "none")) ]));
      ("test", (jo [
        ("options", (jo [
          ("active", (Bool false)) ]));
        ("optspec", (jo [
          ("entity", (Str "`$MAP`"));
          ("net", (Str "`$MAP`")) ]));
        ("strict", (Bool false));
        ("transport", (Str "base")) ]));
      ("timeout", (jo [
        ("options", (jo [
          ("active", (Bool false));
          ("ms", (Num (30000.))) ]));
        ("optspec", (jo [
          ("clearTimer", (Str "`$FUNCTION`"));
          ("now", (Str "`$FUNCTION`"));
          ("setTimer", (Str "`$FUNCTION`")) ]));
        ("strict", (Bool false));
        ("transport", (Str "wrap")) ]));
      ("validate", (jo [
        ("options", (jo [
          ("active", (Bool false));
          ("mode", (Str "throw"));
          ("request", (Bool true));
          ("response", (Bool false));
          ("strict", (Bool false)) ]));
        ("optspec", (jo [
          ("mode", (ja [
            (Str "`$ONE`");
            (ja [
              (Str "`$EXACT`");
              (Str "throw") ]);
            (ja [
              (Str "`$EXACT`");
              (Str "report") ]) ]));
          ("onInvalid", (Str "`$FUNCTION`")) ]));
        ("strict", (Bool false));
        ("transport", (Str "none")) ])) ]));
    ("options", (jo [
      ("base", (Str "https://api.smsapi.com"));
      ("auth", (jo [
        ("prefix", (Str "Bearer")) ]));
      ("headers", (jo [
        ("content-type", (Str "application/json")) ]));
      ("entity", (jo [
        ("available", (empty_map ()));
        ("blacklist", (empty_map ()));
        ("callback", (empty_map ()));
        ("contact", (empty_map ()));
        ("contacts_field", (empty_map ()));
        ("contacts_field_option", (empty_map ()));
        ("contactsgroup", (empty_map ()));
        ("contactstrash", (empty_map ()));
        ("field_available", (empty_map ()));
        ("group", (empty_map ()));
        ("mfa_code", (empty_map ()));
        ("opt_out", (empty_map ()));
        ("opt_out_setting", (empty_map ()));
        ("permission", (empty_map ()));
        ("ping", (empty_map ()));
        ("profile", (empty_map ()));
        ("rcs", (empty_map ()));
        ("sendername", (empty_map ()));
        ("sendername_statement", (empty_map ()));
        ("sent_rcs_message", (empty_map ()));
        ("shipment_country_volume", (empty_map ()));
        ("short_url", (empty_map ()));
        ("smsdo", (empty_map ()));
        ("smssendername", (empty_map ()));
        ("smstemplate", (empty_map ()));
        ("subuser", (empty_map ()));
        ("template", (empty_map ()));
        ("user_rcs_sender_collection", (empty_map ())) ])) ]));
    ("entity", (jo [
      ("available", (jo [
        ("fields", (ja [
          (jo [
            ("name", (Str "name"));
            ("title", (Str "Name"));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "normalize"));
            ("title", (Str "Normalize"));
            ("type", (Str "`$BOOLEAN`")) ]);
          (jo [
            ("name", (Str "template"));
            ("title", (Str "Template"));
            ("type", (Str "`$STRING`")) ]) ]));
        ("name", (Str "available"));
        ("op", (jo [
          ("list", (jo [
            ("input", (Str "data"));
            ("name", (Str "list"));
            ("points", (ja [
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "GET"));
                ("orig", (Str "/sms/templates/available"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "sms")) ]);
                  (jo [
                    ("lit", (Str "templates")) ]);
                  (jo [
                    ("lit", (Str "available")) ]) ]));
                ("parts", (ja [
                  (Str "sms");
                  (Str "templates");
                  (Str "available") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body.collection`")) ]));
                ("args", (empty_map ()));
                ("select", (empty_map ()));
                ("response", (jo [
                  ("kind", (Str "json"));
                  ("media", (Str "application/json")) ])) ]) ])) ])) ]));
        ("relations", (jo [
          ("ancestors", (empty_list ())) ])) ]));
      ("blacklist", (jo [
        ("fields", (ja [
          (jo [
            ("name", (Str "id"));
            ("title", (Str "Id"));
            ("type", (Str "`$STRING`")) ]) ]));
        ("id", (jo [
          ("field", (Str "id"));
          ("name", (Str "id")) ]));
        ("name", (Str "blacklist"));
        ("op", (jo [
          ("create", (jo [
            ("input", (Str "data"));
            ("name", (Str "create"));
            ("points", (ja [
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "POST"));
                ("orig", (Str "/blacklist/phone_numbers"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "blacklist")) ]);
                  (jo [
                    ("lit", (Str "phone_numbers")) ]) ]));
                ("parts", (ja [
                  (Str "blacklist");
                  (Str "phone_numbers") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (empty_map ()));
                ("select", (jo [
                  ("$action", (Str "phone_number")) ]));
                ("body", (jo [
                  ("alternatives", (ja [
                    (jo [
                      ("fields", (ja [
                        (jo [
                          ("name", (Str "expire_at")) ]);
                        (jo [
                          ("name", (Str "phone_number")) ]) ]));
                      ("kind", (Str "form"));
                      ("media", (Str "application/x-www-form-urlencoded")) ]) ]));
                  ("kind", (Str "json"));
                  ("media", (Str "application/json")) ]));
                ("response", (jo [
                  ("kind", (Str "json"));
                  ("media", (Str "application/json")) ])) ]);
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "POST"));
                ("orig", (Str "/blacklist/phone_numbers/imports"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "blacklist")) ]);
                  (jo [
                    ("lit", (Str "phone_numbers")) ]);
                  (jo [
                    ("lit", (Str "imports")) ]) ]));
                ("parts", (ja [
                  (Str "blacklist");
                  (Str "phone_numbers");
                  (Str "imports") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (empty_map ()));
                ("select", (empty_map ()));
                ("body", (jo [
                  ("alternatives", (ja [
                    (jo [
                      ("kind", (Str "raw"));
                      ("media", (Str "text/csv")) ]) ]));
                  ("fields", (ja [
                    (jo [
                      ("name", (Str "import")) ]) ]));
                  ("kind", (Str "multipart"));
                  ("media", (Str "multipart/form-data")) ])) ]) ])) ]));
          ("load", (jo [
            ("input", (Str "data"));
            ("name", (Str "load"));
            ("points", (ja [
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "GET"));
                ("orig", (Str "/blacklist/phone_numbers"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "blacklist")) ]);
                  (jo [
                    ("lit", (Str "phone_numbers")) ]) ]));
                ("parts", (ja [
                  (Str "blacklist");
                  (Str "phone_numbers") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (jo [
                  ("header", (ja [
                    (jo [
                      ("name", (Str "accept"));
                      ("orig", (Str "Accept"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "header"));
                      ("example", (Str "application/json")) ]);
                    (jo [
                      ("name", (Str "x_async"));
                      ("orig", (Str "x-async"));
                      ("type", (Str "`$BOOLEAN`"));
                      ("kind", (Str "header"));
                      ("example", (Bool false)) ]) ]));
                  ("query", (ja [
                    (jo [
                      ("name", (Str "limit"));
                      ("orig", (Str "limit"));
                      ("type", (Str "`$INTEGER`"));
                      ("kind", (Str "query"));
                      ("example", (Num (5.))) ]);
                    (jo [
                      ("name", (Str "offset"));
                      ("orig", (Str "offset"));
                      ("type", (Str "`$INTEGER`"));
                      ("kind", (Str "query"));
                      ("example", (Num (0.))) ]);
                    (jo [
                      ("name", (Str "q"));
                      ("orig", (Str "q"));
                      ("type", (Str "`$INTEGER`"));
                      ("kind", (Str "query"));
                      ("example", (Num (0.))) ]) ])) ]));
                ("select", (jo [
                  ("$action", (Str "phone_number")) ]));
                ("response", (jo [
                  ("alternatives", (ja [
                    (jo [
                      ("kind", (Str "raw"));
                      ("media", (Str "text/csv")) ]) ]));
                  ("kind", (Str "json"));
                  ("media", (Str "application/json")) ])) ]) ])) ]));
          ("remove", (jo [
            ("input", (Str "data"));
            ("name", (Str "remove"));
            ("points", (ja [
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "DELETE"));
                ("orig", (Str "/blacklist/phone_numbers/{id}"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "blacklist")) ]);
                  (jo [
                    ("lit", (Str "phone_numbers")) ]);
                  (jo [
                    ("var", (Str "id")) ]) ]));
                ("parts", (ja [
                  (Str "blacklist");
                  (Str "phone_numbers");
                  (Str "{id}") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (jo [
                  ("params", (ja [
                    (jo [
                      ("name", (Str "id"));
                      ("orig", (Str "id"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "param"));
                      ("reqd", (Bool true));
                      ("example", (Str "0f0f0f0f0f0f0f0f0f0f0f0f")) ]) ])) ]));
                ("select", (jo [
                  ("exist", (ja [
                    (Str "id") ])) ])) ]);
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "DELETE"));
                ("orig", (Str "/blacklist/phone_numbers"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "blacklist")) ]);
                  (jo [
                    ("lit", (Str "phone_numbers")) ]) ]));
                ("parts", (ja [
                  (Str "blacklist");
                  (Str "phone_numbers") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (jo [
                  ("query", (ja [
                    (jo [
                      ("name", (Str "phone_number"));
                      ("orig", (Str "phone_number"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "query")) ]) ])) ]));
                ("select", (jo [
                  ("$action", (Str "phone_number")) ])) ]) ])) ])) ]));
        ("relations", (jo [
          ("ancestors", (empty_list ())) ])) ]));
      ("callback", (jo [
        ("fields", (ja [
          (jo [
            ("name", (Str "active"));
            ("title", (Str "Active"));
            ("type", (Str "`$BOOLEAN`")) ]);
          (jo [
            ("name", (Str "api_version"));
            ("title", (Str "Api Version"));
            ("type", (Str "`$INTEGER`"));
            ("short", (Str "Version of the callback output format.")) ]);
          (jo [
            ("name", (Str "id"));
            ("title", (Str "Id"));
            ("type", (Str "`$STRING`"));
            ("short", (Str "Object ID"));
            ("format", (Str "oid")) ]);
          (jo [
            ("name", (Str "invalid"));
            ("title", (Str "Invalid"));
            ("type", (Str "`$BOOLEAN`")) ]);
          (jo [
            ("name", (Str "receiver"));
            ("title", (Str "Receiver"));
            ("type", (Str "`$OBJECT`")) ]);
          (jo [
            ("name", (Str "receiver_type"));
            ("title", (Str "Receiver Type"));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "type"));
            ("title", (Str "Type"));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "url"));
            ("title", (Str "Url"));
            ("type", (Str "`$STRING`"));
            ("op", (jo [
              ("update", (jo [
                ("req", (Bool true));
                ("type", (Str "`$STRING`")) ])) ]));
            ("short", (Str "WHATWG URL compliant"));
            ("format", (Str "url")) ]) ]));
        ("id", (jo [
          ("field", (Str "id"));
          ("name", (Str "id")) ]));
        ("name", (Str "callback"));
        ("op", (jo [
          ("create", (jo [
            ("input", (Str "data"));
            ("name", (Str "create"));
            ("points", (ja [
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "POST"));
                ("orig", (Str "/callbacks"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "callbacks")) ]) ]));
                ("parts", (ja [
                  (Str "callbacks") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (empty_map ()));
                ("select", (empty_map ()));
                ("response", (jo [
                  ("kind", (Str "json"));
                  ("media", (Str "application/json")) ])) ]) ])) ]));
          ("list", (jo [
            ("input", (Str "data"));
            ("name", (Str "list"));
            ("points", (ja [
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "GET"));
                ("orig", (Str "/callbacks"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "callbacks")) ]) ]));
                ("parts", (ja [
                  (Str "callbacks") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body.collection`")) ]));
                ("args", (empty_map ()));
                ("select", (empty_map ()));
                ("response", (jo [
                  ("kind", (Str "json"));
                  ("media", (Str "application/json")) ])) ]) ])) ]));
          ("load", (jo [
            ("input", (Str "data"));
            ("name", (Str "load"));
            ("points", (ja [
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "GET"));
                ("orig", (Str "/callbacks/{id}"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "callbacks")) ]);
                  (jo [
                    ("var", (Str "id")) ]) ]));
                ("parts", (ja [
                  (Str "callbacks");
                  (Str "{id}") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (jo [
                  ("params", (ja [
                    (jo [
                      ("name", (Str "id"));
                      ("orig", (Str "id"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "param"));
                      ("reqd", (Bool true));
                      ("example", (Str "0f0f0f0f0f0f0f0f0f0f0f0f")) ]) ])) ]));
                ("select", (jo [
                  ("exist", (ja [
                    (Str "id") ])) ]));
                ("response", (jo [
                  ("kind", (Str "json"));
                  ("media", (Str "application/json")) ])) ]);
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "GET"));
                ("orig", (Str "/callbacks/{id}/commands/test"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "callbacks")) ]);
                  (jo [
                    ("var", (Str "id")) ]);
                  (jo [
                    ("lit", (Str "commands")) ]);
                  (jo [
                    ("lit", (Str "test")) ]) ]));
                ("parts", (ja [
                  (Str "callbacks");
                  (Str "{id}");
                  (Str "commands");
                  (Str "test") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (jo [
                  ("params", (ja [
                    (jo [
                      ("name", (Str "id"));
                      ("orig", (Str "id"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "param"));
                      ("reqd", (Bool true));
                      ("example", (Str "0f0f0f0f0f0f0f0f0f0f0f0f")) ]) ])) ]));
                ("select", (jo [
                  ("$action", (Str "command_test"));
                  ("exist", (ja [
                    (Str "id") ])) ]));
                ("response", (jo [
                  ("kind", (Str "json"));
                  ("media", (Str "application/json")) ])) ]) ])) ]));
          ("remove", (jo [
            ("input", (Str "data"));
            ("name", (Str "remove"));
            ("points", (ja [
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "DELETE"));
                ("orig", (Str "/callbacks/{id}"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "callbacks")) ]);
                  (jo [
                    ("var", (Str "id")) ]) ]));
                ("parts", (ja [
                  (Str "callbacks");
                  (Str "{id}") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (jo [
                  ("params", (ja [
                    (jo [
                      ("name", (Str "id"));
                      ("orig", (Str "id"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "param"));
                      ("reqd", (Bool true));
                      ("example", (Str "0f0f0f0f0f0f0f0f0f0f0f0f")) ]) ])) ]));
                ("select", (jo [
                  ("exist", (ja [
                    (Str "id") ])) ])) ]) ])) ]));
          ("update", (jo [
            ("input", (Str "data"));
            ("name", (Str "update"));
            ("points", (ja [
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "PUT"));
                ("orig", (Str "/callbacks/{id}"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "callbacks")) ]);
                  (jo [
                    ("var", (Str "id")) ]) ]));
                ("parts", (ja [
                  (Str "callbacks");
                  (Str "{id}") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (jo [
                  ("params", (ja [
                    (jo [
                      ("name", (Str "id"));
                      ("orig", (Str "id"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "param"));
                      ("reqd", (Bool true));
                      ("example", (Str "0f0f0f0f0f0f0f0f0f0f0f0f")) ]) ])) ]));
                ("select", (jo [
                  ("exist", (ja [
                    (Str "id") ])) ]));
                ("response", (jo [
                  ("kind", (Str "json"));
                  ("media", (Str "application/json")) ])) ]);
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "PUT"));
                ("orig", (Str "/callbacks/{id}/commands/activate"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "callbacks")) ]);
                  (jo [
                    ("var", (Str "id")) ]);
                  (jo [
                    ("lit", (Str "commands")) ]);
                  (jo [
                    ("lit", (Str "activate")) ]) ]));
                ("parts", (ja [
                  (Str "callbacks");
                  (Str "{id}");
                  (Str "commands");
                  (Str "activate") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (jo [
                  ("params", (ja [
                    (jo [
                      ("name", (Str "id"));
                      ("orig", (Str "id"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "param"));
                      ("reqd", (Bool true));
                      ("example", (Str "0f0f0f0f0f0f0f0f0f0f0f0f")) ]) ])) ]));
                ("select", (jo [
                  ("$action", (Str "command_activate"));
                  ("exist", (ja [
                    (Str "id") ])) ])) ]);
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "PUT"));
                ("orig", (Str "/callbacks/{id}/commands/deactivate"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "callbacks")) ]);
                  (jo [
                    ("var", (Str "id")) ]);
                  (jo [
                    ("lit", (Str "commands")) ]);
                  (jo [
                    ("lit", (Str "deactivate")) ]) ]));
                ("parts", (ja [
                  (Str "callbacks");
                  (Str "{id}");
                  (Str "commands");
                  (Str "deactivate") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (jo [
                  ("params", (ja [
                    (jo [
                      ("name", (Str "id"));
                      ("orig", (Str "id"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "param"));
                      ("reqd", (Bool true));
                      ("example", (Str "0f0f0f0f0f0f0f0f0f0f0f0f")) ]) ])) ]));
                ("select", (jo [
                  ("$action", (Str "command_deactivate"));
                  ("exist", (ja [
                    (Str "id") ])) ])) ]) ])) ])) ]));
        ("relations", (jo [
          ("ancestors", (empty_list ())) ])) ]));
      ("contact", (jo [
        ("fields", (ja [
          (jo [
            ("name", (Str "birthday_date"));
            ("title", (Str "Birthday Date"));
            ("type", (Str "`$STRING`"));
            ("format", (Str "date")) ]);
          (jo [
            ("name", (Str "city"));
            ("title", (Str "City"));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "collection"));
            ("title", (Str "Collection"));
            ("type", (Str "`$ARRAY`"));
            ("req", (Bool true)) ]);
          (jo [
            ("name", (Str "contact_expire_after"));
            ("title", (Str "Contact Expire After"));
            ("type", (Str "`$INTEGER`"));
            ("req", (Bool true));
            ("short", (Str "Contact expire after days")) ]);
          (jo [
            ("name", (Str "contacts_count"));
            ("title", (Str "Contacts Count"));
            ("type", (Str "`$INTEGER`"));
            ("req", (Bool true)) ]);
          (jo [
            ("name", (Str "country"));
            ("title", (Str "Country"));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "created_by"));
            ("title", (Str "Created By"));
            ("type", (Str "`$STRING`"));
            ("req", (Bool true)) ]);
          (jo [
            ("name", (Str "date_created"));
            ("title", (Str "Date Created"));
            ("type", (Str "`$STRING`"));
            ("req", (Bool true));
            ("format", (Str "date-time")) ]);
          (jo [
            ("name", (Str "date_updated"));
            ("title", (Str "Date Updated"));
            ("type", (Str "`$STRING`"));
            ("req", (Bool true));
            ("format", (Str "date-time")) ]);
          (jo [
            ("name", (Str "description"));
            ("title", (Str "Description"));
            ("type", (Str "`$STRING`"));
            ("op", (jo [
              ("load", (jo [
                ("req", (Bool true));
                ("type", (Str "`$STRING`")) ])) ])) ]);
          (jo [
            ("name", (Str "email"));
            ("title", (Str "Email"));
            ("type", (Str "`$STRING`"));
            ("format", (Str "email")) ]);
          (jo [
            ("name", (Str "first_name"));
            ("title", (Str "First Name"));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "gender"));
            ("title", (Str "Gender"));
            ("type", (Str "`$STRING`"));
            ("req", (Bool true)) ]);
          (jo [
            ("name", (Str "groups"));
            ("title", (Str "Groups"));
            ("type", (Str "`$ARRAY`"));
            ("req", (Bool true)) ]);
          (jo [
            ("name", (Str "id"));
            ("title", (Str "Id"));
            ("type", (Str "`$STRING`"));
            ("req", (Bool true));
            ("short", (Str "Object ID"));
            ("format", (Str "oid")) ]);
          (jo [
            ("name", (Str "idx"));
            ("title", (Str "Idx"));
            ("type", (Str "`$STRING`"));
            ("short", (Str "User provided resource id")) ]);
          (jo [
            ("name", (Str "last_name"));
            ("title", (Str "Last Name"));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "name"));
            ("title", (Str "Name"));
            ("type", (Str "`$STRING`"));
            ("req", (Bool true));
            ("short", (Str "Group name")) ]);
          (jo [
            ("name", (Str "permissions"));
            ("title", (Str "Permissions"));
            ("type", (Str "`$ARRAY`")) ]);
          (jo [
            ("name", (Str "phone_number"));
            ("title", (Str "Phone Number"));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "size"));
            ("title", (Str "Size"));
            ("type", (Str "`$INTEGER`"));
            ("req", (Bool true)) ]);
          (jo [
            ("name", (Str "source"));
            ("title", (Str "Source"));
            ("type", (Str "`$STRING`")) ]) ]));
        ("id", (jo [
          ("field", (Str "id"));
          ("name", (Str "id")) ]));
        ("name", (Str "contact"));
        ("op", (jo [
          ("create", (jo [
            ("input", (Str "data"));
            ("name", (Str "create"));
            ("points", (ja [
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "POST"));
                ("orig", (Str "/contacts/{contactId}/groups"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "contacts")) ]);
                  (jo [
                    ("var", (Str "id")) ]);
                  (jo [
                    ("lit", (Str "groups")) ]) ]));
                ("parts", (ja [
                  (Str "contacts");
                  (Str "{id}");
                  (Str "groups") ]));
                ("rename", (jo [
                  ("param", (jo [
                    ("contactId", (Str "id")) ])) ]));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (jo [
                  ("params", (ja [
                    (jo [
                      ("name", (Str "id"));
                      ("orig", (Str "contactId"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "param"));
                      ("reqd", (Bool true));
                      ("example", (Str "0f0f0f0f0f0f0f0f0f0f0f0f")) ]) ])) ]));
                ("select", (jo [
                  ("$action", (Str "group"));
                  ("exist", (ja [
                    (Str "id") ])) ]));
                ("body", (jo [
                  ("kind", (Str "form"));
                  ("media", (Str "application/x-www-form-urlencoded")) ]));
                ("response", (jo [
                  ("kind", (Str "json"));
                  ("media", (Str "application/json")) ])) ]);
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "POST"));
                ("orig", (Str "/contacts"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "contacts")) ]) ]));
                ("parts", (ja [
                  (Str "contacts") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (empty_map ()));
                ("select", (empty_map ()));
                ("body", (jo [
                  ("fields", (ja [
                    (jo [
                      ("name", (Str "birthday_date")) ]);
                    (jo [
                      ("name", (Str "browser")) ]);
                    (jo [
                      ("name", (Str "city")) ]);
                    (jo [
                      ("name", (Str "country")) ]);
                    (jo [
                      ("name", (Str "description")) ]);
                    (jo [
                      ("name", (Str "device")) ]);
                    (jo [
                      ("name", (Str "email")) ]);
                    (jo [
                      ("name", (Str "first_name")) ]);
                    (jo [
                      ("name", (Str "gender")) ]);
                    (jo [
                      ("name", (Str "idx")) ]);
                    (jo [
                      ("name", (Str "last_name")) ]);
                    (jo [
                      ("name", (Str "operating_system")) ]);
                    (jo [
                      ("name", (Str "phone_number")) ]);
                    (jo [
                      ("name", (Str "source")) ]);
                    (jo [
                      ("name", (Str "undelivered_messages")) ]) ]));
                  ("kind", (Str "form"));
                  ("media", (Str "application/x-www-form-urlencoded")) ]));
                ("response", (jo [
                  ("kind", (Str "json"));
                  ("media", (Str "application/json")) ])) ]) ])) ]));
          ("list", (jo [
            ("input", (Str "data"));
            ("name", (Str "list"));
            ("points", (ja [
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "GET"));
                ("orig", (Str "/contacts/{contactId}/groups"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "contacts")) ]);
                  (jo [
                    ("var", (Str "id")) ]);
                  (jo [
                    ("lit", (Str "groups")) ]) ]));
                ("parts", (ja [
                  (Str "contacts");
                  (Str "{id}");
                  (Str "groups") ]));
                ("rename", (jo [
                  ("param", (jo [
                    ("contactId", (Str "id")) ])) ]));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body.collection`")) ]));
                ("args", (jo [
                  ("params", (ja [
                    (jo [
                      ("name", (Str "id"));
                      ("orig", (Str "contactId"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "param"));
                      ("reqd", (Bool true));
                      ("example", (Str "0f0f0f0f0f0f0f0f0f0f0f0f")) ]) ])) ]));
                ("select", (jo [
                  ("$action", (Str "group"));
                  ("exist", (ja [
                    (Str "id") ])) ]));
                ("response", (jo [
                  ("kind", (Str "json"));
                  ("media", (Str "application/json")) ])) ]);
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "GET"));
                ("orig", (Str "/contacts"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "contacts")) ]) ]));
                ("parts", (ja [
                  (Str "contacts") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body.collection`")) ]));
                ("args", (jo [
                  ("query", (ja [
                    (jo [
                      ("name", (Str "birthday_date"));
                      ("orig", (Str "birthday_date"));
                      ("type", (Str "`$ARRAY`"));
                      ("kind", (Str "query"));
                      ("example", (Str "2022-06-24"));
                      ("field", (Bool true)) ]);
                    (jo [
                      ("name", (Str "email"));
                      ("orig", (Str "email"));
                      ("type", (Str "`$ARRAY`"));
                      ("kind", (Str "query"));
                      ("field", (Bool true)) ]);
                    (jo [
                      ("name", (Str "first_name"));
                      ("orig", (Str "first_name"));
                      ("type", (Str "`$ARRAY`"));
                      ("kind", (Str "query"));
                      ("field", (Bool true)) ]);
                    (jo [
                      ("name", (Str "gender"));
                      ("orig", (Str "gender"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "query"));
                      ("field", (Bool true)) ]);
                    (jo [
                      ("name", (Str "group_id"));
                      ("orig", (Str "group_id"));
                      ("type", (Str "`$ARRAY`"));
                      ("kind", (Str "query")) ]);
                    (jo [
                      ("name", (Str "last_name"));
                      ("orig", (Str "last_name"));
                      ("type", (Str "`$ARRAY`"));
                      ("kind", (Str "query"));
                      ("field", (Bool true)) ]);
                    (jo [
                      ("name", (Str "limit"));
                      ("orig", (Str "limit"));
                      ("type", (Str "`$INTEGER`"));
                      ("kind", (Str "query"));
                      ("example", (Num (5.))) ]);
                    (jo [
                      ("name", (Str "offset"));
                      ("orig", (Str "offset"));
                      ("type", (Str "`$INTEGER`"));
                      ("kind", (Str "query"));
                      ("example", (Num (0.))) ]);
                    (jo [
                      ("name", (Str "order_by"));
                      ("orig", (Str "order_by"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "query")) ]);
                    (jo [
                      ("name", (Str "phone_number"));
                      ("orig", (Str "phone_number"));
                      ("type", (Str "`$ARRAY`"));
                      ("kind", (Str "query"));
                      ("field", (Bool true)) ]);
                    (jo [
                      ("name", (Str "q"));
                      ("orig", (Str "q"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "query")) ]) ])) ]));
                ("select", (empty_map ()));
                ("response", (jo [
                  ("kind", (Str "json"));
                  ("media", (Str "application/json")) ])) ]) ])) ]));
          ("load", (jo [
            ("input", (Str "data"));
            ("name", (Str "load"));
            ("points", (ja [
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "GET"));
                ("orig", (Str "/contacts/groups/{groupId}/members/{contactId}"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "contacts")) ]);
                  (jo [
                    ("lit", (Str "groups")) ]);
                  (jo [
                    ("var", (Str "group_id")) ]);
                  (jo [
                    ("lit", (Str "members")) ]);
                  (jo [
                    ("var", (Str "contact_id")) ]) ]));
                ("parts", (ja [
                  (Str "contacts");
                  (Str "groups");
                  (Str "{group_id}");
                  (Str "members");
                  (Str "{contact_id}") ]));
                ("rename", (jo [
                  ("param", (jo [
                    ("contactId", (Str "contact_id"));
                    ("groupId", (Str "group_id")) ])) ]));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (jo [
                  ("params", (ja [
                    (jo [
                      ("name", (Str "contact_id"));
                      ("orig", (Str "contactId"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "param"));
                      ("reqd", (Bool true));
                      ("example", (Str "0f0f0f0f0f0f0f0f0f0f0f0f")) ]);
                    (jo [
                      ("name", (Str "group_id"));
                      ("orig", (Str "groupId"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "param"));
                      ("reqd", (Bool true));
                      ("example", (Str "0f0f0f0f0f0f0f0f0f0f0f0f")) ]) ])) ]));
                ("select", (jo [
                  ("exist", (ja [
                    (Str "contact_id");
                    (Str "group_id") ])) ]));
                ("response", (jo [
                  ("kind", (Str "json"));
                  ("media", (Str "application/json")) ])) ]);
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "GET"));
                ("orig", (Str "/contacts/{contactId}/groups/{groupId}"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "contacts")) ]);
                  (jo [
                    ("var", (Str "id")) ]);
                  (jo [
                    ("lit", (Str "groups")) ]);
                  (jo [
                    ("var", (Str "group_id")) ]) ]));
                ("parts", (ja [
                  (Str "contacts");
                  (Str "{id}");
                  (Str "groups");
                  (Str "{group_id}") ]));
                ("rename", (jo [
                  ("param", (jo [
                    ("contactId", (Str "id"));
                    ("groupId", (Str "group_id")) ])) ]));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (jo [
                  ("params", (ja [
                    (jo [
                      ("name", (Str "group_id"));
                      ("orig", (Str "groupId"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "param"));
                      ("reqd", (Bool true));
                      ("example", (Str "0f0f0f0f0f0f0f0f0f0f0f0f")) ]);
                    (jo [
                      ("name", (Str "id"));
                      ("orig", (Str "contactId"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "param"));
                      ("reqd", (Bool true));
                      ("example", (Str "0f0f0f0f0f0f0f0f0f0f0f0f")) ]) ])) ]));
                ("select", (jo [
                  ("exist", (ja [
                    (Str "group_id");
                    (Str "id") ])) ]));
                ("response", (jo [
                  ("kind", (Str "json"));
                  ("media", (Str "application/json")) ])) ]);
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "GET"));
                ("orig", (Str "/contacts/{contactId}"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "contacts")) ]);
                  (jo [
                    ("var", (Str "id")) ]) ]));
                ("parts", (ja [
                  (Str "contacts");
                  (Str "{id}") ]));
                ("rename", (jo [
                  ("param", (jo [
                    ("contactId", (Str "id")) ])) ]));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (jo [
                  ("params", (ja [
                    (jo [
                      ("name", (Str "id"));
                      ("orig", (Str "contactId"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "param"));
                      ("reqd", (Bool true));
                      ("example", (Str "0f0f0f0f0f0f0f0f0f0f0f0f")) ]) ])) ]));
                ("select", (jo [
                  ("exist", (ja [
                    (Str "id") ])) ]));
                ("response", (jo [
                  ("kind", (Str "json"));
                  ("media", (Str "application/json")) ])) ]) ])) ]));
          ("remove", (jo [
            ("input", (Str "data"));
            ("name", (Str "remove"));
            ("points", (ja [
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "DELETE"));
                ("orig", (Str "/contacts/{contactId}/groups/{groupId}"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "contacts")) ]);
                  (jo [
                    ("var", (Str "id")) ]);
                  (jo [
                    ("lit", (Str "groups")) ]);
                  (jo [
                    ("var", (Str "group_id")) ]) ]));
                ("parts", (ja [
                  (Str "contacts");
                  (Str "{id}");
                  (Str "groups");
                  (Str "{group_id}") ]));
                ("rename", (jo [
                  ("param", (jo [
                    ("contactId", (Str "id"));
                    ("groupId", (Str "group_id")) ])) ]));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (jo [
                  ("params", (ja [
                    (jo [
                      ("name", (Str "group_id"));
                      ("orig", (Str "groupId"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "param"));
                      ("reqd", (Bool true));
                      ("example", (Str "0f0f0f0f0f0f0f0f0f0f0f0f")) ]);
                    (jo [
                      ("name", (Str "id"));
                      ("orig", (Str "contactId"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "param"));
                      ("reqd", (Bool true));
                      ("example", (Str "0f0f0f0f0f0f0f0f0f0f0f0f")) ]) ])) ]));
                ("select", (jo [
                  ("exist", (ja [
                    (Str "group_id");
                    (Str "id") ])) ])) ]);
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "DELETE"));
                ("orig", (Str "/contacts/{contactId}"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "contacts")) ]);
                  (jo [
                    ("var", (Str "id")) ]) ]));
                ("parts", (ja [
                  (Str "contacts");
                  (Str "{id}") ]));
                ("rename", (jo [
                  ("param", (jo [
                    ("contactId", (Str "id")) ])) ]));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (jo [
                  ("params", (ja [
                    (jo [
                      ("name", (Str "id"));
                      ("orig", (Str "contactId"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "param"));
                      ("reqd", (Bool true));
                      ("example", (Str "0f0f0f0f0f0f0f0f0f0f0f0f")) ]) ])) ]));
                ("select", (jo [
                  ("exist", (ja [
                    (Str "id") ])) ])) ]);
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "DELETE"));
                ("orig", (Str "/contacts"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "contacts")) ]) ]));
                ("parts", (ja [
                  (Str "contacts") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (empty_map ()));
                ("select", (empty_map ())) ]) ])) ]));
          ("update", (jo [
            ("input", (Str "data"));
            ("name", (Str "update"));
            ("points", (ja [
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "PUT"));
                ("orig", (Str "/contacts/groups/{groupId}/members/{contactId}"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "contacts")) ]);
                  (jo [
                    ("lit", (Str "groups")) ]);
                  (jo [
                    ("var", (Str "group_id")) ]);
                  (jo [
                    ("lit", (Str "members")) ]);
                  (jo [
                    ("var", (Str "contact_id")) ]) ]));
                ("parts", (ja [
                  (Str "contacts");
                  (Str "groups");
                  (Str "{group_id}");
                  (Str "members");
                  (Str "{contact_id}") ]));
                ("rename", (jo [
                  ("param", (jo [
                    ("contactId", (Str "contact_id"));
                    ("groupId", (Str "group_id")) ])) ]));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (jo [
                  ("params", (ja [
                    (jo [
                      ("name", (Str "contact_id"));
                      ("orig", (Str "contactId"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "param"));
                      ("reqd", (Bool true));
                      ("example", (Str "0f0f0f0f0f0f0f0f0f0f0f0f")) ]);
                    (jo [
                      ("name", (Str "group_id"));
                      ("orig", (Str "groupId"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "param"));
                      ("reqd", (Bool true));
                      ("example", (Str "0f0f0f0f0f0f0f0f0f0f0f0f")) ]) ])) ]));
                ("select", (jo [
                  ("exist", (ja [
                    (Str "contact_id");
                    (Str "group_id") ])) ]));
                ("response", (jo [
                  ("kind", (Str "json"));
                  ("media", (Str "application/json")) ])) ]);
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "PUT"));
                ("orig", (Str "/contacts/{contactId}/groups/{groupId}"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "contacts")) ]);
                  (jo [
                    ("var", (Str "id")) ]);
                  (jo [
                    ("lit", (Str "groups")) ]);
                  (jo [
                    ("var", (Str "group_id")) ]) ]));
                ("parts", (ja [
                  (Str "contacts");
                  (Str "{id}");
                  (Str "groups");
                  (Str "{group_id}") ]));
                ("rename", (jo [
                  ("param", (jo [
                    ("contactId", (Str "id"));
                    ("groupId", (Str "group_id")) ])) ]));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (jo [
                  ("params", (ja [
                    (jo [
                      ("name", (Str "group_id"));
                      ("orig", (Str "groupId"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "param"));
                      ("reqd", (Bool true));
                      ("example", (Str "0f0f0f0f0f0f0f0f0f0f0f0f")) ]);
                    (jo [
                      ("name", (Str "id"));
                      ("orig", (Str "contactId"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "param"));
                      ("reqd", (Bool true));
                      ("example", (Str "0f0f0f0f0f0f0f0f0f0f0f0f")) ]) ])) ]));
                ("select", (jo [
                  ("exist", (ja [
                    (Str "group_id");
                    (Str "id") ])) ]));
                ("response", (jo [
                  ("kind", (Str "json"));
                  ("media", (Str "application/json")) ])) ]);
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "PUT"));
                ("orig", (Str "/contacts/{contactId}"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "contacts")) ]);
                  (jo [
                    ("var", (Str "id")) ]) ]));
                ("parts", (ja [
                  (Str "contacts");
                  (Str "{id}") ]));
                ("rename", (jo [
                  ("param", (jo [
                    ("contactId", (Str "id")) ])) ]));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (jo [
                  ("params", (ja [
                    (jo [
                      ("name", (Str "id"));
                      ("orig", (Str "contactId"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "param"));
                      ("reqd", (Bool true));
                      ("example", (Str "0f0f0f0f0f0f0f0f0f0f0f0f")) ]) ])) ]));
                ("select", (jo [
                  ("exist", (ja [
                    (Str "id") ])) ]));
                ("body", (jo [
                  ("fields", (ja [
                    (jo [
                      ("name", (Str "birthday_date")) ]);
                    (jo [
                      ("name", (Str "city")) ]);
                    (jo [
                      ("name", (Str "description")) ]);
                    (jo [
                      ("name", (Str "email")) ]);
                    (jo [
                      ("name", (Str "first_name")) ]);
                    (jo [
                      ("name", (Str "gender")) ]);
                    (jo [
                      ("name", (Str "last_name")) ]);
                    (jo [
                      ("name", (Str "phone_number")) ]);
                    (jo [
                      ("name", (Str "source")) ]) ]));
                  ("kind", (Str "form"));
                  ("media", (Str "application/x-www-form-urlencoded")) ]));
                ("response", (jo [
                  ("kind", (Str "json"));
                  ("media", (Str "application/json")) ])) ]) ])) ])) ]));
        ("relations", (jo [
          ("ancestors", (ja [
            (ja [
              (Str "$.main.kit.entity.group") ]);
            (ja [
              (Str "$.main.kit.entity.group") ]) ])) ])) ]));
      ("contacts_field", (jo [
        ("fields", (ja [
          (jo [
            ("name", (Str "id"));
            ("title", (Str "Id"));
            ("type", (Str "`$STRING`"));
            ("short", (Str "Object ID"));
            ("format", (Str "oid")) ]);
          (jo [
            ("name", (Str "name"));
            ("title", (Str "Name"));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "type"));
            ("title", (Str "Type"));
            ("type", (Str "`$STRING`")) ]) ]));
        ("id", (jo [
          ("field", (Str "id"));
          ("name", (Str "id")) ]));
        ("name", (Str "contacts_field"));
        ("op", (jo [
          ("create", (jo [
            ("input", (Str "data"));
            ("name", (Str "create"));
            ("points", (ja [
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "POST"));
                ("orig", (Str "/contacts/fields"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "contacts")) ]);
                  (jo [
                    ("lit", (Str "fields")) ]) ]));
                ("parts", (ja [
                  (Str "contacts");
                  (Str "fields") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (empty_map ()));
                ("select", (empty_map ()));
                ("body", (jo [
                  ("fields", (ja [
                    (jo [
                      ("name", (Str "name")) ]);
                    (jo [
                      ("name", (Str "type")) ]) ]));
                  ("kind", (Str "form"));
                  ("media", (Str "application/x-www-form-urlencoded")) ]));
                ("response", (jo [
                  ("kind", (Str "json"));
                  ("media", (Str "application/json")) ])) ]) ])) ]));
          ("list", (jo [
            ("input", (Str "data"));
            ("name", (Str "list"));
            ("points", (ja [
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "GET"));
                ("orig", (Str "/contacts/fields"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "contacts")) ]);
                  (jo [
                    ("lit", (Str "fields")) ]) ]));
                ("parts", (ja [
                  (Str "contacts");
                  (Str "fields") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body.collection`")) ]));
                ("args", (empty_map ()));
                ("select", (empty_map ()));
                ("response", (jo [
                  ("kind", (Str "json"));
                  ("media", (Str "application/json")) ])) ]) ])) ]));
          ("remove", (jo [
            ("input", (Str "data"));
            ("name", (Str "remove"));
            ("points", (ja [
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "DELETE"));
                ("orig", (Str "/contacts/fields/{fieldId}"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "contacts")) ]);
                  (jo [
                    ("lit", (Str "fields")) ]);
                  (jo [
                    ("var", (Str "id")) ]) ]));
                ("parts", (ja [
                  (Str "contacts");
                  (Str "fields");
                  (Str "{id}") ]));
                ("rename", (jo [
                  ("param", (jo [
                    ("fieldId", (Str "id")) ])) ]));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (jo [
                  ("params", (ja [
                    (jo [
                      ("name", (Str "id"));
                      ("orig", (Str "fieldId"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "param"));
                      ("reqd", (Bool true));
                      ("example", (Str "0f0f0f0f0f0f0f0f0f0f0f0f")) ]) ])) ]));
                ("select", (jo [
                  ("exist", (ja [
                    (Str "id") ])) ])) ]) ])) ]));
          ("update", (jo [
            ("input", (Str "data"));
            ("name", (Str "update"));
            ("points", (ja [
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "PUT"));
                ("orig", (Str "/contacts/fields/{fieldId}"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "contacts")) ]);
                  (jo [
                    ("lit", (Str "fields")) ]);
                  (jo [
                    ("var", (Str "id")) ]) ]));
                ("parts", (ja [
                  (Str "contacts");
                  (Str "fields");
                  (Str "{id}") ]));
                ("rename", (jo [
                  ("param", (jo [
                    ("fieldId", (Str "id")) ])) ]));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (jo [
                  ("params", (ja [
                    (jo [
                      ("name", (Str "id"));
                      ("orig", (Str "fieldId"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "param"));
                      ("reqd", (Bool true));
                      ("example", (Str "0f0f0f0f0f0f0f0f0f0f0f0f")) ]) ])) ]));
                ("select", (jo [
                  ("exist", (ja [
                    (Str "id") ])) ]));
                ("body", (jo [
                  ("fields", (ja [
                    (jo [
                      ("name", (Str "name")) ]) ]));
                  ("kind", (Str "form"));
                  ("media", (Str "application/x-www-form-urlencoded")) ]));
                ("response", (jo [
                  ("kind", (Str "json"));
                  ("media", (Str "application/json")) ])) ]) ])) ])) ]));
        ("relations", (jo [
          ("ancestors", (empty_list ())) ])) ]));
      ("contacts_field_option", (jo [
        ("fields", (empty_list ()));
        ("name", (Str "contacts_field_option"));
        ("op", (jo [
          ("list", (jo [
            ("input", (Str "data"));
            ("name", (Str "list"));
            ("points", (ja [
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "GET"));
                ("orig", (Str "/contacts/fields/{fieldId}/options"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "contacts")) ]);
                  (jo [
                    ("lit", (Str "fields")) ]);
                  (jo [
                    ("var", (Str "field_id")) ]);
                  (jo [
                    ("lit", (Str "options")) ]) ]));
                ("parts", (ja [
                  (Str "contacts");
                  (Str "fields");
                  (Str "{field_id}");
                  (Str "options") ]));
                ("rename", (jo [
                  ("param", (jo [
                    ("fieldId", (Str "field_id")) ])) ]));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body.collection`")) ]));
                ("args", (jo [
                  ("params", (ja [
                    (jo [
                      ("name", (Str "field_id"));
                      ("orig", (Str "fieldId"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "param"));
                      ("reqd", (Bool true));
                      ("example", (Str "0f0f0f0f0f0f0f0f0f0f0f0f")) ]) ])) ]));
                ("select", (jo [
                  ("exist", (ja [
                    (Str "field_id") ])) ]));
                ("response", (jo [
                  ("kind", (Str "json"));
                  ("media", (Str "application/json")) ])) ]) ])) ])) ]));
        ("relations", (jo [
          ("ancestors", (empty_list ())) ])) ]));
      ("contactsgroup", (jo [
        ("fields", (ja [
          (jo [
            ("name", (Str "group_id"));
            ("title", (Str "Group Id"));
            ("type", (Str "`$STRING`"));
            ("req", (Bool true));
            ("short", (Str "Object ID"));
            ("format", (Str "oid")) ]);
          (jo [
            ("name", (Str "read"));
            ("title", (Str "Read"));
            ("type", (Str "`$BOOLEAN`"));
            ("req", (Bool true));
            ("short", (Str "Has read permission")) ]);
          (jo [
            ("name", (Str "send"));
            ("title", (Str "Send"));
            ("type", (Str "`$BOOLEAN`"));
            ("req", (Bool true));
            ("short", (Str "Has send permission")) ]);
          (jo [
            ("name", (Str "username"));
            ("title", (Str "Username"));
            ("type", (Str "`$STRING`"));
            ("req", (Bool true)) ]);
          (jo [
            ("name", (Str "write"));
            ("title", (Str "Write"));
            ("type", (Str "`$BOOLEAN`"));
            ("req", (Bool true));
            ("short", (Str "Has write permission")) ]) ]));
        ("name", (Str "contactsgroup"));
        ("op", (jo [
          ("create", (jo [
            ("input", (Str "data"));
            ("name", (Str "create"));
            ("points", (ja [
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "POST"));
                ("orig", (Str "/contacts/groups/{groupId}/members"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "contacts")) ]);
                  (jo [
                    ("lit", (Str "groups")) ]);
                  (jo [
                    ("var", (Str "group_id")) ]);
                  (jo [
                    ("lit", (Str "members")) ]) ]));
                ("parts", (ja [
                  (Str "contacts");
                  (Str "groups");
                  (Str "{group_id}");
                  (Str "members") ]));
                ("rename", (jo [
                  ("param", (jo [
                    ("groupId", (Str "group_id")) ])) ]));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (jo [
                  ("params", (ja [
                    (jo [
                      ("name", (Str "group_id"));
                      ("orig", (Str "groupId"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "param"));
                      ("reqd", (Bool true));
                      ("example", (Str "0f0f0f0f0f0f0f0f0f0f0f0f")) ]) ])) ]));
                ("select", (jo [
                  ("exist", (ja [
                    (Str "group_id") ])) ]));
                ("body", (jo [
                  ("fields", (ja [
                    (jo [
                      ("list", (Bool true));
                      ("name", (Str "birthday_date")) ]);
                    (jo [
                      ("list", (Bool true));
                      ("name", (Str "email")) ]);
                    (jo [
                      ("list", (Bool true));
                      ("name", (Str "first_name")) ]);
                    (jo [
                      ("name", (Str "gender")) ]);
                    (jo [
                      ("list", (Bool true));
                      ("name", (Str "group_id")) ]);
                    (jo [
                      ("list", (Bool true));
                      ("name", (Str "last_name")) ]);
                    (jo [
                      ("list", (Bool true));
                      ("name", (Str "phone_number")) ]);
                    (jo [
                      ("name", (Str "q")) ]) ]));
                  ("kind", (Str "form"));
                  ("media", (Str "application/x-www-form-urlencoded")) ])) ]);
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "POST"));
                ("orig", (Str "/contacts/groups"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "contacts")) ]);
                  (jo [
                    ("lit", (Str "groups")) ]) ]));
                ("parts", (ja [
                  (Str "contacts");
                  (Str "groups") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (empty_map ()));
                ("select", (empty_map ()));
                ("body", (jo [
                  ("fields", (ja [
                    (jo [
                      ("name", (Str "contact_expire_after")) ]);
                    (jo [
                      ("name", (Str "description")) ]);
                    (jo [
                      ("name", (Str "idx")) ]);
                    (jo [
                      ("name", (Str "name")) ]) ]));
                  ("kind", (Str "form"));
                  ("media", (Str "application/x-www-form-urlencoded")) ]));
                ("response", (jo [
                  ("kind", (Str "json"));
                  ("media", (Str "application/json")) ])) ]) ])) ]));
          ("list", (jo [
            ("input", (Str "data"));
            ("name", (Str "list"));
            ("points", (ja [
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "GET"));
                ("orig", (Str "/contacts/groups/{groupId}/permissions"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "contacts")) ]);
                  (jo [
                    ("lit", (Str "groups")) ]);
                  (jo [
                    ("var", (Str "group_id")) ]);
                  (jo [
                    ("lit", (Str "permissions")) ]) ]));
                ("parts", (ja [
                  (Str "contacts");
                  (Str "groups");
                  (Str "{group_id}");
                  (Str "permissions") ]));
                ("rename", (jo [
                  ("param", (jo [
                    ("groupId", (Str "group_id")) ])) ]));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body.collection`")) ]));
                ("args", (jo [
                  ("params", (ja [
                    (jo [
                      ("name", (Str "group_id"));
                      ("orig", (Str "groupId"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "param"));
                      ("reqd", (Bool true));
                      ("example", (Str "0f0f0f0f0f0f0f0f0f0f0f0f")) ]) ])) ]));
                ("select", (jo [
                  ("exist", (ja [
                    (Str "group_id") ])) ]));
                ("response", (jo [
                  ("kind", (Str "json"));
                  ("media", (Str "application/json")) ])) ]);
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "GET"));
                ("orig", (Str "/contacts/groups"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "contacts")) ]);
                  (jo [
                    ("lit", (Str "groups")) ]) ]));
                ("parts", (ja [
                  (Str "contacts");
                  (Str "groups") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body.collection`")) ]));
                ("args", (jo [
                  ("query", (ja [
                    (jo [
                      ("name", (Str "name"));
                      ("orig", (Str "name"));
                      ("type", (Str "`$OBJECT`"));
                      ("kind", (Str "query"));
                      ("example", (Str "{\"name\" : \"group name\"}")) ]);
                    (jo [
                      ("name", (Str "with"));
                      ("orig", (Str "with"));
                      ("type", (Str "`$ARRAY`"));
                      ("kind", (Str "query")) ]) ])) ]));
                ("select", (empty_map ()));
                ("response", (jo [
                  ("kind", (Str "json"));
                  ("media", (Str "application/json")) ])) ]) ])) ]));
          ("remove", (jo [
            ("input", (Str "data"));
            ("name", (Str "remove"));
            ("points", (ja [
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "DELETE"));
                ("orig", (Str "/contacts/groups/{groupId}/members/{contactId}"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "contacts")) ]);
                  (jo [
                    ("lit", (Str "groups")) ]);
                  (jo [
                    ("var", (Str "group_id")) ]);
                  (jo [
                    ("lit", (Str "members")) ]);
                  (jo [
                    ("var", (Str "contact_id")) ]) ]));
                ("parts", (ja [
                  (Str "contacts");
                  (Str "groups");
                  (Str "{group_id}");
                  (Str "members");
                  (Str "{contact_id}") ]));
                ("rename", (jo [
                  ("param", (jo [
                    ("contactId", (Str "contact_id"));
                    ("groupId", (Str "group_id")) ])) ]));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (jo [
                  ("params", (ja [
                    (jo [
                      ("name", (Str "contact_id"));
                      ("orig", (Str "contactId"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "param"));
                      ("reqd", (Bool true));
                      ("example", (Str "0f0f0f0f0f0f0f0f0f0f0f0f")) ]);
                    (jo [
                      ("name", (Str "group_id"));
                      ("orig", (Str "groupId"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "param"));
                      ("reqd", (Bool true));
                      ("example", (Str "0f0f0f0f0f0f0f0f0f0f0f0f")) ]) ])) ]));
                ("select", (jo [
                  ("exist", (ja [
                    (Str "contact_id");
                    (Str "group_id") ])) ])) ]);
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "DELETE"));
                ("orig", (Str "/contacts/groups/{groupId}/permissions/{username}"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "contacts")) ]);
                  (jo [
                    ("lit", (Str "groups")) ]);
                  (jo [
                    ("var", (Str "group_id")) ]);
                  (jo [
                    ("lit", (Str "permissions")) ]);
                  (jo [
                    ("var", (Str "username")) ]) ]));
                ("parts", (ja [
                  (Str "contacts");
                  (Str "groups");
                  (Str "{group_id}");
                  (Str "permissions");
                  (Str "{username}") ]));
                ("rename", (jo [
                  ("param", (jo [
                    ("groupId", (Str "group_id")) ])) ]));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (jo [
                  ("params", (ja [
                    (jo [
                      ("name", (Str "group_id"));
                      ("orig", (Str "groupId"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "param"));
                      ("reqd", (Bool true));
                      ("example", (Str "0f0f0f0f0f0f0f0f0f0f0f0f")) ]);
                    (jo [
                      ("name", (Str "username"));
                      ("orig", (Str "username"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "param"));
                      ("reqd", (Bool true));
                      ("example", (Str "example_username")) ]) ])) ]));
                ("select", (jo [
                  ("exist", (ja [
                    (Str "group_id");
                    (Str "username") ])) ])) ]);
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "DELETE"));
                ("orig", (Str "/contacts/groups/{groupId}"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "contacts")) ]);
                  (jo [
                    ("lit", (Str "groups")) ]);
                  (jo [
                    ("var", (Str "group_id")) ]) ]));
                ("parts", (ja [
                  (Str "contacts");
                  (Str "groups");
                  (Str "{group_id}") ]));
                ("rename", (jo [
                  ("param", (jo [
                    ("groupId", (Str "group_id")) ])) ]));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (jo [
                  ("params", (ja [
                    (jo [
                      ("name", (Str "group_id"));
                      ("orig", (Str "groupId"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "param"));
                      ("reqd", (Bool true));
                      ("example", (Str "0f0f0f0f0f0f0f0f0f0f0f0f")) ]) ])) ]));
                ("select", (jo [
                  ("exist", (ja [
                    (Str "group_id") ])) ]));
                ("body", (jo [
                  ("fields", (ja [
                    (jo [
                      ("name", (Str "delete_contacts")) ]) ]));
                  ("kind", (Str "form"));
                  ("media", (Str "application/x-www-form-urlencoded")) ])) ]);
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "DELETE"));
                ("orig", (Str "/contacts/groups/{groupId}/members"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "contacts")) ]);
                  (jo [
                    ("lit", (Str "groups")) ]);
                  (jo [
                    ("var", (Str "group_id")) ]);
                  (jo [
                    ("lit", (Str "members")) ]) ]));
                ("parts", (ja [
                  (Str "contacts");
                  (Str "groups");
                  (Str "{group_id}");
                  (Str "members") ]));
                ("rename", (jo [
                  ("param", (jo [
                    ("groupId", (Str "group_id")) ])) ]));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (jo [
                  ("params", (ja [
                    (jo [
                      ("name", (Str "group_id"));
                      ("orig", (Str "groupId"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "param"));
                      ("reqd", (Bool true));
                      ("example", (Str "0f0f0f0f0f0f0f0f0f0f0f0f")) ]) ])) ]));
                ("select", (jo [
                  ("exist", (ja [
                    (Str "group_id") ])) ]));
                ("body", (jo [
                  ("fields", (ja [
                    (jo [
                      ("list", (Bool true));
                      ("name", (Str "birthday_date")) ]);
                    (jo [
                      ("list", (Bool true));
                      ("name", (Str "email")) ]);
                    (jo [
                      ("list", (Bool true));
                      ("name", (Str "first_name")) ]);
                    (jo [
                      ("name", (Str "gender")) ]);
                    (jo [
                      ("list", (Bool true));
                      ("name", (Str "group_id")) ]);
                    (jo [
                      ("list", (Bool true));
                      ("name", (Str "last_name")) ]);
                    (jo [
                      ("list", (Bool true));
                      ("name", (Str "phone_number")) ]);
                    (jo [
                      ("name", (Str "q")) ]) ]));
                  ("kind", (Str "form"));
                  ("media", (Str "application/x-www-form-urlencoded")) ])) ]);
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "DELETE"));
                ("orig", (Str "/contacts/groups"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "contacts")) ]);
                  (jo [
                    ("lit", (Str "groups")) ]) ]));
                ("parts", (ja [
                  (Str "contacts");
                  (Str "groups") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (empty_map ()));
                ("select", (empty_map ())) ]) ])) ]));
          ("update", (jo [
            ("input", (Str "data"));
            ("name", (Str "update"));
            ("points", (ja [
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "PUT"));
                ("orig", (Str "/contacts/groups/{groupId}/permissions/{username}"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "contacts")) ]);
                  (jo [
                    ("lit", (Str "groups")) ]);
                  (jo [
                    ("var", (Str "group_id")) ]);
                  (jo [
                    ("lit", (Str "permissions")) ]);
                  (jo [
                    ("var", (Str "username")) ]) ]));
                ("parts", (ja [
                  (Str "contacts");
                  (Str "groups");
                  (Str "{group_id}");
                  (Str "permissions");
                  (Str "{username}") ]));
                ("rename", (jo [
                  ("param", (jo [
                    ("groupId", (Str "group_id")) ])) ]));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (jo [
                  ("params", (ja [
                    (jo [
                      ("name", (Str "group_id"));
                      ("orig", (Str "groupId"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "param"));
                      ("reqd", (Bool true));
                      ("example", (Str "0f0f0f0f0f0f0f0f0f0f0f0f")) ]);
                    (jo [
                      ("name", (Str "username"));
                      ("orig", (Str "username"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "param"));
                      ("reqd", (Bool true));
                      ("example", (Str "example_username")) ]) ])) ]));
                ("select", (jo [
                  ("exist", (ja [
                    (Str "group_id");
                    (Str "username") ])) ]));
                ("body", (jo [
                  ("fields", (ja [
                    (jo [
                      ("name", (Str "read")) ]);
                    (jo [
                      ("name", (Str "send")) ]);
                    (jo [
                      ("name", (Str "write")) ]) ]));
                  ("kind", (Str "form"));
                  ("media", (Str "application/x-www-form-urlencoded")) ]));
                ("response", (jo [
                  ("kind", (Str "json"));
                  ("media", (Str "application/json")) ])) ]);
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "PUT"));
                ("orig", (Str "/contacts/groups/{groupId}/members"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "contacts")) ]);
                  (jo [
                    ("lit", (Str "groups")) ]);
                  (jo [
                    ("var", (Str "group_id")) ]);
                  (jo [
                    ("lit", (Str "members")) ]) ]));
                ("parts", (ja [
                  (Str "contacts");
                  (Str "groups");
                  (Str "{group_id}");
                  (Str "members") ]));
                ("rename", (jo [
                  ("param", (jo [
                    ("groupId", (Str "group_id")) ])) ]));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (jo [
                  ("params", (ja [
                    (jo [
                      ("name", (Str "group_id"));
                      ("orig", (Str "groupId"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "param"));
                      ("reqd", (Bool true));
                      ("example", (Str "0f0f0f0f0f0f0f0f0f0f0f0f")) ]) ])) ]));
                ("select", (jo [
                  ("exist", (ja [
                    (Str "group_id") ])) ]));
                ("body", (jo [
                  ("fields", (ja [
                    (jo [
                      ("list", (Bool true));
                      ("name", (Str "birthday_date")) ]);
                    (jo [
                      ("list", (Bool true));
                      ("name", (Str "email")) ]);
                    (jo [
                      ("list", (Bool true));
                      ("name", (Str "first_name")) ]);
                    (jo [
                      ("name", (Str "gender")) ]);
                    (jo [
                      ("list", (Bool true));
                      ("name", (Str "group_id")) ]);
                    (jo [
                      ("list", (Bool true));
                      ("name", (Str "last_name")) ]);
                    (jo [
                      ("list", (Bool true));
                      ("name", (Str "phone_number")) ]);
                    (jo [
                      ("name", (Str "q")) ]) ]));
                  ("kind", (Str "form"));
                  ("media", (Str "application/x-www-form-urlencoded")) ])) ]) ])) ])) ]));
        ("relations", (jo [
          ("ancestors", (ja [
            (ja [
              (Str "$.main.kit.entity.group") ]);
            (ja [
              (Str "$.main.kit.entity.group") ]);
            (ja [
              (Str "$.main.kit.entity.group");
              (Str "$.main.kit.entity.permission") ]) ])) ])) ]));
      ("contactstrash", (jo [
        ("fields", (empty_list ()));
        ("name", (Str "contactstrash"));
        ("op", (jo [
          ("remove", (jo [
            ("input", (Str "data"));
            ("name", (Str "remove"));
            ("points", (ja [
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "DELETE"));
                ("orig", (Str "/contacts/trash"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "contacts")) ]);
                  (jo [
                    ("lit", (Str "trash")) ]) ]));
                ("parts", (ja [
                  (Str "contacts");
                  (Str "trash") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (empty_map ()));
                ("select", (empty_map ())) ]) ])) ]));
          ("update", (jo [
            ("input", (Str "data"));
            ("name", (Str "update"));
            ("points", (ja [
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "PUT"));
                ("orig", (Str "/contacts/trash/restore"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "contacts")) ]);
                  (jo [
                    ("lit", (Str "trash")) ]);
                  (jo [
                    ("lit", (Str "restore")) ]) ]));
                ("parts", (ja [
                  (Str "contacts");
                  (Str "trash");
                  (Str "restore") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (empty_map ()));
                ("select", (empty_map ())) ]) ])) ])) ]));
        ("relations", (jo [
          ("ancestors", (empty_list ())) ])) ]));
      ("field_available", (jo [
        ("fields", (ja [
          (jo [
            ("name", (Str "built_in"));
            ("title", (Str "Built In"));
            ("type", (Str "`$BOOLEAN`")) ]);
          (jo [
            ("name", (Str "id"));
            ("title", (Str "Id"));
            ("type", (Str "`$STRING`"));
            ("short", (Str "Object ID"));
            ("format", (Str "oid")) ]);
          (jo [
            ("name", (Str "name"));
            ("title", (Str "Name"));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "options"));
            ("title", (Str "Options"));
            ("type", (Str "`$ARRAY`")) ]);
          (jo [
            ("name", (Str "type"));
            ("title", (Str "Type"));
            ("type", (Str "`$STRING`")) ]) ]));
        ("id", (jo [
          ("field", (Str "id"));
          ("name", (Str "id")) ]));
        ("name", (Str "field_available"));
        ("op", (jo [
          ("list", (jo [
            ("input", (Str "data"));
            ("name", (Str "list"));
            ("points", (ja [
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "GET"));
                ("orig", (Str "/contacts/fields/available"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "contacts")) ]);
                  (jo [
                    ("lit", (Str "fields")) ]);
                  (jo [
                    ("lit", (Str "available")) ]) ]));
                ("parts", (ja [
                  (Str "contacts");
                  (Str "fields");
                  (Str "available") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (empty_map ()));
                ("select", (empty_map ()));
                ("response", (jo [
                  ("kind", (Str "json"));
                  ("media", (Str "application/json")) ])) ]) ])) ])) ]));
        ("relations", (jo [
          ("ancestors", (empty_list ())) ])) ]));
      ("group", (jo [
        ("fields", (ja [
          (jo [
            ("name", (Str "contact_expire_after"));
            ("title", (Str "Contact Expire After"));
            ("type", (Str "`$INTEGER`"));
            ("req", (Bool true));
            ("short", (Str "Contact expire after days")) ]);
          (jo [
            ("name", (Str "contacts_count"));
            ("title", (Str "Contacts Count"));
            ("type", (Str "`$INTEGER`"));
            ("req", (Bool true)) ]);
          (jo [
            ("name", (Str "created_by"));
            ("title", (Str "Created By"));
            ("type", (Str "`$STRING`"));
            ("req", (Bool true)) ]);
          (jo [
            ("name", (Str "date_created"));
            ("title", (Str "Date Created"));
            ("type", (Str "`$STRING`"));
            ("req", (Bool true));
            ("format", (Str "date-time")) ]);
          (jo [
            ("name", (Str "date_updated"));
            ("title", (Str "Date Updated"));
            ("type", (Str "`$STRING`"));
            ("req", (Bool true));
            ("format", (Str "date-time")) ]);
          (jo [
            ("name", (Str "description"));
            ("title", (Str "Description"));
            ("type", (Str "`$STRING`"));
            ("req", (Bool true)) ]);
          (jo [
            ("name", (Str "id"));
            ("title", (Str "Id"));
            ("type", (Str "`$STRING`"));
            ("req", (Bool true));
            ("short", (Str "Object ID"));
            ("format", (Str "oid")) ]);
          (jo [
            ("name", (Str "idx"));
            ("title", (Str "Idx"));
            ("type", (Str "`$STRING`"));
            ("short", (Str "User provided resource id")) ]);
          (jo [
            ("name", (Str "name"));
            ("title", (Str "Name"));
            ("type", (Str "`$STRING`"));
            ("req", (Bool true));
            ("short", (Str "Group name")) ]);
          (jo [
            ("name", (Str "permissions"));
            ("title", (Str "Permissions"));
            ("type", (Str "`$ARRAY`")) ]) ]));
        ("id", (jo [
          ("field", (Str "id"));
          ("name", (Str "id")) ]));
        ("name", (Str "group"));
        ("op", (jo [
          ("load", (jo [
            ("input", (Str "data"));
            ("name", (Str "load"));
            ("points", (ja [
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "GET"));
                ("orig", (Str "/contacts/groups/{groupId}"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "contacts")) ]);
                  (jo [
                    ("lit", (Str "groups")) ]);
                  (jo [
                    ("var", (Str "id")) ]) ]));
                ("parts", (ja [
                  (Str "contacts");
                  (Str "groups");
                  (Str "{id}") ]));
                ("rename", (jo [
                  ("param", (jo [
                    ("groupId", (Str "id")) ])) ]));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (jo [
                  ("params", (ja [
                    (jo [
                      ("name", (Str "id"));
                      ("orig", (Str "groupId"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "param"));
                      ("reqd", (Bool true));
                      ("example", (Str "0f0f0f0f0f0f0f0f0f0f0f0f")) ]) ])) ]));
                ("select", (jo [
                  ("exist", (ja [
                    (Str "id") ])) ]));
                ("response", (jo [
                  ("kind", (Str "json"));
                  ("media", (Str "application/json")) ])) ]) ])) ]));
          ("update", (jo [
            ("input", (Str "data"));
            ("name", (Str "update"));
            ("points", (ja [
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "PUT"));
                ("orig", (Str "/contacts/groups/{groupId}"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "contacts")) ]);
                  (jo [
                    ("lit", (Str "groups")) ]);
                  (jo [
                    ("var", (Str "id")) ]) ]));
                ("parts", (ja [
                  (Str "contacts");
                  (Str "groups");
                  (Str "{id}") ]));
                ("rename", (jo [
                  ("param", (jo [
                    ("groupId", (Str "id")) ])) ]));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (jo [
                  ("params", (ja [
                    (jo [
                      ("name", (Str "id"));
                      ("orig", (Str "groupId"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "param"));
                      ("reqd", (Bool true));
                      ("example", (Str "0f0f0f0f0f0f0f0f0f0f0f0f")) ]) ])) ]));
                ("select", (jo [
                  ("exist", (ja [
                    (Str "id") ])) ]));
                ("body", (jo [
                  ("fields", (ja [
                    (jo [
                      ("name", (Str "contact_expire_after")) ]);
                    (jo [
                      ("name", (Str "description")) ]);
                    (jo [
                      ("name", (Str "idx")) ]);
                    (jo [
                      ("name", (Str "name")) ]) ]));
                  ("kind", (Str "form"));
                  ("media", (Str "application/x-www-form-urlencoded")) ]));
                ("response", (jo [
                  ("kind", (Str "json"));
                  ("media", (Str "application/json")) ])) ]) ])) ])) ]));
        ("relations", (jo [
          ("ancestors", (empty_list ())) ])) ]));
      ("mfa_code", (jo [
        ("fields", (ja [
          (jo [
            ("name", (Str "content"));
            ("title", (Str "Content"));
            ("type", (Str "`$STRING`"));
            ("short", (Str "Custom content that must contain placeholder [%code%]")) ]);
          (jo [
            ("name", (Str "fast"));
            ("title", (Str "Fast"));
            ("type", (Str "`$ANY`")) ]);
          (jo [
            ("name", (Str "from"));
            ("title", (Str "From"));
            ("type", (Str "`$STRING`"));
            ("short", (Str "Sendername")) ]);
          (jo [
            ("name", (Str "phone_number"));
            ("title", (Str "Phone Number"));
            ("type", (Str "`$STRING`"));
            ("req", (Bool true)) ]) ]));
        ("name", (Str "mfa_code"));
        ("op", (jo [
          ("create", (jo [
            ("input", (Str "data"));
            ("name", (Str "create"));
            ("points", (ja [
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "POST"));
                ("orig", (Str "/mfa/codes"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "mfa")) ]);
                  (jo [
                    ("lit", (Str "codes")) ]) ]));
                ("parts", (ja [
                  (Str "mfa");
                  (Str "codes") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (empty_map ()));
                ("select", (empty_map ()));
                ("response", (jo [
                  ("kind", (Str "json"));
                  ("media", (Str "application/json")) ])) ]);
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "POST"));
                ("orig", (Str "/mfa/codes/verifications"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "mfa")) ]);
                  (jo [
                    ("lit", (Str "codes")) ]);
                  (jo [
                    ("lit", (Str "verifications")) ]) ]));
                ("parts", (ja [
                  (Str "mfa");
                  (Str "codes");
                  (Str "verifications") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (empty_map ()));
                ("select", (jo [
                  ("$action", (Str "verification")) ]));
                ("body", (jo [
                  ("fields", (ja [
                    (jo [
                      ("name", (Str "code")) ]);
                    (jo [
                      ("name", (Str "phone_number")) ]) ]));
                  ("kind", (Str "form"));
                  ("media", (Str "application/x-www-form-urlencoded")) ])) ]) ])) ])) ]));
        ("relations", (jo [
          ("ancestors", (empty_list ())) ])) ]));
      ("opt_out", (jo [
        ("fields", (ja [
          (jo [
            ("name", (Str "date"));
            ("title", (Str "Date"));
            ("type", (Str "`$STRING`"));
            ("format", (Str "date-time")) ]);
          (jo [
            ("name", (Str "id"));
            ("title", (Str "Id"));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "links"));
            ("title", (Str "Links"));
            ("type", (Str "`$ARRAY`")) ]);
          (jo [
            ("name", (Str "phoneNumber"));
            ("title", (Str "Phone Number"));
            ("type", (Str "`$INTEGER`")) ]) ]));
        ("id", (jo [
          ("field", (Str "id"));
          ("name", (Str "id")) ]));
        ("name", (Str "opt_out"));
        ("op", (jo [
          ("list", (jo [
            ("input", (Str "data"));
            ("name", (Str "list"));
            ("points", (ja [
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "GET"));
                ("orig", (Str "/opt_outs"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "opt_outs")) ]) ]));
                ("parts", (ja [
                  (Str "opt_outs") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body.collection`")) ]));
                ("args", (jo [
                  ("header", (ja [
                    (jo [
                      ("name", (Str "accept"));
                      ("orig", (Str "Accept"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "header"));
                      ("example", (Str "application/json")) ]);
                    (jo [
                      ("name", (Str "x_async"));
                      ("orig", (Str "x-async"));
                      ("type", (Str "`$BOOLEAN`"));
                      ("kind", (Str "header"));
                      ("example", (Bool false)) ]) ]));
                  ("query", (ja [
                    (jo [
                      ("name", (Str "limit"));
                      ("orig", (Str "limit"));
                      ("type", (Str "`$INTEGER`"));
                      ("kind", (Str "query"));
                      ("example", (Num (5.))) ]);
                    (jo [
                      ("name", (Str "offset"));
                      ("orig", (Str "offset"));
                      ("type", (Str "`$INTEGER`"));
                      ("kind", (Str "query"));
                      ("example", (Num (0.))) ]);
                    (jo [
                      ("name", (Str "phone_number"));
                      ("orig", (Str "phone_number"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "query")) ]) ])) ]));
                ("select", (empty_map ()));
                ("response", (jo [
                  ("alternatives", (ja [
                    (jo [
                      ("kind", (Str "raw"));
                      ("media", (Str "text/csv")) ]) ]));
                  ("kind", (Str "json"));
                  ("media", (Str "application/json")) ])) ]) ])) ]));
          ("remove", (jo [
            ("input", (Str "data"));
            ("name", (Str "remove"));
            ("points", (ja [
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "DELETE"));
                ("orig", (Str "/opt_outs/{optOutId}"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "opt_outs")) ]);
                  (jo [
                    ("var", (Str "id")) ]) ]));
                ("parts", (ja [
                  (Str "opt_outs");
                  (Str "{id}") ]));
                ("rename", (jo [
                  ("param", (jo [
                    ("optOutId", (Str "id")) ])) ]));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (jo [
                  ("params", (ja [
                    (jo [
                      ("name", (Str "id"));
                      ("orig", (Str "optOutId"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "param"));
                      ("reqd", (Bool true)) ]) ])) ]));
                ("select", (jo [
                  ("exist", (ja [
                    (Str "id") ])) ])) ]) ])) ])) ]));
        ("relations", (jo [
          ("ancestors", (empty_list ())) ])) ]));
      ("opt_out_setting", (jo [
        ("fields", (ja [
          (jo [
            ("name", (Str "brand"));
            ("title", (Str "Brand"));
            ("type", (Str "`$STRING`")) ]) ]));
        ("name", (Str "opt_out_setting"));
        ("op", (jo [
          ("load", (jo [
            ("input", (Str "data"));
            ("name", (Str "load"));
            ("points", (ja [
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "GET"));
                ("orig", (Str "/opt_outs/settings"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "opt_outs")) ]);
                  (jo [
                    ("lit", (Str "settings")) ]) ]));
                ("parts", (ja [
                  (Str "opt_outs");
                  (Str "settings") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (empty_map ()));
                ("select", (empty_map ()));
                ("response", (jo [
                  ("kind", (Str "json"));
                  ("media", (Str "application/json")) ])) ]) ])) ]));
          ("update", (jo [
            ("input", (Str "data"));
            ("name", (Str "update"));
            ("points", (ja [
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "PUT"));
                ("orig", (Str "/opt_outs/settings"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "opt_outs")) ]);
                  (jo [
                    ("lit", (Str "settings")) ]) ]));
                ("parts", (ja [
                  (Str "opt_outs");
                  (Str "settings") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (empty_map ()));
                ("select", (empty_map ()));
                ("response", (jo [
                  ("kind", (Str "json"));
                  ("media", (Str "application/json")) ])) ]) ])) ])) ]));
        ("relations", (jo [
          ("ancestors", (empty_list ())) ])) ]));
      ("permission", (jo [
        ("fields", (ja [
          (jo [
            ("name", (Str "group_id"));
            ("title", (Str "Group Id"));
            ("type", (Str "`$STRING`"));
            ("req", (Bool true));
            ("short", (Str "Object ID"));
            ("format", (Str "oid")) ]);
          (jo [
            ("name", (Str "id"));
            ("title", (Str "Id"));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "read"));
            ("title", (Str "Read"));
            ("type", (Str "`$BOOLEAN`"));
            ("req", (Bool true));
            ("short", (Str "Has read permission")) ]);
          (jo [
            ("name", (Str "send"));
            ("title", (Str "Send"));
            ("type", (Str "`$BOOLEAN`"));
            ("req", (Bool true));
            ("short", (Str "Has send permission")) ]);
          (jo [
            ("name", (Str "username"));
            ("title", (Str "Username"));
            ("type", (Str "`$STRING`"));
            ("req", (Bool true)) ]);
          (jo [
            ("name", (Str "write"));
            ("title", (Str "Write"));
            ("type", (Str "`$BOOLEAN`"));
            ("req", (Bool true));
            ("short", (Str "Has write permission")) ]) ]));
        ("id", (jo [
          ("field", (Str "id"));
          ("name", (Str "id")) ]));
        ("name", (Str "permission"));
        ("op", (jo [
          ("create", (jo [
            ("input", (Str "data"));
            ("name", (Str "create"));
            ("points", (ja [
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "POST"));
                ("orig", (Str "/contacts/groups/{groupId}/permissions"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "contacts")) ]);
                  (jo [
                    ("lit", (Str "groups")) ]);
                  (jo [
                    ("var", (Str "group_id")) ]);
                  (jo [
                    ("lit", (Str "permissions")) ]) ]));
                ("parts", (ja [
                  (Str "contacts");
                  (Str "groups");
                  (Str "{group_id}");
                  (Str "permissions") ]));
                ("rename", (jo [
                  ("param", (jo [
                    ("groupId", (Str "group_id")) ])) ]));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (jo [
                  ("params", (ja [
                    (jo [
                      ("name", (Str "group_id"));
                      ("orig", (Str "groupId"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "param"));
                      ("reqd", (Bool true));
                      ("example", (Str "0f0f0f0f0f0f0f0f0f0f0f0f")) ]) ])) ]));
                ("select", (jo [
                  ("exist", (ja [
                    (Str "group_id") ])) ]));
                ("body", (jo [
                  ("fields", (ja [
                    (jo [
                      ("name", (Str "read")) ]);
                    (jo [
                      ("name", (Str "send")) ]);
                    (jo [
                      ("name", (Str "username")) ]);
                    (jo [
                      ("name", (Str "write")) ]) ]));
                  ("kind", (Str "form"));
                  ("media", (Str "application/x-www-form-urlencoded")) ]));
                ("response", (jo [
                  ("kind", (Str "json"));
                  ("media", (Str "application/json")) ])) ]) ])) ]));
          ("load", (jo [
            ("input", (Str "data"));
            ("name", (Str "load"));
            ("points", (ja [
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "GET"));
                ("orig", (Str "/contacts/groups/{groupId}/permissions/{username}"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "contacts")) ]);
                  (jo [
                    ("lit", (Str "groups")) ]);
                  (jo [
                    ("var", (Str "group_id")) ]);
                  (jo [
                    ("lit", (Str "permissions")) ]);
                  (jo [
                    ("var", (Str "id")) ]) ]));
                ("parts", (ja [
                  (Str "contacts");
                  (Str "groups");
                  (Str "{group_id}");
                  (Str "permissions");
                  (Str "{id}") ]));
                ("rename", (jo [
                  ("param", (jo [
                    ("groupId", (Str "group_id"));
                    ("username", (Str "id")) ])) ]));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (jo [
                  ("params", (ja [
                    (jo [
                      ("name", (Str "group_id"));
                      ("orig", (Str "groupId"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "param"));
                      ("reqd", (Bool true));
                      ("example", (Str "0f0f0f0f0f0f0f0f0f0f0f0f")) ]);
                    (jo [
                      ("name", (Str "id"));
                      ("orig", (Str "username"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "param"));
                      ("reqd", (Bool true));
                      ("example", (Str "example_username")) ]) ])) ]));
                ("select", (jo [
                  ("exist", (ja [
                    (Str "group_id");
                    (Str "id") ])) ]));
                ("response", (jo [
                  ("kind", (Str "json"));
                  ("media", (Str "application/json")) ])) ]) ])) ])) ]));
        ("relations", (jo [
          ("ancestors", (ja [
            (ja [
              (Str "$.main.kit.entity.group") ]) ])) ])) ]));
      ("ping", (jo [
        ("fields", (ja [
          (jo [
            ("name", (Str "authorized"));
            ("title", (Str "Authorized"));
            ("type", (Str "`$BOOLEAN`"));
            ("req", (Bool true)) ]);
          (jo [
            ("name", (Str "unavailable"));
            ("title", (Str "Unavailable"));
            ("type", (Str "`$ARRAY`"));
            ("req", (Bool true)) ]) ]));
        ("name", (Str "ping"));
        ("op", (jo [
          ("list", (jo [
            ("input", (Str "data"));
            ("name", (Str "list"));
            ("points", (ja [
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "GET"));
                ("orig", (Str "/ping"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "ping")) ]) ]));
                ("parts", (ja [
                  (Str "ping") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body.unavailable`")) ]));
                ("args", (empty_map ()));
                ("select", (empty_map ()));
                ("response", (jo [
                  ("kind", (Str "json"));
                  ("media", (Str "application/json")) ])) ]) ])) ])) ]));
        ("relations", (jo [
          ("ancestors", (empty_list ())) ])) ]));
      ("profile", (jo [
        ("fields", (ja [
          (jo [
            ("name", (Str "email"));
            ("title", (Str "Email"));
            ("type", (Str "`$STRING`"));
            ("req", (Bool true)) ]);
          (jo [
            ("name", (Str "name"));
            ("title", (Str "Name"));
            ("type", (Str "`$STRING`"));
            ("req", (Bool true)) ]);
          (jo [
            ("name", (Str "payment_type"));
            ("title", (Str "Payment Type"));
            ("type", (Str "`$STRING`"));
            ("req", (Bool true)) ]);
          (jo [
            ("name", (Str "phone_number"));
            ("title", (Str "Phone Number"));
            ("type", (Str "`$INTEGER`"));
            ("req", (Bool true)) ]);
          (jo [
            ("name", (Str "points"));
            ("title", (Str "Points"));
            ("type", (Str "`$NUMBER`"));
            ("format", (Str "float")) ]);
          (jo [
            ("name", (Str "user_type"));
            ("title", (Str "User Type"));
            ("type", (Str "`$STRING`"));
            ("req", (Bool true)) ]);
          (jo [
            ("name", (Str "username"));
            ("title", (Str "Username"));
            ("type", (Str "`$STRING`"));
            ("req", (Bool true)) ]) ]));
        ("name", (Str "profile"));
        ("op", (jo [
          ("list", (jo [
            ("input", (Str "data"));
            ("name", (Str "list"));
            ("points", (ja [
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "GET"));
                ("orig", (Str "/profile/prices"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "profile")) ]);
                  (jo [
                    ("lit", (Str "prices")) ]) ]));
                ("parts", (ja [
                  (Str "profile");
                  (Str "prices") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body.collection`")) ]));
                ("args", (jo [
                  ("query", (ja [
                    (jo [
                      ("name", (Str "type"));
                      ("orig", (Str "type"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "query"));
                      ("example", (Str "eco")) ]) ])) ]));
                ("select", (jo [
                  ("$action", (Str "price")) ]));
                ("response", (jo [
                  ("kind", (Str "json"));
                  ("media", (Str "application/json")) ])) ]) ])) ]));
          ("load", (jo [
            ("input", (Str "data"));
            ("name", (Str "load"));
            ("points", (ja [
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "GET"));
                ("orig", (Str "/profile"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "profile")) ]) ]));
                ("parts", (ja [
                  (Str "profile") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (empty_map ()));
                ("select", (empty_map ()));
                ("response", (jo [
                  ("kind", (Str "json"));
                  ("media", (Str "application/json")) ])) ]) ])) ])) ]));
        ("relations", (jo [
          ("ancestors", (empty_list ())) ])) ]));
      ("rcs", (jo [
        ("fields", (empty_list ()));
        ("name", (Str "rcs"));
        ("op", (jo [
          ("list", (jo [
            ("input", (Str "data"));
            ("name", (Str "list"));
            ("points", (ja [
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "GET"));
                ("orig", (Str "/rcs/messages"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "rcs")) ]);
                  (jo [
                    ("lit", (Str "messages")) ]) ]));
                ("parts", (ja [
                  (Str "rcs");
                  (Str "messages") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body.collection`")) ]));
                ("args", (empty_map ()));
                ("select", (jo [
                  ("$action", (Str "message")) ]));
                ("response", (jo [
                  ("kind", (Str "json"));
                  ("media", (Str "application/json")) ])) ]) ])) ])) ]));
        ("relations", (jo [
          ("ancestors", (empty_list ())) ])) ]));
      ("sendername", (jo [
        ("fields", (ja [
          (jo [
            ("name", (Str "created_at"));
            ("title", (Str "Created At"));
            ("type", (Str "`$STRING`"));
            ("format", (Str "date-time")) ]);
          (jo [
            ("name", (Str "id"));
            ("title", (Str "Id"));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "is_default"));
            ("title", (Str "Is Default"));
            ("type", (Str "`$BOOLEAN`")) ]);
          (jo [
            ("name", (Str "sender"));
            ("title", (Str "Sender"));
            ("type", (Str "`$STRING`"));
            ("short", (Str "Sendername")) ]);
          (jo [
            ("name", (Str "status"));
            ("title", (Str "Status"));
            ("type", (Str "`$STRING`")) ]) ]));
        ("id", (jo [
          ("field", (Str "id"));
          ("name", (Str "id")) ]));
        ("name", (Str "sendername"));
        ("op", (jo [
          ("create", (jo [
            ("input", (Str "data"));
            ("name", (Str "create"));
            ("points", (ja [
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "POST"));
                ("orig", (Str "/sms/sendernames"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "sms")) ]);
                  (jo [
                    ("lit", (Str "sendernames")) ]) ]));
                ("parts", (ja [
                  (Str "sms");
                  (Str "sendernames") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (empty_map ()));
                ("select", (empty_map ()));
                ("body", (jo [
                  ("fields", (ja [
                    (jo [
                      ("name", (Str "sender")) ]) ]));
                  ("kind", (Str "form"));
                  ("media", (Str "application/x-www-form-urlencoded")) ]));
                ("response", (jo [
                  ("kind", (Str "json"));
                  ("media", (Str "application/json")) ])) ]) ])) ]));
          ("list", (jo [
            ("input", (Str "data"));
            ("name", (Str "list"));
            ("points", (ja [
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "GET"));
                ("orig", (Str "/sms/sendernames"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "sms")) ]);
                  (jo [
                    ("lit", (Str "sendernames")) ]) ]));
                ("parts", (ja [
                  (Str "sms");
                  (Str "sendernames") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body.collection`")) ]));
                ("args", (empty_map ()));
                ("select", (empty_map ()));
                ("response", (jo [
                  ("kind", (Str "json"));
                  ("media", (Str "application/json")) ])) ]) ])) ]));
          ("load", (jo [
            ("input", (Str "data"));
            ("name", (Str "load"));
            ("points", (ja [
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "GET"));
                ("orig", (Str "/sms/sendernames/{sender}"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "sms")) ]);
                  (jo [
                    ("lit", (Str "sendernames")) ]);
                  (jo [
                    ("var", (Str "id")) ]) ]));
                ("parts", (ja [
                  (Str "sms");
                  (Str "sendernames");
                  (Str "{id}") ]));
                ("rename", (jo [
                  ("param", (jo [
                    ("sender", (Str "id")) ])) ]));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (jo [
                  ("params", (ja [
                    (jo [
                      ("name", (Str "id"));
                      ("orig", (Str "sender"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "param"));
                      ("reqd", (Bool true)) ]) ])) ]));
                ("select", (jo [
                  ("exist", (ja [
                    (Str "id") ])) ]));
                ("response", (jo [
                  ("kind", (Str "json"));
                  ("media", (Str "application/json")) ])) ]) ])) ])) ]));
        ("relations", (jo [
          ("ancestors", (empty_list ())) ])) ]));
      ("sendername_statement", (jo [
        ("fields", (ja [
          (jo [
            ("name", (Str "content"));
            ("title", (Str "Content"));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "statements"));
            ("title", (Str "Statements"));
            ("type", (Str "`$ARRAY`")) ]);
          (jo [
            ("name", (Str "title"));
            ("title", (Str "Title"));
            ("type", (Str "`$STRING`")) ]) ]));
        ("name", (Str "sendername_statement"));
        ("op", (jo [
          ("list", (jo [
            ("input", (Str "data"));
            ("name", (Str "list"));
            ("points", (ja [
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "GET"));
                ("orig", (Str "/sms/sendernames/statement"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "sms")) ]);
                  (jo [
                    ("lit", (Str "sendernames")) ]);
                  (jo [
                    ("lit", (Str "statement")) ]) ]));
                ("parts", (ja [
                  (Str "sms");
                  (Str "sendernames");
                  (Str "statement") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body.sections`")) ]));
                ("args", (empty_map ()));
                ("select", (empty_map ()));
                ("response", (jo [
                  ("kind", (Str "json"));
                  ("media", (Str "application/json")) ])) ]) ])) ])) ]));
        ("relations", (jo [
          ("ancestors", (empty_list ())) ])) ]));
      ("sent_rcs_message", (jo [
        ("fields", (ja [
          (jo [
            ("name", (Str "content"));
            ("title", (Str "Content"));
            ("type", (Str "`$OBJECT`"));
            ("short", (Str "RCS message content in RCS JSON format.")) ]);
          (jo [
            ("name", (Str "phone_number"));
            ("title", (Str "Phone Number"));
            ("type", (Str "`$STRING`"));
            ("req", (Bool true));
            ("short", (Str "Recipient phone number (e.g.")) ]);
          (jo [
            ("name", (Str "sender"));
            ("title", (Str "Sender"));
            ("type", (Str "`$STRING`"));
            ("req", (Bool true));
            ("short", (Str "RCS sender ID (object ID of the agent/sender the user has access to)."));
            ("format", (Str "oid")) ]);
          (jo [
            ("name", (Str "text"));
            ("title", (Str "Text"));
            ("type", (Str "`$STRING`"));
            ("short", (Str "Plain text message content.")) ]) ]));
        ("name", (Str "sent_rcs_message"));
        ("op", (jo [
          ("create", (jo [
            ("input", (Str "data"));
            ("name", (Str "create"));
            ("points", (ja [
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "POST"));
                ("orig", (Str "/rcs/messages"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "rcs")) ]);
                  (jo [
                    ("lit", (Str "messages")) ]) ]));
                ("parts", (ja [
                  (Str "rcs");
                  (Str "messages") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (empty_map ()));
                ("select", (empty_map ()));
                ("body", (jo [
                  ("alternatives", (ja [
                    (jo [
                      ("fields", (ja [
                        (jo [
                          ("name", (Str "content")) ]);
                        (jo [
                          ("name", (Str "phone_number")) ]);
                        (jo [
                          ("name", (Str "sender")) ]);
                        (jo [
                          ("name", (Str "text")) ]) ]));
                      ("kind", (Str "form"));
                      ("media", (Str "application/x-www-form-urlencoded")) ]) ]));
                  ("kind", (Str "json"));
                  ("media", (Str "application/json")) ]));
                ("response", (jo [
                  ("kind", (Str "json"));
                  ("media", (Str "application/json")) ])) ]) ])) ])) ]));
        ("relations", (jo [
          ("ancestors", (empty_list ())) ])) ]));
      ("shipment_country_volume", (jo [
        ("fields", (ja [
          (jo [
            ("name", (Str "country_code"));
            ("title", (Str "Country Code"));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "country_limit"));
            ("title", (Str "Country Limit"));
            ("type", (Str "`$INTEGER`")) ]);
          (jo [
            ("name", (Str "country_name"));
            ("title", (Str "Country Name"));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "usage"));
            ("title", (Str "Usage"));
            ("type", (Str "`$INTEGER`")) ]) ]));
        ("name", (Str "shipment_country_volume"));
        ("op", (jo [
          ("list", (jo [
            ("input", (Str "data"));
            ("name", (Str "list"));
            ("points", (ja [
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "GET"));
                ("orig", (Str "/shipment/country_volumes"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "shipment")) ]);
                  (jo [
                    ("lit", (Str "country_volumes")) ]) ]));
                ("parts", (ja [
                  (Str "shipment");
                  (Str "country_volumes") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body.collection`")) ]));
                ("args", (jo [
                  ("header", (ja [
                    (jo [
                      ("name", (Str "accept"));
                      ("orig", (Str "Accept"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "header"));
                      ("example", (Str "application/json")) ]) ]));
                  ("query", (ja [
                    (jo [
                      ("name", (Str "month"));
                      ("orig", (Str "month"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "query")) ]);
                    (jo [
                      ("name", (Str "year"));
                      ("orig", (Str "year"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "query")) ]) ])) ]));
                ("select", (empty_map ()));
                ("response", (jo [
                  ("alternatives", (ja [
                    (jo [
                      ("kind", (Str "raw"));
                      ("media", (Str "text/csv")) ]) ]));
                  ("kind", (Str "json"));
                  ("media", (Str "application/json")) ])) ]) ])) ])) ]));
        ("relations", (jo [
          ("ancestors", (empty_list ())) ])) ]));
      ("short_url", (jo [
        ("fields", (ja [
          (jo [
            ("name", (Str "description"));
            ("title", (Str "Description"));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "expire"));
            ("title", (Str "Expire"));
            ("type", (Str "`$STRING`"));
            ("format", (Str "date-time")) ]);
          (jo [
            ("name", (Str "filename"));
            ("title", (Str "Filename"));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "hits"));
            ("title", (Str "Hits"));
            ("type", (Str "`$INTEGER`")) ]);
          (jo [
            ("name", (Str "hits_unique"));
            ("title", (Str "Hits Unique"));
            ("type", (Str "`$INTEGER`")) ]);
          (jo [
            ("name", (Str "id"));
            ("title", (Str "Id"));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "name"));
            ("title", (Str "Name"));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "short_url"));
            ("title", (Str "Short Url"));
            ("type", (Str "`$STRING`"));
            ("short", (Str "WHATWG URL compliant"));
            ("format", (Str "url")) ]);
          (jo [
            ("name", (Str "type"));
            ("title", (Str "Type"));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "url"));
            ("title", (Str "Url"));
            ("type", (Str "`$STRING`"));
            ("short", (Str "WHATWG URL compliant"));
            ("format", (Str "url")) ]) ]));
        ("id", (jo [
          ("field", (Str "id"));
          ("name", (Str "id")) ]));
        ("name", (Str "short_url"));
        ("op", (jo [
          ("create", (jo [
            ("input", (Str "data"));
            ("name", (Str "create"));
            ("points", (ja [
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "POST"));
                ("orig", (Str "/short_url/links"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "short_url")) ]);
                  (jo [
                    ("lit", (Str "links")) ]) ]));
                ("parts", (ja [
                  (Str "short_url");
                  (Str "links") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (empty_map ()));
                ("select", (jo [
                  ("$action", (Str "link")) ]));
                ("body", (jo [
                  ("alternatives", (ja [
                    (jo [
                      ("kind", (Str "form"));
                      ("media", (Str "application/x-www-form-urlencoded")) ]) ]));
                  ("kind", (Str "json"));
                  ("media", (Str "application/json")) ]));
                ("response", (jo [
                  ("kind", (Str "json"));
                  ("media", (Str "application/json")) ])) ]) ])) ]));
          ("list", (jo [
            ("input", (Str "data"));
            ("name", (Str "list"));
            ("points", (ja [
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "GET"));
                ("orig", (Str "/short_url/links"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "short_url")) ]);
                  (jo [
                    ("lit", (Str "links")) ]) ]));
                ("parts", (ja [
                  (Str "short_url");
                  (Str "links") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body.collection`")) ]));
                ("args", (empty_map ()));
                ("select", (jo [
                  ("$action", (Str "link")) ]));
                ("response", (jo [
                  ("kind", (Str "json"));
                  ("media", (Str "application/json")) ])) ]) ])) ]));
          ("load", (jo [
            ("input", (Str "data"));
            ("name", (Str "load"));
            ("points", (ja [
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "GET"));
                ("orig", (Str "/short_url/links/{id}"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "short_url")) ]);
                  (jo [
                    ("lit", (Str "links")) ]);
                  (jo [
                    ("var", (Str "id")) ]) ]));
                ("parts", (ja [
                  (Str "short_url");
                  (Str "links");
                  (Str "{id}") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (jo [
                  ("params", (ja [
                    (jo [
                      ("name", (Str "id"));
                      ("orig", (Str "id"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "param"));
                      ("reqd", (Bool true));
                      ("example", (Str "123")) ]) ])) ]));
                ("select", (jo [
                  ("exist", (ja [
                    (Str "id") ])) ]));
                ("response", (jo [
                  ("kind", (Str "json"));
                  ("media", (Str "application/json")) ])) ]) ])) ]));
          ("remove", (jo [
            ("input", (Str "data"));
            ("name", (Str "remove"));
            ("points", (ja [
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "DELETE"));
                ("orig", (Str "/short_url/links/{id}"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "short_url")) ]);
                  (jo [
                    ("lit", (Str "links")) ]);
                  (jo [
                    ("var", (Str "id")) ]) ]));
                ("parts", (ja [
                  (Str "short_url");
                  (Str "links");
                  (Str "{id}") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (jo [
                  ("params", (ja [
                    (jo [
                      ("name", (Str "id"));
                      ("orig", (Str "id"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "param"));
                      ("reqd", (Bool true));
                      ("example", (Str "123")) ]) ])) ]));
                ("select", (jo [
                  ("exist", (ja [
                    (Str "id") ])) ])) ]) ])) ]));
          ("update", (jo [
            ("input", (Str "data"));
            ("name", (Str "update"));
            ("points", (ja [
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "PUT"));
                ("orig", (Str "/short_url/links/{id}"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "short_url")) ]);
                  (jo [
                    ("lit", (Str "links")) ]);
                  (jo [
                    ("var", (Str "id")) ]) ]));
                ("parts", (ja [
                  (Str "short_url");
                  (Str "links");
                  (Str "{id}") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (jo [
                  ("params", (ja [
                    (jo [
                      ("name", (Str "id"));
                      ("orig", (Str "id"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "param"));
                      ("reqd", (Bool true));
                      ("example", (Str "123")) ]) ])) ]));
                ("select", (jo [
                  ("exist", (ja [
                    (Str "id") ])) ]));
                ("body", (jo [
                  ("fields", (ja [
                    (jo [
                      ("name", (Str "description")) ]);
                    (jo [
                      ("name", (Str "name")) ]);
                    (jo [
                      ("name", (Str "url")) ]) ]));
                  ("kind", (Str "form"));
                  ("media", (Str "application/x-www-form-urlencoded")) ]));
                ("response", (jo [
                  ("kind", (Str "json"));
                  ("media", (Str "application/json")) ])) ]) ])) ])) ]));
        ("relations", (jo [
          ("ancestors", (empty_list ())) ])) ]));
      ("smsdo", (jo [
        ("fields", (ja [
          (jo [
            ("name", (Str "allow_duplicates"));
            ("title", (Str "Allow Duplicates"));
            ("type", (Str "`$INTEGER`"));
            ("short", (Str "When parameter allow_duplicates is set to \"1\" allows to send message to duplicated numbers in one request (useful i.e.")) ]);
          (jo [
            ("name", (Str "check_idx"));
            ("title", (Str "Check Idx"));
            ("type", (Str "`$ANY`"));
            ("short", (Str "When parameter check_idx is set to „1” prevents from sending more than one message with the same idx in last 24h.")) ]);
          (jo [
            ("name", (Str "date"));
            ("title", (Str "Date"));
            ("type", (Str "`$ANY`"));
            ("short", (Str "Date in UNIX timestamp (&date=1287734110) or in ISO 8601 (&date=2012-05-10T08:40:27+00:00) when message will be sent (&date=1287734110).")) ]);
          (jo [
            ("name", (Str "date_validate"));
            ("title", (Str "Date Validate"));
            ("type", (Str "`$INTEGER`"));
            ("short", (Str "When parameter date_validate is set to \"1\" checks if date if given in proper format.")) ]);
          (jo [
            ("name", (Str "details"));
            ("title", (Str "Details"));
            ("type", (Str "`$ANY`"));
            ("short", (Str "When details parameter is set to \"1\" more details in response will be displayed (message length and sms count).")) ]);
          (jo [
            ("name", (Str "encoding"));
            ("title", (Str "Encoding"));
            ("type", (Str "`$STRING`"));
            ("short", (Str "This parameter describes the encoding of the message text.")) ]);
          (jo [
            ("name", (Str "expiration_date"));
            ("title", (Str "Expiration Date"));
            ("type", (Str "`$ANY`"));
            ("short", (Str "Message expiration date (in UNIX timestamp or in ISO 8601) is a date after which message won't be delivered if it wasn't delivered yet.")) ]);
          (jo [
            ("name", (Str "fallback"));
            ("title", (Str "Fallback"));
            ("type", (Str "`$ARRAY`"));
            ("short", (Str "Enable fallback in case sms sending fails")) ]);
          (jo [
            ("name", (Str "fast"));
            ("title", (Str "Fast"));
            ("type", (Str "`$INTEGER`"));
            ("short", (Str "Setting this parameter to „1” will result in sending message with the highest priority which ensures the quickest possible time of delivery.")) ]);
          (jo [
            ("name", (Str "flash"));
            ("title", (Str "Flash"));
            ("type", (Str "`$INTEGER`"));
            ("short", (Str "Sending a message in flash mode can be activated by setting this parameter to \"1\".")) ]);
          (jo [
            ("name", (Str "format"));
            ("title", (Str "Format"));
            ("type", (Str "`$STRING`"));
            ("short", (Str "Parameter &format=json causes, that response is sending in JSON format.")) ]);
          (jo [
            ("name", (Str "from"));
            ("title", (Str "From"));
            ("type", (Str "`$STRING`"));
            ("short", (Str "Name of the sender.")) ]);
          (jo [
            ("name", (Str "group"));
            ("title", (Str "Group"));
            ("type", (Str "`$STRING`"));
            ("short", (Str "Name of the group from the contacts database to which message should be sent to.")) ]);
          (jo [
            ("name", (Str "idx"));
            ("title", (Str "Idx"));
            ("type", (Str "`$STRING`"));
            ("short", (Str "Optional custom value sent with SMS and sent back in CALLBACK.")) ]);
          (jo [
            ("name", (Str "max_parts"));
            ("title", (Str "Max Parts"));
            ("type", (Str "`$INTEGER`"));
            ("short", (Str "Defines maximum message parts allowed, maximum value allowed is 6.")) ]);
          (jo [
            ("name", (Str "message"));
            ("title", (Str "Message"));
            ("type", (Str "`$STRING`"));
            ("short", (Str "The message text.")) ]);
          (jo [
            ("name", (Str "normalize"));
            ("title", (Str "Normalize"));
            ("type", (Str "`$INTEGER`"));
            ("short", (Str "When parameter normalize is set to „1” special chars in message will be replaced with their equivalents (ê-e, ñ-n, ý-y ...).")) ]);
          (jo [
            ("name", (Str "notify_url"));
            ("title", (Str "Notify Url"));
            ("type", (Str "`$STRING`"));
            ("short", (Str "Parameter allows to set CALLBACK URL for message from request.")) ]);
          (jo [
            ("name", (Str "test"));
            ("title", (Str "Test"));
            ("type", (Str "`$ANY`"));
            ("short", (Str "When parameter test is set to \"1\" message won't be sent but response will be displayed, there is no charge for such test messages.")) ]);
          (jo [
            ("name", (Str "time_restriction"));
            ("title", (Str "Time Restriction"));
            ("type", (Str "`$STRING`"));
            ("short", (Str "Sets the behavior when you try to ship in hours / dates that do not match the settings in your account.")) ]);
          (jo [
            ("name", (Str "to"));
            ("title", (Str "To"));
            ("type", (Str "`$STRING`"));
            ("short", (Str "Recipients' mobile phone numbers (i.e.")) ]) ]));
        ("name", (Str "smsdo"));
        ("op", (jo [
          ("create", (jo [
            ("input", (Str "data"));
            ("name", (Str "create"));
            ("points", (ja [
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "POST"));
                ("orig", (Str "/sms.do"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "sms.do")) ]) ]));
                ("parts", (ja [
                  (Str "sms.do") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (empty_map ()));
                ("select", (empty_map ()));
                ("body", (jo [
                  ("alternatives", (ja [
                    (jo [
                      ("fields", (ja [
                        (jo [
                          ("name", (Str "allow_duplicates")) ]);
                        (jo [
                          ("name", (Str "check_idx")) ]);
                        (jo [
                          ("name", (Str "date")) ]);
                        (jo [
                          ("name", (Str "date_validate")) ]);
                        (jo [
                          ("name", (Str "details")) ]);
                        (jo [
                          ("name", (Str "encoding")) ]);
                        (jo [
                          ("name", (Str "expiration_date")) ]);
                        (jo [
                          ("list", (Bool true));
                          ("name", (Str "fallback")) ]);
                        (jo [
                          ("name", (Str "fast")) ]);
                        (jo [
                          ("name", (Str "flash")) ]);
                        (jo [
                          ("name", (Str "format")) ]);
                        (jo [
                          ("name", (Str "from")) ]);
                        (jo [
                          ("name", (Str "group")) ]);
                        (jo [
                          ("name", (Str "idx")) ]);
                        (jo [
                          ("name", (Str "max_parts")) ]);
                        (jo [
                          ("name", (Str "message")) ]);
                        (jo [
                          ("name", (Str "normalize")) ]);
                        (jo [
                          ("name", (Str "notify_url")) ]);
                        (jo [
                          ("name", (Str "test")) ]);
                        (jo [
                          ("name", (Str "time_restriction")) ]);
                        (jo [
                          ("name", (Str "to")) ]) ]));
                      ("kind", (Str "form"));
                      ("media", (Str "application/x-www-form-urlencoded")) ]) ]));
                  ("kind", (Str "json"));
                  ("media", (Str "application/json")) ]));
                ("response", (jo [
                  ("alternatives", (ja [
                    (jo [
                      ("kind", (Str "raw"));
                      ("media", (Str "text/plain")) ]) ]));
                  ("kind", (Str "json"));
                  ("media", (Str "application/json")) ])) ]) ])) ])) ]));
        ("relations", (jo [
          ("ancestors", (empty_list ())) ])) ]));
      ("smssendername", (jo [
        ("fields", (empty_list ()));
        ("name", (Str "smssendername"));
        ("op", (jo [
          ("create", (jo [
            ("input", (Str "data"));
            ("name", (Str "create"));
            ("points", (ja [
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "POST"));
                ("orig", (Str "/sms/sendernames/{sender}/commands/make_default"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "sms")) ]);
                  (jo [
                    ("lit", (Str "sendernames")) ]);
                  (jo [
                    ("var", (Str "sender")) ]);
                  (jo [
                    ("lit", (Str "commands")) ]);
                  (jo [
                    ("lit", (Str "make_default")) ]) ]));
                ("parts", (ja [
                  (Str "sms");
                  (Str "sendernames");
                  (Str "{sender}");
                  (Str "commands");
                  (Str "make_default") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (jo [
                  ("params", (ja [
                    (jo [
                      ("name", (Str "sender"));
                      ("orig", (Str "sender"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "param"));
                      ("reqd", (Bool true)) ]) ])) ]));
                ("select", (jo [
                  ("exist", (ja [
                    (Str "sender") ])) ])) ]) ])) ]));
          ("remove", (jo [
            ("input", (Str "data"));
            ("name", (Str "remove"));
            ("points", (ja [
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "DELETE"));
                ("orig", (Str "/sms/sendernames/{sender}"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "sms")) ]);
                  (jo [
                    ("lit", (Str "sendernames")) ]);
                  (jo [
                    ("var", (Str "sender")) ]) ]));
                ("parts", (ja [
                  (Str "sms");
                  (Str "sendernames");
                  (Str "{sender}") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (jo [
                  ("params", (ja [
                    (jo [
                      ("name", (Str "sender"));
                      ("orig", (Str "sender"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "param"));
                      ("reqd", (Bool true)) ]) ])) ]));
                ("select", (jo [
                  ("exist", (ja [
                    (Str "sender") ])) ])) ]) ])) ])) ]));
        ("relations", (jo [
          ("ancestors", (ja [
            (ja [
              (Str "$.main.kit.entity.sendername") ]) ])) ])) ]));
      ("smstemplate", (jo [
        ("fields", (ja [
          (jo [
            ("name", (Str "id"));
            ("title", (Str "Id"));
            ("type", (Str "`$STRING`")) ]) ]));
        ("id", (jo [
          ("field", (Str "id"));
          ("name", (Str "id")) ]));
        ("name", (Str "smstemplate"));
        ("op", (jo [
          ("remove", (jo [
            ("input", (Str "data"));
            ("name", (Str "remove"));
            ("points", (ja [
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "DELETE"));
                ("orig", (Str "/sms/templates/{id}"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "sms")) ]);
                  (jo [
                    ("lit", (Str "templates")) ]);
                  (jo [
                    ("var", (Str "id")) ]) ]));
                ("parts", (ja [
                  (Str "sms");
                  (Str "templates");
                  (Str "{id}") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (jo [
                  ("params", (ja [
                    (jo [
                      ("name", (Str "id"));
                      ("orig", (Str "id"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "param"));
                      ("reqd", (Bool true)) ]) ])) ]));
                ("select", (jo [
                  ("exist", (ja [
                    (Str "id") ])) ])) ]) ])) ])) ]));
        ("relations", (jo [
          ("ancestors", (empty_list ())) ])) ]));
      ("subuser", (jo [
        ("fields", (ja [
          (jo [
            ("name", (Str "active"));
            ("title", (Str "Active"));
            ("type", (Str "`$BOOLEAN`")) ]);
          (jo [
            ("name", (Str "credentials"));
            ("title", (Str "Credentials"));
            ("type", (Str "`$OBJECT`"));
            ("req", (Bool true));
            ("op", (jo [
              ("update", (jo [
                ("type", (Str "`$OBJECT`")) ])) ])) ]);
          (jo [
            ("name", (Str "description"));
            ("title", (Str "Description"));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "id"));
            ("title", (Str "Id"));
            ("type", (Str "`$STRING`"));
            ("short", (Str "Object ID"));
            ("format", (Str "oid")) ]);
          (jo [
            ("name", (Str "points"));
            ("title", (Str "Points"));
            ("type", (Str "`$OBJECT`")) ]);
          (jo [
            ("name", (Str "username"));
            ("title", (Str "Username"));
            ("type", (Str "`$STRING`")) ]) ]));
        ("id", (jo [
          ("field", (Str "id"));
          ("name", (Str "id")) ]));
        ("name", (Str "subuser"));
        ("op", (jo [
          ("create", (jo [
            ("input", (Str "data"));
            ("name", (Str "create"));
            ("points", (ja [
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "POST"));
                ("orig", (Str "/subusers"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "subusers")) ]) ]));
                ("parts", (ja [
                  (Str "subusers") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (empty_map ()));
                ("select", (empty_map ()));
                ("response", (jo [
                  ("kind", (Str "json"));
                  ("media", (Str "application/json")) ])) ]) ])) ]));
          ("list", (jo [
            ("input", (Str "data"));
            ("name", (Str "list"));
            ("points", (ja [
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "GET"));
                ("orig", (Str "/subusers/{id}/shares/sendernames"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "subusers")) ]);
                  (jo [
                    ("var", (Str "id")) ]);
                  (jo [
                    ("lit", (Str "shares")) ]);
                  (jo [
                    ("lit", (Str "sendernames")) ]) ]));
                ("parts", (ja [
                  (Str "subusers");
                  (Str "{id}");
                  (Str "shares");
                  (Str "sendernames") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body.senders`")) ]));
                ("args", (jo [
                  ("params", (ja [
                    (jo [
                      ("name", (Str "id"));
                      ("orig", (Str "id"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "param"));
                      ("reqd", (Bool true));
                      ("example", (Str "0f0f0f0f0f0f0f0f0f0f0f0f")) ]) ])) ]));
                ("select", (jo [
                  ("$action", (Str "share_sendername"));
                  ("exist", (ja [
                    (Str "id") ])) ]));
                ("response", (jo [
                  ("kind", (Str "json"));
                  ("media", (Str "application/json")) ])) ]);
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "GET"));
                ("orig", (Str "/subusers/{id}/shares/templates"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "subusers")) ]);
                  (jo [
                    ("var", (Str "id")) ]);
                  (jo [
                    ("lit", (Str "shares")) ]);
                  (jo [
                    ("lit", (Str "templates")) ]) ]));
                ("parts", (ja [
                  (Str "subusers");
                  (Str "{id}");
                  (Str "shares");
                  (Str "templates") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body.templates`")) ]));
                ("args", (jo [
                  ("params", (ja [
                    (jo [
                      ("name", (Str "id"));
                      ("orig", (Str "id"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "param"));
                      ("reqd", (Bool true));
                      ("example", (Str "0f0f0f0f0f0f0f0f0f0f0f0f")) ]) ])) ]));
                ("select", (jo [
                  ("$action", (Str "share_template"));
                  ("exist", (ja [
                    (Str "id") ])) ]));
                ("response", (jo [
                  ("kind", (Str "json"));
                  ("media", (Str "application/json")) ])) ]);
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "GET"));
                ("orig", (Str "/subusers"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "subusers")) ]) ]));
                ("parts", (ja [
                  (Str "subusers") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body.collection`")) ]));
                ("args", (jo [
                  ("query", (ja [
                    (jo [
                      ("name", (Str "q"));
                      ("orig", (Str "q"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "query")) ]) ])) ]));
                ("select", (empty_map ()));
                ("response", (jo [
                  ("kind", (Str "json"));
                  ("media", (Str "application/json")) ])) ]) ])) ]));
          ("load", (jo [
            ("input", (Str "data"));
            ("name", (Str "load"));
            ("points", (ja [
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "GET"));
                ("orig", (Str "/subusers/{id}"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "subusers")) ]);
                  (jo [
                    ("var", (Str "id")) ]) ]));
                ("parts", (ja [
                  (Str "subusers");
                  (Str "{id}") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (jo [
                  ("params", (ja [
                    (jo [
                      ("name", (Str "id"));
                      ("orig", (Str "id"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "param"));
                      ("reqd", (Bool true));
                      ("example", (Str "0f0f0f0f0f0f0f0f0f0f0f0f")) ]) ])) ]));
                ("select", (jo [
                  ("exist", (ja [
                    (Str "id") ])) ]));
                ("response", (jo [
                  ("kind", (Str "json"));
                  ("media", (Str "application/json")) ])) ]) ])) ]));
          ("remove", (jo [
            ("input", (Str "data"));
            ("name", (Str "remove"));
            ("points", (ja [
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "DELETE"));
                ("orig", (Str "/subusers/{id}"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "subusers")) ]);
                  (jo [
                    ("var", (Str "id")) ]) ]));
                ("parts", (ja [
                  (Str "subusers");
                  (Str "{id}") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (jo [
                  ("params", (ja [
                    (jo [
                      ("name", (Str "id"));
                      ("orig", (Str "id"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "param"));
                      ("reqd", (Bool true));
                      ("example", (Str "0f0f0f0f0f0f0f0f0f0f0f0f")) ]) ])) ]));
                ("select", (jo [
                  ("exist", (ja [
                    (Str "id") ])) ])) ]) ])) ]));
          ("update", (jo [
            ("input", (Str "data"));
            ("name", (Str "update"));
            ("points", (ja [
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "PUT"));
                ("orig", (Str "/subusers/{id}"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "subusers")) ]);
                  (jo [
                    ("var", (Str "id")) ]) ]));
                ("parts", (ja [
                  (Str "subusers");
                  (Str "{id}") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (jo [
                  ("params", (ja [
                    (jo [
                      ("name", (Str "id"));
                      ("orig", (Str "id"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "param"));
                      ("reqd", (Bool true));
                      ("example", (Str "0f0f0f0f0f0f0f0f0f0f0f0f")) ]) ])) ]));
                ("select", (jo [
                  ("exist", (ja [
                    (Str "id") ])) ]));
                ("response", (jo [
                  ("kind", (Str "json"));
                  ("media", (Str "application/json")) ])) ]);
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "PUT"));
                ("orig", (Str "/subusers/{id}/shares/sendernames"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "subusers")) ]);
                  (jo [
                    ("var", (Str "id")) ]);
                  (jo [
                    ("lit", (Str "shares")) ]);
                  (jo [
                    ("lit", (Str "sendernames")) ]) ]));
                ("parts", (ja [
                  (Str "subusers");
                  (Str "{id}");
                  (Str "shares");
                  (Str "sendernames") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (jo [
                  ("params", (ja [
                    (jo [
                      ("name", (Str "id"));
                      ("orig", (Str "id"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "param"));
                      ("reqd", (Bool true));
                      ("example", (Str "0f0f0f0f0f0f0f0f0f0f0f0f")) ]) ])) ]));
                ("select", (jo [
                  ("$action", (Str "share_sendername"));
                  ("exist", (ja [
                    (Str "id") ])) ])) ]);
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "PUT"));
                ("orig", (Str "/subusers/{id}/shares/templates"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "subusers")) ]);
                  (jo [
                    ("var", (Str "id")) ]);
                  (jo [
                    ("lit", (Str "shares")) ]);
                  (jo [
                    ("lit", (Str "templates")) ]) ]));
                ("parts", (ja [
                  (Str "subusers");
                  (Str "{id}");
                  (Str "shares");
                  (Str "templates") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (jo [
                  ("params", (ja [
                    (jo [
                      ("name", (Str "id"));
                      ("orig", (Str "id"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "param"));
                      ("reqd", (Bool true));
                      ("example", (Str "0f0f0f0f0f0f0f0f0f0f0f0f")) ]) ])) ]));
                ("select", (jo [
                  ("$action", (Str "share_template"));
                  ("exist", (ja [
                    (Str "id") ])) ])) ]) ])) ])) ]));
        ("relations", (jo [
          ("ancestors", (empty_list ())) ])) ]));
      ("template", (jo [
        ("fields", (ja [
          (jo [
            ("name", (Str "id"));
            ("title", (Str "Id"));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "name"));
            ("title", (Str "Name"));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "normalize"));
            ("title", (Str "Normalize"));
            ("type", (Str "`$BOOLEAN`")) ]);
          (jo [
            ("name", (Str "template"));
            ("title", (Str "Template"));
            ("type", (Str "`$STRING`")) ]) ]));
        ("id", (jo [
          ("field", (Str "id"));
          ("name", (Str "id")) ]));
        ("name", (Str "template"));
        ("op", (jo [
          ("create", (jo [
            ("input", (Str "data"));
            ("name", (Str "create"));
            ("points", (ja [
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "POST"));
                ("orig", (Str "/sms/templates"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "sms")) ]);
                  (jo [
                    ("lit", (Str "templates")) ]) ]));
                ("parts", (ja [
                  (Str "sms");
                  (Str "templates") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (empty_map ()));
                ("select", (empty_map ()));
                ("body", (jo [
                  ("fields", (ja [
                    (jo [
                      ("name", (Str "name")) ]);
                    (jo [
                      ("name", (Str "normalize")) ]);
                    (jo [
                      ("name", (Str "template")) ]) ]));
                  ("kind", (Str "form"));
                  ("media", (Str "application/x-www-form-urlencoded")) ]));
                ("response", (jo [
                  ("kind", (Str "json"));
                  ("media", (Str "application/json")) ])) ]) ])) ]));
          ("list", (jo [
            ("input", (Str "data"));
            ("name", (Str "list"));
            ("points", (ja [
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "GET"));
                ("orig", (Str "/sms/templates"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "sms")) ]);
                  (jo [
                    ("lit", (Str "templates")) ]) ]));
                ("parts", (ja [
                  (Str "sms");
                  (Str "templates") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body.collection`")) ]));
                ("args", (empty_map ()));
                ("select", (empty_map ()));
                ("response", (jo [
                  ("kind", (Str "json"));
                  ("media", (Str "application/json")) ])) ]) ])) ]));
          ("load", (jo [
            ("input", (Str "data"));
            ("name", (Str "load"));
            ("points", (ja [
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "GET"));
                ("orig", (Str "/sms/templates/{id}"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "sms")) ]);
                  (jo [
                    ("lit", (Str "templates")) ]);
                  (jo [
                    ("var", (Str "id")) ]) ]));
                ("parts", (ja [
                  (Str "sms");
                  (Str "templates");
                  (Str "{id}") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (jo [
                  ("params", (ja [
                    (jo [
                      ("name", (Str "id"));
                      ("orig", (Str "id"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "param"));
                      ("reqd", (Bool true)) ]) ])) ]));
                ("select", (jo [
                  ("exist", (ja [
                    (Str "id") ])) ]));
                ("response", (jo [
                  ("kind", (Str "json"));
                  ("media", (Str "application/json")) ])) ]) ])) ]));
          ("update", (jo [
            ("input", (Str "data"));
            ("name", (Str "update"));
            ("points", (ja [
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "PUT"));
                ("orig", (Str "/sms/templates/{id}"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "sms")) ]);
                  (jo [
                    ("lit", (Str "templates")) ]);
                  (jo [
                    ("var", (Str "id")) ]) ]));
                ("parts", (ja [
                  (Str "sms");
                  (Str "templates");
                  (Str "{id}") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (jo [
                  ("params", (ja [
                    (jo [
                      ("name", (Str "id"));
                      ("orig", (Str "id"));
                      ("type", (Str "`$STRING`"));
                      ("kind", (Str "param"));
                      ("reqd", (Bool true)) ]) ])) ]));
                ("select", (jo [
                  ("exist", (ja [
                    (Str "id") ])) ]));
                ("body", (jo [
                  ("fields", (ja [
                    (jo [
                      ("name", (Str "name")) ]);
                    (jo [
                      ("name", (Str "normalize")) ]);
                    (jo [
                      ("name", (Str "template")) ]) ]));
                  ("kind", (Str "form"));
                  ("media", (Str "application/x-www-form-urlencoded")) ]));
                ("response", (jo [
                  ("kind", (Str "json"));
                  ("media", (Str "application/json")) ])) ]) ])) ])) ]));
        ("relations", (jo [
          ("ancestors", (empty_list ())) ])) ]));
      ("user_rcs_sender_collection", (jo [
        ("fields", (empty_list ()));
        ("name", (Str "user_rcs_sender_collection"));
        ("op", (jo [
          ("list", (jo [
            ("input", (Str "data"));
            ("name", (Str "list"));
            ("points", (ja [
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "GET"));
                ("orig", (Str "/rcs/senders"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "rcs")) ]);
                  (jo [
                    ("lit", (Str "senders")) ]) ]));
                ("parts", (ja [
                  (Str "rcs");
                  (Str "senders") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body.collection`")) ]));
                ("args", (empty_map ()));
                ("select", (empty_map ()));
                ("response", (jo [
                  ("kind", (Str "json"));
                  ("media", (Str "application/json")) ])) ]) ])) ])) ]));
        ("relations", (jo [
          ("ancestors", (empty_list ())) ])) ])) ])) ])

(* The plugin definitions the model selected for the secrets feature's
 * provider chain: none - the chain can name the four built-in kinds (env, memory, dotenv, file) and a custom provider, and nothing else.
 * Built, not held: every call is a fresh list, so two chains never share
 * a definition. *)
let feature_plugins (name : string) : Defs.definition list =
  match name with
  | "secrets" -> []
  | _ -> []

let make_feature (name : string) : feature =
  match name with
  | "audit" -> audit_feature ()
  | "cache" -> cache_feature ()
  | "clienttrack" -> clienttrack_feature ()
  | "cost" -> cost_feature ()
  | "debug" -> debug_feature ()
  | "idempotency" -> idempotency_feature ()
  | "log" -> log_feature ()
  | "metrics" -> metrics_feature ()
  | "netsim" -> netsim_feature ()
  | "paging" -> paging_feature ()
  | "proxy" -> proxy_feature ()
  | "ratelimit" -> ratelimit_feature ()
  | "rbac" -> rbac_feature ()
  | "retry" -> retry_feature ()
  | "streaming" -> streaming_feature ()
  | "telemetry" -> telemetry_feature ()
  | "test" -> test_feature ()
  | "timeout" -> timeout_feature ()
  | "validate" -> validate_feature ()
  | "secrets" -> Secrets_feature.make ~plugins:(feature_plugins "secrets") ()
  | _ -> base_feature ()
