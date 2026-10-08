# Smsapi Kotlin SDK Reference

Complete API reference for the Smsapi Kotlin SDK.


## SmsapiSDK

### Constructor

```kotlin
val client = SmsapiSDK(options)
```

Create a new SDK client instance. `options` is a `MutableMap<String, Any?>`.

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

```kotlin
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

#### `optionsMap() -> MutableMap`

Return a deep copy of the current SDK options.

#### `getUtility() -> Utility`

Return a copy of the SDK utility object.

#### `direct(fetchargs) -> MutableMap`

Make a direct HTTP request to any API endpoint. Returns a result
`MutableMap<String, Any?>` with `ok`, `status`, `headers`, and `data`
(or `err` on failure). This escape hatch never raises — branch on
`result["ok"]`.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `fetchargs["path"]` | `String` | URL path with optional `{param}` placeholders. |
| `fetchargs["method"]` | `String` | HTTP method (default: `"GET"`). |
| `fetchargs["params"]` | `Map` | Path parameter values. |
| `fetchargs["query"]` | `Map` | Query string parameters. |
| `fetchargs["headers"]` | `Map` | Request headers (merged with defaults). |
| `fetchargs["body"]` | `Any?` | Request body (maps are JSON-serialized). |

**Returns:** `MutableMap<String, Any?>`

#### `prepare(fetchargs) -> MutableMap`

Prepare a fetch definition without sending. Returns the `fetchdef` and raises on error.


---

## Available

```kotlin
val available = client.available(null)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `name` | `String?` | No |  |
| `normalize` | `Boolean?` | No |  |
| `template` | `String?` | No |  |

### Operations

#### `list(reqmatch, ctrl) -> Any?`

List entities matching the given criteria. The match is optional — call `list(null, null)` to list all records. Returns a list of entities, one per record, and raises on error.

```kotlin
val results = client.available(null).list(null, null) as List<*>
for (item in results) {
    println((item as SdkEntity).data())
}
```

### Common Methods

#### `data(vararg newdata) -> Any?`

Get or set the entity data.

#### `match(vararg newmatch) -> Any?`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Available` entity instance with the same options.

#### `name -> String`

The entity name (read-only property).


---

## Blacklist

```kotlin
val blacklist = client.blacklist(null)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | `String?` | No |  |

### Operations

#### `create(reqdata, ctrl) -> Any?`

Create a new entity with the given data. Returns the created entity and raises on error.

```kotlin
val result = client.blacklist(null).create(mutableMapOf<String, Any?>(
), null)
```

Declares a `multipart/form-data` body, which this SDK does not encode yet: it sends the data as JSON.

#### `load(reqmatch, ctrl) -> Any?`

Load a single entity matching the given criteria. Returns the entity, whose record `data()` reads, and raises on error.

```kotlin
val result = client.blacklist(null).load(null, null)
```

#### `remove(reqmatch, ctrl) -> Any?`

Remove the entity matching the given criteria. Returns the entity, marked as deleted, and raises on error.

```kotlin
val result = client.blacklist(null).remove(mutableMapOf<String, Any?>("id" to "id"), null)
```

### Common Methods

#### `data(vararg newdata) -> Any?`

Get or set the entity data.

#### `match(vararg newmatch) -> Any?`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Blacklist` entity instance with the same options.

#### `name -> String`

The entity name (read-only property).


---

## Callback

```kotlin
val callback = client.callback(null)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `active` | `Boolean?` | No |  |
| `api_version` | `Long?` | No | Version of the callback output format. |
| `id` | `String?` | No | Object ID |
| `invalid` | `Boolean?` | No |  |
| `receiver` | `Map<String, Any?>?` | No |  |
| `receiver_type` | `String?` | No |  |
| `type` | `String?` | No |  |
| `url` | `String?` | No | WHATWG URL compliant |

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

#### `create(reqdata, ctrl) -> Any?`

Create a new entity with the given data. Returns the created entity and raises on error.

```kotlin
val result = client.callback(null).create(mutableMapOf<String, Any?>(
), null)
```

#### `list(reqmatch, ctrl) -> Any?`

List entities matching the given criteria. The match is optional — call `list(null, null)` to list all records. Returns a list of entities, one per record, and raises on error.

```kotlin
val results = client.callback(null).list(null, null) as List<*>
for (item in results) {
    println((item as SdkEntity).data())
}
```

#### `load(reqmatch, ctrl) -> Any?`

Load a single entity matching the given criteria. Returns the entity, whose record `data()` reads, and raises on error.

```kotlin
val result = client.callback(null).load(mutableMapOf<String, Any?>("id" to "callback_id"), null)
```

#### `remove(reqmatch, ctrl) -> Any?`

Remove the entity matching the given criteria. Returns the entity, marked as deleted, and raises on error.

```kotlin
val result = client.callback(null).remove(mutableMapOf<String, Any?>("id" to "callback_id"), null)
```

#### `update(reqdata, ctrl) -> Any?`

Update an existing entity. The data must include the entity `id`. Returns the updated entity and raises on error.

```kotlin
val result = client.callback(null).update(mutableMapOf<String, Any?>(
    "id" to "callback_id"
), null)
```

### Common Methods

#### `data(vararg newdata) -> Any?`

Get or set the entity data.

#### `match(vararg newmatch) -> Any?`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Callback` entity instance with the same options.

