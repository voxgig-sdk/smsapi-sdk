# Smsapi C++ SDK Reference

Complete API reference for the Smsapi C++ SDK.


## SmsapiSDK

### Constructor

```cpp
#include "core/sdk.hpp"

using namespace sdk;

auto client = std::make_shared<SmsapiSDK>(options);
```

Create a new SDK client instance. `options` is an `sdk::Value` map.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `options` | `Value` | SDK configuration options (a map). |
| `options["apikey"]` | `std::string` | API key for authentication. |
| `options["base"]` | `std::string` | Base URL for API requests. |
| `options["prefix"]` | `std::string` | URL prefix appended after base. |
| `options["suffix"]` | `std::string` | URL suffix appended after path. |
| `options["headers"]` | `Value` | Custom headers for all requests. |
| `options["feature"]` | `Value` | Feature configuration. |
| `options["system"]` | `Value` | System overrides. |


### Static Methods

#### `SmsapiSDK::testSDK(testopts, sdkopts)`

Create a test client with mock features active. Both arguments may be
`Value::undef()`; a no-arg overload is also provided.

```cpp
auto client = SmsapiSDK::testSDK();
```


### Instance Methods

#### `available(entopts = Value::undef()) -> std::shared_ptr<AvailableEntity>`

Create a new `AvailableEntity` instance bound to this client.

#### `blacklist(entopts = Value::undef()) -> std::shared_ptr<BlacklistEntity>`

Create a new `BlacklistEntity` instance bound to this client.

#### `callback(entopts = Value::undef()) -> std::shared_ptr<CallbackEntity>`

Create a new `CallbackEntity` instance bound to this client.

#### `contact(entopts = Value::undef()) -> std::shared_ptr<ContactEntity>`

Create a new `ContactEntity` instance bound to this client.

#### `contacts_field(entopts = Value::undef()) -> std::shared_ptr<ContactsFieldEntity>`

Create a new `ContactsFieldEntity` instance bound to this client.

#### `contacts_field_option(entopts = Value::undef()) -> std::shared_ptr<ContactsFieldOptionEntity>`

Create a new `ContactsFieldOptionEntity` instance bound to this client.

#### `contactsgroup(entopts = Value::undef()) -> std::shared_ptr<ContactsgroupEntity>`

Create a new `ContactsgroupEntity` instance bound to this client.

#### `contactstrash(entopts = Value::undef()) -> std::shared_ptr<ContactstrashEntity>`

Create a new `ContactstrashEntity` instance bound to this client.

#### `field_available(entopts = Value::undef()) -> std::shared_ptr<FieldAvailableEntity>`

Create a new `FieldAvailableEntity` instance bound to this client.

#### `group(entopts = Value::undef()) -> std::shared_ptr<GroupEntity>`

Create a new `GroupEntity` instance bound to this client.

#### `mfa_code(entopts = Value::undef()) -> std::shared_ptr<MfaCodeEntity>`

Create a new `MfaCodeEntity` instance bound to this client.

#### `opt_out(entopts = Value::undef()) -> std::shared_ptr<OptOutEntity>`

Create a new `OptOutEntity` instance bound to this client.

#### `opt_out_setting(entopts = Value::undef()) -> std::shared_ptr<OptOutSettingEntity>`

Create a new `OptOutSettingEntity` instance bound to this client.

#### `permission(entopts = Value::undef()) -> std::shared_ptr<PermissionEntity>`

Create a new `PermissionEntity` instance bound to this client.

#### `ping(entopts = Value::undef()) -> std::shared_ptr<PingEntity>`

Create a new `PingEntity` instance bound to this client.

#### `profile(entopts = Value::undef()) -> std::shared_ptr<ProfileEntity>`

Create a new `ProfileEntity` instance bound to this client.

#### `rcs(entopts = Value::undef()) -> std::shared_ptr<RcsEntity>`

Create a new `RcsEntity` instance bound to this client.

#### `sendername(entopts = Value::undef()) -> std::shared_ptr<SendernameEntity>`

Create a new `SendernameEntity` instance bound to this client.

#### `sendername_statement(entopts = Value::undef()) -> std::shared_ptr<SendernameStatementEntity>`

Create a new `SendernameStatementEntity` instance bound to this client.

#### `sent_rcs_message(entopts = Value::undef()) -> std::shared_ptr<SentRcsMessageEntity>`

Create a new `SentRcsMessageEntity` instance bound to this client.

#### `shipment_country_volume(entopts = Value::undef()) -> std::shared_ptr<ShipmentCountryVolumeEntity>`

Create a new `ShipmentCountryVolumeEntity` instance bound to this client.

#### `short_url(entopts = Value::undef()) -> std::shared_ptr<ShortUrlEntity>`

Create a new `ShortUrlEntity` instance bound to this client.

#### `smsdo(entopts = Value::undef()) -> std::shared_ptr<SmsdoEntity>`

Create a new `SmsdoEntity` instance bound to this client.

#### `smssendername(entopts = Value::undef()) -> std::shared_ptr<SmssendernameEntity>`

Create a new `SmssendernameEntity` instance bound to this client.

#### `smstemplate(entopts = Value::undef()) -> std::shared_ptr<SmstemplateEntity>`

Create a new `SmstemplateEntity` instance bound to this client.

#### `subuser(entopts = Value::undef()) -> std::shared_ptr<SubuserEntity>`

Create a new `SubuserEntity` instance bound to this client.

#### `template_(entopts = Value::undef()) -> std::shared_ptr<TemplateEntity>`

Create a new `TemplateEntity` instance bound to this client.

#### `user_rcs_sender_collection(entopts = Value::undef()) -> std::shared_ptr<UserRcsSenderCollectionEntity>`

Create a new `UserRcsSenderCollectionEntity` instance bound to this client.

#### `optionsMap() -> Value`

Return a deep copy of the current SDK options.

#### `getUtility() -> UtilityPtr`

Return a copy of the SDK utility object.

#### `direct(fetchargs) -> Value`

Make a direct HTTP request to any API endpoint. Returns a result `Value` with `ok`, `status`, `headers`, and `data` (or `err` on failure). This escape hatch never throws — branch on `getp(result, "ok")`.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `fetchargs["path"]` | `std::string` | URL path with optional `{param}` placeholders. |
| `fetchargs["method"]` | `std::string` | HTTP method (default: `"GET"`). |
| `fetchargs["params"]` | `Value` | Path parameter values. |
| `fetchargs["query"]` | `Value` | Query string parameters. |
| `fetchargs["headers"]` | `Value` | Request headers (merged with defaults). |
| `fetchargs["body"]` | `Value` | Request body (maps are JSON-serialized). |

**Returns:** `Value` (result map)

#### `prepare(fetchargs) -> Value`

Prepare a fetch definition without sending. Returns the `fetchdef` and throws on error.


---

## AvailableEntity

