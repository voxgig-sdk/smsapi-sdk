# Typed models for the Smsapi SDK.
#
# GENERATED from the API model: main.kit.entity.<e>.fields{} and per-op
# params (op.<name>.points[].g.params[]). Field/param types come from the
# canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
# @voxgig/apidef VALID_CANON). Do not edit by hand.
#
# These are TypedDicts, not dataclasses: the SDK ops return/accept plain dicts
# at runtime, and a TypedDict IS a dict shape, so the types match the runtime.
# Optional (req:false) keys are modelled as TypedDict key-optionality
# (total=False), split into a required base + total=False subclass when a type
# has both required and optional keys.

from __future__ import annotations

from typing import TypedDict, Any


class Available(TypedDict, total=False):
    name: str
    normalize: bool
    template: str


class AvailableListMatch(TypedDict, total=False):
    name: str
    normalize: bool
    template: str


class Blacklist(TypedDict, total=False):
    id: str


class BlacklistLoadMatch(TypedDict, total=False):
    limit: int
    offset: int
    q: int


class BlacklistCreateData(TypedDict, total=False):
    id: str


class BlacklistRemoveMatch(TypedDict):
    id: str


class Callback(TypedDict, total=False):
    active: bool
    api_version: int
    id: str
    invalid: bool
    receiver: dict
    receiver_type: str
    type: str
    url: str


class CallbackLoadMatch(TypedDict):
    id: str


class CallbackListMatch(TypedDict, total=False):
    active: bool
    api_version: int
    id: str
    invalid: bool
    receiver: dict
    receiver_type: str
    type: str
    url: str


class CallbackCreateData(TypedDict, total=False):
    active: bool
    api_version: int
    id: str
    invalid: bool
    receiver: dict
    receiver_type: str
    type: str
    url: str


class CallbackUpdateDataRequired(TypedDict):
    id: str


class CallbackUpdateData(CallbackUpdateDataRequired, total=False):
    active: bool
    api_version: int
    invalid: bool
    receiver: dict
    receiver_type: str
    type: str
    url: str


class CallbackRemoveMatch(TypedDict):
    id: str


class ContactRequired(TypedDict):
    collection: list
    contact_expire_after: int
    contacts_count: int
    created_by: str
    date_created: str
    date_updated: str
    gender: str
    groups: list
    id: str
    name: str
    size: int


class Contact(ContactRequired, total=False):
    birthday_date: str
    city: str
    country: str
    description: str
    email: str
    first_name: str
    group_id: str
    idx: str
    last_name: str
    permissions: list
    phone_number: str
    read: bool
    send: bool
    source: str
    type: str
    username: str
    value: str
    write: bool


class ContactLoadMatch(TypedDict):
    id: str


class ContactListMatch(TypedDict, total=False):
    birthday_date: list
    email: list
    first_name: list
    gender: str
    group_id: list
    last_name: list
    limit: int
    offset: int
    order_by: str
    phone_number: list
    q: str


class ContactCreateDataRequired(TypedDict):
    collection: list
    contact_expire_after: int
    contacts_count: int
    created_by: str
    date_created: str
    date_updated: str
    gender: str
    groups: list
    id: str
    name: str
    size: int


class ContactCreateData(ContactCreateDataRequired, total=False):
    birthday_date: str
    city: str
    country: str
    description: str
    email: str
    first_name: str
    group_id: str
    idx: str
    last_name: str
    permissions: list
    phone_number: str
    read: bool
    send: bool
    source: str
    type: str
    username: str
    value: str
    write: bool


class ContactUpdateDataRequired(TypedDict):
    id: str


class ContactUpdateData(ContactUpdateDataRequired, total=False):
    birthday_date: str
    city: str
    collection: list
    contact_expire_after: int
    contacts_count: int
    country: str
    created_by: str
    date_created: str
    date_updated: str
    description: str
    email: str
    first_name: str
    gender: str
    group_id: str
    groups: list
    idx: str
    last_name: str
    name: str
    permissions: list
    phone_number: str
    read: bool
    send: bool
    size: int
    source: str
    type: str
    username: str
    value: str
    write: bool


class ContactRemoveMatch(TypedDict):
    id: str


class ContactsFieldRequired(TypedDict):
    contact_expire_after: int
    created_by: str
    date_created: str
    date_updated: str
    gender: str
    groups: list


