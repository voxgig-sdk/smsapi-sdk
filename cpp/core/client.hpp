// Smsapi SDK client. All transport and pipeline behaviour lives in the
// SdkClient base (core/types.hpp); this class binds the API-specific entity
// accessors and the test-mode constructor.

#ifndef SDK_CORE_CLIENT_HPP
#define SDK_CORE_CLIENT_HPP

#include <memory>

#include "../core/types.hpp"
#include "../entity/entities.hpp"

namespace sdk {

class SmsapiSDK : public SdkClient {
public:
  explicit SmsapiSDK(Value options = Value::undef()) : SdkClient(options) {}


  // Available entity bound to this client.
  std::shared_ptr<AvailableEntity> available(Value entopts = Value::undef()) {
    return std::make_shared<AvailableEntity>(this, entopts);
  }

  // Blacklist entity bound to this client.
  std::shared_ptr<BlacklistEntity> blacklist(Value entopts = Value::undef()) {
    return std::make_shared<BlacklistEntity>(this, entopts);
  }

  // Callback entity bound to this client.
  std::shared_ptr<CallbackEntity> callback(Value entopts = Value::undef()) {
    return std::make_shared<CallbackEntity>(this, entopts);
  }

  // Contact entity bound to this client.
  std::shared_ptr<ContactEntity> contact(Value entopts = Value::undef()) {
    return std::make_shared<ContactEntity>(this, entopts);
  }

  // ContactsField entity bound to this client.
  std::shared_ptr<ContactsFieldEntity> contacts_field(Value entopts = Value::undef()) {
    return std::make_shared<ContactsFieldEntity>(this, entopts);
  }

  // ContactsFieldOption entity bound to this client.
  std::shared_ptr<ContactsFieldOptionEntity> contacts_field_option(Value entopts = Value::undef()) {
    return std::make_shared<ContactsFieldOptionEntity>(this, entopts);
  }

  // Contactsgroup entity bound to this client.
  std::shared_ptr<ContactsgroupEntity> contactsgroup(Value entopts = Value::undef()) {
    return std::make_shared<ContactsgroupEntity>(this, entopts);
  }

  // Contactstrash entity bound to this client.
  std::shared_ptr<ContactstrashEntity> contactstrash(Value entopts = Value::undef()) {
    return std::make_shared<ContactstrashEntity>(this, entopts);
  }

  // FieldAvailable entity bound to this client.
  std::shared_ptr<FieldAvailableEntity> field_available(Value entopts = Value::undef()) {
    return std::make_shared<FieldAvailableEntity>(this, entopts);
  }

  // Group entity bound to this client.
  std::shared_ptr<GroupEntity> group(Value entopts = Value::undef()) {
    return std::make_shared<GroupEntity>(this, entopts);
  }

  // MfaCode entity bound to this client.
  std::shared_ptr<MfaCodeEntity> mfa_code(Value entopts = Value::undef()) {
    return std::make_shared<MfaCodeEntity>(this, entopts);
  }

  // OptOut entity bound to this client.
  std::shared_ptr<OptOutEntity> opt_out(Value entopts = Value::undef()) {
    return std::make_shared<OptOutEntity>(this, entopts);
  }

  // OptOutSetting entity bound to this client.
  std::shared_ptr<OptOutSettingEntity> opt_out_setting(Value entopts = Value::undef()) {
    return std::make_shared<OptOutSettingEntity>(this, entopts);
  }

  // Permission entity bound to this client.
  std::shared_ptr<PermissionEntity> permission(Value entopts = Value::undef()) {
    return std::make_shared<PermissionEntity>(this, entopts);
  }

  // Ping entity bound to this client.
  std::shared_ptr<PingEntity> ping(Value entopts = Value::undef()) {
    return std::make_shared<PingEntity>(this, entopts);
  }

  // Profile entity bound to this client.
  std::shared_ptr<ProfileEntity> profile(Value entopts = Value::undef()) {
    return std::make_shared<ProfileEntity>(this, entopts);
  }

  // Rcs entity bound to this client.
  std::shared_ptr<RcsEntity> rcs(Value entopts = Value::undef()) {
    return std::make_shared<RcsEntity>(this, entopts);
  }

  // Sendername entity bound to this client.
  std::shared_ptr<SendernameEntity> sendername(Value entopts = Value::undef()) {
    return std::make_shared<SendernameEntity>(this, entopts);
  }

  // SendernameStatement entity bound to this client.
  std::shared_ptr<SendernameStatementEntity> sendername_statement(Value entopts = Value::undef()) {
    return std::make_shared<SendernameStatementEntity>(this, entopts);
  }

  // SentRcsMessage entity bound to this client.
  std::shared_ptr<SentRcsMessageEntity> sent_rcs_message(Value entopts = Value::undef()) {
    return std::make_shared<SentRcsMessageEntity>(this, entopts);
  }

  // ShipmentCountryVolume entity bound to this client.
  std::shared_ptr<ShipmentCountryVolumeEntity> shipment_country_volume(Value entopts = Value::undef()) {
    return std::make_shared<ShipmentCountryVolumeEntity>(this, entopts);
  }

  // ShortUrl entity bound to this client.
  std::shared_ptr<ShortUrlEntity> short_url(Value entopts = Value::undef()) {
    return std::make_shared<ShortUrlEntity>(this, entopts);
  }

  // Smsdo entity bound to this client.
  std::shared_ptr<SmsdoEntity> smsdo(Value entopts = Value::undef()) {
    return std::make_shared<SmsdoEntity>(this, entopts);
  }

  // Smssendername entity bound to this client.
  std::shared_ptr<SmssendernameEntity> smssendername(Value entopts = Value::undef()) {
    return std::make_shared<SmssendernameEntity>(this, entopts);
  }

  // Smstemplate entity bound to this client.
  std::shared_ptr<SmstemplateEntity> smstemplate(Value entopts = Value::undef()) {
    return std::make_shared<SmstemplateEntity>(this, entopts);
  }

  // Subuser entity bound to this client.
  std::shared_ptr<SubuserEntity> subuser(Value entopts = Value::undef()) {
    return std::make_shared<SubuserEntity>(this, entopts);
  }

  // Template entity bound to this client.
  std::shared_ptr<TemplateEntity> template_(Value entopts = Value::undef()) {
    return std::make_shared<TemplateEntity>(this, entopts);
  }

  // UserRcsSenderCollection entity bound to this client.
  std::shared_ptr<UserRcsSenderCollectionEntity> user_rcs_sender_collection(Value entopts = Value::undef()) {
    return std::make_shared<UserRcsSenderCollectionEntity>(this, entopts);
  }


  // testSDK builds a client in test mode: the test feature is activated,
  // installing the in-memory mock transport (no network activity).
  static std::shared_ptr<SmsapiSDK> testSDK() {
    return testSDK(Value::undef(), Value::undef());
  }

  static std::shared_ptr<SmsapiSDK> testSDK(Value testopts, Value sdkopts) {
    auto sdk = std::make_shared<SmsapiSDK>(SdkClient::testOptions(testopts, sdkopts));
    sdk->mode = "test";
    return sdk;
  }

  // Convenience no-arg constructor.
  static std::shared_ptr<SmsapiSDK> create() {
    return std::make_shared<SmsapiSDK>(Value::undef());
  }
};

using SmsapiSDKPtr = std::shared_ptr<SmsapiSDK>;

} // namespace sdk

#endif // SDK_CORE_CLIENT_HPP
