<?php
declare(strict_types=1);

// Typed models for the Smsapi SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields{} and per-op
// params (op.<name>.points[].g.params[]). Field/param types come from the
// canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
// @voxgig/apidef VALID_CANON). Do not edit by hand.
//
// These are documentation-grade value objects (PHP 8 typed properties),
// registered on the composer classmap autoload. The SDK boundary exchanges
// assoc-arrays; these classes name the shapes for tooling and typed callers.

/** Available entity data model. */
class Available
{
    public ?string $name = null;
    public ?bool $normalize = null;
    public ?string $template = null;
}

/** Request payload for Available#list. */
class AvailableListMatch
{
    public ?string $name = null;
    public ?bool $normalize = null;
    public ?string $template = null;
}

/** Blacklist entity data model. */
class Blacklist
{
    public ?string $id = null;
}

/** Request payload for Blacklist#load. */
class BlacklistLoadMatch
{
    public ?int $limit = null;
    public ?int $offset = null;
    public ?int $q = null;
}

/** Request payload for Blacklist#create. */
class BlacklistCreateData
{
    public ?string $id = null;
}

/** Request payload for Blacklist#remove. */
class BlacklistRemoveMatch
{
    public string $id;
}

/** Callback entity data model. */
class Callback
{
    public ?bool $active = null;
    public ?int $api_version = null;
    public ?string $id = null;
    public ?bool $invalid = null;
    public ?array $receiver = null;
    public ?string $receiver_type = null;
    public ?string $type = null;
    public ?string $url = null;
}

/** Request payload for Callback#load. */
class CallbackLoadMatch
{
    public string $id;
}

/** Request payload for Callback#list. */
class CallbackListMatch
{
    public ?bool $active = null;
    public ?int $api_version = null;
    public ?string $id = null;
    public ?bool $invalid = null;
    public ?array $receiver = null;
    public ?string $receiver_type = null;
    public ?string $type = null;
    public ?string $url = null;
}

/** Request payload for Callback#create. */
class CallbackCreateData
{
    public ?bool $active = null;
    public ?int $api_version = null;
    public ?string $id = null;
    public ?bool $invalid = null;
    public ?array $receiver = null;
    public ?string $receiver_type = null;
    public ?string $type = null;
    public ?string $url = null;
}

/** Request payload for Callback#update. */
class CallbackUpdateData
{
    public string $id;
    public ?bool $active = null;
    public ?int $api_version = null;
    public ?bool $invalid = null;
    public ?array $receiver = null;
    public ?string $receiver_type = null;
    public ?string $type = null;
    public ?string $url = null;
}

/** Request payload for Callback#remove. */
class CallbackRemoveMatch
{
    public string $id;
}

/** Contact entity data model. */
class Contact
{
    public ?string $birthday_date = null;
    public ?string $city = null;
    public array $collection;
    public int $contact_expire_after;
    public int $contacts_count;
    public ?string $country = null;
    public string $created_by;
    public string $date_created;
    public string $date_updated;
    public ?string $description = null;
    public ?string $email = null;
    public ?string $first_name = null;
    public string $gender;
    public ?string $group_id = null;
    public array $groups;
    public string $id;
    public ?string $idx = null;
    public ?string $last_name = null;
    public string $name;
    public ?array $permissions = null;
    public ?string $phone_number = null;
    public ?bool $read = null;
    public ?bool $send = null;
    public int $size;
    public ?string $source = null;
    public ?string $type = null;
    public ?string $username = null;
    public ?string $value = null;
    public ?bool $write = null;
}

/** Request payload for Contact#load. */
class ContactLoadMatch
{
    public string $id;
}

/** Request payload for Contact#list. */
class ContactListMatch
{
    public ?array $birthday_date = null;
    public ?array $email = null;
    public ?array $first_name = null;
    public ?string $gender = null;
    public ?array $group_id = null;
    public ?array $last_name = null;
    public ?int $limit = null;
    public ?int $offset = null;
    public ?string $order_by = null;
    public ?array $phone_number = null;
    public ?string $q = null;
}

