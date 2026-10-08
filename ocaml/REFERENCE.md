# Smsapi OCaml SDK Reference

Complete API reference for the Smsapi OCaml SDK.


## Sdk_client

### Constructor

```ocaml
open Voxgig_struct
open Sdk_helpers
open Sdk_types

let client = Sdk_client.make options
```

Create a new SDK client instance from a `value` options map. Use
`Sdk_client.make0 ()` for defaults.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `options` | `value` | SDK configuration options (a Map). |
| `apikey` | `string` | API key for authentication. |
| `base` | `string` | Base URL for API requests. |
| `prefix` | `string` | URL prefix appended after base. |
| `suffix` | `string` | URL suffix appended after path. |
| `headers` | `map` | Custom headers for all requests. |
| `feature` | `map` | Feature configuration. |
| `system` | `map` | System overrides (e.g. custom fetch). |


### Static constructors

#### `Sdk_client.test testopts sdkopts`

Create a test client with mock features active. Both arguments may be `Noval`
(`Sdk_client.test ()` uses defaults, `Sdk_client.test_with` takes explicit
options).

```ocaml
let client = Sdk_client.test ()
```


### Instance functions

#### `Sdk_client.available client entopts : entity_obj`

Create a `Available` entity accessor. Pass `Noval` for no initial options.

#### `Sdk_client.blacklist client entopts : entity_obj`

Create a `Blacklist` entity accessor. Pass `Noval` for no initial options.

#### `Sdk_client.callback client entopts : entity_obj`

Create a `Callback` entity accessor. Pass `Noval` for no initial options.

#### `Sdk_client.contact client entopts : entity_obj`

Create a `Contact` entity accessor. Pass `Noval` for no initial options.

#### `Sdk_client.contacts_field client entopts : entity_obj`

Create a `ContactsField` entity accessor. Pass `Noval` for no initial options.

#### `Sdk_client.contacts_field_option client entopts : entity_obj`

Create a `ContactsFieldOption` entity accessor. Pass `Noval` for no initial options.

#### `Sdk_client.contactsgroup client entopts : entity_obj`

Create a `Contactsgroup` entity accessor. Pass `Noval` for no initial options.

#### `Sdk_client.contactstrash client entopts : entity_obj`

Create a `Contactstrash` entity accessor. Pass `Noval` for no initial options.

#### `Sdk_client.field_available client entopts : entity_obj`

Create a `FieldAvailable` entity accessor. Pass `Noval` for no initial options.

#### `Sdk_client.group client entopts : entity_obj`

Create a `Group` entity accessor. Pass `Noval` for no initial options.

#### `Sdk_client.mfa_code client entopts : entity_obj`

Create a `MfaCode` entity accessor. Pass `Noval` for no initial options.

#### `Sdk_client.opt_out client entopts : entity_obj`

Create a `OptOut` entity accessor. Pass `Noval` for no initial options.

#### `Sdk_client.opt_out_setting client entopts : entity_obj`

Create a `OptOutSetting` entity accessor. Pass `Noval` for no initial options.

#### `Sdk_client.permission client entopts : entity_obj`

Create a `Permission` entity accessor. Pass `Noval` for no initial options.

#### `Sdk_client.ping client entopts : entity_obj`

Create a `Ping` entity accessor. Pass `Noval` for no initial options.

#### `Sdk_client.profile client entopts : entity_obj`

Create a `Profile` entity accessor. Pass `Noval` for no initial options.

#### `Sdk_client.rcs client entopts : entity_obj`

Create a `Rcs` entity accessor. Pass `Noval` for no initial options.

#### `Sdk_client.sendername client entopts : entity_obj`

Create a `Sendername` entity accessor. Pass `Noval` for no initial options.

#### `Sdk_client.sendername_statement client entopts : entity_obj`

Create a `SendernameStatement` entity accessor. Pass `Noval` for no initial options.

#### `Sdk_client.sent_rcs_message client entopts : entity_obj`

Create a `SentRcsMessage` entity accessor. Pass `Noval` for no initial options.

#### `Sdk_client.shipment_country_volume client entopts : entity_obj`

Create a `ShipmentCountryVolume` entity accessor. Pass `Noval` for no initial options.

#### `Sdk_client.short_url client entopts : entity_obj`

Create a `ShortUrl` entity accessor. Pass `Noval` for no initial options.

#### `Sdk_client.smsdo client entopts : entity_obj`

Create a `Smsdo` entity accessor. Pass `Noval` for no initial options.

#### `Sdk_client.smssendername client entopts : entity_obj`

Create a `Smssendername` entity accessor. Pass `Noval` for no initial options.

#### `Sdk_client.smstemplate client entopts : entity_obj`

Create a `Smstemplate` entity accessor. Pass `Noval` for no initial options.

#### `Sdk_client.subuser client entopts : entity_obj`

Create a `Subuser` entity accessor. Pass `Noval` for no initial options.

#### `Sdk_client.template client entopts : entity_obj`

Create a `Template` entity accessor. Pass `Noval` for no initial options.

#### `Sdk_client.user_rcs_sender_collection client entopts : entity_obj`

Create a `UserRcsSenderCollection` entity accessor. Pass `Noval` for no initial options.

#### `Sdk_client.direct client fetchargs : value`

Make a direct HTTP request to any API endpoint. Returns a result `value` map
with `ok`, `status`, `headers`, and `data` (or `err` on failure). This
escape hatch never raises — branch on `getp result "ok"`.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `path` | `string` | URL path with optional `{param}` placeholders. |
| `method` | `string` | HTTP method (default: `"GET"`). |
| `params` | `map` | Path parameter values. |
| `query` | `map` | Query string parameters. |
| `headers` | `map` | Request headers (merged with defaults). |
| `body` | `value` | Request body (Maps are JSON-serialized). |

**Returns:** a result `value` map.

#### `Sdk_client.prepare client fetchargs : value`

Prepare a fetch definition without sending. Returns the `fetchdef` and raises
on error.


---

## Available

```ocaml
let available = Sdk_client.available client Noval
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `name` | `string` | No |  |
| `normalize` | `bool` | No |  |
| `template` | `string` | No |  |

### Operations

#### `e_list reqmatch ctrl : entity_obj list`

List entities matching the given criteria. The match is optional — pass `(empty_map ())` to list all records. Resolves to one entity per record and raises on error.

```ocaml
(* One ENTITY per record; the record is reached with e_data_get. *)
let results = (Sdk_client.available client Noval).e_list (empty_map ()) Noval in
List.iter (fun e -> print_endline (stringify (e.e_data_get ()))) results
```

### Common Fields

#### `e_data_get : unit -> value`

Get the entity data.

#### `e_data_set : value -> unit`

Set the entity data.

#### `e_match_get : unit -> value`

Get the entity match criteria.

#### `e_match_set : value -> unit`

Set the entity match criteria.

#### `e_make : unit -> entity_obj`

Create a new `Available` entity accessor with the same options.

#### `e_name : string`

The entity name.


---

## Blacklist

```ocaml
let blacklist = Sdk_client.blacklist client Noval
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | `string` | No |  |

