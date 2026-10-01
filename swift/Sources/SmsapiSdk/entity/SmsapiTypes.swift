// Typed models for the Smsapi SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields{} and per-op
// params (op.<name>.points[].g.params[]). Field/param types are mapped
// from the canonical type sentinels. Do not edit by hand.
//
// These are DOCUMENTARY: the SDK runtime is dynamic (ops take/return the
// `Value` enum), so nothing consumes these structs yet — they mirror the
// entity/op shapes for reference and IDE support.

import Foundation

/// Available is the typed data model for the available entity.
public struct Available {
  public var name: String?
  public var normalize: Bool?
  public var template: String?
}

/// AvailableListMatch is the typed request payload for Available.list.
public struct AvailableListMatch {
  public var name: String?
  public var normalize: Bool?
  public var template: String?
}

/// Blacklist is the typed data model for the blacklist entity.
public struct Blacklist {
  public var id: String?
}

/// BlacklistLoadMatch is the typed request payload for Blacklist.load.
public struct BlacklistLoadMatch {
  public var limit: Int?
  public var offset: Int?
  public var q: Int?
}

/// BlacklistCreateData is the typed request payload for Blacklist.create.
public struct BlacklistCreateData {
  public var id: String?
}

/// BlacklistRemoveMatch is the typed request payload for Blacklist.remove.
public struct BlacklistRemoveMatch {
  public var id: String
}

/// Callback is the typed data model for the callback entity.
public struct Callback {
  public var active: Bool?
  public var apiVersion: Int?
  public var id: String?
  public var invalid: Bool?
  public var receiver: VMap?
  public var receiverType: String?
  public var type: String?
  public var url: String?
}

/// CallbackLoadMatch is the typed request payload for Callback.load.
public struct CallbackLoadMatch {
  public var id: String
}

/// CallbackListMatch is the typed request payload for Callback.list.
public struct CallbackListMatch {
  public var active: Bool?
  public var apiVersion: Int?
  public var id: String?
  public var invalid: Bool?
  public var receiver: VMap?
  public var receiverType: String?
  public var type: String?
  public var url: String?
}

/// CallbackCreateData is the typed request payload for Callback.create.
public struct CallbackCreateData {
  public var active: Bool?
  public var apiVersion: Int?
  public var id: String?
  public var invalid: Bool?
  public var receiver: VMap?
  public var receiverType: String?
  public var type: String?
  public var url: String?
}

/// CallbackUpdateData is the typed request payload for Callback.update.
public struct CallbackUpdateData {
  public var id: String
  public var active: Bool?
  public var apiVersion: Int?
  public var invalid: Bool?
  public var receiver: VMap?
  public var receiverType: String?
  public var type: String?
  public var url: String?
}

/// CallbackRemoveMatch is the typed request payload for Callback.remove.
public struct CallbackRemoveMatch {
  public var id: String
}

/// Contact is the typed data model for the contact entity.
public struct Contact {
  public var birthdayDate: String?
  public var city: String?
  public var collection: [Value]
  public var contactExpireAfter: Int
  public var contactsCount: Int
  public var country: String?
  public var createdBy: String
  public var dateCreated: String
  public var dateUpdated: String
  public var description: String?
  public var email: String?
  public var firstName: String?
  public var gender: String
  public var groupId: String?
  public var groups: [Value]
  public var id: String
  public var idx: String?
  public var lastName: String?
  public var name: String
  public var permissions: [Value]?
  public var phoneNumber: String?
  public var read: Bool?
  public var send: Bool?
  public var size: Int
  public var source: String?
  public var type: String?
  public var username: String?
  public var value: String?
  public var write: Bool?
}

/// ContactLoadMatch is the typed request payload for Contact.load.
public struct ContactLoadMatch {
  public var id: String
}

/// ContactListMatch is the typed request payload for Contact.list.
public struct ContactListMatch {
  public var birthdayDate: [Value]?
  public var email: [Value]?
  public var firstName: [Value]?
  public var gender: String?
  public var groupId: [Value]?
  public var lastName: [Value]?
  public var limit: Int?
  public var offset: Int?
  public var orderBy: String?
  public var phoneNumber: [Value]?
  public var q: String?
}

