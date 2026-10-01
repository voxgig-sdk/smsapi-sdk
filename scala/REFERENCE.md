# Smsapi Scala SDK Reference

Complete API reference for the Smsapi Scala SDK.


## SmsapiSDK

### Constructor

```scala
val client = new SmsapiSDK(options)
```

Create a new SDK client instance. `options` is a `java.util.Map[String, Object]`.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `options` | `Map` | SDK configuration options. |
| `options["apikey"]` | `String` | API key for authentication. |
| `options["base"]` | `String` | Base URL for API requests. |
| `options["prefix"]` | `String` | URL prefix appended after base. |
| `options["suffix"]` | `String` | URL suffix appended after path. |
| `options["headers"]` | `Map` | Custom headers for all requests. |
| `options["feature"]` | `Map` | Feature configuration. |
| `options["system"]` | `Map` | System overrides (e.g. custom fetch). |


### Static Methods

#### `SmsapiSDK.testSDK(testopts, sdkopts)`

Create a test client with mock features active. Both arguments may be `null`.

```scala
val client = SmsapiSDK.testSDK(null, null)
```


### Instance Methods

#### `available(entopts)`

Create a new `Available` entity instance (returns `SdkEntity`). Pass
`null` for no initial options.

#### `blacklist(entopts)`

Create a new `Blacklist` entity instance (returns `SdkEntity`). Pass
`null` for no initial options.

#### `callback(entopts)`

Create a new `Callback` entity instance (returns `SdkEntity`). Pass
`null` for no initial options.

#### `contact(entopts)`

Create a new `Contact` entity instance (returns `SdkEntity`). Pass
`null` for no initial options.

#### `contactsField(entopts)`

Create a new `ContactsField` entity instance (returns `SdkEntity`). Pass
`null` for no initial options.

#### `contactsFieldOption(entopts)`

Create a new `ContactsFieldOption` entity instance (returns `SdkEntity`). Pass
`null` for no initial options.

#### `contactsgroup(entopts)`

Create a new `Contactsgroup` entity instance (returns `SdkEntity`). Pass
`null` for no initial options.

#### `contactstrash(entopts)`

Create a new `Contactstrash` entity instance (returns `SdkEntity`). Pass
`null` for no initial options.

#### `fieldAvailable(entopts)`

Create a new `FieldAvailable` entity instance (returns `SdkEntity`). Pass
`null` for no initial options.

#### `group(entopts)`

Create a new `Group` entity instance (returns `SdkEntity`). Pass
`null` for no initial options.

#### `mfaCode(entopts)`

Create a new `MfaCode` entity instance (returns `SdkEntity`). Pass
`null` for no initial options.

#### `optOut(entopts)`

Create a new `OptOut` entity instance (returns `SdkEntity`). Pass
`null` for no initial options.

#### `optOutSetting(entopts)`

Create a new `OptOutSetting` entity instance (returns `SdkEntity`). Pass
`null` for no initial options.

#### `permission(entopts)`

Create a new `Permission` entity instance (returns `SdkEntity`). Pass
`null` for no initial options.

#### `ping(entopts)`

Create a new `Ping` entity instance (returns `SdkEntity`). Pass
`null` for no initial options.

#### `profile(entopts)`

Create a new `Profile` entity instance (returns `SdkEntity`). Pass
`null` for no initial options.

#### `rcs(entopts)`

Create a new `Rcs` entity instance (returns `SdkEntity`). Pass
`null` for no initial options.

#### `sendername(entopts)`

Create a new `Sendername` entity instance (returns `SdkEntity`). Pass
`null` for no initial options.

#### `sendernameStatement(entopts)`

Create a new `SendernameStatement` entity instance (returns `SdkEntity`). Pass
`null` for no initial options.

#### `sentRcsMessage(entopts)`

Create a new `SentRcsMessage` entity instance (returns `SdkEntity`). Pass
`null` for no initial options.

#### `shipmentCountryVolume(entopts)`

Create a new `ShipmentCountryVolume` entity instance (returns `SdkEntity`). Pass
`null` for no initial options.

#### `shortUrl(entopts)`

Create a new `ShortUrl` entity instance (returns `SdkEntity`). Pass
`null` for no initial options.

#### `smsdo(entopts)`

Create a new `Smsdo` entity instance (returns `SdkEntity`). Pass
`null` for no initial options.

#### `smssendername(entopts)`

Create a new `Smssendername` entity instance (returns `SdkEntity`). Pass
`null` for no initial options.

#### `smstemplate(entopts)`

Create a new `Smstemplate` entity instance (returns `SdkEntity`). Pass
`null` for no initial options.

#### `subuser(entopts)`

Create a new `Subuser` entity instance (returns `SdkEntity`). Pass
`null` for no initial options.

#### `template(entopts)`

Create a new `Template` entity instance (returns `SdkEntity`). Pass
`null` for no initial options.

#### `userRcsSenderCollection(entopts)`

Create a new `UserRcsSenderCollection` entity instance (returns `SdkEntity`). Pass
`null` for no initial options.

#### `optionsMap() -> Map`

Return a deep copy of the current SDK options.

#### `getUtility() -> Utility`

