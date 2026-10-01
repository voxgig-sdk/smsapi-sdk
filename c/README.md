# Smsapi C SDK

An MCP server and CLI for the SMSAPI REST API, plus clients in 20 languages and a pandas data layer, generated from SMSAPI's public OpenAPI spec so AI agents can reach SMSAPI the way the official SDKs already let developers.

The C SDK for the Smsapi API — an entity-oriented client following idiomatic C conventions (explicit structs, function-pointer vtables, and a trailing `PNError**` out-param for errors).

The SDK exposes the API as capitalised, semantic **Entities** — for example `smsapi_available(client, NULL)` — each
carrying a small, uniform set of operations (`list`, `load`, `create`, `update`, `remove`) instead of raw URL
paths and query strings. You work with named resources and verbs, which
keeps the cognitive load low.

> Other languages, the CLI, and MCP server live alongside this one — see
> the [top-level README](../README.md).


## Install
C has no central package registry — a release is the git tag
(`c/vX.Y.Z`, see [Releases](https://github.com/voxgig-sdk/smsapi-sdk/releases)). Build from a
source checkout with the bundled `Makefile`; the voxgig struct library is
vendored under `utility/struct`, so there are no external dependencies to
fetch:

```bash
cd c && make          # builds libsdk.a
cd c && make test     # builds + runs the test binaries
```

Link your program against `libsdk.a` and include `core/api.h`:

```bash
cc -I c/core -I c/utility/struct \
   myapp.c c/libsdk.a -lm -o myapp
```


## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record.

### 1. Create a client

```c
#include "core/api.h"

SmsapiSDK* client = smsapi_sdk_new(cmap(1,
    "apikey", v_str(getenv("SMSAPI_APIKEY"))));
PNError* err = NULL;
```

### 2. List available records

`list()` returns a List of records and sets `*err` on failure — check
`err` after the call.

```c
Entity* available = smsapi_available(client, NULL);
voxgig_value* availables = available->vt->list(available, NULL, NULL, &err);
if (err) {
    fprintf(stderr, "list failed: %s\n", err->msg);
} else {
    for (size_t i = 0; i < (size_t)voxgig_size(availables); i++) {
        printf("%s\n", voxgig_to_json(voxgig_getelem(availables, v_int(i), NULL)));
    }
}
```

### 3. Load a permission

Permission is nested under group, so provide the `group_id`.
`load()` returns the bare record and sets `*err` on failure.

```c
Entity* permission = smsapi_permission(client, NULL);
voxgig_value* permission_rec = permission->vt->load(permission, cmap(3, "group_id", v_str("example_group_id"), "username", v_str("example_username"), "id", v_str("example_id")), NULL, &err);
if (err) {
    fprintf(stderr, "load failed: %s\n", err->msg);
} else {
    printf("%s\n", voxgig_to_json(permission_rec));
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

For endpoints not covered by entity operations:

```c
PNError* err = NULL;
voxgig_value* result = sdk_direct(client, cmap(3,
    "path", v_str("/api/resource/{id}"),
    "method", v_str("GET"),
    "params", cmap(1, "id", v_str("example"))), &err);

if (voxgig_as_bool(getp(result, "ok"))) {
    printf("%lld\n", (long long)to_int(getp(result, "status")));  // 200
    printf("%s\n", voxgig_to_json(getp(result, "data")));         // response body
} else {
    // A non-2xx response carries status + data (the error body); a
    // transport-level failure carries err instead. Only one is present.
    printf("%s\n", voxgig_to_json(getp(result, "err")));
}
```

`sdk_direct()` never sets `*err` for a non-2xx response — it always returns
a result map you branch on via `getp(result, "ok")`.

### Prepare a request without sending it

```c
PNError* err = NULL;
voxgig_value* fetchdef = sdk_prepare(client, cmap(3,
    "path", v_str("/api/resource/{id}"),
    "method", v_str("DELETE"),
    "params", cmap(1, "id", v_str("example"))), &err);

printf("%s\n", get_str(fetchdef, "url"));
printf("%s\n", get_str(fetchdef, "method"));
printf("%s\n", voxgig_to_json(getp(fetchdef, "headers")));
```

### Use test mode

Create a mock client for unit testing — no server required:

```c
SmsapiSDK* client = test_sdk(NULL, NULL);
PNError* err = NULL;

// Entity ops return the bare record and set *err on failure.
Entity* permission = smsapi_permission(client, NULL);
voxgig_value* permission_rec = permission->vt->load(permission, cmap(1, "id", v_str("test01")), NULL, &err);
// permission_rec contains the mock response record
```

### Use a custom fetch function

Replace the HTTP transport with your own function (the same shape the test
transport uses):

```c
static voxgig_value* mock_fetch(void* ud, voxgig_value* args) {
    (void)ud; (void)args;
    return cmap(4,
        "status", v_num(200),
        "statusText", v_str("OK"),
        "headers", v_map(),
        "json", json_thunk(cmap(1, "id", v_str("mock01"))));
}

SmsapiSDK* client = smsapi_sdk_new(cmap(2,
    "base", v_str("http://localhost:8080"),
    "system", cmap(1, "fetch", vfn(mock_fetch, NULL))));
```

### Point at a different server

Override the base URL to reach a local or staging server:

```c
SmsapiSDK* client = smsapi_sdk_new(cmap(1,
    "base", v_str("http://localhost:8080")));
```

### Run live tests

Create a `.env.local` file at the project root:

```
SMSAPI_TEST_LIVE=TRUE
SMSAPI_APIKEY=<your-key>
```

Then run:

```bash
cd c && make test
```


## Reference

### SmsapiSDK

```c
#include "core/api.h"

SmsapiSDK* client = smsapi_sdk_new(options);
```

Creates a new SDK client. `options` is a `voxgig_value*` map (`NULL` for
none) carrying any of the following keys:

| Option | Value type | Description |
| --- | --- | --- |
| `apikey` | `string` | API key for authentication. |
| `base` | `string` | Base URL of the API server. |
| `prefix` | `string` | URL path prefix prepended to all requests. |
| `suffix` | `string` | URL path suffix appended to all requests. |
| `feature` | `map` | Feature activation flags. |
| `system` | `map` | System overrides (e.g. a custom `fetch`). |

### test_sdk

```c
SmsapiSDK* client = test_sdk(testopts, sdkopts);
```

Creates a test-mode client with mock transport. Both arguments may be
`NULL`.

### SmsapiSDK functions

| Function | Signature | Description |
| --- | --- | --- |
| `sdk_prepare` | `(SmsapiSDK*, fetchargs, PNError**) -> voxgig_value*` | Build an HTTP request definition without sending. |
| `sdk_direct` | `(SmsapiSDK*, fetchargs, PNError**) -> voxgig_value*` | Build and send an HTTP request. Returns a result map (branch on `ok`). |
| `smsapi_available` | `(SmsapiSDK*, entopts) -> Entity*` | Create an Available entity instance. |
| `smsapi_blacklist` | `(SmsapiSDK*, entopts) -> Entity*` | Create a Blacklist entity instance. |
| `smsapi_callback` | `(SmsapiSDK*, entopts) -> Entity*` | Create a Callback entity instance. |
| `smsapi_contact` | `(SmsapiSDK*, entopts) -> Entity*` | Create a Contact entity instance. |
| `smsapi_contacts_field` | `(SmsapiSDK*, entopts) -> Entity*` | Create a ContactsField entity instance. |
| `smsapi_contacts_field_option` | `(SmsapiSDK*, entopts) -> Entity*` | Create a ContactsFieldOption entity instance. |
| `smsapi_contactsgroup` | `(SmsapiSDK*, entopts) -> Entity*` | Create a Contactsgroup entity instance. |
| `smsapi_contactstrash` | `(SmsapiSDK*, entopts) -> Entity*` | Create a Contactstrash entity instance. |
| `smsapi_field_available` | `(SmsapiSDK*, entopts) -> Entity*` | Create a FieldAvailable entity instance. |
| `smsapi_group` | `(SmsapiSDK*, entopts) -> Entity*` | Create a Group entity instance. |
| `smsapi_mfa_code` | `(SmsapiSDK*, entopts) -> Entity*` | Create a MfaCode entity instance. |
| `smsapi_opt_out` | `(SmsapiSDK*, entopts) -> Entity*` | Create an OptOut entity instance. |
| `smsapi_opt_out_setting` | `(SmsapiSDK*, entopts) -> Entity*` | Create an OptOutSetting entity instance. |
| `smsapi_permission` | `(SmsapiSDK*, entopts) -> Entity*` | Create a Permission entity instance. |
| `smsapi_ping` | `(SmsapiSDK*, entopts) -> Entity*` | Create a Ping entity instance. |
| `smsapi_profile` | `(SmsapiSDK*, entopts) -> Entity*` | Create a Profile entity instance. |
| `smsapi_rcs` | `(SmsapiSDK*, entopts) -> Entity*` | Create a Rcs entity instance. |
| `smsapi_sendername` | `(SmsapiSDK*, entopts) -> Entity*` | Create a Sendername entity instance. |
| `smsapi_sendername_statement` | `(SmsapiSDK*, entopts) -> Entity*` | Create a SendernameStatement entity instance. |
| `smsapi_sent_rcs_message` | `(SmsapiSDK*, entopts) -> Entity*` | Create a SentRcsMessage entity instance. |
| `smsapi_shipment_country_volume` | `(SmsapiSDK*, entopts) -> Entity*` | Create a ShipmentCountryVolume entity instance. |
| `smsapi_short_url` | `(SmsapiSDK*, entopts) -> Entity*` | Create a ShortUrl entity instance. |
| `smsapi_smsdo` | `(SmsapiSDK*, entopts) -> Entity*` | Create a Smsdo entity instance. |
| `smsapi_smssendername` | `(SmsapiSDK*, entopts) -> Entity*` | Create a Smssendername entity instance. |
| `smsapi_smstemplate` | `(SmsapiSDK*, entopts) -> Entity*` | Create a Smstemplate entity instance. |
| `smsapi_subuser` | `(SmsapiSDK*, entopts) -> Entity*` | Create a Subuser entity instance. |
| `smsapi_template` | `(SmsapiSDK*, entopts) -> Entity*` | Create a Template entity instance. |
| `smsapi_user_rcs_sender_collection` | `(SmsapiSDK*, entopts) -> Entity*` | Create an UserRcsSenderCollection entity instance. |

### Entity interface (vtable)

All entities share the same `EntityVT` vtable, reached via `e->vt->...`.

| Method | Signature | Description |
| --- | --- | --- |
| `load` | `(Entity*, reqmatch, ctrl, PNError**) -> voxgig_value*` | Load a single entity by match criteria. |
| `list` | `(Entity*, reqmatch, ctrl, PNError**) -> voxgig_value*` | List entities matching the criteria (a List). |
| `create` | `(Entity*, reqdata, ctrl, PNError**) -> voxgig_value*` | Create a new entity. |
| `update` | `(Entity*, reqdata, ctrl, PNError**) -> voxgig_value*` | Update an existing entity. |
| `remove` | `(Entity*, reqmatch, ctrl, PNError**) -> voxgig_value*` | Remove an entity. |
| `data` | `(Entity*, args) -> voxgig_value*` | Get entity data (pass a map to set). |
| `matchv` | `(Entity*, args) -> voxgig_value*` | Get entity match criteria (pass a map to set). |
| `make` | `(Entity*) -> Entity*` | Create a new instance with the same options. |
| `get_name` | `(Entity*) -> const char*` | Return the entity name. |

### Result shape

Entity operations return the bare result data (a `voxgig_value` map for
single-entity ops, a List for `list`) and set `*err` to a `PNError*` on
failure. Always initialise `PNError* err = NULL;` and check it after the
call.

The `sdk_direct()` escape hatch never sets `*err` for a non-2xx response —
it returns a result map you branch on via `getp(result, "ok")`:

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

Create an instance: `Entity* available = smsapi_available(client, NULL);`

#### Operations

| Method | Description |
| --- | --- |
| `vt->list(e, reqmatch, ctrl, &err)` | List entities, optionally matching the given criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `name` | `char*` |  |
| `normalize` | `bool` |  |
| `template` | `char*` |  |

#### Example: List

```c
Entity* available = smsapi_available(client, NULL);
voxgig_value* availables = available->vt->list(available, NULL, NULL, &err);
```


### Blacklist

Create an instance: `Entity* blacklist = smsapi_blacklist(client, NULL);`

#### Operations

| Method | Description |
| --- | --- |
| `vt->create(e, reqdata, ctrl, &err)` | Create a new entity with the given data. |
| `vt->load(e, reqmatch, ctrl, &err)` | Load a single entity by match criteria. |
| `vt->remove(e, reqmatch, ctrl, &err)` | Remove the matching entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `id` | `char*` |  |

#### Example: Load

```c
Entity* blacklist = smsapi_blacklist(client, NULL);
voxgig_value* blacklist_rec = blacklist->vt->load(blacklist, NULL, NULL, &err);
```

#### Example: Create

```c
Entity* blacklist = smsapi_blacklist(client, NULL);
voxgig_value* blacklist_rec = blacklist->vt->create(blacklist, NULL, NULL, &err);
```


### Callback

Create an instance: `Entity* callback = smsapi_callback(client, NULL);`

#### Operations

| Method | Description |
| --- | --- |
| `vt->create(e, reqdata, ctrl, &err)` | Create a new entity with the given data. |
| `vt->list(e, reqmatch, ctrl, &err)` | List entities, optionally matching the given criteria. |
| `vt->load(e, reqmatch, ctrl, &err)` | Load a single entity by match criteria. |
| `vt->remove(e, reqmatch, ctrl, &err)` | Remove the matching entity. |
| `vt->update(e, reqdata, ctrl, &err)` | Update an existing entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `active` | `bool` |  |
| `api_version` | `int64_t` | Version of the callback output format. |
| `id` | `char*` | Object ID |
| `invalid` | `bool` |  |
| `receiver` | `voxgig_value* (map)` |  |
| `receiver_type` | `char*` |  |
| `type` | `char*` |  |
| `url` | `char*` | WHATWG URL compliant |

#### Example: Load

```c
Entity* callback = smsapi_callback(client, NULL);
voxgig_value* callback_rec = callback->vt->load(callback, cmap(1, "id", v_str("callback_id")), NULL, &err);
```

#### Example: List

```c
Entity* callback = smsapi_callback(client, NULL);
voxgig_value* callbacks = callback->vt->list(callback, NULL, NULL, &err);
```

#### Example: Create

```c
Entity* callback = smsapi_callback(client, NULL);
voxgig_value* callback_rec = callback->vt->create(callback, NULL, NULL, &err);
```


### Contact

Create an instance: `Entity* contact = smsapi_contact(client, NULL);`

#### Operations

| Method | Description |
| --- | --- |
| `vt->create(e, reqdata, ctrl, &err)` | Create a new entity with the given data. |
| `vt->list(e, reqmatch, ctrl, &err)` | List entities, optionally matching the given criteria. |
| `vt->load(e, reqmatch, ctrl, &err)` | Load a single entity by match criteria. |
| `vt->remove(e, reqmatch, ctrl, &err)` | Remove the matching entity. |
| `vt->update(e, reqdata, ctrl, &err)` | Update an existing entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `birthday_date` | `char*` |  |
| `city` | `char*` |  |
| `collection` | `voxgig_value* (list)` |  |
| `contact_expire_after` | `int64_t` | Contact expire after days |
| `contacts_count` | `int64_t` |  |
| `country` | `char*` |  |
| `created_by` | `char*` |  |
| `date_created` | `char*` |  |
| `date_updated` | `char*` |  |
| `description` | `char*` |  |
| `email` | `char*` |  |
| `first_name` | `char*` |  |
| `gender` | `char*` |  |
| `group_id` | `char*` | Object ID |
| `groups` | `voxgig_value* (list)` |  |
| `id` | `char*` | Object ID |
| `idx` | `char*` | User provided resource id |
| `last_name` | `char*` |  |
| `name` | `char*` | Group name |
| `permissions` | `voxgig_value* (list)` |  |
| `phone_number` | `char*` |  |
| `read` | `bool` | Has read permission |
| `send` | `bool` | Has send permission |
| `size` | `int64_t` |  |
| `source` | `char*` |  |
| `type` | `char*` |  |
| `username` | `char*` |  |
| `value` | `char*` |  |
| `write` | `bool` | Has write permission |

#### Example: Load

```c
Entity* contact = smsapi_contact(client, NULL);
voxgig_value* contact_rec = contact->vt->load(contact, cmap(1, "id", v_str("contact_id")), NULL, &err);
```

#### Example: List

```c
Entity* contact = smsapi_contact(client, NULL);
voxgig_value* contacts = contact->vt->list(contact, NULL, NULL, &err);
```

#### Example: Create

```c
Entity* contact = smsapi_contact(client, NULL);
voxgig_value* contact_rec = contact->vt->create(contact, cmap(11,
    "collection", v_list(),  // voxgig_value* (list)
    "contact_expire_after", v_num(1),  // int64_t
    "contacts_count", v_num(1),  // int64_t
    "created_by", v_str("example_created_by"),  // char*
    "date_created", v_str("example_date_created"),  // char*
    "date_updated", v_str("example_date_updated"),  // char*
    "gender", v_str("example_gender"),  // char*
    "groups", v_list(),  // voxgig_value* (list)
    "id", v_str("example_id"),  // char*
    "name", v_str("example_name"),  // char*
    "size", v_num(1))  // int64_t
, NULL, &err);
```


### ContactsField

Create an instance: `Entity* contacts_field = smsapi_contacts_field(client, NULL);`

#### Operations

| Method | Description |
| --- | --- |
| `vt->create(e, reqdata, ctrl, &err)` | Create a new entity with the given data. |
| `vt->list(e, reqmatch, ctrl, &err)` | List entities, optionally matching the given criteria. |
| `vt->remove(e, reqmatch, ctrl, &err)` | Remove the matching entity. |
| `vt->update(e, reqdata, ctrl, &err)` | Update an existing entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `birthday_date` | `char*` |  |
| `city` | `char*` |  |
| `contact_expire_after` | `int64_t` | Contact expire after days |
| `contacts_count` | `int64_t` |  |
| `country` | `char*` |  |
| `created_by` | `char*` |  |
| `date_created` | `char*` |  |
| `date_updated` | `char*` |  |
| `description` | `char*` |  |
| `email` | `char*` |  |
| `first_name` | `char*` |  |
| `gender` | `char*` |  |
| `group_id` | `char*` | Object ID |
| `groups` | `voxgig_value* (list)` |  |
| `id` | `char*` | Object ID |
| `idx` | `char*` | User provided resource id |
| `last_name` | `char*` |  |
| `name` | `char*` | Group name |
| `permissions` | `voxgig_value* (list)` |  |
| `phone_number` | `char*` |  |
| `read` | `bool` | Has read permission |
| `send` | `bool` | Has send permission |
| `source` | `char*` |  |
| `type` | `char*` |  |
| `username` | `char*` |  |
| `value` | `char*` |  |
| `write` | `bool` | Has write permission |

#### Example: List

```c
Entity* contacts_field = smsapi_contacts_field(client, NULL);
voxgig_value* contacts_fields = contacts_field->vt->list(contacts_field, NULL, NULL, &err);
```

#### Example: Create

```c
Entity* contacts_field = smsapi_contacts_field(client, NULL);
voxgig_value* contacts_field_rec = contacts_field->vt->create(contacts_field, cmap(6,
    "contact_expire_after", v_num(1),  // int64_t
    "created_by", v_str("example_created_by"),  // char*
    "date_created", v_str("example_date_created"),  // char*
    "date_updated", v_str("example_date_updated"),  // char*
    "gender", v_str("example_gender"),  // char*
    "groups", v_list())  // voxgig_value* (list)
, NULL, &err);
```


### ContactsFieldOption

Create an instance: `Entity* contacts_field_option = smsapi_contacts_field_option(client, NULL);`

#### Operations

| Method | Description |
| --- | --- |
| `vt->list(e, reqmatch, ctrl, &err)` | List entities, optionally matching the given criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `birthday_date` | `char*` |  |
| `city` | `char*` |  |
| `contact_expire_after` | `int64_t` | Contact expire after days |
| `contacts_count` | `int64_t` |  |
| `country` | `char*` |  |
| `created_by` | `char*` |  |
| `date_created` | `char*` |  |
| `date_updated` | `char*` |  |
| `description` | `char*` |  |
| `email` | `char*` |  |
| `first_name` | `char*` |  |
| `gender` | `char*` |  |
| `group_id` | `char*` | Object ID |
| `groups` | `voxgig_value* (list)` |  |
| `id` | `char*` | Object ID |
| `idx` | `char*` | User provided resource id |
| `last_name` | `char*` |  |
| `name` | `char*` | Group name |
| `permissions` | `voxgig_value* (list)` |  |
| `phone_number` | `char*` |  |
| `read` | `bool` | Has read permission |
| `send` | `bool` | Has send permission |
| `source` | `char*` |  |
| `type` | `char*` |  |
| `username` | `char*` |  |
| `value` | `char*` |  |
| `write` | `bool` | Has write permission |

#### Example: List

```c
Entity* contacts_field_option = smsapi_contacts_field_option(client, NULL);
voxgig_value* contacts_field_options = contacts_field_option->vt->list(contacts_field_option, NULL, NULL, &err);
```


### Contactsgroup

Create an instance: `Entity* contactsgroup = smsapi_contactsgroup(client, NULL);`

#### Operations

| Method | Description |
| --- | --- |
| `vt->create(e, reqdata, ctrl, &err)` | Create a new entity with the given data. |
| `vt->list(e, reqmatch, ctrl, &err)` | List entities, optionally matching the given criteria. |
| `vt->remove(e, reqmatch, ctrl, &err)` | Remove the matching entity. |
| `vt->update(e, reqdata, ctrl, &err)` | Update an existing entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `birthday_date` | `char*` |  |
| `city` | `char*` |  |
| `contact_expire_after` | `int64_t` | Contact expire after days |
| `contacts_count` | `int64_t` |  |
| `country` | `char*` |  |
| `created_by` | `char*` |  |
| `date_created` | `char*` |  |
| `date_updated` | `char*` |  |
| `description` | `char*` |  |
| `email` | `char*` |  |
| `first_name` | `char*` |  |
| `gender` | `char*` |  |
| `group_id` | `char*` | Object ID |
| `groups` | `voxgig_value* (list)` |  |
| `id` | `char*` | Object ID |
| `idx` | `char*` | User provided resource id |
| `last_name` | `char*` |  |
| `name` | `char*` | Group name |
| `permissions` | `voxgig_value* (list)` |  |
| `phone_number` | `char*` |  |
| `read` | `bool` | Has read permission |
| `send` | `bool` | Has send permission |
| `source` | `char*` |  |
| `type` | `char*` |  |
| `username` | `char*` |  |
| `value` | `char*` |  |
| `write` | `bool` | Has write permission |

#### Example: List

```c
Entity* contactsgroup = smsapi_contactsgroup(client, NULL);
voxgig_value* contactsgroups = contactsgroup->vt->list(contactsgroup, NULL, NULL, &err);
```

#### Example: Create

```c
Entity* contactsgroup = smsapi_contactsgroup(client, NULL);
voxgig_value* contactsgroup_rec = contactsgroup->vt->create(contactsgroup, cmap(12,
    "contact_expire_after", v_num(1),  // int64_t
    "created_by", v_str("example_created_by"),  // char*
    "date_created", v_str("example_date_created"),  // char*
    "date_updated", v_str("example_date_updated"),  // char*
    "gender", v_str("example_gender"),  // char*
    "group_id", v_str("example_group_id"),  // char*
    "groups", v_list(),  // voxgig_value* (list)
    "id", v_str("example_id"),  // char*
    "read", v_bool(true),  // bool
    "send", v_bool(true),  // bool
    "username", v_str("example_username"),  // char*
    "write", v_bool(true))  // bool
, NULL, &err);
```


### Contactstrash

Create an instance: `Entity* contactstrash = smsapi_contactstrash(client, NULL);`

#### Operations

| Method | Description |
| --- | --- |
| `vt->remove(e, reqmatch, ctrl, &err)` | Remove the matching entity. |
| `vt->update(e, reqdata, ctrl, &err)` | Update an existing entity. |


### FieldAvailable

Create an instance: `Entity* field_available = smsapi_field_available(client, NULL);`

#### Operations

| Method | Description |
| --- | --- |
| `vt->list(e, reqmatch, ctrl, &err)` | List entities, optionally matching the given criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `built_in` | `bool` |  |
| `id` | `char*` | Object ID |
| `name` | `char*` |  |
| `options` | `voxgig_value* (list)` |  |
| `type` | `char*` |  |

#### Example: List

```c
Entity* field_available = smsapi_field_available(client, NULL);
voxgig_value* field_availables = field_available->vt->list(field_available, NULL, NULL, &err);
```


### Group

Create an instance: `Entity* group = smsapi_group(client, NULL);`

#### Operations

| Method | Description |
| --- | --- |
| `vt->load(e, reqmatch, ctrl, &err)` | Load a single entity by match criteria. |
| `vt->update(e, reqdata, ctrl, &err)` | Update an existing entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `contact_expire_after` | `int64_t` | Contact expire after days |
| `contacts_count` | `int64_t` |  |
| `created_by` | `char*` |  |
| `date_created` | `char*` |  |
| `date_updated` | `char*` |  |
| `description` | `char*` |  |
| `id` | `char*` | Object ID |
| `idx` | `char*` | User provided resource id |
| `name` | `char*` | Group name |
| `permissions` | `voxgig_value* (list)` |  |

#### Example: Load

```c
Entity* group = smsapi_group(client, NULL);
voxgig_value* group_rec = group->vt->load(group, cmap(1, "id", v_str("group_id")), NULL, &err);
```


### MfaCode

Create an instance: `Entity* mfa_code = smsapi_mfa_code(client, NULL);`

#### Operations

| Method | Description |
| --- | --- |
| `vt->create(e, reqdata, ctrl, &err)` | Create a new entity with the given data. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `content` | `char*` | Custom content that must contain placeholder [%code%] |
| `fast` | `voxgig_value*` |  |
| `from` | `char*` | Sendername |
| `phone_number` | `char*` |  |

#### Example: Create

```c
Entity* mfa_code = smsapi_mfa_code(client, NULL);
voxgig_value* mfa_code_rec = mfa_code->vt->create(mfa_code, cmap(1,
    "phone_number", v_str("example_phone_number"))  // char*
, NULL, &err);
```


### OptOut

Create an instance: `Entity* opt_out = smsapi_opt_out(client, NULL);`

#### Operations

| Method | Description |
| --- | --- |
| `vt->list(e, reqmatch, ctrl, &err)` | List entities, optionally matching the given criteria. |
| `vt->remove(e, reqmatch, ctrl, &err)` | Remove the matching entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `date` | `char*` |  |
| `id` | `char*` |  |
| `links` | `voxgig_value* (list)` |  |
| `phoneNumber` | `int64_t` |  |

#### Example: List

```c
Entity* opt_out = smsapi_opt_out(client, NULL);
voxgig_value* opt_outs = opt_out->vt->list(opt_out, NULL, NULL, &err);
```


### OptOutSetting

Create an instance: `Entity* opt_out_setting = smsapi_opt_out_setting(client, NULL);`

#### Operations

| Method | Description |
| --- | --- |
| `vt->load(e, reqmatch, ctrl, &err)` | Load a single entity by match criteria. |
| `vt->update(e, reqdata, ctrl, &err)` | Update an existing entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `brand` | `char*` |  |

#### Example: Load

```c
Entity* opt_out_setting = smsapi_opt_out_setting(client, NULL);
voxgig_value* opt_out_setting_rec = opt_out_setting->vt->load(opt_out_setting, NULL, NULL, &err);
```


### Permission

Create an instance: `Entity* permission = smsapi_permission(client, NULL);`

#### Operations

| Method | Description |
| --- | --- |
| `vt->create(e, reqdata, ctrl, &err)` | Create a new entity with the given data. |
| `vt->load(e, reqmatch, ctrl, &err)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `group_id` | `char*` | Object ID |
| `id` | `char*` |  |
| `read` | `bool` | Has read permission |
| `send` | `bool` | Has send permission |
| `username` | `char*` |  |
| `write` | `bool` | Has write permission |

#### Example: Load

```c
Entity* permission = smsapi_permission(client, NULL);
voxgig_value* permission_rec = permission->vt->load(permission, cmap(3, "id", v_str("permission_id"), "group_id", v_str("group_id"), "username", v_str("username")), NULL, &err);
```

#### Example: Create

```c
Entity* permission = smsapi_permission(client, NULL);
voxgig_value* permission_rec = permission->vt->create(permission, cmap(5,
    "group_id", v_str("example_group_id"),  // char*
    "read", v_bool(true),  // bool
    "send", v_bool(true),  // bool
    "username", v_str("example_username"),  // char*
    "write", v_bool(true))  // bool
, NULL, &err);
```


### Ping

Create an instance: `Entity* ping = smsapi_ping(client, NULL);`

#### Operations

| Method | Description |
| --- | --- |
| `vt->list(e, reqmatch, ctrl, &err)` | List entities, optionally matching the given criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `authorized` | `bool` |  |
| `unavailable` | `voxgig_value* (list)` |  |

#### Example: List

```c
Entity* ping = smsapi_ping(client, NULL);
voxgig_value* pings = ping->vt->list(ping, NULL, NULL, &err);
```


### Profile

Create an instance: `Entity* profile = smsapi_profile(client, NULL);`

#### Operations

| Method | Description |
| --- | --- |
| `vt->list(e, reqmatch, ctrl, &err)` | List entities, optionally matching the given criteria. |
| `vt->load(e, reqmatch, ctrl, &err)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `email` | `char*` |  |
| `name` | `char*` |  |
| `payment_type` | `char*` |  |
| `phone_number` | `int64_t` |  |
| `points` | `double` |  |
| `user_type` | `char*` |  |
| `username` | `char*` |  |

#### Example: Load

```c
Entity* profile = smsapi_profile(client, NULL);
voxgig_value* profile_rec = profile->vt->load(profile, NULL, NULL, &err);
```

#### Example: List

```c
Entity* profile = smsapi_profile(client, NULL);
voxgig_value* profiles = profile->vt->list(profile, NULL, NULL, &err);
```


### Rcs

Create an instance: `Entity* rcs = smsapi_rcs(client, NULL);`

#### Operations

| Method | Description |
| --- | --- |
| `vt->list(e, reqmatch, ctrl, &err)` | List entities, optionally matching the given criteria. |

#### Example: List

```c
Entity* rcs = smsapi_rcs(client, NULL);
voxgig_value* rcss = rcs->vt->list(rcs, NULL, NULL, &err);
```


### Sendername

Create an instance: `Entity* sendername = smsapi_sendername(client, NULL);`

#### Operations

| Method | Description |
| --- | --- |
| `vt->create(e, reqdata, ctrl, &err)` | Create a new entity with the given data. |
| `vt->list(e, reqmatch, ctrl, &err)` | List entities, optionally matching the given criteria. |
| `vt->load(e, reqmatch, ctrl, &err)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `created_at` | `char*` |  |
| `id` | `char*` |  |
| `is_default` | `bool` |  |
| `sender` | `char*` | Sendername |
| `status` | `char*` |  |

#### Example: Load

```c
Entity* sendername = smsapi_sendername(client, NULL);
voxgig_value* sendername_rec = sendername->vt->load(sendername, cmap(1, "id", v_str("sendername_id")), NULL, &err);
```

#### Example: List

```c
Entity* sendername = smsapi_sendername(client, NULL);
voxgig_value* sendernames = sendername->vt->list(sendername, NULL, NULL, &err);
```

#### Example: Create

```c
Entity* sendername = smsapi_sendername(client, NULL);
voxgig_value* sendername_rec = sendername->vt->create(sendername, NULL, NULL, &err);
```


### SendernameStatement

Create an instance: `Entity* sendername_statement = smsapi_sendername_statement(client, NULL);`

#### Operations

| Method | Description |
| --- | --- |
| `vt->list(e, reqmatch, ctrl, &err)` | List entities, optionally matching the given criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `content` | `char*` |  |
| `statements` | `voxgig_value* (list)` |  |
| `title` | `char*` |  |

#### Example: List

```c
Entity* sendername_statement = smsapi_sendername_statement(client, NULL);
voxgig_value* sendername_statements = sendername_statement->vt->list(sendername_statement, NULL, NULL, &err);
```


### SentRcsMessage

Create an instance: `Entity* sent_rcs_message = smsapi_sent_rcs_message(client, NULL);`

#### Operations

| Method | Description |
| --- | --- |
| `vt->create(e, reqdata, ctrl, &err)` | Create a new entity with the given data. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `content` | `voxgig_value* (map)` | RCS message content in RCS JSON format. |
| `phone_number` | `char*` | Recipient phone number (e.g. |
| `sender` | `voxgig_value*` |  |
| `text` | `char*` | Plain text message content. |

#### Example: Create

```c
Entity* sent_rcs_message = smsapi_sent_rcs_message(client, NULL);
voxgig_value* sent_rcs_message_rec = sent_rcs_message->vt->create(sent_rcs_message, cmap(2,
    "phone_number", v_str("example_phone_number"),  // char*
    "sender", v_str("example_sender"))  // voxgig_value*
, NULL, &err);
```


### ShipmentCountryVolume

Create an instance: `Entity* shipment_country_volume = smsapi_shipment_country_volume(client, NULL);`

#### Operations

| Method | Description |
| --- | --- |
| `vt->list(e, reqmatch, ctrl, &err)` | List entities, optionally matching the given criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `country_code` | `char*` |  |
| `country_limit` | `int64_t` |  |
| `country_name` | `char*` |  |
| `usage` | `int64_t` |  |

#### Example: List

```c
Entity* shipment_country_volume = smsapi_shipment_country_volume(client, NULL);
voxgig_value* shipment_country_volumes = shipment_country_volume->vt->list(shipment_country_volume, NULL, NULL, &err);
```


### ShortUrl

Create an instance: `Entity* short_url = smsapi_short_url(client, NULL);`

#### Operations

| Method | Description |
| --- | --- |
| `vt->create(e, reqdata, ctrl, &err)` | Create a new entity with the given data. |
| `vt->list(e, reqmatch, ctrl, &err)` | List entities, optionally matching the given criteria. |
| `vt->load(e, reqmatch, ctrl, &err)` | Load a single entity by match criteria. |
| `vt->remove(e, reqmatch, ctrl, &err)` | Remove the matching entity. |
| `vt->update(e, reqdata, ctrl, &err)` | Update an existing entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `description` | `char*` |  |
| `expire` | `char*` |  |
| `filename` | `char*` |  |
| `hits` | `int64_t` |  |
| `hits_unique` | `int64_t` |  |
| `id` | `char*` |  |
| `name` | `char*` |  |
| `short_url` | `char*` | WHATWG URL compliant |
| `type` | `char*` |  |
| `url` | `char*` | WHATWG URL compliant |

#### Example: Load

```c
Entity* short_url = smsapi_short_url(client, NULL);
voxgig_value* short_url_rec = short_url->vt->load(short_url, cmap(1, "id", v_str("short_url_id")), NULL, &err);
```

#### Example: List

```c
Entity* short_url = smsapi_short_url(client, NULL);
voxgig_value* short_urls = short_url->vt->list(short_url, NULL, NULL, &err);
```

#### Example: Create

```c
Entity* short_url = smsapi_short_url(client, NULL);
voxgig_value* short_url_rec = short_url->vt->create(short_url, NULL, NULL, &err);
```


### Smsdo

Create an instance: `Entity* smsdo = smsapi_smsdo(client, NULL);`

#### Operations

| Method | Description |
| --- | --- |
| `vt->create(e, reqdata, ctrl, &err)` | Create a new entity with the given data. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `allow_duplicates` | `int64_t` | When parameter allow_duplicates is set to "1" allows to send message to duplicated numbers in one request (useful i.e. |
| `check_idx` | `voxgig_value*` | When parameter check_idx is set to „1” prevents from sending more than one message with the same idx in last 24h. |
| `date` | `voxgig_value*` | Date in UNIX timestamp (&date=1287734110) or in ISO 8601 (&date=2012-05-10T08:40:27+00:00) when message will be sent (&date=1287734110). |
| `date_validate` | `int64_t` | When parameter date_validate is set to "1" checks if date if given in proper format. |
| `details` | `voxgig_value*` | When details parameter is set to "1" more details in response will be displayed (message length and sms count). |
| `encoding` | `char*` | This parameter describes the encoding of the message text. |
| `expiration_date` | `voxgig_value*` | Message expiration date (in UNIX timestamp or in ISO 8601) is a date after which message won't be delivered if it wasn't delivered yet. |
| `fallback` | `voxgig_value* (list)` | Enable fallback in case sms sending fails |
| `fast` | `int64_t` | Setting this parameter to „1” will result in sending message with the highest priority which ensures the quickest possible time of delivery. |
| `flash` | `int64_t` | Sending a message in flash mode can be activated by setting this parameter to "1". |
| `format` | `char*` | Parameter &format=json causes, that response is sending in JSON format. |
| `from` | `char*` | Name of the sender. |
| `group` | `char*` | Name of the group from the contacts database to which message should be sent to. |
| `idx` | `char*` | Optional custom value sent with SMS and sent back in CALLBACK. |
| `max_parts` | `int64_t` | Defines maximum message parts allowed, maximum value allowed is 6. |
| `message` | `char*` | The message text. |
| `normalize` | `int64_t` | When parameter normalize is set to „1” special chars in message will be replaced with their equivalents (ê-e, ñ-n, ý-y ...). |
| `notify_url` | `char*` | Parameter allows to set CALLBACK URL for message from request. |
| `test` | `voxgig_value*` | When parameter test is set to "1" message won't be sent but response will be displayed, there is no charge for such test messages. |
| `time_restriction` | `char*` | Sets the behavior when you try to ship in hours / dates that do not match the settings in your account. |
| `to` | `char*` | Recipients' mobile phone numbers (i.e. |

#### Example: Create

```c
Entity* smsdo = smsapi_smsdo(client, NULL);
voxgig_value* smsdo_rec = smsdo->vt->create(smsdo, NULL, NULL, &err);
```


### Smssendername

Create an instance: `Entity* smssendername = smsapi_smssendername(client, NULL);`

#### Operations

| Method | Description |
| --- | --- |
| `vt->create(e, reqdata, ctrl, &err)` | Create a new entity with the given data. |
| `vt->remove(e, reqmatch, ctrl, &err)` | Remove the matching entity. |

#### Example: Create

```c
Entity* smssendername = smsapi_smssendername(client, NULL);
voxgig_value* smssendername_rec = smssendername->vt->create(smssendername, cmap(1,
    "sendername_id", v_str("example_sendername_id"))  // char*
, NULL, &err);
```


### Smstemplate

Create an instance: `Entity* smstemplate = smsapi_smstemplate(client, NULL);`

#### Operations

| Method | Description |
| --- | --- |
| `vt->remove(e, reqmatch, ctrl, &err)` | Remove the matching entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `id` | `char*` |  |


### Subuser

Create an instance: `Entity* subuser = smsapi_subuser(client, NULL);`

#### Operations

| Method | Description |
| --- | --- |
| `vt->create(e, reqdata, ctrl, &err)` | Create a new entity with the given data. |
| `vt->list(e, reqmatch, ctrl, &err)` | List entities, optionally matching the given criteria. |
| `vt->load(e, reqmatch, ctrl, &err)` | Load a single entity by match criteria. |
| `vt->remove(e, reqmatch, ctrl, &err)` | Remove the matching entity. |
| `vt->update(e, reqdata, ctrl, &err)` | Update an existing entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `active` | `bool` |  |
| `credentials` | `voxgig_value* (map)` |  |
| `description` | `char*` |  |
| `id` | `char*` | Object ID |
| `points` | `voxgig_value* (map)` |  |
| `username` | `char*` |  |

#### Example: Load

```c
Entity* subuser = smsapi_subuser(client, NULL);
voxgig_value* subuser_rec = subuser->vt->load(subuser, cmap(1, "id", v_str("subuser_id")), NULL, &err);
```

#### Example: List

```c
Entity* subuser = smsapi_subuser(client, NULL);
voxgig_value* subusers = subuser->vt->list(subuser, NULL, NULL, &err);
```

#### Example: Create

```c
Entity* subuser = smsapi_subuser(client, NULL);
voxgig_value* subuser_rec = subuser->vt->create(subuser, cmap(1,
    "credentials", v_map())  // voxgig_value* (map)
, NULL, &err);
```


### Template

Create an instance: `Entity* template = smsapi_template(client, NULL);`

#### Operations

| Method | Description |
| --- | --- |
| `vt->create(e, reqdata, ctrl, &err)` | Create a new entity with the given data. |
| `vt->list(e, reqmatch, ctrl, &err)` | List entities, optionally matching the given criteria. |
| `vt->load(e, reqmatch, ctrl, &err)` | Load a single entity by match criteria. |
| `vt->update(e, reqdata, ctrl, &err)` | Update an existing entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `id` | `char*` |  |
| `name` | `char*` |  |
| `normalize` | `bool` |  |
| `template` | `char*` |  |

#### Example: Load

```c
Entity* template = smsapi_template(client, NULL);
voxgig_value* template_rec = template->vt->load(template, cmap(1, "id", v_str("template_id")), NULL, &err);
```

#### Example: List

```c
Entity* template = smsapi_template(client, NULL);
voxgig_value* templates = template->vt->list(template, NULL, NULL, &err);
```

#### Example: Create

```c
Entity* template = smsapi_template(client, NULL);
voxgig_value* template_rec = template->vt->create(template, NULL, NULL, &err);
```


### UserRcsSenderCollection

Create an instance: `Entity* user_rcs_sender_collection = smsapi_user_rcs_sender_collection(client, NULL);`

#### Operations

| Method | Description |
| --- | --- |
| `vt->list(e, reqmatch, ctrl, &err)` | List entities, optionally matching the given criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `deliveredAt` | `char*` |  |
| `expiredAt` | `char*` |  |
| `id` | `char*` | Object ID |
| `interface` | `char*` | Interface through which the message was sent (www, api, ...). |
| `messageType` | `char*` | RCS message type (basic, single, ...). |
| `readAt` | `char*` |  |
| `recipient` | `char*` | Recipient phone number (without +). |
| `sender` | `char*` | Sender name |
| `senderId` | `char*` | Sender id |
| `sentAt` | `char*` |  |

#### Example: List

```c
Entity* user_rcs_sender_collection = smsapi_user_rcs_sender_collection(client, NULL);
voxgig_value* user_rcs_sender_collections = user_rcs_sender_collection->vt->list(user_rcs_sender_collection, NULL, NULL, &err);
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

### Data as `voxgig_value*`

The C SDK uses a single dynamic `voxgig_value*` type throughout rather than
a typed struct per entity. `voxgig_value` is the vendored voxgig struct
port (a JSON-shaped tagged union: string, number, bool, list, map, null,
undef). This mirrors the dynamic nature of the API and keeps the SDK
flexible — no code generation is needed when the API schema changes.

Build request maps with the `cmap` / `clist` / `v_str` / `v_num` /
`v_bool` helper builders, and read fields back with `getp` (or the typed
`get_str` / `get_bool` / `to_int`); use `to_map` to safely coerce a
value to a map.

Memory follows a retain-heavy, never-free discipline — pipeline values are
never released. This is safe (no use-after-free) and leaks are acceptable
for the short-lived SDK and test binaries.

### Error handling

Fallible functions return a `voxgig_value*` (or a struct pointer) and take a
trailing `PNError** err` out-param. On success `*err` is left `NULL`; on
failure `*err` points to a heap `PNError` carrying `code` and `msg`.
Always initialise `PNError* err = NULL;` and branch on it after each call.

### Project structure

```
c/
├── core/          -- Pipeline types, config, client (client.c), api.h + sdk.h
├── entity/        -- Per-entity implementations (one .c each)
├── feature/       -- Built-in features (base, test, log, ...)
├── utility/       -- Utilities + the vendored voxgig struct port (utility/struct)
├── tests/         -- Test binaries (each a standalone main())
└── Makefile       -- Builds libsdk.a and runs every tests/*.c
```

The public entry header is `core/api.h` — it includes `core/sdk.h` (the
umbrella runtime header) and declares each entity's constructor and SDK
accessor. Include it and link against `libsdk.a`.

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
