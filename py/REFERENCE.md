# Smsapi Python SDK Reference

Complete API reference for the Smsapi Python SDK.


## SmsapiSDK

### Constructor

```python
from smsapi_sdk import SmsapiSDK

client = SmsapiSDK(options)
```

Create a new SDK client instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `options` | `dict` | SDK configuration options. |
| `options["apikey"]` | `str` | API key for authentication. |
| `options["base"]` | `str` | Base URL for API requests. |
| `options["prefix"]` | `str` | URL prefix appended after base. |
| `options["suffix"]` | `str` | URL suffix appended after path. |
| `options["headers"]` | `dict` | Custom headers for all requests. |
| `options["feature"]` | `dict` | Feature configuration. |
| `options["system"]` | `dict` | System overrides (e.g. custom fetch). |


### Static Methods

#### `SmsapiSDK.test(testopts=None, sdkopts=None)`

Create a test client with mock features active. Both arguments may be `None`.

```python
client = SmsapiSDK.test()
```


### Instance Methods

#### `Available(data=None)`

Create a new `AvailableEntity` instance. Pass `None` for no initial data.

#### `Blacklist(data=None)`

Create a new `BlacklistEntity` instance. Pass `None` for no initial data.

#### `Callback(data=None)`

Create a new `CallbackEntity` instance. Pass `None` for no initial data.

#### `Contact(data=None)`

Create a new `ContactEntity` instance. Pass `None` for no initial data.

#### `ContactsField(data=None)`

Create a new `ContactsFieldEntity` instance. Pass `None` for no initial data.

#### `ContactsFieldOption(data=None)`

Create a new `ContactsFieldOptionEntity` instance. Pass `None` for no initial data.

#### `Contactsgroup(data=None)`

Create a new `ContactsgroupEntity` instance. Pass `None` for no initial data.

#### `Contactstrash(data=None)`

Create a new `ContactstrashEntity` instance. Pass `None` for no initial data.

#### `FieldAvailable(data=None)`

Create a new `FieldAvailableEntity` instance. Pass `None` for no initial data.

#### `Group(data=None)`

Create a new `GroupEntity` instance. Pass `None` for no initial data.

#### `MfaCode(data=None)`

Create a new `MfaCodeEntity` instance. Pass `None` for no initial data.

#### `OptOut(data=None)`

Create a new `OptOutEntity` instance. Pass `None` for no initial data.

#### `OptOutSetting(data=None)`

Create a new `OptOutSettingEntity` instance. Pass `None` for no initial data.

#### `Permission(data=None)`

Create a new `PermissionEntity` instance. Pass `None` for no initial data.

#### `Ping(data=None)`

Create a new `PingEntity` instance. Pass `None` for no initial data.

#### `Profile(data=None)`

Create a new `ProfileEntity` instance. Pass `None` for no initial data.

#### `Rcs(data=None)`

Create a new `RcsEntity` instance. Pass `None` for no initial data.

#### `Sendername(data=None)`

Create a new `SendernameEntity` instance. Pass `None` for no initial data.

#### `SendernameStatement(data=None)`

Create a new `SendernameStatementEntity` instance. Pass `None` for no initial data.

#### `SentRcsMessage(data=None)`

Create a new `SentRcsMessageEntity` instance. Pass `None` for no initial data.

#### `ShipmentCountryVolume(data=None)`

Create a new `ShipmentCountryVolumeEntity` instance. Pass `None` for no initial data.

#### `ShortUrl(data=None)`

Create a new `ShortUrlEntity` instance. Pass `None` for no initial data.

#### `Smsdo(data=None)`

Create a new `SmsdoEntity` instance. Pass `None` for no initial data.

#### `Smssendername(data=None)`

Create a new `SmssendernameEntity` instance. Pass `None` for no initial data.

#### `Smstemplate(data=None)`

Create a new `SmstemplateEntity` instance. Pass `None` for no initial data.

#### `Subuser(data=None)`

Create a new `SubuserEntity` instance. Pass `None` for no initial data.

#### `Template(data=None)`

Create a new `TemplateEntity` instance. Pass `None` for no initial data.

#### `UserRcsSenderCollection(data=None)`

Create a new `UserRcsSenderCollectionEntity` instance. Pass `None` for no initial data.

#### `options_map() -> dict`

Return a deep copy of the current SDK options.

#### `get_utility() -> Utility`

