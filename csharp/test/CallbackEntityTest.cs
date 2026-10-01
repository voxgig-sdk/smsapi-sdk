// callback entity test - basic flow (generated from the API model).

using System.Text.Json;

using Voxgig.Struct;
using Xunit;

namespace SmsapiSdk.Test;

public class CallbackEntityTest
{
    [Fact]
    public void Instance()
    {
        var testsdk = SmsapiSDK.TestSDK(null, null);
        var ent = testsdk.Callback();
        Assert.NotNull(ent);
    }

    [Fact]
    public void Basic()
    {
        var setup = CallbackBasicSetup(null);
        // Per-op sdk-test-control.json skip - basic test exercises a flow
        // with multiple ops; skipping any op skips the whole flow.
        var _mode = setup.Live ? "live" : "unit";
        foreach (var _op in new[] { "create", "list", "update", "load", "remove" })
        {
            var (_shouldSkip, _) = TestRunner.IsControlSkipped(
                "entityOp", "callback." + _op, _mode);
            if (_shouldSkip)
            {
                return; // skipped via sdk-test-control.json
            }
        }
        // The basic flow consumes synthetic IDs from the fixture. In live
        // mode without an *_ENTID env override, those IDs hit the live API
        // and 4xx; set SMSAPI_TEST_CALLBACK_ENTID JSON to run live.
        if (setup.SyntheticOnly)
        {
            return;
        }
        var client = setup.Client;

        // CREATE
        var callbackRef01Ent = client.Callback();
        var callbackRef01Data = Helpers.ToMapAny(StructUtils.GetProp(
            StructUtils.GetPath(setup.Data, StructUtils.Jt("new", "callback")),
            "callback_ref01"));

        var callbackRef01DataResult = callbackRef01Ent.Create(callbackRef01Data, null);
        callbackRef01Data = Helpers.ToMapAny(callbackRef01DataResult is IEntity ce ? ce.Data() : callbackRef01DataResult);
        Assert.True(callbackRef01Data != null, "expected create result to be a map");
        Assert.True(callbackRef01Data!["id"] != null, "expected created entity to have an id");

        // LIST
        var callbackRef01Match = new Dictionary<string, object?>();

        var callbackRef01ListResult = callbackRef01Ent.List(callbackRef01Match, null);
        var callbackRef01List = callbackRef01ListResult as List<object?>;
        Assert.True(callbackRef01List != null,
            $"expected list result to be a list, got {callbackRef01ListResult?.GetType()}");

        var callbackRef01ListFound = StructUtils.Select(
            TestRunner.EntityListToData(callbackRef01List!),
            new Dictionary<string, object?> { ["id"] = callbackRef01Data!["id"] });
        Assert.False(StructUtils.IsEmpty(callbackRef01ListFound),
            "expected to find created entity in list");

        // UPDATE
        var callbackRef01DataUp0Up = new Dictionary<string, object?>
        {
            ["id"] = callbackRef01Data!["id"],
        };

        var callbackRef01MarkdefUp0Name = "receiver_type";
        var callbackRef01MarkdefUp0Value = $"Mark01-callback_ref01_{setup.Now}";
        callbackRef01DataUp0Up[callbackRef01MarkdefUp0Name] = callbackRef01MarkdefUp0Value;

        var callbackRef01ResdataUp0Result = callbackRef01Ent.Update(callbackRef01DataUp0Up, null);
        var callbackRef01ResdataUp0 = Helpers.ToMapAny(callbackRef01ResdataUp0Result is IEntity ue ? ue.Data() : callbackRef01ResdataUp0Result);
        Assert.True(callbackRef01ResdataUp0 != null, "expected update result to be a map");
        Assert.True(StructRunner.DeepEqual(callbackRef01ResdataUp0!["id"], callbackRef01DataUp0Up["id"]),
            "expected update result id to match");
        Assert.True(Equals(callbackRef01ResdataUp0![callbackRef01MarkdefUp0Name], callbackRef01MarkdefUp0Value),
            $"expected {callbackRef01MarkdefUp0Name} to be updated, got {callbackRef01ResdataUp0[callbackRef01MarkdefUp0Name]}");

        // LOAD
        var callbackRef01MatchDt0 = new Dictionary<string, object?>
        {
            ["id"] = callbackRef01Data!["id"],
        };
        var callbackRef01DataDt0Loaded = callbackRef01Ent.Load(callbackRef01MatchDt0, null);
        var callbackRef01DataDt0LoadResult = Helpers.ToMapAny(callbackRef01DataDt0Loaded is IEntity le ? le.Data() : callbackRef01DataDt0Loaded);
        Assert.True(callbackRef01DataDt0LoadResult != null, "expected load result to be a map");
        Assert.True(StructRunner.DeepEqual(callbackRef01DataDt0LoadResult!["id"], callbackRef01Data["id"]),
            "expected load result id to match");

        // REMOVE
        var callbackRef01MatchRm0 = new Dictionary<string, object?>
        {
            ["id"] = callbackRef01Data!["id"],
        };
        callbackRef01Ent.Remove(callbackRef01MatchRm0, null);

        // LIST
        var callbackRef01MatchRt0 = new Dictionary<string, object?>();

        var callbackRef01ListRt0Result = callbackRef01Ent.List(callbackRef01MatchRt0, null);
        var callbackRef01ListRt0 = callbackRef01ListRt0Result as List<object?>;
        Assert.True(callbackRef01ListRt0 != null,
            $"expected list result to be a list, got {callbackRef01ListRt0Result?.GetType()}");

        var callbackRef01ListRt0NotFound = StructUtils.Select(
            TestRunner.EntityListToData(callbackRef01ListRt0!),
            new Dictionary<string, object?> { ["id"] = callbackRef01Data!["id"] });
        Assert.True(StructUtils.IsEmpty(callbackRef01ListRt0NotFound),
            "expected removed entity to not be in list");

    }

