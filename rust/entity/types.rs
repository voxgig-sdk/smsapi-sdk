// Typed models for the Smsapi SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields{} and per-op
// params (op.<name>.points[].g.params[]). Field/param types are mapped
// from the canonical type sentinels. Do not edit by hand.
//
// These are DOCUMENTARY: the SDK runtime is dynamic (ops take/return the
// `Value` enum), so nothing consumes these structs yet — they mirror the
// entity/op shapes for reference and IDE support.
#![allow(dead_code, non_snake_case, unused_imports)]

use crate::utility::voxgigstruct::Value;

/// Available is the typed data model for the available entity.
#[derive(Debug, Clone)]
pub struct Available {
    pub name: Option<String>,
    pub normalize: Option<bool>,
    pub template: Option<String>,
}

/// AvailableListMatch is the typed request payload for Available.list.
#[derive(Debug, Clone)]
pub struct AvailableListMatch {
    pub name: Option<String>,
    pub normalize: Option<bool>,
    pub template: Option<String>,
}

/// Blacklist is the typed data model for the blacklist entity.
#[derive(Debug, Clone)]
pub struct Blacklist {
    pub id: Option<String>,
}

/// BlacklistLoadMatch is the typed request payload for Blacklist.load.
#[derive(Debug, Clone)]
pub struct BlacklistLoadMatch {
    pub limit: Option<i64>,
    pub offset: Option<i64>,
    pub q: Option<i64>,
}

/// BlacklistCreateData is the typed request payload for Blacklist.create.
#[derive(Debug, Clone)]
pub struct BlacklistCreateData {
    pub id: Option<String>,
}

/// BlacklistRemoveMatch is the typed request payload for Blacklist.remove.
#[derive(Debug, Clone)]
pub struct BlacklistRemoveMatch {
    pub id: String,
}

/// Callback is the typed data model for the callback entity.
#[derive(Debug, Clone)]
pub struct Callback {
    pub active: Option<bool>,
    pub api_version: Option<i64>,
    pub id: Option<String>,
    pub invalid: Option<bool>,
    pub receiver: Option<std::collections::HashMap<String, Value>>,
    pub receiver_type: Option<String>,
    pub type_: Option<String>,
    pub url: Option<String>,
}

/// CallbackLoadMatch is the typed request payload for Callback.load.
#[derive(Debug, Clone)]
pub struct CallbackLoadMatch {
    pub id: String,
}

/// CallbackListMatch is the typed request payload for Callback.list.
#[derive(Debug, Clone)]
pub struct CallbackListMatch {
    pub active: Option<bool>,
    pub api_version: Option<i64>,
    pub id: Option<String>,
    pub invalid: Option<bool>,
    pub receiver: Option<std::collections::HashMap<String, Value>>,
    pub receiver_type: Option<String>,
    pub type_: Option<String>,
    pub url: Option<String>,
}

/// CallbackCreateData is the typed request payload for Callback.create.
#[derive(Debug, Clone)]
pub struct CallbackCreateData {
    pub active: Option<bool>,
    pub api_version: Option<i64>,
    pub id: Option<String>,
    pub invalid: Option<bool>,
    pub receiver: Option<std::collections::HashMap<String, Value>>,
    pub receiver_type: Option<String>,
    pub type_: Option<String>,
    pub url: Option<String>,
}

/// CallbackUpdateData is the typed request payload for Callback.update.
#[derive(Debug, Clone)]
pub struct CallbackUpdateData {
    pub id: String,
    pub active: Option<bool>,
    pub api_version: Option<i64>,
    pub invalid: Option<bool>,
    pub receiver: Option<std::collections::HashMap<String, Value>>,
    pub receiver_type: Option<String>,
    pub type_: Option<String>,
    pub url: Option<String>,
}

/// CallbackRemoveMatch is the typed request payload for Callback.remove.
#[derive(Debug, Clone)]
pub struct CallbackRemoveMatch {
    pub id: String,
}

