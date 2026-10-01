// Typed models for the Smsapi SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields{} and per-op
// params (op.<name>.points[].g.params[]). Field/param types are mapped
// from the canonical type sentinels. Do not edit by hand.
//
// These are DOCUMENTARY: the SDK runtime is dynamic (ops take/return
// `voxgig_value*`), so nothing consumes these structs yet — they mirror the
// entity/op shapes for reference and IDE support. This header is standalone
// and is not #included by any generated .c.

#ifndef SMSAPI_ENTITY_TYPES_H
#define SMSAPI_ENTITY_TYPES_H

#include "sdk.h"

// Available is the typed data model for the available entity.
typedef struct {
  char*name;  // optional
  bool normalize;  // optional
  char*template;  // optional
} Available;

// AvailableListMatch is the typed request payload for Available.list.
typedef struct {
  char*name;  // optional
  bool normalize;  // optional
  char*template;  // optional
} AvailableListMatch;

// Blacklist is the typed data model for the blacklist entity.
typedef struct {
  char*id;  // optional
} Blacklist;

// BlacklistLoadMatch is the typed request payload for Blacklist.load.
typedef struct {
  int64_t limit;  // optional
  int64_t offset;  // optional
  int64_t q;  // optional
} BlacklistLoadMatch;

// BlacklistCreateData is the typed request payload for Blacklist.create.
typedef struct {
  char*id;  // optional
} BlacklistCreateData;

// BlacklistRemoveMatch is the typed request payload for Blacklist.remove.
typedef struct {
  char*id;
} BlacklistRemoveMatch;

// Callback is the typed data model for the callback entity.
typedef struct {
  bool active;  // optional
  int64_t api_version;  // optional
  char*id;  // optional
  bool invalid;  // optional
  voxgig_value*receiver;  // optional
  char*receiver_type;  // optional
  char*type;  // optional
  char*url;  // optional
} Callback;

// CallbackLoadMatch is the typed request payload for Callback.load.
typedef struct {
  char*id;
} CallbackLoadMatch;

// CallbackListMatch is the typed request payload for Callback.list.
typedef struct {
  bool active;  // optional
  int64_t api_version;  // optional
  char*id;  // optional
  bool invalid;  // optional
  voxgig_value*receiver;  // optional
  char*receiver_type;  // optional
  char*type;  // optional
  char*url;  // optional
} CallbackListMatch;

// CallbackCreateData is the typed request payload for Callback.create.
typedef struct {
  bool active;  // optional
  int64_t api_version;  // optional
  char*id;  // optional
  bool invalid;  // optional
  voxgig_value*receiver;  // optional
  char*receiver_type;  // optional
  char*type;  // optional
  char*url;  // optional
} CallbackCreateData;

// CallbackUpdateData is the typed request payload for Callback.update.
typedef struct {
  char*id;
  bool active;  // optional
  int64_t api_version;  // optional
  bool invalid;  // optional
  voxgig_value*receiver;  // optional
  char*receiver_type;  // optional
  char*type;  // optional
  char*url;  // optional
} CallbackUpdateData;

// CallbackRemoveMatch is the typed request payload for Callback.remove.
typedef struct {
  char*id;
} CallbackRemoveMatch;

// Contact is the typed data model for the contact entity.
typedef struct {
  char*birthday_date;  // optional
  char*city;  // optional
  voxgig_value*collection;
  int64_t contact_expire_after;
  int64_t contacts_count;
  char*country;  // optional
  char*created_by;
  char*date_created;
  char*date_updated;
  char*description;  // optional
  char*email;  // optional
  char*first_name;  // optional
  char*gender;
  char*group_id;  // optional
  voxgig_value*groups;
  char*id;
  char*idx;  // optional
  char*last_name;  // optional
  char*name;
  voxgig_value*permissions;  // optional
  char*phone_number;  // optional
  bool read;  // optional
  bool send;  // optional
  int64_t size;
  char*source;  // optional
  char*type;  // optional
  char*username;  // optional
  char*value;  // optional
  bool write;  // optional
} Contact;

// ContactLoadMatch is the typed request payload for Contact.load.
typedef struct {
  char*id;
} ContactLoadMatch;

