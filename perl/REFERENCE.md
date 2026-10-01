# Smsapi Perl SDK Reference

Complete API reference for the Smsapi Perl SDK.


## SmsapiSDK

### Constructor

```perl
use lib 'lib';
use SmsapiSDK;

my $client = SmsapiSDK->new($options);
```

Create a new SDK client instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `$options` | `hashref` | SDK configuration options. |
| `$options->{apikey}` | `string` | API key for authentication. |
| `$options->{base}` | `string` | Base URL for API requests. |
| `$options->{prefix}` | `string` | URL prefix appended after base. |
| `$options->{suffix}` | `string` | URL suffix appended after path. |
| `$options->{headers}` | `hashref` | Custom headers for all requests. |
| `$options->{feature}` | `hashref` | Feature configuration. |
| `$options->{system}` | `hashref` | System overrides (e.g. custom fetch). |


### Static Methods

#### `SmsapiSDK->test($testopts, $sdkopts)`

Create a test client with mock features active. Both arguments may be `undef`.

```perl
my $client = SmsapiSDK->test();
```


### Instance Methods

#### `Available($data)`

Create a new `Available` entity instance. Pass `undef` for no initial data.

#### `Blacklist($data)`

Create a new `Blacklist` entity instance. Pass `undef` for no initial data.

#### `Callback($data)`

Create a new `Callback` entity instance. Pass `undef` for no initial data.

#### `Contact($data)`

Create a new `Contact` entity instance. Pass `undef` for no initial data.

#### `ContactsField($data)`

Create a new `ContactsField` entity instance. Pass `undef` for no initial data.

#### `ContactsFieldOption($data)`

Create a new `ContactsFieldOption` entity instance. Pass `undef` for no initial data.

#### `Contactsgroup($data)`

Create a new `Contactsgroup` entity instance. Pass `undef` for no initial data.

#### `Contactstrash($data)`

Create a new `Contactstrash` entity instance. Pass `undef` for no initial data.

#### `FieldAvailable($data)`

Create a new `FieldAvailable` entity instance. Pass `undef` for no initial data.

#### `Group($data)`

Create a new `Group` entity instance. Pass `undef` for no initial data.

#### `MfaCode($data)`

Create a new `MfaCode` entity instance. Pass `undef` for no initial data.

#### `OptOut($data)`

Create a new `OptOut` entity instance. Pass `undef` for no initial data.

#### `OptOutSetting($data)`

Create a new `OptOutSetting` entity instance. Pass `undef` for no initial data.

#### `Permission($data)`

Create a new `Permission` entity instance. Pass `undef` for no initial data.

#### `Ping($data)`

Create a new `Ping` entity instance. Pass `undef` for no initial data.

#### `Profile($data)`

Create a new `Profile` entity instance. Pass `undef` for no initial data.

#### `Rcs($data)`

Create a new `Rcs` entity instance. Pass `undef` for no initial data.

#### `Sendername($data)`

Create a new `Sendername` entity instance. Pass `undef` for no initial data.

#### `SendernameStatement($data)`

Create a new `SendernameStatement` entity instance. Pass `undef` for no initial data.

#### `SentRcsMessage($data)`

Create a new `SentRcsMessage` entity instance. Pass `undef` for no initial data.

#### `ShipmentCountryVolume($data)`

Create a new `ShipmentCountryVolume` entity instance. Pass `undef` for no initial data.

#### `ShortUrl($data)`

Create a new `ShortUrl` entity instance. Pass `undef` for no initial data.

#### `Smsdo($data)`

Create a new `Smsdo` entity instance. Pass `undef` for no initial data.

#### `Smssendername($data)`

Create a new `Smssendername` entity instance. Pass `undef` for no initial data.

#### `Smstemplate($data)`

Create a new `Smstemplate` entity instance. Pass `undef` for no initial data.

#### `Subuser($data)`

Create a new `Subuser` entity instance. Pass `undef` for no initial data.

#### `Template($data)`

Create a new `Template` entity instance. Pass `undef` for no initial data.

#### `UserRcsSenderCollection($data)`

Create a new `UserRcsSenderCollection` entity instance. Pass `undef` for no initial data.

#### `options_map() -> hashref`

Return a deep copy of the current SDK options.

#### `get_utility() -> utility`

Return a copy of the SDK utility object.

#### `direct($fetchargs) -> hashref`

Make a direct HTTP request to any API endpoint. Returns a result `hashref` with `ok`, `status`, `headers`, and `data` (or `err` on failure). This escape hatch never dies — branch on `$result->{ok}`.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `$fetchargs->{path}` | `string` | URL path with optional `{param}` placeholders. |
| `$fetchargs->{method}` | `string` | HTTP method (default: `'GET'`). |
| `$fetchargs->{params}` | `hashref` | Path parameter values. |
| `$fetchargs->{query}` | `hashref` | Query string parameters. |
| `$fetchargs->{headers}` | `hashref` | Request headers (merged with defaults). |
| `$fetchargs->{body}` | `any` | Request body (hashrefs are JSON-serialized). |

**Returns:** `hashref`

#### `prepare($fetchargs) -> hashref`

Prepare a fetch definition without sending. Returns the `fetchdef` and dies on error.


---

## Available entity

```perl
my $available = $client->Available;
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `name` | `string` | No |  |
| `normalize` | `boolean` | No |  |
| `template` | `string` | No |  |

### Operations

#### `list($reqmatch, $ctrl) -> arrayref`

List entities matching the given criteria. The match is optional — call `list` with no argument to list all records. Returns an arrayref and dies on error.

```perl
my $results = $client->Available->list;
for my $available (@$results) {
    print "$available->{id}\n";
}
```

### Common Methods

#### `data_get() -> hashref`

Get the entity data.

#### `data_set($data)`

Set the entity data.

#### `match_get() -> hashref`

Get the entity match criteria.

#### `match_set($match)`

Set the entity match criteria.

#### `make() -> entity`

Create a new `Available` entity instance with the same options.

#### `get_name() -> string`

Return the entity name.


---

## Blacklist entity

```perl
my $blacklist = $client->Blacklist;
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | `string` | No |  |

