package voxgig.smsapisdk.core;

import java.util.Map;

/**
 * Smsapi SDK client. All transport and pipeline behaviour lives in
 * the SdkClient base (core/SdkClient.java); this class binds the
 * API-specific entity accessors and the test-mode constructor.
 */
public class SmsapiSDK extends SdkClient {

  public SmsapiSDK() {
    this(null);
  }

  public SmsapiSDK(Map<String, Object> options) {
    super(options);
  }


  /**
   * Returns a available entity bound to this client.
   * Idiomatic usage: client.available(null).list(null, null) or
   * client.available(null).load(Map.of("id", ...), null).
   */
  public SdkEntity available(Map<String, Object> entopts) {
    return new voxgig.smsapisdk.entity.AvailableEntity(this, entopts);
  }

  /**
   * Returns a blacklist entity bound to this client.
   * Idiomatic usage: client.blacklist(null).list(null, null) or
   * client.blacklist(null).load(Map.of("id", ...), null).
   */
  public SdkEntity blacklist(Map<String, Object> entopts) {
    return new voxgig.smsapisdk.entity.BlacklistEntity(this, entopts);
  }

  /**
   * Returns a callback entity bound to this client.
   * Idiomatic usage: client.callback(null).list(null, null) or
   * client.callback(null).load(Map.of("id", ...), null).
   */
  public SdkEntity callback(Map<String, Object> entopts) {
    return new voxgig.smsapisdk.entity.CallbackEntity(this, entopts);
  }

  /**
   * Returns a contact entity bound to this client.
   * Idiomatic usage: client.contact(null).list(null, null) or
   * client.contact(null).load(Map.of("id", ...), null).
   */
  public SdkEntity contact(Map<String, Object> entopts) {
    return new voxgig.smsapisdk.entity.ContactEntity(this, entopts);
  }

  /**
   * Returns a contacts_field entity bound to this client.
   * Idiomatic usage: client.contactsField(null).list(null, null) or
   * client.contactsField(null).load(Map.of("id", ...), null).
   */
  public SdkEntity contactsField(Map<String, Object> entopts) {
    return new voxgig.smsapisdk.entity.ContactsFieldEntity(this, entopts);
  }

  /**
   * Returns a contacts_field_option entity bound to this client.
   * Idiomatic usage: client.contactsFieldOption(null).list(null, null) or
   * client.contactsFieldOption(null).load(Map.of("id", ...), null).
   */
  public SdkEntity contactsFieldOption(Map<String, Object> entopts) {
    return new voxgig.smsapisdk.entity.ContactsFieldOptionEntity(this, entopts);
  }

  /**
   * Returns a contactsgroup entity bound to this client.
   * Idiomatic usage: client.contactsgroup(null).list(null, null) or
   * client.contactsgroup(null).load(Map.of("id", ...), null).
   */
  public SdkEntity contactsgroup(Map<String, Object> entopts) {
    return new voxgig.smsapisdk.entity.ContactsgroupEntity(this, entopts);
  }

  /**
   * Returns a contactstrash entity bound to this client.
   * Idiomatic usage: client.contactstrash(null).list(null, null) or
   * client.contactstrash(null).load(Map.of("id", ...), null).
   */
  public SdkEntity contactstrash(Map<String, Object> entopts) {
    return new voxgig.smsapisdk.entity.ContactstrashEntity(this, entopts);
  }

  /**
   * Returns a field_available entity bound to this client.
   * Idiomatic usage: client.fieldAvailable(null).list(null, null) or
   * client.fieldAvailable(null).load(Map.of("id", ...), null).
   */
  public SdkEntity fieldAvailable(Map<String, Object> entopts) {
    return new voxgig.smsapisdk.entity.FieldAvailableEntity(this, entopts);
  }

  /**
   * Returns a group entity bound to this client.
   * Idiomatic usage: client.group(null).list(null, null) or
   * client.group(null).load(Map.of("id", ...), null).
   */
  public SdkEntity group(Map<String, Object> entopts) {
    return new voxgig.smsapisdk.entity.GroupEntity(this, entopts);
  }

  /**
   * Returns a mfa_code entity bound to this client.
   * Idiomatic usage: client.mfaCode(null).list(null, null) or
   * client.mfaCode(null).load(Map.of("id", ...), null).
   */
  public SdkEntity mfaCode(Map<String, Object> entopts) {
    return new voxgig.smsapisdk.entity.MfaCodeEntity(this, entopts);
  }

  /**
   * Returns a opt_out entity bound to this client.
   * Idiomatic usage: client.optOut(null).list(null, null) or
   * client.optOut(null).load(Map.of("id", ...), null).
   */
  public SdkEntity optOut(Map<String, Object> entopts) {
    return new voxgig.smsapisdk.entity.OptOutEntity(this, entopts);
  }

  /**
   * Returns a opt_out_setting entity bound to this client.
   * Idiomatic usage: client.optOutSetting(null).list(null, null) or
   * client.optOutSetting(null).load(Map.of("id", ...), null).
   */
  public SdkEntity optOutSetting(Map<String, Object> entopts) {
    return new voxgig.smsapisdk.entity.OptOutSettingEntity(this, entopts);
  }

  /**
   * Returns a permission entity bound to this client.
   * Idiomatic usage: client.permission(null).list(null, null) or
   * client.permission(null).load(Map.of("id", ...), null).
   */
  public SdkEntity permission(Map<String, Object> entopts) {
    return new voxgig.smsapisdk.entity.PermissionEntity(this, entopts);
  }