Return a copy of the SDK utility object.

#### `direct(fetchargs=None) -> dict`

Make a direct HTTP request to any API endpoint. Returns a result `dict` with `ok`, `status`, `headers`, and `data` (or `err` on failure). This escape hatch never raises — branch on `result["ok"]`.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `fetchargs["path"]` | `str` | URL path with optional `{param}` placeholders. |
| `fetchargs["method"]` | `str` | HTTP method (default: `"GET"`). |
| `fetchargs["params"]` | `dict` | Path parameter values. |
| `fetchargs["query"]` | `dict` | Query string parameters. |
| `fetchargs["headers"]` | `dict` | Request headers (merged with defaults). |
| `fetchargs["body"]` | `any` | Request body (dicts are JSON-serialized). |

**Returns:** `result_dict`

#### `prepare(fetchargs=None) -> dict`

Prepare a fetch definition without sending. Returns the `fetchdef` and raises on error.


---

## AvailableEntity

```python
available = client.Available()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `name` | `str` | No |  |
| `normalize` | `bool` | No |  |
| `template` | `str` | No |  |

### Operations

#### `list(reqmatch=None, ctrl=None) -> list[AvailableEntity]`

List entities matching the given criteria. The match is optional — call `list()` with no argument to list all records. Returns a list of entities, one per record, and raises on error.

```python
results = client.Available().list()
for available in results:
    print(available.data_get())
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `AvailableEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## BlacklistEntity

```python
blacklist = client.Blacklist()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | `str` | No |  |

### Operations

#### `create(reqdata, ctrl=None) -> BlacklistEntity`

Create a new entity with the given data. Returns the created entity and raises on error.

```python
result = client.Blacklist().create({
})
```

Declares a `multipart/form-data` body, which this SDK does not encode yet: it sends the data as JSON.

#### `load(reqmatch, ctrl=None) -> BlacklistEntity`

Load a single entity matching the given criteria. Returns the entity, whose record `data_get()` reads, and raises on error.

```python
result = client.Blacklist().load()
```

#### `remove(reqmatch, ctrl=None) -> BlacklistEntity`

Remove the entity matching the given criteria. Returns the entity, marked as deleted, and raises on error.

```python
result = client.Blacklist().remove({"id": "id"})
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `BlacklistEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## CallbackEntity

```python
callback = client.Callback()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `active` | `bool` | No |  |
| `api_version` | `int` | No | Version of the callback output format. |
| `id` | `str` | No | Object ID |
| `invalid` | `bool` | No |  |
| `receiver` | `dict` | No |  |
| `receiver_type` | `str` | No |  |
| `type` | `str` | No |  |
| `url` | `str` | No | WHATWG URL compliant |

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

#### `create(reqdata, ctrl=None) -> CallbackEntity`

Create a new entity with the given data. Returns the created entity and raises on error.

```python
result = client.Callback().create({
})
```

#### `list(reqmatch=None, ctrl=None) -> list[CallbackEntity]`

List entities matching the given criteria. The match is optional — call `list()` with no argument to list all records. Returns a list of entities, one per record, and raises on error.

```python
results = client.Callback().list()
for callback in results:
    print(callback.data_get())
```

#### `load(reqmatch, ctrl=None) -> CallbackEntity`

Load a single entity matching the given criteria. Returns the entity, whose record `data_get()` reads, and raises on error.

```python
result = client.Callback().load({"id": "callback_id"})
```

#### `remove(reqmatch, ctrl=None) -> CallbackEntity`

Remove the entity matching the given criteria. Returns the entity, marked as deleted, and raises on error.

```python
result = client.Callback().remove({"id": "callback_id"})
```

#### `update(reqdata, ctrl=None) -> CallbackEntity`

Update an existing entity. The data must include the entity `id`. Returns the updated entity and raises on error.

```python
result = client.Callback().update({
    "id": "callback_id",
    # Fields to update
})
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `CallbackEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## ContactEntity

```python
contact = client.Contact()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `birthday_date` | `str` | No |  |
| `city` | `str` | No |  |
| `collection` | `list` | Yes |  |
| `contact_expire_after` | `int` | Yes | Contact expire after days |
| `contacts_count` | `int` | Yes |  |
| `country` | `str` | No |  |
| `created_by` | `str` | Yes |  |
| `date_created` | `str` | Yes |  |
| `date_updated` | `str` | Yes |  |
| `description` | `str` | No |  |
| `email` | `str` | No |  |
| `first_name` | `str` | No |  |
| `gender` | `str` | Yes |  |
| `groups` | `list` | Yes |  |
| `id` | `str` | Yes | Object ID |
| `idx` | `str` | No | User provided resource id |
| `last_name` | `str` | No |  |
| `name` | `str` | Yes | Group name |
| `permissions` | `list` | No |  |
| `phone_number` | `str` | No |  |
| `size` | `int` | Yes |  |
| `source` | `str` | No |  |

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