```cpp
auto available = client->available();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `name` | `std::string` | No |  |
| `normalize` | `bool` | No |  |
| `template` | `std::string` | No |  |

### Operations

#### `list(reqmatch, ctrl) -> std::vector<SdkEntityPtr>`

List entities matching the given criteria. The match is optional — pass `Value::undef()` to list all records. Returns one entity per record and throws on error.

```cpp
std::vector<SdkEntityPtr> results = client->available()->list(Value::undef(), Value::undef());
for (const auto& available : results) {
  std::cout << Struct::jsonify(available->data()) << std::endl;
}
```

### Common Methods

#### `data(arg = Value::undef()) -> Value`

Get the entity data (no argument) or set it (with a map argument).

#### `match(arg = Value::undef()) -> Value`

Get the entity match criteria (no argument) or set it (with a map argument).

#### `make() -> EntityPtr`

Create a new `AvailableEntity` instance with the same options.

#### `getName() -> std::string`

Return the entity name.


---

## BlacklistEntity

```cpp
auto blacklist = client->blacklist();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | `std::string` | No |  |

### Operations

#### `create(reqdata, ctrl) -> SdkEntityPtr`

Create a new entity with the given data. Returns the created entity and throws on error.

```cpp
SdkEntityPtr result = client->blacklist()->create(vmap({
}), Value::undef());
```

Declares a `multipart/form-data` body, which this SDK does not encode yet: it sends the data as JSON.

#### `load(reqmatch, ctrl) -> SdkEntityPtr`

Load a single entity matching the given criteria. Returns the entity, whose record `data()` reads, and throws on error.

```cpp
SdkEntityPtr result = client->blacklist()->load(Value::undef(), Value::undef());
std::cout << Struct::jsonify(result->data()) << std::endl;
```

#### `remove(reqmatch, ctrl) -> SdkEntityPtr`

Remove the entity matching the given criteria. Returns the entity, marked as deleted, and throws on error.

```cpp
SdkEntityPtr result = client->blacklist()->remove(vmap({{"id", Value("id")}}), Value::undef());
std::cout << Struct::jsonify(result->data()) << std::endl;
```

### Common Methods

#### `data(arg = Value::undef()) -> Value`

Get the entity data (no argument) or set it (with a map argument).

#### `match(arg = Value::undef()) -> Value`

Get the entity match criteria (no argument) or set it (with a map argument).

#### `make() -> EntityPtr`

Create a new `BlacklistEntity` instance with the same options.

#### `getName() -> std::string`

Return the entity name.


---

## CallbackEntity

```cpp
auto callback = client->callback();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `active` | `bool` | No |  |
| `api_version` | `int64_t` | No | Version of the callback output format. |
| `id` | `std::string` | No | Object ID |
| `invalid` | `bool` | No |  |
| `receiver` | `std::map<std::string, Value>` | No |  |
| `receiver_type` | `std::string` | No |  |
| `type` | `std::string` | No |  |
| `url` | `std::string` | No | WHATWG URL compliant |

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

#### `create(reqdata, ctrl) -> SdkEntityPtr`

Create a new entity with the given data. Returns the created entity and throws on error.

```cpp
SdkEntityPtr result = client->callback()->create(vmap({
}), Value::undef());
```

#### `list(reqmatch, ctrl) -> std::vector<SdkEntityPtr>`

List entities matching the given criteria. The match is optional — pass `Value::undef()` to list all records. Returns one entity per record and throws on error.

```cpp
std::vector<SdkEntityPtr> results = client->callback()->list(Value::undef(), Value::undef());
for (const auto& callback : results) {
  std::cout << Struct::jsonify(callback->data()) << std::endl;
}
```

#### `load(reqmatch, ctrl) -> SdkEntityPtr`

Load a single entity matching the given criteria. Returns the entity, whose record `data()` reads, and throws on error.

```cpp
SdkEntityPtr result = client->callback()->load(vmap({{"id", Value("callback_id")}}), Value::undef());
std::cout << Struct::jsonify(result->data()) << std::endl;
```

#### `remove(reqmatch, ctrl) -> SdkEntityPtr`

Remove the entity matching the given criteria. Returns the entity, marked as deleted, and throws on error.

```cpp
SdkEntityPtr result = client->callback()->remove(vmap({{"id", Value("callback_id")}}), Value::undef());
std::cout << Struct::jsonify(result->data()) << std::endl;
```

#### `update(reqdata, ctrl) -> SdkEntityPtr`

Update an existing entity. The data must include the entity `id`. Returns the updated entity and throws on error.

```cpp
SdkEntityPtr result = client->callback()->update(vmap({
    {"id", Value("callback_id")},
    // Fields to update
}), Value::undef());
```

### Common Methods

#### `data(arg = Value::undef()) -> Value`

Get the entity data (no argument) or set it (with a map argument).

#### `match(arg = Value::undef()) -> Value`

Get the entity match criteria (no argument) or set it (with a map argument).

#### `make() -> EntityPtr`

Create a new `CallbackEntity` instance with the same options.

#### `getName() -> std::string`

Return the entity name.


---

## ContactEntity

```cpp
auto contact = client->contact();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `birthday_date` | `std::string` | No |  |
| `city` | `std::string` | No |  |
| `collection` | `std::vector<Value>` | Yes |  |
| `contact_expire_after` | `int64_t` | Yes | Contact expire after days |
| `contacts_count` | `int64_t` | Yes |  |
| `country` | `std::string` | No |  |
| `created_by` | `std::string` | Yes |  |
| `date_created` | `std::string` | Yes |  |
| `date_updated` | `std::string` | Yes |  |
| `description` | `std::string` | No |  |
| `email` | `std::string` | No |  |
| `first_name` | `std::string` | No |  |
| `gender` | `std::string` | Yes |  |
| `groups` | `std::vector<Value>` | Yes |  |
| `id` | `std::string` | Yes | Object ID |
| `idx` | `std::string` | No | User provided resource id |
| `last_name` | `std::string` | No |  |
| `name` | `std::string` | Yes | Group name |
| `permissions` | `std::vector<Value>` | No |  |
| `phone_number` | `std::string` | No |  |
| `size` | `int64_t` | Yes |  |
| `source` | `std::string` | No |  |

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

#### `create(reqdata, ctrl) -> SdkEntityPtr`

Create a new entity with the given data. Returns the created entity and throws on error.

```cpp
SdkEntityPtr result = client->contact()->create(vmap({
    {"collection", vlist()},  // std::vector<Value>
    {"contact_expire_after", Value(1)},  // int64_t
    {"contacts_count", Value(1)},  // int64_t
    {"created_by", Value("example_created_by")},  // std::string
    {"date_created", Value("example_date_created")},  // std::string
    {"date_updated", Value("example_date_updated")},  // std::string
    {"gender", Value("example_gender")},  // std::string
    {"groups", vlist()},  // std::vector<Value>
    {"id", Value("example_id")},  // std::string
    {"name", Value("example_name")},  // std::string
    {"size", Value(1)},  // int64_t
}), Value::undef());
```

