# Smsapi Elixir SDK Reference

Complete API reference for the Smsapi Elixir SDK.


## Smsapi

### Constructor

```elixir
sdk = Smsapi.new(options)
```

Create a new SDK client. `options` is a struct value node — build one from a
native map with `Smsapi.Helpers.deep/1`.

**Options:**

| Name | Type | Description |
| --- | --- | --- |
| `apikey` | `String.t()` | API key for authentication. |
| `base` | `String.t()` | Base URL for API requests. |
| `prefix` | `String.t()` | URL prefix appended after base. |
| `suffix` | `String.t()` | URL suffix appended after path. |
| `headers` | `map()` | Custom headers for all requests. |
| `feature` | `map()` | Feature configuration. |
| `system` | `map()` | System overrides (e.g. custom fetch). |


### Constructors

#### `Smsapi.test(testopts \\ nil, sdkopts \\ nil)`

Create a test client with mock features active. Both arguments may be `nil`.

```elixir
sdk = Smsapi.test()
```


### Functions

#### `Smsapi.available(client, entopts \\ nil)`

Create a `Smsapi.Entity.Available` handle.

#### `Smsapi.blacklist(client, entopts \\ nil)`

Create a `Smsapi.Entity.Blacklist` handle.

#### `Smsapi.callback(client, entopts \\ nil)`

Create a `Smsapi.Entity.Callback` handle.

#### `Smsapi.contact(client, entopts \\ nil)`

Create a `Smsapi.Entity.Contact` handle.

#### `Smsapi.contacts_field(client, entopts \\ nil)`

Create a `Smsapi.Entity.ContactsField` handle.

#### `Smsapi.contacts_field_option(client, entopts \\ nil)`

Create a `Smsapi.Entity.ContactsFieldOption` handle.

#### `Smsapi.contactsgroup(client, entopts \\ nil)`

Create a `Smsapi.Entity.Contactsgroup` handle.

#### `Smsapi.contactstrash(client, entopts \\ nil)`

Create a `Smsapi.Entity.Contactstrash` handle.

#### `Smsapi.field_available(client, entopts \\ nil)`

Create a `Smsapi.Entity.FieldAvailable` handle.

#### `Smsapi.group(client, entopts \\ nil)`

Create a `Smsapi.Entity.Group` handle.

#### `Smsapi.mfa_code(client, entopts \\ nil)`

Create a `Smsapi.Entity.MfaCode` handle.

#### `Smsapi.opt_out(client, entopts \\ nil)`

Create a `Smsapi.Entity.OptOut` handle.

#### `Smsapi.opt_out_setting(client, entopts \\ nil)`

Create a `Smsapi.Entity.OptOutSetting` handle.

#### `Smsapi.permission(client, entopts \\ nil)`

Create a `Smsapi.Entity.Permission` handle.

#### `Smsapi.ping(client, entopts \\ nil)`

Create a `Smsapi.Entity.Ping` handle.

#### `Smsapi.profile(client, entopts \\ nil)`

Create a `Smsapi.Entity.Profile` handle.

#### `Smsapi.rcs(client, entopts \\ nil)`

Create a `Smsapi.Entity.Rcs` handle.

#### `Smsapi.sendername(client, entopts \\ nil)`

Create a `Smsapi.Entity.Sendername` handle.

#### `Smsapi.sendername_statement(client, entopts \\ nil)`

Create a `Smsapi.Entity.SendernameStatement` handle.

#### `Smsapi.sent_rcs_message(client, entopts \\ nil)`

Create a `Smsapi.Entity.SentRcsMessage` handle.

#### `Smsapi.shipment_country_volume(client, entopts \\ nil)`

Create a `Smsapi.Entity.ShipmentCountryVolume` handle.

#### `Smsapi.short_url(client, entopts \\ nil)`

Create a `Smsapi.Entity.ShortUrl` handle.

#### `Smsapi.smsdo(client, entopts \\ nil)`

Create a `Smsapi.Entity.Smsdo` handle.

#### `Smsapi.smssendername(client, entopts \\ nil)`

Create a `Smsapi.Entity.Smssendername` handle.

#### `Smsapi.smstemplate(client, entopts \\ nil)`

Create a `Smsapi.Entity.Smstemplate` handle.

#### `Smsapi.subuser(client, entopts \\ nil)`

Create a `Smsapi.Entity.Subuser` handle.

#### `Smsapi.template(client, entopts \\ nil)`

Create a `Smsapi.Entity.Template` handle.

#### `Smsapi.user_rcs_sender_collection(client, entopts \\ nil)`

Create a `Smsapi.Entity.UserRcsSenderCollection` handle.

#### `options_map(client) :: map()`

Return a deep copy of the current SDK options.

#### `get_utility(client) :: map()`

Return the SDK utility node.

#### `direct(client, fetchargs) :: map()`

Make a direct HTTP request to any API endpoint. Returns a result node with
`ok`, `status`, `headers`, and `data` (or `err` on failure). This escape
hatch never raises — branch on `Voxgig.Struct.getprop(result, "ok")`.

**fetchargs keys:**

| Key | Type | Description |
| --- | --- | --- |
| `path` | `String.t()` | URL path with optional `{param}` placeholders. |
| `method` | `String.t()` | HTTP method (default: `"GET"`). |
| `params` | `map()` | Path parameter values. |
| `query` | `map()` | Query string parameters. |
| `headers` | `map()` | Request headers (merged with defaults). |
| `body` | `any()` | Request body (maps are JSON-serialized). |

#### `prepare(client, fetchargs) :: map()`

Prepare a fetch definition without sending. Returns the `fetchdef` and raises
on error.


---

## Smsapi.Entity.Available

```elixir
available = Smsapi.available(sdk)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `name` | `String.t()` | No |  |
| `normalize` | `boolean()` | No |  |
| `template` | `String.t()` | No |  |

### Operations

#### `list(entity, reqmatch \\ nil, ctrl \\ nil) :: list()`

List entities matching the given criteria. The match is optional — call `list(entity)` to list all records. Returns a list and raises on error.

```elixir
records = Smsapi.Entity.Available.list(available)
```

### Common Functions

#### `data_get(entity) :: map()`

Get the entity data.

#### `data_set(entity, data)`

Set the entity data.

#### `match_get(entity) :: map()`

Get the entity match criteria.

#### `match_set(entity, match)`

Set the entity match criteria.

#### `make(entity) :: entity`

Create a new `Smsapi.Entity.Available` handle with the same options.

#### `get_name(entity) :: String.t()`

Return the entity name.


---

## Smsapi.Entity.Blacklist

```elixir
blacklist = Smsapi.blacklist(sdk)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | `String.t()` | No |  |

### Operations

#### `create(entity, reqdata, ctrl \\ nil) :: map()`

