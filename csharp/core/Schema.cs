// Smsapi SDK - generated schemas. GENERATED from the API model -
// do not edit by hand.
//
// Built from the model: `main.kit.optspec` and each feature's
// `config.options` for Optspec; entity `fields{}.type` for Entityspec.

namespace SmsapiSdk;

public static class SdkSchema
{
    // Built ONCE, on first use. The spec is read on every client construction
    // and never mutated, so rebuilding it per call would be pure waste — and
    // a shared dictionary is safe for the same reason the spec is a constant:
    // MakeOptions validates AGAINST it and writes into the options, never
    // into the spec.
    //
    // A static field initializer, so the CLR's type initializer gives the
    // once-only, thread-safe guarantee with no locking on the read path.

    /// <summary>The option spec MakeOptions validates client options against.</summary>
    public static readonly Dictionary<string, object?> Optspec =
        new Dictionary<string, object?>
        {
            ["allow"] = new Dictionary<string, object?>
            {
                ["method"] = "GET,PUT,POST,PATCH,DELETE,OPTIONS",
                ["op"] = "create,update,patch,load,list,remove,command,direct,graphql",
            },
            ["apikey"] = "",
            ["auth"] = new Dictionary<string, object?>
            {
                ["basic"] = false,
                ["in"] = "",
                ["name"] = "",
                ["prefix"] = "",
            },
            ["base"] = "http://localhost:8000",
            ["clean"] = new Dictionary<string, object?>
            {
                ["active"] = true,
                ["hint"] = "0",
                ["keys"] = "key,secret,token,password,passwd,authorization,cookie,credential,signature",
                ["mask"] = "[redacted]",
                ["min"] = "4",
                ["values"] = "",
            },
            ["entity"] = new Dictionary<string, object?>
            {
                ["`$CHILD`"] = new Dictionary<string, object?>
                {
                    ["`$OPEN`"] = true,
                    ["active"] = false,
                    ["alias"] = new Dictionary<string, object?>(),
                },
            },
            ["extend"] = "`$ANY`",
            ["headers"] = new Dictionary<string, object?>
            {
                ["`$CHILD`"] = "`$STRING`",
            },
            ["prefix"] = "",
            ["secret"] = "",
            ["server"] = new Dictionary<string, object?>
            {
                ["`$CHILD`"] = "",
            },
            ["suffix"] = "",
            ["system"] = new Dictionary<string, object?>
            {
                ["fetch"] = "`$ANY`",
            },
            ["test"] = new Dictionary<string, object?>
            {
                ["active"] = false,
                ["entity"] = new Dictionary<string, object?>
                {
                    ["`$OPEN`"] = true,
                },
            },
            ["utility"] = new Dictionary<string, object?>(),
            ["feature"] = new Dictionary<string, object?>
            {
                ["`$CHILD`"] = new Dictionary<string, object?>
                {
                    ["`$OPEN`"] = true,
                    ["active"] = false,
                },
                ["audit"] = new List<object?>
                {
                    "`$ONE`",
                    new Dictionary<string, object?>
                    {
                        ["`$OPEN`"] = true,
                        ["active"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$BOOLEAN`",
                            "`$NIL`",
                        },
                        ["actor"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["max"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$NUMBER`",
                            "`$NIL`",
                        },
                        ["now"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$FUNCTION`",
                            "`$NIL`",
                        },
                        ["sink"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$FUNCTION`",
                            "`$NIL`",
                        },
                    },
                    "`$NIL`",
                },
                ["cache"] = new List<object?>
                {
                    "`$ONE`",
                    new Dictionary<string, object?>
                    {
                        ["`$OPEN`"] = true,
                        ["active"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$BOOLEAN`",
                            "`$NIL`",
                        },
                        ["max"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$NUMBER`",
                            "`$NIL`",
                        },
                        ["methods"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$LIST`",
                            "`$NIL`",
                        },
                        ["ttl"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$NUMBER`",
                            "`$NIL`",
                        },
                        ["now"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$FUNCTION`",
                            "`$NIL`",
                        },
                    },
                    "`$NIL`",
                },
                ["clienttrack"] = new List<object?>
                {
                    "`$ONE`",
                    new Dictionary<string, object?>
                    {
                        ["`$OPEN`"] = true,
                        ["active"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$BOOLEAN`",
                            "`$NIL`",
                        },
                        ["clientVersion"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            "`$NIL`",
                        },
                        ["clientName"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            "`$NIL`",
                        },
                        ["headers"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$MAP`",
                            "`$NIL`",
                        },
                        ["idgen"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$FUNCTION`",
                            "`$NIL`",
                        },
                        ["sessionId"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            "`$NIL`",
                        },
                    },
                    "`$NIL`",
                },
                ["cost"] = new List<object?>
                {
                    "`$ONE`",
                    new Dictionary<string, object?>
                    {
                        ["`$OPEN`"] = true,
                        ["active"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$BOOLEAN`",
                            "`$NIL`",
                        },
                        ["budget"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$NUMBER`",
                            "`$NIL`",
                        },
                        ["currency"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["header"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["onBudget"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["path"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["perUnit"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$NUMBER`",
                            "`$NIL`",
                        },
                        ["rates"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$MAP`",
                            "`$NIL`",
                        },
                        ["unit"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$NUMBER`",
                            "`$NIL`",
                        },
                        ["actor"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            "`$NIL`",
                        },
                        ["sink"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$FUNCTION`",
                            "`$NIL`",
                        },
                    },
                    "`$NIL`",
                },
                ["debug"] = new List<object?>
                {
                    "`$ONE`",
                    new Dictionary<string, object?>
                    {
                        ["`$OPEN`"] = true,
                        ["active"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$BOOLEAN`",
                            "`$NIL`",
                        },
                        ["max"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$NUMBER`",
                            "`$NIL`",
                        },
                        ["redact"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$LIST`",
                            "`$NIL`",
                        },
                        ["now"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$FUNCTION`",
                            "`$NIL`",
                        },
                        ["onEntry"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$FUNCTION`",
                            "`$NIL`",
                        },
                    },
                    "`$NIL`",
                },
                ["idempotency"] = new List<object?>
                {
                    "`$ONE`",
                    new Dictionary<string, object?>
                    {
                        ["`$OPEN`"] = true,
                        ["active"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$BOOLEAN`",
                            "`$NIL`",
                        },
                        ["header"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["methods"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$LIST`",
                            "`$NIL`",
                        },
                        ["ops"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$LIST`",
                            "`$NIL`",
                        },
                        ["keygen"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$FUNCTION`",
                            "`$NIL`",
                        },
                    },
                    "`$NIL`",
                },
                ["log"] = new List<object?>
                {
                    "`$ONE`",
                    new Dictionary<string, object?>
                    {
                        ["`$OPEN`"] = true,
                        ["active"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$BOOLEAN`",
                            "`$NIL`",
                        },
                        ["level"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            "`$NIL`",
                        },
                        ["logger"] = "`$ANY`",
                    },
                    "`$NIL`",
                },
                ["metrics"] = new List<object?>
                {
                    "`$ONE`",
                    new Dictionary<string, object?>
                    {
                        ["`$OPEN`"] = true,
                        ["active"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$BOOLEAN`",
                            "`$NIL`",
                        },
                        ["now"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$FUNCTION`",
                            "`$NIL`",
                        },
                    },
                    "`$NIL`",
                },
                ["netsim"] = new List<object?>
                {
                    "`$ONE`",
                    new Dictionary<string, object?>
                    {
                        ["`$OPEN`"] = true,
                        ["active"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$BOOLEAN`",
                            "`$NIL`",
                        },
                        ["errorTimes"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$NUMBER`",
                            "`$NIL`",
                        },
                        ["failEvery"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$NUMBER`",
                            "`$NIL`",
                        },
                        ["failRate"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$NUMBER`",
                            "`$NIL`",
                        },
                        ["failStatus"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$NUMBER`",
                            "`$NIL`",
                        },
                        ["failTimes"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$NUMBER`",
                            "`$NIL`",
                        },
                        ["latency"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$NUMBER`",
                            "`$MAP`",
                            "`$NIL`",
                        },
                        ["offline"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$BOOLEAN`",
                            "`$NIL`",
                        },
                        ["rateLimitTimes"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$NUMBER`",
                            "`$NIL`",
                        },
                        ["retryAfter"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$NUMBER`",
                            "`$NIL`",
                        },
                        ["seed"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$NUMBER`",
                            "`$NIL`",
                        },
                        ["sleep"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$FUNCTION`",
                            "`$NIL`",
                        },
                    },
                    "`$NIL`",
                },
                ["paging"] = new List<object?>
                {
                    "`$ONE`",
                    new Dictionary<string, object?>
                    {
                        ["`$OPEN`"] = true,
                        ["active"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$BOOLEAN`",
                            "`$NIL`",
                        },
                        ["afterVar"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["cursorParam"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["firstVar"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["limitParam"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["pageParam"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["startPage"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$NUMBER`",
                            "`$NIL`",
                        },
                        ["limit"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$NUMBER`",
                            "`$NIL`",
                        },
                        ["ops"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$LIST`",
                            "`$NIL`",
                        },
                    },
                    "`$NIL`",
                },
                ["proxy"] = new List<object?>
                {
                    "`$ONE`",
                    new Dictionary<string, object?>
                    {
                        ["`$OPEN`"] = true,
                        ["active"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$BOOLEAN`",
                            "`$NIL`",
                        },
                        ["fromEnv"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$BOOLEAN`",
                            "`$NIL`",
                        },
                        ["noProxy"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$LIST`",
                            "`$NIL`",
                        },
                        ["url"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["agent"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$FUNCTION`",
                            "`$NIL`",
                        },
                    },
                    "`$NIL`",
                },
                ["ratelimit"] = new List<object?>
                {
                    "`$ONE`",
                    new Dictionary<string, object?>
                    {
                        ["`$OPEN`"] = true,
                        ["active"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$BOOLEAN`",
                            "`$NIL`",
                        },
                        ["burst"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$NUMBER`",
                            "`$NIL`",
                        },
                        ["rate"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$NUMBER`",
                            "`$NIL`",
                        },
                        ["now"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$FUNCTION`",
                            "`$NIL`",
                        },
                        ["sleep"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$FUNCTION`",
                            "`$NIL`",
                        },
                    },
                    "`$NIL`",
                },
                ["rbac"] = new List<object?>
                {
                    "`$ONE`",
                    new Dictionary<string, object?>
                    {
                        ["`$OPEN`"] = true,
                        ["active"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$BOOLEAN`",
                            "`$NIL`",
                        },
                        ["deny"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$BOOLEAN`",
                            "`$NIL`",
                        },
                        ["permissions"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$LIST`",
                            "`$NIL`",
                        },
                        ["rules"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$MAP`",
                            "`$NIL`",
                        },
                    },
                    "`$NIL`",
                },
                ["retry"] = new List<object?>
                {
                    "`$ONE`",
                    new Dictionary<string, object?>
                    {
                        ["`$OPEN`"] = true,
                        ["active"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$BOOLEAN`",
                            "`$NIL`",
                        },
                        ["factor"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$NUMBER`",
                            "`$NIL`",
                        },
                        ["maxDelay"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$NUMBER`",
                            "`$NIL`",
                        },
                        ["minDelay"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$NUMBER`",
                            "`$NIL`",
                        },
                        ["retries"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$NUMBER`",
                            "`$NIL`",
                        },
                        ["statuses"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$LIST`",
                            "`$NIL`",
                        },
                        ["jitter"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$BOOLEAN`",
                            "`$NIL`",
                        },
                        ["sleep"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$FUNCTION`",
                            "`$NIL`",
                        },
                    },
                    "`$NIL`",
                },
                ["secrets"] = new List<object?>
                {
                    "`$ONE`",
                    new Dictionary<string, object?>
                    {
                        ["`$OPEN`"] = true,
                        ["active"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$BOOLEAN`",
                            "`$NIL`",
                        },
                        ["cache"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$BOOLEAN`",
                            "`$NIL`",
                        },
                        ["exchange"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$MAP`",
                            "`$NIL`",
                        },
                        ["name"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["providers"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$LIST`",
                            "`$NIL`",
                        },
                    },
                    "`$NIL`",
                },
                ["streaming"] = new List<object?>
                {
                    "`$ONE`",
                    new Dictionary<string, object?>
                    {
                        ["`$OPEN`"] = true,
                        ["active"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$BOOLEAN`",
                            "`$NIL`",
                        },
                        ["chunkDelay"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$NUMBER`",
                            "`$NIL`",
                        },
                        ["chunkSize"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$NUMBER`",
                            "`$NIL`",
                        },
                        ["ops"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$LIST`",
                            "`$NIL`",
                        },
                        ["sleep"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$FUNCTION`",
                            "`$NIL`",
                        },
                    },
                    "`$NIL`",
                },
                ["telemetry"] = new List<object?>
                {
                    "`$ONE`",
                    new Dictionary<string, object?>
                    {
                        ["`$OPEN`"] = true,
                        ["active"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$BOOLEAN`",
                            "`$NIL`",
                        },
                        ["exporter"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$FUNCTION`",
                            "`$NIL`",
                        },
                        ["headers"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$MAP`",
                            "`$NIL`",
                        },
                        ["idgen"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$FUNCTION`",
                            "`$NIL`",
                        },
                        ["now"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$FUNCTION`",
                            "`$NIL`",
                        },
                    },
                    "`$NIL`",
                },
                ["test"] = new List<object?>
                {
                    "`$ONE`",
                    new Dictionary<string, object?>
                    {
                        ["`$OPEN`"] = true,
                        ["active"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$BOOLEAN`",
                            "`$NIL`",
                        },
                        ["entity"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$MAP`",
                            "`$NIL`",
                        },
                        ["net"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$MAP`",
                            "`$NIL`",
                        },
                    },
                    "`$NIL`",
                },
                ["timeout"] = new List<object?>
                {
                    "`$ONE`",
                    new Dictionary<string, object?>
                    {
                        ["`$OPEN`"] = true,
                        ["active"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$BOOLEAN`",
                            "`$NIL`",
                        },
                        ["ms"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$NUMBER`",
                            "`$NIL`",
                        },
                        ["clearTimer"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$FUNCTION`",
                            "`$NIL`",
                        },
                        ["now"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$FUNCTION`",
                            "`$NIL`",
                        },
                        ["setTimer"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$FUNCTION`",
                            "`$NIL`",
                        },
                    },
                    "`$NIL`",
                },
                ["validate"] = new List<object?>
                {
                    "`$ONE`",
                    new Dictionary<string, object?>
                    {
                        ["`$OPEN`"] = true,
                        ["active"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$BOOLEAN`",
                            "`$NIL`",
                        },
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
                            "`$NIL`",
                        },
                        ["request"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$BOOLEAN`",
                            "`$NIL`",
                        },
                        ["response"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$BOOLEAN`",
                            "`$NIL`",
                        },
                        ["strict"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$BOOLEAN`",
                            "`$NIL`",
                        },
                        ["onInvalid"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$FUNCTION`",
                            "`$NIL`",
                        },
                    },
                    "`$NIL`",
                },
            },
        };

    /// <summary>Per-entity data and request specs, keyed by entity name.</summary>
    public static readonly Dictionary<string, object?> Entityspec =
        new Dictionary<string, object?>
        {
            ["available"] = new Dictionary<string, object?>
            {
                ["data"] = new Dictionary<string, object?>
                {
                    ["`$OPEN`"] = true,
                    ["name"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                        "`$NIL`",
                    },
                    ["normalize"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$BOOLEAN`",
                        "`$NIL`",
                    },
                    ["template"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                        "`$NIL`",
                    },
                },
                ["op"] = new Dictionary<string, object?>
                {
                    ["list"] = new Dictionary<string, object?>
                    {
                        ["`$OPEN`"] = true,
                        ["name"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["normalize"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$BOOLEAN`",
                            "`$NIL`",
                        },
                        ["template"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                    },
                },
            },
            ["blacklist"] = new Dictionary<string, object?>
            {
                ["data"] = new Dictionary<string, object?>
                {
                    ["`$OPEN`"] = true,
                    ["id"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                        "`$NIL`",
                    },
                },
                ["op"] = new Dictionary<string, object?>
                {
                    ["create"] = new Dictionary<string, object?>
                    {
                        ["`$OPEN`"] = true,
                        ["id"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                    },
                    ["load"] = new Dictionary<string, object?>
                    {
                        ["`$OPEN`"] = true,
                        ["limit"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$INTEGER`",
                            "`$NIL`",
                        },
                        ["offset"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$INTEGER`",
                            "`$NIL`",
                        },
                        ["q"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$INTEGER`",
                            "`$NIL`",
                        },
                    },
                    ["remove"] = new Dictionary<string, object?>
                    {
                        ["`$OPEN`"] = true,
                        ["id"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                        },
                    },
                },
            },
            ["callback"] = new Dictionary<string, object?>
            {
                ["data"] = new Dictionary<string, object?>
                {
                    ["`$OPEN`"] = true,
                    ["active"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$BOOLEAN`",
                        "`$NIL`",
                    },
                    ["api_version"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$INTEGER`",
                        "`$NIL`",
                    },
                    ["id"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                        "`$NIL`",
                    },
                    ["invalid"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$BOOLEAN`",
                        "`$NIL`",
                    },
                    ["receiver"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$MAP`",
                        "`$NIL`",
                    },
                    ["receiver_type"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                        "`$NIL`",
                    },
                    ["type"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                        "`$NIL`",
                    },
                    ["url"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                        "`$NIL`",
                    },
                },
                ["op"] = new Dictionary<string, object?>
                {
                    ["create"] = new Dictionary<string, object?>
                    {
                        ["`$OPEN`"] = true,
                        ["active"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$BOOLEAN`",
                            "`$NIL`",
                        },
                        ["api_version"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$INTEGER`",
                            "`$NIL`",
                        },
                        ["id"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["invalid"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$BOOLEAN`",
                            "`$NIL`",
                        },
                        ["receiver"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$MAP`",
                            "`$NIL`",
                        },
                        ["receiver_type"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["type"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["url"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                    },
                    ["list"] = new Dictionary<string, object?>
                    {
                        ["`$OPEN`"] = true,
                        ["active"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$BOOLEAN`",
                            "`$NIL`",
                        },
                        ["api_version"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$INTEGER`",
                            "`$NIL`",
                        },
                        ["id"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["invalid"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$BOOLEAN`",
                            "`$NIL`",
                        },
                        ["receiver"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$MAP`",
                            "`$NIL`",
                        },
                        ["receiver_type"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["type"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["url"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                    },
                    ["load"] = new Dictionary<string, object?>
                    {
                        ["`$OPEN`"] = true,
                        ["id"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                        },
                    },
                    ["remove"] = new Dictionary<string, object?>
                    {
                        ["`$OPEN`"] = true,
                        ["id"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                        },
                    },
                    ["update"] = new Dictionary<string, object?>
                    {
                        ["`$OPEN`"] = true,
                        ["id"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                        },
                        ["active"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$BOOLEAN`",
                            "`$NIL`",
                        },
                        ["api_version"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$INTEGER`",
                            "`$NIL`",
                        },
                        ["invalid"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$BOOLEAN`",
                            "`$NIL`",
                        },
                        ["receiver"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$MAP`",
                            "`$NIL`",
                        },
                        ["receiver_type"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["type"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["url"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                    },
                },
            },
            ["contact"] = new Dictionary<string, object?>
            {
                ["data"] = new Dictionary<string, object?>
                {
                    ["`$OPEN`"] = true,
                    ["birthday_date"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                        "`$NIL`",
                    },
                    ["city"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                        "`$NIL`",
                    },
                    ["collection"] = "`$LIST`",
                    ["contact_expire_after"] = "`$INTEGER`",
                    ["contacts_count"] = "`$INTEGER`",
                    ["country"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                        "`$NIL`",
                    },
                    ["created_by"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                    },
                    ["date_created"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                    },
                    ["date_updated"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                    },
                    ["description"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                        "`$NIL`",
                    },
                    ["email"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                        "`$NIL`",
                    },
                    ["first_name"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                        "`$NIL`",
                    },
                    ["gender"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                    },
                    ["groups"] = "`$LIST`",
                    ["id"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                    },
                    ["idx"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                        "`$NIL`",
                    },
                    ["last_name"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                        "`$NIL`",
                    },
                    ["name"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                    },
                    ["permissions"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$LIST`",
                        "`$NIL`",
                    },
                    ["phone_number"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                        "`$NIL`",
                    },
                    ["size"] = "`$INTEGER`",
                    ["source"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                        "`$NIL`",
                    },
                },
                ["op"] = new Dictionary<string, object?>
                {
                    ["create"] = new Dictionary<string, object?>
                    {
                        ["`$OPEN`"] = true,
                        ["birthday_date"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["city"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["collection"] = "`$LIST`",
                        ["contact_expire_after"] = "`$INTEGER`",
                        ["contacts_count"] = "`$INTEGER`",
                        ["country"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["created_by"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                        },
                        ["date_created"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                        },
                        ["date_updated"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                        },
                        ["description"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["email"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["first_name"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["gender"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                        },
                        ["groups"] = "`$LIST`",
                        ["id"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                        },
                        ["idx"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["last_name"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["name"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                        },
                        ["permissions"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$LIST`",
                            "`$NIL`",
                        },
                        ["phone_number"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["size"] = "`$INTEGER`",
                        ["source"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                    },
                    ["list"] = new Dictionary<string, object?>
                    {
                        ["`$OPEN`"] = true,
                        ["birthday_date"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$LIST`",
                            "`$NIL`",
                        },
                        ["email"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$LIST`",
                            "`$NIL`",
                        },
                        ["first_name"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$LIST`",
                            "`$NIL`",
                        },
                        ["gender"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["group_id"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$LIST`",
                            "`$NIL`",
                        },
                        ["last_name"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$LIST`",
                            "`$NIL`",
                        },
                        ["limit"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$INTEGER`",
                            "`$NIL`",
                        },
                        ["offset"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$INTEGER`",
                            "`$NIL`",
                        },
                        ["order_by"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["phone_number"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$LIST`",
                            "`$NIL`",
                        },
                        ["q"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                    },
                    ["load"] = new Dictionary<string, object?>
                    {
                        ["`$OPEN`"] = true,
                        ["id"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                        },
                    },
                    ["remove"] = new Dictionary<string, object?>
                    {
                        ["`$OPEN`"] = true,
                        ["id"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                        },
                    },
                    ["update"] = new Dictionary<string, object?>
                    {
                        ["`$OPEN`"] = true,
                        ["id"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                        },
                        ["birthday_date"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["city"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["collection"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$LIST`",
                            "`$NIL`",
                        },
                        ["contact_expire_after"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$INTEGER`",
                            "`$NIL`",
                        },
                        ["contacts_count"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$INTEGER`",
                            "`$NIL`",
                        },
                        ["country"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["created_by"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["date_created"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["date_updated"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["description"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["email"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["first_name"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["gender"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["groups"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$LIST`",
                            "`$NIL`",
                        },
                        ["idx"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["last_name"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["name"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["permissions"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$LIST`",
                            "`$NIL`",
                        },
                        ["phone_number"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["size"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$INTEGER`",
                            "`$NIL`",
                        },
                        ["source"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                    },
                },
            },
            ["contacts_field"] = new Dictionary<string, object?>
            {
                ["data"] = new Dictionary<string, object?>
                {
                    ["`$OPEN`"] = true,
                    ["id"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                        "`$NIL`",
                    },
                    ["name"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                        "`$NIL`",
                    },
                    ["type"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                        "`$NIL`",
                    },
                },
                ["op"] = new Dictionary<string, object?>
                {
                    ["create"] = new Dictionary<string, object?>
                    {
                        ["`$OPEN`"] = true,
                        ["id"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["name"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["type"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                    },
                    ["list"] = new Dictionary<string, object?>
                    {
                        ["`$OPEN`"] = true,
                        ["id"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["name"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["type"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                    },
                    ["remove"] = new Dictionary<string, object?>
                    {
                        ["`$OPEN`"] = true,
                        ["id"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                        },
                    },
                    ["update"] = new Dictionary<string, object?>
                    {
                        ["`$OPEN`"] = true,
                        ["id"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                        },
                        ["name"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["type"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                    },
                },
            },
            ["contacts_field_option"] = new Dictionary<string, object?>
            {
                ["data"] = new Dictionary<string, object?>
                {
                    ["`$OPEN`"] = true,
                },
                ["op"] = new Dictionary<string, object?>
                {
                    ["list"] = new Dictionary<string, object?>
                    {
                        ["`$OPEN`"] = true,
                        ["field_id"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                        },
                    },
                },
            },
            ["contactsgroup"] = new Dictionary<string, object?>
            {
                ["data"] = new Dictionary<string, object?>
                {
                    ["`$OPEN`"] = true,
                    ["group_id"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                    },
                    ["read"] = "`$BOOLEAN`",
                    ["send"] = "`$BOOLEAN`",
                    ["username"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                    },
                    ["write"] = "`$BOOLEAN`",
                },
                ["op"] = new Dictionary<string, object?>
                {
                    ["create"] = new Dictionary<string, object?>
                    {
                        ["`$OPEN`"] = true,
                        ["group_id"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                        },
                        ["read"] = "`$BOOLEAN`",
                        ["send"] = "`$BOOLEAN`",
                        ["username"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                        },
                        ["write"] = "`$BOOLEAN`",
                    },
                    ["list"] = new Dictionary<string, object?>
                    {
                        ["`$OPEN`"] = true,
                        ["name"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$MAP`",
                            "`$NIL`",
                        },
                        ["with"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$LIST`",
                            "`$NIL`",
                        },
                    },
                    ["remove"] = new Dictionary<string, object?>
                    {
                        ["`$OPEN`"] = true,
                        ["group_id"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                        },
                    },
                    ["update"] = new Dictionary<string, object?>
                    {
                        ["`$OPEN`"] = true,
                        ["group_id"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                        },
                        ["username"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["read"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$BOOLEAN`",
                            "`$NIL`",
                        },
                        ["send"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$BOOLEAN`",
                            "`$NIL`",
                        },
                        ["write"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$BOOLEAN`",
                            "`$NIL`",
                        },
                    },
                },
            },
            ["contactstrash"] = new Dictionary<string, object?>
            {
                ["data"] = new Dictionary<string, object?>
                {
                    ["`$OPEN`"] = true,
                },
                ["op"] = new Dictionary<string, object?>(),
            },
            ["field_available"] = new Dictionary<string, object?>
            {
                ["data"] = new Dictionary<string, object?>
                {
                    ["`$OPEN`"] = true,
                    ["built_in"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$BOOLEAN`",
                        "`$NIL`",
                    },
                    ["id"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                        "`$NIL`",
                    },
                    ["name"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                        "`$NIL`",
                    },
                    ["options"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$LIST`",
                        "`$NIL`",
                    },
                    ["type"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                        "`$NIL`",
                    },
                },
                ["op"] = new Dictionary<string, object?>
                {
                    ["list"] = new Dictionary<string, object?>
                    {
                        ["`$OPEN`"] = true,
                        ["built_in"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$BOOLEAN`",
                            "`$NIL`",
                        },
                        ["id"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["name"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["options"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$LIST`",
                            "`$NIL`",
                        },
                        ["type"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                    },
                },
            },
            ["group"] = new Dictionary<string, object?>
            {
                ["data"] = new Dictionary<string, object?>
                {
                    ["`$OPEN`"] = true,
                    ["contact_expire_after"] = "`$INTEGER`",
                    ["contacts_count"] = "`$INTEGER`",
                    ["created_by"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                    },
                    ["date_created"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                    },
                    ["date_updated"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                    },
                    ["description"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                    },
                    ["id"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                    },
                    ["idx"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                        "`$NIL`",
                    },
                    ["name"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                    },
                    ["permissions"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$LIST`",
                        "`$NIL`",
                    },
                },
                ["op"] = new Dictionary<string, object?>
                {
                    ["load"] = new Dictionary<string, object?>
                    {
                        ["`$OPEN`"] = true,
                        ["id"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                        },
                    },
                    ["update"] = new Dictionary<string, object?>
                    {
                        ["`$OPEN`"] = true,
                        ["id"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                        },
                        ["contact_expire_after"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$INTEGER`",
                            "`$NIL`",
                        },
                        ["contacts_count"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$INTEGER`",
                            "`$NIL`",
                        },
                        ["created_by"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["date_created"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["date_updated"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["description"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["idx"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["name"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["permissions"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$LIST`",
                            "`$NIL`",
                        },
                    },
                },
            },
            ["mfa_code"] = new Dictionary<string, object?>
            {
                ["data"] = new Dictionary<string, object?>
                {
                    ["`$OPEN`"] = true,
                    ["content"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                        "`$NIL`",
                    },
                    ["fast"] = "`$ANY`",
                    ["from"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                        "`$NIL`",
                    },
                    ["phone_number"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                    },
                },
                ["op"] = new Dictionary<string, object?>
                {
                    ["create"] = new Dictionary<string, object?>
                    {
                        ["`$OPEN`"] = true,
                        ["content"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["fast"] = "`$ANY`",
                        ["from"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["phone_number"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                        },
                    },
                },
            },
            ["opt_out"] = new Dictionary<string, object?>
            {
                ["data"] = new Dictionary<string, object?>
                {
                    ["`$OPEN`"] = true,
                    ["date"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                        "`$NIL`",
                    },
                    ["id"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                        "`$NIL`",
                    },
                    ["links"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$LIST`",
                        "`$NIL`",
                    },
                    ["phoneNumber"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$INTEGER`",
                        "`$NIL`",
                    },
                },
                ["op"] = new Dictionary<string, object?>
                {
                    ["list"] = new Dictionary<string, object?>
                    {
                        ["`$OPEN`"] = true,
                        ["limit"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$INTEGER`",
                            "`$NIL`",
                        },
                        ["offset"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$INTEGER`",
                            "`$NIL`",
                        },
                        ["phone_number"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                    },
                    ["remove"] = new Dictionary<string, object?>
                    {
                        ["`$OPEN`"] = true,
                        ["id"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                        },
                    },
                },
            },
            ["opt_out_setting"] = new Dictionary<string, object?>
            {
                ["data"] = new Dictionary<string, object?>
                {
                    ["`$OPEN`"] = true,
                    ["brand"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                        "`$NIL`",
                    },
                },
                ["op"] = new Dictionary<string, object?>
                {
                    ["load"] = new Dictionary<string, object?>
                    {
                        ["`$OPEN`"] = true,
                        ["brand"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                    },
                    ["update"] = new Dictionary<string, object?>
                    {
                        ["`$OPEN`"] = true,
                        ["brand"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                    },
                },
            },
            ["permission"] = new Dictionary<string, object?>
            {
                ["data"] = new Dictionary<string, object?>
                {
                    ["`$OPEN`"] = true,
                    ["group_id"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                    },
                    ["id"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                        "`$NIL`",
                    },
                    ["read"] = "`$BOOLEAN`",
                    ["send"] = "`$BOOLEAN`",
                    ["username"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                    },
                    ["write"] = "`$BOOLEAN`",
                },
                ["op"] = new Dictionary<string, object?>
                {
                    ["create"] = new Dictionary<string, object?>
                    {
                        ["`$OPEN`"] = true,
                        ["group_id"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                        },
                        ["id"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["read"] = "`$BOOLEAN`",
                        ["send"] = "`$BOOLEAN`",
                        ["username"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                        },
                        ["write"] = "`$BOOLEAN`",
                    },
                    ["load"] = new Dictionary<string, object?>
                    {
                        ["`$OPEN`"] = true,
                        ["group_id"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                        },
                        ["id"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                        },
                    },
                },
            },
            ["ping"] = new Dictionary<string, object?>
            {
                ["data"] = new Dictionary<string, object?>
                {
                    ["`$OPEN`"] = true,
                    ["authorized"] = "`$BOOLEAN`",
                    ["unavailable"] = "`$LIST`",
                },
                ["op"] = new Dictionary<string, object?>
                {
                    ["list"] = new Dictionary<string, object?>
                    {
                        ["`$OPEN`"] = true,
                        ["authorized"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$BOOLEAN`",
                            "`$NIL`",
                        },
                        ["unavailable"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$LIST`",
                            "`$NIL`",
                        },
                    },
                },
            },
            ["profile"] = new Dictionary<string, object?>
            {
                ["data"] = new Dictionary<string, object?>
                {
                    ["`$OPEN`"] = true,
                    ["email"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                    },
                    ["name"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                    },
                    ["payment_type"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                    },
                    ["phone_number"] = "`$INTEGER`",
                    ["points"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$NUMBER`",
                        "`$NIL`",
                    },
                    ["user_type"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                    },
                    ["username"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                    },
                },
                ["op"] = new Dictionary<string, object?>
                {
                    ["list"] = new Dictionary<string, object?>
                    {
                        ["`$OPEN`"] = true,
                        ["type"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                    },
                    ["load"] = new Dictionary<string, object?>
                    {
                        ["`$OPEN`"] = true,
                        ["email"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["name"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["payment_type"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["phone_number"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$INTEGER`",
                            "`$NIL`",
                        },
                        ["points"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$NUMBER`",
                            "`$NIL`",
                        },
                        ["user_type"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["username"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                    },
                },
            },
            ["rcs"] = new Dictionary<string, object?>
            {
                ["data"] = new Dictionary<string, object?>
                {
                    ["`$OPEN`"] = true,
                },
                ["op"] = new Dictionary<string, object?>(),
            },
            ["sendername"] = new Dictionary<string, object?>
            {
                ["data"] = new Dictionary<string, object?>
                {
                    ["`$OPEN`"] = true,
                    ["created_at"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                        "`$NIL`",
                    },
                    ["id"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                        "`$NIL`",
                    },
                    ["is_default"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$BOOLEAN`",
                        "`$NIL`",
                    },
                    ["sender"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                        "`$NIL`",
                    },
                    ["status"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                        "`$NIL`",
                    },
                },
                ["op"] = new Dictionary<string, object?>
                {
                    ["create"] = new Dictionary<string, object?>
                    {
                        ["`$OPEN`"] = true,
                        ["created_at"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["id"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["is_default"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$BOOLEAN`",
                            "`$NIL`",
                        },
                        ["sender"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["status"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                    },
                    ["list"] = new Dictionary<string, object?>
                    {
                        ["`$OPEN`"] = true,
                        ["created_at"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["id"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["is_default"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$BOOLEAN`",
                            "`$NIL`",
                        },
                        ["sender"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["status"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                    },
                    ["load"] = new Dictionary<string, object?>
                    {
                        ["`$OPEN`"] = true,
                        ["id"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                        },
                    },
                },
            },
            ["sendername_statement"] = new Dictionary<string, object?>
            {
                ["data"] = new Dictionary<string, object?>
                {
                    ["`$OPEN`"] = true,
                    ["content"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                        "`$NIL`",
                    },
                    ["statements"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$LIST`",
                        "`$NIL`",
                    },
                    ["title"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                        "`$NIL`",
                    },
                },
                ["op"] = new Dictionary<string, object?>
                {
                    ["list"] = new Dictionary<string, object?>
                    {
                        ["`$OPEN`"] = true,
                        ["content"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["statements"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$LIST`",
                            "`$NIL`",
                        },
                        ["title"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                    },
                },
            },
            ["sent_rcs_message"] = new Dictionary<string, object?>
            {
                ["data"] = new Dictionary<string, object?>
                {
                    ["`$OPEN`"] = true,
                    ["content"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$MAP`",
                        "`$NIL`",
                    },
                    ["phone_number"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                    },
                    ["sender"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                    },
                    ["text"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                        "`$NIL`",
                    },
                },
                ["op"] = new Dictionary<string, object?>
                {
                    ["create"] = new Dictionary<string, object?>
                    {
                        ["`$OPEN`"] = true,
                        ["content"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$MAP`",
                            "`$NIL`",
                        },
                        ["phone_number"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                        },
                        ["sender"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                        },
                        ["text"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                    },
                },
            },
            ["shipment_country_volume"] = new Dictionary<string, object?>
            {
                ["data"] = new Dictionary<string, object?>
                {
                    ["`$OPEN`"] = true,
                    ["country_code"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                        "`$NIL`",
                    },
                    ["country_limit"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$INTEGER`",
                        "`$NIL`",
                    },
                    ["country_name"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                        "`$NIL`",
                    },
                    ["usage"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$INTEGER`",
                        "`$NIL`",
                    },
                },
                ["op"] = new Dictionary<string, object?>
                {
                    ["list"] = new Dictionary<string, object?>
                    {
                        ["`$OPEN`"] = true,
                        ["month"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["year"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                    },
                },
            },
            ["short_url"] = new Dictionary<string, object?>
            {
                ["data"] = new Dictionary<string, object?>
                {
                    ["`$OPEN`"] = true,
                    ["description"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                        "`$NIL`",
                    },
                    ["expire"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                        "`$NIL`",
                    },
                    ["filename"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                        "`$NIL`",
                    },
                    ["hits"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$INTEGER`",
                        "`$NIL`",
                    },
                    ["hits_unique"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$INTEGER`",
                        "`$NIL`",
                    },
                    ["id"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                        "`$NIL`",
                    },
                    ["name"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                        "`$NIL`",
                    },
                    ["short_url"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                        "`$NIL`",
                    },
                    ["type"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                        "`$NIL`",
                    },
                    ["url"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                        "`$NIL`",
                    },
                },
                ["op"] = new Dictionary<string, object?>
                {
                    ["create"] = new Dictionary<string, object?>
                    {
                        ["`$OPEN`"] = true,
                        ["description"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["expire"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["filename"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["hits"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$INTEGER`",
                            "`$NIL`",
                        },
                        ["hits_unique"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$INTEGER`",
                            "`$NIL`",
                        },
                        ["id"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["name"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["short_url"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["type"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["url"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                    },
                    ["list"] = new Dictionary<string, object?>
                    {
                        ["`$OPEN`"] = true,
                        ["description"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["expire"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["filename"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["hits"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$INTEGER`",
                            "`$NIL`",
                        },
                        ["hits_unique"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$INTEGER`",
                            "`$NIL`",
                        },
                        ["id"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["name"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["short_url"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["type"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["url"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                    },
                    ["load"] = new Dictionary<string, object?>
                    {
                        ["`$OPEN`"] = true,
                        ["id"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                        },
                    },
                    ["remove"] = new Dictionary<string, object?>
                    {
                        ["`$OPEN`"] = true,
                        ["id"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                        },
                    },
                    ["update"] = new Dictionary<string, object?>
                    {
                        ["`$OPEN`"] = true,
                        ["id"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                        },
                        ["description"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["expire"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["filename"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["hits"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$INTEGER`",
                            "`$NIL`",
                        },
                        ["hits_unique"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$INTEGER`",
                            "`$NIL`",
                        },
                        ["name"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["short_url"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["type"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["url"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                    },
                },
            },
            ["smsdo"] = new Dictionary<string, object?>
            {
                ["data"] = new Dictionary<string, object?>
                {
                    ["`$OPEN`"] = true,
                    ["allow_duplicates"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$INTEGER`",
                        "`$NIL`",
                    },
                    ["check_idx"] = "`$ANY`",
                    ["date"] = "`$ANY`",
                    ["date_validate"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$INTEGER`",
                        "`$NIL`",
                    },
                    ["details"] = "`$ANY`",
                    ["encoding"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                        "`$NIL`",
                    },
                    ["expiration_date"] = "`$ANY`",
                    ["fallback"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$LIST`",
                        "`$NIL`",
                    },
                    ["fast"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$INTEGER`",
                        "`$NIL`",
                    },
                    ["flash"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$INTEGER`",
                        "`$NIL`",
                    },
                    ["format"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                        "`$NIL`",
                    },
                    ["from"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                        "`$NIL`",
                    },
                    ["group"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                        "`$NIL`",
                    },
                    ["idx"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                        "`$NIL`",
                    },
                    ["max_parts"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$INTEGER`",
                        "`$NIL`",
                    },
                    ["message"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                        "`$NIL`",
                    },
                    ["normalize"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$INTEGER`",
                        "`$NIL`",
                    },
                    ["notify_url"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                        "`$NIL`",
                    },
                    ["test"] = "`$ANY`",
                    ["time_restriction"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                        "`$NIL`",
                    },
                    ["to"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                        "`$NIL`",
                    },
                },
                ["op"] = new Dictionary<string, object?>
                {
                    ["create"] = new Dictionary<string, object?>
                    {
                        ["`$OPEN`"] = true,
                        ["allow_duplicates"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$INTEGER`",
                            "`$NIL`",
                        },
                        ["check_idx"] = "`$ANY`",
                        ["date"] = "`$ANY`",
                        ["date_validate"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$INTEGER`",
                            "`$NIL`",
                        },
                        ["details"] = "`$ANY`",
                        ["encoding"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["expiration_date"] = "`$ANY`",
                        ["fallback"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$LIST`",
                            "`$NIL`",
                        },
                        ["fast"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$INTEGER`",
                            "`$NIL`",
                        },
                        ["flash"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$INTEGER`",
                            "`$NIL`",
                        },
                        ["format"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["from"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["group"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["idx"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["max_parts"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$INTEGER`",
                            "`$NIL`",
                        },
                        ["message"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["normalize"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$INTEGER`",
                            "`$NIL`",
                        },
                        ["notify_url"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["test"] = "`$ANY`",
                        ["time_restriction"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["to"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                    },
                },
            },
            ["smssendername"] = new Dictionary<string, object?>
            {
                ["data"] = new Dictionary<string, object?>
                {
                    ["`$OPEN`"] = true,
                },
                ["op"] = new Dictionary<string, object?>
                {
                    ["create"] = new Dictionary<string, object?>
                    {
                        ["`$OPEN`"] = true,
                        ["sender"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                        },
                    },
                    ["remove"] = new Dictionary<string, object?>
                    {
                        ["`$OPEN`"] = true,
                        ["sender"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                        },
                    },
                },
            },
            ["smstemplate"] = new Dictionary<string, object?>
            {
                ["data"] = new Dictionary<string, object?>
                {
                    ["`$OPEN`"] = true,
                    ["id"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                        "`$NIL`",
                    },
                },
                ["op"] = new Dictionary<string, object?>
                {
                    ["remove"] = new Dictionary<string, object?>
                    {
                        ["`$OPEN`"] = true,
                        ["id"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                        },
                    },
                },
            },
            ["subuser"] = new Dictionary<string, object?>
            {
                ["data"] = new Dictionary<string, object?>
                {
                    ["`$OPEN`"] = true,
                    ["active"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$BOOLEAN`",
                        "`$NIL`",
                    },
                    ["credentials"] = "`$MAP`",
                    ["description"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                        "`$NIL`",
                    },
                    ["id"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                        "`$NIL`",
                    },
                    ["points"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$MAP`",
                        "`$NIL`",
                    },
                    ["username"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                        "`$NIL`",
                    },
                },
                ["op"] = new Dictionary<string, object?>
                {
                    ["create"] = new Dictionary<string, object?>
                    {
                        ["`$OPEN`"] = true,
                        ["active"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$BOOLEAN`",
                            "`$NIL`",
                        },
                        ["credentials"] = "`$MAP`",
                        ["description"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["id"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["points"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$MAP`",
                            "`$NIL`",
                        },
                        ["username"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                    },
                    ["list"] = new Dictionary<string, object?>
                    {
                        ["`$OPEN`"] = true,
                        ["q"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                    },
                    ["load"] = new Dictionary<string, object?>
                    {
                        ["`$OPEN`"] = true,
                        ["id"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                        },
                    },
                    ["remove"] = new Dictionary<string, object?>
                    {
                        ["`$OPEN`"] = true,
                        ["id"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                        },
                    },
                    ["update"] = new Dictionary<string, object?>
                    {
                        ["`$OPEN`"] = true,
                        ["id"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                        },
                        ["active"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$BOOLEAN`",
                            "`$NIL`",
                        },
                        ["credentials"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$MAP`",
                            "`$NIL`",
                        },
                        ["description"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["points"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$MAP`",
                            "`$NIL`",
                        },
                        ["username"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                    },
                },
            },
            ["template"] = new Dictionary<string, object?>
            {
                ["data"] = new Dictionary<string, object?>
                {
                    ["`$OPEN`"] = true,
                    ["id"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                        "`$NIL`",
                    },
                    ["name"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                        "`$NIL`",
                    },
                    ["normalize"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$BOOLEAN`",
                        "`$NIL`",
                    },
                    ["template"] = new List<object?>
                    {
                        "`$ONE`",
                        "`$STRING`",
                        new List<object?>
                        {
                            "`$EXACT`",
                            "",
                        },
                        "`$NIL`",
                    },
                },
                ["op"] = new Dictionary<string, object?>
                {
                    ["create"] = new Dictionary<string, object?>
                    {
                        ["`$OPEN`"] = true,
                        ["id"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["name"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["normalize"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$BOOLEAN`",
                            "`$NIL`",
                        },
                        ["template"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                    },
                    ["list"] = new Dictionary<string, object?>
                    {
                        ["`$OPEN`"] = true,
                        ["id"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["name"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["normalize"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$BOOLEAN`",
                            "`$NIL`",
                        },
                        ["template"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                    },
                    ["load"] = new Dictionary<string, object?>
                    {
                        ["`$OPEN`"] = true,
                        ["id"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                        },
                    },
                    ["update"] = new Dictionary<string, object?>
                    {
                        ["`$OPEN`"] = true,
                        ["id"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                        },
                        ["name"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                        ["normalize"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$BOOLEAN`",
                            "`$NIL`",
                        },
                        ["template"] = new List<object?>
                        {
                            "`$ONE`",
                            "`$STRING`",
                            new List<object?>
                            {
                                "`$EXACT`",
                                "",
                            },
                            "`$NIL`",
                        },
                    },
                },
            },
            ["user_rcs_sender_collection"] = new Dictionary<string, object?>
            {
                ["data"] = new Dictionary<string, object?>
                {
                    ["`$OPEN`"] = true,
                },
                ["op"] = new Dictionary<string, object?>(),
            },
        };
}
