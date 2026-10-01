# Smsapi C SDK Reference

Complete API reference for the Smsapi C SDK.


## SmsapiSDK

### Constructor

```c
#include "core/api.h"

SmsapiSDK* client = smsapi_sdk_new(options);
```

Create a new SDK client instance. `options` is a `voxgig_value*` map
(`NULL` for none).

**Parameters (`options` map keys):**

| Key | Value type | Description |
| --- | --- | --- |
| `apikey` | `string` | API key for authentication. |
| `base` | `string` | Base URL for API requests. |
| `prefix` | `string` | URL prefix appended after base. |
| `suffix` | `string` | URL suffix appended after path. |
| `headers` | `map` | Custom headers for all requests. |
| `feature` | `map` | Feature configuration. |
| `system` | `map` | System overrides. |


### Test Constructor

#### `SmsapiSDK* test_sdk(voxgig_value* testopts, voxgig_value* sdkopts)`

Create a test client with mock features active. Both arguments may be
`NULL`.

```c
SmsapiSDK* client = test_sdk(NULL, NULL);
```


### Entity Accessors

#### `Entity* smsapi_available(SmsapiSDK* client, voxgig_value* entopts)`

Create a new `Available` entity instance. Pass `NULL` for no initial
options.

#### `Entity* smsapi_blacklist(SmsapiSDK* client, voxgig_value* entopts)`

Create a new `Blacklist` entity instance. Pass `NULL` for no initial
options.

#### `Entity* smsapi_callback(SmsapiSDK* client, voxgig_value* entopts)`

Create a new `Callback` entity instance. Pass `NULL` for no initial
options.

#### `Entity* smsapi_contact(SmsapiSDK* client, voxgig_value* entopts)`

Create a new `Contact` entity instance. Pass `NULL` for no initial
options.

#### `Entity* smsapi_contacts_field(SmsapiSDK* client, voxgig_value* entopts)`

Create a new `ContactsField` entity instance. Pass `NULL` for no initial
options.

#### `Entity* smsapi_contacts_field_option(SmsapiSDK* client, voxgig_value* entopts)`

Create a new `ContactsFieldOption` entity instance. Pass `NULL` for no initial
options.

#### `Entity* smsapi_contactsgroup(SmsapiSDK* client, voxgig_value* entopts)`

Create a new `Contactsgroup` entity instance. Pass `NULL` for no initial
options.

#### `Entity* smsapi_contactstrash(SmsapiSDK* client, voxgig_value* entopts)`

Create a new `Contactstrash` entity instance. Pass `NULL` for no initial
options.

#### `Entity* smsapi_field_available(SmsapiSDK* client, voxgig_value* entopts)`

Create a new `FieldAvailable` entity instance. Pass `NULL` for no initial
options.

#### `Entity* smsapi_group(SmsapiSDK* client, voxgig_value* entopts)`

Create a new `Group` entity instance. Pass `NULL` for no initial
options.

#### `Entity* smsapi_mfa_code(SmsapiSDK* client, voxgig_value* entopts)`

Create a new `MfaCode` entity instance. Pass `NULL` for no initial
options.

#### `Entity* smsapi_opt_out(SmsapiSDK* client, voxgig_value* entopts)`

Create a new `OptOut` entity instance. Pass `NULL` for no initial
options.

#### `Entity* smsapi_opt_out_setting(SmsapiSDK* client, voxgig_value* entopts)`

Create a new `OptOutSetting` entity instance. Pass `NULL` for no initial
options.

#### `Entity* smsapi_permission(SmsapiSDK* client, voxgig_value* entopts)`

Create a new `Permission` entity instance. Pass `NULL` for no initial
options.

#### `Entity* smsapi_ping(SmsapiSDK* client, voxgig_value* entopts)`

Create a new `Ping` entity instance. Pass `NULL` for no initial
options.

#### `Entity* smsapi_profile(SmsapiSDK* client, voxgig_value* entopts)`

Create a new `Profile` entity instance. Pass `NULL` for no initial
options.

#### `Entity* smsapi_rcs(SmsapiSDK* client, voxgig_value* entopts)`

Create a new `Rcs` entity instance. Pass `NULL` for no initial
options.

#### `Entity* smsapi_sendername(SmsapiSDK* client, voxgig_value* entopts)`

Create a new `Sendername` entity instance. Pass `NULL` for no initial
options.

#### `Entity* smsapi_sendername_statement(SmsapiSDK* client, voxgig_value* entopts)`

Create a new `SendernameStatement` entity instance. Pass `NULL` for no initial
options.

#### `Entity* smsapi_sent_rcs_message(SmsapiSDK* client, voxgig_value* entopts)`

Create a new `SentRcsMessage` entity instance. Pass `NULL` for no initial
options.

#### `Entity* smsapi_shipment_country_volume(SmsapiSDK* client, voxgig_value* entopts)`

Create a new `ShipmentCountryVolume` entity instance. Pass `NULL` for no initial
options.

#### `Entity* smsapi_short_url(SmsapiSDK* client, voxgig_value* entopts)`

Create a new `ShortUrl` entity instance. Pass `NULL` for no initial
options.

#### `Entity* smsapi_smsdo(SmsapiSDK* client, voxgig_value* entopts)`

Create a new `Smsdo` entity instance. Pass `NULL` for no initial
options.

#### `Entity* smsapi_smssendername(SmsapiSDK* client, voxgig_value* entopts)`

Create a new `Smssendername` entity instance. Pass `NULL` for no initial
options.

#### `Entity* smsapi_smstemplate(SmsapiSDK* client, voxgig_value* entopts)`

Create a new `Smstemplate` entity instance. Pass `NULL` for no initial
options.

#### `Entity* smsapi_subuser(SmsapiSDK* client, voxgig_value* entopts)`

Create a new `Subuser` entity instance. Pass `NULL` for no initial
options.

#### `Entity* smsapi_template(SmsapiSDK* client, voxgig_value* entopts)`

Create a new `Template` entity instance. Pass `NULL` for no initial
options.

#### `Entity* smsapi_user_rcs_sender_collection(SmsapiSDK* client, voxgig_value* entopts)`

Create a new `UserRcsSenderCollection` entity instance. Pass `NULL` for no initial
options.

#### `voxgig_value* sdk_direct(SmsapiSDK* client, voxgig_value* fetchargs, PNError** err)`

Make a direct HTTP request to any API endpoint. Returns a result map with
`ok`, `status`, `headers`, and `data` (or `err` on failure). This escape
hatch never sets `*err` for a non-2xx response — branch on
`getp(result, "ok")`.

**Parameters (`fetchargs` map keys):**

| Key | Value type | Description |
| --- | --- | --- |
| `path` | `string` | URL path with optional `{param}` placeholders. |
| `method` | `string` | HTTP method (default: `"GET"`). |
| `params` | `map` | Path parameter values. |
| `query` | `map` | Query string parameters. |
| `headers` | `map` | Request headers (merged with defaults). |
| `body` | `any` | Request body (maps are JSON-serialized). |

#### `voxgig_value* sdk_prepare(SmsapiSDK* client, voxgig_value* fetchargs, PNError** err)`

Prepare a fetch definition without sending. Returns the fetchdef and sets
`*err` on failure.


---

## Available

```c
Entity* available = smsapi_available(client, NULL);
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `name` | `char*` | No |  |
| `normalize` | `bool` | No |  |
| `template` | `char*` | No |  |

### Operations

#### `vt->list(Entity* e, voxgig_value* reqmatch, voxgig_value* ctrl, PNError** err)`

List entities matching the given criteria. The match is optional — pass `NULL` to list all records. Returns a List.

```c
Entity* available = smsapi_available(client, NULL);
voxgig_value* results = available->vt->list(available, NULL, NULL, &err);
for (size_t i = 0; i < (size_t)voxgig_size(results); i++) {
    printf("%s\n", voxgig_to_json(voxgig_getelem(results, v_int(i), NULL)));
}
```

### Common Methods

#### `voxgig_value* vt->data(Entity* e, voxgig_value* args)`

Get the entity data. Pass a map to set it.

#### `voxgig_value* vt->matchv(Entity* e, voxgig_value* args)`

Get the entity match criteria. Pass a map to set it.

#### `Entity* vt->make(Entity* e)`

Create a new `Available` entity instance with the same options.

#### `const char* vt->get_name(Entity* e)`

Return the entity name.


---

## Blacklist

```c
Entity* blacklist = smsapi_blacklist(client, NULL);
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | `char*` | No |  |