Create a new entity with the given data. Returns the created entity data and raises on error.

```elixir
record = Smsapi.Entity.Blacklist.create(blacklist, Smsapi.Helpers.deep(%{
}))
```

#### `load(entity, reqmatch, ctrl \\ nil) :: map()`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```elixir
record = Smsapi.Entity.Blacklist.load(blacklist, Smsapi.Helpers.deep(%{}))
```

#### `remove(entity, reqmatch, ctrl \\ nil) :: map()`

Remove the entity matching the given criteria. Raises on error.

```elixir
record = Smsapi.Entity.Blacklist.remove(blacklist, Smsapi.Helpers.deep(%{"id" => "id"}))
```

### Common Functions

#### `data_get(entity) :: map()`

Get the entity data.

#### `data_set(entity, data)`

Set the entity data.

#### `match_get(entity) :: map()`

Get the entity match criteria.

#### `match_set(entity, match)`

Set the entity match criteria.

#### `make(entity) :: entity`

Create a new `Smsapi.Entity.Blacklist` handle with the same options.

#### `get_name(entity) :: String.t()`

Return the entity name.


---

## Smsapi.Entity.Callback

```elixir
callback = Smsapi.callback(sdk)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `active` | `boolean()` | No |  |
| `api_version` | `integer()` | No | Version of the callback output format. |
| `id` | `String.t()` | No | Object ID |
| `invalid` | `boolean()` | No |  |
| `receiver` | `map()` | No |  |
| `receiver_type` | `String.t()` | No |  |
| `type` | `String.t()` | No |  |
| `url` | `String.t()` | No | WHATWG URL compliant |

### Operations

#### `create(entity, reqdata, ctrl \\ nil) :: map()`

Create a new entity with the given data. Returns the created entity data and raises on error.

```elixir
record = Smsapi.Entity.Callback.create(callback, Smsapi.Helpers.deep(%{
}))
```

#### `list(entity, reqmatch \\ nil, ctrl \\ nil) :: list()`

List entities matching the given criteria. The match is optional — call `list(entity)` to list all records. Returns a list and raises on error.

```elixir
records = Smsapi.Entity.Callback.list(callback)
```

#### `load(entity, reqmatch, ctrl \\ nil) :: map()`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```elixir
record = Smsapi.Entity.Callback.load(callback, Smsapi.Helpers.deep(%{"id" => "callback_id"}))
```

#### `remove(entity, reqmatch, ctrl \\ nil) :: map()`

Remove the entity matching the given criteria. Raises on error.

```elixir
record = Smsapi.Entity.Callback.remove(callback, Smsapi.Helpers.deep(%{"id" => "callback_id"}))
```

#### `update(entity, reqdata, ctrl \\ nil) :: map()`

Update an existing entity. The data must include the entity `id`. Returns the updated entity data and raises on error.

```elixir
record = Smsapi.Entity.Callback.update(callback, Smsapi.Helpers.deep(%{
  "id" => "callback_id",
  # Fields to update
}))
```

### Common Functions

#### `data_get(entity) :: map()`

Get the entity data.

#### `data_set(entity, data)`

Set the entity data.

#### `match_get(entity) :: map()`

Get the entity match criteria.

#### `match_set(entity, match)`

Set the entity match criteria.

#### `make(entity) :: entity`

Create a new `Smsapi.Entity.Callback` handle with the same options.

#### `get_name(entity) :: String.t()`

Return the entity name.


---

## Smsapi.Entity.Contact

```elixir
contact = Smsapi.contact(sdk)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `birthday_date` | `String.t()` | No |  |
| `city` | `String.t()` | No |  |
| `collection` | `list()` | Yes |  |
| `contact_expire_after` | `integer()` | Yes | Contact expire after days |
| `contacts_count` | `integer()` | Yes |  |
| `country` | `String.t()` | No |  |
| `created_by` | `String.t()` | Yes |  |
| `date_created` | `String.t()` | Yes |  |
| `date_updated` | `String.t()` | Yes |  |
| `description` | `String.t()` | No |  |
| `email` | `String.t()` | No |  |
| `first_name` | `String.t()` | No |  |
| `gender` | `String.t()` | Yes |  |
| `group_id` | `String.t()` | No | Object ID |
| `groups` | `list()` | Yes |  |
| `id` | `String.t()` | Yes | Object ID |
| `idx` | `String.t()` | No | User provided resource id |
| `last_name` | `String.t()` | No |  |
| `name` | `String.t()` | Yes | Group name |
| `permissions` | `list()` | No |  |
| `phone_number` | `String.t()` | No |  |
| `read` | `boolean()` | No | Has read permission |
| `send` | `boolean()` | No | Has send permission |
| `size` | `integer()` | Yes |  |
| `source` | `String.t()` | No |  |
| `type` | `String.t()` | No |  |
| `username` | `String.t()` | No |  |
| `value` | `String.t()` | No |  |
| `write` | `boolean()` | No | Has write permission |

### Operations

#### `create(entity, reqdata, ctrl \\ nil) :: map()`

Create a new entity with the given data. Returns the created entity data and raises on error.

```elixir
record = Smsapi.Entity.Contact.create(contact, Smsapi.Helpers.deep(%{
  "collection" => [],  # list()
  "contact_expire_after" => 1,  # integer()
  "contacts_count" => 1,  # integer()
  "created_by" => "example_created_by",  # String.t()
  "date_created" => "example_date_created",  # String.t()
  "date_updated" => "example_date_updated",  # String.t()
  "gender" => "example_gender",  # String.t()
  "groups" => [],  # list()
  "id" => "example_id",  # String.t()
  "name" => "example_name",  # String.t()
  "size" => 1,  # integer()
}))
```

#### `list(entity, reqmatch \\ nil, ctrl \\ nil) :: list()`

List entities matching the given criteria. The match is optional — call `list(entity)` to list all records. Returns a list and raises on error.

```elixir
records = Smsapi.Entity.Contact.list(contact)
```

