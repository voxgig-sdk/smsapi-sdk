# Smsapi C++ SDK

An MCP server and CLI for the SMSAPI REST API, plus clients in 13 languages and a pandas data layer, generated from SMSAPI's public OpenAPI spec so AI agents can reach SMSAPI the way the official SDKs already let developers.

The C++ SDK for the Smsapi API — a header-only,
entity-oriented client following idiomatic modern C++ (C++17) conventions.

The SDK exposes the API as capitalised, semantic **Entities** — for example `client->available()` — each
carrying a small, uniform set of operations (`list`, `load`, `create`, `update`, `remove`) instead of raw URL
paths and query strings. You work with named resources and verbs, which
keeps the cognitive load low. Every value flows through a single dynamic
`sdk::Value` type (a JSON-like variant), so there is no schema-driven code to
regenerate when the API changes.

> Other languages, the CLI, and MCP server live alongside this one — see
> the [top-level README](../README.md).


## Install
The C++ SDK is **header-only** — there is no package to install
from a registry. Vendor the `cpp/` directory into your project (or add the
repository as a git submodule) and put it on your compiler's include path.
Releases are cut as the git tag `cpp/vX.Y.Z` (see
[Releases](https://github.com/voxgig-sdk/smsapi-sdk/releases)).

```bash
# Add the SDK as a submodule (or copy the cpp/ directory into your tree).
git submodule add <repo-url> third_party/smsapi-sdk
```

Then include the umbrella header and compile with C++17:

```cpp
#include "core/sdk.hpp"
```

```bash
g++ -std=c++17 -Ithird_party/smsapi-sdk/cpp your_app.cpp -o your_app
```


## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record.

### 1. Create a client

```cpp
#include <cstdlib>
#include "core/sdk.hpp"

using namespace sdk;

const char* apikey = std::getenv("SMSAPI_APIKEY");
auto client = std::make_shared<SmsapiSDK>(vmap({
    {"apikey", Value(apikey ? apikey : "")},
}));
```

### 2. List available records

`list()` returns an `sdk::Value` list and throws `sdk::SdkErrorPtr`
on error — iterate it directly.

```cpp
try {
  Value availables = client->available()->list(Value::undef(), Value::undef());
  for (const auto& available : *availables.as_list()) {
    std::cout << Struct::jsonify(available) << std::endl;
  }
} catch (const SdkErrorPtr& err) {
  std::cerr << "list failed: " << err->msg << std::endl;
}
```

### 3. Load a permission

Permission is nested under group, so provide the `group_id`.
`load()` returns the bare record and throws on error.

```cpp
try {
  Value permission = client->permission()->load(vmap({{"group_id", Value("example_group_id")}, {"username", Value("example_username")}, {"id", Value("example_id")}}), Value::undef());
  std::cout << Struct::jsonify(permission) << std::endl;
} catch (const SdkErrorPtr& err) {
  std::cerr << "load failed: " << err->msg << std::endl;
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

```cpp
Value result = client->direct(vmap({
    {"path", Value("/api/resource/{id}")},
    {"method", Value("GET")},
    {"params", vmap({{"id", Value("example")}})},
}));

if (getp(result, "ok") == Value(true)) {
  std::cout << Helpers::toInt(getp(result, "status")) << std::endl;  // 200
  std::cout << Struct::jsonify(getp(result, "data")) << std::endl;   // response body
} else {
  // A non-2xx response carries status + data (the error body); a
  // transport-level failure carries err instead. Only one is present.
  std::cerr << Helpers::toInt(getp(result, "status")) << " "
            << Struct::jsonify(getp(result, "err")) << std::endl;
}
```

`direct()` is the escape hatch: it never throws — branch on
`getp(result, "ok")`.

### Prepare a request without sending it

```cpp
// prepare() returns the fetch definition and throws on error.
Value fetchdef = client->prepare(vmap({
    {"path", Value("/api/resource/{id}")},
    {"method", Value("DELETE")},
    {"params", vmap({{"id", Value("example")}})},
}));

std::cout << Struct::stringify(getp(fetchdef, "url")) << std::endl;
std::cout << Struct::stringify(getp(fetchdef, "method")) << std::endl;
std::cout << Struct::jsonify(getp(fetchdef, "headers")) << std::endl;
```

### Use test mode

Create a mock client for unit testing — no server required. The test
feature installs an in-memory mock transport:

```cpp
auto client = SmsapiSDK::testSDK();

// Entity ops return the bare record and throw on error.
Value permission = client->permission()->load(vmap({{"id", Value("test01")}}), Value::undef());
// permission contains the mock response record
std::cout << Struct::jsonify(permission) << std::endl;
```

You can seed the mock store by passing test options — see the generated
`test/` suite for worked examples.

### Run live tests

Create a `.env.local` file at the project root:

```
SMSAPI_TEST_LIVE=TRUE
SMSAPI_APIKEY=<your-key>
```

Then build and run the test suite:

```bash
cd cpp && make test
```


## Reference

### SmsapiSDK

```cpp
#include "core/sdk.hpp"

using namespace sdk;

auto client = std::make_shared<SmsapiSDK>(options);
```

Creates a new SDK client. `options` is an `sdk::Value` map.

| Option | Type | Description |
| --- | --- | --- |
| `apikey` | `std::string` | API key for authentication. |
| `base` | `std::string` | Base URL of the API server. |
| `prefix` | `std::string` | URL path prefix prepended to all requests. |
| `suffix` | `std::string` | URL path suffix appended to all requests. |
| `feature` | `Value` | Feature activation flags. |
| `system` | `Value` | System overrides. |

### testSDK

```cpp
auto client = SmsapiSDK::testSDK(testopts, sdkopts);
```

Creates a test-mode client with mock transport. Both arguments may be
`Value::undef()`; a no-arg `SmsapiSDK::testSDK()` overload is
also provided.

### SmsapiSDK methods

| Method | Signature | Description |
| --- | --- | --- |
| `optionsMap` | `() -> Value` | Deep copy of current SDK options. |
| `getUtility` | `() -> UtilityPtr` | Copy of the SDK utility object. |
| `prepare` | `(fetchargs) -> Value` | Build an HTTP request definition without sending. Throws on error. |
| `direct` | `(fetchargs) -> Value` | Build and send an HTTP request. Returns a result Value (branch on `ok`). |
| `available` | `(entopts) -> std::shared_ptr<AvailableEntity>` | Create an Available entity instance. |
| `blacklist` | `(entopts) -> std::shared_ptr<BlacklistEntity>` | Create a Blacklist entity instance. |
| `callback` | `(entopts) -> std::shared_ptr<CallbackEntity>` | Create a Callback entity instance. |
| `contact` | `(entopts) -> std::shared_ptr<ContactEntity>` | Create a Contact entity instance. |
| `contacts_field` | `(entopts) -> std::shared_ptr<ContactsFieldEntity>` | Create a ContactsField entity instance. |
| `contacts_field_option` | `(entopts) -> std::shared_ptr<ContactsFieldOptionEntity>` | Create a ContactsFieldOption entity instance. |
| `contactsgroup` | `(entopts) -> std::shared_ptr<ContactsgroupEntity>` | Create a Contactsgroup entity instance. |
| `contactstrash` | `(entopts) -> std::shared_ptr<ContactstrashEntity>` | Create a Contactstrash entity instance. |
| `field_available` | `(entopts) -> std::shared_ptr<FieldAvailableEntity>` | Create a FieldAvailable entity instance. |
| `group` | `(entopts) -> std::shared_ptr<GroupEntity>` | Create a Group entity instance. |
| `mfa_code` | `(entopts) -> std::shared_ptr<MfaCodeEntity>` | Create a MfaCode entity instance. |
| `opt_out` | `(entopts) -> std::shared_ptr<OptOutEntity>` | Create an OptOut entity instance. |
| `opt_out_setting` | `(entopts) -> std::shared_ptr<OptOutSettingEntity>` | Create an OptOutSetting entity instance. |
| `permission` | `(entopts) -> std::shared_ptr<PermissionEntity>` | Create a Permission entity instance. |
| `ping` | `(entopts) -> std::shared_ptr<PingEntity>` | Create a Ping entity instance. |
| `profile` | `(entopts) -> std::shared_ptr<ProfileEntity>` | Create a Profile entity instance. |
| `rcs` | `(entopts) -> std::shared_ptr<RcsEntity>` | Create a Rcs entity instance. |
| `sendername` | `(entopts) -> std::shared_ptr<SendernameEntity>` | Create a Sendername entity instance. |
| `sendername_statement` | `(entopts) -> std::shared_ptr<SendernameStatementEntity>` | Create a SendernameStatement entity instance. |
| `sent_rcs_message` | `(entopts) -> std::shared_ptr<SentRcsMessageEntity>` | Create a SentRcsMessage entity instance. |
| `shipment_country_volume` | `(entopts) -> std::shared_ptr<ShipmentCountryVolumeEntity>` | Create a ShipmentCountryVolume entity instance. |
| `short_url` | `(entopts) -> std::shared_ptr<ShortUrlEntity>` | Create a ShortUrl entity instance. |
| `smsdo` | `(entopts) -> std::shared_ptr<SmsdoEntity>` | Create a Smsdo entity instance. |
| `smssendername` | `(entopts) -> std::shared_ptr<SmssendernameEntity>` | Create a Smssendername entity instance. |
| `smstemplate` | `(entopts) -> std::shared_ptr<SmstemplateEntity>` | Create a Smstemplate entity instance. |
| `subuser` | `(entopts) -> std::shared_ptr<SubuserEntity>` | Create a Subuser entity instance. |
| `template_` | `(entopts) -> std::shared_ptr<TemplateEntity>` | Create a Template entity instance. |
| `user_rcs_sender_collection` | `(entopts) -> std::shared_ptr<UserRcsSenderCollectionEntity>` | Create an UserRcsSenderCollection entity instance. |

### Entity interface

All entities share the same interface.

| Method | Signature | Description |
| --- | --- | --- |
| `load` | `(reqmatch, ctrl) -> Value` | Load a single entity by match criteria. Throws on error. |
| `list` | `(reqmatch, ctrl) -> Value` | List entities matching the criteria (a Value list). Throws on error. |
| `create` | `(reqdata, ctrl) -> Value` | Create a new entity. Throws on error. |
| `update` | `(reqdata, ctrl) -> Value` | Update an existing entity. Throws on error. |
| `remove` | `(reqmatch, ctrl) -> Value` | Remove an entity. Throws on error. |
| `data` | `(arg) -> Value` | Get (no arg) or set (with arg) entity data. |
| `match` | `(arg) -> Value` | Get (no arg) or set (with arg) entity match criteria. |
| `make` | `() -> EntityPtr` | Create a new instance with the same options. |
| `getName` | `() -> std::string` | Return the entity name. |

### Result shape

Entity operations return the bare result data (a map `Value` for
single-entity ops, a list `Value` for `list`) and throw
`sdk::SdkErrorPtr` on error. Wrap calls in `try`/`catch` to handle
failures.

The `direct()` escape hatch never throws — it returns a result `Value`
you branch on via `getp(result, "ok")`:

| Key | Type | Description |
| --- | --- | --- |
| `ok` | `bool` | `true` if the HTTP status is 2xx. |
| `status` | `int` | HTTP status code. |
| `headers` | `Value` | Response headers. |
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

Create an instance: `auto available = client->available();`

#### Operations

| Method | Description |
| --- | --- |
| `list(match, ctrl)` | List entities, optionally matching the given criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `name` | `std::string` |  |
| `normalize` | `bool` |  |
| `template` | `std::string` |  |

#### Example: List

```cpp
Value availables = client->available()->list(Value::undef(), Value::undef());
```


### Blacklist

Create an instance: `auto blacklist = client->blacklist();`

#### Operations

| Method | Description |
| --- | --- |
| `create(data, ctrl)` | Create a new entity with the given data. |
| `load(match, ctrl)` | Load a single entity by match criteria. |
| `remove(match, ctrl)` | Remove the matching entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `id` | `std::string` |  |

#### Example: Load

```cpp
Value blacklist = client->blacklist()->load(Value::undef(), Value::undef());
```

#### Example: Create

```cpp
Value blacklist = client->blacklist()->create(vmap({
}), Value::undef());
```


### Callback

Create an instance: `auto callback = client->callback();`

#### Operations

| Method | Description |
| --- | --- |
| `create(data, ctrl)` | Create a new entity with the given data. |
| `list(match, ctrl)` | List entities, optionally matching the given criteria. |
| `load(match, ctrl)` | Load a single entity by match criteria. |
| `remove(match, ctrl)` | Remove the matching entity. |
| `update(data, ctrl)` | Update an existing entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `active` | `bool` |  |
| `api_version` | `int64_t` | Version of the callback output format. |
| `id` | `std::string` | Object ID |
| `invalid` | `bool` |  |
| `receiver` | `std::map<std::string, Value>` |  |
| `receiver_type` | `std::string` |  |
| `type` | `std::string` |  |
| `url` | `std::string` | WHATWG URL compliant |

#### Example: Load

```cpp
Value callback = client->callback()->load(vmap({{"id", Value("callback_id")}}), Value::undef());
```

#### Example: List

```cpp
Value callbacks = client->callback()->list(Value::undef(), Value::undef());
```

#### Example: Create

```cpp
Value callback = client->callback()->create(vmap({
}), Value::undef());
```


### Contact

Create an instance: `auto contact = client->contact();`

#### Operations

| Method | Description |
| --- | --- |
| `create(data, ctrl)` | Create a new entity with the given data. |
| `list(match, ctrl)` | List entities, optionally matching the given criteria. |
| `load(match, ctrl)` | Load a single entity by match criteria. |
| `remove(match, ctrl)` | Remove the matching entity. |
| `update(data, ctrl)` | Update an existing entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `birthday_date` | `std::string` |  |
| `city` | `std::string` |  |
| `collection` | `std::vector<Value>` |  |
| `contact_expire_after` | `int64_t` | Contact expire after days |
| `contacts_count` | `int64_t` |  |
| `country` | `std::string` |  |
| `created_by` | `std::string` |  |
| `date_created` | `std::string` |  |
| `date_updated` | `std::string` |  |
| `description` | `std::string` |  |
| `email` | `std::string` |  |
| `first_name` | `std::string` |  |
| `gender` | `std::string` |  |
| `group_id` | `std::string` | Object ID |
| `groups` | `std::vector<Value>` |  |
| `id` | `std::string` | Object ID |
| `idx` | `std::string` | User provided resource id |
| `last_name` | `std::string` |  |
| `name` | `std::string` | Group name |
| `permissions` | `std::vector<Value>` |  |
| `phone_number` | `std::string` |  |
| `read` | `bool` | Has read permission |
| `send` | `bool` | Has send permission |
| `size` | `int64_t` |  |
| `source` | `std::string` |  |
| `type` | `std::string` |  |
| `username` | `std::string` |  |
| `value` | `std::string` |  |
| `write` | `bool` | Has write permission |

#### Example: Load

```cpp
Value contact = client->contact()->load(vmap({{"id", Value("contact_id")}}), Value::undef());
```

#### Example: List

```cpp
Value contacts = client->contact()->list(Value::undef(), Value::undef());
```

#### Example: Create

```cpp
Value contact = client->contact()->create(vmap({
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


### ContactsField

Create an instance: `auto contacts_field = client->contacts_field();`

#### Operations

| Method | Description |
| --- | --- |
| `create(data, ctrl)` | Create a new entity with the given data. |
| `list(match, ctrl)` | List entities, optionally matching the given criteria. |
| `remove(match, ctrl)` | Remove the matching entity. |
| `update(data, ctrl)` | Update an existing entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `birthday_date` | `std::string` |  |
| `city` | `std::string` |  |
| `contact_expire_after` | `int64_t` | Contact expire after days |
| `contacts_count` | `int64_t` |  |
| `country` | `std::string` |  |
| `created_by` | `std::string` |  |
| `date_created` | `std::string` |  |
| `date_updated` | `std::string` |  |
| `description` | `std::string` |  |
| `email` | `std::string` |  |
| `first_name` | `std::string` |  |
| `gender` | `std::string` |  |
| `group_id` | `std::string` | Object ID |
| `groups` | `std::vector<Value>` |  |
| `id` | `std::string` | Object ID |
| `idx` | `std::string` | User provided resource id |
| `last_name` | `std::string` |  |
| `name` | `std::string` | Group name |
| `permissions` | `std::vector<Value>` |  |
| `phone_number` | `std::string` |  |
| `read` | `bool` | Has read permission |
| `send` | `bool` | Has send permission |
| `source` | `std::string` |  |
| `type` | `std::string` |  |
| `username` | `std::string` |  |
| `value` | `std::string` |  |
| `write` | `bool` | Has write permission |

#### Example: List

```cpp
Value contacts_fields = client->contacts_field()->list(Value::undef(), Value::undef());
```

#### Example: Create

```cpp
Value contacts_field = client->contacts_field()->create(vmap({
    {"contact_expire_after", Value(1)},  // int64_t
    {"created_by", Value("example_created_by")},  // std::string
    {"date_created", Value("example_date_created")},  // std::string
    {"date_updated", Value("example_date_updated")},  // std::string
    {"gender", Value("example_gender")},  // std::string
    {"groups", vlist()},  // std::vector<Value>
}), Value::undef());
```


### ContactsFieldOption

Create an instance: `auto contacts_field_option = client->contacts_field_option();`

#### Operations

| Method | Description |
| --- | --- |
| `list(match, ctrl)` | List entities, optionally matching the given criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `birthday_date` | `std::string` |  |
| `city` | `std::string` |  |
| `contact_expire_after` | `int64_t` | Contact expire after days |
| `contacts_count` | `int64_t` |  |
| `country` | `std::string` |  |
| `created_by` | `std::string` |  |
| `date_created` | `std::string` |  |
| `date_updated` | `std::string` |  |
| `description` | `std::string` |  |
| `email` | `std::string` |  |
| `first_name` | `std::string` |  |
| `gender` | `std::string` |  |
| `group_id` | `std::string` | Object ID |
| `groups` | `std::vector<Value>` |  |
| `id` | `std::string` | Object ID |
| `idx` | `std::string` | User provided resource id |
| `last_name` | `std::string` |  |
| `name` | `std::string` | Group name |
| `permissions` | `std::vector<Value>` |  |
| `phone_number` | `std::string` |  |
| `read` | `bool` | Has read permission |
| `send` | `bool` | Has send permission |
| `source` | `std::string` |  |
| `type` | `std::string` |  |
| `username` | `std::string` |  |
| `value` | `std::string` |  |
| `write` | `bool` | Has write permission |

#### Example: List

```cpp
Value contacts_field_options = client->contacts_field_option()->list(Value::undef(), Value::undef());
```


### Contactsgroup

Create an instance: `auto contactsgroup = client->contactsgroup();`

#### Operations

| Method | Description |
| --- | --- |
| `create(data, ctrl)` | Create a new entity with the given data. |
| `list(match, ctrl)` | List entities, optionally matching the given criteria. |
| `remove(match, ctrl)` | Remove the matching entity. |
| `update(data, ctrl)` | Update an existing entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `birthday_date` | `std::string` |  |
| `city` | `std::string` |  |
| `contact_expire_after` | `int64_t` | Contact expire after days |
| `contacts_count` | `int64_t` |  |
| `country` | `std::string` |  |
| `created_by` | `std::string` |  |
| `date_created` | `std::string` |  |
| `date_updated` | `std::string` |  |
| `description` | `std::string` |  |
| `email` | `std::string` |  |
| `first_name` | `std::string` |  |
| `gender` | `std::string` |  |
| `group_id` | `std::string` | Object ID |
| `groups` | `std::vector<Value>` |  |
| `id` | `std::string` | Object ID |
| `idx` | `std::string` | User provided resource id |
| `last_name` | `std::string` |  |
| `name` | `std::string` | Group name |
| `permissions` | `std::vector<Value>` |  |
| `phone_number` | `std::string` |  |
| `read` | `bool` | Has read permission |
| `send` | `bool` | Has send permission |
| `source` | `std::string` |  |
| `type` | `std::string` |  |
| `username` | `std::string` |  |
| `value` | `std::string` |  |
| `write` | `bool` | Has write permission |

#### Example: List

```cpp
Value contactsgroups = client->contactsgroup()->list(Value::undef(), Value::undef());
```

#### Example: Create

```cpp
Value contactsgroup = client->contactsgroup()->create(vmap({
    {"contact_expire_after", Value(1)},  // int64_t
    {"created_by", Value("example_created_by")},  // std::string
    {"date_created", Value("example_date_created")},  // std::string
    {"date_updated", Value("example_date_updated")},  // std::string
    {"gender", Value("example_gender")},  // std::string
    {"group_id", Value("example_group_id")},  // std::string
    {"groups", vlist()},  // std::vector<Value>
    {"id", Value("example_id")},  // std::string
    {"read", Value(true)},  // bool
    {"send", Value(true)},  // bool
    {"username", Value("example_username")},  // std::string
    {"write", Value(true)},  // bool
}), Value::undef());
```


### Contactstrash

Create an instance: `auto contactstrash = client->contactstrash();`

#### Operations

| Method | Description |
| --- | --- |
| `remove(match, ctrl)` | Remove the matching entity. |
| `update(data, ctrl)` | Update an existing entity. |


### FieldAvailable

Create an instance: `auto field_available = client->field_available();`

#### Operations

| Method | Description |
| --- | --- |
| `list(match, ctrl)` | List entities, optionally matching the given criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `built_in` | `bool` |  |
| `id` | `std::string` | Object ID |
| `name` | `std::string` |  |
| `options` | `std::vector<Value>` |  |
| `type` | `std::string` |  |

#### Example: List

```cpp
Value field_availables = client->field_available()->list(Value::undef(), Value::undef());
```


### Group

Create an instance: `auto group = client->group();`

#### Operations

| Method | Description |
| --- | --- |
| `load(match, ctrl)` | Load a single entity by match criteria. |
| `update(data, ctrl)` | Update an existing entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `contact_expire_after` | `int64_t` | Contact expire after days |
| `contacts_count` | `int64_t` |  |
| `created_by` | `std::string` |  |
| `date_created` | `std::string` |  |
| `date_updated` | `std::string` |  |
| `description` | `std::string` |  |
| `id` | `std::string` | Object ID |
| `idx` | `std::string` | User provided resource id |
| `name` | `std::string` | Group name |
| `permissions` | `std::vector<Value>` |  |

#### Example: Load

```cpp
Value group = client->group()->load(vmap({{"id", Value("group_id")}}), Value::undef());
```


### MfaCode

Create an instance: `auto mfa_code = client->mfa_code();`

#### Operations

| Method | Description |
| --- | --- |
| `create(data, ctrl)` | Create a new entity with the given data. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `content` | `std::string` | Custom content that must contain placeholder [%code%] |
| `fast` | `Value` |  |
| `from` | `std::string` | Sendername |
| `phone_number` | `std::string` |  |

#### Example: Create

```cpp
Value mfa_code = client->mfa_code()->create(vmap({
    {"phone_number", Value("example_phone_number")},  // std::string
}), Value::undef());
```


### OptOut

Create an instance: `auto opt_out = client->opt_out();`

#### Operations

| Method | Description |
| --- | --- |
| `list(match, ctrl)` | List entities, optionally matching the given criteria. |
| `remove(match, ctrl)` | Remove the matching entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `date` | `std::string` |  |
| `id` | `std::string` |  |
| `links` | `std::vector<Value>` |  |
| `phoneNumber` | `int64_t` |  |

#### Example: List

```cpp
Value opt_outs = client->opt_out()->list(Value::undef(), Value::undef());
```


### OptOutSetting

Create an instance: `auto opt_out_setting = client->opt_out_setting();`

#### Operations

| Method | Description |
| --- | --- |
| `load(match, ctrl)` | Load a single entity by match criteria. |
| `update(data, ctrl)` | Update an existing entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `brand` | `std::string` |  |

#### Example: Load

```cpp
Value opt_out_setting = client->opt_out_setting()->load(Value::undef(), Value::undef());
```


### Permission

Create an instance: `auto permission = client->permission();`

#### Operations

| Method | Description |
| --- | --- |
| `create(data, ctrl)` | Create a new entity with the given data. |
| `load(match, ctrl)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `group_id` | `std::string` | Object ID |
| `id` | `std::string` |  |
| `read` | `bool` | Has read permission |
| `send` | `bool` | Has send permission |
| `username` | `std::string` |  |
| `write` | `bool` | Has write permission |

#### Example: Load

```cpp
Value permission = client->permission()->load(vmap({{"id", Value("permission_id")}, {"group_id", Value("group_id")}, {"username", Value("username")}}), Value::undef());
```

#### Example: Create

```cpp
Value permission = client->permission()->create(vmap({
    {"group_id", Value("example_group_id")},  // std::string
    {"read", Value(true)},  // bool
    {"send", Value(true)},  // bool
    {"username", Value("example_username")},  // std::string
    {"write", Value(true)},  // bool
}), Value::undef());
```


### Ping

Create an instance: `auto ping = client->ping();`

#### Operations

| Method | Description |
| --- | --- |
| `list(match, ctrl)` | List entities, optionally matching the given criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `authorized` | `bool` |  |
| `unavailable` | `std::vector<Value>` |  |

#### Example: List

```cpp
Value pings = client->ping()->list(Value::undef(), Value::undef());
```


### Profile

Create an instance: `auto profile = client->profile();`

#### Operations

| Method | Description |
| --- | --- |
| `list(match, ctrl)` | List entities, optionally matching the given criteria. |
| `load(match, ctrl)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `email` | `std::string` |  |
| `name` | `std::string` |  |
| `payment_type` | `std::string` |  |
| `phone_number` | `int64_t` |  |
| `points` | `double` |  |
| `user_type` | `std::string` |  |
| `username` | `std::string` |  |

#### Example: Load

```cpp
Value profile = client->profile()->load(Value::undef(), Value::undef());
```

#### Example: List

```cpp
Value profiles = client->profile()->list(Value::undef(), Value::undef());
```


### Rcs

Create an instance: `auto rcs = client->rcs();`

#### Operations

| Method | Description |
| --- | --- |
| `list(match, ctrl)` | List entities, optionally matching the given criteria. |

#### Example: List

```cpp
Value rcss = client->rcs()->list(Value::undef(), Value::undef());
```


### Sendername

Create an instance: `auto sendername = client->sendername();`

#### Operations

| Method | Description |
| --- | --- |
| `create(data, ctrl)` | Create a new entity with the given data. |
| `list(match, ctrl)` | List entities, optionally matching the given criteria. |
| `load(match, ctrl)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `created_at` | `std::string` |  |
| `id` | `std::string` |  |
| `is_default` | `bool` |  |
| `sender` | `std::string` | Sendername |
| `status` | `std::string` |  |

#### Example: Load

```cpp
Value sendername = client->sendername()->load(vmap({{"id", Value("sendername_id")}}), Value::undef());
```

#### Example: List

```cpp
Value sendernames = client->sendername()->list(Value::undef(), Value::undef());
```

#### Example: Create

```cpp
Value sendername = client->sendername()->create(vmap({
}), Value::undef());
```


### SendernameStatement

Create an instance: `auto sendername_statement = client->sendername_statement();`

#### Operations

| Method | Description |
| --- | --- |
| `list(match, ctrl)` | List entities, optionally matching the given criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `content` | `std::string` |  |
| `statements` | `std::vector<Value>` |  |
| `title` | `std::string` |  |

#### Example: List

```cpp
Value sendername_statements = client->sendername_statement()->list(Value::undef(), Value::undef());
```


### SentRcsMessage

Create an instance: `auto sent_rcs_message = client->sent_rcs_message();`

#### Operations

| Method | Description |
| --- | --- |
| `create(data, ctrl)` | Create a new entity with the given data. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `content` | `std::map<std::string, Value>` | RCS message content in RCS JSON format. |
| `phone_number` | `std::string` | Recipient phone number (e.g. |
| `sender` | `Value` |  |
| `text` | `std::string` | Plain text message content. |

#### Example: Create

```cpp
Value sent_rcs_message = client->sent_rcs_message()->create(vmap({
    {"phone_number", Value("example_phone_number")},  // std::string
    {"sender", Value("example_sender")},  // Value
}), Value::undef());
```


### ShipmentCountryVolume

Create an instance: `auto shipment_country_volume = client->shipment_country_volume();`

#### Operations

| Method | Description |
| --- | --- |
| `list(match, ctrl)` | List entities, optionally matching the given criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `country_code` | `std::string` |  |
| `country_limit` | `int64_t` |  |
| `country_name` | `std::string` |  |
| `usage` | `int64_t` |  |

#### Example: List

```cpp
Value shipment_country_volumes = client->shipment_country_volume()->list(Value::undef(), Value::undef());
```


### ShortUrl

Create an instance: `auto short_url = client->short_url();`

#### Operations

| Method | Description |
| --- | --- |
| `create(data, ctrl)` | Create a new entity with the given data. |
| `list(match, ctrl)` | List entities, optionally matching the given criteria. |
| `load(match, ctrl)` | Load a single entity by match criteria. |
| `remove(match, ctrl)` | Remove the matching entity. |
| `update(data, ctrl)` | Update an existing entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `description` | `std::string` |  |
| `expire` | `std::string` |  |
| `filename` | `std::string` |  |
| `hits` | `int64_t` |  |
| `hits_unique` | `int64_t` |  |
| `id` | `std::string` |  |
| `name` | `std::string` |  |
| `short_url` | `std::string` | WHATWG URL compliant |
| `type` | `std::string` |  |
| `url` | `std::string` | WHATWG URL compliant |

#### Example: Load

```cpp
Value short_url = client->short_url()->load(vmap({{"id", Value("short_url_id")}}), Value::undef());
```

#### Example: List

```cpp
Value short_urls = client->short_url()->list(Value::undef(), Value::undef());
```

#### Example: Create

```cpp
Value short_url = client->short_url()->create(vmap({
}), Value::undef());
```


### Smsdo

Create an instance: `auto smsdo = client->smsdo();`

#### Operations

| Method | Description |
| --- | --- |
| `create(data, ctrl)` | Create a new entity with the given data. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `allow_duplicates` | `int64_t` | When parameter allow_duplicates is set to "1" allows to send message to duplicated numbers in one request (useful i.e. |
| `check_idx` | `Value` | When parameter check_idx is set to „1” prevents from sending more than one message with the same idx in last 24h. |
| `date` | `Value` | Date in UNIX timestamp (&date=1287734110) or in ISO 8601 (&date=2012-05-10T08:40:27+00:00) when message will be sent (&date=1287734110). |
| `date_validate` | `int64_t` | When parameter date_validate is set to "1" checks if date if given in proper format. |
| `details` | `Value` | When details parameter is set to "1" more details in response will be displayed (message length and sms count). |
| `encoding` | `std::string` | This parameter describes the encoding of the message text. |
| `expiration_date` | `Value` | Message expiration date (in UNIX timestamp or in ISO 8601) is a date after which message won't be delivered if it wasn't delivered yet. |
| `fallback` | `std::vector<Value>` | Enable fallback in case sms sending fails |
| `fast` | `int64_t` | Setting this parameter to „1” will result in sending message with the highest priority which ensures the quickest possible time of delivery. |
| `flash` | `int64_t` | Sending a message in flash mode can be activated by setting this parameter to "1". |
| `format` | `std::string` | Parameter &format=json causes, that response is sending in JSON format. |
| `from` | `std::string` | Name of the sender. |
| `group` | `std::string` | Name of the group from the contacts database to which message should be sent to. |
| `idx` | `std::string` | Optional custom value sent with SMS and sent back in CALLBACK. |
| `max_parts` | `int64_t` | Defines maximum message parts allowed, maximum value allowed is 6. |
| `message` | `std::string` | The message text. |
| `normalize` | `int64_t` | When parameter normalize is set to „1” special chars in message will be replaced with their equivalents (ê-e, ñ-n, ý-y ...). |
| `notify_url` | `std::string` | Parameter allows to set CALLBACK URL for message from request. |
| `test` | `Value` | When parameter test is set to "1" message won't be sent but response will be displayed, there is no charge for such test messages. |
| `time_restriction` | `std::string` | Sets the behavior when you try to ship in hours / dates that do not match the settings in your account. |
| `to` | `std::string` | Recipients' mobile phone numbers (i.e. |

#### Example: Create

```cpp
Value smsdo = client->smsdo()->create(vmap({
}), Value::undef());
```


### Smssendername

Create an instance: `auto smssendername = client->smssendername();`

#### Operations

| Method | Description |
| --- | --- |
| `create(data, ctrl)` | Create a new entity with the given data. |
| `remove(match, ctrl)` | Remove the matching entity. |

#### Example: Create

```cpp
Value smssendername = client->smssendername()->create(vmap({
    {"sendername_id", Value("example_sendername_id")},  // std::string
}), Value::undef());
```


### Smstemplate

Create an instance: `auto smstemplate = client->smstemplate();`

#### Operations

| Method | Description |
| --- | --- |
| `remove(match, ctrl)` | Remove the matching entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `id` | `std::string` |  |


### Subuser

Create an instance: `auto subuser = client->subuser();`

#### Operations

| Method | Description |
| --- | --- |
| `create(data, ctrl)` | Create a new entity with the given data. |
| `list(match, ctrl)` | List entities, optionally matching the given criteria. |
| `load(match, ctrl)` | Load a single entity by match criteria. |
| `remove(match, ctrl)` | Remove the matching entity. |
| `update(data, ctrl)` | Update an existing entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `active` | `bool` |  |
| `credentials` | `std::map<std::string, Value>` |  |
| `description` | `std::string` |  |
| `id` | `std::string` | Object ID |
| `points` | `std::map<std::string, Value>` |  |
| `username` | `std::string` |  |

#### Example: Load

```cpp
Value subuser = client->subuser()->load(vmap({{"id", Value("subuser_id")}}), Value::undef());
```

#### Example: List

```cpp
Value subusers = client->subuser()->list(Value::undef(), Value::undef());
```

#### Example: Create

```cpp
Value subuser = client->subuser()->create(vmap({
    {"credentials", vmap()},  // std::map<std::string, Value>
}), Value::undef());
```


### Template

Create an instance: `auto template_ = client->template_();`

#### Operations

| Method | Description |
| --- | --- |
| `create(data, ctrl)` | Create a new entity with the given data. |
| `list(match, ctrl)` | List entities, optionally matching the given criteria. |
| `load(match, ctrl)` | Load a single entity by match criteria. |
| `update(data, ctrl)` | Update an existing entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `id` | `std::string` |  |
| `name` | `std::string` |  |
| `normalize` | `bool` |  |
| `template` | `std::string` |  |

#### Example: Load

```cpp
Value template_ = client->template_()->load(vmap({{"id", Value("template_id")}}), Value::undef());
```

#### Example: List

```cpp
Value template_s = client->template_()->list(Value::undef(), Value::undef());
```

#### Example: Create

```cpp
Value template_ = client->template_()->create(vmap({
}), Value::undef());
```


### UserRcsSenderCollection

Create an instance: `auto user_rcs_sender_collection = client->user_rcs_sender_collection();`

#### Operations

| Method | Description |
| --- | --- |
| `list(match, ctrl)` | List entities, optionally matching the given criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `deliveredAt` | `std::string` |  |
| `expiredAt` | `std::string` |  |
| `id` | `std::string` | Object ID |
| `interface` | `std::string` | Interface through which the message was sent (www, api, ...). |
| `messageType` | `std::string` | RCS message type (basic, single, ...). |
| `readAt` | `std::string` |  |
| `recipient` | `std::string` | Recipient phone number (without +). |
| `sender` | `std::string` | Sender name |
| `senderId` | `std::string` | Sender id |
| `sentAt` | `std::string` |  |

#### Example: List

```cpp
Value user_rcs_sender_collections = client->user_rcs_sender_collection()->list(Value::undef(), Value::undef());
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

The C++ SDK uses a single dynamic `sdk::Value` type (a JSON-like variant
over string / number / bool / list / map) throughout rather than generated
typed structs. This mirrors the dynamic nature of the API and keeps the
SDK flexible — no code generation is needed when the API schema changes.

Build maps with `sdk::vmap({{"key", sdk::Value("v")}})` and lists with
`sdk::vlist({...})`; read fields back with `sdk::getp(value, "key")`. Use
`sdk::to_map()` to safely coerce a value that should be a map, and
`sdk::Struct::jsonify(value)` to render it as JSON.

### Directory structure

```
cpp/
├── core/                        -- Runtime type graph, config, generated client
├── entity/                      -- Per-entity client headers
├── feature/                     -- Built-in features (Base, Test, Log, ...)
├── utility/                     -- Operation pipeline + vendored struct library
├── test/                        -- Test suites
├── Makefile                     -- Build & run the tests (C++17)
└── VERSION                      -- SDK version
```

Include the umbrella header `core/sdk.hpp` to pull in the whole SDK: the
runtime types, the pipeline utilities, the vendored struct, the generated
config, the per-entity clients and the generated `SmsapiSDK`
client class. Everything lives in the `sdk` namespace.

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
