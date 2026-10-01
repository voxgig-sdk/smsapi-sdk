// group entity test - basic flow (generated from the API model).

using System.Text.Json;

using Voxgig.Struct;
using Xunit;

namespace SmsapiSdk.Test;

public class GroupEntityTest
{
    [Fact]
    public void Instance()
    {
        var testsdk = SmsapiSDK.TestSDK(null, null);
        var ent = testsdk.Group();
        Assert.NotNull(ent);
    }

    [Fact]
    public void Basic()
    {
        var setup = GroupBasicSetup(null);
        // Per-op sdk-test-control.json skip - basic test exercises a flow
        // with multiple ops; skipping any op skips the whole flow.
        var _mode = setup.Live ? "live" : "unit";
        foreach (var _op in new[] { "update", "load" })
        {
            var (_shouldSkip, _) = TestRunner.IsControlSkipped(
                "entityOp", "group." + _op, _mode);
            if (_shouldSkip)
            {
                return; // skipped via sdk-test-control.json
            }
        }
        // The basic flow consumes synthetic IDs from the fixture. In live
        // mode without an *_ENTID env override, those IDs hit the live API
        // and 4xx; set SMSAPI_TEST_GROUP_ENTID JSON to run live.
        if (setup.SyntheticOnly)
        {
            return;
        }
        var client = setup.Client;

        // Bootstrap entity data from existing test data (no create step in flow).
        var groupRef01DataRaw = StructUtils.Items(
            Helpers.ToMapAny(StructUtils.GetPath(setup.Data, "existing.group")));
        var groupRef01Data = groupRef01DataRaw.Count > 0
            ? Helpers.ToMapAny(groupRef01DataRaw[0][1])
            : null;

        // UPDATE
        var groupRef01Ent = client.Group();
        var groupRef01DataUp0Up = new Dictionary<string, object?>
        {
            ["id"] = groupRef01Data!["id"],
        };

        var groupRef01MarkdefUp0Name = "created_by";
        var groupRef01MarkdefUp0Value = $"Mark01-group_ref01_{setup.Now}";
        groupRef01DataUp0Up[groupRef01MarkdefUp0Name] = groupRef01MarkdefUp0Value;

        var groupRef01ResdataUp0Result = groupRef01Ent.Update(groupRef01DataUp0Up, null);
        var groupRef01ResdataUp0 = Helpers.ToMapAny(groupRef01ResdataUp0Result is IEntity ue ? ue.Data() : groupRef01ResdataUp0Result);
        Assert.True(groupRef01ResdataUp0 != null, "expected update result to be a map");
        Assert.True(StructRunner.DeepEqual(groupRef01ResdataUp0!["id"], groupRef01DataUp0Up["id"]),
            "expected update result id to match");
        Assert.True(Equals(groupRef01ResdataUp0![groupRef01MarkdefUp0Name], groupRef01MarkdefUp0Value),
            $"expected {groupRef01MarkdefUp0Name} to be updated, got {groupRef01ResdataUp0[groupRef01MarkdefUp0Name]}");

        // LOAD
        var groupRef01MatchDt0 = new Dictionary<string, object?>
        {
            ["id"] = groupRef01Data!["id"],
        };
        var groupRef01DataDt0Loaded = groupRef01Ent.Load(groupRef01MatchDt0, null);
        var groupRef01DataDt0LoadResult = Helpers.ToMapAny(groupRef01DataDt0Loaded is IEntity le ? le.Data() : groupRef01DataDt0Loaded);
        Assert.True(groupRef01DataDt0LoadResult != null, "expected load result to be a map");
        Assert.True(StructRunner.DeepEqual(groupRef01DataDt0LoadResult!["id"], groupRef01Data["id"]),
            "expected load result id to match");

    }

    private static EntityTestSetup GroupBasicSetup(
        Dictionary<string, object?>? extra)
    {
        TestRunner.LoadEnvLocal();

        var entityDataFile = Path.Combine(TestRunner.TestDir(),
            "..", "..", ".sdk", "test", "entity", "group",
            "GroupTestData.json");

        var entityDataEl = JsonSerializer.Deserialize<JsonElement>(
            File.ReadAllText(entityDataFile));
        var entityData = StructRunner.ConvertElement(entityDataEl)
            as Dictionary<string, object?>
            ?? throw new InvalidOperationException(
                "failed to parse group test data");

        var options = new Dictionary<string, object?>
        {
            ["entity"] = entityData["existing"],
        };

        var client = SmsapiSDK.TestSDK(options, extra);

        // Generate idmap via transform, matching the TS pattern.
        var idmap = StructUtils.Transform(
            new List<object?> { "group01", "group02", "group03" },
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
            "SMSAPI_TEST_GROUP_ENTID") ?? "";
        var idmapOverridden = entidEnvRaw != "" &&
            entidEnvRaw.Trim().StartsWith("{");

        var env = TestRunner.EnvOverride(new Dictionary<string, object?>
        {
            ["SMSAPI_TEST_GROUP_ENTID"] = idmap,
            ["SMSAPI_TEST_LIVE"] = "FALSE",
            ["SMSAPI_TEST_EXPLAIN"] = "FALSE",
            ["SMSAPI_APIKEY"] = "",
        });

        var idmapResolved = Helpers.ToMapAny(env["SMSAPI_TEST_GROUP_ENTID"])
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