#### `load(entity, reqmatch, ctrl \\ nil) :: map()`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```elixir
record = Smsapi.Entity.Contact.load(contact, Smsapi.Helpers.deep(%{"id" => "contact_id"}))
```

#### `remove(entity, reqmatch, ctrl \\ nil) :: map()`

Remove the entity matching the given criteria. Raises on error.

```elixir
record = Smsapi.Entity.Contact.remove(contact, Smsapi.Helpers.deep(%{"id" => "contact_id"}))
```

#### `update(entity, reqdata, ctrl \\ nil) :: map()`

Update an existing entity. The data must include the entity `id`. Returns the updated entity data and raises on error.

```elixir
record = Smsapi.Entity.Contact.update(contact, Smsapi.Helpers.deep(%{
  "id" => "contact_id",
  # Fields to update
}))
```

### Common Functions

#### `data_get(entity) :: map()`

Get the entity data.

#### `data_set(entity, data)`

Set the entity data.

#### `match_get(entity) :: map()`

Get the entity match criteria.

#### `match_set(entity, match)`

Set the entity match criteria.

#### `make(entity) :: entity`

Create a new `Smsapi.Entity.Contact` handle with the same options.

#### `get_name(entity) :: String.t()`

Return the entity name.


---

## Smsapi.Entity.ContactsField

```elixir
contacts_field = Smsapi.contacts_field(sdk)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `birthday_date` | `String.t()` | No |  |
| `city` | `String.t()` | No |  |
| `contact_expire_after` | `integer()` | Yes | Contact expire after days |
| `contacts_count` | `integer()` | No |  |
| `country` | `String.t()` | No |  |
| `created_by` | `String.t()` | Yes |  |
| `date_created` | `String.t()` | Yes |  |
| `date_updated` | `String.t()` | Yes |  |
| `description` | `String.t()` | No |  |
| `email` | `String.t()` | No |  |
| `first_name` | `String.t()` | No |  |
| `gender` | `String.t()` | Yes |  |
| `group_id` | `String.t()` | No | Object ID |
| `groups` | `list()` | Yes |  |
| `id` | `String.t()` | No | Object ID |
| `idx` | `String.t()` | No | User provided resource id |
| `last_name` | `String.t()` | No |  |
| `name` | `String.t()` | No | Group name |
| `permissions` | `list()` | No |  |
| `phone_number` | `String.t()` | No |  |
| `read` | `boolean()` | No | Has read permission |
| `send` | `boolean()` | No | Has send permission |
| `source` | `String.t()` | No |  |
| `type` | `String.t()` | No |  |
| `username` | `String.t()` | No |  |
| `value` | `String.t()` | No |  |
| `write` | `boolean()` | No | Has write permission |

### Operations

#### `create(entity, reqdata, ctrl \\ nil) :: map()`

Create a new entity with the given data. Returns the created entity data and raises on error.

```elixir
record = Smsapi.Entity.ContactsField.create(contacts_field, Smsapi.Helpers.deep(%{
  "contact_expire_after" => 1,  # integer()
  "created_by" => "example_created_by",  # String.t()
  "date_created" => "example_date_created",  # String.t()
  "date_updated" => "example_date_updated",  # String.t()
  "gender" => "example_gender",  # String.t()
  "groups" => [],  # list()
}))
```

#### `list(entity, reqmatch \\ nil, ctrl \\ nil) :: list()`

List entities matching the given criteria. The match is optional — call `list(entity)` to list all records. Returns a list and raises on error.

```elixir
records = Smsapi.Entity.ContactsField.list(contacts_field)
```

#### `remove(entity, reqmatch, ctrl \\ nil) :: map()`

Remove the entity matching the given criteria. Raises on error.

```elixir
record = Smsapi.Entity.ContactsField.remove(contacts_field, Smsapi.Helpers.deep(%{"id" => "id"}))
```

#### `update(entity, reqdata, ctrl \\ nil) :: map()`

Update an existing entity. The data must include the entity `id`. Returns the updated entity data and raises on error.

```elixir
record = Smsapi.Entity.ContactsField.update(contacts_field, Smsapi.Helpers.deep(%{
  "id" => "id",
  # Fields to update
}))
```

### Common Functions

#### `data_get(entity) :: map()`

Get the entity data.

#### `data_set(entity, data)`

Set the entity data.

#### `match_get(entity) :: map()`

Get the entity match criteria.

#### `match_set(entity, match)`

Set the entity match criteria.

#### `make(entity) :: entity`

Create a new `Smsapi.Entity.ContactsField` handle with the same options.

#### `get_name(entity) :: String.t()`

Return the entity name.


---

## Smsapi.Entity.ContactsFieldOption

```elixir
contacts_field_option = Smsapi.contacts_field_option(sdk)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `birthday_date` | `String.t()` | No |  |
| `city` | `String.t()` | No |  |
| `contact_expire_after` | `integer()` | Yes | Contact expire after days |
| `contacts_count` | `integer()` | No |  |
| `country` | `String.t()` | No |  |
| `created_by` | `String.t()` | Yes |  |
| `date_created` | `String.t()` | Yes |  |
| `date_updated` | `String.t()` | Yes |  |
| `description` | `String.t()` | No |  |
| `email` | `String.t()` | No |  |
| `first_name` | `String.t()` | No |  |
| `gender` | `String.t()` | Yes |  |
| `group_id` | `String.t()` | No | Object ID |
| `groups` | `list()` | Yes |  |
| `id` | `String.t()` | Yes | Object ID |
| `idx` | `String.t()` | No | User provided resource id |
| `last_name` | `String.t()` | No |  |
| `name` | `String.t()` | No | Group name |
| `permissions` | `list()` | No |  |
| `phone_number` | `String.t()` | No |  |
| `read` | `boolean()` | No | Has read permission |
| `send` | `boolean()` | No | Has send permission |
| `source` | `String.t()` | No |  |
| `type` | `String.t()` | No |  |
| `username` | `String.t()` | No |  |
| `value` | `String.t()` | No |  |
| `write` | `boolean()` | No | Has write permission |

### Operations

#### `list(entity, reqmatch \\ nil, ctrl \\ nil) :: list()`

List entities matching the given criteria. The match is optional — call `list(entity)` to list all records. Returns a list and raises on error.

```elixir
records = Smsapi.Entity.ContactsFieldOption.list(contacts_field_option)
```

### Common Functions

#### `data_get(entity) :: map()`

Get the entity data.

#### `data_set(entity, data)`

Set the entity data.

#### `match_get(entity) :: map()`

Get the entity match criteria.

#### `match_set(entity, match)`

Set the entity match criteria.

#### `make(entity) :: entity`

Create a new `Smsapi.Entity.ContactsFieldOption` handle with the same options.

#### `get_name(entity) :: String.t()`

Return the entity name.


---

## Smsapi.Entity.Contactsgroup

```elixir
contactsgroup = Smsapi.contactsgroup(sdk)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `birthday_date` | `String.t()` | No |  |
| `city` | `String.t()` | No |  |
| `contact_expire_after` | `integer()` | Yes | Contact expire after days |
| `contacts_count` | `integer()` | No |  |
| `country` | `String.t()` | No |  |
| `created_by` | `String.t()` | Yes |  |
| `date_created` | `String.t()` | Yes |  |
| `date_updated` | `String.t()` | Yes |  |
| `description` | `String.t()` | No |  |
| `email` | `String.t()` | No |  |
| `first_name` | `String.t()` | No |  |
| `gender` | `String.t()` | Yes |  |
| `group_id` | `String.t()` | Yes | Object ID |
| `groups` | `list()` | Yes |  |
| `id` | `String.t()` | Yes | Object ID |
| `idx` | `String.t()` | No | User provided resource id |
| `last_name` | `String.t()` | No |  |
| `name` | `String.t()` | No | Group name |
| `permissions` | `list()` | No |  |
| `phone_number` | `String.t()` | No |  |
| `read` | `boolean()` | Yes | Has read permission |
| `send` | `boolean()` | Yes | Has send permission |
| `source` | `String.t()` | No |  |
| `type` | `String.t()` | No |  |
| `username` | `String.t()` | Yes |  |
| `value` | `String.t()` | No |  |
| `write` | `boolean()` | Yes | Has write permission |

