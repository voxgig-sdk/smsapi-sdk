# Smsapi Lua SDK

An MCP server and CLI for the SMSAPI REST API, plus clients in 20 languages and a pandas data layer, generated from SMSAPI's public OpenAPI spec so AI agents can reach SMSAPI the way the official SDKs already let developers.

The Lua SDK for the Smsapi API — an entity-oriented client using Lua conventions.

It exposes the API as capitalised, semantic **Entities** — e.g. `client:Available()` — each with the same small set of operations (`list`, `load`, `create`, `update`, `remove`) instead of raw URL paths and query strings. You call meaning, not endpoints, which keeps the cognitive load low.

> Other languages, the CLI, and MCP server live alongside this one — see
> the [top-level README](../README.md).


## Install
This package is not yet published to LuaRocks. Install it from the
GitHub release tag (`lua/vX.Y.Z`, see [Releases](https://github.com/voxgig-sdk/smsapi-sdk/releases)),
or add the source directory to your `LUA_PATH`:

```bash
export LUA_PATH="path/to/lua/?.lua;path/to/lua/?/init.lua;;"
```


## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record.

### 1. Create a client

```lua
local sdk = require("smsapi_sdk")

local client = sdk.new({
  apikey = os.getenv("SMSAPI_APIKEY"),
})
```

### 2. List available records

Entity operations return `(value, err)`. For `list`, `value` is the
array of records itself — iterate it directly (there is no wrapper).

```lua
local availables, err = client:Available():list()
if err then error(err) end

for _, item in ipairs(availables) do
  print(item)
end
```

### 3. Load a permission

Permission is nested under group, so provide the `group_id`.

```lua
local permission, err = client:Permission():load({ group_id = "example_group_id", username = "example_username", id = "example_id" })
if err then error(err) end
print(permission)
```


## Error handling

Entity operations return `(value, err)`. Check `err` before using
the value:

```lua
local permission, err = client:Permission():load({ group_id = "example", id = "example_id", username = "example" })
if err then error(err) end
```

`direct` follows the same `(value, err)` convention:

```lua
local result, err = client:direct({
  path = "/api/resource/{id}",
  method = "GET",
  params = { id = "example_id" },
})
if err then error(err) end
```


## How-to guides

### Make a direct HTTP request

For endpoints not covered by entity methods:

```lua
local result, err = client:direct({
  path = "/api/resource/{id}",
  method = "GET",
  params = { id = "example" },
})
if err then error(err) end

if result["ok"] then
  print(result["status"])  -- 200
  print(result["data"])    -- response body
end
```

### Prepare a request without sending it

```lua
local fetchdef, err = client:prepare({
  path = "/api/resource/{id}",
  method = "DELETE",
  params = { id = "example" },
})
if err then error(err) end

print(fetchdef["url"])
print(fetchdef["method"])
print(fetchdef["headers"])
```

### Use test mode

Create a mock client for unit testing — no server required:

```lua
local client = sdk.test()

local result, err = client:Permission():load({ id = "test01", group_id = "example", username = "example" })
-- result is the returned data; err is set on failure
```

### Use a custom fetch function

Replace the HTTP transport with your own function:

```lua
local function mock_fetch(url, init)
  return {
    status = 200,
    statusText = "OK",
    headers = {},
    json = function()
      return { id = "mock01" }
    end,
  }, nil
end

local client = sdk.new({
  base = "http://localhost:8080",
  system = {
    fetch = mock_fetch,
  },
})
```

### Run live tests

Create a `.env.local` file at the project root:

```
SMSAPI_TEST_LIVE=TRUE
SMSAPI_APIKEY=<your-key>
```

Then run:

```bash
cd lua && busted test/
```


## Reference

### SmsapiSDK

```lua
local sdk = require("smsapi_sdk")
local client = sdk.new(options)
```

Creates a new SDK client.

| Option | Type | Description |
| --- | --- | --- |
| `apikey` | `string` | API key for authentication. |
| `base` | `string` | Base URL of the API server. |
| `prefix` | `string` | URL path prefix prepended to all requests. |
| `suffix` | `string` | URL path suffix appended to all requests. |
| `feature` | `table` | Feature activation flags. |
| `extend` | `table` | Additional Feature instances to load. |
| `system` | `table` | System overrides (e.g. custom `fetch` function). |

### test

```lua
local client = sdk.test(testopts, sdkopts)
```

Creates a test-mode client with mock transport. Both arguments may be `nil`.

### SmsapiSDK methods

| Method | Signature | Description |
| --- | --- | --- |
| `options_map` | `() -> table` | Deep copy of current SDK options. |
| `get_utility` | `() -> Utility` | Copy of the SDK utility object. |
| `prepare` | `(fetchargs) -> table, err` | Build an HTTP request definition without sending. |
| `direct` | `(fetchargs) -> table, err` | Build and send an HTTP request. |
| `Available` | `(data) -> AvailableEntity` | Create an Available entity instance. |
| `Blacklist` | `(data) -> BlacklistEntity` | Create a Blacklist entity instance. |
| `Callback` | `(data) -> CallbackEntity` | Create a Callback entity instance. |
| `Contact` | `(data) -> ContactEntity` | Create a Contact entity instance. |
| `ContactsField` | `(data) -> ContactsFieldEntity` | Create a ContactsField entity instance. |
| `ContactsFieldOption` | `(data) -> ContactsFieldOptionEntity` | Create a ContactsFieldOption entity instance. |
| `Contactsgroup` | `(data) -> ContactsgroupEntity` | Create a Contactsgroup entity instance. |
| `Contactstrash` | `(data) -> ContactstrashEntity` | Create a Contactstrash entity instance. |
| `FieldAvailable` | `(data) -> FieldAvailableEntity` | Create a FieldAvailable entity instance. |
| `Group` | `(data) -> GroupEntity` | Create a Group entity instance. |
| `MfaCode` | `(data) -> MfaCodeEntity` | Create a MfaCode entity instance. |
| `OptOut` | `(data) -> OptOutEntity` | Create an OptOut entity instance. |
| `OptOutSetting` | `(data) -> OptOutSettingEntity` | Create an OptOutSetting entity instance. |
| `Permission` | `(data) -> PermissionEntity` | Create a Permission entity instance. |
| `Ping` | `(data) -> PingEntity` | Create a Ping entity instance. |
| `Profile` | `(data) -> ProfileEntity` | Create a Profile entity instance. |
| `Rcs` | `(data) -> RcsEntity` | Create a Rcs entity instance. |
| `Sendername` | `(data) -> SendernameEntity` | Create a Sendername entity instance. |
| `SendernameStatement` | `(data) -> SendernameStatementEntity` | Create a SendernameStatement entity instance. |
| `SentRcsMessage` | `(data) -> SentRcsMessageEntity` | Create a SentRcsMessage entity instance. |
| `ShipmentCountryVolume` | `(data) -> ShipmentCountryVolumeEntity` | Create a ShipmentCountryVolume entity instance. |
| `ShortUrl` | `(data) -> ShortUrlEntity` | Create a ShortUrl entity instance. |
| `Smsdo` | `(data) -> SmsdoEntity` | Create a Smsdo entity instance. |
| `Smssendername` | `(data) -> SmssendernameEntity` | Create a Smssendername entity instance. |
| `Smstemplate` | `(data) -> SmstemplateEntity` | Create a Smstemplate entity instance. |
| `Subuser` | `(data) -> SubuserEntity` | Create a Subuser entity instance. |
| `Template` | `(data) -> TemplateEntity` | Create a Template entity instance. |
| `UserRcsSenderCollection` | `(data) -> UserRcsSenderCollectionEntity` | Create an UserRcsSenderCollection entity instance. |

### Entity interface

All entities share the same interface.

| Method | Signature | Description |
| --- | --- | --- |
| `load` | `(reqmatch, ctrl) -> any, err` | Load a single entity by match criteria. |
| `list` | `(reqmatch, ctrl) -> any, err` | List entities matching the criteria. |
| `create` | `(reqdata, ctrl) -> any, err` | Create a new entity. |
| `update` | `(reqdata, ctrl) -> any, err` | Update an existing entity. |
| `remove` | `(reqmatch, ctrl) -> any, err` | Remove an entity. |
| `data_get` | `() -> table` | Get entity data. |
| `data_set` | `(data)` | Set entity data. |
| `match_get` | `() -> table` | Get entity match criteria. |
| `match_set` | `(match)` | Set entity match criteria. |
| `make` | `() -> Entity` | Create a new instance with the same options. |
| `get_name` | `() -> string` | Return the entity name. |

### Result shape

Entity operations return `(value, err)`. The `value` is the operation's
data **directly** — there is no wrapper:

| Operation | `value` |
| --- | --- |
| `load` / `create` / `update` / `remove` | the entity record (a `table`) |
| `list` | an array (`table`) of entity records |

Check `err` first (it is non-`nil` on failure), then use `value`:

    local blacklist, err = client:Blacklist():load()
    if err then error(err) end
    -- blacklist is the loaded record

Only `direct()` returns a response envelope — a `table` with `ok`,
`status`, `headers`, and `data` keys.

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

Create an instance: `local available = client:Available(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `name` | `string` |  |
| `normalize` | `boolean` |  |
| `template` | `string` |  |

#### Example: List

```lua
local availables, err = client:Available():list()
```


### Blacklist

Create an instance: `local blacklist = client:Blacklist(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `create(data)` | Create a new entity with the given data. |
| `load(match)` | Load a single entity by match criteria. |
| `remove(match)` | Remove the matching entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `id` | `string` |  |

#### Example: Load

```lua
local blacklist, err = client:Blacklist():load()
```

#### Example: Create

```lua
local blacklist, err = client:Blacklist():create({
})
```


### Callback

Create an instance: `local callback = client:Callback(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `create(data)` | Create a new entity with the given data. |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |
| `remove(match)` | Remove the matching entity. |
| `update(data)` | Update an existing entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `active` | `boolean` |  |
| `api_version` | `number` | Version of the callback output format. |
| `id` | `string` | Object ID |
| `invalid` | `boolean` |  |
| `receiver` | `table` |  |
| `receiver_type` | `string` |  |
| `type` | `string` |  |
| `url` | `string` | WHATWG URL compliant |

#### Example: Load

```lua
local callback, err = client:Callback():load({ id = "callback_id" })
```

#### Example: List

```lua
local callbacks, err = client:Callback():list()
```

#### Example: Create

```lua
local callback, err = client:Callback():create({
})
```


### Contact

Create an instance: `local contact = client:Contact(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `create(data)` | Create a new entity with the given data. |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |
| `remove(match)` | Remove the matching entity. |
| `update(data)` | Update an existing entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `birthday_date` | `string` |  |
| `city` | `string` |  |
| `collection` | `table` |  |
| `contact_expire_after` | `number` | Contact expire after days |
| `contacts_count` | `number` |  |
| `country` | `string` |  |
| `created_by` | `string` |  |
| `date_created` | `string` |  |
| `date_updated` | `string` |  |
| `description` | `string` |  |
| `email` | `string` |  |
| `first_name` | `string` |  |
| `gender` | `string` |  |
| `group_id` | `string` | Object ID |
| `groups` | `table` |  |
| `id` | `string` | Object ID |
| `idx` | `string` | User provided resource id |
| `last_name` | `string` |  |
| `name` | `string` | Group name |
| `permissions` | `table` |  |
| `phone_number` | `string` |  |
| `read` | `boolean` | Has read permission |
| `send` | `boolean` | Has send permission |
| `size` | `number` |  |
| `source` | `string` |  |
| `type` | `string` |  |
| `username` | `string` |  |
| `value` | `string` |  |
| `write` | `boolean` | Has write permission |

#### Example: Load

```lua
local contact, err = client:Contact():load({ id = "contact_id" })
```

#### Example: List

```lua
local contacts, err = client:Contact():list()
```

#### Example: Create

```lua
local contact, err = client:Contact():create({
  collection = {}, -- table
  contact_expire_after = 1, -- number
  contacts_count = 1, -- number
  created_by = "example_created_by", -- string
  date_created = "example_date_created", -- string
  date_updated = "example_date_updated", -- string
  gender = "example_gender", -- string
  groups = {}, -- table
  id = "example_id", -- string
  name = "example_name", -- string
  size = 1, -- number
})
```


### ContactsField

Create an instance: `local contacts_field = client:ContactsField(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `create(data)` | Create a new entity with the given data. |
| `list(match)` | List entities matching the criteria. |
| `remove(match)` | Remove the matching entity. |
| `update(data)` | Update an existing entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `birthday_date` | `string` |  |
| `city` | `string` |  |
| `contact_expire_after` | `number` | Contact expire after days |
| `contacts_count` | `number` |  |
| `country` | `string` |  |
| `created_by` | `string` |  |
| `date_created` | `string` |  |
| `date_updated` | `string` |  |
| `description` | `string` |  |
| `email` | `string` |  |
| `first_name` | `string` |  |
| `gender` | `string` |  |
| `group_id` | `string` | Object ID |
| `groups` | `table` |  |
| `id` | `string` | Object ID |
| `idx` | `string` | User provided resource id |
| `last_name` | `string` |  |
| `name` | `string` | Group name |
| `permissions` | `table` |  |
| `phone_number` | `string` |  |
| `read` | `boolean` | Has read permission |
| `send` | `boolean` | Has send permission |
| `source` | `string` |  |
| `type` | `string` |  |
| `username` | `string` |  |
| `value` | `string` |  |
| `write` | `boolean` | Has write permission |

#### Example: List

```lua
local contacts_fields, err = client:ContactsField():list()
```

#### Example: Create

```lua
local contacts_field, err = client:ContactsField():create({
  contact_expire_after = 1, -- number
  created_by = "example_created_by", -- string
  date_created = "example_date_created", -- string
  date_updated = "example_date_updated", -- string
  gender = "example_gender", -- string
  groups = {}, -- table
})
```


### ContactsFieldOption

Create an instance: `local contacts_field_option = client:ContactsFieldOption(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `birthday_date` | `string` |  |
| `city` | `string` |  |
| `contact_expire_after` | `number` | Contact expire after days |
| `contacts_count` | `number` |  |
| `country` | `string` |  |
| `created_by` | `string` |  |
| `date_created` | `string` |  |
| `date_updated` | `string` |  |
| `description` | `string` |  |
| `email` | `string` |  |
| `first_name` | `string` |  |
| `gender` | `string` |  |
| `group_id` | `string` | Object ID |
| `groups` | `table` |  |
| `id` | `string` | Object ID |
| `idx` | `string` | User provided resource id |
| `last_name` | `string` |  |
| `name` | `string` | Group name |
| `permissions` | `table` |  |
| `phone_number` | `string` |  |
| `read` | `boolean` | Has read permission |
| `send` | `boolean` | Has send permission |
| `source` | `string` |  |
| `type` | `string` |  |
| `username` | `string` |  |
| `value` | `string` |  |
| `write` | `boolean` | Has write permission |

#### Example: List

```lua
local contacts_field_options, err = client:ContactsFieldOption():list()
```


### Contactsgroup

Create an instance: `local contactsgroup = client:Contactsgroup(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `create(data)` | Create a new entity with the given data. |
| `list(match)` | List entities matching the criteria. |
| `remove(match)` | Remove the matching entity. |
| `update(data)` | Update an existing entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `birthday_date` | `string` |  |
| `city` | `string` |  |
| `contact_expire_after` | `number` | Contact expire after days |
| `contacts_count` | `number` |  |
| `country` | `string` |  |
| `created_by` | `string` |  |
| `date_created` | `string` |  |
| `date_updated` | `string` |  |
| `description` | `string` |  |
| `email` | `string` |  |
| `first_name` | `string` |  |
| `gender` | `string` |  |
| `group_id` | `string` | Object ID |
| `groups` | `table` |  |
| `id` | `string` | Object ID |
| `idx` | `string` | User provided resource id |
| `last_name` | `string` |  |
| `name` | `string` | Group name |
| `permissions` | `table` |  |
| `phone_number` | `string` |  |
| `read` | `boolean` | Has read permission |
| `send` | `boolean` | Has send permission |
| `source` | `string` |  |
| `type` | `string` |  |
| `username` | `string` |  |
| `value` | `string` |  |
| `write` | `boolean` | Has write permission |

#### Example: List

```lua
local contactsgroups, err = client:Contactsgroup():list()
```

#### Example: Create

```lua
local contactsgroup, err = client:Contactsgroup():create({
  contact_expire_after = 1, -- number
  created_by = "example_created_by", -- string
  date_created = "example_date_created", -- string
  date_updated = "example_date_updated", -- string
  gender = "example_gender", -- string
  group_id = "example_group_id", -- string
  groups = {}, -- table
  id = "example_id", -- string
  read = true, -- boolean
  send = true, -- boolean
  username = "example_username", -- string
  write = true, -- boolean
})
```


### Contactstrash

Create an instance: `local contactstrash = client:Contactstrash(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `remove(match)` | Remove the matching entity. |
| `update(data)` | Update an existing entity. |


### FieldAvailable

Create an instance: `local field_available = client:FieldAvailable(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `built_in` | `boolean` |  |
| `id` | `string` | Object ID |
| `name` | `string` |  |
| `options` | `table` |  |
| `type` | `string` |  |

#### Example: List

```lua
local field_availables, err = client:FieldAvailable():list()
```


### Group

Create an instance: `local group = client:Group(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `load(match)` | Load a single entity by match criteria. |
| `update(data)` | Update an existing entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `contact_expire_after` | `number` | Contact expire after days |
| `contacts_count` | `number` |  |
| `created_by` | `string` |  |
| `date_created` | `string` |  |
| `date_updated` | `string` |  |
| `description` | `string` |  |
| `id` | `string` | Object ID |
| `idx` | `string` | User provided resource id |
| `name` | `string` | Group name |
| `permissions` | `table` |  |

#### Example: Load

```lua
local group, err = client:Group():load({ id = "group_id" })
```


### MfaCode

Create an instance: `local mfa_code = client:MfaCode(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `create(data)` | Create a new entity with the given data. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `content` | `string` | Custom content that must contain placeholder [%code%] |
| `fast` | `any` |  |
| `from` | `string` | Sendername |
| `phone_number` | `string` |  |

#### Example: Create

```lua
local mfa_code, err = client:MfaCode():create({
  phone_number = "example_phone_number", -- string
})
```


### OptOut

Create an instance: `local opt_out = client:OptOut(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `remove(match)` | Remove the matching entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `date` | `string` |  |
| `id` | `string` |  |
| `links` | `table` |  |
| `phoneNumber` | `number` |  |

#### Example: List

```lua
local opt_outs, err = client:OptOut():list()
```


### OptOutSetting

Create an instance: `local opt_out_setting = client:OptOutSetting(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `load(match)` | Load a single entity by match criteria. |
| `update(data)` | Update an existing entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `brand` | `string` |  |

#### Example: Load

```lua
local opt_out_setting, err = client:OptOutSetting():load()
```


### Permission

Create an instance: `local permission = client:Permission(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `create(data)` | Create a new entity with the given data. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `group_id` | `string` | Object ID |
| `id` | `string` |  |
| `read` | `boolean` | Has read permission |
| `send` | `boolean` | Has send permission |
| `username` | `string` |  |
| `write` | `boolean` | Has write permission |

#### Example: Load

```lua
local permission, err = client:Permission():load({ id = "permission_id", group_id = "group_id", username = "username" })
```

#### Example: Create

```lua
local permission, err = client:Permission():create({
  group_id = "example_group_id", -- string
  read = true, -- boolean
  send = true, -- boolean
  username = "example_username", -- string
  write = true, -- boolean
})
```


### Ping

Create an instance: `local ping = client:Ping(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `authorized` | `boolean` |  |
| `unavailable` | `table` |  |

#### Example: List

```lua
local pings, err = client:Ping():list()
```


### Profile

Create an instance: `local profile = client:Profile(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `email` | `string` |  |
| `name` | `string` |  |
| `payment_type` | `string` |  |
| `phone_number` | `number` |  |
| `points` | `number` |  |
| `user_type` | `string` |  |
| `username` | `string` |  |

#### Example: Load

```lua
local profile, err = client:Profile():load()
```

#### Example: List

```lua
local profiles, err = client:Profile():list()
```


### Rcs

Create an instance: `local rcs = client:Rcs(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Example: List

```lua
local rcss, err = client:Rcs():list()
```


### Sendername

Create an instance: `local sendername = client:Sendername(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `create(data)` | Create a new entity with the given data. |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `created_at` | `string` |  |
| `id` | `string` |  |
| `is_default` | `boolean` |  |
| `sender` | `string` | Sendername |
| `status` | `string` |  |

#### Example: Load

```lua
local sendername, err = client:Sendername():load({ id = "sendername_id" })
```

#### Example: List

```lua
local sendernames, err = client:Sendername():list()
```

#### Example: Create

```lua
local sendername, err = client:Sendername():create({
})
```


### SendernameStatement

Create an instance: `local sendername_statement = client:SendernameStatement(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `content` | `string` |  |
| `statements` | `table` |  |
| `title` | `string` |  |

#### Example: List

```lua
local sendername_statements, err = client:SendernameStatement():list()
```


### SentRcsMessage

Create an instance: `local sent_rcs_message = client:SentRcsMessage(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `create(data)` | Create a new entity with the given data. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `content` | `table` | RCS message content in RCS JSON format. |
| `phone_number` | `string` | Recipient phone number (e.g. |
| `sender` | `any` |  |
| `text` | `string` | Plain text message content. |

#### Example: Create

```lua
local sent_rcs_message, err = client:SentRcsMessage():create({
  phone_number = "example_phone_number", -- string
  sender = "example_sender", -- any
})
```


### ShipmentCountryVolume

Create an instance: `local shipment_country_volume = client:ShipmentCountryVolume(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `country_code` | `string` |  |
| `country_limit` | `number` |  |
| `country_name` | `string` |  |
| `usage` | `number` |  |

#### Example: List

```lua
local shipment_country_volumes, err = client:ShipmentCountryVolume():list()
```


### ShortUrl

Create an instance: `local short_url = client:ShortUrl(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `create(data)` | Create a new entity with the given data. |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |
| `remove(match)` | Remove the matching entity. |
| `update(data)` | Update an existing entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `description` | `string` |  |
| `expire` | `string` |  |
| `filename` | `string` |  |
| `hits` | `number` |  |
| `hits_unique` | `number` |  |
| `id` | `string` |  |
| `name` | `string` |  |
| `short_url` | `string` | WHATWG URL compliant |
| `type` | `string` |  |
| `url` | `string` | WHATWG URL compliant |

#### Example: Load

```lua
local short_url, err = client:ShortUrl():load({ id = "short_url_id" })
```

#### Example: List

```lua
local short_urls, err = client:ShortUrl():list()
```

#### Example: Create

```lua
local short_url, err = client:ShortUrl():create({
})
```


### Smsdo

Create an instance: `local smsdo = client:Smsdo(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `create(data)` | Create a new entity with the given data. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `allow_duplicates` | `number` | When parameter allow_duplicates is set to "1" allows to send message to duplicated numbers in one request (useful i.e. |
| `check_idx` | `any` | When parameter check_idx is set to „1” prevents from sending more than one message with the same idx in last 24h. |
| `date` | `any` | Date in UNIX timestamp (&date=1287734110) or in ISO 8601 (&date=2012-05-10T08:40:27+00:00) when message will be sent (&date=1287734110). |
| `date_validate` | `number` | When parameter date_validate is set to "1" checks if date if given in proper format. |
| `details` | `any` | When details parameter is set to "1" more details in response will be displayed (message length and sms count). |
| `encoding` | `string` | This parameter describes the encoding of the message text. |
| `expiration_date` | `any` | Message expiration date (in UNIX timestamp or in ISO 8601) is a date after which message won't be delivered if it wasn't delivered yet. |
| `fallback` | `table` | Enable fallback in case sms sending fails |
| `fast` | `number` | Setting this parameter to „1” will result in sending message with the highest priority which ensures the quickest possible time of delivery. |
| `flash` | `number` | Sending a message in flash mode can be activated by setting this parameter to "1". |
| `format` | `string` | Parameter &format=json causes, that response is sending in JSON format. |
| `from` | `string` | Name of the sender. |
| `group` | `string` | Name of the group from the contacts database to which message should be sent to. |
| `idx` | `string` | Optional custom value sent with SMS and sent back in CALLBACK. |
| `max_parts` | `number` | Defines maximum message parts allowed, maximum value allowed is 6. |
| `message` | `string` | The message text. |
| `normalize` | `number` | When parameter normalize is set to „1” special chars in message will be replaced with their equivalents (ê-e, ñ-n, ý-y ...). |
| `notify_url` | `string` | Parameter allows to set CALLBACK URL for message from request. |
| `test` | `any` | When parameter test is set to "1" message won't be sent but response will be displayed, there is no charge for such test messages. |
| `time_restriction` | `string` | Sets the behavior when you try to ship in hours / dates that do not match the settings in your account. |
| `to` | `string` | Recipients' mobile phone numbers (i.e. |

#### Example: Create

```lua
local smsdo, err = client:Smsdo():create({
})
```


### Smssendername

Create an instance: `local smssendername = client:Smssendername(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `create(data)` | Create a new entity with the given data. |
| `remove(match)` | Remove the matching entity. |

#### Example: Create

```lua
local smssendername, err = client:Smssendername():create({
  sendername_id = "example_sendername_id", -- string
})
```


### Smstemplate

Create an instance: `local smstemplate = client:Smstemplate(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `remove(match)` | Remove the matching entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `id` | `string` |  |


### Subuser

Create an instance: `local subuser = client:Subuser(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `create(data)` | Create a new entity with the given data. |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |
| `remove(match)` | Remove the matching entity. |
| `update(data)` | Update an existing entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `active` | `boolean` |  |
| `credentials` | `table` |  |
| `description` | `string` |  |
| `id` | `string` | Object ID |
| `points` | `table` |  |
| `username` | `string` |  |

#### Example: Load

```lua
local subuser, err = client:Subuser():load({ id = "subuser_id" })
```

#### Example: List

```lua
local subusers, err = client:Subuser():list()
```

#### Example: Create

```lua
local subuser, err = client:Subuser():create({
  credentials = {}, -- table
})
```


### Template

Create an instance: `local template = client:Template(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `create(data)` | Create a new entity with the given data. |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |
| `update(data)` | Update an existing entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `id` | `string` |  |
| `name` | `string` |  |
| `normalize` | `boolean` |  |
| `template` | `string` |  |

#### Example: Load

```lua
local template, err = client:Template():load({ id = "template_id" })
```

#### Example: List

```lua
local templates, err = client:Template():list()
```

#### Example: Create

```lua
local template, err = client:Template():create({
})
```


### UserRcsSenderCollection

Create an instance: `local user_rcs_sender_collection = client:UserRcsSenderCollection(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `deliveredAt` | `string` |  |
| `expiredAt` | `string` |  |
| `id` | `string` | Object ID |
| `interface` | `string` | Interface through which the message was sent (www, api, ...). |
| `messageType` | `string` | RCS message type (basic, single, ...). |
| `readAt` | `string` |  |
| `recipient` | `string` | Recipient phone number (without +). |
| `sender` | `string` | Sender name |
| `senderId` | `string` | Sender id |
| `sentAt` | `string` |  |

#### Example: List

```lua
local user_rcs_sender_collections, err = client:UserRcsSenderCollection():list()
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

Features are the extension mechanism. A feature is a Lua table
with hook methods named after pipeline stages (e.g. `PrePoint`,
`PreSpec`). Each method receives the context.

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

### Data as tables

The Lua SDK uses plain Lua tables throughout rather than typed
objects. This mirrors the dynamic nature of the API and keeps the
SDK flexible — no code generation is needed when the API schema
changes.

Use `helpers.to_map()` to safely validate that a value is a table.

### Module structure

```
lua/
├── smsapi_sdk.lua    -- Main SDK module
├── config.lua               -- Configuration
├── schema.lua               -- Generated option + entity specs
├── features.lua             -- Feature factory
├── core/                    -- Core types and context
├── entity/                  -- Entity implementations
├── feature/                 -- Built-in features (Base, Test, Log)
├── utility/                 -- Utility functions and struct library
└── test/                    -- Test suites
```

The main module (`smsapi_sdk`) exports the SDK constructor
and test helper. Import entity or utility modules directly only
when needed.

### Entity state

Entity instances are stateful. After a successful `load`, the entity
stores the returned data and match criteria internally.

```lua
local permission = client:Permission()
permission:load({ group_id = "example", id = "example_id", username = "example" })

-- permission:data_get() now returns the permission data from the last load
-- permission:match_get() returns the last match criteria
```

Call `make()` to create a fresh instance with the same configuration
but no stored state.

### Direct vs entity access

The entity interface handles URL construction, parameter placement,
and response parsing automatically. Use it for standard CRUD operations.

`direct()` gives full control over the HTTP request. Use it for
non-standard endpoints, bulk operations, or any path not modelled as
an entity. `prepare()` builds the request without sending it — useful
for debugging or custom transport.


## Full Reference

See [REFERENCE.md](REFERENCE.md) for complete API reference
documentation including all method signatures, entity field schemas,
and detailed usage examples.