### Operations

#### `e_create reqdata ctrl : entity_obj`

Create a new entity with the given data. Resolves to the created entity and raises on error.

```ocaml
let result = (Sdk_client.blacklist client Noval).e_create (jo [
]) Noval
let result_data = result.e_data_get ()
```

Declares a `multipart/form-data` body, which this SDK does not encode yet: it sends the data as JSON.

#### `e_load reqmatch ctrl : entity_obj`

Load a single entity matching the given criteria. Resolves to the entity, whose record `e_data_get` reads, and raises on error.

```ocaml
let result = (Sdk_client.blacklist client Noval).e_load (Noval) Noval
let result_data = result.e_data_get ()
```

#### `e_remove reqmatch ctrl : entity_obj`

Remove the entity matching the given criteria. Resolves to the entity, marked as deleted (`e_deleted`); it keeps the data it held. Raises on error.

```ocaml
let result = (Sdk_client.blacklist client Noval).e_remove (jo [("id", (Str "id"))]) Noval
let result_data = result.e_data_get ()
```

### Common Fields

#### `e_data_get : unit -> value`

Get the entity data.

#### `e_data_set : value -> unit`

Set the entity data.

#### `e_match_get : unit -> value`

Get the entity match criteria.

#### `e_match_set : value -> unit`

Set the entity match criteria.

#### `e_make : unit -> entity_obj`

Create a new `Blacklist` entity accessor with the same options.

#### `e_name : string`

The entity name.


---

## Callback

```ocaml
let callback = Sdk_client.callback client Noval
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `active` | `bool` | No |  |
| `api_version` | `int` | No | Version of the callback output format. |
| `id` | `string` | No | Object ID |
| `invalid` | `bool` | No |  |
| `receiver` | `value map` | No |  |
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

#### `e_create reqdata ctrl : entity_obj`

Create a new entity with the given data. Resolves to the created entity and raises on error.

```ocaml
let result = (Sdk_client.callback client Noval).e_create (jo [
]) Noval
let result_data = result.e_data_get ()
```

#### `e_list reqmatch ctrl : entity_obj list`

List entities matching the given criteria. The match is optional — pass `(empty_map ())` to list all records. Resolves to one entity per record and raises on error.

```ocaml
(* One ENTITY per record; the record is reached with e_data_get. *)
let results = (Sdk_client.callback client Noval).e_list (empty_map ()) Noval in
List.iter (fun e -> print_endline (stringify (e.e_data_get ()))) results
```

#### `e_load reqmatch ctrl : entity_obj`

Load a single entity matching the given criteria. Resolves to the entity, whose record `e_data_get` reads, and raises on error.

```ocaml
let result = (Sdk_client.callback client Noval).e_load (jo [("id", (Str "callback_id"))]) Noval
let result_data = result.e_data_get ()
```

#### `e_remove reqmatch ctrl : entity_obj`

Remove the entity matching the given criteria. Resolves to the entity, marked as deleted (`e_deleted`); it keeps the data it held. Raises on error.

```ocaml
let result = (Sdk_client.callback client Noval).e_remove (jo [("id", (Str "callback_id"))]) Noval
let result_data = result.e_data_get ()
```

#### `e_update reqdata ctrl : entity_obj`

Update an existing entity. The data must include the entity `id`. Resolves to the updated entity and raises on error.

```ocaml
let result = (Sdk_client.callback client Noval).e_update (jo [
    ("id", (Str "callback_id"));
    (* Fields to update *)
]) Noval
let result_data = result.e_data_get ()
```

### Common Fields

#### `e_data_get : unit -> value`

Get the entity data.

#### `e_data_set : value -> unit`

Set the entity data.

#### `e_match_get : unit -> value`

Get the entity match criteria.

#### `e_match_set : value -> unit`

Set the entity match criteria.

#### `e_make : unit -> entity_obj`

Create a new `Callback` entity accessor with the same options.

#### `e_name : string`

The entity name.


---

## Contact

```ocaml
let contact = Sdk_client.contact client Noval
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `birthday_date` | `string` | No |  |
| `city` | `string` | No |  |
| `collection` | `value list` | Yes |  |
| `contact_expire_after` | `int` | Yes | Contact expire after days |
| `contacts_count` | `int` | Yes |  |
| `country` | `string` | No |  |
| `created_by` | `string` | Yes |  |
| `date_created` | `string` | Yes |  |
| `date_updated` | `string` | Yes |  |
| `description` | `string` | No |  |
| `email` | `string` | No |  |
| `first_name` | `string` | No |  |
| `gender` | `string` | Yes |  |
| `groups` | `value list` | Yes |  |
| `id` | `string` | Yes | Object ID |
| `idx` | `string` | No | User provided resource id |
| `last_name` | `string` | No |  |
| `name` | `string` | Yes | Group name |
| `permissions` | `value list` | No |  |
| `phone_number` | `string` | No |  |
| `size` | `int` | Yes |  |
| `source` | `string` | No |  |

### Field Usage by Operation

| Field | load | list | create | update | remove |
| --- | --- | --- | --- | --- | --- |
| `birthday_date` | - | - | - | - | - |
| `city` | - | - | - | - | - |
| `collection` | - | - | - | - | - |
| `contact_expire_after` | - | - | - | - | - |
| `contacts_count` | - | - | - | - | - |
| `country` | - | - | - | - | - |
| `created_by` | - | - | - | - | - |
| `date_created` | - | - | - | - | - |
| `date_updated` | - | - | - | - | - |
| `description` | Yes | - | - | - | - |
| `email` | - | - | - | - | - |
| `first_name` | - | - | - | - | - |
| `gender` | - | - | - | - | - |
| `groups` | - | - | - | - | - |
| `id` | - | - | - | - | - |
| `idx` | - | - | - | - | - |
| `last_name` | - | - | - | - | - |
| `name` | - | - | - | - | - |
| `permissions` | - | - | - | - | - |
| `phone_number` | - | - | - | - | - |
| `size` | - | - | - | - | - |
| `source` | - | - | - | - | - |

### Operations

#### `e_create reqdata ctrl : entity_obj`

Create a new entity with the given data. Resolves to the created entity and raises on error.

```ocaml
let result = (Sdk_client.contact client Noval).e_create (jo [
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
let result_data = result.e_data_get ()
```

Declares a `application/x-www-form-urlencoded` body, which this SDK does not encode yet: it sends the data as JSON.

#### `e_list reqmatch ctrl : entity_obj list`

List entities matching the given criteria. The match is optional — pass `(empty_map ())` to list all records. Resolves to one entity per record and raises on error.

