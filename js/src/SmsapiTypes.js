// Typed models for the Smsapi SDK (JSDoc typedefs).
//
// GENERATED from the API model: main.kit.entity.<e>.fields{} and per-op
// params (op.<name>.points[].g.params[]). Field/param types come from the
// canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
// @voxgig/apidef VALID_CANON). Annotations only — no runtime effect. Do not
// edit by hand.

/**
 * @typedef {Object} Available
 * @property {string} [name]
 * @property {boolean} [normalize]
 * @property {string} [template]
 */

/**
 * @typedef {Object} AvailableListMatch
 * @property {string} [name]
 * @property {boolean} [normalize]
 * @property {string} [template]
 */

/**
 * @typedef {Object} Blacklist
 * @property {string} [id]
 */

/**
 * @typedef {Object} BlacklistLoadMatch
 * @property {number} [limit]
 * @property {number} [offset]
 * @property {number} [q]
 */

/**
 * @typedef {Object} BlacklistCreateData
 * @property {string} [id]
 */

/**
 * @typedef {Object} BlacklistRemoveMatch
 * @property {string} id
 */

/**
 * @typedef {Object} Callback
 * @property {boolean} [active]
 * @property {number} [api_version]
 * @property {string} [id]
 * @property {boolean} [invalid]
 * @property {Object} [receiver]
 * @property {string} [receiver_type]
 * @property {string} [type]
 * @property {string} [url]
 */

/**
 * @typedef {Object} CallbackLoadMatch
 * @property {string} id
 */

/**
 * @typedef {Object} CallbackListMatch
 * @property {boolean} [active]
 * @property {number} [api_version]
 * @property {string} [id]
 * @property {boolean} [invalid]
 * @property {Object} [receiver]
 * @property {string} [receiver_type]
 * @property {string} [type]
 * @property {string} [url]
 */

/**
 * @typedef {Object} CallbackCreateData
 * @property {boolean} [active]
 * @property {number} [api_version]
 * @property {string} [id]
 * @property {boolean} [invalid]
 * @property {Object} [receiver]
 * @property {string} [receiver_type]
 * @property {string} [type]
 * @property {string} [url]
 */

/**
 * @typedef {Object} CallbackUpdateData
 * @property {string} id
 * @property {boolean} [active]
 * @property {number} [api_version]
 * @property {boolean} [invalid]
 * @property {Object} [receiver]
 * @property {string} [receiver_type]
 * @property {string} [type]
 * @property {string} [url]
 */

/**
 * @typedef {Object} CallbackRemoveMatch
 * @property {string} id
 */

/**
 * @typedef {Object} Contact
 * @property {string} [birthday_date]
 * @property {string} [city]
 * @property {Array} collection
 * @property {number} contact_expire_after
 * @property {number} contacts_count
 * @property {string} [country]
 * @property {string} created_by
 * @property {string} date_created
 * @property {string} date_updated
 * @property {string} [description]
 * @property {string} [email]
 * @property {string} [first_name]
 * @property {string} gender
 * @property {string} [group_id]
 * @property {Array} groups
 * @property {string} id
 * @property {string} [idx]
 * @property {string} [last_name]
 * @property {string} name
 * @property {Array} [permissions]
 * @property {string} [phone_number]
 * @property {boolean} [read]
 * @property {boolean} [send]
 * @property {number} size
 * @property {string} [source]
 * @property {string} [type]
 * @property {string} [username]
 * @property {string} [value]
 * @property {boolean} [write]
 */

/**
 * @typedef {Object} ContactLoadMatch
 * @property {string} id
 */

/**
 * @typedef {Object} ContactListMatch
 * @property {Array} [birthday_date]
 * @property {Array} [email]
 * @property {Array} [first_name]
 * @property {string} [gender]
 * @property {Array} [group_id]
 * @property {Array} [last_name]
 * @property {number} [limit]
 * @property {number} [offset]
 * @property {string} [order_by]
 * @property {Array} [phone_number]
 * @property {string} [q]
 */