### Operations

#### `vt->create(Entity* e, voxgig_value* reqdata, voxgig_value* ctrl, PNError** err)`

Create a new entity with the given data. Returns the created entity data and sets `*err` on failure.

```c
Entity* blacklist = smsapi_blacklist(client, NULL);
voxgig_value* result = blacklist->vt->create(blacklist, NULL, NULL, &err);
```

#### `vt->load(Entity* e, voxgig_value* reqmatch, voxgig_value* ctrl, PNError** err)`

Load a single entity matching the given criteria. Returns the entity data and sets `*err` on failure.

```c
Entity* blacklist = smsapi_blacklist(client, NULL);
voxgig_value* result = blacklist->vt->load(blacklist, NULL, NULL, &err);
```

#### `vt->remove(Entity* e, voxgig_value* reqmatch, voxgig_value* ctrl, PNError** err)`

Remove the entity matching the given criteria. Sets `*err` on failure.

```c
Entity* blacklist = smsapi_blacklist(client, NULL);
voxgig_value* result = blacklist->vt->remove(blacklist, cmap(1, "id", v_str("id")), NULL, &err);
```

### Common Methods

#### `voxgig_value* vt->data(Entity* e, voxgig_value* args)`

Get the entity data. Pass a map to set it.

#### `voxgig_value* vt->matchv(Entity* e, voxgig_value* args)`

Get the entity match criteria. Pass a map to set it.

#### `Entity* vt->make(Entity* e)`

Create a new `Blacklist` entity instance with the same options.

#### `const char* vt->get_name(Entity* e)`

Return the entity name.


---

## Callback

```c
Entity* callback = smsapi_callback(client, NULL);
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `active` | `bool` | No |  |
| `api_version` | `int64_t` | No | Version of the callback output format. |
| `id` | `char*` | No | Object ID |
| `invalid` | `bool` | No |  |
| `receiver` | `voxgig_value* (map)` | No |  |
| `receiver_type` | `char*` | No |  |
| `type` | `char*` | No |  |
| `url` | `char*` | No | WHATWG URL compliant |

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

#### `vt->create(Entity* e, voxgig_value* reqdata, voxgig_value* ctrl, PNError** err)`

Create a new entity with the given data. Returns the created entity data and sets `*err` on failure.

```c
Entity* callback = smsapi_callback(client, NULL);
voxgig_value* result = callback->vt->create(callback, NULL, NULL, &err);
```

#### `vt->list(Entity* e, voxgig_value* reqmatch, voxgig_value* ctrl, PNError** err)`

List entities matching the given criteria. The match is optional — pass `NULL` to list all records. Returns a List.

```c
Entity* callback = smsapi_callback(client, NULL);
voxgig_value* results = callback->vt->list(callback, NULL, NULL, &err);
for (size_t i = 0; i < (size_t)voxgig_size(results); i++) {
    printf("%s\n", voxgig_to_json(voxgig_getelem(results, v_int(i), NULL)));
}
```

#### `vt->load(Entity* e, voxgig_value* reqmatch, voxgig_value* ctrl, PNError** err)`

Load a single entity matching the given criteria. Returns the entity data and sets `*err` on failure.

```c
Entity* callback = smsapi_callback(client, NULL);
voxgig_value* result = callback->vt->load(callback, cmap(1, "id", v_str("callback_id")), NULL, &err);
```

#### `vt->remove(Entity* e, voxgig_value* reqmatch, voxgig_value* ctrl, PNError** err)`

Remove the entity matching the given criteria. Sets `*err` on failure.

```c
Entity* callback = smsapi_callback(client, NULL);
voxgig_value* result = callback->vt->remove(callback, cmap(1, "id", v_str("callback_id")), NULL, &err);
```

#### `vt->update(Entity* e, voxgig_value* reqdata, voxgig_value* ctrl, PNError** err)`

Update an existing entity. The data must include the entity id. Returns the updated entity data.

```c
Entity* callback = smsapi_callback(client, NULL);
voxgig_value* result = callback->vt->update(callback, cmap(1, "id", v_str("callback_id")), NULL, &err);
```

### Common Methods

#### `voxgig_value* vt->data(Entity* e, voxgig_value* args)`

Get the entity data. Pass a map to set it.

#### `voxgig_value* vt->matchv(Entity* e, voxgig_value* args)`

Get the entity match criteria. Pass a map to set it.

#### `Entity* vt->make(Entity* e)`

Create a new `Callback` entity instance with the same options.

#### `const char* vt->get_name(Entity* e)`

Return the entity name.


---

## Contact

```c
Entity* contact = smsapi_contact(client, NULL);
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `birthday_date` | `char*` | No |  |
| `city` | `char*` | No |  |
| `collection` | `voxgig_value* (list)` | Yes |  |
| `contact_expire_after` | `int64_t` | Yes | Contact expire after days |
| `contacts_count` | `int64_t` | Yes |  |
| `country` | `char*` | No |  |
| `created_by` | `char*` | Yes |  |
| `date_created` | `char*` | Yes |  |
| `date_updated` | `char*` | Yes |  |
| `description` | `char*` | No |  |
| `email` | `char*` | No |  |
| `first_name` | `char*` | No |  |
| `gender` | `char*` | Yes |  |
| `group_id` | `char*` | No | Object ID |
| `groups` | `voxgig_value* (list)` | Yes |  |
| `id` | `char*` | Yes | Object ID |
| `idx` | `char*` | No | User provided resource id |
| `last_name` | `char*` | No |  |
| `name` | `char*` | Yes | Group name |
| `permissions` | `voxgig_value* (list)` | No |  |
| `phone_number` | `char*` | No |  |
| `read` | `bool` | No | Has read permission |
| `send` | `bool` | No | Has send permission |
| `size` | `int64_t` | Yes |  |
| `source` | `char*` | No |  |
| `type` | `char*` | No |  |
| `username` | `char*` | No |  |
| `value` | `char*` | No |  |
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

#### `vt->create(Entity* e, voxgig_value* reqdata, voxgig_value* ctrl, PNError** err)`

Create a new entity with the given data. Returns the created entity data and sets `*err` on failure.

