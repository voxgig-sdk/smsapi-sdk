# Smsapi Swift SDK Reference

Complete API reference for the Smsapi Swift SDK.


## SmsapiSDK

### Constructor

```swift
let client = SmsapiSDK(options)
```

Create a new SDK client instance. `options` is a `VMap` of `Value`.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `options` | `VMap` | SDK configuration options. |
| `options["apikey"]` | `String` | API key for authentication. |
| `options["base"]` | `String` | Base URL for API requests. |
| `options["prefix"]` | `String` | URL prefix appended after base. |
| `options["suffix"]` | `String` | URL suffix appended after path. |
| `options["headers"]` | `VMap` | Custom headers for all requests. |
| `options["feature"]` | `VMap` | Feature configuration. |
| `options["system"]` | `VMap` | System overrides (e.g. custom fetch). |


### Static Methods

#### `SmsapiSDK.testSDK(testopts, sdkopts)`

Create a test client with mock features active. Both arguments may be `nil`.

```swift
let client = SmsapiSDK.testSDK(nil, nil)
```


### Instance Methods

#### `Available(entopts)`

Create a new `Available` entity instance. Pass `nil` for no initial
options.

#### `Blacklist(entopts)`

Create a new `Blacklist` entity instance. Pass `nil` for no initial
options.

#### `Callback(entopts)`

Create a new `Callback` entity instance. Pass `nil` for no initial
options.

#### `Contact(entopts)`

Create a new `Contact` entity instance. Pass `nil` for no initial
options.

#### `ContactsField(entopts)`

Create a new `ContactsField` entity instance. Pass `nil` for no initial
options.

#### `ContactsFieldOption(entopts)`

Create a new `ContactsFieldOption` entity instance. Pass `nil` for no initial
options.

#### `Contactsgroup(entopts)`

Create a new `Contactsgroup` entity instance. Pass `nil` for no initial
options.

#### `Contactstrash(entopts)`

Create a new `Contactstrash` entity instance. Pass `nil` for no initial
options.

#### `FieldAvailable(entopts)`

Create a new `FieldAvailable` entity instance. Pass `nil` for no initial
options.

#### `Group(entopts)`

Create a new `Group` entity instance. Pass `nil` for no initial
options.

#### `MfaCode(entopts)`

Create a new `MfaCode` entity instance. Pass `nil` for no initial
options.

#### `OptOut(entopts)`

Create a new `OptOut` entity instance. Pass `nil` for no initial
options.

#### `OptOutSetting(entopts)`

Create a new `OptOutSetting` entity instance. Pass `nil` for no initial
options.

#### `Permission(entopts)`

Create a new `Permission` entity instance. Pass `nil` for no initial
options.

#### `Ping(entopts)`

Create a new `Ping` entity instance. Pass `nil` for no initial
options.

#### `Profile(entopts)`

Create a new `Profile` entity instance. Pass `nil` for no initial
options.

#### `Rcs(entopts)`

Create a new `Rcs` entity instance. Pass `nil` for no initial
options.

#### `Sendername(entopts)`

Create a new `Sendername` entity instance. Pass `nil` for no initial
options.

#### `SendernameStatement(entopts)`

Create a new `SendernameStatement` entity instance. Pass `nil` for no initial
options.

#### `SentRcsMessage(entopts)`

Create a new `SentRcsMessage` entity instance. Pass `nil` for no initial
options.

#### `ShipmentCountryVolume(entopts)`

Create a new `ShipmentCountryVolume` entity instance. Pass `nil` for no initial
options.

#### `ShortUrl(entopts)`

Create a new `ShortUrl` entity instance. Pass `nil` for no initial
options.

#### `Smsdo(entopts)`

Create a new `Smsdo` entity instance. Pass `nil` for no initial
options.

#### `Smssendername(entopts)`

Create a new `Smssendername` entity instance. Pass `nil` for no initial
options.

#### `Smstemplate(entopts)`

Create a new `Smstemplate` entity instance. Pass `nil` for no initial
options.

#### `Subuser(entopts)`

Create a new `Subuser` entity instance. Pass `nil` for no initial
options.

#### `Template(entopts)`

Create a new `Template` entity instance. Pass `nil` for no initial
options.

#### `UserRcsSenderCollection(entopts)`

Create a new `UserRcsSenderCollection` entity instance. Pass `nil` for no initial
options.

#### `optionsMap() -> VMap`

Return a deep copy of the current SDK options.

#### `getUtility() -> Utility`

Return a copy of the SDK utility object.

#### `direct(fetchargs) -> VMap`

Make a direct HTTP request to any API endpoint. Returns a result `VMap`
with `ok`, `status`, `headers`, and `data` (or `err` on failure).
This escape hatch never throws — branch on `result.entries["ok"]`.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `fetchargs["path"]` | `String` | URL path with optional `{param}` placeholders. |
| `fetchargs["method"]` | `String` | HTTP method (default: `"GET"`). |
| `fetchargs["params"]` | `VMap` | Path parameter values. |
| `fetchargs["query"]` | `VMap` | Query string parameters. |
| `fetchargs["headers"]` | `VMap` | Request headers (merged with defaults). |
| `fetchargs["body"]` | `Value` | Request body (maps are JSON-serialized). |

**Returns:** `VMap`

#### `prepare(fetchargs) throws -> VMap`

Prepare a fetch definition without sending. Returns the `fetchdef` and throws on error.


---

## Available

```swift
let available = client.Available()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `name` | `String` | No |  |
| `normalize` | `Bool` | No |  |
| `template` | `String` | No |  |

### Operations

#### `list(reqmatch, ctrl) throws -> Value`

List entities matching the given criteria. The match is optional — call `list(nil, nil)` to list all records. Returns a Value list and throws on error.

```swift
let results = try client.Available().list(nil, nil)
print(results)
```

### Common Methods

#### `data(newdata?) -> Value`

Get or set the entity data.

#### `matchv(newmatch?) -> Value`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Available` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## Blacklist

```swift
let blacklist = client.Blacklist()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | `String` | No |  |

### Operations

#### `create(reqdata, ctrl) throws -> Value`

Create a new entity with the given data. Returns the created entity data and throws on error.

```swift
let result = try client.Blacklist().create(VMap([
]), nil)
```

#### `load(reqmatch, ctrl) throws -> Value`

Load a single entity matching the given criteria. Returns the entity data and throws on error.

```swift
let result = try client.Blacklist().load(nil, nil)
```

#### `remove(reqmatch, ctrl) throws -> Value`

Remove the entity matching the given criteria. Throws on error.

```swift
let result = try client.Blacklist().remove(VMap([("id", .string("id"))]), nil)
```

### Common Methods

#### `data(newdata?) -> Value`

Get or set the entity data.

#### `matchv(newmatch?) -> Value`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Blacklist` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## Callback