/// ContactCreateData is the typed request payload for Contact.create.
public struct ContactCreateData {
  public var birthdayDate: String?
  public var city: String?
  public var collection: [Value]
  public var contactExpireAfter: Int
  public var contactsCount: Int
  public var country: String?
  public var createdBy: String
  public var dateCreated: String
  public var dateUpdated: String
  public var description: String?
  public var email: String?
  public var firstName: String?
  public var gender: String
  public var groupId: String?
  public var groups: [Value]
  public var id: String
  public var idx: String?
  public var lastName: String?
  public var name: String
  public var permissions: [Value]?
  public var phoneNumber: String?
  public var read: Bool?
  public var send: Bool?
  public var size: Int
  public var source: String?
  public var type: String?
  public var username: String?
  public var value: String?
  public var write: Bool?
}

/// ContactUpdateData is the typed request payload for Contact.update.
public struct ContactUpdateData {
  public var id: String
  public var birthdayDate: String?
  public var city: String?
  public var collection: [Value]?
  public var contactExpireAfter: Int?
  public var contactsCount: Int?
  public var country: String?
  public var createdBy: String?
  public var dateCreated: String?
  public var dateUpdated: String?
  public var description: String?
  public var email: String?
  public var firstName: String?
  public var gender: String?
  public var groupId: String?
  public var groups: [Value]?
  public var idx: String?
  public var lastName: String?
  public var name: String?
  public var permissions: [Value]?
  public var phoneNumber: String?
  public var read: Bool?
  public var send: Bool?
  public var size: Int?
  public var source: String?
  public var type: String?
  public var username: String?
  public var value: String?
  public var write: Bool?
}

/// ContactRemoveMatch is the typed request payload for Contact.remove.
public struct ContactRemoveMatch {
  public var id: String
}

/// ContactsField is the typed data model for the contacts_field entity.
public struct ContactsField {
  public var birthdayDate: String?
  public var city: String?
  public var contactExpireAfter: Int
  public var contactsCount: Int?
  public var country: String?
  public var createdBy: String
  public var dateCreated: String
  public var dateUpdated: String
  public var description: String?
  public var email: String?
  public var firstName: String?
  public var gender: String
  public var groupId: String?
  public var groups: [Value]
  public var id: String?
  public var idx: String?
  public var lastName: String?
  public var name: String?
  public var permissions: [Value]?
  public var phoneNumber: String?
  public var read: Bool?
  public var send: Bool?
  public var source: String?
  public var type: String?
  public var username: String?
  public var value: String?
  public var write: Bool?
}

/// ContactsFieldListMatch is the typed request payload for ContactsField.list.
public struct ContactsFieldListMatch {
  public var birthdayDate: String?
  public var city: String?
  public var contactExpireAfter: Int?
  public var contactsCount: Int?
  public var country: String?
  public var createdBy: String?
  public var dateCreated: String?
  public var dateUpdated: String?
  public var description: String?
  public var email: String?
  public var firstName: String?
  public var gender: String?
  public var groupId: String?
  public var groups: [Value]?
  public var id: String?
  public var idx: String?
  public var lastName: String?
  public var name: String?
  public var permissions: [Value]?
  public var phoneNumber: String?
  public var read: Bool?
  public var send: Bool?
  public var source: String?
  public var type: String?
  public var username: String?
  public var value: String?
  public var write: Bool?
}

/// ContactsFieldCreateData is the typed request payload for ContactsField.create.
public struct ContactsFieldCreateData {
  public var birthdayDate: String?
  public var city: String?
  public var contactExpireAfter: Int
  public var contactsCount: Int?
  public var country: String?
  public var createdBy: String
  public var dateCreated: String
  public var dateUpdated: String
  public var description: String?
  public var email: String?
  public var firstName: String?
  public var gender: String
  public var groupId: String?
  public var groups: [Value]
  public var id: String?
  public var idx: String?
  public var lastName: String?
  public var name: String?
  public var permissions: [Value]?
  public var phoneNumber: String?
  public var read: Bool?
  public var send: Bool?
  public var source: String?
  public var type: String?
  public var username: String?
  public var value: String?
  public var write: Bool?
}

