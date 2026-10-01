# Smsapi Data — agent guide

Notebook-oriented pandas access to the Smsapi API. If you are writing an
analysis cell, use THIS package; if you are writing an application, use the
sibling SDK at `../py` instead.

## Getting a client

```python
from smsapi_data import data
ad = data()
```

Credentials resolve from, in order: the `token=` argument, the Colab secret
`SMSAPI_APIKEY`, then the environment variable `SMSAPI_APIKEY`.
Do not construct the SDK client directly and do not read env vars yourself —
`data()` already does both.

## Accessors

- `ad.availables()` -> DataFrame of `available`. Columns: name:string, normalize:boolean, template:string
- `ad.callbacks()` -> DataFrame of `callback`. Columns: active:boolean, api_version:Int64, id:string, invalid:boolean, receiver:object, receiver_type:string, type:string, url:string
- `ad.contacts()` -> DataFrame of `contact`. Columns: birthday_date:string, city:string, collection:object, contact_expire_after:Int64, contacts_count:Int64, country:string, created_by:string, date_created:string, date_updated:string, description:string, email:string, first_name:string, …
- `ad.contacts_fields()` -> DataFrame of `contacts_field`. Columns: birthday_date:string, city:string, contact_expire_after:Int64, contacts_count:Int64, country:string, created_by:string, date_created:string, date_updated:string, description:string, email:string, first_name:string, gender:string, …
- `ad.contacts_field_options()` -> DataFrame of `contacts_field_option`. Columns: birthday_date:string, city:string, contact_expire_after:Int64, contacts_count:Int64, country:string, created_by:string, date_created:string, date_updated:string, description:string, email:string, first_name:string, gender:string, …
- `ad.contactsgroups()` -> DataFrame of `contactsgroup`. Columns: birthday_date:string, city:string, contact_expire_after:Int64, contacts_count:Int64, country:string, created_by:string, date_created:string, date_updated:string, description:string, email:string, first_name:string, gender:string, …
- `ad.field_availables()` -> DataFrame of `field_available`. Columns: built_in:boolean, id:string, name:string, options:object, type:string
- `ad.opt_outs()` -> DataFrame of `opt_out`. Columns: date:string, id:string, links:object, phoneNumber:Int64
- `ad.pings()` -> DataFrame of `ping`. Columns: authorized:boolean, unavailable:object
- `ad.profiles()` -> DataFrame of `profile`. Columns: email:string, name:string, payment_type:string, phone_number:Int64, points:Float64, user_type:string, username:string
- `ad.rcs()` -> DataFrame of `rcs`
- `ad.sendernames()` -> DataFrame of `sendername`. Columns: created_at:string, id:string, is_default:boolean, sender:string, status:string
- `ad.sendername_statements()` -> DataFrame of `sendername_statement`. Columns: content:string, statements:object, title:string
- `ad.shipment_country_volumes()` -> DataFrame of `shipment_country_volume`. Columns: country_code:string, country_limit:Int64, country_name:string, usage:Int64
- `ad.short_urls()` -> DataFrame of `short_url`. Columns: description:string, expire:string, filename:string, hits:Int64, hits_unique:Int64, id:string, name:string, short_url:string, type:string, url:string
- `ad.subusers()` -> DataFrame of `subuser`. Columns: active:boolean, credentials:object, description:string, id:string, points:object, username:string
- `ad.templates()` -> DataFrame of `template`. Columns: id:string, name:string, normalize:boolean, template:string
- `ad.user_rcs_sender_collections()` -> DataFrame of `user_rcs_sender_collection`. Columns: deliveredAt:string, expiredAt:string, id:string, interface:string, messageType:string, readAt:string, recipient:string, sender:string, senderId:string, sentAt:string
- `ad.callback(id)` -> Series for one `callback`
- `ad.contact(id)` -> Series for one `contact`
- `ad.group(id)` -> Series for one `group`
- `ad.permission(id)` -> Series for one `permission`
- `ad.sendername(id)` -> Series for one `sendername`
- `ad.short_url(id)` -> Series for one `short_url`
- `ad.subuser(id)` -> Series for one `subuser`
- `ad.template(id)` -> Series for one `template`

## Semantics you must not get wrong

- Accessors fetch **every page** by default. For a preview, pass `limit=N` —
  do not write a pagination loop, and do not call the accessor repeatedly.
- Filters go in as **keyword arguments**: `ad.things(status="open")`. There is
  no `match=` parameter.
- Columns use **nullable pandas dtypes** (`Int64`, `boolean`, `string`).
  Comparisons against `None` should use `.isna()`, not `== None`.
- Nested objects are flattened **one level** into dotted columns (`a.b`).
  Deeper values remain Python objects inside the column.
- Date columns are **strings** unless you pass `parse_dates=["col"]`.
- The frame returned for an empty result still has the right columns and
  dtypes, so `.empty` and column access are always safe.

## When there is no accessor

Writes and non-entity endpoints are deliberately absent. Use the wrapped
client and shape the result:

```python
result = ad.sdk.SomeEntity().create({"name": "x"})
df = ad.frame(result)
```

## Generated

Generated by @voxgig/sdkgen from the API model. Do not edit files here — they
are overwritten. Change the model and regenerate.
