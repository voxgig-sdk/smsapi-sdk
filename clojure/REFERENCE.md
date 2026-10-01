# Smsapi Clojure SDK Reference

Complete API reference for the Smsapi Clojure SDK.


## Client

### make-sdk

```clojure
(require '[sdk.api :as api]
         '[voxgig.struct :as vs])

(def client (api/make-sdk options))
```

Create a new SDK client instance. `options` is a `voxgig.struct` map.

**Options:**

| Key | Type | Description |
| --- | --- | --- |
| `apikey` | `string` | API key for authentication. |
| `base` | `string` | Base URL for API requests. |
| `prefix` | `string` | URL prefix appended after base. |
| `suffix` | `string` | URL suffix appended after path. |
| `headers` | `map` | Custom headers for all requests. |
| `feature` | `map` | Feature configuration. |
| `system` | `map` | System overrides (e.g. custom fetch). |


### Test client

#### `(api/test-sdk testopts sdkopts)`

Create a test client with mock features active. Both arguments may be `nil`.

```clojure
(def client (api/test-sdk nil nil))
```


### Client functions

#### `(api/available client data)`

Create a new `Available` entity instance. Pass `nil` for no initial data.

#### `(api/blacklist client data)`

Create a new `Blacklist` entity instance. Pass `nil` for no initial data.

#### `(api/callback client data)`

Create a new `Callback` entity instance. Pass `nil` for no initial data.

#### `(api/contact client data)`

Create a new `Contact` entity instance. Pass `nil` for no initial data.

#### `(api/contacts_field client data)`

Create a new `ContactsField` entity instance. Pass `nil` for no initial data.

#### `(api/contacts_field_option client data)`

Create a new `ContactsFieldOption` entity instance. Pass `nil` for no initial data.

#### `(api/contactsgroup client data)`

Create a new `Contactsgroup` entity instance. Pass `nil` for no initial data.

#### `(api/contactstrash client data)`

Create a new `Contactstrash` entity instance. Pass `nil` for no initial data.

#### `(api/field_available client data)`

Create a new `FieldAvailable` entity instance. Pass `nil` for no initial data.

#### `(api/group client data)`

Create a new `Group` entity instance. Pass `nil` for no initial data.

#### `(api/mfa_code client data)`

Create a new `MfaCode` entity instance. Pass `nil` for no initial data.

#### `(api/opt_out client data)`

Create a new `OptOut` entity instance. Pass `nil` for no initial data.

#### `(api/opt_out_setting client data)`

Create a new `OptOutSetting` entity instance. Pass `nil` for no initial data.

#### `(api/permission client data)`

Create a new `Permission` entity instance. Pass `nil` for no initial data.

#### `(api/ping client data)`

Create a new `Ping` entity instance. Pass `nil` for no initial data.

#### `(api/profile client data)`

Create a new `Profile` entity instance. Pass `nil` for no initial data.

#### `(api/rcs client data)`

Create a new `Rcs` entity instance. Pass `nil` for no initial data.

#### `(api/sendername client data)`

Create a new `Sendername` entity instance. Pass `nil` for no initial data.

#### `(api/sendername_statement client data)`

Create a new `SendernameStatement` entity instance. Pass `nil` for no initial data.

#### `(api/sent_rcs_message client data)`

Create a new `SentRcsMessage` entity instance. Pass `nil` for no initial data.

#### `(api/shipment_country_volume client data)`

Create a new `ShipmentCountryVolume` entity instance. Pass `nil` for no initial data.

#### `(api/short_url client data)`

Create a new `ShortUrl` entity instance. Pass `nil` for no initial data.

#### `(api/smsdo client data)`

Create a new `Smsdo` entity instance. Pass `nil` for no initial data.

#### `(api/smssendername client data)`

Create a new `Smssendername` entity instance. Pass `nil` for no initial data.

#### `(api/smstemplate client data)`

Create a new `Smstemplate` entity instance. Pass `nil` for no initial data.

#### `(api/subuser client data)`

Create a new `Subuser` entity instance. Pass `nil` for no initial data.

#### `(api/template client data)`

Create a new `Template` entity instance. Pass `nil` for no initial data.

#### `(api/user_rcs_sender_collection client data)`

Create a new `UserRcsSenderCollection` entity instance. Pass `nil` for no initial data.

#### `(api/options-map client) -> map`

Return a deep copy of the current SDK options.

#### `(api/get-utility client) -> utility`

Return a copy of the SDK utility object.

#### `(api/direct client fetchargs) -> map`

Make a direct HTTP request to any API endpoint. Returns a result `map` with `ok`, `status`, `headers`, and `data` (or `err` on failure). This escape hatch never raises — branch on `(vs/getprop result "ok")`.

**Fetch args:**

| Key | Type | Description |
| --- | --- | --- |
| `path` | `string` | URL path with optional `{param}` placeholders. |
| `method` | `string` | HTTP method (default: `"GET"`). |
| `params` | `map` | Path parameter values. |
| `query` | `map` | Query string parameters. |
| `headers` | `map` | Request headers (merged with defaults). |
| `body` | `any` | Request body (maps are JSON-serialized). |

**Returns:** a result `map`.

#### `(api/prepare client fetchargs) -> map`

Prepare a fetch definition without sending. Returns the `fetchdef` and raises on error.


---

## Available

```clojure
(require '[sdk.entity.available :as e-available])

(def available (api/available client nil))
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `name` | `string` | No |  |
| `normalize` | `boolean` | No |  |
| `template` | `string` | No |  |

### Operations

#### `(list ent reqmatch ctrl) -> vector`

List entities matching the given criteria. The match is optional — call with `nil` to list all records. Returns a vector and raises on error.

```clojure
(doseq [available (e-available/list (api/available client nil) nil nil)]
  (println available))
