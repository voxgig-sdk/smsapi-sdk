// Typed models for the Smsapi SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields{} and per-op
// params (op.<name>.points[].g.params[]). Field/param types come from the
// canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
// @voxgig/apidef VALID_CANON). Do not edit by hand.

export interface Available {
  name?: string
  normalize?: boolean
  template?: string
}

export interface AvailableListMatch {
  name?: string
  normalize?: boolean
  template?: string
}

export interface Blacklist {
  id?: string
}

export interface BlacklistLoadMatch {
  limit?: number
  offset?: number
  q?: number

  // Selects a custom action instead of the plain load:
  //   'phone_number'
  // The remaining keys are that action's own payload.
  $action?: string
  [action: string]: any
}

export interface BlacklistCreateData {
  id?: string

  // Selects a custom action instead of the plain create:
  //   'phone_number'
  // The remaining keys are that action's own payload.
  $action?: string
  [action: string]: any
}

export interface BlacklistRemoveMatch {
  id: string

  // Selects a custom action instead of the plain remove:
  //   'phone_number'
  // The remaining keys are that action's own payload.
  $action?: string
  [action: string]: any
}

export interface Callback {
  active?: boolean
  api_version?: number
  id?: string
  invalid?: boolean
  receiver?: Record<string, any>
  receiver_type?: string
  type?: string
  url?: string
}

export interface CallbackLoadMatch {
  id: string

  // Selects a custom action instead of the plain load:
  //   'command_test'
  // The remaining keys are that action's own payload.
  $action?: string
  [action: string]: any
}

export interface CallbackListMatch {
  active?: boolean
  api_version?: number
  id?: string
  invalid?: boolean
  receiver?: Record<string, any>
  receiver_type?: string
  type?: string
  url?: string
}

export interface CallbackCreateData {
  active?: boolean
  api_version?: number
  id?: string
  invalid?: boolean
  receiver?: Record<string, any>
  receiver_type?: string
  type?: string
  url?: string
}

export interface CallbackUpdateData {
  id: string
  active?: boolean
  api_version?: number
  invalid?: boolean
  receiver?: Record<string, any>
  receiver_type?: string
  type?: string
  url?: string

  // Selects a custom action instead of the plain update:
  //   'command_activate' | 'command_deactivate'
  // The remaining keys are that action's own payload.
  $action?: string
  [action: string]: any
}

export interface CallbackRemoveMatch {
  id: string
}

export interface Contact {
  birthday_date?: string
  city?: string
  collection: any[]
  contact_expire_after: number
  contacts_count: number
  country?: string
  created_by: string
  date_created: string
  date_updated: string
  description?: string
  email?: string
  first_name?: string
  gender: string
  group_id?: string
  groups: any[]
  id: string
  idx?: string
  last_name?: string
  name: string
  permissions?: any[]
  phone_number?: string
  read?: boolean
  send?: boolean
  size: number
  source?: string
  type?: string
  username?: string
  value?: string
  write?: boolean
}

export interface ContactLoadMatch {
  id: string
}

export interface ContactListMatch {
  birthday_date?: any[]
  email?: any[]
  first_name?: any[]
  gender?: string
  group_id?: any[]
  last_name?: any[]
  limit?: number
  offset?: number
  order_by?: string
  phone_number?: any[]
  q?: string

  // Selects a custom action instead of the plain list:
  //   'group'
  // The remaining keys are that action's own payload.
  $action?: string
  [action: string]: any
}

export interface ContactCreateData {
  birthday_date?: string
  city?: string
  collection: any[]
  contact_expire_after: number
  contacts_count: number
  country?: string
  created_by: string
  date_created: string
  date_updated: string
  description?: string
  email?: string
  first_name?: string
  gender: string
  group_id?: string
  groups: any[]
  id: string
  idx?: string
  last_name?: string
  name: string
  permissions?: any[]
  phone_number?: string
  read?: boolean
  send?: boolean
  size: number
  source?: string
  type?: string
  username?: string
  value?: string
  write?: boolean

  // Selects a custom action instead of the plain create:
  //   'group'
  // The remaining keys are that action's own payload.
  $action?: string
  [action: string]: any
}

export interface ContactUpdateData {
  id: string
  birthday_date?: string
  city?: string
  collection?: any[]
  contact_expire_after?: number
  contacts_count?: number
  country?: string
  created_by?: string
  date_created?: string
  date_updated?: string
  description?: string
  email?: string
  first_name?: string
  gender?: string
  group_id?: string
  groups?: any[]
  idx?: string
  last_name?: string
  name?: string
  permissions?: any[]
  phone_number?: string
  read?: boolean
  send?: boolean
  size?: number
  source?: string
  type?: string
  username?: string
  value?: string
  write?: boolean
}