  /**
   * Returns a ping entity bound to this client.
   * Idiomatic usage: client.ping(null).list(null, null) or
   * client.ping(null).load(Map.of("id", ...), null).
   */
  public SdkEntity ping(Map<String, Object> entopts) {
    return new voxgig.smsapisdk.entity.PingEntity(this, entopts);
  }

  /**
   * Returns a profile entity bound to this client.
   * Idiomatic usage: client.profile(null).list(null, null) or
   * client.profile(null).load(Map.of("id", ...), null).
   */
  public SdkEntity profile(Map<String, Object> entopts) {
    return new voxgig.smsapisdk.entity.ProfileEntity(this, entopts);
  }

  /**
   * Returns a rcs entity bound to this client.
   * Idiomatic usage: client.rcs(null).list(null, null) or
   * client.rcs(null).load(Map.of("id", ...), null).
   */
  public SdkEntity rcs(Map<String, Object> entopts) {
    return new voxgig.smsapisdk.entity.RcsEntity(this, entopts);
  }

  /**
   * Returns a sendername entity bound to this client.
   * Idiomatic usage: client.sendername(null).list(null, null) or
   * client.sendername(null).load(Map.of("id", ...), null).
   */
  public SdkEntity sendername(Map<String, Object> entopts) {
    return new voxgig.smsapisdk.entity.SendernameEntity(this, entopts);
  }

  /**
   * Returns a sendername_statement entity bound to this client.
   * Idiomatic usage: client.sendernameStatement(null).list(null, null) or
   * client.sendernameStatement(null).load(Map.of("id", ...), null).
   */
  public SdkEntity sendernameStatement(Map<String, Object> entopts) {
    return new voxgig.smsapisdk.entity.SendernameStatementEntity(this, entopts);
  }

  /**
   * Returns a sent_rcs_message entity bound to this client.
   * Idiomatic usage: client.sentRcsMessage(null).list(null, null) or
   * client.sentRcsMessage(null).load(Map.of("id", ...), null).
   */
  public SdkEntity sentRcsMessage(Map<String, Object> entopts) {
    return new voxgig.smsapisdk.entity.SentRcsMessageEntity(this, entopts);
  }

  /**
   * Returns a shipment_country_volume entity bound to this client.
   * Idiomatic usage: client.shipmentCountryVolume(null).list(null, null) or
   * client.shipmentCountryVolume(null).load(Map.of("id", ...), null).
   */
  public SdkEntity shipmentCountryVolume(Map<String, Object> entopts) {
    return new voxgig.smsapisdk.entity.ShipmentCountryVolumeEntity(this, entopts);
  }

  /**
   * Returns a short_url entity bound to this client.
   * Idiomatic usage: client.shortUrl(null).list(null, null) or
   * client.shortUrl(null).load(Map.of("id", ...), null).
   */
  public SdkEntity shortUrl(Map<String, Object> entopts) {
    return new voxgig.smsapisdk.entity.ShortUrlEntity(this, entopts);
  }

  /**
   * Returns a smsdo entity bound to this client.
   * Idiomatic usage: client.smsdo(null).list(null, null) or
   * client.smsdo(null).load(Map.of("id", ...), null).
   */
  public SdkEntity smsdo(Map<String, Object> entopts) {
    return new voxgig.smsapisdk.entity.SmsdoEntity(this, entopts);
  }

  /**
   * Returns a smssendername entity bound to this client.
   * Idiomatic usage: client.smssendername(null).list(null, null) or
   * client.smssendername(null).load(Map.of("id", ...), null).
   */
  public SdkEntity smssendername(Map<String, Object> entopts) {
    return new voxgig.smsapisdk.entity.SmssendernameEntity(this, entopts);
  }

  /**
   * Returns a smstemplate entity bound to this client.
   * Idiomatic usage: client.smstemplate(null).list(null, null) or
   * client.smstemplate(null).load(Map.of("id", ...), null).
   */
  public SdkEntity smstemplate(Map<String, Object> entopts) {
    return new voxgig.smsapisdk.entity.SmstemplateEntity(this, entopts);
  }

  /**
   * Returns a subuser entity bound to this client.
   * Idiomatic usage: client.subuser(null).list(null, null) or
   * client.subuser(null).load(Map.of("id", ...), null).
   */
  public SdkEntity subuser(Map<String, Object> entopts) {
    return new voxgig.smsapisdk.entity.SubuserEntity(this, entopts);
  }

  /**
   * Returns a template entity bound to this client.
   * Idiomatic usage: client.template(null).list(null, null) or
   * client.template(null).load(Map.of("id", ...), null).
   */
  public SdkEntity template(Map<String, Object> entopts) {
    return new voxgig.smsapisdk.entity.TemplateEntity(this, entopts);
  }

  /**
   * Returns a user_rcs_sender_collection entity bound to this client.
   * Idiomatic usage: client.userRcsSenderCollection(null).list(null, null) or
   * client.userRcsSenderCollection(null).load(Map.of("id", ...), null).
   */
  public SdkEntity userRcsSenderCollection(Map<String, Object> entopts) {
    return new voxgig.smsapisdk.entity.UserRcsSenderCollectionEntity(this, entopts);
  }


  // testSDK builds a client in test mode: the test feature is activated,
  // installing the in-memory mock transport (no network activity).
  public static SmsapiSDK testSDK() {
    return testSDK(null, null);
  }

  public static SmsapiSDK testSDK(
      Map<String, Object> testopts, Map<String, Object> sdkopts) {
    SmsapiSDK sdk = new SmsapiSDK(SdkClient.testOptions(testopts, sdkopts));
    sdk.mode = "test";
    return sdk;
  }
}
