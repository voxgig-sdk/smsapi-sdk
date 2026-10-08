# Smsapi Zig SDK Reference

Complete API reference for the Smsapi Zig SDK.


## SmsapiSDK

### Constructor

```zig
const sdk = @import("sdk");
const h = sdk.h;

const client = sdk.SmsapiSDK.new(options);
```

Create a new SDK client instance. `options` is a `Value` map
(`h.vnull()` for none).

**Parameters:**

| Key | Value type | Description |
| --- | --- | --- |
| `apikey` | `string` | API key for authentication. |
| `base` | `string` | Base URL for API requests. |
| `prefix` | `string` | URL prefix appended after base. |
| `suffix` | `string` | URL suffix appended after path. |
| `headers` | `map` | Custom headers for all requests. |
| `feature` | `map` | Feature configuration. |
| `system` | `map` | System overrides. |


### Static Functions

#### `test_sdk(testopts: Value, sdkopts: Value) *SmsapiSDK`

Create a test client with mock features active. Both arguments may be
`h.vnull()`.

```zig
const client = sdk.test_sdk(h.vnull(), h.vnull());
```


### Instance Methods

#### `available(entopts: Value) *AvailableEntity`

Create a new `AvailableEntity` instance. Pass `h.vnull()` for no
initial options.

#### `blacklist(entopts: Value) *BlacklistEntity`

Create a new `BlacklistEntity` instance. Pass `h.vnull()` for no
initial options.

#### `callback(entopts: Value) *CallbackEntity`

Create a new `CallbackEntity` instance. Pass `h.vnull()` for no
initial options.

#### `contact(entopts: Value) *ContactEntity`

Create a new `ContactEntity` instance. Pass `h.vnull()` for no
initial options.

#### `contacts_field(entopts: Value) *ContactsFieldEntity`

Create a new `ContactsFieldEntity` instance. Pass `h.vnull()` for no
initial options.

#### `contacts_field_option(entopts: Value) *ContactsFieldOptionEntity`

Create a new `ContactsFieldOptionEntity` instance. Pass `h.vnull()` for no
initial options.

#### `contactsgroup(entopts: Value) *ContactsgroupEntity`

Create a new `ContactsgroupEntity` instance. Pass `h.vnull()` for no
initial options.

#### `contactstrash(entopts: Value) *ContactstrashEntity`

Create a new `ContactstrashEntity` instance. Pass `h.vnull()` for no
initial options.

#### `field_available(entopts: Value) *FieldAvailableEntity`

Create a new `FieldAvailableEntity` instance. Pass `h.vnull()` for no
initial options.

#### `group(entopts: Value) *GroupEntity`

Create a new `GroupEntity` instance. Pass `h.vnull()` for no
initial options.

#### `mfa_code(entopts: Value) *MfaCodeEntity`

Create a new `MfaCodeEntity` instance. Pass `h.vnull()` for no
initial options.

#### `opt_out(entopts: Value) *OptOutEntity`

Create a new `OptOutEntity` instance. Pass `h.vnull()` for no
initial options.

#### `opt_out_setting(entopts: Value) *OptOutSettingEntity`

Create a new `OptOutSettingEntity` instance. Pass `h.vnull()` for no
initial options.

#### `permission(entopts: Value) *PermissionEntity`

Create a new `PermissionEntity` instance. Pass `h.vnull()` for no
initial options.

#### `ping(entopts: Value) *PingEntity`

Create a new `PingEntity` instance. Pass `h.vnull()` for no
initial options.

#### `profile(entopts: Value) *ProfileEntity`

Create a new `ProfileEntity` instance. Pass `h.vnull()` for no
initial options.

#### `rcs(entopts: Value) *RcsEntity`

Create a new `RcsEntity` instance. Pass `h.vnull()` for no
initial options.

#### `sendername(entopts: Value) *SendernameEntity`

Create a new `SendernameEntity` instance. Pass `h.vnull()` for no
initial options.

#### `sendername_statement(entopts: Value) *SendernameStatementEntity`

Create a new `SendernameStatementEntity` instance. Pass `h.vnull()` for no
initial options.

#### `sent_rcs_message(entopts: Value) *SentRcsMessageEntity`

Create a new `SentRcsMessageEntity` instance. Pass `h.vnull()` for no
initial options.

#### `shipment_country_volume(entopts: Value) *ShipmentCountryVolumeEntity`

Create a new `ShipmentCountryVolumeEntity` instance. Pass `h.vnull()` for no
initial options.

#### `short_url(entopts: Value) *ShortUrlEntity`

Create a new `ShortUrlEntity` instance. Pass `h.vnull()` for no
initial options.

#### `smsdo(entopts: Value) *SmsdoEntity`

Create a new `SmsdoEntity` instance. Pass `h.vnull()` for no
initial options.

#### `smssendername(entopts: Value) *SmssendernameEntity`

Create a new `SmssendernameEntity` instance. Pass `h.vnull()` for no
initial options.

#### `smstemplate(entopts: Value) *SmstemplateEntity`

Create a new `SmstemplateEntity` instance. Pass `h.vnull()` for no
initial options.

#### `subuser(entopts: Value) *SubuserEntity`

Create a new `SubuserEntity` instance. Pass `h.vnull()` for no
initial options.

#### `template(entopts: Value) *TemplateEntity`

Create a new `TemplateEntity` instance. Pass `h.vnull()` for no
initial options.

#### `user_rcs_sender_collection(entopts: Value) *UserRcsSenderCollectionEntity`

Create a new `UserRcsSenderCollectionEntity` instance. Pass `h.vnull()` for no
initial options.

#### `options_map() Value`

Return a deep copy of the current SDK options.

#### `get_utility() *Utility`

Return a copy of the SDK utility object.

#### `direct(fetchargs: Value) Value`

Make a direct HTTP request to any API endpoint. Returns a result `Value`
map with `ok`, `status`, `headers`, and `data` (or `err` on failure).
This escape hatch returns a map even on a non-2xx response — branch on
`h.get_bool(result, "ok")`.

**Parameters (`fetchargs` map keys):**

| Key | Value type | Description |
| --- | --- | --- |
| `path` | `string` | URL path with optional `{param}` placeholders. |
| `method` | `string` | HTTP method (default: `"GET"`). |
| `params` | `map` | Path parameter values. |
| `query` | `map` | Query string parameters. |
| `headers` | `map` | Request headers (merged with defaults). |
| `body` | `any` | Request body (maps are JSON-serialized). |

#### `prepare(fetchargs: Value) E!Value`

Prepare a fetch definition without sending. Returns the fetchdef (use
`catch`/`try` to handle the error union).


---

## AvailableEntity

```zig
const available = client.available(h.vnull());
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `name` | `[]const u8` | No |  |
| `normalize` | `bool` | No |  |
| `template` | `[]const u8` | No |  |

### Operations

#### `list(reqmatch: Value, ctrl: Value) EntListResult`

List entities matching the given criteria. The match is optional — pass `h.vnull()` to list all records. `.ok` is a slice of entities, one per record.

```zig
switch (client.available(h.vnull()).list(h.vnull(), h.vnull())) {
    .ok => |results| {
        for (results) |result| {
            std.debug.print("{s}\n", .{h.stringify(result.asEntity().data(null))});
        }
    },
    .err => |e| std.debug.print("list failed: {s}\n", .{e.msg}),
}
```

### Common Methods

#### `data(args: ?Value) Value`

Get the entity data. Pass a map to set it.

#### `matchv(args: ?Value) Value`

Get the entity match criteria. Pass a map to set it.

#### `stream(action: []const u8, args: Value, callopts: Value) StreamResult`

Run an operation through the pipeline and materialise its result items.
`StreamResult` is `.ok` with the items, or `.err` with the error that
failed the operation, as an operation call reports it. Under `throw: false`
in `callopts.ctrl`, a failed stream is `.ok` with whatever data the
failure left.

#### `get_name() []const u8`

Return the entity name.


---

## BlacklistEntity

```zig
const blacklist = client.blacklist(h.vnull());
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | `[]const u8` | No |  |

### Operations

#### `create(reqdata: Value, ctrl: Value) EntResult`

Create a new entity with the given data. `.ok` carries the created entity.

```zig
switch (client.blacklist(h.vnull()).create(h.jo(&.{
}), h.vnull())) {
    .ok => |result| std.debug.print("{s}\n", .{h.stringify(result.asEntity().data(null))}),
    .err => |e| std.debug.print("create failed: {s}\n", .{e.msg}),
}
```

Declares a `multipart/form-data` body, which this SDK does not encode yet: it sends the data as JSON.

#### `load(reqmatch: Value, ctrl: Value) EntResult`

Load a single entity matching the given criteria. `.ok` carries the entity, whose record `asEntity().data(null)` reads, and `.err` the branded error.

```zig
switch (client.blacklist(h.vnull()).load(h.vnull(), h.vnull())) {
    .ok => |result| std.debug.print("{s}\n", .{h.stringify(result.asEntity().data(null))}),
    .err => |e| std.debug.print("load failed: {s}\n", .{e.msg}),
}
```

