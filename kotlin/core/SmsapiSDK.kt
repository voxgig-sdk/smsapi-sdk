package voxgig.smsapisdk.core

/**
 * Smsapi SDK client. All transport and pipeline behaviour lives in the
 * SdkClient base (core/SdkClient.kt); this class binds the API-specific
 * entity accessors and the test-mode constructor.
 */
class SmsapiSDK(options: MutableMap<String, Any?>?) : SdkClient(options) {

  constructor() : this(null)


  /**
   * Returns a available entity bound to this client.
   * Idiomatic usage: client.available(null).list(null, null) or
   * client.available(null).load(mutableMapOf("id" to ...), null).
   */
  fun available(entopts: MutableMap<String, Any?>?): SdkEntity {
    return voxgig.smsapisdk.entity.AvailableEntity(this, entopts)
  }

  /**
   * Returns a blacklist entity bound to this client.
   * Idiomatic usage: client.blacklist(null).list(null, null) or
   * client.blacklist(null).load(mutableMapOf("id" to ...), null).
   */
  fun blacklist(entopts: MutableMap<String, Any?>?): SdkEntity {
    return voxgig.smsapisdk.entity.BlacklistEntity(this, entopts)
  }

  /**
   * Returns a callback entity bound to this client.
   * Idiomatic usage: client.callback(null).list(null, null) or
   * client.callback(null).load(mutableMapOf("id" to ...), null).
   */
  fun callback(entopts: MutableMap<String, Any?>?): SdkEntity {
    return voxgig.smsapisdk.entity.CallbackEntity(this, entopts)
  }

  /**
   * Returns a contact entity bound to this client.
   * Idiomatic usage: client.contact(null).list(null, null) or
   * client.contact(null).load(mutableMapOf("id" to ...), null).
   */
  fun contact(entopts: MutableMap<String, Any?>?): SdkEntity {
    return voxgig.smsapisdk.entity.ContactEntity(this, entopts)
  }

  /**
   * Returns a contacts_field entity bound to this client.
   * Idiomatic usage: client.contactsField(null).list(null, null) or
   * client.contactsField(null).load(mutableMapOf("id" to ...), null).
   */
  fun contactsField(entopts: MutableMap<String, Any?>?): SdkEntity {
    return voxgig.smsapisdk.entity.ContactsFieldEntity(this, entopts)
  }

  /**
   * Returns a contacts_field_option entity bound to this client.
   * Idiomatic usage: client.contactsFieldOption(null).list(null, null) or
   * client.contactsFieldOption(null).load(mutableMapOf("id" to ...), null).
   */
  fun contactsFieldOption(entopts: MutableMap<String, Any?>?): SdkEntity {
    return voxgig.smsapisdk.entity.ContactsFieldOptionEntity(this, entopts)
  }

  /**
   * Returns a contactsgroup entity bound to this client.
   * Idiomatic usage: client.contactsgroup(null).list(null, null) or
   * client.contactsgroup(null).load(mutableMapOf("id" to ...), null).
   */
  fun contactsgroup(entopts: MutableMap<String, Any?>?): SdkEntity {
    return voxgig.smsapisdk.entity.ContactsgroupEntity(this, entopts)
  }

  /**
   * Returns a contactstrash entity bound to this client.
   * Idiomatic usage: client.contactstrash(null).list(null, null) or
   * client.contactstrash(null).load(mutableMapOf("id" to ...), null).
   */
  fun contactstrash(entopts: MutableMap<String, Any?>?): SdkEntity {
    return voxgig.smsapisdk.entity.ContactstrashEntity(this, entopts)
  }

  /**
   * Returns a field_available entity bound to this client.
   * Idiomatic usage: client.fieldAvailable(null).list(null, null) or
   * client.fieldAvailable(null).load(mutableMapOf("id" to ...), null).
   */
  fun fieldAvailable(entopts: MutableMap<String, Any?>?): SdkEntity {
    return voxgig.smsapisdk.entity.FieldAvailableEntity(this, entopts)
  }