// ContactListMatch is the typed request payload for Contact.list.
typedef struct {
  voxgig_value*birthday_date;  // optional
  voxgig_value*email;  // optional
  voxgig_value*first_name;  // optional
  char*gender;  // optional
  voxgig_value*group_id;  // optional
  voxgig_value*last_name;  // optional
  int64_t limit;  // optional
  int64_t offset;  // optional
  char*order_by;  // optional
  voxgig_value*phone_number;  // optional
  char*q;  // optional
} ContactListMatch;

// ContactCreateData is the typed request payload for Contact.create.
typedef struct {
  char*birthday_date;  // optional
  char*city;  // optional
  voxgig_value*collection;
  int64_t contact_expire_after;
  int64_t contacts_count;
  char*country;  // optional
  char*created_by;
  char*date_created;
  char*date_updated;
  char*description;  // optional
  char*email;  // optional
  char*first_name;  // optional
  char*gender;
  char*group_id;  // optional
  voxgig_value*groups;
  char*id;
  char*idx;  // optional
  char*last_name;  // optional
  char*name;
  voxgig_value*permissions;  // optional
  char*phone_number;  // optional
  bool read;  // optional
  bool send;  // optional
  int64_t size;
  char*source;  // optional
  char*type;  // optional
  char*username;  // optional
  char*value;  // optional
  bool write;  // optional
} ContactCreateData;

// ContactUpdateData is the typed request payload for Contact.update.
typedef struct {
  char*id;
  char*birthday_date;  // optional
  char*city;  // optional
  voxgig_value*collection;  // optional
  int64_t contact_expire_after;  // optional
  int64_t contacts_count;  // optional
  char*country;  // optional
  char*created_by;  // optional
  char*date_created;  // optional
  char*date_updated;  // optional
  char*description;  // optional
  char*email;  // optional
  char*first_name;  // optional
  char*gender;  // optional
  char*group_id;  // optional
  voxgig_value*groups;  // optional
  char*idx;  // optional
  char*last_name;  // optional
  char*name;  // optional
  voxgig_value*permissions;  // optional
  char*phone_number;  // optional
  bool read;  // optional
  bool send;  // optional
  int64_t size;  // optional
  char*source;  // optional
  char*type;  // optional
  char*username;  // optional
  char*value;  // optional
  bool write;  // optional
} ContactUpdateData;

// ContactRemoveMatch is the typed request payload for Contact.remove.
typedef struct {
  char*id;
} ContactRemoveMatch;

// ContactsField is the typed data model for the contacts_field entity.
typedef struct {
  char*birthday_date;  // optional
  char*city;  // optional
  int64_t contact_expire_after;
  int64_t contacts_count;  // optional
  char*country;  // optional
  char*created_by;
  char*date_created;
  char*date_updated;
  char*description;  // optional
  char*email;  // optional
  char*first_name;  // optional
  char*gender;
  char*group_id;  // optional
  voxgig_value*groups;
  char*id;  // optional
  char*idx;  // optional
  char*last_name;  // optional
  char*name;  // optional
  voxgig_value*permissions;  // optional
  char*phone_number;  // optional
  bool read;  // optional
  bool send;  // optional
  char*source;  // optional
  char*type;  // optional
  char*username;  // optional
  char*value;  // optional
  bool write;  // optional
} ContactsField;

// ContactsFieldListMatch is the typed request payload for ContactsField.list.
typedef struct {
  char*birthday_date;  // optional
  char*city;  // optional
  int64_t contact_expire_after;  // optional
  int64_t contacts_count;  // optional
  char*country;  // optional
  char*created_by;  // optional
  char*date_created;  // optional
  char*date_updated;  // optional
  char*description;  // optional
  char*email;  // optional
  char*first_name;  // optional
  char*gender;  // optional
  char*group_id;  // optional
  voxgig_value*groups;  // optional
  char*id;  // optional
  char*idx;  // optional
  char*last_name;  // optional
  char*name;  // optional
  voxgig_value*permissions;  // optional
  char*phone_number;  // optional
  bool read;  // optional
  bool send;  // optional
  char*source;  // optional
  char*type;  // optional
  char*username;  // optional
  char*value;  // optional
  bool write;  // optional
} ContactsFieldListMatch;

