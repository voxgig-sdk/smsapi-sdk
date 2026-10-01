# Smsapi Rust SDK Reference

Complete API reference for the Smsapi Rust SDK.


## SmsapiSDK

### Constructor

```rust
use smsapi_sdk::{SmsapiSDK, Value};

let client = SmsapiSDK::new(options);
```

Create a new SDK client instance. `options` is a `Value` map
(`Value::Noval` for none).

**Parameters:**

| Key | Value type | Description |
| --- | --- | --- |
| `apikey` | `string` | API key for authentication. |
| `base` | `string` | Base URL for API requests. |
| `prefix` | `string` | URL prefix appended after base. |
| `suffix` | `string` | URL suffix appended after path. |
| `headers` | `map` | Custom headers for all requests. |
| `feature` | `map` | Feature configuration. |
| `system` | `map` | System overrides. |


### Static Functions

#### `test_sdk(testopts: Value, sdkopts: Value) -> Rc<SmsapiSDK>`

Create a test client with mock features active. Both arguments may be
`Value::Noval`.

```rust
use smsapi_sdk::{test_sdk, Value};

let client = test_sdk(Value::Noval, Value::Noval);
```


### Instance Methods

#### `available(entopts: Value) -> Rc<AvailableEntity>`

Create a new `AvailableEntity` instance. Pass `Value::Noval` for no
initial options.

#### `blacklist(entopts: Value) -> Rc<BlacklistEntity>`

Create a new `BlacklistEntity` instance. Pass `Value::Noval` for no
initial options.

#### `callback(entopts: Value) -> Rc<CallbackEntity>`

Create a new `CallbackEntity` instance. Pass `Value::Noval` for no
initial options.

#### `contact(entopts: Value) -> Rc<ContactEntity>`

Create a new `ContactEntity` instance. Pass `Value::Noval` for no
initial options.

#### `contacts_field(entopts: Value) -> Rc<ContactsFieldEntity>`

Create a new `ContactsFieldEntity` instance. Pass `Value::Noval` for no
initial options.

#### `contacts_field_option(entopts: Value) -> Rc<ContactsFieldOptionEntity>`

Create a new `ContactsFieldOptionEntity` instance. Pass `Value::Noval` for no
initial options.

#### `contactsgroup(entopts: Value) -> Rc<ContactsgroupEntity>`

Create a new `ContactsgroupEntity` instance. Pass `Value::Noval` for no
initial options.

#### `contactstrash(entopts: Value) -> Rc<ContactstrashEntity>`

Create a new `ContactstrashEntity` instance. Pass `Value::Noval` for no
initial options.

#### `field_available(entopts: Value) -> Rc<FieldAvailableEntity>`

Create a new `FieldAvailableEntity` instance. Pass `Value::Noval` for no
initial options.

#### `group(entopts: Value) -> Rc<GroupEntity>`

Create a new `GroupEntity` instance. Pass `Value::Noval` for no
initial options.

#### `mfa_code(entopts: Value) -> Rc<MfaCodeEntity>`

Create a new `MfaCodeEntity` instance. Pass `Value::Noval` for no
initial options.

#### `opt_out(entopts: Value) -> Rc<OptOutEntity>`

Create a new `OptOutEntity` instance. Pass `Value::Noval` for no
initial options.

#### `opt_out_setting(entopts: Value) -> Rc<OptOutSettingEntity>`

Create a new `OptOutSettingEntity` instance. Pass `Value::Noval` for no
initial options.

#### `permission(entopts: Value) -> Rc<PermissionEntity>`

Create a new `PermissionEntity` instance. Pass `Value::Noval` for no
initial options.

#### `ping(entopts: Value) -> Rc<PingEntity>`

Create a new `PingEntity` instance. Pass `Value::Noval` for no
initial options.

#### `profile(entopts: Value) -> Rc<ProfileEntity>`

Create a new `ProfileEntity` instance. Pass `Value::Noval` for no
initial options.

#### `rcs(entopts: Value) -> Rc<RcsEntity>`

Create a new `RcsEntity` instance. Pass `Value::Noval` for no
initial options.

#### `sendername(entopts: Value) -> Rc<SendernameEntity>`

Create a new `SendernameEntity` instance. Pass `Value::Noval` for no
initial options.

#### `sendername_statement(entopts: Value) -> Rc<SendernameStatementEntity>`

Create a new `SendernameStatementEntity` instance. Pass `Value::Noval` for no
initial options.

#### `sent_rcs_message(entopts: Value) -> Rc<SentRcsMessageEntity>`

Create a new `SentRcsMessageEntity` instance. Pass `Value::Noval` for no
initial options.

#### `shipment_country_volume(entopts: Value) -> Rc<ShipmentCountryVolumeEntity>`

Create a new `ShipmentCountryVolumeEntity` instance. Pass `Value::Noval` for no
initial options.

#### `short_url(entopts: Value) -> Rc<ShortUrlEntity>`

Create a new `ShortUrlEntity` instance. Pass `Value::Noval` for no
initial options.

#### `smsdo(entopts: Value) -> Rc<SmsdoEntity>`

Create a new `SmsdoEntity` instance. Pass `Value::Noval` for no
initial options.

#### `smssendername(entopts: Value) -> Rc<SmssendernameEntity>`

Create a new `SmssendernameEntity` instance. Pass `Value::Noval` for no
initial options.

#### `smstemplate(entopts: Value) -> Rc<SmstemplateEntity>`

Create a new `SmstemplateEntity` instance. Pass `Value::Noval` for no
initial options.

#### `subuser(entopts: Value) -> Rc<SubuserEntity>`

Create a new `SubuserEntity` instance. Pass `Value::Noval` for no
initial options.

#### `template(entopts: Value) -> Rc<TemplateEntity>`

Create a new `TemplateEntity` instance. Pass `Value::Noval` for no
initial options.

#### `user_rcs_sender_collection(entopts: Value) -> Rc<UserRcsSenderCollectionEntity>`

Create a new `UserRcsSenderCollectionEntity` instance. Pass `Value::Noval` for no
initial options.

#### `options_map() -> Value`

Return a deep copy of the current SDK options.

#### `get_utility() -> Rc<Utility>`

Return a copy of the SDK utility object.

#### `direct(fetchargs: Value) -> Result<Value, SmsapiError>`

Make a direct HTTP request to any API endpoint. `Ok` is a result `Value::Map`
with `ok`, `status`, `headers`, and `data` (or `err` on failure). This
escape hatch resolves to `Ok` even on a non-2xx response — branch on
`getp(&result, "ok")`.

**Parameters (`fetchargs` map keys):**

| Key | Value type | Description |
| --- | --- | --- |
| `path` | `string` | URL path with optional `{param}` placeholders. |
| `method` | `string` | HTTP method (default: `"GET"`). |
| `params` | `map` | Path parameter values. |
| `query` | `map` | Query string parameters. |
| `headers` | `map` | Request headers (merged with defaults). |
| `body` | `any` | Request body (maps are JSON-serialized). |

#### `prepare(fetchargs: Value) -> Result<Value, SmsapiError>`

Prepare a fetch definition without sending. Returns the fetchdef on `Ok`.


---

## AvailableEntity

