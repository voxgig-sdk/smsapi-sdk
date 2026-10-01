package voxgig.smsapisdk.core

// Typed reference models for the Smsapi SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields{} and per-op
// params (op.<name>.points[].g.params[]). Field/param types come from the
// canonical type sentinels (source of truth: @voxgig/apidef VALID_CANON). Do
// not edit by hand.
//
// These types are documentation/DX reference shapes ONLY. The SDK ops take and
// return the loose object model (MutableMap<String, Any?> / Any?) at runtime,
// so these types are not wired into the op signatures — use them to describe a
// payload before converting it to a map. Every component is a nullable type, so
// an optional (req:false) key needs no distinct rendering.

@Suppress("unused")
object SmsapiTypes {

  data class Available(val name: String?, val normalize: Boolean?, val template: String?)

  data class AvailableListMatch(val name: String?, val normalize: Boolean?, val template: String?)

  data class Blacklist(val id: String?)

  data class BlacklistLoadMatch(val limit: Long?, val offset: Long?, val q: Long?)

  data class BlacklistCreateData(val id: String?)

  data class BlacklistRemoveMatch(val id: String?)

  data class Callback(val active: Boolean?, val api_version: Long?, val id: String?, val invalid: Boolean?, val receiver: Map<String, Any?>?, val receiver_type: String?, val type: String?, val url: String?)

  data class CallbackLoadMatch(val id: String?)

  data class CallbackListMatch(val active: Boolean?, val api_version: Long?, val id: String?, val invalid: Boolean?, val receiver: Map<String, Any?>?, val receiver_type: String?, val type: String?, val url: String?)

  data class CallbackCreateData(val active: Boolean?, val api_version: Long?, val id: String?, val invalid: Boolean?, val receiver: Map<String, Any?>?, val receiver_type: String?, val type: String?, val url: String?)

  data class CallbackUpdateData(val id: String?, val active: Boolean?, val api_version: Long?, val invalid: Boolean?, val receiver: Map<String, Any?>?, val receiver_type: String?, val type: String?, val url: String?)

  data class CallbackRemoveMatch(val id: String?)

  data class Contact(val birthday_date: String?, val city: String?, val collection: List<Any?>?, val contact_expire_after: Long?, val contacts_count: Long?, val country: String?, val created_by: String?, val date_created: String?, val date_updated: String?, val description: String?, val email: String?, val first_name: String?, val gender: String?, val group_id: String?, val groups: List<Any?>?, val id: String?, val idx: String?, val last_name: String?, val name: String?, val permissions: List<Any?>?, val phone_number: String?, val read: Boolean?, val send: Boolean?, val size: Long?, val source: String?, val type: String?, val username: String?, val value: String?, val write: Boolean?)

  data class ContactLoadMatch(val id: String?)

  data class ContactListMatch(val birthday_date: List<Any?>?, val email: List<Any?>?, val first_name: List<Any?>?, val gender: String?, val group_id: List<Any?>?, val last_name: List<Any?>?, val limit: Long?, val offset: Long?, val order_by: String?, val phone_number: List<Any?>?, val q: String?)

  data class ContactCreateData(val birthday_date: String?, val city: String?, val collection: List<Any?>?, val contact_expire_after: Long?, val contacts_count: Long?, val country: String?, val created_by: String?, val date_created: String?, val date_updated: String?, val description: String?, val email: String?, val first_name: String?, val gender: String?, val group_id: String?, val groups: List<Any?>?, val id: String?, val idx: String?, val last_name: String?, val name: String?, val permissions: List<Any?>?, val phone_number: String?, val read: Boolean?, val send: Boolean?, val size: Long?, val source: String?, val type: String?, val username: String?, val value: String?, val write: Boolean?)

  data class ContactUpdateData(val id: String?, val birthday_date: String?, val city: String?, val collection: List<Any?>?, val contact_expire_after: Long?, val contacts_count: Long?, val country: String?, val created_by: String?, val date_created: String?, val date_updated: String?, val description: String?, val email: String?, val first_name: String?, val gender: String?, val group_id: String?, val groups: List<Any?>?, val idx: String?, val last_name: String?, val name: String?, val permissions: List<Any?>?, val phone_number: String?, val read: Boolean?, val send: Boolean?, val size: Long?, val source: String?, val type: String?, val username: String?, val value: String?, val write: Boolean?)