// ContactsFieldCreateData is the typed request payload for ContactsField.create.
typedef struct {
  char*birthday_date;  // optional
  char*city;  // optional
  int64_t contact_expire_after;
  int64_t contacts_count;  // optional
  char*country;  // optional
  char*created_by;
  char*date_created;
  char*date_updated;
  char*description;  // optional
  char*email;  // optional
  char*first_name;  // optional
  char*gender;
  char*group_id;  // optional
  voxgig_value*groups;
  char*id;  // optional
  char*idx;  // optional
  char*last_name;  // optional
  char*name;  // optional
  voxgig_value*permissions;  // optional
  char*phone_number;  // optional
  bool read;  // optional
  bool send;  // optional
  char*source;  // optional
  char*type;  // optional
  char*username;  // optional
  char*value;  // optional
  bool write;  // optional
} ContactsFieldCreateData;

// ContactsFieldUpdateData is the typed request payload for ContactsField.update.
typedef struct {
  char*id;
  char*birthday_date;  // optional
  char*city;  // optional
  int64_t contact_expire_after;  // optional
  int64_t contacts_count;  // optional
  char*country;  // optional
  char*created_by;  // optional
  char*date_created;  // optional
  char*date_updated;  // optional
  char*description;  // optional
  char*email;  // optional
  char*first_name;  // optional
  char*gender;  // optional
  char*group_id;  // optional
  voxgig_value*groups;  // optional
  char*idx;  // optional
  char*last_name;  // optional
  char*name;  // optional
  voxgig_value*permissions;  // optional
  char*phone_number;  // optional
  bool read;  // optional
  bool send;  // optional
  char*source;  // optional
  char*type;  // optional
  char*username;  // optional
  char*value;  // optional
  bool write;  // optional
} ContactsFieldUpdateData;

// ContactsFieldRemoveMatch is the typed request payload for ContactsField.remove.
typedef struct {
  char*id;
} ContactsFieldRemoveMatch;

// ContactsFieldOption is the typed data model for the contacts_field_option entity.
typedef struct {
  char*birthday_date;  // optional
  char*city;  // optional
  int64_t contact_expire_after;
  int64_t contacts_count;  // optional
  char*country;  // optional
  char*created_by;
  char*date_created;
  char*date_updated;
  char*description;  // optional
  char*email;  // optional
  char*first_name;  // optional
  char*gender;
  char*group_id;  // optional
  voxgig_value*groups;
  char*id;
  char*idx;  // optional
  char*last_name;  // optional
  char*name;  // optional
  voxgig_value*permissions;  // optional
  char*phone_number;  // optional
  bool read;  // optional
  bool send;  // optional
  char*source;  // optional
  char*type;  // optional
  char*username;  // optional
  char*value;  // optional
  bool write;  // optional
} ContactsFieldOption;

// ContactsFieldOptionListMatch is the typed request payload for ContactsFieldOption.list.
typedef struct {
  char*field_id;
} ContactsFieldOptionListMatch;

// Contactsgroup is the typed data model for the contactsgroup entity.
typedef struct {
  char*birthday_date;  // optional
  char*city;  // optional
  int64_t contact_expire_after;
  int64_t contacts_count;  // optional
  char*country;  // optional
  char*created_by;
  char*date_created;
  char*date_updated;
  char*description;  // optional
  char*email;  // optional
  char*first_name;  // optional
  char*gender;
  char*group_id;
  voxgig_value*groups;
  char*id;
  char*idx;  // optional
  char*last_name;  // optional
  char*name;  // optional
  voxgig_value*permissions;  // optional
  char*phone_number;  // optional
  bool read;
  bool send;
  char*source;  // optional
  char*type;  // optional
  char*username;
  char*value;  // optional
  bool write;
} Contactsgroup;

// ContactsgroupListMatch is the typed request payload for Contactsgroup.list.
typedef struct {
  voxgig_value*name;  // optional
  voxgig_value*with;  // optional
} ContactsgroupListMatch;