/// Contact is the typed data model for the contact entity.
#[derive(Debug, Clone)]
pub struct Contact {
    pub birthday_date: Option<String>,
    pub city: Option<String>,
    pub collection: Vec<Value>,
    pub contact_expire_after: i64,
    pub contacts_count: i64,
    pub country: Option<String>,
    pub created_by: String,
    pub date_created: String,
    pub date_updated: String,
    pub description: Option<String>,
    pub email: Option<String>,
    pub first_name: Option<String>,
    pub gender: String,
    pub group_id: Option<String>,
    pub groups: Vec<Value>,
    pub id: String,
    pub idx: Option<String>,
    pub last_name: Option<String>,
    pub name: String,
    pub permissions: Option<Vec<Value>>,
    pub phone_number: Option<String>,
    pub read: Option<bool>,
    pub send: Option<bool>,
    pub size: i64,
    pub source: Option<String>,
    pub type_: Option<String>,
    pub username: Option<String>,
    pub value: Option<String>,
    pub write: Option<bool>,
}

/// ContactLoadMatch is the typed request payload for Contact.load.
#[derive(Debug, Clone)]
pub struct ContactLoadMatch {
    pub id: String,
}

/// ContactListMatch is the typed request payload for Contact.list.
#[derive(Debug, Clone)]
pub struct ContactListMatch {
    pub birthday_date: Option<Vec<Value>>,
    pub email: Option<Vec<Value>>,
    pub first_name: Option<Vec<Value>>,
    pub gender: Option<String>,
    pub group_id: Option<Vec<Value>>,
    pub last_name: Option<Vec<Value>>,
    pub limit: Option<i64>,
    pub offset: Option<i64>,
    pub order_by: Option<String>,
    pub phone_number: Option<Vec<Value>>,
    pub q: Option<String>,
}

/// ContactCreateData is the typed request payload for Contact.create.
#[derive(Debug, Clone)]
pub struct ContactCreateData {
    pub birthday_date: Option<String>,
    pub city: Option<String>,
    pub collection: Vec<Value>,
    pub contact_expire_after: i64,
    pub contacts_count: i64,
    pub country: Option<String>,
    pub created_by: String,
    pub date_created: String,
    pub date_updated: String,
    pub description: Option<String>,
    pub email: Option<String>,
    pub first_name: Option<String>,
    pub gender: String,
    pub group_id: Option<String>,
    pub groups: Vec<Value>,
    pub id: String,
    pub idx: Option<String>,
    pub last_name: Option<String>,
    pub name: String,
    pub permissions: Option<Vec<Value>>,
    pub phone_number: Option<String>,
    pub read: Option<bool>,
    pub send: Option<bool>,
    pub size: i64,
    pub source: Option<String>,
    pub type_: Option<String>,
    pub username: Option<String>,
    pub value: Option<String>,
    pub write: Option<bool>,
}

/// ContactUpdateData is the typed request payload for Contact.update.
#[derive(Debug, Clone)]
pub struct ContactUpdateData {
    pub id: String,
    pub birthday_date: Option<String>,
    pub city: Option<String>,
    pub collection: Option<Vec<Value>>,
    pub contact_expire_after: Option<i64>,
    pub contacts_count: Option<i64>,
    pub country: Option<String>,
    pub created_by: Option<String>,
    pub date_created: Option<String>,
    pub date_updated: Option<String>,
    pub description: Option<String>,
    pub email: Option<String>,
    pub first_name: Option<String>,
    pub gender: Option<String>,
    pub group_id: Option<String>,
    pub groups: Option<Vec<Value>>,
    pub idx: Option<String>,
    pub last_name: Option<String>,
    pub name: Option<String>,
    pub permissions: Option<Vec<Value>>,
    pub phone_number: Option<String>,
    pub read: Option<bool>,
    pub send: Option<bool>,
    pub size: Option<i64>,
    pub source: Option<String>,
    pub type_: Option<String>,
    pub username: Option<String>,
    pub value: Option<String>,
    pub write: Option<bool>,
}

/// ContactRemoveMatch is the typed request payload for Contact.remove.
#[derive(Debug, Clone)]
pub struct ContactRemoveMatch {
    pub id: String,
}

/// ContactsField is the typed data model for the contacts_field entity.
#[derive(Debug, Clone)]
pub struct ContactsField {
    pub birthday_date: Option<String>,
    pub city: Option<String>,
    pub contact_expire_after: i64,
    pub contacts_count: Option<i64>,
    pub country: Option<String>,
    pub created_by: String,
    pub date_created: String,
    pub date_updated: String,
    pub description: Option<String>,
    pub email: Option<String>,
    pub first_name: Option<String>,
    pub gender: String,
    pub group_id: Option<String>,
    pub groups: Vec<Value>,
    pub id: Option<String>,
    pub idx: Option<String>,
    pub last_name: Option<String>,
    pub name: Option<String>,
    pub permissions: Option<Vec<Value>>,
    pub phone_number: Option<String>,
    pub read: Option<bool>,
    pub send: Option<bool>,
    pub source: Option<String>,
    pub type_: Option<String>,
    pub username: Option<String>,
    pub value: Option<String>,
    pub write: Option<bool>,
}