#### `name -> String`

The entity name (read-only property).


---

## Contact

```kotlin
val contact = client.contact(null)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `birthday_date` | `String?` | No |  |
| `city` | `String?` | No |  |
| `collection` | `List<Any?>?` | Yes |  |
| `contact_expire_after` | `Long?` | Yes | Contact expire after days |
| `contacts_count` | `Long?` | Yes |  |
| `country` | `String?` | No |  |
| `created_by` | `String?` | Yes |  |
| `date_created` | `String?` | Yes |  |
| `date_updated` | `String?` | Yes |  |
| `description` | `String?` | No |  |
| `email` | `String?` | No |  |
| `first_name` | `String?` | No |  |
| `gender` | `String?` | Yes |  |
| `groups` | `List<Any?>?` | Yes |  |
| `id` | `String?` | Yes | Object ID |
| `idx` | `String?` | No | User provided resource id |
| `last_name` | `String?` | No |  |
| `name` | `String?` | Yes | Group name |
| `permissions` | `List<Any?>?` | No |  |
| `phone_number` | `String?` | No |  |
| `size` | `Long?` | Yes |  |
| `source` | `String?` | No |  |

### Field Usage by Operation

| Field | load | list | create | update | remove |
| --- | --- | --- | --- | --- | --- |
| `birthday_date` | - | - | - | - | - |
| `city` | - | - | - | - | - |
| `collection` | - | - | - | - | - |
| `contact_expire_after` | - | - | - | - | - |
| `contacts_count` | - | - | - | - | - |
| `country` | - | - | - | - | - |
| `created_by` | - | - | - | - | - |
| `date_created` | - | - | - | - | - |
| `date_updated` | - | - | - | - | - |
| `description` | Yes | - | - | - | - |
| `email` | - | - | - | - | - |
| `first_name` | - | - | - | - | - |
| `gender` | - | - | - | - | - |
| `groups` | - | - | - | - | - |
| `id` | - | - | - | - | - |
| `idx` | - | - | - | - | - |
| `last_name` | - | - | - | - | - |
| `name` | - | - | - | - | - |
| `permissions` | - | - | - | - | - |
| `phone_number` | - | - | - | - | - |
| `size` | - | - | - | - | - |
| `source` | - | - | - | - | - |

### Operations

#### `create(reqdata, ctrl) -> Any?`

Create a new entity with the given data. Returns the created entity and raises on error.

```kotlin
val result = client.contact(null).create(mutableMapOf<String, Any?>(
    "collection" to listOf<Any?>(),  // List<Any?>?
    "contact_expire_after" to 1L,  // Long?
    "contacts_count" to 1L,  // Long?
    "created_by" to "example_created_by",  // String?
    "date_created" to "example_date_created",  // String?
    "date_updated" to "example_date_updated",  // String?
    "gender" to "example_gender",  // String?
    "groups" to listOf<Any?>(),  // List<Any?>?
    "id" to "example_id",  // String?
    "name" to "example_name",  // String?
    "size" to 1L  // Long?
), null)
```

Declares a `application/x-www-form-urlencoded` body, which this SDK does not encode yet: it sends the data as JSON.

#### `list(reqmatch, ctrl) -> Any?`

List entities matching the given criteria. The match is optional — call `list(null, null)` to list all records. Returns a list of entities, one per record, and raises on error.

```kotlin
val results = client.contact(null).list(null, null) as List<*>
for (item in results) {
    println((item as SdkEntity).data())
}
```

#### `load(reqmatch, ctrl) -> Any?`

Load a single entity matching the given criteria. Returns the entity, whose record `data()` reads, and raises on error.

```kotlin
val result = client.contact(null).load(mutableMapOf<String, Any?>("id" to "contact_id"), null)
```

#### `remove(reqmatch, ctrl) -> Any?`

Remove the entity matching the given criteria. Returns the entity, marked as deleted, and raises on error.

```kotlin
val result = client.contact(null).remove(mutableMapOf<String, Any?>("id" to "contact_id"), null)
```

#### `update(reqdata, ctrl) -> Any?`

Update an existing entity. The data must include the entity `id`. Returns the updated entity and raises on error.

```kotlin
val result = client.contact(null).update(mutableMapOf<String, Any?>(
    "id" to "contact_id"
), null)
```

Declares a `application/x-www-form-urlencoded` body, which this SDK does not encode yet: it sends the data as JSON.

### Common Methods

#### `data(vararg newdata) -> Any?`

Get or set the entity data.

#### `match(vararg newmatch) -> Any?`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Contact` entity instance with the same options.

#### `name -> String`

The entity name (read-only property).


---

## ContactsField