  data class ContactRemoveMatch(val id: String?)

  data class ContactsField(val birthday_date: String?, val city: String?, val contact_expire_after: Long?, val contacts_count: Long?, val country: String?, val created_by: String?, val date_created: String?, val date_updated: String?, val description: String?, val email: String?, val first_name: String?, val gender: String?, val group_id: String?, val groups: List<Any?>?, val id: String?, val idx: String?, val last_name: String?, val name: String?, val permissions: List<Any?>?, val phone_number: String?, val read: Boolean?, val send: Boolean?, val source: String?, val type: String?, val username: String?, val value: String?, val write: Boolean?)

  data class ContactsFieldListMatch(val birthday_date: String?, val city: String?, val contact_expire_after: Long?, val contacts_count: Long?, val country: String?, val created_by: String?, val date_created: String?, val date_updated: String?, val description: String?, val email: String?, val first_name: String?, val gender: String?, val group_id: String?, val groups: List<Any?>?, val id: String?, val idx: String?, val last_name: String?, val name: String?, val permissions: List<Any?>?, val phone_number: String?, val read: Boolean?, val send: Boolean?, val source: String?, val type: String?, val username: String?, val value: String?, val write: Boolean?)

  data class ContactsFieldCreateData(val birthday_date: String?, val city: String?, val contact_expire_after: Long?, val contacts_count: Long?, val country: String?, val created_by: String?, val date_created: String?, val date_updated: String?, val description: String?, val email: String?, val first_name: String?, val gender: String?, val group_id: String?, val groups: List<Any?>?, val id: String?, val idx: String?, val last_name: String?, val name: String?, val permissions: List<Any?>?, val phone_number: String?, val read: Boolean?, val send: Boolean?, val source: String?, val type: String?, val username: String?, val value: String?, val write: Boolean?)

  data class ContactsFieldUpdateData(val id: String?, val birthday_date: String?, val city: String?, val contact_expire_after: Long?, val contacts_count: Long?, val country: String?, val created_by: String?, val date_created: String?, val date_updated: String?, val description: String?, val email: String?, val first_name: String?, val gender: String?, val group_id: String?, val groups: List<Any?>?, val idx: String?, val last_name: String?, val name: String?, val permissions: List<Any?>?, val phone_number: String?, val read: Boolean?, val send: Boolean?, val source: String?, val type: String?, val username: String?, val value: String?, val write: Boolean?)

  data class ContactsFieldRemoveMatch(val id: String?)

  data class ContactsFieldOption(val birthday_date: String?, val city: String?, val contact_expire_after: Long?, val contacts_count: Long?, val country: String?, val created_by: String?, val date_created: String?, val date_updated: String?, val description: String?, val email: String?, val first_name: String?, val gender: String?, val group_id: String?, val groups: List<Any?>?, val id: String?, val idx: String?, val last_name: String?, val name: String?, val permissions: List<Any?>?, val phone_number: String?, val read: Boolean?, val send: Boolean?, val source: String?, val type: String?, val username: String?, val value: String?, val write: Boolean?)

  data class ContactsFieldOptionListMatch(val field_id: String?)

  data class Contactsgroup(val birthday_date: String?, val city: String?, val contact_expire_after: Long?, val contacts_count: Long?, val country: String?, val created_by: String?, val date_created: String?, val date_updated: String?, val description: String?, val email: String?, val first_name: String?, val gender: String?, val group_id: String?, val groups: List<Any?>?, val id: String?, val idx: String?, val last_name: String?, val name: String?, val permissions: List<Any?>?, val phone_number: String?, val read: Boolean?, val send: Boolean?, val source: String?, val type: String?, val username: String?, val value: String?, val write: Boolean?)

  data class ContactsgroupListMatch(val name: Map<String, Any?>?, val with: List<Any?>?)

