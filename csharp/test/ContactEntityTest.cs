// contact entity test - basic flow (generated from the API model).

using System.Text.Json;

using SmsapiSdk.Feature;
using Voxgig.Struct;
using Xunit;

namespace SmsapiSdk.Test;

public class ContactEntityTest
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
        var ent = testsdk.Contact();
        Assert.NotNull(ent);
    }

    [Fact]
    public void Basic()
    {
        var setup = ContactBasicSetup(null);
        // Per-op sdk-test-control.json skip - basic test exercises a flow
        // with multiple ops; skipping any op skips the whole flow.
        var _mode = setup.Live ? "live" : "unit";
        foreach (var _op in new[] { "create", "list", "update", "load", "remove" })
        {
            var (_shouldSkip, _) = TestRunner.IsControlSkipped(
                "entityOp", "contact." + _op, _mode);
            if (_shouldSkip)
            {
                return; // skipped via sdk-test-control.json
            }
        }
        if (setup.Live)
        {
            foreach (var liveKey in new[] { "group01" })
            {
                if (setup.SyntheticOnly || StructUtils.GetProp(setup.Idmap, liveKey) == null)
                {
                    TestRunner.LiveMiss(LIVE_STRICT, "Live entity test blocked: needs " + liveKey + " via SMSAPI_TEST_CONTACT_ENTID");
                    return;
                }
            }
        }
        var client = setup.Client;

        // CREATE
        var contactRef01Ent = client.Contact();
        var contactRef01Data = Helpers.ToMapAny(StructUtils.GetProp(
            StructUtils.GetPath(setup.Data, StructUtils.Jt("new", "contact")),
            "contact_ref01"));
        contactRef01Data!["group_id"] = setup.Idmap["group01"];

        var contactRef01DataResult = contactRef01Ent.Create(contactRef01Data, null);
        contactRef01Data = Helpers.ToMapAny(contactRef01DataResult is IEntity ce ? ce.Data() : contactRef01DataResult);
        Assert.True(contactRef01Data != null, "expected create result to be a map");
        Assert.True(contactRef01Data!["id"] != null, "expected created entity to have an id");

        // LIST
        var contactRef01Match = new Dictionary<string, object?>();

        var contactRef01ListResult = contactRef01Ent.List(contactRef01Match, null);
        var contactRef01List = contactRef01ListResult as List<object?>;
        Assert.True(contactRef01List != null,
            $"expected list result to be a list, got {contactRef01ListResult?.GetType()}");

        var contactRef01ListFound = StructUtils.Select(
            TestRunner.EntityListToData(contactRef01List!),
            new Dictionary<string, object?> { ["id"] = contactRef01Data!["id"] });
        Assert.False(StructUtils.IsEmpty(contactRef01ListFound),
            "expected to find created entity in list");

        // UPDATE
        var contactRef01DataUp0Up = new Dictionary<string, object?>
        {
            ["id"] = contactRef01Data!["id"],
        };

        var contactRef01MarkdefUp0Name = "birthday_date";
        var contactRef01MarkdefUp0Value = $"Mark01-contact_ref01_{setup.Now}";
        contactRef01DataUp0Up[contactRef01MarkdefUp0Name] = contactRef01MarkdefUp0Value;

        var contactRef01ResdataUp0Result = contactRef01Ent.Update(contactRef01DataUp0Up, null);
        var contactRef01ResdataUp0 = Helpers.ToMapAny(contactRef01ResdataUp0Result is IEntity ue ? ue.Data() : contactRef01ResdataUp0Result);
        Assert.True(contactRef01ResdataUp0 != null, "expected update result to be a map");
        Assert.True(StructRunner.DeepEqual(contactRef01ResdataUp0!["id"], contactRef01DataUp0Up["id"]),
            "expected update result id to match");
        Assert.True(Equals(contactRef01ResdataUp0![contactRef01MarkdefUp0Name], contactRef01MarkdefUp0Value),
            $"expected {contactRef01MarkdefUp0Name} to be updated, got {contactRef01ResdataUp0[contactRef01MarkdefUp0Name]}");

        // LOAD
        var contactRef01MatchDt0 = new Dictionary<string, object?>
        {
            ["id"] = contactRef01Data!["id"],
        };
        var contactRef01DataDt0Loaded = contactRef01Ent.Load(contactRef01MatchDt0, null);
        var contactRef01DataDt0LoadResult = Helpers.ToMapAny(contactRef01DataDt0Loaded is IEntity le ? le.Data() : contactRef01DataDt0Loaded);
        Assert.True(contactRef01DataDt0LoadResult != null, "expected load result to be a map");
        Assert.True(StructRunner.DeepEqual(contactRef01DataDt0LoadResult!["id"], contactRef01Data["id"]),
            "expected load result id to match");

        // REMOVE
        var contactRef01MatchRm0 = new Dictionary<string, object?>
        {
            ["id"] = contactRef01Data!["id"],
        };
        contactRef01Ent.Remove(contactRef01MatchRm0, null);

        // LIST
        var contactRef01MatchRt0 = new Dictionary<string, object?>();

        var contactRef01ListRt0Result = contactRef01Ent.List(contactRef01MatchRt0, null);
        var contactRef01ListRt0 = contactRef01ListRt0Result as List<object?>;
        Assert.True(contactRef01ListRt0 != null,
            $"expected list result to be a list, got {contactRef01ListRt0Result?.GetType()}");

        var contactRef01ListRt0NotFound = StructUtils.Select(
            TestRunner.EntityListToData(contactRef01ListRt0!),
            new Dictionary<string, object?> { ["id"] = contactRef01Data!["id"] });
        Assert.True(StructUtils.IsEmpty(contactRef01ListRt0NotFound),
            "expected removed entity to not be in list");

    }

    [Fact]
    public async Task Stream()
    {
        var setup = ContactBasicSetup(new Dictionary<string, object?>
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

        var ent = setup.Client.Contact();
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
        var setup2 = ContactBasicSetup(null);
        var ent2 = setup2.Client.Contact();
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
            throw new Exception("contact hook failed");

        public override void PreUnexpected(Context ctx) => Unexpected++;
    }

    [Fact]
    public async Task StreamError()
    {
        var offline = new Dictionary<string, object?> { ["net"] = new Dictionary<string, object?> { ["offline"] = true } };
        var err = await Assert.ThrowsAnyAsync<Exception>(async () =>
        {
            await foreach (var _ in SmsapiSDK.TestSDK(offline, null).Contact().Stream("list", null, null)) { }
        });
        Assert.Contains("offline", err.Message);

        await foreach (var _ in SmsapiSDK.TestSDK(offline, null).Contact().Stream("list", null,
            new Dictionary<string, object?> { ["ctrl"] = new Dictionary<string, object?> { ["throw"] = false } })) { }

        if (Fh.HasFeature("rbac"))
        {
            var denied = SmsapiSDK.TestSDK(null,
                new Dictionary<string, object?> { ["feature"] = new Dictionary<string, object?> { ["rbac"] = new Dictionary<string, object?> { ["active"] = true, ["deny"] = true } } });
            var denyerr = await Assert.ThrowsAnyAsync<SmsapiError>(async () =>
            {
                await foreach (var _ in denied.Contact().Stream("list", null, null)) { }
            });
            Assert.Equal("rbac_denied", denyerr.Code);
        }
    }

    [Fact]
    public async Task StreamCtrl()
    {
        var explain = new Dictionary<string, object?>();
        var ctrl = new Dictionary<string, object?> { ["explain"] = explain };
        await foreach (var _ in SmsapiSDK.TestSDK(null, null).Contact().Stream("list", null,
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

        var err = Assert.ThrowsAny<Exception>(() => client.Contact().List(null, null));
        Assert.Contains("hook failed", err.Message);
        Assert.True(hook.Unexpected > 0);

        var fired = hook.Unexpected;
        client.Contact().List(null, new Dictionary<string, object?> { ["throw"] = false });
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
        var err = Assert.ThrowsAny<SmsapiError>(() => client.Contact().List(
            new Dictionary<string, object?> { ["gender"] = 1 }, null));
        Assert.Equal("validate_failed", err.Code);
    }

    private static EntityTestSetup ContactBasicSetup(
        Dictionary<string, object?>? extra)
    {
        TestRunner.LoadEnvLocal();

        var entityDataFile = Path.Combine(TestRunner.TestDir(),
            "..", "..", ".sdk", "test", "entity", "contact",
            "ContactTestData.json");

        var entityDataEl = JsonSerializer.Deserialize<JsonElement>(
            File.ReadAllText(entityDataFile));
        var entityData = StructRunner.ConvertElement(entityDataEl)
            as Dictionary<string, object?>
            ?? throw new InvalidOperationException(
                "failed to parse contact test data");

        var options = new Dictionary<string, object?>
        {
            ["entity"] = entityData["existing"],
        };

        var client = SmsapiSDK.TestSDK(options, extra);

        // Generate idmap via transform, matching the TS pattern.
        var idmap = StructUtils.Transform(
            new List<object?> { "contact01", "contact02", "contact03", "group01", "group02", "group03" },
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
            "SMSAPI_TEST_CONTACT_ENTID") ?? "";
        var idmapOverridden = entidEnvRaw != "" &&
            entidEnvRaw.Trim().StartsWith("{");

        var env = TestRunner.EnvOverride(new Dictionary<string, object?>
        {
            ["SMSAPI_TEST_CONTACT_ENTID"] = idmap,
            ["SMSAPI_TEST_LIVE"] = "FALSE",
            ["SMSAPI_TEST_EXPLAIN"] = "FALSE",
            ["SMSAPI_APIKEY"] = "",
        });

        var idmapResolved = Helpers.ToMapAny(env["SMSAPI_TEST_CONTACT_ENTID"])
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
