// Typed reference models for the Smsapi SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields{} and per-op
// params (op.<name>.points[].g.params[]). Field/param types come from the
// canonical type sentinels (source of truth: @voxgig/apidef VALID_CANON). Do
// not edit by hand.
//
// These records are documentation/DX reference shapes ONLY. The SDK ops take
// and return the loose object model (Dictionary<string, object?> / object?) at
// runtime, so these types are not wired into the op signatures — use them to
// describe a payload before converting it to a dictionary. Optional (req:false)
// keys are modelled as nullable properties.

namespace SmsapiSdk.Types;

public record Available
{
    public string? name { get; init; }
    public bool? normalize { get; init; }
    public string? template { get; init; }
}

public record AvailableListMatch
{
    public string? name { get; init; }
    public bool? normalize { get; init; }
    public string? template { get; init; }
}

public record Blacklist
{
    public string? id { get; init; }
}

public record BlacklistLoadMatch
{
    public long? limit { get; init; }
    public long? offset { get; init; }
    public long? q { get; init; }
}

public record BlacklistCreateData
{
    public string? id { get; init; }
}

public record BlacklistRemoveMatch
{
    public string id { get; init; }
}

public record Callback
{
    public bool? active { get; init; }
    public long? api_version { get; init; }
    public string? id { get; init; }
    public bool? invalid { get; init; }
    public Dictionary<string, object?>? receiver { get; init; }
    public string? receiver_type { get; init; }
    public string? type { get; init; }
    public string? url { get; init; }
}

public record CallbackLoadMatch
{
    public string id { get; init; }
}

public record CallbackListMatch
{
    public bool? active { get; init; }
    public long? api_version { get; init; }
    public string? id { get; init; }
    public bool? invalid { get; init; }
    public Dictionary<string, object?>? receiver { get; init; }
    public string? receiver_type { get; init; }
    public string? type { get; init; }
    public string? url { get; init; }
}

public record CallbackCreateData
{
    public bool? active { get; init; }
    public long? api_version { get; init; }
    public string? id { get; init; }
    public bool? invalid { get; init; }
    public Dictionary<string, object?>? receiver { get; init; }
    public string? receiver_type { get; init; }
    public string? type { get; init; }
    public string? url { get; init; }
}

public record CallbackUpdateData
{
    public string id { get; init; }
    public bool? active { get; init; }
    public long? api_version { get; init; }
    public bool? invalid { get; init; }
    public Dictionary<string, object?>? receiver { get; init; }
    public string? receiver_type { get; init; }
    public string? type { get; init; }
    public string? url { get; init; }
}

public record CallbackRemoveMatch
{
    public string id { get; init; }
}

public record Contact
{
    public string? birthday_date { get; init; }
    public string? city { get; init; }
    public List<object?> collection { get; init; }
    public long contact_expire_after { get; init; }
    public long contacts_count { get; init; }
    public string? country { get; init; }
    public string created_by { get; init; }
    public string date_created { get; init; }
    public string date_updated { get; init; }
    public string? description { get; init; }
    public string? email { get; init; }
    public string? first_name { get; init; }
    public string gender { get; init; }
    public List<object?> groups { get; init; }
    public string id { get; init; }
    public string? idx { get; init; }
    public string? last_name { get; init; }
    public string name { get; init; }
    public List<object?>? permissions { get; init; }
    public string? phone_number { get; init; }
    public long size { get; init; }
    public string? source { get; init; }
}

public record ContactLoadMatch
{
    public string id { get; init; }
}

public record ContactListMatch
{
    public List<object?>? birthday_date { get; init; }
    public List<object?>? email { get; init; }
    public List<object?>? first_name { get; init; }
    public string? gender { get; init; }
    public List<object?>? group_id { get; init; }
    public List<object?>? last_name { get; init; }
    public long? limit { get; init; }
    public long? offset { get; init; }
    public string? order_by { get; init; }
    public List<object?>? phone_number { get; init; }
    public string? q { get; init; }
}

public record ContactCreateData
{
    public string? birthday_date { get; init; }
    public string? city { get; init; }
    public List<object?> collection { get; init; }
    public long contact_expire_after { get; init; }
    public long contacts_count { get; init; }
    public string? country { get; init; }
    public string created_by { get; init; }
    public string date_created { get; init; }
    public string date_updated { get; init; }
    public string? description { get; init; }
    public string? email { get; init; }
    public string? first_name { get; init; }
    public string gender { get; init; }
    public List<object?> groups { get; init; }
    public string id { get; init; }
    public string? idx { get; init; }
    public string? last_name { get; init; }
    public string name { get; init; }
    public List<object?>? permissions { get; init; }
    public string? phone_number { get; init; }
    public long size { get; init; }
    public string? source { get; init; }
}