  data class ContactsgroupCreateData(val birthday_date: String?, val city: String?, val contact_expire_after: Long?, val contacts_count: Long?, val country: String?, val created_by: String?, val date_created: String?, val date_updated: String?, val description: String?, val email: String?, val first_name: String?, val gender: String?, val group_id: String?, val groups: List<Any?>?, val id: String?, val idx: String?, val last_name: String?, val name: String?, val permissions: List<Any?>?, val phone_number: String?, val read: Boolean?, val send: Boolean?, val source: String?, val type: String?, val username: String?, val value: String?, val write: Boolean?)

  data class ContactsgroupUpdateData(val group_id: String?, val username: String?, val birthday_date: String?, val city: String?, val contact_expire_after: Long?, val contacts_count: Long?, val country: String?, val created_by: String?, val date_created: String?, val date_updated: String?, val description: String?, val email: String?, val first_name: String?, val gender: String?, val groups: List<Any?>?, val id: String?, val idx: String?, val last_name: String?, val name: String?, val permissions: List<Any?>?, val phone_number: String?, val read: Boolean?, val send: Boolean?, val source: String?, val type: String?, val value: String?, val write: Boolean?)

  data class ContactsgroupRemoveMatch(val group_id: String?)

  class Contactstrash

  class ContactstrashUpdateData

  class ContactstrashRemoveMatch

  data class FieldAvailable(val built_in: Boolean?, val id: String?, val name: String?, val options: List<Any?>?, val type: String?)

  data class FieldAvailableListMatch(val built_in: Boolean?, val id: String?, val name: String?, val options: List<Any?>?, val type: String?)

  data class Group(val contact_expire_after: Long?, val contacts_count: Long?, val created_by: String?, val date_created: String?, val date_updated: String?, val description: String?, val id: String?, val idx: String?, val name: String?, val permissions: List<Any?>?)

  data class GroupLoadMatch(val id: String?)

  data class GroupUpdateData(val id: String?, val contact_expire_after: Long?, val contacts_count: Long?, val created_by: String?, val date_created: String?, val date_updated: String?, val description: String?, val idx: String?, val name: String?, val permissions: List<Any?>?)

  data class MfaCode(val content: String?, val fast: Any?, val from: String?, val phone_number: String?)

  data class MfaCodeCreateData(val content: String?, val fast: Any?, val from: String?, val phone_number: String?)

  data class OptOut(val date: String?, val id: String?, val links: List<Any?>?, val phoneNumber: Long?)

  data class OptOutListMatch(val limit: Long?, val offset: Long?, val phone_number: String?)

  data class OptOutRemoveMatch(val id: String?)

  data class OptOutSetting(val brand: String?)

  data class OptOutSettingLoadMatch(val brand: String?)

  data class OptOutSettingUpdateData(val brand: String?)

  data class Permission(val group_id: String?, val id: String?, val read: Boolean?, val send: Boolean?, val username: String?, val write: Boolean?)

  data class PermissionLoadMatch(val group_id: String?, val id: String?, val username: String?)

  data class PermissionCreateData(val group_id: String?, val id: String?, val read: Boolean?, val send: Boolean?, val username: String?, val write: Boolean?)

  data class Ping(val authorized: Boolean?, val unavailable: List<Any?>?)

  data class PingListMatch(val authorized: Boolean?, val unavailable: List<Any?>?)

  data class Profile(val email: String?, val name: String?, val payment_type: String?, val phone_number: Long?, val points: Double?, val user_type: String?, val username: String?)

  data class ProfileLoadMatch(val email: String?, val name: String?, val payment_type: String?, val phone_number: Long?, val points: Double?, val user_type: String?, val username: String?)

  data class ProfileListMatch(val type: String?)

  class Rcs

  class RcsListMatch

  data class Sendername(val created_at: String?, val id: String?, val is_default: Boolean?, val sender: String?, val status: String?)

  data class SendernameLoadMatch(val id: String?)

  data class SendernameListMatch(val created_at: String?, val id: String?, val is_default: Boolean?, val sender: String?, val status: String?)

  data class SendernameCreateData(val created_at: String?, val id: String?, val is_default: Boolean?, val sender: String?, val status: String?)

  data class SendernameStatement(val content: String?, val statements: List<Any?>?, val title: String?)

  data class SendernameStatementListMatch(val content: String?, val statements: List<Any?>?, val title: String?)

  data class SentRcsMessage(val content: Map<String, Any?>?, val phone_number: String?, val sender: Any?, val text: String?)

