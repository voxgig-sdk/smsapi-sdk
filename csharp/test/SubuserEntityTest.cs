// subuser entity test - basic flow (generated from the API model).

using System.Text.Json;

using SmsapiSdk.Feature;
using Voxgig.Struct;
using Xunit;

namespace SmsapiSdk.Test;

public class SubuserEntityTest
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
        var ent = testsdk.Subuser();
        Assert.NotNull(ent);
    }

    [Fact]
    public void Basic()
    {
        var setup = SubuserBasicSetup(null);
        // Per-op sdk-test-control.json skip - basic test exercises a flow
        // with multiple ops; skipping any op skips the whole flow.
        var _mode = setup.Live ? "live" : "unit";
        foreach (var _op in new[] { "create", "list", "update", "load", "remove" })
        {
            var (_shouldSkip, _) = TestRunner.IsControlSkipped(
                "entityOp", "subuser." + _op, _mode);
            if (_shouldSkip)
            {
                return; // skipped via sdk-test-control.json
            }
        }
        var client = setup.Client;

        // CREATE
        var subuserRef01Ent = client.Subuser();
        var subuserRef01Data = Helpers.ToMapAny(StructUtils.GetProp(
            StructUtils.GetPath(setup.Data, StructUtils.Jt("new", "subuser")),
            "subuser_ref01"));

        var subuserRef01DataResult = subuserRef01Ent.Create(subuserRef01Data, null);
        subuserRef01Data = Helpers.ToMapAny(subuserRef01DataResult is IEntity ce ? ce.Data() : subuserRef01DataResult);
        Assert.True(subuserRef01Data != null, "expected create result to be a map");
        Assert.True(subuserRef01Data!["id"] != null, "expected created entity to have an id");

        // LIST
        var subuserRef01Match = new Dictionary<string, object?>();

        var subuserRef01ListResult = subuserRef01Ent.List(subuserRef01Match, null);
        var subuserRef01List = subuserRef01ListResult as List<object?>;
        Assert.True(subuserRef01List != null,
            $"expected list result to be a list, got {subuserRef01ListResult?.GetType()}");

        var subuserRef01ListFound = StructUtils.Select(
            TestRunner.EntityListToData(subuserRef01List!),
            new Dictionary<string, object?> { ["id"] = subuserRef01Data!["id"] });
        Assert.False(StructUtils.IsEmpty(subuserRef01ListFound),
            "expected to find created entity in list");

        // UPDATE
        var subuserRef01DataUp0Up = new Dictionary<string, object?>
        {
            ["id"] = subuserRef01Data!["id"],
        };

        var subuserRef01MarkdefUp0Name = "description";
        var subuserRef01MarkdefUp0Value = $"Mark01-subuser_ref01_{setup.Now}";
        subuserRef01DataUp0Up[subuserRef01MarkdefUp0Name] = subuserRef01MarkdefUp0Value;

        var subuserRef01ResdataUp0Result = subuserRef01Ent.Update(subuserRef01DataUp0Up, null);
        var subuserRef01ResdataUp0 = Helpers.ToMapAny(subuserRef01ResdataUp0Result is IEntity ue ? ue.Data() : subuserRef01ResdataUp0Result);
        Assert.True(subuserRef01ResdataUp0 != null, "expected update result to be a map");
        Assert.True(StructRunner.DeepEqual(subuserRef01ResdataUp0!["id"], subuserRef01DataUp0Up["id"]),
            "expected update result id to match");
        Assert.True(Equals(subuserRef01ResdataUp0![subuserRef01MarkdefUp0Name], subuserRef01MarkdefUp0Value),
            $"expected {subuserRef01MarkdefUp0Name} to be updated, got {subuserRef01ResdataUp0[subuserRef01MarkdefUp0Name]}");

        // LOAD
        var subuserRef01MatchDt0 = new Dictionary<string, object?>
        {
            ["id"] = subuserRef01Data!["id"],
        };
        var subuserRef01DataDt0Loaded = subuserRef01Ent.Load(subuserRef01MatchDt0, null);
        var subuserRef01DataDt0LoadResult = Helpers.ToMapAny(subuserRef01DataDt0Loaded is IEntity le ? le.Data() : subuserRef01DataDt0Loaded);
        Assert.True(subuserRef01DataDt0LoadResult != null, "expected load result to be a map");
        Assert.True(StructRunner.DeepEqual(subuserRef01DataDt0LoadResult!["id"], subuserRef01Data["id"]),
            "expected load result id to match");

        // REMOVE
        var subuserRef01MatchRm0 = new Dictionary<string, object?>
        {
            ["id"] = subuserRef01Data!["id"],
        };
        subuserRef01Ent.Remove(subuserRef01MatchRm0, null);

        // LIST
        var subuserRef01MatchRt0 = new Dictionary<string, object?>();

        var subuserRef01ListRt0Result = subuserRef01Ent.List(subuserRef01MatchRt0, null);
        var subuserRef01ListRt0 = subuserRef01ListRt0Result as List<object?>;
        Assert.True(subuserRef01ListRt0 != null,
            $"expected list result to be a list, got {subuserRef01ListRt0Result?.GetType()}");

        var subuserRef01ListRt0NotFound = StructUtils.Select(
            TestRunner.EntityListToData(subuserRef01ListRt0!),
            new Dictionary<string, object?> { ["id"] = subuserRef01Data!["id"] });
        Assert.True(StructUtils.IsEmpty(subuserRef01ListRt0NotFound),
            "expected removed entity to not be in list");

    }

    [Fact]
    public async Task Stream()
    {
        var setup = SubuserBasicSetup(new Dictionary<string, object?>
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

        var ent = setup.Client.Subuser();
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
        var setup2 = SubuserBasicSetup(null);
        var ent2 = setup2.Client.Subuser();
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
            throw new Exception("subuser hook failed");

        public override void PreUnexpected(Context ctx) => Unexpected++;
    }

    [Fact]
    public async Task StreamError()
    {
        var offline = new Dictionary<string, object?> { ["net"] = new Dictionary<string, object?> { ["offline"] = true } };
        var err = await Assert.ThrowsAnyAsync<Exception>(async () =>
        {
            await foreach (var _ in SmsapiSDK.TestSDK(offline, null).Subuser().Stream("list", null, null)) { }
        });
        Assert.Contains("offline", err.Message);

        await foreach (var _ in SmsapiSDK.TestSDK(offline, null).Subuser().Stream("list", null,
            new Dictionary<string, object?> { ["ctrl"] = new Dictionary<string, object?> { ["throw"] = false } })) { }

        if (Fh.HasFeature("rbac"))
        {
            var denied = SmsapiSDK.TestSDK(null,
                new Dictionary<string, object?> { ["feature"] = new Dictionary<string, object?> { ["rbac"] = new Dictionary<string, object?> { ["active"] = true, ["deny"] = true } } });
            var denyerr = await Assert.ThrowsAnyAsync<SmsapiError>(async () =>
            {
                await foreach (var _ in denied.Subuser().Stream("list", null, null)) { }
            });
            Assert.Equal("rbac_denied", denyerr.Code);
        }
    }

    [Fact]
    public async Task StreamCtrl()
    {
        var explain = new Dictionary<string, object?>();
        var ctrl = new Dictionary<string, object?> { ["explain"] = explain };
        await foreach (var _ in SmsapiSDK.TestSDK(null, null).Subuser().Stream("list", null,
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

        var err = Assert.ThrowsAny<Exception>(() => client.Subuser().List(null, null));
        Assert.Contains("hook failed", err.Message);
        Assert.True(hook.Unexpected > 0);

        var fired = hook.Unexpected;
        client.Subuser().List(null, new Dictionary<string, object?> { ["throw"] = false });
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
        var err = Assert.ThrowsAny<SmsapiError>(() => client.Subuser().List(
            new Dictionary<string, object?> { ["q"] = 1 }, null));
        Assert.Equal("validate_failed", err.Code);
    }

    private static EntityTestSetup SubuserBasicSetup(
        Dictionary<string, object?>? extra)
    {
        TestRunner.LoadEnvLocal();

        var entityDataFile = Path.Combine(TestRunner.TestDir(),
            "..", "..", ".sdk", "test", "entity", "subuser",
            "SubuserTestData.json");

        var entityDataEl = JsonSerializer.Deserialize<JsonElement>(
            File.ReadAllText(entityDataFile));
        var entityData = StructRunner.ConvertElement(entityDataEl)
            as Dictionary<string, object?>
            ?? throw new InvalidOperationException(
                "failed to parse subuser test data");

        var options = new Dictionary<string, object?>
        {
            ["entity"] = entityData["existing"],
        };

        var client = SmsapiSDK.TestSDK(options, extra);

        // Generate idmap via transform, matching the TS pattern.
        var idmap = StructUtils.Transform(
            new List<object?> { "subuser01", "subuser02", "subuser03" },
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
            "SMSAPI_TEST_SUBUSER_ENTID") ?? "";
        var idmapOverridden = entidEnvRaw != "" &&
            entidEnvRaw.Trim().StartsWith("{");

        var env = TestRunner.EnvOverride(new Dictionary<string, object?>
        {
            ["SMSAPI_TEST_SUBUSER_ENTID"] = idmap,
            ["SMSAPI_TEST_LIVE"] = "FALSE",
            ["SMSAPI_TEST_EXPLAIN"] = "FALSE",
            ["SMSAPI_APIKEY"] = "",
        });

        var idmapResolved = Helpers.ToMapAny(env["SMSAPI_TEST_SUBUSER_ENTID"])
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
