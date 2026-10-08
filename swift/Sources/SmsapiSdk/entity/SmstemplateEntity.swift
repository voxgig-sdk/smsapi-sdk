// Smstemplate entity client for the Smsapi SDK.

import Foundation

public final class SmstemplateEntity: SmsapiEntityBase {
  public init(_ client: SmsapiSDK, _ entopts: VMap? = nil) {
    super.init(client, entopts, "smstemplate")
  }

  public override func make() -> Entity {
    return SmstemplateEntity(client, cloneOpts())
  }

  // (load not defined by this API - base class throws unsupportedOp)

  // (list not defined by this API - base class throws unsupportedOp)

  // (create not defined by this API - base class throws unsupportedOp)

  // (update not defined by this API - base class throws unsupportedOp)

  // (patch not defined by this API - base class throws unsupportedOp)

  public override func remove(_ reqmatch: VMap?, _ ctrl: VMap?) throws -> Value {
    var ctxmap: [String: Any?] = ["opname": "remove", "match": match, "data": data]
    if let ctrl = ctrl { ctxmap["ctrl"] = ctrl }
    if let reqmatch = reqmatch { ctxmap["reqmatch"] = reqmatch }
    let ctx = utility.makeContext(ctxmap, entctx)
  
    return try runOp(ctx) {
      if let result = ctx.result {
        if let rm = result.resmatch { self.match = rm }
        if !isNil(result.resdata) {
          self.data = clone(result.resdata).asMap ?? VMap()
        }
      }
    }
  }
}