```c
Entity* contact = smsapi_contact(client, NULL);
voxgig_value* result = contact->vt->create(contact, cmap(11,
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

#### `vt->list(Entity* e, voxgig_value* reqmatch, voxgig_value* ctrl, PNError** err)`

List entities matching the given criteria. The match is optional — pass `NULL` to list all records. Returns a List.

```c
Entity* contact = smsapi_contact(client, NULL);
voxgig_value* results = contact->vt->list(contact, NULL, NULL, &err);
for (size_t i = 0; i < (size_t)voxgig_size(results); i++) {
    printf("%s\n", voxgig_to_json(voxgig_getelem(results, v_int(i), NULL)));
}
```

#### `vt->load(Entity* e, voxgig_value* reqmatch, voxgig_value* ctrl, PNError** err)`

Load a single entity matching the given criteria. Returns the entity data and sets `*err` on failure.

```c
Entity* contact = smsapi_contact(client, NULL);
voxgig_value* result = contact->vt->load(contact, cmap(1, "id", v_str("contact_id")), NULL, &err);
```

#### `vt->remove(Entity* e, voxgig_value* reqmatch, voxgig_value* ctrl, PNError** err)`

Remove the entity matching the given criteria. Sets `*err` on failure.

```c
Entity* contact = smsapi_contact(client, NULL);
voxgig_value* result = contact->vt->remove(contact, cmap(1, "id", v_str("contact_id")), NULL, &err);
```

#### `vt->update(Entity* e, voxgig_value* reqdata, voxgig_value* ctrl, PNError** err)`

Update an existing entity. The data must include the entity id. Returns the updated entity data.

```c
Entity* contact = smsapi_contact(client, NULL);
voxgig_value* result = contact->vt->update(contact, cmap(1, "id", v_str("contact_id")), NULL, &err);
```

### Common Methods

#### `voxgig_value* vt->data(Entity* e, voxgig_value* args)`

Get the entity data. Pass a map to set it.

#### `voxgig_value* vt->matchv(Entity* e, voxgig_value* args)`

Get the entity match criteria. Pass a map to set it.

#### `Entity* vt->make(Entity* e)`

Create a new `Contact` entity instance with the same options.

#### `const char* vt->get_name(Entity* e)`

Return the entity name.


---

## ContactsField

```c
Entity* contacts_field = smsapi_contacts_field(client, NULL);
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `birthday_date` | `char*` | No |  |
| `city` | `char*` | No |  |
| `contact_expire_after` | `int64_t` | Yes | Contact expire after days |
| `contacts_count` | `int64_t` | No |  |
| `country` | `char*` | No |  |
| `created_by` | `char*` | Yes |  |
| `date_created` | `char*` | Yes |  |
| `date_updated` | `char*` | Yes |  |
| `description` | `char*` | No |  |
| `email` | `char*` | No |  |
| `first_name` | `char*` | No |  |
| `gender` | `char*` | Yes |  |
| `group_id` | `char*` | No | Object ID |
| `groups` | `voxgig_value* (list)` | Yes |  |
| `id` | `char*` | No | Object ID |
| `idx` | `char*` | No | User provided resource id |
| `last_name` | `char*` | No |  |
| `name` | `char*` | No | Group name |
| `permissions` | `voxgig_value* (list)` | No |  |
| `phone_number` | `char*` | No |  |
| `read` | `bool` | No | Has read permission |
| `send` | `bool` | No | Has send permission |
| `source` | `char*` | No |  |
| `type` | `char*` | No |  |
| `username` | `char*` | No |  |
| `value` | `char*` | No |  |
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

#### `vt->create(Entity* e, voxgig_value* reqdata, voxgig_value* ctrl, PNError** err)`

Create a new entity with the given data. Returns the created entity data and sets `*err` on failure.

```c
Entity* contacts_field = smsapi_contacts_field(client, NULL);
voxgig_value* result = contacts_field->vt->create(contacts_field, cmap(6,
    "contact_expire_after", v_num(1),  // int64_t
    "created_by", v_str("example_created_by"),  // char*
    "date_created", v_str("example_date_created"),  // char*
    "date_updated", v_str("example_date_updated"),  // char*
    "gender", v_str("example_gender"),  // char*
    "groups", v_list())  // voxgig_value* (list)
, NULL, &err);
```

#### `vt->list(Entity* e, voxgig_value* reqmatch, voxgig_value* ctrl, PNError** err)`

List entities matching the given criteria. The match is optional — pass `NULL` to list all records. Returns a List.

```c
Entity* contacts_field = smsapi_contacts_field(client, NULL);
voxgig_value* results = contacts_field->vt->list(contacts_field, NULL, NULL, &err);
for (size_t i = 0; i < (size_t)voxgig_size(results); i++) {
    printf("%s\n", voxgig_to_json(voxgig_getelem(results, v_int(i), NULL)));
}
```

#### `vt->remove(Entity* e, voxgig_value* reqmatch, voxgig_value* ctrl, PNError** err)`

Remove the entity matching the given criteria. Sets `*err` on failure.

```c
Entity* contacts_field = smsapi_contacts_field(client, NULL);
voxgig_value* result = contacts_field->vt->remove(contacts_field, cmap(1, "id", v_str("id")), NULL, &err);
```

#### `vt->update(Entity* e, voxgig_value* reqdata, voxgig_value* ctrl, PNError** err)`

Update an existing entity. The data must include the entity id. Returns the updated entity data.

```c
Entity* contacts_field = smsapi_contacts_field(client, NULL);
voxgig_value* result = contacts_field->vt->update(contacts_field, cmap(1, "id", v_str("id")), NULL, &err);
```

### Common Methods

#### `voxgig_value* vt->data(Entity* e, voxgig_value* args)`

Get the entity data. Pass a map to set it.

#### `voxgig_value* vt->matchv(Entity* e, voxgig_value* args)`

Get the entity match criteria. Pass a map to set it.

#### `Entity* vt->make(Entity* e)`

Create a new `ContactsField` entity instance with the same options.

#### `const char* vt->get_name(Entity* e)`

Return the entity name.


---

## ContactsFieldOption

```c
Entity* contacts_field_option = smsapi_contacts_field_option(client, NULL);
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `birthday_date` | `char*` | No |  |
| `city` | `char*` | No |  |
| `contact_expire_after` | `int64_t` | Yes | Contact expire after days |
| `contacts_count` | `int64_t` | No |  |
| `country` | `char*` | No |  |
| `created_by` | `char*` | Yes |  |
| `date_created` | `char*` | Yes |  |
| `date_updated` | `char*` | Yes |  |
| `description` | `char*` | No |  |
| `email` | `char*` | No |  |
| `first_name` | `char*` | No |  |
| `gender` | `char*` | Yes |  |
| `group_id` | `char*` | No | Object ID |
| `groups` | `voxgig_value* (list)` | Yes |  |
| `id` | `char*` | Yes | Object ID |
| `idx` | `char*` | No | User provided resource id |
| `last_name` | `char*` | No |  |
| `name` | `char*` | No | Group name |
| `permissions` | `voxgig_value* (list)` | No |  |
| `phone_number` | `char*` | No |  |
| `read` | `bool` | No | Has read permission |
| `send` | `bool` | No | Has send permission |
| `source` | `char*` | No |  |
| `type` | `char*` | No |  |
| `username` | `char*` | No |  |
| `value` | `char*` | No |  |
| `write` | `bool` | No | Has write permission |

### Operations

#### `vt->list(Entity* e, voxgig_value* reqmatch, voxgig_value* ctrl, PNError** err)`

List entities matching the given criteria. The match is optional — pass `NULL` to list all records. Returns a List.

```c
Entity* contacts_field_option = smsapi_contacts_field_option(client, NULL);
voxgig_value* results = contacts_field_option->vt->list(contacts_field_option, NULL, NULL, &err);
for (size_t i = 0; i < (size_t)voxgig_size(results); i++) {
    printf("%s\n", voxgig_to_json(voxgig_getelem(results, v_int(i), NULL)));
}
```

### Common Methods

#### `voxgig_value* vt->data(Entity* e, voxgig_value* args)`

Get the entity data. Pass a map to set it.

#### `voxgig_value* vt->matchv(Entity* e, voxgig_value* args)`

Get the entity match criteria. Pass a map to set it.

#### `Entity* vt->make(Entity* e)`

Create a new `ContactsFieldOption` entity instance with the same options.

#### `const char* vt->get_name(Entity* e)`

Return the entity name.


---

## Contactsgroup

```c
Entity* contactsgroup = smsapi_contactsgroup(client, NULL);
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `birthday_date` | `char*` | No |  |
| `city` | `char*` | No |  |
| `contact_expire_after` | `int64_t` | Yes | Contact expire after days |
| `contacts_count` | `int64_t` | No |  |
| `country` | `char*` | No |  |
| `created_by` | `char*` | Yes |  |
| `date_created` | `char*` | Yes |  |
| `date_updated` | `char*` | Yes |  |
| `description` | `char*` | No |  |
| `email` | `char*` | No |  |
| `first_name` | `char*` | No |  |
| `gender` | `char*` | Yes |  |
| `group_id` | `char*` | Yes | Object ID |
| `groups` | `voxgig_value* (list)` | Yes |  |
| `id` | `char*` | Yes | Object ID |
| `idx` | `char*` | No | User provided resource id |
| `last_name` | `char*` | No |  |
| `name` | `char*` | No | Group name |
| `permissions` | `voxgig_value* (list)` | No |  |
| `phone_number` | `char*` | No |  |
| `read` | `bool` | Yes | Has read permission |
| `send` | `bool` | Yes | Has send permission |
| `source` | `char*` | No |  |
| `type` | `char*` | No |  |
| `username` | `char*` | Yes |  |
| `value` | `char*` | No |  |
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