### Operations

#### `create(entity, reqdata, ctrl \\ nil) :: map()`

Create a new entity with the given data. Returns the created entity data and raises on error.

```elixir
record = Smsapi.Entity.Contactsgroup.create(contactsgroup, Smsapi.Helpers.deep(%{
  "contact_expire_after" => 1,  # integer()
  "created_by" => "example_created_by",  # String.t()
  "date_created" => "example_date_created",  # String.t()
  "date_updated" => "example_date_updated",  # String.t()
  "gender" => "example_gender",  # String.t()
  "group_id" => "example_group_id",  # String.t()
  "groups" => [],  # list()
  "id" => "example_id",  # String.t()
  "read" => true,  # boolean()
  "send" => true,  # boolean()
  "username" => "example_username",  # String.t()
  "write" => true,  # boolean()
}))
```

#### `list(entity, reqmatch \\ nil, ctrl \\ nil) :: list()`

List entities matching the given criteria. The match is optional — call `list(entity)` to list all records. Returns a list and raises on error.

```elixir
records = Smsapi.Entity.Contactsgroup.list(contactsgroup)
```

#### `remove(entity, reqmatch, ctrl \\ nil) :: map()`

Remove the entity matching the given criteria. Raises on error.

```elixir
record = Smsapi.Entity.Contactsgroup.remove(contactsgroup, Smsapi.Helpers.deep(%{"group_id" => "group_id"}))
```

#### `update(entity, reqdata, ctrl \\ nil) :: map()`

Update an existing entity. The data must include the entity `id`. Returns the updated entity data and raises on error.

```elixir
record = Smsapi.Entity.Contactsgroup.update(contactsgroup, Smsapi.Helpers.deep(%{
  "group_id" => "group_id",
  # Fields to update
}))
```

### Common Functions

#### `data_get(entity) :: map()`

Get the entity data.

#### `data_set(entity, data)`

Set the entity data.

#### `match_get(entity) :: map()`

Get the entity match criteria.

#### `match_set(entity, match)`

Set the entity match criteria.

#### `make(entity) :: entity`

Create a new `Smsapi.Entity.Contactsgroup` handle with the same options.

#### `get_name(entity) :: String.t()`

Return the entity name.


---

## Smsapi.Entity.Contactstrash

```elixir
contactstrash = Smsapi.contactstrash(sdk)
```

### Operations

#### `remove(entity, reqmatch, ctrl \\ nil) :: map()`

Remove the entity matching the given criteria. Raises on error.

```elixir
record = Smsapi.Entity.Contactstrash.remove(contactstrash, Smsapi.Helpers.deep(%{}))
```

#### `update(entity, reqdata, ctrl \\ nil) :: map()`

Update an existing entity. The data must include the entity `id`. Returns the updated entity data and raises on error.

```elixir
record = Smsapi.Entity.Contactstrash.update(contactstrash, Smsapi.Helpers.deep(%{
  # Fields to update
}))
```

### Common Functions

#### `data_get(entity) :: map()`

Get the entity data.

#### `data_set(entity, data)`

Set the entity data.

#### `match_get(entity) :: map()`

Get the entity match criteria.

#### `match_set(entity, match)`

Set the entity match criteria.

#### `make(entity) :: entity`

Create a new `Smsapi.Entity.Contactstrash` handle with the same options.

#### `get_name(entity) :: String.t()`

Return the entity name.


---

## Smsapi.Entity.FieldAvailable

```elixir
field_available = Smsapi.field_available(sdk)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `built_in` | `boolean()` | No |  |
| `id` | `String.t()` | No | Object ID |
| `name` | `String.t()` | No |  |
| `options` | `list()` | No |  |
| `type` | `String.t()` | No |  |

### Operations

#### `list(entity, reqmatch \\ nil, ctrl \\ nil) :: list()`

List entities matching the given criteria. The match is optional — call `list(entity)` to list all records. Returns a list and raises on error.

```elixir
records = Smsapi.Entity.FieldAvailable.list(field_available)
```

### Common Functions

#### `data_get(entity) :: map()`

Get the entity data.

#### `data_set(entity, data)`

Set the entity data.

#### `match_get(entity) :: map()`

Get the entity match criteria.

#### `match_set(entity, match)`

Set the entity match criteria.

#### `make(entity) :: entity`

Create a new `Smsapi.Entity.FieldAvailable` handle with the same options.

#### `get_name(entity) :: String.t()`

Return the entity name.


---

## Smsapi.Entity.Group

```elixir
group = Smsapi.group(sdk)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `contact_expire_after` | `integer()` | Yes | Contact expire after days |
| `contacts_count` | `integer()` | Yes |  |
| `created_by` | `String.t()` | Yes |  |
| `date_created` | `String.t()` | Yes |  |
| `date_updated` | `String.t()` | Yes |  |
| `description` | `String.t()` | Yes |  |
| `id` | `String.t()` | Yes | Object ID |
| `idx` | `String.t()` | No | User provided resource id |
| `name` | `String.t()` | Yes | Group name |
| `permissions` | `list()` | No |  |

### Operations

#### `load(entity, reqmatch, ctrl \\ nil) :: map()`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```elixir
record = Smsapi.Entity.Group.load(group, Smsapi.Helpers.deep(%{"id" => "group_id"}))
```

#### `update(entity, reqdata, ctrl \\ nil) :: map()`

Update an existing entity. The data must include the entity `id`. Returns the updated entity data and raises on error.

```elixir
record = Smsapi.Entity.Group.update(group, Smsapi.Helpers.deep(%{
  "id" => "group_id",
  # Fields to update
}))
```

### Common Functions

#### `data_get(entity) :: map()`

Get the entity data.

#### `data_set(entity, data)`

Set the entity data.

#### `match_get(entity) :: map()`

Get the entity match criteria.

#### `match_set(entity, match)`

Set the entity match criteria.

#### `make(entity) :: entity`

Create a new `Smsapi.Entity.Group` handle with the same options.

#### `get_name(entity) :: String.t()`

Return the entity name.


---

## Smsapi.Entity.MfaCode

```elixir
mfa_code = Smsapi.mfa_code(sdk)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `content` | `String.t()` | No | Custom content that must contain placeholder [%code%] |
| `fast` | `any()` | No |  |
| `from` | `String.t()` | No | Sendername |
| `phone_number` | `String.t()` | Yes |  |