Return a copy of the SDK utility object.

#### `direct(fetchargs) -> Map`

Make a direct HTTP request to any API endpoint. Returns a result
`java.util.Map[String, Object]` with `ok`, `status`, `headers`, and
`data` (or `err` on failure). This escape hatch never raises — branch on
`result.get("ok")`.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `fetchargs["path"]` | `String` | URL path with optional `{param}` placeholders. |
| `fetchargs["method"]` | `String` | HTTP method (default: `"GET"`). |
| `fetchargs["params"]` | `Map` | Path parameter values. |
| `fetchargs["query"]` | `Map` | Query string parameters. |
| `fetchargs["headers"]` | `Map` | Request headers (merged with defaults). |
| `fetchargs["body"]` | `Object` | Request body (maps are JSON-serialized). |

**Returns:** `java.util.Map[String, Object]`

#### `prepare(fetchargs) -> Map`

Prepare a fetch definition without sending. Returns the `fetchdef` and raises on error.


---

## Available

```scala
val available = client.available(null)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `name` | `String` | No |  |
| `normalize` | `java.lang.Boolean` | No |  |
| `template` | `String` | No |  |

### Operations

#### `list(reqmatch, ctrl) -> Object`

List entities matching the given criteria. The match is optional — call `list(null, null)` to list all records. Returns an aggregate list and raises on error.

```scala
val results = client.available(null).list(null, null)
println(results)
```

### Common Methods

#### `data(newdata*) -> Object`

Get or set the entity data.

#### `matchArgs(newmatch*) -> Object`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Available` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## Blacklist

```scala
val blacklist = client.blacklist(null)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | `String` | No |  |

### Operations

#### `create(reqdata, ctrl) -> Object`

Create a new entity with the given data. Returns the created entity data and raises on error.

```scala
val result = client.blacklist(null).create(java.util.Map.of(
), null)
```

#### `load(reqmatch, ctrl) -> Object`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```scala
val result = client.blacklist(null).load(null, null)
```

#### `remove(reqmatch, ctrl) -> Object`

Remove the entity matching the given criteria. Raises on error.

```scala
val result = client.blacklist(null).remove(java.util.Map.of("id", "id"), null)
```

### Common Methods

#### `data(newdata*) -> Object`

Get or set the entity data.

#### `matchArgs(newmatch*) -> Object`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Blacklist` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## Callback

```scala
val callback = client.callback(null)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `active` | `java.lang.Boolean` | No |  |
| `api_version` | `java.lang.Long` | No | Version of the callback output format. |
| `id` | `String` | No | Object ID |
| `invalid` | `java.lang.Boolean` | No |  |
| `receiver` | `java.util.Map[String, Object]` | No |  |
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

#### `create(reqdata, ctrl) -> Object`

Create a new entity with the given data. Returns the created entity data and raises on error.

```scala
val result = client.callback(null).create(java.util.Map.of(
), null)
```

#### `list(reqmatch, ctrl) -> Object`

List entities matching the given criteria. The match is optional — call `list(null, null)` to list all records. Returns an aggregate list and raises on error.

```scala
val results = client.callback(null).list(null, null)
println(results)
```

#### `load(reqmatch, ctrl) -> Object`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```scala
val result = client.callback(null).load(java.util.Map.of("id", "callback_id"), null)
```

#### `remove(reqmatch, ctrl) -> Object`

Remove the entity matching the given criteria. Raises on error.

```scala
val result = client.callback(null).remove(java.util.Map.of("id", "callback_id"), null)
```

#### `update(reqdata, ctrl) -> Object`

Update an existing entity. The data must include the entity `id`. Returns the updated entity data and raises on error.

```scala
val result = client.callback(null).update(java.util.Map.of(
    "id", "callback_id"
), null)
```

### Common Methods

#### `data(newdata*) -> Object`

Get or set the entity data.

#### `matchArgs(newmatch*) -> Object`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Callback` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## Contact

