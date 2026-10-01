-- Typed models for the Smsapi SDK (LuaLS annotations).
--
-- GENERATED from the API model: main.kit.entity.<e>.fields{} and per-op
-- params (op.<name>.points[].g.params[]). Field/param types come from the
-- canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
-- @voxgig/apidef VALID_CANON). Annotations only — no runtime effect. Do not
-- edit by hand.

---@class Available
---@field name? string
---@field normalize? boolean
---@field template? string

---@class AvailableListMatch
---@field name? string
---@field normalize? boolean
---@field template? string

---@class Blacklist
---@field id? string

---@class BlacklistLoadMatch
---@field limit? number
---@field offset? number
---@field q? number

---@class BlacklistCreateData
---@field id? string

---@class BlacklistRemoveMatch
---@field id string

---@class Callback
---@field active? boolean
---@field api_version? number
---@field id? string
---@field invalid? boolean
---@field receiver? table
---@field receiver_type? string
---@field type? string
---@field url? string

---@class CallbackLoadMatch
---@field id string

---@class CallbackListMatch
---@field active? boolean
---@field api_version? number
---@field id? string
---@field invalid? boolean
---@field receiver? table
---@field receiver_type? string
---@field type? string
---@field url? string

---@class CallbackCreateData
---@field active? boolean
---@field api_version? number
---@field id? string
---@field invalid? boolean
---@field receiver? table
---@field receiver_type? string
---@field type? string
---@field url? string

---@class CallbackUpdateData
---@field id string
---@field active? boolean
---@field api_version? number
---@field invalid? boolean
---@field receiver? table
---@field receiver_type? string
---@field type? string
---@field url? string

---@class CallbackRemoveMatch
---@field id string

---@class Contact
---@field birthday_date? string
---@field city? string
---@field collection table
---@field contact_expire_after number
---@field contacts_count number
---@field country? string
---@field created_by string
---@field date_created string
---@field date_updated string
---@field description? string
---@field email? string
---@field first_name? string
---@field gender string
---@field group_id? string
---@field groups table
---@field id string
---@field idx? string
---@field last_name? string
---@field name string
---@field permissions? table
---@field phone_number? string
---@field read? boolean
---@field send? boolean
---@field size number
---@field source? string
---@field type? string
---@field username? string
---@field value? string
---@field write? boolean

---@class ContactLoadMatch
---@field id string

---@class ContactListMatch
---@field birthday_date? table
---@field email? table
---@field first_name? table
---@field gender? string
---@field group_id? table
---@field last_name? table
---@field limit? number
---@field offset? number
---@field order_by? string
---@field phone_number? table
---@field q? string

---@class ContactCreateData
---@field birthday_date? string
---@field city? string
---@field collection table
---@field contact_expire_after number
---@field contacts_count number
---@field country? string
---@field created_by string
---@field date_created string
---@field date_updated string
---@field description? string
---@field email? string
---@field first_name? string
---@field gender string
---@field group_id? string
---@field groups table
---@field id string
---@field idx? string
---@field last_name? string
---@field name string
---@field permissions? table
---@field phone_number? string
---@field read? boolean
---@field send? boolean
---@field size number
---@field source? string
---@field type? string
---@field username? string
---@field value? string
---@field write? boolean

---@class ContactUpdateData
---@field id string
---@field birthday_date? string
---@field city? string
---@field collection? table
---@field contact_expire_after? number
---@field contacts_count? number
---@field country? string
---@field created_by? string
---@field date_created? string
---@field date_updated? string
---@field description? string
---@field email? string
---@field first_name? string
---@field gender? string
---@field group_id? string
---@field groups? table
---@field idx? string
---@field last_name? string
---@field name? string
---@field permissions? table
---@field phone_number? string
---@field read? boolean
---@field send? boolean
---@field size? number
---@field source? string
---@field type? string
---@field username? string
---@field value? string
---@field write? boolean

---@class ContactRemoveMatch
---@field id string

