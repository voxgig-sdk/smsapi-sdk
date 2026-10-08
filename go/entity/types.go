// Typed models for the Smsapi SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields{} and per-op
// params (op.<name>.points[].g.params[]). Field/param types come from the
// canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
// @voxgig/apidef VALID_CANON). Do not edit by hand.
package entity

import (
	"encoding/json"

	"github.com/voxgig-sdk/smsapi-sdk/go/core"
)

// Available is the typed data model for the available entity.
type Available struct {
}

// AvailableListMatch is the typed request payload for Available.ListTyped.
type AvailableListMatch struct {
	Name *string `json:"name,omitempty"`
	Normalize *bool `json:"normalize,omitempty"`
	Template *string `json:"template,omitempty"`
}

// Blacklist is the typed data model for the blacklist entity.
type Blacklist struct {
}

// BlacklistLoadMatch is the typed request payload for Blacklist.LoadTyped.
type BlacklistLoadMatch struct {
	Limit *int `json:"limit,omitempty"`
	Offset *int `json:"offset,omitempty"`
	Q *int `json:"q,omitempty"`
}

// BlacklistCreateData is the typed request payload for Blacklist.CreateTyped.
type BlacklistCreateData struct {
	Id *string `json:"id,omitempty"`
}

// BlacklistRemoveMatch is the typed request payload for Blacklist.RemoveTyped.
type BlacklistRemoveMatch struct {
	Id string `json:"id"`
}

// Callback is the typed data model for the callback entity.
type Callback struct {
}

// CallbackLoadMatch is the typed request payload for Callback.LoadTyped.
type CallbackLoadMatch struct {
	Id string `json:"id"`
}

// CallbackListMatch is the typed request payload for Callback.ListTyped.
type CallbackListMatch struct {
	Active *bool `json:"active,omitempty"`
	ApiVersion *int `json:"api_version,omitempty"`
	Id *string `json:"id,omitempty"`
	Invalid *bool `json:"invalid,omitempty"`
	Receiver *map[string]any `json:"receiver,omitempty"`
	ReceiverType *string `json:"receiver_type,omitempty"`
	Type *string `json:"type,omitempty"`
	Url *string `json:"url,omitempty"`
}

// CallbackCreateData is the typed request payload for Callback.CreateTyped.
type CallbackCreateData struct {
	Active *bool `json:"active,omitempty"`
	ApiVersion *int `json:"api_version,omitempty"`
	Id *string `json:"id,omitempty"`
	Invalid *bool `json:"invalid,omitempty"`
	Receiver *map[string]any `json:"receiver,omitempty"`
	ReceiverType *string `json:"receiver_type,omitempty"`
	Type *string `json:"type,omitempty"`
	Url *string `json:"url,omitempty"`
}

// CallbackUpdateData is the typed request payload for Callback.UpdateTyped.
type CallbackUpdateData struct {
	Id string `json:"id"`
	Active *bool `json:"active,omitempty"`
	ApiVersion *int `json:"api_version,omitempty"`
	Invalid *bool `json:"invalid,omitempty"`
	Receiver *map[string]any `json:"receiver,omitempty"`
	ReceiverType *string `json:"receiver_type,omitempty"`
	Type *string `json:"type,omitempty"`
	Url *string `json:"url,omitempty"`
}

// CallbackRemoveMatch is the typed request payload for Callback.RemoveTyped.
type CallbackRemoveMatch struct {
	Id string `json:"id"`
}

// Contact is the typed data model for the contact entity.
type Contact struct {
}

// ContactLoadMatch is the typed request payload for Contact.LoadTyped.
type ContactLoadMatch struct {
	Id string `json:"id"`
}

// ContactListMatch is the typed request payload for Contact.ListTyped.
type ContactListMatch struct {
	BirthdayDate *[]any `json:"birthday_date,omitempty"`
	Email *[]any `json:"email,omitempty"`
	FirstName *[]any `json:"first_name,omitempty"`
	Gender *string `json:"gender,omitempty"`
	GroupId *[]any `json:"group_id,omitempty"`
	LastName *[]any `json:"last_name,omitempty"`
	Limit *int `json:"limit,omitempty"`
	Offset *int `json:"offset,omitempty"`
	OrderBy *string `json:"order_by,omitempty"`
	PhoneNumber *[]any `json:"phone_number,omitempty"`
	Q *string `json:"q,omitempty"`
}

