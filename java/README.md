# Smsapi Java SDK

An MCP server and CLI for the SMSAPI REST API, plus clients in 20 languages and a pandas data layer, generated from SMSAPI's public OpenAPI spec so AI agents can reach SMSAPI the way the official SDKs already let developers.

The Java SDK for the Smsapi API — an entity-oriented client following idiomatic Java conventions.

The SDK exposes the API as capitalised, semantic **Entities** — for example `client.available(null)` — each
carrying a small, uniform set of operations (`list`, `load`, `create`, `update`, `remove`) instead of raw URL
paths and query strings. You work with named resources and verbs, which
keeps the cognitive load low.

> Other languages, the CLI, and MCP server live alongside this one — see
> the [top-level README](../README.md).


## Install
This package is not yet published to Maven Central. Install it from the GitHub
release tag (`java/vX.Y.Z`, see [Releases](https://github.com/voxgig-sdk/smsapi-sdk/releases)) or
from a source checkout — build the library with Maven:

```bash
cd java && mvn install
```


## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record.

### 1. Create a client

```java
import voxgig.smsapisdk.core.SmsapiSDK;

Map<String, Object> options = new java.util.LinkedHashMap<>();
options.put("apikey", System.getenv("SMSAPI_APIKEY"));
SmsapiSDK client = new SmsapiSDK(options);
```

### 2. List available records

`list(null, null)` returns an aggregate list of records (as `Object`, an
aggregate list) and raises on error.

```java
try {
    Object availableList = client.available(null).list(null, null);
    System.out.println(availableList);
}
catch (RuntimeException err) {
    System.out.println("list failed: " + err.getMessage());
}
```

### 3. Load a permission

Permission is nested under group, so provide the `group_id`.
`load()` returns the ENTITY — call data() for the record — and raises on error.

```java
try {
    Object permission = client.permission(null).load(Map.of("group_id", "example_group_id", "username", "example_username", "id", "example_id"), null);
    System.out.println(permission);
}
catch (RuntimeException err) {
    System.out.println("load failed: " + err.getMessage());
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

```java
Map<String, Object> result = client.direct(Map.of(
    "path", "/api/resource/{id}",
    "method", "GET",
    "params", Map.of("id", "example")));

if (Boolean.TRUE.equals(result.get("ok"))) {
    System.out.println(result.get("status"));  // 200
    System.out.println(result.get("data"));    // response body
}
else {
    // A non-2xx response carries status + data (the error body); a
    // transport-level failure carries err instead. Only one is present, so
    // read both — an absent key simply reads as null.
    System.out.println(result.get("status") + " " + result.get("err"));
}
```

### Prepare a request without sending it

```java
// prepare() returns the fetch definition and raises on error.
Map<String, Object> fetchdef = client.prepare(Map.of(
    "path", "/api/resource/{id}",
    "method", "DELETE",
    "params", Map.of("id", "example")));

System.out.println(fetchdef.get("url"));
System.out.println(fetchdef.get("method"));
System.out.println(fetchdef.get("headers"));
```

### Use test mode

Create a mock client for unit testing — no server required:

```java
SmsapiSDK client = SmsapiSDK.testSDK(null, null);

// Entity ops return the ENTITY and raises on error;
// call data() for the record.
Object permission = client.permission(null).load(Map.of("id", "test01"), null);
// permission holds the mock response record
System.out.println(permission);
```

### Use a custom fetch function

Replace the HTTP transport with your own `BiFunction`:

```java
java.util.function.BiFunction<String, Map<String, Object>, Object> mockFetch =
    (url, init) -> {
        Map<String, Object> res = new java.util.LinkedHashMap<>();
        res.put("status", 200);
        res.put("statusText", "OK");
        res.put("headers", new java.util.LinkedHashMap<String, Object>());
        res.put("json", (java.util.function.Supplier<Object>) () ->
            Map.of("id", "mock01"));
        return res;
    };

Map<String, Object> options = new java.util.LinkedHashMap<>();
options.put("base", "http://localhost:8080");
options.put("system", Map.of("fetch", mockFetch));
SmsapiSDK client = new SmsapiSDK(options);
```

### Run live tests

Create a `.env.local` file at the project root:

```
SMSAPI_TEST_LIVE=TRUE
SMSAPI_APIKEY=<your-key>
```

Then run:

```bash
cd java && mvn test
```


## Reference

### SmsapiSDK

```java
SmsapiSDK client = new SmsapiSDK(options);
```

Creates a new SDK client. `options` is a `Map<String, Object>`.

| Option | Type | Description |
| --- | --- | --- |
| `apikey` | `String` | API key for authentication. |
| `base` | `String` | Base URL of the API server. |
| `prefix` | `String` | URL path prefix prepended to all requests. |
| `suffix` | `String` | URL path suffix appended to all requests. |
| `feature` | `Map` | Feature activation flags. |
| `extend` | `List` | Additional Feature instances to load. |
| `system` | `Map` | System overrides (e.g. custom `fetch` function). |

### testSDK

```java
SmsapiSDK client = SmsapiSDK.testSDK(testopts, sdkopts);
```

Creates a test-mode client with mock transport. Both arguments may be `null`.

### SmsapiSDK methods

| Method | Signature | Description |
| --- | --- | --- |
| `optionsMap` | `() -> Map` | Deep copy of current SDK options. |
| `getUtility` | `() -> Utility` | Copy of the SDK utility object. |
| `prepare` | `(fetchargs) -> Map` | Build an HTTP request definition without sending. Raises on error. |
| `direct` | `(fetchargs) -> Map` | Build and send an HTTP request. Returns a result map (branch on `ok`). |
| `available` | `(entopts) -> SdkEntity` | Create an Available entity instance. |
| `blacklist` | `(entopts) -> SdkEntity` | Create a Blacklist entity instance. |
| `callback` | `(entopts) -> SdkEntity` | Create a Callback entity instance. |
| `contact` | `(entopts) -> SdkEntity` | Create a Contact entity instance. |
| `contactsField` | `(entopts) -> SdkEntity` | Create a ContactsField entity instance. |
| `contactsFieldOption` | `(entopts) -> SdkEntity` | Create a ContactsFieldOption entity instance. |
| `contactsgroup` | `(entopts) -> SdkEntity` | Create a Contactsgroup entity instance. |
| `contactstrash` | `(entopts) -> SdkEntity` | Create a Contactstrash entity instance. |
| `fieldAvailable` | `(entopts) -> SdkEntity` | Create a FieldAvailable entity instance. |
| `group` | `(entopts) -> SdkEntity` | Create a Group entity instance. |
| `mfaCode` | `(entopts) -> SdkEntity` | Create a MfaCode entity instance. |
| `optOut` | `(entopts) -> SdkEntity` | Create an OptOut entity instance. |
| `optOutSetting` | `(entopts) -> SdkEntity` | Create an OptOutSetting entity instance. |
| `permission` | `(entopts) -> SdkEntity` | Create a Permission entity instance. |
| `ping` | `(entopts) -> SdkEntity` | Create a Ping entity instance. |
| `profile` | `(entopts) -> SdkEntity` | Create a Profile entity instance. |
| `rcs` | `(entopts) -> SdkEntity` | Create a Rcs entity instance. |
| `sendername` | `(entopts) -> SdkEntity` | Create a Sendername entity instance. |
| `sendernameStatement` | `(entopts) -> SdkEntity` | Create a SendernameStatement entity instance. |
| `sentRcsMessage` | `(entopts) -> SdkEntity` | Create a SentRcsMessage entity instance. |
| `shipmentCountryVolume` | `(entopts) -> SdkEntity` | Create a ShipmentCountryVolume entity instance. |
| `shortUrl` | `(entopts) -> SdkEntity` | Create a ShortUrl entity instance. |
| `smsdo` | `(entopts) -> SdkEntity` | Create a Smsdo entity instance. |
| `smssendername` | `(entopts) -> SdkEntity` | Create a Smssendername entity instance. |
| `smstemplate` | `(entopts) -> SdkEntity` | Create a Smstemplate entity instance. |
| `subuser` | `(entopts) -> SdkEntity` | Create a Subuser entity instance. |
| `template` | `(entopts) -> SdkEntity` | Create a Template entity instance. |
| `userRcsSenderCollection` | `(entopts) -> SdkEntity` | Create an UserRcsSenderCollection entity instance. |

### Entity interface

All entities share the same interface.

| Method | Signature | Description |
| --- | --- | --- |
| `load` | `(reqmatch, ctrl) -> Object` | Load a single entity by match criteria. Raises on error. |
| `list` | `(reqmatch, ctrl) -> Object` | List entities matching the criteria (an aggregate list). Raises on error. |
| `create` | `(reqdata, ctrl) -> Object` | Create a new entity. Raises on error. |
| `update` | `(reqdata, ctrl) -> Object` | Update an existing entity. Raises on error. |
| `remove` | `(reqmatch, ctrl) -> Object` | Remove an entity. Raises on error. |
| `data` | `(newdata...) -> Object` | Get or set entity data. |
| `match` | `(newmatch...) -> Object` | Get or set entity match criteria. |
| `make` | `() -> Entity` | Create a new instance with the same options. |
| `getName` | `() -> String` | Return the entity name. |

### Result shape

Entity operations return the ENTITY (call data() for the record) (a `Map` for single-entity
ops, an aggregate `List` for `list`) as `Object` and raise on error. Wrap
calls in `try`/`catch` to handle failures.

The `direct()` escape hatch never raises — it returns a result
`Map<String, Object>` you branch on via `result.get("ok")`:

| Key | Type | Description |
| --- | --- | --- |
| `ok` | `Boolean` | `true` if the HTTP status is 2xx. |
| `status` | `int` | HTTP status code. |
| `headers` | `Map` | Response headers. |
| `data` | `Object` | Parsed JSON response body. |

On error, `ok` is `false` and `err` contains the error value.

### Entities

#### Available

| Field | Description |
| --- | --- |
| `name` |  |
| `normalize` |  |
| `template` |  |

Operations: list.

API path: `/sms/templates/available`

#### Blacklist

| Field | Description |
| --- | --- |
| `id` |  |

Operations: create, load, remove.

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

Operations: create, list, load, remove, update.

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

Operations: create, list, load, remove, update.

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

Operations: create, list, remove, update.

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

Operations: list.

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

Operations: create, list, remove, update.

API path: `/contacts/groups/{groupId}/members`

#### Contactstrash

| Field | Description |
| --- | --- |

Operations: remove, update.

API path: `/contacts/trash`

#### FieldAvailable

| Field | Description |
| --- | --- |
| `built_in` |  |
| `id` | Object ID |
| `name` |  |
| `options` |  |
| `type` |  |

Operations: list.

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

Operations: load, update.

API path: `/contacts/groups/{groupId}`

#### MfaCode

| Field | Description |
| --- | --- |
| `content` | Custom content that must contain placeholder [%code%] |
| `fast` |  |
| `from` | Sendername |
| `phone_number` |  |

Operations: create.

API path: `/mfa/codes`

#### OptOut

| Field | Description |
| --- | --- |
| `date` |  |
| `id` |  |
| `links` |  |
| `phoneNumber` |  |

Operations: list, remove.

API path: `/opt_outs`

#### OptOutSetting

| Field | Description |
| --- | --- |
| `brand` |  |

Operations: load, update.

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

Operations: create, load.

API path: `/contacts/groups/{groupId}/permissions`

#### Ping

| Field | Description |
| --- | --- |
| `authorized` |  |
| `unavailable` |  |

Operations: list.

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

Operations: list, load.

API path: `/profile/prices`

#### Rcs

| Field | Description |
| --- | --- |

Operations: list.

API path: `/rcs/messages`

#### Sendername

| Field | Description |
| --- | --- |
| `created_at` |  |
| `id` |  |
| `is_default` |  |
| `sender` | Sendername |
| `status` |  |

Operations: create, list, load.

API path: `/sms/sendernames`

#### SendernameStatement

| Field | Description |
| --- | --- |
| `content` |  |
| `statements` |  |
| `title` |  |

Operations: list.

API path: `/sms/sendernames/statement`

#### SentRcsMessage

| Field | Description |
| --- | --- |
| `content` | RCS message content in RCS JSON format. |
| `phone_number` | Recipient phone number (e.g. |
| `sender` |  |
| `text` | Plain text message content. |

Operations: create.

API path: `/rcs/messages`

#### ShipmentCountryVolume

| Field | Description |
| --- | --- |
| `country_code` |  |
| `country_limit` |  |
| `country_name` |  |
| `usage` |  |

Operations: list.

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

Operations: create, list, load, remove, update.

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

Operations: create.

API path: `/sms.do`

#### Smssendername

| Field | Description |
| --- | --- |

Operations: create, remove.

API path: `/sms/sendernames/{sender}/commands/make_default`

#### Smstemplate

| Field | Description |
| --- | --- |
| `id` |  |

Operations: remove.

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

Operations: create, list, load, remove, update.

API path: `/subusers`

#### Template

| Field | Description |
| --- | --- |
| `id` |  |
| `name` |  |
| `normalize` |  |
| `template` |  |

Operations: create, list, load, update.

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

Operations: list.

API path: `/rcs/senders`



## Entities


### Available

Create an instance: `SdkEntity available = client.available(null);`

#### Operations

| Method | Description |
| --- | --- |
| `list(null, null)` | List entities, optionally matching the given criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `name` | `String` |  |
| `normalize` | `Boolean` |  |
| `template` | `String` |  |

#### Example: List

```java
Object availableList = client.available(null).list(null, null);
```


### Blacklist

Create an instance: `SdkEntity blacklist = client.blacklist(null);`

#### Operations

| Method | Description |
| --- | --- |
| `create(data, null)` | Create a new entity with the given data. |
| `load(match, null)` | Load a single entity by match criteria. |
| `remove(match, null)` | Remove the matching entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `id` | `String` |  |

#### Example: Load

```java
Object blacklist = client.blacklist(null).load(null, null);
```

#### Example: Create

```java
Object blacklist = client.blacklist(null).create(Map.of(
), null);
```


### Callback

Create an instance: `SdkEntity callback = client.callback(null);`

#### Operations

| Method | Description |
| --- | --- |
| `create(data, null)` | Create a new entity with the given data. |
| `list(null, null)` | List entities, optionally matching the given criteria. |
| `load(match, null)` | Load a single entity by match criteria. |
| `remove(match, null)` | Remove the matching entity. |
| `update(data, null)` | Update an existing entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `active` | `Boolean` |  |
| `api_version` | `Long` | Version of the callback output format. |
| `id` | `String` | Object ID |
| `invalid` | `Boolean` |  |
| `receiver` | `Map<String, Object>` |  |
| `receiver_type` | `String` |  |
| `type` | `String` |  |
| `url` | `String` | WHATWG URL compliant |

#### Example: Load

```java
Object callback = client.callback(null).load(Map.of("id", "callback_id"), null);
```

#### Example: List

```java
Object callbackList = client.callback(null).list(null, null);
```

#### Example: Create

```java
Object callback = client.callback(null).create(Map.of(
), null);
```


### Contact

Create an instance: `SdkEntity contact = client.contact(null);`

#### Operations

| Method | Description |
| --- | --- |
| `create(data, null)` | Create a new entity with the given data. |
| `list(null, null)` | List entities, optionally matching the given criteria. |
| `load(match, null)` | Load a single entity by match criteria. |
| `remove(match, null)` | Remove the matching entity. |
| `update(data, null)` | Update an existing entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `birthday_date` | `String` |  |
| `city` | `String` |  |
| `collection` | `List<Object>` |  |
| `contact_expire_after` | `Long` | Contact expire after days |
| `contacts_count` | `Long` |  |
| `country` | `String` |  |
| `created_by` | `String` |  |
| `date_created` | `String` |  |
| `date_updated` | `String` |  |
| `description` | `String` |  |
| `email` | `String` |  |
| `first_name` | `String` |  |
| `gender` | `String` |  |
| `group_id` | `String` | Object ID |
| `groups` | `List<Object>` |  |
| `id` | `String` | Object ID |
| `idx` | `String` | User provided resource id |
| `last_name` | `String` |  |
| `name` | `String` | Group name |
| `permissions` | `List<Object>` |  |
| `phone_number` | `String` |  |
| `read` | `Boolean` | Has read permission |
| `send` | `Boolean` | Has send permission |
| `size` | `Long` |  |
| `source` | `String` |  |
| `type` | `String` |  |
| `username` | `String` |  |
| `value` | `String` |  |
| `write` | `Boolean` | Has write permission |

#### Example: Load

```java
Object contact = client.contact(null).load(Map.of("id", "contact_id"), null);
```

#### Example: List

```java
Object contactList = client.contact(null).list(null, null);
```

#### Example: Create

```java
Object contact = client.contact(null).create(Map.of(
    "collection", List.of(),  // List<Object>
    "contact_expire_after", 1L,  // Long
    "contacts_count", 1L,  // Long
    "created_by", "example_created_by",  // String
    "date_created", "example_date_created",  // String
    "date_updated", "example_date_updated",  // String
    "gender", "example_gender",  // String
    "groups", List.of(),  // List<Object>
    "id", "example_id",  // String
    "name", "example_name",  // String
    "size", 1L  // Long
), null);
```


### ContactsField

Create an instance: `SdkEntity contactsField = client.contactsField(null);`

#### Operations

| Method | Description |
| --- | --- |
| `create(data, null)` | Create a new entity with the given data. |
| `list(null, null)` | List entities, optionally matching the given criteria. |
| `remove(match, null)` | Remove the matching entity. |
| `update(data, null)` | Update an existing entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `birthday_date` | `String` |  |
| `city` | `String` |  |
| `contact_expire_after` | `Long` | Contact expire after days |
| `contacts_count` | `Long` |  |
| `country` | `String` |  |
| `created_by` | `String` |  |
| `date_created` | `String` |  |
| `date_updated` | `String` |  |
| `description` | `String` |  |
| `email` | `String` |  |
| `first_name` | `String` |  |
| `gender` | `String` |  |
| `group_id` | `String` | Object ID |
| `groups` | `List<Object>` |  |
| `id` | `String` | Object ID |
| `idx` | `String` | User provided resource id |
| `last_name` | `String` |  |
| `name` | `String` | Group name |
| `permissions` | `List<Object>` |  |
| `phone_number` | `String` |  |
| `read` | `Boolean` | Has read permission |
| `send` | `Boolean` | Has send permission |
| `source` | `String` |  |
| `type` | `String` |  |
| `username` | `String` |  |
| `value` | `String` |  |
| `write` | `Boolean` | Has write permission |

#### Example: List

```java
Object contactsFieldList = client.contactsField(null).list(null, null);
```

#### Example: Create

```java
Object contactsField = client.contactsField(null).create(Map.of(
    "contact_expire_after", 1L,  // Long
    "created_by", "example_created_by",  // String
    "date_created", "example_date_created",  // String
    "date_updated", "example_date_updated",  // String
    "gender", "example_gender",  // String
    "groups", List.of()  // List<Object>
), null);
```


### ContactsFieldOption

Create an instance: `SdkEntity contactsFieldOption = client.contactsFieldOption(null);`

#### Operations

| Method | Description |
| --- | --- |
| `list(null, null)` | List entities, optionally matching the given criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `birthday_date` | `String` |  |
| `city` | `String` |  |
| `contact_expire_after` | `Long` | Contact expire after days |
| `contacts_count` | `Long` |  |
| `country` | `String` |  |
| `created_by` | `String` |  |
| `date_created` | `String` |  |
| `date_updated` | `String` |  |
| `description` | `String` |  |
| `email` | `String` |  |
| `first_name` | `String` |  |
| `gender` | `String` |  |
| `group_id` | `String` | Object ID |
| `groups` | `List<Object>` |  |
| `id` | `String` | Object ID |
| `idx` | `String` | User provided resource id |
| `last_name` | `String` |  |
| `name` | `String` | Group name |
| `permissions` | `List<Object>` |  |
| `phone_number` | `String` |  |
| `read` | `Boolean` | Has read permission |
| `send` | `Boolean` | Has send permission |
| `source` | `String` |  |
| `type` | `String` |  |
| `username` | `String` |  |
| `value` | `String` |  |
| `write` | `Boolean` | Has write permission |

#### Example: List

```java
Object contactsFieldOptionList = client.contactsFieldOption(null).list(null, null);
```


### Contactsgroup

Create an instance: `SdkEntity contactsgroup = client.contactsgroup(null);`

#### Operations

| Method | Description |
| --- | --- |
| `create(data, null)` | Create a new entity with the given data. |
| `list(null, null)` | List entities, optionally matching the given criteria. |
| `remove(match, null)` | Remove the matching entity. |
| `update(data, null)` | Update an existing entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `birthday_date` | `String` |  |
| `city` | `String` |  |
| `contact_expire_after` | `Long` | Contact expire after days |
| `contacts_count` | `Long` |  |
| `country` | `String` |  |
| `created_by` | `String` |  |
| `date_created` | `String` |  |
| `date_updated` | `String` |  |
| `description` | `String` |  |
| `email` | `String` |  |
| `first_name` | `String` |  |
| `gender` | `String` |  |
| `group_id` | `String` | Object ID |
| `groups` | `List<Object>` |  |
| `id` | `String` | Object ID |
| `idx` | `String` | User provided resource id |
| `last_name` | `String` |  |
| `name` | `String` | Group name |
| `permissions` | `List<Object>` |  |
| `phone_number` | `String` |  |
| `read` | `Boolean` | Has read permission |
| `send` | `Boolean` | Has send permission |
| `source` | `String` |  |
| `type` | `String` |  |
| `username` | `String` |  |
| `value` | `String` |  |
| `write` | `Boolean` | Has write permission |

#### Example: List

```java
Object contactsgroupList = client.contactsgroup(null).list(null, null);
```

#### Example: Create

```java
Object contactsgroup = client.contactsgroup(null).create(Map.of(
    "contact_expire_after", 1L,  // Long
    "created_by", "example_created_by",  // String
    "date_created", "example_date_created",  // String
    "date_updated", "example_date_updated",  // String
    "gender", "example_gender",  // String
    "group_id", "example_group_id",  // String
    "groups", List.of(),  // List<Object>
    "id", "example_id",  // String
    "read", true,  // Boolean
    "send", true,  // Boolean
    "username", "example_username",  // String
    "write", true  // Boolean
), null);
```


### Contactstrash

Create an instance: `SdkEntity contactstrash = client.contactstrash(null);`

#### Operations

| Method | Description |
| --- | --- |
| `remove(match, null)` | Remove the matching entity. |
| `update(data, null)` | Update an existing entity. |


### FieldAvailable

Create an instance: `SdkEntity fieldAvailable = client.fieldAvailable(null);`

#### Operations

| Method | Description |
| --- | --- |
| `list(null, null)` | List entities, optionally matching the given criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `built_in` | `Boolean` |  |
| `id` | `String` | Object ID |
| `name` | `String` |  |
| `options` | `List<Object>` |  |
| `type` | `String` |  |

#### Example: List

```java
Object fieldAvailableList = client.fieldAvailable(null).list(null, null);
```


### Group

Create an instance: `SdkEntity group = client.group(null);`

#### Operations

| Method | Description |
| --- | --- |
| `load(match, null)` | Load a single entity by match criteria. |
| `update(data, null)` | Update an existing entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `contact_expire_after` | `Long` | Contact expire after days |
| `contacts_count` | `Long` |  |
| `created_by` | `String` |  |
| `date_created` | `String` |  |
| `date_updated` | `String` |  |
| `description` | `String` |  |
| `id` | `String` | Object ID |
| `idx` | `String` | User provided resource id |
| `name` | `String` | Group name |
| `permissions` | `List<Object>` |  |

#### Example: Load

```java
Object group = client.group(null).load(Map.of("id", "group_id"), null);
```


### MfaCode

Create an instance: `SdkEntity mfaCode = client.mfaCode(null);`

#### Operations

| Method | Description |
| --- | --- |
| `create(data, null)` | Create a new entity with the given data. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `content` | `String` | Custom content that must contain placeholder [%code%] |
| `fast` | `Object` |  |
| `from` | `String` | Sendername |
| `phone_number` | `String` |  |

#### Example: Create

```java
Object mfaCode = client.mfaCode(null).create(Map.of(
    "phone_number", "example_phone_number"  // String
), null);
```


### OptOut

Create an instance: `SdkEntity optOut = client.optOut(null);`

#### Operations

| Method | Description |
| --- | --- |
| `list(null, null)` | List entities, optionally matching the given criteria. |
| `remove(match, null)` | Remove the matching entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `date` | `String` |  |
| `id` | `String` |  |
| `links` | `List<Object>` |  |
| `phoneNumber` | `Long` |  |

#### Example: List

```java
Object optOutList = client.optOut(null).list(null, null);
```


### OptOutSetting

Create an instance: `SdkEntity optOutSetting = client.optOutSetting(null);`

#### Operations

| Method | Description |
| --- | --- |
| `load(match, null)` | Load a single entity by match criteria. |
| `update(data, null)` | Update an existing entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `brand` | `String` |  |

#### Example: Load

```java
Object optOutSetting = client.optOutSetting(null).load(null, null);
```


### Permission

Create an instance: `SdkEntity permission = client.permission(null);`

#### Operations

| Method | Description |
| --- | --- |
| `create(data, null)` | Create a new entity with the given data. |
| `load(match, null)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `group_id` | `String` | Object ID |
| `id` | `String` |  |
| `read` | `Boolean` | Has read permission |
| `send` | `Boolean` | Has send permission |
| `username` | `String` |  |
| `write` | `Boolean` | Has write permission |

#### Example: Load

```java
Object permission = client.permission(null).load(Map.of("id", "permission_id", "group_id", "group_id", "username", "username"), null);
```

#### Example: Create

```java
Object permission = client.permission(null).create(Map.of(
    "group_id", "example_group_id",  // String
    "read", true,  // Boolean
    "send", true,  // Boolean
    "username", "example_username",  // String
    "write", true  // Boolean
), null);
```


### Ping

Create an instance: `SdkEntity ping = client.ping(null);`

#### Operations

| Method | Description |
| --- | --- |
| `list(null, null)` | List entities, optionally matching the given criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `authorized` | `Boolean` |  |
| `unavailable` | `List<Object>` |  |

#### Example: List

```java
Object pingList = client.ping(null).list(null, null);
```


### Profile

Create an instance: `SdkEntity profile = client.profile(null);`

#### Operations

| Method | Description |
| --- | --- |
| `list(null, null)` | List entities, optionally matching the given criteria. |
| `load(match, null)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `email` | `String` |  |
| `name` | `String` |  |
| `payment_type` | `String` |  |
| `phone_number` | `Long` |  |
| `points` | `Double` |  |
| `user_type` | `String` |  |
| `username` | `String` |  |

#### Example: Load

```java
Object profile = client.profile(null).load(null, null);
```

#### Example: List

```java
Object profileList = client.profile(null).list(null, null);
```


### Rcs

Create an instance: `SdkEntity rcs = client.rcs(null);`

#### Operations

| Method | Description |
| --- | --- |
| `list(null, null)` | List entities, optionally matching the given criteria. |

#### Example: List

```java
Object rcsList = client.rcs(null).list(null, null);
```


### Sendername

Create an instance: `SdkEntity sendername = client.sendername(null);`

#### Operations

| Method | Description |
| --- | --- |
| `create(data, null)` | Create a new entity with the given data. |
| `list(null, null)` | List entities, optionally matching the given criteria. |
| `load(match, null)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `created_at` | `String` |  |
| `id` | `String` |  |
| `is_default` | `Boolean` |  |
| `sender` | `String` | Sendername |
| `status` | `String` |  |

#### Example: Load

```java
Object sendername = client.sendername(null).load(Map.of("id", "sendername_id"), null);
```

#### Example: List

```java
Object sendernameList = client.sendername(null).list(null, null);
```

#### Example: Create

```java
Object sendername = client.sendername(null).create(Map.of(
), null);
```


### SendernameStatement

Create an instance: `SdkEntity sendernameStatement = client.sendernameStatement(null);`

#### Operations

| Method | Description |
| --- | --- |
| `list(null, null)` | List entities, optionally matching the given criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `content` | `String` |  |
| `statements` | `List<Object>` |  |
| `title` | `String` |  |

#### Example: List

```java
Object sendernameStatementList = client.sendernameStatement(null).list(null, null);
```


### SentRcsMessage

Create an instance: `SdkEntity sentRcsMessage = client.sentRcsMessage(null);`

#### Operations

| Method | Description |
| --- | --- |
| `create(data, null)` | Create a new entity with the given data. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `content` | `Map<String, Object>` | RCS message content in RCS JSON format. |
| `phone_number` | `String` | Recipient phone number (e.g. |
| `sender` | `Object` |  |
| `text` | `String` | Plain text message content. |

#### Example: Create

```java
Object sentRcsMessage = client.sentRcsMessage(null).create(Map.of(
    "phone_number", "example_phone_number",  // String
    "sender", "example_sender"  // Object
), null);
```


### ShipmentCountryVolume

Create an instance: `SdkEntity shipmentCountryVolume = client.shipmentCountryVolume(null);`

#### Operations

| Method | Description |
| --- | --- |
| `list(null, null)` | List entities, optionally matching the given criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `country_code` | `String` |  |
| `country_limit` | `Long` |  |
| `country_name` | `String` |  |
| `usage` | `Long` |  |

#### Example: List

```java
Object shipmentCountryVolumeList = client.shipmentCountryVolume(null).list(null, null);
```


### ShortUrl

Create an instance: `SdkEntity shortUrl = client.shortUrl(null);`

#### Operations

| Method | Description |
| --- | --- |
| `create(data, null)` | Create a new entity with the given data. |
| `list(null, null)` | List entities, optionally matching the given criteria. |
| `load(match, null)` | Load a single entity by match criteria. |
| `remove(match, null)` | Remove the matching entity. |
| `update(data, null)` | Update an existing entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `description` | `String` |  |
| `expire` | `String` |  |
| `filename` | `String` |  |
| `hits` | `Long` |  |
| `hits_unique` | `Long` |  |
| `id` | `String` |  |
| `name` | `String` |  |
| `short_url` | `String` | WHATWG URL compliant |
| `type` | `String` |  |
| `url` | `String` | WHATWG URL compliant |

#### Example: Load

```java
Object shortUrl = client.shortUrl(null).load(Map.of("id", "short_url_id"), null);
```

#### Example: List

```java
Object shortUrlList = client.shortUrl(null).list(null, null);
```

#### Example: Create

```java
Object shortUrl = client.shortUrl(null).create(Map.of(
), null);
```


### Smsdo

Create an instance: `SdkEntity smsdo = client.smsdo(null);`

#### Operations

| Method | Description |
| --- | --- |
| `create(data, null)` | Create a new entity with the given data. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `allow_duplicates` | `Long` | When parameter allow_duplicates is set to "1" allows to send message to duplicated numbers in one request (useful i.e. |
| `check_idx` | `Object` | When parameter check_idx is set to „1” prevents from sending more than one message with the same idx in last 24h. |
| `date` | `Object` | Date in UNIX timestamp (&date=1287734110) or in ISO 8601 (&date=2012-05-10T08:40:27+00:00) when message will be sent (&date=1287734110). |
| `date_validate` | `Long` | When parameter date_validate is set to "1" checks if date if given in proper format. |
| `details` | `Object` | When details parameter is set to "1" more details in response will be displayed (message length and sms count). |
| `encoding` | `String` | This parameter describes the encoding of the message text. |
| `expiration_date` | `Object` | Message expiration date (in UNIX timestamp or in ISO 8601) is a date after which message won't be delivered if it wasn't delivered yet. |
| `fallback` | `List<Object>` | Enable fallback in case sms sending fails |
| `fast` | `Long` | Setting this parameter to „1” will result in sending message with the highest priority which ensures the quickest possible time of delivery. |
| `flash` | `Long` | Sending a message in flash mode can be activated by setting this parameter to "1". |
| `format` | `String` | Parameter &format=json causes, that response is sending in JSON format. |
| `from` | `String` | Name of the sender. |
| `group` | `String` | Name of the group from the contacts database to which message should be sent to. |
| `idx` | `String` | Optional custom value sent with SMS and sent back in CALLBACK. |
| `max_parts` | `Long` | Defines maximum message parts allowed, maximum value allowed is 6. |
| `message` | `String` | The message text. |
| `normalize` | `Long` | When parameter normalize is set to „1” special chars in message will be replaced with their equivalents (ê-e, ñ-n, ý-y ...). |
| `notify_url` | `String` | Parameter allows to set CALLBACK URL for message from request. |
| `test` | `Object` | When parameter test is set to "1" message won't be sent but response will be displayed, there is no charge for such test messages. |
| `time_restriction` | `String` | Sets the behavior when you try to ship in hours / dates that do not match the settings in your account. |
| `to` | `String` | Recipients' mobile phone numbers (i.e. |

#### Example: Create

```java
Object smsdo = client.smsdo(null).create(Map.of(
), null);
```


### Smssendername

Create an instance: `SdkEntity smssendername = client.smssendername(null);`

#### Operations

| Method | Description |
| --- | --- |
| `create(data, null)` | Create a new entity with the given data. |
| `remove(match, null)` | Remove the matching entity. |

#### Example: Create

```java
Object smssendername = client.smssendername(null).create(Map.of(
    "sendername_id", "example_sendername_id"  // String
), null);
```


### Smstemplate

Create an instance: `SdkEntity smstemplate = client.smstemplate(null);`

#### Operations

| Method | Description |
| --- | --- |
| `remove(match, null)` | Remove the matching entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `id` | `String` |  |


### Subuser

Create an instance: `SdkEntity subuser = client.subuser(null);`

#### Operations

| Method | Description |
| --- | --- |
| `create(data, null)` | Create a new entity with the given data. |
| `list(null, null)` | List entities, optionally matching the given criteria. |
| `load(match, null)` | Load a single entity by match criteria. |
| `remove(match, null)` | Remove the matching entity. |
| `update(data, null)` | Update an existing entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `active` | `Boolean` |  |
| `credentials` | `Map<String, Object>` |  |
| `description` | `String` |  |
| `id` | `String` | Object ID |
| `points` | `Map<String, Object>` |  |
| `username` | `String` |  |

#### Example: Load

```java
Object subuser = client.subuser(null).load(Map.of("id", "subuser_id"), null);
```

#### Example: List

```java
Object subuserList = client.subuser(null).list(null, null);
```

#### Example: Create

```java
Object subuser = client.subuser(null).create(Map.of(
    "credentials", Map.of()  // Map<String, Object>
), null);
```


### Template

Create an instance: `SdkEntity template = client.template(null);`

#### Operations

| Method | Description |
| --- | --- |
| `create(data, null)` | Create a new entity with the given data. |
| `list(null, null)` | List entities, optionally matching the given criteria. |
| `load(match, null)` | Load a single entity by match criteria. |
| `update(data, null)` | Update an existing entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `id` | `String` |  |
| `name` | `String` |  |
| `normalize` | `Boolean` |  |
| `template` | `String` |  |

#### Example: Load

```java
Object template = client.template(null).load(Map.of("id", "template_id"), null);
```

#### Example: List

```java
Object templateList = client.template(null).list(null, null);
```

#### Example: Create

```java
Object template = client.template(null).create(Map.of(
), null);
```


### UserRcsSenderCollection

Create an instance: `SdkEntity userRcsSenderCollection = client.userRcsSenderCollection(null);`

#### Operations

| Method | Description |
| --- | --- |
| `list(null, null)` | List entities, optionally matching the given criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `deliveredAt` | `String` |  |
| `expiredAt` | `String` |  |
| `id` | `String` | Object ID |
| `interface` | `String` | Interface through which the message was sent (www, api, ...). |
| `messageType` | `String` | RCS message type (basic, single, ...). |
| `readAt` | `String` |  |
| `recipient` | `String` | Recipient phone number (without +). |
| `sender` | `String` | Sender name |
| `senderId` | `String` | Sender id |
| `sentAt` | `String` |  |

#### Example: List

```java
Object userRcsSenderCollectionList = client.userRcsSenderCollection(null).list(null, null);
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

### Data as maps

The Java SDK uses a loose object model — `Map<String, Object>` throughout —
rather than a bespoke typed class per endpoint. This mirrors the dynamic
nature of the API and keeps the SDK flexible: no regeneration is needed when
the API schema changes.

Use `Helpers.toMapAny(value)` to safely coerce a value to a
`Map<String, Object>`. A `SmsapiTypes.java` module of reference
`record` types is also generated for editor documentation.

### Project structure

```
java/
├── pom.xml                     -- Maven project (compiles core/, utility/, feature/, entity/)
├── core/                       -- Main SDK client, config, entity base, error type
├── entity/                     -- Entity implementations
├── feature/                    -- Built-in features (Base, Test, Log, ...)
├── utility/                    -- Utility functions and the vendored struct library
└── test/                       -- JUnit test suites
```

The main client class (`SmsapiSDK`, package `voxgig.smsapisdk.core`)
exposes the entity accessors. Reference entity or utility types directly only
when needed.

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