/** Request payload for Contact#create. */
class ContactCreateData
{
    public ?string $birthday_date = null;
    public ?string $city = null;
    public array $collection;
    public int $contact_expire_after;
    public int $contacts_count;
    public ?string $country = null;
    public string $created_by;
    public string $date_created;
    public string $date_updated;
    public ?string $description = null;
    public ?string $email = null;
    public ?string $first_name = null;
    public string $gender;
    public ?string $group_id = null;
    public array $groups;
    public string $id;
    public ?string $idx = null;
    public ?string $last_name = null;
    public string $name;
    public ?array $permissions = null;
    public ?string $phone_number = null;
    public ?bool $read = null;
    public ?bool $send = null;
    public int $size;
    public ?string $source = null;
    public ?string $type = null;
    public ?string $username = null;
    public ?string $value = null;
    public ?bool $write = null;
}

/** Request payload for Contact#update. */
class ContactUpdateData
{
    public string $id;
    public ?string $birthday_date = null;
    public ?string $city = null;
    public ?array $collection = null;
    public ?int $contact_expire_after = null;
    public ?int $contacts_count = null;
    public ?string $country = null;
    public ?string $created_by = null;
    public ?string $date_created = null;
    public ?string $date_updated = null;
    public ?string $description = null;
    public ?string $email = null;
    public ?string $first_name = null;
    public ?string $gender = null;
    public ?string $group_id = null;
    public ?array $groups = null;
    public ?string $idx = null;
    public ?string $last_name = null;
    public ?string $name = null;
    public ?array $permissions = null;
    public ?string $phone_number = null;
    public ?bool $read = null;
    public ?bool $send = null;
    public ?int $size = null;
    public ?string $source = null;
    public ?string $type = null;
    public ?string $username = null;
    public ?string $value = null;
    public ?bool $write = null;
}

/** Request payload for Contact#remove. */
class ContactRemoveMatch
{
    public string $id;
}

/** ContactsField entity data model. */
class ContactsField
{
    public ?string $birthday_date = null;
    public ?string $city = null;
    public int $contact_expire_after;
    public ?int $contacts_count = null;
    public ?string $country = null;
    public string $created_by;
    public string $date_created;
    public string $date_updated;
    public ?string $description = null;
    public ?string $email = null;
    public ?string $first_name = null;
    public string $gender;
    public ?string $group_id = null;
    public array $groups;
    public ?string $id = null;
    public ?string $idx = null;
    public ?string $last_name = null;
    public ?string $name = null;
    public ?array $permissions = null;
    public ?string $phone_number = null;
    public ?bool $read = null;
    public ?bool $send = null;
    public ?string $source = null;
    public ?string $type = null;
    public ?string $username = null;
    public ?string $value = null;
    public ?bool $write = null;
}

/** Request payload for ContactsField#list. */
class ContactsFieldListMatch
{
    public ?string $birthday_date = null;
    public ?string $city = null;
    public ?int $contact_expire_after = null;
    public ?int $contacts_count = null;
    public ?string $country = null;
    public ?string $created_by = null;
    public ?string $date_created = null;
    public ?string $date_updated = null;
    public ?string $description = null;
    public ?string $email = null;
    public ?string $first_name = null;
    public ?string $gender = null;
    public ?string $group_id = null;
    public ?array $groups = null;
    public ?string $id = null;
    public ?string $idx = null;
    public ?string $last_name = null;
    public ?string $name = null;
    public ?array $permissions = null;
    public ?string $phone_number = null;
    public ?bool $read = null;
    public ?bool $send = null;
    public ?string $source = null;
    public ?string $type = null;
    public ?string $username = null;
    public ?string $value = null;
    public ?bool $write = null;
}

/** Request payload for ContactsField#create. */
class ContactsFieldCreateData
{
    public ?string $birthday_date = null;
    public ?string $city = null;
    public int $contact_expire_after;
    public ?int $contacts_count = null;
    public ?string $country = null;
    public string $created_by;
    public string $date_created;
    public string $date_updated;
    public ?string $description = null;
    public ?string $email = null;
    public ?string $first_name = null;
    public string $gender;
    public ?string $group_id = null;
    public array $groups;
    public ?string $id = null;
    public ?string $idx = null;
    public ?string $last_name = null;
    public ?string $name = null;
    public ?array $permissions = null;
    public ?string $phone_number = null;
    public ?bool $read = null;
    public ?bool $send = null;
    public ?string $source = null;
    public ?string $type = null;
    public ?string $username = null;
    public ?string $value = null;
    public ?bool $write = null;
}

