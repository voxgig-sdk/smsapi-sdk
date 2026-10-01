# Smsapi TypeScript SDK Reference

Complete API reference for the Smsapi TypeScript SDK.


## SmsapiSDK

### Constructor

```ts
new SmsapiSDK(options?: object)
```

Create a new SDK client instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `options` | `object` | SDK configuration options. |
| `options.apikey` | `string` | API key for authentication. |
| `options.base` | `string` | Base URL for API requests. |
| `options.prefix` | `string` | URL prefix appended after base. |
| `options.suffix` | `string` | URL suffix appended after path. |
| `options.headers` | `object` | Custom headers for all requests. |
| `options.feature` | `object` | Feature configuration. |
| `options.system` | `object` | System overrides (e.g. custom fetch). |


### Static Methods

#### `SmsapiSDK.test(testopts?, sdkopts?)`

Create a test client with mock features active.

```ts
const client = SmsapiSDK.test()
```

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `testopts` | `object` | Test feature options. |
| `sdkopts` | `object` | Additional SDK options merged with test defaults. |

**Returns:** `SmsapiSDK` instance in test mode.


### Instance Methods

#### `Available(data?: object)`

Create a new `Available` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `AvailableEntity` instance.

#### `Blacklist(data?: object)`

Create a new `Blacklist` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `BlacklistEntity` instance.

#### `Callback(data?: object)`

Create a new `Callback` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `CallbackEntity` instance.

#### `Contact(data?: object)`

Create a new `Contact` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `ContactEntity` instance.

#### `ContactsField(data?: object)`

Create a new `ContactsField` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `ContactsFieldEntity` instance.

#### `ContactsFieldOption(data?: object)`

Create a new `ContactsFieldOption` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `ContactsFieldOptionEntity` instance.

#### `Contactsgroup(data?: object)`

Create a new `Contactsgroup` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `ContactsgroupEntity` instance.

#### `Contactstrash(data?: object)`

Create a new `Contactstrash` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `ContactstrashEntity` instance.

#### `FieldAvailable(data?: object)`

Create a new `FieldAvailable` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `FieldAvailableEntity` instance.

#### `Group(data?: object)`

Create a new `Group` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `GroupEntity` instance.

#### `MfaCode(data?: object)`

Create a new `MfaCode` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `MfaCodeEntity` instance.

#### `OptOut(data?: object)`

Create a new `OptOut` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `OptOutEntity` instance.

#### `OptOutSetting(data?: object)`

Create a new `OptOutSetting` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `OptOutSettingEntity` instance.

#### `Permission(data?: object)`

Create a new `Permission` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `PermissionEntity` instance.

#### `Ping(data?: object)`

Create a new `Ping` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `PingEntity` instance.

#### `Profile(data?: object)`

Create a new `Profile` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `ProfileEntity` instance.

#### `Rcs(data?: object)`

Create a new `Rcs` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `RcsEntity` instance.

#### `Sendername(data?: object)`

Create a new `Sendername` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `SendernameEntity` instance.

#### `SendernameStatement(data?: object)`

Create a new `SendernameStatement` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `SendernameStatementEntity` instance.

#### `SentRcsMessage(data?: object)`

Create a new `SentRcsMessage` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `SentRcsMessageEntity` instance.

#### `ShipmentCountryVolume(data?: object)`

Create a new `ShipmentCountryVolume` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `ShipmentCountryVolumeEntity` instance.

#### `ShortUrl(data?: object)`

Create a new `ShortUrl` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `ShortUrlEntity` instance.

#### `Smsdo(data?: object)`

Create a new `Smsdo` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `SmsdoEntity` instance.

#### `Smssendername(data?: object)`

Create a new `Smssendername` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `SmssendernameEntity` instance.

#### `Smstemplate(data?: object)`

Create a new `Smstemplate` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `SmstemplateEntity` instance.

#### `Subuser(data?: object)`

Create a new `Subuser` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `SubuserEntity` instance.

#### `Template(data?: object)`

