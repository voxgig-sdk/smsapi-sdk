# frozen_string_literal: true

# Typed models for the Smsapi SDK.
#
# GENERATED from the API model: main.kit.entity.<e>.fields{} and per-op
# params (op.<name>.points[].g.params[]). Member types come from the
# canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
# @voxgig/apidef VALID_CANON). Ruby types are unenforced; these YARD
# annotations document the shapes. Do not edit by hand.

# Available entity data model.
#
# @!attribute [rw] name
#   @return [String, nil]
#
# @!attribute [rw] normalize
#   @return [Boolean, nil]
#
# @!attribute [rw] template
#   @return [String, nil]
Available = Struct.new(
  :name,
  :normalize,
  :template,
  keyword_init: true
)

# Request payload for Available#list.
#
# @!attribute [rw] name
#   @return [String, nil]
#
# @!attribute [rw] normalize
#   @return [Boolean, nil]
#
# @!attribute [rw] template
#   @return [String, nil]
AvailableListMatch = Struct.new(
  :name,
  :normalize,
  :template,
  keyword_init: true
)

# Blacklist entity data model.
#
# @!attribute [rw] id
#   @return [String, nil]
Blacklist = Struct.new(
  :id,
  keyword_init: true
)

# Request payload for Blacklist#load.
#
# @!attribute [rw] limit
#   @return [Integer, nil]
#
# @!attribute [rw] offset
#   @return [Integer, nil]
#
# @!attribute [rw] q
#   @return [Integer, nil]
BlacklistLoadMatch = Struct.new(
  :limit,
  :offset,
  :q,
  keyword_init: true
)

# Request payload for Blacklist#create.
#
# @!attribute [rw] id
#   @return [String, nil]
BlacklistCreateData = Struct.new(
  :id,
  keyword_init: true
)

# Request payload for Blacklist#remove.
#
# @!attribute [rw] id
#   @return [String]
BlacklistRemoveMatch = Struct.new(
  :id,
  keyword_init: true
)

# Callback entity data model.
#
# @!attribute [rw] active
#   @return [Boolean, nil]
#
# @!attribute [rw] api_version
#   @return [Integer, nil]
#
# @!attribute [rw] id
#   @return [String, nil]
#
# @!attribute [rw] invalid
#   @return [Boolean, nil]
#
# @!attribute [rw] receiver
#   @return [Hash, nil]
#
# @!attribute [rw] receiver_type
#   @return [String, nil]
#
# @!attribute [rw] type
#   @return [String, nil]
#
# @!attribute [rw] url
#   @return [String, nil]
Callback = Struct.new(
  :active,
  :api_version,
  :id,
  :invalid,
  :receiver,
  :receiver_type,
  :type,
  :url,
  keyword_init: true
)

# Request payload for Callback#load.
#
# @!attribute [rw] id
#   @return [String]
CallbackLoadMatch = Struct.new(
  :id,
  keyword_init: true
)

# Request payload for Callback#list.
#
# @!attribute [rw] active
#   @return [Boolean, nil]
#
# @!attribute [rw] api_version
#   @return [Integer, nil]
#
# @!attribute [rw] id
#   @return [String, nil]
#
# @!attribute [rw] invalid
#   @return [Boolean, nil]
#
# @!attribute [rw] receiver
#   @return [Hash, nil]
#
# @!attribute [rw] receiver_type
#   @return [String, nil]
#
# @!attribute [rw] type
#   @return [String, nil]
#
# @!attribute [rw] url
#   @return [String, nil]
CallbackListMatch = Struct.new(
  :active,
  :api_version,
  :id,
  :invalid,
  :receiver,
  :receiver_type,
  :type,
  :url,
  keyword_init: true
)

# Request payload for Callback#create.
#
# @!attribute [rw] active
#   @return [Boolean, nil]
#
# @!attribute [rw] api_version
#   @return [Integer, nil]
#
# @!attribute [rw] id
#   @return [String, nil]
#
# @!attribute [rw] invalid
#   @return [Boolean, nil]
#
# @!attribute [rw] receiver
#   @return [Hash, nil]
#
# @!attribute [rw] receiver_type
#   @return [String, nil]
#
# @!attribute [rw] type
#   @return [String, nil]
#
# @!attribute [rw] url
#   @return [String, nil]
CallbackCreateData = Struct.new(
  :active,
  :api_version,
  :id,
  :invalid,
  :receiver,
  :receiver_type,
  :type,
  :url,
  keyword_init: true
)

# Request payload for Callback#update.
#
# @!attribute [rw] id
#   @return [String]
#
# @!attribute [rw] active
#   @return [Boolean, nil]
#
# @!attribute [rw] api_version
#   @return [Integer, nil]
#
# @!attribute [rw] invalid
#   @return [Boolean, nil]
#
# @!attribute [rw] receiver
#   @return [Hash, nil]
#
# @!attribute [rw] receiver_type
#   @return [String, nil]
#
# @!attribute [rw] type
#   @return [String, nil]
#
# @!attribute [rw] url
#   @return [String, nil]
CallbackUpdateData = Struct.new(
  :id,
  :active,
  :api_version,
  :invalid,
  :receiver,
  :receiver_type,
  :type,
  :url,
  keyword_init: true
)

