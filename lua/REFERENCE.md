# Smsapi Lua SDK Reference

Complete API reference for the Smsapi Lua SDK.


## SmsapiSDK

### Constructor

```lua
local sdk = require("smsapi_sdk")
local client = sdk.new(options)
```

Create a new SDK client instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `options` | `table` | SDK configuration options. |
| `options.apikey` | `string` | API key for authentication. |
| `options.base` | `string` | Base URL for API requests. |
| `options.prefix` | `string` | URL prefix appended after base. |
| `options.suffix` | `string` | URL suffix appended after path. |
| `options.headers` | `table` | Custom headers for all requests. |
| `options.feature` | `table` | Feature configuration. |
| `options.system` | `table` | System overrides (e.g. custom fetch). |


### Static Methods

#### `sdk.test(testopts?, sdkopts?)`

Create a test client with mock features active. Both arguments are optional.

```lua
local client = sdk.test()
```


### Instance Methods

#### `Available(data)`

Create a new `Available` entity instance. Pass `nil` for no initial data.

#### `Blacklist(data)`

Create a new `Blacklist` entity instance. Pass `nil` for no initial data.

#### `Callback(data)`

Create a new `Callback` entity instance. Pass `nil` for no initial data.

#### `Contact(data)`

Create a new `Contact` entity instance. Pass `nil` for no initial data.

#### `ContactsField(data)`

Create a new `ContactsField` entity instance. Pass `nil` for no initial data.

#### `ContactsFieldOption(data)`

Create a new `ContactsFieldOption` entity instance. Pass `nil` for no initial data.

#### `Contactsgroup(data)`

Create a new `Contactsgroup` entity instance. Pass `nil` for no initial data.

#### `Contactstrash(data)`

Create a new `Contactstrash` entity instance. Pass `nil` for no initial data.

#### `FieldAvailable(data)`

Create a new `FieldAvailable` entity instance. Pass `nil` for no initial data.

#### `Group(data)`

Create a new `Group` entity instance. Pass `nil` for no initial data.

#### `MfaCode(data)`

Create a new `MfaCode` entity instance. Pass `nil` for no initial data.

#### `OptOut(data)`

Create a new `OptOut` entity instance. Pass `nil` for no initial data.

#### `OptOutSetting(data)`

Create a new `OptOutSetting` entity instance. Pass `nil` for no initial data.

#### `Permission(data)`

Create a new `Permission` entity instance. Pass `nil` for no initial data.

#### `Ping(data)`

Create a new `Ping` entity instance. Pass `nil` for no initial data.

#### `Profile(data)`

Create a new `Profile` entity instance. Pass `nil` for no initial data.

#### `Rcs(data)`

Create a new `Rcs` entity instance. Pass `nil` for no initial data.

#### `Sendername(data)`

Create a new `Sendername` entity instance. Pass `nil` for no initial data.

#### `SendernameStatement(data)`

Create a new `SendernameStatement` entity instance. Pass `nil` for no initial data.

#### `SentRcsMessage(data)`

Create a new `SentRcsMessage` entity instance. Pass `nil` for no initial data.

#### `ShipmentCountryVolume(data)`

Create a new `ShipmentCountryVolume` entity instance. Pass `nil` for no initial data.

#### `ShortUrl(data)`

Create a new `ShortUrl` entity instance. Pass `nil` for no initial data.

#### `Smsdo(data)`

Create a new `Smsdo` entity instance. Pass `nil` for no initial data.

#### `Smssendername(data)`

Create a new `Smssendername` entity instance. Pass `nil` for no initial data.

#### `Smstemplate(data)`

Create a new `Smstemplate` entity instance. Pass `nil` for no initial data.

#### `Subuser(data)`

Create a new `Subuser` entity instance. Pass `nil` for no initial data.

#### `Template(data)`

Create a new `Template` entity instance. Pass `nil` for no initial data.

#### `UserRcsSenderCollection(data)`

Create a new `UserRcsSenderCollection` entity instance. Pass `nil` for no initial data.

#### `options_map() -> table`

Return a deep copy of the current SDK options.

#### `get_utility() -> Utility`

Return a copy of the SDK utility object.

#### `direct(fetchargs) -> table, err`

Make a direct HTTP request to any API endpoint.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `fetchargs.path` | `string` | URL path with optional `{param}` placeholders. |
| `fetchargs.method` | `string` | HTTP method (default: `"GET"`). |
| `fetchargs.params` | `table` | Path parameter values for `{param}` substitution. |
| `fetchargs.query` | `table` | Query string parameters. |
| `fetchargs.headers` | `table` | Request headers (merged with defaults). |
| `fetchargs.body` | `any` | Request body (tables are JSON-serialized). |
| `fetchargs.ctrl` | `table` | Control options (e.g. `{ explain = true }`). |