### Operations

#### `create($reqdata, $ctrl) -> hashref`

Create a new entity with the given data. Returns the created entity data and dies on error.

```perl
my $result = $client->Blacklist->create({
});
```

#### `load($reqmatch, $ctrl) -> hashref`

Load a single entity matching the given criteria. Returns the entity data and dies on error.

```perl
my $result = $client->Blacklist->load();
```

#### `remove($reqmatch, $ctrl) -> hashref`

Remove the entity matching the given criteria. Dies on error.

```perl
my $result = $client->Blacklist->remove({ 'id' => 'id' });
```

### Common Methods

#### `data_get() -> hashref`

Get the entity data.

#### `data_set($data)`

Set the entity data.

#### `match_get() -> hashref`

Get the entity match criteria.

#### `match_set($match)`

Set the entity match criteria.

#### `make() -> entity`

Create a new `Blacklist` entity instance with the same options.

#### `get_name() -> string`

Return the entity name.


---

## Callback entity

```perl
my $callback = $client->Callback;
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `active` | `boolean` | No |  |
| `api_version` | `integer` | No | Version of the callback output format. |
| `id` | `string` | No | Object ID |
| `invalid` | `boolean` | No |  |
| `receiver` | `hashref` | No |  |
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

#### `create($reqdata, $ctrl) -> hashref`

Create a new entity with the given data. Returns the created entity data and dies on error.

```perl
my $result = $client->Callback->create({
});
```

#### `list($reqmatch, $ctrl) -> arrayref`

List entities matching the given criteria. The match is optional — call `list` with no argument to list all records. Returns an arrayref and dies on error.

```perl
my $results = $client->Callback->list;
for my $callback (@$results) {
    print "$callback->{id}\n";
}
```

#### `load($reqmatch, $ctrl) -> hashref`

Load a single entity matching the given criteria. Returns the entity data and dies on error.

```perl
my $result = $client->Callback->load({ 'id' => 'callback_id' });
```

#### `remove($reqmatch, $ctrl) -> hashref`

Remove the entity matching the given criteria. Dies on error.

```perl
my $result = $client->Callback->remove({ 'id' => 'callback_id' });
```

#### `update($reqdata, $ctrl) -> hashref`

Update an existing entity. The data must include the entity `id`. Returns the updated entity data and dies on error.

```perl
my $result = $client->Callback->update({
    'id' => 'callback_id',
    # Fields to update
});
```

### Common Methods

#### `data_get() -> hashref`

Get the entity data.

#### `data_set($data)`

Set the entity data.

#### `match_get() -> hashref`

Get the entity match criteria.

#### `match_set($match)`

Set the entity match criteria.

#### `make() -> entity`

Create a new `Callback` entity instance with the same options.

#### `get_name() -> string`

Return the entity name.


---

## Contact entity

```perl
my $contact = $client->Contact;
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `birthday_date` | `string` | No |  |
| `city` | `string` | No |  |
| `collection` | `arrayref` | Yes |  |
| `contact_expire_after` | `integer` | Yes | Contact expire after days |
| `contacts_count` | `integer` | Yes |  |
| `country` | `string` | No |  |
| `created_by` | `string` | Yes |  |
| `date_created` | `string` | Yes |  |
| `date_updated` | `string` | Yes |  |
| `description` | `string` | No |  |
| `email` | `string` | No |  |
| `first_name` | `string` | No |  |
| `gender` | `string` | Yes |  |
| `group_id` | `string` | No | Object ID |
| `groups` | `arrayref` | Yes |  |
| `id` | `string` | Yes | Object ID |
| `idx` | `string` | No | User provided resource id |
| `last_name` | `string` | No |  |
| `name` | `string` | Yes | Group name |
| `permissions` | `arrayref` | No |  |
| `phone_number` | `string` | No |  |
| `read` | `boolean` | No | Has read permission |
| `send` | `boolean` | No | Has send permission |
| `size` | `integer` | Yes |  |
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

#### `create($reqdata, $ctrl) -> hashref`

Create a new entity with the given data. Returns the created entity data and dies on error.

```perl
my $result = $client->Contact->create({
    'collection' => [],  # arrayref
    'contact_expire_after' => 1,  # integer
    'contacts_count' => 1,  # integer
    'created_by' => 'example_created_by',  # string
    'date_created' => 'example_date_created',  # string
    'date_updated' => 'example_date_updated',  # string
    'gender' => 'example_gender',  # string
    'groups' => [],  # arrayref
    'id' => 'example_id',  # string
    'name' => 'example_name',  # string
    'size' => 1,  # integer
});
```

#### `list($reqmatch, $ctrl) -> arrayref`

List entities matching the given criteria. The match is optional — call `list` with no argument to list all records. Returns an arrayref and dies on error.

```perl
my $results = $client->Contact->list;
for my $contact (@$results) {
    print "$contact->{id}\n";
}
```

#### `load($reqmatch, $ctrl) -> hashref`

Load a single entity matching the given criteria. Returns the entity data and dies on error.

```perl
my $result = $client->Contact->load({ 'id' => 'contact_id' });
```

#### `remove($reqmatch, $ctrl) -> hashref`

Remove the entity matching the given criteria. Dies on error.

