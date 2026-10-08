// short_url entity test - basic flow (generated from the API model).

using System.Text.Json;

using SmsapiSdk.Feature;
using Voxgig.Struct;
using Xunit;

namespace SmsapiSdk.Test;

public class ShortUrlEntityTest
{
    // main.kit.test.live.strict is true (the default is true): a live
    // request that fails, or a live test missing an input it needs,
    // fails the test.
    // An account with no record for a test to read skips it either way.
    private const bool LIVE_STRICT = true;

    [Fact]
    public void Instance()
    {
        var testsdk = SmsapiSDK.TestSDK(null, null);
        var ent = testsdk.ShortUrl();
        Assert.NotNull(ent);
    }

    [Fact]
    public void Basic()
    {
        var setup = ShortUrlBasicSetup(null);
        // Per-op sdk-test-control.json skip - basic test exercises a flow
        // with multiple ops; skipping any op skips the whole flow.
        var _mode = setup.Live ? "live" : "unit";
        foreach (var _op in new[] { "create", "list", "update", "load", "remove" })
        {
            var (_shouldSkip, _) = TestRunner.IsControlSkipped(
                "entityOp", "short_url." + _op, _mode);
            if (_shouldSkip)
            {
                return; // skipped via sdk-test-control.json
            }
        }
        var client = setup.Client;

        // CREATE
        var shortUrlRef01Ent = client.ShortUrl();
        var shortUrlRef01Data = Helpers.ToMapAny(StructUtils.GetProp(
            StructUtils.GetPath(setup.Data, StructUtils.Jt("new", "short_url")),
            "short_url_ref01"));

        var shortUrlRef01DataResult = shortUrlRef01Ent.Create(shortUrlRef01Data, null);
        shortUrlRef01Data = Helpers.ToMapAny(shortUrlRef01DataResult is IEntity ce ? ce.Data() : shortUrlRef01DataResult);
        Assert.True(shortUrlRef01Data != null, "expected create result to be a map");
        Assert.True(shortUrlRef01Data!["id"] != null, "expected created entity to have an id");

        // LIST
        var shortUrlRef01Match = new Dictionary<string, object?>();

        var shortUrlRef01ListResult = shortUrlRef01Ent.List(shortUrlRef01Match, null);
        var shortUrlRef01List = shortUrlRef01ListResult as List<object?>;
        Assert.True(shortUrlRef01List != null,
            $"expected list result to be a list, got {shortUrlRef01ListResult?.GetType()}");

        var shortUrlRef01ListFound = StructUtils.Select(
            TestRunner.EntityListToData(shortUrlRef01List!),
            new Dictionary<string, object?> { ["id"] = shortUrlRef01Data!["id"] });
        Assert.False(StructUtils.IsEmpty(shortUrlRef01ListFound),
            "expected to find created entity in list");

        // UPDATE
        var shortUrlRef01DataUp0Up = new Dictionary<string, object?>
        {
            ["id"] = shortUrlRef01Data!["id"],
        };

        var shortUrlRef01MarkdefUp0Name = "description";
        var shortUrlRef01MarkdefUp0Value = $"Mark01-short_url_ref01_{setup.Now}";
        shortUrlRef01DataUp0Up[shortUrlRef01MarkdefUp0Name] = shortUrlRef01MarkdefUp0Value;

        var shortUrlRef01ResdataUp0Result = shortUrlRef01Ent.Update(shortUrlRef01DataUp0Up, null);
        var shortUrlRef01ResdataUp0 = Helpers.ToMapAny(shortUrlRef01ResdataUp0Result is IEntity ue ? ue.Data() : shortUrlRef01ResdataUp0Result);
        Assert.True(shortUrlRef01ResdataUp0 != null, "expected update result to be a map");
        Assert.True(StructRunner.DeepEqual(shortUrlRef01ResdataUp0!["id"], shortUrlRef01DataUp0Up["id"]),
            "expected update result id to match");
        Assert.True(Equals(shortUrlRef01ResdataUp0![shortUrlRef01MarkdefUp0Name], shortUrlRef01MarkdefUp0Value),
            $"expected {shortUrlRef01MarkdefUp0Name} to be updated, got {shortUrlRef01ResdataUp0[shortUrlRef01MarkdefUp0Name]}");

        // LOAD
        var shortUrlRef01MatchDt0 = new Dictionary<string, object?>
        {
            ["id"] = shortUrlRef01Data!["id"],
        };
        var shortUrlRef01DataDt0Loaded = shortUrlRef01Ent.Load(shortUrlRef01MatchDt0, null);
        var shortUrlRef01DataDt0LoadResult = Helpers.ToMapAny(shortUrlRef01DataDt0Loaded is IEntity le ? le.Data() : shortUrlRef01DataDt0Loaded);
        Assert.True(shortUrlRef01DataDt0LoadResult != null, "expected load result to be a map");
        Assert.True(StructRunner.DeepEqual(shortUrlRef01DataDt0LoadResult!["id"], shortUrlRef01Data["id"]),
            "expected load result id to match");

        // REMOVE
        var shortUrlRef01MatchRm0 = new Dictionary<string, object?>
        {
            ["id"] = shortUrlRef01Data!["id"],
        };
        shortUrlRef01Ent.Remove(shortUrlRef01MatchRm0, null);

        // LIST
        var shortUrlRef01MatchRt0 = new Dictionary<string, object?>();

        var shortUrlRef01ListRt0Result = shortUrlRef01Ent.List(shortUrlRef01MatchRt0, null);
        var shortUrlRef01ListRt0 = shortUrlRef01ListRt0Result as List<object?>;
        Assert.True(shortUrlRef01ListRt0 != null,
            $"expected list result to be a list, got {shortUrlRef01ListRt0Result?.GetType()}");

        var shortUrlRef01ListRt0NotFound = StructUtils.Select(
            TestRunner.EntityListToData(shortUrlRef01ListRt0!),
            new Dictionary<string, object?> { ["id"] = shortUrlRef01Data!["id"] });
        Assert.True(StructUtils.IsEmpty(shortUrlRef01ListRt0NotFound),
            "expected removed entity to not be in list");

    }