// ContactCreateData is the typed request payload for Contact.CreateTyped.
type ContactCreateData struct {
	BirthdayDate *string `json:"birthday_date,omitempty"`
	City *string `json:"city,omitempty"`
	Collection []any `json:"collection"`
	ContactExpireAfter int `json:"contact_expire_after"`
	ContactsCount int `json:"contacts_count"`
	Country *string `json:"country,omitempty"`
	CreatedBy string `json:"created_by"`
	DateCreated string `json:"date_created"`
	DateUpdated string `json:"date_updated"`
	Description *string `json:"description,omitempty"`
	Email *string `json:"email,omitempty"`
	FirstName *string `json:"first_name,omitempty"`
	Gender string `json:"gender"`
	Groups []any `json:"groups"`
	Id string `json:"id"`
	Idx *string `json:"idx,omitempty"`
	LastName *string `json:"last_name,omitempty"`
	Name string `json:"name"`
	Permissions *[]any `json:"permissions,omitempty"`
	PhoneNumber *string `json:"phone_number,omitempty"`
	Size int `json:"size"`
	Source *string `json:"source,omitempty"`
}

// ContactUpdateData is the typed request payload for Contact.UpdateTyped.
type ContactUpdateData struct {
	Id string `json:"id"`
	BirthdayDate *string `json:"birthday_date,omitempty"`
	City *string `json:"city,omitempty"`
	Collection *[]any `json:"collection,omitempty"`
	ContactExpireAfter *int `json:"contact_expire_after,omitempty"`
	ContactsCount *int `json:"contacts_count,omitempty"`
	Country *string `json:"country,omitempty"`
	CreatedBy *string `json:"created_by,omitempty"`
	DateCreated *string `json:"date_created,omitempty"`
	DateUpdated *string `json:"date_updated,omitempty"`
	Description *string `json:"description,omitempty"`
	Email *string `json:"email,omitempty"`
	FirstName *string `json:"first_name,omitempty"`
	Gender *string `json:"gender,omitempty"`
	Groups *[]any `json:"groups,omitempty"`
	Idx *string `json:"idx,omitempty"`
	LastName *string `json:"last_name,omitempty"`
	Name *string `json:"name,omitempty"`
	Permissions *[]any `json:"permissions,omitempty"`
	PhoneNumber *string `json:"phone_number,omitempty"`
	Size *int `json:"size,omitempty"`
	Source *string `json:"source,omitempty"`
}

// ContactRemoveMatch is the typed request payload for Contact.RemoveTyped.
type ContactRemoveMatch struct {
	Id string `json:"id"`
}

// ContactsField is the typed data model for the contacts_field entity.
type ContactsField struct {
}

// ContactsFieldListMatch is the typed request payload for ContactsField.ListTyped.
type ContactsFieldListMatch struct {
	Id *string `json:"id,omitempty"`
	Name *string `json:"name,omitempty"`
	Type *string `json:"type,omitempty"`
}

// ContactsFieldCreateData is the typed request payload for ContactsField.CreateTyped.
type ContactsFieldCreateData struct {
	Id *string `json:"id,omitempty"`
	Name *string `json:"name,omitempty"`
	Type *string `json:"type,omitempty"`
}

// ContactsFieldUpdateData is the typed request payload for ContactsField.UpdateTyped.
type ContactsFieldUpdateData struct {
	Id string `json:"id"`
	Name *string `json:"name,omitempty"`
	Type *string `json:"type,omitempty"`
}

// ContactsFieldRemoveMatch is the typed request payload for ContactsField.RemoveTyped.
type ContactsFieldRemoveMatch struct {
	Id string `json:"id"`
}

// ContactsFieldOption is the typed data model for the contacts_field_option entity.
type ContactsFieldOption struct {
}

// ContactsFieldOptionListMatch is the typed request payload for ContactsFieldOption.ListTyped.
type ContactsFieldOptionListMatch struct {
	FieldId string `json:"field_id"`
}

// Contactsgroup is the typed data model for the contactsgroup entity.
type Contactsgroup struct {
}