```perl
my $result = $client->Contact->remove({ 'id' => 'contact_id' });
```

#### `update($reqdata, $ctrl) -> hashref`

Update an existing entity. The data must include the entity `id`. Returns the updated entity data and dies on error.

```perl
my $result = $client->Contact->update({
    'id' => 'contact_id',
    # Fields to update
});
```

### Common Methods

#### `data_get() -> hashref`

Get the entity data.

#### `data_set($data)`

Set the entity data.

#### `match_get() -> hashref`

Get the entity match criteria.

#### `match_set($match)`

Set the entity match criteria.

#### `make() -> entity`

Create a new `Contact` entity instance with the same options.

#### `get_name() -> string`

Return the entity name.


---

## ContactsField entity

```perl
my $contacts_field = $client->ContactsField;
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `birthday_date` | `string` | No |  |
| `city` | `string` | No |  |
| `contact_expire_after` | `integer` | Yes | Contact expire after days |
| `contacts_count` | `integer` | No |  |
| `country` | `string` | No |  |
| `created_by` | `string` | Yes |  |
| `date_created` | `string` | Yes |  |
| `date_updated` | `string` | Yes |  |
| `description` | `string` | No |  |
| `email` | `string` | No |  |
| `first_name` | `string` | No |  |
| `gender` | `string` | Yes |  |
| `group_id` | `string` | No | Object ID |
| `groups` | `arrayref` | Yes |  |
| `id` | `string` | No | Object ID |
| `idx` | `string` | No | User provided resource id |
| `last_name` | `string` | No |  |
| `name` | `string` | No | Group name |
| `permissions` | `arrayref` | No |  |
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

#### `create($reqdata, $ctrl) -> hashref`

Create a new entity with the given data. Returns the created entity data and dies on error.

```perl
my $result = $client->ContactsField->create({
    'contact_expire_after' => 1,  # integer
    'created_by' => 'example_created_by',  # string
    'date_created' => 'example_date_created',  # string
    'date_updated' => 'example_date_updated',  # string
    'gender' => 'example_gender',  # string
    'groups' => [],  # arrayref
});
```

#### `list($reqmatch, $ctrl) -> arrayref`

List entities matching the given criteria. The match is optional — call `list` with no argument to list all records. Returns an arrayref and dies on error.

```perl
my $results = $client->ContactsField->list;
for my $contacts_field (@$results) {
    print "$contacts_field->{id}\n";
}
```

#### `remove($reqmatch, $ctrl) -> hashref`

Remove the entity matching the given criteria. Dies on error.

```perl
my $result = $client->ContactsField->remove({ 'id' => 'id' });
```

#### `update($reqdata, $ctrl) -> hashref`

Update an existing entity. The data must include the entity `id`. Returns the updated entity data and dies on error.

```perl
my $result = $client->ContactsField->update({
    'id' => 'id',
    # Fields to update
});
```

### Common Methods

#### `data_get() -> hashref`

Get the entity data.

#### `data_set($data)`

Set the entity data.

#### `match_get() -> hashref`

Get the entity match criteria.

#### `match_set($match)`

Set the entity match criteria.

#### `make() -> entity`

Create a new `ContactsField` entity instance with the same options.

#### `get_name() -> string`

Return the entity name.


---

## ContactsFieldOption entity

```perl
my $contacts_field_option = $client->ContactsFieldOption;
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `birthday_date` | `string` | No |  |
| `city` | `string` | No |  |
| `contact_expire_after` | `integer` | Yes | Contact expire after days |
| `contacts_count` | `integer` | No |  |
| `country` | `string` | No |  |
| `created_by` | `string` | Yes |  |
| `date_created` | `string` | Yes |  |
| `date_updated` | `string` | Yes |  |
| `description` | `string` | No |  |
| `email` | `string` | No |  |
| `first_name` | `string` | No |  |
| `gender` | `string` | Yes |  |
| `group_id` | `string` | No | Object ID |
| `groups` | `arrayref` | Yes |  |
| `id` | `string` | Yes | Object ID |
| `idx` | `string` | No | User provided resource id |
| `last_name` | `string` | No |  |
| `name` | `string` | No | Group name |
| `permissions` | `arrayref` | No |  |
| `phone_number` | `string` | No |  |
| `read` | `boolean` | No | Has read permission |
| `send` | `boolean` | No | Has send permission |
| `source` | `string` | No |  |
| `type` | `string` | No |  |
| `username` | `string` | No |  |
| `value` | `string` | No |  |
| `write` | `boolean` | No | Has write permission |

### Operations

#### `list($reqmatch, $ctrl) -> arrayref`

List entities matching the given criteria. The match is optional — call `list` with no argument to list all records. Returns an arrayref and dies on error.

```perl
my $results = $client->ContactsFieldOption->list;
for my $contacts_field_option (@$results) {
    print "$contacts_field_option->{id}\n";
}
```

### Common Methods

#### `data_get() -> hashref`

Get the entity data.

#### `data_set($data)`

Set the entity data.

#### `match_get() -> hashref`

Get the entity match criteria.

#### `match_set($match)`

Set the entity match criteria.

#### `make() -> entity`

Create a new `ContactsFieldOption` entity instance with the same options.

#### `get_name() -> string`

Return the entity name.


---

## Contactsgroup entity