```scala
val contact = client.contact(null)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `birthday_date` | `String` | No |  |
| `city` | `String` | No |  |
| `collection` | `java.util.List[Object]` | Yes |  |
| `contact_expire_after` | `java.lang.Long` | Yes | Contact expire after days |
| `contacts_count` | `java.lang.Long` | Yes |  |
| `country` | `String` | No |  |
| `created_by` | `String` | Yes |  |
| `date_created` | `String` | Yes |  |
| `date_updated` | `String` | Yes |  |
| `description` | `String` | No |  |
| `email` | `String` | No |  |
| `first_name` | `String` | No |  |
| `gender` | `String` | Yes |  |
| `group_id` | `String` | No | Object ID |
| `groups` | `java.util.List[Object]` | Yes |  |
| `id` | `String` | Yes | Object ID |
| `idx` | `String` | No | User provided resource id |
| `last_name` | `String` | No |  |
| `name` | `String` | Yes | Group name |
| `permissions` | `java.util.List[Object]` | No |  |
| `phone_number` | `String` | No |  |
| `read` | `java.lang.Boolean` | No | Has read permission |
| `send` | `java.lang.Boolean` | No | Has send permission |
| `size` | `java.lang.Long` | Yes |  |
| `source` | `String` | No |  |
| `type` | `String` | No |  |
| `username` | `String` | No |  |
| `value` | `String` | No |  |
| `write` | `java.lang.Boolean` | No | Has write permission |

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

#### `create(reqdata, ctrl) -> Object`

Create a new entity with the given data. Returns the created entity data and raises on error.

```scala
val result = client.contact(null).create(java.util.Map.of(
    "collection", java.util.List.of(),  // java.util.List[Object]
    "contact_expire_after", 1L,  // java.lang.Long
    "contacts_count", 1L,  // java.lang.Long
    "created_by", "example_created_by",  // String
    "date_created", "example_date_created",  // String
    "date_updated", "example_date_updated",  // String
    "gender", "example_gender",  // String
    "groups", java.util.List.of(),  // java.util.List[Object]
    "id", "example_id",  // String
    "name", "example_name",  // String
    "size", 1L  // java.lang.Long
), null)
```

#### `list(reqmatch, ctrl) -> Object`

List entities matching the given criteria. The match is optional — call `list(null, null)` to list all records. Returns an aggregate list and raises on error.

```scala
val results = client.contact(null).list(null, null)
println(results)
```

#### `load(reqmatch, ctrl) -> Object`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```scala
val result = client.contact(null).load(java.util.Map.of("id", "contact_id"), null)
```

#### `remove(reqmatch, ctrl) -> Object`

Remove the entity matching the given criteria. Raises on error.

```scala
val result = client.contact(null).remove(java.util.Map.of("id", "contact_id"), null)
```

#### `update(reqdata, ctrl) -> Object`

Update an existing entity. The data must include the entity `id`. Returns the updated entity data and raises on error.

```scala
val result = client.contact(null).update(java.util.Map.of(
    "id", "contact_id"
), null)
```

### Common Methods

#### `data(newdata*) -> Object`

Get or set the entity data.

#### `matchArgs(newmatch*) -> Object`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Contact` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## ContactsField

```scala
val contactsField = client.contactsField(null)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `birthday_date` | `String` | No |  |
| `city` | `String` | No |  |
| `contact_expire_after` | `java.lang.Long` | Yes | Contact expire after days |
| `contacts_count` | `java.lang.Long` | No |  |
| `country` | `String` | No |  |
| `created_by` | `String` | Yes |  |
| `date_created` | `String` | Yes |  |
| `date_updated` | `String` | Yes |  |
| `description` | `String` | No |  |
| `email` | `String` | No |  |
| `first_name` | `String` | No |  |
| `gender` | `String` | Yes |  |
| `group_id` | `String` | No | Object ID |
| `groups` | `java.util.List[Object]` | Yes |  |
| `id` | `String` | No | Object ID |
| `idx` | `String` | No | User provided resource id |
| `last_name` | `String` | No |  |
| `name` | `String` | No | Group name |
| `permissions` | `java.util.List[Object]` | No |  |
| `phone_number` | `String` | No |  |
| `read` | `java.lang.Boolean` | No | Has read permission |
| `send` | `java.lang.Boolean` | No | Has send permission |
| `source` | `String` | No |  |
| `type` | `String` | No |  |
| `username` | `String` | No |  |
| `value` | `String` | No |  |
| `write` | `java.lang.Boolean` | No | Has write permission |

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

#### `create(reqdata, ctrl) -> Object`

Create a new entity with the given data. Returns the created entity data and raises on error.

```scala
val result = client.contactsField(null).create(java.util.Map.of(
    "contact_expire_after", 1L,  // java.lang.Long
    "created_by", "example_created_by",  // String
    "date_created", "example_date_created",  // String
    "date_updated", "example_date_updated",  // String
    "gender", "example_gender",  // String
    "groups", java.util.List.of()  // java.util.List[Object]
), null)
```

#### `list(reqmatch, ctrl) -> Object`

List entities matching the given criteria. The match is optional — call `list(null, null)` to list all records. Returns an aggregate list and raises on error.

```scala
val results = client.contactsField(null).list(null, null)
println(results)
```

#### `remove(reqmatch, ctrl) -> Object`

Remove the entity matching the given criteria. Raises on error.

```scala
val result = client.contactsField(null).remove(java.util.Map.of("id", "id"), null)
```

#### `update(reqdata, ctrl) -> Object`

Update an existing entity. The data must include the entity `id`. Returns the updated entity data and raises on error.

```scala
val result = client.contactsField(null).update(java.util.Map.of(
    "id", "id"
), null)
```

### Common Methods

#### `data(newdata*) -> Object`

Get or set the entity data.

#### `matchArgs(newmatch*) -> Object`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `ContactsField` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## ContactsFieldOption

```scala
val contactsFieldOption = client.contactsFieldOption(null)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `birthday_date` | `String` | No |  |
| `city` | `String` | No |  |
| `contact_expire_after` | `java.lang.Long` | Yes | Contact expire after days |
| `contacts_count` | `java.lang.Long` | No |  |
| `country` | `String` | No |  |
| `created_by` | `String` | Yes |  |
| `date_created` | `String` | Yes |  |
| `date_updated` | `String` | Yes |  |
| `description` | `String` | No |  |
| `email` | `String` | No |  |
| `first_name` | `String` | No |  |
| `gender` | `String` | Yes |  |
| `group_id` | `String` | No | Object ID |
| `groups` | `java.util.List[Object]` | Yes |  |
| `id` | `String` | Yes | Object ID |
| `idx` | `String` | No | User provided resource id |
| `last_name` | `String` | No |  |
| `name` | `String` | No | Group name |
| `permissions` | `java.util.List[Object]` | No |  |
| `phone_number` | `String` | No |  |
| `read` | `java.lang.Boolean` | No | Has read permission |
| `send` | `java.lang.Boolean` | No | Has send permission |
| `source` | `String` | No |  |
| `type` | `String` | No |  |
| `username` | `String` | No |  |
| `value` | `String` | No |  |
| `write` | `java.lang.Boolean` | No | Has write permission |