# Request payload for Callback#remove.
#
# @!attribute [rw] id
#   @return [String]
CallbackRemoveMatch = Struct.new(
  :id,
  keyword_init: true
)

# Contact entity data model.
#
# @!attribute [rw] birthday_date
#   @return [String, nil]
#
# @!attribute [rw] city
#   @return [String, nil]
#
# @!attribute [rw] collection
#   @return [Array]
#
# @!attribute [rw] contact_expire_after
#   @return [Integer]
#
# @!attribute [rw] contacts_count
#   @return [Integer]
#
# @!attribute [rw] country
#   @return [String, nil]
#
# @!attribute [rw] created_by
#   @return [String]
#
# @!attribute [rw] date_created
#   @return [String]
#
# @!attribute [rw] date_updated
#   @return [String]
#
# @!attribute [rw] description
#   @return [String, nil]
#
# @!attribute [rw] email
#   @return [String, nil]
#
# @!attribute [rw] first_name
#   @return [String, nil]
#
# @!attribute [rw] gender
#   @return [String]
#
# @!attribute [rw] groups
#   @return [Array]
#
# @!attribute [rw] id
#   @return [String]
#
# @!attribute [rw] idx
#   @return [String, nil]
#
# @!attribute [rw] last_name
#   @return [String, nil]
#
# @!attribute [rw] name
#   @return [String]
#
# @!attribute [rw] permissions
#   @return [Array, nil]
#
# @!attribute [rw] phone_number
#   @return [String, nil]
#
# @!attribute [rw] size
#   @return [Integer]
#
# @!attribute [rw] source
#   @return [String, nil]
Contact = Struct.new(
  :birthday_date,
  :city,
  :collection,
  :contact_expire_after,
  :contacts_count,
  :country,
  :created_by,
  :date_created,
  :date_updated,
  :description,
  :email,
  :first_name,
  :gender,
  :groups,
  :id,
  :idx,
  :last_name,
  :name,
  :permissions,
  :phone_number,
  :size,
  :source,
  keyword_init: true
)

# Request payload for Contact#load.
#
# @!attribute [rw] id
#   @return [String]
ContactLoadMatch = Struct.new(
  :id,
  keyword_init: true
)

# Request payload for Contact#list.
#
# @!attribute [rw] birthday_date
#   @return [Array, nil]
#
# @!attribute [rw] email
#   @return [Array, nil]
#
# @!attribute [rw] first_name
#   @return [Array, nil]
#
# @!attribute [rw] gender
#   @return [String, nil]
#
# @!attribute [rw] group_id
#   @return [Array, nil]
#
# @!attribute [rw] last_name
#   @return [Array, nil]
#
# @!attribute [rw] limit
#   @return [Integer, nil]
#
# @!attribute [rw] offset
#   @return [Integer, nil]
#
# @!attribute [rw] order_by
#   @return [String, nil]
#
# @!attribute [rw] phone_number
#   @return [Array, nil]
#
# @!attribute [rw] q
#   @return [String, nil]
ContactListMatch = Struct.new(
  :birthday_date,
  :email,
  :first_name,
  :gender,
  :group_id,
  :last_name,
  :limit,
  :offset,
  :order_by,
  :phone_number,
  :q,
  keyword_init: true
)

# Request payload for Contact#create.
#
# @!attribute [rw] birthday_date
#   @return [String, nil]
#
# @!attribute [rw] city
#   @return [String, nil]
#
# @!attribute [rw] collection
#   @return [Array]
#
# @!attribute [rw] contact_expire_after
#   @return [Integer]
#
# @!attribute [rw] contacts_count
#   @return [Integer]
#
# @!attribute [rw] country
#   @return [String, nil]
#
# @!attribute [rw] created_by
#   @return [String]
#
# @!attribute [rw] date_created
#   @return [String]
#
# @!attribute [rw] date_updated
#   @return [String]
#
# @!attribute [rw] description
#   @return [String, nil]
#
# @!attribute [rw] email
#   @return [String, nil]
#
# @!attribute [rw] first_name
#   @return [String, nil]
#
# @!attribute [rw] gender
#   @return [String]
#
# @!attribute [rw] groups
#   @return [Array]
#
# @!attribute [rw] id
#   @return [String]
#
# @!attribute [rw] idx
#   @return [String, nil]
#
# @!attribute [rw] last_name
#   @return [String, nil]
#
# @!attribute [rw] name
#   @return [String]
#
# @!attribute [rw] permissions
#   @return [Array, nil]
#
# @!attribute [rw] phone_number
#   @return [String, nil]
#
# @!attribute [rw] size
#   @return [Integer]
#
# @!attribute [rw] source
#   @return [String, nil]
ContactCreateData = Struct.new(
  :birthday_date,
  :city,
  :collection,
  :contact_expire_after,
  :contacts_count,
  :country,
  :created_by,
  :date_created,
  :date_updated,
  :description,
  :email,
  :first_name,
  :gender,
  :groups,
  :id,
  :idx,
  :last_name,
  :name,
  :permissions,
  :phone_number,
  :size,
  :source,
  keyword_init: true
)

