package voxgig.smsapisdk.core

// Typed reference models for the Smsapi SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields{} and per-op
// params (op.<name>.points[].g.params[]). Field/param types come from the
// canonical type sentinels (source of truth: @voxgig/apidef VALID_CANON). Do
// not edit by hand.
//
// These case classes are documentation/DX reference shapes ONLY. The SDK ops
// take and return the loose object model (java.util.Map[String, Object] /
// Object) at runtime, so these types are not wired into the op signatures —
// use them to describe a payload before converting it to a map. Every
// component is a boxed (nullable) type, so an optional (req:false) key needs
// no distinct rendering.

object SmsapiTypes {

  final case class Available(name: String, normalize: java.lang.Boolean, template: String)

  final case class AvailableListMatch(name: String, normalize: java.lang.Boolean, template: String)

  final case class Blacklist(id: String)

  final case class BlacklistLoadMatch(limit: java.lang.Long, offset: java.lang.Long, q: java.lang.Long)

  final case class BlacklistCreateData(id: String)

  final case class BlacklistRemoveMatch(id: String)

  final case class Callback(active: java.lang.Boolean, api_version: java.lang.Long, id: String, invalid: java.lang.Boolean, receiver: java.util.Map[String, Object], receiver_type: String, url: String)

  final case class CallbackLoadMatch(id: String)

  final case class CallbackListMatch(active: java.lang.Boolean, api_version: java.lang.Long, id: String, invalid: java.lang.Boolean, receiver: java.util.Map[String, Object], receiver_type: String, url: String)

  final case class CallbackCreateData(active: java.lang.Boolean, api_version: java.lang.Long, id: String, invalid: java.lang.Boolean, receiver: java.util.Map[String, Object], receiver_type: String, url: String)

  final case class CallbackUpdateData(id: String, active: java.lang.Boolean, api_version: java.lang.Long, invalid: java.lang.Boolean, receiver: java.util.Map[String, Object], receiver_type: String, url: String)

  final case class CallbackRemoveMatch(id: String)

  final case class Contact(birthday_date: String, city: String, collection: java.util.List[Object], contact_expire_after: java.lang.Long, contacts_count: java.lang.Long, country: String, created_by: String, date_created: String, date_updated: String, description: String, email: String, first_name: String, gender: String, group_id: String, groups: java.util.List[Object], id: String, idx: String, last_name: String, name: String, permissions: java.util.List[Object], phone_number: String, read: java.lang.Boolean, send: java.lang.Boolean, size: java.lang.Long, source: String, username: String, value: String, write: java.lang.Boolean)

  final case class ContactLoadMatch(id: String)

  final case class ContactListMatch(birthday_date: java.util.List[Object], email: java.util.List[Object], first_name: java.util.List[Object], gender: String, group_id: java.util.List[Object], last_name: java.util.List[Object], limit: java.lang.Long, offset: java.lang.Long, order_by: String, phone_number: java.util.List[Object], q: String)

  final case class ContactCreateData(birthday_date: String, city: String, collection: java.util.List[Object], contact_expire_after: java.lang.Long, contacts_count: java.lang.Long, country: String, created_by: String, date_created: String, date_updated: String, description: String, email: String, first_name: String, gender: String, group_id: String, groups: java.util.List[Object], id: String, idx: String, last_name: String, name: String, permissions: java.util.List[Object], phone_number: String, read: java.lang.Boolean, send: java.lang.Boolean, size: java.lang.Long, source: String, username: String, value: String, write: java.lang.Boolean)

  final case class ContactUpdateData(id: String, birthday_date: String, city: String, collection: java.util.List[Object], contact_expire_after: java.lang.Long, contacts_count: java.lang.Long, country: String, created_by: String, date_created: String, date_updated: String, description: String, email: String, first_name: String, gender: String, group_id: String, groups: java.util.List[Object], idx: String, last_name: String, name: String, permissions: java.util.List[Object], phone_number: String, read: java.lang.Boolean, send: java.lang.Boolean, size: java.lang.Long, source: String, username: String, value: String, write: java.lang.Boolean)