Declares a `application/x-www-form-urlencoded` body, which this SDK does not encode yet: it sends the data as JSON.

#### `list(reqmatch, ctrl) -> std::vector<SdkEntityPtr>`

List entities matching the given criteria. The match is optional — pass `Value::undef()` to list all records. Returns one entity per record and throws on error.

```cpp
std::vector<SdkEntityPtr> results = client->contact()->list(Value::undef(), Value::undef());
for (const auto& contact : results) {
  std::cout << Struct::jsonify(contact->data()) << std::endl;
}
```

#### `load(reqmatch, ctrl) -> SdkEntityPtr`

Load a single entity matching the given criteria. Returns the entity, whose record `data()` reads, and throws on error.

```cpp
SdkEntityPtr result = client->contact()->load(vmap({{"id", Value("contact_id")}}), Value::undef());
std::cout << Struct::jsonify(result->data()) << std::endl;
```

#### `remove(reqmatch, ctrl) -> SdkEntityPtr`

Remove the entity matching the given criteria. Returns the entity, marked as deleted, and throws on error.

```cpp
SdkEntityPtr result = client->contact()->remove(vmap({{"id", Value("contact_id")}}), Value::undef());
std::cout << Struct::jsonify(result->data()) << std::endl;
```

#### `update(reqdata, ctrl) -> SdkEntityPtr`

Update an existing entity. The data must include the entity `id`. Returns the updated entity and throws on error.

```cpp
SdkEntityPtr result = client->contact()->update(vmap({
    {"id", Value("contact_id")},
    // Fields to update
}), Value::undef());
```

Declares a `application/x-www-form-urlencoded` body, which this SDK does not encode yet: it sends the data as JSON.

### Common Methods

#### `data(arg = Value::undef()) -> Value`

Get the entity data (no argument) or set it (with a map argument).

#### `match(arg = Value::undef()) -> Value`

Get the entity match criteria (no argument) or set it (with a map argument).

#### `make() -> EntityPtr`

Create a new `ContactEntity` instance with the same options.

#### `getName() -> std::string`

Return the entity name.


---

## ContactsFieldEntity

```cpp
auto contacts_field = client->contacts_field();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | `std::string` | No | Object ID |
| `name` | `std::string` | No |  |
| `type` | `std::string` | No |  |

### Operations

#### `create(reqdata, ctrl) -> SdkEntityPtr`

Create a new entity with the given data. Returns the created entity and throws on error.

```cpp
SdkEntityPtr result = client->contacts_field()->create(vmap({
}), Value::undef());
```

Declares a `application/x-www-form-urlencoded` body, which this SDK does not encode yet: it sends the data as JSON.

#### `list(reqmatch, ctrl) -> std::vector<SdkEntityPtr>`

List entities matching the given criteria. The match is optional — pass `Value::undef()` to list all records. Returns one entity per record and throws on error.

```cpp
std::vector<SdkEntityPtr> results = client->contacts_field()->list(Value::undef(), Value::undef());
for (const auto& contacts_field : results) {
  std::cout << Struct::jsonify(contacts_field->data()) << std::endl;
}
```

#### `remove(reqmatch, ctrl) -> SdkEntityPtr`

Remove the entity matching the given criteria. Returns the entity, marked as deleted, and throws on error.

```cpp
SdkEntityPtr result = client->contacts_field()->remove(vmap({{"id", Value("id")}}), Value::undef());
std::cout << Struct::jsonify(result->data()) << std::endl;
```

#### `update(reqdata, ctrl) -> SdkEntityPtr`

Update an existing entity. The data must include the entity `id`. Returns the updated entity and throws on error.

```cpp
SdkEntityPtr result = client->contacts_field()->update(vmap({
    {"id", Value("id")},
    // Fields to update
}), Value::undef());
```

Declares a `application/x-www-form-urlencoded` body, which this SDK does not encode yet: it sends the data as JSON.

### Common Methods

#### `data(arg = Value::undef()) -> Value`

Get the entity data (no argument) or set it (with a map argument).

#### `match(arg = Value::undef()) -> Value`

Get the entity match criteria (no argument) or set it (with a map argument).

#### `make() -> EntityPtr`

Create a new `ContactsFieldEntity` instance with the same options.

#### `getName() -> std::string`

Return the entity name.


---

## ContactsFieldOptionEntity

```cpp
auto contacts_field_option = client->contacts_field_option();
```

### Operations

#### `list(reqmatch, ctrl) -> std::vector<SdkEntityPtr>`

List entities matching the given criteria. The match is optional — pass `Value::undef()` to list all records. Returns one entity per record and throws on error.

```cpp
std::vector<SdkEntityPtr> results = client->contacts_field_option()->list(vmap({{"field_id", Value("example")}}), Value::undef());
for (const auto& contacts_field_option : results) {
  std::cout << Struct::jsonify(contacts_field_option->data()) << std::endl;
}
```

### Common Methods

#### `data(arg = Value::undef()) -> Value`

Get the entity data (no argument) or set it (with a map argument).

#### `match(arg = Value::undef()) -> Value`

Get the entity match criteria (no argument) or set it (with a map argument).

#### `make() -> EntityPtr`

Create a new `ContactsFieldOptionEntity` instance with the same options.

#### `getName() -> std::string`

Return the entity name.


---

## ContactsgroupEntity

```cpp
auto contactsgroup = client->contactsgroup();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `group_id` | `std::string` | Yes | Object ID |
| `read` | `bool` | Yes | Has read permission |
| `send` | `bool` | Yes | Has send permission |
| `username` | `std::string` | Yes |  |
| `write` | `bool` | Yes | Has write permission |

### Operations

#### `create(reqdata, ctrl) -> SdkEntityPtr`

Create a new entity with the given data. Returns the created entity and throws on error.

```cpp
SdkEntityPtr result = client->contactsgroup()->create(vmap({
    {"group_id", Value("example_group_id")},  // std::string
    {"read", Value(true)},  // bool
    {"send", Value(true)},  // bool
    {"username", Value("example_username")},  // std::string
    {"write", Value(true)},  // bool
}), Value::undef());
```

Declares a `application/x-www-form-urlencoded` body, which this SDK does not encode yet: it sends the data as JSON.

#### `list(reqmatch, ctrl) -> std::vector<SdkEntityPtr>`

List entities matching the given criteria. The match is optional — pass `Value::undef()` to list all records. Returns one entity per record and throws on error.

```cpp
std::vector<SdkEntityPtr> results = client->contactsgroup()->list(Value::undef(), Value::undef());
for (const auto& contactsgroup : results) {
  std::cout << Struct::jsonify(contactsgroup->data()) << std::endl;
}
```