public record ContactUpdateData
{
    public string id { get; init; }
    public string? birthday_date { get; init; }
    public string? city { get; init; }
    public List<object?>? collection { get; init; }
    public long? contact_expire_after { get; init; }
    public long? contacts_count { get; init; }
    public string? country { get; init; }
    public string? created_by { get; init; }
    public string? date_created { get; init; }
    public string? date_updated { get; init; }
    public string? description { get; init; }
    public string? email { get; init; }
    public string? first_name { get; init; }
    public string? gender { get; init; }
    public List<object?>? groups { get; init; }
    public string? idx { get; init; }
    public string? last_name { get; init; }
    public string? name { get; init; }
    public List<object?>? permissions { get; init; }
    public string? phone_number { get; init; }
    public long? size { get; init; }
    public string? source { get; init; }
}

public record ContactRemoveMatch
{
    public string id { get; init; }
}

public record ContactsField
{
    public string? id { get; init; }
    public string? name { get; init; }
    public string? type { get; init; }
}

public record ContactsFieldListMatch
{
    public string? id { get; init; }
    public string? name { get; init; }
    public string? type { get; init; }
}

public record ContactsFieldCreateData
{
    public string? id { get; init; }
    public string? name { get; init; }
    public string? type { get; init; }
}

public record ContactsFieldUpdateData
{
    public string id { get; init; }
    public string? name { get; init; }
    public string? type { get; init; }
}

public record ContactsFieldRemoveMatch
{
    public string id { get; init; }
}

public record ContactsFieldOption();

public record ContactsFieldOptionListMatch
{
    public string field_id { get; init; }
}

public record Contactsgroup
{
    public string group_id { get; init; }
    public bool read { get; init; }
    public bool send { get; init; }
    public string username { get; init; }
    public bool write { get; init; }
}

public record ContactsgroupListMatch
{
    public Dictionary<string, object?>? name { get; init; }
    public List<object?>? with { get; init; }
}

public record ContactsgroupCreateData
{
    public string group_id { get; init; }
    public bool read { get; init; }
    public bool send { get; init; }
    public string username { get; init; }
    public bool write { get; init; }
}

public record ContactsgroupUpdateData
{
    public string group_id { get; init; }
    public string? username { get; init; }
    public bool? read { get; init; }
    public bool? send { get; init; }
    public bool? write { get; init; }
}

public record ContactsgroupRemoveMatch
{
    public string group_id { get; init; }
}

public record Contactstrash();

public record ContactstrashUpdateData();

public record ContactstrashRemoveMatch();

public record FieldAvailable
{
    public bool? built_in { get; init; }
    public string? id { get; init; }
    public string? name { get; init; }
    public List<object?>? options { get; init; }
    public string? type { get; init; }
}

public record FieldAvailableListMatch
{
    public bool? built_in { get; init; }
    public string? id { get; init; }
    public string? name { get; init; }
    public List<object?>? options { get; init; }
    public string? type { get; init; }
}

public record Group
{
    public long contact_expire_after { get; init; }
    public long contacts_count { get; init; }
    public string created_by { get; init; }
    public string date_created { get; init; }
    public string date_updated { get; init; }
    public string description { get; init; }
    public string id { get; init; }
    public string? idx { get; init; }
    public string name { get; init; }
    public List<object?>? permissions { get; init; }
}

public record GroupLoadMatch
{
    public string id { get; init; }
}

public record GroupUpdateData
{
    public string id { get; init; }
    public long? contact_expire_after { get; init; }
    public long? contacts_count { get; init; }
    public string? created_by { get; init; }
    public string? date_created { get; init; }
    public string? date_updated { get; init; }
    public string? description { get; init; }
    public string? idx { get; init; }
    public string? name { get; init; }
    public List<object?>? permissions { get; init; }
}

public record MfaCode
{
    public string? content { get; init; }
    public object? fast { get; init; }
    public string? from { get; init; }
    public string phone_number { get; init; }
}

public record MfaCodeCreateData
{
    public string? content { get; init; }
    public object? fast { get; init; }
    public string? from { get; init; }
    public string phone_number { get; init; }
}

