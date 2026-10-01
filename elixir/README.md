# Smsapi Elixir SDK

An MCP server and CLI for the SMSAPI REST API, plus clients in 13 languages and a pandas data layer, generated from SMSAPI's public OpenAPI spec so AI agents can reach SMSAPI the way the official SDKs already let developers.

The Elixir SDK for the Smsapi API — an entity-oriented client
following idiomatic, functional Elixir conventions.

The SDK exposes the API as capitalised, semantic **Entities** — for example `Smsapi.available(sdk)` — each
carrying a small, uniform set of operations (`list`, `load`, `create`, `update`, `remove`) instead of raw URL
paths and query strings. You work with named resources and verbs, which
keeps the cognitive load low.

> Other languages, the CLI, and MCP server live alongside this one — see
> the [top-level README](../README.md).


## Install
This package is not yet published to [Hex](https://hex.pm). Install it from
the GitHub release tag (`elixir/vX.Y.Z`, see [Releases](https://github.com/voxgig-sdk/smsapi-sdk/releases))
by adding a git dependency to your `mix.exs`:

```elixir
def deps do
  [
    {:smsapi, git: "https://github.com/voxgig-sdk/smsapi-sdk.git", tag: "elixir/vX.Y.Z"}
  ]
end
```

Or from a local source checkout:

```elixir
def deps do
  [
    {:smsapi, path: "../smsapi-sdk/elixir"}
  ]
end
```

Then run `mix deps.get`.


## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record.

### 1. Create a client

```elixir
alias Smsapi.Helpers, as: H

sdk = Smsapi.new(H.deep(%{"apikey" => System.get_env("SMSAPI_APIKEY")}))
```

### 2. List available records

`list/2` returns a list value node and raises on error.

```elixir
try do
  available = Smsapi.available(sdk)
  records = Smsapi.Entity.Available.list(available)
  IO.inspect(records)
rescue
  err -> IO.puts("list failed: " <> inspect(err))
end
```

### 3. Load a permission

Permission is nested under group, so provide the `group_id`.
`load/2` returns the bare record and raises on error.

```elixir
try do
  permission = Smsapi.permission(sdk)
  record = Smsapi.Entity.Permission.load(permission, H.deep(%{"group_id" => "example_group_id", "username" => "example_username", "id" => "example_id"}))
  IO.inspect(record)
rescue
  err -> IO.puts("load failed: " <> inspect(err))
end
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

For endpoints not covered by entity operations. `direct/2` never raises —
it returns a result node you branch on with `Voxgig.Struct.getprop/2`:

```elixir
alias Voxgig.Struct, as: S
alias Smsapi.Helpers, as: H

result = Smsapi.direct(sdk, H.deep(%{
  "path" => "/api/resource/{id}",
  "method" => "GET",
  "params" => %{"id" => "example"}
}))

if S.getprop(result, "ok") do
  IO.inspect(S.getprop(result, "status"))  # 200
  IO.inspect(S.getprop(result, "data"))    # response body
else
  # A non-2xx response carries status + data (the error body); a
  # transport-level failure carries err instead.
  IO.inspect(S.getprop(result, "err"))
end
```

### Prepare a request without sending it

```elixir
alias Smsapi.Helpers, as: H

# prepare/2 returns the fetch definition and raises on error.
fetchdef = Smsapi.prepare(sdk, H.deep(%{
  "path" => "/api/resource/{id}",
  "method" => "DELETE",
  "params" => %{"id" => "example"}
}))

IO.inspect(Voxgig.Struct.getprop(fetchdef, "url"))
IO.inspect(Voxgig.Struct.getprop(fetchdef, "method"))
```

### Use test mode

Create a mock client for unit testing — no server required:

```elixir
alias Smsapi.Helpers, as: H

sdk = Smsapi.test()

# Entity ops return the bare record (raise on error).
permission = Smsapi.permission(sdk)
record = Smsapi.Entity.Permission.load(permission, H.deep(%{"id" => "test01"}))
IO.inspect(record)
```

### Use a custom fetch function

Replace the HTTP transport with your own function. It receives `(url,
fetchdef)` and returns a `{response, error}` tuple:

```elixir
alias Voxgig.Struct, as: S
alias Smsapi.Helpers, as: H

mock_fetch = fn _url, _fetchdef ->
  response = H.deep(%{
    "status" => 200,
    "statusText" => "OK",
    "headers" => %{},
    "json" => fn -> %{"id" => "mock01"} end
  })
  {response, nil}
end

sdk = Smsapi.new(H.deep(%{
  "base" => "http://localhost:8080",
  "system" => %{"fetch" => mock_fetch}
}))
```

### Run live tests

Create a `.env.local` file at the project root:

```
SMSAPI_TEST_LIVE=TRUE
SMSAPI_APIKEY=<your-key>
```

Then run:

```bash
cd elixir && mix test
```


## Reference

### Smsapi

```elixir
sdk = Smsapi.new(options)
```

Creates a new SDK client. `options` is a struct value node — build one from a
native map with `Smsapi.Helpers.deep/1`.

| Option | Type | Description |
| --- | --- | --- |
| `apikey` | `String.t()` | API key for authentication. |
| `base` | `String.t()` | Base URL of the API server. |
| `prefix` | `String.t()` | URL path prefix prepended to all requests. |
| `suffix` | `String.t()` | URL path suffix appended to all requests. |
| `feature` | `map()` | Feature activation flags. |
| `extend` | `list()` | Additional feature instances to load. |
| `system` | `map()` | System overrides (e.g. custom `fetch` function). |

### test

```elixir
sdk = Smsapi.test(testopts, sdkopts)
```

Creates a test-mode client with mock transport. Both arguments may be `nil`.

### Smsapi functions

| Function | Signature | Description |
| --- | --- | --- |
| `options_map` | `(client) :: map()` | Deep copy of current SDK options. |
| `get_utility` | `(client) :: map()` | The SDK utility node. |
| `prepare` | `(client, fetchargs) :: map()` | Build an HTTP request definition without sending. Raises on error. |
| `direct` | `(client, fetchargs) :: map()` | Build and send an HTTP request. Returns a result node (branch on `ok`). |
| `available` | `(client, entopts \\ nil) :: entity` | Create an Available entity handle. |
| `blacklist` | `(client, entopts \\ nil) :: entity` | Create a Blacklist entity handle. |
| `callback` | `(client, entopts \\ nil) :: entity` | Create a Callback entity handle. |
| `contact` | `(client, entopts \\ nil) :: entity` | Create a Contact entity handle. |
| `contacts_field` | `(client, entopts \\ nil) :: entity` | Create a ContactsField entity handle. |
| `contacts_field_option` | `(client, entopts \\ nil) :: entity` | Create a ContactsFieldOption entity handle. |
| `contactsgroup` | `(client, entopts \\ nil) :: entity` | Create a Contactsgroup entity handle. |
| `contactstrash` | `(client, entopts \\ nil) :: entity` | Create a Contactstrash entity handle. |
| `field_available` | `(client, entopts \\ nil) :: entity` | Create a FieldAvailable entity handle. |
| `group` | `(client, entopts \\ nil) :: entity` | Create a Group entity handle. |
| `mfa_code` | `(client, entopts \\ nil) :: entity` | Create a MfaCode entity handle. |
| `opt_out` | `(client, entopts \\ nil) :: entity` | Create an OptOut entity handle. |
| `opt_out_setting` | `(client, entopts \\ nil) :: entity` | Create an OptOutSetting entity handle. |
| `permission` | `(client, entopts \\ nil) :: entity` | Create a Permission entity handle. |
| `ping` | `(client, entopts \\ nil) :: entity` | Create a Ping entity handle. |
| `profile` | `(client, entopts \\ nil) :: entity` | Create a Profile entity handle. |
| `rcs` | `(client, entopts \\ nil) :: entity` | Create a Rcs entity handle. |
| `sendername` | `(client, entopts \\ nil) :: entity` | Create a Sendername entity handle. |
| `sendername_statement` | `(client, entopts \\ nil) :: entity` | Create a SendernameStatement entity handle. |
| `sent_rcs_message` | `(client, entopts \\ nil) :: entity` | Create a SentRcsMessage entity handle. |
| `shipment_country_volume` | `(client, entopts \\ nil) :: entity` | Create a ShipmentCountryVolume entity handle. |
| `short_url` | `(client, entopts \\ nil) :: entity` | Create a ShortUrl entity handle. |
| `smsdo` | `(client, entopts \\ nil) :: entity` | Create a Smsdo entity handle. |
| `smssendername` | `(client, entopts \\ nil) :: entity` | Create a Smssendername entity handle. |
| `smstemplate` | `(client, entopts \\ nil) :: entity` | Create a Smstemplate entity handle. |
| `subuser` | `(client, entopts \\ nil) :: entity` | Create a Subuser entity handle. |
| `template` | `(client, entopts \\ nil) :: entity` | Create a Template entity handle. |
| `user_rcs_sender_collection` | `(client, entopts \\ nil) :: entity` | Create an UserRcsSenderCollection entity handle. |

### Entity interface

Every entity's `Smsapi.Entity.<Name>` module shares the same interface.

| Function | Signature | Description |
| --- | --- | --- |
| `load` | `(entity, reqmatch, ctrl \\ nil) :: map()` | Load a single entity by match criteria. Raises on error. |
| `list` | `(entity, reqmatch \\ nil, ctrl \\ nil) :: list()` | List entities matching the criteria. Raises on error. |
| `create` | `(entity, reqdata, ctrl \\ nil) :: map()` | Create a new entity. Raises on error. |
| `update` | `(entity, reqdata, ctrl \\ nil) :: map()` | Update an existing entity. Raises on error. |
| `remove` | `(entity, reqmatch \\ nil, ctrl \\ nil) :: map()` | Remove an entity. Raises on error. |
| `data_get` | `(entity) :: map()` | Get entity data. |
| `data_set` | `(entity, data)` | Set entity data. |
| `match_get` | `(entity) :: map()` | Get entity match criteria. |
| `match_set` | `(entity, match)` | Set entity match criteria. |
| `make` | `(entity) :: entity` | Create a new handle with the same options. |
| `get_name` | `(entity) :: String.t()` | Return the entity name. |

### Result shape

Entity operations return the bare result data (a value node — a map for
single-entity ops, a list for `list`) and raise a `Smsapi.Error` on
failure. Wrap calls in `try`/`rescue` to handle errors.

The `direct/2` escape hatch never raises — it returns a result node you
branch on via `Voxgig.Struct.getprop(result, "ok")`:

| Key | Type | Description |
| --- | --- | --- |
| `ok` | `boolean()` | `true` if the HTTP status is 2xx. |
| `status` | `integer()` | HTTP status code. |
| `headers` | `map()` | Response headers. |
| `data` | `any()` | Parsed JSON response body. |

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

Every operation lives on the entity's `Smsapi.Entity.<Name>` module and
takes an entity handle built from the client:


### Available

Create a handle: `available = Smsapi.available(sdk)`

#### Operations

| Method | Description |
| --- | --- |
| `list(entity)` | List entities, optionally matching the given criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `name` | `String.t()` |  |
| `normalize` | `boolean()` |  |
| `template` | `String.t()` |  |

#### Example: List

```elixir
available = Smsapi.available(sdk)
records = Smsapi.Entity.Available.list(available)
```


### Blacklist

Create a handle: `blacklist = Smsapi.blacklist(sdk)`

#### Operations

| Method | Description |
| --- | --- |
| `create(entity, data)` | Create a new entity with the given data. |
| `load(entity, match)` | Load a single entity by match criteria. |
| `remove(entity, match)` | Remove the matching entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `id` | `String.t()` |  |

#### Example: Load

```elixir
blacklist = Smsapi.blacklist(sdk)
record = Smsapi.Entity.Blacklist.load(blacklist, Smsapi.Helpers.deep(%{}))
```

#### Example: Create

```elixir
blacklist = Smsapi.blacklist(sdk)
record = Smsapi.Entity.Blacklist.create(blacklist, Smsapi.Helpers.deep(%{
}))
```


### Callback

Create a handle: `callback = Smsapi.callback(sdk)`

#### Operations

| Method | Description |
| --- | --- |
| `create(entity, data)` | Create a new entity with the given data. |
| `list(entity)` | List entities, optionally matching the given criteria. |
| `load(entity, match)` | Load a single entity by match criteria. |
| `remove(entity, match)` | Remove the matching entity. |
| `update(entity, data)` | Update an existing entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `active` | `boolean()` |  |
| `api_version` | `integer()` | Version of the callback output format. |
| `id` | `String.t()` | Object ID |
| `invalid` | `boolean()` |  |
| `receiver` | `map()` |  |
| `receiver_type` | `String.t()` |  |
| `type` | `String.t()` |  |
| `url` | `String.t()` | WHATWG URL compliant |

#### Example: Load

```elixir
callback = Smsapi.callback(sdk)
record = Smsapi.Entity.Callback.load(callback, Smsapi.Helpers.deep(%{"id" => "callback_id"}))
```

#### Example: List

```elixir
callback = Smsapi.callback(sdk)
records = Smsapi.Entity.Callback.list(callback)
```

#### Example: Create

```elixir
callback = Smsapi.callback(sdk)
record = Smsapi.Entity.Callback.create(callback, Smsapi.Helpers.deep(%{
}))
```


### Contact

Create a handle: `contact = Smsapi.contact(sdk)`

#### Operations

| Method | Description |
| --- | --- |
| `create(entity, data)` | Create a new entity with the given data. |
| `list(entity)` | List entities, optionally matching the given criteria. |
| `load(entity, match)` | Load a single entity by match criteria. |
| `remove(entity, match)` | Remove the matching entity. |
| `update(entity, data)` | Update an existing entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `birthday_date` | `String.t()` |  |
| `city` | `String.t()` |  |
| `collection` | `list()` |  |
| `contact_expire_after` | `integer()` | Contact expire after days |
| `contacts_count` | `integer()` |  |
| `country` | `String.t()` |  |
| `created_by` | `String.t()` |  |
| `date_created` | `String.t()` |  |
| `date_updated` | `String.t()` |  |
| `description` | `String.t()` |  |
| `email` | `String.t()` |  |
| `first_name` | `String.t()` |  |
| `gender` | `String.t()` |  |
| `group_id` | `String.t()` | Object ID |
| `groups` | `list()` |  |
| `id` | `String.t()` | Object ID |
| `idx` | `String.t()` | User provided resource id |
| `last_name` | `String.t()` |  |
| `name` | `String.t()` | Group name |
| `permissions` | `list()` |  |
| `phone_number` | `String.t()` |  |
| `read` | `boolean()` | Has read permission |
| `send` | `boolean()` | Has send permission |
| `size` | `integer()` |  |
| `source` | `String.t()` |  |
| `type` | `String.t()` |  |
| `username` | `String.t()` |  |
| `value` | `String.t()` |  |
| `write` | `boolean()` | Has write permission |

#### Example: Load

```elixir
contact = Smsapi.contact(sdk)
record = Smsapi.Entity.Contact.load(contact, Smsapi.Helpers.deep(%{"id" => "contact_id"}))
```

#### Example: List

```elixir
contact = Smsapi.contact(sdk)
records = Smsapi.Entity.Contact.list(contact)
```

#### Example: Create

```elixir
contact = Smsapi.contact(sdk)
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


### ContactsField

Create a handle: `contacts_field = Smsapi.contacts_field(sdk)`

#### Operations

| Method | Description |
| --- | --- |
| `create(entity, data)` | Create a new entity with the given data. |
| `list(entity)` | List entities, optionally matching the given criteria. |
| `remove(entity, match)` | Remove the matching entity. |
| `update(entity, data)` | Update an existing entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `birthday_date` | `String.t()` |  |
| `city` | `String.t()` |  |
| `contact_expire_after` | `integer()` | Contact expire after days |
| `contacts_count` | `integer()` |  |
| `country` | `String.t()` |  |
| `created_by` | `String.t()` |  |
| `date_created` | `String.t()` |  |
| `date_updated` | `String.t()` |  |
| `description` | `String.t()` |  |
| `email` | `String.t()` |  |
| `first_name` | `String.t()` |  |
| `gender` | `String.t()` |  |
| `group_id` | `String.t()` | Object ID |
| `groups` | `list()` |  |
| `id` | `String.t()` | Object ID |
| `idx` | `String.t()` | User provided resource id |
| `last_name` | `String.t()` |  |
| `name` | `String.t()` | Group name |
| `permissions` | `list()` |  |
| `phone_number` | `String.t()` |  |
| `read` | `boolean()` | Has read permission |
| `send` | `boolean()` | Has send permission |
| `source` | `String.t()` |  |
| `type` | `String.t()` |  |
| `username` | `String.t()` |  |
| `value` | `String.t()` |  |
| `write` | `boolean()` | Has write permission |

#### Example: List

```elixir
contacts_field = Smsapi.contacts_field(sdk)
records = Smsapi.Entity.ContactsField.list(contacts_field)
```

#### Example: Create

```elixir
contacts_field = Smsapi.contacts_field(sdk)
record = Smsapi.Entity.ContactsField.create(contacts_field, Smsapi.Helpers.deep(%{
  "contact_expire_after" => 1,  # integer()
  "created_by" => "example_created_by",  # String.t()
  "date_created" => "example_date_created",  # String.t()
  "date_updated" => "example_date_updated",  # String.t()
  "gender" => "example_gender",  # String.t()
  "groups" => [],  # list()
}))
```


### ContactsFieldOption

Create a handle: `contacts_field_option = Smsapi.contacts_field_option(sdk)`

#### Operations

| Method | Description |
| --- | --- |
| `list(entity)` | List entities, optionally matching the given criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `birthday_date` | `String.t()` |  |
| `city` | `String.t()` |  |
| `contact_expire_after` | `integer()` | Contact expire after days |
| `contacts_count` | `integer()` |  |
| `country` | `String.t()` |  |
| `created_by` | `String.t()` |  |
| `date_created` | `String.t()` |  |
| `date_updated` | `String.t()` |  |
| `description` | `String.t()` |  |
| `email` | `String.t()` |  |
| `first_name` | `String.t()` |  |
| `gender` | `String.t()` |  |
| `group_id` | `String.t()` | Object ID |
| `groups` | `list()` |  |
| `id` | `String.t()` | Object ID |
| `idx` | `String.t()` | User provided resource id |
| `last_name` | `String.t()` |  |
| `name` | `String.t()` | Group name |
| `permissions` | `list()` |  |
| `phone_number` | `String.t()` |  |
| `read` | `boolean()` | Has read permission |
| `send` | `boolean()` | Has send permission |
| `source` | `String.t()` |  |
| `type` | `String.t()` |  |
| `username` | `String.t()` |  |
| `value` | `String.t()` |  |
| `write` | `boolean()` | Has write permission |

#### Example: List

```elixir
contacts_field_option = Smsapi.contacts_field_option(sdk)
records = Smsapi.Entity.ContactsFieldOption.list(contacts_field_option)
```


### Contactsgroup

Create a handle: `contactsgroup = Smsapi.contactsgroup(sdk)`

#### Operations

| Method | Description |
| --- | --- |
| `create(entity, data)` | Create a new entity with the given data. |
| `list(entity)` | List entities, optionally matching the given criteria. |
| `remove(entity, match)` | Remove the matching entity. |
| `update(entity, data)` | Update an existing entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `birthday_date` | `String.t()` |  |
| `city` | `String.t()` |  |
| `contact_expire_after` | `integer()` | Contact expire after days |
| `contacts_count` | `integer()` |  |
| `country` | `String.t()` |  |
| `created_by` | `String.t()` |  |
| `date_created` | `String.t()` |  |
| `date_updated` | `String.t()` |  |
| `description` | `String.t()` |  |
| `email` | `String.t()` |  |
| `first_name` | `String.t()` |  |
| `gender` | `String.t()` |  |
| `group_id` | `String.t()` | Object ID |
| `groups` | `list()` |  |
| `id` | `String.t()` | Object ID |
| `idx` | `String.t()` | User provided resource id |
| `last_name` | `String.t()` |  |
| `name` | `String.t()` | Group name |
| `permissions` | `list()` |  |
| `phone_number` | `String.t()` |  |
| `read` | `boolean()` | Has read permission |
| `send` | `boolean()` | Has send permission |
| `source` | `String.t()` |  |
| `type` | `String.t()` |  |
| `username` | `String.t()` |  |
| `value` | `String.t()` |  |
| `write` | `boolean()` | Has write permission |

#### Example: List

```elixir
contactsgroup = Smsapi.contactsgroup(sdk)
records = Smsapi.Entity.Contactsgroup.list(contactsgroup)
```

#### Example: Create

```elixir
contactsgroup = Smsapi.contactsgroup(sdk)
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


### Contactstrash

Create a handle: `contactstrash = Smsapi.contactstrash(sdk)`

#### Operations

| Method | Description |
| --- | --- |
| `remove(entity, match)` | Remove the matching entity. |
| `update(entity, data)` | Update an existing entity. |


### FieldAvailable

Create a handle: `field_available = Smsapi.field_available(sdk)`

#### Operations

| Method | Description |
| --- | --- |
| `list(entity)` | List entities, optionally matching the given criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `built_in` | `boolean()` |  |
| `id` | `String.t()` | Object ID |
| `name` | `String.t()` |  |
| `options` | `list()` |  |
| `type` | `String.t()` |  |

#### Example: List

```elixir
field_available = Smsapi.field_available(sdk)
records = Smsapi.Entity.FieldAvailable.list(field_available)
```


### Group

Create a handle: `group = Smsapi.group(sdk)`

#### Operations

| Method | Description |
| --- | --- |
| `load(entity, match)` | Load a single entity by match criteria. |
| `update(entity, data)` | Update an existing entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `contact_expire_after` | `integer()` | Contact expire after days |
| `contacts_count` | `integer()` |  |
| `created_by` | `String.t()` |  |
| `date_created` | `String.t()` |  |
| `date_updated` | `String.t()` |  |
| `description` | `String.t()` |  |
| `id` | `String.t()` | Object ID |
| `idx` | `String.t()` | User provided resource id |
| `name` | `String.t()` | Group name |
| `permissions` | `list()` |  |

#### Example: Load

```elixir
group = Smsapi.group(sdk)
record = Smsapi.Entity.Group.load(group, Smsapi.Helpers.deep(%{"id" => "group_id"}))
```


### MfaCode

Create a handle: `mfa_code = Smsapi.mfa_code(sdk)`

#### Operations

| Method | Description |
| --- | --- |
| `create(entity, data)` | Create a new entity with the given data. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `content` | `String.t()` | Custom content that must contain placeholder [%code%] |
| `fast` | `any()` |  |
| `from` | `String.t()` | Sendername |
| `phone_number` | `String.t()` |  |

#### Example: Create

```elixir
mfa_code = Smsapi.mfa_code(sdk)
record = Smsapi.Entity.MfaCode.create(mfa_code, Smsapi.Helpers.deep(%{
  "phone_number" => "example_phone_number",  # String.t()
}))
```


### OptOut

Create a handle: `opt_out = Smsapi.opt_out(sdk)`

#### Operations

| Method | Description |
| --- | --- |
| `list(entity)` | List entities, optionally matching the given criteria. |
| `remove(entity, match)` | Remove the matching entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `date` | `String.t()` |  |
| `id` | `String.t()` |  |
| `links` | `list()` |  |
| `phoneNumber` | `integer()` |  |

#### Example: List

```elixir
opt_out = Smsapi.opt_out(sdk)
records = Smsapi.Entity.OptOut.list(opt_out)
```


### OptOutSetting

Create a handle: `opt_out_setting = Smsapi.opt_out_setting(sdk)`

#### Operations

| Method | Description |
| --- | --- |
| `load(entity, match)` | Load a single entity by match criteria. |
| `update(entity, data)` | Update an existing entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `brand` | `String.t()` |  |

#### Example: Load

```elixir
opt_out_setting = Smsapi.opt_out_setting(sdk)
record = Smsapi.Entity.OptOutSetting.load(opt_out_setting, Smsapi.Helpers.deep(%{}))
```


### Permission

Create a handle: `permission = Smsapi.permission(sdk)`

#### Operations

| Method | Description |
| --- | --- |
| `create(entity, data)` | Create a new entity with the given data. |
| `load(entity, match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `group_id` | `String.t()` | Object ID |
| `id` | `String.t()` |  |
| `read` | `boolean()` | Has read permission |
| `send` | `boolean()` | Has send permission |
| `username` | `String.t()` |  |
| `write` | `boolean()` | Has write permission |

#### Example: Load

```elixir
permission = Smsapi.permission(sdk)
record = Smsapi.Entity.Permission.load(permission, Smsapi.Helpers.deep(%{"id" => "permission_id", "group_id" => "group_id", "username" => "username"}))
```

#### Example: Create

```elixir
permission = Smsapi.permission(sdk)
record = Smsapi.Entity.Permission.create(permission, Smsapi.Helpers.deep(%{
  "group_id" => "example_group_id",  # String.t()
  "read" => true,  # boolean()
  "send" => true,  # boolean()
  "username" => "example_username",  # String.t()
  "write" => true,  # boolean()
}))
```


### Ping

Create a handle: `ping = Smsapi.ping(sdk)`

#### Operations

| Method | Description |
| --- | --- |
| `list(entity)` | List entities, optionally matching the given criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `authorized` | `boolean()` |  |
| `unavailable` | `list()` |  |

#### Example: List

```elixir
ping = Smsapi.ping(sdk)
records = Smsapi.Entity.Ping.list(ping)
```


### Profile

Create a handle: `profile = Smsapi.profile(sdk)`

#### Operations

| Method | Description |
| --- | --- |
| `list(entity)` | List entities, optionally matching the given criteria. |
| `load(entity, match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `email` | `String.t()` |  |
| `name` | `String.t()` |  |
| `payment_type` | `String.t()` |  |
| `phone_number` | `integer()` |  |
| `points` | `float()` |  |
| `user_type` | `String.t()` |  |
| `username` | `String.t()` |  |

#### Example: Load

```elixir
profile = Smsapi.profile(sdk)
record = Smsapi.Entity.Profile.load(profile, Smsapi.Helpers.deep(%{}))
```

#### Example: List

```elixir
profile = Smsapi.profile(sdk)
records = Smsapi.Entity.Profile.list(profile)
```


### Rcs

Create a handle: `rcs = Smsapi.rcs(sdk)`

#### Operations

| Method | Description |
| --- | --- |
| `list(entity)` | List entities, optionally matching the given criteria. |

#### Example: List

```elixir
rcs = Smsapi.rcs(sdk)
records = Smsapi.Entity.Rcs.list(rcs)
```


### Sendername

Create a handle: `sendername = Smsapi.sendername(sdk)`

#### Operations

| Method | Description |
| --- | --- |
| `create(entity, data)` | Create a new entity with the given data. |
| `list(entity)` | List entities, optionally matching the given criteria. |
| `load(entity, match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `created_at` | `String.t()` |  |
| `id` | `String.t()` |  |
| `is_default` | `boolean()` |  |
| `sender` | `String.t()` | Sendername |
| `status` | `String.t()` |  |

#### Example: Load

```elixir
sendername = Smsapi.sendername(sdk)
record = Smsapi.Entity.Sendername.load(sendername, Smsapi.Helpers.deep(%{"id" => "sendername_id"}))
```

#### Example: List

```elixir
sendername = Smsapi.sendername(sdk)
records = Smsapi.Entity.Sendername.list(sendername)
```

#### Example: Create

```elixir
sendername = Smsapi.sendername(sdk)
record = Smsapi.Entity.Sendername.create(sendername, Smsapi.Helpers.deep(%{
}))
```


### SendernameStatement

Create a handle: `sendername_statement = Smsapi.sendername_statement(sdk)`

#### Operations

| Method | Description |
| --- | --- |
| `list(entity)` | List entities, optionally matching the given criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `content` | `String.t()` |  |
| `statements` | `list()` |  |
| `title` | `String.t()` |  |

#### Example: List

```elixir
sendername_statement = Smsapi.sendername_statement(sdk)
records = Smsapi.Entity.SendernameStatement.list(sendername_statement)
```


### SentRcsMessage

Create a handle: `sent_rcs_message = Smsapi.sent_rcs_message(sdk)`

#### Operations

| Method | Description |
| --- | --- |
| `create(entity, data)` | Create a new entity with the given data. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `content` | `map()` | RCS message content in RCS JSON format. |
| `phone_number` | `String.t()` | Recipient phone number (e.g. |
| `sender` | `any()` |  |
| `text` | `String.t()` | Plain text message content. |

#### Example: Create

```elixir
sent_rcs_message = Smsapi.sent_rcs_message(sdk)
record = Smsapi.Entity.SentRcsMessage.create(sent_rcs_message, Smsapi.Helpers.deep(%{
  "phone_number" => "example_phone_number",  # String.t()
  "sender" => "example_sender",  # any()
}))
```


### ShipmentCountryVolume

Create a handle: `shipment_country_volume = Smsapi.shipment_country_volume(sdk)`

#### Operations

| Method | Description |
| --- | --- |
| `list(entity)` | List entities, optionally matching the given criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `country_code` | `String.t()` |  |
| `country_limit` | `integer()` |  |
| `country_name` | `String.t()` |  |
| `usage` | `integer()` |  |

#### Example: List

```elixir
shipment_country_volume = Smsapi.shipment_country_volume(sdk)
records = Smsapi.Entity.ShipmentCountryVolume.list(shipment_country_volume)
```


### ShortUrl

Create a handle: `short_url = Smsapi.short_url(sdk)`

#### Operations

| Method | Description |
| --- | --- |
| `create(entity, data)` | Create a new entity with the given data. |
| `list(entity)` | List entities, optionally matching the given criteria. |
| `load(entity, match)` | Load a single entity by match criteria. |
| `remove(entity, match)` | Remove the matching entity. |
| `update(entity, data)` | Update an existing entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `description` | `String.t()` |  |
| `expire` | `String.t()` |  |
| `filename` | `String.t()` |  |
| `hits` | `integer()` |  |
| `hits_unique` | `integer()` |  |
| `id` | `String.t()` |  |
| `name` | `String.t()` |  |
| `short_url` | `String.t()` | WHATWG URL compliant |
| `type` | `String.t()` |  |
| `url` | `String.t()` | WHATWG URL compliant |

#### Example: Load

```elixir
short_url = Smsapi.short_url(sdk)
record = Smsapi.Entity.ShortUrl.load(short_url, Smsapi.Helpers.deep(%{"id" => "short_url_id"}))
```

#### Example: List

```elixir
short_url = Smsapi.short_url(sdk)
records = Smsapi.Entity.ShortUrl.list(short_url)
```

#### Example: Create

```elixir
short_url = Smsapi.short_url(sdk)
record = Smsapi.Entity.ShortUrl.create(short_url, Smsapi.Helpers.deep(%{
}))
```


### Smsdo

Create a handle: `smsdo = Smsapi.smsdo(sdk)`

#### Operations

| Method | Description |
| --- | --- |
| `create(entity, data)` | Create a new entity with the given data. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `allow_duplicates` | `integer()` | When parameter allow_duplicates is set to "1" allows to send message to duplicated numbers in one request (useful i.e. |
| `check_idx` | `any()` | When parameter check_idx is set to „1” prevents from sending more than one message with the same idx in last 24h. |
| `date` | `any()` | Date in UNIX timestamp (&date=1287734110) or in ISO 8601 (&date=2012-05-10T08:40:27+00:00) when message will be sent (&date=1287734110). |
| `date_validate` | `integer()` | When parameter date_validate is set to "1" checks if date if given in proper format. |
| `details` | `any()` | When details parameter is set to "1" more details in response will be displayed (message length and sms count). |
| `encoding` | `String.t()` | This parameter describes the encoding of the message text. |
| `expiration_date` | `any()` | Message expiration date (in UNIX timestamp or in ISO 8601) is a date after which message won't be delivered if it wasn't delivered yet. |
| `fallback` | `list()` | Enable fallback in case sms sending fails |
| `fast` | `integer()` | Setting this parameter to „1” will result in sending message with the highest priority which ensures the quickest possible time of delivery. |
| `flash` | `integer()` | Sending a message in flash mode can be activated by setting this parameter to "1". |
| `format` | `String.t()` | Parameter &format=json causes, that response is sending in JSON format. |
| `from` | `String.t()` | Name of the sender. |
| `group` | `String.t()` | Name of the group from the contacts database to which message should be sent to. |
| `idx` | `String.t()` | Optional custom value sent with SMS and sent back in CALLBACK. |
| `max_parts` | `integer()` | Defines maximum message parts allowed, maximum value allowed is 6. |
| `message` | `String.t()` | The message text. |
| `normalize` | `integer()` | When parameter normalize is set to „1” special chars in message will be replaced with their equivalents (ê-e, ñ-n, ý-y ...). |
| `notify_url` | `String.t()` | Parameter allows to set CALLBACK URL for message from request. |
| `test` | `any()` | When parameter test is set to "1" message won't be sent but response will be displayed, there is no charge for such test messages. |
| `time_restriction` | `String.t()` | Sets the behavior when you try to ship in hours / dates that do not match the settings in your account. |
| `to` | `String.t()` | Recipients' mobile phone numbers (i.e. |

#### Example: Create

```elixir
smsdo = Smsapi.smsdo(sdk)
record = Smsapi.Entity.Smsdo.create(smsdo, Smsapi.Helpers.deep(%{
}))
```


### Smssendername

Create a handle: `smssendername = Smsapi.smssendername(sdk)`

#### Operations

| Method | Description |
| --- | --- |
| `create(entity, data)` | Create a new entity with the given data. |
| `remove(entity, match)` | Remove the matching entity. |

#### Example: Create

```elixir
smssendername = Smsapi.smssendername(sdk)
record = Smsapi.Entity.Smssendername.create(smssendername, Smsapi.Helpers.deep(%{
  "sendername_id" => "example_sendername_id",  # String.t()
}))
```


### Smstemplate

Create a handle: `smstemplate = Smsapi.smstemplate(sdk)`

#### Operations

| Method | Description |
| --- | --- |
| `remove(entity, match)` | Remove the matching entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `id` | `String.t()` |  |


### Subuser

Create a handle: `subuser = Smsapi.subuser(sdk)`

#### Operations

| Method | Description |
| --- | --- |
| `create(entity, data)` | Create a new entity with the given data. |
| `list(entity)` | List entities, optionally matching the given criteria. |
| `load(entity, match)` | Load a single entity by match criteria. |
| `remove(entity, match)` | Remove the matching entity. |
| `update(entity, data)` | Update an existing entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `active` | `boolean()` |  |
| `credentials` | `map()` |  |
| `description` | `String.t()` |  |
| `id` | `String.t()` | Object ID |
| `points` | `map()` |  |
| `username` | `String.t()` |  |

#### Example: Load

```elixir
subuser = Smsapi.subuser(sdk)
record = Smsapi.Entity.Subuser.load(subuser, Smsapi.Helpers.deep(%{"id" => "subuser_id"}))
```

#### Example: List

```elixir
subuser = Smsapi.subuser(sdk)
records = Smsapi.Entity.Subuser.list(subuser)
```

#### Example: Create

```elixir
subuser = Smsapi.subuser(sdk)
record = Smsapi.Entity.Subuser.create(subuser, Smsapi.Helpers.deep(%{
  "credentials" => %{},  # map()
}))
```


### Template

Create a handle: `template = Smsapi.template(sdk)`

#### Operations

| Method | Description |
| --- | --- |
| `create(entity, data)` | Create a new entity with the given data. |
| `list(entity)` | List entities, optionally matching the given criteria. |
| `load(entity, match)` | Load a single entity by match criteria. |
| `update(entity, data)` | Update an existing entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `id` | `String.t()` |  |
| `name` | `String.t()` |  |
| `normalize` | `boolean()` |  |
| `template` | `String.t()` |  |

#### Example: Load

```elixir
template = Smsapi.template(sdk)
record = Smsapi.Entity.Template.load(template, Smsapi.Helpers.deep(%{"id" => "template_id"}))
```

#### Example: List

```elixir
template = Smsapi.template(sdk)
records = Smsapi.Entity.Template.list(template)
```

#### Example: Create

```elixir
template = Smsapi.template(sdk)
record = Smsapi.Entity.Template.create(template, Smsapi.Helpers.deep(%{
}))
```


### UserRcsSenderCollection

Create a handle: `user_rcs_sender_collection = Smsapi.user_rcs_sender_collection(sdk)`

#### Operations

| Method | Description |
| --- | --- |
| `list(entity)` | List entities, optionally matching the given criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `deliveredAt` | `String.t()` |  |
| `expiredAt` | `String.t()` |  |
| `id` | `String.t()` | Object ID |
| `interface` | `String.t()` | Interface through which the message was sent (www, api, ...). |
| `messageType` | `String.t()` | RCS message type (basic, single, ...). |
| `readAt` | `String.t()` |  |
| `recipient` | `String.t()` | Recipient phone number (without +). |
| `sender` | `String.t()` | Sender name |
| `senderId` | `String.t()` | Sender id |
| `sentAt` | `String.t()` |  |

#### Example: List

```elixir
user_rcs_sender_collection = Smsapi.user_rcs_sender_collection(sdk)
records = Smsapi.Entity.UserRcsSenderCollection.list(user_rcs_sender_collection)
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

### Data as struct value nodes

The Elixir SDK models every runtime object — clients, contexts, results and
record data — as reference-stable struct value nodes from the vendored
`Voxgig.Struct` library rather than as compile-time structs. This mirrors
the dynamic nature of the API and lets a feature hook mutate a shared node
that every later pipeline stage observes — the immutable-Elixir way to honour
the shared-mutable hook contract.

Build inputs from native Elixir maps with `Smsapi.Helpers.deep/1`,
and read fields off results with `Voxgig.Struct.getprop/2`.

### Module structure

```
elixir/
├── lib/
│   ├── smsapi.ex                 -- Main SDK module (entity factories)
│   ├── config.ex                 -- Resolved configuration
│   ├── schema.ex                 -- Generated option + entity specs
│   ├── features.ex               -- Feature factory
│   ├── pipeline.ex               -- Operation pipeline
│   └── smsapi/
│       ├── context.ex            -- Operation context
│       ├── entity_base.ex        -- Shared entity behaviour
│       ├── error.ex              -- SDK error type
│       ├── feature.ex            -- Built-in features
│       ├── helpers.ex            -- Value helpers (deep/1, ...)
│       ├── json.ex               -- JSON encode/decode
│       └── utility.ex            -- Utility functions
│   └── entity/                   -- Per-entity modules
├── mix.exs                       -- Package manifest
└── test/                         -- ExUnit suites
```

The main module `Smsapi` exposes the SDK constructors and one entity
factory function per entity. Call an operation on the matching
`Smsapi.Entity.<Name>` module.

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