#### `remove(reqmatch: Value, ctrl: Value) EntResult`

Remove the entity matching the given criteria. `.ok` carries the entity, marked as deleted, and `.err` the branded error.

```zig
switch (client.blacklist(h.vnull()).remove(h.jo(&.{.{ "id", h.vstr("id") }}), h.vnull())) {
    .ok => |result| std.debug.print("{s}\n", .{h.stringify(result.asEntity().data(null))}),
    .err => |e| std.debug.print("remove failed: {s}\n", .{e.msg}),
}
```

### Common Methods

#### `data(args: ?Value) Value`

Get the entity data. Pass a map to set it.

#### `matchv(args: ?Value) Value`

Get the entity match criteria. Pass a map to set it.

#### `stream(action: []const u8, args: Value, callopts: Value) StreamResult`

Run an operation through the pipeline and materialise its result items.
`StreamResult` is `.ok` with the items, or `.err` with the error that
failed the operation, as an operation call reports it. Under `throw: false`
in `callopts.ctrl`, a failed stream is `.ok` with whatever data the
failure left.

#### `get_name() []const u8`

Return the entity name.


---

## CallbackEntity

```zig
const callback = client.callback(h.vnull());
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `active` | `bool` | No |  |
| `api_version` | `i64` | No | Version of the callback output format. |
| `id` | `[]const u8` | No | Object ID |
| `invalid` | `bool` | No |  |
| `receiver` | `Value (object)` | No |  |
| `receiver_type` | `[]const u8` | No |  |
| `type` | `[]const u8` | No |  |
| `url` | `[]const u8` | No | WHATWG URL compliant |

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

#### `create(reqdata: Value, ctrl: Value) EntResult`

Create a new entity with the given data. `.ok` carries the created entity.

```zig
switch (client.callback(h.vnull()).create(h.jo(&.{
}), h.vnull())) {
    .ok => |result| std.debug.print("{s}\n", .{h.stringify(result.asEntity().data(null))}),
    .err => |e| std.debug.print("create failed: {s}\n", .{e.msg}),
}
```

#### `list(reqmatch: Value, ctrl: Value) EntListResult`

List entities matching the given criteria. The match is optional — pass `h.vnull()` to list all records. `.ok` is a slice of entities, one per record.

```zig
switch (client.callback(h.vnull()).list(h.vnull(), h.vnull())) {
    .ok => |results| {
        for (results) |result| {
            std.debug.print("{s}\n", .{h.stringify(result.asEntity().data(null))});
        }
    },
    .err => |e| std.debug.print("list failed: {s}\n", .{e.msg}),
}
```

#### `load(reqmatch: Value, ctrl: Value) EntResult`

Load a single entity matching the given criteria. `.ok` carries the entity, whose record `asEntity().data(null)` reads, and `.err` the branded error.

```zig
switch (client.callback(h.vnull()).load(h.jo(&.{.{ "id", h.vstr("callback_id") }}), h.vnull())) {
    .ok => |result| std.debug.print("{s}\n", .{h.stringify(result.asEntity().data(null))}),
    .err => |e| std.debug.print("load failed: {s}\n", .{e.msg}),
}
```

#### `remove(reqmatch: Value, ctrl: Value) EntResult`

Remove the entity matching the given criteria. `.ok` carries the entity, marked as deleted, and `.err` the branded error.

```zig
switch (client.callback(h.vnull()).remove(h.jo(&.{.{ "id", h.vstr("callback_id") }}), h.vnull())) {
    .ok => |result| std.debug.print("{s}\n", .{h.stringify(result.asEntity().data(null))}),
    .err => |e| std.debug.print("remove failed: {s}\n", .{e.msg}),
}
```

#### `update(reqdata: Value, ctrl: Value) EntResult`

Update an existing entity. The data must include the entity id. `.ok` carries the updated entity.

```zig
switch (client.callback(h.vnull()).update(h.jo(&.{
    .{ "id", h.vstr("callback_id") },
    // Fields to update
}), h.vnull())) {
    .ok => |result| std.debug.print("{s}\n", .{h.stringify(result.asEntity().data(null))}),
    .err => |e| std.debug.print("update failed: {s}\n", .{e.msg}),
}
```

### Common Methods

#### `data(args: ?Value) Value`

Get the entity data. Pass a map to set it.

#### `matchv(args: ?Value) Value`

Get the entity match criteria. Pass a map to set it.

#### `stream(action: []const u8, args: Value, callopts: Value) StreamResult`

Run an operation through the pipeline and materialise its result items.
`StreamResult` is `.ok` with the items, or `.err` with the error that
failed the operation, as an operation call reports it. Under `throw: false`
in `callopts.ctrl`, a failed stream is `.ok` with whatever data the
failure left.

#### `get_name() []const u8`

Return the entity name.


---

## ContactEntity

```zig
const contact = client.contact(h.vnull());
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `birthday_date` | `[]const u8` | No |  |
| `city` | `[]const u8` | No |  |
| `collection` | `Value (array)` | Yes |  |
| `contact_expire_after` | `i64` | Yes | Contact expire after days |
| `contacts_count` | `i64` | Yes |  |
| `country` | `[]const u8` | No |  |
| `created_by` | `[]const u8` | Yes |  |
| `date_created` | `[]const u8` | Yes |  |
| `date_updated` | `[]const u8` | Yes |  |
| `description` | `[]const u8` | No |  |
| `email` | `[]const u8` | No |  |
| `first_name` | `[]const u8` | No |  |
| `gender` | `[]const u8` | Yes |  |
| `groups` | `Value (array)` | Yes |  |
| `id` | `[]const u8` | Yes | Object ID |
| `idx` | `[]const u8` | No | User provided resource id |
| `last_name` | `[]const u8` | No |  |
| `name` | `[]const u8` | Yes | Group name |
| `permissions` | `Value (array)` | No |  |
| `phone_number` | `[]const u8` | No |  |
| `size` | `i64` | Yes |  |
| `source` | `[]const u8` | No |  |

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

#### `create(reqdata: Value, ctrl: Value) EntResult`

Create a new entity with the given data. `.ok` carries the created entity.

```zig
switch (client.contact(h.vnull()).create(h.jo(&.{
    .{ "collection", h.olist() }, // Value (array)
    .{ "contact_expire_after", h.vnum(1) }, // i64
    .{ "contacts_count", h.vnum(1) }, // i64
    .{ "created_by", h.vstr("example_created_by") }, // []const u8
    .{ "date_created", h.vstr("example_date_created") }, // []const u8
    .{ "date_updated", h.vstr("example_date_updated") }, // []const u8
    .{ "gender", h.vstr("example_gender") }, // []const u8
    .{ "groups", h.olist() }, // Value (array)
    .{ "id", h.vstr("example_id") }, // []const u8
    .{ "name", h.vstr("example_name") }, // []const u8
    .{ "size", h.vnum(1) }, // i64
}), h.vnull())) {
    .ok => |result| std.debug.print("{s}\n", .{h.stringify(result.asEntity().data(null))}),
    .err => |e| std.debug.print("create failed: {s}\n", .{e.msg}),
}
```

Declares a `application/x-www-form-urlencoded` body, which this SDK does not encode yet: it sends the data as JSON.

#### `list(reqmatch: Value, ctrl: Value) EntListResult`

List entities matching the given criteria. The match is optional — pass `h.vnull()` to list all records. `.ok` is a slice of entities, one per record.

```zig
switch (client.contact(h.vnull()).list(h.vnull(), h.vnull())) {
    .ok => |results| {
        for (results) |result| {
            std.debug.print("{s}\n", .{h.stringify(result.asEntity().data(null))});
        }
    },
    .err => |e| std.debug.print("list failed: {s}\n", .{e.msg}),
}
```

#### `load(reqmatch: Value, ctrl: Value) EntResult`

Load a single entity matching the given criteria. `.ok` carries the entity, whose record `asEntity().data(null)` reads, and `.err` the branded error.

```zig
switch (client.contact(h.vnull()).load(h.jo(&.{.{ "id", h.vstr("contact_id") }}), h.vnull())) {
    .ok => |result| std.debug.print("{s}\n", .{h.stringify(result.asEntity().data(null))}),
    .err => |e| std.debug.print("load failed: {s}\n", .{e.msg}),
}
```

#### `remove(reqmatch: Value, ctrl: Value) EntResult`

Remove the entity matching the given criteria. `.ok` carries the entity, marked as deleted, and `.err` the branded error.

```zig
switch (client.contact(h.vnull()).remove(h.jo(&.{.{ "id", h.vstr("contact_id") }}), h.vnull())) {
    .ok => |result| std.debug.print("{s}\n", .{h.stringify(result.asEntity().data(null))}),
    .err => |e| std.debug.print("remove failed: {s}\n", .{e.msg}),
}
```

#### `update(reqdata: Value, ctrl: Value) EntResult`

