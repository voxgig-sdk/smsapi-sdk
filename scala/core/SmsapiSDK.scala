package voxgig.smsapisdk.core

import java.util.{Map => JMap}

// Smsapi SDK client. All transport and pipeline behaviour lives in the
// SdkClient base (core/SdkClient.scala); this class binds the API-specific
// entity accessors and the test-mode constructor.
class SmsapiSDK(options: JMap[String, Object]) extends SdkClient(options) {

  def this() = this(null)


  /**
   * Returns a available entity bound to this client.
   * Idiomatic usage: client.available(null).list(null, null) or
   * client.available(null).load(java.util.Map.of("id", ...), null).
   */
  def available(entopts: java.util.Map[String, Object]): SdkEntity =
    new voxgig.smsapisdk.entity.AvailableEntity(this, entopts)

  /**
   * Returns a blacklist entity bound to this client.
   * Idiomatic usage: client.blacklist(null).list(null, null) or
   * client.blacklist(null).load(java.util.Map.of("id", ...), null).
   */
  def blacklist(entopts: java.util.Map[String, Object]): SdkEntity =
    new voxgig.smsapisdk.entity.BlacklistEntity(this, entopts)

  /**
   * Returns a callback entity bound to this client.
   * Idiomatic usage: client.callback(null).list(null, null) or
   * client.callback(null).load(java.util.Map.of("id", ...), null).
   */
  def callback(entopts: java.util.Map[String, Object]): SdkEntity =
    new voxgig.smsapisdk.entity.CallbackEntity(this, entopts)

  /**
   * Returns a contact entity bound to this client.
   * Idiomatic usage: client.contact(null).list(null, null) or
   * client.contact(null).load(java.util.Map.of("id", ...), null).
   */
  def contact(entopts: java.util.Map[String, Object]): SdkEntity =
    new voxgig.smsapisdk.entity.ContactEntity(this, entopts)

  /**
   * Returns a contacts_field entity bound to this client.
   * Idiomatic usage: client.contactsField(null).list(null, null) or
   * client.contactsField(null).load(java.util.Map.of("id", ...), null).
   */
  def contactsField(entopts: java.util.Map[String, Object]): SdkEntity =
    new voxgig.smsapisdk.entity.ContactsFieldEntity(this, entopts)

  /**
   * Returns a contacts_field_option entity bound to this client.
   * Idiomatic usage: client.contactsFieldOption(null).list(null, null) or
   * client.contactsFieldOption(null).load(java.util.Map.of("id", ...), null).
   */
  def contactsFieldOption(entopts: java.util.Map[String, Object]): SdkEntity =
    new voxgig.smsapisdk.entity.ContactsFieldOptionEntity(this, entopts)

  /**
   * Returns a contactsgroup entity bound to this client.
   * Idiomatic usage: client.contactsgroup(null).list(null, null) or
   * client.contactsgroup(null).load(java.util.Map.of("id", ...), null).
   */
  def contactsgroup(entopts: java.util.Map[String, Object]): SdkEntity =
    new voxgig.smsapisdk.entity.ContactsgroupEntity(this, entopts)

  /**
   * Returns a contactstrash entity bound to this client.
   * Idiomatic usage: client.contactstrash(null).list(null, null) or
   * client.contactstrash(null).load(java.util.Map.of("id", ...), null).
   */
  def contactstrash(entopts: java.util.Map[String, Object]): SdkEntity =
    new voxgig.smsapisdk.entity.ContactstrashEntity(this, entopts)

  /**
   * Returns a field_available entity bound to this client.
   * Idiomatic usage: client.fieldAvailable(null).list(null, null) or
   * client.fieldAvailable(null).load(java.util.Map.of("id", ...), null).
   */
  def fieldAvailable(entopts: java.util.Map[String, Object]): SdkEntity =
    new voxgig.smsapisdk.entity.FieldAvailableEntity(this, entopts)