/// ContactsFieldUpdateData is the typed request payload for ContactsField.update.
public struct ContactsFieldUpdateData {
  public var id: String
  public var birthdayDate: String?
  public var city: String?
  public var contactExpireAfter: Int?
  public var contactsCount: Int?
  public var country: String?
  public var createdBy: String?
  public var dateCreated: String?
  public var dateUpdated: String?
  public var description: String?
  public var email: String?
  public var firstName: String?
  public var gender: String?
  public var groupId: String?
  public var groups: [Value]?
  public var idx: String?
  public var lastName: String?
  public var name: String?
  public var permissions: [Value]?
  public var phoneNumber: String?
  public var read: Bool?
  public var send: Bool?
  public var source: String?
  public var type: String?
  public var username: String?
  public var value: String?
  public var write: Bool?
}

/// ContactsFieldRemoveMatch is the typed request payload for ContactsField.remove.
public struct ContactsFieldRemoveMatch {
  public var id: String
}

/// ContactsFieldOption is the typed data model for the contacts_field_option entity.
public struct ContactsFieldOption {
  public var birthdayDate: String?
  public var city: String?
  public var contactExpireAfter: Int
  public var contactsCount: Int?
  public var country: String?
  public var createdBy: String
  public var dateCreated: String
  public var dateUpdated: String
  public var description: String?
  public var email: String?
  public var firstName: String?
  public var gender: String
  public var groupId: String?
  public var groups: [Value]
  public var id: String
  public var idx: String?
  public var lastName: String?
  public var name: String?
  public var permissions: [Value]?
  public var phoneNumber: String?
  public var read: Bool?
  public var send: Bool?
  public var source: String?
  public var type: String?
  public var username: String?
  public var value: String?
  public var write: Bool?
}

/// ContactsFieldOptionListMatch is the typed request payload for ContactsFieldOption.list.
public struct ContactsFieldOptionListMatch {
  public var fieldId: String
}

/// Contactsgroup is the typed data model for the contactsgroup entity.
public struct Contactsgroup {
  public var birthdayDate: String?
  public var city: String?
  public var contactExpireAfter: Int
  public var contactsCount: Int?
  public var country: String?
  public var createdBy: String
  public var dateCreated: String
  public var dateUpdated: String
  public var description: String?
  public var email: String?
  public var firstName: String?
  public var gender: String
  public var groupId: String
  public var groups: [Value]
  public var id: String
  public var idx: String?
  public var lastName: String?
  public var name: String?
  public var permissions: [Value]?
  public var phoneNumber: String?
  public var read: Bool
  public var send: Bool
  public var source: String?
  public var type: String?
  public var username: String
  public var value: String?
  public var write: Bool
}

/// ContactsgroupListMatch is the typed request payload for Contactsgroup.list.
public struct ContactsgroupListMatch {
  public var name: VMap?
  public var with: [Value]?
}

/// ContactsgroupCreateData is the typed request payload for Contactsgroup.create.
public struct ContactsgroupCreateData {
  public var birthdayDate: String?
  public var city: String?
  public var contactExpireAfter: Int
  public var contactsCount: Int?
  public var country: String?
  public var createdBy: String
  public var dateCreated: String
  public var dateUpdated: String
  public var description: String?
  public var email: String?
  public var firstName: String?
  public var gender: String
  public var groupId: String
  public var groups: [Value]
  public var id: String
  public var idx: String?
  public var lastName: String?
  public var name: String?
  public var permissions: [Value]?
  public var phoneNumber: String?
  public var read: Bool
  public var send: Bool
  public var source: String?
  public var type: String?
  public var username: String
  public var value: String?
  public var write: Bool
}

/// ContactsgroupUpdateData is the typed request payload for Contactsgroup.update.
public struct ContactsgroupUpdateData {
  public var groupId: String
  public var username: String?
  public var birthdayDate: String?
  public var city: String?
  public var contactExpireAfter: Int?
  public var contactsCount: Int?
  public var country: String?
  public var createdBy: String?
  public var dateCreated: String?
  public var dateUpdated: String?
  public var description: String?
  public var email: String?
  public var firstName: String?
  public var gender: String?
  public var groups: [Value]?
  public var id: String?
  public var idx: String?
  public var lastName: String?
  public var name: String?
  public var permissions: [Value]?
  public var phoneNumber: String?
  public var read: Bool?
  public var send: Bool?
  public var source: String?
  public var type: String?
  public var value: String?
  public var write: Bool?
}

/// ContactsgroupRemoveMatch is the typed request payload for Contactsgroup.remove.
public struct ContactsgroupRemoveMatch {
  public var groupId: String
}

/// Contactstrash is the typed data model for the contactstrash entity.
public struct Contactstrash {
}

