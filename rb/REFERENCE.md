# Smsapi Ruby SDK Reference

Complete API reference for the Smsapi Ruby SDK.


## SmsapiSDK

### Constructor

```ruby
require_relative 'Smsapi_sdk'

client = SmsapiSDK.new(options)
```

Create a new SDK client instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `options` | `Hash` | SDK configuration options. |
| `options["apikey"]` | `String` | API key for authentication. |
| `options["base"]` | `String` | Base URL for API requests. |
| `options["prefix"]` | `String` | URL prefix appended after base. |
| `options["suffix"]` | `String` | URL suffix appended after path. |
| `options["headers"]` | `Hash` | Custom headers for all requests. |
| `options["feature"]` | `Hash` | Feature configuration. |
| `options["system"]` | `Hash` | System overrides (e.g. custom fetch). |


### Static Methods

#### `SmsapiSDK.test(testopts = nil, sdkopts = nil)`

Create a test client with mock features active. Both arguments may be `nil`.

```ruby
client = SmsapiSDK.test
```


### Instance Methods

#### `Available(data = nil)`

Create a new `Available` entity instance. Pass `nil` for no initial data.

#### `Blacklist(data = nil)`

Create a new `Blacklist` entity instance. Pass `nil` for no initial data.

#### `Callback(data = nil)`

Create a new `Callback` entity instance. Pass `nil` for no initial data.

#### `Contact(data = nil)`

Create a new `Contact` entity instance. Pass `nil` for no initial data.

#### `ContactsField(data = nil)`

Create a new `ContactsField` entity instance. Pass `nil` for no initial data.

#### `ContactsFieldOption(data = nil)`

Create a new `ContactsFieldOption` entity instance. Pass `nil` for no initial data.

#### `Contactsgroup(data = nil)`

Create a new `Contactsgroup` entity instance. Pass `nil` for no initial data.

#### `Contactstrash(data = nil)`

Create a new `Contactstrash` entity instance. Pass `nil` for no initial data.

#### `FieldAvailable(data = nil)`

Create a new `FieldAvailable` entity instance. Pass `nil` for no initial data.

#### `Group(data = nil)`

Create a new `Group` entity instance. Pass `nil` for no initial data.

#### `MfaCode(data = nil)`

Create a new `MfaCode` entity instance. Pass `nil` for no initial data.

#### `OptOut(data = nil)`

Create a new `OptOut` entity instance. Pass `nil` for no initial data.

#### `OptOutSetting(data = nil)`

Create a new `OptOutSetting` entity instance. Pass `nil` for no initial data.

#### `Permission(data = nil)`

Create a new `Permission` entity instance. Pass `nil` for no initial data.

#### `Ping(data = nil)`

Create a new `Ping` entity instance. Pass `nil` for no initial data.

#### `Profile(data = nil)`

Create a new `Profile` entity instance. Pass `nil` for no initial data.

#### `Rcs(data = nil)`

Create a new `Rcs` entity instance. Pass `nil` for no initial data.

#### `Sendername(data = nil)`

Create a new `Sendername` entity instance. Pass `nil` for no initial data.

#### `SendernameStatement(data = nil)`

Create a new `SendernameStatement` entity instance. Pass `nil` for no initial data.

#### `SentRcsMessage(data = nil)`

Create a new `SentRcsMessage` entity instance. Pass `nil` for no initial data.

#### `ShipmentCountryVolume(data = nil)`

Create a new `ShipmentCountryVolume` entity instance. Pass `nil` for no initial data.

#### `ShortUrl(data = nil)`

Create a new `ShortUrl` entity instance. Pass `nil` for no initial data.

#### `Smsdo(data = nil)`

Create a new `Smsdo` entity instance. Pass `nil` for no initial data.

#### `Smssendername(data = nil)`

Create a new `Smssendername` entity instance. Pass `nil` for no initial data.

#### `Smstemplate(data = nil)`

Create a new `Smstemplate` entity instance. Pass `nil` for no initial data.

#### `Subuser(data = nil)`

Create a new `Subuser` entity instance. Pass `nil` for no initial data.

#### `Template(data = nil)`

Create a new `Template` entity instance. Pass `nil` for no initial data.

#### `UserRcsSenderCollection(data = nil)`

