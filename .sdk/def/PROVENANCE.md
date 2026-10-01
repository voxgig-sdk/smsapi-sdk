# API definition provenance

## smsapi-openapi.json

- **Source:** https://www.smsapi.com/rest/ — SMSAPI's interactive API
  reference. The page is a Swagger UI app that reads
  https://www.smsapi.com/rest/services.json, which lists the two OpenAPI
  documents the reference is built from:
  - `Panel` — https://www.smsapi.com/rest/specifications/panel_com.yml
  - `Contacts` — https://www.smsapi.com/rest/specifications/contacts_com.yml
- **Publisher:** SMSAPI (LINK Mobility Poland Sp. z o.o.)
- **Retrieved:** 2026-10-01 (both files served with
  `last-modified: Thu, 01 Oct 2026 14:11:18 GMT`)
- **Format:** OpenAPI 3.0.0 (both documents)
- **Upstream files**, kept byte for byte in `upstream/`:

  | file | bytes | SHA-256 | paths | operations | schemas |
  |---|---|---|---|---|---|
  | `panel_com.yml` | 170814 | `e8fcb97f3e887e16be476024937c26ef3f024c1550149e746633912692a8faa0` | 33 | 55 | 361 |
  | `contacts_com.yml` | 41824 | `eb35aa93908f923cc87c4faa795550d14835e4518cd462e746922f95564b463d` | 16 | 37 | 50 |

- **Merged file:** `smsapi-openapi.json`, 307155 bytes, SHA-256
  `eab53e5bd458cc4b61d16b40d58233bdce94119236276d3f095eae69b8df58f8`.
  49 paths, 92 operations, 403 component schemas: every operation the
  reference lists.
- **Licence:** neither document declares one (`info.license` is absent), and
  SMSAPI's Terms of use (https://www.smsapi.com/en/terms, version of
  2026-07-21) name the Technical Specification at smsapi.com/docs as an
  appendix to the customer agreement but carry no clause restricting its
  reproduction. The documents are public and served without a login.

## How this file was assembled

Both documents describe the same host, `https://api.smsapi.com`, with the
same bearer-token security requirement, and share no path. apidef reads one
definition and an SDK covers its whole API, so they are merged by
`upstream/merge.rb` (run from this directory: `ruby upstream/merge.rb`). The
merge is mechanical and deterministic:

- `openapi`, `info`, `servers` and `security` are Panel's, as published.
- `paths` are unioned.
- `components` are unioned. A name both documents define identically is kept
  once (14 schemas, 7 responses, 2 parameters, the `token` security scheme).
  Six schema names are defined **differently** by the two documents (`Idx`,
  `PhoneNumber`, `Collection`, `FirstName`, `Field`, `Country`); Panel's
  definition keeps the name and Contacts' is renamed with a `Contacts` prefix
  (`ContactsFirstName`, ...), with every `$ref` inside the Contacts document
  rewritten to match. No other name changes.
- Contacts' top-level `host` and `schemes` are Swagger 2.0 keys with no
  meaning in OpenAPI 3; they are dropped (`servers` carries the same URL).

Nothing else is altered. Do not hand-edit `smsapi-openapi.json` or the
upstream files: re-download the upstream files and re-run the merge.

## Defects in the published documents (left as published)

- `panel_com.yml` references two schemas it never defines:
  `#/components/schemas/Cui` and `#/components/schemas/ChargesCurrency`.
- 88 of the 92 operations carry no `operationId`.
- The `token` security scheme is `type: http, scheme: bearer` but also carries
  `in: header`, which belongs to `type: apiKey`.
- `contacts_com.yml` carries Swagger 2.0 `host` and `schemes` keys.
- The two documents disagree on six shared schema names; `FirstName`,
  `Country` and `Field` differ in type, not just in detail.
- 79 component schemas declare no `type`.