#### `remove(reqmatch, ctrl) -> SdkEntityPtr`

Remove the entity matching the given criteria. Returns the entity, marked as deleted, and throws on error.

```cpp
SdkEntityPtr result = client->contactsgroup()->remove(vmap({{"group_id", Value("group_id")}}), Value::undef());
std::cout << Struct::jsonify(result->data()) << std::endl;
```

#### `update(reqdata, ctrl) -> SdkEntityPtr`

Update an existing entity. The data must include the entity `id`. Returns the updated entity and throws on error.

```cpp
SdkEntityPtr result = client->contactsgroup()->update(vmap({
    {"group_id", Value("group_id")},
    // Fields to update
}), Value::undef());
```

Declares a `application/x-www-form-urlencoded` body, which this SDK does not encode yet: it sends the data as JSON.

### Common Methods

#### `data(arg = Value::undef()) -> Value`

Get the entity data (no argument) or set it (with a map argument).

#### `match(arg = Value::undef()) -> Value`

Get the entity match criteria (no argument) or set it (with a map argument).

#### `make() -> EntityPtr`

Create a new `ContactsgroupEntity` instance with the same options.

#### `getName() -> std::string`

Return the entity name.


---

## ContactstrashEntity

```cpp
auto contactstrash = client->contactstrash();
```

### Operations

#### `remove(reqmatch, ctrl) -> SdkEntityPtr`

Remove the entity matching the given criteria. Returns the entity, marked as deleted, and throws on error.

```cpp
SdkEntityPtr result = client->contactstrash()->remove(Value::undef(), Value::undef());
std::cout << Struct::jsonify(result->data()) << std::endl;
```

#### `update(reqdata, ctrl) -> SdkEntityPtr`

Update an existing entity. The data must include the entity `id`. Returns the updated entity and throws on error.

```cpp
SdkEntityPtr result = client->contactstrash()->update(vmap({
    // Fields to update
}), Value::undef());
```

### Common Methods

#### `data(arg = Value::undef()) -> Value`

Get the entity data (no argument) or set it (with a map argument).

#### `match(arg = Value::undef()) -> Value`

Get the entity match criteria (no argument) or set it (with a map argument).

#### `make() -> EntityPtr`

Create a new `ContactstrashEntity` instance with the same options.

#### `getName() -> std::string`

Return the entity name.


---

## FieldAvailableEntity

```cpp
auto field_available = client->field_available();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `built_in` | `bool` | No |  |
| `id` | `std::string` | No | Object ID |
| `name` | `std::string` | No |  |
| `options` | `std::vector<Value>` | No |  |
| `type` | `std::string` | No |  |

### Operations

#### `list(reqmatch, ctrl) -> std::vector<SdkEntityPtr>`

List entities matching the given criteria. The match is optional — pass `Value::undef()` to list all records. Returns one entity per record and throws on error.

```cpp
std::vector<SdkEntityPtr> results = client->field_available()->list(Value::undef(), Value::undef());
for (const auto& field_available : results) {
  std::cout << Struct::jsonify(field_available->data()) << std::endl;
}
```

### Common Methods

#### `data(arg = Value::undef()) -> Value`

Get the entity data (no argument) or set it (with a map argument).

#### `match(arg = Value::undef()) -> Value`

Get the entity match criteria (no argument) or set it (with a map argument).

#### `make() -> EntityPtr`

Create a new `FieldAvailableEntity` instance with the same options.

#### `getName() -> std::string`

Return the entity name.


---

## GroupEntity

```cpp
auto group = client->group();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `contact_expire_after` | `int64_t` | Yes | Contact expire after days |
| `contacts_count` | `int64_t` | Yes |  |
| `created_by` | `std::string` | Yes |  |
| `date_created` | `std::string` | Yes |  |
| `date_updated` | `std::string` | Yes |  |
| `description` | `std::string` | Yes |  |
| `id` | `std::string` | Yes | Object ID |
| `idx` | `std::string` | No | User provided resource id |
| `name` | `std::string` | Yes | Group name |
| `permissions` | `std::vector<Value>` | No |  |

### Operations

#### `load(reqmatch, ctrl) -> SdkEntityPtr`

Load a single entity matching the given criteria. Returns the entity, whose record `data()` reads, and throws on error.

```cpp
SdkEntityPtr result = client->group()->load(vmap({{"id", Value("group_id")}}), Value::undef());
std::cout << Struct::jsonify(result->data()) << std::endl;
```

#### `update(reqdata, ctrl) -> SdkEntityPtr`

Update an existing entity. The data must include the entity `id`. Returns the updated entity and throws on error.

```cpp
SdkEntityPtr result = client->group()->update(vmap({
    {"id", Value("group_id")},
    // Fields to update
}), Value::undef());
```

Declares a `application/x-www-form-urlencoded` body, which this SDK does not encode yet: it sends the data as JSON.

### Common Methods

#### `data(arg = Value::undef()) -> Value`

Get the entity data (no argument) or set it (with a map argument).

#### `match(arg = Value::undef()) -> Value`

Get the entity match criteria (no argument) or set it (with a map argument).

#### `make() -> EntityPtr`

Create a new `GroupEntity` instance with the same options.

#### `getName() -> std::string`

Return the entity name.


---

## MfaCodeEntity

```cpp
auto mfa_code = client->mfa_code();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `content` | `std::string` | No | Custom content that must contain placeholder [%code%] |
| `fast` | `Value` | No |  |
| `from` | `std::string` | No | Sendername |
| `phone_number` | `std::string` | Yes |  |

### Operations

#### `create(reqdata, ctrl) -> SdkEntityPtr`

Create a new entity with the given data. Returns the created entity and throws on error.

```cpp
SdkEntityPtr result = client->mfa_code()->create(vmap({
    {"phone_number", Value("example_phone_number")},  // std::string
}), Value::undef());
```

Declares a `application/x-www-form-urlencoded` body, which this SDK does not encode yet: it sends the data as JSON.

### Common Methods

#### `data(arg = Value::undef()) -> Value`

Get the entity data (no argument) or set it (with a map argument).

#### `match(arg = Value::undef()) -> Value`

Get the entity match criteria (no argument) or set it (with a map argument).

#### `make() -> EntityPtr`

Create a new `MfaCodeEntity` instance with the same options.

#### `getName() -> std::string`

Return the entity name.


---

## OptOutEntity

```cpp
auto opt_out = client->opt_out();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `date` | `std::string` | No |  |
| `id` | `std::string` | No |  |
| `links` | `std::vector<Value>` | No |  |
| `phoneNumber` | `int64_t` | No |  |

### Operations

#### `list(reqmatch, ctrl) -> std::vector<SdkEntityPtr>`

List entities matching the given criteria. The match is optional — pass `Value::undef()` to list all records. Returns one entity per record and throws on error.