**Returns:** `table, err`

#### `prepare(fetchargs) -> table, err`

Prepare a fetch definition without sending the request. Accepts the
same parameters as `direct()`.

**Returns:** `table, err`


---

## AvailableEntity

```lua
local available = client:Available(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `name` | `string` | No |  |
| `normalize` | `boolean` | No |  |
| `template` | `string` | No |  |

### Operations

#### `list(reqmatch, ctrl) -> any, err`

List entities matching the given criteria. Returns an array.

```lua
local results, err = client:Available():list()
```

### Common Methods

#### `data_get() -> table`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> table`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `AvailableEntity` instance with the same client and
options.

#### `get_name() -> string`

Return the entity name.


---

## BlacklistEntity

```lua
local blacklist = client:Blacklist(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | `string` | No |  |

### Operations

#### `create(reqdata, ctrl) -> any, err`

Create a new entity with the given data.

```lua
local result, err = client:Blacklist():create({
})
```

#### `load(reqmatch, ctrl) -> any, err`

Load a single entity matching the given criteria.

```lua
local result, err = client:Blacklist():load()
```

#### `remove(reqmatch, ctrl) -> any, err`

Remove the entity matching the given criteria.

```lua
local result, err = client:Blacklist():remove({ id = "id" })
```

### Common Methods

#### `data_get() -> table`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> table`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `BlacklistEntity` instance with the same client and
options.

#### `get_name() -> string`

Return the entity name.


---

## CallbackEntity

```lua
local callback = client:Callback(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `active` | `boolean` | No |  |
| `api_version` | `number` | No | Version of the callback output format. |
| `id` | `string` | No | Object ID |
| `invalid` | `boolean` | No |  |
| `receiver` | `table` | No |  |
| `receiver_type` | `string` | No |  |
| `type` | `string` | No |  |
| `url` | `string` | No | WHATWG URL compliant |

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

#### `create(reqdata, ctrl) -> any, err`

Create a new entity with the given data.

```lua
local result, err = client:Callback():create({
})
```

#### `list(reqmatch, ctrl) -> any, err`

List entities matching the given criteria. Returns an array.

```lua
local results, err = client:Callback():list()
```

#### `load(reqmatch, ctrl) -> any, err`

Load a single entity matching the given criteria.

```lua
local result, err = client:Callback():load({ id = "callback_id" })
```

#### `remove(reqmatch, ctrl) -> any, err`

Remove the entity matching the given criteria.

```lua
local result, err = client:Callback():remove({ id = "callback_id" })
```

#### `update(reqdata, ctrl) -> any, err`

Update an existing entity. The data must include the entity `id`.

```lua
local result, err = client:Callback():update({
  id = "callback_id",
  -- Fields to update
})
```

### Common Methods

#### `data_get() -> table`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> table`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `CallbackEntity` instance with the same client and
options.

#### `get_name() -> string`

Return the entity name.


---

## ContactEntity

```lua
local contact = client:Contact(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `birthday_date` | `string` | No |  |
| `city` | `string` | No |  |
| `collection` | `table` | Yes |  |
| `contact_expire_after` | `number` | Yes | Contact expire after days |
| `contacts_count` | `number` | Yes |  |
| `country` | `string` | No |  |
| `created_by` | `string` | Yes |  |
| `date_created` | `string` | Yes |  |
| `date_updated` | `string` | Yes |  |
| `description` | `string` | No |  |
| `email` | `string` | No |  |
| `first_name` | `string` | No |  |
| `gender` | `string` | Yes |  |
| `group_id` | `string` | No | Object ID |
| `groups` | `table` | Yes |  |
| `id` | `string` | Yes | Object ID |
| `idx` | `string` | No | User provided resource id |
| `last_name` | `string` | No |  |
| `name` | `string` | Yes | Group name |
| `permissions` | `table` | No |  |
| `phone_number` | `string` | No |  |
| `read` | `boolean` | No | Has read permission |
| `send` | `boolean` | No | Has send permission |
| `size` | `number` | Yes |  |
| `source` | `string` | No |  |
| `type` | `string` | No |  |
| `username` | `string` | No |  |
| `value` | `string` | No |  |
| `write` | `boolean` | No | Has write permission |

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

#### `create(reqdata, ctrl) -> any, err`

Create a new entity with the given data.

```lua
local result, err = client:Contact():create({
  collection = --[[ table ]],
  contact_expire_after = --[[ number ]],
  contacts_count = --[[ number ]],
  created_by = --[[ string ]],
  date_created = --[[ string ]],
  date_updated = --[[ string ]],
  gender = --[[ string ]],
  groups = --[[ table ]],
  id = --[[ string ]],
  name = --[[ string ]],
  size = --[[ number ]],
})
```

#### `list(reqmatch, ctrl) -> any, err`

List entities matching the given criteria. Returns an array.

```lua
local results, err = client:Contact():list()
```

#### `load(reqmatch, ctrl) -> any, err`

Load a single entity matching the given criteria.

```lua
local result, err = client:Contact():load({ id = "contact_id" })
```

#### `remove(reqmatch, ctrl) -> any, err`

Remove the entity matching the given criteria.

```lua
local result, err = client:Contact():remove({ id = "contact_id" })
```

#### `update(reqdata, ctrl) -> any, err`

Update an existing entity. The data must include the entity `id`.

```lua
local result, err = client:Contact():update({
  id = "contact_id",
  -- Fields to update
})
```

### Common Methods

#### `data_get() -> table`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> table`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `ContactEntity` instance with the same client and
options.