Create a new `UserRcsSenderCollection` entity instance. Pass `nil` for no initial data.

#### `options_map -> Hash`

Return a deep copy of the current SDK options.

#### `get_utility -> Utility`

Return a copy of the SDK utility object.

#### `direct(fetchargs = {}) -> Hash`

Make a direct HTTP request to any API endpoint. Returns a result hash
(`{ "ok" => ..., "status" => ..., "data" => ..., "err" => ... }`); it
does not raise — inspect `result["ok"]`.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `fetchargs["path"]` | `String` | URL path with optional `{param}` placeholders. |
| `fetchargs["method"]` | `String` | HTTP method (default: `"GET"`). |
| `fetchargs["params"]` | `Hash` | Path parameter values for `{param}` substitution. |
| `fetchargs["query"]` | `Hash` | Query string parameters. |
| `fetchargs["headers"]` | `Hash` | Request headers (merged with defaults). |
| `fetchargs["body"]` | `any` | Request body (hashes are JSON-serialized). |
| `fetchargs["ctrl"]` | `Hash` | Control options (e.g. `{ "explain" => true }`). |

**Returns:** `Hash`

#### `prepare(fetchargs = {}) -> Hash`

Prepare a fetch definition without sending the request. Accepts the
same parameters as `direct()`. Raises on error.

**Returns:** `Hash` (the fetch definition; raises on error)


---

## AvailableEntity

```ruby
available = client.Available
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `name` | `String` | No |  |
| `normalize` | `Boolean` | No |  |
| `template` | `String` | No |  |

### Operations

#### `list(reqmatch = nil, ctrl = nil) -> Array`

List entities matching the given criteria (call with no argument to list all). Returns an array. Raises on error.

```ruby
results = client.Available.list
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `AvailableEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## BlacklistEntity

```ruby
blacklist = client.Blacklist
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | `String` | No |  |

### Operations

#### `create(reqdata, ctrl = nil) -> result`

Create a new entity with the given data. Raises on error.

```ruby
result = client.Blacklist.create({
})
```

#### `load(reqmatch, ctrl = nil) -> result`

Load a single entity matching the given criteria. Raises on error.

```ruby
result = client.Blacklist.load()
```

#### `remove(reqmatch, ctrl = nil) -> result`

Remove the entity matching the given criteria. Raises on error.

```ruby
result = client.Blacklist.remove({ "id" => "id" })
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `BlacklistEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## CallbackEntity

```ruby
callback = client.Callback
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `active` | `Boolean` | No |  |
| `api_version` | `Integer` | No | Version of the callback output format. |
| `id` | `String` | No | Object ID |
| `invalid` | `Boolean` | No |  |
| `receiver` | `Hash` | No |  |
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

#### `create(reqdata, ctrl = nil) -> result`

Create a new entity with the given data. Raises on error.

```ruby
result = client.Callback.create({
})
```

#### `list(reqmatch = nil, ctrl = nil) -> Array`

List entities matching the given criteria (call with no argument to list all). Returns an array. Raises on error.

```ruby
results = client.Callback.list
```

#### `load(reqmatch, ctrl = nil) -> result`

Load a single entity matching the given criteria. Raises on error.

```ruby
result = client.Callback.load({ "id" => "callback_id" })
```

#### `remove(reqmatch, ctrl = nil) -> result`

Remove the entity matching the given criteria. Raises on error.

```ruby
result = client.Callback.remove({ "id" => "callback_id" })
```

#### `update(reqdata, ctrl = nil) -> result`

Update an existing entity. The data must include the entity `id`. Raises on error.

```ruby
result = client.Callback.update({
  "id" => "callback_id",
  # Fields to update
})
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `CallbackEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## ContactEntity

```ruby
contact = client.Contact
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `birthday_date` | `String` | No |  |
| `city` | `String` | No |  |
| `collection` | `Array` | Yes |  |
| `contact_expire_after` | `Integer` | Yes | Contact expire after days |
| `contacts_count` | `Integer` | Yes |  |
| `country` | `String` | No |  |
| `created_by` | `String` | Yes |  |
| `date_created` | `String` | Yes |  |
| `date_updated` | `String` | Yes |  |
| `description` | `String` | No |  |
| `email` | `String` | No |  |
| `first_name` | `String` | No |  |
| `gender` | `String` | Yes |  |
| `group_id` | `String` | No | Object ID |
| `groups` | `Array` | Yes |  |
| `id` | `String` | Yes | Object ID |
| `idx` | `String` | No | User provided resource id |
| `last_name` | `String` | No |  |
| `name` | `String` | Yes | Group name |
| `permissions` | `Array` | No |  |
| `phone_number` | `String` | No |  |
| `read` | `Boolean` | No | Has read permission |
| `send` | `Boolean` | No | Has send permission |
| `size` | `Integer` | Yes |  |
| `source` | `String` | No |  |
| `type` | `String` | No |  |
| `username` | `String` | No |  |
| `value` | `String` | No |  |
| `write` | `Boolean` | No | Has write permission |

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