```rust
let available = client.available(Value::Noval);
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `name` | `String` | No |  |
| `normalize` | `bool` | No |  |
| `template` | `String` | No |  |

### Operations

#### `list(reqmatch: Value, ctrl: Value) -> Result<Value, SmsapiError>`

List entities matching the given criteria. The match is optional — pass `Value::Noval` to list all records. `Ok` is a `Value::List`.

```rust
let results = client.available(Value::Noval).list(Value::Noval, Value::Noval).unwrap();
if let Value::List(items) = &results {
    for available in items.borrow().iter() {
        println!("{:?}", available);
    }
}
```

### Common Methods

#### `data(args: Option<&Value>) -> Value`

Get the entity data. Pass `Some(&map)` to set it.

#### `matchv(args: Option<&Value>) -> Value`

Get the entity match criteria. Pass `Some(&map)` to set it.

#### `make() -> Rc<dyn Entity>`

Create a new `AvailableEntity` instance with the same options.

#### `get_name() -> String`

Return the entity name.


---

## BlacklistEntity

```rust
let blacklist = client.blacklist(Value::Noval);
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | `String` | No |  |

### Operations

#### `create(reqdata: Value, ctrl: Value) -> Result<Value, SmsapiError>`

Create a new entity with the given data. Returns the created entity data on `Ok` and `Err` on failure.

```rust
let result = client.blacklist(Value::Noval).create(jo(vec![
]), Value::Noval).unwrap();
```

#### `load(reqmatch: Value, ctrl: Value) -> Result<Value, SmsapiError>`

Load a single entity matching the given criteria. Returns the entity data on `Ok` and `Err` on failure.

```rust
let result = client.blacklist(Value::Noval).load(Value::Noval, Value::Noval).unwrap();
```

#### `remove(reqmatch: Value, ctrl: Value) -> Result<Value, SmsapiError>`

Remove the entity matching the given criteria. `Err` on failure.

```rust
let result = client.blacklist(Value::Noval).remove(jo(vec![("id", Value::str("id"))]), Value::Noval).unwrap();
```

### Common Methods

#### `data(args: Option<&Value>) -> Value`

Get the entity data. Pass `Some(&map)` to set it.

#### `matchv(args: Option<&Value>) -> Value`

Get the entity match criteria. Pass `Some(&map)` to set it.

#### `make() -> Rc<dyn Entity>`

Create a new `BlacklistEntity` instance with the same options.

#### `get_name() -> String`

Return the entity name.


---

## CallbackEntity

```rust
let callback = client.callback(Value::Noval);
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `active` | `bool` | No |  |
| `api_version` | `i64` | No | Version of the callback output format. |
| `id` | `String` | No | Object ID |
| `invalid` | `bool` | No |  |
| `receiver` | `std::collections::HashMap<String, Value>` | No |  |
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

#### `create(reqdata: Value, ctrl: Value) -> Result<Value, SmsapiError>`

Create a new entity with the given data. Returns the created entity data on `Ok` and `Err` on failure.

```rust
let result = client.callback(Value::Noval).create(jo(vec![
]), Value::Noval).unwrap();
```

#### `list(reqmatch: Value, ctrl: Value) -> Result<Value, SmsapiError>`

List entities matching the given criteria. The match is optional — pass `Value::Noval` to list all records. `Ok` is a `Value::List`.

```rust
let results = client.callback(Value::Noval).list(Value::Noval, Value::Noval).unwrap();
if let Value::List(items) = &results {
    for callback in items.borrow().iter() {
        println!("{:?}", callback);
    }
}
```

#### `load(reqmatch: Value, ctrl: Value) -> Result<Value, SmsapiError>`

Load a single entity matching the given criteria. Returns the entity data on `Ok` and `Err` on failure.

```rust
let result = client.callback(Value::Noval).load(jo(vec![("id", Value::str("callback_id"))]), Value::Noval).unwrap();
```

#### `remove(reqmatch: Value, ctrl: Value) -> Result<Value, SmsapiError>`

Remove the entity matching the given criteria. `Err` on failure.

```rust
let result = client.callback(Value::Noval).remove(jo(vec![("id", Value::str("callback_id"))]), Value::Noval).unwrap();
```

#### `update(reqdata: Value, ctrl: Value) -> Result<Value, SmsapiError>`

Update an existing entity. The data must include the entity id. Returns the updated entity data on `Ok`.

```rust
let result = client.callback(Value::Noval).update(jo(vec![
    ("id", Value::str("callback_id")),
    // Fields to update
]), Value::Noval).unwrap();
```

### Common Methods

#### `data(args: Option<&Value>) -> Value`

Get the entity data. Pass `Some(&map)` to set it.

#### `matchv(args: Option<&Value>) -> Value`

Get the entity match criteria. Pass `Some(&map)` to set it.

#### `make() -> Rc<dyn Entity>`

Create a new `CallbackEntity` instance with the same options.

#### `get_name() -> String`

Return the entity name.


---

## ContactEntity

```rust
let contact = client.contact(Value::Noval);
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `birthday_date` | `String` | No |  |
| `city` | `String` | No |  |
| `collection` | `Vec<Value>` | Yes |  |
| `contact_expire_after` | `i64` | Yes | Contact expire after days |
| `contacts_count` | `i64` | Yes |  |
| `country` | `String` | No |  |
| `created_by` | `String` | Yes |  |
| `date_created` | `String` | Yes |  |
| `date_updated` | `String` | Yes |  |
| `description` | `String` | No |  |
| `email` | `String` | No |  |
| `first_name` | `String` | No |  |
| `gender` | `String` | Yes |  |
| `group_id` | `String` | No | Object ID |
| `groups` | `Vec<Value>` | Yes |  |
| `id` | `String` | Yes | Object ID |
| `idx` | `String` | No | User provided resource id |
| `last_name` | `String` | No |  |
| `name` | `String` | Yes | Group name |
| `permissions` | `Vec<Value>` | No |  |
| `phone_number` | `String` | No |  |
| `read` | `bool` | No | Has read permission |
| `send` | `bool` | No | Has send permission |
| `size` | `i64` | Yes |  |
| `source` | `String` | No |  |
| `type` | `String` | No |  |
| `username` | `String` | No |  |
| `value` | `String` | No |  |
| `write` | `bool` | No | Has write permission |

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

#### `create(reqdata: Value, ctrl: Value) -> Result<Value, SmsapiError>`

Create a new entity with the given data. Returns the created entity data on `Ok` and `Err` on failure.

```rust
let result = client.contact(Value::Noval).create(jo(vec![
    ("collection", Value::empty_list()),  // Vec<Value>
    ("contact_expire_after", Value::Num(1.0)),  // i64
    ("contacts_count", Value::Num(1.0)),  // i64
    ("created_by", Value::str("example_created_by")),  // String
    ("date_created", Value::str("example_date_created")),  // String
    ("date_updated", Value::str("example_date_updated")),  // String
    ("gender", Value::str("example_gender")),  // String
    ("groups", Value::empty_list()),  // Vec<Value>
    ("id", Value::str("example_id")),  // String
    ("name", Value::str("example_name")),  // String
    ("size", Value::Num(1.0)),  // i64
]), Value::Noval).unwrap();
```

#### `list(reqmatch: Value, ctrl: Value) -> Result<Value, SmsapiError>`

List entities matching the given criteria. The match is optional — pass `Value::Noval` to list all records. `Ok` is a `Value::List`.

```rust
let results = client.contact(Value::Noval).list(Value::Noval, Value::Noval).unwrap();
if let Value::List(items) = &results {
    for contact in items.borrow().iter() {
        println!("{:?}", contact);
    }
}
```