#### `get_name() -> string`

Return the entity name.


---

## ContactsFieldEntity

```lua
local contacts_field = client:ContactsField(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `birthday_date` | `string` | No |  |
| `city` | `string` | No |  |
| `contact_expire_after` | `number` | Yes | Contact expire after days |
| `contacts_count` | `number` | No |  |
| `country` | `string` | No |  |
| `created_by` | `string` | Yes |  |
| `date_created` | `string` | Yes |  |
| `date_updated` | `string` | Yes |  |
| `description` | `string` | No |  |
| `email` | `string` | No |  |
| `first_name` | `string` | No |  |
| `gender` | `string` | Yes |  |
| `group_id` | `string` | No | Object ID |
| `groups` | `table` | Yes |  |
| `id` | `string` | No | Object ID |
| `idx` | `string` | No | User provided resource id |
| `last_name` | `string` | No |  |
| `name` | `string` | No | Group name |
| `permissions` | `table` | No |  |
| `phone_number` | `string` | No |  |
| `read` | `boolean` | No | Has read permission |
| `send` | `boolean` | No | Has send permission |
| `source` | `string` | No |  |
| `type` | `string` | No |  |
| `username` | `string` | No |  |
| `value` | `string` | No |  |
| `write` | `boolean` | No | Has write permission |

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

#### `create(reqdata, ctrl) -> any, err`

Create a new entity with the given data.

```lua
local result, err = client:ContactsField():create({
  contact_expire_after = --[[ number ]],
  created_by = --[[ string ]],
  date_created = --[[ string ]],
  date_updated = --[[ string ]],
  gender = --[[ string ]],
  groups = --[[ table ]],
})
```

#### `list(reqmatch, ctrl) -> any, err`

List entities matching the given criteria. Returns an array.

```lua
local results, err = client:ContactsField():list()
```

#### `remove(reqmatch, ctrl) -> any, err`

Remove the entity matching the given criteria.

```lua
local result, err = client:ContactsField():remove({ id = "id" })
```

#### `update(reqdata, ctrl) -> any, err`

Update an existing entity. The data must include the entity `id`.

```lua
local result, err = client:ContactsField():update({
  id = "id",
  -- Fields to update
})
```

### Common Methods

#### `data_get() -> table`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> table`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `ContactsFieldEntity` instance with the same client and
options.

#### `get_name() -> string`

Return the entity name.


---

## ContactsFieldOptionEntity

```lua
local contacts_field_option = client:ContactsFieldOption(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `birthday_date` | `string` | No |  |
| `city` | `string` | No |  |
| `contact_expire_after` | `number` | Yes | Contact expire after days |
| `contacts_count` | `number` | No |  |
| `country` | `string` | No |  |
| `created_by` | `string` | Yes |  |
| `date_created` | `string` | Yes |  |
| `date_updated` | `string` | Yes |  |
| `description` | `string` | No |  |
| `email` | `string` | No |  |
| `first_name` | `string` | No |  |
| `gender` | `string` | Yes |  |
| `group_id` | `string` | No | Object ID |
| `groups` | `table` | Yes |  |
| `id` | `string` | Yes | Object ID |
| `idx` | `string` | No | User provided resource id |
| `last_name` | `string` | No |  |
| `name` | `string` | No | Group name |
| `permissions` | `table` | No |  |
| `phone_number` | `string` | No |  |
| `read` | `boolean` | No | Has read permission |
| `send` | `boolean` | No | Has send permission |
| `source` | `string` | No |  |
| `type` | `string` | No |  |
| `username` | `string` | No |  |
| `value` | `string` | No |  |
| `write` | `boolean` | No | Has write permission |

### Operations

#### `list(reqmatch, ctrl) -> any, err`

List entities matching the given criteria. Returns an array.

```lua
local results, err = client:ContactsFieldOption():list()
```

### Common Methods

#### `data_get() -> table`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> table`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `ContactsFieldOptionEntity` instance with the same client and
options.