#### `create(reqdata, ctrl = nil) -> result`

Create a new entity with the given data. Raises on error.

```ruby
result = client.Contact.create({
  "collection" => [], # Array
  "contact_expire_after" => 1, # Integer
  "contacts_count" => 1, # Integer
  "created_by" => "example_created_by", # String
  "date_created" => "example_date_created", # String
  "date_updated" => "example_date_updated", # String
  "gender" => "example_gender", # String
  "groups" => [], # Array
  "id" => "example_id", # String
  "name" => "example_name", # String
  "size" => 1, # Integer
})
```

#### `list(reqmatch = nil, ctrl = nil) -> Array`

List entities matching the given criteria (call with no argument to list all). Returns an array. Raises on error.

```ruby
results = client.Contact.list
```

#### `load(reqmatch, ctrl = nil) -> result`

Load a single entity matching the given criteria. Raises on error.

```ruby
result = client.Contact.load({ "id" => "contact_id" })
```

#### `remove(reqmatch, ctrl = nil) -> result`

Remove the entity matching the given criteria. Raises on error.

```ruby
result = client.Contact.remove({ "id" => "contact_id" })
```

#### `update(reqdata, ctrl = nil) -> result`

Update an existing entity. The data must include the entity `id`. Raises on error.

```ruby
result = client.Contact.update({
  "id" => "contact_id",
  # Fields to update
})
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `ContactEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## ContactsFieldEntity

```ruby
contacts_field = client.ContactsField
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `birthday_date` | `String` | No |  |
| `city` | `String` | No |  |
| `contact_expire_after` | `Integer` | Yes | Contact expire after days |
| `contacts_count` | `Integer` | No |  |
| `country` | `String` | No |  |
| `created_by` | `String` | Yes |  |
| `date_created` | `String` | Yes |  |
| `date_updated` | `String` | Yes |  |
| `description` | `String` | No |  |
| `email` | `String` | No |  |
| `first_name` | `String` | No |  |
| `gender` | `String` | Yes |  |
| `group_id` | `String` | No | Object ID |
| `groups` | `Array` | Yes |  |
| `id` | `String` | No | Object ID |
| `idx` | `String` | No | User provided resource id |
| `last_name` | `String` | No |  |
| `name` | `String` | No | Group name |
| `permissions` | `Array` | No |  |
| `phone_number` | `String` | No |  |
| `read` | `Boolean` | No | Has read permission |
| `send` | `Boolean` | No | Has send permission |
| `source` | `String` | No |  |
| `type` | `String` | No |  |
| `username` | `String` | No |  |
| `value` | `String` | No |  |
| `write` | `Boolean` | No | Has write permission |

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

#### `create(reqdata, ctrl = nil) -> result`

Create a new entity with the given data. Raises on error.

```ruby
result = client.ContactsField.create({
  "contact_expire_after" => 1, # Integer
  "created_by" => "example_created_by", # String
  "date_created" => "example_date_created", # String
  "date_updated" => "example_date_updated", # String
  "gender" => "example_gender", # String
  "groups" => [], # Array
})
```

#### `list(reqmatch = nil, ctrl = nil) -> Array`

List entities matching the given criteria (call with no argument to list all). Returns an array. Raises on error.

```ruby
results = client.ContactsField.list
```

#### `remove(reqmatch, ctrl = nil) -> result`

Remove the entity matching the given criteria. Raises on error.

```ruby
result = client.ContactsField.remove({ "id" => "id" })
```

#### `update(reqdata, ctrl = nil) -> result`

Update an existing entity. The data must include the entity `id`. Raises on error.

```ruby
result = client.ContactsField.update({
  "id" => "id",
  # Fields to update
})
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `ContactsFieldEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## ContactsFieldOptionEntity

```ruby
contacts_field_option = client.ContactsFieldOption
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `birthday_date` | `String` | No |  |
| `city` | `String` | No |  |
| `contact_expire_after` | `Integer` | Yes | Contact expire after days |
| `contacts_count` | `Integer` | No |  |
| `country` | `String` | No |  |
| `created_by` | `String` | Yes |  |
| `date_created` | `String` | Yes |  |
| `date_updated` | `String` | Yes |  |
| `description` | `String` | No |  |
| `email` | `String` | No |  |
| `first_name` | `String` | No |  |
| `gender` | `String` | Yes |  |
| `group_id` | `String` | No | Object ID |
| `groups` | `Array` | Yes |  |
| `id` | `String` | Yes | Object ID |
| `idx` | `String` | No | User provided resource id |
| `last_name` | `String` | No |  |
| `name` | `String` | No | Group name |
| `permissions` | `Array` | No |  |
| `phone_number` | `String` | No |  |
| `read` | `Boolean` | No | Has read permission |
| `send` | `Boolean` | No | Has send permission |
| `source` | `String` | No |  |
| `type` | `String` | No |  |
| `username` | `String` | No |  |
| `value` | `String` | No |  |
| `write` | `Boolean` | No | Has write permission |