Create a new `Template` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `TemplateEntity` instance.

#### `UserRcsSenderCollection(data?: object)`

Create a new `UserRcsSenderCollection` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `UserRcsSenderCollectionEntity` instance.

#### `options()`

Return a deep copy of the current SDK options.

**Returns:** `object`

#### `utility()`

Return a copy of the SDK utility object.

**Returns:** `object`

#### `direct(fetchargs?: object)`

Make a direct HTTP request to any API endpoint.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `fetchargs.path` | `string` | URL path with optional `{param}` placeholders. |
| `fetchargs.method` | `string` | HTTP method (default: `GET`). |
| `fetchargs.params` | `object` | Path parameter values for `{param}` substitution. |
| `fetchargs.query` | `object` | Query string parameters. |
| `fetchargs.headers` | `object` | Request headers (merged with defaults). |
| `fetchargs.body` | `any` | Request body (objects are JSON-serialized). |
| `fetchargs.ctrl` | `object` | Control options (e.g. `{ explain: true }`). |

**Returns:** `Promise<{ ok, status, headers, data } | Error>`

#### `prepare(fetchargs?: object)`

Prepare a fetch definition without sending the request. Accepts the
same parameters as `direct()`.

**Returns:** `Promise<{ url, method, headers, body } | Error>`

#### `tester(testopts?, sdkopts?)`

Alias for `SmsapiSDK.test()`.

**Returns:** `SmsapiSDK` instance in test mode.


---

## AvailableEntity

```ts
const available = client.Available()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `name` | `string` | No |  |
| `normalize` | `boolean` | No |  |
| `template` | `string` | No |  |

### Operations

#### `list(match: object, ctrl?: object)`

List entities matching the given criteria. Returns an array.

```ts
const results = await client.Available().list()
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `AvailableEntity` instance with the same client and
options.

#### `client()`

Return the parent `SmsapiSDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## BlacklistEntity

```ts
const blacklist = client.Blacklist()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | `string` | No |  |

### Actions

This entity exposes custom API actions in addition to the standard
operations. Select one with `$action` in the call's argument; the
remaining keys are sent as that action's payload.

| Action | Route | Call |
| --- | --- | --- |
| `phone_number` | `/blacklist/phone_numbers` | `client.Blacklist().create({ $action: 'phone_number', ... })` |
| `phone_number` | `/blacklist/phone_numbers` | `client.Blacklist().load({ $action: 'phone_number', ... })` |
| `phone_number` | `/blacklist/phone_numbers` | `client.Blacklist().remove({ $action: 'phone_number', ... })` |

An action returns that action's OWN response, which is not necessarily a
Blacklist record — check the API definition for its shape.

```ts
const result = await client.Blacklist().create({
  $action: 'phone_number',
  /* ...the action's own arguments */
})
```

### Operations

#### `create(data: object, ctrl?: object)`

Create a new entity with the given data.

```ts
const result = await client.Blacklist().create({
})
```

#### `load(match: object, ctrl?: object)`

Load a single entity matching the given criteria.

```ts
const result = await client.Blacklist().load()
```

#### `remove(match: object, ctrl?: object)`

Remove the entity matching the given criteria.

```ts
const result = await client.Blacklist().remove({ id: 'id' })
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `BlacklistEntity` instance with the same client and
options.

#### `client()`

Return the parent `SmsapiSDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## CallbackEntity

