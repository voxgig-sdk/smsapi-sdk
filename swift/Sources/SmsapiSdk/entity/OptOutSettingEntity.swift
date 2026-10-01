// OptOutSetting entity client for the Smsapi SDK.

import Foundation

public final class OptOutSettingEntity: SmsapiEntityBase {
  public init(_ client: SmsapiSDK, _ entopts: VMap? = nil) {
    super.init(client, entopts, "opt_out_setting")
  }

  public override func make() -> Entity {
    return OptOutSettingEntity(client, cloneOpts())
  }

  public override func load(_ reqmatch: VMap?, _ ctrl: VMap?) throws -> Value {
    var ctxmap: [String: Any?] = ["opname": "load", "match": match, "data": data]
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

  // (list not defined by this API - base class throws unsupportedOp)

  // (create not defined by this API - base class throws unsupportedOp)

  public override func update(_ reqdata: VMap?, _ ctrl: VMap?) throws -> Value {
    var ctxmap: [String: Any?] = ["opname": "update", "match": match, "data": data]
    if let ctrl = ctrl { ctxmap["ctrl"] = ctrl }
    if let reqdata = reqdata { ctxmap["reqdata"] = reqdata }
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

  // (remove not defined by this API - base class throws unsupportedOp)
}
