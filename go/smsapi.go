package voxgigsmsapisdk

import (
	"github.com/voxgig-sdk/smsapi-sdk/go/core"
	"github.com/voxgig-sdk/smsapi-sdk/go/entity"
	"github.com/voxgig-sdk/smsapi-sdk/go/feature"
	_ "github.com/voxgig-sdk/smsapi-sdk/go/utility"
)

// Type aliases preserve external API.
type SmsapiSDK = core.SmsapiSDK
type Context = core.Context
type Utility = core.Utility
type Feature = core.Feature
type Entity = core.Entity
type SmsapiEntity = core.SmsapiEntity
type StreamItem = core.StreamItem
type FetcherFunc = core.FetcherFunc
type Spec = core.Spec
type Result = core.Result
type Response = core.Response
type Operation = core.Operation
type Control = core.Control
type SmsapiError = core.SmsapiError

// BaseFeature from feature package.
type BaseFeature = feature.BaseFeature

func init() {
	core.NewBaseFeatureFunc = func() core.Feature {
		return feature.NewBaseFeature()
	}
	core.NewAuditFeatureFunc = func() core.Feature {
		return feature.NewAuditFeature()
	}
	core.NewCacheFeatureFunc = func() core.Feature {
		return feature.NewCacheFeature()
	}
	core.NewClienttrackFeatureFunc = func() core.Feature {
		return feature.NewClienttrackFeature()
	}
	core.NewCostFeatureFunc = func() core.Feature {
		return feature.NewCostFeature()
	}
	core.NewDebugFeatureFunc = func() core.Feature {
		return feature.NewDebugFeature()
	}
	core.NewIdempotencyFeatureFunc = func() core.Feature {
		return feature.NewIdempotencyFeature()
	}
	core.NewLogFeatureFunc = func() core.Feature {
		return feature.NewLogFeature()
	}
	core.NewMetricsFeatureFunc = func() core.Feature {
		return feature.NewMetricsFeature()
	}
	core.NewNetsimFeatureFunc = func() core.Feature {
		return feature.NewNetsimFeature()
	}
	core.NewPagingFeatureFunc = func() core.Feature {
		return feature.NewPagingFeature()
	}
	core.NewProxyFeatureFunc = func() core.Feature {
		return feature.NewProxyFeature()
	}
	core.NewRatelimitFeatureFunc = func() core.Feature {
		return feature.NewRatelimitFeature()
	}
	core.NewRbacFeatureFunc = func() core.Feature {
		return feature.NewRbacFeature()
	}
	core.NewRetryFeatureFunc = func() core.Feature {
		return feature.NewRetryFeature()
	}
	core.NewSecretsFeatureFunc = func() core.Feature {
		return feature.NewSecretsFeature()
	}
	core.NewStreamingFeatureFunc = func() core.Feature {
		return feature.NewStreamingFeature()
	}
	core.NewTelemetryFeatureFunc = func() core.Feature {
		return feature.NewTelemetryFeature()
	}
	core.NewTestFeatureFunc = func() core.Feature {
		return feature.NewTestFeature()
	}
	core.NewTimeoutFeatureFunc = func() core.Feature {
		return feature.NewTimeoutFeature()
	}
	core.NewValidateFeatureFunc = func() core.Feature {
		return feature.NewValidateFeature()
	}
	core.NewAvailableEntityFunc = func(client *core.SmsapiSDK, entopts map[string]any) core.SmsapiEntity {
		return entity.NewAvailableEntity(client, entopts)
	}
	core.NewBlacklistEntityFunc = func(client *core.SmsapiSDK, entopts map[string]any) core.SmsapiEntity {
		return entity.NewBlacklistEntity(client, entopts)
	}
	core.NewCallbackEntityFunc = func(client *core.SmsapiSDK, entopts map[string]any) core.SmsapiEntity {
		return entity.NewCallbackEntity(client, entopts)
	}
	core.NewContactEntityFunc = func(client *core.SmsapiSDK, entopts map[string]any) core.SmsapiEntity {
		return entity.NewContactEntity(client, entopts)
	}
	core.NewContactsFieldEntityFunc = func(client *core.SmsapiSDK, entopts map[string]any) core.SmsapiEntity {
		return entity.NewContactsFieldEntity(client, entopts)
	}
	core.NewContactsFieldOptionEntityFunc = func(client *core.SmsapiSDK, entopts map[string]any) core.SmsapiEntity {
		return entity.NewContactsFieldOptionEntity(client, entopts)
	}
	core.NewContactsgroupEntityFunc = func(client *core.SmsapiSDK, entopts map[string]any) core.SmsapiEntity {
		return entity.NewContactsgroupEntity(client, entopts)
	}
	core.NewContactstrashEntityFunc = func(client *core.SmsapiSDK, entopts map[string]any) core.SmsapiEntity {
		return entity.NewContactstrashEntity(client, entopts)
	}
	core.NewFieldAvailableEntityFunc = func(client *core.SmsapiSDK, entopts map[string]any) core.SmsapiEntity {
		return entity.NewFieldAvailableEntity(client, entopts)
	}
	core.NewGroupEntityFunc = func(client *core.SmsapiSDK, entopts map[string]any) core.SmsapiEntity {
		return entity.NewGroupEntity(client, entopts)
	}
	core.NewMfaCodeEntityFunc = func(client *core.SmsapiSDK, entopts map[string]any) core.SmsapiEntity {
		return entity.NewMfaCodeEntity(client, entopts)
	}
	core.NewOptOutEntityFunc = func(client *core.SmsapiSDK, entopts map[string]any) core.SmsapiEntity {
		return entity.NewOptOutEntity(client, entopts)
	}
	core.NewOptOutSettingEntityFunc = func(client *core.SmsapiSDK, entopts map[string]any) core.SmsapiEntity {
		return entity.NewOptOutSettingEntity(client, entopts)
	}
	core.NewPermissionEntityFunc = func(client *core.SmsapiSDK, entopts map[string]any) core.SmsapiEntity {
		return entity.NewPermissionEntity(client, entopts)
	}
	core.NewPingEntityFunc = func(client *core.SmsapiSDK, entopts map[string]any) core.SmsapiEntity {
		return entity.NewPingEntity(client, entopts)
	}
	core.NewProfileEntityFunc = func(client *core.SmsapiSDK, entopts map[string]any) core.SmsapiEntity {
		return entity.NewProfileEntity(client, entopts)
	}
	core.NewRcsEntityFunc = func(client *core.SmsapiSDK, entopts map[string]any) core.SmsapiEntity {
		return entity.NewRcsEntity(client, entopts)
	}
	core.NewSendernameEntityFunc = func(client *core.SmsapiSDK, entopts map[string]any) core.SmsapiEntity {
		return entity.NewSendernameEntity(client, entopts)
	}
	core.NewSendernameStatementEntityFunc = func(client *core.SmsapiSDK, entopts map[string]any) core.SmsapiEntity {
		return entity.NewSendernameStatementEntity(client, entopts)
	}
	core.NewSentRcsMessageEntityFunc = func(client *core.SmsapiSDK, entopts map[string]any) core.SmsapiEntity {
		return entity.NewSentRcsMessageEntity(client, entopts)
	}
	core.NewShipmentCountryVolumeEntityFunc = func(client *core.SmsapiSDK, entopts map[string]any) core.SmsapiEntity {
		return entity.NewShipmentCountryVolumeEntity(client, entopts)
	}
	core.NewShortUrlEntityFunc = func(client *core.SmsapiSDK, entopts map[string]any) core.SmsapiEntity {
		return entity.NewShortUrlEntity(client, entopts)
	}
	core.NewSmsdoEntityFunc = func(client *core.SmsapiSDK, entopts map[string]any) core.SmsapiEntity {
		return entity.NewSmsdoEntity(client, entopts)
	}
	core.NewSmssendernameEntityFunc = func(client *core.SmsapiSDK, entopts map[string]any) core.SmsapiEntity {
		return entity.NewSmssendernameEntity(client, entopts)
	}
	core.NewSmstemplateEntityFunc = func(client *core.SmsapiSDK, entopts map[string]any) core.SmsapiEntity {
		return entity.NewSmstemplateEntity(client, entopts)
	}
	core.NewSubuserEntityFunc = func(client *core.SmsapiSDK, entopts map[string]any) core.SmsapiEntity {
		return entity.NewSubuserEntity(client, entopts)
	}
	core.NewTemplateEntityFunc = func(client *core.SmsapiSDK, entopts map[string]any) core.SmsapiEntity {
		return entity.NewTemplateEntity(client, entopts)
	}
	core.NewUserRcsSenderCollectionEntityFunc = func(client *core.SmsapiSDK, entopts map[string]any) core.SmsapiEntity {
		return entity.NewUserRcsSenderCollectionEntity(client, entopts)
	}
}