#### `create(reqdata, ctrl=None) -> ContactEntity`

Create a new entity with the given data. Returns the created entity and raises on error.

```python
result = client.Contact().create({
    "collection": [],  # list
    "contact_expire_after": 1,  # int
    "contacts_count": 1,  # int
    "created_by": "example_created_by",  # str
    "date_created": "example_date_created",  # str
    "date_updated": "example_date_updated",  # str
    "gender": "example_gender",  # str
    "groups": [],  # list
    "id": "example_id",  # str
    "name": "example_name",  # str
    "size": 1,  # int
})
```

Declares a `application/x-www-form-urlencoded` body, which this SDK does not encode yet: it sends the data as JSON.

#### `list(reqmatch=None, ctrl=None) -> list[ContactEntity]`

List entities matching the given criteria. The match is optional — call `list()` with no argument to list all records. Returns a list of entities, one per record, and raises on error.

```python
results = client.Contact().list()
for contact in results:
    print(contact.data_get())
```

#### `load(reqmatch, ctrl=None) -> ContactEntity`

Load a single entity matching the given criteria. Returns the entity, whose record `data_get()` reads, and raises on error.

```python
result = client.Contact().load({"id": "contact_id"})
```

#### `remove(reqmatch, ctrl=None) -> ContactEntity`

Remove the entity matching the given criteria. Returns the entity, marked as deleted, and raises on error.

```python
result = client.Contact().remove({"id": "contact_id"})
```

#### `update(reqdata, ctrl=None) -> ContactEntity`

Update an existing entity. The data must include the entity `id`. Returns the updated entity and raises on error.

```python
result = client.Contact().update({
    "id": "contact_id",
    # Fields to update
})
```

Declares a `application/x-www-form-urlencoded` body, which this SDK does not encode yet: it sends the data as JSON.

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `ContactEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## ContactsFieldEntity

```python
contacts_field = client.ContactsField()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | `str` | No | Object ID |
| `name` | `str` | No |  |
| `type` | `str` | No |  |

### Operations

#### `create(reqdata, ctrl=None) -> ContactsFieldEntity`

Create a new entity with the given data. Returns the created entity and raises on error.

```python
result = client.ContactsField().create({
})
```

Declares a `application/x-www-form-urlencoded` body, which this SDK does not encode yet: it sends the data as JSON.

#### `list(reqmatch=None, ctrl=None) -> list[ContactsFieldEntity]`

List entities matching the given criteria. The match is optional — call `list()` with no argument to list all records. Returns a list of entities, one per record, and raises on error.

```python
results = client.ContactsField().list()
for contacts_field in results:
    print(contacts_field.data_get())
```

#### `remove(reqmatch, ctrl=None) -> ContactsFieldEntity`

Remove the entity matching the given criteria. Returns the entity, marked as deleted, and raises on error.

```python
result = client.ContactsField().remove({"id": "id"})
```

#### `update(reqdata, ctrl=None) -> ContactsFieldEntity`

Update an existing entity. The data must include the entity `id`. Returns the updated entity and raises on error.

```python
result = client.ContactsField().update({
    "id": "id",
    # Fields to update
})
```

Declares a `application/x-www-form-urlencoded` body, which this SDK does not encode yet: it sends the data as JSON.

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `ContactsFieldEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## ContactsFieldOptionEntity

```python
contacts_field_option = client.ContactsFieldOption()
```

### Operations

#### `list(reqmatch=None, ctrl=None) -> list[ContactsFieldOptionEntity]`

List entities matching the given criteria. The match is optional — call `list()` with no argument to list all records. Returns a list of entities, one per record, and raises on error.

```python
results = client.ContactsFieldOption().list({"field_id": "example"})
for contacts_field_option in results:
    print(contacts_field_option.data_get())
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `ContactsFieldOptionEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## ContactsgroupEntity

```python
contactsgroup = client.Contactsgroup()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `group_id` | `str` | Yes | Object ID |
| `read` | `bool` | Yes | Has read permission |
| `send` | `bool` | Yes | Has send permission |
| `username` | `str` | Yes |  |
| `write` | `bool` | Yes | Has write permission |