#### `load(reqmatch: Value, ctrl: Value) -> Result<Value, SmsapiError>`

Load a single entity matching the given criteria. Returns the entity data on `Ok` and `Err` on failure.

```rust
let result = client.contact(Value::Noval).load(jo(vec![("id", Value::str("contact_id"))]), Value::Noval).unwrap();
```

#### `remove(reqmatch: Value, ctrl: Value) -> Result<Value, SmsapiError>`

Remove the entity matching the given criteria. `Err` on failure.

```rust
let result = client.contact(Value::Noval).remove(jo(vec![("id", Value::str("contact_id"))]), Value::Noval).unwrap();
```

#### `update(reqdata: Value, ctrl: Value) -> Result<Value, SmsapiError>`

Update an existing entity. The data must include the entity id. Returns the updated entity data on `Ok`.

```rust
let result = client.contact(Value::Noval).update(jo(vec![
    ("id", Value::str("contact_id")),
    // Fields to update
]), Value::Noval).unwrap();
```

### Common Methods

#### `data(args: Option<&Value>) -> Value`

Get the entity data. Pass `Some(&map)` to set it.

#### `matchv(args: Option<&Value>) -> Value`

Get the entity match criteria. Pass `Some(&map)` to set it.

#### `make() -> Rc<dyn Entity>`

Create a new `ContactEntity` instance with the same options.

#### `get_name() -> String`

Return the entity name.


---

## ContactsFieldEntity

```rust
let contacts_field = client.contacts_field(Value::Noval);
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `birthday_date` | `String` | No |  |
| `city` | `String` | No |  |
| `contact_expire_after` | `i64` | Yes | Contact expire after days |
| `contacts_count` | `i64` | No |  |
| `country` | `String` | No |  |
| `created_by` | `String` | Yes |  |
| `date_created` | `String` | Yes |  |
| `date_updated` | `String` | Yes |  |
| `description` | `String` | No |  |
| `email` | `String` | No |  |
| `first_name` | `String` | No |  |
| `gender` | `String` | Yes |  |
| `group_id` | `String` | No | Object ID |
| `groups` | `Vec<Value>` | Yes |  |
| `id` | `String` | No | Object ID |
| `idx` | `String` | No | User provided resource id |
| `last_name` | `String` | No |  |
| `name` | `String` | No | Group name |
| `permissions` | `Vec<Value>` | No |  |
| `phone_number` | `String` | No |  |
| `read` | `bool` | No | Has read permission |
| `send` | `bool` | No | Has send permission |
| `source` | `String` | No |  |
| `type` | `String` | No |  |
| `username` | `String` | No |  |
| `value` | `String` | No |  |
| `write` | `bool` | No | Has write permission |

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

#### `create(reqdata: Value, ctrl: Value) -> Result<Value, SmsapiError>`

Create a new entity with the given data. Returns the created entity data on `Ok` and `Err` on failure.

```rust
let result = client.contacts_field(Value::Noval).create(jo(vec![
    ("contact_expire_after", Value::Num(1.0)),  // i64
    ("created_by", Value::str("example_created_by")),  // String
    ("date_created", Value::str("example_date_created")),  // String
    ("date_updated", Value::str("example_date_updated")),  // String
    ("gender", Value::str("example_gender")),  // String
    ("groups", Value::empty_list()),  // Vec<Value>
]), Value::Noval).unwrap();
```

#### `list(reqmatch: Value, ctrl: Value) -> Result<Value, SmsapiError>`

List entities matching the given criteria. The match is optional — pass `Value::Noval` to list all records. `Ok` is a `Value::List`.

```rust
let results = client.contacts_field(Value::Noval).list(Value::Noval, Value::Noval).unwrap();
if let Value::List(items) = &results {
    for contacts_field in items.borrow().iter() {
        println!("{:?}", contacts_field);
    }
}
```

#### `remove(reqmatch: Value, ctrl: Value) -> Result<Value, SmsapiError>`

Remove the entity matching the given criteria. `Err` on failure.

```rust
let result = client.contacts_field(Value::Noval).remove(jo(vec![("id", Value::str("id"))]), Value::Noval).unwrap();
```

#### `update(reqdata: Value, ctrl: Value) -> Result<Value, SmsapiError>`

Update an existing entity. The data must include the entity id. Returns the updated entity data on `Ok`.

```rust
let result = client.contacts_field(Value::Noval).update(jo(vec![
    ("id", Value::str("id")),
    // Fields to update
]), Value::Noval).unwrap();
```

### Common Methods

#### `data(args: Option<&Value>) -> Value`

Get the entity data. Pass `Some(&map)` to set it.

#### `matchv(args: Option<&Value>) -> Value`

Get the entity match criteria. Pass `Some(&map)` to set it.

#### `make() -> Rc<dyn Entity>`

Create a new `ContactsFieldEntity` instance with the same options.

#### `get_name() -> String`

Return the entity name.


---

## ContactsFieldOptionEntity

```rust
let contacts_field_option = client.contacts_field_option(Value::Noval);
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `birthday_date` | `String` | No |  |
| `city` | `String` | No |  |
| `contact_expire_after` | `i64` | Yes | Contact expire after days |
| `contacts_count` | `i64` | No |  |
| `country` | `String` | No |  |
| `created_by` | `String` | Yes |  |
| `date_created` | `String` | Yes |  |
| `date_updated` | `String` | Yes |  |
| `description` | `String` | No |  |
| `email` | `String` | No |  |
| `first_name` | `String` | No |  |
| `gender` | `String` | Yes |  |
| `group_id` | `String` | No | Object ID |
| `groups` | `Vec<Value>` | Yes |  |
| `id` | `String` | Yes | Object ID |
| `idx` | `String` | No | User provided resource id |
| `last_name` | `String` | No |  |
| `name` | `String` | No | Group name |
| `permissions` | `Vec<Value>` | No |  |
| `phone_number` | `String` | No |  |
| `read` | `bool` | No | Has read permission |
| `send` | `bool` | No | Has send permission |
| `source` | `String` | No |  |
| `type` | `String` | No |  |
| `username` | `String` | No |  |
| `value` | `String` | No |  |
| `write` | `bool` | No | Has write permission |

### Operations

#### `list(reqmatch: Value, ctrl: Value) -> Result<Value, SmsapiError>`

List entities matching the given criteria. The match is optional — pass `Value::Noval` to list all records. `Ok` is a `Value::List`.

```rust
let results = client.contacts_field_option(Value::Noval).list(Value::Noval, Value::Noval).unwrap();
if let Value::List(items) = &results {
    for contacts_field_option in items.borrow().iter() {
        println!("{:?}", contacts_field_option);
    }
}
```

### Common Methods

#### `data(args: Option<&Value>) -> Value`

Get the entity data. Pass `Some(&map)` to set it.

#### `matchv(args: Option<&Value>) -> Value`

Get the entity match criteria. Pass `Some(&map)` to set it.

#### `make() -> Rc<dyn Entity>`

Create a new `ContactsFieldOptionEntity` instance with the same options.

#### `get_name() -> String`

Return the entity name.


---

## ContactsgroupEntity

