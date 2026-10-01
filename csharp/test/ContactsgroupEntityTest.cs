// contactsgroup entity test - basic flow (generated from the API model).

using System.Text.Json;

using Voxgig.Struct;
using Xunit;

namespace SmsapiSdk.Test;

public class ContactsgroupEntityTest
{
    [Fact]
    public void Instance()
    {
        var testsdk = SmsapiSDK.TestSDK(null, null);
        var ent = testsdk.Contactsgroup();
        Assert.NotNull(ent);
    }

    [Fact]
    public void Basic()
    {
        var setup = ContactsgroupBasicSetup(null);
        // Per-op sdk-test-control.json skip - basic test exercises a flow
        // with multiple ops; skipping any op skips the whole flow.
        var _mode = setup.Live ? "live" : "unit";
        foreach (var _op in new[] { "create", "list", "update", "remove" })
        {
            var (_shouldSkip, _) = TestRunner.IsControlSkipped(
                "entityOp", "contactsgroup." + _op, _mode);
            if (_shouldSkip)
            {
                return; // skipped via sdk-test-control.json
            }
        }
        // The basic flow consumes synthetic IDs from the fixture. In live
        // mode without an *_ENTID env override, those IDs hit the live API
        // and 4xx; set SMSAPI_TEST_CONTACTSGROUP_ENTID JSON to run live.
        if (setup.SyntheticOnly)
        {
            return;
        }
        var client = setup.Client;

        // CREATE
        var contactsgroupRef01Ent = client.Contactsgroup();
        var contactsgroupRef01Data = Helpers.ToMapAny(StructUtils.GetProp(
            StructUtils.GetPath(setup.Data, StructUtils.Jt("new", "contactsgroup")),
            "contactsgroup_ref01"));
        contactsgroupRef01Data!["group_id"] = setup.Idmap["group01"];

        var contactsgroupRef01DataResult = contactsgroupRef01Ent.Create(contactsgroupRef01Data, null);
        contactsgroupRef01Data = Helpers.ToMapAny(contactsgroupRef01DataResult is IEntity ce ? ce.Data() : contactsgroupRef01DataResult);
        Assert.True(contactsgroupRef01Data != null, "expected create result to be a map");
        Assert.True(contactsgroupRef01Data!["id"] != null, "expected created entity to have an id");

        // LIST
        var contactsgroupRef01Match = new Dictionary<string, object?>
        {
            ["group_id"] = setup.Idmap["group01"],
        };

        var contactsgroupRef01ListResult = contactsgroupRef01Ent.List(contactsgroupRef01Match, null);
        var contactsgroupRef01List = contactsgroupRef01ListResult as List<object?>;
        Assert.True(contactsgroupRef01List != null,
            $"expected list result to be a list, got {contactsgroupRef01ListResult?.GetType()}");

        var contactsgroupRef01ListFound = StructUtils.Select(
            TestRunner.EntityListToData(contactsgroupRef01List!),
            new Dictionary<string, object?> { ["id"] = contactsgroupRef01Data!["id"] });
        Assert.False(StructUtils.IsEmpty(contactsgroupRef01ListFound),
            "expected to find created entity in list");

        // UPDATE
        var contactsgroupRef01DataUp0Up = new Dictionary<string, object?>
        {
            ["id"] = contactsgroupRef01Data!["id"],
        };

        var contactsgroupRef01MarkdefUp0Name = "birthday_date";
        var contactsgroupRef01MarkdefUp0Value = $"Mark01-contactsgroup_ref01_{setup.Now}";
        contactsgroupRef01DataUp0Up[contactsgroupRef01MarkdefUp0Name] = contactsgroupRef01MarkdefUp0Value;

        var contactsgroupRef01ResdataUp0Result = contactsgroupRef01Ent.Update(contactsgroupRef01DataUp0Up, null);
        var contactsgroupRef01ResdataUp0 = Helpers.ToMapAny(contactsgroupRef01ResdataUp0Result is IEntity ue ? ue.Data() : contactsgroupRef01ResdataUp0Result);
        Assert.True(contactsgroupRef01ResdataUp0 != null, "expected update result to be a map");
        Assert.True(StructRunner.DeepEqual(contactsgroupRef01ResdataUp0!["id"], contactsgroupRef01DataUp0Up["id"]),
            "expected update result id to match");
        Assert.True(Equals(contactsgroupRef01ResdataUp0![contactsgroupRef01MarkdefUp0Name], contactsgroupRef01MarkdefUp0Value),
            $"expected {contactsgroupRef01MarkdefUp0Name} to be updated, got {contactsgroupRef01ResdataUp0[contactsgroupRef01MarkdefUp0Name]}");

        // REMOVE
        var contactsgroupRef01MatchRm0 = new Dictionary<string, object?>
        {
            ["id"] = contactsgroupRef01Data!["id"],
        };
        contactsgroupRef01Ent.Remove(contactsgroupRef01MatchRm0, null);

        // LIST
        var contactsgroupRef01MatchRt0 = new Dictionary<string, object?>
        {
            ["group_id"] = setup.Idmap["group01"],
        };

        var contactsgroupRef01ListRt0Result = contactsgroupRef01Ent.List(contactsgroupRef01MatchRt0, null);
        var contactsgroupRef01ListRt0 = contactsgroupRef01ListRt0Result as List<object?>;
        Assert.True(contactsgroupRef01ListRt0 != null,
            $"expected list result to be a list, got {contactsgroupRef01ListRt0Result?.GetType()}");

        var contactsgroupRef01ListRt0NotFound = StructUtils.Select(
            TestRunner.EntityListToData(contactsgroupRef01ListRt0!),
            new Dictionary<string, object?> { ["id"] = contactsgroupRef01Data!["id"] });
        Assert.True(StructUtils.IsEmpty(contactsgroupRef01ListRt0NotFound),
            "expected removed entity to not be in list");

    }