/**
 * @typedef {Object} ContactCreateData
 * @property {string} [birthday_date]
 * @property {string} [city]
 * @property {Array} collection
 * @property {number} contact_expire_after
 * @property {number} contacts_count
 * @property {string} [country]
 * @property {string} created_by
 * @property {string} date_created
 * @property {string} date_updated
 * @property {string} [description]
 * @property {string} [email]
 * @property {string} [first_name]
 * @property {string} gender
 * @property {string} [group_id]
 * @property {Array} groups
 * @property {string} id
 * @property {string} [idx]
 * @property {string} [last_name]
 * @property {string} name
 * @property {Array} [permissions]
 * @property {string} [phone_number]
 * @property {boolean} [read]
 * @property {boolean} [send]
 * @property {number} size
 * @property {string} [source]
 * @property {string} [type]
 * @property {string} [username]
 * @property {string} [value]
 * @property {boolean} [write]
 */

/**
 * @typedef {Object} ContactUpdateData
 * @property {string} id
 * @property {string} [birthday_date]
 * @property {string} [city]
 * @property {Array} [collection]
 * @property {number} [contact_expire_after]
 * @property {number} [contacts_count]
 * @property {string} [country]
 * @property {string} [created_by]
 * @property {string} [date_created]
 * @property {string} [date_updated]
 * @property {string} [description]
 * @property {string} [email]
 * @property {string} [first_name]
 * @property {string} [gender]
 * @property {string} [group_id]
 * @property {Array} [groups]
 * @property {string} [idx]
 * @property {string} [last_name]
 * @property {string} [name]
 * @property {Array} [permissions]
 * @property {string} [phone_number]
 * @property {boolean} [read]
 * @property {boolean} [send]
 * @property {number} [size]
 * @property {string} [source]
 * @property {string} [type]
 * @property {string} [username]
 * @property {string} [value]
 * @property {boolean} [write]
 */

/**
 * @typedef {Object} ContactRemoveMatch
 * @property {string} id
 */

/**
 * @typedef {Object} ContactsField
 * @property {string} [birthday_date]
 * @property {string} [city]
 * @property {number} contact_expire_after
 * @property {number} [contacts_count]
 * @property {string} [country]
 * @property {string} created_by
 * @property {string} date_created
 * @property {string} date_updated
 * @property {string} [description]
 * @property {string} [email]
 * @property {string} [first_name]
 * @property {string} gender
 * @property {string} [group_id]
 * @property {Array} groups
 * @property {string} [id]
 * @property {string} [idx]
 * @property {string} [last_name]
 * @property {string} [name]
 * @property {Array} [permissions]
 * @property {string} [phone_number]
 * @property {boolean} [read]
 * @property {boolean} [send]
 * @property {string} [source]
 * @property {string} [type]
 * @property {string} [username]
 * @property {string} [value]
 * @property {boolean} [write]
 */

/**
 * @typedef {Object} ContactsFieldListMatch
 * @property {string} [birthday_date]
 * @property {string} [city]
 * @property {number} [contact_expire_after]
 * @property {number} [contacts_count]
 * @property {string} [country]
 * @property {string} [created_by]
 * @property {string} [date_created]
 * @property {string} [date_updated]
 * @property {string} [description]
 * @property {string} [email]
 * @property {string} [first_name]
 * @property {string} [gender]
 * @property {string} [group_id]
 * @property {Array} [groups]
 * @property {string} [id]
 * @property {string} [idx]
 * @property {string} [last_name]
 * @property {string} [name]
 * @property {Array} [permissions]
 * @property {string} [phone_number]
 * @property {boolean} [read]
 * @property {boolean} [send]
 * @property {string} [source]
 * @property {string} [type]
 * @property {string} [username]
 * @property {string} [value]
 * @property {boolean} [write]
 */

/**
 * @typedef {Object} ContactsFieldCreateData
 * @property {string} [birthday_date]
 * @property {string} [city]
 * @property {number} contact_expire_after
 * @property {number} [contacts_count]
 * @property {string} [country]
 * @property {string} created_by
 * @property {string} date_created
 * @property {string} date_updated
 * @property {string} [description]
 * @property {string} [email]
 * @property {string} [first_name]
 * @property {string} gender
 * @property {string} [group_id]
 * @property {Array} groups
 * @property {string} [id]
 * @property {string} [idx]
 * @property {string} [last_name]
 * @property {string} [name]
 * @property {Array} [permissions]
 * @property {string} [phone_number]
 * @property {boolean} [read]
 * @property {boolean} [send]
 * @property {string} [source]
 * @property {string} [type]
 * @property {string} [username]
 * @property {string} [value]
 * @property {boolean} [write]
 */