    [Fact]
    public async Task Stream()
    {
        var setup = CallbackBasicSetup(new Dictionary<string, object?>
        {
            ["feature"] = new Dictionary<string, object?>
            {
                ["streaming"] = new Dictionary<string, object?> { ["active"] = true },
            },
        });
        if (setup.Live)
        {
            return; // unit mode only - streams the seeded fixture data
        }

        var ent = setup.Client.Callback();
        var match = new Dictionary<string, object?>();

        // Materialised list result for the same op.
        var listed = ent.List(match, null) as List<object?> ?? new List<object?>();

        // stream("list") yields items via the streaming feature's iterator.
        var streamed = new List<object?>();
        await foreach (var item in ent.Stream("list", match, null))
        {
            streamed.Add(item);
        }
        Assert.True(streamed.Count > 0, "expected stream to yield items");
        Assert.Equal(listed.Count, streamed.Count);

        // Fallback: with streaming inactive, stream still yields the
        // materialised items.
        var setup2 = CallbackBasicSetup(null);
        var ent2 = setup2.Client.Callback();
        var streamed2 = new List<object?>();
        await foreach (var item in ent2.Stream("list", match, null))
        {
            streamed2.Add(item);
        }
        Assert.Equal(listed.Count, streamed2.Count);
    }

    private static EntityTestSetup CallbackBasicSetup(
        Dictionary<string, object?>? extra)
    {
        TestRunner.LoadEnvLocal();

        var entityDataFile = Path.Combine(TestRunner.TestDir(),
            "..", "..", ".sdk", "test", "entity", "callback",
            "CallbackTestData.json");

        var entityDataEl = JsonSerializer.Deserialize<JsonElement>(
            File.ReadAllText(entityDataFile));
        var entityData = StructRunner.ConvertElement(entityDataEl)
            as Dictionary<string, object?>
            ?? throw new InvalidOperationException(
                "failed to parse callback test data");

        var options = new Dictionary<string, object?>
        {
            ["entity"] = entityData["existing"],
        };

        var client = SmsapiSDK.TestSDK(options, extra);

        // Generate idmap via transform, matching the TS pattern.
        var idmap = StructUtils.Transform(
            new List<object?> { "callback01", "callback02", "callback03" },
            new Dictionary<string, object?>
            {
                ["`$PACK`"] = new List<object?>
                {
                    "",
                    new Dictionary<string, object?>
                    {
                        ["`$KEY`"] = "`$COPY`",
                        ["`$VAL`"] = new List<object?> { "`$FORMAT`", "upper", "`$COPY`" },
                    },
                },
            });

        // Detect ENTID env override before EnvOverride consumes it. When
        // live mode is on without a real override, the basic test runs
        // against synthetic IDs from the fixture and 4xx's.
        var entidEnvRaw = Environment.GetEnvironmentVariable(
            "SMSAPI_TEST_CALLBACK_ENTID") ?? "";
        var idmapOverridden = entidEnvRaw != "" &&
            entidEnvRaw.Trim().StartsWith("{");

        var env = TestRunner.EnvOverride(new Dictionary<string, object?>
        {
            ["SMSAPI_TEST_CALLBACK_ENTID"] = idmap,
            ["SMSAPI_TEST_LIVE"] = "FALSE",
            ["SMSAPI_TEST_EXPLAIN"] = "FALSE",
            ["SMSAPI_APIKEY"] = "",
        });

        var idmapResolved = Helpers.ToMapAny(env["SMSAPI_TEST_CALLBACK_ENTID"])
            ?? Helpers.ToMapAny(idmap)
            ?? new Dictionary<string, object?>();

        if (Equals(env["SMSAPI_TEST_LIVE"], "TRUE"))
        {
            // 'extra ?? new ...', not a bare 'extra': Merge returns null when
            // the last entry is null, and BasicSetup is normally called with no
            // argument at all - so a bare 'extra' silently discarded the apikey
            // and server values above and handed the SDK null.
            var extraOpts = extra ?? new Dictionary<string, object?>();
            var mergedOpts = StructUtils.Merge(new List<object?>
            {
                // FIRST, so the generated fields below win: sdk-test-control.json's
                // test.client.options adds to the live client, it does not redirect it.
                TestRunner.LiveClientOptions(),
                new Dictionary<string, object?>
                {
                    ["apikey"] = env["SMSAPI_APIKEY"],
                },
                extraOpts,
            });
            client = new SmsapiSDK(Helpers.ToMapAny(mergedOpts));
        }

        var live = Equals(env["SMSAPI_TEST_LIVE"], "TRUE");
        return new EntityTestSetup
        {
            Client = client,
            Data = entityData,
            Idmap = idmapResolved,
            Env = env,
            Explain = Equals(env["SMSAPI_TEST_EXPLAIN"], "TRUE"),
            Live = live,
            SyntheticOnly = live && !idmapOverridden,
            Now = DateTimeOffset.UtcNow.ToUnixTimeMilliseconds(),
        };
    }
}