#### `vt->create(Entity* e, voxgig_value* reqdata, voxgig_value* ctrl, PNError** err)`

Create a new entity with the given data. Returns the created entity data and sets `*err` on failure.

```c
Entity* contactsgroup = smsapi_contactsgroup(client, NULL);
voxgig_value* result = contactsgroup->vt->create(contactsgroup, cmap(12,
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

#### `vt->list(Entity* e, voxgig_value* reqmatch, voxgig_value* ctrl, PNError** err)`

List entities matching the given criteria. The match is optional — pass `NULL` to list all records. Returns a List.

```c
Entity* contactsgroup = smsapi_contactsgroup(client, NULL);
voxgig_value* results = contactsgroup->vt->list(contactsgroup, NULL, NULL, &err);
for (size_t i = 0; i < (size_t)voxgig_size(results); i++) {
    printf("%s\n", voxgig_to_json(voxgig_getelem(results, v_int(i), NULL)));
}
```

#### `vt->remove(Entity* e, voxgig_value* reqmatch, voxgig_value* ctrl, PNError** err)`

Remove the entity matching the given criteria. Sets `*err` on failure.

```c
Entity* contactsgroup = smsapi_contactsgroup(client, NULL);
voxgig_value* result = contactsgroup->vt->remove(contactsgroup, cmap(1, "group_id", v_str("group_id")), NULL, &err);
```

#### `vt->update(Entity* e, voxgig_value* reqdata, voxgig_value* ctrl, PNError** err)`

Update an existing entity. The data must include the entity id. Returns the updated entity data.

```c
Entity* contactsgroup = smsapi_contactsgroup(client, NULL);
voxgig_value* result = contactsgroup->vt->update(contactsgroup, cmap(1, "group_id", v_str("group_id")), NULL, &err);
```

### Common Methods

#### `voxgig_value* vt->data(Entity* e, voxgig_value* args)`

Get the entity data. Pass a map to set it.

#### `voxgig_value* vt->matchv(Entity* e, voxgig_value* args)`

Get the entity match criteria. Pass a map to set it.

#### `Entity* vt->make(Entity* e)`

Create a new `Contactsgroup` entity instance with the same options.

#### `const char* vt->get_name(Entity* e)`

Return the entity name.


---

## Contactstrash

```c
Entity* contactstrash = smsapi_contactstrash(client, NULL);
```

### Operations

#### `vt->remove(Entity* e, voxgig_value* reqmatch, voxgig_value* ctrl, PNError** err)`

Remove the entity matching the given criteria. Sets `*err` on failure.

```c
Entity* contactstrash = smsapi_contactstrash(client, NULL);
voxgig_value* result = contactstrash->vt->remove(contactstrash, NULL, NULL, &err);
```

#### `vt->update(Entity* e, voxgig_value* reqdata, voxgig_value* ctrl, PNError** err)`

Update an existing entity. The data must include the entity id. Returns the updated entity data.

```c
Entity* contactstrash = smsapi_contactstrash(client, NULL);
voxgig_value* result = contactstrash->vt->update(contactstrash, NULL, NULL, &err);
```

### Common Methods

#### `voxgig_value* vt->data(Entity* e, voxgig_value* args)`

Get the entity data. Pass a map to set it.

#### `voxgig_value* vt->matchv(Entity* e, voxgig_value* args)`

Get the entity match criteria. Pass a map to set it.

#### `Entity* vt->make(Entity* e)`

Create a new `Contactstrash` entity instance with the same options.

#### `const char* vt->get_name(Entity* e)`

Return the entity name.


---

## FieldAvailable

```c
Entity* field_available = smsapi_field_available(client, NULL);
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `built_in` | `bool` | No |  |
| `id` | `char*` | No | Object ID |
| `name` | `char*` | No |  |
| `options` | `voxgig_value* (list)` | No |  |
| `type` | `char*` | No |  |

### Operations

#### `vt->list(Entity* e, voxgig_value* reqmatch, voxgig_value* ctrl, PNError** err)`

List entities matching the given criteria. The match is optional — pass `NULL` to list all records. Returns a List.

```c
Entity* field_available = smsapi_field_available(client, NULL);
voxgig_value* results = field_available->vt->list(field_available, NULL, NULL, &err);
for (size_t i = 0; i < (size_t)voxgig_size(results); i++) {
    printf("%s\n", voxgig_to_json(voxgig_getelem(results, v_int(i), NULL)));
}
```

### Common Methods

#### `voxgig_value* vt->data(Entity* e, voxgig_value* args)`

Get the entity data. Pass a map to set it.

#### `voxgig_value* vt->matchv(Entity* e, voxgig_value* args)`

Get the entity match criteria. Pass a map to set it.

#### `Entity* vt->make(Entity* e)`

Create a new `FieldAvailable` entity instance with the same options.

#### `const char* vt->get_name(Entity* e)`

Return the entity name.


---

## Group

```c
Entity* group = smsapi_group(client, NULL);
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `contact_expire_after` | `int64_t` | Yes | Contact expire after days |
| `contacts_count` | `int64_t` | Yes |  |
| `created_by` | `char*` | Yes |  |
| `date_created` | `char*` | Yes |  |
| `date_updated` | `char*` | Yes |  |
| `description` | `char*` | Yes |  |
| `id` | `char*` | Yes | Object ID |
| `idx` | `char*` | No | User provided resource id |
| `name` | `char*` | Yes | Group name |
| `permissions` | `voxgig_value* (list)` | No |  |

### Operations

#### `vt->load(Entity* e, voxgig_value* reqmatch, voxgig_value* ctrl, PNError** err)`

Load a single entity matching the given criteria. Returns the entity data and sets `*err` on failure.

```c
Entity* group = smsapi_group(client, NULL);
voxgig_value* result = group->vt->load(group, cmap(1, "id", v_str("group_id")), NULL, &err);
```

#### `vt->update(Entity* e, voxgig_value* reqdata, voxgig_value* ctrl, PNError** err)`

Update an existing entity. The data must include the entity id. Returns the updated entity data.

```c
Entity* group = smsapi_group(client, NULL);
voxgig_value* result = group->vt->update(group, cmap(1, "id", v_str("group_id")), NULL, &err);
```

### Common Methods

#### `voxgig_value* vt->data(Entity* e, voxgig_value* args)`

Get the entity data. Pass a map to set it.

#### `voxgig_value* vt->matchv(Entity* e, voxgig_value* args)`

Get the entity match criteria. Pass a map to set it.

#### `Entity* vt->make(Entity* e)`

Create a new `Group` entity instance with the same options.

#### `const char* vt->get_name(Entity* e)`

Return the entity name.


---

## MfaCode

```c
Entity* mfa_code = smsapi_mfa_code(client, NULL);
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `content` | `char*` | No | Custom content that must contain placeholder [%code%] |
| `fast` | `voxgig_value*` | No |  |
| `from` | `char*` | No | Sendername |
| `phone_number` | `char*` | Yes |  |

### Operations

#### `vt->create(Entity* e, voxgig_value* reqdata, voxgig_value* ctrl, PNError** err)`

Create a new entity with the given data. Returns the created entity data and sets `*err` on failure.

```c
Entity* mfa_code = smsapi_mfa_code(client, NULL);
voxgig_value* result = mfa_code->vt->create(mfa_code, cmap(1,
    "phone_number", v_str("example_phone_number"))  // char*
, NULL, &err);
```

### Common Methods

#### `voxgig_value* vt->data(Entity* e, voxgig_value* args)`

Get the entity data. Pass a map to set it.

#### `voxgig_value* vt->matchv(Entity* e, voxgig_value* args)`

Get the entity match criteria. Pass a map to set it.

#### `Entity* vt->make(Entity* e)`

