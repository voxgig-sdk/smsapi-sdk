// ContactsFieldOption entity client for the Smsapi SDK.

import Foundation

public final class ContactsFieldOptionEntity: SmsapiEntityBase {
  public init(_ client: SmsapiSDK, _ entopts: VMap? = nil) {
    super.init(client, entopts, "contacts_field_option")
  }

  public override func make() -> Entity {
    return ContactsFieldOptionEntity(client, cloneOpts())
  }

  // (load not defined by this API - base class throws unsupportedOp)

  public override func list(_ reqmatch: VMap?, _ ctrl: VMap?) throws -> Value {
    var ctxmap: [String: Any?] = ["opname": "list", "match": match, "data": data]
    if let ctrl = ctrl { ctxmap["ctrl"] = ctrl }
    if let reqmatch = reqmatch { ctxmap["reqmatch"] = reqmatch }
    let ctx = utility.makeContext(ctxmap, entctx)
  
    return try runOp(ctx) {
      if let result = ctx.result {
        if let rm = result.resmatch { self.match = rm }
      }
    }
  }

  // (create not defined by this API - base class throws unsupportedOp)

  // (update not defined by this API - base class throws unsupportedOp)

  // (patch not defined by this API - base class throws unsupportedOp)

  // (remove not defined by this API - base class throws unsupportedOp)
}
