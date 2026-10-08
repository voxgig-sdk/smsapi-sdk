// contacts_field entity test - basic flow (generated from the API model).

using System.Text.Json;

using SmsapiSdk.Feature;
using Voxgig.Struct;
using Xunit;

namespace SmsapiSdk.Test;

public class ContactsFieldEntityTest
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
        var ent = testsdk.ContactsField();
        Assert.NotNull(ent);
    }

    [Fact]
    public void Basic()
    {
        var setup = ContactsFieldBasicSetup(null);
        // Per-op sdk-test-control.json skip - basic test exercises a flow
        // with multiple ops; skipping any op skips the whole flow.
        var _mode = setup.Live ? "live" : "unit";
        foreach (var _op in new[] { "create", "list", "update", "remove" })
        {
            var (_shouldSkip, _) = TestRunner.IsControlSkipped(
                "entityOp", "contacts_field." + _op, _mode);
            if (_shouldSkip)
            {
                return; // skipped via sdk-test-control.json
            }
        }
        var client = setup.Client;

        // CREATE
        var contactsFieldRef01Ent = client.ContactsField();
        var contactsFieldRef01Data = Helpers.ToMapAny(StructUtils.GetProp(
            StructUtils.GetPath(setup.Data, StructUtils.Jt("new", "contacts_field")),
            "contacts_field_ref01"));

        var contactsFieldRef01DataResult = contactsFieldRef01Ent.Create(contactsFieldRef01Data, null);
        contactsFieldRef01Data = Helpers.ToMapAny(contactsFieldRef01DataResult is IEntity ce ? ce.Data() : contactsFieldRef01DataResult);
        Assert.True(contactsFieldRef01Data != null, "expected create result to be a map");
        Assert.True(contactsFieldRef01Data!["id"] != null, "expected created entity to have an id");

        // LIST
        var contactsFieldRef01Match = new Dictionary<string, object?>();

        var contactsFieldRef01ListResult = contactsFieldRef01Ent.List(contactsFieldRef01Match, null);
        var contactsFieldRef01List = contactsFieldRef01ListResult as List<object?>;
        Assert.True(contactsFieldRef01List != null,
            $"expected list result to be a list, got {contactsFieldRef01ListResult?.GetType()}");

        var contactsFieldRef01ListFound = StructUtils.Select(
            TestRunner.EntityListToData(contactsFieldRef01List!),
            new Dictionary<string, object?> { ["id"] = contactsFieldRef01Data!["id"] });
        Assert.False(StructUtils.IsEmpty(contactsFieldRef01ListFound),
            "expected to find created entity in list");

        // UPDATE
        var contactsFieldRef01DataUp0Up = new Dictionary<string, object?>
        {
            ["id"] = contactsFieldRef01Data!["id"],
        };

        var contactsFieldRef01MarkdefUp0Name = "name";
        var contactsFieldRef01MarkdefUp0Value = $"Mark01-contacts_field_ref01_{setup.Now}";
        contactsFieldRef01DataUp0Up[contactsFieldRef01MarkdefUp0Name] = contactsFieldRef01MarkdefUp0Value;

        var contactsFieldRef01ResdataUp0Result = contactsFieldRef01Ent.Update(contactsFieldRef01DataUp0Up, null);
        var contactsFieldRef01ResdataUp0 = Helpers.ToMapAny(contactsFieldRef01ResdataUp0Result is IEntity ue ? ue.Data() : contactsFieldRef01ResdataUp0Result);
        Assert.True(contactsFieldRef01ResdataUp0 != null, "expected update result to be a map");
        Assert.True(StructRunner.DeepEqual(contactsFieldRef01ResdataUp0!["id"], contactsFieldRef01DataUp0Up["id"]),
            "expected update result id to match");
        Assert.True(Equals(contactsFieldRef01ResdataUp0![contactsFieldRef01MarkdefUp0Name], contactsFieldRef01MarkdefUp0Value),
            $"expected {contactsFieldRef01MarkdefUp0Name} to be updated, got {contactsFieldRef01ResdataUp0[contactsFieldRef01MarkdefUp0Name]}");

        // REMOVE
        var contactsFieldRef01MatchRm0 = new Dictionary<string, object?>
        {
            ["id"] = contactsFieldRef01Data!["id"],
        };
        contactsFieldRef01Ent.Remove(contactsFieldRef01MatchRm0, null);

        // LIST
        var contactsFieldRef01MatchRt0 = new Dictionary<string, object?>();

        var contactsFieldRef01ListRt0Result = contactsFieldRef01Ent.List(contactsFieldRef01MatchRt0, null);
        var contactsFieldRef01ListRt0 = contactsFieldRef01ListRt0Result as List<object?>;
        Assert.True(contactsFieldRef01ListRt0 != null,
            $"expected list result to be a list, got {contactsFieldRef01ListRt0Result?.GetType()}");

        var contactsFieldRef01ListRt0NotFound = StructUtils.Select(
            TestRunner.EntityListToData(contactsFieldRef01ListRt0!),
            new Dictionary<string, object?> { ["id"] = contactsFieldRef01Data!["id"] });
        Assert.True(StructUtils.IsEmpty(contactsFieldRef01ListRt0NotFound),
            "expected removed entity to not be in list");

    }

    [Fact]
    public async Task Stream()
    {
        var setup = ContactsFieldBasicSetup(new Dictionary<string, object?>
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

        var ent = setup.Client.ContactsField();
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
        var setup2 = ContactsFieldBasicSetup(null);
        var ent2 = setup2.Client.ContactsField();
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
            throw new Exception("contacts_field hook failed");

        public override void PreUnexpected(Context ctx) => Unexpected++;
    }

    [Fact]
    public async Task StreamError()
    {
        var offline = new Dictionary<string, object?> { ["net"] = new Dictionary<string, object?> { ["offline"] = true } };
        var err = await Assert.ThrowsAnyAsync<Exception>(async () =>
        {
            await foreach (var _ in SmsapiSDK.TestSDK(offline, null).ContactsField().Stream("list", null, null)) { }
        });
        Assert.Contains("offline", err.Message);

        await foreach (var _ in SmsapiSDK.TestSDK(offline, null).ContactsField().Stream("list", null,
            new Dictionary<string, object?> { ["ctrl"] = new Dictionary<string, object?> { ["throw"] = false } })) { }

        if (Fh.HasFeature("rbac"))
        {
            var denied = SmsapiSDK.TestSDK(null,
                new Dictionary<string, object?> { ["feature"] = new Dictionary<string, object?> { ["rbac"] = new Dictionary<string, object?> { ["active"] = true, ["deny"] = true } } });
            var denyerr = await Assert.ThrowsAnyAsync<SmsapiError>(async () =>
            {
                await foreach (var _ in denied.ContactsField().Stream("list", null, null)) { }
            });
            Assert.Equal("rbac_denied", denyerr.Code);
        }
    }

    [Fact]
    public async Task StreamCtrl()
    {
        var explain = new Dictionary<string, object?>();
        var ctrl = new Dictionary<string, object?> { ["explain"] = explain };
        await foreach (var _ in SmsapiSDK.TestSDK(null, null).ContactsField().Stream("list", null,
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

        var err = Assert.ThrowsAny<Exception>(() => client.ContactsField().List(null, null));
        Assert.Contains("hook failed", err.Message);
        Assert.True(hook.Unexpected > 0);

        var fired = hook.Unexpected;
        client.ContactsField().List(null, new Dictionary<string, object?> { ["throw"] = false });
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
        var err = Assert.ThrowsAny<SmsapiError>(() => client.ContactsField().List(
            new Dictionary<string, object?> { ["id"] = 1 }, null));
        Assert.Equal("validate_failed", err.Code);
    }

    private static EntityTestSetup ContactsFieldBasicSetup(
        Dictionary<string, object?>? extra)
    {
        TestRunner.LoadEnvLocal();

        var entityDataFile = Path.Combine(TestRunner.TestDir(),
            "..", "..", ".sdk", "test", "entity", "contacts_field",
            "ContactsFieldTestData.json");

        var entityDataEl = JsonSerializer.Deserialize<JsonElement>(
            File.ReadAllText(entityDataFile));
        var entityData = StructRunner.ConvertElement(entityDataEl)
            as Dictionary<string, object?>
            ?? throw new InvalidOperationException(
                "failed to parse contacts_field test data");

        var options = new Dictionary<string, object?>
        {
            ["entity"] = entityData["existing"],
        };

        var client = SmsapiSDK.TestSDK(options, extra);

        // Generate idmap via transform, matching the TS pattern.
        var idmap = StructUtils.Transform(
            new List<object?> { "contacts_field01", "contacts_field02", "contacts_field03" },
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
            "SMSAPI_TEST_CONTACTS_FIELD_ENTID") ?? "";
        var idmapOverridden = entidEnvRaw != "" &&
            entidEnvRaw.Trim().StartsWith("{");

        var env = TestRunner.EnvOverride(new Dictionary<string, object?>
        {
            ["SMSAPI_TEST_CONTACTS_FIELD_ENTID"] = idmap,
            ["SMSAPI_TEST_LIVE"] = "FALSE",
            ["SMSAPI_TEST_EXPLAIN"] = "FALSE",
            ["SMSAPI_APIKEY"] = "",
        });

        var idmapResolved = Helpers.ToMapAny(env["SMSAPI_TEST_CONTACTS_FIELD_ENTID"])
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