  /**
   * Returns a group entity bound to this client.
   * Idiomatic usage: client.group(null).list(null, null) or
   * client.group(null).load(mutableMapOf("id" to ...), null).
   */
  fun group(entopts: MutableMap<String, Any?>?): SdkEntity {
    return voxgig.smsapisdk.entity.GroupEntity(this, entopts)
  }

  /**
   * Returns a mfa_code entity bound to this client.
   * Idiomatic usage: client.mfaCode(null).list(null, null) or
   * client.mfaCode(null).load(mutableMapOf("id" to ...), null).
   */
  fun mfaCode(entopts: MutableMap<String, Any?>?): SdkEntity {
    return voxgig.smsapisdk.entity.MfaCodeEntity(this, entopts)
  }

  /**
   * Returns a opt_out entity bound to this client.
   * Idiomatic usage: client.optOut(null).list(null, null) or
   * client.optOut(null).load(mutableMapOf("id" to ...), null).
   */
  fun optOut(entopts: MutableMap<String, Any?>?): SdkEntity {
    return voxgig.smsapisdk.entity.OptOutEntity(this, entopts)
  }

  /**
   * Returns a opt_out_setting entity bound to this client.
   * Idiomatic usage: client.optOutSetting(null).list(null, null) or
   * client.optOutSetting(null).load(mutableMapOf("id" to ...), null).
   */
  fun optOutSetting(entopts: MutableMap<String, Any?>?): SdkEntity {
    return voxgig.smsapisdk.entity.OptOutSettingEntity(this, entopts)
  }

  /**
   * Returns a permission entity bound to this client.
   * Idiomatic usage: client.permission(null).list(null, null) or
   * client.permission(null).load(mutableMapOf("id" to ...), null).
   */
  fun permission(entopts: MutableMap<String, Any?>?): SdkEntity {
    return voxgig.smsapisdk.entity.PermissionEntity(this, entopts)
  }

  /**
   * Returns a ping entity bound to this client.
   * Idiomatic usage: client.ping(null).list(null, null) or
   * client.ping(null).load(mutableMapOf("id" to ...), null).
   */
  fun ping(entopts: MutableMap<String, Any?>?): SdkEntity {
    return voxgig.smsapisdk.entity.PingEntity(this, entopts)
  }

  /**
   * Returns a profile entity bound to this client.
   * Idiomatic usage: client.profile(null).list(null, null) or
   * client.profile(null).load(mutableMapOf("id" to ...), null).
   */
  fun profile(entopts: MutableMap<String, Any?>?): SdkEntity {
    return voxgig.smsapisdk.entity.ProfileEntity(this, entopts)
  }

  /**
   * Returns a rcs entity bound to this client.
   * Idiomatic usage: client.rcs(null).list(null, null) or
   * client.rcs(null).load(mutableMapOf("id" to ...), null).
   */
  fun rcs(entopts: MutableMap<String, Any?>?): SdkEntity {
    return voxgig.smsapisdk.entity.RcsEntity(this, entopts)
  }

  /**
   * Returns a sendername entity bound to this client.
   * Idiomatic usage: client.sendername(null).list(null, null) or
   * client.sendername(null).load(mutableMapOf("id" to ...), null).
   */
  fun sendername(entopts: MutableMap<String, Any?>?): SdkEntity {
    return voxgig.smsapisdk.entity.SendernameEntity(this, entopts)
  }

  /**
   * Returns a sendername_statement entity bound to this client.
   * Idiomatic usage: client.sendernameStatement(null).list(null, null) or
   * client.sendernameStatement(null).load(mutableMapOf("id" to ...), null).
   */
  fun sendernameStatement(entopts: MutableMap<String, Any?>?): SdkEntity {
    return voxgig.smsapisdk.entity.SendernameStatementEntity(this, entopts)
  }

