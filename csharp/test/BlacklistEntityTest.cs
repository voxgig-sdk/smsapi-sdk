// blacklist entity test - basic flow (generated from the API model).

using System.Text.Json;

using Voxgig.Struct;
using Xunit;

namespace SmsapiSdk.Test;

public class BlacklistEntityTest
{
    [Fact]
    public void Instance()
    {
        var testsdk = SmsapiSDK.TestSDK(null, null);
        var ent = testsdk.Blacklist();
        Assert.NotNull(ent);
    }

    [Fact]
    public void Basic()
    {
        var setup = BlacklistBasicSetup(null);
        // Per-op sdk-test-control.json skip - basic test exercises a flow
        // with multiple ops; skipping any op skips the whole flow.
        var _mode = setup.Live ? "live" : "unit";
        foreach (var _op in new[] { "create", "load", "remove" })
        {
            var (_shouldSkip, _) = TestRunner.IsControlSkipped(
                "entityOp", "blacklist." + _op, _mode);
            if (_shouldSkip)
            {
                return; // skipped via sdk-test-control.json
            }
        }
        // The basic flow consumes synthetic IDs from the fixture. In live
        // mode without an *_ENTID env override, those IDs hit the live API
        // and 4xx; set SMSAPI_TEST_BLACKLIST_ENTID JSON to run live.
        if (setup.SyntheticOnly)
        {
            return;
        }
        var client = setup.Client;

        // CREATE
        var blacklistRef01Ent = client.Blacklist();
        var blacklistRef01Data = Helpers.ToMapAny(StructUtils.GetProp(
            StructUtils.GetPath(setup.Data, StructUtils.Jt("new", "blacklist")),
            "blacklist_ref01"));

        var blacklistRef01DataResult = blacklistRef01Ent.Create(blacklistRef01Data, null);
        blacklistRef01Data = Helpers.ToMapAny(blacklistRef01DataResult is IEntity ce ? ce.Data() : blacklistRef01DataResult);
        Assert.True(blacklistRef01Data != null, "expected create result to be a map");
        Assert.True(blacklistRef01Data!["id"] != null, "expected created entity to have an id");

        // LOAD
        var blacklistRef01MatchDt0 = new Dictionary<string, object?>
        {
            ["id"] = blacklistRef01Data!["id"],
        };
        var blacklistRef01DataDt0Loaded = blacklistRef01Ent.Load(blacklistRef01MatchDt0, null);
        var blacklistRef01DataDt0LoadResult = Helpers.ToMapAny(blacklistRef01DataDt0Loaded is IEntity le ? le.Data() : blacklistRef01DataDt0Loaded);
        Assert.True(blacklistRef01DataDt0LoadResult != null, "expected load result to be a map");
        Assert.True(StructRunner.DeepEqual(blacklistRef01DataDt0LoadResult!["id"], blacklistRef01Data["id"]),
            "expected load result id to match");

        // REMOVE
        var blacklistRef01MatchRm0 = new Dictionary<string, object?>
        {
            ["id"] = blacklistRef01Data!["id"],
        };
        blacklistRef01Ent.Remove(blacklistRef01MatchRm0, null);

    }

    private static EntityTestSetup BlacklistBasicSetup(
        Dictionary<string, object?>? extra)
    {
        TestRunner.LoadEnvLocal();

        var entityDataFile = Path.Combine(TestRunner.TestDir(),
            "..", "..", ".sdk", "test", "entity", "blacklist",
            "BlacklistTestData.json");

        var entityDataEl = JsonSerializer.Deserialize<JsonElement>(
            File.ReadAllText(entityDataFile));
        var entityData = StructRunner.ConvertElement(entityDataEl)
            as Dictionary<string, object?>
            ?? throw new InvalidOperationException(
                "failed to parse blacklist test data");

        var options = new Dictionary<string, object?>
        {
            ["entity"] = entityData["existing"],
        };

        var client = SmsapiSDK.TestSDK(options, extra);

        // Generate idmap via transform, matching the TS pattern.
        var idmap = StructUtils.Transform(
            new List<object?> { "blacklist01", "blacklist02", "blacklist03" },
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
            "SMSAPI_TEST_BLACKLIST_ENTID") ?? "";
        var idmapOverridden = entidEnvRaw != "" &&
            entidEnvRaw.Trim().StartsWith("{");

        var env = TestRunner.EnvOverride(new Dictionary<string, object?>
        {
            ["SMSAPI_TEST_BLACKLIST_ENTID"] = idmap,
            ["SMSAPI_TEST_LIVE"] = "FALSE",
            ["SMSAPI_TEST_EXPLAIN"] = "FALSE",
            ["SMSAPI_APIKEY"] = "",
        });

        var idmapResolved = Helpers.ToMapAny(env["SMSAPI_TEST_BLACKLIST_ENTID"])
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