```kotlin
val contactsField = client.contactsField(null)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | `String?` | No | Object ID |
| `name` | `String?` | No |  |
| `type` | `String?` | No |  |

### Operations

#### `create(reqdata, ctrl) -> Any?`

Create a new entity with the given data. Returns the created entity and raises on error.

```kotlin
val result = client.contactsField(null).create(mutableMapOf<String, Any?>(
), null)
```

Declares a `application/x-www-form-urlencoded` body, which this SDK does not encode yet: it sends the data as JSON.

#### `list(reqmatch, ctrl) -> Any?`

List entities matching the given criteria. The match is optional — call `list(null, null)` to list all records. Returns a list of entities, one per record, and raises on error.

```kotlin
val results = client.contactsField(null).list(null, null) as List<*>
for (item in results) {
    println((item as SdkEntity).data())
}
```

#### `remove(reqmatch, ctrl) -> Any?`

Remove the entity matching the given criteria. Returns the entity, marked as deleted, and raises on error.

```kotlin
val result = client.contactsField(null).remove(mutableMapOf<String, Any?>("id" to "id"), null)
```

#### `update(reqdata, ctrl) -> Any?`

Update an existing entity. The data must include the entity `id`. Returns the updated entity and raises on error.

```kotlin
val result = client.contactsField(null).update(mutableMapOf<String, Any?>(
    "id" to "id"
), null)
```

Declares a `application/x-www-form-urlencoded` body, which this SDK does not encode yet: it sends the data as JSON.

### Common Methods

#### `data(vararg newdata) -> Any?`

Get or set the entity data.

#### `match(vararg newmatch) -> Any?`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `ContactsField` entity instance with the same options.

#### `name -> String`

The entity name (read-only property).


---

## ContactsFieldOption

```kotlin
val contactsFieldOption = client.contactsFieldOption(null)
```

### Operations

#### `list(reqmatch, ctrl) -> Any?`

List entities matching the given criteria. The match is optional — call `list(null, null)` to list all records. Returns a list of entities, one per record, and raises on error.

```kotlin
val results = client.contactsFieldOption(null).list(mutableMapOf<String, Any?>("field_id" to "example"), null) as List<*>
for (item in results) {
    println((item as SdkEntity).data())
}
```

### Common Methods

#### `data(vararg newdata) -> Any?`

Get or set the entity data.

#### `match(vararg newmatch) -> Any?`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `ContactsFieldOption` entity instance with the same options.

#### `name -> String`

The entity name (read-only property).


---

## Contactsgroup

```kotlin
val contactsgroup = client.contactsgroup(null)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `group_id` | `String?` | Yes | Object ID |
| `read` | `Boolean?` | Yes | Has read permission |
| `send` | `Boolean?` | Yes | Has send permission |
| `username` | `String?` | Yes |  |
| `write` | `Boolean?` | Yes | Has write permission |

### Operations

#### `create(reqdata, ctrl) -> Any?`

Create a new entity with the given data. Returns the created entity and raises on error.

```kotlin
val result = client.contactsgroup(null).create(mutableMapOf<String, Any?>(
    "group_id" to "example_group_id",  // String?
    "read" to true,  // Boolean?
    "send" to true,  // Boolean?
    "username" to "example_username",  // String?
    "write" to true  // Boolean?
), null)
```

Declares a `application/x-www-form-urlencoded` body, which this SDK does not encode yet: it sends the data as JSON.

#### `list(reqmatch, ctrl) -> Any?`

List entities matching the given criteria. The match is optional — call `list(null, null)` to list all records. Returns a list of entities, one per record, and raises on error.

```kotlin
val results = client.contactsgroup(null).list(null, null) as List<*>
for (item in results) {
    println((item as SdkEntity).data())
}
```

#### `remove(reqmatch, ctrl) -> Any?`

Remove the entity matching the given criteria. Returns the entity, marked as deleted, and raises on error.

```kotlin
val result = client.contactsgroup(null).remove(mutableMapOf<String, Any?>("group_id" to "group_id"), null)
```

#### `update(reqdata, ctrl) -> Any?`

Update an existing entity. The data must include the entity `id`. Returns the updated entity and raises on error.

```kotlin
val result = client.contactsgroup(null).update(mutableMapOf<String, Any?>(
    "group_id" to "group_id"
), null)
```

Declares a `application/x-www-form-urlencoded` body, which this SDK does not encode yet: it sends the data as JSON.

### Common Methods

#### `data(vararg newdata) -> Any?`

Get or set the entity data.

#### `match(vararg newmatch) -> Any?`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Contactsgroup` entity instance with the same options.

#### `name -> String`

The entity name (read-only property).


---

## Contactstrash

```kotlin
val contactstrash = client.contactstrash(null)
```

### Operations

#### `remove(reqmatch, ctrl) -> Any?`

Remove the entity matching the given criteria. Returns the entity, marked as deleted, and raises on error.

```kotlin
val result = client.contactstrash(null).remove(null, null)
```

#### `update(reqdata, ctrl) -> Any?`

Update an existing entity. The data must include the entity `id`. Returns the updated entity and raises on error.

```kotlin
val result = client.contactstrash(null).update(mutableMapOf<String, Any?>(
), null)
```

### Common Methods

#### `data(vararg newdata) -> Any?`

Get or set the entity data.

#### `match(vararg newmatch) -> Any?`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Contactstrash` entity instance with the same options.

#### `name -> String`