# Request payload for Contact#update.
#
# @!attribute [rw] id
#   @return [String]
#
# @!attribute [rw] birthday_date
#   @return [String, nil]
#
# @!attribute [rw] city
#   @return [String, nil]
#
# @!attribute [rw] collection
#   @return [Array, nil]
#
# @!attribute [rw] contact_expire_after
#   @return [Integer, nil]
#
# @!attribute [rw] contacts_count
#   @return [Integer, nil]
#
# @!attribute [rw] country
#   @return [String, nil]
#
# @!attribute [rw] created_by
#   @return [String, nil]
#
# @!attribute [rw] date_created
#   @return [String, nil]
#
# @!attribute [rw] date_updated
#   @return [String, nil]
#
# @!attribute [rw] description
#   @return [String, nil]
#
# @!attribute [rw] email
#   @return [String, nil]
#
# @!attribute [rw] first_name
#   @return [String, nil]
#
# @!attribute [rw] gender
#   @return [String, nil]
#
# @!attribute [rw] groups
#   @return [Array, nil]
#
# @!attribute [rw] idx
#   @return [String, nil]
#
# @!attribute [rw] last_name
#   @return [String, nil]
#
# @!attribute [rw] name
#   @return [String, nil]
#
# @!attribute [rw] permissions
#   @return [Array, nil]
#
# @!attribute [rw] phone_number
#   @return [String, nil]
#
# @!attribute [rw] size
#   @return [Integer, nil]
#
# @!attribute [rw] source
#   @return [String, nil]
ContactUpdateData = Struct.new(
  :id,
  :birthday_date,
  :city,
  :collection,
  :contact_expire_after,
  :contacts_count,
  :country,
  :created_by,
  :date_created,
  :date_updated,
  :description,
  :email,
  :first_name,
  :gender,
  :groups,
  :idx,
  :last_name,
  :name,
  :permissions,
  :phone_number,
  :size,
  :source,
  keyword_init: true
)

# Request payload for Contact#remove.
#
# @!attribute [rw] id
#   @return [String]
ContactRemoveMatch = Struct.new(
  :id,
  keyword_init: true
)

# ContactsField entity data model.
#
# @!attribute [rw] id
#   @return [String, nil]
#
# @!attribute [rw] name
#   @return [String, nil]
#
# @!attribute [rw] type
#   @return [String, nil]
ContactsField = Struct.new(
  :id,
  :name,
  :type,
  keyword_init: true
)

# Request payload for ContactsField#list.
#
# @!attribute [rw] id
#   @return [String, nil]
#
# @!attribute [rw] name
#   @return [String, nil]
#
# @!attribute [rw] type
#   @return [String, nil]
ContactsFieldListMatch = Struct.new(
  :id,
  :name,
  :type,
  keyword_init: true
)

# Request payload for ContactsField#create.
#
# @!attribute [rw] id
#   @return [String, nil]
#
# @!attribute [rw] name
#   @return [String, nil]
#
# @!attribute [rw] type
#   @return [String, nil]
ContactsFieldCreateData = Struct.new(
  :id,
  :name,
  :type,
  keyword_init: true
)

# Request payload for ContactsField#update.
#
# @!attribute [rw] id
#   @return [String]
#
# @!attribute [rw] name
#   @return [String, nil]
#
# @!attribute [rw] type
#   @return [String, nil]
ContactsFieldUpdateData = Struct.new(
  :id,
  :name,
  :type,
  keyword_init: true
)

# Request payload for ContactsField#remove.
#
# @!attribute [rw] id
#   @return [String]
ContactsFieldRemoveMatch = Struct.new(
  :id,
  keyword_init: true
)

# ContactsFieldOption entity data model.
class ContactsFieldOption
end

# Request payload for ContactsFieldOption#list.
#
# @!attribute [rw] field_id
#   @return [String]
ContactsFieldOptionListMatch = Struct.new(
  :field_id,
  keyword_init: true
)

# Contactsgroup entity data model.
#
# @!attribute [rw] group_id
#   @return [String]
#
# @!attribute [rw] read
#   @return [Boolean]
#
# @!attribute [rw] send
#   @return [Boolean]
#
# @!attribute [rw] username
#   @return [String]
#
# @!attribute [rw] write
#   @return [Boolean]
Contactsgroup = Struct.new(
  :group_id,
  :read,
  :send,
  :username,
  :write,
  keyword_init: true
)

# Request payload for Contactsgroup#list.
#
# @!attribute [rw] name
#   @return [Hash, nil]
#
# @!attribute [rw] with
#   @return [Array, nil]
ContactsgroupListMatch = Struct.new(
  :name,
  :with,
  keyword_init: true
)

# Request payload for Contactsgroup#create.
#
# @!attribute [rw] group_id
#   @return [String]
#
# @!attribute [rw] read
#   @return [Boolean]
#
# @!attribute [rw] send
#   @return [Boolean]
#
# @!attribute [rw] username
#   @return [String]
#
# @!attribute [rw] write
#   @return [Boolean]
ContactsgroupCreateData = Struct.new(
  :group_id,
  :read,
  :send,
  :username,
  :write,
  keyword_init: true
)

# Request payload for Contactsgroup#update.
#
# @!attribute [rw] group_id
#   @return [String]
#
# @!attribute [rw] username
#   @return [String, nil]
#
# @!attribute [rw] read
#   @return [Boolean, nil]
#
# @!attribute [rw] send
#   @return [Boolean, nil]
#
# @!attribute [rw] write
#   @return [Boolean, nil]
ContactsgroupUpdateData = Struct.new(
  :group_id,
  :username,
  :read,
  :send,
  :write,
  keyword_init: true
)