// ContactsgroupListMatch is the typed request payload for Contactsgroup.ListTyped.
type ContactsgroupListMatch struct {
	Name *map[string]any `json:"name,omitempty"`
	With *[]any `json:"with,omitempty"`
}

// ContactsgroupCreateData is the typed request payload for Contactsgroup.CreateTyped.
type ContactsgroupCreateData struct {
	GroupId string `json:"group_id"`
	Read bool `json:"read"`
	Send bool `json:"send"`
	Username string `json:"username"`
	Write bool `json:"write"`
}

// ContactsgroupUpdateData is the typed request payload for Contactsgroup.UpdateTyped.
type ContactsgroupUpdateData struct {
	GroupId string `json:"group_id"`
	Username *string `json:"username,omitempty"`
	Read *bool `json:"read,omitempty"`
	Send *bool `json:"send,omitempty"`
	Write *bool `json:"write,omitempty"`
}

// ContactsgroupRemoveMatch is the typed request payload for Contactsgroup.RemoveTyped.
type ContactsgroupRemoveMatch struct {
	GroupId string `json:"group_id"`
}

// Contactstrash is the typed data model for the contactstrash entity.
type Contactstrash struct {
}

// ContactstrashUpdateData is the typed request payload for Contactstrash.UpdateTyped.
type ContactstrashUpdateData struct {
}

// ContactstrashRemoveMatch is the typed request payload for Contactstrash.RemoveTyped.
type ContactstrashRemoveMatch struct {
}

// FieldAvailable is the typed data model for the field_available entity.
type FieldAvailable struct {
}

// FieldAvailableListMatch is the typed request payload for FieldAvailable.ListTyped.
type FieldAvailableListMatch struct {
	BuiltIn *bool `json:"built_in,omitempty"`
	Id *string `json:"id,omitempty"`
	Name *string `json:"name,omitempty"`
	Options *[]any `json:"options,omitempty"`
	Type *string `json:"type,omitempty"`
}

// Group is the typed data model for the group entity.
type Group struct {
}

// GroupLoadMatch is the typed request payload for Group.LoadTyped.
type GroupLoadMatch struct {
	Id string `json:"id"`
}

// GroupUpdateData is the typed request payload for Group.UpdateTyped.
type GroupUpdateData struct {
	Id string `json:"id"`
	ContactExpireAfter *int `json:"contact_expire_after,omitempty"`
	ContactsCount *int `json:"contacts_count,omitempty"`
	CreatedBy *string `json:"created_by,omitempty"`
	DateCreated *string `json:"date_created,omitempty"`
	DateUpdated *string `json:"date_updated,omitempty"`
	Description *string `json:"description,omitempty"`
	Idx *string `json:"idx,omitempty"`
	Name *string `json:"name,omitempty"`
	Permissions *[]any `json:"permissions,omitempty"`
}

// MfaCode is the typed data model for the mfa_code entity.
type MfaCode struct {
}

// MfaCodeCreateData is the typed request payload for MfaCode.CreateTyped.
type MfaCodeCreateData struct {
	Content *string `json:"content,omitempty"`
	Fast *any `json:"fast,omitempty"`
	From *string `json:"from,omitempty"`
	PhoneNumber string `json:"phone_number"`
}

// OptOut is the typed data model for the opt_out entity.
type OptOut struct {
}

// OptOutListMatch is the typed request payload for OptOut.ListTyped.
type OptOutListMatch struct {
	Limit *int `json:"limit,omitempty"`
	Offset *int `json:"offset,omitempty"`
	PhoneNumber *string `json:"phone_number,omitempty"`
}

// OptOutRemoveMatch is the typed request payload for OptOut.RemoveTyped.
type OptOutRemoveMatch struct {
	Id string `json:"id"`
}

// OptOutSetting is the typed data model for the opt_out_setting entity.
type OptOutSetting struct {
}

// OptOutSettingLoadMatch is the typed request payload for OptOutSetting.LoadTyped.
type OptOutSettingLoadMatch struct {
	Brand *string `json:"brand,omitempty"`
}

// OptOutSettingUpdateData is the typed request payload for OptOutSetting.UpdateTyped.
type OptOutSettingUpdateData struct {
	Brand *string `json:"brand,omitempty"`
}

// Permission is the typed data model for the permission entity.
type Permission struct {
}