Create a new `MfaCode` entity instance with the same options.

#### `const char* vt->get_name(Entity* e)`

Return the entity name.


---

## OptOut

```c
Entity* opt_out = smsapi_opt_out(client, NULL);
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `date` | `char*` | No |  |
| `id` | `char*` | No |  |
| `links` | `voxgig_value* (list)` | No |  |
| `phoneNumber` | `int64_t` | No |  |

### Operations

#### `vt->list(Entity* e, voxgig_value* reqmatch, voxgig_value* ctrl, PNError** err)`

List entities matching the given criteria. The match is optional — pass `NULL` to list all records. Returns a List.

```c
Entity* opt_out = smsapi_opt_out(client, NULL);
voxgig_value* results = opt_out->vt->list(opt_out, NULL, NULL, &err);
for (size_t i = 0; i < (size_t)voxgig_size(results); i++) {
    printf("%s\n", voxgig_to_json(voxgig_getelem(results, v_int(i), NULL)));
}
```

#### `vt->remove(Entity* e, voxgig_value* reqmatch, voxgig_value* ctrl, PNError** err)`

Remove the entity matching the given criteria. Sets `*err` on failure.

```c
Entity* opt_out = smsapi_opt_out(client, NULL);
voxgig_value* result = opt_out->vt->remove(opt_out, cmap(1, "id", v_str("id")), NULL, &err);
```

### Common Methods

#### `voxgig_value* vt->data(Entity* e, voxgig_value* args)`

Get the entity data. Pass a map to set it.

#### `voxgig_value* vt->matchv(Entity* e, voxgig_value* args)`

Get the entity match criteria. Pass a map to set it.

#### `Entity* vt->make(Entity* e)`

Create a new `OptOut` entity instance with the same options.

#### `const char* vt->get_name(Entity* e)`

Return the entity name.


---

## OptOutSetting

```c
Entity* opt_out_setting = smsapi_opt_out_setting(client, NULL);
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `brand` | `char*` | No |  |

### Operations

#### `vt->load(Entity* e, voxgig_value* reqmatch, voxgig_value* ctrl, PNError** err)`

Load a single entity matching the given criteria. Returns the entity data and sets `*err` on failure.

```c
Entity* opt_out_setting = smsapi_opt_out_setting(client, NULL);
voxgig_value* result = opt_out_setting->vt->load(opt_out_setting, NULL, NULL, &err);
```

#### `vt->update(Entity* e, voxgig_value* reqdata, voxgig_value* ctrl, PNError** err)`

Update an existing entity. The data must include the entity id. Returns the updated entity data.

```c
Entity* opt_out_setting = smsapi_opt_out_setting(client, NULL);
voxgig_value* result = opt_out_setting->vt->update(opt_out_setting, NULL, NULL, &err);
```

### Common Methods

#### `voxgig_value* vt->data(Entity* e, voxgig_value* args)`

Get the entity data. Pass a map to set it.

#### `voxgig_value* vt->matchv(Entity* e, voxgig_value* args)`

Get the entity match criteria. Pass a map to set it.

#### `Entity* vt->make(Entity* e)`

Create a new `OptOutSetting` entity instance with the same options.

#### `const char* vt->get_name(Entity* e)`

Return the entity name.


---

## Permission

```c
Entity* permission = smsapi_permission(client, NULL);
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `group_id` | `char*` | Yes | Object ID |
| `id` | `char*` | No |  |
| `read` | `bool` | Yes | Has read permission |
| `send` | `bool` | Yes | Has send permission |
| `username` | `char*` | Yes |  |
| `write` | `bool` | Yes | Has write permission |

### Operations

#### `vt->create(Entity* e, voxgig_value* reqdata, voxgig_value* ctrl, PNError** err)`

Create a new entity with the given data. Returns the created entity data and sets `*err` on failure.

```c
Entity* permission = smsapi_permission(client, NULL);
voxgig_value* result = permission->vt->create(permission, cmap(5,
    "group_id", v_str("example_group_id"),  // char*
    "read", v_bool(true),  // bool
    "send", v_bool(true),  // bool
    "username", v_str("example_username"),  // char*
    "write", v_bool(true))  // bool
, NULL, &err);
```

#### `vt->load(Entity* e, voxgig_value* reqmatch, voxgig_value* ctrl, PNError** err)`

Load a single entity matching the given criteria. Returns the entity data and sets `*err` on failure.

```c
Entity* permission = smsapi_permission(client, NULL);
voxgig_value* result = permission->vt->load(permission, cmap(3, "id", v_str("permission_id"), "group_id", v_str("group_id"), "username", v_str("username")), NULL, &err);
```

### Common Methods

#### `voxgig_value* vt->data(Entity* e, voxgig_value* args)`

Get the entity data. Pass a map to set it.

#### `voxgig_value* vt->matchv(Entity* e, voxgig_value* args)`

Get the entity match criteria. Pass a map to set it.

#### `Entity* vt->make(Entity* e)`

Create a new `Permission` entity instance with the same options.

#### `const char* vt->get_name(Entity* e)`

Return the entity name.


---

## Ping

```c
Entity* ping = smsapi_ping(client, NULL);
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `authorized` | `bool` | Yes |  |
| `unavailable` | `voxgig_value* (list)` | Yes |  |

### Operations

#### `vt->list(Entity* e, voxgig_value* reqmatch, voxgig_value* ctrl, PNError** err)`

List entities matching the given criteria. The match is optional — pass `NULL` to list all records. Returns a List.

```c
Entity* ping = smsapi_ping(client, NULL);
voxgig_value* results = ping->vt->list(ping, NULL, NULL, &err);
for (size_t i = 0; i < (size_t)voxgig_size(results); i++) {
    printf("%s\n", voxgig_to_json(voxgig_getelem(results, v_int(i), NULL)));
}
```

### Common Methods

#### `voxgig_value* vt->data(Entity* e, voxgig_value* args)`

Get the entity data. Pass a map to set it.

#### `voxgig_value* vt->matchv(Entity* e, voxgig_value* args)`

Get the entity match criteria. Pass a map to set it.

#### `Entity* vt->make(Entity* e)`

Create a new `Ping` entity instance with the same options.

#### `const char* vt->get_name(Entity* e)`

Return the entity name.


---

## Profile

```c
Entity* profile = smsapi_profile(client, NULL);
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `email` | `char*` | Yes |  |
| `name` | `char*` | Yes |  |
| `payment_type` | `char*` | Yes |  |
| `phone_number` | `int64_t` | Yes |  |
| `points` | `double` | No |  |
| `user_type` | `char*` | Yes |  |
| `username` | `char*` | Yes |  |

### Operations

#### `vt->list(Entity* e, voxgig_value* reqmatch, voxgig_value* ctrl, PNError** err)`

List entities matching the given criteria. The match is optional — pass `NULL` to list all records. Returns a List.

```c
Entity* profile = smsapi_profile(client, NULL);
voxgig_value* results = profile->vt->list(profile, NULL, NULL, &err);
for (size_t i = 0; i < (size_t)voxgig_size(results); i++) {
    printf("%s\n", voxgig_to_json(voxgig_getelem(results, v_int(i), NULL)));
}
```

#### `vt->load(Entity* e, voxgig_value* reqmatch, voxgig_value* ctrl, PNError** err)`

Load a single entity matching the given criteria. Returns the entity data and sets `*err` on failure.

```c
Entity* profile = smsapi_profile(client, NULL);
voxgig_value* result = profile->vt->load(profile, NULL, NULL, &err);
```

### Common Methods

#### `voxgig_value* vt->data(Entity* e, voxgig_value* args)`

Get the entity data. Pass a map to set it.

#### `voxgig_value* vt->matchv(Entity* e, voxgig_value* args)`

Get the entity match criteria. Pass a map to set it.

#### `Entity* vt->make(Entity* e)`

Create a new `Profile` entity instance with the same options.

#### `const char* vt->get_name(Entity* e)`

Return the entity name.


---

## Rcs

```c
Entity* rcs = smsapi_rcs(client, NULL);
```

### Operations

#### `vt->list(Entity* e, voxgig_value* reqmatch, voxgig_value* ctrl, PNError** err)`

List entities matching the given criteria. The match is optional — pass `NULL` to list all records. Returns a List.

```c
Entity* rcs = smsapi_rcs(client, NULL);
voxgig_value* results = rcs->vt->list(rcs, NULL, NULL, &err);
for (size_t i = 0; i < (size_t)voxgig_size(results); i++) {
    printf("%s\n", voxgig_to_json(voxgig_getelem(results, v_int(i), NULL)));
}
```

### Common Methods

#### `voxgig_value* vt->data(Entity* e, voxgig_value* args)`

Get the entity data. Pass a map to set it.

#### `voxgig_value* vt->matchv(Entity* e, voxgig_value* args)`

Get the entity match criteria. Pass a map to set it.

#### `Entity* vt->make(Entity* e)`

Create a new `Rcs` entity instance with the same options.

#### `const char* vt->get_name(Entity* e)`

Return the entity name.


---

## Sendername

```c
Entity* sendername = smsapi_sendername(client, NULL);
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `created_at` | `char*` | No |  |
| `id` | `char*` | No |  |
| `is_default` | `bool` | No |  |
| `sender` | `char*` | No | Sendername |
| `status` | `char*` | No |  |