### Operations

#### `list(reqmatch = nil, ctrl = nil) -> Array`

List entities matching the given criteria (call with no argument to list all). Returns an array. Raises on error.

```ruby
results = client.ContactsFieldOption.list
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `ContactsFieldOptionEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## ContactsgroupEntity

```ruby
contactsgroup = client.Contactsgroup
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `birthday_date` | `String` | No |  |
| `city` | `String` | No |  |
| `contact_expire_after` | `Integer` | Yes | Contact expire after days |
| `contacts_count` | `Integer` | No |  |
| `country` | `String` | No |  |
| `created_by` | `String` | Yes |  |
| `date_created` | `String` | Yes |  |
| `date_updated` | `String` | Yes |  |
| `description` | `String` | No |  |
| `email` | `String` | No |  |
| `first_name` | `String` | No |  |
| `gender` | `String` | Yes |  |
| `group_id` | `String` | Yes | Object ID |
| `groups` | `Array` | Yes |  |
| `id` | `String` | Yes | Object ID |
| `idx` | `String` | No | User provided resource id |
| `last_name` | `String` | No |  |
| `name` | `String` | No | Group name |
| `permissions` | `Array` | No |  |
| `phone_number` | `String` | No |  |
| `read` | `Boolean` | Yes | Has read permission |
| `send` | `Boolean` | Yes | Has send permission |
| `source` | `String` | No |  |
| `type` | `String` | No |  |
| `username` | `String` | Yes |  |
| `value` | `String` | No |  |
| `write` | `Boolean` | Yes | Has write permission |

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

#### `create(reqdata, ctrl = nil) -> result`

Create a new entity with the given data. Raises on error.

```ruby
result = client.Contactsgroup.create({
  "contact_expire_after" => 1, # Integer
  "created_by" => "example_created_by", # String
  "date_created" => "example_date_created", # String
  "date_updated" => "example_date_updated", # String
  "gender" => "example_gender", # String
  "group_id" => "example_group_id", # String
  "groups" => [], # Array
  "id" => "example_id", # String
  "read" => true, # Boolean
  "send" => true, # Boolean
  "username" => "example_username", # String
  "write" => true, # Boolean
})
```

#### `list(reqmatch = nil, ctrl = nil) -> Array`

List entities matching the given criteria (call with no argument to list all). Returns an array. Raises on error.

```ruby
results = client.Contactsgroup.list
```

#### `remove(reqmatch, ctrl = nil) -> result`

Remove the entity matching the given criteria. Raises on error.

```ruby
result = client.Contactsgroup.remove({ "group_id" => "group_id" })
```

#### `update(reqdata, ctrl = nil) -> result`

Update an existing entity. The data must include the entity `id`. Raises on error.

```ruby
result = client.Contactsgroup.update({
  "group_id" => "group_id",
  # Fields to update
})
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `ContactsgroupEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## ContactstrashEntity

```ruby
contactstrash = client.Contactstrash
```

### Operations

#### `remove(reqmatch, ctrl = nil) -> result`

Remove the entity matching the given criteria. Raises on error.

```ruby
result = client.Contactstrash.remove()
```

#### `update(reqdata, ctrl = nil) -> result`

Update an existing entity. The data must include the entity `id`. Raises on error.

```ruby
result = client.Contactstrash.update({
  # Fields to update
})
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `ContactstrashEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## FieldAvailableEntity

```ruby
field_available = client.FieldAvailable
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `built_in` | `Boolean` | No |  |
| `id` | `String` | No | Object ID |
| `name` | `String` | No |  |
| `options` | `Array` | No |  |
| `type` | `String` | No |  |