#### `get_name() -> string`

Return the entity name.


---

## ContactsgroupEntity

```lua
local contactsgroup = client:Contactsgroup(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `birthday_date` | `string` | No |  |
| `city` | `string` | No |  |
| `contact_expire_after` | `number` | Yes | Contact expire after days |
| `contacts_count` | `number` | No |  |
| `country` | `string` | No |  |
| `created_by` | `string` | Yes |  |
| `date_created` | `string` | Yes |  |
| `date_updated` | `string` | Yes |  |
| `description` | `string` | No |  |
| `email` | `string` | No |  |
| `first_name` | `string` | No |  |
| `gender` | `string` | Yes |  |
| `group_id` | `string` | Yes | Object ID |
| `groups` | `table` | Yes |  |
| `id` | `string` | Yes | Object ID |
| `idx` | `string` | No | User provided resource id |
| `last_name` | `string` | No |  |
| `name` | `string` | No | Group name |
| `permissions` | `table` | No |  |
| `phone_number` | `string` | No |  |
| `read` | `boolean` | Yes | Has read permission |
| `send` | `boolean` | Yes | Has send permission |
| `source` | `string` | No |  |
| `type` | `string` | No |  |
| `username` | `string` | Yes |  |
| `value` | `string` | No |  |
| `write` | `boolean` | Yes | Has write permission |

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

#### `create(reqdata, ctrl) -> any, err`

Create a new entity with the given data.

```lua
local result, err = client:Contactsgroup():create({
  contact_expire_after = --[[ number ]],
  created_by = --[[ string ]],
  date_created = --[[ string ]],
  date_updated = --[[ string ]],
  gender = --[[ string ]],
  group_id = --[[ string ]],
  groups = --[[ table ]],
  id = --[[ string ]],
  read = --[[ boolean ]],
  send = --[[ boolean ]],
  username = --[[ string ]],
  write = --[[ boolean ]],
})
```

#### `list(reqmatch, ctrl) -> any, err`

List entities matching the given criteria. Returns an array.

```lua
local results, err = client:Contactsgroup():list()
```

#### `remove(reqmatch, ctrl) -> any, err`

Remove the entity matching the given criteria.

```lua
local result, err = client:Contactsgroup():remove({ group_id = "group_id" })
```

#### `update(reqdata, ctrl) -> any, err`

Update an existing entity. The data must include the entity `id`.

```lua
local result, err = client:Contactsgroup():update({
  group_id = "group_id",
  -- Fields to update
})
```

### Common Methods

#### `data_get() -> table`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> table`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `ContactsgroupEntity` instance with the same client and
options.

#### `get_name() -> string`

Return the entity name.


---

## ContactstrashEntity

```lua
local contactstrash = client:Contactstrash(nil)
```

### Operations

#### `remove(reqmatch, ctrl) -> any, err`

Remove the entity matching the given criteria.

```lua
local result, err = client:Contactstrash():remove()
```

#### `update(reqdata, ctrl) -> any, err`

Update an existing entity. The data must include the entity `id`.

```lua
local result, err = client:Contactstrash():update({
  -- Fields to update
})
```

### Common Methods

#### `data_get() -> table`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> table`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `ContactstrashEntity` instance with the same client and
options.

#### `get_name() -> string`

Return the entity name.


---

## FieldAvailableEntity

```lua
local field_available = client:FieldAvailable(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `built_in` | `boolean` | No |  |
| `id` | `string` | No | Object ID |
| `name` | `string` | No |  |
| `options` | `table` | No |  |
| `type` | `string` | No |  |

### Operations

#### `list(reqmatch, ctrl) -> any, err`

List entities matching the given criteria. Returns an array.

```lua
local results, err = client:FieldAvailable():list()
```

### Common Methods

#### `data_get() -> table`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> table`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `FieldAvailableEntity` instance with the same client and
options.