Update an existing entity. The data must include the entity id. `.ok` carries the updated entity.

```zig
switch (client.contact(h.vnull()).update(h.jo(&.{
    .{ "id", h.vstr("contact_id") },
    // Fields to update
}), h.vnull())) {
    .ok => |result| std.debug.print("{s}\n", .{h.stringify(result.asEntity().data(null))}),
    .err => |e| std.debug.print("update failed: {s}\n", .{e.msg}),
}
```

Declares a `application/x-www-form-urlencoded` body, which this SDK does not encode yet: it sends the data as JSON.

### Common Methods

#### `data(args: ?Value) Value`

Get the entity data. Pass a map to set it.

#### `matchv(args: ?Value) Value`

Get the entity match criteria. Pass a map to set it.

#### `stream(action: []const u8, args: Value, callopts: Value) StreamResult`

Run an operation through the pipeline and materialise its result items.
`StreamResult` is `.ok` with the items, or `.err` with the error that
failed the operation, as an operation call reports it. Under `throw: false`
in `callopts.ctrl`, a failed stream is `.ok` with whatever data the
failure left.

#### `get_name() []const u8`

Return the entity name.


---

## ContactsFieldEntity

```zig
const contacts_field = client.contacts_field(h.vnull());
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | `[]const u8` | No | Object ID |
| `name` | `[]const u8` | No |  |
| `type` | `[]const u8` | No |  |

### Operations

#### `create(reqdata: Value, ctrl: Value) EntResult`

Create a new entity with the given data. `.ok` carries the created entity.

```zig
switch (client.contacts_field(h.vnull()).create(h.jo(&.{
}), h.vnull())) {
    .ok => |result| std.debug.print("{s}\n", .{h.stringify(result.asEntity().data(null))}),
    .err => |e| std.debug.print("create failed: {s}\n", .{e.msg}),
}
```

Declares a `application/x-www-form-urlencoded` body, which this SDK does not encode yet: it sends the data as JSON.

#### `list(reqmatch: Value, ctrl: Value) EntListResult`

List entities matching the given criteria. The match is optional — pass `h.vnull()` to list all records. `.ok` is a slice of entities, one per record.

```zig
switch (client.contacts_field(h.vnull()).list(h.vnull(), h.vnull())) {
    .ok => |results| {
        for (results) |result| {
            std.debug.print("{s}\n", .{h.stringify(result.asEntity().data(null))});
        }
    },
    .err => |e| std.debug.print("list failed: {s}\n", .{e.msg}),
}
```

#### `remove(reqmatch: Value, ctrl: Value) EntResult`

Remove the entity matching the given criteria. `.ok` carries the entity, marked as deleted, and `.err` the branded error.

```zig
switch (client.contacts_field(h.vnull()).remove(h.jo(&.{.{ "id", h.vstr("id") }}), h.vnull())) {
    .ok => |result| std.debug.print("{s}\n", .{h.stringify(result.asEntity().data(null))}),
    .err => |e| std.debug.print("remove failed: {s}\n", .{e.msg}),
}
```

#### `update(reqdata: Value, ctrl: Value) EntResult`

Update an existing entity. The data must include the entity id. `.ok` carries the updated entity.

```zig
switch (client.contacts_field(h.vnull()).update(h.jo(&.{
    .{ "id", h.vstr("id") },
    // Fields to update
}), h.vnull())) {
    .ok => |result| std.debug.print("{s}\n", .{h.stringify(result.asEntity().data(null))}),
    .err => |e| std.debug.print("update failed: {s}\n", .{e.msg}),
}
```

Declares a `application/x-www-form-urlencoded` body, which this SDK does not encode yet: it sends the data as JSON.

### Common Methods

#### `data(args: ?Value) Value`

Get the entity data. Pass a map to set it.

#### `matchv(args: ?Value) Value`

Get the entity match criteria. Pass a map to set it.

#### `stream(action: []const u8, args: Value, callopts: Value) StreamResult`

Run an operation through the pipeline and materialise its result items.
`StreamResult` is `.ok` with the items, or `.err` with the error that
failed the operation, as an operation call reports it. Under `throw: false`
in `callopts.ctrl`, a failed stream is `.ok` with whatever data the
failure left.

#### `get_name() []const u8`

Return the entity name.


---

## ContactsFieldOptionEntity

```zig
const contacts_field_option = client.contacts_field_option(h.vnull());
```

### Operations

#### `list(reqmatch: Value, ctrl: Value) EntListResult`

List entities matching the given criteria. The match is optional — pass `h.vnull()` to list all records. `.ok` is a slice of entities, one per record.

```zig
switch (client.contacts_field_option(h.vnull()).list(h.jo(&.{.{ "field_id", h.vstr("example") }}), h.vnull())) {
    .ok => |results| {
        for (results) |result| {
            std.debug.print("{s}\n", .{h.stringify(result.asEntity().data(null))});
        }
    },
    .err => |e| std.debug.print("list failed: {s}\n", .{e.msg}),
}
```

### Common Methods

#### `data(args: ?Value) Value`

Get the entity data. Pass a map to set it.

#### `matchv(args: ?Value) Value`

Get the entity match criteria. Pass a map to set it.

#### `stream(action: []const u8, args: Value, callopts: Value) StreamResult`

Run an operation through the pipeline and materialise its result items.
`StreamResult` is `.ok` with the items, or `.err` with the error that
failed the operation, as an operation call reports it. Under `throw: false`
in `callopts.ctrl`, a failed stream is `.ok` with whatever data the
failure left.

#### `get_name() []const u8`

Return the entity name.


---

## ContactsgroupEntity

```zig
const contactsgroup = client.contactsgroup(h.vnull());
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `group_id` | `[]const u8` | Yes | Object ID |
| `read` | `bool` | Yes | Has read permission |
| `send` | `bool` | Yes | Has send permission |
| `username` | `[]const u8` | Yes |  |
| `write` | `bool` | Yes | Has write permission |

### Operations

#### `create(reqdata: Value, ctrl: Value) EntResult`

Create a new entity with the given data. `.ok` carries the created entity.

```zig
switch (client.contactsgroup(h.vnull()).create(h.jo(&.{
    .{ "group_id", h.vstr("example_group_id") }, // []const u8
    .{ "read", h.vbool(true) }, // bool
    .{ "send", h.vbool(true) }, // bool
    .{ "username", h.vstr("example_username") }, // []const u8
    .{ "write", h.vbool(true) }, // bool
}), h.vnull())) {
    .ok => |result| std.debug.print("{s}\n", .{h.stringify(result.asEntity().data(null))}),
    .err => |e| std.debug.print("create failed: {s}\n", .{e.msg}),
}
```

Declares a `application/x-www-form-urlencoded` body, which this SDK does not encode yet: it sends the data as JSON.

#### `list(reqmatch: Value, ctrl: Value) EntListResult`

List entities matching the given criteria. The match is optional — pass `h.vnull()` to list all records. `.ok` is a slice of entities, one per record.

```zig
switch (client.contactsgroup(h.vnull()).list(h.vnull(), h.vnull())) {
    .ok => |results| {
        for (results) |result| {
            std.debug.print("{s}\n", .{h.stringify(result.asEntity().data(null))});
        }
    },
    .err => |e| std.debug.print("list failed: {s}\n", .{e.msg}),
}
```

#### `remove(reqmatch: Value, ctrl: Value) EntResult`

Remove the entity matching the given criteria. `.ok` carries the entity, marked as deleted, and `.err` the branded error.

```zig
switch (client.contactsgroup(h.vnull()).remove(h.jo(&.{.{ "group_id", h.vstr("group_id") }}), h.vnull())) {
    .ok => |result| std.debug.print("{s}\n", .{h.stringify(result.asEntity().data(null))}),
    .err => |e| std.debug.print("remove failed: {s}\n", .{e.msg}),
}
```

#### `update(reqdata: Value, ctrl: Value) EntResult`

Update an existing entity. The data must include the entity id. `.ok` carries the updated entity.

```zig
switch (client.contactsgroup(h.vnull()).update(h.jo(&.{
    .{ "group_id", h.vstr("group_id") },
    // Fields to update
}), h.vnull())) {
    .ok => |result| std.debug.print("{s}\n", .{h.stringify(result.asEntity().data(null))}),
    .err => |e| std.debug.print("update failed: {s}\n", .{e.msg}),
}
```

Declares a `application/x-www-form-urlencoded` body, which this SDK does not encode yet: it sends the data as JSON.

### Common Methods

#### `data(args: ?Value) Value`

Get the entity data. Pass a map to set it.

#### `matchv(args: ?Value) Value`

Get the entity match criteria. Pass a map to set it.

#### `stream(action: []const u8, args: Value, callopts: Value) StreamResult`

Run an operation through the pipeline and materialise its result items.
`StreamResult` is `.ok` with the items, or `.err` with the error that
failed the operation, as an operation call reports it. Under `throw: false`
in `callopts.ctrl`, a failed stream is `.ok` with whatever data the
failure left.

