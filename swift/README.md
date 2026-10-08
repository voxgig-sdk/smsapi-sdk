# Smsapi Swift SDK

An MCP server and CLI for the SMSAPI REST API, plus clients in 13 languages and a pandas data layer, generated from SMSAPI's public OpenAPI spec so AI agents can reach SMSAPI the way the official SDKs already let developers.

The Swift SDK for the Smsapi API — an entity-oriented client following idiomatic Swift conventions.

The SDK exposes the API as capitalised, semantic **Entities** — for example `client.Available()` — each
carrying a small, uniform set of operations (`list`, `load`, `create`, `update`, `remove`) instead of raw URL
paths and query strings. You work with named resources and verbs, which
keeps the cognitive load low.

> Other languages, the CLI, and MCP server live alongside this one — see
> the [top-level README](../README.md).


## Install
This package is not yet published to a SwiftPM registry. The generated SDK
is a dependency-free SwiftPM package (Foundation only, plus the vendored
Voxgig Struct port). Depend on it from the GitHub release tag
(`swift/vX.Y.Z`, see [Tags](https://github.com/voxgig-sdk/smsapi-sdk/tags)) by adding it to
your `Package.swift`:

```swift
dependencies: [
    // From the git release tag:
    .package(url: "<repo-url>", exact: "0.0.1"),
],
```

Or build from a source checkout with SwiftPM:

```bash
cd swift && swift build
```


## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record.

### 1. Create a client

```swift
import SmsapiSdk

let options = VMap()
options.entries["apikey"] = .string(
    ProcessInfo.processInfo.environment["SMSAPI_APIKEY"] ?? "")
let client = SmsapiSDK(options)
```

### 2. List available records

`list(nil, nil)` returns a `Value` list of entities, one per record, and
throws on error; `asNative as? Entity` unwraps an item, and its `data()`
reads the record.

```swift
do {
    let availableList = try client.Available().list(nil, nil)
    for availableItem in availableList.asList?.items ?? [] {
        if let availableEntity = availableItem.asNative as? Entity {
            print(availableEntity.data())
        }
    }
}
catch {
    print("list failed: \(error)")
}
```

### 3. Load a permission

Permission is nested under group, so provide the `group_id`.
`load()` returns the ENTITY — call data() for the record — and throws on error.

```swift
do {
    let permission = try client.Permission().load(VMap([("group_id", .string("example_group_id")), ("id", .string("example_id"))]), nil)
    if let permissionEntity = permission.asNative as? Entity {
        print(permissionEntity.data())
    }
}
catch {
    print("load failed: \(error)")
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

```swift
let result = client.direct(VMap([
    ("path", .string("/api/resource/{id}")),
    ("method", .string("GET")),
    ("params", .map([("id", .string("example"))])),
]))

if result.entries["ok"] == .bool(true) {
    print(result.entries["status"] ?? .noval)  // 200
    print(result.entries["data"] ?? .noval)     // response body
}
else {
    // A non-2xx response carries status + data (the error body); a
    // transport-level failure carries err instead. Only one is present, so
    // an absent key simply reads as .noval.
    print(result.entries["status"] ?? .noval, result.entries["err"] ?? .noval)
}
```

### Prepare a request without sending it

```swift
// prepare() returns the fetch definition and throws on error.
let fetchdef = try client.prepare(VMap([
    ("path", .string("/api/resource/{id}")),
    ("method", .string("DELETE")),
    ("params", .map([("id", .string("example"))])),
]))

print(fetchdef.entries["url"] ?? .noval)
print(fetchdef.entries["method"] ?? .noval)
print(fetchdef.entries["headers"] ?? .noval)
```

### Use test mode

Create a mock client for unit testing — no server required:

```swift
let client = SmsapiSDK.testSDK(nil, nil)

// list returns a Value list of entities, one per mock record; it throws on error.
let templateList = try client.Template().list(nil, nil)
for templateItem in templateList.asList?.items ?? [] {
    if let templateEntity = templateItem.asNative as? Entity {
        print(templateEntity.data())
    }
}
```

### Use a custom fetch function

Replace the HTTP transport with your own `SystemFetch` closure:

```swift
let fetch: SystemFetch = { url, _ in
    let m = VMap()
    m.entries["status"] = .int(200)
    m.entries["statusText"] = .string("OK")
    m.entries["headers"] = .map(VMap())
    m.entries["json"] = .nat({ () -> Value in .map(VMap([("id", .string("mock01"))])) } as NativeCall0)
    return .map(m)
}

let system = VMap()
system.entries["fetch"] = .nat(fetch)
let options = VMap()
options.entries["base"] = .string("http://localhost:8080")
options.entries["system"] = .map(system)
let client = SmsapiSDK(options)
```

### Run live tests

Create a `.env.local` file at the project root:

```
SMSAPI_TEST_LIVE=TRUE
SMSAPI_APIKEY=<your-key>
```

Then run:

```bash
cd swift && make test
```


## Reference

### SmsapiSDK

```swift
let client = SmsapiSDK(options)
```

Creates a new SDK client. `options` is a `VMap` of `Value`.

| Option | Type | Description |
| --- | --- | --- |
| `apikey` | `String` | API key for authentication. |
| `base` | `String` | Base URL of the API server. |
| `prefix` | `String` | URL path prefix prepended to all requests. |
| `suffix` | `String` | URL path suffix appended to all requests. |
| `feature` | `VMap` | Feature activation flags. |
| `extend` | `VList` | Additional Feature instances to load. |
| `system` | `VMap` | System overrides (e.g. custom `fetch` function). |

### testSDK

```swift
let client = SmsapiSDK.testSDK(testopts, sdkopts)
```

Creates a test-mode client with mock transport. Both arguments may be `nil`.

### SmsapiSDK methods

| Method | Signature | Description |
| --- | --- | --- |
| `optionsMap` | `() -> VMap` | Deep copy of current SDK options. |
| `getUtility` | `() -> Utility` | Copy of the SDK utility object. |
| `prepare` | `(fetchargs) throws -> VMap` | Build an HTTP request definition without sending. Throws on error. |
| `direct` | `(fetchargs) -> VMap` | Build and send an HTTP request. Returns a result map (branch on `ok`). |
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
| `load` | `(reqmatch, ctrl) throws -> Value` | Load a single entity by match criteria, and return it. Throws on error. |
| `list` | `(reqmatch, ctrl) throws -> Value` | List entities matching the criteria, one per record. Throws on error. |
| `create` | `(reqdata, ctrl) throws -> Value` | Create a new entity, and return it. Throws on error. |
| `update` | `(reqdata, ctrl) throws -> Value` | Update an existing entity, and return it. Throws on error. |
| `remove` | `(reqmatch, ctrl) throws -> Value` | Remove an entity, and return it marked as deleted. Throws on error. |
| `data` | `(newdata?) -> Value` | Get or set entity data. |
| `matchv` | `(newmatch?) -> Value` | Get or set entity match criteria. |
| `make` | `() -> Entity` | Create a new instance with the same options. |
| `getName` | `() -> String` | Return the entity name. |

### Result shape

Entity operations return the entity, and `list` a `Value` list of entities,
one per record; each entity comes wrapped in a native `Value`, which
`asNative as? Entity` unwraps, and its `data()` reads the record. They
throw on error, so wrap calls in `do`/`catch` to handle failures.

The `direct()` escape hatch never throws — it returns a result `VMap` you
branch on via `result.entries["ok"]`:

| Key | Type | Description |
| --- | --- | --- |
| `ok` | `Bool` | `true` if the HTTP status is 2xx. |
| `status` | `Int` | HTTP status code. |
| `headers` | `VMap` | Response headers. |
| `data` | `Value` | Parsed JSON response body. |

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

Create an instance: `let available = client.Available()`

#### Operations

| Method | Description |
| --- | --- |
| `list(nil, nil)` | List entities, optionally matching the given criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `name` | `String` |  |
| `normalize` | `Bool` |  |
| `template` | `String` |  |

#### Example: List

```swift
let availableList = try client.Available().list(nil, nil)
```


### Blacklist

Create an instance: `let blacklist = client.Blacklist()`

#### Operations

| Method | Description |
| --- | --- |
| `create(data, nil)` | Create a new entity with the given data. |
| `load(match, nil)` | Load a single entity by match criteria. |
| `remove(match, nil)` | Remove the matching entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `id` | `String` |  |

#### Example: Load

```swift
let blacklist = try client.Blacklist().load(nil, nil)
```

#### Example: Create

```swift
let blacklist = try client.Blacklist().create(VMap([
]), nil)
```


### Callback

Create an instance: `let callback = client.Callback()`

#### Operations

| Method | Description |
| --- | --- |
| `create(data, nil)` | Create a new entity with the given data. |
| `list(nil, nil)` | List entities, optionally matching the given criteria. |
| `load(match, nil)` | Load a single entity by match criteria. |
| `remove(match, nil)` | Remove the matching entity. |
| `update(data, nil)` | Update an existing entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `active` | `Bool` |  |
| `api_version` | `Int` | Version of the callback output format. |
| `id` | `String` | Object ID |
| `invalid` | `Bool` |  |
| `receiver` | `VMap` |  |
| `receiver_type` | `String` |  |
| `type` | `String` |  |
| `url` | `String` | WHATWG URL compliant |

#### Example: Load

```swift
let callback = try client.Callback().load(VMap([("id", .string("callback_id"))]), nil)
```

#### Example: List

```swift
let callbackList = try client.Callback().list(nil, nil)
```

#### Example: Create

```swift
let callback = try client.Callback().create(VMap([
]), nil)
```


### Contact

Create an instance: `let contact = client.Contact()`

#### Operations

| Method | Description |
| --- | --- |
| `create(data, nil)` | Create a new entity with the given data. |
| `list(nil, nil)` | List entities, optionally matching the given criteria. |
| `load(match, nil)` | Load a single entity by match criteria. |
| `remove(match, nil)` | Remove the matching entity. |
| `update(data, nil)` | Update an existing entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `birthday_date` | `String` |  |
| `city` | `String` |  |
| `collection` | `[Value]` |  |
| `contact_expire_after` | `Int` | Contact expire after days |
| `contacts_count` | `Int` |  |
| `country` | `String` |  |
| `created_by` | `String` |  |
| `date_created` | `String` |  |
| `date_updated` | `String` |  |
| `description` | `String` |  |
| `email` | `String` |  |
| `first_name` | `String` |  |
| `gender` | `String` |  |
| `groups` | `[Value]` |  |
| `id` | `String` | Object ID |
| `idx` | `String` | User provided resource id |
| `last_name` | `String` |  |
| `name` | `String` | Group name |
| `permissions` | `[Value]` |  |
| `phone_number` | `String` |  |
| `size` | `Int` |  |
| `source` | `String` |  |

#### Example: Load

```swift
let contact = try client.Contact().load(VMap([("id", .string("contact_id"))]), nil)
```

#### Example: List

```swift
let contactList = try client.Contact().list(nil, nil)
```

#### Example: Create

```swift
let contact = try client.Contact().create(VMap([
    ("collection", .list([])),  // [Value]
    ("contact_expire_after", .int(1)),  // Int
    ("contacts_count", .int(1)),  // Int
    ("created_by", .string("example_created_by")),  // String
    ("date_created", .string("example_date_created")),  // String
    ("date_updated", .string("example_date_updated")),  // String
    ("gender", .string("example_gender")),  // String
    ("groups", .list([])),  // [Value]
    ("id", .string("example_id")),  // String
    ("name", .string("example_name")),  // String
    ("size", .int(1))  // Int
]), nil)
```


### ContactsField

Create an instance: `let contactsField = client.ContactsField()`

#### Operations

| Method | Description |
| --- | --- |
| `create(data, nil)` | Create a new entity with the given data. |
| `list(nil, nil)` | List entities, optionally matching the given criteria. |
| `remove(match, nil)` | Remove the matching entity. |
| `update(data, nil)` | Update an existing entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `id` | `String` | Object ID |
| `name` | `String` |  |
| `type` | `String` |  |

#### Example: List

```swift
let contactsFieldList = try client.ContactsField().list(nil, nil)
```

#### Example: Create

```swift
let contactsField = try client.ContactsField().create(VMap([
]), nil)
```


### ContactsFieldOption

Create an instance: `let contactsFieldOption = client.ContactsFieldOption()`

#### Operations

| Method | Description |
| --- | --- |
| `list(nil, nil)` | List entities, optionally matching the given criteria. |

#### Example: List

```swift
let contactsFieldOptionList = try client.ContactsFieldOption().list(VMap([("field_id", .string("example"))]), nil)
```


### Contactsgroup

Create an instance: `let contactsgroup = client.Contactsgroup()`

#### Operations

| Method | Description |
| --- | --- |
| `create(data, nil)` | Create a new entity with the given data. |
| `list(nil, nil)` | List entities, optionally matching the given criteria. |
| `remove(match, nil)` | Remove the matching entity. |
| `update(data, nil)` | Update an existing entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `group_id` | `String` | Object ID |
| `read` | `Bool` | Has read permission |
| `send` | `Bool` | Has send permission |
| `username` | `String` |  |
| `write` | `Bool` | Has write permission |

#### Example: List

```swift
let contactsgroupList = try client.Contactsgroup().list(nil, nil)
```

#### Example: Create

```swift
let contactsgroup = try client.Contactsgroup().create(VMap([
    ("group_id", .string("example_group_id")),  // String
    ("read", .bool(true)),  // Bool
    ("send", .bool(true)),  // Bool
    ("username", .string("example_username")),  // String
    ("write", .bool(true))  // Bool
]), nil)
```


### Contactstrash

Create an instance: `let contactstrash = client.Contactstrash()`

#### Operations

| Method | Description |
| --- | --- |
| `remove(match, nil)` | Remove the matching entity. |
| `update(data, nil)` | Update an existing entity. |


### FieldAvailable

Create an instance: `let fieldAvailable = client.FieldAvailable()`

#### Operations

| Method | Description |
| --- | --- |
| `list(nil, nil)` | List entities, optionally matching the given criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `built_in` | `Bool` |  |
| `id` | `String` | Object ID |
| `name` | `String` |  |
| `options` | `[Value]` |  |
| `type` | `String` |  |

#### Example: List

```swift
let fieldAvailableList = try client.FieldAvailable().list(nil, nil)
```


### Group

Create an instance: `let group = client.Group()`

#### Operations

| Method | Description |
| --- | --- |
| `load(match, nil)` | Load a single entity by match criteria. |
| `update(data, nil)` | Update an existing entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `contact_expire_after` | `Int` | Contact expire after days |
| `contacts_count` | `Int` |  |
| `created_by` | `String` |  |
| `date_created` | `String` |  |
| `date_updated` | `String` |  |
| `description` | `String` |  |
| `id` | `String` | Object ID |
| `idx` | `String` | User provided resource id |
| `name` | `String` | Group name |
| `permissions` | `[Value]` |  |

#### Example: Load

```swift
let group = try client.Group().load(VMap([("id", .string("group_id"))]), nil)
```


### MfaCode

Create an instance: `let mfaCode = client.MfaCode()`

#### Operations

| Method | Description |
| --- | --- |
| `create(data, nil)` | Create a new entity with the given data. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `content` | `String` | Custom content that must contain placeholder [%code%] |
| `fast` | `Value` |  |
| `from` | `String` | Sendername |
| `phone_number` | `String` |  |

#### Example: Create

```swift
let mfaCode = try client.MfaCode().create(VMap([
    ("phone_number", .string("example_phone_number"))  // String
]), nil)
```


### OptOut

Create an instance: `let optOut = client.OptOut()`

#### Operations

| Method | Description |
| --- | --- |
| `list(nil, nil)` | List entities, optionally matching the given criteria. |
| `remove(match, nil)` | Remove the matching entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `date` | `String` |  |
| `id` | `String` |  |
| `links` | `[Value]` |  |
| `phoneNumber` | `Int` |  |

#### Example: List

```swift
let optOutList = try client.OptOut().list(nil, nil)
```


### OptOutSetting

Create an instance: `let optOutSetting = client.OptOutSetting()`

#### Operations

| Method | Description |
| --- | --- |
| `load(match, nil)` | Load a single entity by match criteria. |
| `update(data, nil)` | Update an existing entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `brand` | `String` |  |

#### Example: Load

```swift
let optOutSetting = try client.OptOutSetting().load(nil, nil)
```


### Permission

Create an instance: `let permission = client.Permission()`

#### Operations

| Method | Description |
| --- | --- |
| `create(data, nil)` | Create a new entity with the given data. |
| `load(match, nil)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `group_id` | `String` | Object ID |
| `id` | `String` |  |
| `read` | `Bool` | Has read permission |
| `send` | `Bool` | Has send permission |
| `username` | `String` |  |
| `write` | `Bool` | Has write permission |

#### Example: Load

```swift
let permission = try client.Permission().load(VMap([("id", .string("permission_id")), ("group_id", .string("group_id"))]), nil)
```

#### Example: Create

```swift
let permission = try client.Permission().create(VMap([
    ("group_id", .string("example_group_id")),  // String
    ("read", .bool(true)),  // Bool
    ("send", .bool(true)),  // Bool
    ("username", .string("example_username")),  // String
    ("write", .bool(true))  // Bool
]), nil)
```


### Ping

Create an instance: `let ping = client.Ping()`

#### Operations

| Method | Description |
| --- | --- |
| `list(nil, nil)` | List entities, optionally matching the given criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `authorized` | `Bool` |  |
| `unavailable` | `[Value]` |  |

#### Example: List

```swift
let pingList = try client.Ping().list(nil, nil)
```


### Profile

Create an instance: `let profile = client.Profile()`

#### Operations

| Method | Description |
| --- | --- |
| `list(nil, nil)` | List entities, optionally matching the given criteria. |
| `load(match, nil)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `email` | `String` |  |
| `name` | `String` |  |
| `payment_type` | `String` |  |
| `phone_number` | `Int` |  |
| `points` | `Double` |  |
| `user_type` | `String` |  |
| `username` | `String` |  |

#### Example: Load

```swift
let profile = try client.Profile().load(nil, nil)
```

#### Example: List

```swift
let profileList = try client.Profile().list(nil, nil)
```


### Rcs

Create an instance: `let rcs = client.Rcs()`

#### Operations

| Method | Description |
| --- | --- |
| `list(nil, nil)` | List entities, optionally matching the given criteria. |

#### Example: List

```swift
let rcsList = try client.Rcs().list(nil, nil)
```


### Sendername

Create an instance: `let sendername = client.Sendername()`

#### Operations

| Method | Description |
| --- | --- |
| `create(data, nil)` | Create a new entity with the given data. |
| `list(nil, nil)` | List entities, optionally matching the given criteria. |
| `load(match, nil)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `created_at` | `String` |  |
| `id` | `String` |  |
| `is_default` | `Bool` |  |
| `sender` | `String` | Sendername |
| `status` | `String` |  |

#### Example: Load

```swift
let sendername = try client.Sendername().load(VMap([("id", .string("sendername_id"))]), nil)
```

#### Example: List

```swift
let sendernameList = try client.Sendername().list(nil, nil)
```

#### Example: Create

```swift
let sendername = try client.Sendername().create(VMap([
]), nil)
```


### SendernameStatement

Create an instance: `let sendernameStatement = client.SendernameStatement()`

#### Operations

| Method | Description |
| --- | --- |
| `list(nil, nil)` | List entities, optionally matching the given criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `content` | `String` |  |
| `statements` | `[Value]` |  |
| `title` | `String` |  |

#### Example: List

```swift
let sendernameStatementList = try client.SendernameStatement().list(nil, nil)
```


### SentRcsMessage

Create an instance: `let sentRcsMessage = client.SentRcsMessage()`

#### Operations

| Method | Description |
| --- | --- |
| `create(data, nil)` | Create a new entity with the given data. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `content` | `VMap` | RCS message content in RCS JSON format. |
| `phone_number` | `String` | Recipient phone number (e.g. |
| `sender` | `String` | RCS sender ID (object ID of the agent/sender the user has access to). |
| `text` | `String` | Plain text message content. |

#### Example: Create

```swift
let sentRcsMessage = try client.SentRcsMessage().create(VMap([
    ("phone_number", .string("example_phone_number")),  // String
    ("sender", .string("example_sender"))  // String
]), nil)
```


### ShipmentCountryVolume

Create an instance: `let shipmentCountryVolume = client.ShipmentCountryVolume()`

#### Operations

| Method | Description |
| --- | --- |
| `list(nil, nil)` | List entities, optionally matching the given criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `country_code` | `String` |  |
| `country_limit` | `Int` |  |
| `country_name` | `String` |  |
| `usage` | `Int` |  |

#### Example: List

```swift
let shipmentCountryVolumeList = try client.ShipmentCountryVolume().list(nil, nil)
```


### ShortUrl

Create an instance: `let shortUrl = client.ShortUrl()`

#### Operations

| Method | Description |
| --- | --- |
| `create(data, nil)` | Create a new entity with the given data. |
| `list(nil, nil)` | List entities, optionally matching the given criteria. |
| `load(match, nil)` | Load a single entity by match criteria. |
| `remove(match, nil)` | Remove the matching entity. |
| `update(data, nil)` | Update an existing entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `description` | `String` |  |
| `expire` | `String` |  |
| `filename` | `String` |  |
| `hits` | `Int` |  |
| `hits_unique` | `Int` |  |
| `id` | `String` |  |
| `name` | `String` |  |
| `short_url` | `String` | WHATWG URL compliant |
| `type` | `String` |  |
| `url` | `String` | WHATWG URL compliant |

#### Example: Load

```swift
let shortUrl = try client.ShortUrl().load(VMap([("id", .string("short_url_id"))]), nil)
```

#### Example: List

```swift
let shortUrlList = try client.ShortUrl().list(nil, nil)
```

#### Example: Create

```swift
let shortUrl = try client.ShortUrl().create(VMap([
]), nil)
```


### Smsdo

Create an instance: `let smsdo = client.Smsdo()`

#### Operations

| Method | Description |
| --- | --- |
| `create(data, nil)` | Create a new entity with the given data. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `allow_duplicates` | `Int` | When parameter allow_duplicates is set to "1" allows to send message to duplicated numbers in one request (useful i.e. |
| `check_idx` | `Value` | When parameter check_idx is set to „1” prevents from sending more than one message with the same idx in last 24h. |
| `date` | `Value` | Date in UNIX timestamp (&date=1287734110) or in ISO 8601 (&date=2012-05-10T08:40:27+00:00) when message will be sent (&date=1287734110). |
| `date_validate` | `Int` | When parameter date_validate is set to "1" checks if date if given in proper format. |
| `details` | `Value` | When details parameter is set to "1" more details in response will be displayed (message length and sms count). |
| `encoding` | `String` | This parameter describes the encoding of the message text. |
| `expiration_date` | `Value` | Message expiration date (in UNIX timestamp or in ISO 8601) is a date after which message won't be delivered if it wasn't delivered yet. |
| `fallback` | `[Value]` | Enable fallback in case sms sending fails |
| `fast` | `Int` | Setting this parameter to „1” will result in sending message with the highest priority which ensures the quickest possible time of delivery. |
| `flash` | `Int` | Sending a message in flash mode can be activated by setting this parameter to "1". |
| `format` | `String` | Parameter &format=json causes, that response is sending in JSON format. |
| `from` | `String` | Name of the sender. |
| `group` | `String` | Name of the group from the contacts database to which message should be sent to. |
| `idx` | `String` | Optional custom value sent with SMS and sent back in CALLBACK. |
| `max_parts` | `Int` | Defines maximum message parts allowed, maximum value allowed is 6. |
| `message` | `String` | The message text. |
| `normalize` | `Int` | When parameter normalize is set to „1” special chars in message will be replaced with their equivalents (ê-e, ñ-n, ý-y ...). |
| `notify_url` | `String` | Parameter allows to set CALLBACK URL for message from request. |
| `test` | `Value` | When parameter test is set to "1" message won't be sent but response will be displayed, there is no charge for such test messages. |
| `time_restriction` | `String` | Sets the behavior when you try to ship in hours / dates that do not match the settings in your account. |
| `to` | `String` | Recipients' mobile phone numbers (i.e. |

#### Example: Create

```swift
let smsdo = try client.Smsdo().create(VMap([
]), nil)
```


### Smssendername

Create an instance: `let smssendername = client.Smssendername()`

#### Operations

| Method | Description |
| --- | --- |
| `create(data, nil)` | Create a new entity with the given data. |
| `remove(match, nil)` | Remove the matching entity. |

#### Example: Create

```swift
let smssendername = try client.Smssendername().create(VMap([
    ("sender", .string("example_sender"))  // String
]), nil)
```


### Smstemplate

Create an instance: `let smstemplate = client.Smstemplate()`

#### Operations

| Method | Description |
| --- | --- |
| `remove(match, nil)` | Remove the matching entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `id` | `String` |  |


### Subuser

Create an instance: `let subuser = client.Subuser()`

#### Operations

| Method | Description |
| --- | --- |
| `create(data, nil)` | Create a new entity with the given data. |
| `list(nil, nil)` | List entities, optionally matching the given criteria. |
| `load(match, nil)` | Load a single entity by match criteria. |
| `remove(match, nil)` | Remove the matching entity. |
| `update(data, nil)` | Update an existing entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `active` | `Bool` |  |
| `credentials` | `VMap` |  |
| `description` | `String` |  |
| `id` | `String` | Object ID |
| `points` | `VMap` |  |
| `username` | `String` |  |

#### Example: Load

```swift
let subuser = try client.Subuser().load(VMap([("id", .string("subuser_id"))]), nil)
```

#### Example: List

```swift
let subuserList = try client.Subuser().list(nil, nil)
```

#### Example: Create

```swift
let subuser = try client.Subuser().create(VMap([
    ("credentials", .map(VMap()))  // VMap
]), nil)
```


### Template

Create an instance: `let template = client.Template()`

#### Operations

| Method | Description |
| --- | --- |
| `create(data, nil)` | Create a new entity with the given data. |
| `list(nil, nil)` | List entities, optionally matching the given criteria. |
| `load(match, nil)` | Load a single entity by match criteria. |
| `update(data, nil)` | Update an existing entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `id` | `String` |  |
| `name` | `String` |  |
| `normalize` | `Bool` |  |
| `template` | `String` |  |

#### Example: Load

```swift
let template = try client.Template().load(VMap([("id", .string("template_id"))]), nil)
```

#### Example: List

```swift
let templateList = try client.Template().list(nil, nil)
```

#### Example: Create

```swift
let template = try client.Template().create(VMap([
]), nil)
```


### UserRcsSenderCollection

Create an instance: `let userRcsSenderCollection = client.UserRcsSenderCollection()`

#### Operations

| Method | Description |
| --- | --- |
| `list(nil, nil)` | List entities, optionally matching the given criteria. |

#### Example: List

```swift
let userRcsSenderCollectionList = try client.UserRcsSenderCollection().list(nil, nil)
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

### Data as loose values

The Swift SDK uses a loose object model — the vendored `Value` enum
(with `VMap` / `VList` wrappers) throughout — rather than a bespoke typed
struct per endpoint. This mirrors the dynamic nature of the API and keeps the
SDK flexible: no regeneration is needed when the API schema changes.

Use the `.asMap` / `.asList` / `.asString` accessors to safely coerce a
`Value` to a concrete Swift type (each returns `nil` on a type mismatch).
A `SmsapiTypes.swift` file of reference `struct` types is also
generated for editor documentation.

### Project structure

```
swift/
├── Package.swift                     -- SwiftPM manifest (zero runtime deps)
├── Sources/SmsapiSdk/
│   ├── core/                         -- Main client, config, entity base, error type
│   ├── entity/                       -- Generated entity clients
│   ├── feature/                      -- Built-in features (Base, Test, Log, ...)
│   ├── utility/                      -- Utility functions
│   └── Struct/                       -- Vendored Voxgig Struct port
└── Tests/SmsapiSdkTests/    -- Test suites (XCTest)
```

The main client class (`SmsapiSDK`, under `Sources/SmsapiSdk/core`)
exposes the entity accessors. Reference entity or utility types directly only
when needed. The SDK is dependency-free: JSON parsing is the vendored
`Struct/JSON.swift`, HTTP transport is Foundation's `URLSession`, and the
struct library is inlined under `Struct/`.

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