### Operations

#### `create(reqdata, ctrl=None) -> ContactsgroupEntity`

Create a new entity with the given data. Returns the created entity and raises on error.

```python
result = client.Contactsgroup().create({
    "group_id": "example_group_id",  # str
    "read": True,  # bool
    "send": True,  # bool
    "username": "example_username",  # str
    "write": True,  # bool
})
```

Declares a `application/x-www-form-urlencoded` body, which this SDK does not encode yet: it sends the data as JSON.

#### `list(reqmatch=None, ctrl=None) -> list[ContactsgroupEntity]`

List entities matching the given criteria. The match is optional — call `list()` with no argument to list all records. Returns a list of entities, one per record, and raises on error.

```python
results = client.Contactsgroup().list()
for contactsgroup in results:
    print(contactsgroup.data_get())
```

#### `remove(reqmatch, ctrl=None) -> ContactsgroupEntity`

Remove the entity matching the given criteria. Returns the entity, marked as deleted, and raises on error.

```python
result = client.Contactsgroup().remove({"group_id": "group_id"})
```

#### `update(reqdata, ctrl=None) -> ContactsgroupEntity`

Update an existing entity. The data must include the entity `id`. Returns the updated entity and raises on error.

```python
result = client.Contactsgroup().update({
    "group_id": "group_id",
    # Fields to update
})
```

Declares a `application/x-www-form-urlencoded` body, which this SDK does not encode yet: it sends the data as JSON.

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `ContactsgroupEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## ContactstrashEntity

```python
contactstrash = client.Contactstrash()
```

### Operations

#### `remove(reqmatch, ctrl=None) -> ContactstrashEntity`

Remove the entity matching the given criteria. Returns the entity, marked as deleted, and raises on error.

```python
result = client.Contactstrash().remove()
```

#### `update(reqdata, ctrl=None) -> ContactstrashEntity`

Update an existing entity. The data must include the entity `id`. Returns the updated entity and raises on error.

```python
result = client.Contactstrash().update({
    # Fields to update
})
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `ContactstrashEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## FieldAvailableEntity

```python
field_available = client.FieldAvailable()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `built_in` | `bool` | No |  |
| `id` | `str` | No | Object ID |
| `name` | `str` | No |  |
| `options` | `list` | No |  |
| `type` | `str` | No |  |

### Operations

#### `list(reqmatch=None, ctrl=None) -> list[FieldAvailableEntity]`

List entities matching the given criteria. The match is optional — call `list()` with no argument to list all records. Returns a list of entities, one per record, and raises on error.

```python
results = client.FieldAvailable().list()
for field_available in results:
    print(field_available.data_get())
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `FieldAvailableEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## GroupEntity

```python
group = client.Group()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `contact_expire_after` | `int` | Yes | Contact expire after days |
| `contacts_count` | `int` | Yes |  |
| `created_by` | `str` | Yes |  |
| `date_created` | `str` | Yes |  |
| `date_updated` | `str` | Yes |  |
| `description` | `str` | Yes |  |
| `id` | `str` | Yes | Object ID |
| `idx` | `str` | No | User provided resource id |
| `name` | `str` | Yes | Group name |
| `permissions` | `list` | No |  |

### Operations

#### `load(reqmatch, ctrl=None) -> GroupEntity`

Load a single entity matching the given criteria. Returns the entity, whose record `data_get()` reads, and raises on error.

```python
result = client.Group().load({"id": "group_id"})
```

#### `update(reqdata, ctrl=None) -> GroupEntity`

Update an existing entity. The data must include the entity `id`. Returns the updated entity and raises on error.

```python
result = client.Group().update({
    "id": "group_id",
    # Fields to update
})
```

Declares a `application/x-www-form-urlencoded` body, which this SDK does not encode yet: it sends the data as JSON.

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `GroupEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## MfaCodeEntity