```perl
my $contactsgroup = $client->Contactsgroup;
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `birthday_date` | `string` | No |  |
| `city` | `string` | No |  |
| `contact_expire_after` | `integer` | Yes | Contact expire after days |
| `contacts_count` | `integer` | No |  |
| `country` | `string` | No |  |
| `created_by` | `string` | Yes |  |
| `date_created` | `string` | Yes |  |
| `date_updated` | `string` | Yes |  |
| `description` | `string` | No |  |
| `email` | `string` | No |  |
| `first_name` | `string` | No |  |
| `gender` | `string` | Yes |  |
| `group_id` | `string` | Yes | Object ID |
| `groups` | `arrayref` | Yes |  |
| `id` | `string` | Yes | Object ID |
| `idx` | `string` | No | User provided resource id |
| `last_name` | `string` | No |  |
| `name` | `string` | No | Group name |
| `permissions` | `arrayref` | No |  |
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

#### `create($reqdata, $ctrl) -> hashref`

Create a new entity with the given data. Returns the created entity data and dies on error.

```perl
my $result = $client->Contactsgroup->create({
    'contact_expire_after' => 1,  # integer
    'created_by' => 'example_created_by',  # string
    'date_created' => 'example_date_created',  # string
    'date_updated' => 'example_date_updated',  # string
    'gender' => 'example_gender',  # string
    'group_id' => 'example_group_id',  # string
    'groups' => [],  # arrayref
    'id' => 'example_id',  # string
    'read' => 1,  # boolean
    'send' => 1,  # boolean
    'username' => 'example_username',  # string
    'write' => 1,  # boolean
});
```

#### `list($reqmatch, $ctrl) -> arrayref`

List entities matching the given criteria. The match is optional — call `list` with no argument to list all records. Returns an arrayref and dies on error.

```perl
my $results = $client->Contactsgroup->list;
for my $contactsgroup (@$results) {
    print "$contactsgroup->{id}\n";
}
```

#### `remove($reqmatch, $ctrl) -> hashref`

Remove the entity matching the given criteria. Dies on error.

```perl
my $result = $client->Contactsgroup->remove({ 'group_id' => 'group_id' });
```

#### `update($reqdata, $ctrl) -> hashref`

Update an existing entity. The data must include the entity `id`. Returns the updated entity data and dies on error.

```perl
my $result = $client->Contactsgroup->update({
    'group_id' => 'group_id',
    # Fields to update
});
```

### Common Methods

#### `data_get() -> hashref`

Get the entity data.

#### `data_set($data)`

Set the entity data.

#### `match_get() -> hashref`

Get the entity match criteria.

#### `match_set($match)`

Set the entity match criteria.

#### `make() -> entity`

Create a new `Contactsgroup` entity instance with the same options.

#### `get_name() -> string`

Return the entity name.


---

## Contactstrash entity

```perl
my $contactstrash = $client->Contactstrash;
```

### Operations

#### `remove($reqmatch, $ctrl) -> hashref`

Remove the entity matching the given criteria. Dies on error.

```perl
my $result = $client->Contactstrash->remove();
```

#### `update($reqdata, $ctrl) -> hashref`

Update an existing entity. The data must include the entity `id`. Returns the updated entity data and dies on error.

```perl
my $result = $client->Contactstrash->update({
    # Fields to update
});
```

### Common Methods

#### `data_get() -> hashref`

Get the entity data.

#### `data_set($data)`

Set the entity data.

#### `match_get() -> hashref`

Get the entity match criteria.

#### `match_set($match)`

Set the entity match criteria.

#### `make() -> entity`

Create a new `Contactstrash` entity instance with the same options.

#### `get_name() -> string`

Return the entity name.


---

## FieldAvailable entity

```perl
my $field_available = $client->FieldAvailable;
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `built_in` | `boolean` | No |  |
| `id` | `string` | No | Object ID |
| `name` | `string` | No |  |
| `options` | `arrayref` | No |  |
| `type` | `string` | No |  |

### Operations

#### `list($reqmatch, $ctrl) -> arrayref`

List entities matching the given criteria. The match is optional — call `list` with no argument to list all records. Returns an arrayref and dies on error.

```perl
my $results = $client->FieldAvailable->list;
for my $field_available (@$results) {
    print "$field_available->{id}\n";
}
```

### Common Methods

#### `data_get() -> hashref`

Get the entity data.

#### `data_set($data)`

Set the entity data.

#### `match_get() -> hashref`

Get the entity match criteria.

#### `match_set($match)`

Set the entity match criteria.

#### `make() -> entity`

Create a new `FieldAvailable` entity instance with the same options.

#### `get_name() -> string`

Return the entity name.


---

## Group entity

```perl
my $group = $client->Group;
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `contact_expire_after` | `integer` | Yes | Contact expire after days |
| `contacts_count` | `integer` | Yes |  |
| `created_by` | `string` | Yes |  |
| `date_created` | `string` | Yes |  |
| `date_updated` | `string` | Yes |  |
| `description` | `string` | Yes |  |
| `id` | `string` | Yes | Object ID |
| `idx` | `string` | No | User provided resource id |
| `name` | `string` | Yes | Group name |
| `permissions` | `arrayref` | No |  |

### Operations

#### `load($reqmatch, $ctrl) -> hashref`

Load a single entity matching the given criteria. Returns the entity data and dies on error.

```perl
my $result = $client->Group->load({ 'id' => 'group_id' });
```

#### `update($reqdata, $ctrl) -> hashref`

Update an existing entity. The data must include the entity `id`. Returns the updated entity data and dies on error.

```perl
my $result = $client->Group->update({
    'id' => 'group_id',
    # Fields to update
});
```

### Common Methods

#### `data_get() -> hashref`

Get the entity data.

#### `data_set($data)`

Set the entity data.

#### `match_get() -> hashref`

Get the entity match criteria.

#### `match_set($match)`

Set the entity match criteria.

#### `make() -> entity`

Create a new `Group` entity instance with the same options.

#### `get_name() -> string`

Return the entity name.


---

## MfaCode entity

```perl
my $mfa_code = $client->MfaCode;
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `content` | `string` | No | Custom content that must contain placeholder [%code%] |
| `fast` | `scalar` | No |  |
| `from` | `string` | No | Sendername |
| `phone_number` | `string` | Yes |  |