```

### Common Members

State accessors are stored on the entity map and called via keyword lookup.

#### `((:data-get ent)) -> map`

Get the entity data.

#### `((:data-set ent) data)`

Set the entity data.

#### `((:match-get ent)) -> map`

Get the entity match criteria.

#### `((:match-set ent) match)`

Set the entity match criteria.

#### `((:make ent)) -> entity`

Create a new `Available` entity instance with the same options.

#### `((:get-name ent)) -> string`

Return the entity name.


---

## Blacklist

```clojure
(require '[sdk.entity.blacklist :as e-blacklist])

(def blacklist (api/blacklist client nil))
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | `string` | No |  |

### Operations

#### `(create ent reqdata ctrl) -> map`

Create a new entity with the given data. Returns the created entity data and raises on error.

```clojure
(def result
  (e-blacklist/create (api/blacklist client nil)
    (vs/jm
      )
    nil))
```

#### `(load ent reqmatch ctrl) -> map`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```clojure
(def result (e-blacklist/load (api/blacklist client nil) nil nil))
```

#### `(remove ent reqmatch ctrl) -> map`

Remove the entity matching the given criteria. Raises on error.

```clojure
(def result (e-blacklist/remove (api/blacklist client nil) (vs/jm "id" "id") nil))
```

### Common Members

State accessors are stored on the entity map and called via keyword lookup.

#### `((:data-get ent)) -> map`

Get the entity data.

#### `((:data-set ent) data)`

Set the entity data.

#### `((:match-get ent)) -> map`

Get the entity match criteria.

#### `((:match-set ent) match)`

Set the entity match criteria.

#### `((:make ent)) -> entity`

Create a new `Blacklist` entity instance with the same options.

#### `((:get-name ent)) -> string`

Return the entity name.


---

## Callback

```clojure
(require '[sdk.entity.callback :as e-callback])

(def callback (api/callback client nil))
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `active` | `boolean` | No |  |
| `api_version` | `long` | No | Version of the callback output format. |
| `id` | `string` | No | Object ID |
| `invalid` | `boolean` | No |  |
| `receiver` | `map` | No |  |
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

#### `(create ent reqdata ctrl) -> map`

Create a new entity with the given data. Returns the created entity data and raises on error.

```clojure
(def result
  (e-callback/create (api/callback client nil)
    (vs/jm
      )
    nil))
```

#### `(list ent reqmatch ctrl) -> vector`

List entities matching the given criteria. The match is optional — call with `nil` to list all records. Returns a vector and raises on error.

```clojure
(doseq [callback (e-callback/list (api/callback client nil) nil nil)]
  (println callback))
```

#### `(load ent reqmatch ctrl) -> map`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```clojure
(def result (e-callback/load (api/callback client nil) (vs/jm "id" "callback_id") nil))
```

#### `(remove ent reqmatch ctrl) -> map`

Remove the entity matching the given criteria. Raises on error.

```clojure
(def result (e-callback/remove (api/callback client nil) (vs/jm "id" "callback_id") nil))
```

#### `(update ent reqdata ctrl) -> map`

Update an existing entity. The data must include the entity `id`. Returns the updated entity data and raises on error.

```clojure
(def result
  (e-callback/update (api/callback client nil)
    (vs/jm
      "id" "callback_id"
      ;; Fields to update
      )
    nil))
```

### Common Members

State accessors are stored on the entity map and called via keyword lookup.

#### `((:data-get ent)) -> map`

Get the entity data.

#### `((:data-set ent) data)`

Set the entity data.

#### `((:match-get ent)) -> map`

Get the entity match criteria.

#### `((:match-set ent) match)`

Set the entity match criteria.

#### `((:make ent)) -> entity`

Create a new `Callback` entity instance with the same options.

#### `((:get-name ent)) -> string`

Return the entity name.


---

## Contact

```clojure
(require '[sdk.entity.contact :as e-contact])

(def contact (api/contact client nil))
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `birthday_date` | `string` | No |  |
| `city` | `string` | No |  |
| `collection` | `vector` | Yes |  |
| `contact_expire_after` | `long` | Yes | Contact expire after days |
| `contacts_count` | `long` | Yes |  |
| `country` | `string` | No |  |
| `created_by` | `string` | Yes |  |
| `date_created` | `string` | Yes |  |
| `date_updated` | `string` | Yes |  |
| `description` | `string` | No |  |
| `email` | `string` | No |  |
| `first_name` | `string` | No |  |
| `gender` | `string` | Yes |  |
| `group_id` | `string` | No | Object ID |
| `groups` | `vector` | Yes |  |
| `id` | `string` | Yes | Object ID |
| `idx` | `string` | No | User provided resource id |
| `last_name` | `string` | No |  |
| `name` | `string` | Yes | Group name |
| `permissions` | `vector` | No |  |
| `phone_number` | `string` | No |  |
| `read` | `boolean` | No | Has read permission |
| `send` | `boolean` | No | Has send permission |
| `size` | `long` | Yes |  |
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

### Operations

#### `(create ent reqdata ctrl) -> map`

Create a new entity with the given data. Returns the created entity data and raises on error.

```clojure
(def result
  (e-contact/create (api/contact client nil)
    (vs/jm
      "collection" (vs/jt)  ;; vector
      "contact_expire_after" 1  ;; long
      "contacts_count" 1  ;; long
      "created_by" "example_created_by"  ;; string
      "date_created" "example_date_created"  ;; string
      "date_updated" "example_date_updated"  ;; string
      "gender" "example_gender"  ;; string
      "groups" (vs/jt)  ;; vector
      "id" "example_id"  ;; string
      "name" "example_name"  ;; string
      "size" 1  ;; long
      )
    nil))
```

#### `(list ent reqmatch ctrl) -> vector`

List entities matching the given criteria. The match is optional — call with `nil` to list all records. Returns a vector and raises on error.

```clojure
(doseq [contact (e-contact/list (api/contact client nil) nil nil)]
  (println contact))
```

#### `(load ent reqmatch ctrl) -> map`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```clojure
(def result (e-contact/load (api/contact client nil) (vs/jm "id" "contact_id") nil))
```

#### `(remove ent reqmatch ctrl) -> map`

Remove the entity matching the given criteria. Raises on error.

```clojure
(def result (e-contact/remove (api/contact client nil) (vs/jm "id" "contact_id") nil))
```

#### `(update ent reqdata ctrl) -> map`

Update an existing entity. The data must include the entity `id`. Returns the updated entity data and raises on error.

```clojure
(def result
  (e-contact/update (api/contact client nil)
    (vs/jm
      "id" "contact_id"
      ;; Fields to update
      )
    nil))
```

### Common Members

State accessors are stored on the entity map and called via keyword lookup.

#### `((:data-get ent)) -> map`

Get the entity data.

#### `((:data-set ent) data)`

Set the entity data.

#### `((:match-get ent)) -> map`

Get the entity match criteria.

#### `((:match-set ent) match)`

Set the entity match criteria.

#### `((:make ent)) -> entity`

Create a new `Contact` entity instance with the same options.

#### `((:get-name ent)) -> string`

Return the entity name.


---

## ContactsField

```clojure
(require '[sdk.entity.contacts_field :as e-contacts_field])

(def contacts_field (api/contacts_field client nil))
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `birthday_date` | `string` | No |  |
| `city` | `string` | No |  |
| `contact_expire_after` | `long` | Yes | Contact expire after days |
| `contacts_count` | `long` | No |  |
| `country` | `string` | No |  |
| `created_by` | `string` | Yes |  |
| `date_created` | `string` | Yes |  |
| `date_updated` | `string` | Yes |  |
| `description` | `string` | No |  |
| `email` | `string` | No |  |
| `first_name` | `string` | No |  |
| `gender` | `string` | Yes |  |
| `group_id` | `string` | No | Object ID |
| `groups` | `vector` | Yes |  |
| `id` | `string` | No | Object ID |
| `idx` | `string` | No | User provided resource id |
| `last_name` | `string` | No |  |
| `name` | `string` | No | Group name |
| `permissions` | `vector` | No |  |
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

#### `(create ent reqdata ctrl) -> map`

Create a new entity with the given data. Returns the created entity data and raises on error.

```clojure
(def result
  (e-contacts_field/create (api/contacts_field client nil)
    (vs/jm
      "contact_expire_after" 1  ;; long
      "created_by" "example_created_by"  ;; string
      "date_created" "example_date_created"  ;; string
      "date_updated" "example_date_updated"  ;; string
      "gender" "example_gender"  ;; string
      "groups" (vs/jt)  ;; vector
      )
    nil))
```

#### `(list ent reqmatch ctrl) -> vector`

List entities matching the given criteria. The match is optional — call with `nil` to list all records. Returns a vector and raises on error.

```clojure
(doseq [contacts_field (e-contacts_field/list (api/contacts_field client nil) nil nil)]
  (println contacts_field))
```

#### `(remove ent reqmatch ctrl) -> map`

Remove the entity matching the given criteria. Raises on error.

```clojure
(def result (e-contacts_field/remove (api/contacts_field client nil) (vs/jm "id" "id") nil))
```

#### `(update ent reqdata ctrl) -> map`

Update an existing entity. The data must include the entity `id`. Returns the updated entity data and raises on error.

```clojure
(def result
  (e-contacts_field/update (api/contacts_field client nil)
    (vs/jm
      "id" "id"
      ;; Fields to update
      )
    nil))
```

### Common Members

State accessors are stored on the entity map and called via keyword lookup.

#### `((:data-get ent)) -> map`

Get the entity data.

#### `((:data-set ent) data)`

Set the entity data.

#### `((:match-get ent)) -> map`

Get the entity match criteria.

#### `((:match-set ent) match)`

Set the entity match criteria.

#### `((:make ent)) -> entity`

Create a new `ContactsField` entity instance with the same options.

#### `((:get-name ent)) -> string`

Return the entity name.


---

## ContactsFieldOption

```clojure
(require '[sdk.entity.contacts_field_option :as e-contacts_field_option])

(def contacts_field_option (api/contacts_field_option client nil))
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `birthday_date` | `string` | No |  |
| `city` | `string` | No |  |
| `contact_expire_after` | `long` | Yes | Contact expire after days |
| `contacts_count` | `long` | No |  |
| `country` | `string` | No |  |
| `created_by` | `string` | Yes |  |
| `date_created` | `string` | Yes |  |
| `date_updated` | `string` | Yes |  |
| `description` | `string` | No |  |
| `email` | `string` | No |  |
| `first_name` | `string` | No |  |
| `gender` | `string` | Yes |  |
| `group_id` | `string` | No | Object ID |
| `groups` | `vector` | Yes |  |
| `id` | `string` | Yes | Object ID |
| `idx` | `string` | No | User provided resource id |
| `last_name` | `string` | No |  |
| `name` | `string` | No | Group name |
| `permissions` | `vector` | No |  |
| `phone_number` | `string` | No |  |
| `read` | `boolean` | No | Has read permission |
| `send` | `boolean` | No | Has send permission |
| `source` | `string` | No |  |
| `type` | `string` | No |  |
| `username` | `string` | No |  |
| `value` | `string` | No |  |
| `write` | `boolean` | No | Has write permission |

### Operations

#### `(list ent reqmatch ctrl) -> vector`

List entities matching the given criteria. The match is optional — call with `nil` to list all records. Returns a vector and raises on error.

```clojure
(doseq [contacts_field_option (e-contacts_field_option/list (api/contacts_field_option client nil) nil nil)]
  (println contacts_field_option))
```

### Common Members

State accessors are stored on the entity map and called via keyword lookup.

#### `((:data-get ent)) -> map`

Get the entity data.

#### `((:data-set ent) data)`

Set the entity data.

#### `((:match-get ent)) -> map`

Get the entity match criteria.

#### `((:match-set ent) match)`

Set the entity match criteria.

#### `((:make ent)) -> entity`

Create a new `ContactsFieldOption` entity instance with the same options.

#### `((:get-name ent)) -> string`

Return the entity name.


---

## Contactsgroup

```clojure
(require '[sdk.entity.contactsgroup :as e-contactsgroup])

(def contactsgroup (api/contactsgroup client nil))
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `birthday_date` | `string` | No |  |
| `city` | `string` | No |  |
| `contact_expire_after` | `long` | Yes | Contact expire after days |
| `contacts_count` | `long` | No |  |
| `country` | `string` | No |  |
| `created_by` | `string` | Yes |  |
| `date_created` | `string` | Yes |  |
| `date_updated` | `string` | Yes |  |
| `description` | `string` | No |  |
| `email` | `string` | No |  |
| `first_name` | `string` | No |  |
| `gender` | `string` | Yes |  |
| `group_id` | `string` | Yes | Object ID |
| `groups` | `vector` | Yes |  |
| `id` | `string` | Yes | Object ID |
| `idx` | `string` | No | User provided resource id |
| `last_name` | `string` | No |  |
| `name` | `string` | No | Group name |
| `permissions` | `vector` | No |  |
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

#### `(create ent reqdata ctrl) -> map`

Create a new entity with the given data. Returns the created entity data and raises on error.

```clojure
(def result
  (e-contactsgroup/create (api/contactsgroup client nil)
    (vs/jm
      "contact_expire_after" 1  ;; long
      "created_by" "example_created_by"  ;; string
      "date_created" "example_date_created"  ;; string
      "date_updated" "example_date_updated"  ;; string
      "gender" "example_gender"  ;; string
      "group_id" "example_group_id"  ;; string
      "groups" (vs/jt)  ;; vector
      "id" "example_id"  ;; string
      "read" true  ;; boolean
      "send" true  ;; boolean
      "username" "example_username"  ;; string
      "write" true  ;; boolean
      )
    nil))
```

#### `(list ent reqmatch ctrl) -> vector`

List entities matching the given criteria. The match is optional — call with `nil` to list all records. Returns a vector and raises on error.

```clojure
(doseq [contactsgroup (e-contactsgroup/list (api/contactsgroup client nil) nil nil)]
  (println contactsgroup))
```

#### `(remove ent reqmatch ctrl) -> map`

Remove the entity matching the given criteria. Raises on error.

```clojure
(def result (e-contactsgroup/remove (api/contactsgroup client nil) (vs/jm "group_id" "group_id") nil))
```

#### `(update ent reqdata ctrl) -> map`

Update an existing entity. The data must include the entity `id`. Returns the updated entity data and raises on error.

```clojure
(def result
  (e-contactsgroup/update (api/contactsgroup client nil)
    (vs/jm
      "group_id" "group_id"
      ;; Fields to update
      )
    nil))
```

### Common Members

State accessors are stored on the entity map and called via keyword lookup.

#### `((:data-get ent)) -> map`

Get the entity data.

#### `((:data-set ent) data)`

Set the entity data.

#### `((:match-get ent)) -> map`

Get the entity match criteria.

#### `((:match-set ent) match)`

Set the entity match criteria.

#### `((:make ent)) -> entity`

Create a new `Contactsgroup` entity instance with the same options.

#### `((:get-name ent)) -> string`

Return the entity name.


---

## Contactstrash

```clojure
(require '[sdk.entity.contactstrash :as e-contactstrash])

(def contactstrash (api/contactstrash client nil))
```

### Operations

#### `(remove ent reqmatch ctrl) -> map`

Remove the entity matching the given criteria. Raises on error.

```clojure
(def result (e-contactstrash/remove (api/contactstrash client nil) nil nil))
```

#### `(update ent reqdata ctrl) -> map`

Update an existing entity. The data must include the entity `id`. Returns the updated entity data and raises on error.

```clojure
(def result
  (e-contactstrash/update (api/contactstrash client nil)
    (vs/jm
      ;; Fields to update
      )
    nil))
```

### Common Members

State accessors are stored on the entity map and called via keyword lookup.

#### `((:data-get ent)) -> map`

Get the entity data.

#### `((:data-set ent) data)`

Set the entity data.

#### `((:match-get ent)) -> map`

Get the entity match criteria.

#### `((:match-set ent) match)`

Set the entity match criteria.

#### `((:make ent)) -> entity`

Create a new `Contactstrash` entity instance with the same options.

#### `((:get-name ent)) -> string`

Return the entity name.


---

## FieldAvailable

```clojure
(require '[sdk.entity.field_available :as e-field_available])

(def field_available (api/field_available client nil))
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `built_in` | `boolean` | No |  |
| `id` | `string` | No | Object ID |
| `name` | `string` | No |  |
| `options` | `vector` | No |  |
| `type` | `string` | No |  |

### Operations

#### `(list ent reqmatch ctrl) -> vector`

List entities matching the given criteria. The match is optional — call with `nil` to list all records. Returns a vector and raises on error.

```clojure
(doseq [field_available (e-field_available/list (api/field_available client nil) nil nil)]
  (println field_available))
```

### Common Members

State accessors are stored on the entity map and called via keyword lookup.

#### `((:data-get ent)) -> map`

Get the entity data.

#### `((:data-set ent) data)`

Set the entity data.

#### `((:match-get ent)) -> map`

Get the entity match criteria.

#### `((:match-set ent) match)`

Set the entity match criteria.

#### `((:make ent)) -> entity`

Create a new `FieldAvailable` entity instance with the same options.

#### `((:get-name ent)) -> string`

Return the entity name.


---

## Group

```clojure
(require '[sdk.entity.group :as e-group])

(def group (api/group client nil))
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `contact_expire_after` | `long` | Yes | Contact expire after days |
| `contacts_count` | `long` | Yes |  |
| `created_by` | `string` | Yes |  |
| `date_created` | `string` | Yes |  |
| `date_updated` | `string` | Yes |  |
| `description` | `string` | Yes |  |
| `id` | `string` | Yes | Object ID |
| `idx` | `string` | No | User provided resource id |
| `name` | `string` | Yes | Group name |
| `permissions` | `vector` | No |  |

### Operations

#### `(load ent reqmatch ctrl) -> map`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```clojure
(def result (e-group/load (api/group client nil) (vs/jm "id" "group_id") nil))
```

#### `(update ent reqdata ctrl) -> map`

Update an existing entity. The data must include the entity `id`. Returns the updated entity data and raises on error.

```clojure
(def result
  (e-group/update (api/group client nil)
    (vs/jm
      "id" "group_id"
      ;; Fields to update
      )
    nil))
```

### Common Members

State accessors are stored on the entity map and called via keyword lookup.

#### `((:data-get ent)) -> map`

Get the entity data.

#### `((:data-set ent) data)`

Set the entity data.

#### `((:match-get ent)) -> map`

Get the entity match criteria.

#### `((:match-set ent) match)`

Set the entity match criteria.

#### `((:make ent)) -> entity`

Create a new `Group` entity instance with the same options.

#### `((:get-name ent)) -> string`

Return the entity name.


---

## MfaCode

```clojure
(require '[sdk.entity.mfa_code :as e-mfa_code])

(def mfa_code (api/mfa_code client nil))
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `content` | `string` | No | Custom content that must contain placeholder [%code%] |
| `fast` | `any` | No |  |
| `from` | `string` | No | Sendername |
| `phone_number` | `string` | Yes |  |

### Operations

#### `(create ent reqdata ctrl) -> map`

Create a new entity with the given data. Returns the created entity data and raises on error.

```clojure
(def result
  (e-mfa_code/create (api/mfa_code client nil)
    (vs/jm
      "phone_number" "example_phone_number"  ;; string
      )
    nil))
```

### Common Members

State accessors are stored on the entity map and called via keyword lookup.

#### `((:data-get ent)) -> map`

Get the entity data.

#### `((:data-set ent) data)`

Set the entity data.

#### `((:match-get ent)) -> map`

Get the entity match criteria.

#### `((:match-set ent) match)`

Set the entity match criteria.

#### `((:make ent)) -> entity`

Create a new `MfaCode` entity instance with the same options.

#### `((:get-name ent)) -> string`

Return the entity name.


---

## OptOut

```clojure
(require '[sdk.entity.opt_out :as e-opt_out])

(def opt_out (api/opt_out client nil))
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `date` | `string` | No |  |
| `id` | `string` | No |  |
| `links` | `vector` | No |  |
| `phoneNumber` | `long` | No |  |

### Operations

#### `(list ent reqmatch ctrl) -> vector`

List entities matching the given criteria. The match is optional — call with `nil` to list all records. Returns a vector and raises on error.

```clojure
(doseq [opt_out (e-opt_out/list (api/opt_out client nil) nil nil)]
  (println opt_out))
```

#### `(remove ent reqmatch ctrl) -> map`

Remove the entity matching the given criteria. Raises on error.

```clojure
(def result (e-opt_out/remove (api/opt_out client nil) (vs/jm "id" "id") nil))
```

### Common Members

State accessors are stored on the entity map and called via keyword lookup.

#### `((:data-get ent)) -> map`

Get the entity data.

#### `((:data-set ent) data)`

Set the entity data.

#### `((:match-get ent)) -> map`

Get the entity match criteria.

#### `((:match-set ent) match)`

Set the entity match criteria.

#### `((:make ent)) -> entity`

Create a new `OptOut` entity instance with the same options.

#### `((:get-name ent)) -> string`

Return the entity name.


---

## OptOutSetting

```clojure
(require '[sdk.entity.opt_out_setting :as e-opt_out_setting])

(def opt_out_setting (api/opt_out_setting client nil))
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `brand` | `string` | No |  |

### Operations

#### `(load ent reqmatch ctrl) -> map`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```clojure
(def result (e-opt_out_setting/load (api/opt_out_setting client nil) nil nil))
```

#### `(update ent reqdata ctrl) -> map`

Update an existing entity. The data must include the entity `id`. Returns the updated entity data and raises on error.

```clojure
(def result
  (e-opt_out_setting/update (api/opt_out_setting client nil)
    (vs/jm
      ;; Fields to update
      )
    nil))
```

### Common Members

State accessors are stored on the entity map and called via keyword lookup.

#### `((:data-get ent)) -> map`

Get the entity data.

#### `((:data-set ent) data)`

Set the entity data.

#### `((:match-get ent)) -> map`

Get the entity match criteria.

#### `((:match-set ent) match)`

Set the entity match criteria.

#### `((:make ent)) -> entity`

Create a new `OptOutSetting` entity instance with the same options.

#### `((:get-name ent)) -> string`

Return the entity name.


---

## Permission

```clojure
(require '[sdk.entity.permission :as e-permission])

(def permission (api/permission client nil))
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

#### `(create ent reqdata ctrl) -> map`

Create a new entity with the given data. Returns the created entity data and raises on error.

```clojure
(def result
  (e-permission/create (api/permission client nil)
    (vs/jm
      "group_id" "example_group_id"  ;; string
      "read" true  ;; boolean
      "send" true  ;; boolean
      "username" "example_username"  ;; string
      "write" true  ;; boolean
      )
    nil))
```

#### `(load ent reqmatch ctrl) -> map`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```clojure
(def result (e-permission/load (api/permission client nil) (vs/jm "id" "permission_id" "group_id" "group_id" "username" "username") nil))
```

### Common Members

State accessors are stored on the entity map and called via keyword lookup.

#### `((:data-get ent)) -> map`

Get the entity data.

#### `((:data-set ent) data)`

Set the entity data.

#### `((:match-get ent)) -> map`

Get the entity match criteria.

#### `((:match-set ent) match)`

Set the entity match criteria.

#### `((:make ent)) -> entity`

Create a new `Permission` entity instance with the same options.

#### `((:get-name ent)) -> string`

Return the entity name.


---

## Ping

```clojure
(require '[sdk.entity.ping :as e-ping])

(def ping (api/ping client nil))
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `authorized` | `boolean` | Yes |  |
| `unavailable` | `vector` | Yes |  |

### Operations

#### `(list ent reqmatch ctrl) -> vector`

List entities matching the given criteria. The match is optional — call with `nil` to list all records. Returns a vector and raises on error.

```clojure
(doseq [ping (e-ping/list (api/ping client nil) nil nil)]
  (println ping))
```

### Common Members

State accessors are stored on the entity map and called via keyword lookup.

#### `((:data-get ent)) -> map`

Get the entity data.

#### `((:data-set ent) data)`

Set the entity data.

#### `((:match-get ent)) -> map`

Get the entity match criteria.

#### `((:match-set ent) match)`

Set the entity match criteria.

#### `((:make ent)) -> entity`

Create a new `Ping` entity instance with the same options.

#### `((:get-name ent)) -> string`

Return the entity name.


---

## Profile

```clojure
(require '[sdk.entity.profile :as e-profile])

(def profile (api/profile client nil))
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `email` | `string` | Yes |  |
| `name` | `string` | Yes |  |
| `payment_type` | `string` | Yes |  |
| `phone_number` | `long` | Yes |  |
| `points` | `double` | No |  |
| `user_type` | `string` | Yes |  |
| `username` | `string` | Yes |  |

### Operations

#### `(list ent reqmatch ctrl) -> vector`

List entities matching the given criteria. The match is optional — call with `nil` to list all records. Returns a vector and raises on error.

```clojure
(doseq [profile (e-profile/list (api/profile client nil) nil nil)]
  (println profile))
```

#### `(load ent reqmatch ctrl) -> map`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```clojure
(def result (e-profile/load (api/profile client nil) nil nil))
```

### Common Members

State accessors are stored on the entity map and called via keyword lookup.

#### `((:data-get ent)) -> map`

Get the entity data.

#### `((:data-set ent) data)`

Set the entity data.

#### `((:match-get ent)) -> map`

Get the entity match criteria.

#### `((:match-set ent) match)`

Set the entity match criteria.

#### `((:make ent)) -> entity`

Create a new `Profile` entity instance with the same options.

#### `((:get-name ent)) -> string`

Return the entity name.


---

## Rcs

```clojure
(require '[sdk.entity.rcs :as e-rcs])

(def rcs (api/rcs client nil))
```

### Operations

#### `(list ent reqmatch ctrl) -> vector`

List entities matching the given criteria. The match is optional — call with `nil` to list all records. Returns a vector and raises on error.

```clojure
(doseq [rcs (e-rcs/list (api/rcs client nil) nil nil)]
  (println rcs))
```

### Common Members

State accessors are stored on the entity map and called via keyword lookup.

#### `((:data-get ent)) -> map`

Get the entity data.

#### `((:data-set ent) data)`

Set the entity data.

#### `((:match-get ent)) -> map`

Get the entity match criteria.

#### `((:match-set ent) match)`

Set the entity match criteria.

#### `((:make ent)) -> entity`

Create a new `Rcs` entity instance with the same options.

#### `((:get-name ent)) -> string`

Return the entity name.


---

## Sendername

```clojure
(require '[sdk.entity.sendername :as e-sendername])

(def sendername (api/sendername client nil))
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

#### `(create ent reqdata ctrl) -> map`

Create a new entity with the given data. Returns the created entity data and raises on error.

```clojure
(def result
  (e-sendername/create (api/sendername client nil)
    (vs/jm
      )
    nil))
```

#### `(list ent reqmatch ctrl) -> vector`

List entities matching the given criteria. The match is optional — call with `nil` to list all records. Returns a vector and raises on error.

```clojure
(doseq [sendername (e-sendername/list (api/sendername client nil) nil nil)]
  (println sendername))
```

#### `(load ent reqmatch ctrl) -> map`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```clojure
(def result (e-sendername/load (api/sendername client nil) (vs/jm "id" "sendername_id") nil))
```

### Common Members

State accessors are stored on the entity map and called via keyword lookup.

#### `((:data-get ent)) -> map`

Get the entity data.

#### `((:data-set ent) data)`

Set the entity data.

#### `((:match-get ent)) -> map`

Get the entity match criteria.

#### `((:match-set ent) match)`

Set the entity match criteria.

#### `((:make ent)) -> entity`

Create a new `Sendername` entity instance with the same options.

#### `((:get-name ent)) -> string`

Return the entity name.


---

## SendernameStatement

```clojure
(require '[sdk.entity.sendername_statement :as e-sendername_statement])

(def sendername_statement (api/sendername_statement client nil))
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `content` | `string` | No |  |
| `statements` | `vector` | No |  |
| `title` | `string` | No |  |

### Operations

#### `(list ent reqmatch ctrl) -> vector`

List entities matching the given criteria. The match is optional — call with `nil` to list all records. Returns a vector and raises on error.

```clojure
(doseq [sendername_statement (e-sendername_statement/list (api/sendername_statement client nil) nil nil)]
  (println sendername_statement))
```

### Common Members

State accessors are stored on the entity map and called via keyword lookup.

#### `((:data-get ent)) -> map`

Get the entity data.

#### `((:data-set ent) data)`

Set the entity data.

#### `((:match-get ent)) -> map`

Get the entity match criteria.

#### `((:match-set ent) match)`

Set the entity match criteria.

#### `((:make ent)) -> entity`

Create a new `SendernameStatement` entity instance with the same options.

#### `((:get-name ent)) -> string`

Return the entity name.


---

## SentRcsMessage

```clojure
(require '[sdk.entity.sent_rcs_message :as e-sent_rcs_message])

(def sent_rcs_message (api/sent_rcs_message client nil))
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `content` | `map` | No | RCS message content in RCS JSON format. |
| `phone_number` | `string` | Yes | Recipient phone number (e.g. |
| `sender` | `any` | Yes |  |
| `text` | `string` | No | Plain text message content. |

### Operations

#### `(create ent reqdata ctrl) -> map`

Create a new entity with the given data. Returns the created entity data and raises on error.

```clojure
(def result
  (e-sent_rcs_message/create (api/sent_rcs_message client nil)
    (vs/jm
      "phone_number" "example_phone_number"  ;; string
      "sender" "example_sender"  ;; any
      )
    nil))
```

### Common Members

State accessors are stored on the entity map and called via keyword lookup.

#### `((:data-get ent)) -> map`

Get the entity data.

#### `((:data-set ent) data)`

Set the entity data.

#### `((:match-get ent)) -> map`

Get the entity match criteria.

#### `((:match-set ent) match)`

Set the entity match criteria.

#### `((:make ent)) -> entity`

Create a new `SentRcsMessage` entity instance with the same options.

#### `((:get-name ent)) -> string`

Return the entity name.


---

## ShipmentCountryVolume

```clojure
(require '[sdk.entity.shipment_country_volume :as e-shipment_country_volume])

(def shipment_country_volume (api/shipment_country_volume client nil))
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `country_code` | `string` | No |  |
| `country_limit` | `long` | No |  |
| `country_name` | `string` | No |  |
| `usage` | `long` | No |  |

### Operations

#### `(list ent reqmatch ctrl) -> vector`

List entities matching the given criteria. The match is optional — call with `nil` to list all records. Returns a vector and raises on error.

```clojure
(doseq [shipment_country_volume (e-shipment_country_volume/list (api/shipment_country_volume client nil) nil nil)]
  (println shipment_country_volume))
```

### Common Members

State accessors are stored on the entity map and called via keyword lookup.

#### `((:data-get ent)) -> map`

Get the entity data.

#### `((:data-set ent) data)`

Set the entity data.

#### `((:match-get ent)) -> map`

Get the entity match criteria.

#### `((:match-set ent) match)`

Set the entity match criteria.

#### `((:make ent)) -> entity`

Create a new `ShipmentCountryVolume` entity instance with the same options.

#### `((:get-name ent)) -> string`

Return the entity name.


---

## ShortUrl

```clojure
(require '[sdk.entity.short_url :as e-short_url])

(def short_url (api/short_url client nil))
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `description` | `string` | No |  |
| `expire` | `string` | No |  |
| `filename` | `string` | No |  |
| `hits` | `long` | No |  |
| `hits_unique` | `long` | No |  |
| `id` | `string` | No |  |
| `name` | `string` | No |  |
| `short_url` | `string` | No | WHATWG URL compliant |
| `type` | `string` | No |  |
| `url` | `string` | No | WHATWG URL compliant |

### Operations

#### `(create ent reqdata ctrl) -> map`

Create a new entity with the given data. Returns the created entity data and raises on error.

```clojure
(def result
  (e-short_url/create (api/short_url client nil)
    (vs/jm
      )
    nil))
```

#### `(list ent reqmatch ctrl) -> vector`

List entities matching the given criteria. The match is optional — call with `nil` to list all records. Returns a vector and raises on error.

```clojure
(doseq [short_url (e-short_url/list (api/short_url client nil) nil nil)]
  (println short_url))
```

#### `(load ent reqmatch ctrl) -> map`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```clojure
(def result (e-short_url/load (api/short_url client nil) (vs/jm "id" "short_url_id") nil))
```

#### `(remove ent reqmatch ctrl) -> map`

Remove the entity matching the given criteria. Raises on error.

```clojure
(def result (e-short_url/remove (api/short_url client nil) (vs/jm "id" "short_url_id") nil))
```

#### `(update ent reqdata ctrl) -> map`

Update an existing entity. The data must include the entity `id`. Returns the updated entity data and raises on error.

```clojure
(def result
  (e-short_url/update (api/short_url client nil)
    (vs/jm
      "id" "short_url_id"
      ;; Fields to update
      )
    nil))
```

### Common Members

State accessors are stored on the entity map and called via keyword lookup.

#### `((:data-get ent)) -> map`

Get the entity data.

#### `((:data-set ent) data)`

Set the entity data.

#### `((:match-get ent)) -> map`

Get the entity match criteria.

#### `((:match-set ent) match)`

Set the entity match criteria.

#### `((:make ent)) -> entity`

Create a new `ShortUrl` entity instance with the same options.

#### `((:get-name ent)) -> string`

Return the entity name.


---

## Smsdo

```clojure
(require '[sdk.entity.smsdo :as e-smsdo])

(def smsdo (api/smsdo client nil))
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `allow_duplicates` | `long` | No | When parameter allow_duplicates is set to "1" allows to send message to duplicated numbers in one request (useful i.e. |
| `check_idx` | `any` | No | When parameter check_idx is set to „1” prevents from sending more than one message with the same idx in last 24h. |
| `date` | `any` | No | Date in UNIX timestamp (&date=1287734110) or in ISO 8601 (&date=2012-05-10T08:40:27+00:00) when message will be sent (&date=1287734110). |
| `date_validate` | `long` | No | When parameter date_validate is set to "1" checks if date if given in proper format. |
| `details` | `any` | No | When details parameter is set to "1" more details in response will be displayed (message length and sms count). |
| `encoding` | `string` | No | This parameter describes the encoding of the message text. |
| `expiration_date` | `any` | No | Message expiration date (in UNIX timestamp or in ISO 8601) is a date after which message won't be delivered if it wasn't delivered yet. |
| `fallback` | `vector` | No | Enable fallback in case sms sending fails |
| `fast` | `long` | No | Setting this parameter to „1” will result in sending message with the highest priority which ensures the quickest possible time of delivery. |
| `flash` | `long` | No | Sending a message in flash mode can be activated by setting this parameter to "1". |
| `format` | `string` | No | Parameter &format=json causes, that response is sending in JSON format. |
| `from` | `string` | No | Name of the sender. |
| `group` | `string` | No | Name of the group from the contacts database to which message should be sent to. |
| `idx` | `string` | No | Optional custom value sent with SMS and sent back in CALLBACK. |
| `max_parts` | `long` | No | Defines maximum message parts allowed, maximum value allowed is 6. |
| `message` | `string` | No | The message text. |
| `normalize` | `long` | No | When parameter normalize is set to „1” special chars in message will be replaced with their equivalents (ê-e, ñ-n, ý-y ...). |
| `notify_url` | `string` | No | Parameter allows to set CALLBACK URL for message from request. |
| `test` | `any` | No | When parameter test is set to "1" message won't be sent but response will be displayed, there is no charge for such test messages. |
| `time_restriction` | `string` | No | Sets the behavior when you try to ship in hours / dates that do not match the settings in your account. |
| `to` | `string` | No | Recipients' mobile phone numbers (i.e. |

### Operations

#### `(create ent reqdata ctrl) -> map`

Create a new entity with the given data. Returns the created entity data and raises on error.

```clojure
(def result
  (e-smsdo/create (api/smsdo client nil)
    (vs/jm
      )
    nil))
```

### Common Members

State accessors are stored on the entity map and called via keyword lookup.

#### `((:data-get ent)) -> map`

Get the entity data.

#### `((:data-set ent) data)`

Set the entity data.

#### `((:match-get ent)) -> map`

Get the entity match criteria.

#### `((:match-set ent) match)`

Set the entity match criteria.

#### `((:make ent)) -> entity`

Create a new `Smsdo` entity instance with the same options.

#### `((:get-name ent)) -> string`

Return the entity name.


---

## Smssendername

```clojure
(require '[sdk.entity.smssendername :as e-smssendername])

(def smssendername (api/smssendername client nil))
```

### Operations

#### `(create ent reqdata ctrl) -> map`

Create a new entity with the given data. Returns the created entity data and raises on error.

```clojure
(def result
  (e-smssendername/create (api/smssendername client nil)
    (vs/jm
      "sendername_id" "example_sendername_id"  ;; string
      )
    nil))
```

#### `(remove ent reqmatch ctrl) -> map`

Remove the entity matching the given criteria. Raises on error.

```clojure
(def result (e-smssendername/remove (api/smssendername client nil) (vs/jm "sender" "sender") nil))
```

### Common Members

State accessors are stored on the entity map and called via keyword lookup.

#### `((:data-get ent)) -> map`

Get the entity data.

#### `((:data-set ent) data)`

Set the entity data.

#### `((:match-get ent)) -> map`

Get the entity match criteria.

#### `((:match-set ent) match)`

Set the entity match criteria.

#### `((:make ent)) -> entity`

Create a new `Smssendername` entity instance with the same options.

#### `((:get-name ent)) -> string`

Return the entity name.


---

## Smstemplate

```clojure
(require '[sdk.entity.smstemplate :as e-smstemplate])

(def smstemplate (api/smstemplate client nil))
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | `string` | No |  |

### Operations

#### `(remove ent reqmatch ctrl) -> map`

Remove the entity matching the given criteria. Raises on error.

```clojure
(def result (e-smstemplate/remove (api/smstemplate client nil) (vs/jm "id" "id") nil))
```

### Common Members

State accessors are stored on the entity map and called via keyword lookup.

#### `((:data-get ent)) -> map`

Get the entity data.

#### `((:data-set ent) data)`

Set the entity data.

#### `((:match-get ent)) -> map`

Get the entity match criteria.

#### `((:match-set ent) match)`

Set the entity match criteria.

#### `((:make ent)) -> entity`

Create a new `Smstemplate` entity instance with the same options.

#### `((:get-name ent)) -> string`

Return the entity name.


---

## Subuser

```clojure
(require '[sdk.entity.subuser :as e-subuser])

(def subuser (api/subuser client nil))
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `active` | `boolean` | No |  |
| `credentials` | `map` | Yes |  |
| `description` | `string` | No |  |
| `id` | `string` | No | Object ID |
| `points` | `map` | No |  |
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

#### `(create ent reqdata ctrl) -> map`

Create a new entity with the given data. Returns the created entity data and raises on error.

```clojure
(def result
  (e-subuser/create (api/subuser client nil)
    (vs/jm
      "credentials" (vs/jm)  ;; map
      )
    nil))
```

#### `(list ent reqmatch ctrl) -> vector`

List entities matching the given criteria. The match is optional — call with `nil` to list all records. Returns a vector and raises on error.

```clojure
(doseq [subuser (e-subuser/list (api/subuser client nil) nil nil)]
  (println subuser))
```

#### `(load ent reqmatch ctrl) -> map`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```clojure
(def result (e-subuser/load (api/subuser client nil) (vs/jm "id" "subuser_id") nil))
```

#### `(remove ent reqmatch ctrl) -> map`

Remove the entity matching the given criteria. Raises on error.

```clojure
(def result (e-subuser/remove (api/subuser client nil) (vs/jm "id" "subuser_id") nil))
```

#### `(update ent reqdata ctrl) -> map`

Update an existing entity. The data must include the entity `id`. Returns the updated entity data and raises on error.

```clojure
(def result
  (e-subuser/update (api/subuser client nil)
    (vs/jm
      "id" "subuser_id"
      ;; Fields to update
      )
    nil))
```

### Common Members

State accessors are stored on the entity map and called via keyword lookup.

#### `((:data-get ent)) -> map`

Get the entity data.

#### `((:data-set ent) data)`

Set the entity data.

#### `((:match-get ent)) -> map`

Get the entity match criteria.

#### `((:match-set ent) match)`

Set the entity match criteria.

#### `((:make ent)) -> entity`

Create a new `Subuser` entity instance with the same options.

#### `((:get-name ent)) -> string`

Return the entity name.


---

## Template

```clojure
(require '[sdk.entity.template :as e-template])

(def template (api/template client nil))
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | `string` | No |  |
| `name` | `string` | No |  |
| `normalize` | `boolean` | No |  |
| `template` | `string` | No |  |

### Operations

#### `(create ent reqdata ctrl) -> map`

Create a new entity with the given data. Returns the created entity data and raises on error.

```clojure
(def result
  (e-template/create (api/template client nil)
    (vs/jm
      )
    nil))
```

#### `(list ent reqmatch ctrl) -> vector`

List entities matching the given criteria. The match is optional — call with `nil` to list all records. Returns a vector and raises on error.

```clojure
(doseq [template (e-template/list (api/template client nil) nil nil)]
  (println template))
```

#### `(load ent reqmatch ctrl) -> map`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```clojure
(def result (e-template/load (api/template client nil) (vs/jm "id" "template_id") nil))
```

#### `(update ent reqdata ctrl) -> map`

Update an existing entity. The data must include the entity `id`. Returns the updated entity data and raises on error.

```clojure
(def result
  (e-template/update (api/template client nil)
    (vs/jm
      "id" "template_id"
      ;; Fields to update
      )
    nil))
```

### Common Members

State accessors are stored on the entity map and called via keyword lookup.

#### `((:data-get ent)) -> map`

Get the entity data.

#### `((:data-set ent) data)`

Set the entity data.

#### `((:match-get ent)) -> map`

Get the entity match criteria.

#### `((:match-set ent) match)`

Set the entity match criteria.

#### `((:make ent)) -> entity`

Create a new `Template` entity instance with the same options.

#### `((:get-name ent)) -> string`

Return the entity name.


---

## UserRcsSenderCollection

```clojure
(require '[sdk.entity.user_rcs_sender_collection :as e-user_rcs_sender_collection])

(def user_rcs_sender_collection (api/user_rcs_sender_collection client nil))
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

#### `(list ent reqmatch ctrl) -> vector`

List entities matching the given criteria. The match is optional — call with `nil` to list all records. Returns a vector and raises on error.

```clojure
(doseq [user_rcs_sender_collection (e-user_rcs_sender_collection/list (api/user_rcs_sender_collection client nil) nil nil)]
  (println user_rcs_sender_collection))
```

### Common Members

State accessors are stored on the entity map and called via keyword lookup.

#### `((:data-get ent)) -> map`

Get the entity data.

#### `((:data-set ent) data)`

Set the entity data.

#### `((:match-get ent)) -> map`

Get the entity match criteria.

#### `((:match-set ent) match)`

Set the entity match criteria.

#### `((:make ent)) -> entity`

Create a new `UserRcsSenderCollection` entity instance with the same options.

#### `((:get-name ent)) -> string`

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

```clojure
(def client
  (api/make-sdk
    (vs/jm "feature"
      (vs/jm
        "audit" (vs/jm "active" true)
        "cache" (vs/jm "active" true)
        "clienttrack" (vs/jm "active" true)
        "cost" (vs/jm "active" true)
        "debug" (vs/jm "active" true)
        "idempotency" (vs/jm "active" true)
        "log" (vs/jm "active" true)
        "metrics" (vs/jm "active" true)
        "netsim" (vs/jm "active" true)
        "paging" (vs/jm "active" true)
        "proxy" (vs/jm "active" true)
        "ratelimit" (vs/jm "active" true)
        "rbac" (vs/jm "active" true)
        "retry" (vs/jm "active" true)
        "secrets" (vs/jm "active" true)
        "streaming" (vs/jm "active" true)
        "telemetry" (vs/jm "active" true)
        "test" (vs/jm "active" true)
        "timeout" (vs/jm "active" true)
        "validate" (vs/jm "active" true)
        ))))
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