```python
mfa_code = client.MfaCode()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `content` | `str` | No | Custom content that must contain placeholder [%code%] |
| `fast` | `Any` | No |  |
| `from` | `str` | No | Sendername |
| `phone_number` | `str` | Yes |  |

### Operations

#### `create(reqdata, ctrl=None) -> MfaCodeEntity`

Create a new entity with the given data. Returns the created entity and raises on error.

```python
result = client.MfaCode().create({
    "phone_number": "example_phone_number",  # str
})
```

Declares a `application/x-www-form-urlencoded` body, which this SDK does not encode yet: it sends the data as JSON.

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `MfaCodeEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## OptOutEntity

```python
opt_out = client.OptOut()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `date` | `str` | No |  |
| `id` | `str` | No |  |
| `links` | `list` | No |  |
| `phoneNumber` | `int` | No |  |

### Operations

#### `list(reqmatch=None, ctrl=None) -> list[OptOutEntity]`

List entities matching the given criteria. The match is optional — call `list()` with no argument to list all records. Returns a list of entities, one per record, and raises on error.

```python
results = client.OptOut().list()
for opt_out in results:
    print(opt_out.data_get())
```

#### `remove(reqmatch, ctrl=None) -> OptOutEntity`

Remove the entity matching the given criteria. Returns the entity, marked as deleted, and raises on error.

```python
result = client.OptOut().remove({"id": "id"})
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `OptOutEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## OptOutSettingEntity

```python
opt_out_setting = client.OptOutSetting()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `brand` | `str` | No |  |

### Operations

#### `load(reqmatch, ctrl=None) -> OptOutSettingEntity`

Load a single entity matching the given criteria. Returns the entity, whose record `data_get()` reads, and raises on error.

```python
result = client.OptOutSetting().load()
```

#### `update(reqdata, ctrl=None) -> OptOutSettingEntity`

Update an existing entity. The data must include the entity `id`. Returns the updated entity and raises on error.

```python
result = client.OptOutSetting().update({
    # Fields to update
})
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `OptOutSettingEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## PermissionEntity

```python
permission = client.Permission()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `group_id` | `str` | Yes | Object ID |
| `id` | `str` | No |  |
| `read` | `bool` | Yes | Has read permission |
| `send` | `bool` | Yes | Has send permission |
| `username` | `str` | Yes |  |
| `write` | `bool` | Yes | Has write permission |

### Operations

#### `create(reqdata, ctrl=None) -> PermissionEntity`

Create a new entity with the given data. Returns the created entity and raises on error.

```python
result = client.Permission().create({
    "group_id": "example_group_id",  # str
    "read": True,  # bool
    "send": True,  # bool
    "username": "example_username",  # str
    "write": True,  # bool
})
```

Declares a `application/x-www-form-urlencoded` body, which this SDK does not encode yet: it sends the data as JSON.

#### `load(reqmatch, ctrl=None) -> PermissionEntity`

Load a single entity matching the given criteria. Returns the entity, whose record `data_get()` reads, and raises on error.

```python
result = client.Permission().load({"id": "permission_id", "group_id": "group_id"})
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `PermissionEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## PingEntity

```python
ping = client.Ping()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `authorized` | `bool` | Yes |  |
| `unavailable` | `list` | Yes |  |

### Operations

#### `list(reqmatch=None, ctrl=None) -> list[PingEntity]`

List entities matching the given criteria. The match is optional — call `list()` with no argument to list all records. Returns a list of entities, one per record, and raises on error.

```python
results = client.Ping().list()
for ping in results:
    print(ping.data_get())
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `PingEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## ProfileEntity

```python
profile = client.Profile()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `email` | `str` | Yes |  |
| `name` | `str` | Yes |  |
| `payment_type` | `str` | Yes |  |
| `phone_number` | `int` | Yes |  |
| `points` | `float` | No |  |
| `user_type` | `str` | Yes |  |
| `username` | `str` | Yes |  |

### Operations

#### `list(reqmatch=None, ctrl=None) -> list[ProfileEntity]`

List entities matching the given criteria. The match is optional — call `list()` with no argument to list all records. Returns a list of entities, one per record, and raises on error.

```python
results = client.Profile().list()
for profile in results:
    print(profile.data_get())