### Operations

#### `vt->create(Entity* e, voxgig_value* reqdata, voxgig_value* ctrl, PNError** err)`

Create a new entity with the given data. Returns the created entity data and sets `*err` on failure.

```c
Entity* sendername = smsapi_sendername(client, NULL);
voxgig_value* result = sendername->vt->create(sendername, NULL, NULL, &err);
```

#### `vt->list(Entity* e, voxgig_value* reqmatch, voxgig_value* ctrl, PNError** err)`

List entities matching the given criteria. The match is optional — pass `NULL` to list all records. Returns a List.

```c
Entity* sendername = smsapi_sendername(client, NULL);
voxgig_value* results = sendername->vt->list(sendername, NULL, NULL, &err);
for (size_t i = 0; i < (size_t)voxgig_size(results); i++) {
    printf("%s\n", voxgig_to_json(voxgig_getelem(results, v_int(i), NULL)));
}
```

#### `vt->load(Entity* e, voxgig_value* reqmatch, voxgig_value* ctrl, PNError** err)`

Load a single entity matching the given criteria. Returns the entity data and sets `*err` on failure.

```c
Entity* sendername = smsapi_sendername(client, NULL);
voxgig_value* result = sendername->vt->load(sendername, cmap(1, "id", v_str("sendername_id")), NULL, &err);
```

### Common Methods

#### `voxgig_value* vt->data(Entity* e, voxgig_value* args)`

Get the entity data. Pass a map to set it.

#### `voxgig_value* vt->matchv(Entity* e, voxgig_value* args)`

Get the entity match criteria. Pass a map to set it.

#### `Entity* vt->make(Entity* e)`

Create a new `Sendername` entity instance with the same options.

#### `const char* vt->get_name(Entity* e)`

Return the entity name.


---

## SendernameStatement

