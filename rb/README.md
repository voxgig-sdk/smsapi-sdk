# Smsapi Ruby SDK

An MCP server and CLI for the SMSAPI REST API, plus clients in 13 languages and a pandas data layer, generated from SMSAPI's public OpenAPI spec so AI agents can reach SMSAPI the way the official SDKs already let developers.

The Ruby SDK for the Smsapi API — an entity-oriented client using idiomatic Ruby conventions.

The SDK exposes the API as capitalised, semantic **Entities** — for example `client.Available` — with named operations (`list`/`load`/`create`/`update`/`remove`) instead of raw URL paths and query strings. Working with resources and verbs keeps call sites self-describing and reduces cognitive load.

> Other languages, the CLI, and MCP server live alongside this one — see
> the [top-level README](../README.md).


## Install
This package is not yet published to RubyGems. Install it from the
GitHub release tag (`rb/vX.Y.Z`, see [Releases](https://github.com/voxgig-sdk/smsapi-sdk/releases)), or
from a clone:

```bash
git clone https://github.com/voxgig-sdk/smsapi-sdk
```

Then add it to your `Gemfile` by path, and run `bundle install`:

```ruby
gem "voxgig-sdk-smsapi-sdk", path: "./smsapi-sdk/rb"
```


## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record.

### 1. Create a client

```ruby
require_relative "Smsapi_sdk"

client = SmsapiSDK.new({
  "apikey" => ENV["SMSAPI_APIKEY"],
})
```

### 2. List available records

```ruby
begin
  # list returns an Array of Available records — iterate directly.
  availables = client.Available.list
  availables.each do |item|
    puts "#{item["name"]}"
  end
rescue => err
  warn "list failed: #{err}"
end
```

### 3. Load a permission

Permission is nested under group, so provide the `group_id`.

```ruby
begin
  # load returns the ENTITY — call data_get for the Permission record (raises on error).
  permission = client.Permission.load({ "group_id" => "example_group_id", "username" => "example_username", "id" => "example_id" })
  puts permission
rescue => err
  warn "load failed: #{err}"
end
```


## Error handling

Entity operations raise on failure, so rescue them:

```ruby
begin
  permission = client.Permission.load({ "group_id" => "example", "id" => "example_id", "username" => "example" })
rescue => err
  warn "load failed: #{err}"
end
```

`direct` does **not** raise — it returns the result hash. Branch on
`ok`; on failure `status` holds the HTTP status (for error responses) and
`err` holds a transport error, so read both defensively:

```ruby
result = client.direct({
  "path" => "/api/resource/{id}",
  "method" => "GET",
  "params" => { "id" => "example_id" },
})

warn "request failed: #{result["err"] || "HTTP #{result["status"]}"}" unless result["ok"]
```


## How-to guides

### Make a direct HTTP request

For endpoints not covered by entity methods:

```ruby
result = client.direct({
  "path" => "/api/resource/{id}",
  "method" => "GET",
  "params" => { "id" => "example" },
})

if result["ok"]
  puts result["status"]  # 200
  puts result["data"]    # response body
else
  # On an HTTP error status there is no err (only a transport failure sets
  # it), so fall back to the status code.
  warn(result["err"] || "HTTP #{result["status"]}")
end
```

### Prepare a request without sending it

```ruby
begin
  fetchdef = client.prepare({
    "path" => "/api/resource/{id}",
    "method" => "DELETE",
    "params" => { "id" => "example" },
  })
  puts fetchdef["url"]
  puts fetchdef["method"]
  puts fetchdef["headers"]
rescue => err
  warn "prepare failed: #{err}"
end
```

### Use test mode

Create a mock client for unit testing — no server required. Seed fixture
data via the `entity` option so offline calls resolve without a live server:

```ruby
client = SmsapiSDK.test({
  "entity" => { "permission" => { "test01" => { "id" => "test01" } } },
})

# Entity ops return the ENTITY (raises on error);
# call data_get for the mock record.
permission = client.Permission.load({ "id" => "test01", "group_id" => "example", "username" => "example" })
puts permission
```

### Use a custom fetch function

Replace the HTTP transport with your own function:

```ruby
mock_fetch = ->(url, init) {
  return {
    "status" => 200,
    "statusText" => "OK",
    "headers" => {},
    "json" => ->() { { "id" => "mock01" } },
  }, nil
}

client = SmsapiSDK.new({
  "base" => "http://localhost:8080",
  "system" => {
    "fetch" => mock_fetch,
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
cd rb && ruby -Itest -e "Dir['test/*_test.rb'].each { |f| require_relative f }"
```


## Reference

### SmsapiSDK

```ruby
require_relative "Smsapi_sdk"
client = SmsapiSDK.new(options)
```

Creates a new SDK client.

| Option | Type | Description |
| --- | --- | --- |
| `apikey` | `String` | API key for authentication. |
| `base` | `String` | Base URL of the API server. |
| `prefix` | `String` | URL path prefix prepended to all requests. |
| `suffix` | `String` | URL path suffix appended to all requests. |
| `feature` | `Hash` | Feature activation flags. |
| `extend` | `Hash` | Additional Feature instances to load. |
| `system` | `Hash` | System overrides (e.g. custom `fetch` lambda). |

### test

```ruby
client = SmsapiSDK.test(testopts, sdkopts)
```

Creates a test-mode client with mock transport. Both arguments may be `nil`.

### SmsapiSDK methods

| Method | Signature | Description |
| --- | --- | --- |
| `options_map` | `() -> Hash` | Deep copy of current SDK options. |
| `get_utility` | `() -> Utility` | Copy of the SDK utility object. |
| `prepare` | `(fetchargs) -> Hash` | Build an HTTP request definition without sending. Raises on error. |
| `direct` | `(fetchargs) -> Hash` | Build and send an HTTP request. Returns a result hash (`result["ok"]`); does not raise. |
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
| `load` | `(reqmatch, ctrl) -> any` | Load a single entity by match criteria. Raises on error. |
| `list` | `(reqmatch = nil, ctrl) -> Array` | List entities matching the criteria (call with no argument to list all). Raises on error. |
| `create` | `(reqdata, ctrl) -> any` | Create a new entity. Raises on error. |
| `update` | `(reqdata, ctrl) -> any` | Update an existing entity. Raises on error. |
| `remove` | `(reqmatch, ctrl) -> any` | Remove an entity. Raises on error. |
| `data_get` | `() -> Hash` | Get entity data. |
| `data_set` | `(data)` | Set entity data. |
| `match_get` | `() -> Hash` | Get entity match criteria. |
| `match_set` | `(match)` | Set entity match criteria. |
| `make` | `() -> Entity` | Create a new instance with the same options. |
| `get_name` | `() -> String` | Return the entity name. |

### Result shape

Entity operations return the result data directly. On failure they
raise a `SmsapiError` (a `StandardError` subclass), so wrap
calls in `begin`/`rescue` where you need to handle errors.

The `direct` escape hatch is the exception: it never raises and instead
returns a result `Hash` with these keys:

| Key | Type | Description |
| --- | --- | --- |
| `ok` | `Boolean` | `true` if the HTTP status is 2xx. |
| `status` | `Integer` | HTTP status code. |
| `headers` | `Hash` | Response headers. |
| `data` | `any` | Parsed JSON response body. |
| `err` | `Error` | Present when `ok` is `false`. |

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

Create an instance: `available = client.Available`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `name` | `String` |  |
| `normalize` | `Boolean` |  |
| `template` | `String` |  |

#### Example: List

```ruby
# list returns an Array of Available records (raises on error).
availables = client.Available.list
```


### Blacklist

Create an instance: `blacklist = client.Blacklist`

#### Operations

| Method | Description |
| --- | --- |
| `create(data)` | Create a new entity with the given data. |
| `load(match)` | Load a single entity by match criteria. |
| `remove(match)` | Remove the matching entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `id` | `String` |  |

#### Example: Load

```ruby
# load returns the ENTITY — call data_get for the Blacklist record (raises on error).
blacklist = client.Blacklist.load()
```

#### Example: Create

```ruby
blacklist = client.Blacklist.create({
})
```


### Callback

Create an instance: `callback = client.Callback`

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
| `active` | `Boolean` |  |
| `api_version` | `Integer` | Version of the callback output format. |
| `id` | `String` | Object ID |
| `invalid` | `Boolean` |  |
| `receiver` | `Hash` |  |
| `receiver_type` | `String` |  |
| `type` | `String` |  |
| `url` | `String` | WHATWG URL compliant |

#### Example: Load

```ruby
# load returns the ENTITY — call data_get for the Callback record (raises on error).
callback = client.Callback.load({ "id" => "callback_id" })
```

#### Example: List

```ruby
# list returns an Array of Callback records (raises on error).
callbacks = client.Callback.list
```

#### Example: Create

```ruby
callback = client.Callback.create({
})
```


### Contact

Create an instance: `contact = client.Contact`

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
| `birthday_date` | `String` |  |
| `city` | `String` |  |
| `collection` | `Array` |  |
| `contact_expire_after` | `Integer` | Contact expire after days |
| `contacts_count` | `Integer` |  |
| `country` | `String` |  |
| `created_by` | `String` |  |
| `date_created` | `String` |  |
| `date_updated` | `String` |  |
| `description` | `String` |  |
| `email` | `String` |  |
| `first_name` | `String` |  |
| `gender` | `String` |  |
| `group_id` | `String` | Object ID |
| `groups` | `Array` |  |
| `id` | `String` | Object ID |
| `idx` | `String` | User provided resource id |
| `last_name` | `String` |  |
| `name` | `String` | Group name |
| `permissions` | `Array` |  |
| `phone_number` | `String` |  |
| `read` | `Boolean` | Has read permission |
| `send` | `Boolean` | Has send permission |
| `size` | `Integer` |  |
| `source` | `String` |  |
| `type` | `String` |  |
| `username` | `String` |  |
| `value` | `String` |  |
| `write` | `Boolean` | Has write permission |

#### Example: Load

```ruby
# load returns the ENTITY — call data_get for the Contact record (raises on error).
contact = client.Contact.load({ "id" => "contact_id" })
```

#### Example: List

```ruby
# list returns an Array of Contact records (raises on error).
contacts = client.Contact.list
```

#### Example: Create

```ruby
contact = client.Contact.create({
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


### ContactsField

Create an instance: `contacts_field = client.ContactsField`

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
| `birthday_date` | `String` |  |
| `city` | `String` |  |
| `contact_expire_after` | `Integer` | Contact expire after days |
| `contacts_count` | `Integer` |  |
| `country` | `String` |  |
| `created_by` | `String` |  |
| `date_created` | `String` |  |
| `date_updated` | `String` |  |
| `description` | `String` |  |
| `email` | `String` |  |
| `first_name` | `String` |  |
| `gender` | `String` |  |
| `group_id` | `String` | Object ID |
| `groups` | `Array` |  |
| `id` | `String` | Object ID |
| `idx` | `String` | User provided resource id |
| `last_name` | `String` |  |
| `name` | `String` | Group name |
| `permissions` | `Array` |  |
| `phone_number` | `String` |  |
| `read` | `Boolean` | Has read permission |
| `send` | `Boolean` | Has send permission |
| `source` | `String` |  |
| `type` | `String` |  |
| `username` | `String` |  |
| `value` | `String` |  |
| `write` | `Boolean` | Has write permission |

#### Example: List

```ruby
# list returns an Array of ContactsField records (raises on error).
contacts_fields = client.ContactsField.list
```

#### Example: Create

```ruby
contacts_field = client.ContactsField.create({
  "contact_expire_after" => 1, # Integer
  "created_by" => "example_created_by", # String
  "date_created" => "example_date_created", # String
  "date_updated" => "example_date_updated", # String
  "gender" => "example_gender", # String
  "groups" => [], # Array
})
```


### ContactsFieldOption

Create an instance: `contacts_field_option = client.ContactsFieldOption`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `birthday_date` | `String` |  |
| `city` | `String` |  |
| `contact_expire_after` | `Integer` | Contact expire after days |
| `contacts_count` | `Integer` |  |
| `country` | `String` |  |
| `created_by` | `String` |  |
| `date_created` | `String` |  |
| `date_updated` | `String` |  |
| `description` | `String` |  |
| `email` | `String` |  |
| `first_name` | `String` |  |
| `gender` | `String` |  |
| `group_id` | `String` | Object ID |
| `groups` | `Array` |  |
| `id` | `String` | Object ID |
| `idx` | `String` | User provided resource id |
| `last_name` | `String` |  |
| `name` | `String` | Group name |
| `permissions` | `Array` |  |
| `phone_number` | `String` |  |
| `read` | `Boolean` | Has read permission |
| `send` | `Boolean` | Has send permission |
| `source` | `String` |  |
| `type` | `String` |  |
| `username` | `String` |  |
| `value` | `String` |  |
| `write` | `Boolean` | Has write permission |

#### Example: List

```ruby
# list returns an Array of ContactsFieldOption records (raises on error).
contacts_field_options = client.ContactsFieldOption.list
```


### Contactsgroup

Create an instance: `contactsgroup = client.Contactsgroup`

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
| `birthday_date` | `String` |  |
| `city` | `String` |  |
| `contact_expire_after` | `Integer` | Contact expire after days |
| `contacts_count` | `Integer` |  |
| `country` | `String` |  |
| `created_by` | `String` |  |
| `date_created` | `String` |  |
| `date_updated` | `String` |  |
| `description` | `String` |  |
| `email` | `String` |  |
| `first_name` | `String` |  |
| `gender` | `String` |  |
| `group_id` | `String` | Object ID |
| `groups` | `Array` |  |
| `id` | `String` | Object ID |
| `idx` | `String` | User provided resource id |
| `last_name` | `String` |  |
| `name` | `String` | Group name |
| `permissions` | `Array` |  |
| `phone_number` | `String` |  |
| `read` | `Boolean` | Has read permission |
| `send` | `Boolean` | Has send permission |
| `source` | `String` |  |
| `type` | `String` |  |
| `username` | `String` |  |
| `value` | `String` |  |
| `write` | `Boolean` | Has write permission |

#### Example: List

```ruby
# list returns an Array of Contactsgroup records (raises on error).
contactsgroups = client.Contactsgroup.list
```

#### Example: Create

```ruby
contactsgroup = client.Contactsgroup.create({
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


### Contactstrash

Create an instance: `contactstrash = client.Contactstrash`

#### Operations

| Method | Description |
| --- | --- |
| `remove(match)` | Remove the matching entity. |
| `update(data)` | Update an existing entity. |


### FieldAvailable

Create an instance: `field_available = client.FieldAvailable`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `built_in` | `Boolean` |  |
| `id` | `String` | Object ID |
| `name` | `String` |  |
| `options` | `Array` |  |
| `type` | `String` |  |

#### Example: List

```ruby
# list returns an Array of FieldAvailable records (raises on error).
field_availables = client.FieldAvailable.list
```


### Group

Create an instance: `group = client.Group`

#### Operations

| Method | Description |
| --- | --- |
| `load(match)` | Load a single entity by match criteria. |
| `update(data)` | Update an existing entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `contact_expire_after` | `Integer` | Contact expire after days |
| `contacts_count` | `Integer` |  |
| `created_by` | `String` |  |
| `date_created` | `String` |  |
| `date_updated` | `String` |  |
| `description` | `String` |  |
| `id` | `String` | Object ID |
| `idx` | `String` | User provided resource id |
| `name` | `String` | Group name |
| `permissions` | `Array` |  |

#### Example: Load

```ruby
# load returns the ENTITY — call data_get for the Group record (raises on error).
group = client.Group.load({ "id" => "group_id" })
```


### MfaCode

Create an instance: `mfa_code = client.MfaCode`

#### Operations

| Method | Description |
| --- | --- |
| `create(data)` | Create a new entity with the given data. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `content` | `String` | Custom content that must contain placeholder [%code%] |
| `fast` | `Object` |  |
| `from` | `String` | Sendername |
| `phone_number` | `String` |  |

#### Example: Create

```ruby
mfa_code = client.MfaCode.create({
  "phone_number" => "example_phone_number", # String
})
```


### OptOut

Create an instance: `opt_out = client.OptOut`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `remove(match)` | Remove the matching entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `date` | `String` |  |
| `id` | `String` |  |
| `links` | `Array` |  |
| `phoneNumber` | `Integer` |  |

#### Example: List

```ruby
# list returns an Array of OptOut records (raises on error).
opt_outs = client.OptOut.list
```


### OptOutSetting

Create an instance: `opt_out_setting = client.OptOutSetting`

#### Operations

| Method | Description |
| --- | --- |
| `load(match)` | Load a single entity by match criteria. |
| `update(data)` | Update an existing entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `brand` | `String` |  |

#### Example: Load

```ruby
# load returns the ENTITY — call data_get for the OptOutSetting record (raises on error).
opt_out_setting = client.OptOutSetting.load()
```


### Permission

Create an instance: `permission = client.Permission`

#### Operations

| Method | Description |
| --- | --- |
| `create(data)` | Create a new entity with the given data. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `group_id` | `String` | Object ID |
| `id` | `String` |  |
| `read` | `Boolean` | Has read permission |
| `send` | `Boolean` | Has send permission |
| `username` | `String` |  |
| `write` | `Boolean` | Has write permission |

#### Example: Load

```ruby
# load returns the ENTITY — call data_get for the Permission record (raises on error).
permission = client.Permission.load({ "id" => "permission_id", "group_id" => "group_id", "username" => "username" })
```

#### Example: Create

```ruby
permission = client.Permission.create({
  "group_id" => "example_group_id", # String
  "read" => true, # Boolean
  "send" => true, # Boolean
  "username" => "example_username", # String
  "write" => true, # Boolean
})
```


### Ping

Create an instance: `ping = client.Ping`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `authorized` | `Boolean` |  |
| `unavailable` | `Array` |  |

#### Example: List

```ruby
# list returns an Array of Ping records (raises on error).
pings = client.Ping.list
```


### Profile

Create an instance: `profile = client.Profile`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `email` | `String` |  |
| `name` | `String` |  |
| `payment_type` | `String` |  |
| `phone_number` | `Integer` |  |
| `points` | `Float` |  |
| `user_type` | `String` |  |
| `username` | `String` |  |

#### Example: Load

```ruby
# load returns the ENTITY — call data_get for the Profile record (raises on error).
profile = client.Profile.load()
```

#### Example: List

```ruby
# list returns an Array of Profile records (raises on error).
profiles = client.Profile.list
```


### Rcs

Create an instance: `rcs = client.Rcs`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Example: List

```ruby
# list returns an Array of Rcs records (raises on error).
rcss = client.Rcs.list
```


### Sendername

Create an instance: `sendername = client.Sendername`

#### Operations

| Method | Description |
| --- | --- |
| `create(data)` | Create a new entity with the given data. |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `created_at` | `String` |  |
| `id` | `String` |  |
| `is_default` | `Boolean` |  |
| `sender` | `String` | Sendername |
| `status` | `String` |  |

#### Example: Load

```ruby
# load returns the ENTITY — call data_get for the Sendername record (raises on error).
sendername = client.Sendername.load({ "id" => "sendername_id" })
```

#### Example: List

```ruby
# list returns an Array of Sendername records (raises on error).
sendernames = client.Sendername.list
```

#### Example: Create

```ruby
sendername = client.Sendername.create({
})
```


### SendernameStatement

Create an instance: `sendername_statement = client.SendernameStatement`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `content` | `String` |  |
| `statements` | `Array` |  |
| `title` | `String` |  |

#### Example: List

```ruby
# list returns an Array of SendernameStatement records (raises on error).
sendername_statements = client.SendernameStatement.list
```


### SentRcsMessage

Create an instance: `sent_rcs_message = client.SentRcsMessage`

#### Operations

| Method | Description |
| --- | --- |
| `create(data)` | Create a new entity with the given data. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `content` | `Hash` | RCS message content in RCS JSON format. |
| `phone_number` | `String` | Recipient phone number (e.g. |
| `sender` | `Object` |  |
| `text` | `String` | Plain text message content. |

#### Example: Create

```ruby
sent_rcs_message = client.SentRcsMessage.create({
  "phone_number" => "example_phone_number", # String
  "sender" => "example_sender", # Object
})
```


### ShipmentCountryVolume

Create an instance: `shipment_country_volume = client.ShipmentCountryVolume`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `country_code` | `String` |  |
| `country_limit` | `Integer` |  |
| `country_name` | `String` |  |
| `usage` | `Integer` |  |

#### Example: List

```ruby
# list returns an Array of ShipmentCountryVolume records (raises on error).
shipment_country_volumes = client.ShipmentCountryVolume.list
```


### ShortUrl

Create an instance: `short_url = client.ShortUrl`

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
| `description` | `String` |  |
| `expire` | `String` |  |
| `filename` | `String` |  |
| `hits` | `Integer` |  |
| `hits_unique` | `Integer` |  |
| `id` | `String` |  |
| `name` | `String` |  |
| `short_url` | `String` | WHATWG URL compliant |
| `type` | `String` |  |
| `url` | `String` | WHATWG URL compliant |

#### Example: Load

```ruby
# load returns the ENTITY — call data_get for the ShortUrl record (raises on error).
short_url = client.ShortUrl.load({ "id" => "short_url_id" })
```

#### Example: List

```ruby
# list returns an Array of ShortUrl records (raises on error).
short_urls = client.ShortUrl.list
```

#### Example: Create

```ruby
short_url = client.ShortUrl.create({
})
```


### Smsdo

Create an instance: `smsdo = client.Smsdo`

#### Operations

| Method | Description |
| --- | --- |
| `create(data)` | Create a new entity with the given data. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `allow_duplicates` | `Integer` | When parameter allow_duplicates is set to "1" allows to send message to duplicated numbers in one request (useful i.e. |
| `check_idx` | `Object` | When parameter check_idx is set to „1” prevents from sending more than one message with the same idx in last 24h. |
| `date` | `Object` | Date in UNIX timestamp (&date=1287734110) or in ISO 8601 (&date=2012-05-10T08:40:27+00:00) when message will be sent (&date=1287734110). |
| `date_validate` | `Integer` | When parameter date_validate is set to "1" checks if date if given in proper format. |
| `details` | `Object` | When details parameter is set to "1" more details in response will be displayed (message length and sms count). |
| `encoding` | `String` | This parameter describes the encoding of the message text. |
| `expiration_date` | `Object` | Message expiration date (in UNIX timestamp or in ISO 8601) is a date after which message won't be delivered if it wasn't delivered yet. |
| `fallback` | `Array` | Enable fallback in case sms sending fails |
| `fast` | `Integer` | Setting this parameter to „1” will result in sending message with the highest priority which ensures the quickest possible time of delivery. |
| `flash` | `Integer` | Sending a message in flash mode can be activated by setting this parameter to "1". |
| `format` | `String` | Parameter &format=json causes, that response is sending in JSON format. |
| `from` | `String` | Name of the sender. |
| `group` | `String` | Name of the group from the contacts database to which message should be sent to. |
| `idx` | `String` | Optional custom value sent with SMS and sent back in CALLBACK. |
| `max_parts` | `Integer` | Defines maximum message parts allowed, maximum value allowed is 6. |
| `message` | `String` | The message text. |
| `normalize` | `Integer` | When parameter normalize is set to „1” special chars in message will be replaced with their equivalents (ê-e, ñ-n, ý-y ...). |
| `notify_url` | `String` | Parameter allows to set CALLBACK URL for message from request. |
| `test` | `Object` | When parameter test is set to "1" message won't be sent but response will be displayed, there is no charge for such test messages. |
| `time_restriction` | `String` | Sets the behavior when you try to ship in hours / dates that do not match the settings in your account. |
| `to` | `String` | Recipients' mobile phone numbers (i.e. |

#### Example: Create

```ruby
smsdo = client.Smsdo.create({
})
```


### Smssendername

Create an instance: `smssendername = client.Smssendername`

#### Operations

| Method | Description |
| --- | --- |
| `create(data)` | Create a new entity with the given data. |
| `remove(match)` | Remove the matching entity. |

#### Example: Create

```ruby
smssendername = client.Smssendername.create({
  "sendername_id" => "example_sendername_id", # String
})
```


### Smstemplate

Create an instance: `smstemplate = client.Smstemplate`

#### Operations

| Method | Description |
| --- | --- |
| `remove(match)` | Remove the matching entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `id` | `String` |  |


### Subuser

Create an instance: `subuser = client.Subuser`

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
| `active` | `Boolean` |  |
| `credentials` | `Hash` |  |
| `description` | `String` |  |
| `id` | `String` | Object ID |
| `points` | `Hash` |  |
| `username` | `String` |  |

#### Example: Load

```ruby
# load returns the ENTITY — call data_get for the Subuser record (raises on error).
subuser = client.Subuser.load({ "id" => "subuser_id" })
```

#### Example: List

```ruby
# list returns an Array of Subuser records (raises on error).
subusers = client.Subuser.list
```

#### Example: Create

```ruby
subuser = client.Subuser.create({
  "credentials" => {}, # Hash
})
```


### Template

Create an instance: `template = client.Template`

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
| `id` | `String` |  |
| `name` | `String` |  |
| `normalize` | `Boolean` |  |
| `template` | `String` |  |

#### Example: Load

```ruby
# load returns the ENTITY — call data_get for the Template record (raises on error).
template = client.Template.load({ "id" => "template_id" })
```

#### Example: List

```ruby
# list returns an Array of Template records (raises on error).
templates = client.Template.list
```

#### Example: Create

```ruby
template = client.Template.create({
})
```


### UserRcsSenderCollection

Create an instance: `user_rcs_sender_collection = client.UserRcsSenderCollection`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `deliveredAt` | `String` |  |
| `expiredAt` | `String` |  |
| `id` | `String` | Object ID |
| `interface` | `String` | Interface through which the message was sent (www, api, ...). |
| `messageType` | `String` | RCS message type (basic, single, ...). |
| `readAt` | `String` |  |
| `recipient` | `String` | Recipient phone number (without +). |
| `sender` | `String` | Sender name |
| `senderId` | `String` | Sender id |
| `sentAt` | `String` |  |

#### Example: List

```ruby
# list returns an Array of UserRcsSenderCollection records (raises on error).
user_rcs_sender_collections = client.UserRcsSenderCollection.list
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

Features are the extension mechanism. A feature is a Ruby class
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

### Data as hashes

The Ruby SDK uses plain Ruby hashes throughout rather than typed
objects. This mirrors the dynamic nature of the API and keeps the
SDK flexible — no code generation is needed when the API schema
changes.

Use `Helpers.to_map()` to safely validate that a value is a hash.

### Module structure

```
rb/
├── Smsapi_sdk.rb       -- Main SDK module
├── config.rb                  -- Configuration
├── schema.rb                  -- Generated option + entity specs
├── features.rb                -- Feature factory
├── core/                      -- Core types and context
├── entity/                    -- Entity implementations
├── feature/                   -- Built-in features (Base, Test, Log)
├── utility/                   -- Utility functions and struct library
└── test/                      -- Test suites
```

The main module (`Smsapi_sdk`) exports the SDK class
and test helper. Import entity or utility modules directly only
when needed.

### Entity state

Entity instances are stateful. After a successful `load`, the entity
stores the returned data and match criteria internally.

```ruby
permission = client.Permission
permission.load({ "group_id" => "example", "id" => "example_id", "username" => "example" })

# permission.data_get now returns the permission data from the last load
# permission.match_get returns the last match criteria
```

Call `make` to create a fresh instance with the same configuration
but no stored state.

### Direct vs entity access

The entity interface handles URL construction, parameter placement,
and response parsing automatically. Use it for standard CRUD operations.

`direct` gives full control over the HTTP request. Use it for
non-standard endpoints, bulk operations, or any path not modelled as
an entity. `prepare` builds the request without sending it — useful
for debugging or custom transport.


## Full Reference

See [REFERENCE.md](REFERENCE.md) for complete API reference
documentation including all method signatures, entity field schemas,
and detailed usage examples.