    [Fact]
    public async Task Stream()
    {
        var setup = ContactsgroupBasicSetup(new Dictionary<string, object?>
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

        var ent = setup.Client.Contactsgroup();
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
        var setup2 = ContactsgroupBasicSetup(null);
        var ent2 = setup2.Client.Contactsgroup();
        var streamed2 = new List<object?>();
        await foreach (var item in ent2.Stream("list", match, null))
        {
            streamed2.Add(item);
        }
        Assert.Equal(listed.Count, streamed2.Count);
    }

    private static EntityTestSetup ContactsgroupBasicSetup(
        Dictionary<string, object?>? extra)
    {
        TestRunner.LoadEnvLocal();

        var entityDataFile = Path.Combine(TestRunner.TestDir(),
            "..", "..", ".sdk", "test", "entity", "contactsgroup",
            "ContactsgroupTestData.json");

        var entityDataEl = JsonSerializer.Deserialize<JsonElement>(
            File.ReadAllText(entityDataFile));
        var entityData = StructRunner.ConvertElement(entityDataEl)
            as Dictionary<string, object?>
            ?? throw new InvalidOperationException(
                "failed to parse contactsgroup test data");

        var options = new Dictionary<string, object?>
        {
            ["entity"] = entityData["existing"],
        };

        var client = SmsapiSDK.TestSDK(options, extra);

        // Generate idmap via transform, matching the TS pattern.
        var idmap = StructUtils.Transform(
            new List<object?> { "contactsgroup01", "contactsgroup02", "contactsgroup03", "group01", "group02", "group03", "permission01", "permission02", "permission03" },
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
            "SMSAPI_TEST_CONTACTSGROUP_ENTID") ?? "";
        var idmapOverridden = entidEnvRaw != "" &&
            entidEnvRaw.Trim().StartsWith("{");

        var env = TestRunner.EnvOverride(new Dictionary<string, object?>
        {
            ["SMSAPI_TEST_CONTACTSGROUP_ENTID"] = idmap,
            ["SMSAPI_TEST_LIVE"] = "FALSE",
            ["SMSAPI_TEST_EXPLAIN"] = "FALSE",
            ["SMSAPI_APIKEY"] = "",
        });

        var idmapResolved = Helpers.ToMapAny(env["SMSAPI_TEST_CONTACTSGROUP_ENTID"])
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