### Operations

#### `list(reqmatch = nil, ctrl = nil) -> Array`

List entities matching the given criteria (call with no argument to list all). Returns an array. Raises on error.

```ruby
results = client.FieldAvailable.list
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `FieldAvailableEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## GroupEntity

```ruby
group = client.Group
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `contact_expire_after` | `Integer` | Yes | Contact expire after days |
| `contacts_count` | `Integer` | Yes |  |
| `created_by` | `String` | Yes |  |
| `date_created` | `String` | Yes |  |
| `date_updated` | `String` | Yes |  |
| `description` | `String` | Yes |  |
| `id` | `String` | Yes | Object ID |
| `idx` | `String` | No | User provided resource id |
| `name` | `String` | Yes | Group name |
| `permissions` | `Array` | No |  |

### Operations

#### `load(reqmatch, ctrl = nil) -> result`

Load a single entity matching the given criteria. Raises on error.

```ruby
result = client.Group.load({ "id" => "group_id" })
```

#### `update(reqdata, ctrl = nil) -> result`

Update an existing entity. The data must include the entity `id`. Raises on error.

```ruby
result = client.Group.update({
  "id" => "group_id",
  # Fields to update
})
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `GroupEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## MfaCodeEntity

```ruby
mfa_code = client.MfaCode
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `content` | `String` | No | Custom content that must contain placeholder [%code%] |
| `fast` | `Object` | No |  |
| `from` | `String` | No | Sendername |
| `phone_number` | `String` | Yes |  |

### Operations

#### `create(reqdata, ctrl = nil) -> result`

Create a new entity with the given data. Raises on error.

```ruby
result = client.MfaCode.create({
  "phone_number" => "example_phone_number", # String
})
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `MfaCodeEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## OptOutEntity

```ruby
opt_out = client.OptOut
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `date` | `String` | No |  |
| `id` | `String` | No |  |
| `links` | `Array` | No |  |
| `phoneNumber` | `Integer` | No |  |

### Operations

#### `list(reqmatch = nil, ctrl = nil) -> Array`

List entities matching the given criteria (call with no argument to list all). Returns an array. Raises on error.

```ruby
results = client.OptOut.list
```

#### `remove(reqmatch, ctrl = nil) -> result`

Remove the entity matching the given criteria. Raises on error.

```ruby
result = client.OptOut.remove({ "id" => "id" })
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `OptOutEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## OptOutSettingEntity

```ruby
opt_out_setting = client.OptOutSetting
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `brand` | `String` | No |  |

### Operations

#### `load(reqmatch, ctrl = nil) -> result`

Load a single entity matching the given criteria. Raises on error.

```ruby
result = client.OptOutSetting.load()
```

#### `update(reqdata, ctrl = nil) -> result`

Update an existing entity. The data must include the entity `id`. Raises on error.

```ruby
result = client.OptOutSetting.update({
  # Fields to update
})
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `OptOutSettingEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## PermissionEntity