```ts
const callback = client.Callback()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `active` | `boolean` | No |  |
| `api_version` | `number` | No | Version of the callback output format. |
| `id` | `string` | No | Object ID |
| `invalid` | `boolean` | No |  |
| `receiver` | `Record<string, any>` | No |  |
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

### Actions

This entity exposes custom API actions in addition to the standard
operations. Select one with `$action` in the call's argument; the
remaining keys are sent as that action's payload.

| Action | Route | Call |
| --- | --- | --- |
| `command_test` | `/callbacks/{id}/commands/test` | `client.Callback().load({ $action: 'command_test', ... })` |
| `command_activate` | `/callbacks/{id}/commands/activate` | `client.Callback().update({ $action: 'command_activate', ... })` |
| `command_deactivate` | `/callbacks/{id}/commands/deactivate` | `client.Callback().update({ $action: 'command_deactivate', ... })` |

An action returns that action's OWN response, which is not necessarily a
Callback record — check the API definition for its shape.

```ts
const result = await client.Callback().load({
  $action: 'command_test',
  /* ...the action's own arguments */
})
```

### Operations

#### `create(data: object, ctrl?: object)`

Create a new entity with the given data.

```ts
const result = await client.Callback().create({
})
```

#### `list(match: object, ctrl?: object)`

List entities matching the given criteria. Returns an array.

```ts
const results = await client.Callback().list()
```

#### `load(match: object, ctrl?: object)`

Load a single entity matching the given criteria.

```ts
const result = await client.Callback().load({ id: 'callback_id' })
```

#### `remove(match: object, ctrl?: object)`

Remove the entity matching the given criteria.

```ts
const result = await client.Callback().remove({ id: 'callback_id' })
```

#### `update(data: object, ctrl?: object)`

Update an existing entity. The data must include the entity `id`.

```ts
const result = await client.Callback().update({
  id: 'callback_id',
  // Fields to update
})
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `CallbackEntity` instance with the same client and
options.

#### `client()`

Return the parent `SmsapiSDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## ContactEntity

```ts
const contact = client.Contact()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `birthday_date` | `string` | No |  |
| `city` | `string` | No |  |
| `collection` | `any[]` | Yes |  |
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
| `groups` | `any[]` | Yes |  |
| `id` | `string` | Yes | Object ID |
| `idx` | `string` | No | User provided resource id |
| `last_name` | `string` | No |  |
| `name` | `string` | Yes | Group name |
| `permissions` | `any[]` | No |  |
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

### Actions

This entity exposes custom API actions in addition to the standard
operations. Select one with `$action` in the call's argument; the
remaining keys are sent as that action's payload.

| Action | Route | Call |
| --- | --- | --- |
| `group` | `/contacts/{contactId}/groups` | `client.Contact().create({ $action: 'group', ... })` |
| `group` | `/contacts/{contactId}/groups` | `client.Contact().list({ $action: 'group', ... })` |

An action returns that action's OWN response, which is not necessarily a
Contact record — check the API definition for its shape.

```ts
const result = await client.Contact().create({
  $action: 'group',
  /* ...the action's own arguments */
})
```

### Operations

#### `create(data: object, ctrl?: object)`

Create a new entity with the given data.

```ts
const result = await client.Contact().create({
  collection: [],
  contact_expire_after: 1,
  contacts_count: 1,
  created_by: 'example_created_by',
  date_created: 'example_date_created',
  date_updated: 'example_date_updated',
  gender: 'example_gender',
  groups: [],
  id: 'example_id',
  name: 'example_name',
  size: 1,
})
```

#### `list(match: object, ctrl?: object)`

List entities matching the given criteria. Returns an array.

```ts
const results = await client.Contact().list()
```

#### `load(match: object, ctrl?: object)`

Load a single entity matching the given criteria.

```ts
const result = await client.Contact().load({ id: 'contact_id' })
```

#### `remove(match: object, ctrl?: object)`

Remove the entity matching the given criteria.

```ts
const result = await client.Contact().remove({ id: 'contact_id' })
```

#### `update(data: object, ctrl?: object)`

Update an existing entity. The data must include the entity `id`.

```ts
const result = await client.Contact().update({
  id: 'contact_id',
  // Fields to update
})
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `ContactEntity` instance with the same client and
options.

#### `client()`

Return the parent `SmsapiSDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## ContactsFieldEntity