public record OptOut
{
    public string? date { get; init; }
    public string? id { get; init; }
    public List<object?>? links { get; init; }
    public long? phoneNumber { get; init; }
}

public record OptOutListMatch
{
    public long? limit { get; init; }
    public long? offset { get; init; }
    public string? phone_number { get; init; }
}

public record OptOutRemoveMatch
{
    public string id { get; init; }
}

public record OptOutSetting
{
    public string? brand { get; init; }
}

public record OptOutSettingLoadMatch
{
    public string? brand { get; init; }
}

public record OptOutSettingUpdateData
{
    public string? brand { get; init; }
}

public record Permission
{
    public string group_id { get; init; }
    public string? id { get; init; }
    public bool read { get; init; }
    public bool send { get; init; }
    public string username { get; init; }
    public bool write { get; init; }
}

public record PermissionLoadMatch
{
    public string group_id { get; init; }
    public string id { get; init; }
}

public record PermissionCreateData
{
    public string group_id { get; init; }
    public string? id { get; init; }
    public bool read { get; init; }
    public bool send { get; init; }
    public string username { get; init; }
    public bool write { get; init; }
}

public record Ping
{
    public bool authorized { get; init; }
    public List<object?> unavailable { get; init; }
}

public record PingListMatch
{
    public bool? authorized { get; init; }
    public List<object?>? unavailable { get; init; }
}

public record Profile
{
    public string email { get; init; }
    public string name { get; init; }
    public string payment_type { get; init; }
    public long phone_number { get; init; }
    public double? points { get; init; }
    public string user_type { get; init; }
    public string username { get; init; }
}

public record ProfileLoadMatch
{
    public string? email { get; init; }
    public string? name { get; init; }
    public string? payment_type { get; init; }
    public long? phone_number { get; init; }
    public double? points { get; init; }
    public string? user_type { get; init; }
    public string? username { get; init; }
}

public record ProfileListMatch
{
    public string? type { get; init; }
}

public record Rcs();

public record RcsListMatch();

public record Sendername
{
    public string? created_at { get; init; }
    public string? id { get; init; }
    public bool? is_default { get; init; }
    public string? sender { get; init; }
    public string? status { get; init; }
}

public record SendernameLoadMatch
{
    public string id { get; init; }
}

public record SendernameListMatch
{
    public string? created_at { get; init; }
    public string? id { get; init; }
    public bool? is_default { get; init; }
    public string? sender { get; init; }
    public string? status { get; init; }
}

public record SendernameCreateData
{
    public string? created_at { get; init; }
    public string? id { get; init; }
    public bool? is_default { get; init; }
    public string? sender { get; init; }
    public string? status { get; init; }
}

public record SendernameStatement
{
    public string? content { get; init; }
    public List<object?>? statements { get; init; }
    public string? title { get; init; }
}

public record SendernameStatementListMatch
{
    public string? content { get; init; }
    public List<object?>? statements { get; init; }
    public string? title { get; init; }
}

public record SentRcsMessage
{
    public Dictionary<string, object?>? content { get; init; }
    public string phone_number { get; init; }
    public string sender { get; init; }
    public string? text { get; init; }
}

public record SentRcsMessageCreateData
{
    public Dictionary<string, object?>? content { get; init; }
    public string phone_number { get; init; }
    public string sender { get; init; }
    public string? text { get; init; }
}

public record ShipmentCountryVolume
{
    public string? country_code { get; init; }
    public long? country_limit { get; init; }
    public string? country_name { get; init; }
    public long? usage { get; init; }
}

public record ShipmentCountryVolumeListMatch
{
    public string? month { get; init; }
    public string? year { get; init; }
}

public record ShortUrl
{
    public string? description { get; init; }
    public string? expire { get; init; }
    public string? filename { get; init; }
    public long? hits { get; init; }
    public long? hits_unique { get; init; }
    public string? id { get; init; }
    public string? name { get; init; }
    public string? short_url { get; init; }
    public string? type { get; init; }
    public string? url { get; init; }
}

public record ShortUrlLoadMatch
{
    public string id { get; init; }
}

public record ShortUrlListMatch
{
    public string? description { get; init; }
    public string? expire { get; init; }
    public string? filename { get; init; }
    public long? hits { get; init; }
    public long? hits_unique { get; init; }
    public string? id { get; init; }
    public string? name { get; init; }
    public string? short_url { get; init; }
    public string? type { get; init; }
    public string? url { get; init; }
}

