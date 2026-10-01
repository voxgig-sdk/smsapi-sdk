# Smsapi Golang SDK

An MCP server and CLI for the SMSAPI REST API, plus clients in 20 languages and a pandas data layer, generated from SMSAPI's public OpenAPI spec so AI agents can reach SMSAPI the way the official SDKs already let developers.

The Golang SDK for the Smsapi API — an entity-oriented client using standard Go conventions. No generics required; data flows as `map[string]any`.

It exposes the API as capitalised, semantic **Entities** — e.g. `client.Available(nil)` — each with the same small set of operations (`List`, `Load`, `Create`, `Update`, `Remove`) instead of raw URL paths and query strings. You call meaning, not endpoints, which keeps the cognitive load low.

> Also generated from this model: `c`, `clojure`, `cpp`, `csharp`, `elixir`, `go-cli`, `go-mcp`, `java`, `js`, `kotlin`, `lua`, `ocaml`, `perl`, `php`, `py`, `py-data`, `rb`, `rust`, `scala`, `swift`, `ts`, `zig` — see
> the [top-level README](../README.md).


## Install
```bash
go get github.com/voxgig-sdk/smsapi-sdk/go@latest
```

The Go module proxy resolves the version from the `go/vX.Y.Z` GitHub
release tag — see [Releases](https://github.com/voxgig-sdk/smsapi-sdk/releases) for the available versions.

To vendor from a local checkout instead, clone this repo alongside your
project and add a `replace` directive pointing at the checked-out
`go/` directory:

```bash
go mod edit -replace github.com/voxgig-sdk/smsapi-sdk/go=../smsapi-sdk/go
```


## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record.

### Quickstart

A complete program: create a client, then call the entity operations.
Each operation returns `(value, error)` — the value is the data itself
(there is no `{ok, data}` wrapper), so check `err` and use the value
directly.

```go
package main

import (
    "fmt"
    "os"
    sdk "github.com/voxgig-sdk/smsapi-sdk/go"
)

func main() {
    client := sdk.NewSmsapiSDK(map[string]any{
        "apikey": os.Getenv("SMSAPI_APIKEY"),
    })

    // List available records — the value is the array of records itself.
    availables, err := client.Available(nil).List(nil, nil)
    if err != nil {
        panic(err)
    }
    for _, item := range availables.([]any) {
        fmt.Println(item)
    }
}
```


## Error handling

Every entity operation returns `(value, error)`. Check `err` before
using the value — there is no exception to catch:

```go
permission, err := client.Permission(nil).Load(map[string]any{"group_id": "example", "id": "example_id", "username": "example"}, nil)
if err != nil {
    // handle err
    return
}
_ = permission
```

`Direct` follows the same `(value, error)` convention:

```go
result, err := client.Direct(map[string]any{
    "path":   "/api/resource/{id}",
    "method": "GET",
    "params": map[string]any{"id": "example_id"},
})
if err != nil {
    // handle err
}
_ = result
```


## How-to guides

### Make a direct HTTP request

For endpoints not covered by entity methods:

```go
result, err := client.Direct(map[string]any{
    "path":   "/api/resource/{id}",
    "method": "GET",
    "params": map[string]any{"id": "example"},
})
if err != nil {
    panic(err)
}

if result["ok"] == true {
    fmt.Println(result["status"]) // 200
    fmt.Println(result["data"])   // response body
}
```

### Prepare a request without sending it

```go
fetchdef, err := client.Prepare(map[string]any{
    "path":   "/api/resource/{id}",
    "method": "DELETE",
    "params": map[string]any{"id": "example"},
})
if err != nil {
    panic(err)
}

fmt.Println(fetchdef["url"])
fmt.Println(fetchdef["method"])
fmt.Println(fetchdef["headers"])
```

### Use test mode

Create a mock client for unit testing — no server required:

```go
client := sdk.Test()

permission, err := client.Permission(nil).Load(
    map[string]any{"id": "test01", "group_id": "example", "username": "example"}, nil,
)
if err != nil {
    panic(err)
}
fmt.Println(permission) // the returned mock data
```

### Use a custom fetch function

Replace the HTTP transport with your own function:

```go
mockFetch := func(url string, init map[string]any) (map[string]any, error) {
    return map[string]any{
        "status":     200,
        "statusText": "OK",
        "headers":    map[string]any{},
        "json": (func() any)(func() any {
            return map[string]any{"id": "mock01"}
        }),
    }, nil
}

client := sdk.NewSmsapiSDK(map[string]any{
    "base": "http://localhost:8080",
    "system": map[string]any{
        "fetch": (func(string, map[string]any) (map[string]any, error))(mockFetch),
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
cd go && go test ./test/...
```


## Reference

### NewSmsapiSDK

```go
func NewSmsapiSDK(options map[string]any) *SmsapiSDK
```

Creates a new SDK client.

| Option | Type | Description |
| --- | --- | --- |
| `"apikey"` | `string` | API key for authentication. |
| `"base"` | `string` | Base URL of the API server. |
| `"prefix"` | `string` | URL path prefix prepended to all requests. |
| `"suffix"` | `string` | URL path suffix appended to all requests. |
| `"feature"` | `map[string]any` | Feature activation flags. |
| `"extend"` | `[]any` | Additional Feature instances to load. |
| `"system"` | `map[string]any` | System overrides (e.g. custom `"fetch"` function). |

### TestSDK

```go
func TestSDK(testopts map[string]any, sdkopts map[string]any) *SmsapiSDK
```

Creates a test-mode client with mock transport. Both arguments may be `nil`.

### SmsapiSDK methods

| Method | Signature | Description |
| --- | --- | --- |
| `OptionsMap` | `() map[string]any` | Deep copy of current SDK options. |
| `GetUtility` | `() *Utility` | Copy of the SDK utility object. |
| `Prepare` | `(fetchargs map[string]any) (map[string]any, error)` | Build an HTTP request definition without sending. |
| `Direct` | `(fetchargs map[string]any) (map[string]any, error)` | Build and send an HTTP request. |
| `Available` | `(data map[string]any) SmsapiEntity` | Create an Available entity instance. |
| `Blacklist` | `(data map[string]any) SmsapiEntity` | Create a Blacklist entity instance. |
| `Callback` | `(data map[string]any) SmsapiEntity` | Create a Callback entity instance. |
| `Contact` | `(data map[string]any) SmsapiEntity` | Create a Contact entity instance. |
| `ContactsField` | `(data map[string]any) SmsapiEntity` | Create a ContactsField entity instance. |
| `ContactsFieldOption` | `(data map[string]any) SmsapiEntity` | Create a ContactsFieldOption entity instance. |
| `Contactsgroup` | `(data map[string]any) SmsapiEntity` | Create a Contactsgroup entity instance. |
| `Contactstrash` | `(data map[string]any) SmsapiEntity` | Create a Contactstrash entity instance. |
| `FieldAvailable` | `(data map[string]any) SmsapiEntity` | Create a FieldAvailable entity instance. |
| `Group` | `(data map[string]any) SmsapiEntity` | Create a Group entity instance. |
| `MfaCode` | `(data map[string]any) SmsapiEntity` | Create a MfaCode entity instance. |
| `OptOut` | `(data map[string]any) SmsapiEntity` | Create an OptOut entity instance. |
| `OptOutSetting` | `(data map[string]any) SmsapiEntity` | Create an OptOutSetting entity instance. |
| `Permission` | `(data map[string]any) SmsapiEntity` | Create a Permission entity instance. |
| `Ping` | `(data map[string]any) SmsapiEntity` | Create a Ping entity instance. |
| `Profile` | `(data map[string]any) SmsapiEntity` | Create a Profile entity instance. |
| `Rcs` | `(data map[string]any) SmsapiEntity` | Create a Rcs entity instance. |
| `Sendername` | `(data map[string]any) SmsapiEntity` | Create a Sendername entity instance. |
| `SendernameStatement` | `(data map[string]any) SmsapiEntity` | Create a SendernameStatement entity instance. |
| `SentRcsMessage` | `(data map[string]any) SmsapiEntity` | Create a SentRcsMessage entity instance. |
| `ShipmentCountryVolume` | `(data map[string]any) SmsapiEntity` | Create a ShipmentCountryVolume entity instance. |
| `ShortUrl` | `(data map[string]any) SmsapiEntity` | Create a ShortUrl entity instance. |
| `Smsdo` | `(data map[string]any) SmsapiEntity` | Create a Smsdo entity instance. |
| `Smssendername` | `(data map[string]any) SmsapiEntity` | Create a Smssendername entity instance. |
| `Smstemplate` | `(data map[string]any) SmsapiEntity` | Create a Smstemplate entity instance. |
| `Subuser` | `(data map[string]any) SmsapiEntity` | Create a Subuser entity instance. |
| `Template` | `(data map[string]any) SmsapiEntity` | Create a Template entity instance. |
| `UserRcsSenderCollection` | `(data map[string]any) SmsapiEntity` | Create an UserRcsSenderCollection entity instance. |

### Entity interface (SmsapiEntity)

All entities implement the `SmsapiEntity` interface.

| Method | Signature | Description |
| --- | --- | --- |
| `Load` | `(reqmatch, ctrl map[string]any) (any, error)` | Load a single entity by match criteria. |
| `List` | `(reqmatch, ctrl map[string]any) (any, error)` | List entities matching the criteria. |
| `Create` | `(reqdata, ctrl map[string]any) (any, error)` | Create a new entity. |
| `Update` | `(reqdata, ctrl map[string]any) (any, error)` | Update an existing entity. |
| `Remove` | `(reqmatch, ctrl map[string]any) (any, error)` | Remove an entity. |
| `Data` | `(args ...any) any` | Get or set entity data. |
| `Match` | `(args ...any) any` | Get or set entity match criteria. |
| `Make` | `() Entity` | Create a new instance with the same options. |
| `GetName` | `() string` | Return the entity name. |

### Result shape

Entity operations return `(value, error)`. The `value` is the
operation's data **directly** — there is no wrapper:

| Operation | `value` |
| --- | --- |
| `Load` / `Create` / `Update` / `Remove` | the entity record (`map[string]any`) |
| `List` | a `[]any` of entity records |

Check `err` first, then use the value directly (or the typed
`...Typed` variants, which return the entity's model struct and a typed
slice):

    available, err := client.Available(nil).List(map[string]any{/* fields */}, nil)
    if err != nil { /* handle */ }
    // available is the returned record

Only `Direct()` returns a response envelope — a `map[string]any` with
`"ok"`, `"status"`, `"headers"`, and `"data"` keys.

### Entities

#### Available

| Field | Description |
| --- | --- |
| `"name"` |  |
| `"normalize"` |  |
| `"template"` |  |

Operations: List.

API path: `/sms/templates/available`

#### Blacklist

| Field | Description |
| --- | --- |
| `"id"` |  |

Operations: Create, Load, Remove.

API path: `/blacklist/phone_numbers`

#### Callback

| Field | Description |
| --- | --- |
| `"active"` |  |
| `"api_version"` | Version of the callback output format. |
| `"id"` | Object ID |
| `"invalid"` |  |
| `"receiver"` |  |
| `"receiver_type"` |  |
| `"type"` |  |
| `"url"` | WHATWG URL compliant |

Operations: Create, List, Load, Remove, Update.

API path: `/callbacks`

#### Contact

| Field | Description |
| --- | --- |
| `"birthday_date"` |  |
| `"city"` |  |
| `"collection"` |  |
| `"contact_expire_after"` | Contact expire after days |
| `"contacts_count"` |  |
| `"country"` |  |
| `"created_by"` |  |
| `"date_created"` |  |
| `"date_updated"` |  |
| `"description"` |  |
| `"email"` |  |
| `"first_name"` |  |
| `"gender"` |  |
| `"group_id"` | Object ID |
| `"groups"` |  |
| `"id"` | Object ID |
| `"idx"` | User provided resource id |
| `"last_name"` |  |
| `"name"` | Group name |
| `"permissions"` |  |
| `"phone_number"` |  |
| `"read"` | Has read permission |
| `"send"` | Has send permission |
| `"size"` |  |
| `"source"` |  |
| `"type"` |  |
| `"username"` |  |
| `"value"` |  |
| `"write"` | Has write permission |

Operations: Create, List, Load, Remove, Update.

API path: `/contacts/{contactId}/groups`

#### ContactsField

| Field | Description |
| --- | --- |
| `"birthday_date"` |  |
| `"city"` |  |
| `"contact_expire_after"` | Contact expire after days |
| `"contacts_count"` |  |
| `"country"` |  |
| `"created_by"` |  |
| `"date_created"` |  |
| `"date_updated"` |  |
| `"description"` |  |
| `"email"` |  |
| `"first_name"` |  |
| `"gender"` |  |
| `"group_id"` | Object ID |
| `"groups"` |  |
| `"id"` | Object ID |
| `"idx"` | User provided resource id |
| `"last_name"` |  |
| `"name"` | Group name |
| `"permissions"` |  |
| `"phone_number"` |  |
| `"read"` | Has read permission |
| `"send"` | Has send permission |
| `"source"` |  |
| `"type"` |  |
| `"username"` |  |
| `"value"` |  |
| `"write"` | Has write permission |

Operations: Create, List, Remove, Update.

API path: `/contacts/fields`

#### ContactsFieldOption

| Field | Description |
| --- | --- |
| `"birthday_date"` |  |
| `"city"` |  |
| `"contact_expire_after"` | Contact expire after days |
| `"contacts_count"` |  |
| `"country"` |  |
| `"created_by"` |  |
| `"date_created"` |  |
| `"date_updated"` |  |
| `"description"` |  |
| `"email"` |  |
| `"first_name"` |  |
| `"gender"` |  |
| `"group_id"` | Object ID |
| `"groups"` |  |
| `"id"` | Object ID |
| `"idx"` | User provided resource id |
| `"last_name"` |  |
| `"name"` | Group name |
| `"permissions"` |  |
| `"phone_number"` |  |
| `"read"` | Has read permission |
| `"send"` | Has send permission |
| `"source"` |  |
| `"type"` |  |
| `"username"` |  |
| `"value"` |  |
| `"write"` | Has write permission |

Operations: List.

API path: `/contacts/fields/{fieldId}/options`

#### Contactsgroup

| Field | Description |
| --- | --- |
| `"birthday_date"` |  |
| `"city"` |  |
| `"contact_expire_after"` | Contact expire after days |
| `"contacts_count"` |  |
| `"country"` |  |
| `"created_by"` |  |
| `"date_created"` |  |
| `"date_updated"` |  |
| `"description"` |  |
| `"email"` |  |
| `"first_name"` |  |
| `"gender"` |  |
| `"group_id"` | Object ID |
| `"groups"` |  |
| `"id"` | Object ID |
| `"idx"` | User provided resource id |
| `"last_name"` |  |
| `"name"` | Group name |
| `"permissions"` |  |
| `"phone_number"` |  |
| `"read"` | Has read permission |
| `"send"` | Has send permission |
| `"source"` |  |
| `"type"` |  |
| `"username"` |  |
| `"value"` |  |
| `"write"` | Has write permission |

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
| `"built_in"` |  |
| `"id"` | Object ID |
| `"name"` |  |
| `"options"` |  |
| `"type"` |  |

Operations: List.

API path: `/contacts/fields/available`

#### Group

| Field | Description |
| --- | --- |
| `"contact_expire_after"` | Contact expire after days |
| `"contacts_count"` |  |
| `"created_by"` |  |
| `"date_created"` |  |
| `"date_updated"` |  |
| `"description"` |  |
| `"id"` | Object ID |
| `"idx"` | User provided resource id |
| `"name"` | Group name |
| `"permissions"` |  |

Operations: Load, Update.

API path: `/contacts/groups/{groupId}`

#### MfaCode

| Field | Description |
| --- | --- |
| `"content"` | Custom content that must contain placeholder [%code%] |
| `"fast"` |  |
| `"from"` | Sendername |
| `"phone_number"` |  |

Operations: Create.

API path: `/mfa/codes`

#### OptOut

| Field | Description |
| --- | --- |
| `"date"` |  |
| `"id"` |  |
| `"links"` |  |
| `"phoneNumber"` |  |

Operations: List, Remove.

API path: `/opt_outs`

#### OptOutSetting

| Field | Description |
| --- | --- |
| `"brand"` |  |

Operations: Load, Update.

API path: `/opt_outs/settings`

#### Permission

| Field | Description |
| --- | --- |
| `"group_id"` | Object ID |
| `"id"` |  |
| `"read"` | Has read permission |
| `"send"` | Has send permission |
| `"username"` |  |
| `"write"` | Has write permission |

Operations: Create, Load.

API path: `/contacts/groups/{groupId}/permissions`

#### Ping

| Field | Description |
| --- | --- |
| `"authorized"` |  |
| `"unavailable"` |  |

Operations: List.

API path: `/ping`

#### Profile

| Field | Description |
| --- | --- |
| `"email"` |  |
| `"name"` |  |
| `"payment_type"` |  |
| `"phone_number"` |  |
| `"points"` |  |
| `"user_type"` |  |
| `"username"` |  |

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
| `"created_at"` |  |
| `"id"` |  |
| `"is_default"` |  |
| `"sender"` | Sendername |
| `"status"` |  |

Operations: Create, List, Load.

API path: `/sms/sendernames`

#### SendernameStatement

| Field | Description |
| --- | --- |
| `"content"` |  |
| `"statements"` |  |
| `"title"` |  |

Operations: List.

API path: `/sms/sendernames/statement`

#### SentRcsMessage

| Field | Description |
| --- | --- |
| `"content"` | RCS message content in RCS JSON format. |
| `"phone_number"` | Recipient phone number (e.g. |
| `"sender"` |  |
| `"text"` | Plain text message content. |

Operations: Create.

API path: `/rcs/messages`

#### ShipmentCountryVolume

| Field | Description |
| --- | --- |
| `"country_code"` |  |
| `"country_limit"` |  |
| `"country_name"` |  |
| `"usage"` |  |

Operations: List.

API path: `/shipment/country_volumes`

#### ShortUrl

| Field | Description |
| --- | --- |
| `"description"` |  |
| `"expire"` |  |
| `"filename"` |  |
| `"hits"` |  |
| `"hits_unique"` |  |
| `"id"` |  |
| `"name"` |  |
| `"short_url"` | WHATWG URL compliant |
| `"type"` |  |
| `"url"` | WHATWG URL compliant |

Operations: Create, List, Load, Remove, Update.

API path: `/short_url/links`

#### Smsdo

| Field | Description |
| --- | --- |
| `"allow_duplicates"` | When parameter allow_duplicates is set to "1" allows to send message to duplicated numbers in one request (useful i.e. |
| `"check_idx"` | When parameter check_idx is set to „1” prevents from sending more than one message with the same idx in last 24h. |
| `"date"` | Date in UNIX timestamp (&date=1287734110) or in ISO 8601 (&date=2012-05-10T08:40:27+00:00) when message will be sent (&date=1287734110). |
| `"date_validate"` | When parameter date_validate is set to "1" checks if date if given in proper format. |
| `"details"` | When details parameter is set to "1" more details in response will be displayed (message length and sms count). |
| `"encoding"` | This parameter describes the encoding of the message text. |
| `"expiration_date"` | Message expiration date (in UNIX timestamp or in ISO 8601) is a date after which message won't be delivered if it wasn't delivered yet. |
| `"fallback"` | Enable fallback in case sms sending fails |
| `"fast"` | Setting this parameter to „1” will result in sending message with the highest priority which ensures the quickest possible time of delivery. |
| `"flash"` | Sending a message in flash mode can be activated by setting this parameter to "1". |
| `"format"` | Parameter &format=json causes, that response is sending in JSON format. |
| `"from"` | Name of the sender. |
| `"group"` | Name of the group from the contacts database to which message should be sent to. |
| `"idx"` | Optional custom value sent with SMS and sent back in CALLBACK. |
| `"max_parts"` | Defines maximum message parts allowed, maximum value allowed is 6. |
| `"message"` | The message text. |
| `"normalize"` | When parameter normalize is set to „1” special chars in message will be replaced with their equivalents (ê-e, ñ-n, ý-y ...). |
| `"notify_url"` | Parameter allows to set CALLBACK URL for message from request. |
| `"test"` | When parameter test is set to "1" message won't be sent but response will be displayed, there is no charge for such test messages. |
| `"time_restriction"` | Sets the behavior when you try to ship in hours / dates that do not match the settings in your account. |
| `"to"` | Recipients' mobile phone numbers (i.e. |

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
| `"id"` |  |

Operations: Remove.

API path: `/sms/templates/{id}`

#### Subuser

| Field | Description |
| --- | --- |
| `"active"` |  |
| `"credentials"` |  |
| `"description"` |  |
| `"id"` | Object ID |
| `"points"` |  |
| `"username"` |  |

Operations: Create, List, Load, Remove, Update.

API path: `/subusers`

#### Template

| Field | Description |
| --- | --- |
| `"id"` |  |
| `"name"` |  |
| `"normalize"` |  |
| `"template"` |  |

Operations: Create, List, Load, Update.

API path: `/sms/templates`

#### UserRcsSenderCollection

| Field | Description |
| --- | --- |
| `"deliveredAt"` |  |
| `"expiredAt"` |  |
| `"id"` | Object ID |
| `"interface"` | Interface through which the message was sent (www, api, ...). |
| `"messageType"` | RCS message type (basic, single, ...). |
| `"readAt"` |  |
| `"recipient"` | Recipient phone number (without +). |
| `"sender"` | Sender name |
| `"senderId"` | Sender id |
| `"sentAt"` |  |

Operations: List.

API path: `/rcs/senders`



## Entities


### Available

Create an instance: `available := client.Available(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `List(match, ctrl)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `name` | `string` |  |
| `normalize` | `bool` |  |
| `template` | `string` |  |

#### Example: List

```go
availables, err := client.Available(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(availables) // the array of records
```


### Blacklist

Create an instance: `blacklist := client.Blacklist(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `Load(match, ctrl)` | Load a single entity by match criteria. |
| `Create(data, ctrl)` | Create a new entity with the given data. |
| `Remove(match, ctrl)` | Remove the matching entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `id` | `string` |  |

#### Example: Load

```go
blacklist, err := client.Blacklist(nil).Load(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(blacklist) // the loaded record
```

#### Example: Create

```go
result, err := client.Blacklist(nil).Create(map[string]any{
}, nil)
if err != nil {
    panic(err)
}
fmt.Println(result)
```


### Callback

Create an instance: `callback := client.Callback(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `List(match, ctrl)` | List entities matching the criteria. |
| `Load(match, ctrl)` | Load a single entity by match criteria. |
| `Create(data, ctrl)` | Create a new entity with the given data. |
| `Update(data, ctrl)` | Update an existing entity. |
| `Remove(match, ctrl)` | Remove the matching entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `active` | `bool` |  |
| `api_version` | `int` | Version of the callback output format. |
| `id` | `string` | Object ID |
| `invalid` | `bool` |  |
| `receiver` | `map[string]any` |  |
| `receiver_type` | `string` |  |
| `type` | `string` |  |
| `url` | `string` | WHATWG URL compliant |

#### Example: Load

```go
callback, err := client.Callback(nil).Load(map[string]any{"id": "callback_id"}, nil)
if err != nil {
    panic(err)
}
fmt.Println(callback) // the loaded record
```

#### Example: List

```go
callbacks, err := client.Callback(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(callbacks) // the array of records
```

#### Example: Create

```go
result, err := client.Callback(nil).Create(map[string]any{
}, nil)
if err != nil {
    panic(err)
}
fmt.Println(result)
```


### Contact

Create an instance: `contact := client.Contact(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `List(match, ctrl)` | List entities matching the criteria. |
| `Load(match, ctrl)` | Load a single entity by match criteria. |
| `Create(data, ctrl)` | Create a new entity with the given data. |
| `Update(data, ctrl)` | Update an existing entity. |
| `Remove(match, ctrl)` | Remove the matching entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `birthday_date` | `string` |  |
| `city` | `string` |  |
| `collection` | `[]any` |  |
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
| `groups` | `[]any` |  |
| `id` | `string` | Object ID |
| `idx` | `string` | User provided resource id |
| `last_name` | `string` |  |
| `name` | `string` | Group name |
| `permissions` | `[]any` |  |
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

```go
contact, err := client.Contact(nil).Load(map[string]any{"id": "contact_id"}, nil)
if err != nil {
    panic(err)
}
fmt.Println(contact) // the loaded record
```

#### Example: List

```go
contacts, err := client.Contact(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(contacts) // the array of records
```

#### Example: Create

```go
result, err := client.Contact(nil).Create(map[string]any{
    "collection": []any{},
    "contact_expire_after": 1,
    "contacts_count": 1,
    "created_by": "example_created_by",
    "date_created": "example_date_created",
    "date_updated": "example_date_updated",
    "gender": "example_gender",
    "groups": []any{},
    "id": "example_id",
    "name": "example_name",
    "size": 1,
}, nil)
if err != nil {
    panic(err)
}
fmt.Println(result)
```


### ContactsField

Create an instance: `contactsField := client.ContactsField(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `List(match, ctrl)` | List entities matching the criteria. |
| `Create(data, ctrl)` | Create a new entity with the given data. |
| `Update(data, ctrl)` | Update an existing entity. |
| `Remove(match, ctrl)` | Remove the matching entity. |

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
| `groups` | `[]any` |  |
| `id` | `string` | Object ID |
| `idx` | `string` | User provided resource id |
| `last_name` | `string` |  |
| `name` | `string` | Group name |
| `permissions` | `[]any` |  |
| `phone_number` | `string` |  |
| `read` | `bool` | Has read permission |
| `send` | `bool` | Has send permission |
| `source` | `string` |  |
| `type` | `string` |  |
| `username` | `string` |  |
| `value` | `string` |  |
| `write` | `bool` | Has write permission |

#### Example: List

```go
contactsFields, err := client.ContactsField(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(contactsFields) // the array of records
```

#### Example: Create

```go
result, err := client.ContactsField(nil).Create(map[string]any{
    "contact_expire_after": 1,
    "created_by": "example_created_by",
    "date_created": "example_date_created",
    "date_updated": "example_date_updated",
    "gender": "example_gender",
    "groups": []any{},
}, nil)
if err != nil {
    panic(err)
}
fmt.Println(result)
```


### ContactsFieldOption

Create an instance: `contactsFieldOption := client.ContactsFieldOption(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `List(match, ctrl)` | List entities matching the criteria. |

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
| `groups` | `[]any` |  |
| `id` | `string` | Object ID |
| `idx` | `string` | User provided resource id |
| `last_name` | `string` |  |
| `name` | `string` | Group name |
| `permissions` | `[]any` |  |
| `phone_number` | `string` |  |
| `read` | `bool` | Has read permission |
| `send` | `bool` | Has send permission |
| `source` | `string` |  |
| `type` | `string` |  |
| `username` | `string` |  |
| `value` | `string` |  |
| `write` | `bool` | Has write permission |

#### Example: List

```go
contactsFieldOptions, err := client.ContactsFieldOption(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(contactsFieldOptions) // the array of records
```


### Contactsgroup

Create an instance: `contactsgroup := client.Contactsgroup(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `List(match, ctrl)` | List entities matching the criteria. |
| `Create(data, ctrl)` | Create a new entity with the given data. |
| `Update(data, ctrl)` | Update an existing entity. |
| `Remove(match, ctrl)` | Remove the matching entity. |

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
| `groups` | `[]any` |  |
| `id` | `string` | Object ID |
| `idx` | `string` | User provided resource id |
| `last_name` | `string` |  |
| `name` | `string` | Group name |
| `permissions` | `[]any` |  |
| `phone_number` | `string` |  |
| `read` | `bool` | Has read permission |
| `send` | `bool` | Has send permission |
| `source` | `string` |  |
| `type` | `string` |  |
| `username` | `string` |  |
| `value` | `string` |  |
| `write` | `bool` | Has write permission |

#### Example: List

```go
contactsgroups, err := client.Contactsgroup(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(contactsgroups) // the array of records
```

#### Example: Create

```go
result, err := client.Contactsgroup(nil).Create(map[string]any{
    "contact_expire_after": 1,
    "created_by": "example_created_by",
    "date_created": "example_date_created",
    "date_updated": "example_date_updated",
    "gender": "example_gender",
    "group_id": "example_group_id",
    "groups": []any{},
    "id": "example_id",
    "read": true,
    "send": true,
    "username": "example_username",
    "write": true,
}, nil)
if err != nil {
    panic(err)
}
fmt.Println(result)
```


### Contactstrash

Create an instance: `contactstrash := client.Contactstrash(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `Update(data, ctrl)` | Update an existing entity. |
| `Remove(match, ctrl)` | Remove the matching entity. |


### FieldAvailable

Create an instance: `fieldAvailable := client.FieldAvailable(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `List(match, ctrl)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `built_in` | `bool` |  |
| `id` | `string` | Object ID |
| `name` | `string` |  |
| `options` | `[]any` |  |
| `type` | `string` |  |

#### Example: List

```go
fieldAvailables, err := client.FieldAvailable(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(fieldAvailables) // the array of records
```


### Group

Create an instance: `group := client.Group(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `Load(match, ctrl)` | Load a single entity by match criteria. |
| `Update(data, ctrl)` | Update an existing entity. |

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
| `permissions` | `[]any` |  |

#### Example: Load

```go
group, err := client.Group(nil).Load(map[string]any{"id": "group_id"}, nil)
if err != nil {
    panic(err)
}
fmt.Println(group) // the loaded record
```


### MfaCode

Create an instance: `mfaCode := client.MfaCode(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `Create(data, ctrl)` | Create a new entity with the given data. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `content` | `string` | Custom content that must contain placeholder [%code%] |
| `fast` | `any` |  |
| `from` | `string` | Sendername |
| `phone_number` | `string` |  |

#### Example: Create

```go
result, err := client.MfaCode(nil).Create(map[string]any{
    "phone_number": "example_phone_number",
}, nil)
if err != nil {
    panic(err)
}
fmt.Println(result)
```


### OptOut

Create an instance: `optOut := client.OptOut(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `List(match, ctrl)` | List entities matching the criteria. |
| `Remove(match, ctrl)` | Remove the matching entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `date` | `string` |  |
| `id` | `string` |  |
| `links` | `[]any` |  |
| `phoneNumber` | `int` |  |

#### Example: List

```go
optOuts, err := client.OptOut(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(optOuts) // the array of records
```


### OptOutSetting

Create an instance: `optOutSetting := client.OptOutSetting(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `Load(match, ctrl)` | Load a single entity by match criteria. |
| `Update(data, ctrl)` | Update an existing entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `brand` | `string` |  |

#### Example: Load

```go
optOutSetting, err := client.OptOutSetting(nil).Load(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(optOutSetting) // the loaded record
```


### Permission

Create an instance: `permission := client.Permission(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `Load(match, ctrl)` | Load a single entity by match criteria. |
| `Create(data, ctrl)` | Create a new entity with the given data. |

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

```go
permission, err := client.Permission(nil).Load(map[string]any{"id": "permission_id", "group_id": "group_id", "username": "username"}, nil)
if err != nil {
    panic(err)
}
fmt.Println(permission) // the loaded record
```

#### Example: Create

```go
result, err := client.Permission(nil).Create(map[string]any{
    "group_id": "example_group_id",
    "read": true,
    "send": true,
    "username": "example_username",
    "write": true,
}, nil)
if err != nil {
    panic(err)
}
fmt.Println(result)
```


### Ping

Create an instance: `ping := client.Ping(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `List(match, ctrl)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `authorized` | `bool` |  |
| `unavailable` | `[]any` |  |

#### Example: List

```go
pings, err := client.Ping(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(pings) // the array of records
```


### Profile

Create an instance: `profile := client.Profile(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `List(match, ctrl)` | List entities matching the criteria. |
| `Load(match, ctrl)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `email` | `string` |  |
| `name` | `string` |  |
| `payment_type` | `string` |  |
| `phone_number` | `int` |  |
| `points` | `float64` |  |
| `user_type` | `string` |  |
| `username` | `string` |  |

#### Example: Load

```go
profile, err := client.Profile(nil).Load(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(profile) // the loaded record
```

#### Example: List

```go
profiles, err := client.Profile(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(profiles) // the array of records
```


### Rcs

Create an instance: `rcs := client.Rcs(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `List(match, ctrl)` | List entities matching the criteria. |

#### Example: List

```go
rcss, err := client.Rcs(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(rcss) // the array of records
```


### Sendername

Create an instance: `sendername := client.Sendername(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `List(match, ctrl)` | List entities matching the criteria. |
| `Load(match, ctrl)` | Load a single entity by match criteria. |
| `Create(data, ctrl)` | Create a new entity with the given data. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `created_at` | `string` |  |
| `id` | `string` |  |
| `is_default` | `bool` |  |
| `sender` | `string` | Sendername |
| `status` | `string` |  |

#### Example: Load

```go
sendername, err := client.Sendername(nil).Load(map[string]any{"id": "sendername_id"}, nil)
if err != nil {
    panic(err)
}
fmt.Println(sendername) // the loaded record
```

#### Example: List

```go
sendernames, err := client.Sendername(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(sendernames) // the array of records
```

#### Example: Create

```go
result, err := client.Sendername(nil).Create(map[string]any{
}, nil)
if err != nil {
    panic(err)
}
fmt.Println(result)
```


### SendernameStatement

Create an instance: `sendernameStatement := client.SendernameStatement(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `List(match, ctrl)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `content` | `string` |  |
| `statements` | `[]any` |  |
| `title` | `string` |  |

#### Example: List

```go
sendernameStatements, err := client.SendernameStatement(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(sendernameStatements) // the array of records
```


### SentRcsMessage

Create an instance: `sentRcsMessage := client.SentRcsMessage(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `Create(data, ctrl)` | Create a new entity with the given data. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `content` | `map[string]any` | RCS message content in RCS JSON format. |
| `phone_number` | `string` | Recipient phone number (e.g. |
| `sender` | `any` |  |
| `text` | `string` | Plain text message content. |

#### Example: Create

```go
result, err := client.SentRcsMessage(nil).Create(map[string]any{
    "phone_number": "example_phone_number",
    "sender": "example_sender",
}, nil)
if err != nil {
    panic(err)
}
fmt.Println(result)
```


### ShipmentCountryVolume

Create an instance: `shipmentCountryVolume := client.ShipmentCountryVolume(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `List(match, ctrl)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `country_code` | `string` |  |
| `country_limit` | `int` |  |
| `country_name` | `string` |  |
| `usage` | `int` |  |

#### Example: List

```go
shipmentCountryVolumes, err := client.ShipmentCountryVolume(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(shipmentCountryVolumes) // the array of records
```


### ShortUrl

Create an instance: `shortUrl := client.ShortUrl(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `List(match, ctrl)` | List entities matching the criteria. |
| `Load(match, ctrl)` | Load a single entity by match criteria. |
| `Create(data, ctrl)` | Create a new entity with the given data. |
| `Update(data, ctrl)` | Update an existing entity. |
| `Remove(match, ctrl)` | Remove the matching entity. |

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

```go
shortUrl, err := client.ShortUrl(nil).Load(map[string]any{"id": "short_url_id"}, nil)
if err != nil {
    panic(err)
}
fmt.Println(shortUrl) // the loaded record
```

#### Example: List

```go
shortUrls, err := client.ShortUrl(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(shortUrls) // the array of records
```

#### Example: Create

```go
result, err := client.ShortUrl(nil).Create(map[string]any{
}, nil)
if err != nil {
    panic(err)
}
fmt.Println(result)
```


### Smsdo

Create an instance: `smsdo := client.Smsdo(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `Create(data, ctrl)` | Create a new entity with the given data. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `allow_duplicates` | `int` | When parameter allow_duplicates is set to "1" allows to send message to duplicated numbers in one request (useful i.e. |
| `check_idx` | `any` | When parameter check_idx is set to „1” prevents from sending more than one message with the same idx in last 24h. |
| `date` | `any` | Date in UNIX timestamp (&date=1287734110) or in ISO 8601 (&date=2012-05-10T08:40:27+00:00) when message will be sent (&date=1287734110). |
| `date_validate` | `int` | When parameter date_validate is set to "1" checks if date if given in proper format. |
| `details` | `any` | When details parameter is set to "1" more details in response will be displayed (message length and sms count). |
| `encoding` | `string` | This parameter describes the encoding of the message text. |
| `expiration_date` | `any` | Message expiration date (in UNIX timestamp or in ISO 8601) is a date after which message won't be delivered if it wasn't delivered yet. |
| `fallback` | `[]any` | Enable fallback in case sms sending fails |
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
| `test` | `any` | When parameter test is set to "1" message won't be sent but response will be displayed, there is no charge for such test messages. |
| `time_restriction` | `string` | Sets the behavior when you try to ship in hours / dates that do not match the settings in your account. |
| `to` | `string` | Recipients' mobile phone numbers (i.e. |

#### Example: Create

```go
result, err := client.Smsdo(nil).Create(map[string]any{
}, nil)
if err != nil {
    panic(err)
}
fmt.Println(result)
```


### Smssendername

Create an instance: `smssendername := client.Smssendername(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `Create(data, ctrl)` | Create a new entity with the given data. |
| `Remove(match, ctrl)` | Remove the matching entity. |

#### Example: Create

```go
result, err := client.Smssendername(nil).Create(map[string]any{
    "sendername_id": "example_sendername_id",
}, nil)
if err != nil {
    panic(err)
}
fmt.Println(result)
```


### Smstemplate

Create an instance: `smstemplate := client.Smstemplate(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `Remove(match, ctrl)` | Remove the matching entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `id` | `string` |  |


### Subuser

Create an instance: `subuser := client.Subuser(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `List(match, ctrl)` | List entities matching the criteria. |
| `Load(match, ctrl)` | Load a single entity by match criteria. |
| `Create(data, ctrl)` | Create a new entity with the given data. |
| `Update(data, ctrl)` | Update an existing entity. |
| `Remove(match, ctrl)` | Remove the matching entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `active` | `bool` |  |
| `credentials` | `map[string]any` |  |
| `description` | `string` |  |
| `id` | `string` | Object ID |
| `points` | `map[string]any` |  |
| `username` | `string` |  |

#### Example: Load

```go
subuser, err := client.Subuser(nil).Load(map[string]any{"id": "subuser_id"}, nil)
if err != nil {
    panic(err)
}
fmt.Println(subuser) // the loaded record
```

#### Example: List

```go
subusers, err := client.Subuser(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(subusers) // the array of records
```

#### Example: Create

```go
result, err := client.Subuser(nil).Create(map[string]any{
    "credentials": map[string]any{},
}, nil)
if err != nil {
    panic(err)
}
fmt.Println(result)
```


### Template

Create an instance: `template := client.Template(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `List(match, ctrl)` | List entities matching the criteria. |
| `Load(match, ctrl)` | Load a single entity by match criteria. |
| `Create(data, ctrl)` | Create a new entity with the given data. |
| `Update(data, ctrl)` | Update an existing entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `id` | `string` |  |
| `name` | `string` |  |
| `normalize` | `bool` |  |
| `template` | `string` |  |

#### Example: Load

```go
template, err := client.Template(nil).Load(map[string]any{"id": "template_id"}, nil)
if err != nil {
    panic(err)
}
fmt.Println(template) // the loaded record
```

#### Example: List

```go
templates, err := client.Template(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(templates) // the array of records
```

#### Example: Create

```go
result, err := client.Template(nil).Create(map[string]any{
}, nil)
if err != nil {
    panic(err)
}
fmt.Println(result)
```


### UserRcsSenderCollection

Create an instance: `userRcsSenderCollection := client.UserRcsSenderCollection(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `List(match, ctrl)` | List entities matching the criteria. |

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

```go
userRcsSenderCollections, err := client.UserRcsSenderCollection(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(userRcsSenderCollections) // the array of records
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

Features are the extension mechanism. A feature implements the
`Feature` interface and provides hooks — functions keyed by pipeline
stage names.

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

### Data as maps

The Go SDK uses `map[string]any` throughout rather than typed structs.
This mirrors the dynamic nature of the API and keeps the SDK
flexible — no code generation is needed when the API schema changes.

Use `core.ToMapAny()` to safely cast results and nested data.

### Package structure

```
github.com/voxgig-sdk/smsapi-sdk/go/
├── smsapi.go        # Root package — type aliases and constructors
├── core/               # SDK core — client, types, pipeline
├── entity/             # Entity implementations
├── feature/            # Built-in features (Base, Test, Log)
├── utility/            # Utility functions and struct library
└── test/               # Test suites
```

The root package (`github.com/voxgig-sdk/smsapi-sdk/go`) re-exports everything needed
for normal use. Import sub-packages only when you need specific types
like `core.ToMapAny`.

### Entity state

Entity instances are stateful. After a successful `Load`, the entity
stores the returned data and match criteria internally.

```go
permission := client.Permission(nil)
permission.Load(map[string]any{"group_id": "example", "id": "example_id", "username": "example"}, nil)

// permission.Data() now returns the permission data from the last load
// permission.Match() returns the last match criteria
```

Call `Make()` to create a fresh instance with the same configuration
but no stored state.

### Direct vs entity access

The entity interface handles URL construction, parameter placement,
and response parsing automatically. Use it for standard CRUD operations.

`Direct()` gives full control over the HTTP request. Use it for
non-standard endpoints, bulk operations, or any path not modelled as
an entity. `Prepare()` builds the request without sending it — useful
for debugging or custom transport.


## Full Reference

See [REFERENCE.md](REFERENCE.md) for complete API reference
documentation including all method signatures, entity field schemas,
and detailed usage examples.