```ts
const contacts_field = client.ContactsField()
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
| `groups` | `any[]` | Yes |  |
| `id` | `string` | No | Object ID |
| `idx` | `string` | No | User provided resource id |
| `last_name` | `string` | No |  |
| `name` | `string` | No | Group name |
| `permissions` | `any[]` | No |  |
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

#### `create(data: object, ctrl?: object)`

Create a new entity with the given data.

```ts
const result = await client.ContactsField().create({
  contact_expire_after: 1,
  created_by: 'example_created_by',
  date_created: 'example_date_created',
  date_updated: 'example_date_updated',
  gender: 'example_gender',
  groups: [],
})
```

#### `list(match: object, ctrl?: object)`

List entities matching the given criteria. Returns an array.

```ts
const results = await client.ContactsField().list()
```

#### `remove(match: object, ctrl?: object)`

Remove the entity matching the given criteria.

```ts
const result = await client.ContactsField().remove({ id: 'id' })
```

#### `update(data: object, ctrl?: object)`

Update an existing entity. The data must include the entity `id`.

```ts
const result = await client.ContactsField().update({
  id: 'id',
  // Fields to update
})
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `ContactsFieldEntity` instance with the same client and
options.

#### `client()`

Return the parent `SmsapiSDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## ContactsFieldOptionEntity

```ts
const contacts_field_option = client.ContactsFieldOption()
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
| `groups` | `any[]` | Yes |  |
| `id` | `string` | Yes | Object ID |
| `idx` | `string` | No | User provided resource id |
| `last_name` | `string` | No |  |
| `name` | `string` | No | Group name |
| `permissions` | `any[]` | No |  |
| `phone_number` | `string` | No |  |
| `read` | `boolean` | No | Has read permission |
| `send` | `boolean` | No | Has send permission |
| `source` | `string` | No |  |
| `type` | `string` | No |  |
| `username` | `string` | No |  |
| `value` | `string` | No |  |
| `write` | `boolean` | No | Has write permission |

### Operations

#### `list(match: object, ctrl?: object)`

List entities matching the given criteria. Returns an array.

```ts
const results = await client.ContactsFieldOption().list({ field_id: "example" })
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `ContactsFieldOptionEntity` instance with the same client and
options.

#### `client()`

Return the parent `SmsapiSDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## ContactsgroupEntity

```ts
const contactsgroup = client.Contactsgroup()
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
| `groups` | `any[]` | Yes |  |
| `id` | `string` | Yes | Object ID |
| `idx` | `string` | No | User provided resource id |
| `last_name` | `string` | No |  |
| `name` | `string` | No | Group name |
| `permissions` | `any[]` | No |  |
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

#### `create(data: object, ctrl?: object)`

Create a new entity with the given data.

```ts
const result = await client.Contactsgroup().create({
  contact_expire_after: 1,
  created_by: 'example_created_by',
  date_created: 'example_date_created',
  date_updated: 'example_date_updated',
  gender: 'example_gender',
  group_id: 'example_group_id',
  groups: [],
  id: 'example_id',
  read: true,
  send: true,
  username: 'example_username',
  write: true,
})
```

#### `list(match: object, ctrl?: object)`

List entities matching the given criteria. Returns an array.

```ts
const results = await client.Contactsgroup().list()
```

#### `remove(match: object, ctrl?: object)`

Remove the entity matching the given criteria.

```ts
const result = await client.Contactsgroup().remove({ group_id: 'group_id' })
```

#### `update(data: object, ctrl?: object)`

Update an existing entity. The data must include the entity `id`.

```ts
const result = await client.Contactsgroup().update({
  group_id: 'group_id',
  // Fields to update
})
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `ContactsgroupEntity` instance with the same client and
options.

#### `client()`

Return the parent `SmsapiSDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## ContactstrashEntity

```ts
const contactstrash = client.Contactstrash()
```

### Operations

#### `remove(match: object, ctrl?: object)`

Remove the entity matching the given criteria.

```ts
const result = await client.Contactstrash().remove()
```

#### `update(data: object, ctrl?: object)`

Update an existing entity. The data must include the entity `id`.

```ts
const result = await client.Contactstrash().update({
  // Fields to update
})
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `ContactstrashEntity` instance with the same client and
options.

