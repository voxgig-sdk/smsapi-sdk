# Smsapi OCaml SDK

An MCP server and CLI for the SMSAPI REST API, plus clients in 20 languages and a pandas data layer, generated from SMSAPI's public OpenAPI spec so AI agents can reach SMSAPI the way the official SDKs already let developers.

The OCaml SDK for the Smsapi API — an entity-oriented client
following idiomatic OCaml conventions (a dependency-free library that compiles
with the stock `ocamlc`).

The SDK exposes the API as capitalised, semantic **Entities** — for example `Sdk_client.available client Noval` — each
carrying a small, uniform set of operations (`list`, `load`, `create`, `update`, `remove`) instead of raw URL
paths and query strings. You work with named resources and verbs, which
keeps the cognitive load low.

> Other languages, the CLI, and MCP server live alongside this one — see
> the [top-level README](../README.md).


## Install
This package is not yet published to the opam registry. Install it from the
GitHub release tag (`ocaml/vX.Y.Z`, see [Releases](https://github.com/voxgig-sdk/smsapi-sdk/releases))
or from a source checkout. The SDK is dependency-free and compiles with the
stock `ocamlc` — no opam packages, no dune:

```bash
cd ocaml && make build
```


## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record.

### 1. Create a client

```ocaml
open Voxgig_struct
open Sdk_helpers

let client = Sdk_client.make (jo [("apikey", Str (Sys.getenv "SMSAPI_APIKEY"))])
```

### 2. List available records

`e_list` resolves to one ENTITY per record and raises on error. Read a
record with `e_data_get`.

```ocaml
(try
   let availables = (Sdk_client.available client Noval).e_list (empty_map ()) Noval in
   List.iter (fun e -> print_endline (stringify (e.e_data_get ()))) availables
 with Sdk_error.E err -> Printf.eprintf "list failed: %s\n" (Sdk_error.message err))
```

### 3. Load a permission

Permission is nested under group, so provide the `group_id`.
`e_load` resolves to the ENTITY and raises on error; `e_data_get` gives the
record.

```ocaml
(try
   let permission = (Sdk_client.permission client Noval).e_load (jo [("group_id", (Str "example_group_id")); ("username", (Str "example_username")); ("id", (Str "example_id"))]) Noval in
   print_endline (stringify (permission.e_data_get ()))
 with Sdk_error.E err -> Printf.eprintf "load failed: %s\n" (Sdk_error.message err))
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

For endpoints not covered by entity methods:

```ocaml
let result = Sdk_client.direct client (jo [
    ("path", Str "/api/resource/{id}");
    ("method", Str "GET");
    ("params", jo [("id", Str "example")]);
]) in
(match getp result "ok" with
 | Bool true ->
   print_endline (stringify (getp result "status"));  (* 200 *)
   print_endline (stringify (getp result "data"))      (* response body *)
 | _ ->
   (* A non-2xx response carries status + data (the error body); a transport
      failure carries err instead. Read whichever is present. *)
   print_endline (stringify (getp result "status"));
   print_endline (stringify (getp result "err")))
```

### Prepare a request without sending it

```ocaml
(* prepare returns the fetch definition and raises on error. *)
let fetchdef = Sdk_client.prepare client (jo [
    ("path", Str "/api/resource/{id}");
    ("method", Str "DELETE");
    ("params", jo [("id", Str "example")]);
]) in
print_endline (stringify (getp fetchdef "url"));
print_endline (stringify (getp fetchdef "method"));
print_endline (stringify (getp fetchdef "headers"))
```

### Use test mode

Create a mock client for unit testing — no server required:

```ocaml
let () =
  let client = Sdk_client.test () in
  (* Entity ops resolve to the ENTITY and raise on error. *)
  let permission = (Sdk_client.permission client Noval).e_load (jo [("id", Str "test01")]) Noval in
  print_endline (stringify (permission.e_data_get ()))  (* the mock response record *)
```

### Use a custom fetch function

Replace the HTTP transport with your own function:

```ocaml
let mock_fetch = Func (fun _ _args _ _ ->
    jo [("status", Num 200.); ("statusText", Str "OK"); ("headers", empty_map ());
        ("json", json_thunk (jo [("id", Str "mock01")]))]) in
let client = Sdk_client.make (jo [
    ("base", Str "http://localhost:8080");
    ("system", jo [("fetch", mock_fetch)]);
]) in
ignore client
```

### Run live tests

Create a `.env.local` file at the project root:

```
SMSAPI_TEST_LIVE=TRUE
SMSAPI_APIKEY=<your-key>
```

Then run:

```bash
cd ocaml && make test
```


## Reference

### Sdk_client

```ocaml
open Voxgig_struct
open Sdk_helpers

let client = Sdk_client.make options
```

Creates a new SDK client from a `value` options map. Use `Sdk_client.make0 ()`
for defaults.

| Option | Type | Description |
| --- | --- | --- |
| `apikey` | `string` | API key for authentication. |
| `base` | `string` | Base URL of the API server. |
| `prefix` | `string` | URL path prefix prepended to all requests. |
| `suffix` | `string` | URL path suffix appended to all requests. |
| `feature` | `map` | Feature activation flags. |
| `extend` | `list` | Additional feature instances to load. |
| `system` | `map` | System overrides (e.g. custom `fetch` function). |

### Sdk_client.test

```ocaml
let client = Sdk_client.test_with testopts sdkopts
```

Creates a test-mode client with mock transport. Both arguments may be `Noval`
(`Sdk_client.test ()` uses defaults).

### Sdk_client functions

| Function | Signature | Description |
| --- | --- | --- |
| `make` | `value -> sdk_client` | Construct a client from options. |
| `make0` | `unit -> sdk_client` | Construct a client with defaults. |
| `prepare` | `sdk_client -> value -> value` | Build an HTTP request definition without sending. Raises on error. |
| `direct` | `sdk_client -> value -> value` | Build and send an HTTP request. Returns a result map (branch on `ok`). |
| `available` | `sdk_client -> value -> entity_obj` | An Available entity accessor. |
| `blacklist` | `sdk_client -> value -> entity_obj` | A Blacklist entity accessor. |
| `callback` | `sdk_client -> value -> entity_obj` | A Callback entity accessor. |
| `contact` | `sdk_client -> value -> entity_obj` | A Contact entity accessor. |
| `contacts_field` | `sdk_client -> value -> entity_obj` | A ContactsField entity accessor. |
| `contacts_field_option` | `sdk_client -> value -> entity_obj` | A ContactsFieldOption entity accessor. |
| `contactsgroup` | `sdk_client -> value -> entity_obj` | A Contactsgroup entity accessor. |
| `contactstrash` | `sdk_client -> value -> entity_obj` | A Contactstrash entity accessor. |
| `field_available` | `sdk_client -> value -> entity_obj` | A FieldAvailable entity accessor. |
| `group` | `sdk_client -> value -> entity_obj` | A Group entity accessor. |
| `mfa_code` | `sdk_client -> value -> entity_obj` | A MfaCode entity accessor. |
| `opt_out` | `sdk_client -> value -> entity_obj` | An OptOut entity accessor. |
| `opt_out_setting` | `sdk_client -> value -> entity_obj` | An OptOutSetting entity accessor. |
| `permission` | `sdk_client -> value -> entity_obj` | A Permission entity accessor. |
| `ping` | `sdk_client -> value -> entity_obj` | A Ping entity accessor. |
| `profile` | `sdk_client -> value -> entity_obj` | A Profile entity accessor. |
| `rcs` | `sdk_client -> value -> entity_obj` | A Rcs entity accessor. |
| `sendername` | `sdk_client -> value -> entity_obj` | A Sendername entity accessor. |
| `sendername_statement` | `sdk_client -> value -> entity_obj` | A SendernameStatement entity accessor. |
| `sent_rcs_message` | `sdk_client -> value -> entity_obj` | A SentRcsMessage entity accessor. |
| `shipment_country_volume` | `sdk_client -> value -> entity_obj` | A ShipmentCountryVolume entity accessor. |
| `short_url` | `sdk_client -> value -> entity_obj` | A ShortUrl entity accessor. |
| `smsdo` | `sdk_client -> value -> entity_obj` | A Smsdo entity accessor. |
| `smssendername` | `sdk_client -> value -> entity_obj` | A Smssendername entity accessor. |
| `smstemplate` | `sdk_client -> value -> entity_obj` | A Smstemplate entity accessor. |
| `subuser` | `sdk_client -> value -> entity_obj` | A Subuser entity accessor. |
| `template` | `sdk_client -> value -> entity_obj` | A Template entity accessor. |
| `user_rcs_sender_collection` | `sdk_client -> value -> entity_obj` | An UserRcsSenderCollection entity accessor. |

### Entity interface

All entities are `entity_obj` records sharing the same fields.

| Field | Signature | Description |
| --- | --- | --- |
| `e_load` | `value -> value -> entity_obj` | Load a single entity by match criteria. Resolves to the entity. Raises on error. |
| `e_list` | `value -> value -> entity_obj list` | List entities matching the criteria. Resolves to one entity per record. Raises on error. |
| `e_create` | `value -> value -> entity_obj` | Create a new entity. Resolves to the entity. Raises on error. |
| `e_update` | `value -> value -> entity_obj` | Update an existing entity. Resolves to the entity. Raises on error. |
| `e_remove` | `value -> value -> entity_obj` | Remove an entity. Resolves to the entity, marked deleted. Raises on error. |
| `e_data_get` | `unit -> value` | Get entity data. |
| `e_data_set` | `value -> unit` | Set entity data. |
| `e_match_get` | `unit -> value` | Get entity match criteria. |
| `e_match_set` | `value -> unit` | Set entity match criteria. |
| `e_make` | `unit -> entity_obj` | Create a new instance with the same options. |
| `e_name` | `string` | The entity name. |

### Result shape

Entity operations resolve to the ENTITY, not the raw record — `e_list` to
one entity per record — and raise `Sdk_error.E` on error. The record is
reached through `e_data_get`, which returns the entity's data container.
`e_remove` resolves to the entity marked deleted (`e_deleted`); it keeps the
data it held. Wrap calls in `try`/`with` to handle failures.

The `direct` escape hatch never raises — it returns a result `value` map
you branch on via `getp result "ok"`:

| Key | Type | Description |
| --- | --- | --- |
| `ok` | `Bool` | `Bool true` if the HTTP status is 2xx. |
| `status` | `Num` | HTTP status code. |
| `headers` | `Map` | Response headers. |
| `data` | `value` | Parsed JSON response body. |

On error, `ok` is `Bool false` and `err` carries the error value.

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

Create an instance: `let available = Sdk_client.available client Noval`

#### Operations

| Method | Description |
| --- | --- |
| `e_list reqmatch ctrl` | List entities, optionally matching the given criteria. Resolves to one entity per record. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `name` | `string` |  |
| `normalize` | `bool` |  |
| `template` | `string` |  |

#### Example: List

```ocaml
(* One ENTITY per record. *)
let availables = (Sdk_client.available client Noval).e_list (empty_map ()) Noval
let available_datas = List.map (fun e -> e.e_data_get ()) availables
```


### Blacklist

Create an instance: `let blacklist = Sdk_client.blacklist client Noval`

#### Operations

| Method | Description |
| --- | --- |
| `e_create reqdata ctrl` | Create a new entity with the given data. Resolves to the entity. |
| `e_load reqmatch ctrl` | Load a single entity by match criteria. Resolves to the entity. |
| `e_remove reqmatch ctrl` | Remove the matching entity. Resolves to the entity, marked deleted. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `id` | `string` |  |

#### Example: Load

```ocaml
(* The op resolves to the ENTITY; the record is inside it. *)
let blacklist = (Sdk_client.blacklist client Noval).e_load (Noval) Noval
let blacklist_data = blacklist.e_data_get ()
```

#### Example: Create

```ocaml
let blacklist = (Sdk_client.blacklist client Noval).e_create (jo [
]) Noval
let blacklist_data = blacklist.e_data_get ()
```


### Callback

Create an instance: `let callback = Sdk_client.callback client Noval`

#### Operations

| Method | Description |
| --- | --- |
| `e_create reqdata ctrl` | Create a new entity with the given data. Resolves to the entity. |
| `e_list reqmatch ctrl` | List entities, optionally matching the given criteria. Resolves to one entity per record. |
| `e_load reqmatch ctrl` | Load a single entity by match criteria. Resolves to the entity. |
| `e_remove reqmatch ctrl` | Remove the matching entity. Resolves to the entity, marked deleted. |
| `e_update reqdata ctrl` | Update an existing entity. Resolves to the entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `active` | `bool` |  |
| `api_version` | `int` | Version of the callback output format. |
| `id` | `string` | Object ID |
| `invalid` | `bool` |  |
| `receiver` | `value map` |  |
| `receiver_type` | `string` |  |
| `type` | `string` |  |
| `url` | `string` | WHATWG URL compliant |

#### Example: Load

```ocaml
(* The op resolves to the ENTITY; the record is inside it. *)
let callback = (Sdk_client.callback client Noval).e_load (jo [("id", (Str "callback_id"))]) Noval
let callback_data = callback.e_data_get ()
```

#### Example: List

```ocaml
(* One ENTITY per record. *)
let callbacks = (Sdk_client.callback client Noval).e_list (empty_map ()) Noval
let callback_datas = List.map (fun e -> e.e_data_get ()) callbacks
```

#### Example: Create

```ocaml
let callback = (Sdk_client.callback client Noval).e_create (jo [
]) Noval
let callback_data = callback.e_data_get ()
```


### Contact

Create an instance: `let contact = Sdk_client.contact client Noval`

#### Operations

| Method | Description |
| --- | --- |
| `e_create reqdata ctrl` | Create a new entity with the given data. Resolves to the entity. |
| `e_list reqmatch ctrl` | List entities, optionally matching the given criteria. Resolves to one entity per record. |
| `e_load reqmatch ctrl` | Load a single entity by match criteria. Resolves to the entity. |
| `e_remove reqmatch ctrl` | Remove the matching entity. Resolves to the entity, marked deleted. |
| `e_update reqdata ctrl` | Update an existing entity. Resolves to the entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `birthday_date` | `string` |  |
| `city` | `string` |  |
| `collection` | `value list` |  |
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
| `groups` | `value list` |  |
| `id` | `string` | Object ID |
| `idx` | `string` | User provided resource id |
| `last_name` | `string` |  |
| `name` | `string` | Group name |
| `permissions` | `value list` |  |
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

```ocaml
(* The op resolves to the ENTITY; the record is inside it. *)
let contact = (Sdk_client.contact client Noval).e_load (jo [("id", (Str "contact_id"))]) Noval
let contact_data = contact.e_data_get ()
```

#### Example: List

```ocaml
(* One ENTITY per record. *)
let contacts = (Sdk_client.contact client Noval).e_list (empty_map ()) Noval
let contact_datas = List.map (fun e -> e.e_data_get ()) contacts
```

#### Example: Create

```ocaml
let contact = (Sdk_client.contact client Noval).e_create (jo [
    ("collection", (empty_list ()));  (* value list *)
    ("contact_expire_after", (Num 1.));  (* int *)
    ("contacts_count", (Num 1.));  (* int *)
    ("created_by", (Str "example_created_by"));  (* string *)
    ("date_created", (Str "example_date_created"));  (* string *)
    ("date_updated", (Str "example_date_updated"));  (* string *)
    ("gender", (Str "example_gender"));  (* string *)
    ("groups", (empty_list ()));  (* value list *)
    ("id", (Str "example_id"));  (* string *)
    ("name", (Str "example_name"));  (* string *)
    ("size", (Num 1.));  (* int *)
]) Noval
let contact_data = contact.e_data_get ()
```


### ContactsField

Create an instance: `let contacts_field = Sdk_client.contacts_field client Noval`

#### Operations

| Method | Description |
| --- | --- |
| `e_create reqdata ctrl` | Create a new entity with the given data. Resolves to the entity. |
| `e_list reqmatch ctrl` | List entities, optionally matching the given criteria. Resolves to one entity per record. |
| `e_remove reqmatch ctrl` | Remove the matching entity. Resolves to the entity, marked deleted. |
| `e_update reqdata ctrl` | Update an existing entity. Resolves to the entity. |

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
| `groups` | `value list` |  |
| `id` | `string` | Object ID |
| `idx` | `string` | User provided resource id |
| `last_name` | `string` |  |
| `name` | `string` | Group name |
| `permissions` | `value list` |  |
| `phone_number` | `string` |  |
| `read` | `bool` | Has read permission |
| `send` | `bool` | Has send permission |
| `source` | `string` |  |
| `type` | `string` |  |
| `username` | `string` |  |
| `value` | `string` |  |
| `write` | `bool` | Has write permission |

#### Example: List

```ocaml
(* One ENTITY per record. *)
let contacts_fields = (Sdk_client.contacts_field client Noval).e_list (empty_map ()) Noval
let contacts_field_datas = List.map (fun e -> e.e_data_get ()) contacts_fields
```

#### Example: Create

```ocaml
let contacts_field = (Sdk_client.contacts_field client Noval).e_create (jo [
    ("contact_expire_after", (Num 1.));  (* int *)
    ("created_by", (Str "example_created_by"));  (* string *)
    ("date_created", (Str "example_date_created"));  (* string *)
    ("date_updated", (Str "example_date_updated"));  (* string *)
    ("gender", (Str "example_gender"));  (* string *)
    ("groups", (empty_list ()));  (* value list *)
]) Noval
let contacts_field_data = contacts_field.e_data_get ()
```


### ContactsFieldOption

Create an instance: `let contacts_field_option = Sdk_client.contacts_field_option client Noval`

#### Operations

| Method | Description |
| --- | --- |
| `e_list reqmatch ctrl` | List entities, optionally matching the given criteria. Resolves to one entity per record. |

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
| `groups` | `value list` |  |
| `id` | `string` | Object ID |
| `idx` | `string` | User provided resource id |
| `last_name` | `string` |  |
| `name` | `string` | Group name |
| `permissions` | `value list` |  |
| `phone_number` | `string` |  |
| `read` | `bool` | Has read permission |
| `send` | `bool` | Has send permission |
| `source` | `string` |  |
| `type` | `string` |  |
| `username` | `string` |  |
| `value` | `string` |  |
| `write` | `bool` | Has write permission |

#### Example: List

```ocaml
(* One ENTITY per record. *)
let contacts_field_options = (Sdk_client.contacts_field_option client Noval).e_list (empty_map ()) Noval
let contacts_field_option_datas = List.map (fun e -> e.e_data_get ()) contacts_field_options
```


### Contactsgroup

Create an instance: `let contactsgroup = Sdk_client.contactsgroup client Noval`

#### Operations

| Method | Description |
| --- | --- |
| `e_create reqdata ctrl` | Create a new entity with the given data. Resolves to the entity. |
| `e_list reqmatch ctrl` | List entities, optionally matching the given criteria. Resolves to one entity per record. |
| `e_remove reqmatch ctrl` | Remove the matching entity. Resolves to the entity, marked deleted. |
| `e_update reqdata ctrl` | Update an existing entity. Resolves to the entity. |

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
| `groups` | `value list` |  |
| `id` | `string` | Object ID |
| `idx` | `string` | User provided resource id |
| `last_name` | `string` |  |
| `name` | `string` | Group name |
| `permissions` | `value list` |  |
| `phone_number` | `string` |  |
| `read` | `bool` | Has read permission |
| `send` | `bool` | Has send permission |
| `source` | `string` |  |
| `type` | `string` |  |
| `username` | `string` |  |
| `value` | `string` |  |
| `write` | `bool` | Has write permission |

#### Example: List

```ocaml
(* One ENTITY per record. *)
let contactsgroups = (Sdk_client.contactsgroup client Noval).e_list (empty_map ()) Noval
let contactsgroup_datas = List.map (fun e -> e.e_data_get ()) contactsgroups
```

#### Example: Create

```ocaml
let contactsgroup = (Sdk_client.contactsgroup client Noval).e_create (jo [
    ("contact_expire_after", (Num 1.));  (* int *)
    ("created_by", (Str "example_created_by"));  (* string *)
    ("date_created", (Str "example_date_created"));  (* string *)
    ("date_updated", (Str "example_date_updated"));  (* string *)
    ("gender", (Str "example_gender"));  (* string *)
    ("group_id", (Str "example_group_id"));  (* string *)
    ("groups", (empty_list ()));  (* value list *)
    ("id", (Str "example_id"));  (* string *)
    ("read", (Bool true));  (* bool *)
    ("send", (Bool true));  (* bool *)
    ("username", (Str "example_username"));  (* string *)
    ("write", (Bool true));  (* bool *)
]) Noval
let contactsgroup_data = contactsgroup.e_data_get ()
```


### Contactstrash

Create an instance: `let contactstrash = Sdk_client.contactstrash client Noval`

#### Operations

| Method | Description |
| --- | --- |
| `e_remove reqmatch ctrl` | Remove the matching entity. Resolves to the entity, marked deleted. |
| `e_update reqdata ctrl` | Update an existing entity. Resolves to the entity. |


### FieldAvailable

Create an instance: `let field_available = Sdk_client.field_available client Noval`

#### Operations

| Method | Description |
| --- | --- |
| `e_list reqmatch ctrl` | List entities, optionally matching the given criteria. Resolves to one entity per record. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `built_in` | `bool` |  |
| `id` | `string` | Object ID |
| `name` | `string` |  |
| `options` | `value list` |  |
| `type` | `string` |  |

#### Example: List

```ocaml
(* One ENTITY per record. *)
let field_availables = (Sdk_client.field_available client Noval).e_list (empty_map ()) Noval
let field_available_datas = List.map (fun e -> e.e_data_get ()) field_availables
```


### Group

Create an instance: `let group = Sdk_client.group client Noval`

#### Operations

| Method | Description |
| --- | --- |
| `e_load reqmatch ctrl` | Load a single entity by match criteria. Resolves to the entity. |
| `e_update reqdata ctrl` | Update an existing entity. Resolves to the entity. |

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
| `permissions` | `value list` |  |

#### Example: Load

```ocaml
(* The op resolves to the ENTITY; the record is inside it. *)
let group = (Sdk_client.group client Noval).e_load (jo [("id", (Str "group_id"))]) Noval
let group_data = group.e_data_get ()
```


### MfaCode

Create an instance: `let mfa_code = Sdk_client.mfa_code client Noval`

#### Operations

| Method | Description |
| --- | --- |
| `e_create reqdata ctrl` | Create a new entity with the given data. Resolves to the entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `content` | `string` | Custom content that must contain placeholder [%code%] |
| `fast` | `value` |  |
| `from` | `string` | Sendername |
| `phone_number` | `string` |  |

#### Example: Create

```ocaml
let mfa_code = (Sdk_client.mfa_code client Noval).e_create (jo [
    ("phone_number", (Str "example_phone_number"));  (* string *)
]) Noval
let mfa_code_data = mfa_code.e_data_get ()
```


### OptOut

Create an instance: `let opt_out = Sdk_client.opt_out client Noval`

#### Operations

| Method | Description |
| --- | --- |
| `e_list reqmatch ctrl` | List entities, optionally matching the given criteria. Resolves to one entity per record. |
| `e_remove reqmatch ctrl` | Remove the matching entity. Resolves to the entity, marked deleted. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `date` | `string` |  |
| `id` | `string` |  |
| `links` | `value list` |  |
| `phoneNumber` | `int` |  |

#### Example: List

```ocaml
(* One ENTITY per record. *)
let opt_outs = (Sdk_client.opt_out client Noval).e_list (empty_map ()) Noval
let opt_out_datas = List.map (fun e -> e.e_data_get ()) opt_outs
```


### OptOutSetting

Create an instance: `let opt_out_setting = Sdk_client.opt_out_setting client Noval`

#### Operations

| Method | Description |
| --- | --- |
| `e_load reqmatch ctrl` | Load a single entity by match criteria. Resolves to the entity. |
| `e_update reqdata ctrl` | Update an existing entity. Resolves to the entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `brand` | `string` |  |

#### Example: Load

```ocaml
(* The op resolves to the ENTITY; the record is inside it. *)
let opt_out_setting = (Sdk_client.opt_out_setting client Noval).e_load (Noval) Noval
let opt_out_setting_data = opt_out_setting.e_data_get ()
```


### Permission

Create an instance: `let permission = Sdk_client.permission client Noval`

#### Operations

| Method | Description |
| --- | --- |
| `e_create reqdata ctrl` | Create a new entity with the given data. Resolves to the entity. |
| `e_load reqmatch ctrl` | Load a single entity by match criteria. Resolves to the entity. |

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

```ocaml
(* The op resolves to the ENTITY; the record is inside it. *)
let permission = (Sdk_client.permission client Noval).e_load (jo [("id", (Str "permission_id")); ("group_id", (Str "group_id")); ("username", (Str "username"))]) Noval
let permission_data = permission.e_data_get ()
```

#### Example: Create

```ocaml
let permission = (Sdk_client.permission client Noval).e_create (jo [
    ("group_id", (Str "example_group_id"));  (* string *)
    ("read", (Bool true));  (* bool *)
    ("send", (Bool true));  (* bool *)
    ("username", (Str "example_username"));  (* string *)
    ("write", (Bool true));  (* bool *)
]) Noval
let permission_data = permission.e_data_get ()
```


### Ping

Create an instance: `let ping = Sdk_client.ping client Noval`

#### Operations

| Method | Description |
| --- | --- |
| `e_list reqmatch ctrl` | List entities, optionally matching the given criteria. Resolves to one entity per record. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `authorized` | `bool` |  |
| `unavailable` | `value list` |  |

#### Example: List

```ocaml
(* One ENTITY per record. *)
let pings = (Sdk_client.ping client Noval).e_list (empty_map ()) Noval
let ping_datas = List.map (fun e -> e.e_data_get ()) pings
```


### Profile

Create an instance: `let profile = Sdk_client.profile client Noval`

#### Operations

| Method | Description |
| --- | --- |
| `e_list reqmatch ctrl` | List entities, optionally matching the given criteria. Resolves to one entity per record. |
| `e_load reqmatch ctrl` | Load a single entity by match criteria. Resolves to the entity. |

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

```ocaml
(* The op resolves to the ENTITY; the record is inside it. *)
let profile = (Sdk_client.profile client Noval).e_load (Noval) Noval
let profile_data = profile.e_data_get ()
```

#### Example: List

```ocaml
(* One ENTITY per record. *)
let profiles = (Sdk_client.profile client Noval).e_list (empty_map ()) Noval
let profile_datas = List.map (fun e -> e.e_data_get ()) profiles
```


### Rcs

Create an instance: `let rcs = Sdk_client.rcs client Noval`

#### Operations

| Method | Description |
| --- | --- |
| `e_list reqmatch ctrl` | List entities, optionally matching the given criteria. Resolves to one entity per record. |

#### Example: List

```ocaml
(* One ENTITY per record. *)
let rcss = (Sdk_client.rcs client Noval).e_list (empty_map ()) Noval
let rcs_datas = List.map (fun e -> e.e_data_get ()) rcss
```


### Sendername

Create an instance: `let sendername = Sdk_client.sendername client Noval`

#### Operations

| Method | Description |
| --- | --- |
| `e_create reqdata ctrl` | Create a new entity with the given data. Resolves to the entity. |
| `e_list reqmatch ctrl` | List entities, optionally matching the given criteria. Resolves to one entity per record. |
| `e_load reqmatch ctrl` | Load a single entity by match criteria. Resolves to the entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `created_at` | `string` |  |
| `id` | `string` |  |
| `is_default` | `bool` |  |
| `sender` | `string` | Sendername |
| `status` | `string` |  |

#### Example: Load

```ocaml
(* The op resolves to the ENTITY; the record is inside it. *)
let sendername = (Sdk_client.sendername client Noval).e_load (jo [("id", (Str "sendername_id"))]) Noval
let sendername_data = sendername.e_data_get ()
```

#### Example: List

```ocaml
(* One ENTITY per record. *)
let sendernames = (Sdk_client.sendername client Noval).e_list (empty_map ()) Noval
let sendername_datas = List.map (fun e -> e.e_data_get ()) sendernames
```

#### Example: Create

```ocaml
let sendername = (Sdk_client.sendername client Noval).e_create (jo [
]) Noval
let sendername_data = sendername.e_data_get ()
```


### SendernameStatement

Create an instance: `let sendername_statement = Sdk_client.sendername_statement client Noval`

#### Operations

| Method | Description |
| --- | --- |
| `e_list reqmatch ctrl` | List entities, optionally matching the given criteria. Resolves to one entity per record. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `content` | `string` |  |
| `statements` | `value list` |  |
| `title` | `string` |  |

#### Example: List

```ocaml
(* One ENTITY per record. *)
let sendername_statements = (Sdk_client.sendername_statement client Noval).e_list (empty_map ()) Noval
let sendername_statement_datas = List.map (fun e -> e.e_data_get ()) sendername_statements
```


### SentRcsMessage

Create an instance: `let sent_rcs_message = Sdk_client.sent_rcs_message client Noval`

#### Operations

| Method | Description |
| --- | --- |
| `e_create reqdata ctrl` | Create a new entity with the given data. Resolves to the entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `content` | `value map` | RCS message content in RCS JSON format. |
| `phone_number` | `string` | Recipient phone number (e.g. |
| `sender` | `value` |  |
| `text` | `string` | Plain text message content. |

#### Example: Create

```ocaml
let sent_rcs_message = (Sdk_client.sent_rcs_message client Noval).e_create (jo [
    ("phone_number", (Str "example_phone_number"));  (* string *)
    ("sender", (Str "example_sender"));  (* value *)
]) Noval
let sent_rcs_message_data = sent_rcs_message.e_data_get ()
```


### ShipmentCountryVolume

Create an instance: `let shipment_country_volume = Sdk_client.shipment_country_volume client Noval`

#### Operations

| Method | Description |
| --- | --- |
| `e_list reqmatch ctrl` | List entities, optionally matching the given criteria. Resolves to one entity per record. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `country_code` | `string` |  |
| `country_limit` | `int` |  |
| `country_name` | `string` |  |
| `usage` | `int` |  |

#### Example: List

```ocaml
(* One ENTITY per record. *)
let shipment_country_volumes = (Sdk_client.shipment_country_volume client Noval).e_list (empty_map ()) Noval
let shipment_country_volume_datas = List.map (fun e -> e.e_data_get ()) shipment_country_volumes
```


### ShortUrl

Create an instance: `let short_url = Sdk_client.short_url client Noval`

#### Operations

| Method | Description |
| --- | --- |
| `e_create reqdata ctrl` | Create a new entity with the given data. Resolves to the entity. |
| `e_list reqmatch ctrl` | List entities, optionally matching the given criteria. Resolves to one entity per record. |
| `e_load reqmatch ctrl` | Load a single entity by match criteria. Resolves to the entity. |
| `e_remove reqmatch ctrl` | Remove the matching entity. Resolves to the entity, marked deleted. |
| `e_update reqdata ctrl` | Update an existing entity. Resolves to the entity. |

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

```ocaml
(* The op resolves to the ENTITY; the record is inside it. *)
let short_url = (Sdk_client.short_url client Noval).e_load (jo [("id", (Str "short_url_id"))]) Noval
let short_url_data = short_url.e_data_get ()
```

#### Example: List

```ocaml
(* One ENTITY per record. *)
let short_urls = (Sdk_client.short_url client Noval).e_list (empty_map ()) Noval
let short_url_datas = List.map (fun e -> e.e_data_get ()) short_urls
```

#### Example: Create

```ocaml
let short_url = (Sdk_client.short_url client Noval).e_create (jo [
]) Noval
let short_url_data = short_url.e_data_get ()
```


### Smsdo

Create an instance: `let smsdo = Sdk_client.smsdo client Noval`

#### Operations

| Method | Description |
| --- | --- |
| `e_create reqdata ctrl` | Create a new entity with the given data. Resolves to the entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `allow_duplicates` | `int` | When parameter allow_duplicates is set to "1" allows to send message to duplicated numbers in one request (useful i.e. |
| `check_idx` | `value` | When parameter check_idx is set to „1” prevents from sending more than one message with the same idx in last 24h. |
| `date` | `value` | Date in UNIX timestamp (&date=1287734110) or in ISO 8601 (&date=2012-05-10T08:40:27+00:00) when message will be sent (&date=1287734110). |
| `date_validate` | `int` | When parameter date_validate is set to "1" checks if date if given in proper format. |
| `details` | `value` | When details parameter is set to "1" more details in response will be displayed (message length and sms count). |
| `encoding` | `string` | This parameter describes the encoding of the message text. |
| `expiration_date` | `value` | Message expiration date (in UNIX timestamp or in ISO 8601) is a date after which message won't be delivered if it wasn't delivered yet. |
| `fallback` | `value list` | Enable fallback in case sms sending fails |
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
| `test` | `value` | When parameter test is set to "1" message won't be sent but response will be displayed, there is no charge for such test messages. |
| `time_restriction` | `string` | Sets the behavior when you try to ship in hours / dates that do not match the settings in your account. |
| `to` | `string` | Recipients' mobile phone numbers (i.e. |

#### Example: Create

```ocaml
let smsdo = (Sdk_client.smsdo client Noval).e_create (jo [
]) Noval
let smsdo_data = smsdo.e_data_get ()
```


### Smssendername

Create an instance: `let smssendername = Sdk_client.smssendername client Noval`

#### Operations

| Method | Description |
| --- | --- |
| `e_create reqdata ctrl` | Create a new entity with the given data. Resolves to the entity. |
| `e_remove reqmatch ctrl` | Remove the matching entity. Resolves to the entity, marked deleted. |

#### Example: Create

```ocaml
let smssendername = (Sdk_client.smssendername client Noval).e_create (jo [
    ("sendername_id", (Str "example_sendername_id"));  (* string *)
]) Noval
let smssendername_data = smssendername.e_data_get ()
```


### Smstemplate

Create an instance: `let smstemplate = Sdk_client.smstemplate client Noval`

#### Operations

| Method | Description |
| --- | --- |
| `e_remove reqmatch ctrl` | Remove the matching entity. Resolves to the entity, marked deleted. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `id` | `string` |  |


### Subuser

Create an instance: `let subuser = Sdk_client.subuser client Noval`

#### Operations

| Method | Description |
| --- | --- |
| `e_create reqdata ctrl` | Create a new entity with the given data. Resolves to the entity. |
| `e_list reqmatch ctrl` | List entities, optionally matching the given criteria. Resolves to one entity per record. |
| `e_load reqmatch ctrl` | Load a single entity by match criteria. Resolves to the entity. |
| `e_remove reqmatch ctrl` | Remove the matching entity. Resolves to the entity, marked deleted. |
| `e_update reqdata ctrl` | Update an existing entity. Resolves to the entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `active` | `bool` |  |
| `credentials` | `value map` |  |
| `description` | `string` |  |
| `id` | `string` | Object ID |
| `points` | `value map` |  |
| `username` | `string` |  |

#### Example: Load

```ocaml
(* The op resolves to the ENTITY; the record is inside it. *)
let subuser = (Sdk_client.subuser client Noval).e_load (jo [("id", (Str "subuser_id"))]) Noval
let subuser_data = subuser.e_data_get ()
```

#### Example: List

```ocaml
(* One ENTITY per record. *)
let subusers = (Sdk_client.subuser client Noval).e_list (empty_map ()) Noval
let subuser_datas = List.map (fun e -> e.e_data_get ()) subusers
```

#### Example: Create

```ocaml
let subuser = (Sdk_client.subuser client Noval).e_create (jo [
    ("credentials", (empty_map ()));  (* value map *)
]) Noval
let subuser_data = subuser.e_data_get ()
```


### Template

Create an instance: `let template = Sdk_client.template client Noval`

#### Operations

| Method | Description |
| --- | --- |
| `e_create reqdata ctrl` | Create a new entity with the given data. Resolves to the entity. |
| `e_list reqmatch ctrl` | List entities, optionally matching the given criteria. Resolves to one entity per record. |
| `e_load reqmatch ctrl` | Load a single entity by match criteria. Resolves to the entity. |
| `e_update reqdata ctrl` | Update an existing entity. Resolves to the entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `id` | `string` |  |
| `name` | `string` |  |
| `normalize` | `bool` |  |
| `template` | `string` |  |

#### Example: Load

```ocaml
(* The op resolves to the ENTITY; the record is inside it. *)
let template = (Sdk_client.template client Noval).e_load (jo [("id", (Str "template_id"))]) Noval
let template_data = template.e_data_get ()
```

#### Example: List

```ocaml
(* One ENTITY per record. *)
let templates = (Sdk_client.template client Noval).e_list (empty_map ()) Noval
let template_datas = List.map (fun e -> e.e_data_get ()) templates
```

#### Example: Create

```ocaml
let template = (Sdk_client.template client Noval).e_create (jo [
]) Noval
let template_data = template.e_data_get ()
```


### UserRcsSenderCollection

Create an instance: `let user_rcs_sender_collection = Sdk_client.user_rcs_sender_collection client Noval`

#### Operations

| Method | Description |
| --- | --- |
| `e_list reqmatch ctrl` | List entities, optionally matching the given criteria. Resolves to one entity per record. |

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

```ocaml
(* One ENTITY per record. *)
let user_rcs_sender_collections = (Sdk_client.user_rcs_sender_collection client Noval).e_list (empty_map ()) Noval
let user_rcs_sender_collection_datas = List.map (fun e -> e.e_data_get ()) user_rcs_sender_collections
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

### Data as `value`

The OCaml SDK uses a single dynamic `value` type throughout rather than a
typed record per entity. `value` is the vendored voxgig struct port (a
JSON-shaped variant: `Str`, `Num`, `Bool`, `List`, `Map`, `Null`,
`Noval`). This mirrors the dynamic nature of the API and keeps the SDK
flexible — no code generation is needed when the API schema changes.

Build request maps with the `jo` / `ja` helpers and read fields back with
`getp`; use `to_map` to safely coerce a value to a map.

### Module structure

```
ocaml/
├── sdk_client.ml               -- Main SDK client (constructors + accessors)
├── sdk_config.ml               -- Embedded API config + feature factory
├── sdk_schema.ml               -- Generated option + entity specs
├── sdk_error.ml                -- Branded error re-exports
├── sdk_entity_*.ml             -- Per-entity implementations (one each)
├── sdk_types.ml                -- Core pipeline types
├── sdk_helpers.ml              -- jo / ja / getp and friends
├── sdk_runtime.ml              -- Operation pipeline runner
├── sdk_features.ml             -- Built-in features (base, test, log)
├── utility/                    -- Vendored voxgig struct port
└── test/                       -- Test suites
```

The public surface lives in `Sdk_client` (the constructors and per-entity
accessors); `Sdk_helpers` carries the `jo` / `ja` / `getp` value
helpers. Open the runtime modules directly only when needed.

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