  final case class ContactRemoveMatch(id: String)

  final case class ContactsField(birthday_date: String, city: String, contact_expire_after: java.lang.Long, contacts_count: java.lang.Long, country: String, created_by: String, date_created: String, date_updated: String, description: String, email: String, first_name: String, gender: String, group_id: String, groups: java.util.List[Object], id: String, idx: String, last_name: String, name: String, permissions: java.util.List[Object], phone_number: String, read: java.lang.Boolean, send: java.lang.Boolean, source: String, username: String, value: String, write: java.lang.Boolean)

  final case class ContactsFieldListMatch(birthday_date: String, city: String, contact_expire_after: java.lang.Long, contacts_count: java.lang.Long, country: String, created_by: String, date_created: String, date_updated: String, description: String, email: String, first_name: String, gender: String, group_id: String, groups: java.util.List[Object], id: String, idx: String, last_name: String, name: String, permissions: java.util.List[Object], phone_number: String, read: java.lang.Boolean, send: java.lang.Boolean, source: String, username: String, value: String, write: java.lang.Boolean)

  final case class ContactsFieldCreateData(birthday_date: String, city: String, contact_expire_after: java.lang.Long, contacts_count: java.lang.Long, country: String, created_by: String, date_created: String, date_updated: String, description: String, email: String, first_name: String, gender: String, group_id: String, groups: java.util.List[Object], id: String, idx: String, last_name: String, name: String, permissions: java.util.List[Object], phone_number: String, read: java.lang.Boolean, send: java.lang.Boolean, source: String, username: String, value: String, write: java.lang.Boolean)

  final case class ContactsFieldUpdateData(id: String, birthday_date: String, city: String, contact_expire_after: java.lang.Long, contacts_count: java.lang.Long, country: String, created_by: String, date_created: String, date_updated: String, description: String, email: String, first_name: String, gender: String, group_id: String, groups: java.util.List[Object], idx: String, last_name: String, name: String, permissions: java.util.List[Object], phone_number: String, read: java.lang.Boolean, send: java.lang.Boolean, source: String, username: String, value: String, write: java.lang.Boolean)

  final case class ContactsFieldRemoveMatch(id: String)

  final case class ContactsFieldOption(birthday_date: String, city: String, contact_expire_after: java.lang.Long, contacts_count: java.lang.Long, country: String, created_by: String, date_created: String, date_updated: String, description: String, email: String, first_name: String, gender: String, group_id: String, groups: java.util.List[Object], id: String, idx: String, last_name: String, name: String, permissions: java.util.List[Object], phone_number: String, read: java.lang.Boolean, send: java.lang.Boolean, source: String, username: String, value: String, write: java.lang.Boolean)

  final case class ContactsFieldOptionListMatch(field_id: String)

  final case class Contactsgroup(birthday_date: String, city: String, contact_expire_after: java.lang.Long, contacts_count: java.lang.Long, country: String, created_by: String, date_created: String, date_updated: String, description: String, email: String, first_name: String, gender: String, group_id: String, groups: java.util.List[Object], id: String, idx: String, last_name: String, name: String, permissions: java.util.List[Object], phone_number: String, read: java.lang.Boolean, send: java.lang.Boolean, source: String, username: String, value: String, write: java.lang.Boolean)

  final case class ContactsgroupListMatch(name: java.util.Map[String, Object])

  final case class ContactsgroupCreateData(birthday_date: String, city: String, contact_expire_after: java.lang.Long, contacts_count: java.lang.Long, country: String, created_by: String, date_created: String, date_updated: String, description: String, email: String, first_name: String, gender: String, group_id: String, groups: java.util.List[Object], id: String, idx: String, last_name: String, name: String, permissions: java.util.List[Object], phone_number: String, read: java.lang.Boolean, send: java.lang.Boolean, source: String, username: String, value: String, write: java.lang.Boolean)