class ContactsField(ContactsFieldRequired, total=False):
    birthday_date: str
    city: str
    contacts_count: int
    country: str
    description: str
    email: str
    first_name: str
    group_id: str
    id: str
    idx: str
    last_name: str
    name: str
    permissions: list
    phone_number: str
    read: bool
    send: bool
    source: str
    type: str
    username: str
    value: str
    write: bool


class ContactsFieldListMatch(TypedDict, total=False):
    birthday_date: str
    city: str
    contact_expire_after: int
    contacts_count: int
    country: str
    created_by: str
    date_created: str
    date_updated: str
    description: str
    email: str
    first_name: str
    gender: str
    group_id: str
    groups: list
    id: str
    idx: str
    last_name: str
    name: str
    permissions: list
    phone_number: str
    read: bool
    send: bool
    source: str
    type: str
    username: str
    value: str
    write: bool


class ContactsFieldCreateDataRequired(TypedDict):
    contact_expire_after: int
    created_by: str
    date_created: str
    date_updated: str
    gender: str
    groups: list


class ContactsFieldCreateData(ContactsFieldCreateDataRequired, total=False):
    birthday_date: str
    city: str
    contacts_count: int
    country: str
    description: str
    email: str
    first_name: str
    group_id: str
    id: str
    idx: str
    last_name: str
    name: str
    permissions: list
    phone_number: str
    read: bool
    send: bool
    source: str
    type: str
    username: str
    value: str
    write: bool


class ContactsFieldUpdateDataRequired(TypedDict):
    id: str


class ContactsFieldUpdateData(ContactsFieldUpdateDataRequired, total=False):
    birthday_date: str
    city: str
    contact_expire_after: int
    contacts_count: int
    country: str
    created_by: str
    date_created: str
    date_updated: str
    description: str
    email: str
    first_name: str
    gender: str
    group_id: str
    groups: list
    idx: str
    last_name: str
    name: str
    permissions: list
    phone_number: str
    read: bool
    send: bool
    source: str
    type: str
    username: str
    value: str
    write: bool


class ContactsFieldRemoveMatch(TypedDict):
    id: str


class ContactsFieldOptionRequired(TypedDict):
    contact_expire_after: int
    created_by: str
    date_created: str
    date_updated: str
    gender: str
    groups: list
    id: str


class ContactsFieldOption(ContactsFieldOptionRequired, total=False):
    birthday_date: str
    city: str
    contacts_count: int
    country: str
    description: str
    email: str
    first_name: str
    group_id: str
    idx: str
    last_name: str
    name: str
    permissions: list
    phone_number: str
    read: bool
    send: bool
    source: str
    type: str
    username: str
    value: str
    write: bool


class ContactsFieldOptionListMatch(TypedDict):
    field_id: str


class ContactsgroupRequired(TypedDict):
    contact_expire_after: int
    created_by: str
    date_created: str
    date_updated: str
    gender: str
    group_id: str
    groups: list
    id: str
    read: bool
    send: bool
    username: str
    write: bool


class Contactsgroup(ContactsgroupRequired, total=False):
    birthday_date: str
    city: str
    contacts_count: int
    country: str
    description: str
    email: str
    first_name: str
    idx: str
    last_name: str
    name: str
    permissions: list
    phone_number: str
    source: str
    type: str
    value: str


class ContactsgroupListMatch(TypedDict, total=False):
    name: dict


class ContactsgroupCreateDataRequired(TypedDict):
    contact_expire_after: int
    created_by: str
    date_created: str
    date_updated: str
    gender: str
    group_id: str
    groups: list
    id: str
    read: bool
    send: bool
    username: str
    write: bool


class ContactsgroupCreateData(ContactsgroupCreateDataRequired, total=False):
    birthday_date: str
    city: str
    contacts_count: int
    country: str
    description: str
    email: str
    first_name: str
    idx: str
    last_name: str
    name: str
    permissions: list
    phone_number: str
    source: str
    type: str
    value: str


class ContactsgroupUpdateDataRequired(TypedDict):
    group_id: str


class ContactsgroupUpdateData(ContactsgroupUpdateDataRequired, total=False):
    username: str
    birthday_date: str
    city: str
    contact_expire_after: int
    contacts_count: int
    country: str
    created_by: str
    date_created: str
    date_updated: str
    description: str
    email: str
    first_name: str
    gender: str
    groups: list
    id: str
    idx: str
    last_name: str
    name: str
    permissions: list
    phone_number: str
    read: bool
    send: bool
    source: str
    type: str
    value: str
    write: bool