```

#### `load(reqmatch, ctrl=None) -> ProfileEntity`

Load a single entity matching the given criteria. Returns the entity, whose record `data_get()` reads, and raises on error.

```python
result = client.Profile().load()
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `ProfileEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## RcsEntity

```python
rcs = client.Rcs()
```

### Operations

#### `list(reqmatch=None, ctrl=None) -> list[RcsEntity]`

List entities matching the given criteria. The match is optional — call `list()` with no argument to list all records. Returns a list of entities, one per record, and raises on error.

```python
results = client.Rcs().list()
for rcs in results:
    print(rcs.data_get())
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `RcsEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## SendernameEntity

```python
sendername = client.Sendername()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `created_at` | `str` | No |  |
| `id` | `str` | No |  |
| `is_default` | `bool` | No |  |
| `sender` | `str` | No | Sendername |
| `status` | `str` | No |  |

### Operations

#### `create(reqdata, ctrl=None) -> SendernameEntity`

Create a new entity with the given data. Returns the created entity and raises on error.

```python
result = client.Sendername().create({
})
```

Declares a `application/x-www-form-urlencoded` body, which this SDK does not encode yet: it sends the data as JSON.

#### `list(reqmatch=None, ctrl=None) -> list[SendernameEntity]`

List entities matching the given criteria. The match is optional — call `list()` with no argument to list all records. Returns a list of entities, one per record, and raises on error.

```python
results = client.Sendername().list()
for sendername in results:
    print(sendername.data_get())
```

#### `load(reqmatch, ctrl=None) -> SendernameEntity`

Load a single entity matching the given criteria. Returns the entity, whose record `data_get()` reads, and raises on error.

```python
result = client.Sendername().load({"id": "sendername_id"})
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `SendernameEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## SendernameStatementEntity