```ruby
permission = client.Permission
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `group_id` | `String` | Yes | Object ID |
| `id` | `String` | No |  |
| `read` | `Boolean` | Yes | Has read permission |
| `send` | `Boolean` | Yes | Has send permission |
| `username` | `String` | Yes |  |
| `write` | `Boolean` | Yes | Has write permission |

### Operations

#### `create(reqdata, ctrl = nil) -> result`

Create a new entity with the given data. Raises on error.

```ruby
result = client.Permission.create({
  "group_id" => "example_group_id", # String
  "read" => true, # Boolean
  "send" => true, # Boolean
  "username" => "example_username", # String
  "write" => true, # Boolean
})
```

#### `load(reqmatch, ctrl = nil) -> result`

Load a single entity matching the given criteria. Raises on error.

```ruby
result = client.Permission.load({ "id" => "permission_id", "group_id" => "group_id", "username" => "username" })
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `PermissionEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## PingEntity

```ruby
ping = client.Ping
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `authorized` | `Boolean` | Yes |  |
| `unavailable` | `Array` | Yes |  |

### Operations

#### `list(reqmatch = nil, ctrl = nil) -> Array`

List entities matching the given criteria (call with no argument to list all). Returns an array. Raises on error.

```ruby
results = client.Ping.list
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `PingEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## ProfileEntity

```ruby
profile = client.Profile
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `email` | `String` | Yes |  |
| `name` | `String` | Yes |  |
| `payment_type` | `String` | Yes |  |
| `phone_number` | `Integer` | Yes |  |
| `points` | `Float` | No |  |
| `user_type` | `String` | Yes |  |
| `username` | `String` | Yes |  |

### Operations

#### `list(reqmatch = nil, ctrl = nil) -> Array`

List entities matching the given criteria (call with no argument to list all). Returns an array. Raises on error.

```ruby
results = client.Profile.list
```

#### `load(reqmatch, ctrl = nil) -> result`

Load a single entity matching the given criteria. Raises on error.

```ruby
result = client.Profile.load()
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `ProfileEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## RcsEntity

```ruby
rcs = client.Rcs
```

### Operations

#### `list(reqmatch = nil, ctrl = nil) -> Array`

List entities matching the given criteria (call with no argument to list all). Returns an array. Raises on error.

```ruby
results = client.Rcs.list
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `RcsEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## SendernameEntity

```ruby
sendername = client.Sendername
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `created_at` | `String` | No |  |
| `id` | `String` | No |  |
| `is_default` | `Boolean` | No |  |
| `sender` | `String` | No | Sendername |
| `status` | `String` | No |  |

### Operations

#### `create(reqdata, ctrl = nil) -> result`

Create a new entity with the given data. Raises on error.

```ruby
result = client.Sendername.create({
})
```

#### `list(reqmatch = nil, ctrl = nil) -> Array`

List entities matching the given criteria (call with no argument to list all). Returns an array. Raises on error.

```ruby
results = client.Sendername.list
```

#### `load(reqmatch, ctrl = nil) -> result`

Load a single entity matching the given criteria. Raises on error.

```ruby
result = client.Sendername.load({ "id" => "sendername_id" })
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `SendernameEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## SendernameStatementEntity