```rust
let contactsgroup = client.contactsgroup(Value::Noval);
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `birthday_date` | `String` | No |  |
| `city` | `String` | No |  |
| `contact_expire_after` | `i64` | Yes | Contact expire after days |
| `contacts_count` | `i64` | No |  |
| `country` | `String` | No |  |
| `created_by` | `String` | Yes |  |
| `date_created` | `String` | Yes |  |
| `date_updated` | `String` | Yes |  |
| `description` | `String` | No |  |
| `email` | `String` | No |  |
| `first_name` | `String` | No |  |
| `gender` | `String` | Yes |  |
| `group_id` | `String` | Yes | Object ID |
| `groups` | `Vec<Value>` | Yes |  |
| `id` | `String` | Yes | Object ID |
| `idx` | `String` | No | User provided resource id |
| `last_name` | `String` | No |  |
| `name` | `String` | No | Group name |
| `permissions` | `Vec<Value>` | No |  |
| `phone_number` | `String` | No |  |
| `read` | `bool` | Yes | Has read permission |
| `send` | `bool` | Yes | Has send permission |
| `source` | `String` | No |  |
| `type` | `String` | No |  |
| `username` | `String` | Yes |  |
| `value` | `String` | No |  |
| `write` | `bool` | Yes | Has write permission |

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

#### `create(reqdata: Value, ctrl: Value) -> Result<Value, SmsapiError>`

Create a new entity with the given data. Returns the created entity data on `Ok` and `Err` on failure.

```rust
let result = client.contactsgroup(Value::Noval).create(jo(vec![
    ("contact_expire_after", Value::Num(1.0)),  // i64
    ("created_by", Value::str("example_created_by")),  // String
    ("date_created", Value::str("example_date_created")),  // String
    ("date_updated", Value::str("example_date_updated")),  // String
    ("gender", Value::str("example_gender")),  // String
    ("group_id", Value::str("example_group_id")),  // String
    ("groups", Value::empty_list()),  // Vec<Value>
    ("id", Value::str("example_id")),  // String
    ("read", Value::Bool(true)),  // bool
    ("send", Value::Bool(true)),  // bool
    ("username", Value::str("example_username")),  // String
    ("write", Value::Bool(true)),  // bool
]), Value::Noval).unwrap();
```

#### `list(reqmatch: Value, ctrl: Value) -> Result<Value, SmsapiError>`

List entities matching the given criteria. The match is optional — pass `Value::Noval` to list all records. `Ok` is a `Value::List`.

```rust
let results = client.contactsgroup(Value::Noval).list(Value::Noval, Value::Noval).unwrap();
if let Value::List(items) = &results {
    for contactsgroup in items.borrow().iter() {
        println!("{:?}", contactsgroup);
    }
}
```

#### `remove(reqmatch: Value, ctrl: Value) -> Result<Value, SmsapiError>`

Remove the entity matching the given criteria. `Err` on failure.

```rust
let result = client.contactsgroup(Value::Noval).remove(jo(vec![("group_id", Value::str("group_id"))]), Value::Noval).unwrap();
```

#### `update(reqdata: Value, ctrl: Value) -> Result<Value, SmsapiError>`

Update an existing entity. The data must include the entity id. Returns the updated entity data on `Ok`.

```rust
let result = client.contactsgroup(Value::Noval).update(jo(vec![
    ("group_id", Value::str("group_id")),
    // Fields to update
]), Value::Noval).unwrap();
```

### Common Methods

#### `data(args: Option<&Value>) -> Value`

Get the entity data. Pass `Some(&map)` to set it.

#### `matchv(args: Option<&Value>) -> Value`

Get the entity match criteria. Pass `Some(&map)` to set it.

#### `make() -> Rc<dyn Entity>`

Create a new `ContactsgroupEntity` instance with the same options.

#### `get_name() -> String`

Return the entity name.


---

## ContactstrashEntity

```rust
let contactstrash = client.contactstrash(Value::Noval);
```

### Operations

#### `remove(reqmatch: Value, ctrl: Value) -> Result<Value, SmsapiError>`

Remove the entity matching the given criteria. `Err` on failure.

```rust
let result = client.contactstrash(Value::Noval).remove(Value::Noval, Value::Noval).unwrap();
```

#### `update(reqdata: Value, ctrl: Value) -> Result<Value, SmsapiError>`

Update an existing entity. The data must include the entity id. Returns the updated entity data on `Ok`.

```rust
let result = client.contactstrash(Value::Noval).update(jo(vec![
    // Fields to update
]), Value::Noval).unwrap();
```

### Common Methods

#### `data(args: Option<&Value>) -> Value`

Get the entity data. Pass `Some(&map)` to set it.

#### `matchv(args: Option<&Value>) -> Value`

Get the entity match criteria. Pass `Some(&map)` to set it.

#### `make() -> Rc<dyn Entity>`

Create a new `ContactstrashEntity` instance with the same options.

#### `get_name() -> String`

Return the entity name.


---

## FieldAvailableEntity

```rust
let field_available = client.field_available(Value::Noval);
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `built_in` | `bool` | No |  |
| `id` | `String` | No | Object ID |
| `name` | `String` | No |  |
| `options` | `Vec<Value>` | No |  |
| `type` | `String` | No |  |

### Operations

#### `list(reqmatch: Value, ctrl: Value) -> Result<Value, SmsapiError>`

List entities matching the given criteria. The match is optional — pass `Value::Noval` to list all records. `Ok` is a `Value::List`.

```rust
let results = client.field_available(Value::Noval).list(Value::Noval, Value::Noval).unwrap();
if let Value::List(items) = &results {
    for field_available in items.borrow().iter() {
        println!("{:?}", field_available);
    }
}
```

### Common Methods

#### `data(args: Option<&Value>) -> Value`

Get the entity data. Pass `Some(&map)` to set it.

#### `matchv(args: Option<&Value>) -> Value`

Get the entity match criteria. Pass `Some(&map)` to set it.

#### `make() -> Rc<dyn Entity>`

Create a new `FieldAvailableEntity` instance with the same options.

#### `get_name() -> String`

Return the entity name.


---

## GroupEntity

```rust
let group = client.group(Value::Noval);
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `contact_expire_after` | `i64` | Yes | Contact expire after days |
| `contacts_count` | `i64` | Yes |  |
| `created_by` | `String` | Yes |  |
| `date_created` | `String` | Yes |  |
| `date_updated` | `String` | Yes |  |
| `description` | `String` | Yes |  |
| `id` | `String` | Yes | Object ID |
| `idx` | `String` | No | User provided resource id |
| `name` | `String` | Yes | Group name |
| `permissions` | `Vec<Value>` | No |  |

### Operations

#### `load(reqmatch: Value, ctrl: Value) -> Result<Value, SmsapiError>`

Load a single entity matching the given criteria. Returns the entity data on `Ok` and `Err` on failure.

```rust
let result = client.group(Value::Noval).load(jo(vec![("id", Value::str("group_id"))]), Value::Noval).unwrap();
```

#### `update(reqdata: Value, ctrl: Value) -> Result<Value, SmsapiError>`

Update an existing entity. The data must include the entity id. Returns the updated entity data on `Ok`.

```rust
let result = client.group(Value::Noval).update(jo(vec![
    ("id", Value::str("group_id")),
    // Fields to update
]), Value::Noval).unwrap();
```

### Common Methods

#### `data(args: Option<&Value>) -> Value`

Get the entity data. Pass `Some(&map)` to set it.

#### `matchv(args: Option<&Value>) -> Value`

Get the entity match criteria. Pass `Some(&map)` to set it.

#### `make() -> Rc<dyn Entity>`

Create a new `GroupEntity` instance with the same options.

#### `get_name() -> String`

Return the entity name.


---

## MfaCodeEntity

```rust
let mfa_code = client.mfa_code(Value::Noval);
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `content` | `String` | No | Custom content that must contain placeholder [%code%] |
| `fast` | `Value` | No |  |
| `from` | `String` | No | Sendername |
| `phone_number` | `String` | Yes |  |