export interface ContactRemoveMatch {
  id: string
}

export interface ContactsField {
  birthday_date?: string
  city?: string
  contact_expire_after: number
  contacts_count?: number
  country?: string
  created_by: string
  date_created: string
  date_updated: string
  description?: string
  email?: string
  first_name?: string
  gender: string
  group_id?: string
  groups: any[]
  id?: string
  idx?: string
  last_name?: string
  name?: string
  permissions?: any[]
  phone_number?: string
  read?: boolean
  send?: boolean
  source?: string
  type?: string
  username?: string
  value?: string
  write?: boolean
}

export interface ContactsFieldListMatch {
  birthday_date?: string
  city?: string
  contact_expire_after?: number
  contacts_count?: number
  country?: string
  created_by?: string
  date_created?: string
  date_updated?: string
  description?: string
  email?: string
  first_name?: string
  gender?: string
  group_id?: string
  groups?: any[]
  id?: string
  idx?: string
  last_name?: string
  name?: string
  permissions?: any[]
  phone_number?: string
  read?: boolean
  send?: boolean
  source?: string
  type?: string
  username?: string
  value?: string
  write?: boolean
}

export interface ContactsFieldCreateData {
  birthday_date?: string
  city?: string
  contact_expire_after: number
  contacts_count?: number
  country?: string
  created_by: string
  date_created: string
  date_updated: string
  description?: string
  email?: string
  first_name?: string
  gender: string
  group_id?: string
  groups: any[]
  id?: string
  idx?: string
  last_name?: string
  name?: string
  permissions?: any[]
  phone_number?: string
  read?: boolean
  send?: boolean
  source?: string
  type?: string
  username?: string
  value?: string
  write?: boolean
}

export interface ContactsFieldUpdateData {
  id: string
  birthday_date?: string
  city?: string
  contact_expire_after?: number
  contacts_count?: number
  country?: string
  created_by?: string
  date_created?: string
  date_updated?: string
  description?: string
  email?: string
  first_name?: string
  gender?: string
  group_id?: string
  groups?: any[]
  idx?: string
  last_name?: string
  name?: string
  permissions?: any[]
  phone_number?: string
  read?: boolean
  send?: boolean
  source?: string
  type?: string
  username?: string
  value?: string
  write?: boolean
}

export interface ContactsFieldRemoveMatch {
  id: string
}

export interface ContactsFieldOption {
  birthday_date?: string
  city?: string
  contact_expire_after: number
  contacts_count?: number
  country?: string
  created_by: string
  date_created: string
  date_updated: string
  description?: string
  email?: string
  first_name?: string
  gender: string
  group_id?: string
  groups: any[]
  id: string
  idx?: string
  last_name?: string
  name?: string
  permissions?: any[]
  phone_number?: string
  read?: boolean
  send?: boolean
  source?: string
  type?: string
  username?: string
  value?: string
  write?: boolean
}

export interface ContactsFieldOptionListMatch {
  field_id: string
}

export interface Contactsgroup {
  birthday_date?: string
  city?: string
  contact_expire_after: number
  contacts_count?: number
  country?: string
  created_by: string
  date_created: string
  date_updated: string
  description?: string
  email?: string
  first_name?: string
  gender: string
  group_id: string
  groups: any[]
  id: string
  idx?: string
  last_name?: string
  name?: string
  permissions?: any[]
  phone_number?: string
  read: boolean
  send: boolean
  source?: string
  type?: string
  username: string
  value?: string
  write: boolean
}

export interface ContactsgroupListMatch {
  name?: Record<string, any>
  with?: any[]
}

export interface ContactsgroupCreateData {
  birthday_date?: string
  city?: string
  contact_expire_after: number
  contacts_count?: number
  country?: string
  created_by: string
  date_created: string
  date_updated: string
  description?: string
  email?: string
  first_name?: string
  gender: string
  group_id: string
  groups: any[]
  id: string
  idx?: string
  last_name?: string
  name?: string
  permissions?: any[]
  phone_number?: string
  read: boolean
  send: boolean
  source?: string
  type?: string
  username: string
  value?: string
  write: boolean
}