```cpp
std::vector<SdkEntityPtr> results = client->opt_out()->list(Value::undef(), Value::undef());
for (const auto& opt_out : results) {
  std::cout << Struct::jsonify(opt_out->data()) << std::endl;
}
```

#### `remove(reqmatch, ctrl) -> SdkEntityPtr`

Remove the entity matching the given criteria. Returns the entity, marked as deleted, and throws on error.

```cpp
SdkEntityPtr result = client->opt_out()->remove(vmap({{"id", Value("id")}}), Value::undef());
std::cout << Struct::jsonify(result->data()) << std::endl;
```

### Common Methods

#### `data(arg = Value::undef()) -> Value`

Get the entity data (no argument) or set it (with a map argument).

#### `match(arg = Value::undef()) -> Value`

Get the entity match criteria (no argument) or set it (with a map argument).

#### `make() -> EntityPtr`

Create a new `OptOutEntity` instance with the same options.

#### `getName() -> std::string`

Return the entity name.


---

## OptOutSettingEntity

```cpp
auto opt_out_setting = client->opt_out_setting();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `brand` | `std::string` | No |  |

### Operations

#### `load(reqmatch, ctrl) -> SdkEntityPtr`

Load a single entity matching the given criteria. Returns the entity, whose record `data()` reads, and throws on error.

```cpp
SdkEntityPtr result = client->opt_out_setting()->load(Value::undef(), Value::undef());
std::cout << Struct::jsonify(result->data()) << std::endl;
```

#### `update(reqdata, ctrl) -> SdkEntityPtr`

Update an existing entity. The data must include the entity `id`. Returns the updated entity and throws on error.

```cpp
SdkEntityPtr result = client->opt_out_setting()->update(vmap({
    // Fields to update
}), Value::undef());
```

### Common Methods

#### `data(arg = Value::undef()) -> Value`

Get the entity data (no argument) or set it (with a map argument).

#### `match(arg = Value::undef()) -> Value`

Get the entity match criteria (no argument) or set it (with a map argument).

#### `make() -> EntityPtr`

Create a new `OptOutSettingEntity` instance with the same options.

#### `getName() -> std::string`

Return the entity name.


---

## PermissionEntity

```cpp
auto permission = client->permission();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `group_id` | `std::string` | Yes | Object ID |
| `id` | `std::string` | No |  |
| `read` | `bool` | Yes | Has read permission |
| `send` | `bool` | Yes | Has send permission |
| `username` | `std::string` | Yes |  |
| `write` | `bool` | Yes | Has write permission |

### Operations

#### `create(reqdata, ctrl) -> SdkEntityPtr`

Create a new entity with the given data. Returns the created entity and throws on error.

```cpp
SdkEntityPtr result = client->permission()->create(vmap({
    {"group_id", Value("example_group_id")},  // std::string
    {"read", Value(true)},  // bool
    {"send", Value(true)},  // bool
    {"username", Value("example_username")},  // std::string
    {"write", Value(true)},  // bool
}), Value::undef());
```

Declares a `application/x-www-form-urlencoded` body, which this SDK does not encode yet: it sends the data as JSON.

#### `load(reqmatch, ctrl) -> SdkEntityPtr`

Load a single entity matching the given criteria. Returns the entity, whose record `data()` reads, and throws on error.

```cpp
SdkEntityPtr result = client->permission()->load(vmap({{"id", Value("permission_id")}, {"group_id", Value("group_id")}}), Value::undef());
std::cout << Struct::jsonify(result->data()) << std::endl;
```

### Common Methods

#### `data(arg = Value::undef()) -> Value`

Get the entity data (no argument) or set it (with a map argument).

#### `match(arg = Value::undef()) -> Value`

Get the entity match criteria (no argument) or set it (with a map argument).

#### `make() -> EntityPtr`

Create a new `PermissionEntity` instance with the same options.

#### `getName() -> std::string`

Return the entity name.


---

## PingEntity

```cpp
auto ping = client->ping();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `authorized` | `bool` | Yes |  |
| `unavailable` | `std::vector<Value>` | Yes |  |

### Operations

#### `list(reqmatch, ctrl) -> std::vector<SdkEntityPtr>`

List entities matching the given criteria. The match is optional — pass `Value::undef()` to list all records. Returns one entity per record and throws on error.

```cpp
std::vector<SdkEntityPtr> results = client->ping()->list(Value::undef(), Value::undef());
for (const auto& ping : results) {
  std::cout << Struct::jsonify(ping->data()) << std::endl;
}
```

### Common Methods

#### `data(arg = Value::undef()) -> Value`

Get the entity data (no argument) or set it (with a map argument).

#### `match(arg = Value::undef()) -> Value`

Get the entity match criteria (no argument) or set it (with a map argument).

#### `make() -> EntityPtr`

Create a new `PingEntity` instance with the same options.

#### `getName() -> std::string`

Return the entity name.


---

## ProfileEntity

```cpp
auto profile = client->profile();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `email` | `std::string` | Yes |  |
| `name` | `std::string` | Yes |  |
| `payment_type` | `std::string` | Yes |  |
| `phone_number` | `int64_t` | Yes |  |
| `points` | `double` | No |  |
| `user_type` | `std::string` | Yes |  |
| `username` | `std::string` | Yes |  |

### Operations

#### `list(reqmatch, ctrl) -> std::vector<SdkEntityPtr>`

List entities matching the given criteria. The match is optional — pass `Value::undef()` to list all records. Returns one entity per record and throws on error.

```cpp
std::vector<SdkEntityPtr> results = client->profile()->list(Value::undef(), Value::undef());
for (const auto& profile : results) {
  std::cout << Struct::jsonify(profile->data()) << std::endl;
}
```

#### `load(reqmatch, ctrl) -> SdkEntityPtr`

Load a single entity matching the given criteria. Returns the entity, whose record `data()` reads, and throws on error.

```cpp
SdkEntityPtr result = client->profile()->load(Value::undef(), Value::undef());
std::cout << Struct::jsonify(result->data()) << std::endl;
```

### Common Methods

#### `data(arg = Value::undef()) -> Value`

Get the entity data (no argument) or set it (with a map argument).

#### `match(arg = Value::undef()) -> Value`

Get the entity match criteria (no argument) or set it (with a map argument).

#### `make() -> EntityPtr`

Create a new `ProfileEntity` instance with the same options.

#### `getName() -> std::string`

Return the entity name.


---

## RcsEntity

```cpp
auto rcs = client->rcs();
```

### Operations

#### `list(reqmatch, ctrl) -> std::vector<SdkEntityPtr>`

List entities matching the given criteria. The match is optional — pass `Value::undef()` to list all records. Returns one entity per record and throws on error.

```cpp
std::vector<SdkEntityPtr> results = client->rcs()->list(Value::undef(), Value::undef());
for (const auto& rcs : results) {
  std::cout << Struct::jsonify(rcs->data()) << std::endl;
}
```