### Operations

#### `create(reqdata: Value, ctrl: Value) -> Result<Value, SmsapiError>`

Create a new entity with the given data. Returns the created entity data on `Ok` and `Err` on failure.

```rust
let result = client.mfa_code(Value::Noval).create(jo(vec![
    ("phone_number", Value::str("example_phone_number")),  // String
]), Value::Noval).unwrap();
```

### Common Methods

#### `data(args: Option<&Value>) -> Value`

Get the entity data. Pass `Some(&map)` to set it.

#### `matchv(args: Option<&Value>) -> Value`

Get the entity match criteria. Pass `Some(&map)` to set it.

#### `make() -> Rc<dyn Entity>`

Create a new `MfaCodeEntity` instance with the same options.

#### `get_name() -> String`

Return the entity name.


---

## OptOutEntity

```rust
let opt_out = client.opt_out(Value::Noval);
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `date` | `String` | No |  |
| `id` | `String` | No |  |
| `links` | `Vec<Value>` | No |  |
| `phoneNumber` | `i64` | No |  |

### Operations

#### `list(reqmatch: Value, ctrl: Value) -> Result<Value, SmsapiError>`

List entities matching the given criteria. The match is optional — pass `Value::Noval` to list all records. `Ok` is a `Value::List`.

```rust
let results = client.opt_out(Value::Noval).list(Value::Noval, Value::Noval).unwrap();
if let Value::List(items) = &results {
    for opt_out in items.borrow().iter() {
        println!("{:?}", opt_out);
    }
}
```

#### `remove(reqmatch: Value, ctrl: Value) -> Result<Value, SmsapiError>`

Remove the entity matching the given criteria. `Err` on failure.

```rust
let result = client.opt_out(Value::Noval).remove(jo(vec![("id", Value::str("id"))]), Value::Noval).unwrap();
```

### Common Methods

#### `data(args: Option<&Value>) -> Value`

Get the entity data. Pass `Some(&map)` to set it.

#### `matchv(args: Option<&Value>) -> Value`

Get the entity match criteria. Pass `Some(&map)` to set it.

#### `make() -> Rc<dyn Entity>`

Create a new `OptOutEntity` instance with the same options.

#### `get_name() -> String`

Return the entity name.


---

## OptOutSettingEntity

```rust
let opt_out_setting = client.opt_out_setting(Value::Noval);
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `brand` | `String` | No |  |

### Operations

#### `load(reqmatch: Value, ctrl: Value) -> Result<Value, SmsapiError>`

Load a single entity matching the given criteria. Returns the entity data on `Ok` and `Err` on failure.

```rust
let result = client.opt_out_setting(Value::Noval).load(Value::Noval, Value::Noval).unwrap();
```

#### `update(reqdata: Value, ctrl: Value) -> Result<Value, SmsapiError>`

Update an existing entity. The data must include the entity id. Returns the updated entity data on `Ok`.

```rust
let result = client.opt_out_setting(Value::Noval).update(jo(vec![
    // Fields to update
]), Value::Noval).unwrap();
```

### Common Methods

#### `data(args: Option<&Value>) -> Value`

Get the entity data. Pass `Some(&map)` to set it.

#### `matchv(args: Option<&Value>) -> Value`

Get the entity match criteria. Pass `Some(&map)` to set it.

#### `make() -> Rc<dyn Entity>`

Create a new `OptOutSettingEntity` instance with the same options.

#### `get_name() -> String`

Return the entity name.


---

## PermissionEntity

```rust
let permission = client.permission(Value::Noval);
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `group_id` | `String` | Yes | Object ID |
| `id` | `String` | No |  |
| `read` | `bool` | Yes | Has read permission |
| `send` | `bool` | Yes | Has send permission |
| `username` | `String` | Yes |  |
| `write` | `bool` | Yes | Has write permission |

### Operations

#### `create(reqdata: Value, ctrl: Value) -> Result<Value, SmsapiError>`

Create a new entity with the given data. Returns the created entity data on `Ok` and `Err` on failure.

```rust
let result = client.permission(Value::Noval).create(jo(vec![
    ("group_id", Value::str("example_group_id")),  // String
    ("read", Value::Bool(true)),  // bool
    ("send", Value::Bool(true)),  // bool
    ("username", Value::str("example_username")),  // String
    ("write", Value::Bool(true)),  // bool
]), Value::Noval).unwrap();
```

#### `load(reqmatch: Value, ctrl: Value) -> Result<Value, SmsapiError>`

Load a single entity matching the given criteria. Returns the entity data on `Ok` and `Err` on failure.

```rust
let result = client.permission(Value::Noval).load(jo(vec![("id", Value::str("permission_id")), ("group_id", Value::str("group_id")), ("username", Value::str("username"))]), Value::Noval).unwrap();
```

### Common Methods

#### `data(args: Option<&Value>) -> Value`

Get the entity data. Pass `Some(&map)` to set it.

#### `matchv(args: Option<&Value>) -> Value`

Get the entity match criteria. Pass `Some(&map)` to set it.

#### `make() -> Rc<dyn Entity>`

Create a new `PermissionEntity` instance with the same options.

#### `get_name() -> String`

Return the entity name.


---

## PingEntity

```rust
let ping = client.ping(Value::Noval);
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `authorized` | `bool` | Yes |  |
| `unavailable` | `Vec<Value>` | Yes |  |

### Operations

#### `list(reqmatch: Value, ctrl: Value) -> Result<Value, SmsapiError>`

List entities matching the given criteria. The match is optional — pass `Value::Noval` to list all records. `Ok` is a `Value::List`.

```rust
let results = client.ping(Value::Noval).list(Value::Noval, Value::Noval).unwrap();
if let Value::List(items) = &results {
    for ping in items.borrow().iter() {
        println!("{:?}", ping);
    }
}
```

### Common Methods

#### `data(args: Option<&Value>) -> Value`

Get the entity data. Pass `Some(&map)` to set it.

#### `matchv(args: Option<&Value>) -> Value`

Get the entity match criteria. Pass `Some(&map)` to set it.

#### `make() -> Rc<dyn Entity>`

Create a new `PingEntity` instance with the same options.

#### `get_name() -> String`

Return the entity name.


---

## ProfileEntity