/**
 * @typedef {Object} ContactsFieldUpdateData
 * @property {string} id
 * @property {string} [birthday_date]
 * @property {string} [city]
 * @property {number} [contact_expire_after]
 * @property {number} [contacts_count]
 * @property {string} [country]
 * @property {string} [created_by]
 * @property {string} [date_created]
 * @property {string} [date_updated]
 * @property {string} [description]
 * @property {string} [email]
 * @property {string} [first_name]
 * @property {string} [gender]
 * @property {string} [group_id]
 * @property {Array} [groups]
 * @property {string} [idx]
 * @property {string} [last_name]
 * @property {string} [name]
 * @property {Array} [permissions]
 * @property {string} [phone_number]
 * @property {boolean} [read]
 * @property {boolean} [send]
 * @property {string} [source]
 * @property {string} [type]
 * @property {string} [username]
 * @property {string} [value]
 * @property {boolean} [write]
 */

/**
 * @typedef {Object} ContactsFieldRemoveMatch
 * @property {string} id
 */

/**
 * @typedef {Object} ContactsFieldOption
 * @property {string} [birthday_date]
 * @property {string} [city]
 * @property {number} contact_expire_after
 * @property {number} [contacts_count]
 * @property {string} [country]
 * @property {string} created_by
 * @property {string} date_created
 * @property {string} date_updated
 * @property {string} [description]
 * @property {string} [email]
 * @property {string} [first_name]
 * @property {string} gender
 * @property {string} [group_id]
 * @property {Array} groups
 * @property {string} id
 * @property {string} [idx]
 * @property {string} [last_name]
 * @property {string} [name]
 * @property {Array} [permissions]
 * @property {string} [phone_number]
 * @property {boolean} [read]
 * @property {boolean} [send]
 * @property {string} [source]
 * @property {string} [type]
 * @property {string} [username]
 * @property {string} [value]
 * @property {boolean} [write]
 */

/**
 * @typedef {Object} ContactsFieldOptionListMatch
 * @property {string} field_id
 */

/**
 * @typedef {Object} Contactsgroup
 * @property {string} [birthday_date]
 * @property {string} [city]
 * @property {number} contact_expire_after
 * @property {number} [contacts_count]
 * @property {string} [country]
 * @property {string} created_by
 * @property {string} date_created
 * @property {string} date_updated
 * @property {string} [description]
 * @property {string} [email]
 * @property {string} [first_name]
 * @property {string} gender
 * @property {string} group_id
 * @property {Array} groups
 * @property {string} id
 * @property {string} [idx]
 * @property {string} [last_name]
 * @property {string} [name]
 * @property {Array} [permissions]
 * @property {string} [phone_number]
 * @property {boolean} read
 * @property {boolean} send
 * @property {string} [source]
 * @property {string} [type]
 * @property {string} username
 * @property {string} [value]
 * @property {boolean} write
 */

/**
 * @typedef {Object} ContactsgroupListMatch
 * @property {Object} [name]
 * @property {Array} [with]
 */

/**
 * @typedef {Object} ContactsgroupCreateData
 * @property {string} [birthday_date]
 * @property {string} [city]
 * @property {number} contact_expire_after
 * @property {number} [contacts_count]
 * @property {string} [country]
 * @property {string} created_by
 * @property {string} date_created
 * @property {string} date_updated
 * @property {string} [description]
 * @property {string} [email]
 * @property {string} [first_name]
 * @property {string} gender
 * @property {string} group_id
 * @property {Array} groups
 * @property {string} id
 * @property {string} [idx]
 * @property {string} [last_name]
 * @property {string} [name]
 * @property {Array} [permissions]
 * @property {string} [phone_number]
 * @property {boolean} read
 * @property {boolean} send
 * @property {string} [source]
 * @property {string} [type]
 * @property {string} username
 * @property {string} [value]
 * @property {boolean} write
 */

