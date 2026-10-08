package voxgig.smsapisdk.core;

// Typed reference models for the Smsapi SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields{} and per-op
// params (op.<name>.points[].g.params[]). Field/param types come from the
// canonical type sentinels (source of truth: @voxgig/apidef VALID_CANON). Do
// not edit by hand.
//
// These records are documentation/DX reference shapes ONLY. The SDK ops take
// and return the loose object model (Map<String, Object> / Object) at runtime,
// so these types are not wired into the op signatures — use them to describe a
// payload before converting it to a map. Every component is a boxed (nullable)
// type, so an optional (req:false) key needs no distinct rendering.

import java.util.List;
import java.util.Map;

public final class SmsapiTypes {

  private SmsapiTypes() {}

  public record Available(String name, Boolean normalize, String template) {}

  public record AvailableListMatch(String name, Boolean normalize, String template) {}

  public record Blacklist(String id) {}

  public record BlacklistLoadMatch(Long limit, Long offset, Long q) {}

  public record BlacklistCreateData(String id) {}

  public record BlacklistRemoveMatch(String id) {}

  public record Callback(Boolean active, Long api_version, String id, Boolean invalid, Map<String, Object> receiver, String receiver_type, String type, String url) {}

  public record CallbackLoadMatch(String id) {}

  public record CallbackListMatch(Boolean active, Long api_version, String id, Boolean invalid, Map<String, Object> receiver, String receiver_type, String type, String url) {}

  public record CallbackCreateData(Boolean active, Long api_version, String id, Boolean invalid, Map<String, Object> receiver, String receiver_type, String type, String url) {}

  public record CallbackUpdateData(String id, Boolean active, Long api_version, Boolean invalid, Map<String, Object> receiver, String receiver_type, String type, String url) {}

  public record CallbackRemoveMatch(String id) {}

  public record Contact(String birthday_date, String city, List<Object> collection, Long contact_expire_after, Long contacts_count, String country, String created_by, String date_created, String date_updated, String description, String email, String first_name, String gender, List<Object> groups, String id, String idx, String last_name, String name, List<Object> permissions, String phone_number, Long size, String source) {}

  public record ContactLoadMatch(String id) {}

  public record ContactListMatch(List<Object> birthday_date, List<Object> email, List<Object> first_name, String gender, List<Object> group_id, List<Object> last_name, Long limit, Long offset, String order_by, List<Object> phone_number, String q) {}

  public record ContactCreateData(String birthday_date, String city, List<Object> collection, Long contact_expire_after, Long contacts_count, String country, String created_by, String date_created, String date_updated, String description, String email, String first_name, String gender, List<Object> groups, String id, String idx, String last_name, String name, List<Object> permissions, String phone_number, Long size, String source) {}

  public record ContactUpdateData(String id, String birthday_date, String city, List<Object> collection, Long contact_expire_after, Long contacts_count, String country, String created_by, String date_created, String date_updated, String description, String email, String first_name, String gender, List<Object> groups, String idx, String last_name, String name, List<Object> permissions, String phone_number, Long size, String source) {}

  public record ContactRemoveMatch(String id) {}

  public record ContactsField(String id, String name, String type) {}

  public record ContactsFieldListMatch(String id, String name, String type) {}

  public record ContactsFieldCreateData(String id, String name, String type) {}

  public record ContactsFieldUpdateData(String id, String name, String type) {}

  public record ContactsFieldRemoveMatch(String id) {}

  public record ContactsFieldOption() {}

  public record ContactsFieldOptionListMatch(String field_id) {}

  public record Contactsgroup(String group_id, Boolean read, Boolean send, String username, Boolean write) {}

  public record ContactsgroupListMatch(Map<String, Object> name, List<Object> with) {}

  public record ContactsgroupCreateData(String group_id, Boolean read, Boolean send, String username, Boolean write) {}

  public record ContactsgroupUpdateData(String group_id, String username, Boolean read, Boolean send, Boolean write) {}

  public record ContactsgroupRemoveMatch(String group_id) {}

  public record Contactstrash() {}

  public record ContactstrashUpdateData() {}

  public record ContactstrashRemoveMatch() {}

  public record FieldAvailable(Boolean built_in, String id, String name, List<Object> options, String type) {}

  public record FieldAvailableListMatch(Boolean built_in, String id, String name, List<Object> options, String type) {}

  public record Group(Long contact_expire_after, Long contacts_count, String created_by, String date_created, String date_updated, String description, String id, String idx, String name, List<Object> permissions) {}

  public record GroupLoadMatch(String id) {}

  public record GroupUpdateData(String id, Long contact_expire_after, Long contacts_count, String created_by, String date_created, String date_updated, String description, String idx, String name, List<Object> permissions) {}