export interface ContactsgroupUpdateData {
  group_id: string
  username?: string
  birthday_date?: string
  city?: string
  contact_expire_after?: number
  contacts_count?: number
  country?: string
  created_by?: string
  date_created?: string
  date_updated?: string
  description?: string
  email?: string
  first_name?: string
  gender?: string
  groups?: any[]
  id?: string
  idx?: string
  last_name?: string
  name?: string
  permissions?: any[]
  phone_number?: string
  read?: boolean
  send?: boolean
  source?: string
  type?: string
  value?: string
  write?: boolean
}

export interface ContactsgroupRemoveMatch {
  group_id: string
}

export interface Contactstrash {
}

export interface ContactstrashUpdateData {
}

export interface ContactstrashRemoveMatch {
}

export interface FieldAvailable {
  built_in?: boolean
  id?: string
  name?: string
  options?: any[]
  type?: string
}

export interface FieldAvailableListMatch {
  built_in?: boolean
  id?: string
  name?: string
  options?: any[]
  type?: string
}

export interface Group {
  contact_expire_after: number
  contacts_count: number
  created_by: string
  date_created: string
  date_updated: string
  description: string
  id: string
  idx?: string
  name: string
  permissions?: any[]
}

export interface GroupLoadMatch {
  id: string
}

export interface GroupUpdateData {
  id: string
  contact_expire_after?: number
  contacts_count?: number
  created_by?: string
  date_created?: string
  date_updated?: string
  description?: string
  idx?: string
  name?: string
  permissions?: any[]
}

export interface MfaCode {
  content?: string
  fast?: any
  from?: string
  phone_number: string
}

export interface MfaCodeCreateData {
  content?: string
  fast?: any
  from?: string
  phone_number: string

  // Selects a custom action instead of the plain create:
  //   'verification'
  // The remaining keys are that action's own payload.
  $action?: string
  [action: string]: any
}

export interface OptOut {
  date?: string
  id?: string
  links?: any[]
  phoneNumber?: number
}

export interface OptOutListMatch {
  limit?: number
  offset?: number
  phone_number?: string
}

export interface OptOutRemoveMatch {
  id: string
}

export interface OptOutSetting {
  brand?: string
}

export interface OptOutSettingLoadMatch {
  brand?: string
}

export interface OptOutSettingUpdateData {
  brand?: string
}

export interface Permission {
  group_id: string
  id?: string
  read: boolean
  send: boolean
  username: string
  write: boolean
}

export interface PermissionLoadMatch {
  group_id: string
  id: string
  username: string
}

export interface PermissionCreateData {
  group_id: string
  id?: string
  read: boolean
  send: boolean
  username: string
  write: boolean
}

export interface Ping {
  authorized: boolean
  unavailable: any[]
}

export interface PingListMatch {
  authorized?: boolean
  unavailable?: any[]
}

export interface Profile {
  email: string
  name: string
  payment_type: string
  phone_number: number
  points?: number
  user_type: string
  username: string
}

export interface ProfileLoadMatch {
  email?: string
  name?: string
  payment_type?: string
  phone_number?: number
  points?: number
  user_type?: string
  username?: string
}

export interface ProfileListMatch {
  type?: string

  // Selects a custom action instead of the plain list:
  //   'price'
  // The remaining keys are that action's own payload.
  $action?: string
  [action: string]: any
}

export interface Rcs {
}

export interface RcsListMatch {

  // Selects a custom action instead of the plain list:
  //   'message'
  // The remaining keys are that action's own payload.
  $action?: string
  [action: string]: any
}

export interface Sendername {
  created_at?: string
  id?: string
  is_default?: boolean
  sender?: string
  status?: string
}

export interface SendernameLoadMatch {
  id: string
}

export interface SendernameListMatch {
  created_at?: string
  id?: string
  is_default?: boolean
  sender?: string
  status?: string
}

export interface SendernameCreateData {
  created_at?: string
  id?: string
  is_default?: boolean
  sender?: string
  status?: string
}

export interface SendernameStatement {
  content?: string
  statements?: any[]
  title?: string
}

export interface SendernameStatementListMatch {
  content?: string
  statements?: any[]
  title?: string
}

export interface SentRcsMessage {
  content?: Record<string, any>
  phone_number: string
  sender: any
  text?: string
}

export interface SentRcsMessageCreateData {
  content?: Record<string, any>
  phone_number: string
  sender: any
  text?: string
}

export interface ShipmentCountryVolume {
  country_code?: string
  country_limit?: number
  country_name?: string
  usage?: number
}

