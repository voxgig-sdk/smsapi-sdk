# Smsapi C# SDK

An MCP server and CLI for the SMSAPI REST API, plus clients in 13 languages and a pandas data layer, generated from SMSAPI's public OpenAPI spec so AI agents can reach SMSAPI the way the official SDKs already let developers.

The C# SDK for the Smsapi API — an entity-oriented client following idiomatic C# conventions.

The SDK exposes the API as capitalised, semantic **Entities** — for example `client.Available()` — each
carrying a small, uniform set of operations (`list`, `load`, `create`, `update`, `remove`) instead of raw URL
paths and query strings. You work with named resources and verbs, which
keeps the cognitive load low.

> Other languages, the CLI, and MCP server live alongside this one — see
> the [top-level README](../README.md).


## Install
This package is not yet published to NuGet. Install it from the GitHub
release tag (`csharp/vX.Y.Z`, see [Releases](https://github.com/voxgig-sdk/smsapi-sdk/releases)) or
from a source checkout — build the library and add a project reference:

```bash
cd csharp && dotnet build SmsapiSDK.csproj
```


## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record.

### 1. Create a client

```csharp
using SmsapiSdk;

var client = new SmsapiSDK(new Dictionary<string, object?>
{
    ["apikey"] = Environment.GetEnvironmentVariable("SMSAPI_APIKEY"),
});
```

### 2. List available records

`List(null)` returns an aggregate list of records (as `object?`) and raises
on error.

```csharp
try
{
    var availableList = client.Available().List(null);
    Console.WriteLine(availableList);
}
catch (Exception err)
{
    Console.WriteLine($"list failed: {err.Message}");
}
```

### 3. Load a permission

Permission is nested under group, so provide the `group_id`.
`Load()` returns the bare record (as `object?`) and raises on error.

```csharp
try
{
    var permission = client.Permission().Load(new Dictionary<string, object?> { ["group_id"] = "example_group_id", ["username"] = "example_username", ["id"] = "example_id" });
    Console.WriteLine(permission);
}
catch (Exception err)
{
    Console.WriteLine($"load failed: {err.Message}");
}
```


## Error handling

Entity operations reject on failure, so wrap them in `try` / `catch`:

```ts
try {
  const permission = await client.Permission().load({ group_id: "example", id: "example_id", username: "example" })
  console.log(permission)
} catch (err) {
  console.error('load failed:', err)
}
```

The low-level `direct()` method does **not** throw — it returns the
value or an `Error`, so check the result before using it:

```ts
const result = await client.direct({
  path: '/api/resource/{id}',
  method: 'GET',
  params: { id: 'example_id' },
})

if (result instanceof Error) {
  throw result
}
```


## How-to guides

### Make a direct HTTP request

For endpoints not covered by entity methods:

```csharp
var result = client.Direct(new Dictionary<string, object?>
{
    ["path"] = "/api/resource/{id}",
    ["method"] = "GET",
    ["params"] = new Dictionary<string, object?> { ["id"] = "example" },
});

if (Equals(result["ok"], true))
{
    Console.WriteLine(result["status"]);  // 200
    Console.WriteLine(result["data"]);    // response body
}
else
{
    // A non-2xx response carries status + data (the error body); a
    // transport-level failure carries err instead. Only one is present, so
    // read both with TryGetValue rather than indexing a key that may be absent.
    result.TryGetValue("status", out var status);
    result.TryGetValue("err", out var err);
    Console.WriteLine($"{status} {err}");
}
```

### Prepare a request without sending it

```csharp
// Prepare() returns the fetch definition and raises on error.
var fetchdef = client.Prepare(new Dictionary<string, object?>
{
    ["path"] = "/api/resource/{id}",
    ["method"] = "DELETE",
    ["params"] = new Dictionary<string, object?> { ["id"] = "example" },
});

Console.WriteLine(fetchdef["url"]);
Console.WriteLine(fetchdef["method"]);
Console.WriteLine(fetchdef["headers"]);
```

### Use test mode

Create a mock client for unit testing — no server required:

```csharp
var client = SmsapiSDK.TestSDK(null, null);

// Entity ops return the bare record and raise on error.
var permission = client.Permission().Load(new Dictionary<string, object?> { ["id"] = "test01" });
// permission holds the mock response record
Console.WriteLine(permission);
```

### Use a custom fetch function

Replace the HTTP transport with your own delegate:

```csharp
Func<string, Dictionary<string, object?>, Dictionary<string, object?>> mockFetch =
    (url, init) => new Dictionary<string, object?>
    {
        ["status"] = 200,
        ["statusText"] = "OK",
        ["headers"] = new Dictionary<string, object?>(),
        ["json"] = (Func<object?>)(() => new Dictionary<string, object?> { ["id"] = "mock01" }),
    };

var client = new SmsapiSDK(new Dictionary<string, object?>
{
    ["base"] = "http://localhost:8080",
    ["system"] = new Dictionary<string, object?>
    {
        ["fetch"] = mockFetch,
    },
});
```

### Run live tests

Create a `.env.local` file at the project root:

```
SMSAPI_TEST_LIVE=TRUE
SMSAPI_APIKEY=<your-key>
```

Then run:

```bash
cd csharp && dotnet test
```


## Reference

### SmsapiSDK

```csharp
using SmsapiSdk;

var client = new SmsapiSDK(options);
```

Creates a new SDK client. `options` is a `Dictionary<string, object?>`.

| Option | Type | Description |
| --- | --- | --- |
| `apikey` | `string` | API key for authentication. |
| `base` | `string` | Base URL of the API server. |
| `prefix` | `string` | URL path prefix prepended to all requests. |
| `suffix` | `string` | URL path suffix appended to all requests. |
| `feature` | `Dictionary` | Feature activation flags. |
| `extend` | `List` | Additional Feature instances to load. |
| `system` | `Dictionary` | System overrides (e.g. custom `fetch` delegate). |

### TestSDK

```csharp
var client = SmsapiSDK.TestSDK(testopts, sdkopts);
```

Creates a test-mode client with mock transport. Both arguments may be `null`.

### SmsapiSDK methods

| Method | Signature | Description |
| --- | --- | --- |
| `OptionsMap` | `() -> Dictionary` | Deep copy of current SDK options. |
| `GetUtility` | `() -> Utility` | Copy of the SDK utility object. |
| `Prepare` | `(fetchargs) -> Dictionary` | Build an HTTP request definition without sending. Raises on error. |
| `Direct` | `(fetchargs) -> Dictionary` | Build and send an HTTP request. Returns a result dictionary (branch on `ok`). |
| `Available` | `(entopts) -> SmsapiEntityBase` | Create an Available entity instance. |
| `Blacklist` | `(entopts) -> SmsapiEntityBase` | Create a Blacklist entity instance. |
| `Callback` | `(entopts) -> SmsapiEntityBase` | Create a Callback entity instance. |
| `Contact` | `(entopts) -> SmsapiEntityBase` | Create a Contact entity instance. |
| `ContactsField` | `(entopts) -> SmsapiEntityBase` | Create a ContactsField entity instance. |
| `ContactsFieldOption` | `(entopts) -> SmsapiEntityBase` | Create a ContactsFieldOption entity instance. |
| `Contactsgroup` | `(entopts) -> SmsapiEntityBase` | Create a Contactsgroup entity instance. |
| `Contactstrash` | `(entopts) -> SmsapiEntityBase` | Create a Contactstrash entity instance. |
| `FieldAvailable` | `(entopts) -> SmsapiEntityBase` | Create a FieldAvailable entity instance. |
| `Group` | `(entopts) -> SmsapiEntityBase` | Create a Group entity instance. |
| `MfaCode` | `(entopts) -> SmsapiEntityBase` | Create a MfaCode entity instance. |
| `OptOut` | `(entopts) -> SmsapiEntityBase` | Create an OptOut entity instance. |
| `OptOutSetting` | `(entopts) -> SmsapiEntityBase` | Create an OptOutSetting entity instance. |
| `Permission` | `(entopts) -> SmsapiEntityBase` | Create a Permission entity instance. |
| `Ping` | `(entopts) -> SmsapiEntityBase` | Create a Ping entity instance. |
| `Profile` | `(entopts) -> SmsapiEntityBase` | Create a Profile entity instance. |
| `Rcs` | `(entopts) -> SmsapiEntityBase` | Create a Rcs entity instance. |
| `Sendername` | `(entopts) -> SmsapiEntityBase` | Create a Sendername entity instance. |
| `SendernameStatement` | `(entopts) -> SmsapiEntityBase` | Create a SendernameStatement entity instance. |
| `SentRcsMessage` | `(entopts) -> SmsapiEntityBase` | Create a SentRcsMessage entity instance. |
| `ShipmentCountryVolume` | `(entopts) -> SmsapiEntityBase` | Create a ShipmentCountryVolume entity instance. |
| `ShortUrl` | `(entopts) -> SmsapiEntityBase` | Create a ShortUrl entity instance. |
| `Smsdo` | `(entopts) -> SmsapiEntityBase` | Create a Smsdo entity instance. |
| `Smssendername` | `(entopts) -> SmsapiEntityBase` | Create a Smssendername entity instance. |
| `Smstemplate` | `(entopts) -> SmsapiEntityBase` | Create a Smstemplate entity instance. |
| `Subuser` | `(entopts) -> SmsapiEntityBase` | Create a Subuser entity instance. |
| `Template` | `(entopts) -> SmsapiEntityBase` | Create a Template entity instance. |
| `UserRcsSenderCollection` | `(entopts) -> SmsapiEntityBase` | Create an UserRcsSenderCollection entity instance. |

### Entity interface

All entities share the same interface.

| Method | Signature | Description |
| --- | --- | --- |
| `Load` | `(reqmatch, ctrl) -> object?` | Load a single entity by match criteria. Raises on error. |
| `List` | `(reqmatch, ctrl) -> object?` | List entities matching the criteria (an aggregate list). Raises on error. |
| `Create` | `(reqdata, ctrl) -> object?` | Create a new entity. Raises on error. |
| `Update` | `(reqdata, ctrl) -> object?` | Update an existing entity. Raises on error. |
| `Remove` | `(reqmatch, ctrl) -> object?` | Remove an entity. Raises on error. |
| `Data` | `(newdata) -> object?` | Get or set entity data. |
| `Match` | `(newmatch) -> object?` | Get or set entity match criteria. |
| `Make` | `() -> IEntity` | Create a new instance with the same options. |
| `GetName` | `() -> string` | Return the entity name. |

### Result shape

Entity operations return the bare result data (a `Dictionary` for
single-entity ops, an aggregate list for `List`) as `object?` and raise on
error. Wrap calls in `try`/`catch` to handle failures.

The `Direct()` escape hatch never raises — it returns a result
`Dictionary<string, object?>` you branch on via `result["ok"]`:

| Key | Type | Description |
| --- | --- | --- |
| `ok` | `bool` | `true` if the HTTP status is 2xx. |
| `status` | `int` | HTTP status code. |
| `headers` | `Dictionary` | Response headers. |
| `data` | `object?` | Parsed JSON response body. |

On error, `ok` is `false` and `err` contains the error value.

### Entities

#### Available

| Field | Description |
| --- | --- |
| `name` |  |
| `normalize` |  |
| `template` |  |

Operations: List.

API path: `/sms/templates/available`

#### Blacklist

| Field | Description |
| --- | --- |
| `id` |  |

Operations: Create, Load, Remove.

API path: `/blacklist/phone_numbers`

#### Callback

| Field | Description |
| --- | --- |
| `active` |  |
| `api_version` | Version of the callback output format. |
| `id` | Object ID |
| `invalid` |  |
| `receiver` |  |
| `receiver_type` |  |
| `type` |  |
| `url` | WHATWG URL compliant |

Operations: Create, List, Load, Remove, Update.

API path: `/callbacks`

#### Contact

| Field | Description |
| --- | --- |
| `birthday_date` |  |
| `city` |  |
| `collection` |  |
| `contact_expire_after` | Contact expire after days |
| `contacts_count` |  |
| `country` |  |
| `created_by` |  |
| `date_created` |  |
| `date_updated` |  |
| `description` |  |
| `email` |  |
| `first_name` |  |
| `gender` |  |
| `group_id` | Object ID |
| `groups` |  |
| `id` | Object ID |
| `idx` | User provided resource id |
| `last_name` |  |
| `name` | Group name |
| `permissions` |  |
| `phone_number` |  |
| `read` | Has read permission |
| `send` | Has send permission |
| `size` |  |
| `source` |  |
| `type` |  |
| `username` |  |
| `value` |  |
| `write` | Has write permission |

Operations: Create, List, Load, Remove, Update.

API path: `/contacts/{contactId}/groups`

#### ContactsField

| Field | Description |
| --- | --- |
| `birthday_date` |  |
| `city` |  |
| `contact_expire_after` | Contact expire after days |
| `contacts_count` |  |
| `country` |  |
| `created_by` |  |
| `date_created` |  |
| `date_updated` |  |
| `description` |  |
| `email` |  |
| `first_name` |  |
| `gender` |  |
| `group_id` | Object ID |
| `groups` |  |
| `id` | Object ID |
| `idx` | User provided resource id |
| `last_name` |  |
| `name` | Group name |
| `permissions` |  |
| `phone_number` |  |
| `read` | Has read permission |
| `send` | Has send permission |
| `source` |  |
| `type` |  |
| `username` |  |
| `value` |  |
| `write` | Has write permission |

Operations: Create, List, Remove, Update.

API path: `/contacts/fields`

#### ContactsFieldOption

| Field | Description |
| --- | --- |
| `birthday_date` |  |
| `city` |  |
| `contact_expire_after` | Contact expire after days |
| `contacts_count` |  |
| `country` |  |
| `created_by` |  |
| `date_created` |  |
| `date_updated` |  |
| `description` |  |
| `email` |  |
| `first_name` |  |
| `gender` |  |
| `group_id` | Object ID |
| `groups` |  |
| `id` | Object ID |
| `idx` | User provided resource id |
| `last_name` |  |
| `name` | Group name |
| `permissions` |  |
| `phone_number` |  |
| `read` | Has read permission |
| `send` | Has send permission |
| `source` |  |
| `type` |  |
| `username` |  |
| `value` |  |
| `write` | Has write permission |

Operations: List.

API path: `/contacts/fields/{fieldId}/options`

#### Contactsgroup

| Field | Description |
| --- | --- |
| `birthday_date` |  |
| `city` |  |
| `contact_expire_after` | Contact expire after days |
| `contacts_count` |  |
| `country` |  |
| `created_by` |  |
| `date_created` |  |
| `date_updated` |  |
| `description` |  |
| `email` |  |
| `first_name` |  |
| `gender` |  |
| `group_id` | Object ID |
| `groups` |  |
| `id` | Object ID |
| `idx` | User provided resource id |
| `last_name` |  |
| `name` | Group name |
| `permissions` |  |
| `phone_number` |  |
| `read` | Has read permission |
| `send` | Has send permission |
| `source` |  |
| `type` |  |
| `username` |  |
| `value` |  |
| `write` | Has write permission |

Operations: Create, List, Remove, Update.

API path: `/contacts/groups/{groupId}/members`

#### Contactstrash

| Field | Description |
| --- | --- |

Operations: Remove, Update.

API path: `/contacts/trash`

#### FieldAvailable

| Field | Description |
| --- | --- |
| `built_in` |  |
| `id` | Object ID |
| `name` |  |
| `options` |  |
| `type` |  |

Operations: List.

API path: `/contacts/fields/available`

#### Group

| Field | Description |
| --- | --- |
| `contact_expire_after` | Contact expire after days |
| `contacts_count` |  |
| `created_by` |  |
| `date_created` |  |
| `date_updated` |  |
| `description` |  |
| `id` | Object ID |
| `idx` | User provided resource id |
| `name` | Group name |
| `permissions` |  |

Operations: Load, Update.

API path: `/contacts/groups/{groupId}`

#### MfaCode

| Field | Description |
| --- | --- |
| `content` | Custom content that must contain placeholder [%code%] |
| `fast` |  |
| `from` | Sendername |
| `phone_number` |  |

Operations: Create.

API path: `/mfa/codes`

#### OptOut

| Field | Description |
| --- | --- |
| `date` |  |
| `id` |  |
| `links` |  |
| `phoneNumber` |  |

Operations: List, Remove.

API path: `/opt_outs`

#### OptOutSetting

| Field | Description |
| --- | --- |
| `brand` |  |

Operations: Load, Update.

API path: `/opt_outs/settings`

#### Permission

| Field | Description |
| --- | --- |
| `group_id` | Object ID |
| `id` |  |
| `read` | Has read permission |
| `send` | Has send permission |
| `username` |  |
| `write` | Has write permission |

Operations: Create, Load.

API path: `/contacts/groups/{groupId}/permissions`

#### Ping

| Field | Description |
| --- | --- |
| `authorized` |  |
| `unavailable` |  |

Operations: List.

API path: `/ping`

#### Profile

| Field | Description |
| --- | --- |
| `email` |  |
| `name` |  |
| `payment_type` |  |
| `phone_number` |  |
| `points` |  |
| `user_type` |  |
| `username` |  |

Operations: List, Load.

API path: `/profile/prices`

#### Rcs

| Field | Description |
| --- | --- |

Operations: List.

API path: `/rcs/messages`

#### Sendername

| Field | Description |
| --- | --- |
| `created_at` |  |
| `id` |  |
| `is_default` |  |
| `sender` | Sendername |
| `status` |  |

Operations: Create, List, Load.

API path: `/sms/sendernames`

#### SendernameStatement

| Field | Description |
| --- | --- |
| `content` |  |
| `statements` |  |
| `title` |  |

Operations: List.

API path: `/sms/sendernames/statement`

#### SentRcsMessage

| Field | Description |
| --- | --- |
| `content` | RCS message content in RCS JSON format. |
| `phone_number` | Recipient phone number (e.g. |
| `sender` |  |
| `text` | Plain text message content. |

Operations: Create.

API path: `/rcs/messages`

#### ShipmentCountryVolume

| Field | Description |
| --- | --- |
| `country_code` |  |
| `country_limit` |  |
| `country_name` |  |
| `usage` |  |

Operations: List.

API path: `/shipment/country_volumes`

#### ShortUrl

| Field | Description |
| --- | --- |
| `description` |  |
| `expire` |  |
| `filename` |  |
| `hits` |  |
| `hits_unique` |  |
| `id` |  |
| `name` |  |
| `short_url` | WHATWG URL compliant |
| `type` |  |
| `url` | WHATWG URL compliant |

Operations: Create, List, Load, Remove, Update.

API path: `/short_url/links`

#### Smsdo

| Field | Description |
| --- | --- |
| `allow_duplicates` | When parameter allow_duplicates is set to "1" allows to send message to duplicated numbers in one request (useful i.e. |
| `check_idx` | When parameter check_idx is set to „1” prevents from sending more than one message with the same idx in last 24h. |
| `date` | Date in UNIX timestamp (&date=1287734110) or in ISO 8601 (&date=2012-05-10T08:40:27+00:00) when message will be sent (&date=1287734110). |
| `date_validate` | When parameter date_validate is set to "1" checks if date if given in proper format. |
| `details` | When details parameter is set to "1" more details in response will be displayed (message length and sms count). |
| `encoding` | This parameter describes the encoding of the message text. |
| `expiration_date` | Message expiration date (in UNIX timestamp or in ISO 8601) is a date after which message won't be delivered if it wasn't delivered yet. |
| `fallback` | Enable fallback in case sms sending fails |
| `fast` | Setting this parameter to „1” will result in sending message with the highest priority which ensures the quickest possible time of delivery. |
| `flash` | Sending a message in flash mode can be activated by setting this parameter to "1". |
| `format` | Parameter &format=json causes, that response is sending in JSON format. |
| `from` | Name of the sender. |
| `group` | Name of the group from the contacts database to which message should be sent to. |
| `idx` | Optional custom value sent with SMS and sent back in CALLBACK. |
| `max_parts` | Defines maximum message parts allowed, maximum value allowed is 6. |
| `message` | The message text. |
| `normalize` | When parameter normalize is set to „1” special chars in message will be replaced with their equivalents (ê-e, ñ-n, ý-y ...). |
| `notify_url` | Parameter allows to set CALLBACK URL for message from request. |
| `test` | When parameter test is set to "1" message won't be sent but response will be displayed, there is no charge for such test messages. |
| `time_restriction` | Sets the behavior when you try to ship in hours / dates that do not match the settings in your account. |
| `to` | Recipients' mobile phone numbers (i.e. |

Operations: Create.

API path: `/sms.do`

#### Smssendername

| Field | Description |
| --- | --- |

Operations: Create, Remove.

API path: `/sms/sendernames/{sender}/commands/make_default`

#### Smstemplate

| Field | Description |
| --- | --- |
| `id` |  |

Operations: Remove.

API path: `/sms/templates/{id}`

#### Subuser

| Field | Description |
| --- | --- |
| `active` |  |
| `credentials` |  |
| `description` |  |
| `id` | Object ID |
| `points` |  |
| `username` |  |

Operations: Create, List, Load, Remove, Update.

API path: `/subusers`

#### Template

| Field | Description |
| --- | --- |
| `id` |  |
| `name` |  |
| `normalize` |  |
| `template` |  |

Operations: Create, List, Load, Update.

API path: `/sms/templates`

#### UserRcsSenderCollection

| Field | Description |
| --- | --- |
| `deliveredAt` |  |
| `expiredAt` |  |
| `id` | Object ID |
| `interface` | Interface through which the message was sent (www, api, ...). |
| `messageType` | RCS message type (basic, single, ...). |
| `readAt` |  |
| `recipient` | Recipient phone number (without +). |
| `sender` | Sender name |
| `senderId` | Sender id |
| `sentAt` |  |

Operations: List.

API path: `/rcs/senders`



## Entities


### Available

Create an instance: `var available = client.Available();`

#### Operations

| Method | Description |
| --- | --- |
| `List(null)` | List entities, optionally matching the given criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `name` | `string` |  |
| `normalize` | `bool` |  |
| `template` | `string` |  |

#### Example: List

```csharp
var availableList = client.Available().List(null);
```


### Blacklist

Create an instance: `var blacklist = client.Blacklist();`

#### Operations

| Method | Description |
| --- | --- |
| `Create(data)` | Create a new entity with the given data. |
| `Load(match)` | Load a single entity by match criteria. |
| `Remove(match)` | Remove the matching entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `id` | `string` |  |

#### Example: Load

```csharp
var blacklist = client.Blacklist().Load(null);
```

#### Example: Create

```csharp
var blacklist = client.Blacklist().Create(new Dictionary<string, object?>
{
});
```


### Callback

Create an instance: `var callback = client.Callback();`

#### Operations

| Method | Description |
| --- | --- |
| `Create(data)` | Create a new entity with the given data. |
| `List(null)` | List entities, optionally matching the given criteria. |
| `Load(match)` | Load a single entity by match criteria. |
| `Remove(match)` | Remove the matching entity. |
| `Update(data)` | Update an existing entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `active` | `bool` |  |
| `api_version` | `long` | Version of the callback output format. |
| `id` | `string` | Object ID |
| `invalid` | `bool` |  |
| `receiver` | `Dictionary<string, object?>` |  |
| `receiver_type` | `string` |  |
| `type` | `string` |  |
| `url` | `string` | WHATWG URL compliant |

#### Example: Load

```csharp
var callback = client.Callback().Load(new Dictionary<string, object?> { ["id"] = "callback_id" });
```

#### Example: List

```csharp
var callbackList = client.Callback().List(null);
```

#### Example: Create

```csharp
var callback = client.Callback().Create(new Dictionary<string, object?>
{
});
```


### Contact

Create an instance: `var contact = client.Contact();`

#### Operations

| Method | Description |
| --- | --- |
| `Create(data)` | Create a new entity with the given data. |
| `List(null)` | List entities, optionally matching the given criteria. |
| `Load(match)` | Load a single entity by match criteria. |
| `Remove(match)` | Remove the matching entity. |
| `Update(data)` | Update an existing entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `birthday_date` | `string` |  |
| `city` | `string` |  |
| `collection` | `List<object?>` |  |
| `contact_expire_after` | `long` | Contact expire after days |
| `contacts_count` | `long` |  |
| `country` | `string` |  |
| `created_by` | `string` |  |
| `date_created` | `string` |  |
| `date_updated` | `string` |  |
| `description` | `string` |  |
| `email` | `string` |  |
| `first_name` | `string` |  |
| `gender` | `string` |  |
| `group_id` | `string` | Object ID |
| `groups` | `List<object?>` |  |
| `id` | `string` | Object ID |
| `idx` | `string` | User provided resource id |
| `last_name` | `string` |  |
| `name` | `string` | Group name |
| `permissions` | `List<object?>` |  |
| `phone_number` | `string` |  |
| `read` | `bool` | Has read permission |
| `send` | `bool` | Has send permission |
| `size` | `long` |  |
| `source` | `string` |  |
| `type` | `string` |  |
| `username` | `string` |  |
| `value` | `string` |  |
| `write` | `bool` | Has write permission |

#### Example: Load

```csharp
var contact = client.Contact().Load(new Dictionary<string, object?> { ["id"] = "contact_id" });
```

#### Example: List

```csharp
var contactList = client.Contact().List(null);
```

#### Example: Create

```csharp
var contact = client.Contact().Create(new Dictionary<string, object?>
{
    ["collection"] = new List<object?>(),  // List<object?>
    ["contact_expire_after"] = 1L,  // long
    ["contacts_count"] = 1L,  // long
    ["created_by"] = "example_created_by",  // string
    ["date_created"] = "example_date_created",  // string
    ["date_updated"] = "example_date_updated",  // string
    ["gender"] = "example_gender",  // string
    ["groups"] = new List<object?>(),  // List<object?>
    ["id"] = "example_id",  // string
    ["name"] = "example_name",  // string
    ["size"] = 1L,  // long
});
```


### ContactsField

Create an instance: `var contactsField = client.ContactsField();`

#### Operations

| Method | Description |
| --- | --- |
| `Create(data)` | Create a new entity with the given data. |
| `List(null)` | List entities, optionally matching the given criteria. |
| `Remove(match)` | Remove the matching entity. |
| `Update(data)` | Update an existing entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `birthday_date` | `string` |  |
| `city` | `string` |  |
| `contact_expire_after` | `long` | Contact expire after days |
| `contacts_count` | `long` |  |
| `country` | `string` |  |
| `created_by` | `string` |  |
| `date_created` | `string` |  |
| `date_updated` | `string` |  |
| `description` | `string` |  |
| `email` | `string` |  |
| `first_name` | `string` |  |
| `gender` | `string` |  |
| `group_id` | `string` | Object ID |
| `groups` | `List<object?>` |  |
| `id` | `string` | Object ID |
| `idx` | `string` | User provided resource id |
| `last_name` | `string` |  |
| `name` | `string` | Group name |
| `permissions` | `List<object?>` |  |
| `phone_number` | `string` |  |
| `read` | `bool` | Has read permission |
| `send` | `bool` | Has send permission |
| `source` | `string` |  |
| `type` | `string` |  |
| `username` | `string` |  |
| `value` | `string` |  |
| `write` | `bool` | Has write permission |

#### Example: List

```csharp
var contactsFieldList = client.ContactsField().List(null);
```

#### Example: Create

```csharp
var contactsField = client.ContactsField().Create(new Dictionary<string, object?>
{
    ["contact_expire_after"] = 1L,  // long
    ["created_by"] = "example_created_by",  // string
    ["date_created"] = "example_date_created",  // string
    ["date_updated"] = "example_date_updated",  // string
    ["gender"] = "example_gender",  // string
    ["groups"] = new List<object?>(),  // List<object?>
});
```


### ContactsFieldOption

Create an instance: `var contactsFieldOption = client.ContactsFieldOption();`

#### Operations

| Method | Description |
| --- | --- |
| `List(null)` | List entities, optionally matching the given criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `birthday_date` | `string` |  |
| `city` | `string` |  |
| `contact_expire_after` | `long` | Contact expire after days |
| `contacts_count` | `long` |  |
| `country` | `string` |  |
| `created_by` | `string` |  |
| `date_created` | `string` |  |
| `date_updated` | `string` |  |
| `description` | `string` |  |
| `email` | `string` |  |
| `first_name` | `string` |  |
| `gender` | `string` |  |
| `group_id` | `string` | Object ID |
| `groups` | `List<object?>` |  |
| `id` | `string` | Object ID |
| `idx` | `string` | User provided resource id |
| `last_name` | `string` |  |
| `name` | `string` | Group name |
| `permissions` | `List<object?>` |  |
| `phone_number` | `string` |  |
| `read` | `bool` | Has read permission |
| `send` | `bool` | Has send permission |
| `source` | `string` |  |
| `type` | `string` |  |
| `username` | `string` |  |
| `value` | `string` |  |
| `write` | `bool` | Has write permission |

#### Example: List

```csharp
var contactsFieldOptionList = client.ContactsFieldOption().List(null);
```


### Contactsgroup

Create an instance: `var contactsgroup = client.Contactsgroup();`

#### Operations

| Method | Description |
| --- | --- |
| `Create(data)` | Create a new entity with the given data. |
| `List(null)` | List entities, optionally matching the given criteria. |
| `Remove(match)` | Remove the matching entity. |
| `Update(data)` | Update an existing entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `birthday_date` | `string` |  |
| `city` | `string` |  |
| `contact_expire_after` | `long` | Contact expire after days |
| `contacts_count` | `long` |  |
| `country` | `string` |  |
| `created_by` | `string` |  |
| `date_created` | `string` |  |
| `date_updated` | `string` |  |
| `description` | `string` |  |
| `email` | `string` |  |
| `first_name` | `string` |  |
| `gender` | `string` |  |
| `group_id` | `string` | Object ID |
| `groups` | `List<object?>` |  |
| `id` | `string` | Object ID |
| `idx` | `string` | User provided resource id |
| `last_name` | `string` |  |
| `name` | `string` | Group name |
| `permissions` | `List<object?>` |  |
| `phone_number` | `string` |  |
| `read` | `bool` | Has read permission |
| `send` | `bool` | Has send permission |
| `source` | `string` |  |
| `type` | `string` |  |
| `username` | `string` |  |
| `value` | `string` |  |
| `write` | `bool` | Has write permission |

#### Example: List

```csharp
var contactsgroupList = client.Contactsgroup().List(null);
```

#### Example: Create

```csharp
var contactsgroup = client.Contactsgroup().Create(new Dictionary<string, object?>
{
    ["contact_expire_after"] = 1L,  // long
    ["created_by"] = "example_created_by",  // string
    ["date_created"] = "example_date_created",  // string
    ["date_updated"] = "example_date_updated",  // string
    ["gender"] = "example_gender",  // string
    ["group_id"] = "example_group_id",  // string
    ["groups"] = new List<object?>(),  // List<object?>
    ["id"] = "example_id",  // string
    ["read"] = true,  // bool
    ["send"] = true,  // bool
    ["username"] = "example_username",  // string
    ["write"] = true,  // bool
});
```


### Contactstrash

Create an instance: `var contactstrash = client.Contactstrash();`

#### Operations

| Method | Description |
| --- | --- |
| `Remove(match)` | Remove the matching entity. |
| `Update(data)` | Update an existing entity. |


### FieldAvailable

Create an instance: `var fieldAvailable = client.FieldAvailable();`

#### Operations

| Method | Description |
| --- | --- |
| `List(null)` | List entities, optionally matching the given criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `built_in` | `bool` |  |
| `id` | `string` | Object ID |
| `name` | `string` |  |
| `options` | `List<object?>` |  |
| `type` | `string` |  |

#### Example: List

```csharp
var fieldAvailableList = client.FieldAvailable().List(null);
```


### Group

Create an instance: `var group = client.Group();`

#### Operations

| Method | Description |
| --- | --- |
| `Load(match)` | Load a single entity by match criteria. |
| `Update(data)` | Update an existing entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `contact_expire_after` | `long` | Contact expire after days |
| `contacts_count` | `long` |  |
| `created_by` | `string` |  |
| `date_created` | `string` |  |
| `date_updated` | `string` |  |
| `description` | `string` |  |
| `id` | `string` | Object ID |
| `idx` | `string` | User provided resource id |
| `name` | `string` | Group name |
| `permissions` | `List<object?>` |  |

#### Example: Load

```csharp
var group = client.Group().Load(new Dictionary<string, object?> { ["id"] = "group_id" });
```


### MfaCode

Create an instance: `var mfaCode = client.MfaCode();`

#### Operations

| Method | Description |
| --- | --- |
| `Create(data)` | Create a new entity with the given data. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `content` | `string` | Custom content that must contain placeholder [%code%] |
| `fast` | `object?` |  |
| `from` | `string` | Sendername |
| `phone_number` | `string` |  |

#### Example: Create

```csharp
var mfaCode = client.MfaCode().Create(new Dictionary<string, object?>
{
    ["phone_number"] = "example_phone_number",  // string
});
```


### OptOut

Create an instance: `var optOut = client.OptOut();`

#### Operations

| Method | Description |
| --- | --- |
| `List(null)` | List entities, optionally matching the given criteria. |
| `Remove(match)` | Remove the matching entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `date` | `string` |  |
| `id` | `string` |  |
| `links` | `List<object?>` |  |
| `phoneNumber` | `long` |  |

#### Example: List

```csharp
var optOutList = client.OptOut().List(null);
```


### OptOutSetting

Create an instance: `var optOutSetting = client.OptOutSetting();`

#### Operations

| Method | Description |
| --- | --- |
| `Load(match)` | Load a single entity by match criteria. |
| `Update(data)` | Update an existing entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `brand` | `string` |  |

#### Example: Load

```csharp
var optOutSetting = client.OptOutSetting().Load(null);
```


### Permission

Create an instance: `var permission = client.Permission();`

#### Operations

| Method | Description |
| --- | --- |
| `Create(data)` | Create a new entity with the given data. |
| `Load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `group_id` | `string` | Object ID |
| `id` | `string` |  |
| `read` | `bool` | Has read permission |
| `send` | `bool` | Has send permission |
| `username` | `string` |  |
| `write` | `bool` | Has write permission |

#### Example: Load

```csharp
var permission = client.Permission().Load(new Dictionary<string, object?> { ["id"] = "permission_id", ["group_id"] = "group_id", ["username"] = "username" });
```

#### Example: Create

```csharp
var permission = client.Permission().Create(new Dictionary<string, object?>
{
    ["group_id"] = "example_group_id",  // string
    ["read"] = true,  // bool
    ["send"] = true,  // bool
    ["username"] = "example_username",  // string
    ["write"] = true,  // bool
});
```


### Ping

Create an instance: `var ping = client.Ping();`

#### Operations

| Method | Description |
| --- | --- |
| `List(null)` | List entities, optionally matching the given criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `authorized` | `bool` |  |
| `unavailable` | `List<object?>` |  |

#### Example: List

```csharp
var pingList = client.Ping().List(null);
```


### Profile

Create an instance: `var profile = client.Profile();`

#### Operations

| Method | Description |
| --- | --- |
| `List(null)` | List entities, optionally matching the given criteria. |
| `Load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `email` | `string` |  |
| `name` | `string` |  |
| `payment_type` | `string` |  |
| `phone_number` | `long` |  |
| `points` | `double` |  |
| `user_type` | `string` |  |
| `username` | `string` |  |

#### Example: Load

```csharp
var profile = client.Profile().Load(null);
```

#### Example: List

```csharp
var profileList = client.Profile().List(null);
```


### Rcs

Create an instance: `var rcs = client.Rcs();`

#### Operations

| Method | Description |
| --- | --- |
| `List(null)` | List entities, optionally matching the given criteria. |

#### Example: List

```csharp
var rcsList = client.Rcs().List(null);
```


### Sendername

Create an instance: `var sendername = client.Sendername();`

#### Operations

| Method | Description |
| --- | --- |
| `Create(data)` | Create a new entity with the given data. |
| `List(null)` | List entities, optionally matching the given criteria. |
| `Load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `created_at` | `string` |  |
| `id` | `string` |  |
| `is_default` | `bool` |  |
| `sender` | `string` | Sendername |
| `status` | `string` |  |

#### Example: Load

```csharp
var sendername = client.Sendername().Load(new Dictionary<string, object?> { ["id"] = "sendername_id" });
```

#### Example: List

```csharp
var sendernameList = client.Sendername().List(null);
```

#### Example: Create

```csharp
var sendername = client.Sendername().Create(new Dictionary<string, object?>
{
});
```


### SendernameStatement

Create an instance: `var sendernameStatement = client.SendernameStatement();`

#### Operations

| Method | Description |
| --- | --- |
| `List(null)` | List entities, optionally matching the given criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `content` | `string` |  |
| `statements` | `List<object?>` |  |
| `title` | `string` |  |

#### Example: List

```csharp
var sendernameStatementList = client.SendernameStatement().List(null);
```


### SentRcsMessage

Create an instance: `var sentRcsMessage = client.SentRcsMessage();`

#### Operations

| Method | Description |
| --- | --- |
| `Create(data)` | Create a new entity with the given data. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `content` | `Dictionary<string, object?>` | RCS message content in RCS JSON format. |
| `phone_number` | `string` | Recipient phone number (e.g. |
| `sender` | `object?` |  |
| `text` | `string` | Plain text message content. |

#### Example: Create

```csharp
var sentRcsMessage = client.SentRcsMessage().Create(new Dictionary<string, object?>
{
    ["phone_number"] = "example_phone_number",  // string
    ["sender"] = "example_sender",  // object?
});
```


### ShipmentCountryVolume

Create an instance: `var shipmentCountryVolume = client.ShipmentCountryVolume();`

#### Operations

| Method | Description |
| --- | --- |
| `List(null)` | List entities, optionally matching the given criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `country_code` | `string` |  |
| `country_limit` | `long` |  |
| `country_name` | `string` |  |
| `usage` | `long` |  |

#### Example: List

```csharp
var shipmentCountryVolumeList = client.ShipmentCountryVolume().List(null);
```


### ShortUrl

Create an instance: `var shortUrl = client.ShortUrl();`

#### Operations

| Method | Description |
| --- | --- |
| `Create(data)` | Create a new entity with the given data. |
| `List(null)` | List entities, optionally matching the given criteria. |
| `Load(match)` | Load a single entity by match criteria. |
| `Remove(match)` | Remove the matching entity. |
| `Update(data)` | Update an existing entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `description` | `string` |  |
| `expire` | `string` |  |
| `filename` | `string` |  |
| `hits` | `long` |  |
| `hits_unique` | `long` |  |
| `id` | `string` |  |
| `name` | `string` |  |
| `short_url` | `string` | WHATWG URL compliant |
| `type` | `string` |  |
| `url` | `string` | WHATWG URL compliant |

#### Example: Load

```csharp
var shortUrl = client.ShortUrl().Load(new Dictionary<string, object?> { ["id"] = "short_url_id" });
```

#### Example: List

```csharp
var shortUrlList = client.ShortUrl().List(null);
```

#### Example: Create

```csharp
var shortUrl = client.ShortUrl().Create(new Dictionary<string, object?>
{
});
```


### Smsdo

Create an instance: `var smsdo = client.Smsdo();`

#### Operations

| Method | Description |
| --- | --- |
| `Create(data)` | Create a new entity with the given data. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `allow_duplicates` | `long` | When parameter allow_duplicates is set to "1" allows to send message to duplicated numbers in one request (useful i.e. |
| `check_idx` | `object?` | When parameter check_idx is set to „1” prevents from sending more than one message with the same idx in last 24h. |
| `date` | `object?` | Date in UNIX timestamp (&date=1287734110) or in ISO 8601 (&date=2012-05-10T08:40:27+00:00) when message will be sent (&date=1287734110). |
| `date_validate` | `long` | When parameter date_validate is set to "1" checks if date if given in proper format. |
| `details` | `object?` | When details parameter is set to "1" more details in response will be displayed (message length and sms count). |
| `encoding` | `string` | This parameter describes the encoding of the message text. |
| `expiration_date` | `object?` | Message expiration date (in UNIX timestamp or in ISO 8601) is a date after which message won't be delivered if it wasn't delivered yet. |
| `fallback` | `List<object?>` | Enable fallback in case sms sending fails |
| `fast` | `long` | Setting this parameter to „1” will result in sending message with the highest priority which ensures the quickest possible time of delivery. |
| `flash` | `long` | Sending a message in flash mode can be activated by setting this parameter to "1". |
| `format` | `string` | Parameter &format=json causes, that response is sending in JSON format. |
| `from` | `string` | Name of the sender. |
| `group` | `string` | Name of the group from the contacts database to which message should be sent to. |
| `idx` | `string` | Optional custom value sent with SMS and sent back in CALLBACK. |
| `max_parts` | `long` | Defines maximum message parts allowed, maximum value allowed is 6. |
| `message` | `string` | The message text. |
| `normalize` | `long` | When parameter normalize is set to „1” special chars in message will be replaced with their equivalents (ê-e, ñ-n, ý-y ...). |
| `notify_url` | `string` | Parameter allows to set CALLBACK URL for message from request. |
| `test` | `object?` | When parameter test is set to "1" message won't be sent but response will be displayed, there is no charge for such test messages. |
| `time_restriction` | `string` | Sets the behavior when you try to ship in hours / dates that do not match the settings in your account. |
| `to` | `string` | Recipients' mobile phone numbers (i.e. |

#### Example: Create

```csharp
var smsdo = client.Smsdo().Create(new Dictionary<string, object?>
{
});
```


### Smssendername

Create an instance: `var smssendername = client.Smssendername();`

#### Operations

| Method | Description |
| --- | --- |
| `Create(data)` | Create a new entity with the given data. |
| `Remove(match)` | Remove the matching entity. |

#### Example: Create

```csharp
var smssendername = client.Smssendername().Create(new Dictionary<string, object?>
{
    ["sendername_id"] = "example_sendername_id",  // string
});
```


### Smstemplate

Create an instance: `var smstemplate = client.Smstemplate();`

#### Operations

| Method | Description |
| --- | --- |
| `Remove(match)` | Remove the matching entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `id` | `string` |  |


### Subuser

Create an instance: `var subuser = client.Subuser();`

#### Operations

| Method | Description |
| --- | --- |
| `Create(data)` | Create a new entity with the given data. |
| `List(null)` | List entities, optionally matching the given criteria. |
| `Load(match)` | Load a single entity by match criteria. |
| `Remove(match)` | Remove the matching entity. |
| `Update(data)` | Update an existing entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `active` | `bool` |  |
| `credentials` | `Dictionary<string, object?>` |  |
| `description` | `string` |  |
| `id` | `string` | Object ID |
| `points` | `Dictionary<string, object?>` |  |
| `username` | `string` |  |

#### Example: Load

```csharp
var subuser = client.Subuser().Load(new Dictionary<string, object?> { ["id"] = "subuser_id" });
```

#### Example: List

```csharp
var subuserList = client.Subuser().List(null);
```

#### Example: Create

```csharp
var subuser = client.Subuser().Create(new Dictionary<string, object?>
{
    ["credentials"] = new Dictionary<string, object?>(),  // Dictionary<string, object?>
});
```


### Template

Create an instance: `var template = client.Template();`

#### Operations

| Method | Description |
| --- | --- |
| `Create(data)` | Create a new entity with the given data. |
| `List(null)` | List entities, optionally matching the given criteria. |
| `Load(match)` | Load a single entity by match criteria. |
| `Update(data)` | Update an existing entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `id` | `string` |  |
| `name` | `string` |  |
| `normalize` | `bool` |  |
| `template` | `string` |  |

#### Example: Load

```csharp
var template = client.Template().Load(new Dictionary<string, object?> { ["id"] = "template_id" });
```

#### Example: List

```csharp
var templateList = client.Template().List(null);
```

#### Example: Create

```csharp
var template = client.Template().Create(new Dictionary<string, object?>
{
});
```


### UserRcsSenderCollection

Create an instance: `var userRcsSenderCollection = client.UserRcsSenderCollection();`

#### Operations

| Method | Description |
| --- | --- |
| `List(null)` | List entities, optionally matching the given criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `deliveredAt` | `string` |  |
| `expiredAt` | `string` |  |
| `id` | `string` | Object ID |
| `interface` | `string` | Interface through which the message was sent (www, api, ...). |
| `messageType` | `string` | RCS message type (basic, single, ...). |
| `readAt` | `string` |  |
| `recipient` | `string` | Recipient phone number (without +). |
| `sender` | `string` | Sender name |
| `senderId` | `string` | Sender id |
| `sentAt` | `string` |  |

#### Example: List

```csharp
var userRcsSenderCollectionList = client.UserRcsSenderCollection().List(null);
```

## Features

This SDK ships 20 optional features. Each is **inactive until you
switch it on**, so an SDK you have not configured behaves exactly as if none of
them existed — no retries, no cache, no logging, no measurable overhead.

Activate a feature by name in the client options, alongside the options shown
above:

| Feature | What it does |
|---|---|
| [`audit`](#audit) | Audit trail |
| [`cache`](#cache) | Response cache |
| [`clienttrack`](#clienttrack) | Client tracking |
| [`cost`](#cost) | Cost tracking |
| [`debug`](#debug) | Debug capture |
| [`idempotency`](#idempotency) | Idempotency |
| [`log`](#log) | Logging |
| [`metrics`](#metrics) | Metrics |
| [`netsim`](#netsim) | Network simulation |
| [`paging`](#paging) | Paging |
| [`proxy`](#proxy) | Proxy |
| [`ratelimit`](#ratelimit) | Rate limiting |
| [`rbac`](#rbac) | Access control |
| [`retry`](#retry) | Retry |
| [`secrets`](#secrets) | Secrets |
| [`streaming`](#streaming) | Streaming |
| [`telemetry`](#telemetry) | Telemetry |
| [`test`](#test) | Test transport |
| [`timeout`](#timeout) | Timeout |
| [`validate`](#validate) | Validation |

> **Order matters for `cache`, `cost`, `netsim`, `proxy`, `ratelimit`, `retry`, `secrets`, `timeout`.** These wrap the
> transport, so each one wraps whatever is already installed: the order you
> activate them in IS the nesting order. Activating them as an ordered list
> rather than a map is what fixes that order.

### audit

Audit trail.

| Option | Default |
|---|---|
| `active` | `false` |
| `actor` | `'anonymous'` |
| `max` | `1000` |

Set `feature.audit.active` to enable it, then override any of the options above.

### cache

Response cache.

| Option | Default |
|---|---|
| `active` | `false` |
| `max` | `256` |
| `methods` | `['GET']` |
| `ttl` | `5000` |

Set `feature.cache.active` to enable it, then override any of the options above.

`cache` wraps the transport, so its position among the other
transport features decides what it sees. A feature activated later wraps one
activated earlier.

### clienttrack

Client tracking.

| Option | Default |
|---|---|
| `active` | `false` |
| `clientVersion` | `'0.0.1'` |

Set `feature.clienttrack.active` to enable it, then override any of the options above.

### cost

Cost tracking.

| Option | Default |
|---|---|
| `active` | `false` |
| `budget` | `0` |
| `currency` | `'USD'` |
| `header` | `''` |
| `onBudget` | `'warn'` |
| `path` | `''` |
| `perUnit` | `0` |
| `rates` | `{}` |
| `unit` | `0` |

Set `feature.cost.active` to enable it, then override any of the options above.

`cost` wraps the transport, so its position among the other
transport features decides what it sees. A feature activated later wraps one
activated earlier.

### debug

Debug capture.

| Option | Default |
|---|---|
| `active` | `false` |
| `max` | `100` |
| `redact` | `['authorization', 'cookie', 'set-cookie', 'api-key', 'apikey', 'x-api-key', 'idempotency-key']` |

Set `feature.debug.active` to enable it, then override any of the options above.

### idempotency

Idempotency.

| Option | Default |
|---|---|
| `active` | `false` |
| `header` | `'Idempotency-Key'` |
| `methods` | `['POST', 'PUT', 'PATCH', 'DELETE']` |
| `ops` | `['create', 'update', 'remove']` |

Set `feature.idempotency.active` to enable it, then override any of the options above.

### log

Logging.

| Option | Default |
|---|---|
| `active` | `true` |

Set `feature.log.active` to enable it, then override any of the options above.

### metrics

Metrics.

| Option | Default |
|---|---|
| `active` | `false` |

Set `feature.metrics.active` to enable it, then override any of the options above.

### netsim

Network simulation.

| Option | Default |
|---|---|
| `active` | `false` |
| `errorTimes` | `0` |
| `failEvery` | `0` |
| `failRate` | `0` |
| `failStatus` | `503` |
| `failTimes` | `0` |
| `latency` | `0` |
| `offline` | `false` |
| `rateLimitTimes` | `0` |
| `retryAfter` | `0` |
| `seed` | `1` |

Set `feature.netsim.active` to enable it, then override any of the options above.

`netsim` wraps the transport, so its position among the other
transport features decides what it sees. A feature activated later wraps one
activated earlier.

### paging

Paging.

| Option | Default |
|---|---|
| `active` | `false` |
| `afterVar` | `'after'` |
| `cursorParam` | `'cursor'` |
| `firstVar` | `'first'` |
| `limitParam` | `'limit'` |
| `pageParam` | `'page'` |
| `startPage` | `1` |

Set `feature.paging.active` to enable it, then override any of the options above.

### proxy

Proxy.

| Option | Default |
|---|---|
| `active` | `false` |
| `fromEnv` | `false` |
| `noProxy` | `[]` |
| `url` | `''` |

Set `feature.proxy.active` to enable it, then override any of the options above.

`proxy` wraps the transport, so its position among the other
transport features decides what it sees. A feature activated later wraps one
activated earlier.

### ratelimit

Rate limiting.

| Option | Default |
|---|---|
| `active` | `false` |
| `burst` | `5` |
| `rate` | `5` |

Set `feature.ratelimit.active` to enable it, then override any of the options above.

`ratelimit` wraps the transport, so its position among the other
transport features decides what it sees. A feature activated later wraps one
activated earlier.

### rbac

Access control.

| Option | Default |
|---|---|
| `active` | `false` |
| `deny` | `false` |
| `permissions` | `[]` |
| `rules` | `{}` |

Set `feature.rbac.active` to enable it, then override any of the options above.

### retry

Retry.

| Option | Default |
|---|---|
| `active` | `false` |
| `factor` | `2` |
| `maxDelay` | `2000` |
| `minDelay` | `50` |
| `retries` | `2` |
| `statuses` | `[408, 425, 429, 500, 502, 503, 504]` |

Set `feature.retry.active` to enable it, then override any of the options above.

`retry` wraps the transport, so its position among the other
transport features decides what it sees. A feature activated later wraps one
activated earlier.

### secrets

Secrets.

| Option | Default |
|---|---|
| `active` | `false` |
| `cache` | `true` |
| `exchange` | `{active: false, method: 'POST', path: 'auth/token', refresh: '', request: 'refresh_token', response: 'access_token', retries: 1, statuses: [401]}` |
| `name` | `'apikey'` |
| `providers` | `[]` |

Set `feature.secrets.active` to enable it, then override any of the options above.

`secrets` wraps the transport, so its position among the other
transport features decides what it sees. A feature activated later wraps one
activated earlier.

### streaming

Streaming.

| Option | Default |
|---|---|
| `active` | `false` |
| `chunkDelay` | `0` |
| `chunkSize` | `0` |

Set `feature.streaming.active` to enable it, then override any of the options above.

### telemetry

Telemetry.

| Option | Default |
|---|---|
| `active` | `false` |

Set `feature.telemetry.active` to enable it, then override any of the options above.

### test

Test transport.

| Option | Default |
|---|---|
| `active` | `false` |

Set `feature.test.active` to enable it, then override any of the options above.

### timeout

Timeout.

| Option | Default |
|---|---|
| `active` | `false` |
| `ms` | `30000` |

Set `feature.timeout.active` to enable it, then override any of the options above.

`timeout` wraps the transport, so its position among the other
transport features decides what it sees. A feature activated later wraps one
activated earlier.

### validate

Validation.

| Option | Default |
|---|---|
| `active` | `false` |
| `mode` | `'throw'` |
| `request` | `true` |
| `response` | `false` |
| `strict` | `false` |

Set `feature.validate.active` to enable it, then override any of the options above.


## Open types

2 fields are carried as open values rather than typed structures.
This follows from the API definition, not from a gap in this SDK: the
definition describes them with untagged unions —
`oneOf`/`anyOf` branches with no `discriminator` — so it never states which
variant a given value is. Nothing can select a branch reliably, so the SDK
passes the value through unchanged rather than assert a shape the API does not
guarantee.

| Entity | Field | Variants | Nesting |
| --- | --- | --- | --- |
| `smsdo` | `check_idx` | 3 | 0 levels |
| `smsdo` | `test` | 3 | 0 levels |

These values round-trip unchanged — read them, modify them, send them back. If
the API adds a `discriminator` to the definition, regenerating will type them.
Every other field is typed normally.

## Advanced

> The sections above cover everyday use. The material below explains the
> SDK's internals — useful when extending it with custom features, but not
> needed for normal use.

### The operation pipeline

Every entity operation follows a six-stage pipeline. Each stage fires a
feature hook before executing:

```
PrePoint → PreSpec → PreRequest → PreResponse → PreResult → PreDone
```

- **PrePoint**: Resolves which API endpoint to call based on the
  operation name and entity configuration.
- **PreSpec**: Builds the HTTP spec — URL, method, headers, body —
  from the resolved point and the caller's parameters.
- **PreRequest**: Sends the HTTP request. Features can intercept here
  to replace the transport (as TestFeature does with mocks).
- **PreResponse**: Parses the raw HTTP response.
- **PreResult**: Extracts the business data from the parsed response.
- **PreDone**: Final stage before returning to the caller. Entity
  state (match, data) is updated here.

If any stage errors, the pipeline short-circuits and the error surfaces
to the caller — see [Error handling](#error-handling) for how that looks
in this language.

### Features and hooks

Features are the extension mechanism. A feature is an object with a
`hooks` map. Each hook key is a pipeline stage name, and the value is
a function that receives the context.

The SDK ships with built-in features:

- **AuditFeature**: Audit trail
- **CacheFeature**: Response cache
- **ClienttrackFeature**: Client tracking
- **CostFeature**: Cost tracking
- **DebugFeature**: Debug capture
- **IdempotencyFeature**: Idempotency
- **LogFeature**: Logging
- **MetricsFeature**: Metrics
- **NetsimFeature**: Network simulation
- **PagingFeature**: Paging
- **ProxyFeature**: Proxy
- **RatelimitFeature**: Rate limiting
- **RbacFeature**: Access control
- **RetryFeature**: Retry
- **SecretsFeature**: Secrets
- **StreamingFeature**: Streaming
- **TelemetryFeature**: Telemetry
- **TestFeature**: Test transport
- **TimeoutFeature**: Timeout
- **ValidateFeature**: Validation

Features are initialized in order. Hooks fire in the order features
were added, so later features can override earlier ones.

### Data as dictionaries

The C# SDK uses a loose object model — `Dictionary<string, object?>`
throughout — rather than a bespoke typed class per endpoint. This mirrors
the dynamic nature of the API and keeps the SDK flexible: no regeneration is
needed when the API schema changes.

Use `Helpers.ToMapAny(value)` to safely coerce a value to a
`Dictionary<string, object?>`. A `SmsapiTypes.cs` module of
reference `record` types is also generated for editor documentation.

### Project structure

```
csharp/
├── SmsapiSDK.csproj    -- Library project (compiles everything except test/)
├── core/                       -- Main SDK client, config, entity base, error type
├── entity/                     -- Entity implementations
├── feature/                    -- Built-in features (Base, Test, Log, ...)
├── utility/                    -- Utility functions and the vendored struct library
└── test/                       -- xUnit test suites
```

The main client class (`SmsapiSDK`, namespace
`SmsapiSdk`) exposes the entity accessors. Reference entity or
utility types directly only when needed.

### Entity state

Entity instances are stateful. After a successful `load`, the entity
stores the returned data and match criteria internally. Subsequent
calls on the same instance can rely on this state.

```ts
const permission = client.Permission()
await permission.load({ group_id: "example", id: "example_id", username: "example" })

// permission.data() now returns the permission data from the last `load`
// permission.match() returns { id: "example_id" }
```

Call `make()` to create a fresh instance with the same configuration
but no stored state.

### Direct vs entity access

The entity interface handles URL construction, parameter placement,
and response parsing automatically. Use it for standard CRUD operations.

The `direct` method gives full control over the HTTP request. Use it
for non-standard endpoints, bulk operations, or any path not modelled
as an entity. The `prepare` method is useful for debugging — it
shows exactly what `direct` would send.


## Full Reference

See [REFERENCE.md](REFERENCE.md) for complete API reference
documentation including all method signatures, entity field schemas,
and detailed usage examples.
