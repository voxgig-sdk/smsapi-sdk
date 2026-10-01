// short_url entity test - basic flow (generated from the API model).

using System.Text.Json;

using Voxgig.Struct;
using Xunit;

namespace SmsapiSdk.Test;

public class ShortUrlEntityTest
{
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
        // The basic flow consumes synthetic IDs from the fixture. In live
        // mode without an *_ENTID env override, those IDs hit the live API
        // and 4xx; set SMSAPI_TEST_SHORT_URL_ENTID JSON to run live.
        if (setup.SyntheticOnly)
        {
            return;
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

        // Detect ENTID env override before EnvOverride consumes it. When
        // live mode is on without a real override, the basic test runs
        // against synthetic IDs from the fixture and 4xx's.
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