# Request payload for Contactsgroup#remove.
#
# @!attribute [rw] group_id
#   @return [String]
ContactsgroupRemoveMatch = Struct.new(
  :group_id,
  keyword_init: true
)

# Contactstrash entity data model.
class Contactstrash
end

# Request payload for Contactstrash#update.
class ContactstrashUpdateData
end

# Request payload for Contactstrash#remove.
class ContactstrashRemoveMatch
end

# FieldAvailable entity data model.
#
# @!attribute [rw] built_in
#   @return [Boolean, nil]
#
# @!attribute [rw] id
#   @return [String, nil]
#
# @!attribute [rw] name
#   @return [String, nil]
#
# @!attribute [rw] options
#   @return [Array, nil]
#
# @!attribute [rw] type
#   @return [String, nil]
FieldAvailable = Struct.new(
  :built_in,
  :id,
  :name,
  :options,
  :type,
  keyword_init: true
)

# Request payload for FieldAvailable#list.
#
# @!attribute [rw] built_in
#   @return [Boolean, nil]
#
# @!attribute [rw] id
#   @return [String, nil]
#
# @!attribute [rw] name
#   @return [String, nil]
#
# @!attribute [rw] options
#   @return [Array, nil]
#
# @!attribute [rw] type
#   @return [String, nil]
FieldAvailableListMatch = Struct.new(
  :built_in,
  :id,
  :name,
  :options,
  :type,
  keyword_init: true
)

# Group entity data model.
#
# @!attribute [rw] contact_expire_after
#   @return [Integer]
#
# @!attribute [rw] contacts_count
#   @return [Integer]
#
# @!attribute [rw] created_by
#   @return [String]
#
# @!attribute [rw] date_created
#   @return [String]
#
# @!attribute [rw] date_updated
#   @return [String]
#
# @!attribute [rw] description
#   @return [String]
#
# @!attribute [rw] id
#   @return [String]
#
# @!attribute [rw] idx
#   @return [String, nil]
#
# @!attribute [rw] name
#   @return [String]
#
# @!attribute [rw] permissions
#   @return [Array, nil]
Group = Struct.new(
  :contact_expire_after,
  :contacts_count,
  :created_by,
  :date_created,
  :date_updated,
  :description,
  :id,
  :idx,
  :name,
  :permissions,
  keyword_init: true
)

# Request payload for Group#load.
#
# @!attribute [rw] id
#   @return [String]
GroupLoadMatch = Struct.new(
  :id,
  keyword_init: true
)

# Request payload for Group#update.
#
# @!attribute [rw] id
#   @return [String]
#
# @!attribute [rw] contact_expire_after
#   @return [Integer, nil]
#
# @!attribute [rw] contacts_count
#   @return [Integer, nil]
#
# @!attribute [rw] created_by
#   @return [String, nil]
#
# @!attribute [rw] date_created
#   @return [String, nil]
#
# @!attribute [rw] date_updated
#   @return [String, nil]
#
# @!attribute [rw] description
#   @return [String, nil]
#
# @!attribute [rw] idx
#   @return [String, nil]
#
# @!attribute [rw] name
#   @return [String, nil]
#
# @!attribute [rw] permissions
#   @return [Array, nil]
GroupUpdateData = Struct.new(
  :id,
  :contact_expire_after,
  :contacts_count,
  :created_by,
  :date_created,
  :date_updated,
  :description,
  :idx,
  :name,
  :permissions,
  keyword_init: true
)

# MfaCode entity data model.
#
# @!attribute [rw] content
#   @return [String, nil]
#
# @!attribute [rw] fast
#   @return [Object, nil]
#
# @!attribute [rw] from
#   @return [String, nil]
#
# @!attribute [rw] phone_number
#   @return [String]
MfaCode = Struct.new(
  :content,
  :fast,
  :from,
  :phone_number,
  keyword_init: true
)

# Request payload for MfaCode#create.
#
# @!attribute [rw] content
#   @return [String, nil]
#
# @!attribute [rw] fast
#   @return [Object, nil]
#
# @!attribute [rw] from
#   @return [String, nil]
#
# @!attribute [rw] phone_number
#   @return [String]
MfaCodeCreateData = Struct.new(
  :content,
  :fast,
  :from,
  :phone_number,
  keyword_init: true
)

# OptOut entity data model.
#
# @!attribute [rw] date
#   @return [String, nil]
#
# @!attribute [rw] id
#   @return [String, nil]
#
# @!attribute [rw] links
#   @return [Array, nil]
#
# @!attribute [rw] phoneNumber
#   @return [Integer, nil]
OptOut = Struct.new(
  :date,
  :id,
  :links,
  :phoneNumber,
  keyword_init: true
)

# Request payload for OptOut#list.
#
# @!attribute [rw] limit
#   @return [Integer, nil]
#
# @!attribute [rw] offset
#   @return [Integer, nil]
#
# @!attribute [rw] phone_number
#   @return [String, nil]
OptOutListMatch = Struct.new(
  :limit,
  :offset,
  :phone_number,
  keyword_init: true
)