#### `get_name() -> string`

Return the entity name.


---

## GroupEntity

```lua
local group = client:Group(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `contact_expire_after` | `number` | Yes | Contact expire after days |
| `contacts_count` | `number` | Yes |  |
| `created_by` | `string` | Yes |  |
| `date_created` | `string` | Yes |  |
| `date_updated` | `string` | Yes |  |
| `description` | `string` | Yes |  |
| `id` | `string` | Yes | Object ID |
| `idx` | `string` | No | User provided resource id |
| `name` | `string` | Yes | Group name |
| `permissions` | `table` | No |  |

### Operations

#### `load(reqmatch, ctrl) -> any, err`

Load a single entity matching the given criteria.

```lua
local result, err = client:Group():load({ id = "group_id" })
```

#### `update(reqdata, ctrl) -> any, err`

Update an existing entity. The data must include the entity `id`.

```lua
local result, err = client:Group():update({
  id = "group_id",
  -- Fields to update
})
```

### Common Methods

#### `data_get() -> table`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> table`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `GroupEntity` instance with the same client and
options.

#### `get_name() -> string`

Return the entity name.


---

## MfaCodeEntity

```lua
local mfa_code = client:MfaCode(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `content` | `string` | No | Custom content that must contain placeholder [%code%] |
| `fast` | `any` | No |  |
| `from` | `string` | No | Sendername |
| `phone_number` | `string` | Yes |  |

### Operations

#### `create(reqdata, ctrl) -> any, err`

Create a new entity with the given data.

```lua
local result, err = client:MfaCode():create({
  phone_number = --[[ string ]],
})
```

### Common Methods

#### `data_get() -> table`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> table`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `MfaCodeEntity` instance with the same client and
options.

#### `get_name() -> string`

Return the entity name.


---

## OptOutEntity

```lua
local opt_out = client:OptOut(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `date` | `string` | No |  |
| `id` | `string` | No |  |
| `links` | `table` | No |  |
| `phoneNumber` | `number` | No |  |

### Operations

#### `list(reqmatch, ctrl) -> any, err`

List entities matching the given criteria. Returns an array.

```lua
local results, err = client:OptOut():list()
```

#### `remove(reqmatch, ctrl) -> any, err`

Remove the entity matching the given criteria.

```lua
local result, err = client:OptOut():remove({ id = "id" })
```

### Common Methods

#### `data_get() -> table`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> table`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `OptOutEntity` instance with the same client and
options.

#### `get_name() -> string`

Return the entity name.


---

## OptOutSettingEntity

```lua
local opt_out_setting = client:OptOutSetting(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `brand` | `string` | No |  |

### Operations

#### `load(reqmatch, ctrl) -> any, err`

Load a single entity matching the given criteria.

```lua
local result, err = client:OptOutSetting():load()
```

#### `update(reqdata, ctrl) -> any, err`

Update an existing entity. The data must include the entity `id`.

```lua
local result, err = client:OptOutSetting():update({
  -- Fields to update
})
```

### Common Methods

#### `data_get() -> table`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> table`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `OptOutSettingEntity` instance with the same client and
options.

#### `get_name() -> string`

Return the entity name.


---

## PermissionEntity

```lua
local permission = client:Permission(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `group_id` | `string` | Yes | Object ID |
| `id` | `string` | No |  |
| `read` | `boolean` | Yes | Has read permission |
| `send` | `boolean` | Yes | Has send permission |
| `username` | `string` | Yes |  |
| `write` | `boolean` | Yes | Has write permission |

### Operations

#### `create(reqdata, ctrl) -> any, err`

Create a new entity with the given data.

```lua
local result, err = client:Permission():create({
  group_id = --[[ string ]],
  read = --[[ boolean ]],
  send = --[[ boolean ]],
  username = --[[ string ]],
  write = --[[ boolean ]],
})
```

#### `load(reqmatch, ctrl) -> any, err`

Load a single entity matching the given criteria.

```lua
local result, err = client:Permission():load({ id = "permission_id", group_id = "group_id", username = "username" })
```

### Common Methods

#### `data_get() -> table`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> table`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `PermissionEntity` instance with the same client and
options.

#### `get_name() -> string`

Return the entity name.


---

## PingEntity

```lua
local ping = client:Ping(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `authorized` | `boolean` | Yes |  |
| `unavailable` | `table` | Yes |  |

### Operations

#### `list(reqmatch, ctrl) -> any, err`

List entities matching the given criteria. Returns an array.

```lua
local results, err = client:Ping():list()
```

### Common Methods

#### `data_get() -> table`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> table`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `PingEntity` instance with the same client and
options.