/// ContactsFieldListMatch is the typed request payload for ContactsField.list.
#[derive(Debug, Clone)]
pub struct ContactsFieldListMatch {
    pub birthday_date: Option<String>,
    pub city: Option<String>,
    pub contact_expire_after: Option<i64>,
    pub contacts_count: Option<i64>,
    pub country: Option<String>,
    pub created_by: Option<String>,
    pub date_created: Option<String>,
    pub date_updated: Option<String>,
    pub description: Option<String>,
    pub email: Option<String>,
    pub first_name: Option<String>,
    pub gender: Option<String>,
    pub group_id: Option<String>,
    pub groups: Option<Vec<Value>>,
    pub id: Option<String>,
    pub idx: Option<String>,
    pub last_name: Option<String>,
    pub name: Option<String>,
    pub permissions: Option<Vec<Value>>,
    pub phone_number: Option<String>,
    pub read: Option<bool>,
    pub send: Option<bool>,
    pub source: Option<String>,
    pub type_: Option<String>,
    pub username: Option<String>,
    pub value: Option<String>,
    pub write: Option<bool>,
}

/// ContactsFieldCreateData is the typed request payload for ContactsField.create.
#[derive(Debug, Clone)]
pub struct ContactsFieldCreateData {
    pub birthday_date: Option<String>,
    pub city: Option<String>,
    pub contact_expire_after: i64,
    pub contacts_count: Option<i64>,
    pub country: Option<String>,
    pub created_by: String,
    pub date_created: String,
    pub date_updated: String,
    pub description: Option<String>,
    pub email: Option<String>,
    pub first_name: Option<String>,
    pub gender: String,
    pub group_id: Option<String>,
    pub groups: Vec<Value>,
    pub id: Option<String>,
    pub idx: Option<String>,
    pub last_name: Option<String>,
    pub name: Option<String>,
    pub permissions: Option<Vec<Value>>,
    pub phone_number: Option<String>,
    pub read: Option<bool>,
    pub send: Option<bool>,
    pub source: Option<String>,
    pub type_: Option<String>,
    pub username: Option<String>,
    pub value: Option<String>,
    pub write: Option<bool>,
}

/// ContactsFieldUpdateData is the typed request payload for ContactsField.update.
#[derive(Debug, Clone)]
pub struct ContactsFieldUpdateData {
    pub id: String,
    pub birthday_date: Option<String>,
    pub city: Option<String>,
    pub contact_expire_after: Option<i64>,
    pub contacts_count: Option<i64>,
    pub country: Option<String>,
    pub created_by: Option<String>,
    pub date_created: Option<String>,
    pub date_updated: Option<String>,
    pub description: Option<String>,
    pub email: Option<String>,
    pub first_name: Option<String>,
    pub gender: Option<String>,
    pub group_id: Option<String>,
    pub groups: Option<Vec<Value>>,
    pub idx: Option<String>,
    pub last_name: Option<String>,
    pub name: Option<String>,
    pub permissions: Option<Vec<Value>>,
    pub phone_number: Option<String>,
    pub read: Option<bool>,
    pub send: Option<bool>,
    pub source: Option<String>,
    pub type_: Option<String>,
    pub username: Option<String>,
    pub value: Option<String>,
    pub write: Option<bool>,
}

/// ContactsFieldRemoveMatch is the typed request payload for ContactsField.remove.
#[derive(Debug, Clone)]
pub struct ContactsFieldRemoveMatch {
    pub id: String,
}

/// ContactsFieldOption is the typed data model for the contacts_field_option entity.
#[derive(Debug, Clone)]
pub struct ContactsFieldOption {
    pub birthday_date: Option<String>,
    pub city: Option<String>,
    pub contact_expire_after: i64,
    pub contacts_count: Option<i64>,
    pub country: Option<String>,
    pub created_by: String,
    pub date_created: String,
    pub date_updated: String,
    pub description: Option<String>,
    pub email: Option<String>,
    pub first_name: Option<String>,
    pub gender: String,
    pub group_id: Option<String>,
    pub groups: Vec<Value>,
    pub id: String,
    pub idx: Option<String>,
    pub last_name: Option<String>,
    pub name: Option<String>,
    pub permissions: Option<Vec<Value>>,
    pub phone_number: Option<String>,
    pub read: Option<bool>,
    pub send: Option<bool>,
    pub source: Option<String>,
    pub type_: Option<String>,
    pub username: Option<String>,
    pub value: Option<String>,
    pub write: Option<bool>,
}