### Operations

#### `list(reqmatch, ctrl) -> Object`

List entities matching the given criteria. The match is optional — call `list(null, null)` to list all records. Returns an aggregate list and raises on error.

```scala
val results = client.contactsFieldOption(null).list(null, null)
println(results)
```

### Common Methods

#### `data(newdata*) -> Object`

Get or set the entity data.

#### `matchArgs(newmatch*) -> Object`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `ContactsFieldOption` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## Contactsgroup

```scala
val contactsgroup = client.contactsgroup(null)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `birthday_date` | `String` | No |  |
| `city` | `String` | No |  |
| `contact_expire_after` | `java.lang.Long` | Yes | Contact expire after days |
| `contacts_count` | `java.lang.Long` | No |  |
| `country` | `String` | No |  |
| `created_by` | `String` | Yes |  |
| `date_created` | `String` | Yes |  |
| `date_updated` | `String` | Yes |  |
| `description` | `String` | No |  |
| `email` | `String` | No |  |
| `first_name` | `String` | No |  |
| `gender` | `String` | Yes |  |
| `group_id` | `String` | Yes | Object ID |
| `groups` | `java.util.List[Object]` | Yes |  |
| `id` | `String` | Yes | Object ID |
| `idx` | `String` | No | User provided resource id |
| `last_name` | `String` | No |  |
| `name` | `String` | No | Group name |
| `permissions` | `java.util.List[Object]` | No |  |
| `phone_number` | `String` | No |  |
| `read` | `java.lang.Boolean` | Yes | Has read permission |
| `send` | `java.lang.Boolean` | Yes | Has send permission |
| `source` | `String` | No |  |
| `type` | `String` | No |  |
| `username` | `String` | Yes |  |
| `value` | `String` | No |  |
| `write` | `java.lang.Boolean` | Yes | Has write permission |

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

#### `create(reqdata, ctrl) -> Object`

Create a new entity with the given data. Returns the created entity data and raises on error.

```scala
val result = client.contactsgroup(null).create(java.util.Map.of(
    "contact_expire_after", 1L,  // java.lang.Long
    "created_by", "example_created_by",  // String
    "date_created", "example_date_created",  // String
    "date_updated", "example_date_updated",  // String
    "gender", "example_gender",  // String
    "group_id", "example_group_id",  // String
    "groups", java.util.List.of(),  // java.util.List[Object]
    "id", "example_id",  // String
    "read", true,  // java.lang.Boolean
    "send", true,  // java.lang.Boolean
    "username", "example_username",  // String
    "write", true  // java.lang.Boolean
), null)
```

#### `list(reqmatch, ctrl) -> Object`

List entities matching the given criteria. The match is optional — call `list(null, null)` to list all records. Returns an aggregate list and raises on error.

```scala
val results = client.contactsgroup(null).list(null, null)
println(results)
```

#### `remove(reqmatch, ctrl) -> Object`

Remove the entity matching the given criteria. Raises on error.

```scala
val result = client.contactsgroup(null).remove(java.util.Map.of("group_id", "group_id"), null)
```

#### `update(reqdata, ctrl) -> Object`

Update an existing entity. The data must include the entity `id`. Returns the updated entity data and raises on error.

```scala
val result = client.contactsgroup(null).update(java.util.Map.of(
    "group_id", "group_id"
), null)
```

### Common Methods

#### `data(newdata*) -> Object`

Get or set the entity data.

#### `matchArgs(newmatch*) -> Object`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Contactsgroup` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## Contactstrash

```scala
val contactstrash = client.contactstrash(null)
```

### Operations

#### `remove(reqmatch, ctrl) -> Object`

Remove the entity matching the given criteria. Raises on error.

```scala
val result = client.contactstrash(null).remove(null, null)
```

#### `update(reqdata, ctrl) -> Object`

Update an existing entity. The data must include the entity `id`. Returns the updated entity data and raises on error.

```scala
val result = client.contactstrash(null).update(java.util.Map.of(
), null)
```

### Common Methods

#### `data(newdata*) -> Object`

Get or set the entity data.

#### `matchArgs(newmatch*) -> Object`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Contactstrash` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## FieldAvailable