```ocaml
(* One ENTITY per record; the record is reached with e_data_get. *)
let results = (Sdk_client.contact client Noval).e_list (empty_map ()) Noval in
List.iter (fun e -> print_endline (stringify (e.e_data_get ()))) results
```

#### `e_load reqmatch ctrl : entity_obj`

Load a single entity matching the given criteria. Resolves to the entity, whose record `e_data_get` reads, and raises on error.

```ocaml
let result = (Sdk_client.contact client Noval).e_load (jo [("id", (Str "contact_id"))]) Noval
let result_data = result.e_data_get ()
```

#### `e_remove reqmatch ctrl : entity_obj`

Remove the entity matching the given criteria. Resolves to the entity, marked as deleted (`e_deleted`); it keeps the data it held. Raises on error.

```ocaml
let result = (Sdk_client.contact client Noval).e_remove (jo [("id", (Str "contact_id"))]) Noval
let result_data = result.e_data_get ()
```

#### `e_update reqdata ctrl : entity_obj`

Update an existing entity. The data must include the entity `id`. Resolves to the updated entity and raises on error.

```ocaml
let result = (Sdk_client.contact client Noval).e_update (jo [
    ("id", (Str "contact_id"));
    (* Fields to update *)
]) Noval
let result_data = result.e_data_get ()
```

Declares a `application/x-www-form-urlencoded` body, which this SDK does not encode yet: it sends the data as JSON.

### Common Fields

#### `e_data_get : unit -> value`

Get the entity data.

#### `e_data_set : value -> unit`

Set the entity data.

#### `e_match_get : unit -> value`

Get the entity match criteria.

#### `e_match_set : value -> unit`

Set the entity match criteria.

#### `e_make : unit -> entity_obj`

Create a new `Contact` entity accessor with the same options.

#### `e_name : string`

The entity name.


---

## ContactsField

```ocaml
let contacts_field = Sdk_client.contacts_field client Noval
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | `string` | No | Object ID |
| `name` | `string` | No |  |
| `type` | `string` | No |  |

### Operations

#### `e_create reqdata ctrl : entity_obj`

Create a new entity with the given data. Resolves to the created entity and raises on error.

```ocaml
let result = (Sdk_client.contacts_field client Noval).e_create (jo [
]) Noval
let result_data = result.e_data_get ()
```

Declares a `application/x-www-form-urlencoded` body, which this SDK does not encode yet: it sends the data as JSON.

#### `e_list reqmatch ctrl : entity_obj list`

List entities matching the given criteria. The match is optional — pass `(empty_map ())` to list all records. Resolves to one entity per record and raises on error.

```ocaml
(* One ENTITY per record; the record is reached with e_data_get. *)
let results = (Sdk_client.contacts_field client Noval).e_list (empty_map ()) Noval in
List.iter (fun e -> print_endline (stringify (e.e_data_get ()))) results
```

#### `e_remove reqmatch ctrl : entity_obj`

Remove the entity matching the given criteria. Resolves to the entity, marked as deleted (`e_deleted`); it keeps the data it held. Raises on error.

```ocaml
let result = (Sdk_client.contacts_field client Noval).e_remove (jo [("id", (Str "id"))]) Noval
let result_data = result.e_data_get ()
```

#### `e_update reqdata ctrl : entity_obj`

Update an existing entity. The data must include the entity `id`. Resolves to the updated entity and raises on error.

```ocaml
let result = (Sdk_client.contacts_field client Noval).e_update (jo [
    ("id", (Str "id"));
    (* Fields to update *)
]) Noval
let result_data = result.e_data_get ()
```

Declares a `application/x-www-form-urlencoded` body, which this SDK does not encode yet: it sends the data as JSON.

### Common Fields

#### `e_data_get : unit -> value`

Get the entity data.

#### `e_data_set : value -> unit`

Set the entity data.

#### `e_match_get : unit -> value`

Get the entity match criteria.

#### `e_match_set : value -> unit`

Set the entity match criteria.

#### `e_make : unit -> entity_obj`

Create a new `ContactsField` entity accessor with the same options.

#### `e_name : string`

The entity name.


---

## ContactsFieldOption

```ocaml
let contacts_field_option = Sdk_client.contacts_field_option client Noval
```

### Operations

#### `e_list reqmatch ctrl : entity_obj list`

List entities matching the given criteria. The match is optional — pass `(empty_map ())` to list all records. Resolves to one entity per record and raises on error.

```ocaml
(* One ENTITY per record; the record is reached with e_data_get. *)
let results = (Sdk_client.contacts_field_option client Noval).e_list (jo [("field_id", (Str "example"))]) Noval in
List.iter (fun e -> print_endline (stringify (e.e_data_get ()))) results
```

### Common Fields

#### `e_data_get : unit -> value`

Get the entity data.

#### `e_data_set : value -> unit`

Set the entity data.

#### `e_match_get : unit -> value`

Get the entity match criteria.

#### `e_match_set : value -> unit`

Set the entity match criteria.

#### `e_make : unit -> entity_obj`

Create a new `ContactsFieldOption` entity accessor with the same options.

#### `e_name : string`

The entity name.


---

## Contactsgroup

```ocaml
let contactsgroup = Sdk_client.contactsgroup client Noval
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `group_id` | `string` | Yes | Object ID |
| `read` | `bool` | Yes | Has read permission |
| `send` | `bool` | Yes | Has send permission |
| `username` | `string` | Yes |  |
| `write` | `bool` | Yes | Has write permission |

### Operations

#### `e_create reqdata ctrl : entity_obj`

Create a new entity with the given data. Resolves to the created entity and raises on error.

```ocaml
let result = (Sdk_client.contactsgroup client Noval).e_create (jo [
    ("group_id", (Str "example_group_id"));  (* string *)
    ("read", (Bool true));  (* bool *)
    ("send", (Bool true));  (* bool *)
    ("username", (Str "example_username"));  (* string *)
    ("write", (Bool true));  (* bool *)
]) Noval
let result_data = result.e_data_get ()
```

Declares a `application/x-www-form-urlencoded` body, which this SDK does not encode yet: it sends the data as JSON.

#### `e_list reqmatch ctrl : entity_obj list`

List entities matching the given criteria. The match is optional — pass `(empty_map ())` to list all records. Resolves to one entity per record and raises on error.

```ocaml
(* One ENTITY per record; the record is reached with e_data_get. *)
let results = (Sdk_client.contactsgroup client Noval).e_list (empty_map ()) Noval in
List.iter (fun e -> print_endline (stringify (e.e_data_get ()))) results
```

#### `e_remove reqmatch ctrl : entity_obj`

Remove the entity matching the given criteria. Resolves to the entity, marked as deleted (`e_deleted`); it keeps the data it held. Raises on error.

```ocaml
let result = (Sdk_client.contactsgroup client Noval).e_remove (jo [("group_id", (Str "group_id"))]) Noval
let result_data = result.e_data_get ()
```