### Operations

#### `create(entity, reqdata, ctrl \\ nil) :: map()`

Create a new entity with the given data. Returns the created entity data and raises on error.

```elixir
record = Smsapi.Entity.MfaCode.create(mfa_code, Smsapi.Helpers.deep(%{
  "phone_number" => "example_phone_number",  # String.t()
}))
```

### Common Functions

#### `data_get(entity) :: map()`

Get the entity data.

#### `data_set(entity, data)`

Set the entity data.

#### `match_get(entity) :: map()`

Get the entity match criteria.

#### `match_set(entity, match)`

Set the entity match criteria.

#### `make(entity) :: entity`

Create a new `Smsapi.Entity.MfaCode` handle with the same options.

#### `get_name(entity) :: String.t()`

Return the entity name.


---

## Smsapi.Entity.OptOut

```elixir
opt_out = Smsapi.opt_out(sdk)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `date` | `String.t()` | No |  |
| `id` | `String.t()` | No |  |
| `links` | `list()` | No |  |
| `phoneNumber` | `integer()` | No |  |

### Operations

#### `list(entity, reqmatch \\ nil, ctrl \\ nil) :: list()`

List entities matching the given criteria. The match is optional — call `list(entity)` to list all records. Returns a list and raises on error.

```elixir
records = Smsapi.Entity.OptOut.list(opt_out)
```

#### `remove(entity, reqmatch, ctrl \\ nil) :: map()`

Remove the entity matching the given criteria. Raises on error.

```elixir
record = Smsapi.Entity.OptOut.remove(opt_out, Smsapi.Helpers.deep(%{"id" => "id"}))
```

### Common Functions

#### `data_get(entity) :: map()`

Get the entity data.

#### `data_set(entity, data)`

Set the entity data.

#### `match_get(entity) :: map()`

Get the entity match criteria.

#### `match_set(entity, match)`

Set the entity match criteria.

#### `make(entity) :: entity`

Create a new `Smsapi.Entity.OptOut` handle with the same options.

#### `get_name(entity) :: String.t()`

Return the entity name.


---

## Smsapi.Entity.OptOutSetting

```elixir
opt_out_setting = Smsapi.opt_out_setting(sdk)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `brand` | `String.t()` | No |  |

### Operations

#### `load(entity, reqmatch, ctrl \\ nil) :: map()`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```elixir
record = Smsapi.Entity.OptOutSetting.load(opt_out_setting, Smsapi.Helpers.deep(%{}))
```

#### `update(entity, reqdata, ctrl \\ nil) :: map()`

Update an existing entity. The data must include the entity `id`. Returns the updated entity data and raises on error.

```elixir
record = Smsapi.Entity.OptOutSetting.update(opt_out_setting, Smsapi.Helpers.deep(%{
  # Fields to update
}))
```

### Common Functions

#### `data_get(entity) :: map()`

Get the entity data.

#### `data_set(entity, data)`

Set the entity data.

#### `match_get(entity) :: map()`

Get the entity match criteria.

#### `match_set(entity, match)`

Set the entity match criteria.

#### `make(entity) :: entity`

Create a new `Smsapi.Entity.OptOutSetting` handle with the same options.

#### `get_name(entity) :: String.t()`

Return the entity name.


---

## Smsapi.Entity.Permission

```elixir
permission = Smsapi.permission(sdk)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `group_id` | `String.t()` | Yes | Object ID |
| `id` | `String.t()` | No |  |
| `read` | `boolean()` | Yes | Has read permission |
| `send` | `boolean()` | Yes | Has send permission |
| `username` | `String.t()` | Yes |  |
| `write` | `boolean()` | Yes | Has write permission |

### Operations

#### `create(entity, reqdata, ctrl \\ nil) :: map()`

Create a new entity with the given data. Returns the created entity data and raises on error.

```elixir
record = Smsapi.Entity.Permission.create(permission, Smsapi.Helpers.deep(%{
  "group_id" => "example_group_id",  # String.t()
  "read" => true,  # boolean()
  "send" => true,  # boolean()
  "username" => "example_username",  # String.t()
  "write" => true,  # boolean()
}))
```

#### `load(entity, reqmatch, ctrl \\ nil) :: map()`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```elixir
record = Smsapi.Entity.Permission.load(permission, Smsapi.Helpers.deep(%{"id" => "permission_id", "group_id" => "group_id", "username" => "username"}))
```

### Common Functions

#### `data_get(entity) :: map()`

Get the entity data.

#### `data_set(entity, data)`

Set the entity data.

#### `match_get(entity) :: map()`

Get the entity match criteria.

#### `match_set(entity, match)`

Set the entity match criteria.

#### `make(entity) :: entity`

Create a new `Smsapi.Entity.Permission` handle with the same options.

#### `get_name(entity) :: String.t()`

Return the entity name.


---

## Smsapi.Entity.Ping

```elixir
ping = Smsapi.ping(sdk)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `authorized` | `boolean()` | Yes |  |
| `unavailable` | `list()` | Yes |  |

### Operations

#### `list(entity, reqmatch \\ nil, ctrl \\ nil) :: list()`

List entities matching the given criteria. The match is optional — call `list(entity)` to list all records. Returns a list and raises on error.

```elixir
records = Smsapi.Entity.Ping.list(ping)
```

### Common Functions

#### `data_get(entity) :: map()`

Get the entity data.

#### `data_set(entity, data)`

Set the entity data.

#### `match_get(entity) :: map()`

Get the entity match criteria.

#### `match_set(entity, match)`

Set the entity match criteria.

#### `make(entity) :: entity`

Create a new `Smsapi.Entity.Ping` handle with the same options.

#### `get_name(entity) :: String.t()`

Return the entity name.


---

## Smsapi.Entity.Profile