# Request payload for OptOut#remove.
#
# @!attribute [rw] id
#   @return [String]
OptOutRemoveMatch = Struct.new(
  :id,
  keyword_init: true
)

# OptOutSetting entity data model.
#
# @!attribute [rw] brand
#   @return [String, nil]
OptOutSetting = Struct.new(
  :brand,
  keyword_init: true
)

# Request payload for OptOutSetting#load.
#
# @!attribute [rw] brand
#   @return [String, nil]
OptOutSettingLoadMatch = Struct.new(
  :brand,
  keyword_init: true
)

# Request payload for OptOutSetting#update.
#
# @!attribute [rw] brand
#   @return [String, nil]
OptOutSettingUpdateData = Struct.new(
  :brand,
  keyword_init: true
)

# Permission entity data model.
#
# @!attribute [rw] group_id
#   @return [String]
#
# @!attribute [rw] id
#   @return [String, nil]
#
# @!attribute [rw] read
#   @return [Boolean]
#
# @!attribute [rw] send
#   @return [Boolean]
#
# @!attribute [rw] username
#   @return [String]
#
# @!attribute [rw] write
#   @return [Boolean]
Permission = Struct.new(
  :group_id,
  :id,
  :read,
  :send,
  :username,
  :write,
  keyword_init: true
)

# Request payload for Permission#load.
#
# @!attribute [rw] group_id
#   @return [String]
#
# @!attribute [rw] id
#   @return [String]
PermissionLoadMatch = Struct.new(
  :group_id,
  :id,
  keyword_init: true
)

# Request payload for Permission#create.
#
# @!attribute [rw] group_id
#   @return [String]
#
# @!attribute [rw] id
#   @return [String, nil]
#
# @!attribute [rw] read
#   @return [Boolean]
#
# @!attribute [rw] send
#   @return [Boolean]
#
# @!attribute [rw] username
#   @return [String]
#
# @!attribute [rw] write
#   @return [Boolean]
PermissionCreateData = Struct.new(
  :group_id,
  :id,
  :read,
  :send,
  :username,
  :write,
  keyword_init: true
)

# Ping entity data model.
#
# @!attribute [rw] authorized
#   @return [Boolean]
#
# @!attribute [rw] unavailable
#   @return [Array]
Ping = Struct.new(
  :authorized,
  :unavailable,
  keyword_init: true
)

# Request payload for Ping#list.
#
# @!attribute [rw] authorized
#   @return [Boolean, nil]
#
# @!attribute [rw] unavailable
#   @return [Array, nil]
PingListMatch = Struct.new(
  :authorized,
  :unavailable,
  keyword_init: true
)

# Profile entity data model.
#
# @!attribute [rw] email
#   @return [String]
#
# @!attribute [rw] name
#   @return [String]
#
# @!attribute [rw] payment_type
#   @return [String]
#
# @!attribute [rw] phone_number
#   @return [Integer]
#
# @!attribute [rw] points
#   @return [Float, nil]
#
# @!attribute [rw] user_type
#   @return [String]
#
# @!attribute [rw] username
#   @return [String]
Profile = Struct.new(
  :email,
  :name,
  :payment_type,
  :phone_number,
  :points,
  :user_type,
  :username,
  keyword_init: true
)

# Request payload for Profile#load.
#
# @!attribute [rw] email
#   @return [String, nil]
#
# @!attribute [rw] name
#   @return [String, nil]
#
# @!attribute [rw] payment_type
#   @return [String, nil]
#
# @!attribute [rw] phone_number
#   @return [Integer, nil]
#
# @!attribute [rw] points
#   @return [Float, nil]
#
# @!attribute [rw] user_type
#   @return [String, nil]
#
# @!attribute [rw] username
#   @return [String, nil]
ProfileLoadMatch = Struct.new(
  :email,
  :name,
  :payment_type,
  :phone_number,
  :points,
  :user_type,
  :username,
  keyword_init: true
)

# Request payload for Profile#list.
#
# @!attribute [rw] type
#   @return [String, nil]
ProfileListMatch = Struct.new(
  :type,
  keyword_init: true
)

# Rcs entity data model.
class Rcs
end

# Request payload for Rcs#list.
class RcsListMatch
end

# Sendername entity data model.
#
# @!attribute [rw] created_at
#   @return [String, nil]
#
# @!attribute [rw] id
#   @return [String, nil]
#
# @!attribute [rw] is_default
#   @return [Boolean, nil]
#
# @!attribute [rw] sender
#   @return [String, nil]
#
# @!attribute [rw] status
#   @return [String, nil]
Sendername = Struct.new(
  :created_at,
  :id,
  :is_default,
  :sender,
  :status,
  keyword_init: true
)

# Request payload for Sendername#load.
#
# @!attribute [rw] id
#   @return [String]
SendernameLoadMatch = Struct.new(
  :id,
  keyword_init: true
)

# Request payload for Sendername#list.
#
# @!attribute [rw] created_at
#   @return [String, nil]
#
# @!attribute [rw] id
#   @return [String, nil]
#
# @!attribute [rw] is_default
#   @return [Boolean, nil]
#
# @!attribute [rw] sender
#   @return [String, nil]
#
# @!attribute [rw] status
#   @return [String, nil]
SendernameListMatch = Struct.new(
  :created_at,
  :id,
  :is_default,
  :sender,
  :status,
  keyword_init: true
)