#### `e_update reqdata ctrl : entity_obj`

Update an existing entity. The data must include the entity `id`. Resolves to the updated entity and raises on error.

```ocaml
let result = (Sdk_client.contactsgroup client Noval).e_update (jo [
    ("group_id", (Str "group_id"));
    (* Fields to update *)
]) Noval
let result_data = result.e_data_get ()
```

Declares a `application/x-www-form-urlencoded` body, which this SDK does not encode yet: it sends the data as JSON.

### Common Fields

#### `e_data_get : unit -> value`

Get the entity data.

#### `e_data_set : value -> unit`

Set the entity data.

#### `e_match_get : unit -> value`

Get the entity match criteria.

#### `e_match_set : value -> unit`

Set the entity match criteria.

#### `e_make : unit -> entity_obj`

Create a new `Contactsgroup` entity accessor with the same options.

#### `e_name : string`

The entity name.


---

## Contactstrash

```ocaml
let contactstrash = Sdk_client.contactstrash client Noval
```

### Operations

#### `e_remove reqmatch ctrl : entity_obj`

Remove the entity matching the given criteria. Resolves to the entity, marked as deleted (`e_deleted`); it keeps the data it held. Raises on error.

```ocaml
let result = (Sdk_client.contactstrash client Noval).e_remove (Noval) Noval
let result_data = result.e_data_get ()
```

#### `e_update reqdata ctrl : entity_obj`

Update an existing entity. The data must include the entity `id`. Resolves to the updated entity and raises on error.

```ocaml
let result = (Sdk_client.contactstrash client Noval).e_update (jo [
    (* Fields to update *)
]) Noval
let result_data = result.e_data_get ()
```

### Common Fields

#### `e_data_get : unit -> value`

Get the entity data.

#### `e_data_set : value -> unit`

Set the entity data.

#### `e_match_get : unit -> value`

Get the entity match criteria.

#### `e_match_set : value -> unit`

Set the entity match criteria.

#### `e_make : unit -> entity_obj`

Create a new `Contactstrash` entity accessor with the same options.

#### `e_name : string`

The entity name.


---

## FieldAvailable

```ocaml
let field_available = Sdk_client.field_available client Noval
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `built_in` | `bool` | No |  |
| `id` | `string` | No | Object ID |
| `name` | `string` | No |  |
| `options` | `value list` | No |  |
| `type` | `string` | No |  |

### Operations

#### `e_list reqmatch ctrl : entity_obj list`

List entities matching the given criteria. The match is optional — pass `(empty_map ())` to list all records. Resolves to one entity per record and raises on error.

```ocaml
(* One ENTITY per record; the record is reached with e_data_get. *)
let results = (Sdk_client.field_available client Noval).e_list (empty_map ()) Noval in
List.iter (fun e -> print_endline (stringify (e.e_data_get ()))) results
```

### Common Fields

#### `e_data_get : unit -> value`

Get the entity data.

#### `e_data_set : value -> unit`

Set the entity data.

#### `e_match_get : unit -> value`

Get the entity match criteria.

#### `e_match_set : value -> unit`

Set the entity match criteria.

#### `e_make : unit -> entity_obj`

Create a new `FieldAvailable` entity accessor with the same options.

#### `e_name : string`

The entity name.


---

## Group

```ocaml
let group = Sdk_client.group client Noval
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `contact_expire_after` | `int` | Yes | Contact expire after days |
| `contacts_count` | `int` | Yes |  |
| `created_by` | `string` | Yes |  |
| `date_created` | `string` | Yes |  |
| `date_updated` | `string` | Yes |  |
| `description` | `string` | Yes |  |
| `id` | `string` | Yes | Object ID |
| `idx` | `string` | No | User provided resource id |
| `name` | `string` | Yes | Group name |
| `permissions` | `value list` | No |  |

### Operations

#### `e_load reqmatch ctrl : entity_obj`

Load a single entity matching the given criteria. Resolves to the entity, whose record `e_data_get` reads, and raises on error.

```ocaml
let result = (Sdk_client.group client Noval).e_load (jo [("id", (Str "group_id"))]) Noval
let result_data = result.e_data_get ()
```

#### `e_update reqdata ctrl : entity_obj`

Update an existing entity. The data must include the entity `id`. Resolves to the updated entity and raises on error.

```ocaml
let result = (Sdk_client.group client Noval).e_update (jo [
    ("id", (Str "group_id"));
    (* Fields to update *)
]) Noval
let result_data = result.e_data_get ()
```

Declares a `application/x-www-form-urlencoded` body, which this SDK does not encode yet: it sends the data as JSON.

### Common Fields

#### `e_data_get : unit -> value`

Get the entity data.

#### `e_data_set : value -> unit`

Set the entity data.

#### `e_match_get : unit -> value`

Get the entity match criteria.

#### `e_match_set : value -> unit`

Set the entity match criteria.

#### `e_make : unit -> entity_obj`

Create a new `Group` entity accessor with the same options.

#### `e_name : string`

The entity name.


---

## MfaCode

```ocaml
let mfa_code = Sdk_client.mfa_code client Noval
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `content` | `string` | No | Custom content that must contain placeholder [%code%] |
| `fast` | `value` | No |  |
| `from` | `string` | No | Sendername |
| `phone_number` | `string` | Yes |  |

### Operations

#### `e_create reqdata ctrl : entity_obj`

Create a new entity with the given data. Resolves to the created entity and raises on error.

```ocaml
let result = (Sdk_client.mfa_code client Noval).e_create (jo [
    ("phone_number", (Str "example_phone_number"));  (* string *)
]) Noval
let result_data = result.e_data_get ()
```

Declares a `application/x-www-form-urlencoded` body, which this SDK does not encode yet: it sends the data as JSON.

### Common Fields

#### `e_data_get : unit -> value`

Get the entity data.

#### `e_data_set : value -> unit`

Set the entity data.

#### `e_match_get : unit -> value`

Get the entity match criteria.

#### `e_match_set : value -> unit`

Set the entity match criteria.

#### `e_make : unit -> entity_obj`

Create a new `MfaCode` entity accessor with the same options.

#### `e_name : string`

The entity name.


---

## OptOut

```ocaml
let opt_out = Sdk_client.opt_out client Noval
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `date` | `string` | No |  |
| `id` | `string` | No |  |
| `links` | `value list` | No |  |
| `phoneNumber` | `int` | No |  |

### Operations

#### `e_list reqmatch ctrl : entity_obj list`

List entities matching the given criteria. The match is optional — pass `(empty_map ())` to list all records. Resolves to one entity per record and raises on error.

```ocaml
(* One ENTITY per record; the record is reached with e_data_get. *)
let results = (Sdk_client.opt_out client Noval).e_list (empty_map ()) Noval in
List.iter (fun e -> print_endline (stringify (e.e_data_get ()))) results
```