#### `get_name() []const u8`

Return the entity name.


---

## ContactstrashEntity

```zig
const contactstrash = client.contactstrash(h.vnull());
```

### Operations

#### `remove(reqmatch: Value, ctrl: Value) EntResult`

Remove the entity matching the given criteria. `.ok` carries the entity, marked as deleted, and `.err` the branded error.

```zig
switch (client.contactstrash(h.vnull()).remove(h.vnull(), h.vnull())) {
    .ok => |result| std.debug.print("{s}\n", .{h.stringify(result.asEntity().data(null))}),
    .err => |e| std.debug.print("remove failed: {s}\n", .{e.msg}),
}
```

#### `update(reqdata: Value, ctrl: Value) EntResult`

Update an existing entity. The data must include the entity id. `.ok` carries the updated entity.

```zig
switch (client.contactstrash(h.vnull()).update(h.jo(&.{
    // Fields to update
}), h.vnull())) {
    .ok => |result| std.debug.print("{s}\n", .{h.stringify(result.asEntity().data(null))}),
    .err => |e| std.debug.print("update failed: {s}\n", .{e.msg}),
}
```

### Common Methods

#### `data(args: ?Value) Value`

Get the entity data. Pass a map to set it.

#### `matchv(args: ?Value) Value`

Get the entity match criteria. Pass a map to set it.

#### `stream(action: []const u8, args: Value, callopts: Value) StreamResult`

Run an operation through the pipeline and materialise its result items.
`StreamResult` is `.ok` with the items, or `.err` with the error that
failed the operation, as an operation call reports it. Under `throw: false`
in `callopts.ctrl`, a failed stream is `.ok` with whatever data the
failure left.

#### `get_name() []const u8`

Return the entity name.


---

## FieldAvailableEntity

```zig
const field_available = client.field_available(h.vnull());
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `built_in` | `bool` | No |  |
| `id` | `[]const u8` | No | Object ID |
| `name` | `[]const u8` | No |  |
| `options` | `Value (array)` | No |  |
| `type` | `[]const u8` | No |  |

### Operations

#### `list(reqmatch: Value, ctrl: Value) EntListResult`

List entities matching the given criteria. The match is optional — pass `h.vnull()` to list all records. `.ok` is a slice of entities, one per record.

```zig
switch (client.field_available(h.vnull()).list(h.vnull(), h.vnull())) {
    .ok => |results| {
        for (results) |result| {
            std.debug.print("{s}\n", .{h.stringify(result.asEntity().data(null))});
        }
    },
    .err => |e| std.debug.print("list failed: {s}\n", .{e.msg}),
}
```

### Common Methods

#### `data(args: ?Value) Value`

Get the entity data. Pass a map to set it.

#### `matchv(args: ?Value) Value`

Get the entity match criteria. Pass a map to set it.

#### `stream(action: []const u8, args: Value, callopts: Value) StreamResult`

Run an operation through the pipeline and materialise its result items.
`StreamResult` is `.ok` with the items, or `.err` with the error that
failed the operation, as an operation call reports it. Under `throw: false`
in `callopts.ctrl`, a failed stream is `.ok` with whatever data the
failure left.

#### `get_name() []const u8`

Return the entity name.


---

## GroupEntity

```zig
const group = client.group(h.vnull());
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `contact_expire_after` | `i64` | Yes | Contact expire after days |
| `contacts_count` | `i64` | Yes |  |
| `created_by` | `[]const u8` | Yes |  |
| `date_created` | `[]const u8` | Yes |  |
| `date_updated` | `[]const u8` | Yes |  |
| `description` | `[]const u8` | Yes |  |
| `id` | `[]const u8` | Yes | Object ID |
| `idx` | `[]const u8` | No | User provided resource id |
| `name` | `[]const u8` | Yes | Group name |
| `permissions` | `Value (array)` | No |  |

### Operations

#### `load(reqmatch: Value, ctrl: Value) EntResult`

Load a single entity matching the given criteria. `.ok` carries the entity, whose record `asEntity().data(null)` reads, and `.err` the branded error.

```zig
switch (client.group(h.vnull()).load(h.jo(&.{.{ "id", h.vstr("group_id") }}), h.vnull())) {
    .ok => |result| std.debug.print("{s}\n", .{h.stringify(result.asEntity().data(null))}),
    .err => |e| std.debug.print("load failed: {s}\n", .{e.msg}),
}
```

#### `update(reqdata: Value, ctrl: Value) EntResult`

Update an existing entity. The data must include the entity id. `.ok` carries the updated entity.

```zig
switch (client.group(h.vnull()).update(h.jo(&.{
    .{ "id", h.vstr("group_id") },
    // Fields to update
}), h.vnull())) {
    .ok => |result| std.debug.print("{s}\n", .{h.stringify(result.asEntity().data(null))}),
    .err => |e| std.debug.print("update failed: {s}\n", .{e.msg}),
}
```

Declares a `application/x-www-form-urlencoded` body, which this SDK does not encode yet: it sends the data as JSON.

### Common Methods

#### `data(args: ?Value) Value`

Get the entity data. Pass a map to set it.

#### `matchv(args: ?Value) Value`

Get the entity match criteria. Pass a map to set it.

#### `stream(action: []const u8, args: Value, callopts: Value) StreamResult`

Run an operation through the pipeline and materialise its result items.
`StreamResult` is `.ok` with the items, or `.err` with the error that
failed the operation, as an operation call reports it. Under `throw: false`
in `callopts.ctrl`, a failed stream is `.ok` with whatever data the
failure left.

#### `get_name() []const u8`

Return the entity name.


---

## MfaCodeEntity

```zig
const mfa_code = client.mfa_code(h.vnull());
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `content` | `[]const u8` | No | Custom content that must contain placeholder [%code%] |
| `fast` | `Value` | No |  |
| `from` | `[]const u8` | No | Sendername |
| `phone_number` | `[]const u8` | Yes |  |

### Operations

#### `create(reqdata: Value, ctrl: Value) EntResult`

Create a new entity with the given data. `.ok` carries the created entity.

```zig
switch (client.mfa_code(h.vnull()).create(h.jo(&.{
    .{ "phone_number", h.vstr("example_phone_number") }, // []const u8
}), h.vnull())) {
    .ok => |result| std.debug.print("{s}\n", .{h.stringify(result.asEntity().data(null))}),
    .err => |e| std.debug.print("create failed: {s}\n", .{e.msg}),
}
```

Declares a `application/x-www-form-urlencoded` body, which this SDK does not encode yet: it sends the data as JSON.

### Common Methods

#### `data(args: ?Value) Value`

Get the entity data. Pass a map to set it.

#### `matchv(args: ?Value) Value`

Get the entity match criteria. Pass a map to set it.

#### `stream(action: []const u8, args: Value, callopts: Value) StreamResult`

Run an operation through the pipeline and materialise its result items.
`StreamResult` is `.ok` with the items, or `.err` with the error that
failed the operation, as an operation call reports it. Under `throw: false`
in `callopts.ctrl`, a failed stream is `.ok` with whatever data the
failure left.

#### `get_name() []const u8`

Return the entity name.


---

## OptOutEntity

```zig
const opt_out = client.opt_out(h.vnull());
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `date` | `[]const u8` | No |  |
| `id` | `[]const u8` | No |  |
| `links` | `Value (array)` | No |  |
| `phoneNumber` | `i64` | No |  |

### Operations

#### `list(reqmatch: Value, ctrl: Value) EntListResult`

List entities matching the given criteria. The match is optional — pass `h.vnull()` to list all records. `.ok` is a slice of entities, one per record.

```zig
switch (client.opt_out(h.vnull()).list(h.vnull(), h.vnull())) {
    .ok => |results| {
        for (results) |result| {
            std.debug.print("{s}\n", .{h.stringify(result.asEntity().data(null))});
        }
    },
    .err => |e| std.debug.print("list failed: {s}\n", .{e.msg}),
}
```

#### `remove(reqmatch: Value, ctrl: Value) EntResult`

Remove the entity matching the given criteria. `.ok` carries the entity, marked as deleted, and `.err` the branded error.

```zig
switch (client.opt_out(h.vnull()).remove(h.jo(&.{.{ "id", h.vstr("id") }}), h.vnull())) {
    .ok => |result| std.debug.print("{s}\n", .{h.stringify(result.asEntity().data(null))}),
    .err => |e| std.debug.print("remove failed: {s}\n", .{e.msg}),
}
```

### Common Methods

#### `data(args: ?Value) Value`

Get the entity data. Pass a map to set it.

#### `matchv(args: ?Value) Value`

Get the entity match criteria. Pass a map to set it.

#### `stream(action: []const u8, args: Value, callopts: Value) StreamResult`

Run an operation through the pipeline and materialise its result items.
`StreamResult` is `.ok` with the items, or `.err` with the error that
failed the operation, as an operation call reports it. Under `throw: false`
in `callopts.ctrl`, a failed stream is `.ok` with whatever data the
failure left.