### Operations

#### `create($reqdata, $ctrl) -> hashref`

Create a new entity with the given data. Returns the created entity data and dies on error.

```perl
my $result = $client->MfaCode->create({
    'phone_number' => 'example_phone_number',  # string
});
```

### Common Methods

#### `data_get() -> hashref`

Get the entity data.

#### `data_set($data)`

Set the entity data.

#### `match_get() -> hashref`

Get the entity match criteria.

#### `match_set($match)`

Set the entity match criteria.

#### `make() -> entity`

Create a new `MfaCode` entity instance with the same options.

#### `get_name() -> string`

Return the entity name.


---

## OptOut entity

```perl
my $opt_out = $client->OptOut;
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `date` | `string` | No |  |
| `id` | `string` | No |  |
| `links` | `arrayref` | No |  |
| `phoneNumber` | `integer` | No |  |

### Operations

#### `list($reqmatch, $ctrl) -> arrayref`

List entities matching the given criteria. The match is optional — call `list` with no argument to list all records. Returns an arrayref and dies on error.

```perl
my $results = $client->OptOut->list;
for my $opt_out (@$results) {
    print "$opt_out->{id}\n";
}
```

#### `remove($reqmatch, $ctrl) -> hashref`

Remove the entity matching the given criteria. Dies on error.

```perl
my $result = $client->OptOut->remove({ 'id' => 'id' });
```

### Common Methods

#### `data_get() -> hashref`

Get the entity data.

#### `data_set($data)`

Set the entity data.

#### `match_get() -> hashref`

Get the entity match criteria.

#### `match_set($match)`

Set the entity match criteria.

#### `make() -> entity`

Create a new `OptOut` entity instance with the same options.

#### `get_name() -> string`

Return the entity name.


---

## OptOutSetting entity

```perl
my $opt_out_setting = $client->OptOutSetting;
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `brand` | `string` | No |  |

### Operations

#### `load($reqmatch, $ctrl) -> hashref`

Load a single entity matching the given criteria. Returns the entity data and dies on error.

```perl
my $result = $client->OptOutSetting->load();
```

#### `update($reqdata, $ctrl) -> hashref`

Update an existing entity. The data must include the entity `id`. Returns the updated entity data and dies on error.

```perl
my $result = $client->OptOutSetting->update({
    # Fields to update
});
```

### Common Methods

#### `data_get() -> hashref`

Get the entity data.

#### `data_set($data)`

Set the entity data.

#### `match_get() -> hashref`

Get the entity match criteria.

#### `match_set($match)`

Set the entity match criteria.

#### `make() -> entity`

Create a new `OptOutSetting` entity instance with the same options.

#### `get_name() -> string`

Return the entity name.


---

## Permission entity

```perl
my $permission = $client->Permission;
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

#### `create($reqdata, $ctrl) -> hashref`

Create a new entity with the given data. Returns the created entity data and dies on error.

```perl
my $result = $client->Permission->create({
    'group_id' => 'example_group_id',  # string
    'read' => 1,  # boolean
    'send' => 1,  # boolean
    'username' => 'example_username',  # string
    'write' => 1,  # boolean
});
```

#### `load($reqmatch, $ctrl) -> hashref`

Load a single entity matching the given criteria. Returns the entity data and dies on error.

```perl
my $result = $client->Permission->load({ 'id' => 'permission_id', 'group_id' => 'group_id', 'username' => 'username' });
```

### Common Methods

#### `data_get() -> hashref`

Get the entity data.

#### `data_set($data)`

Set the entity data.

#### `match_get() -> hashref`

Get the entity match criteria.

#### `match_set($match)`

Set the entity match criteria.

#### `make() -> entity`

Create a new `Permission` entity instance with the same options.

#### `get_name() -> string`

Return the entity name.


---

## Ping entity

```perl
my $ping = $client->Ping;
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `authorized` | `boolean` | Yes |  |
| `unavailable` | `arrayref` | Yes |  |

### Operations

#### `list($reqmatch, $ctrl) -> arrayref`

List entities matching the given criteria. The match is optional — call `list` with no argument to list all records. Returns an arrayref and dies on error.

```perl
my $results = $client->Ping->list;
for my $ping (@$results) {
    print "$ping->{id}\n";
}
```

### Common Methods

#### `data_get() -> hashref`

Get the entity data.

#### `data_set($data)`

Set the entity data.

#### `match_get() -> hashref`

Get the entity match criteria.

#### `match_set($match)`

Set the entity match criteria.

#### `make() -> entity`

Create a new `Ping` entity instance with the same options.

#### `get_name() -> string`

Return the entity name.


---

## Profile entity