# Request payload for Sendername#create.
#
# @!attribute [rw] created_at
#   @return [String, nil]
#
# @!attribute [rw] id
#   @return [String, nil]
#
# @!attribute [rw] is_default
#   @return [Boolean, nil]
#
# @!attribute [rw] sender
#   @return [String, nil]
#
# @!attribute [rw] status
#   @return [String, nil]
SendernameCreateData = Struct.new(
  :created_at,
  :id,
  :is_default,
  :sender,
  :status,
  keyword_init: true
)

# SendernameStatement entity data model.
#
# @!attribute [rw] content
#   @return [String, nil]
#
# @!attribute [rw] statements
#   @return [Array, nil]
#
# @!attribute [rw] title
#   @return [String, nil]
SendernameStatement = Struct.new(
  :content,
  :statements,
  :title,
  keyword_init: true
)

# Request payload for SendernameStatement#list.
#
# @!attribute [rw] content
#   @return [String, nil]
#
# @!attribute [rw] statements
#   @return [Array, nil]
#
# @!attribute [rw] title
#   @return [String, nil]
SendernameStatementListMatch = Struct.new(
  :content,
  :statements,
  :title,
  keyword_init: true
)

# SentRcsMessage entity data model.
#
# @!attribute [rw] content
#   @return [Hash, nil]
#
# @!attribute [rw] phone_number
#   @return [String]
#
# @!attribute [rw] sender
#   @return [String]
#
# @!attribute [rw] text
#   @return [String, nil]
SentRcsMessage = Struct.new(
  :content,
  :phone_number,
  :sender,
  :text,
  keyword_init: true
)

# Request payload for SentRcsMessage#create.
#
# @!attribute [rw] content
#   @return [Hash, nil]
#
# @!attribute [rw] phone_number
#   @return [String]
#
# @!attribute [rw] sender
#   @return [String]
#
# @!attribute [rw] text
#   @return [String, nil]
SentRcsMessageCreateData = Struct.new(
  :content,
  :phone_number,
  :sender,
  :text,
  keyword_init: true
)

# ShipmentCountryVolume entity data model.
#
# @!attribute [rw] country_code
#   @return [String, nil]
#
# @!attribute [rw] country_limit
#   @return [Integer, nil]
#
# @!attribute [rw] country_name
#   @return [String, nil]
#
# @!attribute [rw] usage
#   @return [Integer, nil]
ShipmentCountryVolume = Struct.new(
  :country_code,
  :country_limit,
  :country_name,
  :usage,
  keyword_init: true
)

# Request payload for ShipmentCountryVolume#list.
#
# @!attribute [rw] month
#   @return [String, nil]
#
# @!attribute [rw] year
#   @return [String, nil]
ShipmentCountryVolumeListMatch = Struct.new(
  :month,
  :year,
  keyword_init: true
)

# ShortUrl entity data model.
#
# @!attribute [rw] description
#   @return [String, nil]
#
# @!attribute [rw] expire
#   @return [String, nil]
#
# @!attribute [rw] filename
#   @return [String, nil]
#
# @!attribute [rw] hits
#   @return [Integer, nil]
#
# @!attribute [rw] hits_unique
#   @return [Integer, nil]
#
# @!attribute [rw] id
#   @return [String, nil]
#
# @!attribute [rw] name
#   @return [String, nil]
#
# @!attribute [rw] short_url
#   @return [String, nil]
#
# @!attribute [rw] type
#   @return [String, nil]
#
# @!attribute [rw] url
#   @return [String, nil]
ShortUrl = Struct.new(
  :description,
  :expire,
  :filename,
  :hits,
  :hits_unique,
  :id,
  :name,
  :short_url,
  :type,
  :url,
  keyword_init: true
)

# Request payload for ShortUrl#load.
#
# @!attribute [rw] id
#   @return [String]
ShortUrlLoadMatch = Struct.new(
  :id,
  keyword_init: true
)

# Request payload for ShortUrl#list.
#
# @!attribute [rw] description
#   @return [String, nil]
#
# @!attribute [rw] expire
#   @return [String, nil]
#
# @!attribute [rw] filename
#   @return [String, nil]
#
# @!attribute [rw] hits
#   @return [Integer, nil]
#
# @!attribute [rw] hits_unique
#   @return [Integer, nil]
#
# @!attribute [rw] id
#   @return [String, nil]
#
# @!attribute [rw] name
#   @return [String, nil]
#
# @!attribute [rw] short_url
#   @return [String, nil]
#
# @!attribute [rw] type
#   @return [String, nil]
#
# @!attribute [rw] url
#   @return [String, nil]
ShortUrlListMatch = Struct.new(
  :description,
  :expire,
  :filename,
  :hits,
  :hits_unique,
  :id,
  :name,
  :short_url,
  :type,
  :url,
  keyword_init: true
)

