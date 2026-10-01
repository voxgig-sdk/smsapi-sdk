# Smsapi SDK utility: make_context
require_relative '../core/context'
module SmsapiUtilities
  MakeContext = ->(ctxmap, basectx) {
    SmsapiContext.new(ctxmap, basectx)
  }
end