#### `get_name() []const u8`

Return the entity name.


---

## OptOutSettingEntity

```zig
const opt_out_setting = client.opt_out_setting(h.vnull());
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `brand` | `[]const u8` | No |  |

### Operations

#### `load(reqmatch: Value, ctrl: Value) EntResult`

Load a single entity matching the given criteria. `.ok` carries the entity, whose record `asEntity().data(null)` reads, and `.err` the branded error.

```zig
switch (client.opt_out_setting(h.vnull()).load(h.vnull(), h.vnull())) {
    .ok => |result| std.debug.print("{s}\n", .{h.stringify(result.asEntity().data(null))}),
    .err => |e| std.debug.print("load failed: {s}\n", .{e.msg}),
}
```

#### `update(reqdata: Value, ctrl: Value) EntResult`

Update an existing entity. The data must include the entity id. `.ok` carries the updated entity.

```zig
switch (client.opt_out_setting(h.vnull()).update(h.jo(&.{
    // Fields to update
}), h.vnull())) {
    .ok => |result| std.debug.print("{s}\n", .{h.stringify(result.asEntity().data(null))}),
    .err => |e| std.debug.print("update failed: {s}\n", .{e.msg}),
}
```

### Common Methods

#### `data(args: ?Value) Value`

Get the entity data. Pass a map to set it.

#### `matchv(args: ?Value) Value`

Get the entity match criteria. Pass a map to set it.

#### `stream(action: []const u8, args: Value, callopts: Value) StreamResult`

Run an operation through the pipeline and materialise its result items.
`StreamResult` is `.ok` with the items, or `.err` with the error that
failed the operation, as an operation call reports it. Under `throw: false`
in `callopts.ctrl`, a failed stream is `.ok` with whatever data the
failure left.

#### `get_name() []const u8`

Return the entity name.


---

## PermissionEntity

```zig
const permission = client.permission(h.vnull());
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `group_id` | `[]const u8` | Yes | Object ID |
| `id` | `[]const u8` | No |  |
| `read` | `bool` | Yes | Has read permission |
| `send` | `bool` | Yes | Has send permission |
| `username` | `[]const u8` | Yes |  |
| `write` | `bool` | Yes | Has write permission |

### Operations

#### `create(reqdata: Value, ctrl: Value) EntResult`

Create a new entity with the given data. `.ok` carries the created entity.

```zig
switch (client.permission(h.vnull()).create(h.jo(&.{
    .{ "group_id", h.vstr("example_group_id") }, // []const u8
    .{ "read", h.vbool(true) }, // bool
    .{ "send", h.vbool(true) }, // bool
    .{ "username", h.vstr("example_username") }, // []const u8
    .{ "write", h.vbool(true) }, // bool
}), h.vnull())) {
    .ok => |result| std.debug.print("{s}\n", .{h.stringify(result.asEntity().data(null))}),
    .err => |e| std.debug.print("create failed: {s}\n", .{e.msg}),
}
```

Declares a `application/x-www-form-urlencoded` body, which this SDK does not encode yet: it sends the data as JSON.

#### `load(reqmatch: Value, ctrl: Value) EntResult`

Load a single entity matching the given criteria. `.ok` carries the entity, whose record `asEntity().data(null)` reads, and `.err` the branded error.

```zig
switch (client.permission(h.vnull()).load(h.jo(&.{.{ "id", h.vstr("permission_id") }, .{ "group_id", h.vstr("group_id") }}), h.vnull())) {
    .ok => |result| std.debug.print("{s}\n", .{h.stringify(result.asEntity().data(null))}),
    .err => |e| std.debug.print("load failed: {s}\n", .{e.msg}),
}
```

### Common Methods

#### `data(args: ?Value) Value`

Get the entity data. Pass a map to set it.

#### `matchv(args: ?Value) Value`

Get the entity match criteria. Pass a map to set it.

#### `stream(action: []const u8, args: Value, callopts: Value) StreamResult`

Run an operation through the pipeline and materialise its result items.
`StreamResult` is `.ok` with the items, or `.err` with the error that
failed the operation, as an operation call reports it. Under `throw: false`
in `callopts.ctrl`, a failed stream is `.ok` with whatever data the
failure left.

#### `get_name() []const u8`

Return the entity name.


---

## PingEntity

```zig
const ping = client.ping(h.vnull());
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `authorized` | `bool` | Yes |  |
| `unavailable` | `Value (array)` | Yes |  |

### Operations

#### `list(reqmatch: Value, ctrl: Value) EntListResult`

List entities matching the given criteria. The match is optional — pass `h.vnull()` to list all records. `.ok` is a slice of entities, one per record.

```zig
switch (client.ping(h.vnull()).list(h.vnull(), h.vnull())) {
    .ok => |results| {
        for (results) |result| {
            std.debug.print("{s}\n", .{h.stringify(result.asEntity().data(null))});
        }
    },
    .err => |e| std.debug.print("list failed: {s}\n", .{e.msg}),
}
```

### Common Methods

#### `data(args: ?Value) Value`

Get the entity data. Pass a map to set it.

#### `matchv(args: ?Value) Value`

Get the entity match criteria. Pass a map to set it.

#### `stream(action: []const u8, args: Value, callopts: Value) StreamResult`

Run an operation through the pipeline and materialise its result items.
`StreamResult` is `.ok` with the items, or `.err` with the error that
failed the operation, as an operation call reports it. Under `throw: false`
in `callopts.ctrl`, a failed stream is `.ok` with whatever data the
failure left.

#### `get_name() []const u8`

Return the entity name.


---

## ProfileEntity

```zig
const profile = client.profile(h.vnull());
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `email` | `[]const u8` | Yes |  |
| `name` | `[]const u8` | Yes |  |
| `payment_type` | `[]const u8` | Yes |  |
| `phone_number` | `i64` | Yes |  |
| `points` | `f64` | No |  |
| `user_type` | `[]const u8` | Yes |  |
| `username` | `[]const u8` | Yes |  |

### Operations

#### `list(reqmatch: Value, ctrl: Value) EntListResult`

List entities matching the given criteria. The match is optional — pass `h.vnull()` to list all records. `.ok` is a slice of entities, one per record.

```zig
switch (client.profile(h.vnull()).list(h.vnull(), h.vnull())) {
    .ok => |results| {
        for (results) |result| {
            std.debug.print("{s}\n", .{h.stringify(result.asEntity().data(null))});
        }
    },
    .err => |e| std.debug.print("list failed: {s}\n", .{e.msg}),
}
```

#### `load(reqmatch: Value, ctrl: Value) EntResult`

Load a single entity matching the given criteria. `.ok` carries the entity, whose record `asEntity().data(null)` reads, and `.err` the branded error.

```zig
switch (client.profile(h.vnull()).load(h.vnull(), h.vnull())) {
    .ok => |result| std.debug.print("{s}\n", .{h.stringify(result.asEntity().data(null))}),
    .err => |e| std.debug.print("load failed: {s}\n", .{e.msg}),
}
```

### Common Methods

#### `data(args: ?Value) Value`

Get the entity data. Pass a map to set it.

#### `matchv(args: ?Value) Value`

Get the entity match criteria. Pass a map to set it.

#### `stream(action: []const u8, args: Value, callopts: Value) StreamResult`

Run an operation through the pipeline and materialise its result items.
`StreamResult` is `.ok` with the items, or `.err` with the error that
failed the operation, as an operation call reports it. Under `throw: false`
in `callopts.ctrl`, a failed stream is `.ok` with whatever data the
failure left.

#### `get_name() []const u8`

Return the entity name.


---

## RcsEntity

```zig
const rcs = client.rcs(h.vnull());
```

### Operations

#### `list(reqmatch: Value, ctrl: Value) EntListResult`

List entities matching the given criteria. The match is optional — pass `h.vnull()` to list all records. `.ok` is a slice of entities, one per record.

```zig
switch (client.rcs(h.vnull()).list(h.vnull(), h.vnull())) {
    .ok => |results| {
        for (results) |result| {
            std.debug.print("{s}\n", .{h.stringify(result.asEntity().data(null))});
        }
    },
    .err => |e| std.debug.print("list failed: {s}\n", .{e.msg}),
}
```

### Common Methods

#### `data(args: ?Value) Value`

Get the entity data. Pass a map to set it.

#### `matchv(args: ?Value) Value`

Get the entity match criteria. Pass a map to set it.

#### `stream(action: []const u8, args: Value, callopts: Value) StreamResult`

Run an operation through the pipeline and materialise its result items.
`StreamResult` is `.ok` with the items, or `.err` with the error that
failed the operation, as an operation call reports it. Under `throw: false`
in `callopts.ctrl`, a failed stream is `.ok` with whatever data the
failure left.

#### `get_name() []const u8`

Return the entity name.


---

## SendernameEntity