/// ContactsFieldOptionListMatch is the typed request payload for ContactsFieldOption.list.
#[derive(Debug, Clone)]
pub struct ContactsFieldOptionListMatch {
    pub field_id: String,
}

/// Contactsgroup is the typed data model for the contactsgroup entity.
#[derive(Debug, Clone)]
pub struct Contactsgroup {
    pub birthday_date: Option<String>,
    pub city: Option<String>,
    pub contact_expire_after: i64,
    pub contacts_count: Option<i64>,
    pub country: Option<String>,
    pub created_by: String,
    pub date_created: String,
    pub date_updated: String,
    pub description: Option<String>,
    pub email: Option<String>,
    pub first_name: Option<String>,
    pub gender: String,
    pub group_id: String,
    pub groups: Vec<Value>,
    pub id: String,
    pub idx: Option<String>,
    pub last_name: Option<String>,
    pub name: Option<String>,
    pub permissions: Option<Vec<Value>>,
    pub phone_number: Option<String>,
    pub read: bool,
    pub send: bool,
    pub source: Option<String>,
    pub type_: Option<String>,
    pub username: String,
    pub value: Option<String>,
    pub write: bool,
}

/// ContactsgroupListMatch is the typed request payload for Contactsgroup.list.
#[derive(Debug, Clone)]
pub struct ContactsgroupListMatch {
    pub name: Option<std::collections::HashMap<String, Value>>,
    pub with: Option<Vec<Value>>,
}

/// ContactsgroupCreateData is the typed request payload for Contactsgroup.create.
#[derive(Debug, Clone)]
pub struct ContactsgroupCreateData {
    pub birthday_date: Option<String>,
    pub city: Option<String>,
    pub contact_expire_after: i64,
    pub contacts_count: Option<i64>,
    pub country: Option<String>,
    pub created_by: String,
    pub date_created: String,
    pub date_updated: String,
    pub description: Option<String>,
    pub email: Option<String>,
    pub first_name: Option<String>,
    pub gender: String,
    pub group_id: String,
    pub groups: Vec<Value>,
    pub id: String,
    pub idx: Option<String>,
    pub last_name: Option<String>,
    pub name: Option<String>,
    pub permissions: Option<Vec<Value>>,
    pub phone_number: Option<String>,
    pub read: bool,
    pub send: bool,
    pub source: Option<String>,
    pub type_: Option<String>,
    pub username: String,
    pub value: Option<String>,
    pub write: bool,
}

/// ContactsgroupUpdateData is the typed request payload for Contactsgroup.update.
#[derive(Debug, Clone)]
pub struct ContactsgroupUpdateData {
    pub group_id: String,
    pub username: Option<String>,
    pub birthday_date: Option<String>,
    pub city: Option<String>,
    pub contact_expire_after: Option<i64>,
    pub contacts_count: Option<i64>,
    pub country: Option<String>,
    pub created_by: Option<String>,
    pub date_created: Option<String>,
    pub date_updated: Option<String>,
    pub description: Option<String>,
    pub email: Option<String>,
    pub first_name: Option<String>,
    pub gender: Option<String>,
    pub groups: Option<Vec<Value>>,
    pub id: Option<String>,
    pub idx: Option<String>,
    pub last_name: Option<String>,
    pub name: Option<String>,
    pub permissions: Option<Vec<Value>>,
    pub phone_number: Option<String>,
    pub read: Option<bool>,
    pub send: Option<bool>,
    pub source: Option<String>,
    pub type_: Option<String>,
    pub value: Option<String>,
    pub write: Option<bool>,
}

/// ContactsgroupRemoveMatch is the typed request payload for Contactsgroup.remove.
#[derive(Debug, Clone)]
pub struct ContactsgroupRemoveMatch {
    pub group_id: String,
}

/// Contactstrash is the typed data model for the contactstrash entity.
#[derive(Debug, Clone)]
pub struct Contactstrash {
}

/// ContactstrashUpdateData is the typed request payload for Contactstrash.update.
#[derive(Debug, Clone)]
pub struct ContactstrashUpdateData {
}