```swift
let callback = client.Callback()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `active` | `Bool` | No |  |
| `api_version` | `Int` | No | Version of the callback output format. |
| `id` | `String` | No | Object ID |
| `invalid` | `Bool` | No |  |
| `receiver` | `VMap` | No |  |
| `receiver_type` | `String` | No |  |
| `type` | `String` | No |  |
| `url` | `String` | No | WHATWG URL compliant |

### Field Usage by Operation

| Field | load | list | create | update | remove |
| --- | --- | --- | --- | --- | --- |
| `active` | - | - | - | - | - |
| `api_version` | - | - | - | - | - |
| `id` | - | - | - | - | - |
| `invalid` | - | - | - | - | - |
| `receiver` | - | - | - | - | - |
| `receiver_type` | - | - | - | - | - |
| `type` | - | - | - | - | - |
| `url` | - | - | - | Yes | - |

### Operations

#### `create(reqdata, ctrl) throws -> Value`

Create a new entity with the given data. Returns the created entity data and throws on error.

```swift
let result = try client.Callback().create(VMap([
]), nil)
```

#### `list(reqmatch, ctrl) throws -> Value`

List entities matching the given criteria. The match is optional — call `list(nil, nil)` to list all records. Returns a Value list and throws on error.

```swift
let results = try client.Callback().list(nil, nil)
print(results)
```

#### `load(reqmatch, ctrl) throws -> Value`

Load a single entity matching the given criteria. Returns the entity data and throws on error.

```swift
let result = try client.Callback().load(VMap([("id", .string("callback_id"))]), nil)
```

#### `remove(reqmatch, ctrl) throws -> Value`

Remove the entity matching the given criteria. Throws on error.

```swift
let result = try client.Callback().remove(VMap([("id", .string("callback_id"))]), nil)
```

#### `update(reqdata, ctrl) throws -> Value`

Update an existing entity. The data must include the entity `id`. Returns the updated entity data and throws on error.

```swift
let result = try client.Callback().update(VMap([
    ("id", .string("callback_id"))
]), nil)
```

### Common Methods

#### `data(newdata?) -> Value`

Get or set the entity data.

#### `matchv(newmatch?) -> Value`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Callback` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## Contact