/// ContactstrashUpdateData is the typed request payload for Contactstrash.update.
public struct ContactstrashUpdateData {
}

/// ContactstrashRemoveMatch is the typed request payload for Contactstrash.remove.
public struct ContactstrashRemoveMatch {
}

/// FieldAvailable is the typed data model for the field_available entity.
public struct FieldAvailable {
  public var builtIn: Bool?
  public var id: String?
  public var name: String?
  public var options: [Value]?
  public var type: String?
}

/// FieldAvailableListMatch is the typed request payload for FieldAvailable.list.
public struct FieldAvailableListMatch {
  public var builtIn: Bool?
  public var id: String?
  public var name: String?
  public var options: [Value]?
  public var type: String?
}

/// Group is the typed data model for the group entity.
public struct Group {
  public var contactExpireAfter: Int
  public var contactsCount: Int
  public var createdBy: String
  public var dateCreated: String
  public var dateUpdated: String
  public var description: String
  public var id: String
  public var idx: String?
  public var name: String
  public var permissions: [Value]?
}

/// GroupLoadMatch is the typed request payload for Group.load.
public struct GroupLoadMatch {
  public var id: String
}

/// GroupUpdateData is the typed request payload for Group.update.
public struct GroupUpdateData {
  public var id: String
  public var contactExpireAfter: Int?
  public var contactsCount: Int?
  public var createdBy: String?
  public var dateCreated: String?
  public var dateUpdated: String?
  public var description: String?
  public var idx: String?
  public var name: String?
  public var permissions: [Value]?
}

/// MfaCode is the typed data model for the mfa_code entity.
public struct MfaCode {
  public var content: String?
  public var fast: Value?
  public var from: String?
  public var phoneNumber: String
}

/// MfaCodeCreateData is the typed request payload for MfaCode.create.
public struct MfaCodeCreateData {
  public var content: String?
  public var fast: Value?
  public var from: String?
  public var phoneNumber: String
}

/// OptOut is the typed data model for the opt_out entity.
public struct OptOut {
  public var date: String?
  public var id: String?
  public var links: [Value]?
  public var phoneNumber: Int?
}

/// OptOutListMatch is the typed request payload for OptOut.list.
public struct OptOutListMatch {
  public var limit: Int?
  public var offset: Int?
  public var phoneNumber: String?
}

/// OptOutRemoveMatch is the typed request payload for OptOut.remove.
public struct OptOutRemoveMatch {
  public var id: String
}

/// OptOutSetting is the typed data model for the opt_out_setting entity.
public struct OptOutSetting {
  public var brand: String?
}

/// OptOutSettingLoadMatch is the typed request payload for OptOutSetting.load.
public struct OptOutSettingLoadMatch {
  public var brand: String?
}

/// OptOutSettingUpdateData is the typed request payload for OptOutSetting.update.
public struct OptOutSettingUpdateData {
  public var brand: String?
}

/// Permission is the typed data model for the permission entity.
public struct Permission {
  public var groupId: String
  public var id: String?
  public var read: Bool
  public var send: Bool
  public var username: String
  public var write: Bool
}

/// PermissionLoadMatch is the typed request payload for Permission.load.
public struct PermissionLoadMatch {
  public var groupId: String
  public var id: String
  public var username: String
}

/// PermissionCreateData is the typed request payload for Permission.create.
public struct PermissionCreateData {
  public var groupId: String
  public var id: String?
  public var read: Bool
  public var send: Bool
  public var username: String
  public var write: Bool
}

/// Ping is the typed data model for the ping entity.
public struct Ping {
  public var authorized: Bool
  public var unavailable: [Value]
}

/// PingListMatch is the typed request payload for Ping.list.
public struct PingListMatch {
  public var authorized: Bool?
  public var unavailable: [Value]?
}

/// Profile is the typed data model for the profile entity.
public struct Profile {
  public var email: String
  public var name: String
  public var paymentType: String
  public var phoneNumber: Int
  public var points: Double?
  public var userType: String
  public var username: String
}

/// ProfileLoadMatch is the typed request payload for Profile.load.
public struct ProfileLoadMatch {
  public var email: String?
  public var name: String?
  public var paymentType: String?
  public var phoneNumber: Int?
  public var points: Double?
  public var userType: String?
  public var username: String?
}

