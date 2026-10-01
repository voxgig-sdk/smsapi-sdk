// contacts_field entity test - basic flow (generated from the API model).

using System.Text.Json;

using Voxgig.Struct;
using Xunit;

namespace SmsapiSdk.Test;

public class ContactsFieldEntityTest
{
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
        // The basic flow consumes synthetic IDs from the fixture. In live
        // mode without an *_ENTID env override, those IDs hit the live API
        // and 4xx; set SMSAPI_TEST_CONTACTS_FIELD_ENTID JSON to run live.
        if (setup.SyntheticOnly)
        {
            return;
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

        var contactsFieldRef01MarkdefUp0Name = "birthday_date";
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

        // Detect ENTID env override before EnvOverride consumes it. When
        // live mode is on without a real override, the basic test runs
        // against synthetic IDs from the fixture and 4xx's.
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