/** Request payload for ContactsField#update. */
class ContactsFieldUpdateData
{
    public string $id;
    public ?string $birthday_date = null;
    public ?string $city = null;
    public ?int $contact_expire_after = null;
    public ?int $contacts_count = null;
    public ?string $country = null;
    public ?string $created_by = null;
    public ?string $date_created = null;
    public ?string $date_updated = null;
    public ?string $description = null;
    public ?string $email = null;
    public ?string $first_name = null;
    public ?string $gender = null;
    public ?string $group_id = null;
    public ?array $groups = null;
    public ?string $idx = null;
    public ?string $last_name = null;
    public ?string $name = null;
    public ?array $permissions = null;
    public ?string $phone_number = null;
    public ?bool $read = null;
    public ?bool $send = null;
    public ?string $source = null;
    public ?string $type = null;
    public ?string $username = null;
    public ?string $value = null;
    public ?bool $write = null;
}

/** Request payload for ContactsField#remove. */
class ContactsFieldRemoveMatch
{
    public string $id;
}

/** ContactsFieldOption entity data model. */
class ContactsFieldOption
{
    public ?string $birthday_date = null;
    public ?string $city = null;
    public int $contact_expire_after;
    public ?int $contacts_count = null;
    public ?string $country = null;
    public string $created_by;
    public string $date_created;
    public string $date_updated;
    public ?string $description = null;
    public ?string $email = null;
    public ?string $first_name = null;
    public string $gender;
    public ?string $group_id = null;
    public array $groups;
    public string $id;
    public ?string $idx = null;
    public ?string $last_name = null;
    public ?string $name = null;
    public ?array $permissions = null;
    public ?string $phone_number = null;
    public ?bool $read = null;
    public ?bool $send = null;
    public ?string $source = null;
    public ?string $type = null;
    public ?string $username = null;
    public ?string $value = null;
    public ?bool $write = null;
}

/** Request payload for ContactsFieldOption#list. */
class ContactsFieldOptionListMatch
{
    public string $field_id;
}

/** Contactsgroup entity data model. */
class Contactsgroup
{
    public ?string $birthday_date = null;
    public ?string $city = null;
    public int $contact_expire_after;
    public ?int $contacts_count = null;
    public ?string $country = null;
    public string $created_by;
    public string $date_created;
    public string $date_updated;
    public ?string $description = null;
    public ?string $email = null;
    public ?string $first_name = null;
    public string $gender;
    public string $group_id;
    public array $groups;
    public string $id;
    public ?string $idx = null;
    public ?string $last_name = null;
    public ?string $name = null;
    public ?array $permissions = null;
    public ?string $phone_number = null;
    public bool $read;
    public bool $send;
    public ?string $source = null;
    public ?string $type = null;
    public string $username;
    public ?string $value = null;
    public bool $write;
}

/** Request payload for Contactsgroup#list. */
class ContactsgroupListMatch
{
    public ?array $name = null;
    public ?array $with = null;
}

/** Request payload for Contactsgroup#create. */
class ContactsgroupCreateData
{
    public ?string $birthday_date = null;
    public ?string $city = null;
    public int $contact_expire_after;
    public ?int $contacts_count = null;
    public ?string $country = null;
    public string $created_by;
    public string $date_created;
    public string $date_updated;
    public ?string $description = null;
    public ?string $email = null;
    public ?string $first_name = null;
    public string $gender;
    public string $group_id;
    public array $groups;
    public string $id;
    public ?string $idx = null;
    public ?string $last_name = null;
    public ?string $name = null;
    public ?array $permissions = null;
    public ?string $phone_number = null;
    public bool $read;
    public bool $send;
    public ?string $source = null;
    public ?string $type = null;
    public string $username;
    public ?string $value = null;
    public bool $write;
}

/** Request payload for Contactsgroup#update. */
class ContactsgroupUpdateData
{
    public string $group_id;
    public ?string $username = null;
    public ?string $birthday_date = null;
    public ?string $city = null;
    public ?int $contact_expire_after = null;
    public ?int $contacts_count = null;
    public ?string $country = null;
    public ?string $created_by = null;
    public ?string $date_created = null;
    public ?string $date_updated = null;
    public ?string $description = null;
    public ?string $email = null;
    public ?string $first_name = null;
    public ?string $gender = null;
    public ?array $groups = null;
    public ?string $id = null;
    public ?string $idx = null;
    public ?string $last_name = null;
    public ?string $name = null;
    public ?array $permissions = null;
    public ?string $phone_number = null;
    public ?bool $read = null;
    public ?bool $send = null;
    public ?string $source = null;
    public ?string $type = null;
    public ?string $value = null;
    public ?bool $write = null;
}