/// ProfileListMatch is the typed request payload for Profile.list.
public struct ProfileListMatch {
  public var type: String?
}

/// Rcs is the typed data model for the rcs entity.
public struct Rcs {
}

/// RcsListMatch is the typed request payload for Rcs.list.
public struct RcsListMatch {
}

/// Sendername is the typed data model for the sendername entity.
public struct Sendername {
  public var createdAt: String?
  public var id: String?
  public var isDefault: Bool?
  public var sender: String?
  public var status: String?
}

/// SendernameLoadMatch is the typed request payload for Sendername.load.
public struct SendernameLoadMatch {
  public var id: String
}

/// SendernameListMatch is the typed request payload for Sendername.list.
public struct SendernameListMatch {
  public var createdAt: String?
  public var id: String?
  public var isDefault: Bool?
  public var sender: String?
  public var status: String?
}

/// SendernameCreateData is the typed request payload for Sendername.create.
public struct SendernameCreateData {
  public var createdAt: String?
  public var id: String?
  public var isDefault: Bool?
  public var sender: String?
  public var status: String?
}

/// SendernameStatement is the typed data model for the sendername_statement entity.
public struct SendernameStatement {
  public var content: String?
  public var statements: [Value]?
  public var title: String?
}

/// SendernameStatementListMatch is the typed request payload for SendernameStatement.list.
public struct SendernameStatementListMatch {
  public var content: String?
  public var statements: [Value]?
  public var title: String?
}

/// SentRcsMessage is the typed data model for the sent_rcs_message entity.
public struct SentRcsMessage {
  public var content: VMap?
  public var phoneNumber: String
  public var sender: Value
  public var text: String?
}

/// SentRcsMessageCreateData is the typed request payload for SentRcsMessage.create.
public struct SentRcsMessageCreateData {
  public var content: VMap?
  public var phoneNumber: String
  public var sender: Value
  public var text: String?
}

/// ShipmentCountryVolume is the typed data model for the shipment_country_volume entity.
public struct ShipmentCountryVolume {
  public var countryCode: String?
  public var countryLimit: Int?
  public var countryName: String?
  public var usage: Int?
}

/// ShipmentCountryVolumeListMatch is the typed request payload for ShipmentCountryVolume.list.
public struct ShipmentCountryVolumeListMatch {
  public var month: String?
  public var year: String?
}

/// ShortUrl is the typed data model for the short_url entity.
public struct ShortUrl {
  public var description: String?
  public var expire: String?
  public var filename: String?
  public var hits: Int?
  public var hitsUnique: Int?
  public var id: String?
  public var name: String?
  public var shortUrl: String?
  public var type: String?
  public var url: String?
}

/// ShortUrlLoadMatch is the typed request payload for ShortUrl.load.
public struct ShortUrlLoadMatch {
  public var id: String
}

/// ShortUrlListMatch is the typed request payload for ShortUrl.list.
public struct ShortUrlListMatch {
  public var description: String?
  public var expire: String?
  public var filename: String?
  public var hits: Int?
  public var hitsUnique: Int?
  public var id: String?
  public var name: String?
  public var shortUrl: String?
  public var type: String?
  public var url: String?
}

/// ShortUrlCreateData is the typed request payload for ShortUrl.create.
public struct ShortUrlCreateData {
  public var description: String?
  public var expire: String?
  public var filename: String?
  public var hits: Int?
  public var hitsUnique: Int?
  public var id: String?
  public var name: String?
  public var shortUrl: String?
  public var type: String?
  public var url: String?
}

/// ShortUrlUpdateData is the typed request payload for ShortUrl.update.
public struct ShortUrlUpdateData {
  public var id: String
  public var description: String?
  public var expire: String?
  public var filename: String?
  public var hits: Int?
  public var hitsUnique: Int?
  public var name: String?
  public var shortUrl: String?
  public var type: String?
  public var url: String?
}

/// ShortUrlRemoveMatch is the typed request payload for ShortUrl.remove.
public struct ShortUrlRemoveMatch {
  public var id: String
}

/// Smsdo is the typed data model for the smsdo entity.
public struct Smsdo {
  public var allowDuplicates: Int?
  public var checkIdx: Value?
  public var date: Value?
  public var dateValidate: Int?
  public var details: Value?
  public var encoding: String?
  public var expirationDate: Value?
  public var fallback: [Value]?
  public var fast: Int?
  public var flash: Int?
  public var format: String?
  public var from: String?
  public var group: String?
  public var idx: String?
  public var maxParts: Int?
  public var message: String?
  public var normalize: Int?
  public var notifyUrl: String?
  public var test: Value?
  public var timeRestriction: String?
  public var to: String?
}

