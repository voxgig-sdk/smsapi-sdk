# Smsapi SDK utility: prepare_body
require_relative 'media'
module SmsapiUtilities
  PrepareBody = ->(ctx) {
    return nil unless ctx.op.input == "data"
    return SmsapiUtilities.raw_body(ctx.reqdata) if SmsapiUtilities.raw_request?(ctx.point)
    ctx.utility.transform_request.call(ctx)
  }
end