#### `get_name() -> string`

Return the entity name.


---

## ProfileEntity

```lua
local profile = client:Profile(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `email` | `string` | Yes |  |
| `name` | `string` | Yes |  |
| `payment_type` | `string` | Yes |  |
| `phone_number` | `number` | Yes |  |
| `points` | `number` | No |  |
| `user_type` | `string` | Yes |  |
| `username` | `string` | Yes |  |

### Operations

#### `list(reqmatch, ctrl) -> any, err`

List entities matching the given criteria. Returns an array.

```lua
local results, err = client:Profile():list()
```

#### `load(reqmatch, ctrl) -> any, err`

Load a single entity matching the given criteria.

```lua
local result, err = client:Profile():load()
```

### Common Methods

#### `data_get() -> table`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> table`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `ProfileEntity` instance with the same client and
options.

#### `get_name() -> string`

Return the entity name.


---

## RcsEntity

```lua
local rcs = client:Rcs(nil)
```

### Operations

#### `list(reqmatch, ctrl) -> any, err`

List entities matching the given criteria. Returns an array.

```lua
local results, err = client:Rcs():list()
```

### Common Methods

#### `data_get() -> table`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> table`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `RcsEntity` instance with the same client and
options.

#### `get_name() -> string`

Return the entity name.


---

## SendernameEntity

```lua
local sendername = client:Sendername(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `created_at` | `string` | No |  |
| `id` | `string` | No |  |
| `is_default` | `boolean` | No |  |
| `sender` | `string` | No | Sendername |
| `status` | `string` | No |  |

### Operations

#### `create(reqdata, ctrl) -> any, err`

Create a new entity with the given data.

```lua
local result, err = client:Sendername():create({
})
```

#### `list(reqmatch, ctrl) -> any, err`

List entities matching the given criteria. Returns an array.

```lua
local results, err = client:Sendername():list()
```

#### `load(reqmatch, ctrl) -> any, err`

Load a single entity matching the given criteria.

```lua
local result, err = client:Sendername():load({ id = "sendername_id" })
```

### Common Methods

#### `data_get() -> table`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> table`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `SendernameEntity` instance with the same client and
options.

#### `get_name() -> string`

Return the entity name.


---

## SendernameStatementEntity

```lua
local sendername_statement = client:SendernameStatement(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `content` | `string` | No |  |
| `statements` | `table` | No |  |
| `title` | `string` | No |  |

### Operations

#### `list(reqmatch, ctrl) -> any, err`

List entities matching the given criteria. Returns an array.

```lua
local results, err = client:SendernameStatement():list()
```

### Common Methods

#### `data_get() -> table`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> table`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `SendernameStatementEntity` instance with the same client and
options.

#### `get_name() -> string`

Return the entity name.


---

## SentRcsMessageEntity

```lua
local sent_rcs_message = client:SentRcsMessage(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `content` | `table` | No | RCS message content in RCS JSON format. |
| `phone_number` | `string` | Yes | Recipient phone number (e.g. |
| `sender` | `any` | Yes |  |
| `text` | `string` | No | Plain text message content. |

### Operations

#### `create(reqdata, ctrl) -> any, err`

Create a new entity with the given data.

```lua
local result, err = client:SentRcsMessage():create({
  phone_number = --[[ string ]],
  sender = --[[ any ]],
})
```

### Common Methods

#### `data_get() -> table`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> table`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `SentRcsMessageEntity` instance with the same client and
options.

#### `get_name() -> string`

Return the entity name.


---

## ShipmentCountryVolumeEntity

```lua
local shipment_country_volume = client:ShipmentCountryVolume(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `country_code` | `string` | No |  |
| `country_limit` | `number` | No |  |
| `country_name` | `string` | No |  |
| `usage` | `number` | No |  |

### Operations

#### `list(reqmatch, ctrl) -> any, err`

List entities matching the given criteria. Returns an array.

```lua
local results, err = client:ShipmentCountryVolume():list()
```

### Common Methods

#### `data_get() -> table`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> table`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `ShipmentCountryVolumeEntity` instance with the same client and
options.

#### `get_name() -> string`

Return the entity name.


---

## ShortUrlEntity