```zig
const sendername = client.sendername(h.vnull());
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `created_at` | `[]const u8` | No |  |
| `id` | `[]const u8` | No |  |
| `is_default` | `bool` | No |  |
| `sender` | `[]const u8` | No | Sendername |
| `status` | `[]const u8` | No |  |

### Operations

#### `create(reqdata: Value, ctrl: Value) EntResult`

Create a new entity with the given data. `.ok` carries the created entity.

```zig
switch (client.sendername(h.vnull()).create(h.jo(&.{
}), h.vnull())) {
    .ok => |result| std.debug.print("{s}\n", .{h.stringify(result.asEntity().data(null))}),
    .err => |e| std.debug.print("create failed: {s}\n", .{e.msg}),
}
```

Declares a `application/x-www-form-urlencoded` body, which this SDK does not encode yet: it sends the data as JSON.

#### `list(reqmatch: Value, ctrl: Value) EntListResult`

List entities matching the given criteria. The match is optional — pass `h.vnull()` to list all records. `.ok` is a slice of entities, one per record.

```zig
switch (client.sendername(h.vnull()).list(h.vnull(), h.vnull())) {
    .ok => |results| {
        for (results) |result| {
            std.debug.print("{s}\n", .{h.stringify(result.asEntity().data(null))});
        }
    },
    .err => |e| std.debug.print("list failed: {s}\n", .{e.msg}),
}
```

#### `load(reqmatch: Value, ctrl: Value) EntResult`

Load a single entity matching the given criteria. `.ok` carries the entity, whose record `asEntity().data(null)` reads, and `.err` the branded error.

```zig
switch (client.sendername(h.vnull()).load(h.jo(&.{.{ "id", h.vstr("sendername_id") }}), h.vnull())) {
    .ok => |result| std.debug.print("{s}\n", .{h.stringify(result.asEntity().data(null))}),
    .err => |e| std.debug.print("load failed: {s}\n", .{e.msg}),
}
```

### Common Methods

#### `data(args: ?Value) Value`

Get the entity data. Pass a map to set it.

#### `matchv(args: ?Value) Value`

Get the entity match criteria. Pass a map to set it.

#### `stream(action: []const u8, args: Value, callopts: Value) StreamResult`

Run an operation through the pipeline and materialise its result items.
`StreamResult` is `.ok` with the items, or `.err` with the error that
failed the operation, as an operation call reports it. Under `throw: false`
in `callopts.ctrl`, a failed stream is `.ok` with whatever data the
failure left.

#### `get_name() []const u8`

Return the entity name.


---

## SendernameStatementEntity

```zig
const sendername_statement = client.sendername_statement(h.vnull());
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `content` | `[]const u8` | No |  |
| `statements` | `Value (array)` | No |  |
| `title` | `[]const u8` | No |  |

### Operations

#### `list(reqmatch: Value, ctrl: Value) EntListResult`

List entities matching the given criteria. The match is optional — pass `h.vnull()` to list all records. `.ok` is a slice of entities, one per record.

```zig
switch (client.sendername_statement(h.vnull()).list(h.vnull(), h.vnull())) {
    .ok => |results| {
        for (results) |result| {
            std.debug.print("{s}\n", .{h.stringify(result.asEntity().data(null))});
        }
    },
    .err => |e| std.debug.print("list failed: {s}\n", .{e.msg}),
}
```

### Common Methods

#### `data(args: ?Value) Value`

Get the entity data. Pass a map to set it.

#### `matchv(args: ?Value) Value`

Get the entity match criteria. Pass a map to set it.

#### `stream(action: []const u8, args: Value, callopts: Value) StreamResult`

Run an operation through the pipeline and materialise its result items.
`StreamResult` is `.ok` with the items, or `.err` with the error that
failed the operation, as an operation call reports it. Under `throw: false`
in `callopts.ctrl`, a failed stream is `.ok` with whatever data the
failure left.

#### `get_name() []const u8`

Return the entity name.


---

## SentRcsMessageEntity

```zig
const sent_rcs_message = client.sent_rcs_message(h.vnull());
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `content` | `Value (object)` | No | RCS message content in RCS JSON format. |
| `phone_number` | `[]const u8` | Yes | Recipient phone number (e.g. |
| `sender` | `[]const u8` | Yes | RCS sender ID (object ID of the agent/sender the user has access to). |
| `text` | `[]const u8` | No | Plain text message content. |

### Operations

#### `create(reqdata: Value, ctrl: Value) EntResult`

Create a new entity with the given data. `.ok` carries the created entity.

```zig
switch (client.sent_rcs_message(h.vnull()).create(h.jo(&.{
    .{ "phone_number", h.vstr("example_phone_number") }, // []const u8
    .{ "sender", h.vstr("example_sender") }, // []const u8
}), h.vnull())) {
    .ok => |result| std.debug.print("{s}\n", .{h.stringify(result.asEntity().data(null))}),
    .err => |e| std.debug.print("create failed: {s}\n", .{e.msg}),
}
```

### Common Methods

#### `data(args: ?Value) Value`

Get the entity data. Pass a map to set it.

#### `matchv(args: ?Value) Value`

Get the entity match criteria. Pass a map to set it.

#### `stream(action: []const u8, args: Value, callopts: Value) StreamResult`

Run an operation through the pipeline and materialise its result items.
`StreamResult` is `.ok` with the items, or `.err` with the error that
failed the operation, as an operation call reports it. Under `throw: false`
in `callopts.ctrl`, a failed stream is `.ok` with whatever data the
failure left.

#### `get_name() []const u8`

Return the entity name.


---

## ShipmentCountryVolumeEntity

```zig
const shipment_country_volume = client.shipment_country_volume(h.vnull());
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `country_code` | `[]const u8` | No |  |
| `country_limit` | `i64` | No |  |
| `country_name` | `[]const u8` | No |  |
| `usage` | `i64` | No |  |

### Operations

#### `list(reqmatch: Value, ctrl: Value) EntListResult`

List entities matching the given criteria. The match is optional — pass `h.vnull()` to list all records. `.ok` is a slice of entities, one per record.

```zig
switch (client.shipment_country_volume(h.vnull()).list(h.vnull(), h.vnull())) {
    .ok => |results| {
        for (results) |result| {
            std.debug.print("{s}\n", .{h.stringify(result.asEntity().data(null))});
        }
    },
    .err => |e| std.debug.print("list failed: {s}\n", .{e.msg}),
}
```

### Common Methods

#### `data(args: ?Value) Value`

Get the entity data. Pass a map to set it.

#### `matchv(args: ?Value) Value`

Get the entity match criteria. Pass a map to set it.

#### `stream(action: []const u8, args: Value, callopts: Value) StreamResult`

Run an operation through the pipeline and materialise its result items.
`StreamResult` is `.ok` with the items, or `.err` with the error that
failed the operation, as an operation call reports it. Under `throw: false`
in `callopts.ctrl`, a failed stream is `.ok` with whatever data the
failure left.

#### `get_name() []const u8`

Return the entity name.


---

## ShortUrlEntity