// ContactsgroupCreateData is the typed request payload for Contactsgroup.create.
typedef struct {
  char*birthday_date;  // optional
  char*city;  // optional
  int64_t contact_expire_after;
  int64_t contacts_count;  // optional
  char*country;  // optional
  char*created_by;
  char*date_created;
  char*date_updated;
  char*description;  // optional
  char*email;  // optional
  char*first_name;  // optional
  char*gender;
  char*group_id;
  voxgig_value*groups;
  char*id;
  char*idx;  // optional
  char*last_name;  // optional
  char*name;  // optional
  voxgig_value*permissions;  // optional
  char*phone_number;  // optional
  bool read;
  bool send;
  char*source;  // optional
  char*type;  // optional
  char*username;
  char*value;  // optional
  bool write;
} ContactsgroupCreateData;

// ContactsgroupUpdateData is the typed request payload for Contactsgroup.update.
typedef struct {
  char*group_id;
  char*username;  // optional
  char*birthday_date;  // optional
  char*city;  // optional
  int64_t contact_expire_after;  // optional
  int64_t contacts_count;  // optional
  char*country;  // optional
  char*created_by;  // optional
  char*date_created;  // optional
  char*date_updated;  // optional
  char*description;  // optional
  char*email;  // optional
  char*first_name;  // optional
  char*gender;  // optional
  voxgig_value*groups;  // optional
  char*id;  // optional
  char*idx;  // optional
  char*last_name;  // optional
  char*name;  // optional
  voxgig_value*permissions;  // optional
  char*phone_number;  // optional
  bool read;  // optional
  bool send;  // optional
  char*source;  // optional
  char*type;  // optional
  char*value;  // optional
  bool write;  // optional
} ContactsgroupUpdateData;

// ContactsgroupRemoveMatch is the typed request payload for Contactsgroup.remove.
typedef struct {
  char*group_id;
} ContactsgroupRemoveMatch;

// Contactstrash is the typed data model for the contactstrash entity.
typedef struct {
  char _unused;  // placeholder: no modelled members
} Contactstrash;

// ContactstrashUpdateData is the typed request payload for Contactstrash.update.
typedef struct {
  char _unused;  // placeholder: no modelled members
} ContactstrashUpdateData;

// ContactstrashRemoveMatch is the typed request payload for Contactstrash.remove.
typedef struct {
  char _unused;  // placeholder: no modelled members
} ContactstrashRemoveMatch;

// FieldAvailable is the typed data model for the field_available entity.
typedef struct {
  bool built_in;  // optional
  char*id;  // optional
  char*name;  // optional
  voxgig_value*options;  // optional
  char*type;  // optional
} FieldAvailable;

// FieldAvailableListMatch is the typed request payload for FieldAvailable.list.
typedef struct {
  bool built_in;  // optional
  char*id;  // optional
  char*name;  // optional
  voxgig_value*options;  // optional
  char*type;  // optional
} FieldAvailableListMatch;

// Group is the typed data model for the group entity.
typedef struct {
  int64_t contact_expire_after;
  int64_t contacts_count;
  char*created_by;
  char*date_created;
  char*date_updated;
  char*description;
  char*id;
  char*idx;  // optional
  char*name;
  voxgig_value*permissions;  // optional
} Group;

// GroupLoadMatch is the typed request payload for Group.load.
typedef struct {
  char*id;
} GroupLoadMatch;

// GroupUpdateData is the typed request payload for Group.update.
typedef struct {
  char*id;
  int64_t contact_expire_after;  // optional
  int64_t contacts_count;  // optional
  char*created_by;  // optional
  char*date_created;  // optional
  char*date_updated;  // optional
  char*description;  // optional
  char*idx;  // optional
  char*name;  // optional
  voxgig_value*permissions;  // optional
} GroupUpdateData;

// MfaCode is the typed data model for the mfa_code entity.
typedef struct {
  char*content;  // optional
  voxgig_value*fast;  // optional
  char*from;  // optional
  char*phone_number;
} MfaCode;

// MfaCodeCreateData is the typed request payload for MfaCode.create.
typedef struct {
  char*content;  // optional
  voxgig_value*fast;  // optional
  char*from;  // optional
  char*phone_number;
} MfaCodeCreateData;