```perl
my $profile = $client->Profile;
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `email` | `string` | Yes |  |
| `name` | `string` | Yes |  |
| `payment_type` | `string` | Yes |  |
| `phone_number` | `integer` | Yes |  |
| `points` | `number` | No |  |
| `user_type` | `string` | Yes |  |
| `username` | `string` | Yes |  |

### Operations

#### `list($reqmatch, $ctrl) -> arrayref`

List entities matching the given criteria. The match is optional — call `list` with no argument to list all records. Returns an arrayref and dies on error.

```perl
my $results = $client->Profile->list;
for my $profile (@$results) {
    print "$profile->{id}\n";
}
```

#### `load($reqmatch, $ctrl) -> hashref`

Load a single entity matching the given criteria. Returns the entity data and dies on error.

```perl
my $result = $client->Profile->load();
```

### Common Methods

#### `data_get() -> hashref`

Get the entity data.

#### `data_set($data)`

Set the entity data.

#### `match_get() -> hashref`

Get the entity match criteria.

#### `match_set($match)`

Set the entity match criteria.

#### `make() -> entity`

Create a new `Profile` entity instance with the same options.

#### `get_name() -> string`

Return the entity name.


---

## Rcs entity

```perl
my $rcs = $client->Rcs;
```

### Operations

#### `list($reqmatch, $ctrl) -> arrayref`

List entities matching the given criteria. The match is optional — call `list` with no argument to list all records. Returns an arrayref and dies on error.

```perl
my $results = $client->Rcs->list;
for my $rcs (@$results) {
    print "$rcs->{id}\n";
}
```

### Common Methods

#### `data_get() -> hashref`

Get the entity data.

#### `data_set($data)`

Set the entity data.

#### `match_get() -> hashref`

Get the entity match criteria.

#### `match_set($match)`

Set the entity match criteria.

#### `make() -> entity`

Create a new `Rcs` entity instance with the same options.

#### `get_name() -> string`

Return the entity name.


---

## Sendername entity

```perl
my $sendername = $client->Sendername;
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

#### `create($reqdata, $ctrl) -> hashref`

Create a new entity with the given data. Returns the created entity data and dies on error.

```perl
my $result = $client->Sendername->create({
});
```

#### `list($reqmatch, $ctrl) -> arrayref`

List entities matching the given criteria. The match is optional — call `list` with no argument to list all records. Returns an arrayref and dies on error.

```perl
my $results = $client->Sendername->list;
for my $sendername (@$results) {
    print "$sendername->{id}\n";
}
```

#### `load($reqmatch, $ctrl) -> hashref`

Load a single entity matching the given criteria. Returns the entity data and dies on error.

```perl
my $result = $client->Sendername->load({ 'id' => 'sendername_id' });
```

### Common Methods

#### `data_get() -> hashref`

Get the entity data.

#### `data_set($data)`

Set the entity data.

#### `match_get() -> hashref`

Get the entity match criteria.

#### `match_set($match)`

Set the entity match criteria.

#### `make() -> entity`

Create a new `Sendername` entity instance with the same options.

#### `get_name() -> string`

Return the entity name.


---

## SendernameStatement entity