  /**
   * Returns a sent_rcs_message entity bound to this client.
   * Idiomatic usage: client.sentRcsMessage(null).list(null, null) or
   * client.sentRcsMessage(null).load(mutableMapOf("id" to ...), null).
   */
  fun sentRcsMessage(entopts: MutableMap<String, Any?>?): SdkEntity {
    return voxgig.smsapisdk.entity.SentRcsMessageEntity(this, entopts)
  }

  /**
   * Returns a shipment_country_volume entity bound to this client.
   * Idiomatic usage: client.shipmentCountryVolume(null).list(null, null) or
   * client.shipmentCountryVolume(null).load(mutableMapOf("id" to ...), null).
   */
  fun shipmentCountryVolume(entopts: MutableMap<String, Any?>?): SdkEntity {
    return voxgig.smsapisdk.entity.ShipmentCountryVolumeEntity(this, entopts)
  }

  /**
   * Returns a short_url entity bound to this client.
   * Idiomatic usage: client.shortUrl(null).list(null, null) or
   * client.shortUrl(null).load(mutableMapOf("id" to ...), null).
   */
  fun shortUrl(entopts: MutableMap<String, Any?>?): SdkEntity {
    return voxgig.smsapisdk.entity.ShortUrlEntity(this, entopts)
  }

  /**
   * Returns a smsdo entity bound to this client.
   * Idiomatic usage: client.smsdo(null).list(null, null) or
   * client.smsdo(null).load(mutableMapOf("id" to ...), null).
   */
  fun smsdo(entopts: MutableMap<String, Any?>?): SdkEntity {
    return voxgig.smsapisdk.entity.SmsdoEntity(this, entopts)
  }

  /**
   * Returns a smssendername entity bound to this client.
   * Idiomatic usage: client.smssendername(null).list(null, null) or
   * client.smssendername(null).load(mutableMapOf("id" to ...), null).
   */
  fun smssendername(entopts: MutableMap<String, Any?>?): SdkEntity {
    return voxgig.smsapisdk.entity.SmssendernameEntity(this, entopts)
  }

  /**
   * Returns a smstemplate entity bound to this client.
   * Idiomatic usage: client.smstemplate(null).list(null, null) or
   * client.smstemplate(null).load(mutableMapOf("id" to ...), null).
   */
  fun smstemplate(entopts: MutableMap<String, Any?>?): SdkEntity {
    return voxgig.smsapisdk.entity.SmstemplateEntity(this, entopts)
  }

  /**
   * Returns a subuser entity bound to this client.
   * Idiomatic usage: client.subuser(null).list(null, null) or
   * client.subuser(null).load(mutableMapOf("id" to ...), null).
   */
  fun subuser(entopts: MutableMap<String, Any?>?): SdkEntity {
    return voxgig.smsapisdk.entity.SubuserEntity(this, entopts)
  }

  /**
   * Returns a template entity bound to this client.
   * Idiomatic usage: client.template(null).list(null, null) or
   * client.template(null).load(mutableMapOf("id" to ...), null).
   */
  fun template(entopts: MutableMap<String, Any?>?): SdkEntity {
    return voxgig.smsapisdk.entity.TemplateEntity(this, entopts)
  }

  /**
   * Returns a user_rcs_sender_collection entity bound to this client.
   * Idiomatic usage: client.userRcsSenderCollection(null).list(null, null) or
   * client.userRcsSenderCollection(null).load(mutableMapOf("id" to ...), null).
   */
  fun userRcsSenderCollection(entopts: MutableMap<String, Any?>?): SdkEntity {
    return voxgig.smsapisdk.entity.UserRcsSenderCollectionEntity(this, entopts)
  }


  companion object {
    // testSDK builds a client in test mode: the test feature is activated,
    // installing the in-memory mock transport (no network activity).
    fun testSDK(): SmsapiSDK = testSDK(null, null)

    fun testSDK(
      testopts: MutableMap<String, Any?>?,
      sdkopts: MutableMap<String, Any?>?,
    ): SmsapiSDK {
      val sdk = SmsapiSDK(testOptions(testopts, sdkopts))
      sdk.mode = "test"
      return sdk
    }
  }
}