/// ContactstrashRemoveMatch is the typed request payload for Contactstrash.remove.
#[derive(Debug, Clone)]
pub struct ContactstrashRemoveMatch {
}

/// FieldAvailable is the typed data model for the field_available entity.
#[derive(Debug, Clone)]
pub struct FieldAvailable {
    pub built_in: Option<bool>,
    pub id: Option<String>,
    pub name: Option<String>,
    pub options: Option<Vec<Value>>,
    pub type_: Option<String>,
}

/// FieldAvailableListMatch is the typed request payload for FieldAvailable.list.
#[derive(Debug, Clone)]
pub struct FieldAvailableListMatch {
    pub built_in: Option<bool>,
    pub id: Option<String>,
    pub name: Option<String>,
    pub options: Option<Vec<Value>>,
    pub type_: Option<String>,
}

/// Group is the typed data model for the group entity.
#[derive(Debug, Clone)]
pub struct Group {
    pub contact_expire_after: i64,
    pub contacts_count: i64,
    pub created_by: String,
    pub date_created: String,
    pub date_updated: String,
    pub description: String,
    pub id: String,
    pub idx: Option<String>,
    pub name: String,
    pub permissions: Option<Vec<Value>>,
}

/// GroupLoadMatch is the typed request payload for Group.load.
#[derive(Debug, Clone)]
pub struct GroupLoadMatch {
    pub id: String,
}

/// GroupUpdateData is the typed request payload for Group.update.
#[derive(Debug, Clone)]
pub struct GroupUpdateData {
    pub id: String,
    pub contact_expire_after: Option<i64>,
    pub contacts_count: Option<i64>,
    pub created_by: Option<String>,
    pub date_created: Option<String>,
    pub date_updated: Option<String>,
    pub description: Option<String>,
    pub idx: Option<String>,
    pub name: Option<String>,
    pub permissions: Option<Vec<Value>>,
}

/// MfaCode is the typed data model for the mfa_code entity.
#[derive(Debug, Clone)]
pub struct MfaCode {
    pub content: Option<String>,
    pub fast: Option<Value>,
    pub from: Option<String>,
    pub phone_number: String,
}

/// MfaCodeCreateData is the typed request payload for MfaCode.create.
#[derive(Debug, Clone)]
pub struct MfaCodeCreateData {
    pub content: Option<String>,
    pub fast: Option<Value>,
    pub from: Option<String>,
    pub phone_number: String,
}

/// OptOut is the typed data model for the opt_out entity.
#[derive(Debug, Clone)]
pub struct OptOut {
    pub date: Option<String>,
    pub id: Option<String>,
    pub links: Option<Vec<Value>>,
    pub phonenumber: Option<i64>,
}

/// OptOutListMatch is the typed request payload for OptOut.list.
#[derive(Debug, Clone)]
pub struct OptOutListMatch {
    pub limit: Option<i64>,
    pub offset: Option<i64>,
    pub phone_number: Option<String>,
}

/// OptOutRemoveMatch is the typed request payload for OptOut.remove.
#[derive(Debug, Clone)]
pub struct OptOutRemoveMatch {
    pub id: String,
}

/// OptOutSetting is the typed data model for the opt_out_setting entity.
#[derive(Debug, Clone)]
pub struct OptOutSetting {
    pub brand: Option<String>,
}

/// OptOutSettingLoadMatch is the typed request payload for OptOutSetting.load.
#[derive(Debug, Clone)]
pub struct OptOutSettingLoadMatch {
    pub brand: Option<String>,
}

/// OptOutSettingUpdateData is the typed request payload for OptOutSetting.update.
#[derive(Debug, Clone)]
pub struct OptOutSettingUpdateData {
    pub brand: Option<String>,
}

/// Permission is the typed data model for the permission entity.
#[derive(Debug, Clone)]
pub struct Permission {
    pub group_id: String,
    pub id: Option<String>,
    pub read: bool,
    pub send: bool,
    pub username: String,
    pub write: bool,
}

/// PermissionLoadMatch is the typed request payload for Permission.load.
#[derive(Debug, Clone)]
pub struct PermissionLoadMatch {
    pub group_id: String,
    pub id: String,
    pub username: String,
}

/// PermissionCreateData is the typed request payload for Permission.create.
#[derive(Debug, Clone)]
pub struct PermissionCreateData {
    pub group_id: String,
    pub id: Option<String>,
    pub read: bool,
    pub send: bool,
    pub username: String,
    pub write: bool,
}