### Common Methods

#### `data(arg = Value::undef()) -> Value`

Get the entity data (no argument) or set it (with a map argument).

#### `match(arg = Value::undef()) -> Value`

Get the entity match criteria (no argument) or set it (with a map argument).

#### `make() -> EntityPtr`

Create a new `RcsEntity` instance with the same options.

#### `getName() -> std::string`

Return the entity name.


---

## SendernameEntity

```cpp
auto sendername = client->sendername();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `created_at` | `std::string` | No |  |
| `id` | `std::string` | No |  |
| `is_default` | `bool` | No |  |
| `sender` | `std::string` | No | Sendername |
| `status` | `std::string` | No |  |

### Operations

#### `create(reqdata, ctrl) -> SdkEntityPtr`

Create a new entity with the given data. Returns the created entity and throws on error.

```cpp
SdkEntityPtr result = client->sendername()->create(vmap({
}), Value::undef());
```

Declares a `application/x-www-form-urlencoded` body, which this SDK does not encode yet: it sends the data as JSON.

#### `list(reqmatch, ctrl) -> std::vector<SdkEntityPtr>`

List entities matching the given criteria. The match is optional — pass `Value::undef()` to list all records. Returns one entity per record and throws on error.

```cpp
std::vector<SdkEntityPtr> results = client->sendername()->list(Value::undef(), Value::undef());
for (const auto& sendername : results) {
  std::cout << Struct::jsonify(sendername->data()) << std::endl;
}
```

#### `load(reqmatch, ctrl) -> SdkEntityPtr`

Load a single entity matching the given criteria. Returns the entity, whose record `data()` reads, and throws on error.

```cpp
SdkEntityPtr result = client->sendername()->load(vmap({{"id", Value("sendername_id")}}), Value::undef());
std::cout << Struct::jsonify(result->data()) << std::endl;
```

### Common Methods

#### `data(arg = Value::undef()) -> Value`

Get the entity data (no argument) or set it (with a map argument).

#### `match(arg = Value::undef()) -> Value`

Get the entity match criteria (no argument) or set it (with a map argument).

#### `make() -> EntityPtr`

Create a new `SendernameEntity` instance with the same options.

#### `getName() -> std::string`

Return the entity name.


---

## SendernameStatementEntity

```cpp
auto sendername_statement = client->sendername_statement();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `content` | `std::string` | No |  |
| `statements` | `std::vector<Value>` | No |  |
| `title` | `std::string` | No |  |

### Operations

#### `list(reqmatch, ctrl) -> std::vector<SdkEntityPtr>`

List entities matching the given criteria. The match is optional — pass `Value::undef()` to list all records. Returns one entity per record and throws on error.

```cpp
std::vector<SdkEntityPtr> results = client->sendername_statement()->list(Value::undef(), Value::undef());
for (const auto& sendername_statement : results) {
  std::cout << Struct::jsonify(sendername_statement->data()) << std::endl;
}
```

### Common Methods

#### `data(arg = Value::undef()) -> Value`

Get the entity data (no argument) or set it (with a map argument).

#### `match(arg = Value::undef()) -> Value`

Get the entity match criteria (no argument) or set it (with a map argument).

#### `make() -> EntityPtr`

Create a new `SendernameStatementEntity` instance with the same options.

#### `getName() -> std::string`

Return the entity name.


---

## SentRcsMessageEntity

```cpp
auto sent_rcs_message = client->sent_rcs_message();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `content` | `std::map<std::string, Value>` | No | RCS message content in RCS JSON format. |
| `phone_number` | `std::string` | Yes | Recipient phone number (e.g. |
| `sender` | `std::string` | Yes | RCS sender ID (object ID of the agent/sender the user has access to). |
| `text` | `std::string` | No | Plain text message content. |

### Operations

#### `create(reqdata, ctrl) -> SdkEntityPtr`

Create a new entity with the given data. Returns the created entity and throws on error.

```cpp
SdkEntityPtr result = client->sent_rcs_message()->create(vmap({
    {"phone_number", Value("example_phone_number")},  // std::string
    {"sender", Value("example_sender")},  // std::string
}), Value::undef());
```

### Common Methods

#### `data(arg = Value::undef()) -> Value`

Get the entity data (no argument) or set it (with a map argument).

#### `match(arg = Value::undef()) -> Value`

Get the entity match criteria (no argument) or set it (with a map argument).

#### `make() -> EntityPtr`

Create a new `SentRcsMessageEntity` instance with the same options.

#### `getName() -> std::string`

Return the entity name.


---

## ShipmentCountryVolumeEntity

```cpp
auto shipment_country_volume = client->shipment_country_volume();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `country_code` | `std::string` | No |  |
| `country_limit` | `int64_t` | No |  |
| `country_name` | `std::string` | No |  |
| `usage` | `int64_t` | No |  |

### Operations

#### `list(reqmatch, ctrl) -> std::vector<SdkEntityPtr>`

List entities matching the given criteria. The match is optional — pass `Value::undef()` to list all records. Returns one entity per record and throws on error.

```cpp
std::vector<SdkEntityPtr> results = client->shipment_country_volume()->list(Value::undef(), Value::undef());
for (const auto& shipment_country_volume : results) {
  std::cout << Struct::jsonify(shipment_country_volume->data()) << std::endl;
}
```

### Common Methods

#### `data(arg = Value::undef()) -> Value`

Get the entity data (no argument) or set it (with a map argument).

#### `match(arg = Value::undef()) -> Value`

Get the entity match criteria (no argument) or set it (with a map argument).

#### `make() -> EntityPtr`

Create a new `ShipmentCountryVolumeEntity` instance with the same options.

#### `getName() -> std::string`

Return the entity name.


---

## ShortUrlEntity