/** Request payload for Contactsgroup#remove. */
class ContactsgroupRemoveMatch
{
    public string $group_id;
}

/** Contactstrash entity data model. */
class Contactstrash
{
}

/** Request payload for Contactstrash#update. */
class ContactstrashUpdateData
{
}

/** Request payload for Contactstrash#remove. */
class ContactstrashRemoveMatch
{
}

/** FieldAvailable entity data model. */
class FieldAvailable
{
    public ?bool $built_in = null;
    public ?string $id = null;
    public ?string $name = null;
    public ?array $options = null;
    public ?string $type = null;
}

/** Request payload for FieldAvailable#list. */
class FieldAvailableListMatch
{
    public ?bool $built_in = null;
    public ?string $id = null;
    public ?string $name = null;
    public ?array $options = null;
    public ?string $type = null;
}

/** Group entity data model. */
class Group
{
    public int $contact_expire_after;
    public int $contacts_count;
    public string $created_by;
    public string $date_created;
    public string $date_updated;
    public string $description;
    public string $id;
    public ?string $idx = null;
    public string $name;
    public ?array $permissions = null;
}

/** Request payload for Group#load. */
class GroupLoadMatch
{
    public string $id;
}

/** Request payload for Group#update. */
class GroupUpdateData
{
    public string $id;
    public ?int $contact_expire_after = null;
    public ?int $contacts_count = null;
    public ?string $created_by = null;
    public ?string $date_created = null;
    public ?string $date_updated = null;
    public ?string $description = null;
    public ?string $idx = null;
    public ?string $name = null;
    public ?array $permissions = null;
}

/** MfaCode entity data model. */
class MfaCode
{
    public ?string $content = null;
    public mixed $fast = null;
    public ?string $from = null;
    public string $phone_number;
}

/** Request payload for MfaCode#create. */
class MfaCodeCreateData
{
    public ?string $content = null;
    public mixed $fast = null;
    public ?string $from = null;
    public string $phone_number;
}

/** OptOut entity data model. */
class OptOut
{
    public ?string $date = null;
    public ?string $id = null;
    public ?array $links = null;
    public ?int $phoneNumber = null;
}

/** Request payload for OptOut#list. */
class OptOutListMatch
{
    public ?int $limit = null;
    public ?int $offset = null;
    public ?string $phone_number = null;
}

/** Request payload for OptOut#remove. */
class OptOutRemoveMatch
{
    public string $id;
}

/** OptOutSetting entity data model. */
class OptOutSetting
{
    public ?string $brand = null;
}

/** Request payload for OptOutSetting#load. */
class OptOutSettingLoadMatch
{
    public ?string $brand = null;
}

/** Request payload for OptOutSetting#update. */
class OptOutSettingUpdateData
{
    public ?string $brand = null;
}

/** Permission entity data model. */
class Permission
{
    public string $group_id;
    public ?string $id = null;
    public bool $read;
    public bool $send;
    public string $username;
    public bool $write;
}

/** Request payload for Permission#load. */
class PermissionLoadMatch
{
    public string $group_id;
    public string $id;
    public string $username;
}

/** Request payload for Permission#create. */
class PermissionCreateData
{
    public string $group_id;
    public ?string $id = null;
    public bool $read;
    public bool $send;
    public string $username;
    public bool $write;
}

/** Ping entity data model. */
class Ping
{
    public bool $authorized;
    public array $unavailable;
}

/** Request payload for Ping#list. */
class PingListMatch
{
    public ?bool $authorized = null;
    public ?array $unavailable = null;
}

/** Profile entity data model. */
class Profile
{
    public string $email;
    public string $name;
    public string $payment_type;
    public int $phone_number;
    public ?float $points = null;
    public string $user_type;
    public string $username;
}

/** Request payload for Profile#load. */
class ProfileLoadMatch
{
    public ?string $email = null;
    public ?string $name = null;
    public ?string $payment_type = null;
    public ?int $phone_number = null;
    public ?float $points = null;
    public ?string $user_type = null;
    public ?string $username = null;
}

