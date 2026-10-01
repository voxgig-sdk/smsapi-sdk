# Smsapi Data

SMSAPI REST as **pandas DataFrames**, for data analysts working in
notebooks. Built on the sibling [Python SDK](../py) in this repo.

```python
# Not yet on PyPI — install both packages from this repo:
!pip install "git+https://github.com/voxgig-sdk/smsapi-sdk#subdirectory=py" \
             "git+https://github.com/voxgig-sdk/smsapi-sdk#subdirectory=py-data"

from smsapi_data import data

ad = data()
df = ad.availables()          # every page, flattened, typed -> DataFrame
df.groupby("name").size()
```

No client to construct, no pagination loop to write, no `json_normalize`
boilerplate. Credentials are found automatically (see below).

## Install

This package is not on PyPI yet. Install it and the SDK it wraps straight
from the repo — in a notebook, prefix with `!`:

```sh
pip install "git+https://github.com/voxgig-sdk/smsapi-sdk#subdirectory=py" \
            "git+https://github.com/voxgig-sdk/smsapi-sdk#subdirectory=py-data"
```

Released versions are tagged at https://github.com/voxgig-sdk/smsapi-sdk/releases.

## Credentials

`data()` looks in three places, in order, and stops at the first hit:

1. the `token=` / `base_url=` arguments
2. **Colab secrets** — `SMSAPI_APIKEY`
3. **environment variables** — the same names

In Colab, open the key panel in the left sidebar, add `SMSAPI_APIKEY`, and
switch on notebook access for it. Elsewhere:

```python
import os
os.environ["SMSAPI_APIKEY"] = "your-api-key"
```

## Accessors

| Call | Entity | Returns | Columns |
|---|---|---|---|
| `availables()` | `available` | DataFrame | 3 |
| `callbacks()` | `callback` | DataFrame | 8 |
| `contacts()` | `contact` | DataFrame | 29 |
| `contacts_fields()` | `contacts_field` | DataFrame | 27 |
| `contacts_field_options()` | `contacts_field_option` | DataFrame | 27 |
| `contactsgroups()` | `contactsgroup` | DataFrame | 27 |
| `field_availables()` | `field_available` | DataFrame | 5 |
| `opt_outs()` | `opt_out` | DataFrame | 4 |
| `pings()` | `ping` | DataFrame | 2 |
| `profiles()` | `profile` | DataFrame | 7 |
| `rcs()` | `rcs` | DataFrame | 0 |
| `sendernames()` | `sendername` | DataFrame | 5 |
| `sendername_statements()` | `sendername_statement` | DataFrame | 3 |
| `shipment_country_volumes()` | `shipment_country_volume` | DataFrame | 4 |
| `short_urls()` | `short_url` | DataFrame | 10 |
| `subusers()` | `subuser` | DataFrame | 6 |
| `templates()` | `template` | DataFrame | 4 |
| `user_rcs_sender_collections()` | `user_rcs_sender_collection` | DataFrame | 10 |
| `callback(id)` | `callback` | Series | 8 |
| `contact(id)` | `contact` | Series | 29 |
| `group(id)` | `group` | Series | 10 |
| `permission(id)` | `permission` | Series | 6 |
| `sendername(id)` | `sendername` | Series | 5 |
| `short_url(id)` | `short_url` | Series | 10 |
| `subuser(id)` | `subuser` | Series | 6 |
| `template(id)` | `template` | Series | 4 |

Every frame accessor takes the same keyword arguments:

| Argument | Default | Meaning |
|---|---|---|
| `limit` | `None` (all rows) | Stop after this many rows |
| `flatten` | `1` | Nesting depth to expand into dotted columns; `"none"` or `"full"` |
| `dtype` | `True` | Apply the model's dtypes; `False` leaves pandas to infer |
| `parse_dates` | `None` | Column names to parse as UTC datetimes |
| `max_pages` | `1000` | Safety backstop for a server that always reports more |
| `quiet` | `False` | Suppress the progress line |
| `**match` | — | Anything else is passed to the API as a filter |

## Columns

### available

| Column | dtype | Required |
|---|---|---|
| `name` | `string` |  |
| `normalize` | `boolean` |  |
| `template` | `string` |  |

### callback

| Column | dtype | Required |
|---|---|---|
| `active` | `boolean` |  |
| `api_version` | `Int64` |  |
| `id` | `string` |  |
| `invalid` | `boolean` |  |
| `receiver` | `object` |  |
| `receiver_type` | `string` |  |
| `type` | `string` |  |
| `url` | `string` |  |

### contact