class ContactsgroupRemoveMatch(TypedDict):
    group_id: str


class Contactstrash(TypedDict):
    pass


class ContactstrashUpdateData(TypedDict):
    pass


class ContactstrashRemoveMatch(TypedDict):
    pass


class FieldAvailable(TypedDict, total=False):
    built_in: bool
    id: str
    name: str
    options: list
    type: str


class FieldAvailableListMatch(TypedDict, total=False):
    built_in: bool
    id: str
    name: str
    options: list
    type: str


class GroupRequired(TypedDict):
    contact_expire_after: int
    contacts_count: int
    created_by: str
    date_created: str
    date_updated: str
    description: str
    id: str
    name: str


class Group(GroupRequired, total=False):
    idx: str
    permissions: list


class GroupLoadMatch(TypedDict):
    id: str


class GroupUpdateDataRequired(TypedDict):
    id: str


class GroupUpdateData(GroupUpdateDataRequired, total=False):
    contact_expire_after: int
    contacts_count: int
    created_by: str
    date_created: str
    date_updated: str
    description: str
    idx: str
    name: str
    permissions: list


class MfaCodeRequired(TypedDict):
    phone_number: str


class MfaCode(MfaCodeRequired, total=False):
    content: str
    fast: Any


class MfaCodeCreateDataRequired(TypedDict):
    phone_number: str


class MfaCodeCreateData(MfaCodeCreateDataRequired, total=False):
    content: str
    fast: Any


class OptOut(TypedDict, total=False):
    date: str
    id: str
    links: list
    phoneNumber: int


class OptOutListMatch(TypedDict, total=False):
    limit: int
    offset: int
    phone_number: str


class OptOutRemoveMatch(TypedDict):
    id: str


class OptOutSetting(TypedDict, total=False):
    brand: str


class OptOutSettingLoadMatch(TypedDict, total=False):
    brand: str


class OptOutSettingUpdateData(TypedDict, total=False):
    brand: str


class PermissionRequired(TypedDict):
    group_id: str
    read: bool
    send: bool
    username: str
    write: bool


class Permission(PermissionRequired, total=False):
    id: str


class PermissionLoadMatch(TypedDict):
    group_id: str
    id: str
    username: str


class PermissionCreateDataRequired(TypedDict):
    group_id: str
    read: bool
    send: bool
    username: str
    write: bool


class PermissionCreateData(PermissionCreateDataRequired, total=False):
    id: str


class Ping(TypedDict):
    authorized: bool
    unavailable: list


class PingListMatch(TypedDict, total=False):
    authorized: bool
    unavailable: list


class ProfileRequired(TypedDict):
    email: str
    name: str
    payment_type: str
    phone_number: int
    user_type: str
    username: str


class Profile(ProfileRequired, total=False):
    points: float


class ProfileLoadMatch(TypedDict, total=False):
    email: str
    name: str
    payment_type: str
    phone_number: int
    points: float
    user_type: str
    username: str


class ProfileListMatch(TypedDict, total=False):
    type: str


class Rcs(TypedDict):
    pass


class RcsListMatch(TypedDict):
    pass


class Sendername(TypedDict, total=False):
    created_at: str
    id: str
    is_default: bool
    sender: str
    status: str


class SendernameLoadMatch(TypedDict):
    id: str


class SendernameListMatch(TypedDict, total=False):
    created_at: str
    id: str
    is_default: bool
    sender: str
    status: str


class SendernameCreateData(TypedDict, total=False):
    created_at: str
    id: str
    is_default: bool
    sender: str
    status: str


class SendernameStatement(TypedDict, total=False):
    content: str
    statements: list
    title: str


class SendernameStatementListMatch(TypedDict, total=False):
    content: str
    statements: list
    title: str


class SentRcsMessageRequired(TypedDict):
    phone_number: str
    sender: Any


class SentRcsMessage(SentRcsMessageRequired, total=False):
    content: dict
    text: str


class SentRcsMessageCreateDataRequired(TypedDict):
    phone_number: str
    sender: Any