```scala
val fieldAvailable = client.fieldAvailable(null)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `built_in` | `java.lang.Boolean` | No |  |
| `id` | `String` | No | Object ID |
| `name` | `String` | No |  |
| `options` | `java.util.List[Object]` | No |  |
| `type` | `String` | No |  |

### Operations

#### `list(reqmatch, ctrl) -> Object`

List entities matching the given criteria. The match is optional — call `list(null, null)` to list all records. Returns an aggregate list and raises on error.

```scala
val results = client.fieldAvailable(null).list(null, null)
println(results)
```

### Common Methods

#### `data(newdata*) -> Object`

Get or set the entity data.

#### `matchArgs(newmatch*) -> Object`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `FieldAvailable` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## Group

```scala
val group = client.group(null)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `contact_expire_after` | `java.lang.Long` | Yes | Contact expire after days |
| `contacts_count` | `java.lang.Long` | Yes |  |
| `created_by` | `String` | Yes |  |
| `date_created` | `String` | Yes |  |
| `date_updated` | `String` | Yes |  |
| `description` | `String` | Yes |  |
| `id` | `String` | Yes | Object ID |
| `idx` | `String` | No | User provided resource id |
| `name` | `String` | Yes | Group name |
| `permissions` | `java.util.List[Object]` | No |  |

### Operations

#### `load(reqmatch, ctrl) -> Object`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```scala
val result = client.group(null).load(java.util.Map.of("id", "group_id"), null)
```

#### `update(reqdata, ctrl) -> Object`

Update an existing entity. The data must include the entity `id`. Returns the updated entity data and raises on error.

```scala
val result = client.group(null).update(java.util.Map.of(
    "id", "group_id"
), null)
```

### Common Methods

#### `data(newdata*) -> Object`

Get or set the entity data.

#### `matchArgs(newmatch*) -> Object`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Group` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## MfaCode

```scala
val mfaCode = client.mfaCode(null)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `content` | `String` | No | Custom content that must contain placeholder [%code%] |
| `fast` | `Object` | No |  |
| `from` | `String` | No | Sendername |
| `phone_number` | `String` | Yes |  |

### Operations

#### `create(reqdata, ctrl) -> Object`

Create a new entity with the given data. Returns the created entity data and raises on error.

```scala
val result = client.mfaCode(null).create(java.util.Map.of(
    "phone_number", "example_phone_number"  // String
), null)
```

### Common Methods

#### `data(newdata*) -> Object`

Get or set the entity data.

#### `matchArgs(newmatch*) -> Object`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `MfaCode` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## OptOut

```scala
val optOut = client.optOut(null)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `date` | `String` | No |  |
| `id` | `String` | No |  |
| `links` | `java.util.List[Object]` | No |  |
| `phoneNumber` | `java.lang.Long` | No |  |

### Operations

#### `list(reqmatch, ctrl) -> Object`

List entities matching the given criteria. The match is optional — call `list(null, null)` to list all records. Returns an aggregate list and raises on error.

```scala
val results = client.optOut(null).list(null, null)
println(results)
```

#### `remove(reqmatch, ctrl) -> Object`

Remove the entity matching the given criteria. Raises on error.

```scala
val result = client.optOut(null).remove(java.util.Map.of("id", "id"), null)
```

### Common Methods

#### `data(newdata*) -> Object`

Get or set the entity data.

#### `matchArgs(newmatch*) -> Object`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `OptOut` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## OptOutSetting

```scala
val optOutSetting = client.optOutSetting(null)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `brand` | `String` | No |  |

### Operations

#### `load(reqmatch, ctrl) -> Object`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```scala
val result = client.optOutSetting(null).load(null, null)
```

#### `update(reqdata, ctrl) -> Object`

Update an existing entity. The data must include the entity `id`. Returns the updated entity data and raises on error.

```scala
val result = client.optOutSetting(null).update(java.util.Map.of(
), null)
```

### Common Methods

#### `data(newdata*) -> Object`

Get or set the entity data.

#### `matchArgs(newmatch*) -> Object`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `OptOutSetting` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## Permission

```scala
val permission = client.permission(null)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `group_id` | `String` | Yes | Object ID |
| `id` | `String` | No |  |
| `read` | `java.lang.Boolean` | Yes | Has read permission |
| `send` | `java.lang.Boolean` | Yes | Has send permission |
| `username` | `String` | Yes |  |
| `write` | `java.lang.Boolean` | Yes | Has write permission |

### Operations

#### `create(reqdata, ctrl) -> Object`

Create a new entity with the given data. Returns the created entity data and raises on error.

```scala
val result = client.permission(null).create(java.util.Map.of(
    "group_id", "example_group_id",  // String
    "read", true,  // java.lang.Boolean
    "send", true,  // java.lang.Boolean
    "username", "example_username",  // String
    "write", true  // java.lang.Boolean
), null)
```

#### `load(reqmatch, ctrl) -> Object`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```scala
val result = client.permission(null).load(java.util.Map.of("id", "permission_id", "group_id", "group_id", "username", "username"), null)
```

### Common Methods

#### `data(newdata*) -> Object`

Get or set the entity data.

#### `matchArgs(newmatch*) -> Object`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Permission` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## Ping

