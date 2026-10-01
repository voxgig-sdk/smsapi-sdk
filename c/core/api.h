// Smsapi SDK public API (generated).

#ifndef SMSAPI_API_H
#define SMSAPI_API_H

#include "sdk.h"

// Available entity.
Entity* available_entity_new(SmsapiSDK* client, voxgig_value* entopts);
Entity* smsapi_available(SmsapiSDK* client, voxgig_value* entopts);
voxgig_value* available_stream(Entity* e, const char* action, voxgig_value* args, voxgig_value* callopts, PNError** err);
// Blacklist entity.
Entity* blacklist_entity_new(SmsapiSDK* client, voxgig_value* entopts);
Entity* smsapi_blacklist(SmsapiSDK* client, voxgig_value* entopts);
voxgig_value* blacklist_stream(Entity* e, const char* action, voxgig_value* args, voxgig_value* callopts, PNError** err);
// Callback entity.
Entity* callback_entity_new(SmsapiSDK* client, voxgig_value* entopts);
Entity* smsapi_callback(SmsapiSDK* client, voxgig_value* entopts);
voxgig_value* callback_stream(Entity* e, const char* action, voxgig_value* args, voxgig_value* callopts, PNError** err);
// Contact entity.
Entity* contact_entity_new(SmsapiSDK* client, voxgig_value* entopts);
Entity* smsapi_contact(SmsapiSDK* client, voxgig_value* entopts);
voxgig_value* contact_stream(Entity* e, const char* action, voxgig_value* args, voxgig_value* callopts, PNError** err);
// ContactsField entity.
Entity* contacts_field_entity_new(SmsapiSDK* client, voxgig_value* entopts);
Entity* smsapi_contacts_field(SmsapiSDK* client, voxgig_value* entopts);
voxgig_value* contacts_field_stream(Entity* e, const char* action, voxgig_value* args, voxgig_value* callopts, PNError** err);
// ContactsFieldOption entity.
Entity* contacts_field_option_entity_new(SmsapiSDK* client, voxgig_value* entopts);
Entity* smsapi_contacts_field_option(SmsapiSDK* client, voxgig_value* entopts);
voxgig_value* contacts_field_option_stream(Entity* e, const char* action, voxgig_value* args, voxgig_value* callopts, PNError** err);
// Contactsgroup entity.
Entity* contactsgroup_entity_new(SmsapiSDK* client, voxgig_value* entopts);
Entity* smsapi_contactsgroup(SmsapiSDK* client, voxgig_value* entopts);
voxgig_value* contactsgroup_stream(Entity* e, const char* action, voxgig_value* args, voxgig_value* callopts, PNError** err);
// Contactstrash entity.
Entity* contactstrash_entity_new(SmsapiSDK* client, voxgig_value* entopts);
Entity* smsapi_contactstrash(SmsapiSDK* client, voxgig_value* entopts);
voxgig_value* contactstrash_stream(Entity* e, const char* action, voxgig_value* args, voxgig_value* callopts, PNError** err);
// FieldAvailable entity.
Entity* field_available_entity_new(SmsapiSDK* client, voxgig_value* entopts);
Entity* smsapi_field_available(SmsapiSDK* client, voxgig_value* entopts);
voxgig_value* field_available_stream(Entity* e, const char* action, voxgig_value* args, voxgig_value* callopts, PNError** err);
// Group entity.
Entity* group_entity_new(SmsapiSDK* client, voxgig_value* entopts);
Entity* smsapi_group(SmsapiSDK* client, voxgig_value* entopts);
voxgig_value* group_stream(Entity* e, const char* action, voxgig_value* args, voxgig_value* callopts, PNError** err);
// MfaCode entity.
Entity* mfa_code_entity_new(SmsapiSDK* client, voxgig_value* entopts);
Entity* smsapi_mfa_code(SmsapiSDK* client, voxgig_value* entopts);
voxgig_value* mfa_code_stream(Entity* e, const char* action, voxgig_value* args, voxgig_value* callopts, PNError** err);
// OptOut entity.
Entity* opt_out_entity_new(SmsapiSDK* client, voxgig_value* entopts);
Entity* smsapi_opt_out(SmsapiSDK* client, voxgig_value* entopts);
voxgig_value* opt_out_stream(Entity* e, const char* action, voxgig_value* args, voxgig_value* callopts, PNError** err);
// OptOutSetting entity.
Entity* opt_out_setting_entity_new(SmsapiSDK* client, voxgig_value* entopts);
Entity* smsapi_opt_out_setting(SmsapiSDK* client, voxgig_value* entopts);
voxgig_value* opt_out_setting_stream(Entity* e, const char* action, voxgig_value* args, voxgig_value* callopts, PNError** err);
// Permission entity.
Entity* permission_entity_new(SmsapiSDK* client, voxgig_value* entopts);
Entity* smsapi_permission(SmsapiSDK* client, voxgig_value* entopts);
voxgig_value* permission_stream(Entity* e, const char* action, voxgig_value* args, voxgig_value* callopts, PNError** err);
// Ping entity.
Entity* ping_entity_new(SmsapiSDK* client, voxgig_value* entopts);
Entity* smsapi_ping(SmsapiSDK* client, voxgig_value* entopts);
voxgig_value* ping_stream(Entity* e, const char* action, voxgig_value* args, voxgig_value* callopts, PNError** err);
// Profile entity.
Entity* profile_entity_new(SmsapiSDK* client, voxgig_value* entopts);
Entity* smsapi_profile(SmsapiSDK* client, voxgig_value* entopts);
voxgig_value* profile_stream(Entity* e, const char* action, voxgig_value* args, voxgig_value* callopts, PNError** err);
// Rcs entity.
Entity* rcs_entity_new(SmsapiSDK* client, voxgig_value* entopts);
Entity* smsapi_rcs(SmsapiSDK* client, voxgig_value* entopts);
voxgig_value* rcs_stream(Entity* e, const char* action, voxgig_value* args, voxgig_value* callopts, PNError** err);
// Sendername entity.
Entity* sendername_entity_new(SmsapiSDK* client, voxgig_value* entopts);
Entity* smsapi_sendername(SmsapiSDK* client, voxgig_value* entopts);
voxgig_value* sendername_stream(Entity* e, const char* action, voxgig_value* args, voxgig_value* callopts, PNError** err);
// SendernameStatement entity.
Entity* sendername_statement_entity_new(SmsapiSDK* client, voxgig_value* entopts);
Entity* smsapi_sendername_statement(SmsapiSDK* client, voxgig_value* entopts);
voxgig_value* sendername_statement_stream(Entity* e, const char* action, voxgig_value* args, voxgig_value* callopts, PNError** err);
// SentRcsMessage entity.
Entity* sent_rcs_message_entity_new(SmsapiSDK* client, voxgig_value* entopts);
Entity* smsapi_sent_rcs_message(SmsapiSDK* client, voxgig_value* entopts);
voxgig_value* sent_rcs_message_stream(Entity* e, const char* action, voxgig_value* args, voxgig_value* callopts, PNError** err);
// ShipmentCountryVolume entity.
Entity* shipment_country_volume_entity_new(SmsapiSDK* client, voxgig_value* entopts);
Entity* smsapi_shipment_country_volume(SmsapiSDK* client, voxgig_value* entopts);
voxgig_value* shipment_country_volume_stream(Entity* e, const char* action, voxgig_value* args, voxgig_value* callopts, PNError** err);
// ShortUrl entity.
Entity* short_url_entity_new(SmsapiSDK* client, voxgig_value* entopts);
Entity* smsapi_short_url(SmsapiSDK* client, voxgig_value* entopts);
voxgig_value* short_url_stream(Entity* e, const char* action, voxgig_value* args, voxgig_value* callopts, PNError** err);
// Smsdo entity.
Entity* smsdo_entity_new(SmsapiSDK* client, voxgig_value* entopts);
Entity* smsapi_smsdo(SmsapiSDK* client, voxgig_value* entopts);
voxgig_value* smsdo_stream(Entity* e, const char* action, voxgig_value* args, voxgig_value* callopts, PNError** err);
// Smssendername entity.
Entity* smssendername_entity_new(SmsapiSDK* client, voxgig_value* entopts);
Entity* smsapi_smssendername(SmsapiSDK* client, voxgig_value* entopts);
voxgig_value* smssendername_stream(Entity* e, const char* action, voxgig_value* args, voxgig_value* callopts, PNError** err);
// Smstemplate entity.
Entity* smstemplate_entity_new(SmsapiSDK* client, voxgig_value* entopts);
Entity* smsapi_smstemplate(SmsapiSDK* client, voxgig_value* entopts);
voxgig_value* smstemplate_stream(Entity* e, const char* action, voxgig_value* args, voxgig_value* callopts, PNError** err);
// Subuser entity.
Entity* subuser_entity_new(SmsapiSDK* client, voxgig_value* entopts);
Entity* smsapi_subuser(SmsapiSDK* client, voxgig_value* entopts);
voxgig_value* subuser_stream(Entity* e, const char* action, voxgig_value* args, voxgig_value* callopts, PNError** err);
// Template entity.
Entity* template_entity_new(SmsapiSDK* client, voxgig_value* entopts);
Entity* smsapi_template(SmsapiSDK* client, voxgig_value* entopts);
voxgig_value* template_stream(Entity* e, const char* action, voxgig_value* args, voxgig_value* callopts, PNError** err);
// UserRcsSenderCollection entity.
Entity* user_rcs_sender_collection_entity_new(SmsapiSDK* client, voxgig_value* entopts);
Entity* smsapi_user_rcs_sender_collection(SmsapiSDK* client, voxgig_value* entopts);
voxgig_value* user_rcs_sender_collection_stream(Entity* e, const char* action, voxgig_value* args, voxgig_value* callopts, PNError** err);

#endif // SMSAPI_API_H