```elixir
profile = Smsapi.profile(sdk)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `email` | `String.t()` | Yes |  |
| `name` | `String.t()` | Yes |  |
| `payment_type` | `String.t()` | Yes |  |
| `phone_number` | `integer()` | Yes |  |
| `points` | `float()` | No |  |
| `user_type` | `String.t()` | Yes |  |
| `username` | `String.t()` | Yes |  |

### Operations

#### `list(entity, reqmatch \\ nil, ctrl \\ nil) :: list()`

List entities matching the given criteria. The match is optional — call `list(entity)` to list all records. Returns a list and raises on error.

```elixir
records = Smsapi.Entity.Profile.list(profile)
```

#### `load(entity, reqmatch, ctrl \\ nil) :: map()`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```elixir
record = Smsapi.Entity.Profile.load(profile, Smsapi.Helpers.deep(%{}))
```

### Common Functions

#### `data_get(entity) :: map()`

Get the entity data.

#### `data_set(entity, data)`

Set the entity data.

#### `match_get(entity) :: map()`

Get the entity match criteria.

#### `match_set(entity, match)`

Set the entity match criteria.

#### `make(entity) :: entity`

Create a new `Smsapi.Entity.Profile` handle with the same options.

#### `get_name(entity) :: String.t()`

Return the entity name.


---

## Smsapi.Entity.Rcs

```elixir
rcs = Smsapi.rcs(sdk)
```

### Operations

#### `list(entity, reqmatch \\ nil, ctrl \\ nil) :: list()`

List entities matching the given criteria. The match is optional — call `list(entity)` to list all records. Returns a list and raises on error.

```elixir
records = Smsapi.Entity.Rcs.list(rcs)
```

### Common Functions

#### `data_get(entity) :: map()`

Get the entity data.

#### `data_set(entity, data)`

Set the entity data.

#### `match_get(entity) :: map()`

Get the entity match criteria.

#### `match_set(entity, match)`

Set the entity match criteria.

#### `make(entity) :: entity`

Create a new `Smsapi.Entity.Rcs` handle with the same options.

#### `get_name(entity) :: String.t()`

Return the entity name.


---

## Smsapi.Entity.Sendername

```elixir
sendername = Smsapi.sendername(sdk)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `created_at` | `String.t()` | No |  |
| `id` | `String.t()` | No |  |
| `is_default` | `boolean()` | No |  |
| `sender` | `String.t()` | No | Sendername |
| `status` | `String.t()` | No |  |

### Operations

#### `create(entity, reqdata, ctrl \\ nil) :: map()`

Create a new entity with the given data. Returns the created entity data and raises on error.

```elixir
record = Smsapi.Entity.Sendername.create(sendername, Smsapi.Helpers.deep(%{
}))
```

#### `list(entity, reqmatch \\ nil, ctrl \\ nil) :: list()`

List entities matching the given criteria. The match is optional — call `list(entity)` to list all records. Returns a list and raises on error.

```elixir
records = Smsapi.Entity.Sendername.list(sendername)
```

#### `load(entity, reqmatch, ctrl \\ nil) :: map()`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```elixir
record = Smsapi.Entity.Sendername.load(sendername, Smsapi.Helpers.deep(%{"id" => "sendername_id"}))
```

### Common Functions

#### `data_get(entity) :: map()`

Get the entity data.

#### `data_set(entity, data)`

Set the entity data.

#### `match_get(entity) :: map()`

Get the entity match criteria.

#### `match_set(entity, match)`

Set the entity match criteria.

#### `make(entity) :: entity`

Create a new `Smsapi.Entity.Sendername` handle with the same options.

#### `get_name(entity) :: String.t()`

Return the entity name.


---

## Smsapi.Entity.SendernameStatement

```elixir
sendername_statement = Smsapi.sendername_statement(sdk)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `content` | `String.t()` | No |  |
| `statements` | `list()` | No |  |
| `title` | `String.t()` | No |  |

### Operations

#### `list(entity, reqmatch \\ nil, ctrl \\ nil) :: list()`

List entities matching the given criteria. The match is optional — call `list(entity)` to list all records. Returns a list and raises on error.

```elixir
records = Smsapi.Entity.SendernameStatement.list(sendername_statement)
```

### Common Functions

#### `data_get(entity) :: map()`

Get the entity data.

#### `data_set(entity, data)`

Set the entity data.

#### `match_get(entity) :: map()`

Get the entity match criteria.

#### `match_set(entity, match)`

Set the entity match criteria.

#### `make(entity) :: entity`

Create a new `Smsapi.Entity.SendernameStatement` handle with the same options.

#### `get_name(entity) :: String.t()`

Return the entity name.


---

## Smsapi.Entity.SentRcsMessage

```elixir
sent_rcs_message = Smsapi.sent_rcs_message(sdk)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `content` | `map()` | No | RCS message content in RCS JSON format. |
| `phone_number` | `String.t()` | Yes | Recipient phone number (e.g. |
| `sender` | `any()` | Yes |  |
| `text` | `String.t()` | No | Plain text message content. |

### Operations

#### `create(entity, reqdata, ctrl \\ nil) :: map()`

Create a new entity with the given data. Returns the created entity data and raises on error.

```elixir
record = Smsapi.Entity.SentRcsMessage.create(sent_rcs_message, Smsapi.Helpers.deep(%{
  "phone_number" => "example_phone_number",  # String.t()
  "sender" => "example_sender",  # any()
}))
```

### Common Functions

#### `data_get(entity) :: map()`

Get the entity data.

#### `data_set(entity, data)`

Set the entity data.

#### `match_get(entity) :: map()`

Get the entity match criteria.

#### `match_set(entity, match)`

Set the entity match criteria.

#### `make(entity) :: entity`

Create a new `Smsapi.Entity.SentRcsMessage` handle with the same options.

#### `get_name(entity) :: String.t()`

Return the entity name.


---

## Smsapi.Entity.ShipmentCountryVolume

```elixir
shipment_country_volume = Smsapi.shipment_country_volume(sdk)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `country_code` | `String.t()` | No |  |
| `country_limit` | `integer()` | No |  |
| `country_name` | `String.t()` | No |  |
| `usage` | `integer()` | No |  |

### Operations

#### `list(entity, reqmatch \\ nil, ctrl \\ nil) :: list()`

List entities matching the given criteria. The match is optional — call `list(entity)` to list all records. Returns a list and raises on error.

```elixir
records = Smsapi.Entity.ShipmentCountryVolume.list(shipment_country_volume)
```

### Common Functions

#### `data_get(entity) :: map()`

Get the entity data.

#### `data_set(entity, data)`

Set the entity data.

#### `match_get(entity) :: map()`

Get the entity match criteria.

#### `match_set(entity, match)`

Set the entity match criteria.

#### `make(entity) :: entity`

Create a new `Smsapi.Entity.ShipmentCountryVolume` handle with the same options.

#### `get_name(entity) :: String.t()`

Return the entity name.


---

## Smsapi.Entity.ShortUrl