```rust
let profile = client.profile(Value::Noval);
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `email` | `String` | Yes |  |
| `name` | `String` | Yes |  |
| `payment_type` | `String` | Yes |  |
| `phone_number` | `i64` | Yes |  |
| `points` | `f64` | No |  |
| `user_type` | `String` | Yes |  |
| `username` | `String` | Yes |  |

### Operations

#### `list(reqmatch: Value, ctrl: Value) -> Result<Value, SmsapiError>`

List entities matching the given criteria. The match is optional — pass `Value::Noval` to list all records. `Ok` is a `Value::List`.

```rust
let results = client.profile(Value::Noval).list(Value::Noval, Value::Noval).unwrap();
if let Value::List(items) = &results {
    for profile in items.borrow().iter() {
        println!("{:?}", profile);
    }
}
```

#### `load(reqmatch: Value, ctrl: Value) -> Result<Value, SmsapiError>`

Load a single entity matching the given criteria. Returns the entity data on `Ok` and `Err` on failure.

```rust
let result = client.profile(Value::Noval).load(Value::Noval, Value::Noval).unwrap();
```

### Common Methods

#### `data(args: Option<&Value>) -> Value`

Get the entity data. Pass `Some(&map)` to set it.

#### `matchv(args: Option<&Value>) -> Value`

Get the entity match criteria. Pass `Some(&map)` to set it.

#### `make() -> Rc<dyn Entity>`

Create a new `ProfileEntity` instance with the same options.

#### `get_name() -> String`

Return the entity name.


---

## RcsEntity

```rust
let rcs = client.rcs(Value::Noval);
```

### Operations

#### `list(reqmatch: Value, ctrl: Value) -> Result<Value, SmsapiError>`

List entities matching the given criteria. The match is optional — pass `Value::Noval` to list all records. `Ok` is a `Value::List`.

```rust
let results = client.rcs(Value::Noval).list(Value::Noval, Value::Noval).unwrap();
if let Value::List(items) = &results {
    for rcs in items.borrow().iter() {
        println!("{:?}", rcs);
    }
}
```

### Common Methods

#### `data(args: Option<&Value>) -> Value`

Get the entity data. Pass `Some(&map)` to set it.

#### `matchv(args: Option<&Value>) -> Value`

Get the entity match criteria. Pass `Some(&map)` to set it.

#### `make() -> Rc<dyn Entity>`

Create a new `RcsEntity` instance with the same options.

#### `get_name() -> String`

Return the entity name.


---

## SendernameEntity

```rust
let sendername = client.sendername(Value::Noval);
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `created_at` | `String` | No |  |
| `id` | `String` | No |  |
| `is_default` | `bool` | No |  |
| `sender` | `String` | No | Sendername |
| `status` | `String` | No |  |

### Operations

#### `create(reqdata: Value, ctrl: Value) -> Result<Value, SmsapiError>`

Create a new entity with the given data. Returns the created entity data on `Ok` and `Err` on failure.

```rust
let result = client.sendername(Value::Noval).create(jo(vec![
]), Value::Noval).unwrap();
```

#### `list(reqmatch: Value, ctrl: Value) -> Result<Value, SmsapiError>`

List entities matching the given criteria. The match is optional — pass `Value::Noval` to list all records. `Ok` is a `Value::List`.

```rust
let results = client.sendername(Value::Noval).list(Value::Noval, Value::Noval).unwrap();
if let Value::List(items) = &results {
    for sendername in items.borrow().iter() {
        println!("{:?}", sendername);
    }
}
```

#### `load(reqmatch: Value, ctrl: Value) -> Result<Value, SmsapiError>`

Load a single entity matching the given criteria. Returns the entity data on `Ok` and `Err` on failure.

```rust
let result = client.sendername(Value::Noval).load(jo(vec![("id", Value::str("sendername_id"))]), Value::Noval).unwrap();
```

### Common Methods

#### `data(args: Option<&Value>) -> Value`

Get the entity data. Pass `Some(&map)` to set it.

#### `matchv(args: Option<&Value>) -> Value`

Get the entity match criteria. Pass `Some(&map)` to set it.

#### `make() -> Rc<dyn Entity>`

Create a new `SendernameEntity` instance with the same options.

#### `get_name() -> String`

Return the entity name.


---

## SendernameStatementEntity