// Constructor re-exports.
var NewSmsapiSDK = core.NewSmsapiSDK
var TestSDK = core.TestSDK
var NewContext = core.NewContext
var NewSpec = core.NewSpec
var NewResult = core.NewResult
var NewResponse = core.NewResponse
var NewOperation = core.NewOperation
var MakeConfig = core.MakeConfig
var SharedConfig = core.SharedConfig

// No-arg convenience constructors. Go has no default-argument syntax,
// so these aliases let callers write `sdk.New()` / `sdk.Test()`
// instead of `sdk.NewSmsapiSDK(nil)` / `sdk.TestSDK(nil, nil)`
// for the common no-options case.
func New() *SmsapiSDK  { return NewSmsapiSDK(nil) }
func Test() *SmsapiSDK { return TestSDK(nil, nil) }
var NewBaseFeature = feature.NewBaseFeature
var NewAuditFeature = feature.NewAuditFeature
var NewCacheFeature = feature.NewCacheFeature
var NewClienttrackFeature = feature.NewClienttrackFeature
var NewCostFeature = feature.NewCostFeature
var NewDebugFeature = feature.NewDebugFeature
var NewIdempotencyFeature = feature.NewIdempotencyFeature
var NewLogFeature = feature.NewLogFeature
var NewMetricsFeature = feature.NewMetricsFeature
var NewNetsimFeature = feature.NewNetsimFeature
var NewPagingFeature = feature.NewPagingFeature
var NewProxyFeature = feature.NewProxyFeature
var NewRatelimitFeature = feature.NewRatelimitFeature
var NewRbacFeature = feature.NewRbacFeature
var NewRetryFeature = feature.NewRetryFeature
var NewSecretsFeature = feature.NewSecretsFeature
var NewStreamingFeature = feature.NewStreamingFeature
var NewTelemetryFeature = feature.NewTelemetryFeature
var NewTestFeature = feature.NewTestFeature
var NewTimeoutFeature = feature.NewTimeoutFeature
var NewValidateFeature = feature.NewValidateFeature
