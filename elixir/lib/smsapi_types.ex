# Typed models for the Smsapi SDK.
#
# GENERATED from the API model: main.kit.entity.<e>.fields{} and per-op
# params (op.<name>.points[].g.params[]). Member types come from the
# canonical type sentinels. The SDK carries data as string-keyed struct value
# nodes, so each alias is an open string-keyed map; the @typedoc member lists
# document the concrete shapes. Do not edit by hand.

defmodule Smsapi.Types do
  @moduledoc """
  Documented shapes for the Smsapi SDK entities and operation payloads.

  Every alias resolves to an open string-keyed map because the SDK carries
  data as string-keyed struct value nodes; consult each type's member list for
  the concrete field/param types.
  """

  @typedoc """
  Available entity data model.

  Members:
    * `"name"` — String.t() (optional)
    * `"normalize"` — boolean() (optional)
    * `"template"` — String.t() (optional)
  """
  @type available :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for Available list.

  Members:
    * `"name"` — String.t() (optional)
    * `"normalize"` — boolean() (optional)
    * `"template"` — String.t() (optional)
  """
  @type available_list_match :: %{optional(String.t()) => any()}

  @typedoc """
  Blacklist entity data model.

  Members:
    * `"id"` — String.t() (optional)
  """
  @type blacklist :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for Blacklist load.

  Members:
    * `"limit"` — integer() (optional)
    * `"offset"` — integer() (optional)
    * `"q"` — integer() (optional)
  """
  @type blacklist_load_match :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for Blacklist create.

  Members:
    * `"id"` — String.t() (optional)
  """
  @type blacklist_create_data :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for Blacklist remove.

  Members:
    * `"id"` — String.t() (required)
  """
  @type blacklist_remove_match :: %{optional(String.t()) => any()}

  @typedoc """
  Callback entity data model.

  Members:
    * `"active"` — boolean() (optional)
    * `"api_version"` — integer() (optional)
    * `"id"` — String.t() (optional)
    * `"invalid"` — boolean() (optional)
    * `"receiver"` — map() (optional)
    * `"receiver_type"` — String.t() (optional)
    * `"type"` — String.t() (optional)
    * `"url"` — String.t() (optional)
  """
  @type callback :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for Callback load.

  Members:
    * `"id"` — String.t() (required)
  """
  @type callback_load_match :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for Callback list.

  Members:
    * `"active"` — boolean() (optional)
    * `"api_version"` — integer() (optional)
    * `"id"` — String.t() (optional)
    * `"invalid"` — boolean() (optional)
    * `"receiver"` — map() (optional)
    * `"receiver_type"` — String.t() (optional)
    * `"type"` — String.t() (optional)
    * `"url"` — String.t() (optional)
  """
  @type callback_list_match :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for Callback create.

  Members:
    * `"active"` — boolean() (optional)
    * `"api_version"` — integer() (optional)
    * `"id"` — String.t() (optional)
    * `"invalid"` — boolean() (optional)
    * `"receiver"` — map() (optional)
    * `"receiver_type"` — String.t() (optional)
    * `"type"` — String.t() (optional)
    * `"url"` — String.t() (optional)
  """
  @type callback_create_data :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for Callback update.

  Members:
    * `"id"` — String.t() (required)
    * `"active"` — boolean() (optional)
    * `"api_version"` — integer() (optional)
    * `"invalid"` — boolean() (optional)
    * `"receiver"` — map() (optional)
    * `"receiver_type"` — String.t() (optional)
    * `"type"` — String.t() (optional)
    * `"url"` — String.t() (optional)
  """
  @type callback_update_data :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for Callback remove.

  Members:
    * `"id"` — String.t() (required)
  """
  @type callback_remove_match :: %{optional(String.t()) => any()}

  @typedoc """
  Contact entity data model.

  Members:
    * `"birthday_date"` — String.t() (optional)
    * `"city"` — String.t() (optional)
    * `"collection"` — list() (required)
    * `"contact_expire_after"` — integer() (required)
    * `"contacts_count"` — integer() (required)
    * `"country"` — String.t() (optional)
    * `"created_by"` — String.t() (required)
    * `"date_created"` — String.t() (required)
    * `"date_updated"` — String.t() (required)
    * `"description"` — String.t() (optional)
    * `"email"` — String.t() (optional)
    * `"first_name"` — String.t() (optional)
    * `"gender"` — String.t() (required)
    * `"group_id"` — String.t() (optional)
    * `"groups"` — list() (required)
    * `"id"` — String.t() (required)
    * `"idx"` — String.t() (optional)
    * `"last_name"` — String.t() (optional)
    * `"name"` — String.t() (required)
    * `"permissions"` — list() (optional)
    * `"phone_number"` — String.t() (optional)
    * `"read"` — boolean() (optional)
    * `"send"` — boolean() (optional)
    * `"size"` — integer() (required)
    * `"source"` — String.t() (optional)
    * `"type"` — String.t() (optional)
    * `"username"` — String.t() (optional)
    * `"value"` — String.t() (optional)
    * `"write"` — boolean() (optional)
  """
  @type contact :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for Contact load.

  Members:
    * `"id"` — String.t() (required)
  """
  @type contact_load_match :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for Contact list.

  Members:
    * `"birthday_date"` — list() (optional)
    * `"email"` — list() (optional)
    * `"first_name"` — list() (optional)
    * `"gender"` — String.t() (optional)
    * `"group_id"` — list() (optional)
    * `"last_name"` — list() (optional)
    * `"limit"` — integer() (optional)
    * `"offset"` — integer() (optional)
    * `"order_by"` — String.t() (optional)
    * `"phone_number"` — list() (optional)
    * `"q"` — String.t() (optional)
  """
  @type contact_list_match :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for Contact create.

  Members:
    * `"birthday_date"` — String.t() (optional)
    * `"city"` — String.t() (optional)
    * `"collection"` — list() (required)
    * `"contact_expire_after"` — integer() (required)
    * `"contacts_count"` — integer() (required)
    * `"country"` — String.t() (optional)
    * `"created_by"` — String.t() (required)
    * `"date_created"` — String.t() (required)
    * `"date_updated"` — String.t() (required)
    * `"description"` — String.t() (optional)
    * `"email"` — String.t() (optional)
    * `"first_name"` — String.t() (optional)
    * `"gender"` — String.t() (required)
    * `"group_id"` — String.t() (optional)
    * `"groups"` — list() (required)
    * `"id"` — String.t() (required)
    * `"idx"` — String.t() (optional)
    * `"last_name"` — String.t() (optional)
    * `"name"` — String.t() (required)
    * `"permissions"` — list() (optional)
    * `"phone_number"` — String.t() (optional)
    * `"read"` — boolean() (optional)
    * `"send"` — boolean() (optional)
    * `"size"` — integer() (required)
    * `"source"` — String.t() (optional)
    * `"type"` — String.t() (optional)
    * `"username"` — String.t() (optional)
    * `"value"` — String.t() (optional)
    * `"write"` — boolean() (optional)
  """
  @type contact_create_data :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for Contact update.

  Members:
    * `"id"` — String.t() (required)
    * `"birthday_date"` — String.t() (optional)
    * `"city"` — String.t() (optional)
    * `"collection"` — list() (optional)
    * `"contact_expire_after"` — integer() (optional)
    * `"contacts_count"` — integer() (optional)
    * `"country"` — String.t() (optional)
    * `"created_by"` — String.t() (optional)
    * `"date_created"` — String.t() (optional)
    * `"date_updated"` — String.t() (optional)
    * `"description"` — String.t() (optional)
    * `"email"` — String.t() (optional)
    * `"first_name"` — String.t() (optional)
    * `"gender"` — String.t() (optional)
    * `"group_id"` — String.t() (optional)
    * `"groups"` — list() (optional)
    * `"idx"` — String.t() (optional)
    * `"last_name"` — String.t() (optional)
    * `"name"` — String.t() (optional)
    * `"permissions"` — list() (optional)
    * `"phone_number"` — String.t() (optional)
    * `"read"` — boolean() (optional)
    * `"send"` — boolean() (optional)
    * `"size"` — integer() (optional)
    * `"source"` — String.t() (optional)
    * `"type"` — String.t() (optional)
    * `"username"` — String.t() (optional)
    * `"value"` — String.t() (optional)
    * `"write"` — boolean() (optional)
  """
  @type contact_update_data :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for Contact remove.

  Members:
    * `"id"` — String.t() (required)
  """
  @type contact_remove_match :: %{optional(String.t()) => any()}

  @typedoc """
  ContactsField entity data model.

  Members:
    * `"birthday_date"` — String.t() (optional)
    * `"city"` — String.t() (optional)
    * `"contact_expire_after"` — integer() (required)
    * `"contacts_count"` — integer() (optional)
    * `"country"` — String.t() (optional)
    * `"created_by"` — String.t() (required)
    * `"date_created"` — String.t() (required)
    * `"date_updated"` — String.t() (required)
    * `"description"` — String.t() (optional)
    * `"email"` — String.t() (optional)
    * `"first_name"` — String.t() (optional)
    * `"gender"` — String.t() (required)
    * `"group_id"` — String.t() (optional)
    * `"groups"` — list() (required)
    * `"id"` — String.t() (optional)
    * `"idx"` — String.t() (optional)
    * `"last_name"` — String.t() (optional)
    * `"name"` — String.t() (optional)
    * `"permissions"` — list() (optional)
    * `"phone_number"` — String.t() (optional)
    * `"read"` — boolean() (optional)
    * `"send"` — boolean() (optional)
    * `"source"` — String.t() (optional)
    * `"type"` — String.t() (optional)
    * `"username"` — String.t() (optional)
    * `"value"` — String.t() (optional)
    * `"write"` — boolean() (optional)
  """
  @type contacts_field :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for ContactsField list.

  Members:
    * `"birthday_date"` — String.t() (optional)
    * `"city"` — String.t() (optional)
    * `"contact_expire_after"` — integer() (optional)
    * `"contacts_count"` — integer() (optional)
    * `"country"` — String.t() (optional)
    * `"created_by"` — String.t() (optional)
    * `"date_created"` — String.t() (optional)
    * `"date_updated"` — String.t() (optional)
    * `"description"` — String.t() (optional)
    * `"email"` — String.t() (optional)
    * `"first_name"` — String.t() (optional)
    * `"gender"` — String.t() (optional)
    * `"group_id"` — String.t() (optional)
    * `"groups"` — list() (optional)
    * `"id"` — String.t() (optional)
    * `"idx"` — String.t() (optional)
    * `"last_name"` — String.t() (optional)
    * `"name"` — String.t() (optional)
    * `"permissions"` — list() (optional)
    * `"phone_number"` — String.t() (optional)
    * `"read"` — boolean() (optional)
    * `"send"` — boolean() (optional)
    * `"source"` — String.t() (optional)
    * `"type"` — String.t() (optional)
    * `"username"` — String.t() (optional)
    * `"value"` — String.t() (optional)
    * `"write"` — boolean() (optional)
  """
  @type contacts_field_list_match :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for ContactsField create.

  Members:
    * `"birthday_date"` — String.t() (optional)
    * `"city"` — String.t() (optional)
    * `"contact_expire_after"` — integer() (required)
    * `"contacts_count"` — integer() (optional)
    * `"country"` — String.t() (optional)
    * `"created_by"` — String.t() (required)
    * `"date_created"` — String.t() (required)
    * `"date_updated"` — String.t() (required)
    * `"description"` — String.t() (optional)
    * `"email"` — String.t() (optional)
    * `"first_name"` — String.t() (optional)
    * `"gender"` — String.t() (required)
    * `"group_id"` — String.t() (optional)
    * `"groups"` — list() (required)
    * `"id"` — String.t() (optional)
    * `"idx"` — String.t() (optional)
    * `"last_name"` — String.t() (optional)
    * `"name"` — String.t() (optional)
    * `"permissions"` — list() (optional)
    * `"phone_number"` — String.t() (optional)
    * `"read"` — boolean() (optional)
    * `"send"` — boolean() (optional)
    * `"source"` — String.t() (optional)
    * `"type"` — String.t() (optional)
    * `"username"` — String.t() (optional)
    * `"value"` — String.t() (optional)
    * `"write"` — boolean() (optional)
  """
  @type contacts_field_create_data :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for ContactsField update.

  Members:
    * `"id"` — String.t() (required)
    * `"birthday_date"` — String.t() (optional)
    * `"city"` — String.t() (optional)
    * `"contact_expire_after"` — integer() (optional)
    * `"contacts_count"` — integer() (optional)
    * `"country"` — String.t() (optional)
    * `"created_by"` — String.t() (optional)
    * `"date_created"` — String.t() (optional)
    * `"date_updated"` — String.t() (optional)
    * `"description"` — String.t() (optional)
    * `"email"` — String.t() (optional)
    * `"first_name"` — String.t() (optional)
    * `"gender"` — String.t() (optional)
    * `"group_id"` — String.t() (optional)
    * `"groups"` — list() (optional)
    * `"idx"` — String.t() (optional)
    * `"last_name"` — String.t() (optional)
    * `"name"` — String.t() (optional)
    * `"permissions"` — list() (optional)
    * `"phone_number"` — String.t() (optional)
    * `"read"` — boolean() (optional)
    * `"send"` — boolean() (optional)
    * `"source"` — String.t() (optional)
    * `"type"` — String.t() (optional)
    * `"username"` — String.t() (optional)
    * `"value"` — String.t() (optional)
    * `"write"` — boolean() (optional)
  """
  @type contacts_field_update_data :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for ContactsField remove.

  Members:
    * `"id"` — String.t() (required)
  """
  @type contacts_field_remove_match :: %{optional(String.t()) => any()}

  @typedoc """
  ContactsFieldOption entity data model.

  Members:
    * `"birthday_date"` — String.t() (optional)
    * `"city"` — String.t() (optional)
    * `"contact_expire_after"` — integer() (required)
    * `"contacts_count"` — integer() (optional)
    * `"country"` — String.t() (optional)
    * `"created_by"` — String.t() (required)
    * `"date_created"` — String.t() (required)
    * `"date_updated"` — String.t() (required)
    * `"description"` — String.t() (optional)
    * `"email"` — String.t() (optional)
    * `"first_name"` — String.t() (optional)
    * `"gender"` — String.t() (required)
    * `"group_id"` — String.t() (optional)
    * `"groups"` — list() (required)
    * `"id"` — String.t() (required)
    * `"idx"` — String.t() (optional)
    * `"last_name"` — String.t() (optional)
    * `"name"` — String.t() (optional)
    * `"permissions"` — list() (optional)
    * `"phone_number"` — String.t() (optional)
    * `"read"` — boolean() (optional)
    * `"send"` — boolean() (optional)
    * `"source"` — String.t() (optional)
    * `"type"` — String.t() (optional)
    * `"username"` — String.t() (optional)
    * `"value"` — String.t() (optional)
    * `"write"` — boolean() (optional)
  """
  @type contacts_field_option :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for ContactsFieldOption list.

  Members:
    * `"field_id"` — String.t() (required)
  """
  @type contacts_field_option_list_match :: %{optional(String.t()) => any()}

  @typedoc """
  Contactsgroup entity data model.

  Members:
    * `"birthday_date"` — String.t() (optional)
    * `"city"` — String.t() (optional)
    * `"contact_expire_after"` — integer() (required)
    * `"contacts_count"` — integer() (optional)
    * `"country"` — String.t() (optional)
    * `"created_by"` — String.t() (required)
    * `"date_created"` — String.t() (required)
    * `"date_updated"` — String.t() (required)
    * `"description"` — String.t() (optional)
    * `"email"` — String.t() (optional)
    * `"first_name"` — String.t() (optional)
    * `"gender"` — String.t() (required)
    * `"group_id"` — String.t() (required)
    * `"groups"` — list() (required)
    * `"id"` — String.t() (required)
    * `"idx"` — String.t() (optional)
    * `"last_name"` — String.t() (optional)
    * `"name"` — String.t() (optional)
    * `"permissions"` — list() (optional)
    * `"phone_number"` — String.t() (optional)
    * `"read"` — boolean() (required)
    * `"send"` — boolean() (required)
    * `"source"` — String.t() (optional)
    * `"type"` — String.t() (optional)
    * `"username"` — String.t() (required)
    * `"value"` — String.t() (optional)
    * `"write"` — boolean() (required)
  """
  @type contactsgroup :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for Contactsgroup list.

  Members:
    * `"name"` — map() (optional)
    * `"with"` — list() (optional)
  """
  @type contactsgroup_list_match :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for Contactsgroup create.

  Members:
    * `"birthday_date"` — String.t() (optional)
    * `"city"` — String.t() (optional)
    * `"contact_expire_after"` — integer() (required)
    * `"contacts_count"` — integer() (optional)
    * `"country"` — String.t() (optional)
    * `"created_by"` — String.t() (required)
    * `"date_created"` — String.t() (required)
    * `"date_updated"` — String.t() (required)
    * `"description"` — String.t() (optional)
    * `"email"` — String.t() (optional)
    * `"first_name"` — String.t() (optional)
    * `"gender"` — String.t() (required)
    * `"group_id"` — String.t() (required)
    * `"groups"` — list() (required)
    * `"id"` — String.t() (required)
    * `"idx"` — String.t() (optional)
    * `"last_name"` — String.t() (optional)
    * `"name"` — String.t() (optional)
    * `"permissions"` — list() (optional)
    * `"phone_number"` — String.t() (optional)
    * `"read"` — boolean() (required)
    * `"send"` — boolean() (required)
    * `"source"` — String.t() (optional)
    * `"type"` — String.t() (optional)
    * `"username"` — String.t() (required)
    * `"value"` — String.t() (optional)
    * `"write"` — boolean() (required)
  """
  @type contactsgroup_create_data :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for Contactsgroup update.

  Members:
    * `"group_id"` — String.t() (required)
    * `"username"` — String.t() (optional)
    * `"birthday_date"` — String.t() (optional)
    * `"city"` — String.t() (optional)
    * `"contact_expire_after"` — integer() (optional)
    * `"contacts_count"` — integer() (optional)
    * `"country"` — String.t() (optional)
    * `"created_by"` — String.t() (optional)
    * `"date_created"` — String.t() (optional)
    * `"date_updated"` — String.t() (optional)
    * `"description"` — String.t() (optional)
    * `"email"` — String.t() (optional)
    * `"first_name"` — String.t() (optional)
    * `"gender"` — String.t() (optional)
    * `"groups"` — list() (optional)
    * `"id"` — String.t() (optional)
    * `"idx"` — String.t() (optional)
    * `"last_name"` — String.t() (optional)
    * `"name"` — String.t() (optional)
    * `"permissions"` — list() (optional)
    * `"phone_number"` — String.t() (optional)
    * `"read"` — boolean() (optional)
    * `"send"` — boolean() (optional)
    * `"source"` — String.t() (optional)
    * `"type"` — String.t() (optional)
    * `"value"` — String.t() (optional)
    * `"write"` — boolean() (optional)
  """
  @type contactsgroup_update_data :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for Contactsgroup remove.

  Members:
    * `"group_id"` — String.t() (required)
  """
  @type contactsgroup_remove_match :: %{optional(String.t()) => any()}

  @typedoc """
  Contactstrash entity data model.
  """
  @type contactstrash :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for Contactstrash update.
  """
  @type contactstrash_update_data :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for Contactstrash remove.
  """
  @type contactstrash_remove_match :: %{optional(String.t()) => any()}

  @typedoc """
  FieldAvailable entity data model.

  Members:
    * `"built_in"` — boolean() (optional)
    * `"id"` — String.t() (optional)
    * `"name"` — String.t() (optional)
    * `"options"` — list() (optional)
    * `"type"` — String.t() (optional)
  """
  @type field_available :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for FieldAvailable list.

  Members:
    * `"built_in"` — boolean() (optional)
    * `"id"` — String.t() (optional)
    * `"name"` — String.t() (optional)
    * `"options"` — list() (optional)
    * `"type"` — String.t() (optional)
  """
  @type field_available_list_match :: %{optional(String.t()) => any()}

  @typedoc """
  Group entity data model.

  Members:
    * `"contact_expire_after"` — integer() (required)
    * `"contacts_count"` — integer() (required)
    * `"created_by"` — String.t() (required)
    * `"date_created"` — String.t() (required)
    * `"date_updated"` — String.t() (required)
    * `"description"` — String.t() (required)
    * `"id"` — String.t() (required)
    * `"idx"` — String.t() (optional)
    * `"name"` — String.t() (required)
    * `"permissions"` — list() (optional)
  """
  @type group :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for Group load.

  Members:
    * `"id"` — String.t() (required)
  """
  @type group_load_match :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for Group update.

  Members:
    * `"id"` — String.t() (required)
    * `"contact_expire_after"` — integer() (optional)
    * `"contacts_count"` — integer() (optional)
    * `"created_by"` — String.t() (optional)
    * `"date_created"` — String.t() (optional)
    * `"date_updated"` — String.t() (optional)
    * `"description"` — String.t() (optional)
    * `"idx"` — String.t() (optional)
    * `"name"` — String.t() (optional)
    * `"permissions"` — list() (optional)
  """
  @type group_update_data :: %{optional(String.t()) => any()}

  @typedoc """
  MfaCode entity data model.

  Members:
    * `"content"` — String.t() (optional)
    * `"fast"` — any() (optional)
    * `"from"` — String.t() (optional)
    * `"phone_number"` — String.t() (required)
  """
  @type mfa_code :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for MfaCode create.

  Members:
    * `"content"` — String.t() (optional)
    * `"fast"` — any() (optional)
    * `"from"` — String.t() (optional)
    * `"phone_number"` — String.t() (required)
  """
  @type mfa_code_create_data :: %{optional(String.t()) => any()}

  @typedoc """
  OptOut entity data model.

  Members:
    * `"date"` — String.t() (optional)
    * `"id"` — String.t() (optional)
    * `"links"` — list() (optional)
    * `"phoneNumber"` — integer() (optional)
  """
  @type opt_out :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for OptOut list.

  Members:
    * `"limit"` — integer() (optional)
    * `"offset"` — integer() (optional)
    * `"phone_number"` — String.t() (optional)
  """
  @type opt_out_list_match :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for OptOut remove.

  Members:
    * `"id"` — String.t() (required)
  """
  @type opt_out_remove_match :: %{optional(String.t()) => any()}

  @typedoc """
  OptOutSetting entity data model.

  Members:
    * `"brand"` — String.t() (optional)
  """
  @type opt_out_setting :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for OptOutSetting load.

  Members:
    * `"brand"` — String.t() (optional)
  """
  @type opt_out_setting_load_match :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for OptOutSetting update.

  Members:
    * `"brand"` — String.t() (optional)
  """
  @type opt_out_setting_update_data :: %{optional(String.t()) => any()}

  @typedoc """
  Permission entity data model.

  Members:
    * `"group_id"` — String.t() (required)
    * `"id"` — String.t() (optional)
    * `"read"` — boolean() (required)
    * `"send"` — boolean() (required)
    * `"username"` — String.t() (required)
    * `"write"` — boolean() (required)
  """
  @type permission :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for Permission load.

  Members:
    * `"group_id"` — String.t() (required)
    * `"id"` — String.t() (required)
    * `"username"` — String.t() (required)
  """
  @type permission_load_match :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for Permission create.

  Members:
    * `"group_id"` — String.t() (required)
    * `"id"` — String.t() (optional)
    * `"read"` — boolean() (required)
    * `"send"` — boolean() (required)
    * `"username"` — String.t() (required)
    * `"write"` — boolean() (required)
  """
  @type permission_create_data :: %{optional(String.t()) => any()}

  @typedoc """
  Ping entity data model.

  Members:
    * `"authorized"` — boolean() (required)
    * `"unavailable"` — list() (required)
  """
  @type ping :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for Ping list.

  Members:
    * `"authorized"` — boolean() (optional)
    * `"unavailable"` — list() (optional)
  """
  @type ping_list_match :: %{optional(String.t()) => any()}

  @typedoc """
  Profile entity data model.

  Members:
    * `"email"` — String.t() (required)
    * `"name"` — String.t() (required)
    * `"payment_type"` — String.t() (required)
    * `"phone_number"` — integer() (required)
    * `"points"` — float() (optional)
    * `"user_type"` — String.t() (required)
    * `"username"` — String.t() (required)
  """
  @type profile :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for Profile load.

  Members:
    * `"email"` — String.t() (optional)
    * `"name"` — String.t() (optional)
    * `"payment_type"` — String.t() (optional)
    * `"phone_number"` — integer() (optional)
    * `"points"` — float() (optional)
    * `"user_type"` — String.t() (optional)
    * `"username"` — String.t() (optional)
  """
  @type profile_load_match :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for Profile list.

  Members:
    * `"type"` — String.t() (optional)
  """
  @type profile_list_match :: %{optional(String.t()) => any()}

  @typedoc """
  Rcs entity data model.
  """
  @type rcs :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for Rcs list.
  """
  @type rcs_list_match :: %{optional(String.t()) => any()}

  @typedoc """
  Sendername entity data model.

  Members:
    * `"created_at"` — String.t() (optional)
    * `"id"` — String.t() (optional)
    * `"is_default"` — boolean() (optional)
    * `"sender"` — String.t() (optional)
    * `"status"` — String.t() (optional)
  """
  @type sendername :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for Sendername load.

  Members:
    * `"id"` — String.t() (required)
  """
  @type sendername_load_match :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for Sendername list.

  Members:
    * `"created_at"` — String.t() (optional)
    * `"id"` — String.t() (optional)
    * `"is_default"` — boolean() (optional)
    * `"sender"` — String.t() (optional)
    * `"status"` — String.t() (optional)
  """
  @type sendername_list_match :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for Sendername create.

  Members:
    * `"created_at"` — String.t() (optional)
    * `"id"` — String.t() (optional)
    * `"is_default"` — boolean() (optional)
    * `"sender"` — String.t() (optional)
    * `"status"` — String.t() (optional)
  """
  @type sendername_create_data :: %{optional(String.t()) => any()}

  @typedoc """
  SendernameStatement entity data model.

  Members:
    * `"content"` — String.t() (optional)
    * `"statements"` — list() (optional)
    * `"title"` — String.t() (optional)
  """
  @type sendername_statement :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for SendernameStatement list.

  Members:
    * `"content"` — String.t() (optional)
    * `"statements"` — list() (optional)
    * `"title"` — String.t() (optional)
  """
  @type sendername_statement_list_match :: %{optional(String.t()) => any()}

  @typedoc """
  SentRcsMessage entity data model.

  Members:
    * `"content"` — map() (optional)
    * `"phone_number"` — String.t() (required)
    * `"sender"` — any() (required)
    * `"text"` — String.t() (optional)
  """
  @type sent_rcs_message :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for SentRcsMessage create.

  Members:
    * `"content"` — map() (optional)
    * `"phone_number"` — String.t() (required)
    * `"sender"` — any() (required)
    * `"text"` — String.t() (optional)
  """
  @type sent_rcs_message_create_data :: %{optional(String.t()) => any()}

  @typedoc """
  ShipmentCountryVolume entity data model.

  Members:
    * `"country_code"` — String.t() (optional)
    * `"country_limit"` — integer() (optional)
    * `"country_name"` — String.t() (optional)
    * `"usage"` — integer() (optional)
  """
  @type shipment_country_volume :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for ShipmentCountryVolume list.

  Members:
    * `"month"` — String.t() (optional)
    * `"year"` — String.t() (optional)
  """
  @type shipment_country_volume_list_match :: %{optional(String.t()) => any()}

  @typedoc """
  ShortUrl entity data model.

  Members:
    * `"description"` — String.t() (optional)
    * `"expire"` — String.t() (optional)
    * `"filename"` — String.t() (optional)
    * `"hits"` — integer() (optional)
    * `"hits_unique"` — integer() (optional)
    * `"id"` — String.t() (optional)
    * `"name"` — String.t() (optional)
    * `"short_url"` — String.t() (optional)
    * `"type"` — String.t() (optional)
    * `"url"` — String.t() (optional)
  """
  @type short_url :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for ShortUrl load.

  Members:
    * `"id"` — String.t() (required)
  """
  @type short_url_load_match :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for ShortUrl list.

  Members:
    * `"description"` — String.t() (optional)
    * `"expire"` — String.t() (optional)
    * `"filename"` — String.t() (optional)
    * `"hits"` — integer() (optional)
    * `"hits_unique"` — integer() (optional)
    * `"id"` — String.t() (optional)
    * `"name"` — String.t() (optional)
    * `"short_url"` — String.t() (optional)
    * `"type"` — String.t() (optional)
    * `"url"` — String.t() (optional)
  """
  @type short_url_list_match :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for ShortUrl create.

  Members:
    * `"description"` — String.t() (optional)
    * `"expire"` — String.t() (optional)
    * `"filename"` — String.t() (optional)
    * `"hits"` — integer() (optional)
    * `"hits_unique"` — integer() (optional)
    * `"id"` — String.t() (optional)
    * `"name"` — String.t() (optional)
    * `"short_url"` — String.t() (optional)
    * `"type"` — String.t() (optional)
    * `"url"` — String.t() (optional)
  """
  @type short_url_create_data :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for ShortUrl update.

  Members:
    * `"id"` — String.t() (required)
    * `"description"` — String.t() (optional)
    * `"expire"` — String.t() (optional)
    * `"filename"` — String.t() (optional)
    * `"hits"` — integer() (optional)
    * `"hits_unique"` — integer() (optional)
    * `"name"` — String.t() (optional)
    * `"short_url"` — String.t() (optional)
    * `"type"` — String.t() (optional)
    * `"url"` — String.t() (optional)
  """
  @type short_url_update_data :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for ShortUrl remove.

  Members:
    * `"id"` — String.t() (required)
  """
  @type short_url_remove_match :: %{optional(String.t()) => any()}

  @typedoc """
  Smsdo entity data model.

  Members:
    * `"allow_duplicates"` — integer() (optional)
    * `"check_idx"` — any() (optional)
    * `"date"` — any() (optional)
    * `"date_validate"` — integer() (optional)
    * `"details"` — any() (optional)
    * `"encoding"` — String.t() (optional)
    * `"expiration_date"` — any() (optional)
    * `"fallback"` — list() (optional)
    * `"fast"` — integer() (optional)
    * `"flash"` — integer() (optional)
    * `"format"` — String.t() (optional)
    * `"from"` — String.t() (optional)
    * `"group"` — String.t() (optional)
    * `"idx"` — String.t() (optional)
    * `"max_parts"` — integer() (optional)
    * `"message"` — String.t() (optional)
    * `"normalize"` — integer() (optional)
    * `"notify_url"` — String.t() (optional)
    * `"test"` — any() (optional)
    * `"time_restriction"` — String.t() (optional)
    * `"to"` — String.t() (optional)
  """
  @type smsdo :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for Smsdo create.

  Members:
    * `"allow_duplicates"` — integer() (optional)
    * `"check_idx"` — any() (optional)
    * `"date"` — any() (optional)
    * `"date_validate"` — integer() (optional)
    * `"details"` — any() (optional)
    * `"encoding"` — String.t() (optional)
    * `"expiration_date"` — any() (optional)
    * `"fallback"` — list() (optional)
    * `"fast"` — integer() (optional)
    * `"flash"` — integer() (optional)
    * `"format"` — String.t() (optional)
    * `"from"` — String.t() (optional)
    * `"group"` — String.t() (optional)
    * `"idx"` — String.t() (optional)
    * `"max_parts"` — integer() (optional)
    * `"message"` — String.t() (optional)
    * `"normalize"` — integer() (optional)
    * `"notify_url"` — String.t() (optional)
    * `"test"` — any() (optional)
    * `"time_restriction"` — String.t() (optional)
    * `"to"` — String.t() (optional)
  """
  @type smsdo_create_data :: %{optional(String.t()) => any()}

  @typedoc """
  Smssendername entity data model.
  """
  @type smssendername :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for Smssendername create.

  Members:
    * `"sendername_id"` — String.t() (required)
  """
  @type smssendername_create_data :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for Smssendername remove.

  Members:
    * `"sender"` — String.t() (required)
  """
  @type smssendername_remove_match :: %{optional(String.t()) => any()}

  @typedoc """
  Smstemplate entity data model.

  Members:
    * `"id"` — String.t() (optional)
  """
  @type smstemplate :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for Smstemplate remove.

  Members:
    * `"id"` — String.t() (required)
  """
  @type smstemplate_remove_match :: %{optional(String.t()) => any()}

  @typedoc """
  Subuser entity data model.

  Members:
    * `"active"` — boolean() (optional)
    * `"credentials"` — map() (required)
    * `"description"` — String.t() (optional)
    * `"id"` — String.t() (optional)
    * `"points"` — map() (optional)
    * `"username"` — String.t() (optional)
  """
  @type subuser :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for Subuser load.

  Members:
    * `"id"` — String.t() (required)
  """
  @type subuser_load_match :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for Subuser list.

  Members:
    * `"q"` — String.t() (optional)
  """
  @type subuser_list_match :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for Subuser create.

  Members:
    * `"active"` — boolean() (optional)
    * `"credentials"` — map() (required)
    * `"description"` — String.t() (optional)
    * `"id"` — String.t() (optional)
    * `"points"` — map() (optional)
    * `"username"` — String.t() (optional)
  """
  @type subuser_create_data :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for Subuser update.

  Members:
    * `"id"` — String.t() (required)
    * `"active"` — boolean() (optional)
    * `"credentials"` — map() (optional)
    * `"description"` — String.t() (optional)
    * `"points"` — map() (optional)
    * `"username"` — String.t() (optional)
  """
  @type subuser_update_data :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for Subuser remove.

  Members:
    * `"id"` — String.t() (required)
  """
  @type subuser_remove_match :: %{optional(String.t()) => any()}

  @typedoc """
  Template entity data model.

  Members:
    * `"id"` — String.t() (optional)
    * `"name"` — String.t() (optional)
    * `"normalize"` — boolean() (optional)
    * `"template"` — String.t() (optional)
  """
  @type template :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for Template load.

  Members:
    * `"id"` — String.t() (required)
  """
  @type template_load_match :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for Template list.

  Members:
    * `"id"` — String.t() (optional)
    * `"name"` — String.t() (optional)
    * `"normalize"` — boolean() (optional)
    * `"template"` — String.t() (optional)
  """
  @type template_list_match :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for Template create.

  Members:
    * `"id"` — String.t() (optional)
    * `"name"` — String.t() (optional)
    * `"normalize"` — boolean() (optional)
    * `"template"` — String.t() (optional)
  """
  @type template_create_data :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for Template update.

  Members:
    * `"id"` — String.t() (required)
    * `"name"` — String.t() (optional)
    * `"normalize"` — boolean() (optional)
    * `"template"` — String.t() (optional)
  """
  @type template_update_data :: %{optional(String.t()) => any()}

  @typedoc """
  UserRcsSenderCollection entity data model.

  Members:
    * `"deliveredAt"` — String.t() (optional)
    * `"expiredAt"` — String.t() (optional)
    * `"id"` — String.t() (optional)
    * `"interface"` — String.t() (optional)
    * `"messageType"` — String.t() (optional)
    * `"readAt"` — String.t() (optional)
    * `"recipient"` — String.t() (optional)
    * `"sender"` — String.t() (optional)
    * `"senderId"` — String.t() (optional)
    * `"sentAt"` — String.t() (optional)
  """
  @type user_rcs_sender_collection :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for UserRcsSenderCollection list.

  Members:
    * `"deliveredAt"` — String.t() (optional)
    * `"expiredAt"` — String.t() (optional)
    * `"id"` — String.t() (optional)
    * `"interface"` — String.t() (optional)
    * `"messageType"` — String.t() (optional)
    * `"readAt"` — String.t() (optional)
    * `"recipient"` — String.t() (optional)
    * `"sender"` — String.t() (optional)
    * `"senderId"` — String.t() (optional)
    * `"sentAt"` — String.t() (optional)
  """
  @type user_rcs_sender_collection_list_match :: %{optional(String.t()) => any()}

end