```zig
const short_url = client.short_url(h.vnull());
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `description` | `[]const u8` | No |  |
| `expire` | `[]const u8` | No |  |
| `filename` | `[]const u8` | No |  |
| `hits` | `i64` | No |  |
| `hits_unique` | `i64` | No |  |
| `id` | `[]const u8` | No |  |
| `name` | `[]const u8` | No |  |
| `short_url` | `[]const u8` | No | WHATWG URL compliant |
| `type` | `[]const u8` | No |  |
| `url` | `[]const u8` | No | WHATWG URL compliant |

### Operations

#### `create(reqdata: Value, ctrl: Value) EntResult`

Create a new entity with the given data. `.ok` carries the created entity.

```zig
switch (client.short_url(h.vnull()).create(h.jo(&.{
}), h.vnull())) {
    .ok => |result| std.debug.print("{s}\n", .{h.stringify(result.asEntity().data(null))}),
    .err => |e| std.debug.print("create failed: {s}\n", .{e.msg}),
}
```

#### `list(reqmatch: Value, ctrl: Value) EntListResult`

List entities matching the given criteria. The match is optional — pass `h.vnull()` to list all records. `.ok` is a slice of entities, one per record.

```zig
switch (client.short_url(h.vnull()).list(h.vnull(), h.vnull())) {
    .ok => |results| {
        for (results) |result| {
            std.debug.print("{s}\n", .{h.stringify(result.asEntity().data(null))});
        }
    },
    .err => |e| std.debug.print("list failed: {s}\n", .{e.msg}),
}
```

#### `load(reqmatch: Value, ctrl: Value) EntResult`

Load a single entity matching the given criteria. `.ok` carries the entity, whose record `asEntity().data(null)` reads, and `.err` the branded error.

```zig
switch (client.short_url(h.vnull()).load(h.jo(&.{.{ "id", h.vstr("short_url_id") }}), h.vnull())) {
    .ok => |result| std.debug.print("{s}\n", .{h.stringify(result.asEntity().data(null))}),
    .err => |e| std.debug.print("load failed: {s}\n", .{e.msg}),
}
```

#### `remove(reqmatch: Value, ctrl: Value) EntResult`

Remove the entity matching the given criteria. `.ok` carries the entity, marked as deleted, and `.err` the branded error.

```zig
switch (client.short_url(h.vnull()).remove(h.jo(&.{.{ "id", h.vstr("short_url_id") }}), h.vnull())) {
    .ok => |result| std.debug.print("{s}\n", .{h.stringify(result.asEntity().data(null))}),
    .err => |e| std.debug.print("remove failed: {s}\n", .{e.msg}),
}
```

#### `update(reqdata: Value, ctrl: Value) EntResult`

Update an existing entity. The data must include the entity id. `.ok` carries the updated entity.

```zig
switch (client.short_url(h.vnull()).update(h.jo(&.{
    .{ "id", h.vstr("short_url_id") },
    // Fields to update
}), h.vnull())) {
    .ok => |result| std.debug.print("{s}\n", .{h.stringify(result.asEntity().data(null))}),
    .err => |e| std.debug.print("update failed: {s}\n", .{e.msg}),
}
```

Declares a `application/x-www-form-urlencoded` body, which this SDK does not encode yet: it sends the data as JSON.

### Common Methods

#### `data(args: ?Value) Value`

Get the entity data. Pass a map to set it.

#### `matchv(args: ?Value) Value`

Get the entity match criteria. Pass a map to set it.

#### `stream(action: []const u8, args: Value, callopts: Value) StreamResult`

Run an operation through the pipeline and materialise its result items.
`StreamResult` is `.ok` with the items, or `.err` with the error that
failed the operation, as an operation call reports it. Under `throw: false`
in `callopts.ctrl`, a failed stream is `.ok` with whatever data the
failure left.

#### `get_name() []const u8`

Return the entity name.


---

## SmsdoEntity

```zig
const smsdo = client.smsdo(h.vnull());
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `allow_duplicates` | `i64` | No | When parameter allow_duplicates is set to "1" allows to send message to duplicated numbers in one request (useful i.e. |
| `check_idx` | `Value` | No | When parameter check_idx is set to „1” prevents from sending more than one message with the same idx in last 24h. |
| `date` | `Value` | No | Date in UNIX timestamp (&date=1287734110) or in ISO 8601 (&date=2012-05-10T08:40:27+00:00) when message will be sent (&date=1287734110). |
| `date_validate` | `i64` | No | When parameter date_validate is set to "1" checks if date if given in proper format. |
| `details` | `Value` | No | When details parameter is set to "1" more details in response will be displayed (message length and sms count). |
| `encoding` | `[]const u8` | No | This parameter describes the encoding of the message text. |
| `expiration_date` | `Value` | No | Message expiration date (in UNIX timestamp or in ISO 8601) is a date after which message won't be delivered if it wasn't delivered yet. |
| `fallback` | `Value (array)` | No | Enable fallback in case sms sending fails |
| `fast` | `i64` | No | Setting this parameter to „1” will result in sending message with the highest priority which ensures the quickest possible time of delivery. |
| `flash` | `i64` | No | Sending a message in flash mode can be activated by setting this parameter to "1". |
| `format` | `[]const u8` | No | Parameter &format=json causes, that response is sending in JSON format. |
| `from` | `[]const u8` | No | Name of the sender. |
| `group` | `[]const u8` | No | Name of the group from the contacts database to which message should be sent to. |
| `idx` | `[]const u8` | No | Optional custom value sent with SMS and sent back in CALLBACK. |
| `max_parts` | `i64` | No | Defines maximum message parts allowed, maximum value allowed is 6. |
| `message` | `[]const u8` | No | The message text. |
| `normalize` | `i64` | No | When parameter normalize is set to „1” special chars in message will be replaced with their equivalents (ê-e, ñ-n, ý-y ...). |
| `notify_url` | `[]const u8` | No | Parameter allows to set CALLBACK URL for message from request. |
| `test` | `Value` | No | When parameter test is set to "1" message won't be sent but response will be displayed, there is no charge for such test messages. |
| `time_restriction` | `[]const u8` | No | Sets the behavior when you try to ship in hours / dates that do not match the settings in your account. |
| `to` | `[]const u8` | No | Recipients' mobile phone numbers (i.e. |

### Operations

#### `create(reqdata: Value, ctrl: Value) EntResult`

Create a new entity with the given data. `.ok` carries the created entity.

```zig
switch (client.smsdo(h.vnull()).create(h.jo(&.{
}), h.vnull())) {
    .ok => |result| std.debug.print("{s}\n", .{h.stringify(result.asEntity().data(null))}),
    .err => |e| std.debug.print("create failed: {s}\n", .{e.msg}),
}
```

### Common Methods

#### `data(args: ?Value) Value`

Get the entity data. Pass a map to set it.

#### `matchv(args: ?Value) Value`

Get the entity match criteria. Pass a map to set it.

#### `stream(action: []const u8, args: Value, callopts: Value) StreamResult`

Run an operation through the pipeline and materialise its result items.
`StreamResult` is `.ok` with the items, or `.err` with the error that
failed the operation, as an operation call reports it. Under `throw: false`
in `callopts.ctrl`, a failed stream is `.ok` with whatever data the
failure left.

#### `get_name() []const u8`

Return the entity name.


---

## SmssendernameEntity

```zig
const smssendername = client.smssendername(h.vnull());
```

### Operations

#### `create(reqdata: Value, ctrl: Value) EntResult`

Create a new entity with the given data. `.ok` carries the created entity.

```zig
switch (client.smssendername(h.vnull()).create(h.jo(&.{
    .{ "sender", h.vstr("example_sender") }, // []const u8
}), h.vnull())) {
    .ok => |result| std.debug.print("{s}\n", .{h.stringify(result.asEntity().data(null))}),
    .err => |e| std.debug.print("create failed: {s}\n", .{e.msg}),
}
```

#### `remove(reqmatch: Value, ctrl: Value) EntResult`

Remove the entity matching the given criteria. `.ok` carries the entity, marked as deleted, and `.err` the branded error.

```zig
switch (client.smssendername(h.vnull()).remove(h.jo(&.{.{ "sender", h.vstr("sender") }}), h.vnull())) {
    .ok => |result| std.debug.print("{s}\n", .{h.stringify(result.asEntity().data(null))}),
    .err => |e| std.debug.print("remove failed: {s}\n", .{e.msg}),
}
```

### Common Methods

#### `data(args: ?Value) Value`

Get the entity data. Pass a map to set it.

#### `matchv(args: ?Value) Value`

Get the entity match criteria. Pass a map to set it.

#### `stream(action: []const u8, args: Value, callopts: Value) StreamResult`

Run an operation through the pipeline and materialise its result items.
`StreamResult` is `.ok` with the items, or `.err` with the error that
failed the operation, as an operation call reports it. Under `throw: false`
in `callopts.ctrl`, a failed stream is `.ok` with whatever data the
failure left.

#### `get_name() []const u8`

Return the entity name.


---

## SmstemplateEntity

```zig
const smstemplate = client.smstemplate(h.vnull());
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | `[]const u8` | No |  |

### Operations

#### `remove(reqmatch: Value, ctrl: Value) EntResult`

Remove the entity matching the given criteria. `.ok` carries the entity, marked as deleted, and `.err` the branded error.

```zig
switch (client.smstemplate(h.vnull()).remove(h.jo(&.{.{ "id", h.vstr("id") }}), h.vnull())) {
    .ok => |result| std.debug.print("{s}\n", .{h.stringify(result.asEntity().data(null))}),
    .err => |e| std.debug.print("remove failed: {s}\n", .{e.msg}),
}
```

### Common Methods

#### `data(args: ?Value) Value`

Get the entity data. Pass a map to set it.

#### `matchv(args: ?Value) Value`

Get the entity match criteria. Pass a map to set it.

#### `stream(action: []const u8, args: Value, callopts: Value) StreamResult`

Run an operation through the pipeline and materialise its result items.
`StreamResult` is `.ok` with the items, or `.err` with the error that
failed the operation, as an operation call reports it. Under `throw: false`
in `callopts.ctrl`, a failed stream is `.ok` with whatever data the
failure left.

#### `get_name() []const u8`

Return the entity name.


---

## SubuserEntity

```zig
const subuser = client.subuser(h.vnull());
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `active` | `bool` | No |  |
| `credentials` | `Value (object)` | Yes |  |
| `description` | `[]const u8` | No |  |
| `id` | `[]const u8` | No | Object ID |
| `points` | `Value (object)` | No |  |
| `username` | `[]const u8` | No |  |

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

#### `create(reqdata: Value, ctrl: Value) EntResult`

Create a new entity with the given data. `.ok` carries the created entity.

```zig
switch (client.subuser(h.vnull()).create(h.jo(&.{
    .{ "credentials", h.omap() }, // Value (object)
}), h.vnull())) {
    .ok => |result| std.debug.print("{s}\n", .{h.stringify(result.asEntity().data(null))}),
    .err => |e| std.debug.print("create failed: {s}\n", .{e.msg}),
}
```

#### `list(reqmatch: Value, ctrl: Value) EntListResult`

List entities matching the given criteria. The match is optional — pass `h.vnull()` to list all records. `.ok` is a slice of entities, one per record.

```zig
switch (client.subuser(h.vnull()).list(h.vnull(), h.vnull())) {
    .ok => |results| {
        for (results) |result| {
            std.debug.print("{s}\n", .{h.stringify(result.asEntity().data(null))});
        }
    },
    .err => |e| std.debug.print("list failed: {s}\n", .{e.msg}),
}
```

#### `load(reqmatch: Value, ctrl: Value) EntResult`

Load a single entity matching the given criteria. `.ok` carries the entity, whose record `asEntity().data(null)` reads, and `.err` the branded error.

```zig
switch (client.subuser(h.vnull()).load(h.jo(&.{.{ "id", h.vstr("subuser_id") }}), h.vnull())) {
    .ok => |result| std.debug.print("{s}\n", .{h.stringify(result.asEntity().data(null))}),
    .err => |e| std.debug.print("load failed: {s}\n", .{e.msg}),
}
```

#### `remove(reqmatch: Value, ctrl: Value) EntResult`

Remove the entity matching the given criteria. `.ok` carries the entity, marked as deleted, and `.err` the branded error.

```zig
switch (client.subuser(h.vnull()).remove(h.jo(&.{.{ "id", h.vstr("subuser_id") }}), h.vnull())) {
    .ok => |result| std.debug.print("{s}\n", .{h.stringify(result.asEntity().data(null))}),
    .err => |e| std.debug.print("remove failed: {s}\n", .{e.msg}),
}
```

#### `update(reqdata: Value, ctrl: Value) EntResult`

Update an existing entity. The data must include the entity id. `.ok` carries the updated entity.

```zig
switch (client.subuser(h.vnull()).update(h.jo(&.{
    .{ "id", h.vstr("subuser_id") },
    // Fields to update
}), h.vnull())) {
    .ok => |result| std.debug.print("{s}\n", .{h.stringify(result.asEntity().data(null))}),
    .err => |e| std.debug.print("update failed: {s}\n", .{e.msg}),
}
```

### Common Methods

#### `data(args: ?Value) Value`

Get the entity data. Pass a map to set it.

#### `matchv(args: ?Value) Value`

Get the entity match criteria. Pass a map to set it.

#### `stream(action: []const u8, args: Value, callopts: Value) StreamResult`

Run an operation through the pipeline and materialise its result items.
`StreamResult` is `.ok` with the items, or `.err` with the error that
failed the operation, as an operation call reports it. Under `throw: false`
in `callopts.ctrl`, a failed stream is `.ok` with whatever data the
failure left.

#### `get_name() []const u8`

Return the entity name.


---

## TemplateEntity

```zig
const template = client.template(h.vnull());
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | `[]const u8` | No |  |
| `name` | `[]const u8` | No |  |
| `normalize` | `bool` | No |  |
| `template` | `[]const u8` | No |  |

### Operations

#### `create(reqdata: Value, ctrl: Value) EntResult`

Create a new entity with the given data. `.ok` carries the created entity.

```zig
switch (client.template(h.vnull()).create(h.jo(&.{
}), h.vnull())) {
    .ok => |result| std.debug.print("{s}\n", .{h.stringify(result.asEntity().data(null))}),
    .err => |e| std.debug.print("create failed: {s}\n", .{e.msg}),
}
```

Declares a `application/x-www-form-urlencoded` body, which this SDK does not encode yet: it sends the data as JSON.

#### `list(reqmatch: Value, ctrl: Value) EntListResult`

List entities matching the given criteria. The match is optional — pass `h.vnull()` to list all records. `.ok` is a slice of entities, one per record.

```zig
switch (client.template(h.vnull()).list(h.vnull(), h.vnull())) {
    .ok => |results| {
        for (results) |result| {
            std.debug.print("{s}\n", .{h.stringify(result.asEntity().data(null))});
        }
    },
    .err => |e| std.debug.print("list failed: {s}\n", .{e.msg}),
}
```

#### `load(reqmatch: Value, ctrl: Value) EntResult`

Load a single entity matching the given criteria. `.ok` carries the entity, whose record `asEntity().data(null)` reads, and `.err` the branded error.

```zig
switch (client.template(h.vnull()).load(h.jo(&.{.{ "id", h.vstr("template_id") }}), h.vnull())) {
    .ok => |result| std.debug.print("{s}\n", .{h.stringify(result.asEntity().data(null))}),
    .err => |e| std.debug.print("load failed: {s}\n", .{e.msg}),
}
```

#### `update(reqdata: Value, ctrl: Value) EntResult`

Update an existing entity. The data must include the entity id. `.ok` carries the updated entity.

```zig
switch (client.template(h.vnull()).update(h.jo(&.{
    .{ "id", h.vstr("template_id") },
    // Fields to update
}), h.vnull())) {
    .ok => |result| std.debug.print("{s}\n", .{h.stringify(result.asEntity().data(null))}),
    .err => |e| std.debug.print("update failed: {s}\n", .{e.msg}),
}
```

Declares a `application/x-www-form-urlencoded` body, which this SDK does not encode yet: it sends the data as JSON.

### Common Methods

#### `data(args: ?Value) Value`

Get the entity data. Pass a map to set it.

#### `matchv(args: ?Value) Value`

Get the entity match criteria. Pass a map to set it.

#### `stream(action: []const u8, args: Value, callopts: Value) StreamResult`

Run an operation through the pipeline and materialise its result items.
`StreamResult` is `.ok` with the items, or `.err` with the error that
failed the operation, as an operation call reports it. Under `throw: false`
in `callopts.ctrl`, a failed stream is `.ok` with whatever data the
failure left.

#### `get_name() []const u8`

Return the entity name.


---

## UserRcsSenderCollectionEntity

```zig
const user_rcs_sender_collection = client.user_rcs_sender_collection(h.vnull());
```

### Operations

#### `list(reqmatch: Value, ctrl: Value) EntListResult`

List entities matching the given criteria. The match is optional — pass `h.vnull()` to list all records. `.ok` is a slice of entities, one per record.

```zig
switch (client.user_rcs_sender_collection(h.vnull()).list(h.vnull(), h.vnull())) {
    .ok => |results| {
        for (results) |result| {
            std.debug.print("{s}\n", .{h.stringify(result.asEntity().data(null))});
        }
    },
    .err => |e| std.debug.print("list failed: {s}\n", .{e.msg}),
}
```

### Common Methods

#### `data(args: ?Value) Value`

Get the entity data. Pass a map to set it.

#### `matchv(args: ?Value) Value`

Get the entity match criteria. Pass a map to set it.

#### `stream(action: []const u8, args: Value, callopts: Value) StreamResult`

Run an operation through the pipeline and materialise its result items.
`StreamResult` is `.ok` with the items, or `.err` with the error that
failed the operation, as an operation call reports it. Under `throw: false`
in `callopts.ctrl`, a failed stream is `.ok` with whatever data the
failure left.

#### `get_name() []const u8`

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

```zig
const client = sdk.SmsapiSDK.new(h.jo(&.{
    .{ "feature", h.jo(&.{
        .{ "audit", h.jo(&.{.{ "active", h.vbool(true) }}) },
        .{ "cache", h.jo(&.{.{ "active", h.vbool(true) }}) },
        .{ "clienttrack", h.jo(&.{.{ "active", h.vbool(true) }}) },
        .{ "cost", h.jo(&.{.{ "active", h.vbool(true) }}) },
        .{ "debug", h.jo(&.{.{ "active", h.vbool(true) }}) },
        .{ "idempotency", h.jo(&.{.{ "active", h.vbool(true) }}) },
        .{ "log", h.jo(&.{.{ "active", h.vbool(true) }}) },
        .{ "metrics", h.jo(&.{.{ "active", h.vbool(true) }}) },
        .{ "netsim", h.jo(&.{.{ "active", h.vbool(true) }}) },
        .{ "paging", h.jo(&.{.{ "active", h.vbool(true) }}) },
        .{ "proxy", h.jo(&.{.{ "active", h.vbool(true) }}) },
        .{ "ratelimit", h.jo(&.{.{ "active", h.vbool(true) }}) },
        .{ "rbac", h.jo(&.{.{ "active", h.vbool(true) }}) },
        .{ "retry", h.jo(&.{.{ "active", h.vbool(true) }}) },
        .{ "secrets", h.jo(&.{.{ "active", h.vbool(true) }}) },
        .{ "streaming", h.jo(&.{.{ "active", h.vbool(true) }}) },
        .{ "telemetry", h.jo(&.{.{ "active", h.vbool(true) }}) },
        .{ "test", h.jo(&.{.{ "active", h.vbool(true) }}) },
        .{ "timeout", h.jo(&.{.{ "active", h.vbool(true) }}) },
        .{ "validate", h.jo(&.{.{ "active", h.vbool(true) }}) },
    }) },
}));
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