#### `e_remove reqmatch ctrl : entity_obj`

Remove the entity matching the given criteria. Resolves to the entity, marked as deleted (`e_deleted`); it keeps the data it held. Raises on error.

```ocaml
let result = (Sdk_client.opt_out client Noval).e_remove (jo [("id", (Str "id"))]) Noval
let result_data = result.e_data_get ()
```

### Common Fields

#### `e_data_get : unit -> value`

Get the entity data.

#### `e_data_set : value -> unit`

Set the entity data.

#### `e_match_get : unit -> value`

Get the entity match criteria.

#### `e_match_set : value -> unit`

Set the entity match criteria.

#### `e_make : unit -> entity_obj`

Create a new `OptOut` entity accessor with the same options.

#### `e_name : string`

The entity name.


---

## OptOutSetting

```ocaml
let opt_out_setting = Sdk_client.opt_out_setting client Noval
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `brand` | `string` | No |  |

### Operations

#### `e_load reqmatch ctrl : entity_obj`

Load a single entity matching the given criteria. Resolves to the entity, whose record `e_data_get` reads, and raises on error.

```ocaml
let result = (Sdk_client.opt_out_setting client Noval).e_load (Noval) Noval
let result_data = result.e_data_get ()
```

#### `e_update reqdata ctrl : entity_obj`

Update an existing entity. The data must include the entity `id`. Resolves to the updated entity and raises on error.

```ocaml
let result = (Sdk_client.opt_out_setting client Noval).e_update (jo [
    (* Fields to update *)
]) Noval
let result_data = result.e_data_get ()
```

### Common Fields

#### `e_data_get : unit -> value`

Get the entity data.

#### `e_data_set : value -> unit`

Set the entity data.

#### `e_match_get : unit -> value`

Get the entity match criteria.

#### `e_match_set : value -> unit`

Set the entity match criteria.

#### `e_make : unit -> entity_obj`

Create a new `OptOutSetting` entity accessor with the same options.

#### `e_name : string`

The entity name.


---

## Permission

```ocaml
let permission = Sdk_client.permission client Noval
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `group_id` | `string` | Yes | Object ID |
| `id` | `string` | No |  |
| `read` | `bool` | Yes | Has read permission |
| `send` | `bool` | Yes | Has send permission |
| `username` | `string` | Yes |  |
| `write` | `bool` | Yes | Has write permission |

### Operations

#### `e_create reqdata ctrl : entity_obj`

Create a new entity with the given data. Resolves to the created entity and raises on error.

```ocaml
let result = (Sdk_client.permission client Noval).e_create (jo [
    ("group_id", (Str "example_group_id"));  (* string *)
    ("read", (Bool true));  (* bool *)
    ("send", (Bool true));  (* bool *)
    ("username", (Str "example_username"));  (* string *)
    ("write", (Bool true));  (* bool *)
]) Noval
let result_data = result.e_data_get ()
```

Declares a `application/x-www-form-urlencoded` body, which this SDK does not encode yet: it sends the data as JSON.

#### `e_load reqmatch ctrl : entity_obj`

Load a single entity matching the given criteria. Resolves to the entity, whose record `e_data_get` reads, and raises on error.

```ocaml
let result = (Sdk_client.permission client Noval).e_load (jo [("id", (Str "permission_id")); ("group_id", (Str "group_id"))]) Noval
let result_data = result.e_data_get ()
```

### Common Fields

#### `e_data_get : unit -> value`

Get the entity data.

#### `e_data_set : value -> unit`

Set the entity data.

#### `e_match_get : unit -> value`

Get the entity match criteria.

#### `e_match_set : value -> unit`

Set the entity match criteria.

#### `e_make : unit -> entity_obj`

Create a new `Permission` entity accessor with the same options.

#### `e_name : string`

The entity name.


---

## Ping

```ocaml
let ping = Sdk_client.ping client Noval
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `authorized` | `bool` | Yes |  |
| `unavailable` | `value list` | Yes |  |

### Operations

#### `e_list reqmatch ctrl : entity_obj list`

List entities matching the given criteria. The match is optional — pass `(empty_map ())` to list all records. Resolves to one entity per record and raises on error.

```ocaml
(* One ENTITY per record; the record is reached with e_data_get. *)
let results = (Sdk_client.ping client Noval).e_list (empty_map ()) Noval in
List.iter (fun e -> print_endline (stringify (e.e_data_get ()))) results
```

### Common Fields

#### `e_data_get : unit -> value`

Get the entity data.

#### `e_data_set : value -> unit`

Set the entity data.

#### `e_match_get : unit -> value`

Get the entity match criteria.

#### `e_match_set : value -> unit`

Set the entity match criteria.

#### `e_make : unit -> entity_obj`

Create a new `Ping` entity accessor with the same options.

#### `e_name : string`

The entity name.


---

## Profile

```ocaml
let profile = Sdk_client.profile client Noval
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `email` | `string` | Yes |  |
| `name` | `string` | Yes |  |
| `payment_type` | `string` | Yes |  |
| `phone_number` | `int` | Yes |  |
| `points` | `float` | No |  |
| `user_type` | `string` | Yes |  |
| `username` | `string` | Yes |  |

### Operations

#### `e_list reqmatch ctrl : entity_obj list`

List entities matching the given criteria. The match is optional — pass `(empty_map ())` to list all records. Resolves to one entity per record and raises on error.

```ocaml
(* One ENTITY per record; the record is reached with e_data_get. *)
let results = (Sdk_client.profile client Noval).e_list (empty_map ()) Noval in
List.iter (fun e -> print_endline (stringify (e.e_data_get ()))) results
```

#### `e_load reqmatch ctrl : entity_obj`

Load a single entity matching the given criteria. Resolves to the entity, whose record `e_data_get` reads, and raises on error.

```ocaml
let result = (Sdk_client.profile client Noval).e_load (Noval) Noval
let result_data = result.e_data_get ()
```

### Common Fields

#### `e_data_get : unit -> value`

Get the entity data.

#### `e_data_set : value -> unit`

Set the entity data.

#### `e_match_get : unit -> value`

Get the entity match criteria.

#### `e_match_set : value -> unit`

Set the entity match criteria.

#### `e_make : unit -> entity_obj`

Create a new `Profile` entity accessor with the same options.

#### `e_name : string`

The entity name.


---

## Rcs

```ocaml
let rcs = Sdk_client.rcs client Noval
```

### Operations

#### `e_list reqmatch ctrl : entity_obj list`

List entities matching the given criteria. The match is optional — pass `(empty_map ())` to list all records. Resolves to one entity per record and raises on error.

```ocaml
(* One ENTITY per record; the record is reached with e_data_get. *)
let results = (Sdk_client.rcs client Noval).e_list (empty_map ()) Noval in
List.iter (fun e -> print_endline (stringify (e.e_data_get ()))) results
```

### Common Fields

#### `e_data_get : unit -> value`