/** Request payload for Profile#list. */
class ProfileListMatch
{
    public ?string $type = null;
}

/** Rcs entity data model. */
class Rcs
{
}

/** Request payload for Rcs#list. */
class RcsListMatch
{
}

/** Sendername entity data model. */
class Sendername
{
    public ?string $created_at = null;
    public ?string $id = null;
    public ?bool $is_default = null;
    public ?string $sender = null;
    public ?string $status = null;
}

/** Request payload for Sendername#load. */
class SendernameLoadMatch
{
    public string $id;
}

/** Request payload for Sendername#list. */
class SendernameListMatch
{
    public ?string $created_at = null;
    public ?string $id = null;
    public ?bool $is_default = null;
    public ?string $sender = null;
    public ?string $status = null;
}

/** Request payload for Sendername#create. */
class SendernameCreateData
{
    public ?string $created_at = null;
    public ?string $id = null;
    public ?bool $is_default = null;
    public ?string $sender = null;
    public ?string $status = null;
}

/** SendernameStatement entity data model. */
class SendernameStatement
{
    public ?string $content = null;
    public ?array $statements = null;
    public ?string $title = null;
}

/** Request payload for SendernameStatement#list. */
class SendernameStatementListMatch
{
    public ?string $content = null;
    public ?array $statements = null;
    public ?string $title = null;
}

/** SentRcsMessage entity data model. */
class SentRcsMessage
{
    public ?array $content = null;
    public string $phone_number;
    public mixed $sender;
    public ?string $text = null;
}

/** Request payload for SentRcsMessage#create. */
class SentRcsMessageCreateData
{
    public ?array $content = null;
    public string $phone_number;
    public mixed $sender;
    public ?string $text = null;
}

/** ShipmentCountryVolume entity data model. */
class ShipmentCountryVolume
{
    public ?string $country_code = null;
    public ?int $country_limit = null;
    public ?string $country_name = null;
    public ?int $usage = null;
}

/** Request payload for ShipmentCountryVolume#list. */
class ShipmentCountryVolumeListMatch
{
    public ?string $month = null;
    public ?string $year = null;
}

/** ShortUrl entity data model. */
class ShortUrl
{
    public ?string $description = null;
    public ?string $expire = null;
    public ?string $filename = null;
    public ?int $hits = null;
    public ?int $hits_unique = null;
    public ?string $id = null;
    public ?string $name = null;
    public ?string $short_url = null;
    public ?string $type = null;
    public ?string $url = null;
}

/** Request payload for ShortUrl#load. */
class ShortUrlLoadMatch
{
    public string $id;
}

/** Request payload for ShortUrl#list. */
class ShortUrlListMatch
{
    public ?string $description = null;
    public ?string $expire = null;
    public ?string $filename = null;
    public ?int $hits = null;
    public ?int $hits_unique = null;
    public ?string $id = null;
    public ?string $name = null;
    public ?string $short_url = null;
    public ?string $type = null;
    public ?string $url = null;
}

/** Request payload for ShortUrl#create. */
class ShortUrlCreateData
{
    public ?string $description = null;
    public ?string $expire = null;
    public ?string $filename = null;
    public ?int $hits = null;
    public ?int $hits_unique = null;
    public ?string $id = null;
    public ?string $name = null;
    public ?string $short_url = null;
    public ?string $type = null;
    public ?string $url = null;
}

/** Request payload for ShortUrl#update. */
class ShortUrlUpdateData
{
    public string $id;
    public ?string $description = null;
    public ?string $expire = null;
    public ?string $filename = null;
    public ?int $hits = null;
    public ?int $hits_unique = null;
    public ?string $name = null;
    public ?string $short_url = null;
    public ?string $type = null;
    public ?string $url = null;
}

/** Request payload for ShortUrl#remove. */
class ShortUrlRemoveMatch
{
    public string $id;
}