```scala
val ping = client.ping(null)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `authorized` | `java.lang.Boolean` | Yes |  |
| `unavailable` | `java.util.List[Object]` | Yes |  |

### Operations

#### `list(reqmatch, ctrl) -> Object`

List entities matching the given criteria. The match is optional — call `list(null, null)` to list all records. Returns an aggregate list and raises on error.

```scala
val results = client.ping(null).list(null, null)
println(results)
```

### Common Methods

#### `data(newdata*) -> Object`

Get or set the entity data.

#### `matchArgs(newmatch*) -> Object`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Ping` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## Profile

```scala
val profile = client.profile(null)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `email` | `String` | Yes |  |
| `name` | `String` | Yes |  |
| `payment_type` | `String` | Yes |  |
| `phone_number` | `java.lang.Long` | Yes |  |
| `points` | `java.lang.Double` | No |  |
| `user_type` | `String` | Yes |  |
| `username` | `String` | Yes |  |

### Operations

#### `list(reqmatch, ctrl) -> Object`

List entities matching the given criteria. The match is optional — call `list(null, null)` to list all records. Returns an aggregate list and raises on error.

```scala
val results = client.profile(null).list(null, null)
println(results)
```

#### `load(reqmatch, ctrl) -> Object`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```scala
val result = client.profile(null).load(null, null)
```

### Common Methods

#### `data(newdata*) -> Object`

Get or set the entity data.

#### `matchArgs(newmatch*) -> Object`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Profile` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## Rcs

```scala
val rcs = client.rcs(null)
```

### Operations

#### `list(reqmatch, ctrl) -> Object`

List entities matching the given criteria. The match is optional — call `list(null, null)` to list all records. Returns an aggregate list and raises on error.

```scala
val results = client.rcs(null).list(null, null)
println(results)
```

### Common Methods

#### `data(newdata*) -> Object`

Get or set the entity data.

#### `matchArgs(newmatch*) -> Object`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Rcs` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## Sendername

```scala
val sendername = client.sendername(null)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `created_at` | `String` | No |  |
| `id` | `String` | No |  |
| `is_default` | `java.lang.Boolean` | No |  |
| `sender` | `String` | No | Sendername |
| `status` | `String` | No |  |

### Operations

#### `create(reqdata, ctrl) -> Object`

Create a new entity with the given data. Returns the created entity data and raises on error.

```scala
val result = client.sendername(null).create(java.util.Map.of(
), null)
```

#### `list(reqmatch, ctrl) -> Object`

List entities matching the given criteria. The match is optional — call `list(null, null)` to list all records. Returns an aggregate list and raises on error.

```scala
val results = client.sendername(null).list(null, null)
println(results)
```

#### `load(reqmatch, ctrl) -> Object`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```scala
val result = client.sendername(null).load(java.util.Map.of("id", "sendername_id"), null)
```

### Common Methods

#### `data(newdata*) -> Object`

Get or set the entity data.

#### `matchArgs(newmatch*) -> Object`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Sendername` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## SendernameStatement