The entity name (read-only property).


---

## FieldAvailable

```kotlin
val fieldAvailable = client.fieldAvailable(null)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `built_in` | `Boolean?` | No |  |
| `id` | `String?` | No | Object ID |
| `name` | `String?` | No |  |
| `options` | `List<Any?>?` | No |  |
| `type` | `String?` | No |  |

### Operations

#### `list(reqmatch, ctrl) -> Any?`

List entities matching the given criteria. The match is optional — call `list(null, null)` to list all records. Returns a list of entities, one per record, and raises on error.

```kotlin
val results = client.fieldAvailable(null).list(null, null) as List<*>
for (item in results) {
    println((item as SdkEntity).data())
}
```

### Common Methods

#### `data(vararg newdata) -> Any?`

Get or set the entity data.

#### `match(vararg newmatch) -> Any?`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `FieldAvailable` entity instance with the same options.

#### `name -> String`

The entity name (read-only property).


---

## Group

```kotlin
val group = client.group(null)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `contact_expire_after` | `Long?` | Yes | Contact expire after days |
| `contacts_count` | `Long?` | Yes |  |
| `created_by` | `String?` | Yes |  |
| `date_created` | `String?` | Yes |  |
| `date_updated` | `String?` | Yes |  |
| `description` | `String?` | Yes |  |
| `id` | `String?` | Yes | Object ID |
| `idx` | `String?` | No | User provided resource id |
| `name` | `String?` | Yes | Group name |
| `permissions` | `List<Any?>?` | No |  |

### Operations

#### `load(reqmatch, ctrl) -> Any?`

Load a single entity matching the given criteria. Returns the entity, whose record `data()` reads, and raises on error.

```kotlin
val result = client.group(null).load(mutableMapOf<String, Any?>("id" to "group_id"), null)
```

#### `update(reqdata, ctrl) -> Any?`

Update an existing entity. The data must include the entity `id`. Returns the updated entity and raises on error.

```kotlin
val result = client.group(null).update(mutableMapOf<String, Any?>(
    "id" to "group_id"
), null)
```

Declares a `application/x-www-form-urlencoded` body, which this SDK does not encode yet: it sends the data as JSON.

### Common Methods

#### `data(vararg newdata) -> Any?`

Get or set the entity data.

#### `match(vararg newmatch) -> Any?`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Group` entity instance with the same options.

#### `name -> String`

The entity name (read-only property).


---

## MfaCode

```kotlin
val mfaCode = client.mfaCode(null)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `content` | `String?` | No | Custom content that must contain placeholder [%code%] |
| `fast` | `Any?` | No |  |
| `from` | `String?` | No | Sendername |
| `phone_number` | `String?` | Yes |  |

### Operations

#### `create(reqdata, ctrl) -> Any?`

Create a new entity with the given data. Returns the created entity and raises on error.

```kotlin
val result = client.mfaCode(null).create(mutableMapOf<String, Any?>(
    "phone_number" to "example_phone_number"  // String?
), null)
```

Declares a `application/x-www-form-urlencoded` body, which this SDK does not encode yet: it sends the data as JSON.

### Common Methods

#### `data(vararg newdata) -> Any?`

Get or set the entity data.

#### `match(vararg newmatch) -> Any?`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `MfaCode` entity instance with the same options.

#### `name -> String`

The entity name (read-only property).


---

## OptOut

```kotlin
val optOut = client.optOut(null)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `date` | `String?` | No |  |
| `id` | `String?` | No |  |
| `links` | `List<Any?>?` | No |  |
| `phoneNumber` | `Long?` | No |  |

### Operations

#### `list(reqmatch, ctrl) -> Any?`

List entities matching the given criteria. The match is optional — call `list(null, null)` to list all records. Returns a list of entities, one per record, and raises on error.

```kotlin
val results = client.optOut(null).list(null, null) as List<*>
for (item in results) {
    println((item as SdkEntity).data())
}
```

#### `remove(reqmatch, ctrl) -> Any?`

Remove the entity matching the given criteria. Returns the entity, marked as deleted, and raises on error.

```kotlin
val result = client.optOut(null).remove(mutableMapOf<String, Any?>("id" to "id"), null)
```

### Common Methods

#### `data(vararg newdata) -> Any?`

Get or set the entity data.

#### `match(vararg newmatch) -> Any?`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `OptOut` entity instance with the same options.

#### `name -> String`

The entity name (read-only property).


---

## OptOutSetting

```kotlin
val optOutSetting = client.optOutSetting(null)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `brand` | `String?` | No |  |

### Operations

#### `load(reqmatch, ctrl) -> Any?`

Load a single entity matching the given criteria. Returns the entity, whose record `data()` reads, and raises on error.

```kotlin
val result = client.optOutSetting(null).load(null, null)
```

#### `update(reqdata, ctrl) -> Any?`

Update an existing entity. The data must include the entity `id`. Returns the updated entity and raises on error.

```kotlin
val result = client.optOutSetting(null).update(mutableMapOf<String, Any?>(
), null)
```

### Common Methods

#### `data(vararg newdata) -> Any?`

Get or set the entity data.

#### `match(vararg newmatch) -> Any?`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `OptOutSetting` entity instance with the same options.

#### `name -> String`

The entity name (read-only property).


---

## Permission

```kotlin
val permission = client.permission(null)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `group_id` | `String?` | Yes | Object ID |
| `id` | `String?` | No |  |
| `read` | `Boolean?` | Yes | Has read permission |
| `send` | `Boolean?` | Yes | Has send permission |
| `username` | `String?` | Yes |  |
| `write` | `Boolean?` | Yes | Has write permission |