// OptOut is the typed data model for the opt_out entity.
typedef struct {
  char*date;  // optional
  char*id;  // optional
  voxgig_value*links;  // optional
  int64_t phonenumber;  // optional
} OptOut;

// OptOutListMatch is the typed request payload for OptOut.list.
typedef struct {
  int64_t limit;  // optional
  int64_t offset;  // optional
  char*phone_number;  // optional
} OptOutListMatch;

// OptOutRemoveMatch is the typed request payload for OptOut.remove.
typedef struct {
  char*id;
} OptOutRemoveMatch;

// OptOutSetting is the typed data model for the opt_out_setting entity.
typedef struct {
  char*brand;  // optional
} OptOutSetting;

// OptOutSettingLoadMatch is the typed request payload for OptOutSetting.load.
typedef struct {
  char*brand;  // optional
} OptOutSettingLoadMatch;

// OptOutSettingUpdateData is the typed request payload for OptOutSetting.update.
typedef struct {
  char*brand;  // optional
} OptOutSettingUpdateData;

// Permission is the typed data model for the permission entity.
typedef struct {
  char*group_id;
  char*id;  // optional
  bool read;
  bool send;
  char*username;
  bool write;
} Permission;

// PermissionLoadMatch is the typed request payload for Permission.load.
typedef struct {
  char*group_id;
  char*id;
  char*username;
} PermissionLoadMatch;

// PermissionCreateData is the typed request payload for Permission.create.
typedef struct {
  char*group_id;
  char*id;  // optional
  bool read;
  bool send;
  char*username;
  bool write;
} PermissionCreateData;

// Ping is the typed data model for the ping entity.
typedef struct {
  bool authorized;
  voxgig_value*unavailable;
} Ping;

// PingListMatch is the typed request payload for Ping.list.
typedef struct {
  bool authorized;  // optional
  voxgig_value*unavailable;  // optional
} PingListMatch;

// Profile is the typed data model for the profile entity.
typedef struct {
  char*email;
  char*name;
  char*payment_type;
  int64_t phone_number;
  double points;  // optional
  char*user_type;
  char*username;
} Profile;

// ProfileLoadMatch is the typed request payload for Profile.load.
typedef struct {
  char*email;  // optional
  char*name;  // optional
  char*payment_type;  // optional
  int64_t phone_number;  // optional
  double points;  // optional
  char*user_type;  // optional
  char*username;  // optional
} ProfileLoadMatch;

// ProfileListMatch is the typed request payload for Profile.list.
typedef struct {
  char*type;  // optional
} ProfileListMatch;

// Rcs is the typed data model for the rcs entity.
typedef struct {
  char _unused;  // placeholder: no modelled members
} Rcs;

// RcsListMatch is the typed request payload for Rcs.list.
typedef struct {
  char _unused;  // placeholder: no modelled members
} RcsListMatch;

// Sendername is the typed data model for the sendername entity.
typedef struct {
  char*created_at;  // optional
  char*id;  // optional
  bool is_default;  // optional
  char*sender;  // optional
  char*status;  // optional
} Sendername;

// SendernameLoadMatch is the typed request payload for Sendername.load.
typedef struct {
  char*id;
} SendernameLoadMatch;

// SendernameListMatch is the typed request payload for Sendername.list.
typedef struct {
  char*created_at;  // optional
  char*id;  // optional
  bool is_default;  // optional
  char*sender;  // optional
  char*status;  // optional
} SendernameListMatch;

// SendernameCreateData is the typed request payload for Sendername.create.
typedef struct {
  char*created_at;  // optional
  char*id;  // optional
  bool is_default;  // optional
  char*sender;  // optional
  char*status;  // optional
} SendernameCreateData;

// SendernameStatement is the typed data model for the sendername_statement entity.
typedef struct {
  char*content;  // optional
  voxgig_value*statements;  // optional
  char*title;  // optional
} SendernameStatement;

// SendernameStatementListMatch is the typed request payload for SendernameStatement.list.
typedef struct {
  char*content;  // optional
  voxgig_value*statements;  // optional
  char*title;  // optional
} SendernameStatementListMatch;