---@class ContactsField
---@field birthday_date? string
---@field city? string
---@field contact_expire_after number
---@field contacts_count? number
---@field country? string
---@field created_by string
---@field date_created string
---@field date_updated string
---@field description? string
---@field email? string
---@field first_name? string
---@field gender string
---@field group_id? string
---@field groups table
---@field id? string
---@field idx? string
---@field last_name? string
---@field name? string
---@field permissions? table
---@field phone_number? string
---@field read? boolean
---@field send? boolean
---@field source? string
---@field type? string
---@field username? string
---@field value? string
---@field write? boolean

---@class ContactsFieldListMatch
---@field birthday_date? string
---@field city? string
---@field contact_expire_after? number
---@field contacts_count? number
---@field country? string
---@field created_by? string
---@field date_created? string
---@field date_updated? string
---@field description? string
---@field email? string
---@field first_name? string
---@field gender? string
---@field group_id? string
---@field groups? table
---@field id? string
---@field idx? string
---@field last_name? string
---@field name? string
---@field permissions? table
---@field phone_number? string
---@field read? boolean
---@field send? boolean
---@field source? string
---@field type? string
---@field username? string
---@field value? string
---@field write? boolean

---@class ContactsFieldCreateData
---@field birthday_date? string
---@field city? string
---@field contact_expire_after number
---@field contacts_count? number
---@field country? string
---@field created_by string
---@field date_created string
---@field date_updated string
---@field description? string
---@field email? string
---@field first_name? string
---@field gender string
---@field group_id? string
---@field groups table
---@field id? string
---@field idx? string
---@field last_name? string
---@field name? string
---@field permissions? table
---@field phone_number? string
---@field read? boolean
---@field send? boolean
---@field source? string
---@field type? string
---@field username? string
---@field value? string
---@field write? boolean

---@class ContactsFieldUpdateData
---@field id string
---@field birthday_date? string
---@field city? string
---@field contact_expire_after? number
---@field contacts_count? number
---@field country? string
---@field created_by? string
---@field date_created? string
---@field date_updated? string
---@field description? string
---@field email? string
---@field first_name? string
---@field gender? string
---@field group_id? string
---@field groups? table
---@field idx? string
---@field last_name? string
---@field name? string
---@field permissions? table
---@field phone_number? string
---@field read? boolean
---@field send? boolean
---@field source? string
---@field type? string
---@field username? string
---@field value? string
---@field write? boolean

---@class ContactsFieldRemoveMatch
---@field id string

---@class ContactsFieldOption
---@field birthday_date? string
---@field city? string
---@field contact_expire_after number
---@field contacts_count? number
---@field country? string
---@field created_by string
---@field date_created string
---@field date_updated string
---@field description? string
---@field email? string
---@field first_name? string
---@field gender string
---@field group_id? string
---@field groups table
---@field id string
---@field idx? string
---@field last_name? string
---@field name? string
---@field permissions? table
---@field phone_number? string
---@field read? boolean
---@field send? boolean
---@field source? string
---@field type? string
---@field username? string
---@field value? string
---@field write? boolean

---@class ContactsFieldOptionListMatch
---@field field_id string

---@class Contactsgroup
---@field birthday_date? string
---@field city? string
---@field contact_expire_after number
---@field contacts_count? number
---@field country? string
---@field created_by string
---@field date_created string
---@field date_updated string
---@field description? string
---@field email? string
---@field first_name? string
---@field gender string
---@field group_id string
---@field groups table
---@field id string
---@field idx? string
---@field last_name? string
---@field name? string
---@field permissions? table
---@field phone_number? string
---@field read boolean
---@field send boolean
---@field source? string
---@field type? string
---@field username string
---@field value? string
---@field write boolean

---@class ContactsgroupListMatch
---@field name? table
---@field with? table

---@class ContactsgroupCreateData
---@field birthday_date? string
---@field city? string
---@field contact_expire_after number
---@field contacts_count? number
---@field country? string
---@field created_by string
---@field date_created string
---@field date_updated string
---@field description? string
---@field email? string
---@field first_name? string
---@field gender string
---@field group_id string
---@field groups table
---@field id string
---@field idx? string
---@field last_name? string
---@field name? string
---@field permissions? table
---@field phone_number? string
---@field read boolean
---@field send boolean
---@field source? string
---@field type? string
---@field username string
---@field value? string
---@field write boolean