### Operations

#### `create(reqdata, ctrl) -> Any?`

Create a new entity with the given data. Returns the created entity and raises on error.

```kotlin
val result = client.permission(null).create(mutableMapOf<String, Any?>(
    "group_id" to "example_group_id",  // String?
    "read" to true,  // Boolean?
    "send" to true,  // Boolean?
    "username" to "example_username",  // String?
    "write" to true  // Boolean?
), null)
```

Declares a `application/x-www-form-urlencoded` body, which this SDK does not encode yet: it sends the data as JSON.

#### `load(reqmatch, ctrl) -> Any?`

Load a single entity matching the given criteria. Returns the entity, whose record `data()` reads, and raises on error.

```kotlin
val result = client.permission(null).load(mutableMapOf<String, Any?>("id" to "permission_id", "group_id" to "group_id"), null)
```

### Common Methods

#### `data(vararg newdata) -> Any?`

Get or set the entity data.

#### `match(vararg newmatch) -> Any?`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Permission` entity instance with the same options.

#### `name -> String`

The entity name (read-only property).


---

## Ping

```kotlin
val ping = client.ping(null)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `authorized` | `Boolean?` | Yes |  |
| `unavailable` | `List<Any?>?` | Yes |  |

### Operations

#### `list(reqmatch, ctrl) -> Any?`

List entities matching the given criteria. The match is optional — call `list(null, null)` to list all records. Returns a list of entities, one per record, and raises on error.

```kotlin
val results = client.ping(null).list(null, null) as List<*>
for (item in results) {
    println((item as SdkEntity).data())
}
```

### Common Methods

#### `data(vararg newdata) -> Any?`

Get or set the entity data.

#### `match(vararg newmatch) -> Any?`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Ping` entity instance with the same options.

#### `name -> String`

The entity name (read-only property).


---

## Profile

```kotlin
val profile = client.profile(null)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `email` | `String?` | Yes |  |
| `name` | `String?` | Yes |  |
| `payment_type` | `String?` | Yes |  |
| `phone_number` | `Long?` | Yes |  |
| `points` | `Double?` | No |  |
| `user_type` | `String?` | Yes |  |
| `username` | `String?` | Yes |  |

### Operations

#### `list(reqmatch, ctrl) -> Any?`

List entities matching the given criteria. The match is optional — call `list(null, null)` to list all records. Returns a list of entities, one per record, and raises on error.

```kotlin
val results = client.profile(null).list(null, null) as List<*>
for (item in results) {
    println((item as SdkEntity).data())
}
```

#### `load(reqmatch, ctrl) -> Any?`

Load a single entity matching the given criteria. Returns the entity, whose record `data()` reads, and raises on error.

```kotlin
val result = client.profile(null).load(null, null)
```

### Common Methods

#### `data(vararg newdata) -> Any?`

Get or set the entity data.

#### `match(vararg newmatch) -> Any?`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Profile` entity instance with the same options.

#### `name -> String`

The entity name (read-only property).


---

## Rcs

```kotlin
val rcs = client.rcs(null)
```

### Operations

#### `list(reqmatch, ctrl) -> Any?`

List entities matching the given criteria. The match is optional — call `list(null, null)` to list all records. Returns a list of entities, one per record, and raises on error.

```kotlin
val results = client.rcs(null).list(null, null) as List<*>
for (item in results) {
    println((item as SdkEntity).data())
}
```

### Common Methods

#### `data(vararg newdata) -> Any?`

Get or set the entity data.

#### `match(vararg newmatch) -> Any?`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Rcs` entity instance with the same options.

#### `name -> String`

The entity name (read-only property).


---

## Sendername

```kotlin
val sendername = client.sendername(null)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `created_at` | `String?` | No |  |
| `id` | `String?` | No |  |
| `is_default` | `Boolean?` | No |  |
| `sender` | `String?` | No | Sendername |
| `status` | `String?` | No |  |

### Operations

#### `create(reqdata, ctrl) -> Any?`

Create a new entity with the given data. Returns the created entity and raises on error.

```kotlin
val result = client.sendername(null).create(mutableMapOf<String, Any?>(
), null)
```

Declares a `application/x-www-form-urlencoded` body, which this SDK does not encode yet: it sends the data as JSON.

#### `list(reqmatch, ctrl) -> Any?`

List entities matching the given criteria. The match is optional — call `list(null, null)` to list all records. Returns a list of entities, one per record, and raises on error.

```kotlin
val results = client.sendername(null).list(null, null) as List<*>
for (item in results) {
    println((item as SdkEntity).data())
}
```

#### `load(reqmatch, ctrl) -> Any?`

Load a single entity matching the given criteria. Returns the entity, whose record `data()` reads, and raises on error.

```kotlin
val result = client.sendername(null).load(mutableMapOf<String, Any?>("id" to "sendername_id"), null)
```

### Common Methods

#### `data(vararg newdata) -> Any?`

Get or set the entity data.

#### `match(vararg newmatch) -> Any?`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Sendername` entity instance with the same options.