// PermissionLoadMatch is the typed request payload for Permission.LoadTyped.
type PermissionLoadMatch struct {
	GroupId string `json:"group_id"`
	Id string `json:"id"`
}

// PermissionCreateData is the typed request payload for Permission.CreateTyped.
type PermissionCreateData struct {
	GroupId string `json:"group_id"`
	Id *string `json:"id,omitempty"`
	Read bool `json:"read"`
	Send bool `json:"send"`
	Username string `json:"username"`
	Write bool `json:"write"`
}

// Ping is the typed data model for the ping entity.
type Ping struct {
}

// PingListMatch is the typed request payload for Ping.ListTyped.
type PingListMatch struct {
	Authorized *bool `json:"authorized,omitempty"`
	Unavailable *[]any `json:"unavailable,omitempty"`
}

// Profile is the typed data model for the profile entity.
type Profile struct {
}

// ProfileLoadMatch is the typed request payload for Profile.LoadTyped.
type ProfileLoadMatch struct {
	Email *string `json:"email,omitempty"`
	Name *string `json:"name,omitempty"`
	PaymentType *string `json:"payment_type,omitempty"`
	PhoneNumber *int `json:"phone_number,omitempty"`
	Points *float64 `json:"points,omitempty"`
	UserType *string `json:"user_type,omitempty"`
	Username *string `json:"username,omitempty"`
}

// ProfileListMatch is the typed request payload for Profile.ListTyped.
type ProfileListMatch struct {
	Type *string `json:"type,omitempty"`
}

// Rcs is the typed data model for the rcs entity.
type Rcs struct {
}

// RcsListMatch is the typed request payload for Rcs.ListTyped.
type RcsListMatch struct {
}

// Sendername is the typed data model for the sendername entity.
type Sendername struct {
}

// SendernameLoadMatch is the typed request payload for Sendername.LoadTyped.
type SendernameLoadMatch struct {
	Id string `json:"id"`
}

// SendernameListMatch is the typed request payload for Sendername.ListTyped.
type SendernameListMatch struct {
	CreatedAt *string `json:"created_at,omitempty"`
	Id *string `json:"id,omitempty"`
	IsDefault *bool `json:"is_default,omitempty"`
	Sender *string `json:"sender,omitempty"`
	Status *string `json:"status,omitempty"`
}

// SendernameCreateData is the typed request payload for Sendername.CreateTyped.
type SendernameCreateData struct {
	CreatedAt *string `json:"created_at,omitempty"`
	Id *string `json:"id,omitempty"`
	IsDefault *bool `json:"is_default,omitempty"`
	Sender *string `json:"sender,omitempty"`
	Status *string `json:"status,omitempty"`
}

// SendernameStatement is the typed data model for the sendername_statement entity.
type SendernameStatement struct {
}

// SendernameStatementListMatch is the typed request payload for SendernameStatement.ListTyped.
type SendernameStatementListMatch struct {
	Content *string `json:"content,omitempty"`
	Statements *[]any `json:"statements,omitempty"`
	Title *string `json:"title,omitempty"`
}

// SentRcsMessage is the typed data model for the sent_rcs_message entity.
type SentRcsMessage struct {
}

// SentRcsMessageCreateData is the typed request payload for SentRcsMessage.CreateTyped.
type SentRcsMessageCreateData struct {
	Content *map[string]any `json:"content,omitempty"`
	PhoneNumber string `json:"phone_number"`
	Sender string `json:"sender"`
	Text *string `json:"text,omitempty"`
}

// ShipmentCountryVolume is the typed data model for the shipment_country_volume entity.
type ShipmentCountryVolume struct {
}

// ShipmentCountryVolumeListMatch is the typed request payload for ShipmentCountryVolume.ListTyped.
type ShipmentCountryVolumeListMatch struct {
	Month *string `json:"month,omitempty"`
	Year *string `json:"year,omitempty"`
}

// ShortUrl is the typed data model for the short_url entity.
type ShortUrl struct {
}

// ShortUrlLoadMatch is the typed request payload for ShortUrl.LoadTyped.
type ShortUrlLoadMatch struct {
	Id string `json:"id"`
}

