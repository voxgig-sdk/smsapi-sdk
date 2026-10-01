# Smsapi SDK utility registration
require_relative '../core/utility_type'
require_relative 'clean'
require_relative 'done'
require_relative 'make_error'
require_relative 'feature_add'
require_relative 'feature_hook'
require_relative 'feature_init'
require_relative 'fetcher'
require_relative 'make_fetch_def'
require_relative 'make_context'
require_relative 'make_options'
require_relative 'make_request'
require_relative 'make_response'
require_relative 'make_result'
require_relative 'make_point'
require_relative 'make_spec'
require_relative 'make_url'
require_relative 'param'
require_relative 'prepare_auth'
require_relative 'prepare_body'
require_relative 'prepare_headers'
require_relative 'prepare_method'
require_relative 'prepare_params'
require_relative 'prepare_path'
require_relative 'prepare_query'
require_relative 'graphql'
require_relative 'result_basic'
require_relative 'result_body'
require_relative 'result_headers'
require_relative 'transform_request'
require_relative 'transform_response'

SmsapiUtility.registrar = ->(u) {
  u.clean = SmsapiUtilities::Clean
  u.clean_add = SmsapiUtilities::CleanAdd
  u.clean_explain = SmsapiUtilities::CleanExplain
  u.done = SmsapiUtilities::Done
  u.make_error = SmsapiUtilities::MakeError
  u.feature_add = SmsapiUtilities::FeatureAdd
  u.feature_hook = SmsapiUtilities::FeatureHook
  u.feature_init = SmsapiUtilities::FeatureInit
  u.fetcher = SmsapiUtilities::Fetcher
  u.make_fetch_def = SmsapiUtilities::MakeFetchDef
  u.make_context = SmsapiUtilities::MakeContext
  u.make_options = SmsapiUtilities::MakeOptions
  u.make_request = SmsapiUtilities::MakeRequest
  u.make_response = SmsapiUtilities::MakeResponse
  u.make_result = SmsapiUtilities::MakeResult
  u.make_point = SmsapiUtilities::MakePoint
  u.make_spec = SmsapiUtilities::MakeSpec
  u.make_url = SmsapiUtilities::MakeUrl
  u.param = SmsapiUtilities::Param
  u.prepare_auth = SmsapiUtilities::PrepareAuth
  u.prepare_body = SmsapiUtilities::PrepareBody
  u.prepare_headers = SmsapiUtilities::PrepareHeaders
  u.prepare_method = SmsapiUtilities::PrepareMethod
  u.prepare_params = SmsapiUtilities::PrepareParams
  u.prepare_path = SmsapiUtilities::PreparePath
  u.prepare_query = SmsapiUtilities::PrepareQuery
  u.graphql_body = SmsapiUtilities::GraphqlBody
  u.graphql_errors = SmsapiUtilities::GraphqlErrors
  u.result_basic = SmsapiUtilities::ResultBasic
  u.result_body = SmsapiUtilities::ResultBody
  u.result_headers = SmsapiUtilities::ResultHeaders
  u.transform_request = SmsapiUtilities::TransformRequest
  u.transform_response = SmsapiUtilities::TransformResponse
}