#### `client()`

Return the parent `SmsapiSDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## FieldAvailableEntity

```ts
const field_available = client.FieldAvailable()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `built_in` | `boolean` | No |  |
| `id` | `string` | No | Object ID |
| `name` | `string` | No |  |
| `options` | `any[]` | No |  |
| `type` | `string` | No |  |

### Operations

#### `list(match: object, ctrl?: object)`

List entities matching the given criteria. Returns an array.

```ts
const results = await client.FieldAvailable().list()
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `FieldAvailableEntity` instance with the same client and
options.

#### `client()`

Return the parent `SmsapiSDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## GroupEntity

```ts
const group = client.Group()
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
| `permissions` | `any[]` | No |  |

### Operations

#### `load(match: object, ctrl?: object)`

Load a single entity matching the given criteria.

```ts
const result = await client.Group().load({ id: 'group_id' })
```

#### `update(data: object, ctrl?: object)`

Update an existing entity. The data must include the entity `id`.

```ts
const result = await client.Group().update({
  id: 'group_id',
  // Fields to update
})
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `GroupEntity` instance with the same client and
options.

#### `client()`

Return the parent `SmsapiSDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## MfaCodeEntity

```ts
const mfa_code = client.MfaCode()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `content` | `string` | No | Custom content that must contain placeholder [%code%] |
| `fast` | `any` | No |  |
| `from` | `string` | No | Sendername |
| `phone_number` | `string` | Yes |  |

### Actions

This entity exposes custom API actions in addition to the standard
operations. Select one with `$action` in the call's argument; the
remaining keys are sent as that action's payload.

| Action | Route | Call |
| --- | --- | --- |
| `verification` | `/mfa/codes/verifications` | `client.MfaCode().create({ $action: 'verification', ... })` |

An action returns that action's OWN response, which is not necessarily a
MfaCode record — check the API definition for its shape.

```ts
const result = await client.MfaCode().create({
  $action: 'verification',
  /* ...the action's own arguments */
})
```

### Operations

#### `create(data: object, ctrl?: object)`

Create a new entity with the given data.

```ts
const result = await client.MfaCode().create({
  phone_number: 'example_phone_number',
})
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `MfaCodeEntity` instance with the same client and
options.

#### `client()`

Return the parent `SmsapiSDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## OptOutEntity

```ts
const opt_out = client.OptOut()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `date` | `string` | No |  |
| `id` | `string` | No |  |
| `links` | `any[]` | No |  |
| `phoneNumber` | `number` | No |  |

### Operations

#### `list(match: object, ctrl?: object)`

List entities matching the given criteria. Returns an array.

```ts
const results = await client.OptOut().list()
```

#### `remove(match: object, ctrl?: object)`

Remove the entity matching the given criteria.

```ts
const result = await client.OptOut().remove({ id: 'id' })
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `OptOutEntity` instance with the same client and
options.

#### `client()`

Return the parent `SmsapiSDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## OptOutSettingEntity

```ts
const opt_out_setting = client.OptOutSetting()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `brand` | `string` | No |  |

### Operations

#### `load(match: object, ctrl?: object)`

Load a single entity matching the given criteria.

```ts
const result = await client.OptOutSetting().load()
```

#### `update(data: object, ctrl?: object)`

Update an existing entity. The data must include the entity `id`.

```ts
const result = await client.OptOutSetting().update({
  // Fields to update
})
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `OptOutSettingEntity` instance with the same client and
options.

#### `client()`

Return the parent `SmsapiSDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## PermissionEntity

```ts
const permission = client.Permission()
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

#### `create(data: object, ctrl?: object)`

Create a new entity with the given data.

```ts
const result = await client.Permission().create({
  group_id: 'example_group_id',
  read: true,
  send: true,
  username: 'example_username',
  write: true,
})
```

#### `load(match: object, ctrl?: object)`

Load a single entity matching the given criteria.

```ts
const result = await client.Permission().load({ id: 'permission_id', group_id: 'group_id', username: 'username' })
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `PermissionEntity` instance with the same client and
options.