/// Ping is the typed data model for the ping entity.
#[derive(Debug, Clone)]
pub struct Ping {
    pub authorized: bool,
    pub unavailable: Vec<Value>,
}

/// PingListMatch is the typed request payload for Ping.list.
#[derive(Debug, Clone)]
pub struct PingListMatch {
    pub authorized: Option<bool>,
    pub unavailable: Option<Vec<Value>>,
}

/// Profile is the typed data model for the profile entity.
#[derive(Debug, Clone)]
pub struct Profile {
    pub email: String,
    pub name: String,
    pub payment_type: String,
    pub phone_number: i64,
    pub points: Option<f64>,
    pub user_type: String,
    pub username: String,
}

/// ProfileLoadMatch is the typed request payload for Profile.load.
#[derive(Debug, Clone)]
pub struct ProfileLoadMatch {
    pub email: Option<String>,
    pub name: Option<String>,
    pub payment_type: Option<String>,
    pub phone_number: Option<i64>,
    pub points: Option<f64>,
    pub user_type: Option<String>,
    pub username: Option<String>,
}

/// ProfileListMatch is the typed request payload for Profile.list.
#[derive(Debug, Clone)]
pub struct ProfileListMatch {
    pub type_: Option<String>,
}

/// Rcs is the typed data model for the rcs entity.
#[derive(Debug, Clone)]
pub struct Rcs {
}

/// RcsListMatch is the typed request payload for Rcs.list.
#[derive(Debug, Clone)]
pub struct RcsListMatch {
}

/// Sendername is the typed data model for the sendername entity.
#[derive(Debug, Clone)]
pub struct Sendername {
    pub created_at: Option<String>,
    pub id: Option<String>,
    pub is_default: Option<bool>,
    pub sender: Option<String>,
    pub status: Option<String>,
}

/// SendernameLoadMatch is the typed request payload for Sendername.load.
#[derive(Debug, Clone)]
pub struct SendernameLoadMatch {
    pub id: String,
}

/// SendernameListMatch is the typed request payload for Sendername.list.
#[derive(Debug, Clone)]
pub struct SendernameListMatch {
    pub created_at: Option<String>,
    pub id: Option<String>,
    pub is_default: Option<bool>,
    pub sender: Option<String>,
    pub status: Option<String>,
}

/// SendernameCreateData is the typed request payload for Sendername.create.
#[derive(Debug, Clone)]
pub struct SendernameCreateData {
    pub created_at: Option<String>,
    pub id: Option<String>,
    pub is_default: Option<bool>,
    pub sender: Option<String>,
    pub status: Option<String>,
}

/// SendernameStatement is the typed data model for the sendername_statement entity.
#[derive(Debug, Clone)]
pub struct SendernameStatement {
    pub content: Option<String>,
    pub statements: Option<Vec<Value>>,
    pub title: Option<String>,
}

/// SendernameStatementListMatch is the typed request payload for SendernameStatement.list.
#[derive(Debug, Clone)]
pub struct SendernameStatementListMatch {
    pub content: Option<String>,
    pub statements: Option<Vec<Value>>,
    pub title: Option<String>,
}

/// SentRcsMessage is the typed data model for the sent_rcs_message entity.
#[derive(Debug, Clone)]
pub struct SentRcsMessage {
    pub content: Option<std::collections::HashMap<String, Value>>,
    pub phone_number: String,
    pub sender: Value,
    pub text: Option<String>,
}

/// SentRcsMessageCreateData is the typed request payload for SentRcsMessage.create.
#[derive(Debug, Clone)]
pub struct SentRcsMessageCreateData {
    pub content: Option<std::collections::HashMap<String, Value>>,
    pub phone_number: String,
    pub sender: Value,
    pub text: Option<String>,
}

/// ShipmentCountryVolume is the typed data model for the shipment_country_volume entity.
#[derive(Debug, Clone)]
pub struct ShipmentCountryVolume {
    pub country_code: Option<String>,
    pub country_limit: Option<i64>,
    pub country_name: Option<String>,
    pub usage: Option<i64>,
}

/// ShipmentCountryVolumeListMatch is the typed request payload for ShipmentCountryVolume.list.
#[derive(Debug, Clone)]
pub struct ShipmentCountryVolumeListMatch {
    pub month: Option<String>,
    pub year: Option<String>,
}