Get the entity data.

#### `e_data_set : value -> unit`

Set the entity data.

#### `e_match_get : unit -> value`

Get the entity match criteria.

#### `e_match_set : value -> unit`

Set the entity match criteria.

#### `e_make : unit -> entity_obj`

Create a new `Rcs` entity accessor with the same options.

#### `e_name : string`

The entity name.


---

## Sendername

```ocaml
let sendername = Sdk_client.sendername client Noval
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `created_at` | `string` | No |  |
| `id` | `string` | No |  |
| `is_default` | `bool` | No |  |
| `sender` | `string` | No | Sendername |
| `status` | `string` | No |  |

### Operations

#### `e_create reqdata ctrl : entity_obj`

Create a new entity with the given data. Resolves to the created entity and raises on error.

```ocaml
let result = (Sdk_client.sendername client Noval).e_create (jo [
]) Noval
let result_data = result.e_data_get ()
```

Declares a `application/x-www-form-urlencoded` body, which this SDK does not encode yet: it sends the data as JSON.

#### `e_list reqmatch ctrl : entity_obj list`

List entities matching the given criteria. The match is optional — pass `(empty_map ())` to list all records. Resolves to one entity per record and raises on error.

```ocaml
(* One ENTITY per record; the record is reached with e_data_get. *)
let results = (Sdk_client.sendername client Noval).e_list (empty_map ()) Noval in
List.iter (fun e -> print_endline (stringify (e.e_data_get ()))) results
```

#### `e_load reqmatch ctrl : entity_obj`

Load a single entity matching the given criteria. Resolves to the entity, whose record `e_data_get` reads, and raises on error.

```ocaml
let result = (Sdk_client.sendername client Noval).e_load (jo [("id", (Str "sendername_id"))]) Noval
let result_data = result.e_data_get ()
```

### Common Fields

#### `e_data_get : unit -> value`

Get the entity data.

#### `e_data_set : value -> unit`

Set the entity data.

#### `e_match_get : unit -> value`

Get the entity match criteria.

#### `e_match_set : value -> unit`

Set the entity match criteria.

#### `e_make : unit -> entity_obj`

Create a new `Sendername` entity accessor with the same options.

#### `e_name : string`

The entity name.


---

## SendernameStatement

```ocaml
let sendername_statement = Sdk_client.sendername_statement client Noval
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `content` | `string` | No |  |
| `statements` | `value list` | No |  |
| `title` | `string` | No |  |

### Operations

#### `e_list reqmatch ctrl : entity_obj list`

List entities matching the given criteria. The match is optional — pass `(empty_map ())` to list all records. Resolves to one entity per record and raises on error.

```ocaml
(* One ENTITY per record; the record is reached with e_data_get. *)
let results = (Sdk_client.sendername_statement client Noval).e_list (empty_map ()) Noval in
List.iter (fun e -> print_endline (stringify (e.e_data_get ()))) results
```

### Common Fields

#### `e_data_get : unit -> value`

Get the entity data.

#### `e_data_set : value -> unit`

Set the entity data.

#### `e_match_get : unit -> value`

Get the entity match criteria.

#### `e_match_set : value -> unit`

Set the entity match criteria.

#### `e_make : unit -> entity_obj`

Create a new `SendernameStatement` entity accessor with the same options.

#### `e_name : string`

The entity name.


---

## SentRcsMessage

```ocaml
let sent_rcs_message = Sdk_client.sent_rcs_message client Noval
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `content` | `value map` | No | RCS message content in RCS JSON format. |
| `phone_number` | `string` | Yes | Recipient phone number (e.g. |
| `sender` | `string` | Yes | RCS sender ID (object ID of the agent/sender the user has access to). |
| `text` | `string` | No | Plain text message content. |

### Operations

#### `e_create reqdata ctrl : entity_obj`

Create a new entity with the given data. Resolves to the created entity and raises on error.

```ocaml
let result = (Sdk_client.sent_rcs_message client Noval).e_create (jo [
    ("phone_number", (Str "example_phone_number"));  (* string *)
    ("sender", (Str "example_sender"));  (* string *)
]) Noval
let result_data = result.e_data_get ()
```

### Common Fields

#### `e_data_get : unit -> value`

Get the entity data.

#### `e_data_set : value -> unit`

Set the entity data.

#### `e_match_get : unit -> value`

Get the entity match criteria.

#### `e_match_set : value -> unit`

Set the entity match criteria.

#### `e_make : unit -> entity_obj`

Create a new `SentRcsMessage` entity accessor with the same options.

#### `e_name : string`

The entity name.


---

## ShipmentCountryVolume

```ocaml
let shipment_country_volume = Sdk_client.shipment_country_volume client Noval
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `country_code` | `string` | No |  |
| `country_limit` | `int` | No |  |
| `country_name` | `string` | No |  |
| `usage` | `int` | No |  |

### Operations

#### `e_list reqmatch ctrl : entity_obj list`

List entities matching the given criteria. The match is optional — pass `(empty_map ())` to list all records. Resolves to one entity per record and raises on error.

```ocaml
(* One ENTITY per record; the record is reached with e_data_get. *)
let results = (Sdk_client.shipment_country_volume client Noval).e_list (empty_map ()) Noval in
List.iter (fun e -> print_endline (stringify (e.e_data_get ()))) results
```

### Common Fields

#### `e_data_get : unit -> value`

Get the entity data.

#### `e_data_set : value -> unit`

Set the entity data.

#### `e_match_get : unit -> value`

Get the entity match criteria.

#### `e_match_set : value -> unit`

Set the entity match criteria.

#### `e_make : unit -> entity_obj`

Create a new `ShipmentCountryVolume` entity accessor with the same options.

#### `e_name : string`

The entity name.


---

## ShortUrl