# Request payload for ShortUrl#create.
#
# @!attribute [rw] description
#   @return [String, nil]
#
# @!attribute [rw] expire
#   @return [String, nil]
#
# @!attribute [rw] filename
#   @return [String, nil]
#
# @!attribute [rw] hits
#   @return [Integer, nil]
#
# @!attribute [rw] hits_unique
#   @return [Integer, nil]
#
# @!attribute [rw] id
#   @return [String, nil]
#
# @!attribute [rw] name
#   @return [String, nil]
#
# @!attribute [rw] short_url
#   @return [String, nil]
#
# @!attribute [rw] type
#   @return [String, nil]
#
# @!attribute [rw] url
#   @return [String, nil]
ShortUrlCreateData = Struct.new(
  :description,
  :expire,
  :filename,
  :hits,
  :hits_unique,
  :id,
  :name,
  :short_url,
  :type,
  :url,
  keyword_init: true
)

# Request payload for ShortUrl#update.
#
# @!attribute [rw] id
#   @return [String]
#
# @!attribute [rw] description
#   @return [String, nil]
#
# @!attribute [rw] expire
#   @return [String, nil]
#
# @!attribute [rw] filename
#   @return [String, nil]
#
# @!attribute [rw] hits
#   @return [Integer, nil]
#
# @!attribute [rw] hits_unique
#   @return [Integer, nil]
#
# @!attribute [rw] name
#   @return [String, nil]
#
# @!attribute [rw] short_url
#   @return [String, nil]
#
# @!attribute [rw] type
#   @return [String, nil]
#
# @!attribute [rw] url
#   @return [String, nil]
ShortUrlUpdateData = Struct.new(
  :id,
  :description,
  :expire,
  :filename,
  :hits,
  :hits_unique,
  :name,
  :short_url,
  :type,
  :url,
  keyword_init: true
)

# Request payload for ShortUrl#remove.
#
# @!attribute [rw] id
#   @return [String]
ShortUrlRemoveMatch = Struct.new(
  :id,
  keyword_init: true
)

# Smsdo entity data model.
#
# @!attribute [rw] allow_duplicates
#   @return [Integer, nil]
#
# @!attribute [rw] check_idx
#   @return [Object, nil]
#
# @!attribute [rw] date
#   @return [Object, nil]
#
# @!attribute [rw] date_validate
#   @return [Integer, nil]
#
# @!attribute [rw] details
#   @return [Object, nil]
#
# @!attribute [rw] encoding
#   @return [String, nil]
#
# @!attribute [rw] expiration_date
#   @return [Object, nil]
#
# @!attribute [rw] fallback
#   @return [Array, nil]
#
# @!attribute [rw] fast
#   @return [Integer, nil]
#
# @!attribute [rw] flash
#   @return [Integer, nil]
#
# @!attribute [rw] format
#   @return [String, nil]
#
# @!attribute [rw] from
#   @return [String, nil]
#
# @!attribute [rw] group
#   @return [String, nil]
#
# @!attribute [rw] idx
#   @return [String, nil]
#
# @!attribute [rw] max_parts
#   @return [Integer, nil]
#
# @!attribute [rw] message
#   @return [String, nil]
#
# @!attribute [rw] normalize
#   @return [Integer, nil]
#
# @!attribute [rw] notify_url
#   @return [String, nil]
#
# @!attribute [rw] test
#   @return [Object, nil]
#
# @!attribute [rw] time_restriction
#   @return [String, nil]
#
# @!attribute [rw] to
#   @return [String, nil]
Smsdo = Struct.new(
  :allow_duplicates,
  :check_idx,
  :date,
  :date_validate,
  :details,
  :encoding,
  :expiration_date,
  :fallback,
  :fast,
  :flash,
  :format,
  :from,
  :group,
  :idx,
  :max_parts,
  :message,
  :normalize,
  :notify_url,
  :test,
  :time_restriction,
  :to,
  keyword_init: true
)

# Request payload for Smsdo#create.
#
# @!attribute [rw] allow_duplicates
#   @return [Integer, nil]
#
# @!attribute [rw] check_idx
#   @return [Object, nil]
#
# @!attribute [rw] date
#   @return [Object, nil]
#
# @!attribute [rw] date_validate
#   @return [Integer, nil]
#
# @!attribute [rw] details
#   @return [Object, nil]
#
# @!attribute [rw] encoding
#   @return [String, nil]
#
# @!attribute [rw] expiration_date
#   @return [Object, nil]
#
# @!attribute [rw] fallback
#   @return [Array, nil]
#
# @!attribute [rw] fast
#   @return [Integer, nil]
#
# @!attribute [rw] flash
#   @return [Integer, nil]
#
# @!attribute [rw] format
#   @return [String, nil]
#
# @!attribute [rw] from
#   @return [String, nil]
#
# @!attribute [rw] group
#   @return [String, nil]
#
# @!attribute [rw] idx
#   @return [String, nil]
#
# @!attribute [rw] max_parts
#   @return [Integer, nil]
#
# @!attribute [rw] message
#   @return [String, nil]
#
# @!attribute [rw] normalize
#   @return [Integer, nil]
#
# @!attribute [rw] notify_url
#   @return [String, nil]
#
# @!attribute [rw] test
#   @return [Object, nil]
#
# @!attribute [rw] time_restriction
#   @return [String, nil]
#
# @!attribute [rw] to
#   @return [String, nil]
SmsdoCreateData = Struct.new(
  :allow_duplicates,
  :check_idx,
  :date,
  :date_validate,
  :details,
  :encoding,
  :expiration_date,
  :fallback,
  :fast,
  :flash,
  :format,
  :from,
  :group,
  :idx,
  :max_parts,
  :message,
  :normalize,
  :notify_url,
  :test,
  :time_restriction,
  :to,
  keyword_init: true
)