/**
 * @typedef {Object} ContactsgroupUpdateData
 * @property {string} group_id
 * @property {string} [username]
 * @property {string} [birthday_date]
 * @property {string} [city]
 * @property {number} [contact_expire_after]
 * @property {number} [contacts_count]
 * @property {string} [country]
 * @property {string} [created_by]
 * @property {string} [date_created]
 * @property {string} [date_updated]
 * @property {string} [description]
 * @property {string} [email]
 * @property {string} [first_name]
 * @property {string} [gender]
 * @property {Array} [groups]
 * @property {string} [id]
 * @property {string} [idx]
 * @property {string} [last_name]
 * @property {string} [name]
 * @property {Array} [permissions]
 * @property {string} [phone_number]
 * @property {boolean} [read]
 * @property {boolean} [send]
 * @property {string} [source]
 * @property {string} [type]
 * @property {string} [value]
 * @property {boolean} [write]
 */

/**
 * @typedef {Object} ContactsgroupRemoveMatch
 * @property {string} group_id
 */

/**
 * @typedef {Object} Contactstrash
 */

/**
 * @typedef {Object} ContactstrashUpdateData
 */

/**
 * @typedef {Object} ContactstrashRemoveMatch
 */

/**
 * @typedef {Object} FieldAvailable
 * @property {boolean} [built_in]
 * @property {string} [id]
 * @property {string} [name]
 * @property {Array} [options]
 * @property {string} [type]
 */

/**
 * @typedef {Object} FieldAvailableListMatch
 * @property {boolean} [built_in]
 * @property {string} [id]
 * @property {string} [name]
 * @property {Array} [options]
 * @property {string} [type]
 */

/**
 * @typedef {Object} Group
 * @property {number} contact_expire_after
 * @property {number} contacts_count
 * @property {string} created_by
 * @property {string} date_created
 * @property {string} date_updated
 * @property {string} description
 * @property {string} id
 * @property {string} [idx]
 * @property {string} name
 * @property {Array} [permissions]
 */

/**
 * @typedef {Object} GroupLoadMatch
 * @property {string} id
 */

/**
 * @typedef {Object} GroupUpdateData
 * @property {string} id
 * @property {number} [contact_expire_after]
 * @property {number} [contacts_count]
 * @property {string} [created_by]
 * @property {string} [date_created]
 * @property {string} [date_updated]
 * @property {string} [description]
 * @property {string} [idx]
 * @property {string} [name]
 * @property {Array} [permissions]
 */

/**
 * @typedef {Object} MfaCode
 * @property {string} [content]
 * @property {*} [fast]
 * @property {string} [from]
 * @property {string} phone_number
 */

/**
 * @typedef {Object} MfaCodeCreateData
 * @property {string} [content]
 * @property {*} [fast]
 * @property {string} [from]
 * @property {string} phone_number
 */

/**
 * @typedef {Object} OptOut
 * @property {string} [date]
 * @property {string} [id]
 * @property {Array} [links]
 * @property {number} [phoneNumber]
 */

/**
 * @typedef {Object} OptOutListMatch
 * @property {number} [limit]
 * @property {number} [offset]
 * @property {string} [phone_number]
 */

/**
 * @typedef {Object} OptOutRemoveMatch
 * @property {string} id
 */

/**
 * @typedef {Object} OptOutSetting
 * @property {string} [brand]
 */

/**
 * @typedef {Object} OptOutSettingLoadMatch
 * @property {string} [brand]
 */

/**
 * @typedef {Object} OptOutSettingUpdateData
 * @property {string} [brand]
 */

/**
 * @typedef {Object} Permission
 * @property {string} group_id
 * @property {string} [id]
 * @property {boolean} read
 * @property {boolean} send
 * @property {string} username
 * @property {boolean} write
 */

/**
 * @typedef {Object} PermissionLoadMatch
 * @property {string} group_id
 * @property {string} id
 * @property {string} username
 */

/**
 * @typedef {Object} PermissionCreateData
 * @property {string} group_id
 * @property {string} [id]
 * @property {boolean} read
 * @property {boolean} send
 * @property {string} username
 * @property {boolean} write
 */

/**
 * @typedef {Object} Ping
 * @property {boolean} authorized
 * @property {Array} unavailable
 */

/**
 * @typedef {Object} PingListMatch
 * @property {boolean} [authorized]
 * @property {Array} [unavailable]
 */