```lua
local short_url = client:ShortUrl(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `description` | `string` | No |  |
| `expire` | `string` | No |  |
| `filename` | `string` | No |  |
| `hits` | `number` | No |  |
| `hits_unique` | `number` | No |  |
| `id` | `string` | No |  |
| `name` | `string` | No |  |
| `short_url` | `string` | No | WHATWG URL compliant |
| `type` | `string` | No |  |
| `url` | `string` | No | WHATWG URL compliant |

### Operations

#### `create(reqdata, ctrl) -> any, err`

Create a new entity with the given data.

```lua
local result, err = client:ShortUrl():create({
})
```

#### `list(reqmatch, ctrl) -> any, err`

List entities matching the given criteria. Returns an array.

```lua
local results, err = client:ShortUrl():list()
```

#### `load(reqmatch, ctrl) -> any, err`

Load a single entity matching the given criteria.

```lua
local result, err = client:ShortUrl():load({ id = "short_url_id" })
```

#### `remove(reqmatch, ctrl) -> any, err`

Remove the entity matching the given criteria.

```lua
local result, err = client:ShortUrl():remove({ id = "short_url_id" })
```

#### `update(reqdata, ctrl) -> any, err`

Update an existing entity. The data must include the entity `id`.

```lua
local result, err = client:ShortUrl():update({
  id = "short_url_id",
  -- Fields to update
})
```

### Common Methods

#### `data_get() -> table`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> table`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `ShortUrlEntity` instance with the same client and
options.

#### `get_name() -> string`

Return the entity name.


---

## SmsdoEntity

```lua
local smsdo = client:Smsdo(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `allow_duplicates` | `number` | No | When parameter allow_duplicates is set to "1" allows to send message to duplicated numbers in one request (useful i.e. |
| `check_idx` | `any` | No | When parameter check_idx is set to „1” prevents from sending more than one message with the same idx in last 24h. |
| `date` | `any` | No | Date in UNIX timestamp (&date=1287734110) or in ISO 8601 (&date=2012-05-10T08:40:27+00:00) when message will be sent (&date=1287734110). |
| `date_validate` | `number` | No | When parameter date_validate is set to "1" checks if date if given in proper format. |
| `details` | `any` | No | When details parameter is set to "1" more details in response will be displayed (message length and sms count). |
| `encoding` | `string` | No | This parameter describes the encoding of the message text. |
| `expiration_date` | `any` | No | Message expiration date (in UNIX timestamp or in ISO 8601) is a date after which message won't be delivered if it wasn't delivered yet. |
| `fallback` | `table` | No | Enable fallback in case sms sending fails |
| `fast` | `number` | No | Setting this parameter to „1” will result in sending message with the highest priority which ensures the quickest possible time of delivery. |
| `flash` | `number` | No | Sending a message in flash mode can be activated by setting this parameter to "1". |
| `format` | `string` | No | Parameter &format=json causes, that response is sending in JSON format. |
| `from` | `string` | No | Name of the sender. |
| `group` | `string` | No | Name of the group from the contacts database to which message should be sent to. |
| `idx` | `string` | No | Optional custom value sent with SMS and sent back in CALLBACK. |
| `max_parts` | `number` | No | Defines maximum message parts allowed, maximum value allowed is 6. |
| `message` | `string` | No | The message text. |
| `normalize` | `number` | No | When parameter normalize is set to „1” special chars in message will be replaced with their equivalents (ê-e, ñ-n, ý-y ...). |
| `notify_url` | `string` | No | Parameter allows to set CALLBACK URL for message from request. |
| `test` | `any` | No | When parameter test is set to "1" message won't be sent but response will be displayed, there is no charge for such test messages. |
| `time_restriction` | `string` | No | Sets the behavior when you try to ship in hours / dates that do not match the settings in your account. |
| `to` | `string` | No | Recipients' mobile phone numbers (i.e. |

### Operations

#### `create(reqdata, ctrl) -> any, err`

Create a new entity with the given data.

```lua
local result, err = client:Smsdo():create({
})
```

### Common Methods

#### `data_get() -> table`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> table`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `SmsdoEntity` instance with the same client and
options.

#### `get_name() -> string`

Return the entity name.


---

## SmssendernameEntity

```lua
local smssendername = client:Smssendername(nil)
```

### Operations

#### `create(reqdata, ctrl) -> any, err`

Create a new entity with the given data.

```lua
local result, err = client:Smssendername():create({
  sendername_id = --[[ string ]],
})
```

#### `remove(reqmatch, ctrl) -> any, err`

Remove the entity matching the given criteria.

```lua
local result, err = client:Smssendername():remove({ sender = "sender" })
```

### Common Methods

#### `data_get() -> table`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> table`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `SmssendernameEntity` instance with the same client and
options.