/// ShortUrl is the typed data model for the short_url entity.
#[derive(Debug, Clone)]
pub struct ShortUrl {
    pub description: Option<String>,
    pub expire: Option<String>,
    pub filename: Option<String>,
    pub hits: Option<i64>,
    pub hits_unique: Option<i64>,
    pub id: Option<String>,
    pub name: Option<String>,
    pub short_url: Option<String>,
    pub type_: Option<String>,
    pub url: Option<String>,
}

/// ShortUrlLoadMatch is the typed request payload for ShortUrl.load.
#[derive(Debug, Clone)]
pub struct ShortUrlLoadMatch {
    pub id: String,
}

/// ShortUrlListMatch is the typed request payload for ShortUrl.list.
#[derive(Debug, Clone)]
pub struct ShortUrlListMatch {
    pub description: Option<String>,
    pub expire: Option<String>,
    pub filename: Option<String>,
    pub hits: Option<i64>,
    pub hits_unique: Option<i64>,
    pub id: Option<String>,
    pub name: Option<String>,
    pub short_url: Option<String>,
    pub type_: Option<String>,
    pub url: Option<String>,
}

/// ShortUrlCreateData is the typed request payload for ShortUrl.create.
#[derive(Debug, Clone)]
pub struct ShortUrlCreateData {
    pub description: Option<String>,
    pub expire: Option<String>,
    pub filename: Option<String>,
    pub hits: Option<i64>,
    pub hits_unique: Option<i64>,
    pub id: Option<String>,
    pub name: Option<String>,
    pub short_url: Option<String>,
    pub type_: Option<String>,
    pub url: Option<String>,
}

/// ShortUrlUpdateData is the typed request payload for ShortUrl.update.
#[derive(Debug, Clone)]
pub struct ShortUrlUpdateData {
    pub id: String,
    pub description: Option<String>,
    pub expire: Option<String>,
    pub filename: Option<String>,
    pub hits: Option<i64>,
    pub hits_unique: Option<i64>,
    pub name: Option<String>,
    pub short_url: Option<String>,
    pub type_: Option<String>,
    pub url: Option<String>,
}

/// ShortUrlRemoveMatch is the typed request payload for ShortUrl.remove.
#[derive(Debug, Clone)]
pub struct ShortUrlRemoveMatch {
    pub id: String,
}

/// Smsdo is the typed data model for the smsdo entity.
#[derive(Debug, Clone)]
pub struct Smsdo {
    pub allow_duplicates: Option<i64>,
    pub check_idx: Option<Value>,
    pub date: Option<Value>,
    pub date_validate: Option<i64>,
    pub details: Option<Value>,
    pub encoding: Option<String>,
    pub expiration_date: Option<Value>,
    pub fallback: Option<Vec<Value>>,
    pub fast: Option<i64>,
    pub flash: Option<i64>,
    pub format: Option<String>,
    pub from: Option<String>,
    pub group: Option<String>,
    pub idx: Option<String>,
    pub max_parts: Option<i64>,
    pub message: Option<String>,
    pub normalize: Option<i64>,
    pub notify_url: Option<String>,
    pub test: Option<Value>,
    pub time_restriction: Option<String>,
    pub to: Option<String>,
}

/// SmsdoCreateData is the typed request payload for Smsdo.create.
#[derive(Debug, Clone)]
pub struct SmsdoCreateData {
    pub allow_duplicates: Option<i64>,
    pub check_idx: Option<Value>,
    pub date: Option<Value>,
    pub date_validate: Option<i64>,
    pub details: Option<Value>,
    pub encoding: Option<String>,
    pub expiration_date: Option<Value>,
    pub fallback: Option<Vec<Value>>,
    pub fast: Option<i64>,
    pub flash: Option<i64>,
    pub format: Option<String>,
    pub from: Option<String>,
    pub group: Option<String>,
    pub idx: Option<String>,
    pub max_parts: Option<i64>,
    pub message: Option<String>,
    pub normalize: Option<i64>,
    pub notify_url: Option<String>,
    pub test: Option<Value>,
    pub time_restriction: Option<String>,
    pub to: Option<String>,
}

/// Smssendername is the typed data model for the smssendername entity.
#[derive(Debug, Clone)]
pub struct Smssendername {
}

/// SmssendernameCreateData is the typed request payload for Smssendername.create.
#[derive(Debug, Clone)]
pub struct SmssendernameCreateData {
    pub sendername_id: String,
}