```cpp
auto short_url = client->short_url();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `description` | `std::string` | No |  |
| `expire` | `std::string` | No |  |
| `filename` | `std::string` | No |  |
| `hits` | `int64_t` | No |  |
| `hits_unique` | `int64_t` | No |  |
| `id` | `std::string` | No |  |
| `name` | `std::string` | No |  |
| `short_url` | `std::string` | No | WHATWG URL compliant |
| `type` | `std::string` | No |  |
| `url` | `std::string` | No | WHATWG URL compliant |

### Operations

#### `create(reqdata, ctrl) -> SdkEntityPtr`

Create a new entity with the given data. Returns the created entity and throws on error.

```cpp
SdkEntityPtr result = client->short_url()->create(vmap({
}), Value::undef());
```

#### `list(reqmatch, ctrl) -> std::vector<SdkEntityPtr>`

List entities matching the given criteria. The match is optional — pass `Value::undef()` to list all records. Returns one entity per record and throws on error.

```cpp
std::vector<SdkEntityPtr> results = client->short_url()->list(Value::undef(), Value::undef());
for (const auto& short_url : results) {
  std::cout << Struct::jsonify(short_url->data()) << std::endl;
}
```

#### `load(reqmatch, ctrl) -> SdkEntityPtr`

Load a single entity matching the given criteria. Returns the entity, whose record `data()` reads, and throws on error.

```cpp
SdkEntityPtr result = client->short_url()->load(vmap({{"id", Value("short_url_id")}}), Value::undef());
std::cout << Struct::jsonify(result->data()) << std::endl;
```

#### `remove(reqmatch, ctrl) -> SdkEntityPtr`

Remove the entity matching the given criteria. Returns the entity, marked as deleted, and throws on error.

```cpp
SdkEntityPtr result = client->short_url()->remove(vmap({{"id", Value("short_url_id")}}), Value::undef());
std::cout << Struct::jsonify(result->data()) << std::endl;
```

#### `update(reqdata, ctrl) -> SdkEntityPtr`

Update an existing entity. The data must include the entity `id`. Returns the updated entity and throws on error.

```cpp
SdkEntityPtr result = client->short_url()->update(vmap({
    {"id", Value("short_url_id")},
    // Fields to update
}), Value::undef());
```

Declares a `application/x-www-form-urlencoded` body, which this SDK does not encode yet: it sends the data as JSON.

### Common Methods

#### `data(arg = Value::undef()) -> Value`

Get the entity data (no argument) or set it (with a map argument).

#### `match(arg = Value::undef()) -> Value`

Get the entity match criteria (no argument) or set it (with a map argument).

#### `make() -> EntityPtr`

Create a new `ShortUrlEntity` instance with the same options.

#### `getName() -> std::string`

Return the entity name.


---

## SmsdoEntity

```cpp
auto smsdo = client->smsdo();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `allow_duplicates` | `int64_t` | No | When parameter allow_duplicates is set to "1" allows to send message to duplicated numbers in one request (useful i.e. |
| `check_idx` | `Value` | No | When parameter check_idx is set to „1” prevents from sending more than one message with the same idx in last 24h. |
| `date` | `Value` | No | Date in UNIX timestamp (&date=1287734110) or in ISO 8601 (&date=2012-05-10T08:40:27+00:00) when message will be sent (&date=1287734110). |
| `date_validate` | `int64_t` | No | When parameter date_validate is set to "1" checks if date if given in proper format. |
| `details` | `Value` | No | When details parameter is set to "1" more details in response will be displayed (message length and sms count). |
| `encoding` | `std::string` | No | This parameter describes the encoding of the message text. |
| `expiration_date` | `Value` | No | Message expiration date (in UNIX timestamp or in ISO 8601) is a date after which message won't be delivered if it wasn't delivered yet. |
| `fallback` | `std::vector<Value>` | No | Enable fallback in case sms sending fails |
| `fast` | `int64_t` | No | Setting this parameter to „1” will result in sending message with the highest priority which ensures the quickest possible time of delivery. |
| `flash` | `int64_t` | No | Sending a message in flash mode can be activated by setting this parameter to "1". |
| `format` | `std::string` | No | Parameter &format=json causes, that response is sending in JSON format. |
| `from` | `std::string` | No | Name of the sender. |
| `group` | `std::string` | No | Name of the group from the contacts database to which message should be sent to. |
| `idx` | `std::string` | No | Optional custom value sent with SMS and sent back in CALLBACK. |
| `max_parts` | `int64_t` | No | Defines maximum message parts allowed, maximum value allowed is 6. |
| `message` | `std::string` | No | The message text. |
| `normalize` | `int64_t` | No | When parameter normalize is set to „1” special chars in message will be replaced with their equivalents (ê-e, ñ-n, ý-y ...). |
| `notify_url` | `std::string` | No | Parameter allows to set CALLBACK URL for message from request. |
| `test` | `Value` | No | When parameter test is set to "1" message won't be sent but response will be displayed, there is no charge for such test messages. |
| `time_restriction` | `std::string` | No | Sets the behavior when you try to ship in hours / dates that do not match the settings in your account. |
| `to` | `std::string` | No | Recipients' mobile phone numbers (i.e. |

### Operations

#### `create(reqdata, ctrl) -> SdkEntityPtr`

Create a new entity with the given data. Returns the created entity and throws on error.

```cpp
SdkEntityPtr result = client->smsdo()->create(vmap({
}), Value::undef());
```

### Common Methods

#### `data(arg = Value::undef()) -> Value`

Get the entity data (no argument) or set it (with a map argument).

#### `match(arg = Value::undef()) -> Value`

Get the entity match criteria (no argument) or set it (with a map argument).

#### `make() -> EntityPtr`

Create a new `SmsdoEntity` instance with the same options.

#### `getName() -> std::string`

Return the entity name.


---

## SmssendernameEntity

```cpp
auto smssendername = client->smssendername();
```

### Operations

#### `create(reqdata, ctrl) -> SdkEntityPtr`

Create a new entity with the given data. Returns the created entity and throws on error.

```cpp
SdkEntityPtr result = client->smssendername()->create(vmap({
    {"sender", Value("example_sender")},  // std::string
}), Value::undef());
```

#### `remove(reqmatch, ctrl) -> SdkEntityPtr`

Remove the entity matching the given criteria. Returns the entity, marked as deleted, and throws on error.

```cpp
SdkEntityPtr result = client->smssendername()->remove(vmap({{"sender", Value("sender")}}), Value::undef());
std::cout << Struct::jsonify(result->data()) << std::endl;
```

### Common Methods

#### `data(arg = Value::undef()) -> Value`

Get the entity data (no argument) or set it (with a map argument).

#### `match(arg = Value::undef()) -> Value`

Get the entity match criteria (no argument) or set it (with a map argument).

#### `make() -> EntityPtr`

Create a new `SmssendernameEntity` instance with the same options.

#### `getName() -> std::string`

Return the entity name.


---

## SmstemplateEntity

```cpp
auto smstemplate = client->smstemplate();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | `std::string` | No |  |

### Operations

#### `remove(reqmatch, ctrl) -> SdkEntityPtr`

Remove the entity matching the given criteria. Returns the entity, marked as deleted, and throws on error.

```cpp
SdkEntityPtr result = client->smstemplate()->remove(vmap({{"id", Value("id")}}), Value::undef());
std::cout << Struct::jsonify(result->data()) << std::endl;
```

### Common Methods

#### `data(arg = Value::undef()) -> Value`

Get the entity data (no argument) or set it (with a map argument).

#### `match(arg = Value::undef()) -> Value`

Get the entity match criteria (no argument) or set it (with a map argument).

#### `make() -> EntityPtr`

Create a new `SmstemplateEntity` instance with the same options.

#### `getName() -> std::string`

Return the entity name.


---

## SubuserEntity

```cpp
auto subuser = client->subuser();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `active` | `bool` | No |  |
| `credentials` | `std::map<std::string, Value>` | Yes |  |
| `description` | `std::string` | No |  |
| `id` | `std::string` | No | Object ID |
| `points` | `std::map<std::string, Value>` | No |  |
| `username` | `std::string` | No |  |

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

#### `create(reqdata, ctrl) -> SdkEntityPtr`

Create a new entity with the given data. Returns the created entity and throws on error.

```cpp
SdkEntityPtr result = client->subuser()->create(vmap({
    {"credentials", vmap()},  // std::map<std::string, Value>
}), Value::undef());
```

#### `list(reqmatch, ctrl) -> std::vector<SdkEntityPtr>`

List entities matching the given criteria. The match is optional — pass `Value::undef()` to list all records. Returns one entity per record and throws on error.

```cpp
std::vector<SdkEntityPtr> results = client->subuser()->list(Value::undef(), Value::undef());
for (const auto& subuser : results) {
  std::cout << Struct::jsonify(subuser->data()) << std::endl;
}
```

#### `load(reqmatch, ctrl) -> SdkEntityPtr`

Load a single entity matching the given criteria. Returns the entity, whose record `data()` reads, and throws on error.

```cpp
SdkEntityPtr result = client->subuser()->load(vmap({{"id", Value("subuser_id")}}), Value::undef());
std::cout << Struct::jsonify(result->data()) << std::endl;
```

#### `remove(reqmatch, ctrl) -> SdkEntityPtr`

Remove the entity matching the given criteria. Returns the entity, marked as deleted, and throws on error.

```cpp
SdkEntityPtr result = client->subuser()->remove(vmap({{"id", Value("subuser_id")}}), Value::undef());
std::cout << Struct::jsonify(result->data()) << std::endl;
```

#### `update(reqdata, ctrl) -> SdkEntityPtr`

Update an existing entity. The data must include the entity `id`. Returns the updated entity and throws on error.

```cpp
SdkEntityPtr result = client->subuser()->update(vmap({
    {"id", Value("subuser_id")},
    // Fields to update
}), Value::undef());
```

### Common Methods

#### `data(arg = Value::undef()) -> Value`

Get the entity data (no argument) or set it (with a map argument).

#### `match(arg = Value::undef()) -> Value`

Get the entity match criteria (no argument) or set it (with a map argument).

#### `make() -> EntityPtr`

Create a new `SubuserEntity` instance with the same options.

#### `getName() -> std::string`

Return the entity name.


---

## TemplateEntity

```cpp
auto template_ = client->template_();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | `std::string` | No |  |
| `name` | `std::string` | No |  |
| `normalize` | `bool` | No |  |
| `template` | `std::string` | No |  |

### Operations

#### `create(reqdata, ctrl) -> SdkEntityPtr`

Create a new entity with the given data. Returns the created entity and throws on error.

```cpp
SdkEntityPtr result = client->template_()->create(vmap({
}), Value::undef());
```

Declares a `application/x-www-form-urlencoded` body, which this SDK does not encode yet: it sends the data as JSON.

#### `list(reqmatch, ctrl) -> std::vector<SdkEntityPtr>`

List entities matching the given criteria. The match is optional — pass `Value::undef()` to list all records. Returns one entity per record and throws on error.

```cpp
std::vector<SdkEntityPtr> results = client->template_()->list(Value::undef(), Value::undef());
for (const auto& template_ : results) {
  std::cout << Struct::jsonify(template_->data()) << std::endl;
}
```

#### `load(reqmatch, ctrl) -> SdkEntityPtr`

Load a single entity matching the given criteria. Returns the entity, whose record `data()` reads, and throws on error.

```cpp
SdkEntityPtr result = client->template_()->load(vmap({{"id", Value("template_id")}}), Value::undef());
std::cout << Struct::jsonify(result->data()) << std::endl;
```

#### `update(reqdata, ctrl) -> SdkEntityPtr`

Update an existing entity. The data must include the entity `id`. Returns the updated entity and throws on error.

```cpp
SdkEntityPtr result = client->template_()->update(vmap({
    {"id", Value("template_id")},
    // Fields to update
}), Value::undef());
```

Declares a `application/x-www-form-urlencoded` body, which this SDK does not encode yet: it sends the data as JSON.

### Common Methods

#### `data(arg = Value::undef()) -> Value`

Get the entity data (no argument) or set it (with a map argument).

#### `match(arg = Value::undef()) -> Value`

Get the entity match criteria (no argument) or set it (with a map argument).

#### `make() -> EntityPtr`

Create a new `TemplateEntity` instance with the same options.

#### `getName() -> std::string`

Return the entity name.


---

## UserRcsSenderCollectionEntity

```cpp
auto user_rcs_sender_collection = client->user_rcs_sender_collection();
```

### Operations

#### `list(reqmatch, ctrl) -> std::vector<SdkEntityPtr>`

List entities matching the given criteria. The match is optional — pass `Value::undef()` to list all records. Returns one entity per record and throws on error.

```cpp
std::vector<SdkEntityPtr> results = client->user_rcs_sender_collection()->list(Value::undef(), Value::undef());
for (const auto& user_rcs_sender_collection : results) {
  std::cout << Struct::jsonify(user_rcs_sender_collection->data()) << std::endl;
}
```

### Common Methods

#### `data(arg = Value::undef()) -> Value`

Get the entity data (no argument) or set it (with a map argument).

#### `match(arg = Value::undef()) -> Value`

Get the entity match criteria (no argument) or set it (with a map argument).

#### `make() -> EntityPtr`

Create a new `UserRcsSenderCollectionEntity` instance with the same options.

#### `getName() -> std::string`

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

```cpp
auto client = std::make_shared<SmsapiSDK>(vmap({
    {"feature", vmap({
        {"audit", vmap({{"active", Value(true)}})},
        {"cache", vmap({{"active", Value(true)}})},
        {"clienttrack", vmap({{"active", Value(true)}})},
        {"cost", vmap({{"active", Value(true)}})},
        {"debug", vmap({{"active", Value(true)}})},
        {"idempotency", vmap({{"active", Value(true)}})},
        {"log", vmap({{"active", Value(true)}})},
        {"metrics", vmap({{"active", Value(true)}})},
        {"netsim", vmap({{"active", Value(true)}})},
        {"paging", vmap({{"active", Value(true)}})},
        {"proxy", vmap({{"active", Value(true)}})},
        {"ratelimit", vmap({{"active", Value(true)}})},
        {"rbac", vmap({{"active", Value(true)}})},
        {"retry", vmap({{"active", Value(true)}})},
        {"secrets", vmap({{"active", Value(true)}})},
        {"streaming", vmap({{"active", Value(true)}})},
        {"telemetry", vmap({{"active", Value(true)}})},
        {"test", vmap({{"active", Value(true)}})},
        {"timeout", vmap({{"active", Value(true)}})},
        {"validate", vmap({{"active", Value(true)}})},
    })},
}));
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