  final case class ContactsgroupUpdateData(group_id: String, username: String, birthday_date: String, city: String, contact_expire_after: java.lang.Long, contacts_count: java.lang.Long, country: String, created_by: String, date_created: String, date_updated: String, description: String, email: String, first_name: String, gender: String, groups: java.util.List[Object], id: String, idx: String, last_name: String, name: String, permissions: java.util.List[Object], phone_number: String, read: java.lang.Boolean, send: java.lang.Boolean, source: String, value: String, write: java.lang.Boolean)

  final case class ContactsgroupRemoveMatch(group_id: String)

  final case class Contactstrash()

  final case class ContactstrashUpdateData()

  final case class ContactstrashRemoveMatch()

  final case class FieldAvailable(built_in: java.lang.Boolean, id: String, name: String, options: java.util.List[Object])

  final case class FieldAvailableListMatch(built_in: java.lang.Boolean, id: String, name: String, options: java.util.List[Object])

  final case class Group(contact_expire_after: java.lang.Long, contacts_count: java.lang.Long, created_by: String, date_created: String, date_updated: String, description: String, id: String, idx: String, name: String, permissions: java.util.List[Object])

  final case class GroupLoadMatch(id: String)

  final case class GroupUpdateData(id: String, contact_expire_after: java.lang.Long, contacts_count: java.lang.Long, created_by: String, date_created: String, date_updated: String, description: String, idx: String, name: String, permissions: java.util.List[Object])

  final case class MfaCode(content: String, fast: Object, from: String, phone_number: String)

  final case class MfaCodeCreateData(content: String, fast: Object, from: String, phone_number: String)

  final case class OptOut(date: String, id: String, links: java.util.List[Object], phoneNumber: java.lang.Long)

  final case class OptOutListMatch(limit: java.lang.Long, offset: java.lang.Long, phone_number: String)

  final case class OptOutRemoveMatch(id: String)

  final case class OptOutSetting(brand: String)

  final case class OptOutSettingLoadMatch(brand: String)

  final case class OptOutSettingUpdateData(brand: String)

  final case class Permission(group_id: String, id: String, read: java.lang.Boolean, send: java.lang.Boolean, username: String, write: java.lang.Boolean)

  final case class PermissionLoadMatch(group_id: String, id: String, username: String)

  final case class PermissionCreateData(group_id: String, id: String, read: java.lang.Boolean, send: java.lang.Boolean, username: String, write: java.lang.Boolean)

  final case class Ping(authorized: java.lang.Boolean, unavailable: java.util.List[Object])

  final case class PingListMatch(authorized: java.lang.Boolean, unavailable: java.util.List[Object])

  final case class Profile(email: String, name: String, payment_type: String, phone_number: java.lang.Long, points: java.lang.Double, user_type: String, username: String)

  final case class ProfileLoadMatch(email: String, name: String, payment_type: String, phone_number: java.lang.Long, points: java.lang.Double, user_type: String, username: String)

  final case class ProfileListMatch()

  final case class Rcs()

  final case class RcsListMatch()

  final case class Sendername(created_at: String, id: String, is_default: java.lang.Boolean, sender: String, status: String)

  final case class SendernameLoadMatch(id: String)

  final case class SendernameListMatch(created_at: String, id: String, is_default: java.lang.Boolean, sender: String, status: String)

  final case class SendernameCreateData(created_at: String, id: String, is_default: java.lang.Boolean, sender: String, status: String)

  final case class SendernameStatement(content: String, statements: java.util.List[Object], title: String)

  final case class SendernameStatementListMatch(content: String, statements: java.util.List[Object], title: String)

  final case class SentRcsMessage(content: java.util.Map[String, Object], phone_number: String, sender: Object, text: String)