---@class ContactsgroupUpdateData
---@field group_id string
---@field username? string
---@field birthday_date? string
---@field city? string
---@field contact_expire_after? number
---@field contacts_count? number
---@field country? string
---@field created_by? string
---@field date_created? string
---@field date_updated? string
---@field description? string
---@field email? string
---@field first_name? string
---@field gender? string
---@field groups? table
---@field id? string
---@field idx? string
---@field last_name? string
---@field name? string
---@field permissions? table
---@field phone_number? string
---@field read? boolean
---@field send? boolean
---@field source? string
---@field type? string
---@field value? string
---@field write? boolean

---@class ContactsgroupRemoveMatch
---@field group_id string

---@class Contactstrash

---@class ContactstrashUpdateData

---@class ContactstrashRemoveMatch

---@class FieldAvailable
---@field built_in? boolean
---@field id? string
---@field name? string
---@field options? table
---@field type? string

---@class FieldAvailableListMatch
---@field built_in? boolean
---@field id? string
---@field name? string
---@field options? table
---@field type? string

---@class Group
---@field contact_expire_after number
---@field contacts_count number
---@field created_by string
---@field date_created string
---@field date_updated string
---@field description string
---@field id string
---@field idx? string
---@field name string
---@field permissions? table

---@class GroupLoadMatch
---@field id string

---@class GroupUpdateData
---@field id string
---@field contact_expire_after? number
---@field contacts_count? number
---@field created_by? string
---@field date_created? string
---@field date_updated? string
---@field description? string
---@field idx? string
---@field name? string
---@field permissions? table

---@class MfaCode
---@field content? string
---@field fast? any
---@field from? string
---@field phone_number string

---@class MfaCodeCreateData
---@field content? string
---@field fast? any
---@field from? string
---@field phone_number string

---@class OptOut
---@field date? string
---@field id? string
---@field links? table
---@field phoneNumber? number

---@class OptOutListMatch
---@field limit? number
---@field offset? number
---@field phone_number? string

---@class OptOutRemoveMatch
---@field id string

---@class OptOutSetting
---@field brand? string

---@class OptOutSettingLoadMatch
---@field brand? string

---@class OptOutSettingUpdateData
---@field brand? string

---@class Permission
---@field group_id string
---@field id? string
---@field read boolean
---@field send boolean
---@field username string
---@field write boolean

---@class PermissionLoadMatch
---@field group_id string
---@field id string
---@field username string

---@class PermissionCreateData
---@field group_id string
---@field id? string
---@field read boolean
---@field send boolean
---@field username string
---@field write boolean

---@class Ping
---@field authorized boolean
---@field unavailable table

---@class PingListMatch
---@field authorized? boolean
---@field unavailable? table

---@class Profile
---@field email string
---@field name string
---@field payment_type string
---@field phone_number number
---@field points? number
---@field user_type string
---@field username string

---@class ProfileLoadMatch
---@field email? string
---@field name? string
---@field payment_type? string
---@field phone_number? number
---@field points? number
---@field user_type? string
---@field username? string

---@class ProfileListMatch
---@field type? string

---@class Rcs

---@class RcsListMatch

---@class Sendername
---@field created_at? string
---@field id? string
---@field is_default? boolean
---@field sender? string
---@field status? string

---@class SendernameLoadMatch
---@field id string

---@class SendernameListMatch
---@field created_at? string
---@field id? string
---@field is_default? boolean
---@field sender? string
---@field status? string

---@class SendernameCreateData
---@field created_at? string
---@field id? string
---@field is_default? boolean
---@field sender? string
---@field status? string

---@class SendernameStatement
---@field content? string
---@field statements? table
---@field title? string

---@class SendernameStatementListMatch
---@field content? string
---@field statements? table
---@field title? string

---@class SentRcsMessage
---@field content? table
---@field phone_number string
---@field sender any
---@field text? string

---@class SentRcsMessageCreateData
---@field content? table
---@field phone_number string
---@field sender any
---@field text? string