  public record MfaCode(String content, Object fast, String from, String phone_number) {}

  public record MfaCodeCreateData(String content, Object fast, String from, String phone_number) {}

  public record OptOut(String date, String id, List<Object> links, Long phoneNumber) {}

  public record OptOutListMatch(Long limit, Long offset, String phone_number) {}

  public record OptOutRemoveMatch(String id) {}

  public record OptOutSetting(String brand) {}

  public record OptOutSettingLoadMatch(String brand) {}

  public record OptOutSettingUpdateData(String brand) {}

  public record Permission(String group_id, String id, Boolean read, Boolean send, String username, Boolean write) {}

  public record PermissionLoadMatch(String group_id, String id) {}

  public record PermissionCreateData(String group_id, String id, Boolean read, Boolean send, String username, Boolean write) {}

  public record Ping(Boolean authorized, List<Object> unavailable) {}

  public record PingListMatch(Boolean authorized, List<Object> unavailable) {}

  public record Profile(String email, String name, String payment_type, Long phone_number, Double points, String user_type, String username) {}

  public record ProfileLoadMatch(String email, String name, String payment_type, Long phone_number, Double points, String user_type, String username) {}

  public record ProfileListMatch(String type) {}

  public record Rcs() {}

  public record RcsListMatch() {}

  public record Sendername(String created_at, String id, Boolean is_default, String sender, String status) {}

  public record SendernameLoadMatch(String id) {}

  public record SendernameListMatch(String created_at, String id, Boolean is_default, String sender, String status) {}

  public record SendernameCreateData(String created_at, String id, Boolean is_default, String sender, String status) {}

  public record SendernameStatement(String content, List<Object> statements, String title) {}

  public record SendernameStatementListMatch(String content, List<Object> statements, String title) {}

  public record SentRcsMessage(Map<String, Object> content, String phone_number, String sender, String text) {}

  public record SentRcsMessageCreateData(Map<String, Object> content, String phone_number, String sender, String text) {}

  public record ShipmentCountryVolume(String country_code, Long country_limit, String country_name, Long usage) {}

  public record ShipmentCountryVolumeListMatch(String month, String year) {}

  public record ShortUrl(String description, String expire, String filename, Long hits, Long hits_unique, String id, String name, String short_url, String type, String url) {}

  public record ShortUrlLoadMatch(String id) {}

  public record ShortUrlListMatch(String description, String expire, String filename, Long hits, Long hits_unique, String id, String name, String short_url, String type, String url) {}

  public record ShortUrlCreateData(String description, String expire, String filename, Long hits, Long hits_unique, String id, String name, String short_url, String type, String url) {}

  public record ShortUrlUpdateData(String id, String description, String expire, String filename, Long hits, Long hits_unique, String name, String short_url, String type, String url) {}

  public record ShortUrlRemoveMatch(String id) {}

  public record Smsdo(Long allow_duplicates, Object check_idx, Object date, Long date_validate, Object details, String encoding, Object expiration_date, List<Object> fallback, Long fast, Long flash, String format, String from, String group, String idx, Long max_parts, String message, Long normalize, String notify_url, Object test, String time_restriction, String to) {}

  public record SmsdoCreateData(Long allow_duplicates, Object check_idx, Object date, Long date_validate, Object details, String encoding, Object expiration_date, List<Object> fallback, Long fast, Long flash, String format, String from, String group, String idx, Long max_parts, String message, Long normalize, String notify_url, Object test, String time_restriction, String to) {}

  public record Smssendername() {}

  public record SmssendernameCreateData(String sender) {}

  public record SmssendernameRemoveMatch(String sender) {}

  public record Smstemplate(String id) {}

  public record SmstemplateRemoveMatch(String id) {}

  public record Subuser(Boolean active, Map<String, Object> credentials, String description, String id, Map<String, Object> points, String username) {}

  public record SubuserLoadMatch(String id) {}

  public record SubuserListMatch(String q) {}

  public record SubuserCreateData(Boolean active, Map<String, Object> credentials, String description, String id, Map<String, Object> points, String username) {}

  public record SubuserUpdateData(String id, Boolean active, Map<String, Object> credentials, String description, Map<String, Object> points, String username) {}

  public record SubuserRemoveMatch(String id) {}

  public record Template(String id, String name, Boolean normalize, String template) {}

  public record TemplateLoadMatch(String id) {}

  public record TemplateListMatch(String id, String name, Boolean normalize, String template) {}

  public record TemplateCreateData(String id, String name, Boolean normalize, String template) {}

  public record TemplateUpdateData(String id, String name, Boolean normalize, String template) {}

  public record UserRcsSenderCollection() {}

  public record UserRcsSenderCollectionListMatch() {}

}