  final case class SentRcsMessageCreateData(content: java.util.Map[String, Object], phone_number: String, sender: Object, text: String)

  final case class ShipmentCountryVolume(country_code: String, country_limit: java.lang.Long, country_name: String, usage: java.lang.Long)

  final case class ShipmentCountryVolumeListMatch(month: String, year: String)

  final case class ShortUrl(description: String, expire: String, filename: String, hits: java.lang.Long, hits_unique: java.lang.Long, id: String, name: String, short_url: String, url: String)

  final case class ShortUrlLoadMatch(id: String)

  final case class ShortUrlListMatch(description: String, expire: String, filename: String, hits: java.lang.Long, hits_unique: java.lang.Long, id: String, name: String, short_url: String, url: String)

  final case class ShortUrlCreateData(description: String, expire: String, filename: String, hits: java.lang.Long, hits_unique: java.lang.Long, id: String, name: String, short_url: String, url: String)

  final case class ShortUrlUpdateData(id: String, description: String, expire: String, filename: String, hits: java.lang.Long, hits_unique: java.lang.Long, name: String, short_url: String, url: String)

  final case class ShortUrlRemoveMatch(id: String)

  final case class Smsdo(allow_duplicates: java.lang.Long, check_idx: Object, date: Object, date_validate: java.lang.Long, details: Object, encoding: String, expiration_date: Object, fallback: java.util.List[Object], fast: java.lang.Long, flash: java.lang.Long, format: String, from: String, group: String, idx: String, max_parts: java.lang.Long, message: String, normalize: java.lang.Long, notify_url: String, test: Object, time_restriction: String, to: String)

  final case class SmsdoCreateData(allow_duplicates: java.lang.Long, check_idx: Object, date: Object, date_validate: java.lang.Long, details: Object, encoding: String, expiration_date: Object, fallback: java.util.List[Object], fast: java.lang.Long, flash: java.lang.Long, format: String, from: String, group: String, idx: String, max_parts: java.lang.Long, message: String, normalize: java.lang.Long, notify_url: String, test: Object, time_restriction: String, to: String)

  final case class Smssendername()

  final case class SmssendernameCreateData(sendername_id: String)

  final case class SmssendernameRemoveMatch(sender: String)

  final case class Smstemplate(id: String)

  final case class SmstemplateRemoveMatch(id: String)

  final case class Subuser(active: java.lang.Boolean, credentials: java.util.Map[String, Object], description: String, id: String, points: java.util.Map[String, Object], username: String)

  final case class SubuserLoadMatch(id: String)

  final case class SubuserListMatch(q: String)

  final case class SubuserCreateData(active: java.lang.Boolean, credentials: java.util.Map[String, Object], description: String, id: String, points: java.util.Map[String, Object], username: String)

  final case class SubuserUpdateData(id: String, active: java.lang.Boolean, credentials: java.util.Map[String, Object], description: String, points: java.util.Map[String, Object], username: String)

  final case class SubuserRemoveMatch(id: String)

  final case class Template(id: String, name: String, normalize: java.lang.Boolean, template: String)

  final case class TemplateLoadMatch(id: String)

  final case class TemplateListMatch(id: String, name: String, normalize: java.lang.Boolean, template: String)

  final case class TemplateCreateData(id: String, name: String, normalize: java.lang.Boolean, template: String)

  final case class TemplateUpdateData(id: String, name: String, normalize: java.lang.Boolean, template: String)

  final case class UserRcsSenderCollection(deliveredAt: String, expiredAt: String, id: String, interface: String, messageType: String, readAt: String, recipient: String, sender: String, senderId: String, sentAt: String)

  final case class UserRcsSenderCollectionListMatch(deliveredAt: String, expiredAt: String, id: String, interface: String, messageType: String, readAt: String, recipient: String, sender: String, senderId: String, sentAt: String)

}