```c
Entity* sendername_statement = smsapi_sendername_statement(client, NULL);
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `content` | `char*` | No |  |
| `statements` | `voxgig_value* (list)` | No |  |
| `title` | `char*` | No |  |

### Operations

#### `vt->list(Entity* e, voxgig_value* reqmatch, voxgig_value* ctrl, PNError** err)`

List entities matching the given criteria. The match is optional — pass `NULL` to list all records. Returns a List.

```c
Entity* sendername_statement = smsapi_sendername_statement(client, NULL);
voxgig_value* results = sendername_statement->vt->list(sendername_statement, NULL, NULL, &err);
for (size_t i = 0; i < (size_t)voxgig_size(results); i++) {
    printf("%s\n", voxgig_to_json(voxgig_getelem(results, v_int(i), NULL)));
}
```

### Common Methods

#### `voxgig_value* vt->data(Entity* e, voxgig_value* args)`

Get the entity data. Pass a map to set it.

#### `voxgig_value* vt->matchv(Entity* e, voxgig_value* args)`

Get the entity match criteria. Pass a map to set it.

#### `Entity* vt->make(Entity* e)`

Create a new `SendernameStatement` entity instance with the same options.

#### `const char* vt->get_name(Entity* e)`

Return the entity name.


---

## SentRcsMessage

```c
Entity* sent_rcs_message = smsapi_sent_rcs_message(client, NULL);
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `content` | `voxgig_value* (map)` | No | RCS message content in RCS JSON format. |
| `phone_number` | `char*` | Yes | Recipient phone number (e.g. |
| `sender` | `voxgig_value*` | Yes |  |
| `text` | `char*` | No | Plain text message content. |

### Operations

#### `vt->create(Entity* e, voxgig_value* reqdata, voxgig_value* ctrl, PNError** err)`

Create a new entity with the given data. Returns the created entity data and sets `*err` on failure.

```c
Entity* sent_rcs_message = smsapi_sent_rcs_message(client, NULL);
voxgig_value* result = sent_rcs_message->vt->create(sent_rcs_message, cmap(2,
    "phone_number", v_str("example_phone_number"),  // char*
    "sender", v_str("example_sender"))  // voxgig_value*
, NULL, &err);
```

### Common Methods

#### `voxgig_value* vt->data(Entity* e, voxgig_value* args)`

Get the entity data. Pass a map to set it.

#### `voxgig_value* vt->matchv(Entity* e, voxgig_value* args)`

Get the entity match criteria. Pass a map to set it.

#### `Entity* vt->make(Entity* e)`

Create a new `SentRcsMessage` entity instance with the same options.

#### `const char* vt->get_name(Entity* e)`

Return the entity name.


---

## ShipmentCountryVolume

```c
Entity* shipment_country_volume = smsapi_shipment_country_volume(client, NULL);
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `country_code` | `char*` | No |  |
| `country_limit` | `int64_t` | No |  |
| `country_name` | `char*` | No |  |
| `usage` | `int64_t` | No |  |

### Operations

#### `vt->list(Entity* e, voxgig_value* reqmatch, voxgig_value* ctrl, PNError** err)`

List entities matching the given criteria. The match is optional — pass `NULL` to list all records. Returns a List.

```c
Entity* shipment_country_volume = smsapi_shipment_country_volume(client, NULL);
voxgig_value* results = shipment_country_volume->vt->list(shipment_country_volume, NULL, NULL, &err);
for (size_t i = 0; i < (size_t)voxgig_size(results); i++) {
    printf("%s\n", voxgig_to_json(voxgig_getelem(results, v_int(i), NULL)));
}
```

### Common Methods

#### `voxgig_value* vt->data(Entity* e, voxgig_value* args)`

Get the entity data. Pass a map to set it.

#### `voxgig_value* vt->matchv(Entity* e, voxgig_value* args)`

Get the entity match criteria. Pass a map to set it.

#### `Entity* vt->make(Entity* e)`

Create a new `ShipmentCountryVolume` entity instance with the same options.

#### `const char* vt->get_name(Entity* e)`

Return the entity name.


---

## ShortUrl

```c
Entity* short_url = smsapi_short_url(client, NULL);
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `description` | `char*` | No |  |
| `expire` | `char*` | No |  |
| `filename` | `char*` | No |  |
| `hits` | `int64_t` | No |  |
| `hits_unique` | `int64_t` | No |  |
| `id` | `char*` | No |  |
| `name` | `char*` | No |  |
| `short_url` | `char*` | No | WHATWG URL compliant |
| `type` | `char*` | No |  |
| `url` | `char*` | No | WHATWG URL compliant |

### Operations

#### `vt->create(Entity* e, voxgig_value* reqdata, voxgig_value* ctrl, PNError** err)`

Create a new entity with the given data. Returns the created entity data and sets `*err` on failure.

```c
Entity* short_url = smsapi_short_url(client, NULL);
voxgig_value* result = short_url->vt->create(short_url, NULL, NULL, &err);
```

#### `vt->list(Entity* e, voxgig_value* reqmatch, voxgig_value* ctrl, PNError** err)`

List entities matching the given criteria. The match is optional — pass `NULL` to list all records. Returns a List.

```c
Entity* short_url = smsapi_short_url(client, NULL);
voxgig_value* results = short_url->vt->list(short_url, NULL, NULL, &err);
for (size_t i = 0; i < (size_t)voxgig_size(results); i++) {
    printf("%s\n", voxgig_to_json(voxgig_getelem(results, v_int(i), NULL)));
}
```

#### `vt->load(Entity* e, voxgig_value* reqmatch, voxgig_value* ctrl, PNError** err)`

Load a single entity matching the given criteria. Returns the entity data and sets `*err` on failure.

```c
Entity* short_url = smsapi_short_url(client, NULL);
voxgig_value* result = short_url->vt->load(short_url, cmap(1, "id", v_str("short_url_id")), NULL, &err);
```

#### `vt->remove(Entity* e, voxgig_value* reqmatch, voxgig_value* ctrl, PNError** err)`

Remove the entity matching the given criteria. Sets `*err` on failure.

```c
Entity* short_url = smsapi_short_url(client, NULL);
voxgig_value* result = short_url->vt->remove(short_url, cmap(1, "id", v_str("short_url_id")), NULL, &err);
```

#### `vt->update(Entity* e, voxgig_value* reqdata, voxgig_value* ctrl, PNError** err)`

Update an existing entity. The data must include the entity id. Returns the updated entity data.

```c
Entity* short_url = smsapi_short_url(client, NULL);
voxgig_value* result = short_url->vt->update(short_url, cmap(1, "id", v_str("short_url_id")), NULL, &err);
```

### Common Methods

#### `voxgig_value* vt->data(Entity* e, voxgig_value* args)`

Get the entity data. Pass a map to set it.

#### `voxgig_value* vt->matchv(Entity* e, voxgig_value* args)`

Get the entity match criteria. Pass a map to set it.

#### `Entity* vt->make(Entity* e)`

Create a new `ShortUrl` entity instance with the same options.

#### `const char* vt->get_name(Entity* e)`

Return the entity name.


---

## Smsdo

```c
Entity* smsdo = smsapi_smsdo(client, NULL);
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `allow_duplicates` | `int64_t` | No | When parameter allow_duplicates is set to "1" allows to send message to duplicated numbers in one request (useful i.e. |
| `check_idx` | `voxgig_value*` | No | When parameter check_idx is set to „1” prevents from sending more than one message with the same idx in last 24h. |
| `date` | `voxgig_value*` | No | Date in UNIX timestamp (&date=1287734110) or in ISO 8601 (&date=2012-05-10T08:40:27+00:00) when message will be sent (&date=1287734110). |
| `date_validate` | `int64_t` | No | When parameter date_validate is set to "1" checks if date if given in proper format. |
| `details` | `voxgig_value*` | No | When details parameter is set to "1" more details in response will be displayed (message length and sms count). |
| `encoding` | `char*` | No | This parameter describes the encoding of the message text. |
| `expiration_date` | `voxgig_value*` | No | Message expiration date (in UNIX timestamp or in ISO 8601) is a date after which message won't be delivered if it wasn't delivered yet. |
| `fallback` | `voxgig_value* (list)` | No | Enable fallback in case sms sending fails |
| `fast` | `int64_t` | No | Setting this parameter to „1” will result in sending message with the highest priority which ensures the quickest possible time of delivery. |
| `flash` | `int64_t` | No | Sending a message in flash mode can be activated by setting this parameter to "1". |
| `format` | `char*` | No | Parameter &format=json causes, that response is sending in JSON format. |
| `from` | `char*` | No | Name of the sender. |
| `group` | `char*` | No | Name of the group from the contacts database to which message should be sent to. |
| `idx` | `char*` | No | Optional custom value sent with SMS and sent back in CALLBACK. |
| `max_parts` | `int64_t` | No | Defines maximum message parts allowed, maximum value allowed is 6. |
| `message` | `char*` | No | The message text. |
| `normalize` | `int64_t` | No | When parameter normalize is set to „1” special chars in message will be replaced with their equivalents (ê-e, ñ-n, ý-y ...). |
| `notify_url` | `char*` | No | Parameter allows to set CALLBACK URL for message from request. |
| `test` | `voxgig_value*` | No | When parameter test is set to "1" message won't be sent but response will be displayed, there is no charge for such test messages. |
| `time_restriction` | `char*` | No | Sets the behavior when you try to ship in hours / dates that do not match the settings in your account. |
| `to` | `char*` | No | Recipients' mobile phone numbers (i.e. |

### Operations

#### `vt->create(Entity* e, voxgig_value* reqdata, voxgig_value* ctrl, PNError** err)`

Create a new entity with the given data. Returns the created entity data and sets `*err` on failure.

```c
Entity* smsdo = smsapi_smsdo(client, NULL);
voxgig_value* result = smsdo->vt->create(smsdo, NULL, NULL, &err);
```

### Common Methods

#### `voxgig_value* vt->data(Entity* e, voxgig_value* args)`

Get the entity data. Pass a map to set it.

#### `voxgig_value* vt->matchv(Entity* e, voxgig_value* args)`

Get the entity match criteria. Pass a map to set it.

#### `Entity* vt->make(Entity* e)`

Create a new `Smsdo` entity instance with the same options.

#### `const char* vt->get_name(Entity* e)`

Return the entity name.


---

## Smssendername

```c
Entity* smssendername = smsapi_smssendername(client, NULL);
```

### Operations

#### `vt->create(Entity* e, voxgig_value* reqdata, voxgig_value* ctrl, PNError** err)`

Create a new entity with the given data. Returns the created entity data and sets `*err` on failure.

```c
Entity* smssendername = smsapi_smssendername(client, NULL);
voxgig_value* result = smssendername->vt->create(smssendername, cmap(1,
    "sendername_id", v_str("example_sendername_id"))  // char*
, NULL, &err);
```

#### `vt->remove(Entity* e, voxgig_value* reqmatch, voxgig_value* ctrl, PNError** err)`

Remove the entity matching the given criteria. Sets `*err` on failure.

```c
Entity* smssendername = smsapi_smssendername(client, NULL);
voxgig_value* result = smssendername->vt->remove(smssendername, cmap(1, "sender", v_str("sender")), NULL, &err);
```

### Common Methods

#### `voxgig_value* vt->data(Entity* e, voxgig_value* args)`

Get the entity data. Pass a map to set it.

#### `voxgig_value* vt->matchv(Entity* e, voxgig_value* args)`

Get the entity match criteria. Pass a map to set it.

#### `Entity* vt->make(Entity* e)`

Create a new `Smssendername` entity instance with the same options.

#### `const char* vt->get_name(Entity* e)`

Return the entity name.


---

## Smstemplate

```c
Entity* smstemplate = smsapi_smstemplate(client, NULL);
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | `char*` | No |  |

### Operations

#### `vt->remove(Entity* e, voxgig_value* reqmatch, voxgig_value* ctrl, PNError** err)`

Remove the entity matching the given criteria. Sets `*err` on failure.

```c
Entity* smstemplate = smsapi_smstemplate(client, NULL);
voxgig_value* result = smstemplate->vt->remove(smstemplate, cmap(1, "id", v_str("id")), NULL, &err);
```

### Common Methods

#### `voxgig_value* vt->data(Entity* e, voxgig_value* args)`

Get the entity data. Pass a map to set it.

#### `voxgig_value* vt->matchv(Entity* e, voxgig_value* args)`

Get the entity match criteria. Pass a map to set it.

#### `Entity* vt->make(Entity* e)`

Create a new `Smstemplate` entity instance with the same options.

#### `const char* vt->get_name(Entity* e)`

Return the entity name.


---

## Subuser

```c
Entity* subuser = smsapi_subuser(client, NULL);
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `active` | `bool` | No |  |
| `credentials` | `voxgig_value* (map)` | Yes |  |
| `description` | `char*` | No |  |
| `id` | `char*` | No | Object ID |
| `points` | `voxgig_value* (map)` | No |  |
| `username` | `char*` | No |  |

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

#### `vt->create(Entity* e, voxgig_value* reqdata, voxgig_value* ctrl, PNError** err)`

Create a new entity with the given data. Returns the created entity data and sets `*err` on failure.

```c
Entity* subuser = smsapi_subuser(client, NULL);
voxgig_value* result = subuser->vt->create(subuser, cmap(1,
    "credentials", v_map())  // voxgig_value* (map)
, NULL, &err);
```

#### `vt->list(Entity* e, voxgig_value* reqmatch, voxgig_value* ctrl, PNError** err)`

List entities matching the given criteria. The match is optional — pass `NULL` to list all records. Returns a List.

```c
Entity* subuser = smsapi_subuser(client, NULL);
voxgig_value* results = subuser->vt->list(subuser, NULL, NULL, &err);
for (size_t i = 0; i < (size_t)voxgig_size(results); i++) {
    printf("%s\n", voxgig_to_json(voxgig_getelem(results, v_int(i), NULL)));
}
```

#### `vt->load(Entity* e, voxgig_value* reqmatch, voxgig_value* ctrl, PNError** err)`

Load a single entity matching the given criteria. Returns the entity data and sets `*err` on failure.

```c
Entity* subuser = smsapi_subuser(client, NULL);
voxgig_value* result = subuser->vt->load(subuser, cmap(1, "id", v_str("subuser_id")), NULL, &err);
```

#### `vt->remove(Entity* e, voxgig_value* reqmatch, voxgig_value* ctrl, PNError** err)`

Remove the entity matching the given criteria. Sets `*err` on failure.

```c
Entity* subuser = smsapi_subuser(client, NULL);
voxgig_value* result = subuser->vt->remove(subuser, cmap(1, "id", v_str("subuser_id")), NULL, &err);
```

#### `vt->update(Entity* e, voxgig_value* reqdata, voxgig_value* ctrl, PNError** err)`

Update an existing entity. The data must include the entity id. Returns the updated entity data.

```c
Entity* subuser = smsapi_subuser(client, NULL);
voxgig_value* result = subuser->vt->update(subuser, cmap(1, "id", v_str("subuser_id")), NULL, &err);
```

### Common Methods

#### `voxgig_value* vt->data(Entity* e, voxgig_value* args)`

Get the entity data. Pass a map to set it.

#### `voxgig_value* vt->matchv(Entity* e, voxgig_value* args)`

Get the entity match criteria. Pass a map to set it.

#### `Entity* vt->make(Entity* e)`

Create a new `Subuser` entity instance with the same options.

#### `const char* vt->get_name(Entity* e)`

Return the entity name.


---

## Template

```c
Entity* template = smsapi_template(client, NULL);
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | `char*` | No |  |
| `name` | `char*` | No |  |
| `normalize` | `bool` | No |  |
| `template` | `char*` | No |  |

### Operations

#### `vt->create(Entity* e, voxgig_value* reqdata, voxgig_value* ctrl, PNError** err)`

Create a new entity with the given data. Returns the created entity data and sets `*err` on failure.

```c
Entity* template = smsapi_template(client, NULL);
voxgig_value* result = template->vt->create(template, NULL, NULL, &err);
```

#### `vt->list(Entity* e, voxgig_value* reqmatch, voxgig_value* ctrl, PNError** err)`

List entities matching the given criteria. The match is optional — pass `NULL` to list all records. Returns a List.

```c
Entity* template = smsapi_template(client, NULL);
voxgig_value* results = template->vt->list(template, NULL, NULL, &err);
for (size_t i = 0; i < (size_t)voxgig_size(results); i++) {
    printf("%s\n", voxgig_to_json(voxgig_getelem(results, v_int(i), NULL)));
}
```

#### `vt->load(Entity* e, voxgig_value* reqmatch, voxgig_value* ctrl, PNError** err)`

Load a single entity matching the given criteria. Returns the entity data and sets `*err` on failure.

```c
Entity* template = smsapi_template(client, NULL);
voxgig_value* result = template->vt->load(template, cmap(1, "id", v_str("template_id")), NULL, &err);
```

#### `vt->update(Entity* e, voxgig_value* reqdata, voxgig_value* ctrl, PNError** err)`

Update an existing entity. The data must include the entity id. Returns the updated entity data.

```c
Entity* template = smsapi_template(client, NULL);
voxgig_value* result = template->vt->update(template, cmap(1, "id", v_str("template_id")), NULL, &err);
```

### Common Methods

#### `voxgig_value* vt->data(Entity* e, voxgig_value* args)`

Get the entity data. Pass a map to set it.

#### `voxgig_value* vt->matchv(Entity* e, voxgig_value* args)`

Get the entity match criteria. Pass a map to set it.

#### `Entity* vt->make(Entity* e)`

Create a new `Template` entity instance with the same options.

#### `const char* vt->get_name(Entity* e)`

Return the entity name.


---

## UserRcsSenderCollection

```c
Entity* user_rcs_sender_collection = smsapi_user_rcs_sender_collection(client, NULL);
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `deliveredAt` | `char*` | No |  |
| `expiredAt` | `char*` | No |  |
| `id` | `char*` | No | Object ID |
| `interface` | `char*` | No | Interface through which the message was sent (www, api, ...). |
| `messageType` | `char*` | No | RCS message type (basic, single, ...). |
| `readAt` | `char*` | No |  |
| `recipient` | `char*` | No | Recipient phone number (without +). |
| `sender` | `char*` | No | Sender name |
| `senderId` | `char*` | No | Sender id |
| `sentAt` | `char*` | No |  |

### Operations

#### `vt->list(Entity* e, voxgig_value* reqmatch, voxgig_value* ctrl, PNError** err)`

List entities matching the given criteria. The match is optional — pass `NULL` to list all records. Returns a List.

```c
Entity* user_rcs_sender_collection = smsapi_user_rcs_sender_collection(client, NULL);
voxgig_value* results = user_rcs_sender_collection->vt->list(user_rcs_sender_collection, NULL, NULL, &err);
for (size_t i = 0; i < (size_t)voxgig_size(results); i++) {
    printf("%s\n", voxgig_to_json(voxgig_getelem(results, v_int(i), NULL)));
}
```

### Common Methods

#### `voxgig_value* vt->data(Entity* e, voxgig_value* args)`

Get the entity data. Pass a map to set it.

#### `voxgig_value* vt->matchv(Entity* e, voxgig_value* args)`

Get the entity match criteria. Pass a map to set it.

#### `Entity* vt->make(Entity* e)`

Create a new `UserRcsSenderCollection` entity instance with the same options.

#### `const char* vt->get_name(Entity* e)`

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

```c
SmsapiSDK* client = smsapi_sdk_new(cmap(1,
    "feature", cmap(20,
        "audit", cmap(1, "active", v_bool(true)),
        "cache", cmap(1, "active", v_bool(true)),
        "clienttrack", cmap(1, "active", v_bool(true)),
        "cost", cmap(1, "active", v_bool(true)),
        "debug", cmap(1, "active", v_bool(true)),
        "idempotency", cmap(1, "active", v_bool(true)),
        "log", cmap(1, "active", v_bool(true)),
        "metrics", cmap(1, "active", v_bool(true)),
        "netsim", cmap(1, "active", v_bool(true)),
        "paging", cmap(1, "active", v_bool(true)),
        "proxy", cmap(1, "active", v_bool(true)),
        "ratelimit", cmap(1, "active", v_bool(true)),
        "rbac", cmap(1, "active", v_bool(true)),
        "retry", cmap(1, "active", v_bool(true)),
        "secrets", cmap(1, "active", v_bool(true)),
        "streaming", cmap(1, "active", v_bool(true)),
        "telemetry", cmap(1, "active", v_bool(true)),
        "test", cmap(1, "active", v_bool(true)),
        "timeout", cmap(1, "active", v_bool(true)),
        "validate", cmap(1, "active", v_bool(true)))
));
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