// ShortUrlListMatch is the typed request payload for ShortUrl.ListTyped.
type ShortUrlListMatch struct {
	Description *string `json:"description,omitempty"`
	Expire *string `json:"expire,omitempty"`
	Filename *string `json:"filename,omitempty"`
	Hits *int `json:"hits,omitempty"`
	HitsUnique *int `json:"hits_unique,omitempty"`
	Id *string `json:"id,omitempty"`
	Name *string `json:"name,omitempty"`
	ShortUrl *string `json:"short_url,omitempty"`
	Type *string `json:"type,omitempty"`
	Url *string `json:"url,omitempty"`
}

// ShortUrlCreateData is the typed request payload for ShortUrl.CreateTyped.
type ShortUrlCreateData struct {
	Description *string `json:"description,omitempty"`
	Expire *string `json:"expire,omitempty"`
	Filename *string `json:"filename,omitempty"`
	Hits *int `json:"hits,omitempty"`
	HitsUnique *int `json:"hits_unique,omitempty"`
	Id *string `json:"id,omitempty"`
	Name *string `json:"name,omitempty"`
	ShortUrl *string `json:"short_url,omitempty"`
	Type *string `json:"type,omitempty"`
	Url *string `json:"url,omitempty"`
}

// ShortUrlUpdateData is the typed request payload for ShortUrl.UpdateTyped.
type ShortUrlUpdateData struct {
	Id string `json:"id"`
	Description *string `json:"description,omitempty"`
	Expire *string `json:"expire,omitempty"`
	Filename *string `json:"filename,omitempty"`
	Hits *int `json:"hits,omitempty"`
	HitsUnique *int `json:"hits_unique,omitempty"`
	Name *string `json:"name,omitempty"`
	ShortUrl *string `json:"short_url,omitempty"`
	Type *string `json:"type,omitempty"`
	Url *string `json:"url,omitempty"`
}

// ShortUrlRemoveMatch is the typed request payload for ShortUrl.RemoveTyped.
type ShortUrlRemoveMatch struct {
	Id string `json:"id"`
}

// Smsdo is the typed data model for the smsdo entity.
type Smsdo struct {
}

// SmsdoCreateData is the typed request payload for Smsdo.CreateTyped.
type SmsdoCreateData struct {
	AllowDuplicates *int `json:"allow_duplicates,omitempty"`
	CheckIdx *any `json:"check_idx,omitempty"`
	Date *any `json:"date,omitempty"`
	DateValidate *int `json:"date_validate,omitempty"`
	Details *any `json:"details,omitempty"`
	Encoding *string `json:"encoding,omitempty"`
	ExpirationDate *any `json:"expiration_date,omitempty"`
	Fallback *[]any `json:"fallback,omitempty"`
	Fast *int `json:"fast,omitempty"`
	Flash *int `json:"flash,omitempty"`
	Format *string `json:"format,omitempty"`
	From *string `json:"from,omitempty"`
	Group *string `json:"group,omitempty"`
	Idx *string `json:"idx,omitempty"`
	MaxParts *int `json:"max_parts,omitempty"`
	Message *string `json:"message,omitempty"`
	Normalize *int `json:"normalize,omitempty"`
	NotifyUrl *string `json:"notify_url,omitempty"`
	Test *any `json:"test,omitempty"`
	TimeRestriction *string `json:"time_restriction,omitempty"`
	To *string `json:"to,omitempty"`
}

// Smssendername is the typed data model for the smssendername entity.
type Smssendername struct {
}

// SmssendernameCreateData is the typed request payload for Smssendername.CreateTyped.
type SmssendernameCreateData struct {
	Sender string `json:"sender"`
}

// SmssendernameRemoveMatch is the typed request payload for Smssendername.RemoveTyped.
type SmssendernameRemoveMatch struct {
	Sender string `json:"sender"`
}

// Smstemplate is the typed data model for the smstemplate entity.
type Smstemplate struct {
}

// SmstemplateRemoveMatch is the typed request payload for Smstemplate.RemoveTyped.
type SmstemplateRemoveMatch struct {
	Id string `json:"id"`
}

// Subuser is the typed data model for the subuser entity.
type Subuser struct {
}

// SubuserLoadMatch is the typed request payload for Subuser.LoadTyped.
type SubuserLoadMatch struct {
	Id string `json:"id"`
}

// SubuserListMatch is the typed request payload for Subuser.ListTyped.
type SubuserListMatch struct {
	Q *string `json:"q,omitempty"`
}