/// SmssendernameRemoveMatch is the typed request payload for Smssendername.remove.
#[derive(Debug, Clone)]
pub struct SmssendernameRemoveMatch {
    pub sender: String,
}

/// Smstemplate is the typed data model for the smstemplate entity.
#[derive(Debug, Clone)]
pub struct Smstemplate {
    pub id: Option<String>,
}

/// SmstemplateRemoveMatch is the typed request payload for Smstemplate.remove.
#[derive(Debug, Clone)]
pub struct SmstemplateRemoveMatch {
    pub id: String,
}

/// Subuser is the typed data model for the subuser entity.
#[derive(Debug, Clone)]
pub struct Subuser {
    pub active: Option<bool>,
    pub credentials: std::collections::HashMap<String, Value>,
    pub description: Option<String>,
    pub id: Option<String>,
    pub points: Option<std::collections::HashMap<String, Value>>,
    pub username: Option<String>,
}

/// SubuserLoadMatch is the typed request payload for Subuser.load.
#[derive(Debug, Clone)]
pub struct SubuserLoadMatch {
    pub id: String,
}

/// SubuserListMatch is the typed request payload for Subuser.list.
#[derive(Debug, Clone)]
pub struct SubuserListMatch {
    pub q: Option<String>,
}

/// SubuserCreateData is the typed request payload for Subuser.create.
#[derive(Debug, Clone)]
pub struct SubuserCreateData {
    pub active: Option<bool>,
    pub credentials: std::collections::HashMap<String, Value>,
    pub description: Option<String>,
    pub id: Option<String>,
    pub points: Option<std::collections::HashMap<String, Value>>,
    pub username: Option<String>,
}

/// SubuserUpdateData is the typed request payload for Subuser.update.
#[derive(Debug, Clone)]
pub struct SubuserUpdateData {
    pub id: String,
    pub active: Option<bool>,
    pub credentials: Option<std::collections::HashMap<String, Value>>,
    pub description: Option<String>,
    pub points: Option<std::collections::HashMap<String, Value>>,
    pub username: Option<String>,
}

/// SubuserRemoveMatch is the typed request payload for Subuser.remove.
#[derive(Debug, Clone)]
pub struct SubuserRemoveMatch {
    pub id: String,
}

/// Template is the typed data model for the template entity.
#[derive(Debug, Clone)]
pub struct Template {
    pub id: Option<String>,
    pub name: Option<String>,
    pub normalize: Option<bool>,
    pub template: Option<String>,
}

/// TemplateLoadMatch is the typed request payload for Template.load.
#[derive(Debug, Clone)]
pub struct TemplateLoadMatch {
    pub id: String,
}

/// TemplateListMatch is the typed request payload for Template.list.
#[derive(Debug, Clone)]
pub struct TemplateListMatch {
    pub id: Option<String>,
    pub name: Option<String>,
    pub normalize: Option<bool>,
    pub template: Option<String>,
}

/// TemplateCreateData is the typed request payload for Template.create.
#[derive(Debug, Clone)]
pub struct TemplateCreateData {
    pub id: Option<String>,
    pub name: Option<String>,
    pub normalize: Option<bool>,
    pub template: Option<String>,
}

/// TemplateUpdateData is the typed request payload for Template.update.
#[derive(Debug, Clone)]
pub struct TemplateUpdateData {
    pub id: String,
    pub name: Option<String>,
    pub normalize: Option<bool>,
    pub template: Option<String>,
}

/// UserRcsSenderCollection is the typed data model for the user_rcs_sender_collection entity.
#[derive(Debug, Clone)]
pub struct UserRcsSenderCollection {
    pub deliveredat: Option<String>,
    pub expiredat: Option<String>,
    pub id: Option<String>,
    pub interface: Option<String>,
    pub messagetype: Option<String>,
    pub readat: Option<String>,
    pub recipient: Option<String>,
    pub sender: Option<String>,
    pub senderid: Option<String>,
    pub sentat: Option<String>,
}

/// UserRcsSenderCollectionListMatch is the typed request payload for UserRcsSenderCollection.list.
#[derive(Debug, Clone)]
pub struct UserRcsSenderCollectionListMatch {
    pub deliveredat: Option<String>,
    pub expiredat: Option<String>,
    pub id: Option<String>,
    pub interface: Option<String>,
    pub messagetype: Option<String>,
    pub readat: Option<String>,
    pub recipient: Option<String>,
    pub sender: Option<String>,
    pub senderid: Option<String>,
    pub sentat: Option<String>,
}