/** Smsdo entity data model. */
class Smsdo
{
    public ?int $allow_duplicates = null;
    public mixed $check_idx = null;
    public mixed $date = null;
    public ?int $date_validate = null;
    public mixed $details = null;
    public ?string $encoding = null;
    public mixed $expiration_date = null;
    public ?array $fallback = null;
    public ?int $fast = null;
    public ?int $flash = null;
    public ?string $format = null;
    public ?string $from = null;
    public ?string $group = null;
    public ?string $idx = null;
    public ?int $max_parts = null;
    public ?string $message = null;
    public ?int $normalize = null;
    public ?string $notify_url = null;
    public mixed $test = null;
    public ?string $time_restriction = null;
    public ?string $to = null;
}

/** Request payload for Smsdo#create. */
class SmsdoCreateData
{
    public ?int $allow_duplicates = null;
    public mixed $check_idx = null;
    public mixed $date = null;
    public ?int $date_validate = null;
    public mixed $details = null;
    public ?string $encoding = null;
    public mixed $expiration_date = null;
    public ?array $fallback = null;
    public ?int $fast = null;
    public ?int $flash = null;
    public ?string $format = null;
    public ?string $from = null;
    public ?string $group = null;
    public ?string $idx = null;
    public ?int $max_parts = null;
    public ?string $message = null;
    public ?int $normalize = null;
    public ?string $notify_url = null;
    public mixed $test = null;
    public ?string $time_restriction = null;
    public ?string $to = null;
}

/** Smssendername entity data model. */
class Smssendername
{
}

/** Request payload for Smssendername#create. */
class SmssendernameCreateData
{
    public string $sendername_id;
}

/** Request payload for Smssendername#remove. */
class SmssendernameRemoveMatch
{
    public string $sender;
}

/** Smstemplate entity data model. */
class Smstemplate
{
    public ?string $id = null;
}

/** Request payload for Smstemplate#remove. */
class SmstemplateRemoveMatch
{
    public string $id;
}

/** Subuser entity data model. */
class Subuser
{
    public ?bool $active = null;
    public array $credentials;
    public ?string $description = null;
    public ?string $id = null;
    public ?array $points = null;
    public ?string $username = null;
}

/** Request payload for Subuser#load. */
class SubuserLoadMatch
{
    public string $id;
}

/** Request payload for Subuser#list. */
class SubuserListMatch
{
    public ?string $q = null;
}

/** Request payload for Subuser#create. */
class SubuserCreateData
{
    public ?bool $active = null;
    public array $credentials;
    public ?string $description = null;
    public ?string $id = null;
    public ?array $points = null;
    public ?string $username = null;
}

/** Request payload for Subuser#update. */
class SubuserUpdateData
{
    public string $id;
    public ?bool $active = null;
    public ?array $credentials = null;
    public ?string $description = null;
    public ?array $points = null;
    public ?string $username = null;
}

/** Request payload for Subuser#remove. */
class SubuserRemoveMatch
{
    public string $id;
}

/** Template entity data model. */
class Template
{
    public ?string $id = null;
    public ?string $name = null;
    public ?bool $normalize = null;
    public ?string $template = null;
}

/** Request payload for Template#load. */
class TemplateLoadMatch
{
    public string $id;
}

/** Request payload for Template#list. */
class TemplateListMatch
{
    public ?string $id = null;
    public ?string $name = null;
    public ?bool $normalize = null;
    public ?string $template = null;
}

/** Request payload for Template#create. */
class TemplateCreateData
{
    public ?string $id = null;
    public ?string $name = null;
    public ?bool $normalize = null;
    public ?string $template = null;
}

/** Request payload for Template#update. */
class TemplateUpdateData
{
    public string $id;
    public ?string $name = null;
    public ?bool $normalize = null;
    public ?string $template = null;
}

/** UserRcsSenderCollection entity data model. */
class UserRcsSenderCollection
{
    public ?string $deliveredAt = null;
    public ?string $expiredAt = null;
    public ?string $id = null;
    public ?string $interface = null;
    public ?string $messageType = null;
    public ?string $readAt = null;
    public ?string $recipient = null;
    public ?string $sender = null;
    public ?string $senderId = null;
    public ?string $sentAt = null;
}

/** Request payload for UserRcsSenderCollection#list. */
class UserRcsSenderCollectionListMatch
{
    public ?string $deliveredAt = null;
    public ?string $expiredAt = null;
    public ?string $id = null;
    public ?string $interface = null;
    public ?string $messageType = null;
    public ?string $readAt = null;
    public ?string $recipient = null;
    public ?string $sender = null;
    public ?string $senderId = null;
    public ?string $sentAt = null;
}