```ruby
sendername_statement = client.SendernameStatement
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `content` | `String` | No |  |
| `statements` | `Array` | No |  |
| `title` | `String` | No |  |

### Operations

#### `list(reqmatch = nil, ctrl = nil) -> Array`

List entities matching the given criteria (call with no argument to list all). Returns an array. Raises on error.

```ruby
results = client.SendernameStatement.list
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `SendernameStatementEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## SentRcsMessageEntity

```ruby
sent_rcs_message = client.SentRcsMessage
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `content` | `Hash` | No | RCS message content in RCS JSON format. |
| `phone_number` | `String` | Yes | Recipient phone number (e.g. |
| `sender` | `Object` | Yes |  |
| `text` | `String` | No | Plain text message content. |

### Operations

#### `create(reqdata, ctrl = nil) -> result`

Create a new entity with the given data. Raises on error.

```ruby
result = client.SentRcsMessage.create({
  "phone_number" => "example_phone_number", # String
  "sender" => "example_sender", # Object
})
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `SentRcsMessageEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## ShipmentCountryVolumeEntity

```ruby
shipment_country_volume = client.ShipmentCountryVolume
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `country_code` | `String` | No |  |
| `country_limit` | `Integer` | No |  |
| `country_name` | `String` | No |  |
| `usage` | `Integer` | No |  |

### Operations

#### `list(reqmatch = nil, ctrl = nil) -> Array`

List entities matching the given criteria (call with no argument to list all). Returns an array. Raises on error.

```ruby
results = client.ShipmentCountryVolume.list
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `ShipmentCountryVolumeEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## ShortUrlEntity

```ruby
short_url = client.ShortUrl
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `description` | `String` | No |  |
| `expire` | `String` | No |  |
| `filename` | `String` | No |  |
| `hits` | `Integer` | No |  |
| `hits_unique` | `Integer` | No |  |
| `id` | `String` | No |  |
| `name` | `String` | No |  |
| `short_url` | `String` | No | WHATWG URL compliant |
| `type` | `String` | No |  |
| `url` | `String` | No | WHATWG URL compliant |

### Operations

#### `create(reqdata, ctrl = nil) -> result`

Create a new entity with the given data. Raises on error.

```ruby
result = client.ShortUrl.create({
})
```

#### `list(reqmatch = nil, ctrl = nil) -> Array`

List entities matching the given criteria (call with no argument to list all). Returns an array. Raises on error.

```ruby
results = client.ShortUrl.list
```

#### `load(reqmatch, ctrl = nil) -> result`

Load a single entity matching the given criteria. Raises on error.

```ruby
result = client.ShortUrl.load({ "id" => "short_url_id" })
```

#### `remove(reqmatch, ctrl = nil) -> result`

Remove the entity matching the given criteria. Raises on error.

```ruby
result = client.ShortUrl.remove({ "id" => "short_url_id" })
```

#### `update(reqdata, ctrl = nil) -> result`

Update an existing entity. The data must include the entity `id`. Raises on error.

```ruby
result = client.ShortUrl.update({
  "id" => "short_url_id",
  # Fields to update
})
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `ShortUrlEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## SmsdoEntity

```ruby
smsdo = client.Smsdo
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `allow_duplicates` | `Integer` | No | When parameter allow_duplicates is set to "1" allows to send message to duplicated numbers in one request (useful i.e. |
| `check_idx` | `Object` | No | When parameter check_idx is set to „1” prevents from sending more than one message with the same idx in last 24h. |
| `date` | `Object` | No | Date in UNIX timestamp (&date=1287734110) or in ISO 8601 (&date=2012-05-10T08:40:27+00:00) when message will be sent (&date=1287734110). |
| `date_validate` | `Integer` | No | When parameter date_validate is set to "1" checks if date if given in proper format. |
| `details` | `Object` | No | When details parameter is set to "1" more details in response will be displayed (message length and sms count). |
| `encoding` | `String` | No | This parameter describes the encoding of the message text. |
| `expiration_date` | `Object` | No | Message expiration date (in UNIX timestamp or in ISO 8601) is a date after which message won't be delivered if it wasn't delivered yet. |
| `fallback` | `Array` | No | Enable fallback in case sms sending fails |
| `fast` | `Integer` | No | Setting this parameter to „1” will result in sending message with the highest priority which ensures the quickest possible time of delivery. |
| `flash` | `Integer` | No | Sending a message in flash mode can be activated by setting this parameter to "1". |
| `format` | `String` | No | Parameter &format=json causes, that response is sending in JSON format. |
| `from` | `String` | No | Name of the sender. |
| `group` | `String` | No | Name of the group from the contacts database to which message should be sent to. |
| `idx` | `String` | No | Optional custom value sent with SMS and sent back in CALLBACK. |
| `max_parts` | `Integer` | No | Defines maximum message parts allowed, maximum value allowed is 6. |
| `message` | `String` | No | The message text. |
| `normalize` | `Integer` | No | When parameter normalize is set to „1” special chars in message will be replaced with their equivalents (ê-e, ñ-n, ý-y ...). |
| `notify_url` | `String` | No | Parameter allows to set CALLBACK URL for message from request. |
| `test` | `Object` | No | When parameter test is set to "1" message won't be sent but response will be displayed, there is no charge for such test messages. |
| `time_restriction` | `String` | No | Sets the behavior when you try to ship in hours / dates that do not match the settings in your account. |
| `to` | `String` | No | Recipients' mobile phone numbers (i.e. |

### Operations

#### `create(reqdata, ctrl = nil) -> result`

Create a new entity with the given data. Raises on error.

```ruby
result = client.Smsdo.create({
})
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `SmsdoEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## SmssendernameEntity

```ruby
smssendername = client.Smssendername
```

### Operations

#### `create(reqdata, ctrl = nil) -> result`

Create a new entity with the given data. Raises on error.

```ruby
result = client.Smssendername.create({
  "sendername_id" => "example_sendername_id", # String
})
```

#### `remove(reqmatch, ctrl = nil) -> result`

Remove the entity matching the given criteria. Raises on error.

```ruby
result = client.Smssendername.remove({ "sender" => "sender" })
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `SmssendernameEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## SmstemplateEntity

```ruby
smstemplate = client.Smstemplate
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | `String` | No |  |

### Operations

#### `remove(reqmatch, ctrl = nil) -> result`

Remove the entity matching the given criteria. Raises on error.

```ruby
result = client.Smstemplate.remove({ "id" => "id" })
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `SmstemplateEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## SubuserEntity

```ruby
subuser = client.Subuser
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `active` | `Boolean` | No |  |
| `credentials` | `Hash` | Yes |  |
| `description` | `String` | No |  |
| `id` | `String` | No | Object ID |
| `points` | `Hash` | No |  |
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

#### `create(reqdata, ctrl = nil) -> result`

Create a new entity with the given data. Raises on error.

```ruby
result = client.Subuser.create({
  "credentials" => {}, # Hash
})
```

#### `list(reqmatch = nil, ctrl = nil) -> Array`

List entities matching the given criteria (call with no argument to list all). Returns an array. Raises on error.

```ruby
results = client.Subuser.list
```

#### `load(reqmatch, ctrl = nil) -> result`

Load a single entity matching the given criteria. Raises on error.

```ruby
result = client.Subuser.load({ "id" => "subuser_id" })
```

#### `remove(reqmatch, ctrl = nil) -> result`

Remove the entity matching the given criteria. Raises on error.

```ruby
result = client.Subuser.remove({ "id" => "subuser_id" })
```

#### `update(reqdata, ctrl = nil) -> result`

Update an existing entity. The data must include the entity `id`. Raises on error.

```ruby
result = client.Subuser.update({
  "id" => "subuser_id",
  # Fields to update
})
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `SubuserEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## TemplateEntity

```ruby
template = client.Template
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | `String` | No |  |
| `name` | `String` | No |  |
| `normalize` | `Boolean` | No |  |
| `template` | `String` | No |  |

### Operations

#### `create(reqdata, ctrl = nil) -> result`

Create a new entity with the given data. Raises on error.

```ruby
result = client.Template.create({
})
```

#### `list(reqmatch = nil, ctrl = nil) -> Array`

List entities matching the given criteria (call with no argument to list all). Returns an array. Raises on error.

```ruby
results = client.Template.list
```

#### `load(reqmatch, ctrl = nil) -> result`

Load a single entity matching the given criteria. Raises on error.

```ruby
result = client.Template.load({ "id" => "template_id" })
```

#### `update(reqdata, ctrl = nil) -> result`

Update an existing entity. The data must include the entity `id`. Raises on error.

```ruby
result = client.Template.update({
  "id" => "template_id",
  # Fields to update
})
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `TemplateEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## UserRcsSenderCollectionEntity

```ruby
user_rcs_sender_collection = client.UserRcsSenderCollection
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

#### `list(reqmatch = nil, ctrl = nil) -> Array`

List entities matching the given criteria (call with no argument to list all). Returns an array. Raises on error.

```ruby
results = client.UserRcsSenderCollection.list
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `UserRcsSenderCollectionEntity` instance with the same client and
options.

#### `get_name -> String`

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

```ruby
client = SmsapiSDK.new({
  "feature" => {
    "audit" => { "active" => true },
    "cache" => { "active" => true },
    "clienttrack" => { "active" => true },
    "cost" => { "active" => true },
    "debug" => { "active" => true },
    "idempotency" => { "active" => true },
    "log" => { "active" => true },
    "metrics" => { "active" => true },
    "netsim" => { "active" => true },
    "paging" => { "active" => true },
    "proxy" => { "active" => true },
    "ratelimit" => { "active" => true },
    "rbac" => { "active" => true },
    "retry" => { "active" => true },
    "secrets" => { "active" => true },
    "streaming" => { "active" => true },
    "telemetry" => { "active" => true },
    "test" => { "active" => true },
    "timeout" => { "active" => true },
    "validate" => { "active" => true },
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