public record ShortUrlCreateData
{
    public string? description { get; init; }
    public string? expire { get; init; }
    public string? filename { get; init; }
    public long? hits { get; init; }
    public long? hits_unique { get; init; }
    public string? id { get; init; }
    public string? name { get; init; }
    public string? short_url { get; init; }
    public string? type { get; init; }
    public string? url { get; init; }
}

public record ShortUrlUpdateData
{
    public string id { get; init; }
    public string? description { get; init; }
    public string? expire { get; init; }
    public string? filename { get; init; }
    public long? hits { get; init; }
    public long? hits_unique { get; init; }
    public string? name { get; init; }
    public string? short_url { get; init; }
    public string? type { get; init; }
    public string? url { get; init; }
}

public record ShortUrlRemoveMatch
{
    public string id { get; init; }
}

public record Smsdo
{
    public long? allow_duplicates { get; init; }
    public object? check_idx { get; init; }
    public object? date { get; init; }
    public long? date_validate { get; init; }
    public object? details { get; init; }
    public string? encoding { get; init; }
    public object? expiration_date { get; init; }
    public List<object?>? fallback { get; init; }
    public long? fast { get; init; }
    public long? flash { get; init; }
    public string? format { get; init; }
    public string? from { get; init; }
    public string? group { get; init; }
    public string? idx { get; init; }
    public long? max_parts { get; init; }
    public string? message { get; init; }
    public long? normalize { get; init; }
    public string? notify_url { get; init; }
    public object? test { get; init; }
    public string? time_restriction { get; init; }
    public string? to { get; init; }
}

public record SmsdoCreateData
{
    public long? allow_duplicates { get; init; }
    public object? check_idx { get; init; }
    public object? date { get; init; }
    public long? date_validate { get; init; }
    public object? details { get; init; }
    public string? encoding { get; init; }
    public object? expiration_date { get; init; }
    public List<object?>? fallback { get; init; }
    public long? fast { get; init; }
    public long? flash { get; init; }
    public string? format { get; init; }
    public string? from { get; init; }
    public string? group { get; init; }
    public string? idx { get; init; }
    public long? max_parts { get; init; }
    public string? message { get; init; }
    public long? normalize { get; init; }
    public string? notify_url { get; init; }
    public object? test { get; init; }
    public string? time_restriction { get; init; }
    public string? to { get; init; }
}

public record Smssendername();

public record SmssendernameCreateData
{
    public string sender { get; init; }
}

public record SmssendernameRemoveMatch
{
    public string sender { get; init; }
}

public record Smstemplate
{
    public string? id { get; init; }
}

public record SmstemplateRemoveMatch
{
    public string id { get; init; }
}

public record Subuser
{
    public bool? active { get; init; }
    public Dictionary<string, object?> credentials { get; init; }
    public string? description { get; init; }
    public string? id { get; init; }
    public Dictionary<string, object?>? points { get; init; }
    public string? username { get; init; }
}

public record SubuserLoadMatch
{
    public string id { get; init; }
}

public record SubuserListMatch
{
    public string? q { get; init; }
}

public record SubuserCreateData
{
    public bool? active { get; init; }
    public Dictionary<string, object?> credentials { get; init; }
    public string? description { get; init; }
    public string? id { get; init; }
    public Dictionary<string, object?>? points { get; init; }
    public string? username { get; init; }
}

public record SubuserUpdateData
{
    public string id { get; init; }
    public bool? active { get; init; }
    public Dictionary<string, object?>? credentials { get; init; }
    public string? description { get; init; }
    public Dictionary<string, object?>? points { get; init; }
    public string? username { get; init; }
}

public record SubuserRemoveMatch
{
    public string id { get; init; }
}

public record Template
{
    public string? id { get; init; }
    public string? name { get; init; }
    public bool? normalize { get; init; }
    public string? template { get; init; }
}

public record TemplateLoadMatch
{
    public string id { get; init; }
}

public record TemplateListMatch
{
    public string? id { get; init; }
    public string? name { get; init; }
    public bool? normalize { get; init; }
    public string? template { get; init; }
}

public record TemplateCreateData
{
    public string? id { get; init; }
    public string? name { get; init; }
    public bool? normalize { get; init; }
    public string? template { get; init; }
}

public record TemplateUpdateData
{
    public string id { get; init; }
    public string? name { get; init; }
    public bool? normalize { get; init; }
    public string? template { get; init; }
}

public record UserRcsSenderCollection();

public record UserRcsSenderCollectionListMatch();