// SubuserCreateData is the typed request payload for Subuser.CreateTyped.
type SubuserCreateData struct {
	Active *bool `json:"active,omitempty"`
	Credentials map[string]any `json:"credentials"`
	Description *string `json:"description,omitempty"`
	Id *string `json:"id,omitempty"`
	Points *map[string]any `json:"points,omitempty"`
	Username *string `json:"username,omitempty"`
}

// SubuserUpdateData is the typed request payload for Subuser.UpdateTyped.
type SubuserUpdateData struct {
	Id string `json:"id"`
	Active *bool `json:"active,omitempty"`
	Credentials *map[string]any `json:"credentials,omitempty"`
	Description *string `json:"description,omitempty"`
	Points *map[string]any `json:"points,omitempty"`
	Username *string `json:"username,omitempty"`
}

// SubuserRemoveMatch is the typed request payload for Subuser.RemoveTyped.
type SubuserRemoveMatch struct {
	Id string `json:"id"`
}

// Template is the typed data model for the template entity.
type Template struct {
}

// TemplateLoadMatch is the typed request payload for Template.LoadTyped.
type TemplateLoadMatch struct {
	Id string `json:"id"`
}

// TemplateListMatch is the typed request payload for Template.ListTyped.
type TemplateListMatch struct {
	Id *string `json:"id,omitempty"`
	Name *string `json:"name,omitempty"`
	Normalize *bool `json:"normalize,omitempty"`
	Template *string `json:"template,omitempty"`
}

// TemplateCreateData is the typed request payload for Template.CreateTyped.
type TemplateCreateData struct {
	Id *string `json:"id,omitempty"`
	Name *string `json:"name,omitempty"`
	Normalize *bool `json:"normalize,omitempty"`
	Template *string `json:"template,omitempty"`
}

// TemplateUpdateData is the typed request payload for Template.UpdateTyped.
type TemplateUpdateData struct {
	Id string `json:"id"`
	Name *string `json:"name,omitempty"`
	Normalize *bool `json:"normalize,omitempty"`
	Template *string `json:"template,omitempty"`
}

// UserRcsSenderCollection is the typed data model for the user_rcs_sender_collection entity.
type UserRcsSenderCollection struct {
}

// UserRcsSenderCollectionListMatch is the typed request payload for UserRcsSenderCollection.ListTyped.
type UserRcsSenderCollectionListMatch struct {
}

// asMap turns a typed request/data struct into the map[string]any the
// runtime op pipeline consumes, honouring the json tags above.
func asMap(v any) map[string]any {
	out := map[string]any{}
	b, err := json.Marshal(v)
	if err != nil {
		return out
	}
	_ = json.Unmarshal(b, &out)
	return out
}

// entityData unwraps an entity to its data map.
//
// Operations resolve to the ENTITY, not the raw data (see AGENTS.md), and an
// entity's fields are UNEXPORTED — marshalling one directly yields `{}`, so
// every typed accessor would silently hand back a zero-valued struct. The
// typed boundary therefore takes the data hop first.
func entityData(v any) any {
	if ent, ok := v.(core.Entity); ok {
		return ent.Data()
	}
	return v
}

// typedFrom decodes a runtime value (an entity, or the map[string]any the op
// pipeline produced) into a typed model T via a JSON round-trip. On any error
// it returns the zero value of T; the op's own (value, error) tuple carries
// the real error.
func typedFrom[T any](v any) T {
	var out T
	v = entityData(v)
	if v == nil {
		return out
	}
	b, err := json.Marshal(v)
	if err != nil {
		return out
	}
	_ = json.Unmarshal(b, &out)
	return out
}

// typedSliceFrom decodes a runtime list value into a typed slice []T via a
// JSON round-trip, for list ops. `list` resolves to a slice of ENTITY
// instances, so each element takes the data hop.
func typedSliceFrom[T any](v any) []T {
	var out []T
	if v == nil {
		return out
	}
	if list, ok := v.([]any); ok {
		unwrapped := make([]any, 0, len(list))
		for _, item := range list {
			unwrapped = append(unwrapped, entityData(item))
		}
		v = unwrapped
	}
	b, err := json.Marshal(v)
	if err != nil {
		return out
	}
	_ = json.Unmarshal(b, &out)
	return out
}