```elixir
short_url = Smsapi.short_url(sdk)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `description` | `String.t()` | No |  |
| `expire` | `String.t()` | No |  |
| `filename` | `String.t()` | No |  |
| `hits` | `integer()` | No |  |
| `hits_unique` | `integer()` | No |  |
| `id` | `String.t()` | No |  |
| `name` | `String.t()` | No |  |
| `short_url` | `String.t()` | No | WHATWG URL compliant |
| `type` | `String.t()` | No |  |
| `url` | `String.t()` | No | WHATWG URL compliant |

### Operations

#### `create(entity, reqdata, ctrl \\ nil) :: map()`

Create a new entity with the given data. Returns the created entity data and raises on error.

```elixir
record = Smsapi.Entity.ShortUrl.create(short_url, Smsapi.Helpers.deep(%{
}))
```

#### `list(entity, reqmatch \\ nil, ctrl \\ nil) :: list()`

List entities matching the given criteria. The match is optional — call `list(entity)` to list all records. Returns a list and raises on error.

```elixir
records = Smsapi.Entity.ShortUrl.list(short_url)
```

#### `load(entity, reqmatch, ctrl \\ nil) :: map()`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```elixir
record = Smsapi.Entity.ShortUrl.load(short_url, Smsapi.Helpers.deep(%{"id" => "short_url_id"}))
```

#### `remove(entity, reqmatch, ctrl \\ nil) :: map()`

Remove the entity matching the given criteria. Raises on error.

```elixir
record = Smsapi.Entity.ShortUrl.remove(short_url, Smsapi.Helpers.deep(%{"id" => "short_url_id"}))
```

#### `update(entity, reqdata, ctrl \\ nil) :: map()`

Update an existing entity. The data must include the entity `id`. Returns the updated entity data and raises on error.

```elixir
record = Smsapi.Entity.ShortUrl.update(short_url, Smsapi.Helpers.deep(%{
  "id" => "short_url_id",
  # Fields to update
}))
```

### Common Functions

#### `data_get(entity) :: map()`

Get the entity data.

#### `data_set(entity, data)`

Set the entity data.

#### `match_get(entity) :: map()`

Get the entity match criteria.

#### `match_set(entity, match)`

Set the entity match criteria.

#### `make(entity) :: entity`

Create a new `Smsapi.Entity.ShortUrl` handle with the same options.

#### `get_name(entity) :: String.t()`

Return the entity name.


---

## Smsapi.Entity.Smsdo

```elixir
smsdo = Smsapi.smsdo(sdk)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `allow_duplicates` | `integer()` | No | When parameter allow_duplicates is set to "1" allows to send message to duplicated numbers in one request (useful i.e. |
| `check_idx` | `any()` | No | When parameter check_idx is set to „1” prevents from sending more than one message with the same idx in last 24h. |
| `date` | `any()` | No | Date in UNIX timestamp (&date=1287734110) or in ISO 8601 (&date=2012-05-10T08:40:27+00:00) when message will be sent (&date=1287734110). |
| `date_validate` | `integer()` | No | When parameter date_validate is set to "1" checks if date if given in proper format. |
| `details` | `any()` | No | When details parameter is set to "1" more details in response will be displayed (message length and sms count). |
| `encoding` | `String.t()` | No | This parameter describes the encoding of the message text. |
| `expiration_date` | `any()` | No | Message expiration date (in UNIX timestamp or in ISO 8601) is a date after which message won't be delivered if it wasn't delivered yet. |
| `fallback` | `list()` | No | Enable fallback in case sms sending fails |
| `fast` | `integer()` | No | Setting this parameter to „1” will result in sending message with the highest priority which ensures the quickest possible time of delivery. |
| `flash` | `integer()` | No | Sending a message in flash mode can be activated by setting this parameter to "1". |
| `format` | `String.t()` | No | Parameter &format=json causes, that response is sending in JSON format. |
| `from` | `String.t()` | No | Name of the sender. |
| `group` | `String.t()` | No | Name of the group from the contacts database to which message should be sent to. |
| `idx` | `String.t()` | No | Optional custom value sent with SMS and sent back in CALLBACK. |
| `max_parts` | `integer()` | No | Defines maximum message parts allowed, maximum value allowed is 6. |
| `message` | `String.t()` | No | The message text. |
| `normalize` | `integer()` | No | When parameter normalize is set to „1” special chars in message will be replaced with their equivalents (ê-e, ñ-n, ý-y ...). |
| `notify_url` | `String.t()` | No | Parameter allows to set CALLBACK URL for message from request. |
| `test` | `any()` | No | When parameter test is set to "1" message won't be sent but response will be displayed, there is no charge for such test messages. |
| `time_restriction` | `String.t()` | No | Sets the behavior when you try to ship in hours / dates that do not match the settings in your account. |
| `to` | `String.t()` | No | Recipients' mobile phone numbers (i.e. |

### Operations

#### `create(entity, reqdata, ctrl \\ nil) :: map()`

Create a new entity with the given data. Returns the created entity data and raises on error.

```elixir
record = Smsapi.Entity.Smsdo.create(smsdo, Smsapi.Helpers.deep(%{
}))
```

### Common Functions

#### `data_get(entity) :: map()`

Get the entity data.

#### `data_set(entity, data)`

Set the entity data.

#### `match_get(entity) :: map()`

Get the entity match criteria.

#### `match_set(entity, match)`

Set the entity match criteria.

#### `make(entity) :: entity`

Create a new `Smsapi.Entity.Smsdo` handle with the same options.

#### `get_name(entity) :: String.t()`

Return the entity name.


---

## Smsapi.Entity.Smssendername

```elixir
smssendername = Smsapi.smssendername(sdk)
```

### Operations

#### `create(entity, reqdata, ctrl \\ nil) :: map()`

Create a new entity with the given data. Returns the created entity data and raises on error.

```elixir
record = Smsapi.Entity.Smssendername.create(smssendername, Smsapi.Helpers.deep(%{
  "sendername_id" => "example_sendername_id",  # String.t()
}))
```

#### `remove(entity, reqmatch, ctrl \\ nil) :: map()`

Remove the entity matching the given criteria. Raises on error.

```elixir
record = Smsapi.Entity.Smssendername.remove(smssendername, Smsapi.Helpers.deep(%{"sender" => "sender"}))
```

### Common Functions

#### `data_get(entity) :: map()`

Get the entity data.

#### `data_set(entity, data)`

Set the entity data.

#### `match_get(entity) :: map()`

Get the entity match criteria.

#### `match_set(entity, match)`

Set the entity match criteria.

#### `make(entity) :: entity`

Create a new `Smsapi.Entity.Smssendername` handle with the same options.

#### `get_name(entity) :: String.t()`

Return the entity name.


---

## Smsapi.Entity.Smstemplate

```elixir
smstemplate = Smsapi.smstemplate(sdk)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | `String.t()` | No |  |

### Operations

#### `remove(entity, reqmatch, ctrl \\ nil) :: map()`

Remove the entity matching the given criteria. Raises on error.

```elixir
record = Smsapi.Entity.Smstemplate.remove(smstemplate, Smsapi.Helpers.deep(%{"id" => "id"}))
```

### Common Functions

#### `data_get(entity) :: map()`

Get the entity data.

#### `data_set(entity, data)`

Set the entity data.

#### `match_get(entity) :: map()`

Get the entity match criteria.

#### `match_set(entity, match)`

Set the entity match criteria.

#### `make(entity) :: entity`

Create a new `Smsapi.Entity.Smstemplate` handle with the same options.

#### `get_name(entity) :: String.t()`

Return the entity name.


---

## Smsapi.Entity.Subuser

```elixir
subuser = Smsapi.subuser(sdk)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `active` | `boolean()` | No |  |
| `credentials` | `map()` | Yes |  |
| `description` | `String.t()` | No |  |
| `id` | `String.t()` | No | Object ID |
| `points` | `map()` | No |  |
| `username` | `String.t()` | No |  |

### Operations

#### `create(entity, reqdata, ctrl \\ nil) :: map()`

Create a new entity with the given data. Returns the created entity data and raises on error.

```elixir
record = Smsapi.Entity.Subuser.create(subuser, Smsapi.Helpers.deep(%{
  "credentials" => %{},  # map()
}))
```

#### `list(entity, reqmatch \\ nil, ctrl \\ nil) :: list()`

List entities matching the given criteria. The match is optional — call `list(entity)` to list all records. Returns a list and raises on error.

```elixir
records = Smsapi.Entity.Subuser.list(subuser)
```

#### `load(entity, reqmatch, ctrl \\ nil) :: map()`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```elixir
record = Smsapi.Entity.Subuser.load(subuser, Smsapi.Helpers.deep(%{"id" => "subuser_id"}))
```

#### `remove(entity, reqmatch, ctrl \\ nil) :: map()`

Remove the entity matching the given criteria. Raises on error.

```elixir
record = Smsapi.Entity.Subuser.remove(subuser, Smsapi.Helpers.deep(%{"id" => "subuser_id"}))
```

#### `update(entity, reqdata, ctrl \\ nil) :: map()`

Update an existing entity. The data must include the entity `id`. Returns the updated entity data and raises on error.

```elixir
record = Smsapi.Entity.Subuser.update(subuser, Smsapi.Helpers.deep(%{
  "id" => "subuser_id",
  # Fields to update
}))
```

### Common Functions

#### `data_get(entity) :: map()`

Get the entity data.

#### `data_set(entity, data)`

Set the entity data.

#### `match_get(entity) :: map()`

Get the entity match criteria.

#### `match_set(entity, match)`

Set the entity match criteria.

#### `make(entity) :: entity`

Create a new `Smsapi.Entity.Subuser` handle with the same options.

#### `get_name(entity) :: String.t()`

Return the entity name.


---

## Smsapi.Entity.Template

```elixir
template = Smsapi.template(sdk)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | `String.t()` | No |  |
| `name` | `String.t()` | No |  |
| `normalize` | `boolean()` | No |  |
| `template` | `String.t()` | No |  |

### Operations

#### `create(entity, reqdata, ctrl \\ nil) :: map()`

Create a new entity with the given data. Returns the created entity data and raises on error.

```elixir
record = Smsapi.Entity.Template.create(template, Smsapi.Helpers.deep(%{
}))
```

#### `list(entity, reqmatch \\ nil, ctrl \\ nil) :: list()`

List entities matching the given criteria. The match is optional — call `list(entity)` to list all records. Returns a list and raises on error.

```elixir
records = Smsapi.Entity.Template.list(template)
```

#### `load(entity, reqmatch, ctrl \\ nil) :: map()`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```elixir
record = Smsapi.Entity.Template.load(template, Smsapi.Helpers.deep(%{"id" => "template_id"}))
```

#### `update(entity, reqdata, ctrl \\ nil) :: map()`

Update an existing entity. The data must include the entity `id`. Returns the updated entity data and raises on error.

```elixir
record = Smsapi.Entity.Template.update(template, Smsapi.Helpers.deep(%{
  "id" => "template_id",
  # Fields to update
}))
```

### Common Functions

#### `data_get(entity) :: map()`

Get the entity data.

#### `data_set(entity, data)`

Set the entity data.

#### `match_get(entity) :: map()`

Get the entity match criteria.

#### `match_set(entity, match)`

Set the entity match criteria.

#### `make(entity) :: entity`

Create a new `Smsapi.Entity.Template` handle with the same options.

#### `get_name(entity) :: String.t()`

Return the entity name.


---

## Smsapi.Entity.UserRcsSenderCollection

```elixir
user_rcs_sender_collection = Smsapi.user_rcs_sender_collection(sdk)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `deliveredAt` | `String.t()` | No |  |
| `expiredAt` | `String.t()` | No |  |
| `id` | `String.t()` | No | Object ID |
| `interface` | `String.t()` | No | Interface through which the message was sent (www, api, ...). |
| `messageType` | `String.t()` | No | RCS message type (basic, single, ...). |
| `readAt` | `String.t()` | No |  |
| `recipient` | `String.t()` | No | Recipient phone number (without +). |
| `sender` | `String.t()` | No | Sender name |
| `senderId` | `String.t()` | No | Sender id |
| `sentAt` | `String.t()` | No |  |

### Operations

#### `list(entity, reqmatch \\ nil, ctrl \\ nil) :: list()`

List entities matching the given criteria. The match is optional — call `list(entity)` to list all records. Returns a list and raises on error.

```elixir
records = Smsapi.Entity.UserRcsSenderCollection.list(user_rcs_sender_collection)
```

### Common Functions

#### `data_get(entity) :: map()`

Get the entity data.

#### `data_set(entity, data)`

Set the entity data.

#### `match_get(entity) :: map()`

Get the entity match criteria.

#### `match_set(entity, match)`

Set the entity match criteria.

#### `make(entity) :: entity`

Create a new `Smsapi.Entity.UserRcsSenderCollection` handle with the same options.

#### `get_name(entity) :: String.t()`

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

```elixir
sdk = Smsapi.new(Smsapi.Helpers.deep(%{
  "feature" => %{
    "audit" => %{"active" => true},
    "cache" => %{"active" => true},
    "clienttrack" => %{"active" => true},
    "cost" => %{"active" => true},
    "debug" => %{"active" => true},
    "idempotency" => %{"active" => true},
    "log" => %{"active" => true},
    "metrics" => %{"active" => true},
    "netsim" => %{"active" => true},
    "paging" => %{"active" => true},
    "proxy" => %{"active" => true},
    "ratelimit" => %{"active" => true},
    "rbac" => %{"active" => true},
    "retry" => %{"active" => true},
    "secrets" => %{"active" => true},
    "streaming" => %{"active" => true},
    "telemetry" => %{"active" => true},
    "test" => %{"active" => true},
    "timeout" => %{"active" => true},
    "validate" => %{"active" => true},
  }
}))
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