```perl
my $sendername_statement = $client->SendernameStatement;
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `content` | `string` | No |  |
| `statements` | `arrayref` | No |  |
| `title` | `string` | No |  |

### Operations

#### `list($reqmatch, $ctrl) -> arrayref`

List entities matching the given criteria. The match is optional — call `list` with no argument to list all records. Returns an arrayref and dies on error.

```perl
my $results = $client->SendernameStatement->list;
for my $sendername_statement (@$results) {
    print "$sendername_statement->{id}\n";
}
```

### Common Methods

#### `data_get() -> hashref`

Get the entity data.

#### `data_set($data)`

Set the entity data.

#### `match_get() -> hashref`

Get the entity match criteria.

#### `match_set($match)`

Set the entity match criteria.

#### `make() -> entity`

Create a new `SendernameStatement` entity instance with the same options.

#### `get_name() -> string`

Return the entity name.


---

## SentRcsMessage entity

```perl
my $sent_rcs_message = $client->SentRcsMessage;
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `content` | `hashref` | No | RCS message content in RCS JSON format. |
| `phone_number` | `string` | Yes | Recipient phone number (e.g. |
| `sender` | `scalar` | Yes |  |
| `text` | `string` | No | Plain text message content. |

### Operations

#### `create($reqdata, $ctrl) -> hashref`

Create a new entity with the given data. Returns the created entity data and dies on error.

```perl
my $result = $client->SentRcsMessage->create({
    'phone_number' => 'example_phone_number',  # string
    'sender' => 'example_sender',  # scalar
});
```

### Common Methods

#### `data_get() -> hashref`

Get the entity data.

#### `data_set($data)`

Set the entity data.

#### `match_get() -> hashref`

Get the entity match criteria.

#### `match_set($match)`

Set the entity match criteria.

#### `make() -> entity`

Create a new `SentRcsMessage` entity instance with the same options.

#### `get_name() -> string`

Return the entity name.


---

## ShipmentCountryVolume entity

```perl
my $shipment_country_volume = $client->ShipmentCountryVolume;
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `country_code` | `string` | No |  |
| `country_limit` | `integer` | No |  |
| `country_name` | `string` | No |  |
| `usage` | `integer` | No |  |

### Operations

#### `list($reqmatch, $ctrl) -> arrayref`

List entities matching the given criteria. The match is optional — call `list` with no argument to list all records. Returns an arrayref and dies on error.

```perl
my $results = $client->ShipmentCountryVolume->list;
for my $shipment_country_volume (@$results) {
    print "$shipment_country_volume->{id}\n";
}
```

### Common Methods

#### `data_get() -> hashref`

Get the entity data.

#### `data_set($data)`

Set the entity data.

#### `match_get() -> hashref`

Get the entity match criteria.

#### `match_set($match)`

Set the entity match criteria.

#### `make() -> entity`

Create a new `ShipmentCountryVolume` entity instance with the same options.

#### `get_name() -> string`

Return the entity name.


---

## ShortUrl entity

```perl
my $short_url = $client->ShortUrl;
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `description` | `string` | No |  |
| `expire` | `string` | No |  |
| `filename` | `string` | No |  |
| `hits` | `integer` | No |  |
| `hits_unique` | `integer` | No |  |
| `id` | `string` | No |  |
| `name` | `string` | No |  |
| `short_url` | `string` | No | WHATWG URL compliant |
| `type` | `string` | No |  |
| `url` | `string` | No | WHATWG URL compliant |

### Operations

#### `create($reqdata, $ctrl) -> hashref`

Create a new entity with the given data. Returns the created entity data and dies on error.

```perl
my $result = $client->ShortUrl->create({
});
```

#### `list($reqmatch, $ctrl) -> arrayref`

List entities matching the given criteria. The match is optional — call `list` with no argument to list all records. Returns an arrayref and dies on error.

```perl
my $results = $client->ShortUrl->list;
for my $short_url (@$results) {
    print "$short_url->{id}\n";
}
```

#### `load($reqmatch, $ctrl) -> hashref`

Load a single entity matching the given criteria. Returns the entity data and dies on error.

```perl
my $result = $client->ShortUrl->load({ 'id' => 'short_url_id' });
```

#### `remove($reqmatch, $ctrl) -> hashref`

Remove the entity matching the given criteria. Dies on error.

```perl
my $result = $client->ShortUrl->remove({ 'id' => 'short_url_id' });
```

#### `update($reqdata, $ctrl) -> hashref`

Update an existing entity. The data must include the entity `id`. Returns the updated entity data and dies on error.

```perl
my $result = $client->ShortUrl->update({
    'id' => 'short_url_id',
    # Fields to update
});
```

### Common Methods

#### `data_get() -> hashref`

Get the entity data.

#### `data_set($data)`

Set the entity data.

#### `match_get() -> hashref`

Get the entity match criteria.

#### `match_set($match)`

Set the entity match criteria.

#### `make() -> entity`

Create a new `ShortUrl` entity instance with the same options.

#### `get_name() -> string`

Return the entity name.


---

## Smsdo entity

```perl
my $smsdo = $client->Smsdo;
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `allow_duplicates` | `integer` | No | When parameter allow_duplicates is set to "1" allows to send message to duplicated numbers in one request (useful i.e. |
| `check_idx` | `scalar` | No | When parameter check_idx is set to „1” prevents from sending more than one message with the same idx in last 24h. |
| `date` | `scalar` | No | Date in UNIX timestamp (&date=1287734110) or in ISO 8601 (&date=2012-05-10T08:40:27+00:00) when message will be sent (&date=1287734110). |
| `date_validate` | `integer` | No | When parameter date_validate is set to "1" checks if date if given in proper format. |
| `details` | `scalar` | No | When details parameter is set to "1" more details in response will be displayed (message length and sms count). |
| `encoding` | `string` | No | This parameter describes the encoding of the message text. |
| `expiration_date` | `scalar` | No | Message expiration date (in UNIX timestamp or in ISO 8601) is a date after which message won't be delivered if it wasn't delivered yet. |
| `fallback` | `arrayref` | No | Enable fallback in case sms sending fails |
| `fast` | `integer` | No | Setting this parameter to „1” will result in sending message with the highest priority which ensures the quickest possible time of delivery. |
| `flash` | `integer` | No | Sending a message in flash mode can be activated by setting this parameter to "1". |
| `format` | `string` | No | Parameter &format=json causes, that response is sending in JSON format. |
| `from` | `string` | No | Name of the sender. |
| `group` | `string` | No | Name of the group from the contacts database to which message should be sent to. |
| `idx` | `string` | No | Optional custom value sent with SMS and sent back in CALLBACK. |
| `max_parts` | `integer` | No | Defines maximum message parts allowed, maximum value allowed is 6. |
| `message` | `string` | No | The message text. |
| `normalize` | `integer` | No | When parameter normalize is set to „1” special chars in message will be replaced with their equivalents (ê-e, ñ-n, ý-y ...). |
| `notify_url` | `string` | No | Parameter allows to set CALLBACK URL for message from request. |
| `test` | `scalar` | No | When parameter test is set to "1" message won't be sent but response will be displayed, there is no charge for such test messages. |
| `time_restriction` | `string` | No | Sets the behavior when you try to ship in hours / dates that do not match the settings in your account. |
| `to` | `string` | No | Recipients' mobile phone numbers (i.e. |

### Operations

#### `create($reqdata, $ctrl) -> hashref`

Create a new entity with the given data. Returns the created entity data and dies on error.

```perl
my $result = $client->Smsdo->create({
});
```

### Common Methods

#### `data_get() -> hashref`

Get the entity data.

#### `data_set($data)`

Set the entity data.

#### `match_get() -> hashref`

Get the entity match criteria.

#### `match_set($match)`

Set the entity match criteria.

#### `make() -> entity`

Create a new `Smsdo` entity instance with the same options.

#### `get_name() -> string`

Return the entity name.


---

## Smssendername entity

```perl
my $smssendername = $client->Smssendername;
```

### Operations

#### `create($reqdata, $ctrl) -> hashref`

Create a new entity with the given data. Returns the created entity data and dies on error.

```perl
my $result = $client->Smssendername->create({
    'sendername_id' => 'example_sendername_id',  # string
});
```

#### `remove($reqmatch, $ctrl) -> hashref`

Remove the entity matching the given criteria. Dies on error.

```perl
my $result = $client->Smssendername->remove({ 'sender' => 'sender' });
```

### Common Methods

#### `data_get() -> hashref`

Get the entity data.

#### `data_set($data)`

Set the entity data.

#### `match_get() -> hashref`

Get the entity match criteria.

#### `match_set($match)`

Set the entity match criteria.

#### `make() -> entity`

Create a new `Smssendername` entity instance with the same options.

#### `get_name() -> string`

Return the entity name.


---

## Smstemplate entity

```perl
my $smstemplate = $client->Smstemplate;
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | `string` | No |  |

### Operations

#### `remove($reqmatch, $ctrl) -> hashref`

Remove the entity matching the given criteria. Dies on error.

```perl
my $result = $client->Smstemplate->remove({ 'id' => 'id' });
```

### Common Methods

#### `data_get() -> hashref`

Get the entity data.

#### `data_set($data)`

Set the entity data.

#### `match_get() -> hashref`

Get the entity match criteria.

#### `match_set($match)`

Set the entity match criteria.

#### `make() -> entity`

Create a new `Smstemplate` entity instance with the same options.

#### `get_name() -> string`

Return the entity name.


---

## Subuser entity

```perl
my $subuser = $client->Subuser;
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `active` | `boolean` | No |  |
| `credentials` | `hashref` | Yes |  |
| `description` | `string` | No |  |
| `id` | `string` | No | Object ID |
| `points` | `hashref` | No |  |
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

#### `create($reqdata, $ctrl) -> hashref`

Create a new entity with the given data. Returns the created entity data and dies on error.

```perl
my $result = $client->Subuser->create({
    'credentials' => {},  # hashref
});
```

#### `list($reqmatch, $ctrl) -> arrayref`

List entities matching the given criteria. The match is optional — call `list` with no argument to list all records. Returns an arrayref and dies on error.

```perl
my $results = $client->Subuser->list;
for my $subuser (@$results) {
    print "$subuser->{id}\n";
}
```

#### `load($reqmatch, $ctrl) -> hashref`

Load a single entity matching the given criteria. Returns the entity data and dies on error.

```perl
my $result = $client->Subuser->load({ 'id' => 'subuser_id' });
```

#### `remove($reqmatch, $ctrl) -> hashref`

Remove the entity matching the given criteria. Dies on error.

```perl
my $result = $client->Subuser->remove({ 'id' => 'subuser_id' });
```

#### `update($reqdata, $ctrl) -> hashref`

Update an existing entity. The data must include the entity `id`. Returns the updated entity data and dies on error.

```perl
my $result = $client->Subuser->update({
    'id' => 'subuser_id',
    # Fields to update
});
```

### Common Methods

#### `data_get() -> hashref`

Get the entity data.

#### `data_set($data)`

Set the entity data.

#### `match_get() -> hashref`

Get the entity match criteria.

#### `match_set($match)`

Set the entity match criteria.

#### `make() -> entity`

Create a new `Subuser` entity instance with the same options.

#### `get_name() -> string`

Return the entity name.


---

## Template entity

```perl
my $template = $client->Template;
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | `string` | No |  |
| `name` | `string` | No |  |
| `normalize` | `boolean` | No |  |
| `template` | `string` | No |  |

### Operations

#### `create($reqdata, $ctrl) -> hashref`

Create a new entity with the given data. Returns the created entity data and dies on error.

```perl
my $result = $client->Template->create({
});
```

#### `list($reqmatch, $ctrl) -> arrayref`

List entities matching the given criteria. The match is optional — call `list` with no argument to list all records. Returns an arrayref and dies on error.

```perl
my $results = $client->Template->list;
for my $template (@$results) {
    print "$template->{id}\n";
}
```

#### `load($reqmatch, $ctrl) -> hashref`

Load a single entity matching the given criteria. Returns the entity data and dies on error.

```perl
my $result = $client->Template->load({ 'id' => 'template_id' });
```

#### `update($reqdata, $ctrl) -> hashref`

Update an existing entity. The data must include the entity `id`. Returns the updated entity data and dies on error.

```perl
my $result = $client->Template->update({
    'id' => 'template_id',
    # Fields to update
});
```

### Common Methods

#### `data_get() -> hashref`

Get the entity data.

#### `data_set($data)`

Set the entity data.

#### `match_get() -> hashref`

Get the entity match criteria.

#### `match_set($match)`

Set the entity match criteria.

#### `make() -> entity`

Create a new `Template` entity instance with the same options.

#### `get_name() -> string`

Return the entity name.


---

## UserRcsSenderCollection entity

```perl
my $user_rcs_sender_collection = $client->UserRcsSenderCollection;
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

#### `list($reqmatch, $ctrl) -> arrayref`

List entities matching the given criteria. The match is optional — call `list` with no argument to list all records. Returns an arrayref and dies on error.

```perl
my $results = $client->UserRcsSenderCollection->list;
for my $user_rcs_sender_collection (@$results) {
    print "$user_rcs_sender_collection->{id}\n";
}
```

### Common Methods

#### `data_get() -> hashref`

Get the entity data.

#### `data_set($data)`

Set the entity data.

#### `match_get() -> hashref`

Get the entity match criteria.

#### `match_set($match)`

Set the entity match criteria.

#### `make() -> entity`

Create a new `UserRcsSenderCollection` entity instance with the same options.

#### `get_name() -> string`

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

```perl
my $client = SmsapiSDK->new({
    'feature' => {
        'audit' => { 'active' => 1 },
        'cache' => { 'active' => 1 },
        'clienttrack' => { 'active' => 1 },
        'cost' => { 'active' => 1 },
        'debug' => { 'active' => 1 },
        'idempotency' => { 'active' => 1 },
        'log' => { 'active' => 1 },
        'metrics' => { 'active' => 1 },
        'netsim' => { 'active' => 1 },
        'paging' => { 'active' => 1 },
        'proxy' => { 'active' => 1 },
        'ratelimit' => { 'active' => 1 },
        'rbac' => { 'active' => 1 },
        'retry' => { 'active' => 1 },
        'secrets' => { 'active' => 1 },
        'streaming' => { 'active' => 1 },
        'telemetry' => { 'active' => 1 },
        'test' => { 'active' => 1 },
        'timeout' => { 'active' => 1 },
        'validate' => { 'active' => 1 },
    },
});
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