/// SmsdoCreateData is the typed request payload for Smsdo.create.
public struct SmsdoCreateData {
  public var allowDuplicates: Int?
  public var checkIdx: Value?
  public var date: Value?
  public var dateValidate: Int?
  public var details: Value?
  public var encoding: String?
  public var expirationDate: Value?
  public var fallback: [Value]?
  public var fast: Int?
  public var flash: Int?
  public var format: String?
  public var from: String?
  public var group: String?
  public var idx: String?
  public var maxParts: Int?
  public var message: String?
  public var normalize: Int?
  public var notifyUrl: String?
  public var test: Value?
  public var timeRestriction: String?
  public var to: String?
}

/// Smssendername is the typed data model for the smssendername entity.
public struct Smssendername {
}

/// SmssendernameCreateData is the typed request payload for Smssendername.create.
public struct SmssendernameCreateData {
  public var sendernameId: String
}

/// SmssendernameRemoveMatch is the typed request payload for Smssendername.remove.
public struct SmssendernameRemoveMatch {
  public var sender: String
}

/// Smstemplate is the typed data model for the smstemplate entity.
public struct Smstemplate {
  public var id: String?
}

/// SmstemplateRemoveMatch is the typed request payload for Smstemplate.remove.
public struct SmstemplateRemoveMatch {
  public var id: String
}

/// Subuser is the typed data model for the subuser entity.
public struct Subuser {
  public var active: Bool?
  public var credentials: VMap
  public var description: String?
  public var id: String?
  public var points: VMap?
  public var username: String?
}

/// SubuserLoadMatch is the typed request payload for Subuser.load.
public struct SubuserLoadMatch {
  public var id: String
}

/// SubuserListMatch is the typed request payload for Subuser.list.
public struct SubuserListMatch {
  public var q: String?
}

/// SubuserCreateData is the typed request payload for Subuser.create.
public struct SubuserCreateData {
  public var active: Bool?
  public var credentials: VMap
  public var description: String?
  public var id: String?
  public var points: VMap?
  public var username: String?
}

/// SubuserUpdateData is the typed request payload for Subuser.update.
public struct SubuserUpdateData {
  public var id: String
  public var active: Bool?
  public var credentials: VMap?
  public var description: String?
  public var points: VMap?
  public var username: String?
}

/// SubuserRemoveMatch is the typed request payload for Subuser.remove.
public struct SubuserRemoveMatch {
  public var id: String
}

/// Template is the typed data model for the template entity.
public struct Template {
  public var id: String?
  public var name: String?
  public var normalize: Bool?
  public var template: String?
}

/// TemplateLoadMatch is the typed request payload for Template.load.
public struct TemplateLoadMatch {
  public var id: String
}

/// TemplateListMatch is the typed request payload for Template.list.
public struct TemplateListMatch {
  public var id: String?
  public var name: String?
  public var normalize: Bool?
  public var template: String?
}

/// TemplateCreateData is the typed request payload for Template.create.
public struct TemplateCreateData {
  public var id: String?
  public var name: String?
  public var normalize: Bool?
  public var template: String?
}

/// TemplateUpdateData is the typed request payload for Template.update.
public struct TemplateUpdateData {
  public var id: String
  public var name: String?
  public var normalize: Bool?
  public var template: String?
}

/// UserRcsSenderCollection is the typed data model for the user_rcs_sender_collection entity.
public struct UserRcsSenderCollection {
  public var deliveredAt: String?
  public var expiredAt: String?
  public var id: String?
  public var interface: String?
  public var messageType: String?
  public var readAt: String?
  public var recipient: String?
  public var sender: String?
  public var senderId: String?
  public var sentAt: String?
}

/// UserRcsSenderCollectionListMatch is the typed request payload for UserRcsSenderCollection.list.
public struct UserRcsSenderCollectionListMatch {
  public var deliveredAt: String?
  public var expiredAt: String?
  public var id: String?
  public var interface: String?
  public var messageType: String?
  public var readAt: String?
  public var recipient: String?
  public var sender: String?
  public var senderId: String?
  public var sentAt: String?
}

