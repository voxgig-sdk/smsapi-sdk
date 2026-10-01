# Smsapi Rust SDK

An MCP server and CLI for the SMSAPI REST API, plus clients in 20 languages and a pandas data layer, generated from SMSAPI's public OpenAPI spec so AI agents can reach SMSAPI the way the official SDKs already let developers.

The Rust SDK for the Smsapi API — an entity-oriented client following idiomatic Rust conventions.

The SDK exposes the API as capitalised, semantic **Entities** — for example `client.available(Value::Noval)` — each
carrying a small, uniform set of operations (`list`, `load`, `create`, `update`, `remove`) instead of raw URL
paths and query strings. You work with named resources and verbs, which
keeps the cognitive load low.

> Other languages, the CLI, and MCP server live alongside this one — see
> the [top-level README](../README.md).


## Install
This crate is not yet published to crates.io. Depend on it from the GitHub
release tag (`rust/vX.Y.Z`, see [Releases](https://github.com/voxgig-sdk/smsapi-sdk/releases)) or
from a source checkout by adding it to your `Cargo.toml`:

```toml
[dependencies]
# From a source checkout:
voxgig-smsapi-sdk = { path = "../rust" }

# Or from the git release tag:
# voxgig-smsapi-sdk = { git = "<repo-url>", tag = "rust/vX.Y.Z" }
```


## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record.

### 1. Create a client

```rust
use smsapi_sdk::{getp, jo, SmsapiSDK, Value};

let client = SmsapiSDK::new(jo(vec![
    ("apikey", Value::str(std::env::var("SMSAPI_APIKEY").unwrap_or_default())),
]));
```

### 2. List available records

`list()` returns a `Value::List` of records and returns `Err` on
failure — match on the `Result`.

```rust
match client.available(Value::Noval).list(Value::Noval, Value::Noval) {
    Ok(availables) => {
        if let Value::List(items) = &availables {
            for available in items.borrow().iter() {
                println!("{:?}", available);
            }
        }
    }
    Err(err) => eprintln!("list failed: {}", err),
}
```

### 3. Load a permission

Permission is nested under group, so provide the `group_id`.
`load()` returns the bare record and returns `Err` on failure.

```rust
match client.permission(Value::Noval).load(jo(vec![("group_id", Value::str("example_group_id")), ("username", Value::str("example_username")), ("id", Value::str("example_id"))]), Value::Noval) {
    Ok(permission) => println!("{:?}", permission),
    Err(err) => eprintln!("load failed: {}", err),
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

```rust
let result = client.direct(jo(vec![
    ("path", Value::str("/api/resource/{id}")),
    ("method", Value::str("GET")),
    ("params", jo(vec![("id", Value::str("example"))])),
])).unwrap();

if getp(&result, "ok") == Value::Bool(true) {
    println!("{:?}", getp(&result, "status"));  // 200
    println!("{:?}", getp(&result, "data"));    // response body
} else {
    // A non-2xx response carries status + data (the error body); a
    // transport-level failure carries err instead. Only one is present.
    println!("{:?} {:?}", getp(&result, "status"), getp(&result, "err"));
}
```

### Prepare a request without sending it

```rust
// prepare() returns the fetch definition on Ok and Err on failure.
let fetchdef = client.prepare(jo(vec![
    ("path", Value::str("/api/resource/{id}")),
    ("method", Value::str("DELETE")),
    ("params", jo(vec![("id", Value::str("example"))])),
])).unwrap();

println!("{:?}", getp(&fetchdef, "url"));
println!("{:?}", getp(&fetchdef, "method"));
println!("{:?}", getp(&fetchdef, "headers"));
```

### Use test mode

Create a mock client for unit testing — no server required:

```rust
let client = test_sdk(Value::Noval, Value::Noval);

// Entity ops return the bare record on Ok and Err on failure.
let permission = client.permission(Value::Noval).load(jo(vec![("id", Value::str("test01"))]), Value::Noval).unwrap();
// permission contains the mock response record
```

### Point at a different server

Override the base URL to reach a local or staging server:

```rust
let client = SmsapiSDK::new(jo(vec![
    ("base", Value::str("http://localhost:8080")),
]));
```

### Run live tests

Create a `.env.local` file at the crate root:

```
SMSAPI_TEST_LIVE=TRUE
SMSAPI_APIKEY=<your-key>
```

Then run:

```bash
cd rust && cargo test
```


## Reference

### SmsapiSDK

```rust
use smsapi_sdk::{SmsapiSDK, Value};

let client = SmsapiSDK::new(options);
```

Creates a new SDK client. `options` is a `Value` map (`Value::Noval` for
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

```rust
use smsapi_sdk::{test_sdk, Value};

let client = test_sdk(testopts, sdkopts);
```

Creates a test-mode client with mock transport. Both arguments may be
`Value::Noval`.

### SmsapiSDK methods

| Method | Signature | Description |
| --- | --- | --- |
| `options_map` | `() -> Value` | Deep copy of the current SDK options. |
| `get_utility` | `() -> Rc<Utility>` | Copy of the SDK utility object. |
| `prepare` | `(fetchargs: Value) -> Result<Value, SmsapiError>` | Build an HTTP request definition without sending. |
| `direct` | `(fetchargs: Value) -> Result<Value, SmsapiError>` | Build and send an HTTP request. `Ok` is a result map (branch on `ok`). |
| `available` | `(entopts: Value) -> Rc<AvailableEntity>` | Create an Available entity instance. |
| `blacklist` | `(entopts: Value) -> Rc<BlacklistEntity>` | Create a Blacklist entity instance. |
| `callback` | `(entopts: Value) -> Rc<CallbackEntity>` | Create a Callback entity instance. |
| `contact` | `(entopts: Value) -> Rc<ContactEntity>` | Create a Contact entity instance. |
| `contacts_field` | `(entopts: Value) -> Rc<ContactsFieldEntity>` | Create a ContactsField entity instance. |
| `contacts_field_option` | `(entopts: Value) -> Rc<ContactsFieldOptionEntity>` | Create a ContactsFieldOption entity instance. |
| `contactsgroup` | `(entopts: Value) -> Rc<ContactsgroupEntity>` | Create a Contactsgroup entity instance. |
| `contactstrash` | `(entopts: Value) -> Rc<ContactstrashEntity>` | Create a Contactstrash entity instance. |
| `field_available` | `(entopts: Value) -> Rc<FieldAvailableEntity>` | Create a FieldAvailable entity instance. |
| `group` | `(entopts: Value) -> Rc<GroupEntity>` | Create a Group entity instance. |
| `mfa_code` | `(entopts: Value) -> Rc<MfaCodeEntity>` | Create a MfaCode entity instance. |
| `opt_out` | `(entopts: Value) -> Rc<OptOutEntity>` | Create an OptOut entity instance. |
| `opt_out_setting` | `(entopts: Value) -> Rc<OptOutSettingEntity>` | Create an OptOutSetting entity instance. |
| `permission` | `(entopts: Value) -> Rc<PermissionEntity>` | Create a Permission entity instance. |
| `ping` | `(entopts: Value) -> Rc<PingEntity>` | Create a Ping entity instance. |
| `profile` | `(entopts: Value) -> Rc<ProfileEntity>` | Create a Profile entity instance. |
| `rcs` | `(entopts: Value) -> Rc<RcsEntity>` | Create a Rcs entity instance. |
| `sendername` | `(entopts: Value) -> Rc<SendernameEntity>` | Create a Sendername entity instance. |
| `sendername_statement` | `(entopts: Value) -> Rc<SendernameStatementEntity>` | Create a SendernameStatement entity instance. |
| `sent_rcs_message` | `(entopts: Value) -> Rc<SentRcsMessageEntity>` | Create a SentRcsMessage entity instance. |
| `shipment_country_volume` | `(entopts: Value) -> Rc<ShipmentCountryVolumeEntity>` | Create a ShipmentCountryVolume entity instance. |
| `short_url` | `(entopts: Value) -> Rc<ShortUrlEntity>` | Create a ShortUrl entity instance. |
| `smsdo` | `(entopts: Value) -> Rc<SmsdoEntity>` | Create a Smsdo entity instance. |
| `smssendername` | `(entopts: Value) -> Rc<SmssendernameEntity>` | Create a Smssendername entity instance. |
| `smstemplate` | `(entopts: Value) -> Rc<SmstemplateEntity>` | Create a Smstemplate entity instance. |
| `subuser` | `(entopts: Value) -> Rc<SubuserEntity>` | Create a Subuser entity instance. |
| `template` | `(entopts: Value) -> Rc<TemplateEntity>` | Create a Template entity instance. |
| `user_rcs_sender_collection` | `(entopts: Value) -> Rc<UserRcsSenderCollectionEntity>` | Create an UserRcsSenderCollection entity instance. |

### Entity interface

All entities share the same interface.

| Method | Signature | Description |
| --- | --- | --- |
| `load` | `(reqmatch: Value, ctrl: Value) -> Result<Value, SmsapiError>` | Load a single entity by match criteria. |
| `list` | `(reqmatch: Value, ctrl: Value) -> Result<Value, SmsapiError>` | List entities matching the criteria (Ok is a `Value::List`). |
| `create` | `(reqdata: Value, ctrl: Value) -> Result<Value, SmsapiError>` | Create a new entity. |
| `update` | `(reqdata: Value, ctrl: Value) -> Result<Value, SmsapiError>` | Update an existing entity. |
| `remove` | `(reqmatch: Value, ctrl: Value) -> Result<Value, SmsapiError>` | Remove an entity. |
| `data` | `(args: Option<&Value>) -> Value` | Get entity data (pass `Some(&map)` to set). |
| `matchv` | `(args: Option<&Value>) -> Value` | Get entity match criteria (pass `Some(&map)` to set). |
| `make` | `() -> Rc<dyn Entity>` | Create a new instance with the same options. |
| `get_name` | `() -> String` | Return the entity name. |

### Result shape

Entity operations return `Result<Value, SmsapiError>` — the
bare result data on `Ok` (a `Value::Map` for single-entity ops, a
`Value::List` for `list`) and the branded error on `Err`.

The `direct()` escape hatch resolves to `Ok` even on a non-2xx response —
it returns a result `Value::Map` you branch on via `getp(&result, "ok")`:

| Key | Type | Description |
| --- | --- | --- |
| `ok` | `bool` | `true` if the HTTP status is 2xx. |
| `status` | `number` | HTTP status code. |
| `headers` | `map` | Response headers. |
| `data` | `any` | Parsed JSON response body. |

On error, `ok` is `false` and `err` carries the error value.

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

Create an instance: `let available = client.available(Value::Noval);`

#### Operations

| Method | Description |
| --- | --- |
| `list(reqmatch, ctrl)` | List entities, optionally matching the given criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `name` | `String` |  |
| `normalize` | `bool` |  |
| `template` | `String` |  |

#### Example: List

```rust
let availables = client.available(Value::Noval).list(Value::Noval, Value::Noval).unwrap();
```


### Blacklist

Create an instance: `let blacklist = client.blacklist(Value::Noval);`

#### Operations

| Method | Description |
| --- | --- |
| `create(reqdata, ctrl)` | Create a new entity with the given data. |
| `load(reqmatch, ctrl)` | Load a single entity by match criteria. |
| `remove(reqmatch, ctrl)` | Remove the matching entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `id` | `String` |  |

#### Example: Load

```rust
let blacklist = client.blacklist(Value::Noval).load(Value::Noval, Value::Noval).unwrap();
```

#### Example: Create

```rust
let blacklist = client.blacklist(Value::Noval).create(jo(vec![
]), Value::Noval).unwrap();
```


### Callback

Create an instance: `let callback = client.callback(Value::Noval);`

#### Operations

| Method | Description |
| --- | --- |
| `create(reqdata, ctrl)` | Create a new entity with the given data. |
| `list(reqmatch, ctrl)` | List entities, optionally matching the given criteria. |
| `load(reqmatch, ctrl)` | Load a single entity by match criteria. |
| `remove(reqmatch, ctrl)` | Remove the matching entity. |
| `update(reqdata, ctrl)` | Update an existing entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `active` | `bool` |  |
| `api_version` | `i64` | Version of the callback output format. |
| `id` | `String` | Object ID |
| `invalid` | `bool` |  |
| `receiver` | `std::collections::HashMap<String, Value>` |  |
| `receiver_type` | `String` |  |
| `type` | `String` |  |
| `url` | `String` | WHATWG URL compliant |

#### Example: Load

```rust
let callback = client.callback(Value::Noval).load(jo(vec![("id", Value::str("callback_id"))]), Value::Noval).unwrap();
```

#### Example: List

```rust
let callbacks = client.callback(Value::Noval).list(Value::Noval, Value::Noval).unwrap();
```

#### Example: Create

```rust
let callback = client.callback(Value::Noval).create(jo(vec![
]), Value::Noval).unwrap();
```


### Contact

Create an instance: `let contact = client.contact(Value::Noval);`

#### Operations

| Method | Description |
| --- | --- |
| `create(reqdata, ctrl)` | Create a new entity with the given data. |
| `list(reqmatch, ctrl)` | List entities, optionally matching the given criteria. |
| `load(reqmatch, ctrl)` | Load a single entity by match criteria. |
| `remove(reqmatch, ctrl)` | Remove the matching entity. |
| `update(reqdata, ctrl)` | Update an existing entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `birthday_date` | `String` |  |
| `city` | `String` |  |
| `collection` | `Vec<Value>` |  |
| `contact_expire_after` | `i64` | Contact expire after days |
| `contacts_count` | `i64` |  |
| `country` | `String` |  |
| `created_by` | `String` |  |
| `date_created` | `String` |  |
| `date_updated` | `String` |  |
| `description` | `String` |  |
| `email` | `String` |  |
| `first_name` | `String` |  |
| `gender` | `String` |  |
| `group_id` | `String` | Object ID |
| `groups` | `Vec<Value>` |  |
| `id` | `String` | Object ID |
| `idx` | `String` | User provided resource id |
| `last_name` | `String` |  |
| `name` | `String` | Group name |
| `permissions` | `Vec<Value>` |  |
| `phone_number` | `String` |  |
| `read` | `bool` | Has read permission |
| `send` | `bool` | Has send permission |
| `size` | `i64` |  |
| `source` | `String` |  |
| `type` | `String` |  |
| `username` | `String` |  |
| `value` | `String` |  |
| `write` | `bool` | Has write permission |

#### Example: Load

```rust
let contact = client.contact(Value::Noval).load(jo(vec![("id", Value::str("contact_id"))]), Value::Noval).unwrap();
```

#### Example: List

```rust
let contacts = client.contact(Value::Noval).list(Value::Noval, Value::Noval).unwrap();
```

#### Example: Create

```rust
let contact = client.contact(Value::Noval).create(jo(vec![
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


### ContactsField

Create an instance: `let contacts_field = client.contacts_field(Value::Noval);`

#### Operations

| Method | Description |
| --- | --- |
| `create(reqdata, ctrl)` | Create a new entity with the given data. |
| `list(reqmatch, ctrl)` | List entities, optionally matching the given criteria. |
| `remove(reqmatch, ctrl)` | Remove the matching entity. |
| `update(reqdata, ctrl)` | Update an existing entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `birthday_date` | `String` |  |
| `city` | `String` |  |
| `contact_expire_after` | `i64` | Contact expire after days |
| `contacts_count` | `i64` |  |
| `country` | `String` |  |
| `created_by` | `String` |  |
| `date_created` | `String` |  |
| `date_updated` | `String` |  |
| `description` | `String` |  |
| `email` | `String` |  |
| `first_name` | `String` |  |
| `gender` | `String` |  |
| `group_id` | `String` | Object ID |
| `groups` | `Vec<Value>` |  |
| `id` | `String` | Object ID |
| `idx` | `String` | User provided resource id |
| `last_name` | `String` |  |
| `name` | `String` | Group name |
| `permissions` | `Vec<Value>` |  |
| `phone_number` | `String` |  |
| `read` | `bool` | Has read permission |
| `send` | `bool` | Has send permission |
| `source` | `String` |  |
| `type` | `String` |  |
| `username` | `String` |  |
| `value` | `String` |  |
| `write` | `bool` | Has write permission |

#### Example: List

```rust
let contacts_fields = client.contacts_field(Value::Noval).list(Value::Noval, Value::Noval).unwrap();
```

#### Example: Create

```rust
let contacts_field = client.contacts_field(Value::Noval).create(jo(vec![
    ("contact_expire_after", Value::Num(1.0)),  // i64
    ("created_by", Value::str("example_created_by")),  // String
    ("date_created", Value::str("example_date_created")),  // String
    ("date_updated", Value::str("example_date_updated")),  // String
    ("gender", Value::str("example_gender")),  // String
    ("groups", Value::empty_list()),  // Vec<Value>
]), Value::Noval).unwrap();
```


### ContactsFieldOption

Create an instance: `let contacts_field_option = client.contacts_field_option(Value::Noval);`

#### Operations

| Method | Description |
| --- | --- |
| `list(reqmatch, ctrl)` | List entities, optionally matching the given criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `birthday_date` | `String` |  |
| `city` | `String` |  |
| `contact_expire_after` | `i64` | Contact expire after days |
| `contacts_count` | `i64` |  |
| `country` | `String` |  |
| `created_by` | `String` |  |
| `date_created` | `String` |  |
| `date_updated` | `String` |  |
| `description` | `String` |  |
| `email` | `String` |  |
| `first_name` | `String` |  |
| `gender` | `String` |  |
| `group_id` | `String` | Object ID |
| `groups` | `Vec<Value>` |  |
| `id` | `String` | Object ID |
| `idx` | `String` | User provided resource id |
| `last_name` | `String` |  |
| `name` | `String` | Group name |
| `permissions` | `Vec<Value>` |  |
| `phone_number` | `String` |  |
| `read` | `bool` | Has read permission |
| `send` | `bool` | Has send permission |
| `source` | `String` |  |
| `type` | `String` |  |
| `username` | `String` |  |
| `value` | `String` |  |
| `write` | `bool` | Has write permission |

#### Example: List

```rust
let contacts_field_options = client.contacts_field_option(Value::Noval).list(Value::Noval, Value::Noval).unwrap();
```


### Contactsgroup

Create an instance: `let contactsgroup = client.contactsgroup(Value::Noval);`

#### Operations

| Method | Description |
| --- | --- |
| `create(reqdata, ctrl)` | Create a new entity with the given data. |
| `list(reqmatch, ctrl)` | List entities, optionally matching the given criteria. |
| `remove(reqmatch, ctrl)` | Remove the matching entity. |
| `update(reqdata, ctrl)` | Update an existing entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `birthday_date` | `String` |  |
| `city` | `String` |  |
| `contact_expire_after` | `i64` | Contact expire after days |
| `contacts_count` | `i64` |  |
| `country` | `String` |  |
| `created_by` | `String` |  |
| `date_created` | `String` |  |
| `date_updated` | `String` |  |
| `description` | `String` |  |
| `email` | `String` |  |
| `first_name` | `String` |  |
| `gender` | `String` |  |
| `group_id` | `String` | Object ID |
| `groups` | `Vec<Value>` |  |
| `id` | `String` | Object ID |
| `idx` | `String` | User provided resource id |
| `last_name` | `String` |  |
| `name` | `String` | Group name |
| `permissions` | `Vec<Value>` |  |
| `phone_number` | `String` |  |
| `read` | `bool` | Has read permission |
| `send` | `bool` | Has send permission |
| `source` | `String` |  |
| `type` | `String` |  |
| `username` | `String` |  |
| `value` | `String` |  |
| `write` | `bool` | Has write permission |

#### Example: List

```rust
let contactsgroups = client.contactsgroup(Value::Noval).list(Value::Noval, Value::Noval).unwrap();
```

#### Example: Create

```rust
let contactsgroup = client.contactsgroup(Value::Noval).create(jo(vec![
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


### Contactstrash

Create an instance: `let contactstrash = client.contactstrash(Value::Noval);`

#### Operations

| Method | Description |
| --- | --- |
| `remove(reqmatch, ctrl)` | Remove the matching entity. |
| `update(reqdata, ctrl)` | Update an existing entity. |


### FieldAvailable

Create an instance: `let field_available = client.field_available(Value::Noval);`

#### Operations

| Method | Description |
| --- | --- |
| `list(reqmatch, ctrl)` | List entities, optionally matching the given criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `built_in` | `bool` |  |
| `id` | `String` | Object ID |
| `name` | `String` |  |
| `options` | `Vec<Value>` |  |
| `type` | `String` |  |

#### Example: List

```rust
let field_availables = client.field_available(Value::Noval).list(Value::Noval, Value::Noval).unwrap();
```


### Group

Create an instance: `let group = client.group(Value::Noval);`

#### Operations

| Method | Description |
| --- | --- |
| `load(reqmatch, ctrl)` | Load a single entity by match criteria. |
| `update(reqdata, ctrl)` | Update an existing entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `contact_expire_after` | `i64` | Contact expire after days |
| `contacts_count` | `i64` |  |
| `created_by` | `String` |  |
| `date_created` | `String` |  |
| `date_updated` | `String` |  |
| `description` | `String` |  |
| `id` | `String` | Object ID |
| `idx` | `String` | User provided resource id |
| `name` | `String` | Group name |
| `permissions` | `Vec<Value>` |  |

#### Example: Load

```rust
let group = client.group(Value::Noval).load(jo(vec![("id", Value::str("group_id"))]), Value::Noval).unwrap();
```


### MfaCode

Create an instance: `let mfa_code = client.mfa_code(Value::Noval);`

#### Operations

| Method | Description |
| --- | --- |
| `create(reqdata, ctrl)` | Create a new entity with the given data. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `content` | `String` | Custom content that must contain placeholder [%code%] |
| `fast` | `Value` |  |
| `from` | `String` | Sendername |
| `phone_number` | `String` |  |

#### Example: Create

```rust
let mfa_code = client.mfa_code(Value::Noval).create(jo(vec![
    ("phone_number", Value::str("example_phone_number")),  // String
]), Value::Noval).unwrap();
```


### OptOut

Create an instance: `let opt_out = client.opt_out(Value::Noval);`

#### Operations

| Method | Description |
| --- | --- |
| `list(reqmatch, ctrl)` | List entities, optionally matching the given criteria. |
| `remove(reqmatch, ctrl)` | Remove the matching entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `date` | `String` |  |
| `id` | `String` |  |
| `links` | `Vec<Value>` |  |
| `phoneNumber` | `i64` |  |

#### Example: List

```rust
let opt_outs = client.opt_out(Value::Noval).list(Value::Noval, Value::Noval).unwrap();
```


### OptOutSetting

Create an instance: `let opt_out_setting = client.opt_out_setting(Value::Noval);`

#### Operations

| Method | Description |
| --- | --- |
| `load(reqmatch, ctrl)` | Load a single entity by match criteria. |
| `update(reqdata, ctrl)` | Update an existing entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `brand` | `String` |  |

#### Example: Load

```rust
let opt_out_setting = client.opt_out_setting(Value::Noval).load(Value::Noval, Value::Noval).unwrap();
```


### Permission

Create an instance: `let permission = client.permission(Value::Noval);`

#### Operations

| Method | Description |
| --- | --- |
| `create(reqdata, ctrl)` | Create a new entity with the given data. |
| `load(reqmatch, ctrl)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `group_id` | `String` | Object ID |
| `id` | `String` |  |
| `read` | `bool` | Has read permission |
| `send` | `bool` | Has send permission |
| `username` | `String` |  |
| `write` | `bool` | Has write permission |

#### Example: Load

```rust
let permission = client.permission(Value::Noval).load(jo(vec![("id", Value::str("permission_id")), ("group_id", Value::str("group_id")), ("username", Value::str("username"))]), Value::Noval).unwrap();
```

#### Example: Create

```rust
let permission = client.permission(Value::Noval).create(jo(vec![
    ("group_id", Value::str("example_group_id")),  // String
    ("read", Value::Bool(true)),  // bool
    ("send", Value::Bool(true)),  // bool
    ("username", Value::str("example_username")),  // String
    ("write", Value::Bool(true)),  // bool
]), Value::Noval).unwrap();
```


### Ping

Create an instance: `let ping = client.ping(Value::Noval);`

#### Operations

| Method | Description |
| --- | --- |
| `list(reqmatch, ctrl)` | List entities, optionally matching the given criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `authorized` | `bool` |  |
| `unavailable` | `Vec<Value>` |  |

#### Example: List

```rust
let pings = client.ping(Value::Noval).list(Value::Noval, Value::Noval).unwrap();
```


### Profile

Create an instance: `let profile = client.profile(Value::Noval);`

#### Operations

| Method | Description |
| --- | --- |
| `list(reqmatch, ctrl)` | List entities, optionally matching the given criteria. |
| `load(reqmatch, ctrl)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `email` | `String` |  |
| `name` | `String` |  |
| `payment_type` | `String` |  |
| `phone_number` | `i64` |  |
| `points` | `f64` |  |
| `user_type` | `String` |  |
| `username` | `String` |  |

#### Example: Load

```rust
let profile = client.profile(Value::Noval).load(Value::Noval, Value::Noval).unwrap();
```

#### Example: List

```rust
let profiles = client.profile(Value::Noval).list(Value::Noval, Value::Noval).unwrap();
```


### Rcs

Create an instance: `let rcs = client.rcs(Value::Noval);`

#### Operations

| Method | Description |
| --- | --- |
| `list(reqmatch, ctrl)` | List entities, optionally matching the given criteria. |

#### Example: List

```rust
let rcss = client.rcs(Value::Noval).list(Value::Noval, Value::Noval).unwrap();
```


### Sendername

Create an instance: `let sendername = client.sendername(Value::Noval);`

#### Operations

| Method | Description |
| --- | --- |
| `create(reqdata, ctrl)` | Create a new entity with the given data. |
| `list(reqmatch, ctrl)` | List entities, optionally matching the given criteria. |
| `load(reqmatch, ctrl)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `created_at` | `String` |  |
| `id` | `String` |  |
| `is_default` | `bool` |  |
| `sender` | `String` | Sendername |
| `status` | `String` |  |

#### Example: Load

```rust
let sendername = client.sendername(Value::Noval).load(jo(vec![("id", Value::str("sendername_id"))]), Value::Noval).unwrap();
```

#### Example: List

```rust
let sendernames = client.sendername(Value::Noval).list(Value::Noval, Value::Noval).unwrap();
```

#### Example: Create

```rust
let sendername = client.sendername(Value::Noval).create(jo(vec![
]), Value::Noval).unwrap();
```


### SendernameStatement

Create an instance: `let sendername_statement = client.sendername_statement(Value::Noval);`

#### Operations

| Method | Description |
| --- | --- |
| `list(reqmatch, ctrl)` | List entities, optionally matching the given criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `content` | `String` |  |
| `statements` | `Vec<Value>` |  |
| `title` | `String` |  |

#### Example: List

```rust
let sendername_statements = client.sendername_statement(Value::Noval).list(Value::Noval, Value::Noval).unwrap();
```


### SentRcsMessage

Create an instance: `let sent_rcs_message = client.sent_rcs_message(Value::Noval);`

#### Operations

| Method | Description |
| --- | --- |
| `create(reqdata, ctrl)` | Create a new entity with the given data. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `content` | `std::collections::HashMap<String, Value>` | RCS message content in RCS JSON format. |
| `phone_number` | `String` | Recipient phone number (e.g. |
| `sender` | `Value` |  |
| `text` | `String` | Plain text message content. |

#### Example: Create

```rust
let sent_rcs_message = client.sent_rcs_message(Value::Noval).create(jo(vec![
    ("phone_number", Value::str("example_phone_number")),  // String
    ("sender", Value::str("example_sender")),  // Value
]), Value::Noval).unwrap();
```


### ShipmentCountryVolume

Create an instance: `let shipment_country_volume = client.shipment_country_volume(Value::Noval);`

#### Operations

| Method | Description |
| --- | --- |
| `list(reqmatch, ctrl)` | List entities, optionally matching the given criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `country_code` | `String` |  |
| `country_limit` | `i64` |  |
| `country_name` | `String` |  |
| `usage` | `i64` |  |

#### Example: List

```rust
let shipment_country_volumes = client.shipment_country_volume(Value::Noval).list(Value::Noval, Value::Noval).unwrap();
```


### ShortUrl

Create an instance: `let short_url = client.short_url(Value::Noval);`

#### Operations

| Method | Description |
| --- | --- |
| `create(reqdata, ctrl)` | Create a new entity with the given data. |
| `list(reqmatch, ctrl)` | List entities, optionally matching the given criteria. |
| `load(reqmatch, ctrl)` | Load a single entity by match criteria. |
| `remove(reqmatch, ctrl)` | Remove the matching entity. |
| `update(reqdata, ctrl)` | Update an existing entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `description` | `String` |  |
| `expire` | `String` |  |
| `filename` | `String` |  |
| `hits` | `i64` |  |
| `hits_unique` | `i64` |  |
| `id` | `String` |  |
| `name` | `String` |  |
| `short_url` | `String` | WHATWG URL compliant |
| `type` | `String` |  |
| `url` | `String` | WHATWG URL compliant |

#### Example: Load

```rust
let short_url = client.short_url(Value::Noval).load(jo(vec![("id", Value::str("short_url_id"))]), Value::Noval).unwrap();
```

#### Example: List

```rust
let short_urls = client.short_url(Value::Noval).list(Value::Noval, Value::Noval).unwrap();
```

#### Example: Create

```rust
let short_url = client.short_url(Value::Noval).create(jo(vec![
]), Value::Noval).unwrap();
```


### Smsdo

Create an instance: `let smsdo = client.smsdo(Value::Noval);`

#### Operations

| Method | Description |
| --- | --- |
| `create(reqdata, ctrl)` | Create a new entity with the given data. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `allow_duplicates` | `i64` | When parameter allow_duplicates is set to "1" allows to send message to duplicated numbers in one request (useful i.e. |
| `check_idx` | `Value` | When parameter check_idx is set to „1” prevents from sending more than one message with the same idx in last 24h. |
| `date` | `Value` | Date in UNIX timestamp (&date=1287734110) or in ISO 8601 (&date=2012-05-10T08:40:27+00:00) when message will be sent (&date=1287734110). |
| `date_validate` | `i64` | When parameter date_validate is set to "1" checks if date if given in proper format. |
| `details` | `Value` | When details parameter is set to "1" more details in response will be displayed (message length and sms count). |
| `encoding` | `String` | This parameter describes the encoding of the message text. |
| `expiration_date` | `Value` | Message expiration date (in UNIX timestamp or in ISO 8601) is a date after which message won't be delivered if it wasn't delivered yet. |
| `fallback` | `Vec<Value>` | Enable fallback in case sms sending fails |
| `fast` | `i64` | Setting this parameter to „1” will result in sending message with the highest priority which ensures the quickest possible time of delivery. |
| `flash` | `i64` | Sending a message in flash mode can be activated by setting this parameter to "1". |
| `format` | `String` | Parameter &format=json causes, that response is sending in JSON format. |
| `from` | `String` | Name of the sender. |
| `group` | `String` | Name of the group from the contacts database to which message should be sent to. |
| `idx` | `String` | Optional custom value sent with SMS and sent back in CALLBACK. |
| `max_parts` | `i64` | Defines maximum message parts allowed, maximum value allowed is 6. |
| `message` | `String` | The message text. |
| `normalize` | `i64` | When parameter normalize is set to „1” special chars in message will be replaced with their equivalents (ê-e, ñ-n, ý-y ...). |
| `notify_url` | `String` | Parameter allows to set CALLBACK URL for message from request. |
| `test` | `Value` | When parameter test is set to "1" message won't be sent but response will be displayed, there is no charge for such test messages. |
| `time_restriction` | `String` | Sets the behavior when you try to ship in hours / dates that do not match the settings in your account. |
| `to` | `String` | Recipients' mobile phone numbers (i.e. |

#### Example: Create

```rust
let smsdo = client.smsdo(Value::Noval).create(jo(vec![
]), Value::Noval).unwrap();
```


### Smssendername

Create an instance: `let smssendername = client.smssendername(Value::Noval);`

#### Operations

| Method | Description |
| --- | --- |
| `create(reqdata, ctrl)` | Create a new entity with the given data. |
| `remove(reqmatch, ctrl)` | Remove the matching entity. |

#### Example: Create

```rust
let smssendername = client.smssendername(Value::Noval).create(jo(vec![
    ("sendername_id", Value::str("example_sendername_id")),  // String
]), Value::Noval).unwrap();
```


### Smstemplate

Create an instance: `let smstemplate = client.smstemplate(Value::Noval);`

#### Operations

| Method | Description |
| --- | --- |
| `remove(reqmatch, ctrl)` | Remove the matching entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `id` | `String` |  |


### Subuser

Create an instance: `let subuser = client.subuser(Value::Noval);`

#### Operations

| Method | Description |
| --- | --- |
| `create(reqdata, ctrl)` | Create a new entity with the given data. |
| `list(reqmatch, ctrl)` | List entities, optionally matching the given criteria. |
| `load(reqmatch, ctrl)` | Load a single entity by match criteria. |
| `remove(reqmatch, ctrl)` | Remove the matching entity. |
| `update(reqdata, ctrl)` | Update an existing entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `active` | `bool` |  |
| `credentials` | `std::collections::HashMap<String, Value>` |  |
| `description` | `String` |  |
| `id` | `String` | Object ID |
| `points` | `std::collections::HashMap<String, Value>` |  |
| `username` | `String` |  |

#### Example: Load

```rust
let subuser = client.subuser(Value::Noval).load(jo(vec![("id", Value::str("subuser_id"))]), Value::Noval).unwrap();
```

#### Example: List

```rust
let subusers = client.subuser(Value::Noval).list(Value::Noval, Value::Noval).unwrap();
```

#### Example: Create

```rust
let subuser = client.subuser(Value::Noval).create(jo(vec![
    ("credentials", Value::empty_map()),  // std::collections::HashMap<String, Value>
]), Value::Noval).unwrap();
```


### Template

Create an instance: `let template = client.template(Value::Noval);`

#### Operations

| Method | Description |
| --- | --- |
| `create(reqdata, ctrl)` | Create a new entity with the given data. |
| `list(reqmatch, ctrl)` | List entities, optionally matching the given criteria. |
| `load(reqmatch, ctrl)` | Load a single entity by match criteria. |
| `update(reqdata, ctrl)` | Update an existing entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `id` | `String` |  |
| `name` | `String` |  |
| `normalize` | `bool` |  |
| `template` | `String` |  |

#### Example: Load

```rust
let template = client.template(Value::Noval).load(jo(vec![("id", Value::str("template_id"))]), Value::Noval).unwrap();
```

#### Example: List

```rust
let templates = client.template(Value::Noval).list(Value::Noval, Value::Noval).unwrap();
```

#### Example: Create

```rust
let template = client.template(Value::Noval).create(jo(vec![
]), Value::Noval).unwrap();
```


### UserRcsSenderCollection

Create an instance: `let user_rcs_sender_collection = client.user_rcs_sender_collection(Value::Noval);`

#### Operations

| Method | Description |
| --- | --- |
| `list(reqmatch, ctrl)` | List entities, optionally matching the given criteria. |

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

```rust
let user_rcs_sender_collections = client.user_rcs_sender_collection(Value::Noval).list(Value::Noval, Value::Noval).unwrap();
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

The Rust SDK uses a single dynamic `Value` type throughout rather than a
typed struct per entity. `Value` is the vendored voxgig struct port (a
JSON-shaped enum: `Str`, `Num`, `Bool`, `List`, `Map`, `Null`,
`Noval`). This mirrors the dynamic nature of the API and keeps the SDK
flexible — no code generation is needed when the API schema changes.

Build request maps with the `jo` / `ja` helpers and read fields back with
`getp`; use `to_map` to safely coerce a value to a map.

### Crate structure

```
rust/
├── lib.rs                       -- Crate root (module decls + re-exports)
├── core/                        -- Pipeline types, config, client (sdk.rs)
├── entity/                      -- Per-entity clients (one module each)
├── feature/                     -- Built-in features (base, test, log)
└── utility/                     -- Utilities + the vendored voxgig struct port
```

The public API is re-exported from the crate root, so `use smsapi_sdk::{...}`
reaches the SDK client, `Value`, and the `jo` / `ja` / `getp` helpers
directly. Import entity or utility modules only when needed.

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