| Column | dtype | Required |
|---|---|---|
| `birthday_date` | `string` |  |
| `city` | `string` |  |
| `collection` | `object` | yes |
| `contact_expire_after` | `Int64` | yes |
| `contacts_count` | `Int64` | yes |
| `country` | `string` |  |
| `created_by` | `string` | yes |
| `date_created` | `string` | yes |
| `date_updated` | `string` | yes |
| `description` | `string` |  |
| `email` | `string` |  |
| `first_name` | `string` |  |
| `gender` | `string` | yes |
| `group_id` | `string` |  |
| `groups` | `object` | yes |
| `id` | `string` | yes |
| `idx` | `string` |  |
| `last_name` | `string` |  |
| `name` | `string` | yes |
| `permissions` | `object` |  |
| `phone_number` | `string` |  |
| `read` | `boolean` |  |
| `send` | `boolean` |  |
| `size` | `Int64` | yes |
| `source` | `string` |  |
| `type` | `string` |  |
| `username` | `string` |  |
| `value` | `string` |  |
| `write` | `boolean` |  |

### contacts_field

| Column | dtype | Required |
|---|---|---|
| `birthday_date` | `string` |  |
| `city` | `string` |  |
| `contact_expire_after` | `Int64` | yes |
| `contacts_count` | `Int64` |  |
| `country` | `string` |  |
| `created_by` | `string` | yes |
| `date_created` | `string` | yes |
| `date_updated` | `string` | yes |
| `description` | `string` |  |
| `email` | `string` |  |
| `first_name` | `string` |  |
| `gender` | `string` | yes |
| `group_id` | `string` |  |
| `groups` | `object` | yes |
| `id` | `string` |  |
| `idx` | `string` |  |
| `last_name` | `string` |  |
| `name` | `string` |  |
| `permissions` | `object` |  |
| `phone_number` | `string` |  |
| `read` | `boolean` |  |
| `send` | `boolean` |  |
| `source` | `string` |  |
| `type` | `string` |  |
| `username` | `string` |  |
| `value` | `string` |  |
| `write` | `boolean` |  |

### contacts_field_option

| Column | dtype | Required |
|---|---|---|
| `birthday_date` | `string` |  |
| `city` | `string` |  |
| `contact_expire_after` | `Int64` | yes |
| `contacts_count` | `Int64` |  |
| `country` | `string` |  |
| `created_by` | `string` | yes |
| `date_created` | `string` | yes |
| `date_updated` | `string` | yes |
| `description` | `string` |  |
| `email` | `string` |  |
| `first_name` | `string` |  |
| `gender` | `string` | yes |
| `group_id` | `string` |  |
| `groups` | `object` | yes |
| `id` | `string` | yes |
| `idx` | `string` |  |
| `last_name` | `string` |  |
| `name` | `string` |  |
| `permissions` | `object` |  |
| `phone_number` | `string` |  |
| `read` | `boolean` |  |
| `send` | `boolean` |  |
| `source` | `string` |  |
| `type` | `string` |  |
| `username` | `string` |  |
| `value` | `string` |  |
| `write` | `boolean` |  |

### contactsgroup

| Column | dtype | Required |
|---|---|---|
| `birthday_date` | `string` |  |
| `city` | `string` |  |
| `contact_expire_after` | `Int64` | yes |
| `contacts_count` | `Int64` |  |
| `country` | `string` |  |
| `created_by` | `string` | yes |
| `date_created` | `string` | yes |
| `date_updated` | `string` | yes |
| `description` | `string` |  |
| `email` | `string` |  |
| `first_name` | `string` |  |
| `gender` | `string` | yes |
| `group_id` | `string` | yes |
| `groups` | `object` | yes |
| `id` | `string` | yes |
| `idx` | `string` |  |
| `last_name` | `string` |  |
| `name` | `string` |  |
| `permissions` | `object` |  |
| `phone_number` | `string` |  |
| `read` | `boolean` | yes |
| `send` | `boolean` | yes |
| `source` | `string` |  |
| `type` | `string` |  |
| `username` | `string` | yes |
| `value` | `string` |  |
| `write` | `boolean` | yes |

### field_available

| Column | dtype | Required |
|---|---|---|
| `built_in` | `boolean` |  |
| `id` | `string` |  |
| `name` | `string` |  |
| `options` | `object` |  |
| `type` | `string` |  |

### opt_out

| Column | dtype | Required |
|---|---|---|
| `date` | `string` |  |
| `id` | `string` |  |
| `links` | `object` |  |
| `phoneNumber` | `Int64` |  |

### ping

| Column | dtype | Required |
|---|---|---|
| `authorized` | `boolean` | yes |
| `unavailable` | `object` | yes |

### profile