  /**
   * Returns a group entity bound to this client.
   * Idiomatic usage: client.group(null).list(null, null) or
   * client.group(null).load(java.util.Map.of("id", ...), null).
   */
  def group(entopts: java.util.Map[String, Object]): SdkEntity =
    new voxgig.smsapisdk.entity.GroupEntity(this, entopts)

  /**
   * Returns a mfa_code entity bound to this client.
   * Idiomatic usage: client.mfaCode(null).list(null, null) or
   * client.mfaCode(null).load(java.util.Map.of("id", ...), null).
   */
  def mfaCode(entopts: java.util.Map[String, Object]): SdkEntity =
    new voxgig.smsapisdk.entity.MfaCodeEntity(this, entopts)

  /**
   * Returns a opt_out entity bound to this client.
   * Idiomatic usage: client.optOut(null).list(null, null) or
   * client.optOut(null).load(java.util.Map.of("id", ...), null).
   */
  def optOut(entopts: java.util.Map[String, Object]): SdkEntity =
    new voxgig.smsapisdk.entity.OptOutEntity(this, entopts)

  /**
   * Returns a opt_out_setting entity bound to this client.
   * Idiomatic usage: client.optOutSetting(null).list(null, null) or
   * client.optOutSetting(null).load(java.util.Map.of("id", ...), null).
   */
  def optOutSetting(entopts: java.util.Map[String, Object]): SdkEntity =
    new voxgig.smsapisdk.entity.OptOutSettingEntity(this, entopts)

  /**
   * Returns a permission entity bound to this client.
   * Idiomatic usage: client.permission(null).list(null, null) or
   * client.permission(null).load(java.util.Map.of("id", ...), null).
   */
  def permission(entopts: java.util.Map[String, Object]): SdkEntity =
    new voxgig.smsapisdk.entity.PermissionEntity(this, entopts)

  /**
   * Returns a ping entity bound to this client.
   * Idiomatic usage: client.ping(null).list(null, null) or
   * client.ping(null).load(java.util.Map.of("id", ...), null).
   */
  def ping(entopts: java.util.Map[String, Object]): SdkEntity =
    new voxgig.smsapisdk.entity.PingEntity(this, entopts)

  /**
   * Returns a profile entity bound to this client.
   * Idiomatic usage: client.profile(null).list(null, null) or
   * client.profile(null).load(java.util.Map.of("id", ...), null).
   */
  def profile(entopts: java.util.Map[String, Object]): SdkEntity =
    new voxgig.smsapisdk.entity.ProfileEntity(this, entopts)

  /**
   * Returns a rcs entity bound to this client.
   * Idiomatic usage: client.rcs(null).list(null, null) or
   * client.rcs(null).load(java.util.Map.of("id", ...), null).
   */
  def rcs(entopts: java.util.Map[String, Object]): SdkEntity =
    new voxgig.smsapisdk.entity.RcsEntity(this, entopts)

  /**
   * Returns a sendername entity bound to this client.
   * Idiomatic usage: client.sendername(null).list(null, null) or
   * client.sendername(null).load(java.util.Map.of("id", ...), null).
   */
  def sendername(entopts: java.util.Map[String, Object]): SdkEntity =
    new voxgig.smsapisdk.entity.SendernameEntity(this, entopts)

  /**
   * Returns a sendername_statement entity bound to this client.
   * Idiomatic usage: client.sendernameStatement(null).list(null, null) or
   * client.sendernameStatement(null).load(java.util.Map.of("id", ...), null).
   */
  def sendernameStatement(entopts: java.util.Map[String, Object]): SdkEntity =
    new voxgig.smsapisdk.entity.SendernameStatementEntity(this, entopts)