// SentRcsMessage is the typed data model for the sent_rcs_message entity.
typedef struct {
  voxgig_value*content;  // optional
  char*phone_number;
  voxgig_value*sender;
  char*text;  // optional
} SentRcsMessage;

// SentRcsMessageCreateData is the typed request payload for SentRcsMessage.create.
typedef struct {
  voxgig_value*content;  // optional
  char*phone_number;
  voxgig_value*sender;
  char*text;  // optional
} SentRcsMessageCreateData;

// ShipmentCountryVolume is the typed data model for the shipment_country_volume entity.
typedef struct {
  char*country_code;  // optional
  int64_t country_limit;  // optional
  char*country_name;  // optional
  int64_t usage;  // optional
} ShipmentCountryVolume;

// ShipmentCountryVolumeListMatch is the typed request payload for ShipmentCountryVolume.list.
typedef struct {
  char*month;  // optional
  char*year;  // optional
} ShipmentCountryVolumeListMatch;

// ShortUrl is the typed data model for the short_url entity.
typedef struct {
  char*description;  // optional
  char*expire;  // optional
  char*filename;  // optional
  int64_t hits;  // optional
  int64_t hits_unique;  // optional
  char*id;  // optional
  char*name;  // optional
  char*short_url;  // optional
  char*type;  // optional
  char*url;  // optional
} ShortUrl;

// ShortUrlLoadMatch is the typed request payload for ShortUrl.load.
typedef struct {
  char*id;
} ShortUrlLoadMatch;

// ShortUrlListMatch is the typed request payload for ShortUrl.list.
typedef struct {
  char*description;  // optional
  char*expire;  // optional
  char*filename;  // optional
  int64_t hits;  // optional
  int64_t hits_unique;  // optional
  char*id;  // optional
  char*name;  // optional
  char*short_url;  // optional
  char*type;  // optional
  char*url;  // optional
} ShortUrlListMatch;

// ShortUrlCreateData is the typed request payload for ShortUrl.create.
typedef struct {
  char*description;  // optional
  char*expire;  // optional
  char*filename;  // optional
  int64_t hits;  // optional
  int64_t hits_unique;  // optional
  char*id;  // optional
  char*name;  // optional
  char*short_url;  // optional
  char*type;  // optional
  char*url;  // optional
} ShortUrlCreateData;

// ShortUrlUpdateData is the typed request payload for ShortUrl.update.
typedef struct {
  char*id;
  char*description;  // optional
  char*expire;  // optional
  char*filename;  // optional
  int64_t hits;  // optional
  int64_t hits_unique;  // optional
  char*name;  // optional
  char*short_url;  // optional
  char*type;  // optional
  char*url;  // optional
} ShortUrlUpdateData;

// ShortUrlRemoveMatch is the typed request payload for ShortUrl.remove.
typedef struct {
  char*id;
} ShortUrlRemoveMatch;

// Smsdo is the typed data model for the smsdo entity.
typedef struct {
  int64_t allow_duplicates;  // optional
  voxgig_value*check_idx;  // optional
  voxgig_value*date;  // optional
  int64_t date_validate;  // optional
  voxgig_value*details;  // optional
  char*encoding;  // optional
  voxgig_value*expiration_date;  // optional
  voxgig_value*fallback;  // optional
  int64_t fast;  // optional
  int64_t flash;  // optional
  char*format;  // optional
  char*from;  // optional
  char*group;  // optional
  char*idx;  // optional
  int64_t max_parts;  // optional
  char*message;  // optional
  int64_t normalize;  // optional
  char*notify_url;  // optional
  voxgig_value*test;  // optional
  char*time_restriction;  // optional
  char*to;  // optional
} Smsdo;

// SmsdoCreateData is the typed request payload for Smsdo.create.
typedef struct {
  int64_t allow_duplicates;  // optional
  voxgig_value*check_idx;  // optional
  voxgig_value*date;  // optional
  int64_t date_validate;  // optional
  voxgig_value*details;  // optional
  char*encoding;  // optional
  voxgig_value*expiration_date;  // optional
  voxgig_value*fallback;  // optional
  int64_t fast;  // optional
  int64_t flash;  // optional
  char*format;  // optional
  char*from;  // optional
  char*group;  // optional
  char*idx;  // optional
  int64_t max_parts;  // optional
  char*message;  // optional
  int64_t normalize;  // optional
  char*notify_url;  // optional
  voxgig_value*test;  // optional
  char*time_restriction;  // optional
  char*to;  // optional
} SmsdoCreateData;