export interface ShipmentCountryVolumeListMatch {
  month?: string
  year?: string
}

export interface ShortUrl {
  description?: string
  expire?: string
  filename?: string
  hits?: number
  hits_unique?: number
  id?: string
  name?: string
  short_url?: string
  type?: string
  url?: string
}

export interface ShortUrlLoadMatch {
  id: string
}

export interface ShortUrlListMatch {
  description?: string
  expire?: string
  filename?: string
  hits?: number
  hits_unique?: number
  id?: string
  name?: string
  short_url?: string
  type?: string
  url?: string

  // Selects a custom action instead of the plain list:
  //   'link'
  // The remaining keys are that action's own payload.
  $action?: string
  [action: string]: any
}

export interface ShortUrlCreateData {
  description?: string
  expire?: string
  filename?: string
  hits?: number
  hits_unique?: number
  id?: string
  name?: string
  short_url?: string
  type?: string
  url?: string

  // Selects a custom action instead of the plain create:
  //   'link'
  // The remaining keys are that action's own payload.
  $action?: string
  [action: string]: any
}

export interface ShortUrlUpdateData {
  id: string
  description?: string
  expire?: string
  filename?: string
  hits?: number
  hits_unique?: number
  name?: string
  short_url?: string
  type?: string
  url?: string
}

export interface ShortUrlRemoveMatch {
  id: string
}

export interface Smsdo {
  allow_duplicates?: number
  check_idx?: any
  date?: any
  date_validate?: number
  details?: any
  encoding?: string
  expiration_date?: any
  fallback?: any[]
  fast?: number
  flash?: number
  format?: string
  from?: string
  group?: string
  idx?: string
  max_parts?: number
  message?: string
  normalize?: number
  notify_url?: string
  test?: any
  time_restriction?: string
  to?: string
}

export interface SmsdoCreateData {
  allow_duplicates?: number
  check_idx?: any
  date?: any
  date_validate?: number
  details?: any
  encoding?: string
  expiration_date?: any
  fallback?: any[]
  fast?: number
  flash?: number
  format?: string
  from?: string
  group?: string
  idx?: string
  max_parts?: number
  message?: string
  normalize?: number
  notify_url?: string
  test?: any
  time_restriction?: string
  to?: string
}

export interface Smssendername {
}

export interface SmssendernameCreateData {
  sendername_id: string
}

export interface SmssendernameRemoveMatch {
  sender: string
}

export interface Smstemplate {
  id?: string
}

export interface SmstemplateRemoveMatch {
  id: string
}

export interface Subuser {
  active?: boolean
  credentials: Record<string, any>
  description?: string
  id?: string
  points?: Record<string, any>
  username?: string
}

export interface SubuserLoadMatch {
  id: string
}

export interface SubuserListMatch {
  q?: string

  // Selects a custom action instead of the plain list:
  //   'share_sendername' | 'share_template'
  // The remaining keys are that action's own payload.
  $action?: string
  [action: string]: any
}

export interface SubuserCreateData {
  active?: boolean
  credentials: Record<string, any>
  description?: string
  id?: string
  points?: Record<string, any>
  username?: string
}

export interface SubuserUpdateData {
  id: string
  active?: boolean
  credentials?: Record<string, any>
  description?: string
  points?: Record<string, any>
  username?: string

  // Selects a custom action instead of the plain update:
  //   'share_sendername' | 'share_template'
  // The remaining keys are that action's own payload.
  $action?: string
  [action: string]: any
}

export interface SubuserRemoveMatch {
  id: string
}

export interface Template {
  id?: string
  name?: string
  normalize?: boolean
  template?: string
}

export interface TemplateLoadMatch {
  id: string
}

export interface TemplateListMatch {
  id?: string
  name?: string
  normalize?: boolean
  template?: string
}

export interface TemplateCreateData {
  id?: string
  name?: string
  normalize?: boolean
  template?: string
}

export interface TemplateUpdateData {
  id: string
  name?: string
  normalize?: boolean
  template?: string
}

export interface UserRcsSenderCollection {
  deliveredAt?: string
  expiredAt?: string
  id?: string
  interface?: string
  messageType?: string
  readAt?: string
  recipient?: string
  sender?: string
  senderId?: string
  sentAt?: string
}

export interface UserRcsSenderCollectionListMatch {
  deliveredAt?: string
  expiredAt?: string
  id?: string
  interface?: string
  messageType?: string
  readAt?: string
  recipient?: string
  sender?: string
  senderId?: string
  sentAt?: string
}