/**
 * @typedef {Object} Profile
 * @property {string} email
 * @property {string} name
 * @property {string} payment_type
 * @property {number} phone_number
 * @property {number} [points]
 * @property {string} user_type
 * @property {string} username
 */

/**
 * @typedef {Object} ProfileLoadMatch
 * @property {string} [email]
 * @property {string} [name]
 * @property {string} [payment_type]
 * @property {number} [phone_number]
 * @property {number} [points]
 * @property {string} [user_type]
 * @property {string} [username]
 */

/**
 * @typedef {Object} ProfileListMatch
 * @property {string} [type]
 */

/**
 * @typedef {Object} Rcs
 */

/**
 * @typedef {Object} RcsListMatch
 */

/**
 * @typedef {Object} Sendername
 * @property {string} [created_at]
 * @property {string} [id]
 * @property {boolean} [is_default]
 * @property {string} [sender]
 * @property {string} [status]
 */

/**
 * @typedef {Object} SendernameLoadMatch
 * @property {string} id
 */

/**
 * @typedef {Object} SendernameListMatch
 * @property {string} [created_at]
 * @property {string} [id]
 * @property {boolean} [is_default]
 * @property {string} [sender]
 * @property {string} [status]
 */

/**
 * @typedef {Object} SendernameCreateData
 * @property {string} [created_at]
 * @property {string} [id]
 * @property {boolean} [is_default]
 * @property {string} [sender]
 * @property {string} [status]
 */

/**
 * @typedef {Object} SendernameStatement
 * @property {string} [content]
 * @property {Array} [statements]
 * @property {string} [title]
 */

/**
 * @typedef {Object} SendernameStatementListMatch
 * @property {string} [content]
 * @property {Array} [statements]
 * @property {string} [title]
 */

/**
 * @typedef {Object} SentRcsMessage
 * @property {Object} [content]
 * @property {string} phone_number
 * @property {*} sender
 * @property {string} [text]
 */

/**
 * @typedef {Object} SentRcsMessageCreateData
 * @property {Object} [content]
 * @property {string} phone_number
 * @property {*} sender
 * @property {string} [text]
 */

/**
 * @typedef {Object} ShipmentCountryVolume
 * @property {string} [country_code]
 * @property {number} [country_limit]
 * @property {string} [country_name]
 * @property {number} [usage]
 */

/**
 * @typedef {Object} ShipmentCountryVolumeListMatch
 * @property {string} [month]
 * @property {string} [year]
 */

/**
 * @typedef {Object} ShortUrl
 * @property {string} [description]
 * @property {string} [expire]
 * @property {string} [filename]
 * @property {number} [hits]
 * @property {number} [hits_unique]
 * @property {string} [id]
 * @property {string} [name]
 * @property {string} [short_url]
 * @property {string} [type]
 * @property {string} [url]
 */

/**
 * @typedef {Object} ShortUrlLoadMatch
 * @property {string} id
 */

/**
 * @typedef {Object} ShortUrlListMatch
 * @property {string} [description]
 * @property {string} [expire]
 * @property {string} [filename]
 * @property {number} [hits]
 * @property {number} [hits_unique]
 * @property {string} [id]
 * @property {string} [name]
 * @property {string} [short_url]
 * @property {string} [type]
 * @property {string} [url]
 */

/**
 * @typedef {Object} ShortUrlCreateData
 * @property {string} [description]
 * @property {string} [expire]
 * @property {string} [filename]
 * @property {number} [hits]
 * @property {number} [hits_unique]
 * @property {string} [id]
 * @property {string} [name]
 * @property {string} [short_url]
 * @property {string} [type]
 * @property {string} [url]
 */

/**
 * @typedef {Object} ShortUrlUpdateData
 * @property {string} id
 * @property {string} [description]
 * @property {string} [expire]
 * @property {string} [filename]
 * @property {number} [hits]
 * @property {number} [hits_unique]
 * @property {string} [name]
 * @property {string} [short_url]
 * @property {string} [type]
 * @property {string} [url]
 */

/**
 * @typedef {Object} ShortUrlRemoveMatch
 * @property {string} id
 */