// Smssendername is the typed data model for the smssendername entity.
typedef struct {
  char _unused;  // placeholder: no modelled members
} Smssendername;

// SmssendernameCreateData is the typed request payload for Smssendername.create.
typedef struct {
  char*sendername_id;
} SmssendernameCreateData;

// SmssendernameRemoveMatch is the typed request payload for Smssendername.remove.
typedef struct {
  char*sender;
} SmssendernameRemoveMatch;

// Smstemplate is the typed data model for the smstemplate entity.
typedef struct {
  char*id;  // optional
} Smstemplate;

// SmstemplateRemoveMatch is the typed request payload for Smstemplate.remove.
typedef struct {
  char*id;
} SmstemplateRemoveMatch;

// Subuser is the typed data model for the subuser entity.
typedef struct {
  bool active;  // optional
  voxgig_value*credentials;
  char*description;  // optional
  char*id;  // optional
  voxgig_value*points;  // optional
  char*username;  // optional
} Subuser;

// SubuserLoadMatch is the typed request payload for Subuser.load.
typedef struct {
  char*id;
} SubuserLoadMatch;

// SubuserListMatch is the typed request payload for Subuser.list.
typedef struct {
  char*q;  // optional
} SubuserListMatch;

// SubuserCreateData is the typed request payload for Subuser.create.
typedef struct {
  bool active;  // optional
  voxgig_value*credentials;
  char*description;  // optional
  char*id;  // optional
  voxgig_value*points;  // optional
  char*username;  // optional
} SubuserCreateData;

// SubuserUpdateData is the typed request payload for Subuser.update.
typedef struct {
  char*id;
  bool active;  // optional
  voxgig_value*credentials;  // optional
  char*description;  // optional
  voxgig_value*points;  // optional
  char*username;  // optional
} SubuserUpdateData;

// SubuserRemoveMatch is the typed request payload for Subuser.remove.
typedef struct {
  char*id;
} SubuserRemoveMatch;

// Template is the typed data model for the template entity.
typedef struct {
  char*id;  // optional
  char*name;  // optional
  bool normalize;  // optional
  char*template;  // optional
} Template;

// TemplateLoadMatch is the typed request payload for Template.load.
typedef struct {
  char*id;
} TemplateLoadMatch;

// TemplateListMatch is the typed request payload for Template.list.
typedef struct {
  char*id;  // optional
  char*name;  // optional
  bool normalize;  // optional
  char*template;  // optional
} TemplateListMatch;

// TemplateCreateData is the typed request payload for Template.create.
typedef struct {
  char*id;  // optional
  char*name;  // optional
  bool normalize;  // optional
  char*template;  // optional
} TemplateCreateData;

// TemplateUpdateData is the typed request payload for Template.update.
typedef struct {
  char*id;
  char*name;  // optional
  bool normalize;  // optional
  char*template;  // optional
} TemplateUpdateData;

// UserRcsSenderCollection is the typed data model for the user_rcs_sender_collection entity.
typedef struct {
  char*deliveredat;  // optional
  char*expiredat;  // optional
  char*id;  // optional
  char*interface;  // optional
  char*messagetype;  // optional
  char*readat;  // optional
  char*recipient;  // optional
  char*sender;  // optional
  char*senderid;  // optional
  char*sentat;  // optional
} UserRcsSenderCollection;

// UserRcsSenderCollectionListMatch is the typed request payload for UserRcsSenderCollection.list.
typedef struct {
  char*deliveredat;  // optional
  char*expiredat;  // optional
  char*id;  // optional
  char*interface;  // optional
  char*messagetype;  // optional
  char*readat;  // optional
  char*recipient;  // optional
  char*sender;  // optional
  char*senderid;  // optional
  char*sentat;  // optional
} UserRcsSenderCollectionListMatch;

#endif // SMSAPI_ENTITY_TYPES_H