#### `client()`

Return the parent `SmsapiSDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## PingEntity

```ts
const ping = client.Ping()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `authorized` | `boolean` | Yes |  |
| `unavailable` | `any[]` | Yes |  |

### Operations

#### `list(match: object, ctrl?: object)`

List entities matching the given criteria. Returns an array.

```ts
const results = await client.Ping().list()
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `PingEntity` instance with the same client and
options.

#### `client()`

Return the parent `SmsapiSDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## ProfileEntity

```ts
const profile = client.Profile()
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

### Actions

This entity exposes custom API actions in addition to the standard
operations. Select one with `$action` in the call's argument; the
remaining keys are sent as that action's payload.

| Action | Route | Call |
| --- | --- | --- |
| `price` | `/profile/prices` | `client.Profile().list({ $action: 'price', ... })` |

An action returns that action's OWN response, which is not necessarily a
Profile record — check the API definition for its shape.

```ts
const result = await client.Profile().list({
  $action: 'price',
  /* ...the action's own arguments */
})
```

### Operations

#### `list(match: object, ctrl?: object)`

List entities matching the given criteria. Returns an array.

```ts
const results = await client.Profile().list()
```

#### `load(match: object, ctrl?: object)`

Load a single entity matching the given criteria.

```ts
const result = await client.Profile().load()
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `ProfileEntity` instance with the same client and
options.

#### `client()`

Return the parent `SmsapiSDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## RcsEntity

```ts
const rcs = client.Rcs()
```

### Actions

This entity exposes custom API actions in addition to the standard
operations. Select one with `$action` in the call's argument; the
remaining keys are sent as that action's payload.

| Action | Route | Call |
| --- | --- | --- |
| `message` | `/rcs/messages` | `client.Rcs().list({ $action: 'message', ... })` |

An action returns that action's OWN response, which is not necessarily a
Rcs record — check the API definition for its shape.

```ts
const result = await client.Rcs().list({
  $action: 'message',
  /* ...the action's own arguments */
})
```

### Operations

#### `list(match: object, ctrl?: object)`

List entities matching the given criteria. Returns an array.

```ts
const results = await client.Rcs().list()
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `RcsEntity` instance with the same client and
options.

#### `client()`

Return the parent `SmsapiSDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## SendernameEntity

```ts
const sendername = client.Sendername()
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

#### `create(data: object, ctrl?: object)`

Create a new entity with the given data.

```ts
const result = await client.Sendername().create({
})
```

#### `list(match: object, ctrl?: object)`

List entities matching the given criteria. Returns an array.

```ts
const results = await client.Sendername().list()
```

#### `load(match: object, ctrl?: object)`

Load a single entity matching the given criteria.

```ts
const result = await client.Sendername().load({ id: 'sendername_id' })
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `SendernameEntity` instance with the same client and
options.

#### `client()`

Return the parent `SmsapiSDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## SendernameStatementEntity

```ts
const sendername_statement = client.SendernameStatement()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `content` | `string` | No |  |
| `statements` | `any[]` | No |  |
| `title` | `string` | No |  |

### Operations

#### `list(match: object, ctrl?: object)`

List entities matching the given criteria. Returns an array.

```ts
const results = await client.SendernameStatement().list()
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `SendernameStatementEntity` instance with the same client and
options.

#### `client()`

