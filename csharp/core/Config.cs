// Smsapi SDK - generated model configuration and feature
// factory. GENERATED from the API model - do not edit by hand.

namespace SmsapiSdk;

public static class SdkConfig
{
    public static Dictionary<string, object?> MakeConfig()
    {
        return new Dictionary<string, object?>
        {
            ["main"] = new Dictionary<string, object?>
            {
                ["name"] = "Smsapi",
                ["slug"] = "smsapi",
                ["version"] = "0.0.1",
                ["target"] = "csharp",
            },
            ["feature"] = new Dictionary<string, object?>
            {
                ["audit"] = new Dictionary<string, object?>
                {
                    ["options"] = new Dictionary<string, object?>
                    {
                        ["active"] = false,
                        ["actor"] = "anonymous",
                        ["max"] = 1000,
                    },
                    ["optspec"] = new Dictionary<string, object?>
                    {
                        ["now"] = "`$FUNCTION`",
                        ["sink"] = "`$FUNCTION`",
                    },
                    ["strict"] = false,
                    ["transport"] = "none",
                },
                ["cache"] = new Dictionary<string, object?>
                {
                    ["options"] = new Dictionary<string, object?>
                    {
                        ["active"] = false,
                        ["max"] = 256,
                        ["methods"] = new List<object?>
                        {
                            "GET",
                        },
                        ["ttl"] = 5000,
                    },
                    ["optspec"] = new Dictionary<string, object?>
                    {
                        ["now"] = "`$FUNCTION`",
                    },
                    ["strict"] = false,
                    ["transport"] = "wrap",
                },
                ["clienttrack"] = new Dictionary<string, object?>
                {
                    ["options"] = new Dictionary<string, object?>
                    {
                        ["active"] = false,
                        ["clientVersion"] = "0.0.1",
                    },
                    ["optspec"] = new Dictionary<string, object?>
                    {
                        ["clientName"] = "`$STRING`",
                        ["clientVersion"] = "`$STRING`",
                        ["headers"] = "`$MAP`",
                        ["idgen"] = "`$FUNCTION`",
                        ["sessionId"] = "`$STRING`",
                    },
                    ["strict"] = false,
                    ["transport"] = "none",
                },
                ["cost"] = new Dictionary<string, object?>
                {
                    ["options"] = new Dictionary<string, object?>
                    {
                        ["active"] = false,
                        ["budget"] = 0,
                        ["currency"] = "USD",
                        ["header"] = "",
                        ["onBudget"] = "warn",
                        ["path"] = "",
                        ["perUnit"] = 0,
                        ["rates"] = new Dictionary<string, object?>(),
                        ["unit"] = 0,
                    },
                    ["optspec"] = new Dictionary<string, object?>
                    {
                        ["actor"] = "`$STRING`",
                        ["sink"] = "`$FUNCTION`",
                    },
                    ["strict"] = false,
                    ["transport"] = "wrap",
                },
                ["debug"] = new Dictionary<string, object?>
                {
                    ["options"] = new Dictionary<string, object?>
                    {
                        ["active"] = false,
                        ["max"] = 100,
                        ["redact"] = new List<object?>
                        {
                            "authorization",
                            "cookie",
                            "set-cookie",
                            "api-key",
                            "apikey",
                            "x-api-key",
                            "idempotency-key",
                        },
                    },
                    ["optspec"] = new Dictionary<string, object?>
                    {
                        ["now"] = "`$FUNCTION`",
                        ["onEntry"] = "`$FUNCTION`",
                    },
                    ["strict"] = false,
                    ["transport"] = "none",
                },
                ["idempotency"] = new Dictionary<string, object?>
                {
                    ["options"] = new Dictionary<string, object?>
                    {
                        ["active"] = false,
                        ["header"] = "Idempotency-Key",
                        ["methods"] = new List<object?>
                        {
                            "POST",
                            "PUT",
                            "PATCH",
                            "DELETE",
                        },
                        ["ops"] = new List<object?>
                        {
                            "create",
                            "update",
                            "remove",
                        },
                    },
                    ["optspec"] = new Dictionary<string, object?>
                    {
                        ["keygen"] = "`$FUNCTION`",
                    },
                    ["strict"] = false,
                    ["transport"] = "none",
                },
                ["log"] = new Dictionary<string, object?>
                {
                    ["options"] = new Dictionary<string, object?>
                    {
                        ["active"] = true,
                    },
                    ["optspec"] = new Dictionary<string, object?>
                    {
                        ["level"] = "`$STRING`",
                        ["logger"] = "`$ANY`",
                    },
                    ["strict"] = false,
                    ["transport"] = "none",
                },
                ["metrics"] = new Dictionary<string, object?>
                {
                    ["options"] = new Dictionary<string, object?>
                    {
                        ["active"] = false,
                    },
                    ["optspec"] = new Dictionary<string, object?>
                    {
                        ["now"] = "`$FUNCTION`",
                    },
                    ["strict"] = false,
                    ["transport"] = "none",
                },
                ["netsim"] = new Dictionary<string, object?>
                {
                    ["options"] = new Dictionary<string, object?>
                    {
                        ["active"] = false,
                        ["errorTimes"] = 0,
                        ["failEvery"] = 0,
                        ["failRate"] = 0,
                        ["failStatus"] = 503,
                        ["failTimes"] = 0,
                        ["latency"] = 0,
                        ["offline"] = false,
                        ["rateLimitTimes"] = 0,
                        ["retryAfter"] = 0,
                        ["seed"] = 1,
                    },
                    ["optspec"] = new Dictionary<string, object?>
                    {
                        ["latency"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$NUMBER`",
                            "`$MAP`",
                        },
                        ["sleep"] = "`$FUNCTION`",
                    },
                    ["strict"] = false,
                    ["transport"] = "wrap",
                },
                ["paging"] = new Dictionary<string, object?>
                {
                    ["options"] = new Dictionary<string, object?>
                    {
                        ["active"] = false,
                        ["afterVar"] = "after",
                        ["cursorParam"] = "cursor",
                        ["firstVar"] = "first",
                        ["limitParam"] = "limit",
                        ["pageParam"] = "page",
                        ["startPage"] = 1,
                    },
                    ["optspec"] = new Dictionary<string, object?>
                    {
                        ["limit"] = "`$NUMBER`",
                        ["ops"] = "`$LIST`",
                    },
                    ["strict"] = false,
                    ["transport"] = "none",
                },
                ["proxy"] = new Dictionary<string, object?>
                {
                    ["options"] = new Dictionary<string, object?>
                    {
                        ["active"] = false,
                        ["fromEnv"] = false,
                        ["noProxy"] = new List<object?>(),
                        ["url"] = "",
                    },
                    ["optspec"] = new Dictionary<string, object?>
                    {
                        ["agent"] = "`$FUNCTION`",
                    },
                    ["strict"] = false,
                    ["transport"] = "wrap",
                },
                ["ratelimit"] = new Dictionary<string, object?>
                {
                    ["options"] = new Dictionary<string, object?>
                    {
                        ["active"] = false,
                        ["burst"] = 5,
                        ["rate"] = 5,
                    },
                    ["optspec"] = new Dictionary<string, object?>
                    {
                        ["now"] = "`$FUNCTION`",
                        ["sleep"] = "`$FUNCTION`",
                    },
                    ["strict"] = false,
                    ["transport"] = "wrap",
                },
                ["rbac"] = new Dictionary<string, object?>
                {
                    ["options"] = new Dictionary<string, object?>
                    {
                        ["active"] = false,
                        ["deny"] = false,
                        ["permissions"] = new List<object?>(),
                        ["rules"] = new Dictionary<string, object?>(),
                    },
                    ["optspec"] = new Dictionary<string, object?>(),
                    ["strict"] = false,
                    ["transport"] = "none",
                },
                ["retry"] = new Dictionary<string, object?>
                {
                    ["options"] = new Dictionary<string, object?>
                    {
                        ["active"] = false,
                        ["factor"] = 2,
                        ["maxDelay"] = 2000,
                        ["minDelay"] = 50,
                        ["retries"] = 2,
                        ["statuses"] = new List<object?>
                        {
                            408,
                            425,
                            429,
                            500,
                            502,
                            503,
                            504,
                        },
                    },
                    ["optspec"] = new Dictionary<string, object?>
                    {
                        ["jitter"] = "`$BOOLEAN`",
                        ["sleep"] = "`$FUNCTION`",
                    },
                    ["strict"] = false,
                    ["transport"] = "wrap",
                },
                ["secrets"] = new Dictionary<string, object?>
                {
                    ["options"] = new Dictionary<string, object?>
                    {
                        ["active"] = false,
                        ["cache"] = true,
                        ["exchange"] = new Dictionary<string, object?>
                        {
                            ["active"] = false,
                            ["method"] = "POST",
                            ["path"] = "auth/token",
                            ["refresh"] = "",
                            ["request"] = "refresh_token",
                            ["response"] = "access_token",
                            ["retries"] = 1,
                            ["statuses"] = new List<object?>
                            {
                                401,
                            },
                        },
                        ["name"] = "apikey",
                        ["providers"] = new List<object?>(),
                    },
                    ["optspec"] = new Dictionary<string, object?>(),
                    ["strict"] = false,
                    ["transport"] = "wrap",
                },
                ["streaming"] = new Dictionary<string, object?>
                {
                    ["options"] = new Dictionary<string, object?>
                    {
                        ["active"] = false,
                        ["chunkDelay"] = 0,
                        ["chunkSize"] = 0,
                    },
                    ["optspec"] = new Dictionary<string, object?>
                    {
                        ["ops"] = "`$LIST`",
                        ["sleep"] = "`$FUNCTION`",
                    },
                    ["strict"] = false,
                    ["transport"] = "none",
                },
                ["telemetry"] = new Dictionary<string, object?>
                {
                    ["options"] = new Dictionary<string, object?>
                    {
                        ["active"] = false,
                    },
                    ["optspec"] = new Dictionary<string, object?>
                    {
                        ["exporter"] = "`$FUNCTION`",
                        ["headers"] = "`$MAP`",
                        ["idgen"] = "`$FUNCTION`",
                        ["now"] = "`$FUNCTION`",
                    },
                    ["strict"] = false,
                    ["transport"] = "none",
                },
                ["test"] = new Dictionary<string, object?>
                {
                    ["options"] = new Dictionary<string, object?>
                    {
                        ["active"] = false,
                    },
                    ["optspec"] = new Dictionary<string, object?>
                    {
                        ["entity"] = "`$MAP`",
                        ["net"] = "`$MAP`",
                    },
                    ["strict"] = false,
                    ["transport"] = "base",
                },
                ["timeout"] = new Dictionary<string, object?>
                {
                    ["options"] = new Dictionary<string, object?>
                    {
                        ["active"] = false,
                        ["ms"] = 30000,
                    },
                    ["optspec"] = new Dictionary<string, object?>
                    {
                        ["clearTimer"] = "`$FUNCTION`",
                        ["now"] = "`$FUNCTION`",
                        ["setTimer"] = "`$FUNCTION`",
                    },
                    ["strict"] = false,
                    ["transport"] = "wrap",
                },
                ["validate"] = new Dictionary<string, object?>
                {
                    ["options"] = new Dictionary<string, object?>
                    {
                        ["active"] = false,
                        ["mode"] = "throw",
                        ["request"] = true,
                        ["response"] = false,
                        ["strict"] = false,
                    },
                    ["optspec"] = new Dictionary<string, object?>
                    {
                        ["mode"] = new List<object?>
                        {
                            "`$ONE`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "throw",
                            },
                            new List<object?>
                            {
                                "`$EXACT`",
                                "report",
                            },
                        },
                        ["onInvalid"] = "`$FUNCTION`",
                    },
                    ["strict"] = false,
                    ["transport"] = "none",
                },
            },
            ["options"] = new Dictionary<string, object?>
            {
                ["base"] = "https://api.smsapi.com",
                ["auth"] = new Dictionary<string, object?>
                {
                    ["prefix"] = "Bearer",
                },
                ["headers"] = new Dictionary<string, object?>
                {
                    ["content-type"] = "application/json",
                },
                ["entity"] = new Dictionary<string, object?>
                {
                    ["available"] = new Dictionary<string, object?>(),
                    ["blacklist"] = new Dictionary<string, object?>(),
                    ["callback"] = new Dictionary<string, object?>(),
                    ["contact"] = new Dictionary<string, object?>(),
                    ["contacts_field"] = new Dictionary<string, object?>(),
                    ["contacts_field_option"] = new Dictionary<string, object?>(),
                    ["contactsgroup"] = new Dictionary<string, object?>(),
                    ["contactstrash"] = new Dictionary<string, object?>(),
                    ["field_available"] = new Dictionary<string, object?>(),
                    ["group"] = new Dictionary<string, object?>(),
                    ["mfa_code"] = new Dictionary<string, object?>(),
                    ["opt_out"] = new Dictionary<string, object?>(),
                    ["opt_out_setting"] = new Dictionary<string, object?>(),
                    ["permission"] = new Dictionary<string, object?>(),
                    ["ping"] = new Dictionary<string, object?>(),
                    ["profile"] = new Dictionary<string, object?>(),
                    ["rcs"] = new Dictionary<string, object?>(),
                    ["sendername"] = new Dictionary<string, object?>(),
                    ["sendername_statement"] = new Dictionary<string, object?>(),
                    ["sent_rcs_message"] = new Dictionary<string, object?>(),
                    ["shipment_country_volume"] = new Dictionary<string, object?>(),
                    ["short_url"] = new Dictionary<string, object?>(),
                    ["smsdo"] = new Dictionary<string, object?>(),
                    ["smssendername"] = new Dictionary<string, object?>(),
                    ["smstemplate"] = new Dictionary<string, object?>(),
                    ["subuser"] = new Dictionary<string, object?>(),
                    ["template"] = new Dictionary<string, object?>(),
                    ["user_rcs_sender_collection"] = new Dictionary<string, object?>(),
                },
            },
            ["entity"] = new Dictionary<string, object?>
            {
                ["available"] = new Dictionary<string, object?>
                {
                    ["fields"] = new List<object?>
                    {
                        new Dictionary<string, object?>
                        {
                            ["name"] = "name",
                            ["title"] = "Name",
                            ["type"] = "`$STRING`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "normalize",
                            ["title"] = "Normalize",
                            ["type"] = "`$BOOLEAN`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "template",
                            ["title"] = "Template",
                            ["type"] = "`$STRING`",
                        },
                    },
                    ["name"] = "available",
                    ["op"] = new Dictionary<string, object?>
                    {
                        ["list"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "list",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "GET",
                                    ["orig"] = "/sms/templates/available",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "sms",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "templates",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "available",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "sms",
                                        "templates",
                                        "available",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body.collection`",
                                    },
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["select"] = new Dictionary<string, object?>(),
                                    ["response"] = new Dictionary<string, object?>
                                    {
                                        ["kind"] = "json",
                                        ["media"] = "application/json",
                                    },
                                },
                            },
                        },
                    },
                    ["relations"] = new Dictionary<string, object?>
                    {
                        ["ancestors"] = new List<object?>(),
                    },
                },
                ["blacklist"] = new Dictionary<string, object?>
                {
                    ["fields"] = new List<object?>
                    {
                        new Dictionary<string, object?>
                        {
                            ["name"] = "id",
                            ["title"] = "Id",
                            ["type"] = "`$STRING`",
                        },
                    },
                    ["id"] = new Dictionary<string, object?>
                    {
                        ["field"] = "id",
                        ["name"] = "id",
                    },
                    ["name"] = "blacklist",
                    ["op"] = new Dictionary<string, object?>
                    {
                        ["create"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "create",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "POST",
                                    ["orig"] = "/blacklist/phone_numbers",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "blacklist",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "phone_numbers",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "blacklist",
                                        "phone_numbers",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["$action"] = "phone_number",
                                    },
                                    ["body"] = new Dictionary<string, object?>
                                    {
                                        ["alternatives"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["fields"] = new List<object?>
                                                {
                                                    new Dictionary<string, object?>
                                                    {
                                                        ["name"] = "expire_at",
                                                    },
                                                    new Dictionary<string, object?>
                                                    {
                                                        ["name"] = "phone_number",
                                                    },
                                                },
                                                ["kind"] = "form",
                                                ["media"] = "application/x-www-form-urlencoded",
                                            },
                                        },
                                        ["kind"] = "json",
                                        ["media"] = "application/json",
                                    },
                                    ["response"] = new Dictionary<string, object?>
                                    {
                                        ["kind"] = "json",
                                        ["media"] = "application/json",
                                    },
                                },
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "POST",
                                    ["orig"] = "/blacklist/phone_numbers/imports",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "blacklist",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "phone_numbers",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "imports",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "blacklist",
                                        "phone_numbers",
                                        "imports",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["select"] = new Dictionary<string, object?>(),
                                    ["body"] = new Dictionary<string, object?>
                                    {
                                        ["alternatives"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["kind"] = "raw",
                                                ["media"] = "text/csv",
                                            },
                                        },
                                        ["fields"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "import",
                                            },
                                        },
                                        ["kind"] = "multipart",
                                        ["media"] = "multipart/form-data",
                                    },
                                },
                            },
                        },
                        ["load"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "load",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "GET",
                                    ["orig"] = "/blacklist/phone_numbers",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "blacklist",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "phone_numbers",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "blacklist",
                                        "phone_numbers",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["header"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "accept",
                                                ["orig"] = "Accept",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "header",
                                                ["example"] = "application/json",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "x_async",
                                                ["orig"] = "x-async",
                                                ["type"] = "`$BOOLEAN`",
                                                ["kind"] = "header",
                                                ["example"] = false,
                                            },
                                        },
                                        ["query"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "limit",
                                                ["orig"] = "limit",
                                                ["type"] = "`$INTEGER`",
                                                ["kind"] = "query",
                                                ["example"] = 5,
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "offset",
                                                ["orig"] = "offset",
                                                ["type"] = "`$INTEGER`",
                                                ["kind"] = "query",
                                                ["example"] = 0,
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "q",
                                                ["orig"] = "q",
                                                ["type"] = "`$INTEGER`",
                                                ["kind"] = "query",
                                                ["example"] = 0,
                                            },
                                        },
                                    },
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["$action"] = "phone_number",
                                    },
                                    ["response"] = new Dictionary<string, object?>
                                    {
                                        ["alternatives"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["kind"] = "raw",
                                                ["media"] = "text/csv",
                                            },
                                        },
                                        ["kind"] = "json",
                                        ["media"] = "application/json",
                                    },
                                },
                            },
                        },
                        ["remove"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "remove",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "DELETE",
                                    ["orig"] = "/blacklist/phone_numbers/{id}",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "blacklist",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "phone_numbers",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["var"] = "id",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "blacklist",
                                        "phone_numbers",
                                        "{id}",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["params"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "id",
                                                ["orig"] = "id",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "param",
                                                ["reqd"] = true,
                                                ["example"] = "0f0f0f0f0f0f0f0f0f0f0f0f",
                                            },
                                        },
                                    },
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["exist"] = new List<object?>
                                        {
                                            "id",
                                        },
                                    },
                                },
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "DELETE",
                                    ["orig"] = "/blacklist/phone_numbers",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "blacklist",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "phone_numbers",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "blacklist",
                                        "phone_numbers",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["query"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "phone_number",
                                                ["orig"] = "phone_number",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "query",
                                            },
                                        },
                                    },
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["$action"] = "phone_number",
                                    },
                                },
                            },
                        },
                    },
                    ["relations"] = new Dictionary<string, object?>
                    {
                        ["ancestors"] = new List<object?>(),
                    },
                },
                ["callback"] = new Dictionary<string, object?>
                {
                    ["fields"] = new List<object?>
                    {
                        new Dictionary<string, object?>
                        {
                            ["name"] = "active",
                            ["title"] = "Active",
                            ["type"] = "`$BOOLEAN`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "api_version",
                            ["title"] = "Api Version",
                            ["type"] = "`$INTEGER`",
                            ["short"] = "Version of the callback output format.",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "id",
                            ["title"] = "Id",
                            ["type"] = "`$STRING`",
                            ["short"] = "Object ID",
                            ["format"] = "oid",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "invalid",
                            ["title"] = "Invalid",
                            ["type"] = "`$BOOLEAN`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "receiver",
                            ["title"] = "Receiver",
                            ["type"] = "`$OBJECT`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "receiver_type",
                            ["title"] = "Receiver Type",
                            ["type"] = "`$STRING`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "type",
                            ["title"] = "Type",
                            ["type"] = "`$STRING`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "url",
                            ["title"] = "Url",
                            ["type"] = "`$STRING`",
                            ["op"] = new Dictionary<string, object?>
                            {
                                ["update"] = new Dictionary<string, object?>
                                {
                                    ["req"] = true,
                                    ["type"] = "`$STRING`",
                                },
                            },
                            ["short"] = "WHATWG URL compliant",
                            ["format"] = "url",
                        },
                    },
                    ["id"] = new Dictionary<string, object?>
                    {
                        ["field"] = "id",
                        ["name"] = "id",
                    },
                    ["name"] = "callback",
                    ["op"] = new Dictionary<string, object?>
                    {
                        ["create"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "create",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "POST",
                                    ["orig"] = "/callbacks",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "callbacks",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "callbacks",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["select"] = new Dictionary<string, object?>(),
                                    ["response"] = new Dictionary<string, object?>
                                    {
                                        ["kind"] = "json",
                                        ["media"] = "application/json",
                                    },
                                },
                            },
                        },
                        ["list"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "list",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "GET",
                                    ["orig"] = "/callbacks",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "callbacks",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "callbacks",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body.collection`",
                                    },
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["select"] = new Dictionary<string, object?>(),
                                    ["response"] = new Dictionary<string, object?>
                                    {
                                        ["kind"] = "json",
                                        ["media"] = "application/json",
                                    },
                                },
                            },
                        },
                        ["load"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "load",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "GET",
                                    ["orig"] = "/callbacks/{id}",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "callbacks",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["var"] = "id",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "callbacks",
                                        "{id}",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["params"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "id",
                                                ["orig"] = "id",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "param",
                                                ["reqd"] = true,
                                                ["example"] = "0f0f0f0f0f0f0f0f0f0f0f0f",
                                            },
                                        },
                                    },
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["exist"] = new List<object?>
                                        {
                                            "id",
                                        },
                                    },
                                    ["response"] = new Dictionary<string, object?>
                                    {
                                        ["kind"] = "json",
                                        ["media"] = "application/json",
                                    },
                                },
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "GET",
                                    ["orig"] = "/callbacks/{id}/commands/test",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "callbacks",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["var"] = "id",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "commands",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "test",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "callbacks",
                                        "{id}",
                                        "commands",
                                        "test",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["params"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "id",
                                                ["orig"] = "id",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "param",
                                                ["reqd"] = true,
                                                ["example"] = "0f0f0f0f0f0f0f0f0f0f0f0f",
                                            },
                                        },
                                    },
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["$action"] = "command_test",
                                        ["exist"] = new List<object?>
                                        {
                                            "id",
                                        },
                                    },
                                    ["response"] = new Dictionary<string, object?>
                                    {
                                        ["kind"] = "json",
                                        ["media"] = "application/json",
                                    },
                                },
                            },
                        },
                        ["remove"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "remove",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "DELETE",
                                    ["orig"] = "/callbacks/{id}",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "callbacks",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["var"] = "id",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "callbacks",
                                        "{id}",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["params"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "id",
                                                ["orig"] = "id",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "param",
                                                ["reqd"] = true,
                                                ["example"] = "0f0f0f0f0f0f0f0f0f0f0f0f",
                                            },
                                        },
                                    },
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["exist"] = new List<object?>
                                        {
                                            "id",
                                        },
                                    },
                                },
                            },
                        },
                        ["update"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "update",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "PUT",
                                    ["orig"] = "/callbacks/{id}",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "callbacks",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["var"] = "id",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "callbacks",
                                        "{id}",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["params"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "id",
                                                ["orig"] = "id",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "param",
                                                ["reqd"] = true,
                                                ["example"] = "0f0f0f0f0f0f0f0f0f0f0f0f",
                                            },
                                        },
                                    },
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["exist"] = new List<object?>
                                        {
                                            "id",
                                        },
                                    },
                                    ["response"] = new Dictionary<string, object?>
                                    {
                                        ["kind"] = "json",
                                        ["media"] = "application/json",
                                    },
                                },
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "PUT",
                                    ["orig"] = "/callbacks/{id}/commands/activate",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "callbacks",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["var"] = "id",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "commands",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "activate",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "callbacks",
                                        "{id}",
                                        "commands",
                                        "activate",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["params"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "id",
                                                ["orig"] = "id",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "param",
                                                ["reqd"] = true,
                                                ["example"] = "0f0f0f0f0f0f0f0f0f0f0f0f",
                                            },
                                        },
                                    },
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["$action"] = "command_activate",
                                        ["exist"] = new List<object?>
                                        {
                                            "id",
                                        },
                                    },
                                },
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "PUT",
                                    ["orig"] = "/callbacks/{id}/commands/deactivate",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "callbacks",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["var"] = "id",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "commands",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "deactivate",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "callbacks",
                                        "{id}",
                                        "commands",
                                        "deactivate",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["params"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "id",
                                                ["orig"] = "id",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "param",
                                                ["reqd"] = true,
                                                ["example"] = "0f0f0f0f0f0f0f0f0f0f0f0f",
                                            },
                                        },
                                    },
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["$action"] = "command_deactivate",
                                        ["exist"] = new List<object?>
                                        {
                                            "id",
                                        },
                                    },
                                },
                            },
                        },
                    },
                    ["relations"] = new Dictionary<string, object?>
                    {
                        ["ancestors"] = new List<object?>(),
                    },
                },
                ["contact"] = new Dictionary<string, object?>
                {
                    ["fields"] = new List<object?>
                    {
                        new Dictionary<string, object?>
                        {
                            ["name"] = "birthday_date",
                            ["title"] = "Birthday Date",
                            ["type"] = "`$STRING`",
                            ["format"] = "date",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "city",
                            ["title"] = "City",
                            ["type"] = "`$STRING`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "collection",
                            ["title"] = "Collection",
                            ["type"] = "`$ARRAY`",
                            ["req"] = true,
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "contact_expire_after",
                            ["title"] = "Contact Expire After",
                            ["type"] = "`$INTEGER`",
                            ["req"] = true,
                            ["short"] = "Contact expire after days",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "contacts_count",
                            ["title"] = "Contacts Count",
                            ["type"] = "`$INTEGER`",
                            ["req"] = true,
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "country",
                            ["title"] = "Country",
                            ["type"] = "`$STRING`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "created_by",
                            ["title"] = "Created By",
                            ["type"] = "`$STRING`",
                            ["req"] = true,
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "date_created",
                            ["title"] = "Date Created",
                            ["type"] = "`$STRING`",
                            ["req"] = true,
                            ["format"] = "date-time",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "date_updated",
                            ["title"] = "Date Updated",
                            ["type"] = "`$STRING`",
                            ["req"] = true,
                            ["format"] = "date-time",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "description",
                            ["title"] = "Description",
                            ["type"] = "`$STRING`",
                            ["op"] = new Dictionary<string, object?>
                            {
                                ["load"] = new Dictionary<string, object?>
                                {
                                    ["req"] = true,
                                    ["type"] = "`$STRING`",
                                },
                            },
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "email",
                            ["title"] = "Email",
                            ["type"] = "`$STRING`",
                            ["format"] = "email",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "first_name",
                            ["title"] = "First Name",
                            ["type"] = "`$STRING`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "gender",
                            ["title"] = "Gender",
                            ["type"] = "`$STRING`",
                            ["req"] = true,
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "groups",
                            ["title"] = "Groups",
                            ["type"] = "`$ARRAY`",
                            ["req"] = true,
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "id",
                            ["title"] = "Id",
                            ["type"] = "`$STRING`",
                            ["req"] = true,
                            ["short"] = "Object ID",
                            ["format"] = "oid",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "idx",
                            ["title"] = "Idx",
                            ["type"] = "`$STRING`",
                            ["short"] = "User provided resource id",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "last_name",
                            ["title"] = "Last Name",
                            ["type"] = "`$STRING`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "name",
                            ["title"] = "Name",
                            ["type"] = "`$STRING`",
                            ["req"] = true,
                            ["short"] = "Group name",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "permissions",
                            ["title"] = "Permissions",
                            ["type"] = "`$ARRAY`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "phone_number",
                            ["title"] = "Phone Number",
                            ["type"] = "`$STRING`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "size",
                            ["title"] = "Size",
                            ["type"] = "`$INTEGER`",
                            ["req"] = true,
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "source",
                            ["title"] = "Source",
                            ["type"] = "`$STRING`",
                        },
                    },
                    ["id"] = new Dictionary<string, object?>
                    {
                        ["field"] = "id",
                        ["name"] = "id",
                    },
                    ["name"] = "contact",
                    ["op"] = new Dictionary<string, object?>
                    {
                        ["create"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "create",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "POST",
                                    ["orig"] = "/contacts/{contactId}/groups",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "contacts",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["var"] = "id",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "groups",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "contacts",
                                        "{id}",
                                        "groups",
                                    },
                                    ["rename"] = new Dictionary<string, object?>
                                    {
                                        ["param"] = new Dictionary<string, object?>
                                        {
                                            ["contactId"] = "id",
                                        },
                                    },
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["params"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "id",
                                                ["orig"] = "contactId",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "param",
                                                ["reqd"] = true,
                                                ["example"] = "0f0f0f0f0f0f0f0f0f0f0f0f",
                                            },
                                        },
                                    },
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["$action"] = "group",
                                        ["exist"] = new List<object?>
                                        {
                                            "id",
                                        },
                                    },
                                    ["body"] = new Dictionary<string, object?>
                                    {
                                        ["kind"] = "form",
                                        ["media"] = "application/x-www-form-urlencoded",
                                    },
                                    ["response"] = new Dictionary<string, object?>
                                    {
                                        ["kind"] = "json",
                                        ["media"] = "application/json",
                                    },
                                },
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "POST",
                                    ["orig"] = "/contacts",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "contacts",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "contacts",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["select"] = new Dictionary<string, object?>(),
                                    ["body"] = new Dictionary<string, object?>
                                    {
                                        ["fields"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "birthday_date",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "browser",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "city",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "country",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "description",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "device",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "email",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "first_name",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "gender",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "idx",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "last_name",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "operating_system",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "phone_number",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "source",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "undelivered_messages",
                                            },
                                        },
                                        ["kind"] = "form",
                                        ["media"] = "application/x-www-form-urlencoded",
                                    },
                                    ["response"] = new Dictionary<string, object?>
                                    {
                                        ["kind"] = "json",
                                        ["media"] = "application/json",
                                    },
                                },
                            },
                        },
                        ["list"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "list",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "GET",
                                    ["orig"] = "/contacts/{contactId}/groups",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "contacts",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["var"] = "id",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "groups",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "contacts",
                                        "{id}",
                                        "groups",
                                    },
                                    ["rename"] = new Dictionary<string, object?>
                                    {
                                        ["param"] = new Dictionary<string, object?>
                                        {
                                            ["contactId"] = "id",
                                        },
                                    },
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body.collection`",
                                    },
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["params"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "id",
                                                ["orig"] = "contactId",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "param",
                                                ["reqd"] = true,
                                                ["example"] = "0f0f0f0f0f0f0f0f0f0f0f0f",
                                            },
                                        },
                                    },
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["$action"] = "group",
                                        ["exist"] = new List<object?>
                                        {
                                            "id",
                                        },
                                    },
                                    ["response"] = new Dictionary<string, object?>
                                    {
                                        ["kind"] = "json",
                                        ["media"] = "application/json",
                                    },
                                },
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "GET",
                                    ["orig"] = "/contacts",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "contacts",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "contacts",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body.collection`",
                                    },
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["query"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "birthday_date",
                                                ["orig"] = "birthday_date",
                                                ["type"] = "`$ARRAY`",
                                                ["kind"] = "query",
                                                ["example"] = "2022-06-24",
                                                ["field"] = true,
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "email",
                                                ["orig"] = "email",
                                                ["type"] = "`$ARRAY`",
                                                ["kind"] = "query",
                                                ["field"] = true,
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "first_name",
                                                ["orig"] = "first_name",
                                                ["type"] = "`$ARRAY`",
                                                ["kind"] = "query",
                                                ["field"] = true,
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "gender",
                                                ["orig"] = "gender",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "query",
                                                ["field"] = true,
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "group_id",
                                                ["orig"] = "group_id",
                                                ["type"] = "`$ARRAY`",
                                                ["kind"] = "query",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "last_name",
                                                ["orig"] = "last_name",
                                                ["type"] = "`$ARRAY`",
                                                ["kind"] = "query",
                                                ["field"] = true,
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "limit",
                                                ["orig"] = "limit",
                                                ["type"] = "`$INTEGER`",
                                                ["kind"] = "query",
                                                ["example"] = 5,
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "offset",
                                                ["orig"] = "offset",
                                                ["type"] = "`$INTEGER`",
                                                ["kind"] = "query",
                                                ["example"] = 0,
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "order_by",
                                                ["orig"] = "order_by",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "query",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "phone_number",
                                                ["orig"] = "phone_number",
                                                ["type"] = "`$ARRAY`",
                                                ["kind"] = "query",
                                                ["field"] = true,
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "q",
                                                ["orig"] = "q",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "query",
                                            },
                                        },
                                    },
                                    ["select"] = new Dictionary<string, object?>(),
                                    ["response"] = new Dictionary<string, object?>
                                    {
                                        ["kind"] = "json",
                                        ["media"] = "application/json",
                                    },
                                },
                            },
                        },
                        ["load"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "load",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "GET",
                                    ["orig"] = "/contacts/groups/{groupId}/members/{contactId}",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "contacts",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "groups",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["var"] = "group_id",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "members",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["var"] = "contact_id",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "contacts",
                                        "groups",
                                        "{group_id}",
                                        "members",
                                        "{contact_id}",
                                    },
                                    ["rename"] = new Dictionary<string, object?>
                                    {
                                        ["param"] = new Dictionary<string, object?>
                                        {
                                            ["contactId"] = "contact_id",
                                            ["groupId"] = "group_id",
                                        },
                                    },
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["params"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "contact_id",
                                                ["orig"] = "contactId",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "param",
                                                ["reqd"] = true,
                                                ["example"] = "0f0f0f0f0f0f0f0f0f0f0f0f",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "group_id",
                                                ["orig"] = "groupId",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "param",
                                                ["reqd"] = true,
                                                ["example"] = "0f0f0f0f0f0f0f0f0f0f0f0f",
                                            },
                                        },
                                    },
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["exist"] = new List<object?>
                                        {
                                            "contact_id",
                                            "group_id",
                                        },
                                    },
                                    ["response"] = new Dictionary<string, object?>
                                    {
                                        ["kind"] = "json",
                                        ["media"] = "application/json",
                                    },
                                },
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "GET",
                                    ["orig"] = "/contacts/{contactId}/groups/{groupId}",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "contacts",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["var"] = "id",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "groups",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["var"] = "group_id",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "contacts",
                                        "{id}",
                                        "groups",
                                        "{group_id}",
                                    },
                                    ["rename"] = new Dictionary<string, object?>
                                    {
                                        ["param"] = new Dictionary<string, object?>
                                        {
                                            ["contactId"] = "id",
                                            ["groupId"] = "group_id",
                                        },
                                    },
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["params"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "group_id",
                                                ["orig"] = "groupId",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "param",
                                                ["reqd"] = true,
                                                ["example"] = "0f0f0f0f0f0f0f0f0f0f0f0f",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "id",
                                                ["orig"] = "contactId",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "param",
                                                ["reqd"] = true,
                                                ["example"] = "0f0f0f0f0f0f0f0f0f0f0f0f",
                                            },
                                        },
                                    },
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["exist"] = new List<object?>
                                        {
                                            "group_id",
                                            "id",
                                        },
                                    },
                                    ["response"] = new Dictionary<string, object?>
                                    {
                                        ["kind"] = "json",
                                        ["media"] = "application/json",
                                    },
                                },
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "GET",
                                    ["orig"] = "/contacts/{contactId}",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "contacts",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["var"] = "id",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "contacts",
                                        "{id}",
                                    },
                                    ["rename"] = new Dictionary<string, object?>
                                    {
                                        ["param"] = new Dictionary<string, object?>
                                        {
                                            ["contactId"] = "id",
                                        },
                                    },
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["params"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "id",
                                                ["orig"] = "contactId",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "param",
                                                ["reqd"] = true,
                                                ["example"] = "0f0f0f0f0f0f0f0f0f0f0f0f",
                                            },
                                        },
                                    },
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["exist"] = new List<object?>
                                        {
                                            "id",
                                        },
                                    },
                                    ["response"] = new Dictionary<string, object?>
                                    {
                                        ["kind"] = "json",
                                        ["media"] = "application/json",
                                    },
                                },
                            },
                        },
                        ["remove"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "remove",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "DELETE",
                                    ["orig"] = "/contacts/{contactId}/groups/{groupId}",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "contacts",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["var"] = "id",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "groups",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["var"] = "group_id",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "contacts",
                                        "{id}",
                                        "groups",
                                        "{group_id}",
                                    },
                                    ["rename"] = new Dictionary<string, object?>
                                    {
                                        ["param"] = new Dictionary<string, object?>
                                        {
                                            ["contactId"] = "id",
                                            ["groupId"] = "group_id",
                                        },
                                    },
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["params"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "group_id",
                                                ["orig"] = "groupId",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "param",
                                                ["reqd"] = true,
                                                ["example"] = "0f0f0f0f0f0f0f0f0f0f0f0f",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "id",
                                                ["orig"] = "contactId",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "param",
                                                ["reqd"] = true,
                                                ["example"] = "0f0f0f0f0f0f0f0f0f0f0f0f",
                                            },
                                        },
                                    },
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["exist"] = new List<object?>
                                        {
                                            "group_id",
                                            "id",
                                        },
                                    },
                                },
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "DELETE",
                                    ["orig"] = "/contacts/{contactId}",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "contacts",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["var"] = "id",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "contacts",
                                        "{id}",
                                    },
                                    ["rename"] = new Dictionary<string, object?>
                                    {
                                        ["param"] = new Dictionary<string, object?>
                                        {
                                            ["contactId"] = "id",
                                        },
                                    },
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["params"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "id",
                                                ["orig"] = "contactId",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "param",
                                                ["reqd"] = true,
                                                ["example"] = "0f0f0f0f0f0f0f0f0f0f0f0f",
                                            },
                                        },
                                    },
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["exist"] = new List<object?>
                                        {
                                            "id",
                                        },
                                    },
                                },
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "DELETE",
                                    ["orig"] = "/contacts",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "contacts",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "contacts",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["select"] = new Dictionary<string, object?>(),
                                },
                            },
                        },
                        ["update"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "update",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "PUT",
                                    ["orig"] = "/contacts/groups/{groupId}/members/{contactId}",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "contacts",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "groups",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["var"] = "group_id",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "members",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["var"] = "contact_id",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "contacts",
                                        "groups",
                                        "{group_id}",
                                        "members",
                                        "{contact_id}",
                                    },
                                    ["rename"] = new Dictionary<string, object?>
                                    {
                                        ["param"] = new Dictionary<string, object?>
                                        {
                                            ["contactId"] = "contact_id",
                                            ["groupId"] = "group_id",
                                        },
                                    },
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["params"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "contact_id",
                                                ["orig"] = "contactId",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "param",
                                                ["reqd"] = true,
                                                ["example"] = "0f0f0f0f0f0f0f0f0f0f0f0f",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "group_id",
                                                ["orig"] = "groupId",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "param",
                                                ["reqd"] = true,
                                                ["example"] = "0f0f0f0f0f0f0f0f0f0f0f0f",
                                            },
                                        },
                                    },
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["exist"] = new List<object?>
                                        {
                                            "contact_id",
                                            "group_id",
                                        },
                                    },
                                    ["response"] = new Dictionary<string, object?>
                                    {
                                        ["kind"] = "json",
                                        ["media"] = "application/json",
                                    },
                                },
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "PUT",
                                    ["orig"] = "/contacts/{contactId}/groups/{groupId}",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "contacts",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["var"] = "id",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "groups",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["var"] = "group_id",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "contacts",
                                        "{id}",
                                        "groups",
                                        "{group_id}",
                                    },
                                    ["rename"] = new Dictionary<string, object?>
                                    {
                                        ["param"] = new Dictionary<string, object?>
                                        {
                                            ["contactId"] = "id",
                                            ["groupId"] = "group_id",
                                        },
                                    },
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["params"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "group_id",
                                                ["orig"] = "groupId",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "param",
                                                ["reqd"] = true,
                                                ["example"] = "0f0f0f0f0f0f0f0f0f0f0f0f",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "id",
                                                ["orig"] = "contactId",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "param",
                                                ["reqd"] = true,
                                                ["example"] = "0f0f0f0f0f0f0f0f0f0f0f0f",
                                            },
                                        },
                                    },
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["exist"] = new List<object?>
                                        {
                                            "group_id",
                                            "id",
                                        },
                                    },
                                    ["response"] = new Dictionary<string, object?>
                                    {
                                        ["kind"] = "json",
                                        ["media"] = "application/json",
                                    },
                                },
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "PUT",
                                    ["orig"] = "/contacts/{contactId}",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "contacts",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["var"] = "id",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "contacts",
                                        "{id}",
                                    },
                                    ["rename"] = new Dictionary<string, object?>
                                    {
                                        ["param"] = new Dictionary<string, object?>
                                        {
                                            ["contactId"] = "id",
                                        },
                                    },
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["params"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "id",
                                                ["orig"] = "contactId",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "param",
                                                ["reqd"] = true,
                                                ["example"] = "0f0f0f0f0f0f0f0f0f0f0f0f",
                                            },
                                        },
                                    },
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["exist"] = new List<object?>
                                        {
                                            "id",
                                        },
                                    },
                                    ["body"] = new Dictionary<string, object?>
                                    {
                                        ["fields"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "birthday_date",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "city",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "description",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "email",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "first_name",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "gender",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "last_name",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "phone_number",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "source",
                                            },
                                        },
                                        ["kind"] = "form",
                                        ["media"] = "application/x-www-form-urlencoded",
                                    },
                                    ["response"] = new Dictionary<string, object?>
                                    {
                                        ["kind"] = "json",
                                        ["media"] = "application/json",
                                    },
                                },
                            },
                        },
                    },
                    ["relations"] = new Dictionary<string, object?>
                    {
                        ["ancestors"] = new List<object?>
                        {
                            new List<object?>
                            {
                                "$.main.kit.entity.group",
                            },
                            new List<object?>
                            {
                                "$.main.kit.entity.group",
                            },
                        },
                    },
                },
                ["contacts_field"] = new Dictionary<string, object?>
                {
                    ["fields"] = new List<object?>
                    {
                        new Dictionary<string, object?>
                        {
                            ["name"] = "id",
                            ["title"] = "Id",
                            ["type"] = "`$STRING`",
                            ["short"] = "Object ID",
                            ["format"] = "oid",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "name",
                            ["title"] = "Name",
                            ["type"] = "`$STRING`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "type",
                            ["title"] = "Type",
                            ["type"] = "`$STRING`",
                        },
                    },
                    ["id"] = new Dictionary<string, object?>
                    {
                        ["field"] = "id",
                        ["name"] = "id",
                    },
                    ["name"] = "contacts_field",
                    ["op"] = new Dictionary<string, object?>
                    {
                        ["create"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "create",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "POST",
                                    ["orig"] = "/contacts/fields",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "contacts",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "fields",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "contacts",
                                        "fields",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["select"] = new Dictionary<string, object?>(),
                                    ["body"] = new Dictionary<string, object?>
                                    {
                                        ["fields"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "name",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "type",
                                            },
                                        },
                                        ["kind"] = "form",
                                        ["media"] = "application/x-www-form-urlencoded",
                                    },
                                    ["response"] = new Dictionary<string, object?>
                                    {
                                        ["kind"] = "json",
                                        ["media"] = "application/json",
                                    },
                                },
                            },
                        },
                        ["list"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "list",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "GET",
                                    ["orig"] = "/contacts/fields",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "contacts",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "fields",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "contacts",
                                        "fields",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body.collection`",
                                    },
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["select"] = new Dictionary<string, object?>(),
                                    ["response"] = new Dictionary<string, object?>
                                    {
                                        ["kind"] = "json",
                                        ["media"] = "application/json",
                                    },
                                },
                            },
                        },
                        ["remove"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "remove",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "DELETE",
                                    ["orig"] = "/contacts/fields/{fieldId}",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "contacts",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "fields",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["var"] = "id",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "contacts",
                                        "fields",
                                        "{id}",
                                    },
                                    ["rename"] = new Dictionary<string, object?>
                                    {
                                        ["param"] = new Dictionary<string, object?>
                                        {
                                            ["fieldId"] = "id",
                                        },
                                    },
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["params"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "id",
                                                ["orig"] = "fieldId",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "param",
                                                ["reqd"] = true,
                                                ["example"] = "0f0f0f0f0f0f0f0f0f0f0f0f",
                                            },
                                        },
                                    },
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["exist"] = new List<object?>
                                        {
                                            "id",
                                        },
                                    },
                                },
                            },
                        },
                        ["update"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "update",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "PUT",
                                    ["orig"] = "/contacts/fields/{fieldId}",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "contacts",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "fields",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["var"] = "id",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "contacts",
                                        "fields",
                                        "{id}",
                                    },
                                    ["rename"] = new Dictionary<string, object?>
                                    {
                                        ["param"] = new Dictionary<string, object?>
                                        {
                                            ["fieldId"] = "id",
                                        },
                                    },
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["params"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "id",
                                                ["orig"] = "fieldId",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "param",
                                                ["reqd"] = true,
                                                ["example"] = "0f0f0f0f0f0f0f0f0f0f0f0f",
                                            },
                                        },
                                    },
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["exist"] = new List<object?>
                                        {
                                            "id",
                                        },
                                    },
                                    ["body"] = new Dictionary<string, object?>
                                    {
                                        ["fields"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "name",
                                            },
                                        },
                                        ["kind"] = "form",
                                        ["media"] = "application/x-www-form-urlencoded",
                                    },
                                    ["response"] = new Dictionary<string, object?>
                                    {
                                        ["kind"] = "json",
                                        ["media"] = "application/json",
                                    },
                                },
                            },
                        },
                    },
                    ["relations"] = new Dictionary<string, object?>
                    {
                        ["ancestors"] = new List<object?>(),
                    },
                },
                ["contacts_field_option"] = new Dictionary<string, object?>
                {
                    ["fields"] = new List<object?>(),
                    ["name"] = "contacts_field_option",
                    ["op"] = new Dictionary<string, object?>
                    {
                        ["list"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "list",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "GET",
                                    ["orig"] = "/contacts/fields/{fieldId}/options",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "contacts",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "fields",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["var"] = "field_id",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "options",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "contacts",
                                        "fields",
                                        "{field_id}",
                                        "options",
                                    },
                                    ["rename"] = new Dictionary<string, object?>
                                    {
                                        ["param"] = new Dictionary<string, object?>
                                        {
                                            ["fieldId"] = "field_id",
                                        },
                                    },
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body.collection`",
                                    },
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["params"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "field_id",
                                                ["orig"] = "fieldId",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "param",
                                                ["reqd"] = true,
                                                ["example"] = "0f0f0f0f0f0f0f0f0f0f0f0f",
                                            },
                                        },
                                    },
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["exist"] = new List<object?>
                                        {
                                            "field_id",
                                        },
                                    },
                                    ["response"] = new Dictionary<string, object?>
                                    {
                                        ["kind"] = "json",
                                        ["media"] = "application/json",
                                    },
                                },
                            },
                        },
                    },
                    ["relations"] = new Dictionary<string, object?>
                    {
                        ["ancestors"] = new List<object?>(),
                    },
                },
                ["contactsgroup"] = new Dictionary<string, object?>
                {
                    ["fields"] = new List<object?>
                    {
                        new Dictionary<string, object?>
                        {
                            ["name"] = "group_id",
                            ["title"] = "Group Id",
                            ["type"] = "`$STRING`",
                            ["req"] = true,
                            ["short"] = "Object ID",
                            ["format"] = "oid",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "read",
                            ["title"] = "Read",
                            ["type"] = "`$BOOLEAN`",
                            ["req"] = true,
                            ["short"] = "Has read permission",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "send",
                            ["title"] = "Send",
                            ["type"] = "`$BOOLEAN`",
                            ["req"] = true,
                            ["short"] = "Has send permission",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "username",
                            ["title"] = "Username",
                            ["type"] = "`$STRING`",
                            ["req"] = true,
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "write",
                            ["title"] = "Write",
                            ["type"] = "`$BOOLEAN`",
                            ["req"] = true,
                            ["short"] = "Has write permission",
                        },
                    },
                    ["name"] = "contactsgroup",
                    ["op"] = new Dictionary<string, object?>
                    {
                        ["create"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "create",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "POST",
                                    ["orig"] = "/contacts/groups/{groupId}/members",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "contacts",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "groups",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["var"] = "group_id",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "members",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "contacts",
                                        "groups",
                                        "{group_id}",
                                        "members",
                                    },
                                    ["rename"] = new Dictionary<string, object?>
                                    {
                                        ["param"] = new Dictionary<string, object?>
                                        {
                                            ["groupId"] = "group_id",
                                        },
                                    },
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["params"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "group_id",
                                                ["orig"] = "groupId",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "param",
                                                ["reqd"] = true,
                                                ["example"] = "0f0f0f0f0f0f0f0f0f0f0f0f",
                                            },
                                        },
                                    },
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["exist"] = new List<object?>
                                        {
                                            "group_id",
                                        },
                                    },
                                    ["body"] = new Dictionary<string, object?>
                                    {
                                        ["fields"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["list"] = true,
                                                ["name"] = "birthday_date",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["list"] = true,
                                                ["name"] = "email",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["list"] = true,
                                                ["name"] = "first_name",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "gender",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["list"] = true,
                                                ["name"] = "group_id",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["list"] = true,
                                                ["name"] = "last_name",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["list"] = true,
                                                ["name"] = "phone_number",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "q",
                                            },
                                        },
                                        ["kind"] = "form",
                                        ["media"] = "application/x-www-form-urlencoded",
                                    },
                                },
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "POST",
                                    ["orig"] = "/contacts/groups",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "contacts",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "groups",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "contacts",
                                        "groups",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["select"] = new Dictionary<string, object?>(),
                                    ["body"] = new Dictionary<string, object?>
                                    {
                                        ["fields"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "contact_expire_after",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "description",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "idx",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "name",
                                            },
                                        },
                                        ["kind"] = "form",
                                        ["media"] = "application/x-www-form-urlencoded",
                                    },
                                    ["response"] = new Dictionary<string, object?>
                                    {
                                        ["kind"] = "json",
                                        ["media"] = "application/json",
                                    },
                                },
                            },
                        },
                        ["list"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "list",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "GET",
                                    ["orig"] = "/contacts/groups/{groupId}/permissions",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "contacts",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "groups",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["var"] = "group_id",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "permissions",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "contacts",
                                        "groups",
                                        "{group_id}",
                                        "permissions",
                                    },
                                    ["rename"] = new Dictionary<string, object?>
                                    {
                                        ["param"] = new Dictionary<string, object?>
                                        {
                                            ["groupId"] = "group_id",
                                        },
                                    },
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body.collection`",
                                    },
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["params"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "group_id",
                                                ["orig"] = "groupId",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "param",
                                                ["reqd"] = true,
                                                ["example"] = "0f0f0f0f0f0f0f0f0f0f0f0f",
                                            },
                                        },
                                    },
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["exist"] = new List<object?>
                                        {
                                            "group_id",
                                        },
                                    },
                                    ["response"] = new Dictionary<string, object?>
                                    {
                                        ["kind"] = "json",
                                        ["media"] = "application/json",
                                    },
                                },
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "GET",
                                    ["orig"] = "/contacts/groups",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "contacts",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "groups",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "contacts",
                                        "groups",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body.collection`",
                                    },
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["query"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "name",
                                                ["orig"] = "name",
                                                ["type"] = "`$OBJECT`",
                                                ["kind"] = "query",
                                                ["example"] = "{\"name\" : \"group name\"}",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "with",
                                                ["orig"] = "with",
                                                ["type"] = "`$ARRAY`",
                                                ["kind"] = "query",
                                            },
                                        },
                                    },
                                    ["select"] = new Dictionary<string, object?>(),
                                    ["response"] = new Dictionary<string, object?>
                                    {
                                        ["kind"] = "json",
                                        ["media"] = "application/json",
                                    },
                                },
                            },
                        },
                        ["remove"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "remove",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "DELETE",
                                    ["orig"] = "/contacts/groups/{groupId}/members/{contactId}",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "contacts",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "groups",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["var"] = "group_id",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "members",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["var"] = "contact_id",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "contacts",
                                        "groups",
                                        "{group_id}",
                                        "members",
                                        "{contact_id}",
                                    },
                                    ["rename"] = new Dictionary<string, object?>
                                    {
                                        ["param"] = new Dictionary<string, object?>
                                        {
                                            ["contactId"] = "contact_id",
                                            ["groupId"] = "group_id",
                                        },
                                    },
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["params"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "contact_id",
                                                ["orig"] = "contactId",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "param",
                                                ["reqd"] = true,
                                                ["example"] = "0f0f0f0f0f0f0f0f0f0f0f0f",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "group_id",
                                                ["orig"] = "groupId",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "param",
                                                ["reqd"] = true,
                                                ["example"] = "0f0f0f0f0f0f0f0f0f0f0f0f",
                                            },
                                        },
                                    },
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["exist"] = new List<object?>
                                        {
                                            "contact_id",
                                            "group_id",
                                        },
                                    },
                                },
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "DELETE",
                                    ["orig"] = "/contacts/groups/{groupId}/permissions/{username}",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "contacts",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "groups",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["var"] = "group_id",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "permissions",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["var"] = "username",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "contacts",
                                        "groups",
                                        "{group_id}",
                                        "permissions",
                                        "{username}",
                                    },
                                    ["rename"] = new Dictionary<string, object?>
                                    {
                                        ["param"] = new Dictionary<string, object?>
                                        {
                                            ["groupId"] = "group_id",
                                        },
                                    },
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["params"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "group_id",
                                                ["orig"] = "groupId",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "param",
                                                ["reqd"] = true,
                                                ["example"] = "0f0f0f0f0f0f0f0f0f0f0f0f",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "username",
                                                ["orig"] = "username",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "param",
                                                ["reqd"] = true,
                                                ["example"] = "example_username",
                                            },
                                        },
                                    },
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["exist"] = new List<object?>
                                        {
                                            "group_id",
                                            "username",
                                        },
                                    },
                                },
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "DELETE",
                                    ["orig"] = "/contacts/groups/{groupId}",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "contacts",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "groups",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["var"] = "group_id",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "contacts",
                                        "groups",
                                        "{group_id}",
                                    },
                                    ["rename"] = new Dictionary<string, object?>
                                    {
                                        ["param"] = new Dictionary<string, object?>
                                        {
                                            ["groupId"] = "group_id",
                                        },
                                    },
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["params"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "group_id",
                                                ["orig"] = "groupId",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "param",
                                                ["reqd"] = true,
                                                ["example"] = "0f0f0f0f0f0f0f0f0f0f0f0f",
                                            },
                                        },
                                    },
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["exist"] = new List<object?>
                                        {
                                            "group_id",
                                        },
                                    },
                                    ["body"] = new Dictionary<string, object?>
                                    {
                                        ["fields"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "delete_contacts",
                                            },
                                        },
                                        ["kind"] = "form",
                                        ["media"] = "application/x-www-form-urlencoded",
                                    },
                                },
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "DELETE",
                                    ["orig"] = "/contacts/groups/{groupId}/members",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "contacts",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "groups",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["var"] = "group_id",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "members",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "contacts",
                                        "groups",
                                        "{group_id}",
                                        "members",
                                    },
                                    ["rename"] = new Dictionary<string, object?>
                                    {
                                        ["param"] = new Dictionary<string, object?>
                                        {
                                            ["groupId"] = "group_id",
                                        },
                                    },
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["params"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "group_id",
                                                ["orig"] = "groupId",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "param",
                                                ["reqd"] = true,
                                                ["example"] = "0f0f0f0f0f0f0f0f0f0f0f0f",
                                            },
                                        },
                                    },
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["exist"] = new List<object?>
                                        {
                                            "group_id",
                                        },
                                    },
                                    ["body"] = new Dictionary<string, object?>
                                    {
                                        ["fields"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["list"] = true,
                                                ["name"] = "birthday_date",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["list"] = true,
                                                ["name"] = "email",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["list"] = true,
                                                ["name"] = "first_name",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "gender",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["list"] = true,
                                                ["name"] = "group_id",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["list"] = true,
                                                ["name"] = "last_name",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["list"] = true,
                                                ["name"] = "phone_number",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "q",
                                            },
                                        },
                                        ["kind"] = "form",
                                        ["media"] = "application/x-www-form-urlencoded",
                                    },
                                },
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "DELETE",
                                    ["orig"] = "/contacts/groups",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "contacts",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "groups",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "contacts",
                                        "groups",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["select"] = new Dictionary<string, object?>(),
                                },
                            },
                        },
                        ["update"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "update",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "PUT",
                                    ["orig"] = "/contacts/groups/{groupId}/permissions/{username}",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "contacts",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "groups",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["var"] = "group_id",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "permissions",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["var"] = "username",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "contacts",
                                        "groups",
                                        "{group_id}",
                                        "permissions",
                                        "{username}",
                                    },
                                    ["rename"] = new Dictionary<string, object?>
                                    {
                                        ["param"] = new Dictionary<string, object?>
                                        {
                                            ["groupId"] = "group_id",
                                        },
                                    },
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["params"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "group_id",
                                                ["orig"] = "groupId",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "param",
                                                ["reqd"] = true,
                                                ["example"] = "0f0f0f0f0f0f0f0f0f0f0f0f",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "username",
                                                ["orig"] = "username",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "param",
                                                ["reqd"] = true,
                                                ["example"] = "example_username",
                                            },
                                        },
                                    },
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["exist"] = new List<object?>
                                        {
                                            "group_id",
                                            "username",
                                        },
                                    },
                                    ["body"] = new Dictionary<string, object?>
                                    {
                                        ["fields"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "read",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "send",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "write",
                                            },
                                        },
                                        ["kind"] = "form",
                                        ["media"] = "application/x-www-form-urlencoded",
                                    },
                                    ["response"] = new Dictionary<string, object?>
                                    {
                                        ["kind"] = "json",
                                        ["media"] = "application/json",
                                    },
                                },
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "PUT",
                                    ["orig"] = "/contacts/groups/{groupId}/members",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "contacts",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "groups",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["var"] = "group_id",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "members",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "contacts",
                                        "groups",
                                        "{group_id}",
                                        "members",
                                    },
                                    ["rename"] = new Dictionary<string, object?>
                                    {
                                        ["param"] = new Dictionary<string, object?>
                                        {
                                            ["groupId"] = "group_id",
                                        },
                                    },
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["params"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "group_id",
                                                ["orig"] = "groupId",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "param",
                                                ["reqd"] = true,
                                                ["example"] = "0f0f0f0f0f0f0f0f0f0f0f0f",
                                            },
                                        },
                                    },
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["exist"] = new List<object?>
                                        {
                                            "group_id",
                                        },
                                    },
                                    ["body"] = new Dictionary<string, object?>
                                    {
                                        ["fields"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["list"] = true,
                                                ["name"] = "birthday_date",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["list"] = true,
                                                ["name"] = "email",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["list"] = true,
                                                ["name"] = "first_name",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "gender",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["list"] = true,
                                                ["name"] = "group_id",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["list"] = true,
                                                ["name"] = "last_name",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["list"] = true,
                                                ["name"] = "phone_number",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "q",
                                            },
                                        },
                                        ["kind"] = "form",
                                        ["media"] = "application/x-www-form-urlencoded",
                                    },
                                },
                            },
                        },
                    },
                    ["relations"] = new Dictionary<string, object?>
                    {
                        ["ancestors"] = new List<object?>
                        {
                            new List<object?>
                            {
                                "$.main.kit.entity.group",
                            },
                            new List<object?>
                            {
                                "$.main.kit.entity.group",
                            },
                            new List<object?>
                            {
                                "$.main.kit.entity.group",
                                "$.main.kit.entity.permission",
                            },
                        },
                    },
                },
                ["contactstrash"] = new Dictionary<string, object?>
                {
                    ["fields"] = new List<object?>(),
                    ["name"] = "contactstrash",
                    ["op"] = new Dictionary<string, object?>
                    {
                        ["remove"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "remove",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "DELETE",
                                    ["orig"] = "/contacts/trash",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "contacts",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "trash",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "contacts",
                                        "trash",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["select"] = new Dictionary<string, object?>(),
                                },
                            },
                        },
                        ["update"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "update",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "PUT",
                                    ["orig"] = "/contacts/trash/restore",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "contacts",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "trash",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "restore",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "contacts",
                                        "trash",
                                        "restore",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["select"] = new Dictionary<string, object?>(),
                                },
                            },
                        },
                    },
                    ["relations"] = new Dictionary<string, object?>
                    {
                        ["ancestors"] = new List<object?>(),
                    },
                },
                ["field_available"] = new Dictionary<string, object?>
                {
                    ["fields"] = new List<object?>
                    {
                        new Dictionary<string, object?>
                        {
                            ["name"] = "built_in",
                            ["title"] = "Built In",
                            ["type"] = "`$BOOLEAN`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "id",
                            ["title"] = "Id",
                            ["type"] = "`$STRING`",
                            ["short"] = "Object ID",
                            ["format"] = "oid",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "name",
                            ["title"] = "Name",
                            ["type"] = "`$STRING`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "options",
                            ["title"] = "Options",
                            ["type"] = "`$ARRAY`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "type",
                            ["title"] = "Type",
                            ["type"] = "`$STRING`",
                        },
                    },
                    ["id"] = new Dictionary<string, object?>
                    {
                        ["field"] = "id",
                        ["name"] = "id",
                    },
                    ["name"] = "field_available",
                    ["op"] = new Dictionary<string, object?>
                    {
                        ["list"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "list",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "GET",
                                    ["orig"] = "/contacts/fields/available",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "contacts",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "fields",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "available",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "contacts",
                                        "fields",
                                        "available",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["select"] = new Dictionary<string, object?>(),
                                    ["response"] = new Dictionary<string, object?>
                                    {
                                        ["kind"] = "json",
                                        ["media"] = "application/json",
                                    },
                                },
                            },
                        },
                    },
                    ["relations"] = new Dictionary<string, object?>
                    {
                        ["ancestors"] = new List<object?>(),
                    },
                },
                ["group"] = new Dictionary<string, object?>
                {
                    ["fields"] = new List<object?>
                    {
                        new Dictionary<string, object?>
                        {
                            ["name"] = "contact_expire_after",
                            ["title"] = "Contact Expire After",
                            ["type"] = "`$INTEGER`",
                            ["req"] = true,
                            ["short"] = "Contact expire after days",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "contacts_count",
                            ["title"] = "Contacts Count",
                            ["type"] = "`$INTEGER`",
                            ["req"] = true,
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "created_by",
                            ["title"] = "Created By",
                            ["type"] = "`$STRING`",
                            ["req"] = true,
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "date_created",
                            ["title"] = "Date Created",
                            ["type"] = "`$STRING`",
                            ["req"] = true,
                            ["format"] = "date-time",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "date_updated",
                            ["title"] = "Date Updated",
                            ["type"] = "`$STRING`",
                            ["req"] = true,
                            ["format"] = "date-time",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "description",
                            ["title"] = "Description",
                            ["type"] = "`$STRING`",
                            ["req"] = true,
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "id",
                            ["title"] = "Id",
                            ["type"] = "`$STRING`",
                            ["req"] = true,
                            ["short"] = "Object ID",
                            ["format"] = "oid",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "idx",
                            ["title"] = "Idx",
                            ["type"] = "`$STRING`",
                            ["short"] = "User provided resource id",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "name",
                            ["title"] = "Name",
                            ["type"] = "`$STRING`",
                            ["req"] = true,
                            ["short"] = "Group name",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "permissions",
                            ["title"] = "Permissions",
                            ["type"] = "`$ARRAY`",
                        },
                    },
                    ["id"] = new Dictionary<string, object?>
                    {
                        ["field"] = "id",
                        ["name"] = "id",
                    },
                    ["name"] = "group",
                    ["op"] = new Dictionary<string, object?>
                    {
                        ["load"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "load",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "GET",
                                    ["orig"] = "/contacts/groups/{groupId}",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "contacts",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "groups",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["var"] = "id",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "contacts",
                                        "groups",
                                        "{id}",
                                    },
                                    ["rename"] = new Dictionary<string, object?>
                                    {
                                        ["param"] = new Dictionary<string, object?>
                                        {
                                            ["groupId"] = "id",
                                        },
                                    },
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["params"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "id",
                                                ["orig"] = "groupId",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "param",
                                                ["reqd"] = true,
                                                ["example"] = "0f0f0f0f0f0f0f0f0f0f0f0f",
                                            },
                                        },
                                    },
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["exist"] = new List<object?>
                                        {
                                            "id",
                                        },
                                    },
                                    ["response"] = new Dictionary<string, object?>
                                    {
                                        ["kind"] = "json",
                                        ["media"] = "application/json",
                                    },
                                },
                            },
                        },
                        ["update"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "update",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "PUT",
                                    ["orig"] = "/contacts/groups/{groupId}",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "contacts",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "groups",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["var"] = "id",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "contacts",
                                        "groups",
                                        "{id}",
                                    },
                                    ["rename"] = new Dictionary<string, object?>
                                    {
                                        ["param"] = new Dictionary<string, object?>
                                        {
                                            ["groupId"] = "id",
                                        },
                                    },
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["params"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "id",
                                                ["orig"] = "groupId",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "param",
                                                ["reqd"] = true,
                                                ["example"] = "0f0f0f0f0f0f0f0f0f0f0f0f",
                                            },
                                        },
                                    },
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["exist"] = new List<object?>
                                        {
                                            "id",
                                        },
                                    },
                                    ["body"] = new Dictionary<string, object?>
                                    {
                                        ["fields"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "contact_expire_after",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "description",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "idx",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "name",
                                            },
                                        },
                                        ["kind"] = "form",
                                        ["media"] = "application/x-www-form-urlencoded",
                                    },
                                    ["response"] = new Dictionary<string, object?>
                                    {
                                        ["kind"] = "json",
                                        ["media"] = "application/json",
                                    },
                                },
                            },
                        },
                    },
                    ["relations"] = new Dictionary<string, object?>
                    {
                        ["ancestors"] = new List<object?>(),
                    },
                },
                ["mfa_code"] = new Dictionary<string, object?>
                {
                    ["fields"] = new List<object?>
                    {
                        new Dictionary<string, object?>
                        {
                            ["name"] = "content",
                            ["title"] = "Content",
                            ["type"] = "`$STRING`",
                            ["short"] = "Custom content that must contain placeholder [%code%]",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "fast",
                            ["title"] = "Fast",
                            ["type"] = "`$ANY`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "from",
                            ["title"] = "From",
                            ["type"] = "`$STRING`",
                            ["short"] = "Sendername",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "phone_number",
                            ["title"] = "Phone Number",
                            ["type"] = "`$STRING`",
                            ["req"] = true,
                        },
                    },
                    ["name"] = "mfa_code",
                    ["op"] = new Dictionary<string, object?>
                    {
                        ["create"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "create",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "POST",
                                    ["orig"] = "/mfa/codes",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "mfa",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "codes",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "mfa",
                                        "codes",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["select"] = new Dictionary<string, object?>(),
                                    ["response"] = new Dictionary<string, object?>
                                    {
                                        ["kind"] = "json",
                                        ["media"] = "application/json",
                                    },
                                },
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "POST",
                                    ["orig"] = "/mfa/codes/verifications",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "mfa",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "codes",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "verifications",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "mfa",
                                        "codes",
                                        "verifications",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["$action"] = "verification",
                                    },
                                    ["body"] = new Dictionary<string, object?>
                                    {
                                        ["fields"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "code",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "phone_number",
                                            },
                                        },
                                        ["kind"] = "form",
                                        ["media"] = "application/x-www-form-urlencoded",
                                    },
                                },
                            },
                        },
                    },
                    ["relations"] = new Dictionary<string, object?>
                    {
                        ["ancestors"] = new List<object?>(),
                    },
                },
                ["opt_out"] = new Dictionary<string, object?>
                {
                    ["fields"] = new List<object?>
                    {
                        new Dictionary<string, object?>
                        {
                            ["name"] = "date",
                            ["title"] = "Date",
                            ["type"] = "`$STRING`",
                            ["format"] = "date-time",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "id",
                            ["title"] = "Id",
                            ["type"] = "`$STRING`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "links",
                            ["title"] = "Links",
                            ["type"] = "`$ARRAY`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "phoneNumber",
                            ["title"] = "Phone Number",
                            ["type"] = "`$INTEGER`",
                        },
                    },
                    ["id"] = new Dictionary<string, object?>
                    {
                        ["field"] = "id",
                        ["name"] = "id",
                    },
                    ["name"] = "opt_out",
                    ["op"] = new Dictionary<string, object?>
                    {
                        ["list"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "list",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "GET",
                                    ["orig"] = "/opt_outs",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "opt_outs",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "opt_outs",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body.collection`",
                                    },
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["header"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "accept",
                                                ["orig"] = "Accept",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "header",
                                                ["example"] = "application/json",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "x_async",
                                                ["orig"] = "x-async",
                                                ["type"] = "`$BOOLEAN`",
                                                ["kind"] = "header",
                                                ["example"] = false,
                                            },
                                        },
                                        ["query"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "limit",
                                                ["orig"] = "limit",
                                                ["type"] = "`$INTEGER`",
                                                ["kind"] = "query",
                                                ["example"] = 5,
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "offset",
                                                ["orig"] = "offset",
                                                ["type"] = "`$INTEGER`",
                                                ["kind"] = "query",
                                                ["example"] = 0,
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "phone_number",
                                                ["orig"] = "phone_number",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "query",
                                            },
                                        },
                                    },
                                    ["select"] = new Dictionary<string, object?>(),
                                    ["response"] = new Dictionary<string, object?>
                                    {
                                        ["alternatives"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["kind"] = "raw",
                                                ["media"] = "text/csv",
                                            },
                                        },
                                        ["kind"] = "json",
                                        ["media"] = "application/json",
                                    },
                                },
                            },
                        },
                        ["remove"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "remove",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "DELETE",
                                    ["orig"] = "/opt_outs/{optOutId}",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "opt_outs",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["var"] = "id",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "opt_outs",
                                        "{id}",
                                    },
                                    ["rename"] = new Dictionary<string, object?>
                                    {
                                        ["param"] = new Dictionary<string, object?>
                                        {
                                            ["optOutId"] = "id",
                                        },
                                    },
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["params"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "id",
                                                ["orig"] = "optOutId",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "param",
                                                ["reqd"] = true,
                                            },
                                        },
                                    },
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["exist"] = new List<object?>
                                        {
                                            "id",
                                        },
                                    },
                                },
                            },
                        },
                    },
                    ["relations"] = new Dictionary<string, object?>
                    {
                        ["ancestors"] = new List<object?>(),
                    },
                },
                ["opt_out_setting"] = new Dictionary<string, object?>
                {
                    ["fields"] = new List<object?>
                    {
                        new Dictionary<string, object?>
                        {
                            ["name"] = "brand",
                            ["title"] = "Brand",
                            ["type"] = "`$STRING`",
                        },
                    },
                    ["name"] = "opt_out_setting",
                    ["op"] = new Dictionary<string, object?>
                    {
                        ["load"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "load",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "GET",
                                    ["orig"] = "/opt_outs/settings",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "opt_outs",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "settings",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "opt_outs",
                                        "settings",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["select"] = new Dictionary<string, object?>(),
                                    ["response"] = new Dictionary<string, object?>
                                    {
                                        ["kind"] = "json",
                                        ["media"] = "application/json",
                                    },
                                },
                            },
                        },
                        ["update"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "update",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "PUT",
                                    ["orig"] = "/opt_outs/settings",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "opt_outs",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "settings",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "opt_outs",
                                        "settings",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["select"] = new Dictionary<string, object?>(),
                                    ["response"] = new Dictionary<string, object?>
                                    {
                                        ["kind"] = "json",
                                        ["media"] = "application/json",
                                    },
                                },
                            },
                        },
                    },
                    ["relations"] = new Dictionary<string, object?>
                    {
                        ["ancestors"] = new List<object?>(),
                    },
                },
                ["permission"] = new Dictionary<string, object?>
                {
                    ["fields"] = new List<object?>
                    {
                        new Dictionary<string, object?>
                        {
                            ["name"] = "group_id",
                            ["title"] = "Group Id",
                            ["type"] = "`$STRING`",
                            ["req"] = true,
                            ["short"] = "Object ID",
                            ["format"] = "oid",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "id",
                            ["title"] = "Id",
                            ["type"] = "`$STRING`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "read",
                            ["title"] = "Read",
                            ["type"] = "`$BOOLEAN`",
                            ["req"] = true,
                            ["short"] = "Has read permission",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "send",
                            ["title"] = "Send",
                            ["type"] = "`$BOOLEAN`",
                            ["req"] = true,
                            ["short"] = "Has send permission",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "username",
                            ["title"] = "Username",
                            ["type"] = "`$STRING`",
                            ["req"] = true,
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "write",
                            ["title"] = "Write",
                            ["type"] = "`$BOOLEAN`",
                            ["req"] = true,
                            ["short"] = "Has write permission",
                        },
                    },
                    ["id"] = new Dictionary<string, object?>
                    {
                        ["field"] = "id",
                        ["name"] = "id",
                    },
                    ["name"] = "permission",
                    ["op"] = new Dictionary<string, object?>
                    {
                        ["create"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "create",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "POST",
                                    ["orig"] = "/contacts/groups/{groupId}/permissions",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "contacts",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "groups",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["var"] = "group_id",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "permissions",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "contacts",
                                        "groups",
                                        "{group_id}",
                                        "permissions",
                                    },
                                    ["rename"] = new Dictionary<string, object?>
                                    {
                                        ["param"] = new Dictionary<string, object?>
                                        {
                                            ["groupId"] = "group_id",
                                        },
                                    },
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["params"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "group_id",
                                                ["orig"] = "groupId",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "param",
                                                ["reqd"] = true,
                                                ["example"] = "0f0f0f0f0f0f0f0f0f0f0f0f",
                                            },
                                        },
                                    },
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["exist"] = new List<object?>
                                        {
                                            "group_id",
                                        },
                                    },
                                    ["body"] = new Dictionary<string, object?>
                                    {
                                        ["fields"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "read",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "send",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "username",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "write",
                                            },
                                        },
                                        ["kind"] = "form",
                                        ["media"] = "application/x-www-form-urlencoded",
                                    },
                                    ["response"] = new Dictionary<string, object?>
                                    {
                                        ["kind"] = "json",
                                        ["media"] = "application/json",
                                    },
                                },
                            },
                        },
                        ["load"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "load",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "GET",
                                    ["orig"] = "/contacts/groups/{groupId}/permissions/{username}",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "contacts",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "groups",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["var"] = "group_id",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "permissions",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["var"] = "id",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "contacts",
                                        "groups",
                                        "{group_id}",
                                        "permissions",
                                        "{id}",
                                    },
                                    ["rename"] = new Dictionary<string, object?>
                                    {
                                        ["param"] = new Dictionary<string, object?>
                                        {
                                            ["groupId"] = "group_id",
                                            ["username"] = "id",
                                        },
                                    },
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["params"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "group_id",
                                                ["orig"] = "groupId",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "param",
                                                ["reqd"] = true,
                                                ["example"] = "0f0f0f0f0f0f0f0f0f0f0f0f",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "id",
                                                ["orig"] = "username",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "param",
                                                ["reqd"] = true,
                                                ["example"] = "example_username",
                                            },
                                        },
                                    },
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["exist"] = new List<object?>
                                        {
                                            "group_id",
                                            "id",
                                        },
                                    },
                                    ["response"] = new Dictionary<string, object?>
                                    {
                                        ["kind"] = "json",
                                        ["media"] = "application/json",
                                    },
                                },
                            },
                        },
                    },
                    ["relations"] = new Dictionary<string, object?>
                    {
                        ["ancestors"] = new List<object?>
                        {
                            new List<object?>
                            {
                                "$.main.kit.entity.group",
                            },
                        },
                    },
                },
                ["ping"] = new Dictionary<string, object?>
                {
                    ["fields"] = new List<object?>
                    {
                        new Dictionary<string, object?>
                        {
                            ["name"] = "authorized",
                            ["title"] = "Authorized",
                            ["type"] = "`$BOOLEAN`",
                            ["req"] = true,
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "unavailable",
                            ["title"] = "Unavailable",
                            ["type"] = "`$ARRAY`",
                            ["req"] = true,
                        },
                    },
                    ["name"] = "ping",
                    ["op"] = new Dictionary<string, object?>
                    {
                        ["list"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "list",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "GET",
                                    ["orig"] = "/ping",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "ping",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "ping",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body.unavailable`",
                                    },
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["select"] = new Dictionary<string, object?>(),
                                    ["response"] = new Dictionary<string, object?>
                                    {
                                        ["kind"] = "json",
                                        ["media"] = "application/json",
                                    },
                                },
                            },
                        },
                    },
                    ["relations"] = new Dictionary<string, object?>
                    {
                        ["ancestors"] = new List<object?>(),
                    },
                },
                ["profile"] = new Dictionary<string, object?>
                {
                    ["fields"] = new List<object?>
                    {
                        new Dictionary<string, object?>
                        {
                            ["name"] = "email",
                            ["title"] = "Email",
                            ["type"] = "`$STRING`",
                            ["req"] = true,
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "name",
                            ["title"] = "Name",
                            ["type"] = "`$STRING`",
                            ["req"] = true,
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "payment_type",
                            ["title"] = "Payment Type",
                            ["type"] = "`$STRING`",
                            ["req"] = true,
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "phone_number",
                            ["title"] = "Phone Number",
                            ["type"] = "`$INTEGER`",
                            ["req"] = true,
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "points",
                            ["title"] = "Points",
                            ["type"] = "`$NUMBER`",
                            ["format"] = "float",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "user_type",
                            ["title"] = "User Type",
                            ["type"] = "`$STRING`",
                            ["req"] = true,
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "username",
                            ["title"] = "Username",
                            ["type"] = "`$STRING`",
                            ["req"] = true,
                        },
                    },
                    ["name"] = "profile",
                    ["op"] = new Dictionary<string, object?>
                    {
                        ["list"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "list",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "GET",
                                    ["orig"] = "/profile/prices",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "profile",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "prices",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "profile",
                                        "prices",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body.collection`",
                                    },
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["query"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "type",
                                                ["orig"] = "type",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "query",
                                                ["example"] = "eco",
                                            },
                                        },
                                    },
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["$action"] = "price",
                                    },
                                    ["response"] = new Dictionary<string, object?>
                                    {
                                        ["kind"] = "json",
                                        ["media"] = "application/json",
                                    },
                                },
                            },
                        },
                        ["load"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "load",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "GET",
                                    ["orig"] = "/profile",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "profile",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "profile",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["select"] = new Dictionary<string, object?>(),
                                    ["response"] = new Dictionary<string, object?>
                                    {
                                        ["kind"] = "json",
                                        ["media"] = "application/json",
                                    },
                                },
                            },
                        },
                    },
                    ["relations"] = new Dictionary<string, object?>
                    {
                        ["ancestors"] = new List<object?>(),
                    },
                },
                ["rcs"] = new Dictionary<string, object?>
                {
                    ["fields"] = new List<object?>(),
                    ["name"] = "rcs",
                    ["op"] = new Dictionary<string, object?>
                    {
                        ["list"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "list",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "GET",
                                    ["orig"] = "/rcs/messages",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "rcs",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "messages",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "rcs",
                                        "messages",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body.collection`",
                                    },
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["$action"] = "message",
                                    },
                                    ["response"] = new Dictionary<string, object?>
                                    {
                                        ["kind"] = "json",
                                        ["media"] = "application/json",
                                    },
                                },
                            },
                        },
                    },
                    ["relations"] = new Dictionary<string, object?>
                    {
                        ["ancestors"] = new List<object?>(),
                    },
                },
                ["sendername"] = new Dictionary<string, object?>
                {
                    ["fields"] = new List<object?>
                    {
                        new Dictionary<string, object?>
                        {
                            ["name"] = "created_at",
                            ["title"] = "Created At",
                            ["type"] = "`$STRING`",
                            ["format"] = "date-time",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "id",
                            ["title"] = "Id",
                            ["type"] = "`$STRING`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "is_default",
                            ["title"] = "Is Default",
                            ["type"] = "`$BOOLEAN`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "sender",
                            ["title"] = "Sender",
                            ["type"] = "`$STRING`",
                            ["short"] = "Sendername",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "status",
                            ["title"] = "Status",
                            ["type"] = "`$STRING`",
                        },
                    },
                    ["id"] = new Dictionary<string, object?>
                    {
                        ["field"] = "id",
                        ["name"] = "id",
                    },
                    ["name"] = "sendername",
                    ["op"] = new Dictionary<string, object?>
                    {
                        ["create"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "create",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "POST",
                                    ["orig"] = "/sms/sendernames",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "sms",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "sendernames",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "sms",
                                        "sendernames",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["select"] = new Dictionary<string, object?>(),
                                    ["body"] = new Dictionary<string, object?>
                                    {
                                        ["fields"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "sender",
                                            },
                                        },
                                        ["kind"] = "form",
                                        ["media"] = "application/x-www-form-urlencoded",
                                    },
                                    ["response"] = new Dictionary<string, object?>
                                    {
                                        ["kind"] = "json",
                                        ["media"] = "application/json",
                                    },
                                },
                            },
                        },
                        ["list"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "list",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "GET",
                                    ["orig"] = "/sms/sendernames",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "sms",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "sendernames",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "sms",
                                        "sendernames",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body.collection`",
                                    },
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["select"] = new Dictionary<string, object?>(),
                                    ["response"] = new Dictionary<string, object?>
                                    {
                                        ["kind"] = "json",
                                        ["media"] = "application/json",
                                    },
                                },
                            },
                        },
                        ["load"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "load",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "GET",
                                    ["orig"] = "/sms/sendernames/{sender}",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "sms",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "sendernames",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["var"] = "id",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "sms",
                                        "sendernames",
                                        "{id}",
                                    },
                                    ["rename"] = new Dictionary<string, object?>
                                    {
                                        ["param"] = new Dictionary<string, object?>
                                        {
                                            ["sender"] = "id",
                                        },
                                    },
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["params"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "id",
                                                ["orig"] = "sender",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "param",
                                                ["reqd"] = true,
                                            },
                                        },
                                    },
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["exist"] = new List<object?>
                                        {
                                            "id",
                                        },
                                    },
                                    ["response"] = new Dictionary<string, object?>
                                    {
                                        ["kind"] = "json",
                                        ["media"] = "application/json",
                                    },
                                },
                            },
                        },
                    },
                    ["relations"] = new Dictionary<string, object?>
                    {
                        ["ancestors"] = new List<object?>(),
                    },
                },
                ["sendername_statement"] = new Dictionary<string, object?>
                {
                    ["fields"] = new List<object?>
                    {
                        new Dictionary<string, object?>
                        {
                            ["name"] = "content",
                            ["title"] = "Content",
                            ["type"] = "`$STRING`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "statements",
                            ["title"] = "Statements",
                            ["type"] = "`$ARRAY`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "title",
                            ["title"] = "Title",
                            ["type"] = "`$STRING`",
                        },
                    },
                    ["name"] = "sendername_statement",
                    ["op"] = new Dictionary<string, object?>
                    {
                        ["list"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "list",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "GET",
                                    ["orig"] = "/sms/sendernames/statement",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "sms",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "sendernames",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "statement",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "sms",
                                        "sendernames",
                                        "statement",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body.sections`",
                                    },
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["select"] = new Dictionary<string, object?>(),
                                    ["response"] = new Dictionary<string, object?>
                                    {
                                        ["kind"] = "json",
                                        ["media"] = "application/json",
                                    },
                                },
                            },
                        },
                    },
                    ["relations"] = new Dictionary<string, object?>
                    {
                        ["ancestors"] = new List<object?>(),
                    },
                },
                ["sent_rcs_message"] = new Dictionary<string, object?>
                {
                    ["fields"] = new List<object?>
                    {
                        new Dictionary<string, object?>
                        {
                            ["name"] = "content",
                            ["title"] = "Content",
                            ["type"] = "`$OBJECT`",
                            ["short"] = "RCS message content in RCS JSON format.",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "phone_number",
                            ["title"] = "Phone Number",
                            ["type"] = "`$STRING`",
                            ["req"] = true,
                            ["short"] = "Recipient phone number (e.g.",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "sender",
                            ["title"] = "Sender",
                            ["type"] = "`$STRING`",
                            ["req"] = true,
                            ["short"] = "RCS sender ID (object ID of the agent/sender the user has access to).",
                            ["format"] = "oid",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "text",
                            ["title"] = "Text",
                            ["type"] = "`$STRING`",
                            ["short"] = "Plain text message content.",
                        },
                    },
                    ["name"] = "sent_rcs_message",
                    ["op"] = new Dictionary<string, object?>
                    {
                        ["create"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "create",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "POST",
                                    ["orig"] = "/rcs/messages",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "rcs",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "messages",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "rcs",
                                        "messages",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["select"] = new Dictionary<string, object?>(),
                                    ["body"] = new Dictionary<string, object?>
                                    {
                                        ["alternatives"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["fields"] = new List<object?>
                                                {
                                                    new Dictionary<string, object?>
                                                    {
                                                        ["name"] = "content",
                                                    },
                                                    new Dictionary<string, object?>
                                                    {
                                                        ["name"] = "phone_number",
                                                    },
                                                    new Dictionary<string, object?>
                                                    {
                                                        ["name"] = "sender",
                                                    },
                                                    new Dictionary<string, object?>
                                                    {
                                                        ["name"] = "text",
                                                    },
                                                },
                                                ["kind"] = "form",
                                                ["media"] = "application/x-www-form-urlencoded",
                                            },
                                        },
                                        ["kind"] = "json",
                                        ["media"] = "application/json",
                                    },
                                    ["response"] = new Dictionary<string, object?>
                                    {
                                        ["kind"] = "json",
                                        ["media"] = "application/json",
                                    },
                                },
                            },
                        },
                    },
                    ["relations"] = new Dictionary<string, object?>
                    {
                        ["ancestors"] = new List<object?>(),
                    },
                },
                ["shipment_country_volume"] = new Dictionary<string, object?>
                {
                    ["fields"] = new List<object?>
                    {
                        new Dictionary<string, object?>
                        {
                            ["name"] = "country_code",
                            ["title"] = "Country Code",
                            ["type"] = "`$STRING`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "country_limit",
                            ["title"] = "Country Limit",
                            ["type"] = "`$INTEGER`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "country_name",
                            ["title"] = "Country Name",
                            ["type"] = "`$STRING`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "usage",
                            ["title"] = "Usage",
                            ["type"] = "`$INTEGER`",
                        },
                    },
                    ["name"] = "shipment_country_volume",
                    ["op"] = new Dictionary<string, object?>
                    {
                        ["list"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "list",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "GET",
                                    ["orig"] = "/shipment/country_volumes",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "shipment",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "country_volumes",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "shipment",
                                        "country_volumes",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body.collection`",
                                    },
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["header"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "accept",
                                                ["orig"] = "Accept",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "header",
                                                ["example"] = "application/json",
                                            },
                                        },
                                        ["query"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "month",
                                                ["orig"] = "month",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "query",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "year",
                                                ["orig"] = "year",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "query",
                                            },
                                        },
                                    },
                                    ["select"] = new Dictionary<string, object?>(),
                                    ["response"] = new Dictionary<string, object?>
                                    {
                                        ["alternatives"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["kind"] = "raw",
                                                ["media"] = "text/csv",
                                            },
                                        },
                                        ["kind"] = "json",
                                        ["media"] = "application/json",
                                    },
                                },
                            },
                        },
                    },
                    ["relations"] = new Dictionary<string, object?>
                    {
                        ["ancestors"] = new List<object?>(),
                    },
                },
                ["short_url"] = new Dictionary<string, object?>
                {
                    ["fields"] = new List<object?>
                    {
                        new Dictionary<string, object?>
                        {
                            ["name"] = "description",
                            ["title"] = "Description",
                            ["type"] = "`$STRING`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "expire",
                            ["title"] = "Expire",
                            ["type"] = "`$STRING`",
                            ["format"] = "date-time",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "filename",
                            ["title"] = "Filename",
                            ["type"] = "`$STRING`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "hits",
                            ["title"] = "Hits",
                            ["type"] = "`$INTEGER`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "hits_unique",
                            ["title"] = "Hits Unique",
                            ["type"] = "`$INTEGER`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "id",
                            ["title"] = "Id",
                            ["type"] = "`$STRING`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "name",
                            ["title"] = "Name",
                            ["type"] = "`$STRING`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "short_url",
                            ["title"] = "Short Url",
                            ["type"] = "`$STRING`",
                            ["short"] = "WHATWG URL compliant",
                            ["format"] = "url",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "type",
                            ["title"] = "Type",
                            ["type"] = "`$STRING`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "url",
                            ["title"] = "Url",
                            ["type"] = "`$STRING`",
                            ["short"] = "WHATWG URL compliant",
                            ["format"] = "url",
                        },
                    },
                    ["id"] = new Dictionary<string, object?>
                    {
                        ["field"] = "id",
                        ["name"] = "id",
                    },
                    ["name"] = "short_url",
                    ["op"] = new Dictionary<string, object?>
                    {
                        ["create"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "create",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "POST",
                                    ["orig"] = "/short_url/links",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "short_url",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "links",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "short_url",
                                        "links",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["$action"] = "link",
                                    },
                                    ["body"] = new Dictionary<string, object?>
                                    {
                                        ["alternatives"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["kind"] = "form",
                                                ["media"] = "application/x-www-form-urlencoded",
                                            },
                                        },
                                        ["kind"] = "json",
                                        ["media"] = "application/json",
                                    },
                                    ["response"] = new Dictionary<string, object?>
                                    {
                                        ["kind"] = "json",
                                        ["media"] = "application/json",
                                    },
                                },
                            },
                        },
                        ["list"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "list",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "GET",
                                    ["orig"] = "/short_url/links",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "short_url",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "links",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "short_url",
                                        "links",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body.collection`",
                                    },
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["$action"] = "link",
                                    },
                                    ["response"] = new Dictionary<string, object?>
                                    {
                                        ["kind"] = "json",
                                        ["media"] = "application/json",
                                    },
                                },
                            },
                        },
                        ["load"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "load",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "GET",
                                    ["orig"] = "/short_url/links/{id}",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "short_url",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "links",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["var"] = "id",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "short_url",
                                        "links",
                                        "{id}",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["params"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "id",
                                                ["orig"] = "id",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "param",
                                                ["reqd"] = true,
                                                ["example"] = "123",
                                            },
                                        },
                                    },
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["exist"] = new List<object?>
                                        {
                                            "id",
                                        },
                                    },
                                    ["response"] = new Dictionary<string, object?>
                                    {
                                        ["kind"] = "json",
                                        ["media"] = "application/json",
                                    },
                                },
                            },
                        },
                        ["remove"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "remove",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "DELETE",
                                    ["orig"] = "/short_url/links/{id}",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "short_url",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "links",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["var"] = "id",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "short_url",
                                        "links",
                                        "{id}",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["params"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "id",
                                                ["orig"] = "id",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "param",
                                                ["reqd"] = true,
                                                ["example"] = "123",
                                            },
                                        },
                                    },
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["exist"] = new List<object?>
                                        {
                                            "id",
                                        },
                                    },
                                },
                            },
                        },
                        ["update"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "update",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "PUT",
                                    ["orig"] = "/short_url/links/{id}",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "short_url",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "links",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["var"] = "id",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "short_url",
                                        "links",
                                        "{id}",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["params"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "id",
                                                ["orig"] = "id",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "param",
                                                ["reqd"] = true,
                                                ["example"] = "123",
                                            },
                                        },
                                    },
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["exist"] = new List<object?>
                                        {
                                            "id",
                                        },
                                    },
                                    ["body"] = new Dictionary<string, object?>
                                    {
                                        ["fields"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "description",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "name",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "url",
                                            },
                                        },
                                        ["kind"] = "form",
                                        ["media"] = "application/x-www-form-urlencoded",
                                    },
                                    ["response"] = new Dictionary<string, object?>
                                    {
                                        ["kind"] = "json",
                                        ["media"] = "application/json",
                                    },
                                },
                            },
                        },
                    },
                    ["relations"] = new Dictionary<string, object?>
                    {
                        ["ancestors"] = new List<object?>(),
                    },
                },
                ["smsdo"] = new Dictionary<string, object?>
                {
                    ["fields"] = new List<object?>
                    {
                        new Dictionary<string, object?>
                        {
                            ["name"] = "allow_duplicates",
                            ["title"] = "Allow Duplicates",
                            ["type"] = "`$INTEGER`",
                            ["short"] = "When parameter allow_duplicates is set to \"1\" allows to send message to duplicated numbers in one request (useful i.e.",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "check_idx",
                            ["title"] = "Check Idx",
                            ["type"] = "`$ANY`",
                            ["short"] = "When parameter check_idx is set to „1” prevents from sending more than one message with the same idx in last 24h.",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "date",
                            ["title"] = "Date",
                            ["type"] = "`$ANY`",
                            ["short"] = "Date in UNIX timestamp (&date=1287734110) or in ISO 8601 (&date=2012-05-10T08:40:27+00:00) when message will be sent (&date=1287734110).",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "date_validate",
                            ["title"] = "Date Validate",
                            ["type"] = "`$INTEGER`",
                            ["short"] = "When parameter date_validate is set to \"1\" checks if date if given in proper format.",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "details",
                            ["title"] = "Details",
                            ["type"] = "`$ANY`",
                            ["short"] = "When details parameter is set to \"1\" more details in response will be displayed (message length and sms count).",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "encoding",
                            ["title"] = "Encoding",
                            ["type"] = "`$STRING`",
                            ["short"] = "This parameter describes the encoding of the message text.",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "expiration_date",
                            ["title"] = "Expiration Date",
                            ["type"] = "`$ANY`",
                            ["short"] = "Message expiration date (in UNIX timestamp or in ISO 8601) is a date after which message won't be delivered if it wasn't delivered yet.",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "fallback",
                            ["title"] = "Fallback",
                            ["type"] = "`$ARRAY`",
                            ["short"] = "Enable fallback in case sms sending fails",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "fast",
                            ["title"] = "Fast",
                            ["type"] = "`$INTEGER`",
                            ["short"] = "Setting this parameter to „1” will result in sending message with the highest priority which ensures the quickest possible time of delivery.",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "flash",
                            ["title"] = "Flash",
                            ["type"] = "`$INTEGER`",
                            ["short"] = "Sending a message in flash mode can be activated by setting this parameter to \"1\".",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "format",
                            ["title"] = "Format",
                            ["type"] = "`$STRING`",
                            ["short"] = "Parameter &format=json causes, that response is sending in JSON format.",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "from",
                            ["title"] = "From",
                            ["type"] = "`$STRING`",
                            ["short"] = "Name of the sender.",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "group",
                            ["title"] = "Group",
                            ["type"] = "`$STRING`",
                            ["short"] = "Name of the group from the contacts database to which message should be sent to.",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "idx",
                            ["title"] = "Idx",
                            ["type"] = "`$STRING`",
                            ["short"] = "Optional custom value sent with SMS and sent back in CALLBACK.",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "max_parts",
                            ["title"] = "Max Parts",
                            ["type"] = "`$INTEGER`",
                            ["short"] = "Defines maximum message parts allowed, maximum value allowed is 6.",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "message",
                            ["title"] = "Message",
                            ["type"] = "`$STRING`",
                            ["short"] = "The message text.",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "normalize",
                            ["title"] = "Normalize",
                            ["type"] = "`$INTEGER`",
                            ["short"] = "When parameter normalize is set to „1” special chars in message will be replaced with their equivalents (ê-e, ñ-n, ý-y ...).",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "notify_url",
                            ["title"] = "Notify Url",
                            ["type"] = "`$STRING`",
                            ["short"] = "Parameter allows to set CALLBACK URL for message from request.",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "test",
                            ["title"] = "Test",
                            ["type"] = "`$ANY`",
                            ["short"] = "When parameter test is set to \"1\" message won't be sent but response will be displayed, there is no charge for such test messages.",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "time_restriction",
                            ["title"] = "Time Restriction",
                            ["type"] = "`$STRING`",
                            ["short"] = "Sets the behavior when you try to ship in hours / dates that do not match the settings in your account.",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "to",
                            ["title"] = "To",
                            ["type"] = "`$STRING`",
                            ["short"] = "Recipients' mobile phone numbers (i.e.",
                        },
                    },
                    ["name"] = "smsdo",
                    ["op"] = new Dictionary<string, object?>
                    {
                        ["create"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "create",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "POST",
                                    ["orig"] = "/sms.do",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "sms.do",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "sms.do",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["select"] = new Dictionary<string, object?>(),
                                    ["body"] = new Dictionary<string, object?>
                                    {
                                        ["alternatives"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["fields"] = new List<object?>
                                                {
                                                    new Dictionary<string, object?>
                                                    {
                                                        ["name"] = "allow_duplicates",
                                                    },
                                                    new Dictionary<string, object?>
                                                    {
                                                        ["name"] = "check_idx",
                                                    },
                                                    new Dictionary<string, object?>
                                                    {
                                                        ["name"] = "date",
                                                    },
                                                    new Dictionary<string, object?>
                                                    {
                                                        ["name"] = "date_validate",
                                                    },
                                                    new Dictionary<string, object?>
                                                    {
                                                        ["name"] = "details",
                                                    },
                                                    new Dictionary<string, object?>
                                                    {
                                                        ["name"] = "encoding",
                                                    },
                                                    new Dictionary<string, object?>
                                                    {
                                                        ["name"] = "expiration_date",
                                                    },
                                                    new Dictionary<string, object?>
                                                    {
                                                        ["list"] = true,
                                                        ["name"] = "fallback",
                                                    },
                                                    new Dictionary<string, object?>
                                                    {
                                                        ["name"] = "fast",
                                                    },
                                                    new Dictionary<string, object?>
                                                    {
                                                        ["name"] = "flash",
                                                    },
                                                    new Dictionary<string, object?>
                                                    {
                                                        ["name"] = "format",
                                                    },
                                                    new Dictionary<string, object?>
                                                    {
                                                        ["name"] = "from",
                                                    },
                                                    new Dictionary<string, object?>
                                                    {
                                                        ["name"] = "group",
                                                    },
                                                    new Dictionary<string, object?>
                                                    {
                                                        ["name"] = "idx",
                                                    },
                                                    new Dictionary<string, object?>
                                                    {
                                                        ["name"] = "max_parts",
                                                    },
                                                    new Dictionary<string, object?>
                                                    {
                                                        ["name"] = "message",
                                                    },
                                                    new Dictionary<string, object?>
                                                    {
                                                        ["name"] = "normalize",
                                                    },
                                                    new Dictionary<string, object?>
                                                    {
                                                        ["name"] = "notify_url",
                                                    },
                                                    new Dictionary<string, object?>
                                                    {
                                                        ["name"] = "test",
                                                    },
                                                    new Dictionary<string, object?>
                                                    {
                                                        ["name"] = "time_restriction",
                                                    },
                                                    new Dictionary<string, object?>
                                                    {
                                                        ["name"] = "to",
                                                    },
                                                },
                                                ["kind"] = "form",
                                                ["media"] = "application/x-www-form-urlencoded",
                                            },
                                        },
                                        ["kind"] = "json",
                                        ["media"] = "application/json",
                                    },
                                    ["response"] = new Dictionary<string, object?>
                                    {
                                        ["alternatives"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["kind"] = "raw",
                                                ["media"] = "text/plain",
                                            },
                                        },
                                        ["kind"] = "json",
                                        ["media"] = "application/json",
                                    },
                                },
                            },
                        },
                    },
                    ["relations"] = new Dictionary<string, object?>
                    {
                        ["ancestors"] = new List<object?>(),
                    },
                },
                ["smssendername"] = new Dictionary<string, object?>
                {
                    ["fields"] = new List<object?>(),
                    ["name"] = "smssendername",
                    ["op"] = new Dictionary<string, object?>
                    {
                        ["create"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "create",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "POST",
                                    ["orig"] = "/sms/sendernames/{sender}/commands/make_default",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "sms",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "sendernames",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["var"] = "sender",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "commands",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "make_default",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "sms",
                                        "sendernames",
                                        "{sender}",
                                        "commands",
                                        "make_default",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["params"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "sender",
                                                ["orig"] = "sender",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "param",
                                                ["reqd"] = true,
                                            },
                                        },
                                    },
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["exist"] = new List<object?>
                                        {
                                            "sender",
                                        },
                                    },
                                },
                            },
                        },
                        ["remove"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "remove",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "DELETE",
                                    ["orig"] = "/sms/sendernames/{sender}",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "sms",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "sendernames",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["var"] = "sender",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "sms",
                                        "sendernames",
                                        "{sender}",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["params"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "sender",
                                                ["orig"] = "sender",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "param",
                                                ["reqd"] = true,
                                            },
                                        },
                                    },
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["exist"] = new List<object?>
                                        {
                                            "sender",
                                        },
                                    },
                                },
                            },
                        },
                    },
                    ["relations"] = new Dictionary<string, object?>
                    {
                        ["ancestors"] = new List<object?>
                        {
                            new List<object?>
                            {
                                "$.main.kit.entity.sendername",
                            },
                        },
                    },
                },
                ["smstemplate"] = new Dictionary<string, object?>
                {
                    ["fields"] = new List<object?>
                    {
                        new Dictionary<string, object?>
                        {
                            ["name"] = "id",
                            ["title"] = "Id",
                            ["type"] = "`$STRING`",
                        },
                    },
                    ["id"] = new Dictionary<string, object?>
                    {
                        ["field"] = "id",
                        ["name"] = "id",
                    },
                    ["name"] = "smstemplate",
                    ["op"] = new Dictionary<string, object?>
                    {
                        ["remove"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "remove",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "DELETE",
                                    ["orig"] = "/sms/templates/{id}",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "sms",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "templates",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["var"] = "id",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "sms",
                                        "templates",
                                        "{id}",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["params"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "id",
                                                ["orig"] = "id",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "param",
                                                ["reqd"] = true,
                                            },
                                        },
                                    },
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["exist"] = new List<object?>
                                        {
                                            "id",
                                        },
                                    },
                                },
                            },
                        },
                    },
                    ["relations"] = new Dictionary<string, object?>
                    {
                        ["ancestors"] = new List<object?>(),
                    },
                },
                ["subuser"] = new Dictionary<string, object?>
                {
                    ["fields"] = new List<object?>
                    {
                        new Dictionary<string, object?>
                        {
                            ["name"] = "active",
                            ["title"] = "Active",
                            ["type"] = "`$BOOLEAN`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "credentials",
                            ["title"] = "Credentials",
                            ["type"] = "`$OBJECT`",
                            ["req"] = true,
                            ["op"] = new Dictionary<string, object?>
                            {
                                ["update"] = new Dictionary<string, object?>
                                {
                                    ["type"] = "`$OBJECT`",
                                },
                            },
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "description",
                            ["title"] = "Description",
                            ["type"] = "`$STRING`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "id",
                            ["title"] = "Id",
                            ["type"] = "`$STRING`",
                            ["short"] = "Object ID",
                            ["format"] = "oid",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "points",
                            ["title"] = "Points",
                            ["type"] = "`$OBJECT`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "username",
                            ["title"] = "Username",
                            ["type"] = "`$STRING`",
                        },
                    },
                    ["id"] = new Dictionary<string, object?>
                    {
                        ["field"] = "id",
                        ["name"] = "id",
                    },
                    ["name"] = "subuser",
                    ["op"] = new Dictionary<string, object?>
                    {
                        ["create"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "create",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "POST",
                                    ["orig"] = "/subusers",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "subusers",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "subusers",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["select"] = new Dictionary<string, object?>(),
                                    ["response"] = new Dictionary<string, object?>
                                    {
                                        ["kind"] = "json",
                                        ["media"] = "application/json",
                                    },
                                },
                            },
                        },
                        ["list"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "list",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "GET",
                                    ["orig"] = "/subusers/{id}/shares/sendernames",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "subusers",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["var"] = "id",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "shares",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "sendernames",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "subusers",
                                        "{id}",
                                        "shares",
                                        "sendernames",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body.senders`",
                                    },
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["params"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "id",
                                                ["orig"] = "id",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "param",
                                                ["reqd"] = true,
                                                ["example"] = "0f0f0f0f0f0f0f0f0f0f0f0f",
                                            },
                                        },
                                    },
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["$action"] = "share_sendername",
                                        ["exist"] = new List<object?>
                                        {
                                            "id",
                                        },
                                    },
                                    ["response"] = new Dictionary<string, object?>
                                    {
                                        ["kind"] = "json",
                                        ["media"] = "application/json",
                                    },
                                },
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "GET",
                                    ["orig"] = "/subusers/{id}/shares/templates",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "subusers",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["var"] = "id",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "shares",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "templates",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "subusers",
                                        "{id}",
                                        "shares",
                                        "templates",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body.templates`",
                                    },
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["params"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "id",
                                                ["orig"] = "id",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "param",
                                                ["reqd"] = true,
                                                ["example"] = "0f0f0f0f0f0f0f0f0f0f0f0f",
                                            },
                                        },
                                    },
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["$action"] = "share_template",
                                        ["exist"] = new List<object?>
                                        {
                                            "id",
                                        },
                                    },
                                    ["response"] = new Dictionary<string, object?>
                                    {
                                        ["kind"] = "json",
                                        ["media"] = "application/json",
                                    },
                                },
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "GET",
                                    ["orig"] = "/subusers",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "subusers",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "subusers",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body.collection`",
                                    },
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["query"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "q",
                                                ["orig"] = "q",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "query",
                                            },
                                        },
                                    },
                                    ["select"] = new Dictionary<string, object?>(),
                                    ["response"] = new Dictionary<string, object?>
                                    {
                                        ["kind"] = "json",
                                        ["media"] = "application/json",
                                    },
                                },
                            },
                        },
                        ["load"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "load",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "GET",
                                    ["orig"] = "/subusers/{id}",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "subusers",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["var"] = "id",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "subusers",
                                        "{id}",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["params"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "id",
                                                ["orig"] = "id",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "param",
                                                ["reqd"] = true,
                                                ["example"] = "0f0f0f0f0f0f0f0f0f0f0f0f",
                                            },
                                        },
                                    },
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["exist"] = new List<object?>
                                        {
                                            "id",
                                        },
                                    },
                                    ["response"] = new Dictionary<string, object?>
                                    {
                                        ["kind"] = "json",
                                        ["media"] = "application/json",
                                    },
                                },
                            },
                        },
                        ["remove"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "remove",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "DELETE",
                                    ["orig"] = "/subusers/{id}",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "subusers",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["var"] = "id",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "subusers",
                                        "{id}",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["params"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "id",
                                                ["orig"] = "id",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "param",
                                                ["reqd"] = true,
                                                ["example"] = "0f0f0f0f0f0f0f0f0f0f0f0f",
                                            },
                                        },
                                    },
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["exist"] = new List<object?>
                                        {
                                            "id",
                                        },
                                    },
                                },
                            },
                        },
                        ["update"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "update",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "PUT",
                                    ["orig"] = "/subusers/{id}",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "subusers",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["var"] = "id",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "subusers",
                                        "{id}",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["params"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "id",
                                                ["orig"] = "id",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "param",
                                                ["reqd"] = true,
                                                ["example"] = "0f0f0f0f0f0f0f0f0f0f0f0f",
                                            },
                                        },
                                    },
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["exist"] = new List<object?>
                                        {
                                            "id",
                                        },
                                    },
                                    ["response"] = new Dictionary<string, object?>
                                    {
                                        ["kind"] = "json",
                                        ["media"] = "application/json",
                                    },
                                },
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "PUT",
                                    ["orig"] = "/subusers/{id}/shares/sendernames",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "subusers",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["var"] = "id",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "shares",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "sendernames",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "subusers",
                                        "{id}",
                                        "shares",
                                        "sendernames",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["params"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "id",
                                                ["orig"] = "id",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "param",
                                                ["reqd"] = true,
                                                ["example"] = "0f0f0f0f0f0f0f0f0f0f0f0f",
                                            },
                                        },
                                    },
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["$action"] = "share_sendername",
                                        ["exist"] = new List<object?>
                                        {
                                            "id",
                                        },
                                    },
                                },
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "PUT",
                                    ["orig"] = "/subusers/{id}/shares/templates",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "subusers",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["var"] = "id",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "shares",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "templates",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "subusers",
                                        "{id}",
                                        "shares",
                                        "templates",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["params"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "id",
                                                ["orig"] = "id",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "param",
                                                ["reqd"] = true,
                                                ["example"] = "0f0f0f0f0f0f0f0f0f0f0f0f",
                                            },
                                        },
                                    },
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["$action"] = "share_template",
                                        ["exist"] = new List<object?>
                                        {
                                            "id",
                                        },
                                    },
                                },
                            },
                        },
                    },
                    ["relations"] = new Dictionary<string, object?>
                    {
                        ["ancestors"] = new List<object?>(),
                    },
                },
                ["template"] = new Dictionary<string, object?>
                {
                    ["fields"] = new List<object?>
                    {
                        new Dictionary<string, object?>
                        {
                            ["name"] = "id",
                            ["title"] = "Id",
                            ["type"] = "`$STRING`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "name",
                            ["title"] = "Name",
                            ["type"] = "`$STRING`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "normalize",
                            ["title"] = "Normalize",
                            ["type"] = "`$BOOLEAN`",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "template",
                            ["title"] = "Template",
                            ["type"] = "`$STRING`",
                        },
                    },
                    ["id"] = new Dictionary<string, object?>
                    {
                        ["field"] = "id",
                        ["name"] = "id",
                    },
                    ["name"] = "template",
                    ["op"] = new Dictionary<string, object?>
                    {
                        ["create"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "create",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "POST",
                                    ["orig"] = "/sms/templates",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "sms",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "templates",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "sms",
                                        "templates",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["select"] = new Dictionary<string, object?>(),
                                    ["body"] = new Dictionary<string, object?>
                                    {
                                        ["fields"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "name",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "normalize",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "template",
                                            },
                                        },
                                        ["kind"] = "form",
                                        ["media"] = "application/x-www-form-urlencoded",
                                    },
                                    ["response"] = new Dictionary<string, object?>
                                    {
                                        ["kind"] = "json",
                                        ["media"] = "application/json",
                                    },
                                },
                            },
                        },
                        ["list"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "list",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "GET",
                                    ["orig"] = "/sms/templates",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "sms",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "templates",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "sms",
                                        "templates",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body.collection`",
                                    },
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["select"] = new Dictionary<string, object?>(),
                                    ["response"] = new Dictionary<string, object?>
                                    {
                                        ["kind"] = "json",
                                        ["media"] = "application/json",
                                    },
                                },
                            },
                        },
                        ["load"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "load",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "GET",
                                    ["orig"] = "/sms/templates/{id}",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "sms",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "templates",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["var"] = "id",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "sms",
                                        "templates",
                                        "{id}",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["params"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "id",
                                                ["orig"] = "id",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "param",
                                                ["reqd"] = true,
                                            },
                                        },
                                    },
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["exist"] = new List<object?>
                                        {
                                            "id",
                                        },
                                    },
                                    ["response"] = new Dictionary<string, object?>
                                    {
                                        ["kind"] = "json",
                                        ["media"] = "application/json",
                                    },
                                },
                            },
                        },
                        ["update"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "update",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "PUT",
                                    ["orig"] = "/sms/templates/{id}",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "sms",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "templates",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["var"] = "id",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "sms",
                                        "templates",
                                        "{id}",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["params"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "id",
                                                ["orig"] = "id",
                                                ["type"] = "`$STRING`",
                                                ["kind"] = "param",
                                                ["reqd"] = true,
                                            },
                                        },
                                    },
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["exist"] = new List<object?>
                                        {
                                            "id",
                                        },
                                    },
                                    ["body"] = new Dictionary<string, object?>
                                    {
                                        ["fields"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "name",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "normalize",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["name"] = "template",
                                            },
                                        },
                                        ["kind"] = "form",
                                        ["media"] = "application/x-www-form-urlencoded",
                                    },
                                    ["response"] = new Dictionary<string, object?>
                                    {
                                        ["kind"] = "json",
                                        ["media"] = "application/json",
                                    },
                                },
                            },
                        },
                    },
                    ["relations"] = new Dictionary<string, object?>
                    {
                        ["ancestors"] = new List<object?>(),
                    },
                },
                ["user_rcs_sender_collection"] = new Dictionary<string, object?>
                {
                    ["fields"] = new List<object?>(),
                    ["name"] = "user_rcs_sender_collection",
                    ["op"] = new Dictionary<string, object?>
                    {
                        ["list"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "list",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "GET",
                                    ["orig"] = "/rcs/senders",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "rcs",
                                        },
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "senders",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "rcs",
                                        "senders",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body.collection`",
                                    },
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["select"] = new Dictionary<string, object?>(),
                                    ["response"] = new Dictionary<string, object?>
                                    {
                                        ["kind"] = "json",
                                        ["media"] = "application/json",
                                    },
                                },
                            },
                        },
                    },
                    ["relations"] = new Dictionary<string, object?>
                    {
                        ["ancestors"] = new List<object?>(),
                    },
                },
            },
        };
    }

    private static readonly Lazy<Dictionary<string, object?>> SharedConfigVal =
        new(MakeConfig);

    // The process-wide config, built once on first use.
    //
    // The returned dictionary is SHARED: treat it as read-only. Callers that
    // need to mutate should use MakeConfig, which always returns a fresh copy.
    public static Dictionary<string, object?> SharedConfig()
    {
        return SharedConfigVal.Value;
    }

    public static List<object?> FeaturePlugins(string name)
    {
        switch (name)
        {
            default:
                return new List<object?>();
        }
    }

    public static Feature.BaseFeature MakeFeature(string name)
    {
        switch (name)
        {
            case "audit":
                return new Feature.AuditFeature();
            case "cache":
                return new Feature.CacheFeature();
            case "clienttrack":
                return new Feature.ClienttrackFeature();
            case "cost":
                return new Feature.CostFeature();
            case "debug":
                return new Feature.DebugFeature();
            case "idempotency":
                return new Feature.IdempotencyFeature();
            case "log":
                return new Feature.LogFeature();
            case "metrics":
                return new Feature.MetricsFeature();
            case "netsim":
                return new Feature.NetsimFeature();
            case "paging":
                return new Feature.PagingFeature();
            case "proxy":
                return new Feature.ProxyFeature();
            case "ratelimit":
                return new Feature.RatelimitFeature();
            case "rbac":
                return new Feature.RbacFeature();
            case "retry":
                return new Feature.RetryFeature();
            case "secrets":
                return new Feature.SecretsFeature();
            case "streaming":
                return new Feature.StreamingFeature();
            case "telemetry":
                return new Feature.TelemetryFeature();
            case "test":
                return new Feature.TestFeature();
            case "timeout":
                return new Feature.TimeoutFeature();
            case "validate":
                return new Feature.ValidateFeature();
            default:
                return new Feature.BaseFeature();
        }
    }
}