```rust
let sendername_statement = client.sendername_statement(Value::Noval);
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `content` | `String` | No |  |
| `statements` | `Vec<Value>` | No |  |
| `title` | `String` | No |  |

### Operations

#### `list(reqmatch: Value, ctrl: Value) -> Result<Value, SmsapiError>`

List entities matching the given criteria. The match is optional — pass `Value::Noval` to list all records. `Ok` is a `Value::List`.

```rust
let results = client.sendername_statement(Value::Noval).list(Value::Noval, Value::Noval).unwrap();
if let Value::List(items) = &results {
    for sendername_statement in items.borrow().iter() {
        println!("{:?}", sendername_statement);
    }
}
```

### Common Methods

#### `data(args: Option<&Value>) -> Value`

Get the entity data. Pass `Some(&map)` to set it.

#### `matchv(args: Option<&Value>) -> Value`

Get the entity match criteria. Pass `Some(&map)` to set it.

#### `make() -> Rc<dyn Entity>`

Create a new `SendernameStatementEntity` instance with the same options.

#### `get_name() -> String`

Return the entity name.


---

## SentRcsMessageEntity

```rust
let sent_rcs_message = client.sent_rcs_message(Value::Noval);
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `content` | `std::collections::HashMap<String, Value>` | No | RCS message content in RCS JSON format. |
| `phone_number` | `String` | Yes | Recipient phone number (e.g. |
| `sender` | `Value` | Yes |  |
| `text` | `String` | No | Plain text message content. |

### Operations

#### `create(reqdata: Value, ctrl: Value) -> Result<Value, SmsapiError>`

Create a new entity with the given data. Returns the created entity data on `Ok` and `Err` on failure.

```rust
let result = client.sent_rcs_message(Value::Noval).create(jo(vec![
    ("phone_number", Value::str("example_phone_number")),  // String
    ("sender", Value::str("example_sender")),  // Value
]), Value::Noval).unwrap();
```

### Common Methods

#### `data(args: Option<&Value>) -> Value`

Get the entity data. Pass `Some(&map)` to set it.

#### `matchv(args: Option<&Value>) -> Value`

Get the entity match criteria. Pass `Some(&map)` to set it.

#### `make() -> Rc<dyn Entity>`

Create a new `SentRcsMessageEntity` instance with the same options.

#### `get_name() -> String`

Return the entity name.


---

## ShipmentCountryVolumeEntity

```rust
let shipment_country_volume = client.shipment_country_volume(Value::Noval);
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `country_code` | `String` | No |  |
| `country_limit` | `i64` | No |  |
| `country_name` | `String` | No |  |
| `usage` | `i64` | No |  |

### Operations

#### `list(reqmatch: Value, ctrl: Value) -> Result<Value, SmsapiError>`

List entities matching the given criteria. The match is optional — pass `Value::Noval` to list all records. `Ok` is a `Value::List`.

```rust
let results = client.shipment_country_volume(Value::Noval).list(Value::Noval, Value::Noval).unwrap();
if let Value::List(items) = &results {
    for shipment_country_volume in items.borrow().iter() {
        println!("{:?}", shipment_country_volume);
    }
}
```

### Common Methods

#### `data(args: Option<&Value>) -> Value`

Get the entity data. Pass `Some(&map)` to set it.

#### `matchv(args: Option<&Value>) -> Value`

Get the entity match criteria. Pass `Some(&map)` to set it.

#### `make() -> Rc<dyn Entity>`

Create a new `ShipmentCountryVolumeEntity` instance with the same options.

#### `get_name() -> String`

Return the entity name.


---

## ShortUrlEntity

```rust
let short_url = client.short_url(Value::Noval);
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `description` | `String` | No |  |
| `expire` | `String` | No |  |
| `filename` | `String` | No |  |
| `hits` | `i64` | No |  |
| `hits_unique` | `i64` | No |  |
| `id` | `String` | No |  |
| `name` | `String` | No |  |
| `short_url` | `String` | No | WHATWG URL compliant |
| `type` | `String` | No |  |
| `url` | `String` | No | WHATWG URL compliant |

### Operations

#### `create(reqdata: Value, ctrl: Value) -> Result<Value, SmsapiError>`

Create a new entity with the given data. Returns the created entity data on `Ok` and `Err` on failure.

```rust
let result = client.short_url(Value::Noval).create(jo(vec![
]), Value::Noval).unwrap();
```

#### `list(reqmatch: Value, ctrl: Value) -> Result<Value, SmsapiError>`

List entities matching the given criteria. The match is optional — pass `Value::Noval` to list all records. `Ok` is a `Value::List`.

```rust
let results = client.short_url(Value::Noval).list(Value::Noval, Value::Noval).unwrap();
if let Value::List(items) = &results {
    for short_url in items.borrow().iter() {
        println!("{:?}", short_url);
    }
}
```

#### `load(reqmatch: Value, ctrl: Value) -> Result<Value, SmsapiError>`

Load a single entity matching the given criteria. Returns the entity data on `Ok` and `Err` on failure.

```rust
let result = client.short_url(Value::Noval).load(jo(vec![("id", Value::str("short_url_id"))]), Value::Noval).unwrap();
```

#### `remove(reqmatch: Value, ctrl: Value) -> Result<Value, SmsapiError>`

Remove the entity matching the given criteria. `Err` on failure.

```rust
let result = client.short_url(Value::Noval).remove(jo(vec![("id", Value::str("short_url_id"))]), Value::Noval).unwrap();
```

#### `update(reqdata: Value, ctrl: Value) -> Result<Value, SmsapiError>`

Update an existing entity. The data must include the entity id. Returns the updated entity data on `Ok`.

```rust
let result = client.short_url(Value::Noval).update(jo(vec![
    ("id", Value::str("short_url_id")),
    // Fields to update
]), Value::Noval).unwrap();
```

### Common Methods

#### `data(args: Option<&Value>) -> Value`

Get the entity data. Pass `Some(&map)` to set it.

#### `matchv(args: Option<&Value>) -> Value`

Get the entity match criteria. Pass `Some(&map)` to set it.

#### `make() -> Rc<dyn Entity>`

Create a new `ShortUrlEntity` instance with the same options.

#### `get_name() -> String`

Return the entity name.


---

## SmsdoEntity

```rust
let smsdo = client.smsdo(Value::Noval);
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `allow_duplicates` | `i64` | No | When parameter allow_duplicates is set to "1" allows to send message to duplicated numbers in one request (useful i.e. |
| `check_idx` | `Value` | No | When parameter check_idx is set to „1” prevents from sending more than one message with the same idx in last 24h. |
| `date` | `Value` | No | Date in UNIX timestamp (&date=1287734110) or in ISO 8601 (&date=2012-05-10T08:40:27+00:00) when message will be sent (&date=1287734110). |
| `date_validate` | `i64` | No | When parameter date_validate is set to "1" checks if date if given in proper format. |
| `details` | `Value` | No | When details parameter is set to "1" more details in response will be displayed (message length and sms count). |
| `encoding` | `String` | No | This parameter describes the encoding of the message text. |
| `expiration_date` | `Value` | No | Message expiration date (in UNIX timestamp or in ISO 8601) is a date after which message won't be delivered if it wasn't delivered yet. |
| `fallback` | `Vec<Value>` | No | Enable fallback in case sms sending fails |
| `fast` | `i64` | No | Setting this parameter to „1” will result in sending message with the highest priority which ensures the quickest possible time of delivery. |
| `flash` | `i64` | No | Sending a message in flash mode can be activated by setting this parameter to "1". |
| `format` | `String` | No | Parameter &format=json causes, that response is sending in JSON format. |
| `from` | `String` | No | Name of the sender. |
| `group` | `String` | No | Name of the group from the contacts database to which message should be sent to. |
| `idx` | `String` | No | Optional custom value sent with SMS and sent back in CALLBACK. |
| `max_parts` | `i64` | No | Defines maximum message parts allowed, maximum value allowed is 6. |
| `message` | `String` | No | The message text. |
| `normalize` | `i64` | No | When parameter normalize is set to „1” special chars in message will be replaced with their equivalents (ê-e, ñ-n, ý-y ...). |
| `notify_url` | `String` | No | Parameter allows to set CALLBACK URL for message from request. |
| `test` | `Value` | No | When parameter test is set to "1" message won't be sent but response will be displayed, there is no charge for such test messages. |
| `time_restriction` | `String` | No | Sets the behavior when you try to ship in hours / dates that do not match the settings in your account. |
| `to` | `String` | No | Recipients' mobile phone numbers (i.e. |

### Operations

#### `create(reqdata: Value, ctrl: Value) -> Result<Value, SmsapiError>`

Create a new entity with the given data. Returns the created entity data on `Ok` and `Err` on failure.

```rust
let result = client.smsdo(Value::Noval).create(jo(vec![
]), Value::Noval).unwrap();
```

### Common Methods

#### `data(args: Option<&Value>) -> Value`

Get the entity data. Pass `Some(&map)` to set it.

#### `matchv(args: Option<&Value>) -> Value`

Get the entity match criteria. Pass `Some(&map)` to set it.

#### `make() -> Rc<dyn Entity>`

Create a new `SmsdoEntity` instance with the same options.

#### `get_name() -> String`

Return the entity name.


---

## SmssendernameEntity

```rust
let smssendername = client.smssendername(Value::Noval);
```

### Operations

#### `create(reqdata: Value, ctrl: Value) -> Result<Value, SmsapiError>`

Create a new entity with the given data. Returns the created entity data on `Ok` and `Err` on failure.

```rust
let result = client.smssendername(Value::Noval).create(jo(vec![
    ("sendername_id", Value::str("example_sendername_id")),  // String
]), Value::Noval).unwrap();
```

#### `remove(reqmatch: Value, ctrl: Value) -> Result<Value, SmsapiError>`

Remove the entity matching the given criteria. `Err` on failure.

```rust
let result = client.smssendername(Value::Noval).remove(jo(vec![("sender", Value::str("sender"))]), Value::Noval).unwrap();
```

### Common Methods

#### `data(args: Option<&Value>) -> Value`

Get the entity data. Pass `Some(&map)` to set it.

#### `matchv(args: Option<&Value>) -> Value`

Get the entity match criteria. Pass `Some(&map)` to set it.

#### `make() -> Rc<dyn Entity>`

Create a new `SmssendernameEntity` instance with the same options.

#### `get_name() -> String`

Return the entity name.


---

## SmstemplateEntity

```rust
let smstemplate = client.smstemplate(Value::Noval);
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | `String` | No |  |

### Operations

#### `remove(reqmatch: Value, ctrl: Value) -> Result<Value, SmsapiError>`

Remove the entity matching the given criteria. `Err` on failure.

```rust
let result = client.smstemplate(Value::Noval).remove(jo(vec![("id", Value::str("id"))]), Value::Noval).unwrap();
```

### Common Methods

#### `data(args: Option<&Value>) -> Value`

Get the entity data. Pass `Some(&map)` to set it.

#### `matchv(args: Option<&Value>) -> Value`

Get the entity match criteria. Pass `Some(&map)` to set it.

#### `make() -> Rc<dyn Entity>`

Create a new `SmstemplateEntity` instance with the same options.

#### `get_name() -> String`

Return the entity name.


---

## SubuserEntity

```rust
let subuser = client.subuser(Value::Noval);
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `active` | `bool` | No |  |
| `credentials` | `std::collections::HashMap<String, Value>` | Yes |  |
| `description` | `String` | No |  |
| `id` | `String` | No | Object ID |
| `points` | `std::collections::HashMap<String, Value>` | No |  |
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

#### `create(reqdata: Value, ctrl: Value) -> Result<Value, SmsapiError>`

Create a new entity with the given data. Returns the created entity data on `Ok` and `Err` on failure.

```rust
let result = client.subuser(Value::Noval).create(jo(vec![
    ("credentials", Value::empty_map()),  // std::collections::HashMap<String, Value>
]), Value::Noval).unwrap();
```

#### `list(reqmatch: Value, ctrl: Value) -> Result<Value, SmsapiError>`

List entities matching the given criteria. The match is optional — pass `Value::Noval` to list all records. `Ok` is a `Value::List`.

```rust
let results = client.subuser(Value::Noval).list(Value::Noval, Value::Noval).unwrap();
if let Value::List(items) = &results {
    for subuser in items.borrow().iter() {
        println!("{:?}", subuser);
    }
}
```

#### `load(reqmatch: Value, ctrl: Value) -> Result<Value, SmsapiError>`

Load a single entity matching the given criteria. Returns the entity data on `Ok` and `Err` on failure.

```rust
let result = client.subuser(Value::Noval).load(jo(vec![("id", Value::str("subuser_id"))]), Value::Noval).unwrap();
```

#### `remove(reqmatch: Value, ctrl: Value) -> Result<Value, SmsapiError>`

Remove the entity matching the given criteria. `Err` on failure.

```rust
let result = client.subuser(Value::Noval).remove(jo(vec![("id", Value::str("subuser_id"))]), Value::Noval).unwrap();
```

#### `update(reqdata: Value, ctrl: Value) -> Result<Value, SmsapiError>`

Update an existing entity. The data must include the entity id. Returns the updated entity data on `Ok`.

```rust
let result = client.subuser(Value::Noval).update(jo(vec![
    ("id", Value::str("subuser_id")),
    // Fields to update
]), Value::Noval).unwrap();
```

### Common Methods

#### `data(args: Option<&Value>) -> Value`

Get the entity data. Pass `Some(&map)` to set it.

#### `matchv(args: Option<&Value>) -> Value`

Get the entity match criteria. Pass `Some(&map)` to set it.

#### `make() -> Rc<dyn Entity>`

Create a new `SubuserEntity` instance with the same options.

#### `get_name() -> String`

Return the entity name.


---

## TemplateEntity

```rust
let template = client.template(Value::Noval);
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | `String` | No |  |
| `name` | `String` | No |  |
| `normalize` | `bool` | No |  |
| `template` | `String` | No |  |

### Operations

#### `create(reqdata: Value, ctrl: Value) -> Result<Value, SmsapiError>`

Create a new entity with the given data. Returns the created entity data on `Ok` and `Err` on failure.

```rust
let result = client.template(Value::Noval).create(jo(vec![
]), Value::Noval).unwrap();
```

#### `list(reqmatch: Value, ctrl: Value) -> Result<Value, SmsapiError>`

List entities matching the given criteria. The match is optional — pass `Value::Noval` to list all records. `Ok` is a `Value::List`.

```rust
let results = client.template(Value::Noval).list(Value::Noval, Value::Noval).unwrap();
if let Value::List(items) = &results {
    for template in items.borrow().iter() {
        println!("{:?}", template);
    }
}
```

#### `load(reqmatch: Value, ctrl: Value) -> Result<Value, SmsapiError>`

Load a single entity matching the given criteria. Returns the entity data on `Ok` and `Err` on failure.

```rust
let result = client.template(Value::Noval).load(jo(vec![("id", Value::str("template_id"))]), Value::Noval).unwrap();
```

#### `update(reqdata: Value, ctrl: Value) -> Result<Value, SmsapiError>`

Update an existing entity. The data must include the entity id. Returns the updated entity data on `Ok`.

```rust
let result = client.template(Value::Noval).update(jo(vec![
    ("id", Value::str("template_id")),
    // Fields to update
]), Value::Noval).unwrap();
```

### Common Methods

#### `data(args: Option<&Value>) -> Value`

Get the entity data. Pass `Some(&map)` to set it.

#### `matchv(args: Option<&Value>) -> Value`

Get the entity match criteria. Pass `Some(&map)` to set it.

#### `make() -> Rc<dyn Entity>`

Create a new `TemplateEntity` instance with the same options.

#### `get_name() -> String`

Return the entity name.


---

## UserRcsSenderCollectionEntity

```rust
let user_rcs_sender_collection = client.user_rcs_sender_collection(Value::Noval);
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

#### `list(reqmatch: Value, ctrl: Value) -> Result<Value, SmsapiError>`

List entities matching the given criteria. The match is optional — pass `Value::Noval` to list all records. `Ok` is a `Value::List`.

```rust
let results = client.user_rcs_sender_collection(Value::Noval).list(Value::Noval, Value::Noval).unwrap();
if let Value::List(items) = &results {
    for user_rcs_sender_collection in items.borrow().iter() {
        println!("{:?}", user_rcs_sender_collection);
    }
}
```

### Common Methods

#### `data(args: Option<&Value>) -> Value`

Get the entity data. Pass `Some(&map)` to set it.

#### `matchv(args: Option<&Value>) -> Value`

Get the entity match criteria. Pass `Some(&map)` to set it.

#### `make() -> Rc<dyn Entity>`

Create a new `UserRcsSenderCollectionEntity` instance with the same options.

#### `get_name() -> String`

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

```rust
let client = SmsapiSDK::new(jo(vec![
    ("feature", jo(vec![
        ("audit", jo(vec![("active", Value::Bool(true))])),
        ("cache", jo(vec![("active", Value::Bool(true))])),
        ("clienttrack", jo(vec![("active", Value::Bool(true))])),
        ("cost", jo(vec![("active", Value::Bool(true))])),
        ("debug", jo(vec![("active", Value::Bool(true))])),
        ("idempotency", jo(vec![("active", Value::Bool(true))])),
        ("log", jo(vec![("active", Value::Bool(true))])),
        ("metrics", jo(vec![("active", Value::Bool(true))])),
        ("netsim", jo(vec![("active", Value::Bool(true))])),
        ("paging", jo(vec![("active", Value::Bool(true))])),
        ("proxy", jo(vec![("active", Value::Bool(true))])),
        ("ratelimit", jo(vec![("active", Value::Bool(true))])),
        ("rbac", jo(vec![("active", Value::Bool(true))])),
        ("retry", jo(vec![("active", Value::Bool(true))])),
        ("secrets", jo(vec![("active", Value::Bool(true))])),
        ("streaming", jo(vec![("active", Value::Bool(true))])),
        ("telemetry", jo(vec![("active", Value::Bool(true))])),
        ("test", jo(vec![("active", Value::Bool(true))])),
        ("timeout", jo(vec![("active", Value::Bool(true))])),
        ("validate", jo(vec![("active", Value::Bool(true))])),
    ])),
]));
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