#### `name -> String`

The entity name (read-only property).


---

## SendernameStatement

```kotlin
val sendernameStatement = client.sendernameStatement(null)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `content` | `String?` | No |  |
| `statements` | `List<Any?>?` | No |  |
| `title` | `String?` | No |  |

### Operations

#### `list(reqmatch, ctrl) -> Any?`

List entities matching the given criteria. The match is optional — call `list(null, null)` to list all records. Returns a list of entities, one per record, and raises on error.

```kotlin
val results = client.sendernameStatement(null).list(null, null) as List<*>
for (item in results) {
    println((item as SdkEntity).data())
}
```

### Common Methods

#### `data(vararg newdata) -> Any?`

Get or set the entity data.

#### `match(vararg newmatch) -> Any?`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `SendernameStatement` entity instance with the same options.

#### `name -> String`

The entity name (read-only property).


---

## SentRcsMessage

```kotlin
val sentRcsMessage = client.sentRcsMessage(null)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `content` | `Map<String, Any?>?` | No | RCS message content in RCS JSON format. |
| `phone_number` | `String?` | Yes | Recipient phone number (e.g. |
| `sender` | `String?` | Yes | RCS sender ID (object ID of the agent/sender the user has access to). |
| `text` | `String?` | No | Plain text message content. |

### Operations

#### `create(reqdata, ctrl) -> Any?`

Create a new entity with the given data. Returns the created entity and raises on error.

```kotlin
val result = client.sentRcsMessage(null).create(mutableMapOf<String, Any?>(
    "phone_number" to "example_phone_number",  // String?
    "sender" to "example_sender"  // String?
), null)
```

### Common Methods

#### `data(vararg newdata) -> Any?`

Get or set the entity data.

#### `match(vararg newmatch) -> Any?`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `SentRcsMessage` entity instance with the same options.

#### `name -> String`

The entity name (read-only property).


---

## ShipmentCountryVolume

```kotlin
val shipmentCountryVolume = client.shipmentCountryVolume(null)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `country_code` | `String?` | No |  |
| `country_limit` | `Long?` | No |  |
| `country_name` | `String?` | No |  |
| `usage` | `Long?` | No |  |

### Operations

#### `list(reqmatch, ctrl) -> Any?`

List entities matching the given criteria. The match is optional — call `list(null, null)` to list all records. Returns a list of entities, one per record, and raises on error.

```kotlin
val results = client.shipmentCountryVolume(null).list(null, null) as List<*>
for (item in results) {
    println((item as SdkEntity).data())
}
```

### Common Methods

#### `data(vararg newdata) -> Any?`

Get or set the entity data.

#### `match(vararg newmatch) -> Any?`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `ShipmentCountryVolume` entity instance with the same options.

#### `name -> String`

The entity name (read-only property).


---

## ShortUrl

```kotlin
val shortUrl = client.shortUrl(null)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `description` | `String?` | No |  |
| `expire` | `String?` | No |  |
| `filename` | `String?` | No |  |
| `hits` | `Long?` | No |  |
| `hits_unique` | `Long?` | No |  |
| `id` | `String?` | No |  |
| `name` | `String?` | No |  |
| `short_url` | `String?` | No | WHATWG URL compliant |
| `type` | `String?` | No |  |
| `url` | `String?` | No | WHATWG URL compliant |

### Operations

#### `create(reqdata, ctrl) -> Any?`

Create a new entity with the given data. Returns the created entity and raises on error.

```kotlin
val result = client.shortUrl(null).create(mutableMapOf<String, Any?>(
), null)
```

#### `list(reqmatch, ctrl) -> Any?`

List entities matching the given criteria. The match is optional — call `list(null, null)` to list all records. Returns a list of entities, one per record, and raises on error.

```kotlin
val results = client.shortUrl(null).list(null, null) as List<*>
for (item in results) {
    println((item as SdkEntity).data())
}
```

#### `load(reqmatch, ctrl) -> Any?`

Load a single entity matching the given criteria. Returns the entity, whose record `data()` reads, and raises on error.

```kotlin
val result = client.shortUrl(null).load(mutableMapOf<String, Any?>("id" to "short_url_id"), null)
```

#### `remove(reqmatch, ctrl) -> Any?`

Remove the entity matching the given criteria. Returns the entity, marked as deleted, and raises on error.

```kotlin
val result = client.shortUrl(null).remove(mutableMapOf<String, Any?>("id" to "short_url_id"), null)
```

#### `update(reqdata, ctrl) -> Any?`

Update an existing entity. The data must include the entity `id`. Returns the updated entity and raises on error.

```kotlin
val result = client.shortUrl(null).update(mutableMapOf<String, Any?>(
    "id" to "short_url_id"
), null)
```

Declares a `application/x-www-form-urlencoded` body, which this SDK does not encode yet: it sends the data as JSON.

### Common Methods

#### `data(vararg newdata) -> Any?`

Get or set the entity data.

#### `match(vararg newmatch) -> Any?`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `ShortUrl` entity instance with the same options.

#### `name -> String`

The entity name (read-only property).


---

## Smsdo

```kotlin
val smsdo = client.smsdo(null)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `allow_duplicates` | `Long?` | No | When parameter allow_duplicates is set to "1" allows to send message to duplicated numbers in one request (useful i.e. |
| `check_idx` | `Any?` | No | When parameter check_idx is set to „1” prevents from sending more than one message with the same idx in last 24h. |
| `date` | `Any?` | No | Date in UNIX timestamp (&date=1287734110) or in ISO 8601 (&date=2012-05-10T08:40:27+00:00) when message will be sent (&date=1287734110). |
| `date_validate` | `Long?` | No | When parameter date_validate is set to "1" checks if date if given in proper format. |
| `details` | `Any?` | No | When details parameter is set to "1" more details in response will be displayed (message length and sms count). |
| `encoding` | `String?` | No | This parameter describes the encoding of the message text. |
| `expiration_date` | `Any?` | No | Message expiration date (in UNIX timestamp or in ISO 8601) is a date after which message won't be delivered if it wasn't delivered yet. |
| `fallback` | `List<Any?>?` | No | Enable fallback in case sms sending fails |
| `fast` | `Long?` | No | Setting this parameter to „1” will result in sending message with the highest priority which ensures the quickest possible time of delivery. |
| `flash` | `Long?` | No | Sending a message in flash mode can be activated by setting this parameter to "1". |
| `format` | `String?` | No | Parameter &format=json causes, that response is sending in JSON format. |
| `from` | `String?` | No | Name of the sender. |
| `group` | `String?` | No | Name of the group from the contacts database to which message should be sent to. |
| `idx` | `String?` | No | Optional custom value sent with SMS and sent back in CALLBACK. |
| `max_parts` | `Long?` | No | Defines maximum message parts allowed, maximum value allowed is 6. |
| `message` | `String?` | No | The message text. |
| `normalize` | `Long?` | No | When parameter normalize is set to „1” special chars in message will be replaced with their equivalents (ê-e, ñ-n, ý-y ...). |
| `notify_url` | `String?` | No | Parameter allows to set CALLBACK URL for message from request. |
| `test` | `Any?` | No | When parameter test is set to "1" message won't be sent but response will be displayed, there is no charge for such test messages. |
| `time_restriction` | `String?` | No | Sets the behavior when you try to ship in hours / dates that do not match the settings in your account. |
| `to` | `String?` | No | Recipients' mobile phone numbers (i.e. |

### Operations

#### `create(reqdata, ctrl) -> Any?`

Create a new entity with the given data. Returns the created entity and raises on error.

```kotlin
val result = client.smsdo(null).create(mutableMapOf<String, Any?>(
), null)
```

### Common Methods

#### `data(vararg newdata) -> Any?`

Get or set the entity data.

#### `match(vararg newmatch) -> Any?`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Smsdo` entity instance with the same options.

#### `name -> String`

The entity name (read-only property).


---

## Smssendername

```kotlin
val smssendername = client.smssendername(null)
```

### Operations

#### `create(reqdata, ctrl) -> Any?`

Create a new entity with the given data. Returns the created entity and raises on error.

```kotlin
val result = client.smssendername(null).create(mutableMapOf<String, Any?>(
    "sender" to "example_sender"  // String?
), null)
```

#### `remove(reqmatch, ctrl) -> Any?`

Remove the entity matching the given criteria. Returns the entity, marked as deleted, and raises on error.

```kotlin
val result = client.smssendername(null).remove(mutableMapOf<String, Any?>("sender" to "sender"), null)
```

### Common Methods

#### `data(vararg newdata) -> Any?`

Get or set the entity data.

#### `match(vararg newmatch) -> Any?`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Smssendername` entity instance with the same options.

#### `name -> String`

The entity name (read-only property).


---

## Smstemplate

```kotlin
val smstemplate = client.smstemplate(null)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | `String?` | No |  |

### Operations

#### `remove(reqmatch, ctrl) -> Any?`

Remove the entity matching the given criteria. Returns the entity, marked as deleted, and raises on error.

```kotlin
val result = client.smstemplate(null).remove(mutableMapOf<String, Any?>("id" to "id"), null)
```

### Common Methods

#### `data(vararg newdata) -> Any?`

Get or set the entity data.

#### `match(vararg newmatch) -> Any?`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Smstemplate` entity instance with the same options.

#### `name -> String`

The entity name (read-only property).


---

## Subuser

```kotlin
val subuser = client.subuser(null)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `active` | `Boolean?` | No |  |
| `credentials` | `Map<String, Any?>?` | Yes |  |
| `description` | `String?` | No |  |
| `id` | `String?` | No | Object ID |
| `points` | `Map<String, Any?>?` | No |  |
| `username` | `String?` | No |  |

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

#### `create(reqdata, ctrl) -> Any?`

Create a new entity with the given data. Returns the created entity and raises on error.

```kotlin
val result = client.subuser(null).create(mutableMapOf<String, Any?>(
    "credentials" to mapOf<String, Any?>()  // Map<String, Any?>?
), null)
```

#### `list(reqmatch, ctrl) -> Any?`

List entities matching the given criteria. The match is optional — call `list(null, null)` to list all records. Returns a list of entities, one per record, and raises on error.

```kotlin
val results = client.subuser(null).list(null, null) as List<*>
for (item in results) {
    println((item as SdkEntity).data())
}
```

#### `load(reqmatch, ctrl) -> Any?`

Load a single entity matching the given criteria. Returns the entity, whose record `data()` reads, and raises on error.

```kotlin
val result = client.subuser(null).load(mutableMapOf<String, Any?>("id" to "subuser_id"), null)
```

#### `remove(reqmatch, ctrl) -> Any?`

Remove the entity matching the given criteria. Returns the entity, marked as deleted, and raises on error.

```kotlin
val result = client.subuser(null).remove(mutableMapOf<String, Any?>("id" to "subuser_id"), null)
```

#### `update(reqdata, ctrl) -> Any?`

Update an existing entity. The data must include the entity `id`. Returns the updated entity and raises on error.

```kotlin
val result = client.subuser(null).update(mutableMapOf<String, Any?>(
    "id" to "subuser_id"
), null)
```

### Common Methods

#### `data(vararg newdata) -> Any?`

Get or set the entity data.

#### `match(vararg newmatch) -> Any?`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Subuser` entity instance with the same options.

#### `name -> String`

The entity name (read-only property).


---

## Template

```kotlin
val template = client.template(null)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | `String?` | No |  |
| `name` | `String?` | No |  |
| `normalize` | `Boolean?` | No |  |
| `template` | `String?` | No |  |

### Operations

#### `create(reqdata, ctrl) -> Any?`

Create a new entity with the given data. Returns the created entity and raises on error.

```kotlin
val result = client.template(null).create(mutableMapOf<String, Any?>(
), null)
```

Declares a `application/x-www-form-urlencoded` body, which this SDK does not encode yet: it sends the data as JSON.

#### `list(reqmatch, ctrl) -> Any?`

List entities matching the given criteria. The match is optional — call `list(null, null)` to list all records. Returns a list of entities, one per record, and raises on error.

```kotlin
val results = client.template(null).list(null, null) as List<*>
for (item in results) {
    println((item as SdkEntity).data())
}
```

#### `load(reqmatch, ctrl) -> Any?`

Load a single entity matching the given criteria. Returns the entity, whose record `data()` reads, and raises on error.

```kotlin
val result = client.template(null).load(mutableMapOf<String, Any?>("id" to "template_id"), null)
```

#### `update(reqdata, ctrl) -> Any?`

Update an existing entity. The data must include the entity `id`. Returns the updated entity and raises on error.

```kotlin
val result = client.template(null).update(mutableMapOf<String, Any?>(
    "id" to "template_id"
), null)
```

Declares a `application/x-www-form-urlencoded` body, which this SDK does not encode yet: it sends the data as JSON.

### Common Methods

#### `data(vararg newdata) -> Any?`

Get or set the entity data.

#### `match(vararg newmatch) -> Any?`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Template` entity instance with the same options.

#### `name -> String`

The entity name (read-only property).


---

## UserRcsSenderCollection

```kotlin
val userRcsSenderCollection = client.userRcsSenderCollection(null)
```

### Operations

#### `list(reqmatch, ctrl) -> Any?`

List entities matching the given criteria. The match is optional — call `list(null, null)` to list all records. Returns a list of entities, one per record, and raises on error.

```kotlin
val results = client.userRcsSenderCollection(null).list(null, null) as List<*>
for (item in results) {
    println((item as SdkEntity).data())
}
```

### Common Methods

#### `data(vararg newdata) -> Any?`

Get or set the entity data.

#### `match(vararg newmatch) -> Any?`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `UserRcsSenderCollection` entity instance with the same options.

#### `name -> String`

The entity name (read-only property).


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

```kotlin
val feature = mutableMapOf<String, Any?>(
    "audit" to mapOf("active" to true),
    "cache" to mapOf("active" to true),
    "clienttrack" to mapOf("active" to true),
    "cost" to mapOf("active" to true),
    "debug" to mapOf("active" to true),
    "idempotency" to mapOf("active" to true),
    "log" to mapOf("active" to true),
    "metrics" to mapOf("active" to true),
    "netsim" to mapOf("active" to true),
    "paging" to mapOf("active" to true),
    "proxy" to mapOf("active" to true),
    "ratelimit" to mapOf("active" to true),
    "rbac" to mapOf("active" to true),
    "retry" to mapOf("active" to true),
    "secrets" to mapOf("active" to true),
    "streaming" to mapOf("active" to true),
    "telemetry" to mapOf("active" to true),
    "test" to mapOf("active" to true),
    "timeout" to mapOf("active" to true),
    "validate" to mapOf("active" to true),
)
val client = SmsapiSDK(mutableMapOf<String, Any?>("feature" to feature))
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
| `now` | function |
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