#### `get_name() -> string`

Return the entity name.


---

## SmstemplateEntity

```lua
local smstemplate = client:Smstemplate(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | `string` | No |  |

### Operations

#### `remove(reqmatch, ctrl) -> any, err`

Remove the entity matching the given criteria.

```lua
local result, err = client:Smstemplate():remove({ id = "id" })
```

### Common Methods

#### `data_get() -> table`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> table`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `SmstemplateEntity` instance with the same client and
options.

#### `get_name() -> string`

Return the entity name.


---

## SubuserEntity

```lua
local subuser = client:Subuser(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `active` | `boolean` | No |  |
| `credentials` | `table` | Yes |  |
| `description` | `string` | No |  |
| `id` | `string` | No | Object ID |
| `points` | `table` | No |  |
| `username` | `string` | No |  |

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

#### `create(reqdata, ctrl) -> any, err`

Create a new entity with the given data.

```lua
local result, err = client:Subuser():create({
  credentials = --[[ table ]],
})
```

#### `list(reqmatch, ctrl) -> any, err`

List entities matching the given criteria. Returns an array.

```lua
local results, err = client:Subuser():list()
```

#### `load(reqmatch, ctrl) -> any, err`

Load a single entity matching the given criteria.

```lua
local result, err = client:Subuser():load({ id = "subuser_id" })
```

#### `remove(reqmatch, ctrl) -> any, err`

Remove the entity matching the given criteria.

```lua
local result, err = client:Subuser():remove({ id = "subuser_id" })
```

#### `update(reqdata, ctrl) -> any, err`

Update an existing entity. The data must include the entity `id`.

```lua
local result, err = client:Subuser():update({
  id = "subuser_id",
  -- Fields to update
})
```

### Common Methods

#### `data_get() -> table`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> table`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `SubuserEntity` instance with the same client and
options.

#### `get_name() -> string`

Return the entity name.


---

## TemplateEntity

```lua
local template = client:Template(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | `string` | No |  |
| `name` | `string` | No |  |
| `normalize` | `boolean` | No |  |
| `template` | `string` | No |  |

### Operations

#### `create(reqdata, ctrl) -> any, err`

Create a new entity with the given data.

```lua
local result, err = client:Template():create({
})
```

#### `list(reqmatch, ctrl) -> any, err`

List entities matching the given criteria. Returns an array.

```lua
local results, err = client:Template():list()
```

#### `load(reqmatch, ctrl) -> any, err`

Load a single entity matching the given criteria.

```lua
local result, err = client:Template():load({ id = "template_id" })
```

#### `update(reqdata, ctrl) -> any, err`

Update an existing entity. The data must include the entity `id`.

```lua
local result, err = client:Template():update({
  id = "template_id",
  -- Fields to update
})
```

### Common Methods

#### `data_get() -> table`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> table`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `TemplateEntity` instance with the same client and
options.

#### `get_name() -> string`

Return the entity name.


---

## UserRcsSenderCollectionEntity

```lua
local user_rcs_sender_collection = client:UserRcsSenderCollection(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `deliveredAt` | `string` | No |  |
| `expiredAt` | `string` | No |  |
| `id` | `string` | No | Object ID |
| `interface` | `string` | No | Interface through which the message was sent (www, api, ...). |
| `messageType` | `string` | No | RCS message type (basic, single, ...). |
| `readAt` | `string` | No |  |
| `recipient` | `string` | No | Recipient phone number (without +). |
| `sender` | `string` | No | Sender name |
| `senderId` | `string` | No | Sender id |
| `sentAt` | `string` | No |  |

### Operations

#### `list(reqmatch, ctrl) -> any, err`

List entities matching the given criteria. Returns an array.

```lua
local results, err = client:UserRcsSenderCollection():list()
```

### Common Methods

#### `data_get() -> table`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> table`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `UserRcsSenderCollectionEntity` instance with the same client and
options.

#### `get_name() -> string`

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

```lua
local client = sdk.new({
  feature = {
    audit = { active = true },
    cache = { active = true },
    clienttrack = { active = true },
    cost = { active = true },
    debug = { active = true },
    idempotency = { active = true },
    log = { active = true },
    metrics = { active = true },
    netsim = { active = true },
    paging = { active = true },
    proxy = { active = true },
    ratelimit = { active = true },
    rbac = { active = true },
    retry = { active = true },
    secrets = { active = true },
    streaming = { active = true },
    telemetry = { active = true },
    test = { active = true },
    timeout = { active = true },
    validate = { active = true },
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