```scala
val sendernameStatement = client.sendernameStatement(null)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `content` | `String` | No |  |
| `statements` | `java.util.List[Object]` | No |  |
| `title` | `String` | No |  |

### Operations

#### `list(reqmatch, ctrl) -> Object`

List entities matching the given criteria. The match is optional — call `list(null, null)` to list all records. Returns an aggregate list and raises on error.

```scala
val results = client.sendernameStatement(null).list(null, null)
println(results)
```

### Common Methods

#### `data(newdata*) -> Object`

Get or set the entity data.

#### `matchArgs(newmatch*) -> Object`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `SendernameStatement` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## SentRcsMessage

```scala
val sentRcsMessage = client.sentRcsMessage(null)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `content` | `java.util.Map[String, Object]` | No | RCS message content in RCS JSON format. |
| `phone_number` | `String` | Yes | Recipient phone number (e.g. |
| `sender` | `Object` | Yes |  |
| `text` | `String` | No | Plain text message content. |

### Operations

#### `create(reqdata, ctrl) -> Object`

Create a new entity with the given data. Returns the created entity data and raises on error.

```scala
val result = client.sentRcsMessage(null).create(java.util.Map.of(
    "phone_number", "example_phone_number",  // String
    "sender", "example_sender"  // Object
), null)
```

### Common Methods

#### `data(newdata*) -> Object`

Get or set the entity data.

#### `matchArgs(newmatch*) -> Object`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `SentRcsMessage` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## ShipmentCountryVolume

```scala
val shipmentCountryVolume = client.shipmentCountryVolume(null)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `country_code` | `String` | No |  |
| `country_limit` | `java.lang.Long` | No |  |
| `country_name` | `String` | No |  |
| `usage` | `java.lang.Long` | No |  |

### Operations

#### `list(reqmatch, ctrl) -> Object`

List entities matching the given criteria. The match is optional — call `list(null, null)` to list all records. Returns an aggregate list and raises on error.

```scala
val results = client.shipmentCountryVolume(null).list(null, null)
println(results)
```

### Common Methods

#### `data(newdata*) -> Object`

Get or set the entity data.

#### `matchArgs(newmatch*) -> Object`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `ShipmentCountryVolume` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## ShortUrl

```scala
val shortUrl = client.shortUrl(null)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `description` | `String` | No |  |
| `expire` | `String` | No |  |
| `filename` | `String` | No |  |
| `hits` | `java.lang.Long` | No |  |
| `hits_unique` | `java.lang.Long` | No |  |
| `id` | `String` | No |  |
| `name` | `String` | No |  |
| `short_url` | `String` | No | WHATWG URL compliant |
| `type` | `String` | No |  |
| `url` | `String` | No | WHATWG URL compliant |

### Operations

#### `create(reqdata, ctrl) -> Object`

Create a new entity with the given data. Returns the created entity data and raises on error.

```scala
val result = client.shortUrl(null).create(java.util.Map.of(
), null)
```

#### `list(reqmatch, ctrl) -> Object`

List entities matching the given criteria. The match is optional — call `list(null, null)` to list all records. Returns an aggregate list and raises on error.

```scala
val results = client.shortUrl(null).list(null, null)
println(results)
```

#### `load(reqmatch, ctrl) -> Object`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```scala
val result = client.shortUrl(null).load(java.util.Map.of("id", "short_url_id"), null)
```

#### `remove(reqmatch, ctrl) -> Object`

Remove the entity matching the given criteria. Raises on error.

```scala
val result = client.shortUrl(null).remove(java.util.Map.of("id", "short_url_id"), null)
```

#### `update(reqdata, ctrl) -> Object`

Update an existing entity. The data must include the entity `id`. Returns the updated entity data and raises on error.

```scala
val result = client.shortUrl(null).update(java.util.Map.of(
    "id", "short_url_id"
), null)
```

### Common Methods

#### `data(newdata*) -> Object`

Get or set the entity data.

#### `matchArgs(newmatch*) -> Object`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `ShortUrl` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## Smsdo

```scala
val smsdo = client.smsdo(null)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `allow_duplicates` | `java.lang.Long` | No | When parameter allow_duplicates is set to "1" allows to send message to duplicated numbers in one request (useful i.e. |
| `check_idx` | `Object` | No | When parameter check_idx is set to „1” prevents from sending more than one message with the same idx in last 24h. |
| `date` | `Object` | No | Date in UNIX timestamp (&date=1287734110) or in ISO 8601 (&date=2012-05-10T08:40:27+00:00) when message will be sent (&date=1287734110). |
| `date_validate` | `java.lang.Long` | No | When parameter date_validate is set to "1" checks if date if given in proper format. |
| `details` | `Object` | No | When details parameter is set to "1" more details in response will be displayed (message length and sms count). |
| `encoding` | `String` | No | This parameter describes the encoding of the message text. |
| `expiration_date` | `Object` | No | Message expiration date (in UNIX timestamp or in ISO 8601) is a date after which message won't be delivered if it wasn't delivered yet. |
| `fallback` | `java.util.List[Object]` | No | Enable fallback in case sms sending fails |
| `fast` | `java.lang.Long` | No | Setting this parameter to „1” will result in sending message with the highest priority which ensures the quickest possible time of delivery. |
| `flash` | `java.lang.Long` | No | Sending a message in flash mode can be activated by setting this parameter to "1". |
| `format` | `String` | No | Parameter &format=json causes, that response is sending in JSON format. |
| `from` | `String` | No | Name of the sender. |
| `group` | `String` | No | Name of the group from the contacts database to which message should be sent to. |
| `idx` | `String` | No | Optional custom value sent with SMS and sent back in CALLBACK. |
| `max_parts` | `java.lang.Long` | No | Defines maximum message parts allowed, maximum value allowed is 6. |
| `message` | `String` | No | The message text. |
| `normalize` | `java.lang.Long` | No | When parameter normalize is set to „1” special chars in message will be replaced with their equivalents (ê-e, ñ-n, ý-y ...). |
| `notify_url` | `String` | No | Parameter allows to set CALLBACK URL for message from request. |
| `test` | `Object` | No | When parameter test is set to "1" message won't be sent but response will be displayed, there is no charge for such test messages. |
| `time_restriction` | `String` | No | Sets the behavior when you try to ship in hours / dates that do not match the settings in your account. |
| `to` | `String` | No | Recipients' mobile phone numbers (i.e. |

### Operations

#### `create(reqdata, ctrl) -> Object`

Create a new entity with the given data. Returns the created entity data and raises on error.

```scala
val result = client.smsdo(null).create(java.util.Map.of(
), null)
```

### Common Methods

#### `data(newdata*) -> Object`

Get or set the entity data.

#### `matchArgs(newmatch*) -> Object`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Smsdo` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## Smssendername

```scala
val smssendername = client.smssendername(null)
```

### Operations

#### `create(reqdata, ctrl) -> Object`

Create a new entity with the given data. Returns the created entity data and raises on error.

```scala
val result = client.smssendername(null).create(java.util.Map.of(
    "sendername_id", "example_sendername_id"  // String
), null)
```

#### `remove(reqmatch, ctrl) -> Object`

Remove the entity matching the given criteria. Raises on error.

```scala
val result = client.smssendername(null).remove(java.util.Map.of("sender", "sender"), null)
```

### Common Methods

#### `data(newdata*) -> Object`

Get or set the entity data.

#### `matchArgs(newmatch*) -> Object`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Smssendername` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## Smstemplate

```scala
val smstemplate = client.smstemplate(null)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | `String` | No |  |

### Operations

#### `remove(reqmatch, ctrl) -> Object`

Remove the entity matching the given criteria. Raises on error.

```scala
val result = client.smstemplate(null).remove(java.util.Map.of("id", "id"), null)
```

### Common Methods

#### `data(newdata*) -> Object`

Get or set the entity data.

#### `matchArgs(newmatch*) -> Object`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Smstemplate` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## Subuser

```scala
val subuser = client.subuser(null)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `active` | `java.lang.Boolean` | No |  |
| `credentials` | `java.util.Map[String, Object]` | Yes |  |
| `description` | `String` | No |  |
| `id` | `String` | No | Object ID |
| `points` | `java.util.Map[String, Object]` | No |  |
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

#### `create(reqdata, ctrl) -> Object`

Create a new entity with the given data. Returns the created entity data and raises on error.

```scala
val result = client.subuser(null).create(java.util.Map.of(
    "credentials", java.util.Map.of()  // java.util.Map[String, Object]
), null)
```

#### `list(reqmatch, ctrl) -> Object`

List entities matching the given criteria. The match is optional — call `list(null, null)` to list all records. Returns an aggregate list and raises on error.

```scala
val results = client.subuser(null).list(null, null)
println(results)
```

#### `load(reqmatch, ctrl) -> Object`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```scala
val result = client.subuser(null).load(java.util.Map.of("id", "subuser_id"), null)
```

#### `remove(reqmatch, ctrl) -> Object`

Remove the entity matching the given criteria. Raises on error.

```scala
val result = client.subuser(null).remove(java.util.Map.of("id", "subuser_id"), null)
```

#### `update(reqdata, ctrl) -> Object`

Update an existing entity. The data must include the entity `id`. Returns the updated entity data and raises on error.

```scala
val result = client.subuser(null).update(java.util.Map.of(
    "id", "subuser_id"
), null)
```

### Common Methods

#### `data(newdata*) -> Object`

Get or set the entity data.

#### `matchArgs(newmatch*) -> Object`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Subuser` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## Template

```scala
val template = client.template(null)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | `String` | No |  |
| `name` | `String` | No |  |
| `normalize` | `java.lang.Boolean` | No |  |
| `template` | `String` | No |  |

### Operations

#### `create(reqdata, ctrl) -> Object`

Create a new entity with the given data. Returns the created entity data and raises on error.

```scala
val result = client.template(null).create(java.util.Map.of(
), null)
```

#### `list(reqmatch, ctrl) -> Object`

List entities matching the given criteria. The match is optional — call `list(null, null)` to list all records. Returns an aggregate list and raises on error.

```scala
val results = client.template(null).list(null, null)
println(results)
```

#### `load(reqmatch, ctrl) -> Object`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```scala
val result = client.template(null).load(java.util.Map.of("id", "template_id"), null)
```

#### `update(reqdata, ctrl) -> Object`

Update an existing entity. The data must include the entity `id`. Returns the updated entity data and raises on error.

```scala
val result = client.template(null).update(java.util.Map.of(
    "id", "template_id"
), null)
```

### Common Methods

#### `data(newdata*) -> Object`

Get or set the entity data.

#### `matchArgs(newmatch*) -> Object`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Template` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## UserRcsSenderCollection

```scala
val userRcsSenderCollection = client.userRcsSenderCollection(null)
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

#### `list(reqmatch, ctrl) -> Object`

List entities matching the given criteria. The match is optional — call `list(null, null)` to list all records. Returns an aggregate list and raises on error.

```scala
val results = client.userRcsSenderCollection(null).list(null, null)
println(results)
```

### Common Methods

#### `data(newdata*) -> Object`

Get or set the entity data.

#### `matchArgs(newmatch*) -> Object`

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

```scala
val feature = new java.util.LinkedHashMap[String, Object]()
feature.put("audit", java.util.Map.of("active", true))
feature.put("cache", java.util.Map.of("active", true))
feature.put("clienttrack", java.util.Map.of("active", true))
feature.put("cost", java.util.Map.of("active", true))
feature.put("debug", java.util.Map.of("active", true))
feature.put("idempotency", java.util.Map.of("active", true))
feature.put("log", java.util.Map.of("active", true))
feature.put("metrics", java.util.Map.of("active", true))
feature.put("netsim", java.util.Map.of("active", true))
feature.put("paging", java.util.Map.of("active", true))
feature.put("proxy", java.util.Map.of("active", true))
feature.put("ratelimit", java.util.Map.of("active", true))
feature.put("rbac", java.util.Map.of("active", true))
feature.put("retry", java.util.Map.of("active", true))
feature.put("secrets", java.util.Map.of("active", true))
feature.put("streaming", java.util.Map.of("active", true))
feature.put("telemetry", java.util.Map.of("active", true))
feature.put("test", java.util.Map.of("active", true))
feature.put("timeout", java.util.Map.of("active", true))
feature.put("validate", java.util.Map.of("active", true))
val options = new java.util.LinkedHashMap[String, Object]()
options.put("feature", feature)
val client = new SmsapiSDK(options)
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