class SentRcsMessageCreateData(SentRcsMessageCreateDataRequired, total=False):
    content: dict
    text: str


class ShipmentCountryVolume(TypedDict, total=False):
    country_code: str
    country_limit: int
    country_name: str
    usage: int


class ShipmentCountryVolumeListMatch(TypedDict, total=False):
    month: str
    year: str


class ShortUrl(TypedDict, total=False):
    description: str
    expire: str
    filename: str
    hits: int
    hits_unique: int
    id: str
    name: str
    short_url: str
    type: str
    url: str


class ShortUrlLoadMatch(TypedDict):
    id: str


class ShortUrlListMatch(TypedDict, total=False):
    description: str
    expire: str
    filename: str
    hits: int
    hits_unique: int
    id: str
    name: str
    short_url: str
    type: str
    url: str


class ShortUrlCreateData(TypedDict, total=False):
    description: str
    expire: str
    filename: str
    hits: int
    hits_unique: int
    id: str
    name: str
    short_url: str
    type: str
    url: str


class ShortUrlUpdateDataRequired(TypedDict):
    id: str


class ShortUrlUpdateData(ShortUrlUpdateDataRequired, total=False):
    description: str
    expire: str
    filename: str
    hits: int
    hits_unique: int
    name: str
    short_url: str
    type: str
    url: str


class ShortUrlRemoveMatch(TypedDict):
    id: str


class Smsdo(TypedDict, total=False):
    allow_duplicates: int
    check_idx: Any
    date: Any
    date_validate: int
    details: Any
    encoding: str
    expiration_date: Any
    fallback: list
    fast: int
    flash: int
    format: str
    group: str
    idx: str
    max_parts: int
    message: str
    normalize: int
    notify_url: str
    test: Any
    time_restriction: str
    to: str


class SmsdoCreateData(TypedDict, total=False):
    allow_duplicates: int
    check_idx: Any
    date: Any
    date_validate: int
    details: Any
    encoding: str
    expiration_date: Any
    fallback: list
    fast: int
    flash: int
    format: str
    group: str
    idx: str
    max_parts: int
    message: str
    normalize: int
    notify_url: str
    test: Any
    time_restriction: str
    to: str


class Smssendername(TypedDict):
    pass


class SmssendernameCreateData(TypedDict):
    sendername_id: str


class SmssendernameRemoveMatch(TypedDict):
    sender: str


class Smstemplate(TypedDict, total=False):
    id: str


class SmstemplateRemoveMatch(TypedDict):
    id: str


class SubuserRequired(TypedDict):
    credentials: dict


class Subuser(SubuserRequired, total=False):
    active: bool
    description: str
    id: str
    points: dict
    username: str


class SubuserLoadMatch(TypedDict):
    id: str


class SubuserListMatch(TypedDict, total=False):
    q: str


class SubuserCreateDataRequired(TypedDict):
    credentials: dict


class SubuserCreateData(SubuserCreateDataRequired, total=False):
    active: bool
    description: str
    id: str
    points: dict
    username: str


class SubuserUpdateDataRequired(TypedDict):
    id: str


class SubuserUpdateData(SubuserUpdateDataRequired, total=False):
    active: bool
    credentials: dict
    description: str
    points: dict
    username: str


class SubuserRemoveMatch(TypedDict):
    id: str


class Template(TypedDict, total=False):
    id: str
    name: str
    normalize: bool
    template: str


class TemplateLoadMatch(TypedDict):
    id: str


class TemplateListMatch(TypedDict, total=False):
    id: str
    name: str
    normalize: bool
    template: str


class TemplateCreateData(TypedDict, total=False):
    id: str
    name: str
    normalize: bool
    template: str


class TemplateUpdateDataRequired(TypedDict):
    id: str


class TemplateUpdateData(TemplateUpdateDataRequired, total=False):
    name: str
    normalize: bool
    template: str


class UserRcsSenderCollection(TypedDict, total=False):
    deliveredAt: str
    expiredAt: str
    id: str
    interface: str
    messageType: str
    readAt: str
    recipient: str
    sender: str
    senderId: str
    sentAt: str


class UserRcsSenderCollectionListMatch(TypedDict, total=False):
    deliveredAt: str
    expiredAt: str
    id: str
    interface: str
    messageType: str
    readAt: str
    recipient: str
    sender: str
    senderId: str
    sentAt: str
