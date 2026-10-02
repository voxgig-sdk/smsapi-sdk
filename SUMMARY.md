# SMSAPI REST API

> [SMSAPI.com main page](https://www.smsapi.com/)
>
> [API documentation](https://www.smsapi.com/docs)
> ### URL adresses
> API URL adresses:
> * `https://api.smsapi.com/` - for secure SSL connections
> * `https://api2.smsapi.com/` - backup for secure SSL connections
>
> ### Authorization
> Authorization at SMSAPI utilizes OAuth 2 mechanism.
> You can generate OAuth token in our customer panel [API Tokens](https://ssl.smsapi.com/react/oauth/manage).
> Authorization header will be necessary in request to our API.
>
> `Authorization: Bearer &lt;token&gt;`

## Start here

This guide introduces the API, the client libraries, and the companion tools in this repository. Start with the API capabilities, choose a client for your application, and use the linked reference when you need exact request and response details.

The selected API surface contains 28 entities and 89 HTTP routes. There are 13 SDK targets and 3 companion tools.

An entity groups related API operations. An operation can have several routes with different inputs or authentication requirements. The SDK exposes the entity and its operations using the conventions of the selected language.

## What the API provides

### Available

Results: List.

SDK operations: `list`.

### Blacklist

Results: Blacklist phone number created; Import accepted; Blacklist phone numbers; CSV file generation started; No blacklist phone numbers to export; Blacklist phone number deleted; Blacklist phone numbers deleted.

SDK operations: `create`, `load`, `remove`.

Key fields to recognise:

- `id`: Object ID

### Callback

Results: Callback created; Callbacks list; Callback; Callback test result; Callback deleted; Callback updated; Callback activation started; Callback deactivation started.

SDK operations: `create`, `list`, `load`, `remove`, `update`.

Key fields to recognise:

- `api_version`: Version of the callback output format. Supported values depend on the callback type; when omitted on creation the default version of the given type is used.
- `id`: Object ID
- `url`: WHATWG URL compliant

### Contact

Results: No contact-group association created, contact not assigned to any new group; Groups collection; Contacts collection; Contact to group association deleted; Contact deleted; Contacts deleted.

SDK operations: `create`, `list`, `load`, `remove`, `update`.

Key fields to recognise:

- `collection`: Always empty
- `contact_expire_after`: Contact expire after days
- `group_id`: Object ID
- `id`: Object ID
- `idx`: User provided resource id

### ContactsField

Results: Fields collection; Contact field deleted.

SDK operations: `create`, `list`, `remove`, `update`.

Key fields to recognise:

- `contact_expire_after`: Contact expire after days
- `group_id`: Object ID
- `id`: Object ID
- `idx`: User provided resource id
- `name`: Group name

### ContactsFieldOption

Results: Field options collection.

SDK operations: `list`.

Key fields to recognise:

- `contact_expire_after`: Contact expire after days
- `group_id`: Object ID
- `id`: Object ID
- `idx`: User provided resource id
- `name`: Group name

### Contactsgroup

Results: Command accepted; Command executed; Groups collection; Group permissions collection; Contact to group association deleted; Permission deleted; Group deleted; Groups deleted.

SDK operations: `create`, `list`, `remove`, `update`.

Key fields to recognise:

- `contact_expire_after`: Contact expire after days
- `group_id`: Object ID
- `id`: Object ID
- `idx`: User provided resource id
- `name`: Group name

### Contactstrash

Results: Command accepted - trash will be deleted; Command not accepted - no trash; Command accepted - trash will be restored; Commad not accepted - no trash.

SDK operations: `remove`, `update`.

### FieldAvailable

SDK operations: `list`.

Key fields to recognise:

- `id`: Object ID

### Group

SDK operations: `load`, `update`.

Key fields to recognise:

- `contact_expire_after`: Contact expire after days
- `id`: Object ID
- `idx`: User provided resource id
- `name`: Group name

### MfaCode

Results: MFA code created; MFA confirmed.

SDK operations: `create`.

Key fields to recognise:

- `content`: Custom content that must contain placeholder [%code%]
- `from`: Sendername

### OptOut

Results: Opt-Out list; Opt-Out deleted.

SDK operations: `list`, `remove`.

### OptOutSetting

Results: Opt-Out company presentation.

SDK operations: `load`, `update`.

### Permission

SDK operations: `create`, `load`.

Key fields to recognise:

- `group_id`: Object ID
- `read`: Has read permission
- `send`: Has send permission
- `write`: Has write permission

### Ping

Results: Success.

SDK operations: `list`.

### Profile

SDK operations: `list`, `load`.

### Rcs

SDK operations: `list`.

### Sendername

SDK operations: `create`, `list`, `load`.

Key fields to recognise:

- `sender`: Sendername

### SendernameStatement

SDK operations: `list`.

### SentRcsMessage

Results: RCS message has been sent.

SDK operations: `create`.

Key fields to recognise:

- `content`: RCS message content in RCS JSON format.
- `phone_number`: Recipient phone number (for example
- `text`: Plain text message content.

### ShipmentCountryVolume

Results: Shipment countries volumes.

SDK operations: `list`.

### ShortUrl

Results: Short URL created.; Short URL links.; Short URL.; Short URL deleted.; Short URL updated.

SDK operations: `create`, `list`, `load`, `remove`, `update`.

Key fields to recognise:

- `short_url`: WHATWG URL compliant
- `url`: WHATWG URL compliant

### Smsdo

SDK operations: `create`.

Key fields to recognise:

- `allow_duplicates`: When parameter `allow_duplicates` is set to &quot;1&quot; allows to send message to duplicated numbers in one request (useful that is
- `check_idx`: When parameter `check_idx` is set to „1” prevents from sending more than one message with the same idx in last 24h.
- `date`: Date in UNIX timestamp (&amp;date=1287734110) or in ISO 8601 (&amp;date=2012-05-10T08:40:27+00:00) when message will be sent (&amp;date=1287734110).
- `date_validate`: When parameter `date_validate` is set to &quot;1&quot; checks if date if given in proper format.
- `details`: When details parameter is set to &quot;1&quot; more details in response will be displayed (message length and sms count).

### Smssendername

Results: Sendername made as default; Delete sendername.

SDK operations: `create`, `remove`.

### Smstemplate

Results: Delete.

SDK operations: `remove`.

### Subuser

Results: Subuser deleted; Subuser native sendernames access updated; Subuser native templates access updated.

SDK operations: `create`, `list`, `load`, `remove`, `update`.

Key fields to recognise:

- `id`: Object ID

### Template

Results: Created; List.

SDK operations: `create`, `list`, `load`, `update`.

### UserRcsSenderCollection

SDK operations: `list`.

Key fields to recognise:

- `id`: Object ID
- `interface`: Interface through which the message was sent (www, api, ...).
- `messageType`: RCS message type (basic, single, ...).
- `recipient`: Recipient phone number (without +).
- `sender`: Sender name

### Route map

Use this map to locate a capability. Consult the entity reference before supplying request data; routes for the same operation can require different fields.

| Entity | SDK operation | HTTP route | Authentication |
| --- | --- | --- | --- |
| Available | `list` | `GET /sms/templates/available` | Required |
| Blacklist | `create` | `POST /blacklist/phone_numbers` | Required |
| Blacklist | `create` | `POST /blacklist/phone_numbers/imports` | Required |
| Blacklist | `load` | `GET /blacklist/phone_numbers` | Required |
| Blacklist | `remove` | `DELETE /blacklist/phone_numbers/{id}` | Required |
| Blacklist | `remove` | `DELETE /blacklist/phone_numbers` | Required |
| Callback | `create` | `POST /callbacks` | Required |
| Callback | `list` | `GET /callbacks` | Required |
| Callback | `load` | `GET /callbacks/{id}` | Required |
| Callback | `load` | `GET /callbacks/{id}/commands/test` | Required |
| Callback | `remove` | `DELETE /callbacks/{id}` | Required |
| Callback | `update` | `PUT /callbacks/{id}` | Required |
| Callback | `update` | `PUT /callbacks/{id}/commands/activate` | Required |
| Callback | `update` | `PUT /callbacks/{id}/commands/deactivate` | Required |
| Contact | `create` | `POST /contacts/{contactId}/groups` | Required |
| Contact | `create` | `POST /contacts` | Required |
| Contact | `list` | `GET /contacts` | Required |
| Contact | `list` | `GET /contacts/{contactId}/groups` | Required |
| Contact | `load` | `GET /contacts/groups/{groupId}/members/{contactId}` | Required |
| Contact | `load` | `GET /contacts/{contactId}/groups/{groupId}` | Required |
| Contact | `load` | `GET /contacts/{contactId}` | Required |
| Contact | `remove` | `DELETE /contacts/{contactId}/groups/{groupId}` | Required |
| Contact | `remove` | `DELETE /contacts/{contactId}` | Required |
| Contact | `remove` | `DELETE /contacts` | Required |
| Contact | `update` | `PUT /contacts/groups/{groupId}/members/{contactId}` | Required |
| Contact | `update` | `PUT /contacts/{contactId}/groups/{groupId}` | Required |
| Contact | `update` | `PUT /contacts/{contactId}` | Required |
| ContactsField | `create` | `POST /contacts/fields` | Required |
| ContactsField | `list` | `GET /contacts/fields` | Required |
| ContactsField | `remove` | `DELETE /contacts/fields/{fieldId}` | Required |
| ContactsField | `update` | `PUT /contacts/fields/{fieldId}` | Required |
| ContactsFieldOption | `list` | `GET /contacts/fields/{fieldId}/options` | Required |
| Contactsgroup | `create` | `POST /contacts/groups/{groupId}/members` | Required |
| Contactsgroup | `create` | `POST /contacts/groups` | Required |
| Contactsgroup | `list` | `GET /contacts/groups` | Required |
| Contactsgroup | `list` | `GET /contacts/groups/{groupId}/permissions` | Required |
| Contactsgroup | `remove` | `DELETE /contacts/groups/{groupId}/members/{contactId}` | Required |
| Contactsgroup | `remove` | `DELETE /contacts/groups/{groupId}/permissions/{username}` | Required |
| Contactsgroup | `remove` | `DELETE /contacts/groups/{groupId}` | Required |
| Contactsgroup | `remove` | `DELETE /contacts/groups/{groupId}/members` | Required |
| Contactsgroup | `remove` | `DELETE /contacts/groups` | Required |
| Contactsgroup | `update` | `PUT /contacts/groups/{groupId}/permissions/{username}` | Required |
| Contactsgroup | `update` | `PUT /contacts/groups/{groupId}/members` | Required |
| Contactstrash | `remove` | `DELETE /contacts/trash` | Required |
| Contactstrash | `update` | `PUT /contacts/trash/restore` | Required |
| FieldAvailable | `list` | `GET /contacts/fields/available` | Required |
| Group | `load` | `GET /contacts/groups/{groupId}` | Required |
| Group | `update` | `PUT /contacts/groups/{groupId}` | Required |
| MfaCode | `create` | `POST /mfa/codes` | Required |
| MfaCode | `create` | `POST /mfa/codes/verifications` | Required |
| OptOut | `list` | `GET /opt_outs` | Required |
| OptOut | `remove` | `DELETE /opt_outs/{optOutId}` | Required |
| OptOutSetting | `load` | `GET /opt_outs/settings` | Required |
| OptOutSetting | `update` | `PUT /opt_outs/settings` | Required |
| Permission | `create` | `POST /contacts/groups/{groupId}/permissions` | Required |
| Permission | `load` | `GET /contacts/groups/{groupId}/permissions/{username}` | Required |
| Ping | `list` | `GET /ping` | Required |
| Profile | `list` | `GET /profile/prices` | Required |
| Profile | `load` | `GET /profile` | Required |
| Rcs | `list` | `GET /rcs/messages` | Required |
| Sendername | `create` | `POST /sms/sendernames` | Required |
| Sendername | `list` | `GET /sms/sendernames` | Required |
| Sendername | `load` | `GET /sms/sendernames/{sender}` | Required |
| SendernameStatement | `list` | `GET /sms/sendernames/statement` | Required |
| SentRcsMessage | `create` | `POST /rcs/messages` | Required |
| ShipmentCountryVolume | `list` | `GET /shipment/country_volumes` | Required |
| ShortUrl | `create` | `POST /short_url/links` | Required |
| ShortUrl | `list` | `GET /short_url/links` | Required |
| ShortUrl | `load` | `GET /short_url/links/{id}` | Required |
| ShortUrl | `remove` | `DELETE /short_url/links/{id}` | Required |
| ShortUrl | `update` | `PUT /short_url/links/{id}` | Required |
| Smsdo | `create` | `POST /sms.do` | Required |
| Smssendername | `create` | `POST /sms/sendernames/{sender}/commands/make_default` | Required |
| Smssendername | `remove` | `DELETE /sms/sendernames/{sender}` | Required |
| Smstemplate | `remove` | `DELETE /sms/templates/{id}` | Required |
| Subuser | `create` | `POST /subusers` | Required |
| Subuser | `list` | `GET /subusers/{id}/shares/sendernames` | Required |
| Subuser | `list` | `GET /subusers/{id}/shares/templates` | Required |
| Subuser | `list` | `GET /subusers` | Required |
| Subuser | `load` | `GET /subusers/{id}` | Required |
| Subuser | `remove` | `DELETE /subusers/{id}` | Required |
| Subuser | `update` | `PUT /subusers/{id}` | Required |
| Subuser | `update` | `PUT /subusers/{id}/shares/sendernames` | Required |
| Subuser | `update` | `PUT /subusers/{id}/shares/templates` | Required |
| Template | `create` | `POST /sms/templates` | Required |
| Template | `list` | `GET /sms/templates` | Required |
| Template | `load` | `GET /sms/templates/{id}` | Required |
| Template | `update` | `PUT /sms/templates/{id}` | Required |
| UserRcsSenderCollection | `list` | `GET /rcs/senders` | Required |

## Connect to the API

- API server: `https://api.smsapi.com`
- API server: `https://api2.smsapi.com`

The default credential is sent in the `Authorization` header with the `Bearer` prefix.

Check authentication for the route you plan to call. A route that declares no authentication can be used without credentials; this does not change the requirements of other routes. Keep credentials in environment variables or a configured secret provider, and keep them out of source control and logs.

## Make a first request

1. Choose the API server and an operation that matches your task.
2. Check the operation’s required input and authentication. Use values valid for your account and environment.
3. Send one request and inspect the returned data before adding retries, concurrency, or a larger batch.

For an SDK call, install or build the chosen client, create a client instance with its documented configuration, and call the required entity operation. Language references describe the argument shape, asynchronous behaviour, and returned values.

## Choose an SDK

Choose the language already used by your application or service. The clients represent the same API model, while package setup, naming, and return types follow each language. Check the selected client’s reference and tests before integrating it into an existing application.

| Client | Repository directory | Distribution |
| --- | --- | --- |
| Clojure | `clojure/` | Build from source |
| C++ | `cpp/` | Build from source |
| C# | `csharp/` | Build from source |
| Elixir | `elixir/` | Build from source |
| Golang | `go/` | Build from source |
| Java | `java/` | Build from source |
| Kotlin | `kotlin/` | Build from source |
| Lua | `lua/` | Build from source |
| OCaml | `ocaml/` | Build from source |
| Python | `py/` | Build from source |
| Ruby | `rb/` | Build from source |
| Swift | `swift/` | Build from source |
| Zig | `zig/` | Build from source |

Build-from-source entries are not marked as published in the project model. Follow the build instructions in that target’s README, then consume the resulting package using your language’s local dependency mechanism. Published entries give the installation command recorded for that client.

## Companion tools

These targets provide another way to use the API. Their available commands or tools can cover a smaller set of operations than the client libraries.

### Go CLI

Use the command-line interface for shell-based tasks and scripts.

Repository directory: `go-cli/`. Not published. Build from the go-cli directory.


### Go MCP server

Use the MCP server to expose supported API operations to an MCP client.

Repository directory: `go-mcp/`. Not published. Build from the go-mcp directory.

- `smsapi_list`: List records for an entity. Supported entities: `available`, `callback`, `contact`, `contacts_field`, `contacts_field_option`, `contactsgroup`, `field_available`, `opt_out`, `ping`, `profile`, `rcs`, `sendername`, `sendername_statement`, `shipment_country_volume`, `short_url`, `subuser`, `template`, `user_rcs_sender_collection`.
- `smsapi_load`: Load one record for an entity. Supported entities: `blacklist`, `callback`, `contact`, `group`, `opt_out_setting`, `permission`, `profile`, `sendername`, `short_url`, `subuser`, `template`.

### Python Data

Use the data integration for analysis and notebook workflows.

Repository directory: `py-data/`. Not published. Build from the py-data directory.


## Operational features

Features supply behaviour around API calls, such as request handling, diagnostics, or local testing. Inclusion in this project does not mean a feature is enabled at runtime. Check the selected SDK’s supported features and configuration defaults, then enable the behaviour your application needs.

- `audit`: Structured audit trail of operations
- `cache`: Response caching for safe read requests
- `clienttrack`: Client identity and per-request correlation headers
- `cost`: Cost tracking and spend budget for API calls
- `debug`: Request/response capture ring buffer for debugging
- `idempotency`: Idempotency keys for safe retries of mutating operations
- `log`: Structured request and response logging
- `metrics`: Statistics capture: per-operation counters and latency
- `netsim`: Network behaviour simulation for offline testing (latency, failures, outages)
- `paging`: Pagination signals for list operations
- `proxy`: Outbound HTTP(S) proxy routing
- `ratelimit`: Client-side rate limiting via a token bucket
- `rbac`: Client-side role/permission enforcement
- `retry`: Automatic retry of transient failures with exponential backoff
- `secrets`: Secret access: resolve the API credential through a provider chain, and exchange a refresh token for short-lived access tokens
- `streaming`: Incremental streaming of list results via async iteration
- `telemetry`: Distributed tracing spans with W3C trace-context propagation
- `test`: In-memory mock transport for testing without a live server
- `timeout`: Per-request timeout with transport abort
- `validate`: Payload validation against the model&#39;s own field types

Start with the default client configuration. Add request limits and diagnostics as needed, test error paths, and review retry behaviour before using operations that change data. A retry can repeat an operation unless the API provides a suitable guarantee.

## Continue with the documentation

- Follow the first-call guide for the setup sequence.
- Read the authentication guide before using protected routes.
- Use the API reference for request schemas, response formats, and status codes.
- Check the chosen SDK or companion tool reference for its configuration and supported operations.