/**
 * @typedef {Object} Smsdo
 * @property {number} [allow_duplicates]
 * @property {*} [check_idx]
 * @property {*} [date]
 * @property {number} [date_validate]
 * @property {*} [details]
 * @property {string} [encoding]
 * @property {*} [expiration_date]
 * @property {Array} [fallback]
 * @property {number} [fast]
 * @property {number} [flash]
 * @property {string} [format]
 * @property {string} [from]
 * @property {string} [group]
 * @property {string} [idx]
 * @property {number} [max_parts]
 * @property {string} [message]
 * @property {number} [normalize]
 * @property {string} [notify_url]
 * @property {*} [test]
 * @property {string} [time_restriction]
 * @property {string} [to]
 */

/**
 * @typedef {Object} SmsdoCreateData
 * @property {number} [allow_duplicates]
 * @property {*} [check_idx]
 * @property {*} [date]
 * @property {number} [date_validate]
 * @property {*} [details]
 * @property {string} [encoding]
 * @property {*} [expiration_date]
 * @property {Array} [fallback]
 * @property {number} [fast]
 * @property {number} [flash]
 * @property {string} [format]
 * @property {string} [from]
 * @property {string} [group]
 * @property {string} [idx]
 * @property {number} [max_parts]
 * @property {string} [message]
 * @property {number} [normalize]
 * @property {string} [notify_url]
 * @property {*} [test]
 * @property {string} [time_restriction]
 * @property {string} [to]
 */

/**
 * @typedef {Object} Smssendername
 */

/**
 * @typedef {Object} SmssendernameCreateData
 * @property {string} sendername_id
 */

/**
 * @typedef {Object} SmssendernameRemoveMatch
 * @property {string} sender
 */

/**
 * @typedef {Object} Smstemplate
 * @property {string} [id]
 */

/**
 * @typedef {Object} SmstemplateRemoveMatch
 * @property {string} id
 */

/**
 * @typedef {Object} Subuser
 * @property {boolean} [active]
 * @property {Object} credentials
 * @property {string} [description]
 * @property {string} [id]
 * @property {Object} [points]
 * @property {string} [username]
 */

/**
 * @typedef {Object} SubuserLoadMatch
 * @property {string} id
 */

/**
 * @typedef {Object} SubuserListMatch
 * @property {string} [q]
 */

/**
 * @typedef {Object} SubuserCreateData
 * @property {boolean} [active]
 * @property {Object} credentials
 * @property {string} [description]
 * @property {string} [id]
 * @property {Object} [points]
 * @property {string} [username]
 */

/**
 * @typedef {Object} SubuserUpdateData
 * @property {string} id
 * @property {boolean} [active]
 * @property {Object} [credentials]
 * @property {string} [description]
 * @property {Object} [points]
 * @property {string} [username]
 */

/**
 * @typedef {Object} SubuserRemoveMatch
 * @property {string} id
 */

/**
 * @typedef {Object} Template
 * @property {string} [id]
 * @property {string} [name]
 * @property {boolean} [normalize]
 * @property {string} [template]
 */

/**
 * @typedef {Object} TemplateLoadMatch
 * @property {string} id
 */

/**
 * @typedef {Object} TemplateListMatch
 * @property {string} [id]
 * @property {string} [name]
 * @property {boolean} [normalize]
 * @property {string} [template]
 */

/**
 * @typedef {Object} TemplateCreateData
 * @property {string} [id]
 * @property {string} [name]
 * @property {boolean} [normalize]
 * @property {string} [template]
 */

/**
 * @typedef {Object} TemplateUpdateData
 * @property {string} id
 * @property {string} [name]
 * @property {boolean} [normalize]
 * @property {string} [template]
 */

/**
 * @typedef {Object} UserRcsSenderCollection
 * @property {string} [deliveredAt]
 * @property {string} [expiredAt]
 * @property {string} [id]
 * @property {string} [interface]
 * @property {string} [messageType]
 * @property {string} [readAt]
 * @property {string} [recipient]
 * @property {string} [sender]
 * @property {string} [senderId]
 * @property {string} [sentAt]
 */

/**
 * @typedef {Object} UserRcsSenderCollectionListMatch
 * @property {string} [deliveredAt]
 * @property {string} [expiredAt]
 * @property {string} [id]
 * @property {string} [interface]
 * @property {string} [messageType]
 * @property {string} [readAt]
 * @property {string} [recipient]
 * @property {string} [sender]
 * @property {string} [senderId]
 * @property {string} [sentAt]
 */