```python
sendername_statement = client.SendernameStatement()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `content` | `str` | No |  |
| `statements` | `list` | No |  |
| `title` | `str` | No |  |

### Operations

#### `list(reqmatch=None, ctrl=None) -> list[SendernameStatementEntity]`

List entities matching the given criteria. The match is optional — call `list()` with no argument to list all records. Returns a list of entities, one per record, and raises on error.

```python
results = client.SendernameStatement().list()
for sendername_statement in results:
    print(sendername_statement.data_get())
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `SendernameStatementEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## SentRcsMessageEntity

```python
sent_rcs_message = client.SentRcsMessage()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `content` | `dict` | No | RCS message content in RCS JSON format. |
| `phone_number` | `str` | Yes | Recipient phone number (e.g. |
| `sender` | `str` | Yes | RCS sender ID (object ID of the agent/sender the user has access to). |
| `text` | `str` | No | Plain text message content. |

### Operations

#### `create(reqdata, ctrl=None) -> SentRcsMessageEntity`

Create a new entity with the given data. Returns the created entity and raises on error.

```python
result = client.SentRcsMessage().create({
    "phone_number": "example_phone_number",  # str
    "sender": "example_sender",  # str
})
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `SentRcsMessageEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## ShipmentCountryVolumeEntity

```python
shipment_country_volume = client.ShipmentCountryVolume()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `country_code` | `str` | No |  |
| `country_limit` | `int` | No |  |
| `country_name` | `str` | No |  |
| `usage` | `int` | No |  |

### Operations

#### `list(reqmatch=None, ctrl=None) -> list[ShipmentCountryVolumeEntity]`

List entities matching the given criteria. The match is optional — call `list()` with no argument to list all records. Returns a list of entities, one per record, and raises on error.

```python
results = client.ShipmentCountryVolume().list()
for shipment_country_volume in results:
    print(shipment_country_volume.data_get())
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `ShipmentCountryVolumeEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## ShortUrlEntity

```python
short_url = client.ShortUrl()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `description` | `str` | No |  |
| `expire` | `str` | No |  |
| `filename` | `str` | No |  |
| `hits` | `int` | No |  |
| `hits_unique` | `int` | No |  |
| `id` | `str` | No |  |
| `name` | `str` | No |  |
| `short_url` | `str` | No | WHATWG URL compliant |
| `type` | `str` | No |  |
| `url` | `str` | No | WHATWG URL compliant |

### Operations

#### `create(reqdata, ctrl=None) -> ShortUrlEntity`

Create a new entity with the given data. Returns the created entity and raises on error.

```python
result = client.ShortUrl().create({
})
```

#### `list(reqmatch=None, ctrl=None) -> list[ShortUrlEntity]`

List entities matching the given criteria. The match is optional — call `list()` with no argument to list all records. Returns a list of entities, one per record, and raises on error.

```python
results = client.ShortUrl().list()
for short_url in results:
    print(short_url.data_get())
```

#### `load(reqmatch, ctrl=None) -> ShortUrlEntity`

Load a single entity matching the given criteria. Returns the entity, whose record `data_get()` reads, and raises on error.

```python
result = client.ShortUrl().load({"id": "short_url_id"})
```

#### `remove(reqmatch, ctrl=None) -> ShortUrlEntity`

Remove the entity matching the given criteria. Returns the entity, marked as deleted, and raises on error.

```python
result = client.ShortUrl().remove({"id": "short_url_id"})
```

#### `update(reqdata, ctrl=None) -> ShortUrlEntity`

Update an existing entity. The data must include the entity `id`. Returns the updated entity and raises on error.

```python
result = client.ShortUrl().update({
    "id": "short_url_id",
    # Fields to update
})
```

Declares a `application/x-www-form-urlencoded` body, which this SDK does not encode yet: it sends the data as JSON.

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `ShortUrlEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## SmsdoEntity

```python
smsdo = client.Smsdo()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `allow_duplicates` | `int` | No | When parameter allow_duplicates is set to "1" allows to send message to duplicated numbers in one request (useful i.e. |
| `check_idx` | `Any` | No | When parameter check_idx is set to „1” prevents from sending more than one message with the same idx in last 24h. |
| `date` | `Any` | No | Date in UNIX timestamp (&date=1287734110) or in ISO 8601 (&date=2012-05-10T08:40:27+00:00) when message will be sent (&date=1287734110). |
| `date_validate` | `int` | No | When parameter date_validate is set to "1" checks if date if given in proper format. |
| `details` | `Any` | No | When details parameter is set to "1" more details in response will be displayed (message length and sms count). |
| `encoding` | `str` | No | This parameter describes the encoding of the message text. |
| `expiration_date` | `Any` | No | Message expiration date (in UNIX timestamp or in ISO 8601) is a date after which message won't be delivered if it wasn't delivered yet. |
| `fallback` | `list` | No | Enable fallback in case sms sending fails |
| `fast` | `int` | No | Setting this parameter to „1” will result in sending message with the highest priority which ensures the quickest possible time of delivery. |
| `flash` | `int` | No | Sending a message in flash mode can be activated by setting this parameter to "1". |
| `format` | `str` | No | Parameter &format=json causes, that response is sending in JSON format. |
| `from` | `str` | No | Name of the sender. |
| `group` | `str` | No | Name of the group from the contacts database to which message should be sent to. |
| `idx` | `str` | No | Optional custom value sent with SMS and sent back in CALLBACK. |
| `max_parts` | `int` | No | Defines maximum message parts allowed, maximum value allowed is 6. |
| `message` | `str` | No | The message text. |
| `normalize` | `int` | No | When parameter normalize is set to „1” special chars in message will be replaced with their equivalents (ê-e, ñ-n, ý-y ...). |
| `notify_url` | `str` | No | Parameter allows to set CALLBACK URL for message from request. |
| `test` | `Any` | No | When parameter test is set to "1" message won't be sent but response will be displayed, there is no charge for such test messages. |
| `time_restriction` | `str` | No | Sets the behavior when you try to ship in hours / dates that do not match the settings in your account. |
| `to` | `str` | No | Recipients' mobile phone numbers (i.e. |

### Operations

#### `create(reqdata, ctrl=None) -> SmsdoEntity`

Create a new entity with the given data. Returns the created entity and raises on error.

```python
result = client.Smsdo().create({
})
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `SmsdoEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## SmssendernameEntity

```python
smssendername = client.Smssendername()
```

### Operations

#### `create(reqdata, ctrl=None) -> SmssendernameEntity`

Create a new entity with the given data. Returns the created entity and raises on error.

```python
result = client.Smssendername().create({
    "sender": "example_sender",  # str
})
```

#### `remove(reqmatch, ctrl=None) -> SmssendernameEntity`

Remove the entity matching the given criteria. Returns the entity, marked as deleted, and raises on error.

```python
result = client.Smssendername().remove({"sender": "sender"})
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `SmssendernameEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## SmstemplateEntity

```python
smstemplate = client.Smstemplate()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | `str` | No |  |

### Operations

#### `remove(reqmatch, ctrl=None) -> SmstemplateEntity`

Remove the entity matching the given criteria. Returns the entity, marked as deleted, and raises on error.

```python
result = client.Smstemplate().remove({"id": "id"})
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `SmstemplateEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## SubuserEntity

```python
subuser = client.Subuser()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `active` | `bool` | No |  |
| `credentials` | `dict` | Yes |  |
| `description` | `str` | No |  |
| `id` | `str` | No | Object ID |
| `points` | `dict` | No |  |
| `username` | `str` | No |  |

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

#### `create(reqdata, ctrl=None) -> SubuserEntity`

Create a new entity with the given data. Returns the created entity and raises on error.

```python
result = client.Subuser().create({
    "credentials": {},  # dict
})
```

#### `list(reqmatch=None, ctrl=None) -> list[SubuserEntity]`

List entities matching the given criteria. The match is optional — call `list()` with no argument to list all records. Returns a list of entities, one per record, and raises on error.

```python
results = client.Subuser().list()
for subuser in results:
    print(subuser.data_get())
```

#### `load(reqmatch, ctrl=None) -> SubuserEntity`

Load a single entity matching the given criteria. Returns the entity, whose record `data_get()` reads, and raises on error.

```python
result = client.Subuser().load({"id": "subuser_id"})
```

#### `remove(reqmatch, ctrl=None) -> SubuserEntity`

Remove the entity matching the given criteria. Returns the entity, marked as deleted, and raises on error.

```python
result = client.Subuser().remove({"id": "subuser_id"})
```

#### `update(reqdata, ctrl=None) -> SubuserEntity`

Update an existing entity. The data must include the entity `id`. Returns the updated entity and raises on error.

```python
result = client.Subuser().update({
    "id": "subuser_id",
    # Fields to update
})
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `SubuserEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## TemplateEntity

```python
template = client.Template()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | `str` | No |  |
| `name` | `str` | No |  |
| `normalize` | `bool` | No |  |
| `template` | `str` | No |  |

### Operations

#### `create(reqdata, ctrl=None) -> TemplateEntity`

Create a new entity with the given data. Returns the created entity and raises on error.

```python
result = client.Template().create({
})
```

Declares a `application/x-www-form-urlencoded` body, which this SDK does not encode yet: it sends the data as JSON.

#### `list(reqmatch=None, ctrl=None) -> list[TemplateEntity]`

List entities matching the given criteria. The match is optional — call `list()` with no argument to list all records. Returns a list of entities, one per record, and raises on error.

```python
results = client.Template().list()
for template in results:
    print(template.data_get())
```

#### `load(reqmatch, ctrl=None) -> TemplateEntity`

Load a single entity matching the given criteria. Returns the entity, whose record `data_get()` reads, and raises on error.

```python
result = client.Template().load({"id": "template_id"})
```

#### `update(reqdata, ctrl=None) -> TemplateEntity`

Update an existing entity. The data must include the entity `id`. Returns the updated entity and raises on error.

```python
result = client.Template().update({
    "id": "template_id",
    # Fields to update
})
```

Declares a `application/x-www-form-urlencoded` body, which this SDK does not encode yet: it sends the data as JSON.

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `TemplateEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## UserRcsSenderCollectionEntity

```python
user_rcs_sender_collection = client.UserRcsSenderCollection()
```

### Operations

#### `list(reqmatch=None, ctrl=None) -> list[UserRcsSenderCollectionEntity]`

List entities matching the given criteria. The match is optional — call `list()` with no argument to list all records. Returns a list of entities, one per record, and raises on error.

```python
results = client.UserRcsSenderCollection().list()
for user_rcs_sender_collection in results:
    print(user_rcs_sender_collection.data_get())
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `UserRcsSenderCollectionEntity` instance with the same options.

#### `get_name() -> str`

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

```python
client = SmsapiSDK({
    "feature": {
        "audit": {"active": True},
        "cache": {"active": True},
        "clienttrack": {"active": True},
        "cost": {"active": True},
        "debug": {"active": True},
        "idempotency": {"active": True},
        "log": {"active": True},
        "metrics": {"active": True},
        "netsim": {"active": True},
        "paging": {"active": True},
        "proxy": {"active": True},
        "ratelimit": {"active": True},
        "rbac": {"active": True},
        "retry": {"active": True},
        "secrets": {"active": True},
        "streaming": {"active": True},
        "telemetry": {"active": True},
        "test": {"active": True},
        "timeout": {"active": True},
        "validate": {"active": True},
    },
})
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

