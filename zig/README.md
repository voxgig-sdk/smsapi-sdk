# Smsapi Zig SDK

An MCP server and CLI for the SMSAPI REST API, plus clients in 13 languages and a pandas data layer, generated from SMSAPI's public OpenAPI spec so AI agents can reach SMSAPI the way the official SDKs already let developers.

The Zig SDK for the Smsapi API — an entity-oriented client following idiomatic Zig conventions.

The SDK exposes the API as capitalised, semantic **Entities** — for example `client.available(h.vnull())` — each
carrying a small, uniform set of operations (`list`, `load`, `create`, `update`, `remove`) instead of raw URL
paths and query strings. You work with named resources and verbs, which
keeps the cognitive load low.

> Other languages, the CLI, and MCP server live alongside this one — see
> the [top-level README](../README.md).


## Install
Zig has no central package registry, so this package is distributed as a
git tag (`zig/vX.Y.Z`, see [Tags](https://github.com/voxgig-sdk/smsapi-sdk/tags)). Add it to
your `build.zig.zon` dependencies, or build from a source checkout:

```bash
cd zig && zig build
```

To depend on it from another project, add the tagged archive to
`build.zig.zon`:

```zig
.dependencies = .{
    .sdk = .{
        .url = "<repo-url>/archive/refs/tags/zig/vX.Y.Z.tar.gz",
        // .hash = "...", // filled in by `zig fetch`
    },
},
```


## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record.

### 1. Create a client

```zig
const std = @import("std");
const sdk = @import("sdk");
const h = sdk.h;

const client = sdk.SmsapiSDK.new(h.jo(&.{
    .{ "apikey", h.vstr(std.posix.getenv("SMSAPI_APIKEY") orelse "") },
}));
```

### 2. List available records

`list()`'s `.ok` is a slice of entities, one per record — `switch` on
it. `asEntity().data(null)` reads an entity's record.

```zig
switch (client.available(h.vnull()).list(h.vnull(), h.vnull())) {
    .ok => |availables| {
        for (availables) |available| {
            std.debug.print("{s}\n", .{h.stringify(available.asEntity().data(null))});
        }
    },
    .err => |e| std.debug.print("list failed: {s}\n", .{e.msg}),
}
```

### 3. Load a permission

Permission is nested under group, so provide the `group_id`.
`load()`'s `.ok` carries the entity; `asEntity().data(null)` reads its
record.

```zig
switch (client.permission(h.vnull()).load(h.jo(&.{.{ "group_id", h.vstr("example_group_id") }, .{ "id", h.vstr("example_id") }}), h.vnull())) {
    .ok => |permission| std.debug.print("{s}\n", .{h.stringify(permission.asEntity().data(null))}),
    .err => |e| std.debug.print("load failed: {s}\n", .{e.msg}),
}
```


## Error handling

Entity operations reject on failure, so wrap them in `try` / `catch`:

```ts
try {
  const templates = await client.Template().list()
  console.log(templates.map((item) => item.data()))
} catch (err) {
  console.error('list failed:', err)
}
```

The low-level `direct()` method does **not** throw — it returns the
result envelope. Branch on `ok`; on failure `status` holds the HTTP status
(for error responses) and `err` holds the error:

```ts
const result = await client.direct({
  path: '/api/resource/{id}',
  method: 'GET',
  params: { id: 'example_id' },
})

if (!result.ok) {
  console.error('request failed:', result.status, result.err)
}
```


## How-to guides

### Make a direct HTTP request

For endpoints not covered by entity methods:

```zig
const result = client.direct(h.jo(&.{
    .{ "path", h.vstr("/api/resource/{id}") },
    .{ "method", h.vstr("GET") },
    .{ "params", h.jo(&.{.{ "id", h.vstr("example") }}) },
}));

if (h.get_bool(result, "ok") orelse false) {
    std.debug.print("{d}\n", .{h.to_int(h.getp(result, "status"))}); // 200
    std.debug.print("{s}\n", .{h.stringify(h.getp(result, "data"))}); // response body
} else {
    // A non-2xx response carries status + data (the error body); a
    // transport-level failure carries err instead. Only one is present.
    std.debug.print("{s}\n", .{h.get_str(result, "err") orelse ""});
}
```

### Prepare a request without sending it

```zig
// prepare() returns the fetch definition (an error union — use `catch`/`try`).
const fetchdef = client.prepare(h.jo(&.{
    .{ "path", h.vstr("/api/resource/{id}") },
    .{ "method", h.vstr("DELETE") },
    .{ "params", h.jo(&.{.{ "id", h.vstr("example") }}) },
})) catch unreachable;

std.debug.print("{s}\n", .{h.get_str(fetchdef, "url") orelse ""});
std.debug.print("{s}\n", .{h.get_str(fetchdef, "method") orelse ""});
std.debug.print("{s}\n", .{h.stringify(h.getp(fetchdef, "headers"))});
```

### Use test mode

Create a mock client for unit testing — no server required:

```zig
const client = sdk.test_sdk(h.vnull(), h.vnull());

// list's .ok is one entity per mock record, .err the error.
switch (client.template(h.vnull()).list(h.vnull(), h.vnull())) {
    .ok => |templates| {
        for (templates) |template| {
            std.debug.print("{s}\n", .{h.stringify(template.asEntity().data(null))});
        }
    },
    .err => |e| std.debug.print("list failed: {s}\n", .{e.msg}),
}
```

### Point at a different server

Override the base URL to reach a local or staging server:

```zig
const client = sdk.SmsapiSDK.new(h.jo(&.{
    .{ "base", h.vstr("http://localhost:8080") },
}));
```

### Run live tests

Create a `.env.local` file at the project root:

```
SMSAPI_TEST_LIVE=TRUE
SMSAPI_APIKEY=<your-key>
```

Then run:

```bash
cd zig && zig build test
```


## Reference

### SmsapiSDK

```zig
const sdk = @import("sdk");
const h = sdk.h;

const client = sdk.SmsapiSDK.new(options);
```

Creates a new SDK client. `options` is a `Value` map (`h.vnull()` for
none) carrying any of the following keys:

| Option | Value type | Description |
| --- | --- | --- |
| `apikey` | `string` | API key for authentication. |
| `base` | `string` | Base URL of the API server. |
| `prefix` | `string` | URL path prefix prepended to all requests. |
| `suffix` | `string` | URL path suffix appended to all requests. |
| `feature` | `map` | Feature activation flags. |
| `system` | `map` | System overrides (e.g. a custom fetcher). |

### test_sdk

```zig
const client = sdk.test_sdk(testopts, sdkopts);
```

Creates a test-mode client with mock transport. Both arguments may be
`h.vnull()`.

### SmsapiSDK methods

| Method | Signature | Description |
| --- | --- | --- |
| `options_map` | `() Value` | Deep copy of the current SDK options. |
| `get_utility` | `() *Utility` | Copy of the SDK utility object. |
| `prepare` | `(fetchargs: Value) E!Value` | Build an HTTP request definition without sending. |
| `direct` | `(fetchargs: Value) Value` | Build and send an HTTP request. Returns a result map (branch on `ok`). |
| `available` | `(entopts: Value) *AvailableEntity` | Create an Available entity instance. |
| `blacklist` | `(entopts: Value) *BlacklistEntity` | Create a Blacklist entity instance. |
| `callback` | `(entopts: Value) *CallbackEntity` | Create a Callback entity instance. |
| `contact` | `(entopts: Value) *ContactEntity` | Create a Contact entity instance. |
| `contacts_field` | `(entopts: Value) *ContactsFieldEntity` | Create a ContactsField entity instance. |
| `contacts_field_option` | `(entopts: Value) *ContactsFieldOptionEntity` | Create a ContactsFieldOption entity instance. |
| `contactsgroup` | `(entopts: Value) *ContactsgroupEntity` | Create a Contactsgroup entity instance. |
| `contactstrash` | `(entopts: Value) *ContactstrashEntity` | Create a Contactstrash entity instance. |
| `field_available` | `(entopts: Value) *FieldAvailableEntity` | Create a FieldAvailable entity instance. |
| `group` | `(entopts: Value) *GroupEntity` | Create a Group entity instance. |
| `mfa_code` | `(entopts: Value) *MfaCodeEntity` | Create a MfaCode entity instance. |
| `opt_out` | `(entopts: Value) *OptOutEntity` | Create an OptOut entity instance. |
| `opt_out_setting` | `(entopts: Value) *OptOutSettingEntity` | Create an OptOutSetting entity instance. |
| `permission` | `(entopts: Value) *PermissionEntity` | Create a Permission entity instance. |
| `ping` | `(entopts: Value) *PingEntity` | Create a Ping entity instance. |
| `profile` | `(entopts: Value) *ProfileEntity` | Create a Profile entity instance. |
| `rcs` | `(entopts: Value) *RcsEntity` | Create a Rcs entity instance. |
| `sendername` | `(entopts: Value) *SendernameEntity` | Create a Sendername entity instance. |
| `sendername_statement` | `(entopts: Value) *SendernameStatementEntity` | Create a SendernameStatement entity instance. |
| `sent_rcs_message` | `(entopts: Value) *SentRcsMessageEntity` | Create a SentRcsMessage entity instance. |
| `shipment_country_volume` | `(entopts: Value) *ShipmentCountryVolumeEntity` | Create a ShipmentCountryVolume entity instance. |
| `short_url` | `(entopts: Value) *ShortUrlEntity` | Create a ShortUrl entity instance. |
| `smsdo` | `(entopts: Value) *SmsdoEntity` | Create a Smsdo entity instance. |
| `smssendername` | `(entopts: Value) *SmssendernameEntity` | Create a Smssendername entity instance. |
| `smstemplate` | `(entopts: Value) *SmstemplateEntity` | Create a Smstemplate entity instance. |
| `subuser` | `(entopts: Value) *SubuserEntity` | Create a Subuser entity instance. |
| `template` | `(entopts: Value) *TemplateEntity` | Create a Template entity instance. |
| `user_rcs_sender_collection` | `(entopts: Value) *UserRcsSenderCollectionEntity` | Create an UserRcsSenderCollection entity instance. |

### Entity interface

All entities share the same interface.

| Method | Signature | Description |
| --- | --- | --- |
| `load` | `(reqmatch: Value, ctrl: Value) EntResult` | Load a single entity by match criteria. |
| `list` | `(reqmatch: Value, ctrl: Value) EntListResult` | List entities matching the criteria (`.ok` is a slice of entities, one per record). |
| `create` | `(reqdata: Value, ctrl: Value) EntResult` | Create a new entity. |
| `update` | `(reqdata: Value, ctrl: Value) EntResult` | Update an existing entity. |
| `remove` | `(reqmatch: Value, ctrl: Value) EntResult` | Remove an entity, which is returned marked as deleted. |
| `stream` | `(action: []const u8, args: Value, callopts: Value) StreamResult` | Run an op through the pipeline: `.ok` with its result items, or `.err` with the error that failed it. |
| `data` | `(args: ?Value) Value` | Get entity data (pass a map to set). |
| `matchv` | `(args: ?Value) Value` | Get entity match criteria (pass a map to set). |
| `get_name` | `() []const u8` | Return the entity name. |

### Result shape

Entity operations return a result union — `switch` on it: `.ok` carries
the entity (`EntResult`), or for `list` a slice of entities, one per record
(`EntListResult`), and `asEntity().data(null)` reads an entity's record;
`.err` carries the branded error pointer.

The `direct()` escape hatch returns a result `Value` map directly (no
error union) — even on a non-2xx response — that you branch on via
`h.get_bool(result, "ok")`:

| Key | Type | Description |
| --- | --- | --- |
| `ok` | `bool` | `true` if the HTTP status is 2xx. |
| `status` | `number` | HTTP status code. |
| `headers` | `map` | Response headers. |
| `data` | `any` | Parsed JSON response body. |

On error, `ok` is `false` and `err` carries the error message.

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
| `groups` |  |
| `id` | Object ID |
| `idx` | User provided resource id |
| `last_name` |  |
| `name` | Group name |
| `permissions` |  |
| `phone_number` |  |
| `size` |  |
| `source` |  |

Operations: Create, List, Load, Remove, Update.

API path: `/contacts/{contactId}/groups`

#### ContactsField

| Field | Description |
| --- | --- |
| `id` | Object ID |
| `name` |  |
| `type` |  |

Operations: Create, List, Remove, Update.

API path: `/contacts/fields`

#### ContactsFieldOption

| Field | Description |
| --- | --- |

Operations: List.

API path: `/contacts/fields/{fieldId}/options`

#### Contactsgroup

| Field | Description |
| --- | --- |
| `group_id` | Object ID |
| `read` | Has read permission |
| `send` | Has send permission |
| `username` |  |
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
| `sender` | RCS sender ID (object ID of the agent/sender the user has access to). |
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

Operations: List.

API path: `/rcs/senders`



## Entities


### Available

Create an instance: `const available = client.available(h.vnull());`

#### Operations

| Method | Description |
| --- | --- |
| `list(reqmatch, ctrl)` | List entities, optionally matching the given criteria. |

Each operation returns a result union — `switch` on it: `.ok` carries the
entity (for `list`, a slice of entities, one per record), whose record
`asEntity().data(null)` reads, and `.err => |e|` the branded error.

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `name` | `[]const u8` |  |
| `normalize` | `bool` |  |
| `template` | `[]const u8` |  |

#### Example: List

```zig
switch (client.available(h.vnull()).list(h.vnull(), h.vnull())) {
    .ok => |availables| {
        for (availables) |available| {
            std.debug.print("{s}\n", .{h.stringify(available.asEntity().data(null))});
        }
    },
    .err => |e| std.debug.print("list failed: {s}\n", .{e.msg}),
}
```


### Blacklist

Create an instance: `const blacklist = client.blacklist(h.vnull());`

#### Operations

| Method | Description |
| --- | --- |
| `create(reqdata, ctrl)` | Create a new entity with the given data. |
| `load(reqmatch, ctrl)` | Load a single entity by match criteria. |
| `remove(reqmatch, ctrl)` | Remove the matching entity. |

Each operation returns a result union — `switch` on it: `.ok` carries the
entity (for `list`, a slice of entities, one per record), whose record
`asEntity().data(null)` reads, and `.err => |e|` the branded error.

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `id` | `[]const u8` |  |

#### Example: Load

```zig
switch (client.blacklist(h.vnull()).load(h.vnull(), h.vnull())) {
    .ok => |blacklist| std.debug.print("{s}\n", .{h.stringify(blacklist.asEntity().data(null))}),
    .err => |e| std.debug.print("load failed: {s}\n", .{e.msg}),
}
```

#### Example: Create

```zig
switch (client.blacklist(h.vnull()).create(h.jo(&.{
}), h.vnull())) {
    .ok => |blacklist| std.debug.print("{s}\n", .{h.stringify(blacklist.asEntity().data(null))}),
    .err => |e| std.debug.print("create failed: {s}\n", .{e.msg}),
}
```


### Callback

Create an instance: `const callback = client.callback(h.vnull());`

#### Operations

| Method | Description |
| --- | --- |
| `create(reqdata, ctrl)` | Create a new entity with the given data. |
| `list(reqmatch, ctrl)` | List entities, optionally matching the given criteria. |
| `load(reqmatch, ctrl)` | Load a single entity by match criteria. |
| `remove(reqmatch, ctrl)` | Remove the matching entity. |
| `update(reqdata, ctrl)` | Update an existing entity. |

Each operation returns a result union — `switch` on it: `.ok` carries the
entity (for `list`, a slice of entities, one per record), whose record
`asEntity().data(null)` reads, and `.err => |e|` the branded error.

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `active` | `bool` |  |
| `api_version` | `i64` | Version of the callback output format. |
| `id` | `[]const u8` | Object ID |
| `invalid` | `bool` |  |
| `receiver` | `Value (object)` |  |
| `receiver_type` | `[]const u8` |  |
| `type` | `[]const u8` |  |
| `url` | `[]const u8` | WHATWG URL compliant |

#### Example: Load

```zig
switch (client.callback(h.vnull()).load(h.jo(&.{.{ "id", h.vstr("callback_id") }}), h.vnull())) {
    .ok => |callback| std.debug.print("{s}\n", .{h.stringify(callback.asEntity().data(null))}),
    .err => |e| std.debug.print("load failed: {s}\n", .{e.msg}),
}
```

#### Example: List

```zig
switch (client.callback(h.vnull()).list(h.vnull(), h.vnull())) {
    .ok => |callbacks| {
        for (callbacks) |callback| {
            std.debug.print("{s}\n", .{h.stringify(callback.asEntity().data(null))});
        }
    },
    .err => |e| std.debug.print("list failed: {s}\n", .{e.msg}),
}
```

#### Example: Create

```zig
switch (client.callback(h.vnull()).create(h.jo(&.{
}), h.vnull())) {
    .ok => |callback| std.debug.print("{s}\n", .{h.stringify(callback.asEntity().data(null))}),
    .err => |e| std.debug.print("create failed: {s}\n", .{e.msg}),
}
```


### Contact

Create an instance: `const contact = client.contact(h.vnull());`

#### Operations

| Method | Description |
| --- | --- |
| `create(reqdata, ctrl)` | Create a new entity with the given data. |
| `list(reqmatch, ctrl)` | List entities, optionally matching the given criteria. |
| `load(reqmatch, ctrl)` | Load a single entity by match criteria. |
| `remove(reqmatch, ctrl)` | Remove the matching entity. |
| `update(reqdata, ctrl)` | Update an existing entity. |

Each operation returns a result union — `switch` on it: `.ok` carries the
entity (for `list`, a slice of entities, one per record), whose record
`asEntity().data(null)` reads, and `.err => |e|` the branded error.

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `birthday_date` | `[]const u8` |  |
| `city` | `[]const u8` |  |
| `collection` | `Value (array)` |  |
| `contact_expire_after` | `i64` | Contact expire after days |
| `contacts_count` | `i64` |  |
| `country` | `[]const u8` |  |
| `created_by` | `[]const u8` |  |
| `date_created` | `[]const u8` |  |
| `date_updated` | `[]const u8` |  |
| `description` | `[]const u8` |  |
| `email` | `[]const u8` |  |
| `first_name` | `[]const u8` |  |
| `gender` | `[]const u8` |  |
| `groups` | `Value (array)` |  |
| `id` | `[]const u8` | Object ID |
| `idx` | `[]const u8` | User provided resource id |
| `last_name` | `[]const u8` |  |
| `name` | `[]const u8` | Group name |
| `permissions` | `Value (array)` |  |
| `phone_number` | `[]const u8` |  |
| `size` | `i64` |  |
| `source` | `[]const u8` |  |

#### Example: Load

```zig
switch (client.contact(h.vnull()).load(h.jo(&.{.{ "id", h.vstr("contact_id") }}), h.vnull())) {
    .ok => |contact| std.debug.print("{s}\n", .{h.stringify(contact.asEntity().data(null))}),
    .err => |e| std.debug.print("load failed: {s}\n", .{e.msg}),
}
```

#### Example: List

```zig
switch (client.contact(h.vnull()).list(h.vnull(), h.vnull())) {
    .ok => |contacts| {
        for (contacts) |contact| {
            std.debug.print("{s}\n", .{h.stringify(contact.asEntity().data(null))});
        }
    },
    .err => |e| std.debug.print("list failed: {s}\n", .{e.msg}),
}
```

#### Example: Create

```zig
switch (client.contact(h.vnull()).create(h.jo(&.{
    .{ "collection", h.olist() }, // Value (array)
    .{ "contact_expire_after", h.vnum(1) }, // i64
    .{ "contacts_count", h.vnum(1) }, // i64
    .{ "created_by", h.vstr("example_created_by") }, // []const u8
    .{ "date_created", h.vstr("example_date_created") }, // []const u8
    .{ "date_updated", h.vstr("example_date_updated") }, // []const u8
    .{ "gender", h.vstr("example_gender") }, // []const u8
    .{ "groups", h.olist() }, // Value (array)
    .{ "id", h.vstr("example_id") }, // []const u8
    .{ "name", h.vstr("example_name") }, // []const u8
    .{ "size", h.vnum(1) }, // i64
}), h.vnull())) {
    .ok => |contact| std.debug.print("{s}\n", .{h.stringify(contact.asEntity().data(null))}),
    .err => |e| std.debug.print("create failed: {s}\n", .{e.msg}),
}
```


### ContactsField

Create an instance: `const contacts_field = client.contacts_field(h.vnull());`

#### Operations

| Method | Description |
| --- | --- |
| `create(reqdata, ctrl)` | Create a new entity with the given data. |
| `list(reqmatch, ctrl)` | List entities, optionally matching the given criteria. |
| `remove(reqmatch, ctrl)` | Remove the matching entity. |
| `update(reqdata, ctrl)` | Update an existing entity. |

Each operation returns a result union — `switch` on it: `.ok` carries the
entity (for `list`, a slice of entities, one per record), whose record
`asEntity().data(null)` reads, and `.err => |e|` the branded error.

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `id` | `[]const u8` | Object ID |
| `name` | `[]const u8` |  |
| `type` | `[]const u8` |  |

#### Example: List

```zig
switch (client.contacts_field(h.vnull()).list(h.vnull(), h.vnull())) {
    .ok => |contacts_fields| {
        for (contacts_fields) |contacts_field| {
            std.debug.print("{s}\n", .{h.stringify(contacts_field.asEntity().data(null))});
        }
    },
    .err => |e| std.debug.print("list failed: {s}\n", .{e.msg}),
}
```

#### Example: Create

```zig
switch (client.contacts_field(h.vnull()).create(h.jo(&.{
}), h.vnull())) {
    .ok => |contacts_field| std.debug.print("{s}\n", .{h.stringify(contacts_field.asEntity().data(null))}),
    .err => |e| std.debug.print("create failed: {s}\n", .{e.msg}),
}
```


### ContactsFieldOption

Create an instance: `const contacts_field_option = client.contacts_field_option(h.vnull());`

#### Operations

| Method | Description |
| --- | --- |
| `list(reqmatch, ctrl)` | List entities, optionally matching the given criteria. |

Each operation returns a result union — `switch` on it: `.ok` carries the
entity (for `list`, a slice of entities, one per record), whose record
`asEntity().data(null)` reads, and `.err => |e|` the branded error.

#### Example: List

```zig
switch (client.contacts_field_option(h.vnull()).list(h.jo(&.{.{ "field_id", h.vstr("example") }}), h.vnull())) {
    .ok => |contacts_field_options| {
        for (contacts_field_options) |contacts_field_option| {
            std.debug.print("{s}\n", .{h.stringify(contacts_field_option.asEntity().data(null))});
        }
    },
    .err => |e| std.debug.print("list failed: {s}\n", .{e.msg}),
}
```


### Contactsgroup

Create an instance: `const contactsgroup = client.contactsgroup(h.vnull());`

#### Operations

| Method | Description |
| --- | --- |
| `create(reqdata, ctrl)` | Create a new entity with the given data. |
| `list(reqmatch, ctrl)` | List entities, optionally matching the given criteria. |
| `remove(reqmatch, ctrl)` | Remove the matching entity. |
| `update(reqdata, ctrl)` | Update an existing entity. |

Each operation returns a result union — `switch` on it: `.ok` carries the
entity (for `list`, a slice of entities, one per record), whose record
`asEntity().data(null)` reads, and `.err => |e|` the branded error.

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `group_id` | `[]const u8` | Object ID |
| `read` | `bool` | Has read permission |
| `send` | `bool` | Has send permission |
| `username` | `[]const u8` |  |
| `write` | `bool` | Has write permission |

#### Example: List

```zig
switch (client.contactsgroup(h.vnull()).list(h.vnull(), h.vnull())) {
    .ok => |contactsgroups| {
        for (contactsgroups) |contactsgroup| {
            std.debug.print("{s}\n", .{h.stringify(contactsgroup.asEntity().data(null))});
        }
    },
    .err => |e| std.debug.print("list failed: {s}\n", .{e.msg}),
}
```

#### Example: Create

```zig
switch (client.contactsgroup(h.vnull()).create(h.jo(&.{
    .{ "group_id", h.vstr("example_group_id") }, // []const u8
    .{ "read", h.vbool(true) }, // bool
    .{ "send", h.vbool(true) }, // bool
    .{ "username", h.vstr("example_username") }, // []const u8
    .{ "write", h.vbool(true) }, // bool
}), h.vnull())) {
    .ok => |contactsgroup| std.debug.print("{s}\n", .{h.stringify(contactsgroup.asEntity().data(null))}),
    .err => |e| std.debug.print("create failed: {s}\n", .{e.msg}),
}
```


### Contactstrash

Create an instance: `const contactstrash = client.contactstrash(h.vnull());`

#### Operations

| Method | Description |
| --- | --- |
| `remove(reqmatch, ctrl)` | Remove the matching entity. |
| `update(reqdata, ctrl)` | Update an existing entity. |

Each operation returns a result union — `switch` on it: `.ok` carries the
entity (for `list`, a slice of entities, one per record), whose record
`asEntity().data(null)` reads, and `.err => |e|` the branded error.


### FieldAvailable

Create an instance: `const field_available = client.field_available(h.vnull());`

#### Operations

| Method | Description |
| --- | --- |
| `list(reqmatch, ctrl)` | List entities, optionally matching the given criteria. |

Each operation returns a result union — `switch` on it: `.ok` carries the
entity (for `list`, a slice of entities, one per record), whose record
`asEntity().data(null)` reads, and `.err => |e|` the branded error.

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `built_in` | `bool` |  |
| `id` | `[]const u8` | Object ID |
| `name` | `[]const u8` |  |
| `options` | `Value (array)` |  |
| `type` | `[]const u8` |  |

#### Example: List

```zig
switch (client.field_available(h.vnull()).list(h.vnull(), h.vnull())) {
    .ok => |field_availables| {
        for (field_availables) |field_available| {
            std.debug.print("{s}\n", .{h.stringify(field_available.asEntity().data(null))});
        }
    },
    .err => |e| std.debug.print("list failed: {s}\n", .{e.msg}),
}
```


### Group

Create an instance: `const group = client.group(h.vnull());`

#### Operations

| Method | Description |
| --- | --- |
| `load(reqmatch, ctrl)` | Load a single entity by match criteria. |
| `update(reqdata, ctrl)` | Update an existing entity. |

Each operation returns a result union — `switch` on it: `.ok` carries the
entity (for `list`, a slice of entities, one per record), whose record
`asEntity().data(null)` reads, and `.err => |e|` the branded error.

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `contact_expire_after` | `i64` | Contact expire after days |
| `contacts_count` | `i64` |  |
| `created_by` | `[]const u8` |  |
| `date_created` | `[]const u8` |  |
| `date_updated` | `[]const u8` |  |
| `description` | `[]const u8` |  |
| `id` | `[]const u8` | Object ID |
| `idx` | `[]const u8` | User provided resource id |
| `name` | `[]const u8` | Group name |
| `permissions` | `Value (array)` |  |

#### Example: Load

```zig
switch (client.group(h.vnull()).load(h.jo(&.{.{ "id", h.vstr("group_id") }}), h.vnull())) {
    .ok => |group| std.debug.print("{s}\n", .{h.stringify(group.asEntity().data(null))}),
    .err => |e| std.debug.print("load failed: {s}\n", .{e.msg}),
}
```


### MfaCode

Create an instance: `const mfa_code = client.mfa_code(h.vnull());`

#### Operations

| Method | Description |
| --- | --- |
| `create(reqdata, ctrl)` | Create a new entity with the given data. |

Each operation returns a result union — `switch` on it: `.ok` carries the
entity (for `list`, a slice of entities, one per record), whose record
`asEntity().data(null)` reads, and `.err => |e|` the branded error.

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `content` | `[]const u8` | Custom content that must contain placeholder [%code%] |
| `fast` | `Value` |  |
| `from` | `[]const u8` | Sendername |
| `phone_number` | `[]const u8` |  |

#### Example: Create

```zig
switch (client.mfa_code(h.vnull()).create(h.jo(&.{
    .{ "phone_number", h.vstr("example_phone_number") }, // []const u8
}), h.vnull())) {
    .ok => |mfa_code| std.debug.print("{s}\n", .{h.stringify(mfa_code.asEntity().data(null))}),
    .err => |e| std.debug.print("create failed: {s}\n", .{e.msg}),
}
```


### OptOut

Create an instance: `const opt_out = client.opt_out(h.vnull());`

#### Operations

| Method | Description |
| --- | --- |
| `list(reqmatch, ctrl)` | List entities, optionally matching the given criteria. |
| `remove(reqmatch, ctrl)` | Remove the matching entity. |

Each operation returns a result union — `switch` on it: `.ok` carries the
entity (for `list`, a slice of entities, one per record), whose record
`asEntity().data(null)` reads, and `.err => |e|` the branded error.

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `date` | `[]const u8` |  |
| `id` | `[]const u8` |  |
| `links` | `Value (array)` |  |
| `phoneNumber` | `i64` |  |

#### Example: List

```zig
switch (client.opt_out(h.vnull()).list(h.vnull(), h.vnull())) {
    .ok => |opt_outs| {
        for (opt_outs) |opt_out| {
            std.debug.print("{s}\n", .{h.stringify(opt_out.asEntity().data(null))});
        }
    },
    .err => |e| std.debug.print("list failed: {s}\n", .{e.msg}),
}
```


### OptOutSetting

Create an instance: `const opt_out_setting = client.opt_out_setting(h.vnull());`

#### Operations

| Method | Description |
| --- | --- |
| `load(reqmatch, ctrl)` | Load a single entity by match criteria. |
| `update(reqdata, ctrl)` | Update an existing entity. |

Each operation returns a result union — `switch` on it: `.ok` carries the
entity (for `list`, a slice of entities, one per record), whose record
`asEntity().data(null)` reads, and `.err => |e|` the branded error.

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `brand` | `[]const u8` |  |

#### Example: Load

```zig
switch (client.opt_out_setting(h.vnull()).load(h.vnull(), h.vnull())) {
    .ok => |opt_out_setting| std.debug.print("{s}\n", .{h.stringify(opt_out_setting.asEntity().data(null))}),
    .err => |e| std.debug.print("load failed: {s}\n", .{e.msg}),
}
```


### Permission

Create an instance: `const permission = client.permission(h.vnull());`

#### Operations

| Method | Description |
| --- | --- |
| `create(reqdata, ctrl)` | Create a new entity with the given data. |
| `load(reqmatch, ctrl)` | Load a single entity by match criteria. |

Each operation returns a result union — `switch` on it: `.ok` carries the
entity (for `list`, a slice of entities, one per record), whose record
`asEntity().data(null)` reads, and `.err => |e|` the branded error.

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `group_id` | `[]const u8` | Object ID |
| `id` | `[]const u8` |  |
| `read` | `bool` | Has read permission |
| `send` | `bool` | Has send permission |
| `username` | `[]const u8` |  |
| `write` | `bool` | Has write permission |

#### Example: Load

```zig
switch (client.permission(h.vnull()).load(h.jo(&.{.{ "id", h.vstr("permission_id") }, .{ "group_id", h.vstr("group_id") }}), h.vnull())) {
    .ok => |permission| std.debug.print("{s}\n", .{h.stringify(permission.asEntity().data(null))}),
    .err => |e| std.debug.print("load failed: {s}\n", .{e.msg}),
}
```

#### Example: Create

```zig
switch (client.permission(h.vnull()).create(h.jo(&.{
    .{ "group_id", h.vstr("example_group_id") }, // []const u8
    .{ "read", h.vbool(true) }, // bool
    .{ "send", h.vbool(true) }, // bool
    .{ "username", h.vstr("example_username") }, // []const u8
    .{ "write", h.vbool(true) }, // bool
}), h.vnull())) {
    .ok => |permission| std.debug.print("{s}\n", .{h.stringify(permission.asEntity().data(null))}),
    .err => |e| std.debug.print("create failed: {s}\n", .{e.msg}),
}
```


### Ping

Create an instance: `const ping = client.ping(h.vnull());`

#### Operations

| Method | Description |
| --- | --- |
| `list(reqmatch, ctrl)` | List entities, optionally matching the given criteria. |

Each operation returns a result union — `switch` on it: `.ok` carries the
entity (for `list`, a slice of entities, one per record), whose record
`asEntity().data(null)` reads, and `.err => |e|` the branded error.

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `authorized` | `bool` |  |
| `unavailable` | `Value (array)` |  |

#### Example: List

```zig
switch (client.ping(h.vnull()).list(h.vnull(), h.vnull())) {
    .ok => |pings| {
        for (pings) |ping| {
            std.debug.print("{s}\n", .{h.stringify(ping.asEntity().data(null))});
        }
    },
    .err => |e| std.debug.print("list failed: {s}\n", .{e.msg}),
}
```


### Profile

Create an instance: `const profile = client.profile(h.vnull());`

#### Operations

| Method | Description |
| --- | --- |
| `list(reqmatch, ctrl)` | List entities, optionally matching the given criteria. |
| `load(reqmatch, ctrl)` | Load a single entity by match criteria. |

Each operation returns a result union — `switch` on it: `.ok` carries the
entity (for `list`, a slice of entities, one per record), whose record
`asEntity().data(null)` reads, and `.err => |e|` the branded error.

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `email` | `[]const u8` |  |
| `name` | `[]const u8` |  |
| `payment_type` | `[]const u8` |  |
| `phone_number` | `i64` |  |
| `points` | `f64` |  |
| `user_type` | `[]const u8` |  |
| `username` | `[]const u8` |  |

#### Example: Load

```zig
switch (client.profile(h.vnull()).load(h.vnull(), h.vnull())) {
    .ok => |profile| std.debug.print("{s}\n", .{h.stringify(profile.asEntity().data(null))}),
    .err => |e| std.debug.print("load failed: {s}\n", .{e.msg}),
}
```

#### Example: List

```zig
switch (client.profile(h.vnull()).list(h.vnull(), h.vnull())) {
    .ok => |profiles| {
        for (profiles) |profile| {
            std.debug.print("{s}\n", .{h.stringify(profile.asEntity().data(null))});
        }
    },
    .err => |e| std.debug.print("list failed: {s}\n", .{e.msg}),
}
```


### Rcs

Create an instance: `const rcs = client.rcs(h.vnull());`

#### Operations

| Method | Description |
| --- | --- |
| `list(reqmatch, ctrl)` | List entities, optionally matching the given criteria. |

Each operation returns a result union — `switch` on it: `.ok` carries the
entity (for `list`, a slice of entities, one per record), whose record
`asEntity().data(null)` reads, and `.err => |e|` the branded error.

#### Example: List

```zig
switch (client.rcs(h.vnull()).list(h.vnull(), h.vnull())) {
    .ok => |rcss| {
        for (rcss) |rcs| {
            std.debug.print("{s}\n", .{h.stringify(rcs.asEntity().data(null))});
        }
    },
    .err => |e| std.debug.print("list failed: {s}\n", .{e.msg}),
}
```


### Sendername

Create an instance: `const sendername = client.sendername(h.vnull());`

#### Operations

| Method | Description |
| --- | --- |
| `create(reqdata, ctrl)` | Create a new entity with the given data. |
| `list(reqmatch, ctrl)` | List entities, optionally matching the given criteria. |
| `load(reqmatch, ctrl)` | Load a single entity by match criteria. |

Each operation returns a result union — `switch` on it: `.ok` carries the
entity (for `list`, a slice of entities, one per record), whose record
`asEntity().data(null)` reads, and `.err => |e|` the branded error.

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `created_at` | `[]const u8` |  |
| `id` | `[]const u8` |  |
| `is_default` | `bool` |  |
| `sender` | `[]const u8` | Sendername |
| `status` | `[]const u8` |  |

#### Example: Load

```zig
switch (client.sendername(h.vnull()).load(h.jo(&.{.{ "id", h.vstr("sendername_id") }}), h.vnull())) {
    .ok => |sendername| std.debug.print("{s}\n", .{h.stringify(sendername.asEntity().data(null))}),
    .err => |e| std.debug.print("load failed: {s}\n", .{e.msg}),
}
```

#### Example: List

```zig
switch (client.sendername(h.vnull()).list(h.vnull(), h.vnull())) {
    .ok => |sendernames| {
        for (sendernames) |sendername| {
            std.debug.print("{s}\n", .{h.stringify(sendername.asEntity().data(null))});
        }
    },
    .err => |e| std.debug.print("list failed: {s}\n", .{e.msg}),
}
```

#### Example: Create

```zig
switch (client.sendername(h.vnull()).create(h.jo(&.{
}), h.vnull())) {
    .ok => |sendername| std.debug.print("{s}\n", .{h.stringify(sendername.asEntity().data(null))}),
    .err => |e| std.debug.print("create failed: {s}\n", .{e.msg}),
}
```


### SendernameStatement

Create an instance: `const sendername_statement = client.sendername_statement(h.vnull());`

#### Operations

| Method | Description |
| --- | --- |
| `list(reqmatch, ctrl)` | List entities, optionally matching the given criteria. |

Each operation returns a result union — `switch` on it: `.ok` carries the
entity (for `list`, a slice of entities, one per record), whose record
`asEntity().data(null)` reads, and `.err => |e|` the branded error.

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `content` | `[]const u8` |  |
| `statements` | `Value (array)` |  |
| `title` | `[]const u8` |  |

#### Example: List

```zig
switch (client.sendername_statement(h.vnull()).list(h.vnull(), h.vnull())) {
    .ok => |sendername_statements| {
        for (sendername_statements) |sendername_statement| {
            std.debug.print("{s}\n", .{h.stringify(sendername_statement.asEntity().data(null))});
        }
    },
    .err => |e| std.debug.print("list failed: {s}\n", .{e.msg}),
}
```


### SentRcsMessage

Create an instance: `const sent_rcs_message = client.sent_rcs_message(h.vnull());`

#### Operations

| Method | Description |
| --- | --- |
| `create(reqdata, ctrl)` | Create a new entity with the given data. |

Each operation returns a result union — `switch` on it: `.ok` carries the
entity (for `list`, a slice of entities, one per record), whose record
`asEntity().data(null)` reads, and `.err => |e|` the branded error.

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `content` | `Value (object)` | RCS message content in RCS JSON format. |
| `phone_number` | `[]const u8` | Recipient phone number (e.g. |
| `sender` | `[]const u8` | RCS sender ID (object ID of the agent/sender the user has access to). |
| `text` | `[]const u8` | Plain text message content. |

#### Example: Create

```zig
switch (client.sent_rcs_message(h.vnull()).create(h.jo(&.{
    .{ "phone_number", h.vstr("example_phone_number") }, // []const u8
    .{ "sender", h.vstr("example_sender") }, // []const u8
}), h.vnull())) {
    .ok => |sent_rcs_message| std.debug.print("{s}\n", .{h.stringify(sent_rcs_message.asEntity().data(null))}),
    .err => |e| std.debug.print("create failed: {s}\n", .{e.msg}),
}
```


### ShipmentCountryVolume

Create an instance: `const shipment_country_volume = client.shipment_country_volume(h.vnull());`

#### Operations

| Method | Description |
| --- | --- |
| `list(reqmatch, ctrl)` | List entities, optionally matching the given criteria. |

Each operation returns a result union — `switch` on it: `.ok` carries the
entity (for `list`, a slice of entities, one per record), whose record
`asEntity().data(null)` reads, and `.err => |e|` the branded error.

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `country_code` | `[]const u8` |  |
| `country_limit` | `i64` |  |
| `country_name` | `[]const u8` |  |
| `usage` | `i64` |  |

#### Example: List

```zig
switch (client.shipment_country_volume(h.vnull()).list(h.vnull(), h.vnull())) {
    .ok => |shipment_country_volumes| {
        for (shipment_country_volumes) |shipment_country_volume| {
            std.debug.print("{s}\n", .{h.stringify(shipment_country_volume.asEntity().data(null))});
        }
    },
    .err => |e| std.debug.print("list failed: {s}\n", .{e.msg}),
}
```


### ShortUrl

Create an instance: `const short_url = client.short_url(h.vnull());`

#### Operations

| Method | Description |
| --- | --- |
| `create(reqdata, ctrl)` | Create a new entity with the given data. |
| `list(reqmatch, ctrl)` | List entities, optionally matching the given criteria. |
| `load(reqmatch, ctrl)` | Load a single entity by match criteria. |
| `remove(reqmatch, ctrl)` | Remove the matching entity. |
| `update(reqdata, ctrl)` | Update an existing entity. |

Each operation returns a result union — `switch` on it: `.ok` carries the
entity (for `list`, a slice of entities, one per record), whose record
`asEntity().data(null)` reads, and `.err => |e|` the branded error.

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `description` | `[]const u8` |  |
| `expire` | `[]const u8` |  |
| `filename` | `[]const u8` |  |
| `hits` | `i64` |  |
| `hits_unique` | `i64` |  |
| `id` | `[]const u8` |  |
| `name` | `[]const u8` |  |
| `short_url` | `[]const u8` | WHATWG URL compliant |
| `type` | `[]const u8` |  |
| `url` | `[]const u8` | WHATWG URL compliant |

#### Example: Load

```zig
switch (client.short_url(h.vnull()).load(h.jo(&.{.{ "id", h.vstr("short_url_id") }}), h.vnull())) {
    .ok => |short_url| std.debug.print("{s}\n", .{h.stringify(short_url.asEntity().data(null))}),
    .err => |e| std.debug.print("load failed: {s}\n", .{e.msg}),
}
```

#### Example: List

```zig
switch (client.short_url(h.vnull()).list(h.vnull(), h.vnull())) {
    .ok => |short_urls| {
        for (short_urls) |short_url| {
            std.debug.print("{s}\n", .{h.stringify(short_url.asEntity().data(null))});
        }
    },
    .err => |e| std.debug.print("list failed: {s}\n", .{e.msg}),
}
```

#### Example: Create

```zig
switch (client.short_url(h.vnull()).create(h.jo(&.{
}), h.vnull())) {
    .ok => |short_url| std.debug.print("{s}\n", .{h.stringify(short_url.asEntity().data(null))}),
    .err => |e| std.debug.print("create failed: {s}\n", .{e.msg}),
}
```


### Smsdo

Create an instance: `const smsdo = client.smsdo(h.vnull());`

#### Operations

| Method | Description |
| --- | --- |
| `create(reqdata, ctrl)` | Create a new entity with the given data. |

Each operation returns a result union — `switch` on it: `.ok` carries the
entity (for `list`, a slice of entities, one per record), whose record
`asEntity().data(null)` reads, and `.err => |e|` the branded error.

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `allow_duplicates` | `i64` | When parameter allow_duplicates is set to "1" allows to send message to duplicated numbers in one request (useful i.e. |
| `check_idx` | `Value` | When parameter check_idx is set to „1” prevents from sending more than one message with the same idx in last 24h. |
| `date` | `Value` | Date in UNIX timestamp (&date=1287734110) or in ISO 8601 (&date=2012-05-10T08:40:27+00:00) when message will be sent (&date=1287734110). |
| `date_validate` | `i64` | When parameter date_validate is set to "1" checks if date if given in proper format. |
| `details` | `Value` | When details parameter is set to "1" more details in response will be displayed (message length and sms count). |
| `encoding` | `[]const u8` | This parameter describes the encoding of the message text. |
| `expiration_date` | `Value` | Message expiration date (in UNIX timestamp or in ISO 8601) is a date after which message won't be delivered if it wasn't delivered yet. |
| `fallback` | `Value (array)` | Enable fallback in case sms sending fails |
| `fast` | `i64` | Setting this parameter to „1” will result in sending message with the highest priority which ensures the quickest possible time of delivery. |
| `flash` | `i64` | Sending a message in flash mode can be activated by setting this parameter to "1". |
| `format` | `[]const u8` | Parameter &format=json causes, that response is sending in JSON format. |
| `from` | `[]const u8` | Name of the sender. |
| `group` | `[]const u8` | Name of the group from the contacts database to which message should be sent to. |
| `idx` | `[]const u8` | Optional custom value sent with SMS and sent back in CALLBACK. |
| `max_parts` | `i64` | Defines maximum message parts allowed, maximum value allowed is 6. |
| `message` | `[]const u8` | The message text. |
| `normalize` | `i64` | When parameter normalize is set to „1” special chars in message will be replaced with their equivalents (ê-e, ñ-n, ý-y ...). |
| `notify_url` | `[]const u8` | Parameter allows to set CALLBACK URL for message from request. |
| `test` | `Value` | When parameter test is set to "1" message won't be sent but response will be displayed, there is no charge for such test messages. |
| `time_restriction` | `[]const u8` | Sets the behavior when you try to ship in hours / dates that do not match the settings in your account. |
| `to` | `[]const u8` | Recipients' mobile phone numbers (i.e. |

#### Example: Create

```zig
switch (client.smsdo(h.vnull()).create(h.jo(&.{
}), h.vnull())) {
    .ok => |smsdo| std.debug.print("{s}\n", .{h.stringify(smsdo.asEntity().data(null))}),
    .err => |e| std.debug.print("create failed: {s}\n", .{e.msg}),
}
```


### Smssendername

Create an instance: `const smssendername = client.smssendername(h.vnull());`

#### Operations

| Method | Description |
| --- | --- |
| `create(reqdata, ctrl)` | Create a new entity with the given data. |
| `remove(reqmatch, ctrl)` | Remove the matching entity. |

Each operation returns a result union — `switch` on it: `.ok` carries the
entity (for `list`, a slice of entities, one per record), whose record
`asEntity().data(null)` reads, and `.err => |e|` the branded error.

#### Example: Create

```zig
switch (client.smssendername(h.vnull()).create(h.jo(&.{
    .{ "sender", h.vstr("example_sender") }, // []const u8
}), h.vnull())) {
    .ok => |smssendername| std.debug.print("{s}\n", .{h.stringify(smssendername.asEntity().data(null))}),
    .err => |e| std.debug.print("create failed: {s}\n", .{e.msg}),
}
```


### Smstemplate

Create an instance: `const smstemplate = client.smstemplate(h.vnull());`

#### Operations

| Method | Description |
| --- | --- |
| `remove(reqmatch, ctrl)` | Remove the matching entity. |

Each operation returns a result union — `switch` on it: `.ok` carries the
entity (for `list`, a slice of entities, one per record), whose record
`asEntity().data(null)` reads, and `.err => |e|` the branded error.

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `id` | `[]const u8` |  |


### Subuser

Create an instance: `const subuser = client.subuser(h.vnull());`

#### Operations

| Method | Description |
| --- | --- |
| `create(reqdata, ctrl)` | Create a new entity with the given data. |
| `list(reqmatch, ctrl)` | List entities, optionally matching the given criteria. |
| `load(reqmatch, ctrl)` | Load a single entity by match criteria. |
| `remove(reqmatch, ctrl)` | Remove the matching entity. |
| `update(reqdata, ctrl)` | Update an existing entity. |

Each operation returns a result union — `switch` on it: `.ok` carries the
entity (for `list`, a slice of entities, one per record), whose record
`asEntity().data(null)` reads, and `.err => |e|` the branded error.

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `active` | `bool` |  |
| `credentials` | `Value (object)` |  |
| `description` | `[]const u8` |  |
| `id` | `[]const u8` | Object ID |
| `points` | `Value (object)` |  |
| `username` | `[]const u8` |  |

#### Example: Load

```zig
switch (client.subuser(h.vnull()).load(h.jo(&.{.{ "id", h.vstr("subuser_id") }}), h.vnull())) {
    .ok => |subuser| std.debug.print("{s}\n", .{h.stringify(subuser.asEntity().data(null))}),
    .err => |e| std.debug.print("load failed: {s}\n", .{e.msg}),
}
```

#### Example: List

```zig
switch (client.subuser(h.vnull()).list(h.vnull(), h.vnull())) {
    .ok => |subusers| {
        for (subusers) |subuser| {
            std.debug.print("{s}\n", .{h.stringify(subuser.asEntity().data(null))});
        }
    },
    .err => |e| std.debug.print("list failed: {s}\n", .{e.msg}),
}
```

#### Example: Create

```zig
switch (client.subuser(h.vnull()).create(h.jo(&.{
    .{ "credentials", h.omap() }, // Value (object)
}), h.vnull())) {
    .ok => |subuser| std.debug.print("{s}\n", .{h.stringify(subuser.asEntity().data(null))}),
    .err => |e| std.debug.print("create failed: {s}\n", .{e.msg}),
}
```


### Template

Create an instance: `const template = client.template(h.vnull());`

#### Operations

| Method | Description |
| --- | --- |
| `create(reqdata, ctrl)` | Create a new entity with the given data. |
| `list(reqmatch, ctrl)` | List entities, optionally matching the given criteria. |
| `load(reqmatch, ctrl)` | Load a single entity by match criteria. |
| `update(reqdata, ctrl)` | Update an existing entity. |

Each operation returns a result union — `switch` on it: `.ok` carries the
entity (for `list`, a slice of entities, one per record), whose record
`asEntity().data(null)` reads, and `.err => |e|` the branded error.

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `id` | `[]const u8` |  |
| `name` | `[]const u8` |  |
| `normalize` | `bool` |  |
| `template` | `[]const u8` |  |

#### Example: Load

```zig
switch (client.template(h.vnull()).load(h.jo(&.{.{ "id", h.vstr("template_id") }}), h.vnull())) {
    .ok => |template| std.debug.print("{s}\n", .{h.stringify(template.asEntity().data(null))}),
    .err => |e| std.debug.print("load failed: {s}\n", .{e.msg}),
}
```

#### Example: List

```zig
switch (client.template(h.vnull()).list(h.vnull(), h.vnull())) {
    .ok => |templates| {
        for (templates) |template| {
            std.debug.print("{s}\n", .{h.stringify(template.asEntity().data(null))});
        }
    },
    .err => |e| std.debug.print("list failed: {s}\n", .{e.msg}),
}
```

#### Example: Create

```zig
switch (client.template(h.vnull()).create(h.jo(&.{
}), h.vnull())) {
    .ok => |template| std.debug.print("{s}\n", .{h.stringify(template.asEntity().data(null))}),
    .err => |e| std.debug.print("create failed: {s}\n", .{e.msg}),
}
```


### UserRcsSenderCollection

Create an instance: `const user_rcs_sender_collection = client.user_rcs_sender_collection(h.vnull());`

#### Operations

| Method | Description |
| --- | --- |
| `list(reqmatch, ctrl)` | List entities, optionally matching the given criteria. |

Each operation returns a result union — `switch` on it: `.ok` carries the
entity (for `list`, a slice of entities, one per record), whose record
`asEntity().data(null)` reads, and `.err => |e|` the branded error.

#### Example: List

```zig
switch (client.user_rcs_sender_collection(h.vnull()).list(h.vnull(), h.vnull())) {
    .ok => |user_rcs_sender_collections| {
        for (user_rcs_sender_collections) |user_rcs_sender_collection| {
            std.debug.print("{s}\n", .{h.stringify(user_rcs_sender_collection.asEntity().data(null))});
        }
    },
    .err => |e| std.debug.print("list failed: {s}\n", .{e.msg}),
}
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

### Data as `Value`

The Zig SDK uses a single dynamic `Value` type throughout rather than a
typed struct per entity. `Value` is the vendored voxgig struct port's
`JsonValue` (a JSON-shaped tagged union: `.string`, `.integer`,
`.float`, `.bool`, `.array`, `.object`, `.null`). This mirrors the
dynamic nature of the API and keeps the SDK flexible — no code generation is
needed when the API schema changes.

Build request maps with the `h.jo` / `h.ja` helpers and read fields back
with `h.getp` (or the typed `h.get_str` / `h.get_bool` / `h.to_int`
accessors); use `h.to_map` to safely coerce a value to a map.

### Module structure

```
zig/
├── root.zig                     -- Module root (re-exports the public surface)
├── build.zig                    -- Build + test wiring
├── core/                        -- Pipeline types, config, client (sdk.zig)
├── entity/                      -- Per-entity clients (one file each)
├── feature/                     -- Built-in features (base, test, log)
├── utility/                     -- Utilities + the vendored voxgig struct port
└── test/                        -- Test suites
```

The public API is re-exported from `root.zig`, so `@import("sdk")` reaches
the SDK client, `Value`, and the `h` (helpers) namespace directly. Import
entity or utility modules only when needed.

### Entity state

Entity instances are stateful. After a successful `list`, the entity
stores the returned data and match criteria internally. Subsequent
calls on the same instance can rely on this state.

```ts
const template = client.Template()
await template.list()

// template.data() now returns the template data from the last `list`
// template.match() returns the last match criteria
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