```swift
let contact = client.Contact()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `birthday_date` | `String` | No |  |
| `city` | `String` | No |  |
| `collection` | `[Value]` | Yes |  |
| `contact_expire_after` | `Int` | Yes | Contact expire after days |
| `contacts_count` | `Int` | Yes |  |
| `country` | `String` | No |  |
| `created_by` | `String` | Yes |  |
| `date_created` | `String` | Yes |  |
| `date_updated` | `String` | Yes |  |
| `description` | `String` | No |  |
| `email` | `String` | No |  |
| `first_name` | `String` | No |  |
| `gender` | `String` | Yes |  |
| `group_id` | `String` | No | Object ID |
| `groups` | `[Value]` | Yes |  |
| `id` | `String` | Yes | Object ID |
| `idx` | `String` | No | User provided resource id |
| `last_name` | `String` | No |  |
| `name` | `String` | Yes | Group name |
| `permissions` | `[Value]` | No |  |
| `phone_number` | `String` | No |  |
| `read` | `Bool` | No | Has read permission |
| `send` | `Bool` | No | Has send permission |
| `size` | `Int` | Yes |  |
| `source` | `String` | No |  |
| `type` | `String` | No |  |
| `username` | `String` | No |  |
| `value` | `String` | No |  |
| `write` | `Bool` | No | Has write permission |

### Field Usage by Operation

| Field | load | list | create | update | remove |
| --- | --- | --- | --- | --- | --- |
| `birthday_date` | - | - | - | - | - |
| `city` | - | - | - | - | - |
| `collection` | - | - | - | Yes | - |
| `contact_expire_after` | - | - | - | - | - |
| `contacts_count` | - | Yes | - | - | - |
| `country` | - | - | - | - | - |
| `created_by` | - | - | - | - | - |
| `date_created` | - | - | - | - | - |
| `date_updated` | - | - | - | - | - |
| `description` | Yes | - | - | - | - |
| `email` | - | - | - | - | - |
| `first_name` | - | - | - | - | - |
| `gender` | - | - | - | - | - |
| `group_id` | - | - | - | - | - |
| `groups` | - | - | - | - | - |
| `id` | - | - | - | - | - |
| `idx` | - | - | - | - | - |
| `last_name` | - | - | - | - | - |
| `name` | - | Yes | - | - | - |
| `permissions` | - | - | - | - | - |
| `phone_number` | - | - | - | - | - |
| `read` | - | - | - | - | - |
| `send` | - | - | - | - | - |
| `size` | - | - | - | - | - |
| `source` | - | - | - | - | - |
| `type` | - | - | - | - | - |
| `username` | - | - | - | - | - |
| `value` | - | - | - | - | - |
| `write` | - | - | - | - | - |

### Operations

#### `create(reqdata, ctrl) throws -> Value`

Create a new entity with the given data. Returns the created entity data and throws on error.

```swift
let result = try client.Contact().create(VMap([
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

#### `list(reqmatch, ctrl) throws -> Value`

List entities matching the given criteria. The match is optional — call `list(nil, nil)` to list all records. Returns a Value list and throws on error.

```swift
let results = try client.Contact().list(nil, nil)
print(results)
```

#### `load(reqmatch, ctrl) throws -> Value`

Load a single entity matching the given criteria. Returns the entity data and throws on error.

```swift
let result = try client.Contact().load(VMap([("id", .string("contact_id"))]), nil)
```

#### `remove(reqmatch, ctrl) throws -> Value`

Remove the entity matching the given criteria. Throws on error.

```swift
let result = try client.Contact().remove(VMap([("id", .string("contact_id"))]), nil)
```

#### `update(reqdata, ctrl) throws -> Value`

Update an existing entity. The data must include the entity `id`. Returns the updated entity data and throws on error.

```swift
let result = try client.Contact().update(VMap([
    ("id", .string("contact_id"))
]), nil)
```

### Common Methods

#### `data(newdata?) -> Value`

Get or set the entity data.

#### `matchv(newmatch?) -> Value`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Contact` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## ContactsField

```swift
let contactsField = client.ContactsField()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `birthday_date` | `String` | No |  |
| `city` | `String` | No |  |
| `contact_expire_after` | `Int` | Yes | Contact expire after days |
| `contacts_count` | `Int` | No |  |
| `country` | `String` | No |  |
| `created_by` | `String` | Yes |  |
| `date_created` | `String` | Yes |  |
| `date_updated` | `String` | Yes |  |
| `description` | `String` | No |  |
| `email` | `String` | No |  |
| `first_name` | `String` | No |  |
| `gender` | `String` | Yes |  |
| `group_id` | `String` | No | Object ID |
| `groups` | `[Value]` | Yes |  |
| `id` | `String` | No | Object ID |
| `idx` | `String` | No | User provided resource id |
| `last_name` | `String` | No |  |
| `name` | `String` | No | Group name |
| `permissions` | `[Value]` | No |  |
| `phone_number` | `String` | No |  |
| `read` | `Bool` | No | Has read permission |
| `send` | `Bool` | No | Has send permission |
| `source` | `String` | No |  |
| `type` | `String` | No |  |
| `username` | `String` | No |  |
| `value` | `String` | No |  |
| `write` | `Bool` | No | Has write permission |

### Field Usage by Operation

| Field | list | create | update | remove |
| --- | --- | --- | --- | --- |
| `birthday_date` | - | - | - | - |
| `city` | - | - | - | - |
| `contact_expire_after` | - | - | - | - |
| `contacts_count` | - | - | - | - |
| `country` | - | - | - | - |
| `created_by` | - | - | - | - |
| `date_created` | - | - | - | - |
| `date_updated` | - | - | - | - |
| `description` | - | - | - | - |
| `email` | - | - | - | - |
| `first_name` | - | - | - | - |
| `gender` | - | - | - | - |
| `group_id` | - | - | - | - |
| `groups` | - | - | - | - |
| `id` | Yes | - | - | - |
| `idx` | - | - | - | - |
| `last_name` | - | - | - | - |
| `name` | - | - | - | - |
| `permissions` | - | - | - | - |
| `phone_number` | - | - | - | - |
| `read` | - | - | - | - |
| `send` | - | - | - | - |
| `source` | - | - | - | - |
| `type` | - | - | - | - |
| `username` | - | - | - | - |
| `value` | - | - | - | - |
| `write` | - | - | - | - |

### Operations

#### `create(reqdata, ctrl) throws -> Value`

Create a new entity with the given data. Returns the created entity data and throws on error.

```swift
let result = try client.ContactsField().create(VMap([
    ("contact_expire_after", .int(1)),  // Int
    ("created_by", .string("example_created_by")),  // String
    ("date_created", .string("example_date_created")),  // String
    ("date_updated", .string("example_date_updated")),  // String
    ("gender", .string("example_gender")),  // String
    ("groups", .list([]))  // [Value]
]), nil)
```

#### `list(reqmatch, ctrl) throws -> Value`

List entities matching the given criteria. The match is optional — call `list(nil, nil)` to list all records. Returns a Value list and throws on error.

```swift
let results = try client.ContactsField().list(nil, nil)
print(results)
```

#### `remove(reqmatch, ctrl) throws -> Value`

Remove the entity matching the given criteria. Throws on error.

```swift
let result = try client.ContactsField().remove(VMap([("id", .string("id"))]), nil)
```

#### `update(reqdata, ctrl) throws -> Value`

Update an existing entity. The data must include the entity `id`. Returns the updated entity data and throws on error.

```swift
let result = try client.ContactsField().update(VMap([
    ("id", .string("id"))
]), nil)
```

### Common Methods

#### `data(newdata?) -> Value`

Get or set the entity data.

#### `matchv(newmatch?) -> Value`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `ContactsField` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## ContactsFieldOption

```swift
let contactsFieldOption = client.ContactsFieldOption()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `birthday_date` | `String` | No |  |
| `city` | `String` | No |  |
| `contact_expire_after` | `Int` | Yes | Contact expire after days |
| `contacts_count` | `Int` | No |  |
| `country` | `String` | No |  |
| `created_by` | `String` | Yes |  |
| `date_created` | `String` | Yes |  |
| `date_updated` | `String` | Yes |  |
| `description` | `String` | No |  |
| `email` | `String` | No |  |
| `first_name` | `String` | No |  |
| `gender` | `String` | Yes |  |
| `group_id` | `String` | No | Object ID |
| `groups` | `[Value]` | Yes |  |
| `id` | `String` | Yes | Object ID |
| `idx` | `String` | No | User provided resource id |
| `last_name` | `String` | No |  |
| `name` | `String` | No | Group name |
| `permissions` | `[Value]` | No |  |
| `phone_number` | `String` | No |  |
| `read` | `Bool` | No | Has read permission |
| `send` | `Bool` | No | Has send permission |
| `source` | `String` | No |  |
| `type` | `String` | No |  |
| `username` | `String` | No |  |
| `value` | `String` | No |  |
| `write` | `Bool` | No | Has write permission |

### Operations

#### `list(reqmatch, ctrl) throws -> Value`

List entities matching the given criteria. The match is optional — call `list(nil, nil)` to list all records. Returns a Value list and throws on error.

```swift
let results = try client.ContactsFieldOption().list(nil, nil)
print(results)
```

### Common Methods

#### `data(newdata?) -> Value`

Get or set the entity data.

#### `matchv(newmatch?) -> Value`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `ContactsFieldOption` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## Contactsgroup

```swift
let contactsgroup = client.Contactsgroup()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `birthday_date` | `String` | No |  |
| `city` | `String` | No |  |
| `contact_expire_after` | `Int` | Yes | Contact expire after days |
| `contacts_count` | `Int` | No |  |
| `country` | `String` | No |  |
| `created_by` | `String` | Yes |  |
| `date_created` | `String` | Yes |  |
| `date_updated` | `String` | Yes |  |
| `description` | `String` | No |  |
| `email` | `String` | No |  |
| `first_name` | `String` | No |  |
| `gender` | `String` | Yes |  |
| `group_id` | `String` | Yes | Object ID |
| `groups` | `[Value]` | Yes |  |
| `id` | `String` | Yes | Object ID |
| `idx` | `String` | No | User provided resource id |
| `last_name` | `String` | No |  |
| `name` | `String` | No | Group name |
| `permissions` | `[Value]` | No |  |
| `phone_number` | `String` | No |  |
| `read` | `Bool` | Yes | Has read permission |
| `send` | `Bool` | Yes | Has send permission |
| `source` | `String` | No |  |
| `type` | `String` | No |  |
| `username` | `String` | Yes |  |
| `value` | `String` | No |  |
| `write` | `Bool` | Yes | Has write permission |

### Field Usage by Operation

| Field | list | create | update | remove |
| --- | --- | --- | --- | --- |
| `birthday_date` | - | - | - | - |
| `city` | - | - | - | - |
| `contact_expire_after` | - | - | - | - |
| `contacts_count` | - | - | - | - |
| `country` | - | - | - | - |
| `created_by` | - | - | - | - |
| `date_created` | - | - | - | - |
| `date_updated` | - | - | - | - |
| `description` | - | - | - | - |
| `email` | - | - | - | - |
| `first_name` | - | - | - | - |
| `gender` | - | - | - | - |
| `group_id` | Yes | - | - | - |
| `groups` | - | - | - | - |
| `id` | - | - | - | - |
| `idx` | - | - | - | - |
| `last_name` | - | - | - | - |
| `name` | - | - | - | - |
| `permissions` | - | - | - | - |
| `phone_number` | - | - | - | - |
| `read` | Yes | - | - | - |
| `send` | Yes | - | - | - |
| `source` | - | - | - | - |
| `type` | - | - | - | - |
| `username` | Yes | - | - | - |
| `value` | - | - | - | - |
| `write` | Yes | - | - | - |

### Operations

#### `create(reqdata, ctrl) throws -> Value`

Create a new entity with the given data. Returns the created entity data and throws on error.

```swift
let result = try client.Contactsgroup().create(VMap([
    ("contact_expire_after", .int(1)),  // Int
    ("created_by", .string("example_created_by")),  // String
    ("date_created", .string("example_date_created")),  // String
    ("date_updated", .string("example_date_updated")),  // String
    ("gender", .string("example_gender")),  // String
    ("group_id", .string("example_group_id")),  // String
    ("groups", .list([])),  // [Value]
    ("id", .string("example_id")),  // String
    ("read", .bool(true)),  // Bool
    ("send", .bool(true)),  // Bool
    ("username", .string("example_username")),  // String
    ("write", .bool(true))  // Bool
]), nil)
```

#### `list(reqmatch, ctrl) throws -> Value`

List entities matching the given criteria. The match is optional — call `list(nil, nil)` to list all records. Returns a Value list and throws on error.

```swift
let results = try client.Contactsgroup().list(nil, nil)
print(results)
```

#### `remove(reqmatch, ctrl) throws -> Value`

Remove the entity matching the given criteria. Throws on error.

```swift
let result = try client.Contactsgroup().remove(VMap([("group_id", .string("group_id"))]), nil)
```

#### `update(reqdata, ctrl) throws -> Value`

Update an existing entity. The data must include the entity `id`. Returns the updated entity data and throws on error.

```swift
let result = try client.Contactsgroup().update(VMap([
    ("group_id", .string("group_id"))
]), nil)
```

### Common Methods

#### `data(newdata?) -> Value`

Get or set the entity data.

#### `matchv(newmatch?) -> Value`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Contactsgroup` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## Contactstrash

```swift
let contactstrash = client.Contactstrash()
```

### Operations

#### `remove(reqmatch, ctrl) throws -> Value`

Remove the entity matching the given criteria. Throws on error.

```swift
let result = try client.Contactstrash().remove(nil, nil)
```

#### `update(reqdata, ctrl) throws -> Value`

Update an existing entity. The data must include the entity `id`. Returns the updated entity data and throws on error.

```swift
let result = try client.Contactstrash().update(VMap([
]), nil)
```

### Common Methods

#### `data(newdata?) -> Value`

Get or set the entity data.

#### `matchv(newmatch?) -> Value`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Contactstrash` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## FieldAvailable

```swift
let fieldAvailable = client.FieldAvailable()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `built_in` | `Bool` | No |  |
| `id` | `String` | No | Object ID |
| `name` | `String` | No |  |
| `options` | `[Value]` | No |  |
| `type` | `String` | No |  |

### Operations

#### `list(reqmatch, ctrl) throws -> Value`

List entities matching the given criteria. The match is optional — call `list(nil, nil)` to list all records. Returns a Value list and throws on error.

```swift
let results = try client.FieldAvailable().list(nil, nil)
print(results)
```

### Common Methods

#### `data(newdata?) -> Value`

Get or set the entity data.

#### `matchv(newmatch?) -> Value`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `FieldAvailable` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## Group

```swift
let group = client.Group()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `contact_expire_after` | `Int` | Yes | Contact expire after days |
| `contacts_count` | `Int` | Yes |  |
| `created_by` | `String` | Yes |  |
| `date_created` | `String` | Yes |  |
| `date_updated` | `String` | Yes |  |
| `description` | `String` | Yes |  |
| `id` | `String` | Yes | Object ID |
| `idx` | `String` | No | User provided resource id |
| `name` | `String` | Yes | Group name |
| `permissions` | `[Value]` | No |  |

### Operations

#### `load(reqmatch, ctrl) throws -> Value`

Load a single entity matching the given criteria. Returns the entity data and throws on error.

```swift
let result = try client.Group().load(VMap([("id", .string("group_id"))]), nil)
```

#### `update(reqdata, ctrl) throws -> Value`

Update an existing entity. The data must include the entity `id`. Returns the updated entity data and throws on error.

```swift
let result = try client.Group().update(VMap([
    ("id", .string("group_id"))
]), nil)
```

### Common Methods

#### `data(newdata?) -> Value`

Get or set the entity data.

#### `matchv(newmatch?) -> Value`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Group` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## MfaCode

```swift
let mfaCode = client.MfaCode()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `content` | `String` | No | Custom content that must contain placeholder [%code%] |
| `fast` | `Value` | No |  |
| `from` | `String` | No | Sendername |
| `phone_number` | `String` | Yes |  |

### Operations

#### `create(reqdata, ctrl) throws -> Value`

Create a new entity with the given data. Returns the created entity data and throws on error.

```swift
let result = try client.MfaCode().create(VMap([
    ("phone_number", .string("example_phone_number"))  // String
]), nil)
```

### Common Methods

#### `data(newdata?) -> Value`

Get or set the entity data.

#### `matchv(newmatch?) -> Value`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `MfaCode` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## OptOut

```swift
let optOut = client.OptOut()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `date` | `String` | No |  |
| `id` | `String` | No |  |
| `links` | `[Value]` | No |  |
| `phoneNumber` | `Int` | No |  |

### Operations

#### `list(reqmatch, ctrl) throws -> Value`

List entities matching the given criteria. The match is optional — call `list(nil, nil)` to list all records. Returns a Value list and throws on error.

```swift
let results = try client.OptOut().list(nil, nil)
print(results)
```

#### `remove(reqmatch, ctrl) throws -> Value`

Remove the entity matching the given criteria. Throws on error.

```swift
let result = try client.OptOut().remove(VMap([("id", .string("id"))]), nil)
```

### Common Methods

#### `data(newdata?) -> Value`

Get or set the entity data.

#### `matchv(newmatch?) -> Value`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `OptOut` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## OptOutSetting

```swift
let optOutSetting = client.OptOutSetting()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `brand` | `String` | No |  |

### Operations

#### `load(reqmatch, ctrl) throws -> Value`

Load a single entity matching the given criteria. Returns the entity data and throws on error.

```swift
let result = try client.OptOutSetting().load(nil, nil)
```

#### `update(reqdata, ctrl) throws -> Value`

Update an existing entity. The data must include the entity `id`. Returns the updated entity data and throws on error.

```swift
let result = try client.OptOutSetting().update(VMap([
]), nil)
```

### Common Methods

#### `data(newdata?) -> Value`

Get or set the entity data.

#### `matchv(newmatch?) -> Value`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `OptOutSetting` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## Permission

```swift
let permission = client.Permission()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `group_id` | `String` | Yes | Object ID |
| `id` | `String` | No |  |
| `read` | `Bool` | Yes | Has read permission |
| `send` | `Bool` | Yes | Has send permission |
| `username` | `String` | Yes |  |
| `write` | `Bool` | Yes | Has write permission |

### Operations

#### `create(reqdata, ctrl) throws -> Value`

Create a new entity with the given data. Returns the created entity data and throws on error.

```swift
let result = try client.Permission().create(VMap([
    ("group_id", .string("example_group_id")),  // String
    ("read", .bool(true)),  // Bool
    ("send", .bool(true)),  // Bool
    ("username", .string("example_username")),  // String
    ("write", .bool(true))  // Bool
]), nil)
```

#### `load(reqmatch, ctrl) throws -> Value`

Load a single entity matching the given criteria. Returns the entity data and throws on error.

```swift
let result = try client.Permission().load(VMap([("id", .string("permission_id")), ("group_id", .string("group_id")), ("username", .string("username"))]), nil)
```

### Common Methods

#### `data(newdata?) -> Value`

Get or set the entity data.

#### `matchv(newmatch?) -> Value`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Permission` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## Ping

```swift
let ping = client.Ping()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `authorized` | `Bool` | Yes |  |
| `unavailable` | `[Value]` | Yes |  |

### Operations

#### `list(reqmatch, ctrl) throws -> Value`

List entities matching the given criteria. The match is optional — call `list(nil, nil)` to list all records. Returns a Value list and throws on error.

```swift
let results = try client.Ping().list(nil, nil)
print(results)
```

### Common Methods

#### `data(newdata?) -> Value`

Get or set the entity data.

#### `matchv(newmatch?) -> Value`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Ping` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## Profile

```swift
let profile = client.Profile()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `email` | `String` | Yes |  |
| `name` | `String` | Yes |  |
| `payment_type` | `String` | Yes |  |
| `phone_number` | `Int` | Yes |  |
| `points` | `Double` | No |  |
| `user_type` | `String` | Yes |  |
| `username` | `String` | Yes |  |

### Operations

#### `list(reqmatch, ctrl) throws -> Value`

List entities matching the given criteria. The match is optional — call `list(nil, nil)` to list all records. Returns a Value list and throws on error.

```swift
let results = try client.Profile().list(nil, nil)
print(results)
```

#### `load(reqmatch, ctrl) throws -> Value`

Load a single entity matching the given criteria. Returns the entity data and throws on error.

```swift
let result = try client.Profile().load(nil, nil)
```

### Common Methods

#### `data(newdata?) -> Value`

Get or set the entity data.

#### `matchv(newmatch?) -> Value`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Profile` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## Rcs

```swift
let rcs = client.Rcs()
```

### Operations

#### `list(reqmatch, ctrl) throws -> Value`

List entities matching the given criteria. The match is optional — call `list(nil, nil)` to list all records. Returns a Value list and throws on error.

```swift
let results = try client.Rcs().list(nil, nil)
print(results)
```

### Common Methods

#### `data(newdata?) -> Value`

Get or set the entity data.

#### `matchv(newmatch?) -> Value`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Rcs` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## Sendername

```swift
let sendername = client.Sendername()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `created_at` | `String` | No |  |
| `id` | `String` | No |  |
| `is_default` | `Bool` | No |  |
| `sender` | `String` | No | Sendername |
| `status` | `String` | No |  |

### Operations

#### `create(reqdata, ctrl) throws -> Value`

Create a new entity with the given data. Returns the created entity data and throws on error.

```swift
let result = try client.Sendername().create(VMap([
]), nil)
```

#### `list(reqmatch, ctrl) throws -> Value`

List entities matching the given criteria. The match is optional — call `list(nil, nil)` to list all records. Returns a Value list and throws on error.

```swift
let results = try client.Sendername().list(nil, nil)
print(results)
```

#### `load(reqmatch, ctrl) throws -> Value`

Load a single entity matching the given criteria. Returns the entity data and throws on error.

```swift
let result = try client.Sendername().load(VMap([("id", .string("sendername_id"))]), nil)
```

### Common Methods

#### `data(newdata?) -> Value`

Get or set the entity data.

#### `matchv(newmatch?) -> Value`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Sendername` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## SendernameStatement

```swift
let sendernameStatement = client.SendernameStatement()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `content` | `String` | No |  |
| `statements` | `[Value]` | No |  |
| `title` | `String` | No |  |

### Operations

#### `list(reqmatch, ctrl) throws -> Value`

List entities matching the given criteria. The match is optional — call `list(nil, nil)` to list all records. Returns a Value list and throws on error.

```swift
let results = try client.SendernameStatement().list(nil, nil)
print(results)
```

### Common Methods

#### `data(newdata?) -> Value`

Get or set the entity data.

#### `matchv(newmatch?) -> Value`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `SendernameStatement` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## SentRcsMessage

```swift
let sentRcsMessage = client.SentRcsMessage()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `content` | `VMap` | No | RCS message content in RCS JSON format. |
| `phone_number` | `String` | Yes | Recipient phone number (e.g. |
| `sender` | `Value` | Yes |  |
| `text` | `String` | No | Plain text message content. |

### Operations

#### `create(reqdata, ctrl) throws -> Value`

Create a new entity with the given data. Returns the created entity data and throws on error.

```swift
let result = try client.SentRcsMessage().create(VMap([
    ("phone_number", .string("example_phone_number")),  // String
    ("sender", .string("example_sender"))  // Value
]), nil)
```

### Common Methods

#### `data(newdata?) -> Value`

Get or set the entity data.

#### `matchv(newmatch?) -> Value`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `SentRcsMessage` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## ShipmentCountryVolume

```swift
let shipmentCountryVolume = client.ShipmentCountryVolume()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `country_code` | `String` | No |  |
| `country_limit` | `Int` | No |  |
| `country_name` | `String` | No |  |
| `usage` | `Int` | No |  |

### Operations

#### `list(reqmatch, ctrl) throws -> Value`

List entities matching the given criteria. The match is optional — call `list(nil, nil)` to list all records. Returns a Value list and throws on error.

```swift
let results = try client.ShipmentCountryVolume().list(nil, nil)
print(results)
```

### Common Methods

#### `data(newdata?) -> Value`

Get or set the entity data.

#### `matchv(newmatch?) -> Value`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `ShipmentCountryVolume` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## ShortUrl

```swift
let shortUrl = client.ShortUrl()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `description` | `String` | No |  |
| `expire` | `String` | No |  |
| `filename` | `String` | No |  |
| `hits` | `Int` | No |  |
| `hits_unique` | `Int` | No |  |
| `id` | `String` | No |  |
| `name` | `String` | No |  |
| `short_url` | `String` | No | WHATWG URL compliant |
| `type` | `String` | No |  |
| `url` | `String` | No | WHATWG URL compliant |

### Operations

#### `create(reqdata, ctrl) throws -> Value`

Create a new entity with the given data. Returns the created entity data and throws on error.

```swift
let result = try client.ShortUrl().create(VMap([
]), nil)
```

#### `list(reqmatch, ctrl) throws -> Value`

List entities matching the given criteria. The match is optional — call `list(nil, nil)` to list all records. Returns a Value list and throws on error.

```swift
let results = try client.ShortUrl().list(nil, nil)
print(results)
```

#### `load(reqmatch, ctrl) throws -> Value`

Load a single entity matching the given criteria. Returns the entity data and throws on error.

```swift
let result = try client.ShortUrl().load(VMap([("id", .string("short_url_id"))]), nil)
```

#### `remove(reqmatch, ctrl) throws -> Value`

Remove the entity matching the given criteria. Throws on error.

```swift
let result = try client.ShortUrl().remove(VMap([("id", .string("short_url_id"))]), nil)
```

#### `update(reqdata, ctrl) throws -> Value`

Update an existing entity. The data must include the entity `id`. Returns the updated entity data and throws on error.

```swift
let result = try client.ShortUrl().update(VMap([
    ("id", .string("short_url_id"))
]), nil)
```

### Common Methods

#### `data(newdata?) -> Value`

Get or set the entity data.

#### `matchv(newmatch?) -> Value`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `ShortUrl` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## Smsdo

```swift
let smsdo = client.Smsdo()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `allow_duplicates` | `Int` | No | When parameter allow_duplicates is set to "1" allows to send message to duplicated numbers in one request (useful i.e. |
| `check_idx` | `Value` | No | When parameter check_idx is set to „1” prevents from sending more than one message with the same idx in last 24h. |
| `date` | `Value` | No | Date in UNIX timestamp (&date=1287734110) or in ISO 8601 (&date=2012-05-10T08:40:27+00:00) when message will be sent (&date=1287734110). |
| `date_validate` | `Int` | No | When parameter date_validate is set to "1" checks if date if given in proper format. |
| `details` | `Value` | No | When details parameter is set to "1" more details in response will be displayed (message length and sms count). |
| `encoding` | `String` | No | This parameter describes the encoding of the message text. |
| `expiration_date` | `Value` | No | Message expiration date (in UNIX timestamp or in ISO 8601) is a date after which message won't be delivered if it wasn't delivered yet. |
| `fallback` | `[Value]` | No | Enable fallback in case sms sending fails |
| `fast` | `Int` | No | Setting this parameter to „1” will result in sending message with the highest priority which ensures the quickest possible time of delivery. |
| `flash` | `Int` | No | Sending a message in flash mode can be activated by setting this parameter to "1". |
| `format` | `String` | No | Parameter &format=json causes, that response is sending in JSON format. |
| `from` | `String` | No | Name of the sender. |
| `group` | `String` | No | Name of the group from the contacts database to which message should be sent to. |
| `idx` | `String` | No | Optional custom value sent with SMS and sent back in CALLBACK. |
| `max_parts` | `Int` | No | Defines maximum message parts allowed, maximum value allowed is 6. |
| `message` | `String` | No | The message text. |
| `normalize` | `Int` | No | When parameter normalize is set to „1” special chars in message will be replaced with their equivalents (ê-e, ñ-n, ý-y ...). |
| `notify_url` | `String` | No | Parameter allows to set CALLBACK URL for message from request. |
| `test` | `Value` | No | When parameter test is set to "1" message won't be sent but response will be displayed, there is no charge for such test messages. |
| `time_restriction` | `String` | No | Sets the behavior when you try to ship in hours / dates that do not match the settings in your account. |
| `to` | `String` | No | Recipients' mobile phone numbers (i.e. |

### Operations

#### `create(reqdata, ctrl) throws -> Value`

Create a new entity with the given data. Returns the created entity data and throws on error.

```swift
let result = try client.Smsdo().create(VMap([
]), nil)
```

### Common Methods

#### `data(newdata?) -> Value`

Get or set the entity data.

#### `matchv(newmatch?) -> Value`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Smsdo` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## Smssendername

```swift
let smssendername = client.Smssendername()
```

### Operations

#### `create(reqdata, ctrl) throws -> Value`

Create a new entity with the given data. Returns the created entity data and throws on error.

```swift
let result = try client.Smssendername().create(VMap([
    ("sendername_id", .string("example_sendername_id"))  // String
]), nil)
```

#### `remove(reqmatch, ctrl) throws -> Value`

Remove the entity matching the given criteria. Throws on error.

```swift
let result = try client.Smssendername().remove(VMap([("sender", .string("sender"))]), nil)
```

### Common Methods

#### `data(newdata?) -> Value`

Get or set the entity data.

#### `matchv(newmatch?) -> Value`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Smssendername` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## Smstemplate

```swift
let smstemplate = client.Smstemplate()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | `String` | No |  |

### Operations

#### `remove(reqmatch, ctrl) throws -> Value`

Remove the entity matching the given criteria. Throws on error.

```swift
let result = try client.Smstemplate().remove(VMap([("id", .string("id"))]), nil)
```

### Common Methods

#### `data(newdata?) -> Value`

Get or set the entity data.

#### `matchv(newmatch?) -> Value`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Smstemplate` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## Subuser

```swift
let subuser = client.Subuser()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `active` | `Bool` | No |  |
| `credentials` | `VMap` | Yes |  |
| `description` | `String` | No |  |
| `id` | `String` | No | Object ID |
| `points` | `VMap` | No |  |
| `username` | `String` | No |  |

### Field Usage by Operation

| Field | load | list | create | update | remove |
| --- | --- | --- | --- | --- | --- |
| `active` | - | - | - | - | - |
| `credentials` | - | - | - | Yes | - |
| `description` | - | - | - | - | - |
| `id` | - | - | - | - | - |
| `points` | - | - | - | - | - |
| `username` | - | - | - | - | - |

### Operations

#### `create(reqdata, ctrl) throws -> Value`

Create a new entity with the given data. Returns the created entity data and throws on error.

```swift
let result = try client.Subuser().create(VMap([
    ("credentials", .map(VMap()))  // VMap
]), nil)
```

#### `list(reqmatch, ctrl) throws -> Value`

List entities matching the given criteria. The match is optional — call `list(nil, nil)` to list all records. Returns a Value list and throws on error.

```swift
let results = try client.Subuser().list(nil, nil)
print(results)
```

#### `load(reqmatch, ctrl) throws -> Value`

Load a single entity matching the given criteria. Returns the entity data and throws on error.

```swift
let result = try client.Subuser().load(VMap([("id", .string("subuser_id"))]), nil)
```

#### `remove(reqmatch, ctrl) throws -> Value`

Remove the entity matching the given criteria. Throws on error.

```swift
let result = try client.Subuser().remove(VMap([("id", .string("subuser_id"))]), nil)
```

#### `update(reqdata, ctrl) throws -> Value`

Update an existing entity. The data must include the entity `id`. Returns the updated entity data and throws on error.

```swift
let result = try client.Subuser().update(VMap([
    ("id", .string("subuser_id"))
]), nil)
```

### Common Methods

#### `data(newdata?) -> Value`

Get or set the entity data.

#### `matchv(newmatch?) -> Value`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Subuser` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## Template

```swift
let template = client.Template()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | `String` | No |  |
| `name` | `String` | No |  |
| `normalize` | `Bool` | No |  |
| `template` | `String` | No |  |

### Operations

#### `create(reqdata, ctrl) throws -> Value`

Create a new entity with the given data. Returns the created entity data and throws on error.

```swift
let result = try client.Template().create(VMap([
]), nil)
```

#### `list(reqmatch, ctrl) throws -> Value`

List entities matching the given criteria. The match is optional — call `list(nil, nil)` to list all records. Returns a Value list and throws on error.

```swift
let results = try client.Template().list(nil, nil)
print(results)
```

#### `load(reqmatch, ctrl) throws -> Value`

Load a single entity matching the given criteria. Returns the entity data and throws on error.

```swift
let result = try client.Template().load(VMap([("id", .string("template_id"))]), nil)
```

#### `update(reqdata, ctrl) throws -> Value`

Update an existing entity. The data must include the entity `id`. Returns the updated entity data and throws on error.

```swift
let result = try client.Template().update(VMap([
    ("id", .string("template_id"))
]), nil)
```

### Common Methods

#### `data(newdata?) -> Value`

Get or set the entity data.

#### `matchv(newmatch?) -> Value`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Template` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## UserRcsSenderCollection

```swift
let userRcsSenderCollection = client.UserRcsSenderCollection()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `deliveredAt` | `String` | No |  |
| `expiredAt` | `String` | No |  |
| `id` | `String` | No | Object ID |
| `interface` | `String` | No | Interface through which the message was sent (www, api, ...). |
| `messageType` | `String` | No | RCS message type (basic, single, ...). |
| `readAt` | `String` | No |  |
| `recipient` | `String` | No | Recipient phone number (without +). |
| `sender` | `String` | No | Sender name |
| `senderId` | `String` | No | Sender id |
| `sentAt` | `String` | No |  |

### Operations

#### `list(reqmatch, ctrl) throws -> Value`

List entities matching the given criteria. The match is optional — call `list(nil, nil)` to list all records. Returns a Value list and throws on error.

```swift
let results = try client.UserRcsSenderCollection().list(nil, nil)
print(results)
```

### Common Methods

#### `data(newdata?) -> Value`

Get or set the entity data.

#### `matchv(newmatch?) -> Value`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `UserRcsSenderCollection` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `audit` | 0.0.1 | Audit trail |
| `cache` | 0.0.1 | Response cache |
| `clienttrack` | 0.0.1 | Client tracking |
| `cost` | 0.0.1 | Cost tracking |
| `debug` | 0.0.1 | Debug capture |
| `idempotency` | 0.0.1 | Idempotency |
| `log` | 0.0.1 | Logging |
| `metrics` | 0.0.1 | Metrics |
| `netsim` | 0.0.1 | Network simulation |
| `paging` | 0.0.1 | Paging |
| `proxy` | 0.0.1 | Proxy |
| `ratelimit` | 0.0.1 | Rate limiting |
| `rbac` | 0.0.1 | Access control |
| `retry` | 0.0.1 | Retry |
| `secrets` | 0.1.0 | Secrets |
| `streaming` | 0.0.1 | Streaming |
| `telemetry` | 0.0.1 | Telemetry |
| `test` | 0.0.1 | Test transport |
| `timeout` | 0.0.1 | Timeout |
| `validate` | 0.0.1 | Validation |


Features are activated via the `feature` option:

```swift
let feature = VMap()
feature.entries["audit"] = .map([("active", .bool(true))])
feature.entries["cache"] = .map([("active", .bool(true))])
feature.entries["clienttrack"] = .map([("active", .bool(true))])
feature.entries["cost"] = .map([("active", .bool(true))])
feature.entries["debug"] = .map([("active", .bool(true))])
feature.entries["idempotency"] = .map([("active", .bool(true))])
feature.entries["log"] = .map([("active", .bool(true))])
feature.entries["metrics"] = .map([("active", .bool(true))])
feature.entries["netsim"] = .map([("active", .bool(true))])
feature.entries["paging"] = .map([("active", .bool(true))])
feature.entries["proxy"] = .map([("active", .bool(true))])
feature.entries["ratelimit"] = .map([("active", .bool(true))])
feature.entries["rbac"] = .map([("active", .bool(true))])
feature.entries["retry"] = .map([("active", .bool(true))])
feature.entries["secrets"] = .map([("active", .bool(true))])
feature.entries["streaming"] = .map([("active", .bool(true))])
feature.entries["telemetry"] = .map([("active", .bool(true))])
feature.entries["test"] = .map([("active", .bool(true))])
feature.entries["timeout"] = .map([("active", .bool(true))])
feature.entries["validate"] = .map([("active", .bool(true))])
let options = VMap()
options.entries["feature"] = .map(feature)
let client = SmsapiSDK(options)
```


### Configuring features

Each feature is inactive until switched on, and an SDK with no feature
configured does no feature work at all. Every option below keeps its default
unless you name it.

The array form of \`feature\` is significant: several features wrap the
transport, and the order you list them in is the order they nest.

#### Ordering

`cache`, `cost`, `netsim`, `proxy`, `ratelimit`, `retry`, `secrets`, `timeout` wrap the transport. Each
wraps whatever is already installed, so **activation order is nesting order**:
a feature activated later sits OUTSIDE one activated earlier, and sees the call
first.

That decides behaviour, not just sequence. \`cost\` activated before \`cache\`
sits inside it, so a response served from the cache never reaches \`cost\` and is
correctly charged nothing; reverse them and every cache hit is billed for money
that was never spent.

`audit`, `clienttrack`, `debug`, `idempotency`, `log`, `metrics`, `paging`, `rbac`, `streaming`, `telemetry`, `test`, `validate` attach to pipeline hooks
rather than the transport, so their order does not affect what they observe.

#### `audit`

Audit trail.

**Configuration**

| Option | Default |
|---|---|
| `active` | `false` |
| `actor` | `'anonymous'` |
| `max` | `1000` |

| Option | Type |
|---|---|
| `now` | function |
| `sink` | function |

These take no default: the feature behaves one way when you supply them and
another when you do not.

**Usage**

Set `feature.audit.active` to true in the client options, and override any option above in the same entry. Every option keeps
its default unless you name it.

**Considerations**

- Attaches to pipeline hooks, not the transport, so activation order does
  not change what it observes.
- Inactive by default: leaving it out costs nothing at runtime.

#### `cache`

Response cache.

**Configuration**

| Option | Default |
|---|---|
| `active` | `false` |
| `max` | `256` |
| `methods` | `['GET']` |
| `ttl` | `5000` |

| Option | Type |
|---|---|
| `now` | function |

These take no default: the feature behaves one way when you supply them and
another when you do not.

**Usage**

Set `feature.cache.active` to true in the client options, and override any option above in the same entry. Every option keeps
its default unless you name it.

**Considerations**

- Wraps the transport: its place in the activation order decides what it
  sees. See [Ordering](#ordering) above.
- Inactive by default: leaving it out costs nothing at runtime.

#### `clienttrack`

Client tracking.

**Configuration**

| Option | Default |
|---|---|
| `active` | `false` |
| `clientVersion` | `'0.0.1'` |

| Option | Type |
|---|---|
| `clientName` | string |
| `headers` | map |
| `idgen` | function |
| `sessionId` | string |

These take no default: the feature behaves one way when you supply them and
another when you do not.

**Usage**

Set `feature.clienttrack.active` to true in the client options, and override any option above in the same entry. Every option keeps
its default unless you name it.

**Considerations**

- Attaches to pipeline hooks, not the transport, so activation order does
  not change what it observes.
- Inactive by default: leaving it out costs nothing at runtime.

#### `cost`

Cost tracking.

**Configuration**

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

| Option | Type |
|---|---|
| `actor` | string |
| `sink` | function |

These take no default: the feature behaves one way when you supply them and
another when you do not.

**Usage**

Set `feature.cost.active` to true in the client options, and override any option above in the same entry. Every option keeps
its default unless you name it.

**Considerations**

- Wraps the transport: its place in the activation order decides what it
  sees. See [Ordering](#ordering) above.
- Inactive by default: leaving it out costs nothing at runtime.

#### `debug`

Debug capture.

**Configuration**

| Option | Default |
|---|---|
| `active` | `false` |
| `max` | `100` |
| `redact` | `['authorization', 'cookie', 'set-cookie', 'api-key', 'apikey', 'x-api-key', 'idempotency-key']` |

| Option | Type |
|---|---|
| `now` | function |
| `onEntry` | function |

These take no default: the feature behaves one way when you supply them and
another when you do not.

**Usage**

Set `feature.debug.active` to true in the client options, and override any option above in the same entry. Every option keeps
its default unless you name it.

**Considerations**

- Attaches to pipeline hooks, not the transport, so activation order does
  not change what it observes.
- Inactive by default: leaving it out costs nothing at runtime.

#### `idempotency`

Idempotency.

**Configuration**

| Option | Default |
|---|---|
| `active` | `false` |
| `header` | `'Idempotency-Key'` |
| `methods` | `['POST', 'PUT', 'PATCH', 'DELETE']` |
| `ops` | `['create', 'update', 'remove']` |

| Option | Type |
|---|---|
| `keygen` | function |

These take no default: the feature behaves one way when you supply them and
another when you do not.

**Usage**

Set `feature.idempotency.active` to true in the client options, and override any option above in the same entry. Every option keeps
its default unless you name it.

**Considerations**

- Attaches to pipeline hooks, not the transport, so activation order does
  not change what it observes.
- Inactive by default: leaving it out costs nothing at runtime.

#### `log`

Logging.

**Configuration**

| Option | Default |
|---|---|
| `active` | `true` |

| Option | Type |
|---|---|
| `level` | string |
| `logger` | any |

These take no default: the feature behaves one way when you supply them and
another when you do not.

**Usage**

Set `feature.log.active` to true in the client options, and override any option above in the same entry. Every option keeps
its default unless you name it.

**Considerations**

- Attaches to pipeline hooks, not the transport, so activation order does
  not change what it observes.
- Inactive by default: leaving it out costs nothing at runtime.

#### `metrics`

Metrics.

**Configuration**

| Option | Default |
|---|---|
| `active` | `false` |

| Option | Type |
|---|---|
| `now` | function |

These take no default: the feature behaves one way when you supply them and
another when you do not.

**Usage**

Set `feature.metrics.active` to true in the client options, and override any option above in the same entry. Every option keeps
its default unless you name it.

**Considerations**

- Attaches to pipeline hooks, not the transport, so activation order does
  not change what it observes.
- Inactive by default: leaving it out costs nothing at runtime.

#### `netsim`

Network simulation.

**Configuration**

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

| Option | Type |
|---|---|
| `sleep` | function |

These take no default: the feature behaves one way when you supply them and
another when you do not.

**Usage**

Set `feature.netsim.active` to true in the client options, and override any option above in the same entry. Every option keeps
its default unless you name it.

**Considerations**

- Wraps the transport: its place in the activation order decides what it
  sees. See [Ordering](#ordering) above.
- Inactive by default: leaving it out costs nothing at runtime.

#### `paging`

Paging.

**Configuration**

| Option | Default |
|---|---|
| `active` | `false` |
| `afterVar` | `'after'` |
| `cursorParam` | `'cursor'` |
| `firstVar` | `'first'` |
| `limitParam` | `'limit'` |
| `pageParam` | `'page'` |
| `startPage` | `1` |

| Option | Type |
|---|---|
| `limit` | number |
| `ops` | list |

These take no default: the feature behaves one way when you supply them and
another when you do not.

**Usage**

Set `feature.paging.active` to true in the client options, and override any option above in the same entry. Every option keeps
its default unless you name it.

**Considerations**

- Attaches to pipeline hooks, not the transport, so activation order does
  not change what it observes.
- Inactive by default: leaving it out costs nothing at runtime.

#### `proxy`

Proxy.

**Configuration**

| Option | Default |
|---|---|
| `active` | `false` |
| `fromEnv` | `false` |
| `noProxy` | `[]` |
| `url` | `''` |

| Option | Type |
|---|---|
| `agent` | function |

These take no default: the feature behaves one way when you supply them and
another when you do not.

**Usage**

Set `feature.proxy.active` to true in the client options, and override any option above in the same entry. Every option keeps
its default unless you name it.

**Considerations**

- Wraps the transport: its place in the activation order decides what it
  sees. See [Ordering](#ordering) above.
- Inactive by default: leaving it out costs nothing at runtime.

#### `ratelimit`

Rate limiting.

**Configuration**

| Option | Default |
|---|---|
| `active` | `false` |
| `burst` | `5` |
| `rate` | `5` |

| Option | Type |
|---|---|
| `now` | function |
| `sleep` | function |

These take no default: the feature behaves one way when you supply them and
another when you do not.

**Usage**

Set `feature.ratelimit.active` to true in the client options, and override any option above in the same entry. Every option keeps
its default unless you name it.

**Considerations**

- Wraps the transport: its place in the activation order decides what it
  sees. See [Ordering](#ordering) above.
- Inactive by default: leaving it out costs nothing at runtime.

#### `rbac`

Access control.

**Configuration**

| Option | Default |
|---|---|
| `active` | `false` |
| `deny` | `false` |
| `permissions` | `[]` |
| `rules` | `{}` |

**Usage**

Set `feature.rbac.active` to true in the client options, and override any option above in the same entry. Every option keeps
its default unless you name it.

**Considerations**

- Attaches to pipeline hooks, not the transport, so activation order does
  not change what it observes.
- Inactive by default: leaving it out costs nothing at runtime.

#### `retry`

Retry.

**Configuration**

| Option | Default |
|---|---|
| `active` | `false` |
| `factor` | `2` |
| `maxDelay` | `2000` |
| `minDelay` | `50` |
| `retries` | `2` |
| `statuses` | `[408, 425, 429, 500, 502, 503, 504]` |

| Option | Type |
|---|---|
| `jitter` | boolean |
| `sleep` | function |

These take no default: the feature behaves one way when you supply them and
another when you do not.

**Usage**

Set `feature.retry.active` to true in the client options, and override any option above in the same entry. Every option keeps
its default unless you name it.

**Considerations**

- Wraps the transport: its place in the activation order decides what it
  sees. See [Ordering](#ordering) above.
- Inactive by default: leaving it out costs nothing at runtime.

#### `secrets`

Secrets.

**Configuration**

| Option | Default |
|---|---|
| `active` | `false` |
| `cache` | `true` |
| `exchange` | `{active: false, method: 'POST', path: 'auth/token', refresh: '', request: 'refresh_token', response: 'access_token', retries: 1, statuses: [401]}` |
| `name` | `'apikey'` |
| `providers` | `[]` |

**Usage**

Set `feature.secrets.active` to true in the client options, and override any option above in the same entry. Every option keeps
its default unless you name it.

**Considerations**

- Wraps the transport: its place in the activation order decides what it
  sees. See [Ordering](#ordering) above.
- Inactive by default: leaving it out costs nothing at runtime.

#### `streaming`

Streaming.

**Configuration**

| Option | Default |
|---|---|
| `active` | `false` |
| `chunkDelay` | `0` |
| `chunkSize` | `0` |

| Option | Type |
|---|---|
| `ops` | list |
| `sleep` | function |

These take no default: the feature behaves one way when you supply them and
another when you do not.

**Usage**

Set `feature.streaming.active` to true in the client options, and override any option above in the same entry. Every option keeps
its default unless you name it.

**Considerations**

- Attaches to pipeline hooks, not the transport, so activation order does
  not change what it observes.
- Inactive by default: leaving it out costs nothing at runtime.

#### `telemetry`

Telemetry.

**Configuration**

| Option | Default |
|---|---|
| `active` | `false` |

| Option | Type |
|---|---|
| `exporter` | function |
| `headers` | map |
| `idgen` | function |
| `now` | function |

These take no default: the feature behaves one way when you supply them and
another when you do not.

**Usage**

Set `feature.telemetry.active` to true in the client options, and override any option above in the same entry. Every option keeps
its default unless you name it.

**Considerations**

- Attaches to pipeline hooks, not the transport, so activation order does
  not change what it observes.
- Inactive by default: leaving it out costs nothing at runtime.

#### `test`

Test transport.

**Configuration**

| Option | Default |
|---|---|
| `active` | `false` |

| Option | Type |
|---|---|
| `entity` | map |
| `net` | map |

These take no default: the feature behaves one way when you supply them and
another when you do not.

**Usage**

Set `feature.test.active` to true in the client options, and override any option above in the same entry. Every option keeps
its default unless you name it.

**Considerations**

- Attaches to pipeline hooks, not the transport, so activation order does
  not change what it observes.
- Installs the BASE transport that the wrapping features wrap, so it must be
  activated before them.
- Inactive by default: leaving it out costs nothing at runtime.

#### `timeout`

Timeout.

**Configuration**

| Option | Default |
|---|---|
| `active` | `false` |
| `ms` | `30000` |

| Option | Type |
|---|---|
| `clearTimer` | function |
| `setTimer` | function |

These take no default: the feature behaves one way when you supply them and
another when you do not.

**Usage**

Set `feature.timeout.active` to true in the client options, and override any option above in the same entry. Every option keeps
its default unless you name it.

**Considerations**

- Wraps the transport: its place in the activation order decides what it
  sees. See [Ordering](#ordering) above.
- Inactive by default: leaving it out costs nothing at runtime.

#### `validate`

Validation.

**Configuration**

| Option | Default |
|---|---|
| `active` | `false` |
| `mode` | `'throw'` |
| `request` | `true` |
| `response` | `false` |
| `strict` | `false` |

| Option | Type |
|---|---|
| `onInvalid` | function |

These take no default: the feature behaves one way when you supply them and
another when you do not.

**Usage**

Set `feature.validate.active` to true in the client options, and override any option above in the same entry. Every option keeps
its default unless you name it.

**Considerations**

- Attaches to pipeline hooks, not the transport, so activation order does
  not change what it observes.
- Inactive by default: leaving it out costs nothing at runtime.