    [Fact]
    public async Task Stream()
    {
        var setup = ShortUrlBasicSetup(new Dictionary<string, object?>
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

        var ent = setup.Client.ShortUrl();
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
        var setup2 = ShortUrlBasicSetup(null);
        var ent2 = setup2.Client.ShortUrl();
        var streamed2 = new List<object?>();
        await foreach (var item in ent2.Stream("list", match, null))
        {
            streamed2.Add(item);
        }
        Assert.Equal(listed.Count, streamed2.Count);
    }

    private sealed class FailHook : BaseFeature
    {
        public int Unexpected;

        public FailHook()
        {
            Name = "failhook";
            Version = "0.0.1";
            Active = true;
        }

        public override void PreSpec(Context ctx) =>
            throw new Exception("short_url hook failed");

        public override void PreUnexpected(Context ctx) => Unexpected++;
    }

    [Fact]
    public async Task StreamError()
    {
        var offline = new Dictionary<string, object?> { ["net"] = new Dictionary<string, object?> { ["offline"] = true } };
        var err = await Assert.ThrowsAnyAsync<Exception>(async () =>
        {
            await foreach (var _ in SmsapiSDK.TestSDK(offline, null).ShortUrl().Stream("list", null, null)) { }
        });
        Assert.Contains("offline", err.Message);

        await foreach (var _ in SmsapiSDK.TestSDK(offline, null).ShortUrl().Stream("list", null,
            new Dictionary<string, object?> { ["ctrl"] = new Dictionary<string, object?> { ["throw"] = false } })) { }

        if (Fh.HasFeature("rbac"))
        {
            var denied = SmsapiSDK.TestSDK(null,
                new Dictionary<string, object?> { ["feature"] = new Dictionary<string, object?> { ["rbac"] = new Dictionary<string, object?> { ["active"] = true, ["deny"] = true } } });
            var denyerr = await Assert.ThrowsAnyAsync<SmsapiError>(async () =>
            {
                await foreach (var _ in denied.ShortUrl().Stream("list", null, null)) { }
            });
            Assert.Equal("rbac_denied", denyerr.Code);
        }
    }

    [Fact]
    public async Task StreamCtrl()
    {
        var explain = new Dictionary<string, object?>();
        var ctrl = new Dictionary<string, object?> { ["explain"] = explain };
        await foreach (var _ in SmsapiSDK.TestSDK(null, null).ShortUrl().Stream("list", null,
            new Dictionary<string, object?> { ["ctrl"] = ctrl })) { }
        Assert.Equal(new[] { "explain" }, ctrl.Keys.ToArray());
        Assert.Same(explain, ctrl["explain"]);
        Assert.NotEmpty(explain);
    }

    [Fact]
    public void Unexpected()
    {
        var hook = new FailHook();
        var client = new SmsapiSDK(new Dictionary<string, object?>
        {
            ["feature"] = new Dictionary<string, object?> { ["test"] = new Dictionary<string, object?> { ["active"] = true } },
            ["extend"] = new List<object?> { hook },
        });

        var err = Assert.ThrowsAny<Exception>(() => client.ShortUrl().List(null, null));
        Assert.Contains("hook failed", err.Message);
        Assert.True(hook.Unexpected > 0);

        var fired = hook.Unexpected;
        client.ShortUrl().List(null, new Dictionary<string, object?> { ["throw"] = false });
        Assert.True(hook.Unexpected > fired);
    }

    [Fact]
    public void Validate()
    {
        if (!Fh.HasFeature("validate"))
        {
            Console.WriteLine("skip: feature not present in this SDK: validate");
            return;
        }
        var client = SmsapiSDK.TestSDK(null,
            new Dictionary<string, object?> { ["feature"] = new Dictionary<string, object?> { ["validate"] = new Dictionary<string, object?> { ["active"] = true } } });
        var err = Assert.ThrowsAny<SmsapiError>(() => client.ShortUrl().List(
            new Dictionary<string, object?> { ["description"] = 1 }, null));
        Assert.Equal("validate_failed", err.Code);
    }

    private static EntityTestSetup ShortUrlBasicSetup(
        Dictionary<string, object?>? extra)
    {
        TestRunner.LoadEnvLocal();

        var entityDataFile = Path.Combine(TestRunner.TestDir(),
            "..", "..", ".sdk", "test", "entity", "short_url",
            "ShortUrlTestData.json");

        var entityDataEl = JsonSerializer.Deserialize<JsonElement>(
            File.ReadAllText(entityDataFile));
        var entityData = StructRunner.ConvertElement(entityDataEl)
            as Dictionary<string, object?>
            ?? throw new InvalidOperationException(
                "failed to parse short_url test data");

        var options = new Dictionary<string, object?>
        {
            ["entity"] = entityData["existing"],
        };

        var client = SmsapiSDK.TestSDK(options, extra);

        // Generate idmap via transform, matching the TS pattern.
        var idmap = StructUtils.Transform(
            new List<object?> { "short_url01", "short_url02", "short_url03" },
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

        // Whether *_ENTID supplied the idmap, read before EnvOverride consumes
        // it: without it, the ids a live flow binds are the fixture's synthetic ones.
        var entidEnvRaw = Environment.GetEnvironmentVariable(
            "SMSAPI_TEST_SHORT_URL_ENTID") ?? "";
        var idmapOverridden = entidEnvRaw != "" &&
            entidEnvRaw.Trim().StartsWith("{");

        var env = TestRunner.EnvOverride(new Dictionary<string, object?>
        {
            ["SMSAPI_TEST_SHORT_URL_ENTID"] = idmap,
            ["SMSAPI_TEST_LIVE"] = "FALSE",
            ["SMSAPI_TEST_EXPLAIN"] = "FALSE",
            ["SMSAPI_APIKEY"] = "",
        });

        var idmapResolved = Helpers.ToMapAny(env["SMSAPI_TEST_SHORT_URL_ENTID"])
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