  data class SentRcsMessageCreateData(val content: Map<String, Any?>?, val phone_number: String?, val sender: Any?, val text: String?)

  data class ShipmentCountryVolume(val country_code: String?, val country_limit: Long?, val country_name: String?, val usage: Long?)

  data class ShipmentCountryVolumeListMatch(val month: String?, val year: String?)

  data class ShortUrl(val description: String?, val expire: String?, val filename: String?, val hits: Long?, val hits_unique: Long?, val id: String?, val name: String?, val short_url: String?, val type: String?, val url: String?)

  data class ShortUrlLoadMatch(val id: String?)

  data class ShortUrlListMatch(val description: String?, val expire: String?, val filename: String?, val hits: Long?, val hits_unique: Long?, val id: String?, val name: String?, val short_url: String?, val type: String?, val url: String?)

  data class ShortUrlCreateData(val description: String?, val expire: String?, val filename: String?, val hits: Long?, val hits_unique: Long?, val id: String?, val name: String?, val short_url: String?, val type: String?, val url: String?)

  data class ShortUrlUpdateData(val id: String?, val description: String?, val expire: String?, val filename: String?, val hits: Long?, val hits_unique: Long?, val name: String?, val short_url: String?, val type: String?, val url: String?)

  data class ShortUrlRemoveMatch(val id: String?)

  data class Smsdo(val allow_duplicates: Long?, val check_idx: Any?, val date: Any?, val date_validate: Long?, val details: Any?, val encoding: String?, val expiration_date: Any?, val fallback: List<Any?>?, val fast: Long?, val flash: Long?, val format: String?, val from: String?, val group: String?, val idx: String?, val max_parts: Long?, val message: String?, val normalize: Long?, val notify_url: String?, val test: Any?, val time_restriction: String?, val to: String?)

  data class SmsdoCreateData(val allow_duplicates: Long?, val check_idx: Any?, val date: Any?, val date_validate: Long?, val details: Any?, val encoding: String?, val expiration_date: Any?, val fallback: List<Any?>?, val fast: Long?, val flash: Long?, val format: String?, val from: String?, val group: String?, val idx: String?, val max_parts: Long?, val message: String?, val normalize: Long?, val notify_url: String?, val test: Any?, val time_restriction: String?, val to: String?)

  class Smssendername

  data class SmssendernameCreateData(val sendername_id: String?)

  data class SmssendernameRemoveMatch(val sender: String?)

  data class Smstemplate(val id: String?)

  data class SmstemplateRemoveMatch(val id: String?)

  data class Subuser(val active: Boolean?, val credentials: Map<String, Any?>?, val description: String?, val id: String?, val points: Map<String, Any?>?, val username: String?)

  data class SubuserLoadMatch(val id: String?)

  data class SubuserListMatch(val q: String?)

  data class SubuserCreateData(val active: Boolean?, val credentials: Map<String, Any?>?, val description: String?, val id: String?, val points: Map<String, Any?>?, val username: String?)

  data class SubuserUpdateData(val id: String?, val active: Boolean?, val credentials: Map<String, Any?>?, val description: String?, val points: Map<String, Any?>?, val username: String?)

  data class SubuserRemoveMatch(val id: String?)

  data class Template(val id: String?, val name: String?, val normalize: Boolean?, val template: String?)

  data class TemplateLoadMatch(val id: String?)

  data class TemplateListMatch(val id: String?, val name: String?, val normalize: Boolean?, val template: String?)

  data class TemplateCreateData(val id: String?, val name: String?, val normalize: Boolean?, val template: String?)

  data class TemplateUpdateData(val id: String?, val name: String?, val normalize: Boolean?, val template: String?)

  data class UserRcsSenderCollection(val deliveredAt: String?, val expiredAt: String?, val id: String?, val messageType: String?, val readAt: String?, val recipient: String?, val sender: String?, val senderId: String?, val sentAt: String?)

  data class UserRcsSenderCollectionListMatch(val deliveredAt: String?, val expiredAt: String?, val id: String?, val messageType: String?, val readAt: String?, val recipient: String?, val sender: String?, val senderId: String?, val sentAt: String?)

}