| Column | dtype | Required |
|---|---|---|
| `email` | `string` | yes |
| `name` | `string` | yes |
| `payment_type` | `string` | yes |
| `phone_number` | `Int64` | yes |
| `points` | `Float64` |  |
| `user_type` | `string` | yes |
| `username` | `string` | yes |

### rcs

No fields are declared for this entity in the API model.

### sendername

| Column | dtype | Required |
|---|---|---|
| `created_at` | `string` |  |
| `id` | `string` |  |
| `is_default` | `boolean` |  |
| `sender` | `string` |  |
| `status` | `string` |  |

### sendername_statement

| Column | dtype | Required |
|---|---|---|
| `content` | `string` |  |
| `statements` | `object` |  |
| `title` | `string` |  |

### shipment_country_volume

| Column | dtype | Required |
|---|---|---|
| `country_code` | `string` |  |
| `country_limit` | `Int64` |  |
| `country_name` | `string` |  |
| `usage` | `Int64` |  |

### short_url

| Column | dtype | Required |
|---|---|---|
| `description` | `string` |  |
| `expire` | `string` |  |
| `filename` | `string` |  |
| `hits` | `Int64` |  |
| `hits_unique` | `Int64` |  |
| `id` | `string` |  |
| `name` | `string` |  |
| `short_url` | `string` |  |
| `type` | `string` |  |
| `url` | `string` |  |

### subuser

| Column | dtype | Required |
|---|---|---|
| `active` | `boolean` |  |
| `credentials` | `object` | yes |
| `description` | `string` |  |
| `id` | `string` |  |
| `points` | `object` |  |
| `username` | `string` |  |

### template

| Column | dtype | Required |
|---|---|---|
| `id` | `string` |  |
| `name` | `string` |  |
| `normalize` | `boolean` |  |
| `template` | `string` |  |

### user_rcs_sender_collection

| Column | dtype | Required |
|---|---|---|
| `deliveredAt` | `string` |  |
| `expiredAt` | `string` |  |
| `id` | `string` |  |
| `interface` | `string` |  |
| `messageType` | `string` |  |
| `readAt` | `string` |  |
| `recipient` | `string` |  |
| `sender` | `string` |  |
| `senderId` | `string` |  |
| `sentAt` | `string` |  |

### group

| Column | dtype | Required |
|---|---|---|
| `contact_expire_after` | `Int64` | yes |
| `contacts_count` | `Int64` | yes |
| `created_by` | `string` | yes |
| `date_created` | `string` | yes |
| `date_updated` | `string` | yes |
| `description` | `string` | yes |
| `id` | `string` | yes |
| `idx` | `string` |  |
| `name` | `string` | yes |
| `permissions` | `object` |  |

### permission

| Column | dtype | Required |
|---|---|---|
| `group_id` | `string` | yes |
| `id` | `string` |  |
| `read` | `boolean` | yes |
| `send` | `boolean` | yes |
| `username` | `string` | yes |
| `write` | `boolean` | yes |


## How it works

- **Every page, eagerly.** Analysts want the whole table, not an iterator. The
  SDK's paging feature already normalises `Link: rel="next"`, `X-Next-Page`
  and body-level `cursor`/`hasMore` signals; this package just drives them to
  exhaustion. `limit=` stops early; `max_pages` is a backstop against a
  server that never stops offering more.
- **Nullable dtypes.** Columns use pandas' nullable types (`Int64`, not
  `int64`). Optional fields are omitted freely by APIs, and NumPy's `int64`
  cannot hold a null — it would silently upcast to `float64` partway through a
  fetch, making a column's type depend on which rows came back.
- **One level of flattening.** `{"a": {"b": 1}}` becomes column `a.b`. Full
  recursive flattening turns a deep payload into an unusable 400-column frame,
  so deeper structures stay boxed in object columns.
- **Dates are never guessed.** The API model carries no date formats, so a
  date-looking string stays a string until you ask: `parse_dates=["created"]`.
- **Your data wins.** If a column will not convert to its declared dtype it is
  left as-is rather than raising. A usable frame with one object column beats
  an exception.

## What this package does not do

- **Writes.** Create, update and delete are not exposed. Use `ad.sdk` for
  those — a generated bulk-write path against a live API is a liability, not a
  convenience.
- **Endpoints without a list or load op.** Use `ad.sdk` and shape the result
  with `ad.frame(result)`.

```python
result = ad.sdk.SomeEntity().create({"name": "x"})   # full SDK, unchanged
df = ad.frame(result)                                # shape anything
```

## Generated code

This package is generated from the API model by
[@voxgig/sdkgen](https://github.com/voxgig/sdkgen). Edits to these files are
overwritten on the next regeneration — change the model, not the output.

MIT licensed. Unofficial: not
affiliated with or endorsed by the upstream API provider.