# Smssendername entity data model.
class Smssendername
end

# Request payload for Smssendername#create.
#
# @!attribute [rw] sender
#   @return [String]
SmssendernameCreateData = Struct.new(
  :sender,
  keyword_init: true
)

# Request payload for Smssendername#remove.
#
# @!attribute [rw] sender
#   @return [String]
SmssendernameRemoveMatch = Struct.new(
  :sender,
  keyword_init: true
)

# Smstemplate entity data model.
#
# @!attribute [rw] id
#   @return [String, nil]
Smstemplate = Struct.new(
  :id,
  keyword_init: true
)

# Request payload for Smstemplate#remove.
#
# @!attribute [rw] id
#   @return [String]
SmstemplateRemoveMatch = Struct.new(
  :id,
  keyword_init: true
)

# Subuser entity data model.
#
# @!attribute [rw] active
#   @return [Boolean, nil]
#
# @!attribute [rw] credentials
#   @return [Hash]
#
# @!attribute [rw] description
#   @return [String, nil]
#
# @!attribute [rw] id
#   @return [String, nil]
#
# @!attribute [rw] points
#   @return [Hash, nil]
#
# @!attribute [rw] username
#   @return [String, nil]
Subuser = Struct.new(
  :active,
  :credentials,
  :description,
  :id,
  :points,
  :username,
  keyword_init: true
)

# Request payload for Subuser#load.
#
# @!attribute [rw] id
#   @return [String]
SubuserLoadMatch = Struct.new(
  :id,
  keyword_init: true
)

# Request payload for Subuser#list.
#
# @!attribute [rw] q
#   @return [String, nil]
SubuserListMatch = Struct.new(
  :q,
  keyword_init: true
)

# Request payload for Subuser#create.
#
# @!attribute [rw] active
#   @return [Boolean, nil]
#
# @!attribute [rw] credentials
#   @return [Hash]
#
# @!attribute [rw] description
#   @return [String, nil]
#
# @!attribute [rw] id
#   @return [String, nil]
#
# @!attribute [rw] points
#   @return [Hash, nil]
#
# @!attribute [rw] username
#   @return [String, nil]
SubuserCreateData = Struct.new(
  :active,
  :credentials,
  :description,
  :id,
  :points,
  :username,
  keyword_init: true
)

# Request payload for Subuser#update.
#
# @!attribute [rw] id
#   @return [String]
#
# @!attribute [rw] active
#   @return [Boolean, nil]
#
# @!attribute [rw] credentials
#   @return [Hash, nil]
#
# @!attribute [rw] description
#   @return [String, nil]
#
# @!attribute [rw] points
#   @return [Hash, nil]
#
# @!attribute [rw] username
#   @return [String, nil]
SubuserUpdateData = Struct.new(
  :id,
  :active,
  :credentials,
  :description,
  :points,
  :username,
  keyword_init: true
)

# Request payload for Subuser#remove.
#
# @!attribute [rw] id
#   @return [String]
SubuserRemoveMatch = Struct.new(
  :id,
  keyword_init: true
)

# Template entity data model.
#
# @!attribute [rw] id
#   @return [String, nil]
#
# @!attribute [rw] name
#   @return [String, nil]
#
# @!attribute [rw] normalize
#   @return [Boolean, nil]
#
# @!attribute [rw] template
#   @return [String, nil]
Template = Struct.new(
  :id,
  :name,
  :normalize,
  :template,
  keyword_init: true
)

# Request payload for Template#load.
#
# @!attribute [rw] id
#   @return [String]
TemplateLoadMatch = Struct.new(
  :id,
  keyword_init: true
)

# Request payload for Template#list.
#
# @!attribute [rw] id
#   @return [String, nil]
#
# @!attribute [rw] name
#   @return [String, nil]
#
# @!attribute [rw] normalize
#   @return [Boolean, nil]
#
# @!attribute [rw] template
#   @return [String, nil]
TemplateListMatch = Struct.new(
  :id,
  :name,
  :normalize,
  :template,
  keyword_init: true
)

# Request payload for Template#create.
#
# @!attribute [rw] id
#   @return [String, nil]
#
# @!attribute [rw] name
#   @return [String, nil]
#
# @!attribute [rw] normalize
#   @return [Boolean, nil]
#
# @!attribute [rw] template
#   @return [String, nil]
TemplateCreateData = Struct.new(
  :id,
  :name,
  :normalize,
  :template,
  keyword_init: true
)

# Request payload for Template#update.
#
# @!attribute [rw] id
#   @return [String]
#
# @!attribute [rw] name
#   @return [String, nil]
#
# @!attribute [rw] normalize
#   @return [Boolean, nil]
#
# @!attribute [rw] template
#   @return [String, nil]
TemplateUpdateData = Struct.new(
  :id,
  :name,
  :normalize,
  :template,
  keyword_init: true
)

# UserRcsSenderCollection entity data model.
class UserRcsSenderCollection
end

# Request payload for UserRcsSenderCollection#list.
class UserRcsSenderCollectionListMatch
end