---@class ShipmentCountryVolume
---@field country_code? string
---@field country_limit? number
---@field country_name? string
---@field usage? number

---@class ShipmentCountryVolumeListMatch
---@field month? string
---@field year? string

---@class ShortUrl
---@field description? string
---@field expire? string
---@field filename? string
---@field hits? number
---@field hits_unique? number
---@field id? string
---@field name? string
---@field short_url? string
---@field type? string
---@field url? string

---@class ShortUrlLoadMatch
---@field id string

---@class ShortUrlListMatch
---@field description? string
---@field expire? string
---@field filename? string
---@field hits? number
---@field hits_unique? number
---@field id? string
---@field name? string
---@field short_url? string
---@field type? string
---@field url? string

---@class ShortUrlCreateData
---@field description? string
---@field expire? string
---@field filename? string
---@field hits? number
---@field hits_unique? number
---@field id? string
---@field name? string
---@field short_url? string
---@field type? string
---@field url? string

---@class ShortUrlUpdateData
---@field id string
---@field description? string
---@field expire? string
---@field filename? string
---@field hits? number
---@field hits_unique? number
---@field name? string
---@field short_url? string
---@field type? string
---@field url? string

---@class ShortUrlRemoveMatch
---@field id string

---@class Smsdo
---@field allow_duplicates? number
---@field check_idx? any
---@field date? any
---@field date_validate? number
---@field details? any
---@field encoding? string
---@field expiration_date? any
---@field fallback? table
---@field fast? number
---@field flash? number
---@field format? string
---@field from? string
---@field group? string
---@field idx? string
---@field max_parts? number
---@field message? string
---@field normalize? number
---@field notify_url? string
---@field test? any
---@field time_restriction? string
---@field to? string

---@class SmsdoCreateData
---@field allow_duplicates? number
---@field check_idx? any
---@field date? any
---@field date_validate? number
---@field details? any
---@field encoding? string
---@field expiration_date? any
---@field fallback? table
---@field fast? number
---@field flash? number
---@field format? string
---@field from? string
---@field group? string
---@field idx? string
---@field max_parts? number
---@field message? string
---@field normalize? number
---@field notify_url? string
---@field test? any
---@field time_restriction? string
---@field to? string

---@class Smssendername

---@class SmssendernameCreateData
---@field sendername_id string

---@class SmssendernameRemoveMatch
---@field sender string

---@class Smstemplate
---@field id? string

---@class SmstemplateRemoveMatch
---@field id string

---@class Subuser
---@field active? boolean
---@field credentials table
---@field description? string
---@field id? string
---@field points? table
---@field username? string

---@class SubuserLoadMatch
---@field id string

---@class SubuserListMatch
---@field q? string

---@class SubuserCreateData
---@field active? boolean
---@field credentials table
---@field description? string
---@field id? string
---@field points? table
---@field username? string

---@class SubuserUpdateData
---@field id string
---@field active? boolean
---@field credentials? table
---@field description? string
---@field points? table
---@field username? string

---@class SubuserRemoveMatch
---@field id string

---@class Template
---@field id? string
---@field name? string
---@field normalize? boolean
---@field template? string

---@class TemplateLoadMatch
---@field id string

---@class TemplateListMatch
---@field id? string
---@field name? string
---@field normalize? boolean
---@field template? string

---@class TemplateCreateData
---@field id? string
---@field name? string
---@field normalize? boolean
---@field template? string

---@class TemplateUpdateData
---@field id string
---@field name? string
---@field normalize? boolean
---@field template? string

---@class UserRcsSenderCollection
---@field deliveredAt? string
---@field expiredAt? string
---@field id? string
---@field interface? string
---@field messageType? string
---@field readAt? string
---@field recipient? string
---@field sender? string
---@field senderId? string
---@field sentAt? string

---@class UserRcsSenderCollectionListMatch
---@field deliveredAt? string
---@field expiredAt? string
---@field id? string
---@field interface? string
---@field messageType? string
---@field readAt? string
---@field recipient? string
---@field sender? string
---@field senderId? string
---@field sentAt? string

local M = {}

return M