Return the parent `SmsapiSDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## SentRcsMessageEntity

```ts
const sent_rcs_message = client.SentRcsMessage()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `content` | `Record<string, any>` | No | RCS message content in RCS JSON format. |
| `phone_number` | `string` | Yes | Recipient phone number (e.g. |
| `sender` | `any` | Yes |  |
| `text` | `string` | No | Plain text message content. |

### Operations

#### `create(data: object, ctrl?: object)`

Create a new entity with the given data.

```ts
const result = await client.SentRcsMessage().create({
  phone_number: 'example_phone_number',
  sender: 'example_sender',
})
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `SentRcsMessageEntity` instance with the same client and
options.

#### `client()`

Return the parent `SmsapiSDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## ShipmentCountryVolumeEntity

```ts
const shipment_country_volume = client.ShipmentCountryVolume()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `country_code` | `string` | No |  |
| `country_limit` | `number` | No |  |
| `country_name` | `string` | No |  |
| `usage` | `number` | No |  |

### Operations

#### `list(match: object, ctrl?: object)`

List entities matching the given criteria. Returns an array.

```ts
const results = await client.ShipmentCountryVolume().list()
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `ShipmentCountryVolumeEntity` instance with the same client and
options.

#### `client()`

Return the parent `SmsapiSDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## ShortUrlEntity

```ts
const short_url = client.ShortUrl()
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

### Actions

This entity exposes custom API actions in addition to the standard
operations. Select one with `$action` in the call's argument; the
remaining keys are sent as that action's payload.

| Action | Route | Call |
| --- | --- | --- |
| `link` | `/short_url/links` | `client.ShortUrl().create({ $action: 'link', ... })` |
| `link` | `/short_url/links` | `client.ShortUrl().list({ $action: 'link', ... })` |

An action returns that action's OWN response, which is not necessarily a
ShortUrl record — check the API definition for its shape.

```ts
const result = await client.ShortUrl().create({
  $action: 'link',
  /* ...the action's own arguments */
})
```

### Operations

#### `create(data: object, ctrl?: object)`

Create a new entity with the given data.

```ts
const result = await client.ShortUrl().create({
})
```

#### `list(match: object, ctrl?: object)`

List entities matching the given criteria. Returns an array.

```ts
const results = await client.ShortUrl().list()
```

#### `load(match: object, ctrl?: object)`

Load a single entity matching the given criteria.

```ts
const result = await client.ShortUrl().load({ id: 'short_url_id' })
```

#### `remove(match: object, ctrl?: object)`

Remove the entity matching the given criteria.

```ts
const result = await client.ShortUrl().remove({ id: 'short_url_id' })
```

#### `update(data: object, ctrl?: object)`

Update an existing entity. The data must include the entity `id`.

```ts
const result = await client.ShortUrl().update({
  id: 'short_url_id',
  // Fields to update
})
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `ShortUrlEntity` instance with the same client and
options.

#### `client()`

Return the parent `SmsapiSDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## SmsdoEntity

```ts
const smsdo = client.Smsdo()
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
| `fallback` | `any[]` | No | Enable fallback in case sms sending fails |
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

#### `create(data: object, ctrl?: object)`

Create a new entity with the given data.

```ts
const result = await client.Smsdo().create({
})
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `SmsdoEntity` instance with the same client and
options.

#### `client()`

Return the parent `SmsapiSDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## SmssendernameEntity

```ts
const smssendername = client.Smssendername()
```

### Operations

#### `create(data: object, ctrl?: object)`

Create a new entity with the given data.

```ts
const result = await client.Smssendername().create({
  sendername_id: 'example_sendername_id',
})
```

#### `remove(match: object, ctrl?: object)`

Remove the entity matching the given criteria.

```ts
const result = await client.Smssendername().remove({ sender: 'sender' })
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `SmssendernameEntity` instance with the same client and
options.

#### `client()`

Return the parent `SmsapiSDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## SmstemplateEntity

```ts
const smstemplate = client.Smstemplate()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | `string` | No |  |

### Operations

#### `remove(match: object, ctrl?: object)`

Remove the entity matching the given criteria.

```ts
const result = await client.Smstemplate().remove({ id: 'id' })
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `SmstemplateEntity` instance with the same client and
options.

#### `client()`

Return the parent `SmsapiSDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## SubuserEntity

```ts
const subuser = client.Subuser()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `active` | `boolean` | No |  |
| `credentials` | `Record<string, any>` | Yes |  |
| `description` | `string` | No |  |
| `id` | `string` | No | Object ID |
| `points` | `Record<string, any>` | No |  |
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

### Actions

This entity exposes custom API actions in addition to the standard
operations. Select one with `$action` in the call's argument; the
remaining keys are sent as that action's payload.

| Action | Route | Call |
| --- | --- | --- |
| `share_sendername` | `/subusers/{id}/shares/sendernames` | `client.Subuser().list({ $action: 'share_sendername', ... })` |
| `share_template` | `/subusers/{id}/shares/templates` | `client.Subuser().list({ $action: 'share_template', ... })` |
| `share_sendername` | `/subusers/{id}/shares/sendernames` | `client.Subuser().update({ $action: 'share_sendername', ... })` |
| `share_template` | `/subusers/{id}/shares/templates` | `client.Subuser().update({ $action: 'share_template', ... })` |

An action returns that action's OWN response, which is not necessarily a
Subuser record — check the API definition for its shape.

```ts
const result = await client.Subuser().list({
  $action: 'share_sendername',
  /* ...the action's own arguments */
})
```

### Operations

#### `create(data: object, ctrl?: object)`

Create a new entity with the given data.

```ts
const result = await client.Subuser().create({
  credentials: {},
})
```

#### `list(match: object, ctrl?: object)`

List entities matching the given criteria. Returns an array.

```ts
const results = await client.Subuser().list()
```

#### `load(match: object, ctrl?: object)`

Load a single entity matching the given criteria.

```ts
const result = await client.Subuser().load({ id: 'subuser_id' })
```

#### `remove(match: object, ctrl?: object)`

Remove the entity matching the given criteria.

```ts
const result = await client.Subuser().remove({ id: 'subuser_id' })
```

#### `update(data: object, ctrl?: object)`

Update an existing entity. The data must include the entity `id`.

```ts
const result = await client.Subuser().update({
  id: 'subuser_id',
  // Fields to update
})
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `SubuserEntity` instance with the same client and
options.

#### `client()`

Return the parent `SmsapiSDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## TemplateEntity

```ts
const template = client.Template()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | `string` | No |  |
| `name` | `string` | No |  |
| `normalize` | `boolean` | No |  |
| `template` | `string` | No |  |

### Operations

#### `create(data: object, ctrl?: object)`

Create a new entity with the given data.

```ts
const result = await client.Template().create({
})
```

#### `list(match: object, ctrl?: object)`

List entities matching the given criteria. Returns an array.

```ts
const results = await client.Template().list()
```

#### `load(match: object, ctrl?: object)`

Load a single entity matching the given criteria.

```ts
const result = await client.Template().load({ id: 'template_id' })
```

#### `update(data: object, ctrl?: object)`

Update an existing entity. The data must include the entity `id`.

```ts
const result = await client.Template().update({
  id: 'template_id',
  // Fields to update
})
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `TemplateEntity` instance with the same client and
options.

#### `client()`

Return the parent `SmsapiSDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## UserRcsSenderCollectionEntity

```ts
const user_rcs_sender_collection = client.UserRcsSenderCollection()
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

#### `list(match: object, ctrl?: object)`

List entities matching the given criteria. Returns an array.

```ts
const results = await client.UserRcsSenderCollection().list()
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `UserRcsSenderCollectionEntity` instance with the same client and
options.

#### `client()`

Return the parent `SmsapiSDK` instance.

#### `entopts()`

Return a copy of the entity options.


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

```ts
const client = new SmsapiSDK({
  feature: {
    audit: { active: true },
    cache: { active: true },
    clienttrack: { active: true },
    cost: { active: true },
    debug: { active: true },
    idempotency: { active: true },
    log: { active: true },
    metrics: { active: true },
    netsim: { active: true },
    paging: { active: true },
    proxy: { active: true },
    ratelimit: { active: true },
    rbac: { active: true },
    retry: { active: true },
    secrets: { active: true },
    streaming: { active: true },
    telemetry: { active: true },
    test: { active: true },
    timeout: { active: true },
    validate: { active: true },
  }
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

