// template entity test - basic flow (generated from the API model).

using System.Text.Json;

using Voxgig.Struct;
using Xunit;

namespace SmsapiSdk.Test;

public class TemplateEntityTest
{
    [Fact]
    public void Instance()
    {
        var testsdk = SmsapiSDK.TestSDK(null, null);
        var ent = testsdk.Template();
        Assert.NotNull(ent);
    }

    [Fact]
    public void Basic()
    {
        var setup = TemplateBasicSetup(null);
        // Per-op sdk-test-control.json skip - basic test exercises a flow
        // with multiple ops; skipping any op skips the whole flow.
        var _mode = setup.Live ? "live" : "unit";
        foreach (var _op in new[] { "create", "list", "update", "load" })
        {
            var (_shouldSkip, _) = TestRunner.IsControlSkipped(
                "entityOp", "template." + _op, _mode);
            if (_shouldSkip)
            {
                return; // skipped via sdk-test-control.json
            }
        }
        // The basic flow consumes synthetic IDs from the fixture. In live
        // mode without an *_ENTID env override, those IDs hit the live API
        // and 4xx; set SMSAPI_TEST_TEMPLATE_ENTID JSON to run live.
        if (setup.SyntheticOnly)
        {
            return;
        }
        var client = setup.Client;

        // CREATE
        var templateRef01Ent = client.Template();
        var templateRef01Data = Helpers.ToMapAny(StructUtils.GetProp(
            StructUtils.GetPath(setup.Data, StructUtils.Jt("new", "template")),
            "template_ref01"));

        var templateRef01DataResult = templateRef01Ent.Create(templateRef01Data, null);
        templateRef01Data = Helpers.ToMapAny(templateRef01DataResult is IEntity ce ? ce.Data() : templateRef01DataResult);
        Assert.True(templateRef01Data != null, "expected create result to be a map");
        Assert.True(templateRef01Data!["id"] != null, "expected created entity to have an id");

        // LIST
        var templateRef01Match = new Dictionary<string, object?>();

        var templateRef01ListResult = templateRef01Ent.List(templateRef01Match, null);
        var templateRef01List = templateRef01ListResult as List<object?>;
        Assert.True(templateRef01List != null,
            $"expected list result to be a list, got {templateRef01ListResult?.GetType()}");

        var templateRef01ListFound = StructUtils.Select(
            TestRunner.EntityListToData(templateRef01List!),
            new Dictionary<string, object?> { ["id"] = templateRef01Data!["id"] });
        Assert.False(StructUtils.IsEmpty(templateRef01ListFound),
            "expected to find created entity in list");

        // UPDATE
        var templateRef01DataUp0Up = new Dictionary<string, object?>
        {
            ["id"] = templateRef01Data!["id"],
        };

        var templateRef01MarkdefUp0Name = "name";
        var templateRef01MarkdefUp0Value = $"Mark01-template_ref01_{setup.Now}";
        templateRef01DataUp0Up[templateRef01MarkdefUp0Name] = templateRef01MarkdefUp0Value;

        var templateRef01ResdataUp0Result = templateRef01Ent.Update(templateRef01DataUp0Up, null);
        var templateRef01ResdataUp0 = Helpers.ToMapAny(templateRef01ResdataUp0Result is IEntity ue ? ue.Data() : templateRef01ResdataUp0Result);
        Assert.True(templateRef01ResdataUp0 != null, "expected update result to be a map");
        Assert.True(StructRunner.DeepEqual(templateRef01ResdataUp0!["id"], templateRef01DataUp0Up["id"]),
            "expected update result id to match");
        Assert.True(Equals(templateRef01ResdataUp0![templateRef01MarkdefUp0Name], templateRef01MarkdefUp0Value),
            $"expected {templateRef01MarkdefUp0Name} to be updated, got {templateRef01ResdataUp0[templateRef01MarkdefUp0Name]}");

        // LOAD
        var templateRef01MatchDt0 = new Dictionary<string, object?>
        {
            ["id"] = templateRef01Data!["id"],
        };
        var templateRef01DataDt0Loaded = templateRef01Ent.Load(templateRef01MatchDt0, null);
        var templateRef01DataDt0LoadResult = Helpers.ToMapAny(templateRef01DataDt0Loaded is IEntity le ? le.Data() : templateRef01DataDt0Loaded);
        Assert.True(templateRef01DataDt0LoadResult != null, "expected load result to be a map");
        Assert.True(StructRunner.DeepEqual(templateRef01DataDt0LoadResult!["id"], templateRef01Data["id"]),
            "expected load result id to match");

    }

    [Fact]
    public async Task Stream()
    {
        var setup = TemplateBasicSetup(new Dictionary<string, object?>
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

        var ent = setup.Client.Template();
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
        var setup2 = TemplateBasicSetup(null);
        var ent2 = setup2.Client.Template();
        var streamed2 = new List<object?>();
        await foreach (var item in ent2.Stream("list", match, null))
        {
            streamed2.Add(item);
        }
        Assert.Equal(listed.Count, streamed2.Count);
    }

    private static EntityTestSetup TemplateBasicSetup(
        Dictionary<string, object?>? extra)
    {
        TestRunner.LoadEnvLocal();

        var entityDataFile = Path.Combine(TestRunner.TestDir(),
            "..", "..", ".sdk", "test", "entity", "template",
            "TemplateTestData.json");

        var entityDataEl = JsonSerializer.Deserialize<JsonElement>(
            File.ReadAllText(entityDataFile));
        var entityData = StructRunner.ConvertElement(entityDataEl)
            as Dictionary<string, object?>
            ?? throw new InvalidOperationException(
                "failed to parse template test data");

        var options = new Dictionary<string, object?>
        {
            ["entity"] = entityData["existing"],
        };

        var client = SmsapiSDK.TestSDK(options, extra);

        // Generate idmap via transform, matching the TS pattern.
        var idmap = StructUtils.Transform(
            new List<object?> { "template01", "template02", "template03" },
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
            "SMSAPI_TEST_TEMPLATE_ENTID") ?? "";
        var idmapOverridden = entidEnvRaw != "" &&
            entidEnvRaw.Trim().StartsWith("{");

        var env = TestRunner.EnvOverride(new Dictionary<string, object?>
        {
            ["SMSAPI_TEST_TEMPLATE_ENTID"] = idmap,
            ["SMSAPI_TEST_LIVE"] = "FALSE",
            ["SMSAPI_TEST_EXPLAIN"] = "FALSE",
            ["SMSAPI_APIKEY"] = "",
        });

        var idmapResolved = Helpers.ToMapAny(env["SMSAPI_TEST_TEMPLATE_ENTID"])
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