```ocaml
let short_url = Sdk_client.short_url client Noval
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `description` | `string` | No |  |
| `expire` | `string` | No |  |
| `filename` | `string` | No |  |
| `hits` | `int` | No |  |
| `hits_unique` | `int` | No |  |
| `id` | `string` | No |  |
| `name` | `string` | No |  |
| `short_url` | `string` | No | WHATWG URL compliant |
| `type` | `string` | No |  |
| `url` | `string` | No | WHATWG URL compliant |

### Operations

#### `e_create reqdata ctrl : entity_obj`

Create a new entity with the given data. Resolves to the created entity and raises on error.

```ocaml
let result = (Sdk_client.short_url client Noval).e_create (jo [
]) Noval
let result_data = result.e_data_get ()
```

#### `e_list reqmatch ctrl : entity_obj list`

List entities matching the given criteria. The match is optional — pass `(empty_map ())` to list all records. Resolves to one entity per record and raises on error.

```ocaml
(* One ENTITY per record; the record is reached with e_data_get. *)
let results = (Sdk_client.short_url client Noval).e_list (empty_map ()) Noval in
List.iter (fun e -> print_endline (stringify (e.e_data_get ()))) results
```

#### `e_load reqmatch ctrl : entity_obj`

Load a single entity matching the given criteria. Resolves to the entity, whose record `e_data_get` reads, and raises on error.

```ocaml
let result = (Sdk_client.short_url client Noval).e_load (jo [("id", (Str "short_url_id"))]) Noval
let result_data = result.e_data_get ()
```

#### `e_remove reqmatch ctrl : entity_obj`

Remove the entity matching the given criteria. Resolves to the entity, marked as deleted (`e_deleted`); it keeps the data it held. Raises on error.

```ocaml
let result = (Sdk_client.short_url client Noval).e_remove (jo [("id", (Str "short_url_id"))]) Noval
let result_data = result.e_data_get ()
```

#### `e_update reqdata ctrl : entity_obj`

Update an existing entity. The data must include the entity `id`. Resolves to the updated entity and raises on error.

```ocaml
let result = (Sdk_client.short_url client Noval).e_update (jo [
    ("id", (Str "short_url_id"));
    (* Fields to update *)
]) Noval
let result_data = result.e_data_get ()
```

Declares a `application/x-www-form-urlencoded` body, which this SDK does not encode yet: it sends the data as JSON.

### Common Fields

#### `e_data_get : unit -> value`

Get the entity data.

#### `e_data_set : value -> unit`

Set the entity data.

#### `e_match_get : unit -> value`

Get the entity match criteria.

#### `e_match_set : value -> unit`

Set the entity match criteria.

#### `e_make : unit -> entity_obj`

Create a new `ShortUrl` entity accessor with the same options.

#### `e_name : string`

The entity name.


---

## Smsdo

```ocaml
let smsdo = Sdk_client.smsdo client Noval
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `allow_duplicates` | `int` | No | When parameter allow_duplicates is set to "1" allows to send message to duplicated numbers in one request (useful i.e. |
| `check_idx` | `value` | No | When parameter check_idx is set to „1” prevents from sending more than one message with the same idx in last 24h. |
| `date` | `value` | No | Date in UNIX timestamp (&date=1287734110) or in ISO 8601 (&date=2012-05-10T08:40:27+00:00) when message will be sent (&date=1287734110). |
| `date_validate` | `int` | No | When parameter date_validate is set to "1" checks if date if given in proper format. |
| `details` | `value` | No | When details parameter is set to "1" more details in response will be displayed (message length and sms count). |
| `encoding` | `string` | No | This parameter describes the encoding of the message text. |
| `expiration_date` | `value` | No | Message expiration date (in UNIX timestamp or in ISO 8601) is a date after which message won't be delivered if it wasn't delivered yet. |
| `fallback` | `value list` | No | Enable fallback in case sms sending fails |
| `fast` | `int` | No | Setting this parameter to „1” will result in sending message with the highest priority which ensures the quickest possible time of delivery. |
| `flash` | `int` | No | Sending a message in flash mode can be activated by setting this parameter to "1". |
| `format` | `string` | No | Parameter &format=json causes, that response is sending in JSON format. |
| `from` | `string` | No | Name of the sender. |
| `group` | `string` | No | Name of the group from the contacts database to which message should be sent to. |
| `idx` | `string` | No | Optional custom value sent with SMS and sent back in CALLBACK. |
| `max_parts` | `int` | No | Defines maximum message parts allowed, maximum value allowed is 6. |
| `message` | `string` | No | The message text. |
| `normalize` | `int` | No | When parameter normalize is set to „1” special chars in message will be replaced with their equivalents (ê-e, ñ-n, ý-y ...). |
| `notify_url` | `string` | No | Parameter allows to set CALLBACK URL for message from request. |
| `test` | `value` | No | When parameter test is set to "1" message won't be sent but response will be displayed, there is no charge for such test messages. |
| `time_restriction` | `string` | No | Sets the behavior when you try to ship in hours / dates that do not match the settings in your account. |
| `to` | `string` | No | Recipients' mobile phone numbers (i.e. |

### Operations

#### `e_create reqdata ctrl : entity_obj`

Create a new entity with the given data. Resolves to the created entity and raises on error.

```ocaml
let result = (Sdk_client.smsdo client Noval).e_create (jo [
]) Noval
let result_data = result.e_data_get ()
```

### Common Fields

#### `e_data_get : unit -> value`

Get the entity data.

#### `e_data_set : value -> unit`

Set the entity data.

#### `e_match_get : unit -> value`

Get the entity match criteria.

#### `e_match_set : value -> unit`

Set the entity match criteria.

#### `e_make : unit -> entity_obj`

Create a new `Smsdo` entity accessor with the same options.

#### `e_name : string`

The entity name.


---

## Smssendername

```ocaml
let smssendername = Sdk_client.smssendername client Noval
```

### Operations

#### `e_create reqdata ctrl : entity_obj`

Create a new entity with the given data. Resolves to the created entity and raises on error.

```ocaml
let result = (Sdk_client.smssendername client Noval).e_create (jo [
    ("sender", (Str "example_sender"));  (* string *)
]) Noval
let result_data = result.e_data_get ()
```

#### `e_remove reqmatch ctrl : entity_obj`

Remove the entity matching the given criteria. Resolves to the entity, marked as deleted (`e_deleted`); it keeps the data it held. Raises on error.

```ocaml
let result = (Sdk_client.smssendername client Noval).e_remove (jo [("sender", (Str "sender"))]) Noval
let result_data = result.e_data_get ()
```

### Common Fields

#### `e_data_get : unit -> value`

Get the entity data.

#### `e_data_set : value -> unit`

Set the entity data.

#### `e_match_get : unit -> value`

Get the entity match criteria.

#### `e_match_set : value -> unit`

Set the entity match criteria.

#### `e_make : unit -> entity_obj`

Create a new `Smssendername` entity accessor with the same options.

#### `e_name : string`

The entity name.


---

## Smstemplate

```ocaml
let smstemplate = Sdk_client.smstemplate client Noval
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | `string` | No |  |

### Operations

#### `e_remove reqmatch ctrl : entity_obj`

Remove the entity matching the given criteria. Resolves to the entity, marked as deleted (`e_deleted`); it keeps the data it held. Raises on error.

```ocaml
let result = (Sdk_client.smstemplate client Noval).e_remove (jo [("id", (Str "id"))]) Noval
let result_data = result.e_data_get ()
```

### Common Fields

#### `e_data_get : unit -> value`

Get the entity data.

#### `e_data_set : value -> unit`

Set the entity data.

#### `e_match_get : unit -> value`

Get the entity match criteria.

#### `e_match_set : value -> unit`

Set the entity match criteria.

#### `e_make : unit -> entity_obj`

Create a new `Smstemplate` entity accessor with the same options.

#### `e_name : string`

The entity name.


---

## Subuser

```ocaml
let subuser = Sdk_client.subuser client Noval
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `active` | `bool` | No |  |
| `credentials` | `value map` | Yes |  |
| `description` | `string` | No |  |
| `id` | `string` | No | Object ID |
| `points` | `value map` | No |  |
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

#### `e_create reqdata ctrl : entity_obj`

Create a new entity with the given data. Resolves to the created entity and raises on error.

```ocaml
let result = (Sdk_client.subuser client Noval).e_create (jo [
    ("credentials", (empty_map ()));  (* value map *)
]) Noval
let result_data = result.e_data_get ()
```

#### `e_list reqmatch ctrl : entity_obj list`

List entities matching the given criteria. The match is optional — pass `(empty_map ())` to list all records. Resolves to one entity per record and raises on error.

```ocaml
(* One ENTITY per record; the record is reached with e_data_get. *)
let results = (Sdk_client.subuser client Noval).e_list (empty_map ()) Noval in
List.iter (fun e -> print_endline (stringify (e.e_data_get ()))) results
```

#### `e_load reqmatch ctrl : entity_obj`

Load a single entity matching the given criteria. Resolves to the entity, whose record `e_data_get` reads, and raises on error.

```ocaml
let result = (Sdk_client.subuser client Noval).e_load (jo [("id", (Str "subuser_id"))]) Noval
let result_data = result.e_data_get ()
```

#### `e_remove reqmatch ctrl : entity_obj`

Remove the entity matching the given criteria. Resolves to the entity, marked as deleted (`e_deleted`); it keeps the data it held. Raises on error.

```ocaml
let result = (Sdk_client.subuser client Noval).e_remove (jo [("id", (Str "subuser_id"))]) Noval
let result_data = result.e_data_get ()
```

#### `e_update reqdata ctrl : entity_obj`

Update an existing entity. The data must include the entity `id`. Resolves to the updated entity and raises on error.

```ocaml
let result = (Sdk_client.subuser client Noval).e_update (jo [
    ("id", (Str "subuser_id"));
    (* Fields to update *)
]) Noval
let result_data = result.e_data_get ()
```

### Common Fields

#### `e_data_get : unit -> value`

Get the entity data.

#### `e_data_set : value -> unit`

Set the entity data.

#### `e_match_get : unit -> value`

Get the entity match criteria.

#### `e_match_set : value -> unit`

Set the entity match criteria.

#### `e_make : unit -> entity_obj`

Create a new `Subuser` entity accessor with the same options.

#### `e_name : string`

The entity name.


---

## Template

```ocaml
let template = Sdk_client.template client Noval
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | `string` | No |  |
| `name` | `string` | No |  |
| `normalize` | `bool` | No |  |
| `template` | `string` | No |  |

### Operations

#### `e_create reqdata ctrl : entity_obj`

Create a new entity with the given data. Resolves to the created entity and raises on error.

```ocaml
let result = (Sdk_client.template client Noval).e_create (jo [
]) Noval
let result_data = result.e_data_get ()
```

Declares a `application/x-www-form-urlencoded` body, which this SDK does not encode yet: it sends the data as JSON.

#### `e_list reqmatch ctrl : entity_obj list`

List entities matching the given criteria. The match is optional — pass `(empty_map ())` to list all records. Resolves to one entity per record and raises on error.

```ocaml
(* One ENTITY per record; the record is reached with e_data_get. *)
let results = (Sdk_client.template client Noval).e_list (empty_map ()) Noval in
List.iter (fun e -> print_endline (stringify (e.e_data_get ()))) results
```

#### `e_load reqmatch ctrl : entity_obj`

Load a single entity matching the given criteria. Resolves to the entity, whose record `e_data_get` reads, and raises on error.

```ocaml
let result = (Sdk_client.template client Noval).e_load (jo [("id", (Str "template_id"))]) Noval
let result_data = result.e_data_get ()
```

#### `e_update reqdata ctrl : entity_obj`

Update an existing entity. The data must include the entity `id`. Resolves to the updated entity and raises on error.

```ocaml
let result = (Sdk_client.template client Noval).e_update (jo [
    ("id", (Str "template_id"));
    (* Fields to update *)
]) Noval
let result_data = result.e_data_get ()
```

Declares a `application/x-www-form-urlencoded` body, which this SDK does not encode yet: it sends the data as JSON.

### Common Fields

#### `e_data_get : unit -> value`

Get the entity data.

#### `e_data_set : value -> unit`

Set the entity data.

#### `e_match_get : unit -> value`

Get the entity match criteria.

#### `e_match_set : value -> unit`

Set the entity match criteria.

#### `e_make : unit -> entity_obj`

Create a new `Template` entity accessor with the same options.

#### `e_name : string`

The entity name.


---

## UserRcsSenderCollection

```ocaml
let user_rcs_sender_collection = Sdk_client.user_rcs_sender_collection client Noval
```

### Operations

#### `e_list reqmatch ctrl : entity_obj list`

List entities matching the given criteria. The match is optional — pass `(empty_map ())` to list all records. Resolves to one entity per record and raises on error.

```ocaml
(* One ENTITY per record; the record is reached with e_data_get. *)
let results = (Sdk_client.user_rcs_sender_collection client Noval).e_list (empty_map ()) Noval in
List.iter (fun e -> print_endline (stringify (e.e_data_get ()))) results
```

### Common Fields

#### `e_data_get : unit -> value`

Get the entity data.

#### `e_data_set : value -> unit`

Set the entity data.

#### `e_match_get : unit -> value`

Get the entity match criteria.

#### `e_match_set : value -> unit`

Set the entity match criteria.

#### `e_make : unit -> entity_obj`

Create a new `UserRcsSenderCollection` entity accessor with the same options.

#### `e_name : string`

The entity name.


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

```ocaml
let client = Sdk_client.make (jo [
    ("feature", jo [
        ("audit", jo [("active", Bool true)]);
        ("cache", jo [("active", Bool true)]);
        ("clienttrack", jo [("active", Bool true)]);
        ("cost", jo [("active", Bool true)]);
        ("debug", jo [("active", Bool true)]);
        ("idempotency", jo [("active", Bool true)]);
        ("log", jo [("active", Bool true)]);
        ("metrics", jo [("active", Bool true)]);
        ("netsim", jo [("active", Bool true)]);
        ("paging", jo [("active", Bool true)]);
        ("proxy", jo [("active", Bool true)]);
        ("ratelimit", jo [("active", Bool true)]);
        ("rbac", jo [("active", Bool true)]);
        ("retry", jo [("active", Bool true)]);
        ("secrets", jo [("active", Bool true)]);
        ("streaming", jo [("active", Bool true)]);
        ("telemetry", jo [("active", Bool true)]);
        ("test", jo [("active", Bool true)]);
        ("timeout", jo [("active", Bool true)]);
        ("validate", jo [("active", Bool true)]);
    ]);
])
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
| `now` | function |
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