  /**
   * Returns a sent_rcs_message entity bound to this client.
   * Idiomatic usage: client.sentRcsMessage(null).list(null, null) or
   * client.sentRcsMessage(null).load(java.util.Map.of("id", ...), null).
   */
  def sentRcsMessage(entopts: java.util.Map[String, Object]): SdkEntity =
    new voxgig.smsapisdk.entity.SentRcsMessageEntity(this, entopts)

  /**
   * Returns a shipment_country_volume entity bound to this client.
   * Idiomatic usage: client.shipmentCountryVolume(null).list(null, null) or
   * client.shipmentCountryVolume(null).load(java.util.Map.of("id", ...), null).
   */
  def shipmentCountryVolume(entopts: java.util.Map[String, Object]): SdkEntity =
    new voxgig.smsapisdk.entity.ShipmentCountryVolumeEntity(this, entopts)

  /**
   * Returns a short_url entity bound to this client.
   * Idiomatic usage: client.shortUrl(null).list(null, null) or
   * client.shortUrl(null).load(java.util.Map.of("id", ...), null).
   */
  def shortUrl(entopts: java.util.Map[String, Object]): SdkEntity =
    new voxgig.smsapisdk.entity.ShortUrlEntity(this, entopts)

  /**
   * Returns a smsdo entity bound to this client.
   * Idiomatic usage: client.smsdo(null).list(null, null) or
   * client.smsdo(null).load(java.util.Map.of("id", ...), null).
   */
  def smsdo(entopts: java.util.Map[String, Object]): SdkEntity =
    new voxgig.smsapisdk.entity.SmsdoEntity(this, entopts)

  /**
   * Returns a smssendername entity bound to this client.
   * Idiomatic usage: client.smssendername(null).list(null, null) or
   * client.smssendername(null).load(java.util.Map.of("id", ...), null).
   */
  def smssendername(entopts: java.util.Map[String, Object]): SdkEntity =
    new voxgig.smsapisdk.entity.SmssendernameEntity(this, entopts)

  /**
   * Returns a smstemplate entity bound to this client.
   * Idiomatic usage: client.smstemplate(null).list(null, null) or
   * client.smstemplate(null).load(java.util.Map.of("id", ...), null).
   */
  def smstemplate(entopts: java.util.Map[String, Object]): SdkEntity =
    new voxgig.smsapisdk.entity.SmstemplateEntity(this, entopts)

  /**
   * Returns a subuser entity bound to this client.
   * Idiomatic usage: client.subuser(null).list(null, null) or
   * client.subuser(null).load(java.util.Map.of("id", ...), null).
   */
  def subuser(entopts: java.util.Map[String, Object]): SdkEntity =
    new voxgig.smsapisdk.entity.SubuserEntity(this, entopts)

  /**
   * Returns a template entity bound to this client.
   * Idiomatic usage: client.template(null).list(null, null) or
   * client.template(null).load(java.util.Map.of("id", ...), null).
   */
  def template(entopts: java.util.Map[String, Object]): SdkEntity =
    new voxgig.smsapisdk.entity.TemplateEntity(this, entopts)

  /**
   * Returns a user_rcs_sender_collection entity bound to this client.
   * Idiomatic usage: client.userRcsSenderCollection(null).list(null, null) or
   * client.userRcsSenderCollection(null).load(java.util.Map.of("id", ...), null).
   */
  def userRcsSenderCollection(entopts: java.util.Map[String, Object]): SdkEntity =
    new voxgig.smsapisdk.entity.UserRcsSenderCollectionEntity(this, entopts)


}

object SmsapiSDK {

  // testSDK builds a client in test mode: the test feature is activated,
  // installing the in-memory mock transport (no network activity).
  def testSDK(): SmsapiSDK = testSDK(null, null)

  def testSDK(testopts: JMap[String, Object], sdkopts: JMap[String, Object]): SmsapiSDK = {
    val sdk = new SmsapiSDK(SdkClient.testOptions(testopts, sdkopts))
    sdk.mode = "test"
    sdk
  }
}
