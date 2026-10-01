# Smsapi PHP SDK

An MCP server and CLI for the SMSAPI REST API, plus clients in 20 languages and a pandas data layer, generated from SMSAPI's public OpenAPI spec so AI agents can reach SMSAPI the way the official SDKs already let developers.

The PHP SDK for the Smsapi API — an entity-oriented client using PHP conventions.

The SDK exposes the API as capitalised, semantic **Entities** — for example `$client->Available()` — with named operations (`list`/`load`/`create`/`update`/`remove`) instead of raw URL paths and query strings. Working with resources and verbs keeps call sites self-describing and reduces cognitive load.

> Other languages, the CLI, and MCP server live alongside this one — see
> the [top-level README](../README.md).


## Install
This package is not yet published to Packagist. Install it from the
GitHub release tag (`php/vX.Y.Z`, see [Releases](https://github.com/voxgig-sdk/smsapi-sdk/releases)), or
from a clone as a Composer path repository:

```bash
git clone https://github.com/voxgig-sdk/smsapi-sdk
composer config repositories.smsapi-sdk path ./smsapi-sdk/php
composer require voxgig-sdk/smsapi-sdk:@dev
```


## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record.

### 1. Create a client

```php
<?php
require_once 'smsapi_sdk.php';

$client = new SmsapiSDK([
    "apikey" => getenv("SMSAPI_APIKEY"),
]);
```

### 2. List available records

```php
try {
    // list() returns entity instances; data_get() reads each record.
    $availables = $client->Available()->list();
    foreach ($availables as $record) {
        $item = $record->data_get();
        echo $item["name"] . "\n";
    }
} catch (\Throwable $err) {
    echo "Error: " . $err->getMessage();
}
```

### 3. Load a permission

Permission is nested under group, so provide the `group_id`.

```php
try {
    // load() returns the ENTITY — call data_get() for the Permission record (throws on error).
    $permission = $client->Permission()->load(["group_id" => "example_group_id", "username" => "example_username", "id" => "example_id"]);
    print_r($permission->data_get());
} catch (\Throwable $err) {
    echo "Error: " . $err->getMessage();
}
```


## Error handling

Entity operations throw a `\Throwable` on failure, so wrap them in
`try` / `catch`:

```php
try {
    $permission = $client->Permission()->load(["group_id" => "example", "id" => "example_id", "username" => "example"]);
} catch (\Throwable $err) {
    echo "Error: " . $err->getMessage();
}
```

`direct()` does **not** throw — it returns the result array. Branch on
`ok`; on failure `status` holds the HTTP status (for error responses) and
`err` holds a transport error, so read both defensively:

```php
$result = $client->direct([
    "path" => "/api/resource/{id}",
    "method" => "GET",
    "params" => ["id" => "example_id"],
]);

if (! $result["ok"]) {
    $err = $result["err"] ?? null;
    echo "request failed: " . ($err ? $err->getMessage() : "HTTP " . $result["status"]);
}
```


## How-to guides

### Make a direct HTTP request

For endpoints not covered by entity methods:

```php
// direct() is the raw-HTTP escape hatch: it returns a result array
// (it does not throw). Branch on $result["ok"].
$result = $client->direct([
    "path" => "/api/resource/{id}",
    "method" => "GET",
    "params" => ["id" => "example"],
]);

if ($result["ok"]) {
    echo $result["status"];  // 200
    print_r($result["data"]);  // response body
} else {
    // On an HTTP error status there is no err (only a transport failure sets
    // it), so fall back to the status code.
    $err = $result["err"] ?? null;
    echo "Error: " . ($err ? $err->getMessage() : "HTTP " . $result["status"]);
}
```

### Prepare a request without sending it

```php
// prepare() throws on error and returns the fetch definition.
$fetchdef = $client->prepare([
    "path" => "/api/resource/{id}",
    "method" => "DELETE",
    "params" => ["id" => "example"],
]);

echo $fetchdef["url"];
echo $fetchdef["method"];
print_r($fetchdef["headers"]);
```

### Use test mode

Create a mock client for unit testing — no server required. Seed fixture
data via the `entity` option so offline calls resolve without a live server:

```php
$client = SmsapiSDK::test([
    "entity" => ["callback" => ["test01" => ["id" => "test01"]]],
]);

// list() returns entity instances (throws on error);
// call data_get() for the mock record.
$callback = $client->Callback()->list();
print_r(array_map(fn($item) => $item->data_get(), $callback));
```

### Use a custom fetch function

Replace the HTTP transport with your own function:

```php
$mock_fetch = function ($url, $init) {
    return [
        [
            "status" => 200,
            "statusText" => "OK",
            "headers" => [],
            "json" => function () { return ["id" => "mock01"]; },
        ],
        null,
    ];
};

$client = new SmsapiSDK([
    "base" => "http://localhost:8080",
    "system" => [
        "fetch" => $mock_fetch,
    ],
]);
```

### Run live tests

Create a `.env.local` file at the project root:

```
SMSAPI_TEST_LIVE=TRUE
SMSAPI_APIKEY=<your-key>
```

Then run:

```bash
cd php && ./vendor/bin/phpunit test/
```


## Reference

### SmsapiSDK

```php
require_once 'smsapi_sdk.php';
$client = new SmsapiSDK($options);
```

Creates a new SDK client.

| Option | Type | Description |
| --- | --- | --- |
| `apikey` | `string` | API key for authentication. |
| `base` | `string` | Base URL of the API server. |
| `prefix` | `string` | URL path prefix prepended to all requests. |
| `suffix` | `string` | URL path suffix appended to all requests. |
| `feature` | `array` | Feature activation flags. |
| `extend` | `array` | Additional Feature instances to load. |
| `system` | `array` | System overrides (e.g. custom `fetch` callable). |

### test

```php
$client = SmsapiSDK::test($testopts, $sdkopts);
```

Creates a test-mode client with mock transport. Both arguments may be `null`.

### SmsapiSDK methods

| Method | Signature | Description |
| --- | --- | --- |
| `options_map` | `(): array` | Deep copy of current SDK options. |
| `get_utility` | `(): Utility` | Copy of the SDK utility object. |
| `prepare` | `(array $fetchargs): array` | Build an HTTP request definition without sending. |
| `direct` | `(array $fetchargs): array` | Build and send an HTTP request. |
| `Available` | `($data): AvailableEntity` | Create an Available entity instance. |
| `Blacklist` | `($data): BlacklistEntity` | Create a Blacklist entity instance. |
| `Callback` | `($data): CallbackEntity` | Create a Callback entity instance. |
| `Contact` | `($data): ContactEntity` | Create a Contact entity instance. |
| `ContactsField` | `($data): ContactsFieldEntity` | Create a ContactsField entity instance. |
| `ContactsFieldOption` | `($data): ContactsFieldOptionEntity` | Create a ContactsFieldOption entity instance. |
| `Contactsgroup` | `($data): ContactsgroupEntity` | Create a Contactsgroup entity instance. |
| `Contactstrash` | `($data): ContactstrashEntity` | Create a Contactstrash entity instance. |
| `FieldAvailable` | `($data): FieldAvailableEntity` | Create a FieldAvailable entity instance. |
| `Group` | `($data): GroupEntity` | Create a Group entity instance. |
| `MfaCode` | `($data): MfaCodeEntity` | Create a MfaCode entity instance. |
| `OptOut` | `($data): OptOutEntity` | Create an OptOut entity instance. |
| `OptOutSetting` | `($data): OptOutSettingEntity` | Create an OptOutSetting entity instance. |
| `Permission` | `($data): PermissionEntity` | Create a Permission entity instance. |
| `Ping` | `($data): PingEntity` | Create a Ping entity instance. |
| `Profile` | `($data): ProfileEntity` | Create a Profile entity instance. |
| `Rcs` | `($data): RcsEntity` | Create a Rcs entity instance. |
| `Sendername` | `($data): SendernameEntity` | Create a Sendername entity instance. |
| `SendernameStatement` | `($data): SendernameStatementEntity` | Create a SendernameStatement entity instance. |
| `SentRcsMessage` | `($data): SentRcsMessageEntity` | Create a SentRcsMessage entity instance. |
| `ShipmentCountryVolume` | `($data): ShipmentCountryVolumeEntity` | Create a ShipmentCountryVolume entity instance. |
| `ShortUrl` | `($data): ShortUrlEntity` | Create a ShortUrl entity instance. |
| `Smsdo` | `($data): SmsdoEntity` | Create a Smsdo entity instance. |
| `Smssendername` | `($data): SmssendernameEntity` | Create a Smssendername entity instance. |
| `Smstemplate` | `($data): SmstemplateEntity` | Create a Smstemplate entity instance. |
| `Subuser` | `($data): SubuserEntity` | Create a Subuser entity instance. |
| `Template` | `($data): TemplateEntity` | Create a Template entity instance. |
| `UserRcsSenderCollection` | `($data): UserRcsSenderCollectionEntity` | Create an UserRcsSenderCollection entity instance. |

### Entity interface

All entities share the same interface.

| Method | Signature | Description |
| --- | --- | --- |
| `load` | `($reqmatch, $ctrl): array` | Load a single entity by match criteria. |
| `list` | `(?array $reqmatch = null, $ctrl): array` | List entities matching the criteria (call with no argument to list all). |
| `create` | `($reqdata, $ctrl): array` | Create a new entity. |
| `update` | `($reqdata, $ctrl): array` | Update an existing entity. |
| `remove` | `($reqmatch, $ctrl): array` | Remove an entity. |
| `data_get` | `(): array` | Get entity data. |
| `data_set` | `($data): void` | Set entity data. |
| `match_get` | `(): array` | Get entity match criteria. |
| `match_set` | `($match): void` | Set entity match criteria. |
| `make` | `(): Entity` | Create a new instance with the same options. |
| `get_name` | `(): string` | Return the entity name. |

### Result shape

Entity operations return the ENTITY (call data_get() for the record) (an `array` for single-entity
ops, a `list` for `list`) and throw on error. Wrap calls in
`try`/`catch` to handle failures.

The `direct()` escape hatch never throws — it returns a result `array`
you branch on via `$result["ok"]`:

| Key | Type | Description |
| --- | --- | --- |
| `ok` | `bool` | `true` if the HTTP status is 2xx. |
| `status` | `int` | HTTP status code. |
| `headers` | `array` | Response headers. |
| `data` | `mixed` | Parsed JSON response body. |

On error, `ok` is `false` and `$err` contains the error value.

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

Create an instance: `$available = $client->Available();`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `name` | `string` |  |
| `normalize` | `bool` |  |
| `template` | `string` |  |

#### Example: List

```php
// list() returns an array of Available records (throws on error).
$availables = $client->Available()->list();
```


### Blacklist

Create an instance: `$blacklist = $client->Blacklist();`

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

```php
// load() returns the ENTITY — call data_get() for the Blacklist record (throws on error).
$blacklist = $client->Blacklist()->load();
```

#### Example: Create

```php
$blacklist = $client->Blacklist()->create([
]);
```


### Callback

Create an instance: `$callback = $client->Callback();`

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
| `active` | `bool` |  |
| `api_version` | `int` | Version of the callback output format. |
| `id` | `string` | Object ID |
| `invalid` | `bool` |  |
| `receiver` | `array` |  |
| `receiver_type` | `string` |  |
| `type` | `string` |  |
| `url` | `string` | WHATWG URL compliant |

#### Example: Load

```php
// load() returns the ENTITY — call data_get() for the Callback record (throws on error).
$callback = $client->Callback()->load(["id" => "callback_id"]);
```

#### Example: List

```php
// list() returns an array of Callback records (throws on error).
$callbacks = $client->Callback()->list();
```

#### Example: Create

```php
$callback = $client->Callback()->create([
]);
```


### Contact

Create an instance: `$contact = $client->Contact();`

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
| `collection` | `array` |  |
| `contact_expire_after` | `int` | Contact expire after days |
| `contacts_count` | `int` |  |
| `country` | `string` |  |
| `created_by` | `string` |  |
| `date_created` | `string` |  |
| `date_updated` | `string` |  |
| `description` | `string` |  |
| `email` | `string` |  |
| `first_name` | `string` |  |
| `gender` | `string` |  |
| `group_id` | `string` | Object ID |
| `groups` | `array` |  |
| `id` | `string` | Object ID |
| `idx` | `string` | User provided resource id |
| `last_name` | `string` |  |
| `name` | `string` | Group name |
| `permissions` | `array` |  |
| `phone_number` | `string` |  |
| `read` | `bool` | Has read permission |
| `send` | `bool` | Has send permission |
| `size` | `int` |  |
| `source` | `string` |  |
| `type` | `string` |  |
| `username` | `string` |  |
| `value` | `string` |  |
| `write` | `bool` | Has write permission |

#### Example: Load

```php
// load() returns the ENTITY — call data_get() for the Contact record (throws on error).
$contact = $client->Contact()->load(["id" => "contact_id"]);
```

#### Example: List

```php
// list() returns an array of Contact records (throws on error).
$contacts = $client->Contact()->list();
```

#### Example: Create

```php
$contact = $client->Contact()->create([
    "collection" => null, // array
    "contact_expire_after" => null, // int
    "contacts_count" => null, // int
    "created_by" => null, // string
    "date_created" => null, // string
    "date_updated" => null, // string
    "gender" => null, // string
    "groups" => null, // array
    "id" => null, // string
    "name" => null, // string
    "size" => null, // int
]);
```


### ContactsField

Create an instance: `$contacts_field = $client->ContactsField();`

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
| `contact_expire_after` | `int` | Contact expire after days |
| `contacts_count` | `int` |  |
| `country` | `string` |  |
| `created_by` | `string` |  |
| `date_created` | `string` |  |
| `date_updated` | `string` |  |
| `description` | `string` |  |
| `email` | `string` |  |
| `first_name` | `string` |  |
| `gender` | `string` |  |
| `group_id` | `string` | Object ID |
| `groups` | `array` |  |
| `id` | `string` | Object ID |
| `idx` | `string` | User provided resource id |
| `last_name` | `string` |  |
| `name` | `string` | Group name |
| `permissions` | `array` |  |
| `phone_number` | `string` |  |
| `read` | `bool` | Has read permission |
| `send` | `bool` | Has send permission |
| `source` | `string` |  |
| `type` | `string` |  |
| `username` | `string` |  |
| `value` | `string` |  |
| `write` | `bool` | Has write permission |

#### Example: List

```php
// list() returns an array of ContactsField records (throws on error).
$contacts_fields = $client->ContactsField()->list();
```

#### Example: Create

```php
$contacts_field = $client->ContactsField()->create([
    "contact_expire_after" => null, // int
    "created_by" => null, // string
    "date_created" => null, // string
    "date_updated" => null, // string
    "gender" => null, // string
    "groups" => null, // array
]);
```


### ContactsFieldOption

Create an instance: `$contacts_field_option = $client->ContactsFieldOption();`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `birthday_date` | `string` |  |
| `city` | `string` |  |
| `contact_expire_after` | `int` | Contact expire after days |
| `contacts_count` | `int` |  |
| `country` | `string` |  |
| `created_by` | `string` |  |
| `date_created` | `string` |  |
| `date_updated` | `string` |  |
| `description` | `string` |  |
| `email` | `string` |  |
| `first_name` | `string` |  |
| `gender` | `string` |  |
| `group_id` | `string` | Object ID |
| `groups` | `array` |  |
| `id` | `string` | Object ID |
| `idx` | `string` | User provided resource id |
| `last_name` | `string` |  |
| `name` | `string` | Group name |
| `permissions` | `array` |  |
| `phone_number` | `string` |  |
| `read` | `bool` | Has read permission |
| `send` | `bool` | Has send permission |
| `source` | `string` |  |
| `type` | `string` |  |
| `username` | `string` |  |
| `value` | `string` |  |
| `write` | `bool` | Has write permission |

#### Example: List

```php
// list() returns an array of ContactsFieldOption records (throws on error).
$contacts_field_options = $client->ContactsFieldOption()->list();
```


### Contactsgroup

Create an instance: `$contactsgroup = $client->Contactsgroup();`

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
| `contact_expire_after` | `int` | Contact expire after days |
| `contacts_count` | `int` |  |
| `country` | `string` |  |
| `created_by` | `string` |  |
| `date_created` | `string` |  |
| `date_updated` | `string` |  |
| `description` | `string` |  |
| `email` | `string` |  |
| `first_name` | `string` |  |
| `gender` | `string` |  |
| `group_id` | `string` | Object ID |
| `groups` | `array` |  |
| `id` | `string` | Object ID |
| `idx` | `string` | User provided resource id |
| `last_name` | `string` |  |
| `name` | `string` | Group name |
| `permissions` | `array` |  |
| `phone_number` | `string` |  |
| `read` | `bool` | Has read permission |
| `send` | `bool` | Has send permission |
| `source` | `string` |  |
| `type` | `string` |  |
| `username` | `string` |  |
| `value` | `string` |  |
| `write` | `bool` | Has write permission |

#### Example: List

```php
// list() returns an array of Contactsgroup records (throws on error).
$contactsgroups = $client->Contactsgroup()->list();
```

#### Example: Create

```php
$contactsgroup = $client->Contactsgroup()->create([
    "contact_expire_after" => null, // int
    "created_by" => null, // string
    "date_created" => null, // string
    "date_updated" => null, // string
    "gender" => null, // string
    "group_id" => null, // string
    "groups" => null, // array
    "id" => null, // string
    "read" => null, // bool
    "send" => null, // bool
    "username" => null, // string
    "write" => null, // bool
]);
```


### Contactstrash

Create an instance: `$contactstrash = $client->Contactstrash();`

#### Operations

| Method | Description |
| --- | --- |
| `remove(match)` | Remove the matching entity. |
| `update(data)` | Update an existing entity. |


### FieldAvailable

Create an instance: `$field_available = $client->FieldAvailable();`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `built_in` | `bool` |  |
| `id` | `string` | Object ID |
| `name` | `string` |  |
| `options` | `array` |  |
| `type` | `string` |  |

#### Example: List

```php
// list() returns an array of FieldAvailable records (throws on error).
$field_availables = $client->FieldAvailable()->list();
```


### Group

Create an instance: `$group = $client->Group();`

#### Operations

| Method | Description |
| --- | --- |
| `load(match)` | Load a single entity by match criteria. |
| `update(data)` | Update an existing entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `contact_expire_after` | `int` | Contact expire after days |
| `contacts_count` | `int` |  |
| `created_by` | `string` |  |
| `date_created` | `string` |  |
| `date_updated` | `string` |  |
| `description` | `string` |  |
| `id` | `string` | Object ID |
| `idx` | `string` | User provided resource id |
| `name` | `string` | Group name |
| `permissions` | `array` |  |

#### Example: Load

```php
// load() returns the ENTITY — call data_get() for the Group record (throws on error).
$group = $client->Group()->load(["id" => "group_id"]);
```


### MfaCode

Create an instance: `$mfa_code = $client->MfaCode();`

#### Operations

| Method | Description |
| --- | --- |
| `create(data)` | Create a new entity with the given data. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `content` | `string` | Custom content that must contain placeholder [%code%] |
| `fast` | `mixed` |  |
| `from` | `string` | Sendername |
| `phone_number` | `string` |  |

#### Example: Create

```php
$mfa_code = $client->MfaCode()->create([
    "phone_number" => null, // string
]);
```


### OptOut

Create an instance: `$opt_out = $client->OptOut();`

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
| `links` | `array` |  |
| `phoneNumber` | `int` |  |

#### Example: List

```php
// list() returns an array of OptOut records (throws on error).
$opt_outs = $client->OptOut()->list();
```


### OptOutSetting

Create an instance: `$opt_out_setting = $client->OptOutSetting();`

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

```php
// load() returns the ENTITY — call data_get() for the OptOutSetting record (throws on error).
$opt_out_setting = $client->OptOutSetting()->load();
```


### Permission

Create an instance: `$permission = $client->Permission();`

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
| `read` | `bool` | Has read permission |
| `send` | `bool` | Has send permission |
| `username` | `string` |  |
| `write` | `bool` | Has write permission |

#### Example: Load

```php
// load() returns the ENTITY — call data_get() for the Permission record (throws on error).
$permission = $client->Permission()->load(["id" => "permission_id", "group_id" => "group_id", "username" => "username"]);
```

#### Example: Create

```php
$permission = $client->Permission()->create([
    "group_id" => null, // string
    "read" => null, // bool
    "send" => null, // bool
    "username" => null, // string
    "write" => null, // bool
]);
```


### Ping

Create an instance: `$ping = $client->Ping();`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `authorized` | `bool` |  |
| `unavailable` | `array` |  |

#### Example: List

```php
// list() returns an array of Ping records (throws on error).
$pings = $client->Ping()->list();
```


### Profile

Create an instance: `$profile = $client->Profile();`

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
| `phone_number` | `int` |  |
| `points` | `float` |  |
| `user_type` | `string` |  |
| `username` | `string` |  |

#### Example: Load

```php
// load() returns the ENTITY — call data_get() for the Profile record (throws on error).
$profile = $client->Profile()->load();
```

#### Example: List

```php
// list() returns an array of Profile records (throws on error).
$profiles = $client->Profile()->list();
```


### Rcs

Create an instance: `$rcs = $client->Rcs();`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Example: List

```php
// list() returns an array of Rcs records (throws on error).
$rcss = $client->Rcs()->list();
```


### Sendername

Create an instance: `$sendername = $client->Sendername();`

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
| `is_default` | `bool` |  |
| `sender` | `string` | Sendername |
| `status` | `string` |  |

#### Example: Load

```php
// load() returns the ENTITY — call data_get() for the Sendername record (throws on error).
$sendername = $client->Sendername()->load(["id" => "sendername_id"]);
```

#### Example: List

```php
// list() returns an array of Sendername records (throws on error).
$sendernames = $client->Sendername()->list();
```

#### Example: Create

```php
$sendername = $client->Sendername()->create([
]);
```


### SendernameStatement

Create an instance: `$sendername_statement = $client->SendernameStatement();`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `content` | `string` |  |
| `statements` | `array` |  |
| `title` | `string` |  |

#### Example: List

```php
// list() returns an array of SendernameStatement records (throws on error).
$sendername_statements = $client->SendernameStatement()->list();
```


### SentRcsMessage

Create an instance: `$sent_rcs_message = $client->SentRcsMessage();`

#### Operations

| Method | Description |
| --- | --- |
| `create(data)` | Create a new entity with the given data. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `content` | `array` | RCS message content in RCS JSON format. |
| `phone_number` | `string` | Recipient phone number (e.g. |
| `sender` | `mixed` |  |
| `text` | `string` | Plain text message content. |

#### Example: Create

```php
$sent_rcs_message = $client->SentRcsMessage()->create([
    "phone_number" => null, // string
    "sender" => null, // mixed
]);
```


### ShipmentCountryVolume

Create an instance: `$shipment_country_volume = $client->ShipmentCountryVolume();`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `country_code` | `string` |  |
| `country_limit` | `int` |  |
| `country_name` | `string` |  |
| `usage` | `int` |  |

#### Example: List

```php
// list() returns an array of ShipmentCountryVolume records (throws on error).
$shipment_country_volumes = $client->ShipmentCountryVolume()->list();
```


### ShortUrl

Create an instance: `$short_url = $client->ShortUrl();`

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
| `hits` | `int` |  |
| `hits_unique` | `int` |  |
| `id` | `string` |  |
| `name` | `string` |  |
| `short_url` | `string` | WHATWG URL compliant |
| `type` | `string` |  |
| `url` | `string` | WHATWG URL compliant |

#### Example: Load

```php
// load() returns the ENTITY — call data_get() for the ShortUrl record (throws on error).
$short_url = $client->ShortUrl()->load(["id" => "short_url_id"]);
```

#### Example: List

```php
// list() returns an array of ShortUrl records (throws on error).
$short_urls = $client->ShortUrl()->list();
```

#### Example: Create

```php
$short_url = $client->ShortUrl()->create([
]);
```


### Smsdo

Create an instance: `$smsdo = $client->Smsdo();`

#### Operations

| Method | Description |
| --- | --- |
| `create(data)` | Create a new entity with the given data. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `allow_duplicates` | `int` | When parameter allow_duplicates is set to "1" allows to send message to duplicated numbers in one request (useful i.e. |
| `check_idx` | `mixed` | When parameter check_idx is set to „1” prevents from sending more than one message with the same idx in last 24h. |
| `date` | `mixed` | Date in UNIX timestamp (&date=1287734110) or in ISO 8601 (&date=2012-05-10T08:40:27+00:00) when message will be sent (&date=1287734110). |
| `date_validate` | `int` | When parameter date_validate is set to "1" checks if date if given in proper format. |
| `details` | `mixed` | When details parameter is set to "1" more details in response will be displayed (message length and sms count). |
| `encoding` | `string` | This parameter describes the encoding of the message text. |
| `expiration_date` | `mixed` | Message expiration date (in UNIX timestamp or in ISO 8601) is a date after which message won't be delivered if it wasn't delivered yet. |
| `fallback` | `array` | Enable fallback in case sms sending fails |
| `fast` | `int` | Setting this parameter to „1” will result in sending message with the highest priority which ensures the quickest possible time of delivery. |
| `flash` | `int` | Sending a message in flash mode can be activated by setting this parameter to "1". |
| `format` | `string` | Parameter &format=json causes, that response is sending in JSON format. |
| `from` | `string` | Name of the sender. |
| `group` | `string` | Name of the group from the contacts database to which message should be sent to. |
| `idx` | `string` | Optional custom value sent with SMS and sent back in CALLBACK. |
| `max_parts` | `int` | Defines maximum message parts allowed, maximum value allowed is 6. |
| `message` | `string` | The message text. |
| `normalize` | `int` | When parameter normalize is set to „1” special chars in message will be replaced with their equivalents (ê-e, ñ-n, ý-y ...). |
| `notify_url` | `string` | Parameter allows to set CALLBACK URL for message from request. |
| `test` | `mixed` | When parameter test is set to "1" message won't be sent but response will be displayed, there is no charge for such test messages. |
| `time_restriction` | `string` | Sets the behavior when you try to ship in hours / dates that do not match the settings in your account. |
| `to` | `string` | Recipients' mobile phone numbers (i.e. |

#### Example: Create

```php
$smsdo = $client->Smsdo()->create([
]);
```


### Smssendername

Create an instance: `$smssendername = $client->Smssendername();`

#### Operations

| Method | Description |
| --- | --- |
| `create(data)` | Create a new entity with the given data. |
| `remove(match)` | Remove the matching entity. |

#### Example: Create

```php
$smssendername = $client->Smssendername()->create([
    "sendername_id" => null, // string
]);
```


### Smstemplate

Create an instance: `$smstemplate = $client->Smstemplate();`

#### Operations

| Method | Description |
| --- | --- |
| `remove(match)` | Remove the matching entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `id` | `string` |  |


### Subuser

Create an instance: `$subuser = $client->Subuser();`

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
| `active` | `bool` |  |
| `credentials` | `array` |  |
| `description` | `string` |  |
| `id` | `string` | Object ID |
| `points` | `array` |  |
| `username` | `string` |  |

#### Example: Load

```php
// load() returns the ENTITY — call data_get() for the Subuser record (throws on error).
$subuser = $client->Subuser()->load(["id" => "subuser_id"]);
```

#### Example: List

```php
// list() returns an array of Subuser records (throws on error).
$subusers = $client->Subuser()->list();
```

#### Example: Create

```php
$subuser = $client->Subuser()->create([
    "credentials" => null, // array
]);
```


### Template

Create an instance: `$template = $client->Template();`

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
| `normalize` | `bool` |  |
| `template` | `string` |  |

#### Example: Load

```php
// load() returns the ENTITY — call data_get() for the Template record (throws on error).
$template = $client->Template()->load(["id" => "template_id"]);
```

#### Example: List

```php
// list() returns an array of Template records (throws on error).
$templates = $client->Template()->list();
```

#### Example: Create

```php
$template = $client->Template()->create([
]);
```


### UserRcsSenderCollection

Create an instance: `$user_rcs_sender_collection = $client->UserRcsSenderCollection();`

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

```php
// list() returns an array of UserRcsSenderCollection records (throws on error).
$user_rcs_sender_collections = $client->UserRcsSenderCollection()->list();
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

Features are the extension mechanism. A feature is a PHP class
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

### Data as arrays

The PHP SDK uses plain PHP associative arrays throughout rather than typed
objects. This mirrors the dynamic nature of the API and keeps the
SDK flexible — no code generation is needed when the API schema
changes.

Use `Helpers::to_map()` to safely validate that a value is an array.

### Directory structure

```
php/
├── smsapi_sdk.php          -- Main SDK class
├── config.php                     -- Configuration
├── schema.php                     -- Generated option + entity specs
├── features.php                   -- Feature factory
├── core/                          -- Core types and context
├── entity/                        -- Entity implementations
├── feature/                       -- Built-in features (Base, Test, Log)
├── utility/                       -- Utility functions and struct library
└── test/                          -- Test suites
```

The main class (`smsapi_sdk.php`) exports the SDK class
and test helper. Import entity or utility modules directly only
when needed.

### Entity state

Entity instances are stateful. After a successful `load`, the entity
stores the returned data and match criteria internally.

```php
$permission = $client->Permission();
$permission->load(["group_id" => "example", "id" => "example_id", "username" => "example"]);

// $permission->data_get() now returns the permission data from the last load
// $permission->match_get() returns the last match criteria
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
