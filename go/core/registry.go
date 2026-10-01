package core

var UtilityRegistrar func(u *Utility)

var NewBaseFeatureFunc func() Feature

var NewAuditFeatureFunc func() Feature

var NewCacheFeatureFunc func() Feature

var NewClienttrackFeatureFunc func() Feature

var NewCostFeatureFunc func() Feature

var NewDebugFeatureFunc func() Feature

var NewIdempotencyFeatureFunc func() Feature

var NewLogFeatureFunc func() Feature

var NewMetricsFeatureFunc func() Feature

var NewNetsimFeatureFunc func() Feature

var NewPagingFeatureFunc func() Feature

var NewProxyFeatureFunc func() Feature

var NewRatelimitFeatureFunc func() Feature

var NewRbacFeatureFunc func() Feature

var NewRetryFeatureFunc func() Feature

var NewSecretsFeatureFunc func() Feature

var NewStreamingFeatureFunc func() Feature

var NewTelemetryFeatureFunc func() Feature

var NewTestFeatureFunc func() Feature

var NewTimeoutFeatureFunc func() Feature

var NewValidateFeatureFunc func() Feature

var NewAvailableEntityFunc func(client *SmsapiSDK, entopts map[string]any) SmsapiEntity

var NewBlacklistEntityFunc func(client *SmsapiSDK, entopts map[string]any) SmsapiEntity

var NewCallbackEntityFunc func(client *SmsapiSDK, entopts map[string]any) SmsapiEntity

var NewContactEntityFunc func(client *SmsapiSDK, entopts map[string]any) SmsapiEntity

var NewContactsFieldEntityFunc func(client *SmsapiSDK, entopts map[string]any) SmsapiEntity

var NewContactsFieldOptionEntityFunc func(client *SmsapiSDK, entopts map[string]any) SmsapiEntity

var NewContactsgroupEntityFunc func(client *SmsapiSDK, entopts map[string]any) SmsapiEntity

var NewContactstrashEntityFunc func(client *SmsapiSDK, entopts map[string]any) SmsapiEntity

var NewFieldAvailableEntityFunc func(client *SmsapiSDK, entopts map[string]any) SmsapiEntity

var NewGroupEntityFunc func(client *SmsapiSDK, entopts map[string]any) SmsapiEntity

var NewMfaCodeEntityFunc func(client *SmsapiSDK, entopts map[string]any) SmsapiEntity

var NewOptOutEntityFunc func(client *SmsapiSDK, entopts map[string]any) SmsapiEntity

var NewOptOutSettingEntityFunc func(client *SmsapiSDK, entopts map[string]any) SmsapiEntity

var NewPermissionEntityFunc func(client *SmsapiSDK, entopts map[string]any) SmsapiEntity

var NewPingEntityFunc func(client *SmsapiSDK, entopts map[string]any) SmsapiEntity

var NewProfileEntityFunc func(client *SmsapiSDK, entopts map[string]any) SmsapiEntity

var NewRcsEntityFunc func(client *SmsapiSDK, entopts map[string]any) SmsapiEntity

var NewSendernameEntityFunc func(client *SmsapiSDK, entopts map[string]any) SmsapiEntity

var NewSendernameStatementEntityFunc func(client *SmsapiSDK, entopts map[string]any) SmsapiEntity

var NewSentRcsMessageEntityFunc func(client *SmsapiSDK, entopts map[string]any) SmsapiEntity

var NewShipmentCountryVolumeEntityFunc func(client *SmsapiSDK, entopts map[string]any) SmsapiEntity

var NewShortUrlEntityFunc func(client *SmsapiSDK, entopts map[string]any) SmsapiEntity

var NewSmsdoEntityFunc func(client *SmsapiSDK, entopts map[string]any) SmsapiEntity

var NewSmssendernameEntityFunc func(client *SmsapiSDK, entopts map[string]any) SmsapiEntity

var NewSmstemplateEntityFunc func(client *SmsapiSDK, entopts map[string]any) SmsapiEntity

var NewSubuserEntityFunc func(client *SmsapiSDK, entopts map[string]any) SmsapiEntity

var NewTemplateEntityFunc func(client *SmsapiSDK, entopts map[string]any) SmsapiEntity

var NewUserRcsSenderCollectionEntityFunc func(client *SmsapiSDK, entopts map[string]any) SmsapiEntity

