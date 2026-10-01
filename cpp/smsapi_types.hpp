// Typed reference models for the Smsapi SDK (C++).
//
// GENERATED from the API model: main.kit.entity.<e>.fields{} and per-op
// params. The C++ SDK runtime is Value-based, so these structs are
// DOCUMENTATION / convenience types only — the SDK neither includes nor
// requires this header. Array fields surface as std::vector<Value>, object
// fields as std::map<std::string, Value>, and any/null fields as sdk::Value.
// Optional (req:false) members are flagged with a trailing "// optional"
// comment. Do not edit by hand.

#ifndef SDK_SMSAPI_TYPES_HPP
#define SDK_SMSAPI_TYPES_HPP

#include <cstdint>
#include <map>
#include <string>
#include <vector>

#include "core/types.hpp"

namespace sdk {
namespace types {

struct Available {
  std::string name;  // optional
  bool normalize;  // optional
  std::string template;  // optional
};

struct AvailableListMatch {
  std::string name;  // optional
  bool normalize;  // optional
  std::string template;  // optional
};

struct Blacklist {
  std::string id;  // optional
};

struct BlacklistLoadMatch {
  int64_t limit;  // optional
  int64_t offset;  // optional
  int64_t q;  // optional
};

struct BlacklistCreateData {
  std::string id;  // optional
};

struct BlacklistRemoveMatch {
  std::string id;
};

struct Callback {
  bool active;  // optional
  int64_t api_version;  // optional
  std::string id;  // optional
  bool invalid;  // optional
  std::map<std::string, Value> receiver;  // optional
  std::string receiver_type;  // optional
  std::string type;  // optional
  std::string url;  // optional
};

struct CallbackLoadMatch {
  std::string id;
};

struct CallbackListMatch {
  bool active;  // optional
  int64_t api_version;  // optional
  std::string id;  // optional
  bool invalid;  // optional
  std::map<std::string, Value> receiver;  // optional
  std::string receiver_type;  // optional
  std::string type;  // optional
  std::string url;  // optional
};

struct CallbackCreateData {
  bool active;  // optional
  int64_t api_version;  // optional
  std::string id;  // optional
  bool invalid;  // optional
  std::map<std::string, Value> receiver;  // optional
  std::string receiver_type;  // optional
  std::string type;  // optional
  std::string url;  // optional
};

struct CallbackUpdateData {
  std::string id;
  bool active;  // optional
  int64_t api_version;  // optional
  bool invalid;  // optional
  std::map<std::string, Value> receiver;  // optional
  std::string receiver_type;  // optional
  std::string type;  // optional
  std::string url;  // optional
};

struct CallbackRemoveMatch {
  std::string id;
};

struct Contact {
  std::string birthday_date;  // optional
  std::string city;  // optional
  std::vector<Value> collection;
  int64_t contact_expire_after;
  int64_t contacts_count;
  std::string country;  // optional
  std::string created_by;
  std::string date_created;
  std::string date_updated;
  std::string description;  // optional
  std::string email;  // optional
  std::string first_name;  // optional
  std::string gender;
  std::string group_id;  // optional
  std::vector<Value> groups;
  std::string id;
  std::string idx;  // optional
  std::string last_name;  // optional
  std::string name;
  std::vector<Value> permissions;  // optional
  std::string phone_number;  // optional
  bool read;  // optional
  bool send;  // optional
  int64_t size;
  std::string source;  // optional
  std::string type;  // optional
  std::string username;  // optional
  std::string value;  // optional
  bool write;  // optional
};

struct ContactLoadMatch {
  std::string id;
};

struct ContactListMatch {
  std::vector<Value> birthday_date;  // optional
  std::vector<Value> email;  // optional
  std::vector<Value> first_name;  // optional
  std::string gender;  // optional
  std::vector<Value> group_id;  // optional
  std::vector<Value> last_name;  // optional
  int64_t limit;  // optional
  int64_t offset;  // optional
  std::string order_by;  // optional
  std::vector<Value> phone_number;  // optional
  std::string q;  // optional
};

struct ContactCreateData {
  std::string birthday_date;  // optional
  std::string city;  // optional
  std::vector<Value> collection;
  int64_t contact_expire_after;
  int64_t contacts_count;
  std::string country;  // optional
  std::string created_by;
  std::string date_created;
  std::string date_updated;
  std::string description;  // optional
  std::string email;  // optional
  std::string first_name;  // optional
  std::string gender;
  std::string group_id;  // optional
  std::vector<Value> groups;
  std::string id;
  std::string idx;  // optional
  std::string last_name;  // optional
  std::string name;
  std::vector<Value> permissions;  // optional
  std::string phone_number;  // optional
  bool read;  // optional
  bool send;  // optional
  int64_t size;
  std::string source;  // optional
  std::string type;  // optional
  std::string username;  // optional
  std::string value;  // optional
  bool write;  // optional
};

struct ContactUpdateData {
  std::string id;
  std::string birthday_date;  // optional
  std::string city;  // optional
  std::vector<Value> collection;  // optional
  int64_t contact_expire_after;  // optional
  int64_t contacts_count;  // optional
  std::string country;  // optional
  std::string created_by;  // optional
  std::string date_created;  // optional
  std::string date_updated;  // optional
  std::string description;  // optional
  std::string email;  // optional
  std::string first_name;  // optional
  std::string gender;  // optional
  std::string group_id;  // optional
  std::vector<Value> groups;  // optional
  std::string idx;  // optional
  std::string last_name;  // optional
  std::string name;  // optional
  std::vector<Value> permissions;  // optional
  std::string phone_number;  // optional
  bool read;  // optional
  bool send;  // optional
  int64_t size;  // optional
  std::string source;  // optional
  std::string type;  // optional
  std::string username;  // optional
  std::string value;  // optional
  bool write;  // optional
};

struct ContactRemoveMatch {
  std::string id;
};

struct ContactsField {
  std::string birthday_date;  // optional
  std::string city;  // optional
  int64_t contact_expire_after;
  int64_t contacts_count;  // optional
  std::string country;  // optional
  std::string created_by;
  std::string date_created;
  std::string date_updated;
  std::string description;  // optional
  std::string email;  // optional
  std::string first_name;  // optional
  std::string gender;
  std::string group_id;  // optional
  std::vector<Value> groups;
  std::string id;  // optional
  std::string idx;  // optional
  std::string last_name;  // optional
  std::string name;  // optional
  std::vector<Value> permissions;  // optional
  std::string phone_number;  // optional
  bool read;  // optional
  bool send;  // optional
  std::string source;  // optional
  std::string type;  // optional
  std::string username;  // optional
  std::string value;  // optional
  bool write;  // optional
};

struct ContactsFieldListMatch {
  std::string birthday_date;  // optional
  std::string city;  // optional
  int64_t contact_expire_after;  // optional
  int64_t contacts_count;  // optional
  std::string country;  // optional
  std::string created_by;  // optional
  std::string date_created;  // optional
  std::string date_updated;  // optional
  std::string description;  // optional
  std::string email;  // optional
  std::string first_name;  // optional
  std::string gender;  // optional
  std::string group_id;  // optional
  std::vector<Value> groups;  // optional
  std::string id;  // optional
  std::string idx;  // optional
  std::string last_name;  // optional
  std::string name;  // optional
  std::vector<Value> permissions;  // optional
  std::string phone_number;  // optional
  bool read;  // optional
  bool send;  // optional
  std::string source;  // optional
  std::string type;  // optional
  std::string username;  // optional
  std::string value;  // optional
  bool write;  // optional
};

struct ContactsFieldCreateData {
  std::string birthday_date;  // optional
  std::string city;  // optional
  int64_t contact_expire_after;
  int64_t contacts_count;  // optional
  std::string country;  // optional
  std::string created_by;
  std::string date_created;
  std::string date_updated;
  std::string description;  // optional
  std::string email;  // optional
  std::string first_name;  // optional
  std::string gender;
  std::string group_id;  // optional
  std::vector<Value> groups;
  std::string id;  // optional
  std::string idx;  // optional
  std::string last_name;  // optional
  std::string name;  // optional
  std::vector<Value> permissions;  // optional
  std::string phone_number;  // optional
  bool read;  // optional
  bool send;  // optional
  std::string source;  // optional
  std::string type;  // optional
  std::string username;  // optional
  std::string value;  // optional
  bool write;  // optional
};

struct ContactsFieldUpdateData {
  std::string id;
  std::string birthday_date;  // optional
  std::string city;  // optional
  int64_t contact_expire_after;  // optional
  int64_t contacts_count;  // optional
  std::string country;  // optional
  std::string created_by;  // optional
  std::string date_created;  // optional
  std::string date_updated;  // optional
  std::string description;  // optional
  std::string email;  // optional
  std::string first_name;  // optional
  std::string gender;  // optional
  std::string group_id;  // optional
  std::vector<Value> groups;  // optional
  std::string idx;  // optional
  std::string last_name;  // optional
  std::string name;  // optional
  std::vector<Value> permissions;  // optional
  std::string phone_number;  // optional
  bool read;  // optional
  bool send;  // optional
  std::string source;  // optional
  std::string type;  // optional
  std::string username;  // optional
  std::string value;  // optional
  bool write;  // optional
};

struct ContactsFieldRemoveMatch {
  std::string id;
};

struct ContactsFieldOption {
  std::string birthday_date;  // optional
  std::string city;  // optional
  int64_t contact_expire_after;
  int64_t contacts_count;  // optional
  std::string country;  // optional
  std::string created_by;
  std::string date_created;
  std::string date_updated;
  std::string description;  // optional
  std::string email;  // optional
  std::string first_name;  // optional
  std::string gender;
  std::string group_id;  // optional
  std::vector<Value> groups;
  std::string id;
  std::string idx;  // optional
  std::string last_name;  // optional
  std::string name;  // optional
  std::vector<Value> permissions;  // optional
  std::string phone_number;  // optional
  bool read;  // optional
  bool send;  // optional
  std::string source;  // optional
  std::string type;  // optional
  std::string username;  // optional
  std::string value;  // optional
  bool write;  // optional
};

struct ContactsFieldOptionListMatch {
  std::string field_id;
};

struct Contactsgroup {
  std::string birthday_date;  // optional
  std::string city;  // optional
  int64_t contact_expire_after;
  int64_t contacts_count;  // optional
  std::string country;  // optional
  std::string created_by;
  std::string date_created;
  std::string date_updated;
  std::string description;  // optional
  std::string email;  // optional
  std::string first_name;  // optional
  std::string gender;
  std::string group_id;
  std::vector<Value> groups;
  std::string id;
  std::string idx;  // optional
  std::string last_name;  // optional
  std::string name;  // optional
  std::vector<Value> permissions;  // optional
  std::string phone_number;  // optional
  bool read;
  bool send;
  std::string source;  // optional
  std::string type;  // optional
  std::string username;
  std::string value;  // optional
  bool write;
};

struct ContactsgroupListMatch {
  std::map<std::string, Value> name;  // optional
  std::vector<Value> with;  // optional
};

struct ContactsgroupCreateData {
  std::string birthday_date;  // optional
  std::string city;  // optional
  int64_t contact_expire_after;
  int64_t contacts_count;  // optional
  std::string country;  // optional
  std::string created_by;
  std::string date_created;
  std::string date_updated;
  std::string description;  // optional
  std::string email;  // optional
  std::string first_name;  // optional
  std::string gender;
  std::string group_id;
  std::vector<Value> groups;
  std::string id;
  std::string idx;  // optional
  std::string last_name;  // optional
  std::string name;  // optional
  std::vector<Value> permissions;  // optional
  std::string phone_number;  // optional
  bool read;
  bool send;
  std::string source;  // optional
  std::string type;  // optional
  std::string username;
  std::string value;  // optional
  bool write;
};

struct ContactsgroupUpdateData {
  std::string group_id;
  std::string username;  // optional
  std::string birthday_date;  // optional
  std::string city;  // optional
  int64_t contact_expire_after;  // optional
  int64_t contacts_count;  // optional
  std::string country;  // optional
  std::string created_by;  // optional
  std::string date_created;  // optional
  std::string date_updated;  // optional
  std::string description;  // optional
  std::string email;  // optional
  std::string first_name;  // optional
  std::string gender;  // optional
  std::vector<Value> groups;  // optional
  std::string id;  // optional
  std::string idx;  // optional
  std::string last_name;  // optional
  std::string name;  // optional
  std::vector<Value> permissions;  // optional
  std::string phone_number;  // optional
  bool read;  // optional
  bool send;  // optional
  std::string source;  // optional
  std::string type;  // optional
  std::string value;  // optional
  bool write;  // optional
};

struct ContactsgroupRemoveMatch {
  std::string group_id;
};

struct Contactstrash {};

struct ContactstrashUpdateData {};

struct ContactstrashRemoveMatch {};

struct FieldAvailable {
  bool built_in;  // optional
  std::string id;  // optional
  std::string name;  // optional
  std::vector<Value> options;  // optional
  std::string type;  // optional
};

struct FieldAvailableListMatch {
  bool built_in;  // optional
  std::string id;  // optional
  std::string name;  // optional
  std::vector<Value> options;  // optional
  std::string type;  // optional
};

struct Group {
  int64_t contact_expire_after;
  int64_t contacts_count;
  std::string created_by;
  std::string date_created;
  std::string date_updated;
  std::string description;
  std::string id;
  std::string idx;  // optional
  std::string name;
  std::vector<Value> permissions;  // optional
};

struct GroupLoadMatch {
  std::string id;
};

struct GroupUpdateData {
  std::string id;
  int64_t contact_expire_after;  // optional
  int64_t contacts_count;  // optional
  std::string created_by;  // optional
  std::string date_created;  // optional
  std::string date_updated;  // optional
  std::string description;  // optional
  std::string idx;  // optional
  std::string name;  // optional
  std::vector<Value> permissions;  // optional
};

struct MfaCode {
  std::string content;  // optional
  Value fast;  // optional
  std::string from;  // optional
  std::string phone_number;
};

struct MfaCodeCreateData {
  std::string content;  // optional
  Value fast;  // optional
  std::string from;  // optional
  std::string phone_number;
};

struct OptOut {
  std::string date;  // optional
  std::string id;  // optional
  std::vector<Value> links;  // optional
  int64_t phoneNumber;  // optional
};

struct OptOutListMatch {
  int64_t limit;  // optional
  int64_t offset;  // optional
  std::string phone_number;  // optional
};

struct OptOutRemoveMatch {
  std::string id;
};

struct OptOutSetting {
  std::string brand;  // optional
};

struct OptOutSettingLoadMatch {
  std::string brand;  // optional
};

struct OptOutSettingUpdateData {
  std::string brand;  // optional
};

struct Permission {
  std::string group_id;
  std::string id;  // optional
  bool read;
  bool send;
  std::string username;
  bool write;
};

struct PermissionLoadMatch {
  std::string group_id;
  std::string id;
  std::string username;
};

struct PermissionCreateData {
  std::string group_id;
  std::string id;  // optional
  bool read;
  bool send;
  std::string username;
  bool write;
};

struct Ping {
  bool authorized;
  std::vector<Value> unavailable;
};

struct PingListMatch {
  bool authorized;  // optional
  std::vector<Value> unavailable;  // optional
};

struct Profile {
  std::string email;
  std::string name;
  std::string payment_type;
  int64_t phone_number;
  double points;  // optional
  std::string user_type;
  std::string username;
};

struct ProfileLoadMatch {
  std::string email;  // optional
  std::string name;  // optional
  std::string payment_type;  // optional
  int64_t phone_number;  // optional
  double points;  // optional
  std::string user_type;  // optional
  std::string username;  // optional
};

struct ProfileListMatch {
  std::string type;  // optional
};

struct Rcs {};

struct RcsListMatch {};

struct Sendername {
  std::string created_at;  // optional
  std::string id;  // optional
  bool is_default;  // optional
  std::string sender;  // optional
  std::string status;  // optional
};

struct SendernameLoadMatch {
  std::string id;
};

struct SendernameListMatch {
  std::string created_at;  // optional
  std::string id;  // optional
  bool is_default;  // optional
  std::string sender;  // optional
  std::string status;  // optional
};

struct SendernameCreateData {
  std::string created_at;  // optional
  std::string id;  // optional
  bool is_default;  // optional
  std::string sender;  // optional
  std::string status;  // optional
};

struct SendernameStatement {
  std::string content;  // optional
  std::vector<Value> statements;  // optional
  std::string title;  // optional
};

struct SendernameStatementListMatch {
  std::string content;  // optional
  std::vector<Value> statements;  // optional
  std::string title;  // optional
};

struct SentRcsMessage {
  std::map<std::string, Value> content;  // optional
  std::string phone_number;
  Value sender;
  std::string text;  // optional
};

struct SentRcsMessageCreateData {
  std::map<std::string, Value> content;  // optional
  std::string phone_number;
  Value sender;
  std::string text;  // optional
};

struct ShipmentCountryVolume {
  std::string country_code;  // optional
  int64_t country_limit;  // optional
  std::string country_name;  // optional
  int64_t usage;  // optional
};

struct ShipmentCountryVolumeListMatch {
  std::string month;  // optional
  std::string year;  // optional
};

struct ShortUrl {
  std::string description;  // optional
  std::string expire;  // optional
  std::string filename;  // optional
  int64_t hits;  // optional
  int64_t hits_unique;  // optional
  std::string id;  // optional
  std::string name;  // optional
  std::string short_url;  // optional
  std::string type;  // optional
  std::string url;  // optional
};

struct ShortUrlLoadMatch {
  std::string id;
};

struct ShortUrlListMatch {
  std::string description;  // optional
  std::string expire;  // optional
  std::string filename;  // optional
  int64_t hits;  // optional
  int64_t hits_unique;  // optional
  std::string id;  // optional
  std::string name;  // optional
  std::string short_url;  // optional
  std::string type;  // optional
  std::string url;  // optional
};

struct ShortUrlCreateData {
  std::string description;  // optional
  std::string expire;  // optional
  std::string filename;  // optional
  int64_t hits;  // optional
  int64_t hits_unique;  // optional
  std::string id;  // optional
  std::string name;  // optional
  std::string short_url;  // optional
  std::string type;  // optional
  std::string url;  // optional
};

struct ShortUrlUpdateData {
  std::string id;
  std::string description;  // optional
  std::string expire;  // optional
  std::string filename;  // optional
  int64_t hits;  // optional
  int64_t hits_unique;  // optional
  std::string name;  // optional
  std::string short_url;  // optional
  std::string type;  // optional
  std::string url;  // optional
};

struct ShortUrlRemoveMatch {
  std::string id;
};

struct Smsdo {
  int64_t allow_duplicates;  // optional
  Value check_idx;  // optional
  Value date;  // optional
  int64_t date_validate;  // optional
  Value details;  // optional
  std::string encoding;  // optional
  Value expiration_date;  // optional
  std::vector<Value> fallback;  // optional
  int64_t fast;  // optional
  int64_t flash;  // optional
  std::string format;  // optional
  std::string from;  // optional
  std::string group;  // optional
  std::string idx;  // optional
  int64_t max_parts;  // optional
  std::string message;  // optional
  int64_t normalize;  // optional
  std::string notify_url;  // optional
  Value test;  // optional
  std::string time_restriction;  // optional
  std::string to;  // optional
};

struct SmsdoCreateData {
  int64_t allow_duplicates;  // optional
  Value check_idx;  // optional
  Value date;  // optional
  int64_t date_validate;  // optional
  Value details;  // optional
  std::string encoding;  // optional
  Value expiration_date;  // optional
  std::vector<Value> fallback;  // optional
  int64_t fast;  // optional
  int64_t flash;  // optional
  std::string format;  // optional
  std::string from;  // optional
  std::string group;  // optional
  std::string idx;  // optional
  int64_t max_parts;  // optional
  std::string message;  // optional
  int64_t normalize;  // optional
  std::string notify_url;  // optional
  Value test;  // optional
  std::string time_restriction;  // optional
  std::string to;  // optional
};

struct Smssendername {};

struct SmssendernameCreateData {
  std::string sendername_id;
};

struct SmssendernameRemoveMatch {
  std::string sender;
};

struct Smstemplate {
  std::string id;  // optional
};

struct SmstemplateRemoveMatch {
  std::string id;
};

struct Subuser {
  bool active;  // optional
  std::map<std::string, Value> credentials;
  std::string description;  // optional
  std::string id;  // optional
  std::map<std::string, Value> points;  // optional
  std::string username;  // optional
};

struct SubuserLoadMatch {
  std::string id;
};

struct SubuserListMatch {
  std::string q;  // optional
};

struct SubuserCreateData {
  bool active;  // optional
  std::map<std::string, Value> credentials;
  std::string description;  // optional
  std::string id;  // optional
  std::map<std::string, Value> points;  // optional
  std::string username;  // optional
};

struct SubuserUpdateData {
  std::string id;
  bool active;  // optional
  std::map<std::string, Value> credentials;  // optional
  std::string description;  // optional
  std::map<std::string, Value> points;  // optional
  std::string username;  // optional
};

struct SubuserRemoveMatch {
  std::string id;
};

struct Template {
  std::string id;  // optional
  std::string name;  // optional
  bool normalize;  // optional
  std::string template;  // optional
};

struct TemplateLoadMatch {
  std::string id;
};

struct TemplateListMatch {
  std::string id;  // optional
  std::string name;  // optional
  bool normalize;  // optional
  std::string template;  // optional
};

struct TemplateCreateData {
  std::string id;  // optional
  std::string name;  // optional
  bool normalize;  // optional
  std::string template;  // optional
};

struct TemplateUpdateData {
  std::string id;
  std::string name;  // optional
  bool normalize;  // optional
  std::string template;  // optional
};

struct UserRcsSenderCollection {
  std::string deliveredAt;  // optional
  std::string expiredAt;  // optional
  std::string id;  // optional
  std::string interface;  // optional
  std::string messageType;  // optional
  std::string readAt;  // optional
  std::string recipient;  // optional
  std::string sender;  // optional
  std::string senderId;  // optional
  std::string sentAt;  // optional
};

struct UserRcsSenderCollectionListMatch {
  std::string deliveredAt;  // optional
  std::string expiredAt;  // optional
  std::string id;  // optional
  std::string interface;  // optional
  std::string messageType;  // optional
  std::string readAt;  // optional
  std::string recipient;  // optional
  std::string sender;  // optional
  std::string senderId;  // optional
  std::string sentAt;  // optional
};

} // namespace types
} // namespace sdk

#endif // SDK_SMSAPI_TYPES_HPP
