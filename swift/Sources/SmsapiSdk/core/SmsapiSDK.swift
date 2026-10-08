// Smsapi SDK client.
//
// SDK TYPES ARE MODULE-QUALIFIED IN THIS FILE (`SmsapiSdk.VMap`, not
// `VMap`), and only in this file. MainEntity_swift emits one accessor PER
// ENTITY into this class body, named after the entity - `Utility()`,
// `Spec()`, `Value()` for an API with entities of those names - and inside
// a class body a METHOD of that name shadows the TYPE for every unqualified
// use: `utility = Utility()` then reads as a call to the accessor, and
// `-> Utility` as a return type that does not exist. The entity TYPE is
// already renamed on such a collision (swiftSafeTypeName), but the accessor
// keeps the entity's own name, which is the public API. Qualifying by
// module - the generated module is <Name>Sdk, so `SmsapiSdk.` lands as
// `<Name>Sdk.` - is the one spelling a method cannot shadow. The shared
// fixture's `utility` entity is what found this; every other swift file is
// outside this class and unaffected.

import Foundation

public final class SmsapiSDK {
  public var mode = "live"
  private var options: SmsapiSdk.VMap = SmsapiSdk.VMap()
  private let utility: SmsapiSdk.Utility
  public var features: [BaseFeature] = []
  private var rootctx: SmsapiSdk.Context!

  public init(_ optionsIn: SmsapiSdk.VMap? = nil) {
    utility = SmsapiSdk.Utility()

    // The process-wide config (sdkgen rung L2): read-only on the request path,
    // so every client shares one rather than rebuilding it.
    let config = SdkConfig.sharedConfig()

    var ctxmap: [String: Any?] = [
      "client": self,
      "utility": utility,
      "config": config,
      "shared": SmsapiSdk.VMap(),
    ]
    if let o = optionsIn { ctxmap["options"] = o }

    rootctx = utility.makeContext(ctxmap, nil)

    options = utility.makeOptions(rootctx)

    if gpath(options, "feature", "test", "active") == .bool(true) {
      mode = "test"
    }

    rootctx.options = options

    // Add features in the resolved order (makeOptions puts an explicit list
    // order first, else defaults to test-first). Ordering matters: the `test`
    // feature installs the base mock transport and the transport features
    // (retry/cache/netsim/proxy/ratelimit) wrap whatever is current, so `test`
    // must be added before them to sit at the base of the chain.
    let featureOpts = gp(options, "feature").asMap ?? SmsapiSdk.VMap()
    if let featureOrder = gpath(options, "__derived__", "featureorder").asList {
      for fnameVal in featureOrder.items {
        let fname = fnameVal.asString ?? ""
        if fname != "", let fopts = gp(featureOpts, fname).asMap,
          fopts.entries["active"]?.asBool == true {
          utility.featureAdd(rootctx, SdkConfig.makeFeature(fname))
        }
      }
    }

    // Add extension features.
    if let extList = gp(options, "extend").asList {
      for f in extList.items {
        if let feat = f.asNative as? BaseFeature {
          utility.featureAdd(rootctx, feat)
        }
      }
    }

    // Initialize features.
    for f in features {
      utility.featureInit(rootctx, f)
    }

    utility.featureHook(rootctx, "PostConstruct")
  }

  public func optionsMap() -> SmsapiSdk.VMap {
    return clone(.map(options)).asMap ?? SmsapiSdk.VMap()
  }

  public func getUtility() -> SmsapiSdk.Utility {
    return SmsapiSdk.Utility.copy(utility)
  }

  public func getRootCtx() -> SmsapiSdk.Context {
    return rootctx
  }

  public func prepare(_ fetchargsIn: SmsapiSdk.VMap?) throws -> SmsapiSdk.VMap {
    let utility = self.utility

    let fetchargs = fetchargsIn ?? SmsapiSdk.VMap()

    let ctrl = gp(fetchargs, "ctrl").asMap ?? SmsapiSdk.VMap()

    let ctx = utility.makeContext(["opname": "prepare", "ctrl": ctrl], rootctx)

    let options = self.options

    let path = gp(fetchargs, "path").asString ?? ""
    var method = gp(fetchargs, "method").asString ?? ""
    if method == "" { method = "GET" }
    method = method.uppercased()

    if !allowed(gpath(options, "allow", "method"), method) {
      throw ctx.makeError("spec_method_allow",
        "Method \"\(method)\" not allowed by SDK option allow.method value: \""
          + (gpath(options, "allow", "method").asString ?? "") + "\"")
    }

    let pathParams = gp(fetchargs, "params").asMap ?? SmsapiSdk.VMap()
    let query = gp(fetchargs, "query").asMap ?? SmsapiSdk.VMap()

    let headers = utility.prepareHeaders(ctx)

    let basev = gp(options, "base").asString ?? ""
    let prefix = gp(options, "prefix").asString ?? ""
    let suffix = gp(options, "suffix").asString ?? ""

    let specmap = SmsapiSdk.VMap()
    specmap.entries["base"] = .string(basev)
    specmap.entries["prefix"] = .string(prefix)
    specmap.entries["suffix"] = .string(suffix)
    specmap.entries["path"] = .string(path)
    specmap.entries["method"] = .string(method)
    specmap.entries["params"] = .map(pathParams)
    specmap.entries["query"] = .map(query)
    specmap.entries["headers"] = .map(headers)
    specmap.entries["body"] = gp(fetchargs, "body")
    specmap.entries["step"] = .string("start")
    ctx.spec = SmsapiSdk.Spec(specmap)

    // Merge user-provided headers.
    if let uhm = gp(fetchargs, "headers").asMap {
      for (k, v) in uhm.entries {
        ctx.spec!.headers.entries[k] = v
      }
    }

    _ = try utility.prepareAuth(ctx)

    return try utility.makeFetchDef(ctx)
  }

  // Raw endpoint access is operator-controllable, like every entity op.
  // Blocking it means denying BOTH the 'direct' and 'graphql' tokens, since
  // either one reaches the same endpoint.
  public func direct(_ fetchargsIn: SmsapiSdk.VMap?) -> SmsapiSdk.VMap {
    if !opAllowed("direct") {
      return opDenied("direct")
    }

    return rawRequest(fetchargsIn)
  }

  // Is this raw-access op permitted by the SDK's allow.op option?
  private func opAllowed(_ op: String) -> Bool {
    return allowed(gpath(options, "allow", "op"), op)
  }

  private func opDenied(_ op: String) -> SmsapiSdk.VMap {
    let allow = gpath(options, "allow", "op").asString ?? ""
    let r = SmsapiSdk.VMap()
    r.entries["ok"] = .bool(false)
    r.entries["err"] = .nat(SmsapiError(
      op + "_allow",
      "SmsapiSDK: \(op): operation not allowed by SDK option "
        + "allow.op value: \"\(allow)\"", nil))
    return r
  }

  // Ungated request path shared by direct and graphql, each of which checks
  // its own allow.op token first. Private, rather than a flag on fetchargs:
  // a caller-supplied marker would let anyone opt straight back out of the
  // gate by passing it.
  private func rawRequest(_ fetchargsIn: SmsapiSdk.VMap?) -> SmsapiSdk.VMap {
    let utility = self.utility

    // The error is returned rather than passed through makeError, so it is
    // cleaned here.
    let fetchdef: SmsapiSdk.VMap
    do {
      fetchdef = try prepare(fetchargsIn)
    } catch {
      let r = SmsapiSdk.VMap()
      r.entries["ok"] = .bool(false)
      r.entries["err"] = utility.clean(rootctx, .nat(error))
      return r
    }

    let fetchargs = fetchargsIn ?? SmsapiSdk.VMap()
    let ctrl = gp(fetchargs, "ctrl").asMap ?? SmsapiSdk.VMap()

    let ctx = utility.makeContext(["opname": "direct", "ctrl": ctrl], rootctx)

    let url = gp(fetchdef, "url").asString ?? ""

    let fetched: SmsapiSdk.Value
    do {
      fetched = try utility.fetcher(ctx, url, fetchdef)
    } catch {
      let r = SmsapiSdk.VMap()
      r.entries["ok"] = .bool(false)
      r.entries["err"] = utility.clean(ctx, .nat(error))
      return r
    }

    if isNil(fetched) {
      let r = SmsapiSdk.VMap()
      r.entries["ok"] = .bool(false)
      r.entries["err"] = .nat(ctx.makeError("direct_no_response", "response: undefined"))
      return r
    }

    if let fm = fetched.asMap {
      let status = toInt(gp(fm, "status"))
      let headers = gp(fm, "headers")

      // No-body responses (204, 304) and explicit zero content-length must
      // skip JSON parsing.
      var contentLength = ""
      if let hm = headers.asMap, let cl = hm.entries["content-length"], !isNil(cl) {
        contentLength = stringify(cl)
      }
      let noBody = status == 204 || status == 304 || contentLength == "0"

      var jsonData: SmsapiSdk.Value = .noval
      if !noBody, let jf = gp(fm, "json").asNative as? SmsapiSdk.NativeCall0 {
        jsonData = jf()
      }

      var bodyErr: Swift.Error? = nil
      if !noBody, gp(fm, "unreadable") == .bool(true) {
        var failed: Swift.Error? = nil
        if status < 200 || status >= 300 {
          failed = ctx.makeError(
            "request_status", "request: \(status): \(gp(fm, "statusText").asString ?? "")")
        }
        bodyErr = SmsapiSdk.Response.unreadableBody(
          ctx, status, headers, gp(fm, "body"), gp(fetchdef, "headers"), failed)
      }

      let r = SmsapiSdk.VMap()
      r.entries["ok"] = .bool(bodyErr == nil && status >= 200 && status < 300)
      r.entries["status"] = .int(Int64(status))
      r.entries["headers"] = headers
      r.entries["data"] = jsonData
      if let bodyErr = bodyErr {
        r.entries["err"] = utility.clean(ctx, .nat(bodyErr))
      }
      return r
    }

    let r = SmsapiSdk.VMap()
    r.entries["ok"] = .bool(false)
    r.entries["err"] = .nat(ctx.makeError("direct_invalid", "invalid response type"))
    return r
  }

  // Raw GraphQL access: the pressure valve that makes the generated surface's
  // deliberate omissions (per-call selection sets, typed filter builders,
  // batching, subscriptions) livable — the whole schema stays reachable.
  //
  // Thin wrapper over the same prepare/fetch path direct uses, with the one
  // thing raw direct cannot do for GraphQL: a GraphQL failure rides HTTP 200
  // as a top-level `errors` array, so status alone would report a failed
  // query as ok.
  //
  // NOTE: like direct, this bypasses the feature pipeline — no retry,
  // ratelimit or paging features apply.
  public func graphql(
    _ query: String, _ variables: SmsapiSdk.VMap? = nil, _ ctrl: SmsapiSdk.VMap? = nil
  ) -> SmsapiSdk.VMap {
    if !opAllowed("graphql") {
      return opDenied("graphql")
    }

    let headers = SmsapiSdk.VMap()
    headers.entries["content-type"] = .string("application/json")

    let body = SmsapiSdk.VMap()
    body.entries["query"] = .string(query)
    body.entries["variables"] = .map(variables ?? SmsapiSdk.VMap())

    let fetchargs = SmsapiSdk.VMap()
    fetchargs.entries["method"] = .string("POST")
    fetchargs.entries["headers"] = .map(headers)
    fetchargs.entries["body"] = .map(body)
    fetchargs.entries["ctrl"] = .map(ctrl ?? SmsapiSdk.VMap())

    let res = rawRequest(fetchargs)

    // Errors are read BEFORE any status check: a GraphQL parse or validation
    // failure comes back as HTTP 400 carrying the standard { errors: [...] }
    // body, and the raw path represents a non-2xx as ok:false with no err —
    // so returning early on status would discard the server's own
    // diagnostics, which are the only useful part of that response.
    guard let errors = gp(gp(.map(res), "data"), "errors").asList,
          !errors.items.isEmpty else {
      return res
    }

    var msg = gp(errors.items[0], "message").asString ?? ""
    if msg.isEmpty { msg = "graphql error" }

    res.entries["ok"] = .bool(false)
    res.entries["err"] = .nat(SmsapiError(
      "graphql_error", "SmsapiSDK: graphql: " + msg, nil))
    res.entries["graphql"] = .list(errors)

    return res
  }


  // Available returns a Available entity bound to this client.
  // Idiomatic usage: try client.Available().list(nil) or
  // try client.Available().load(vm(("id", .string("..."))), nil).
  public func Available(_ entopts: VMap? = nil) -> SmsapiEntityBase {
    return AvailableEntity(self, entopts)
  }

  // Blacklist returns a Blacklist entity bound to this client.
  // Idiomatic usage: try client.Blacklist().list(nil) or
  // try client.Blacklist().load(vm(("id", .string("..."))), nil).
  public func Blacklist(_ entopts: VMap? = nil) -> SmsapiEntityBase {
    return BlacklistEntity(self, entopts)
  }

  // Callback returns a Callback entity bound to this client.
  // Idiomatic usage: try client.Callback().list(nil) or
  // try client.Callback().load(vm(("id", .string("..."))), nil).
  public func Callback(_ entopts: VMap? = nil) -> SmsapiEntityBase {
    return CallbackEntity(self, entopts)
  }

  // Contact returns a Contact entity bound to this client.
  // Idiomatic usage: try client.Contact().list(nil) or
  // try client.Contact().load(vm(("id", .string("..."))), nil).
  public func Contact(_ entopts: VMap? = nil) -> SmsapiEntityBase {
    return ContactEntity(self, entopts)
  }

  // ContactsField returns a ContactsField entity bound to this client.
  // Idiomatic usage: try client.ContactsField().list(nil) or
  // try client.ContactsField().load(vm(("id", .string("..."))), nil).
  public func ContactsField(_ entopts: VMap? = nil) -> SmsapiEntityBase {
    return ContactsFieldEntity(self, entopts)
  }

  // ContactsFieldOption returns a ContactsFieldOption entity bound to this client.
  // Idiomatic usage: try client.ContactsFieldOption().list(nil) or
  // try client.ContactsFieldOption().load(vm(("id", .string("..."))), nil).
  public func ContactsFieldOption(_ entopts: VMap? = nil) -> SmsapiEntityBase {
    return ContactsFieldOptionEntity(self, entopts)
  }

  // Contactsgroup returns a Contactsgroup entity bound to this client.
  // Idiomatic usage: try client.Contactsgroup().list(nil) or
  // try client.Contactsgroup().load(vm(("id", .string("..."))), nil).
  public func Contactsgroup(_ entopts: VMap? = nil) -> SmsapiEntityBase {
    return ContactsgroupEntity(self, entopts)
  }

  // Contactstrash returns a Contactstrash entity bound to this client.
  // Idiomatic usage: try client.Contactstrash().list(nil) or
  // try client.Contactstrash().load(vm(("id", .string("..."))), nil).
  public func Contactstrash(_ entopts: VMap? = nil) -> SmsapiEntityBase {
    return ContactstrashEntity(self, entopts)
  }

  // FieldAvailable returns a FieldAvailable entity bound to this client.
  // Idiomatic usage: try client.FieldAvailable().list(nil) or
  // try client.FieldAvailable().load(vm(("id", .string("..."))), nil).
  public func FieldAvailable(_ entopts: VMap? = nil) -> SmsapiEntityBase {
    return FieldAvailableEntity(self, entopts)
  }

  // Group returns a Group entity bound to this client.
  // Idiomatic usage: try client.Group().list(nil) or
  // try client.Group().load(vm(("id", .string("..."))), nil).
  public func Group(_ entopts: VMap? = nil) -> SmsapiEntityBase {
    return GroupEntity(self, entopts)
  }

  // MfaCode returns a MfaCode entity bound to this client.
  // Idiomatic usage: try client.MfaCode().list(nil) or
  // try client.MfaCode().load(vm(("id", .string("..."))), nil).
  public func MfaCode(_ entopts: VMap? = nil) -> SmsapiEntityBase {
    return MfaCodeEntity(self, entopts)
  }

  // OptOut returns a OptOut entity bound to this client.
  // Idiomatic usage: try client.OptOut().list(nil) or
  // try client.OptOut().load(vm(("id", .string("..."))), nil).
  public func OptOut(_ entopts: VMap? = nil) -> SmsapiEntityBase {
    return OptOutEntity(self, entopts)
  }

  // OptOutSetting returns a OptOutSetting entity bound to this client.
  // Idiomatic usage: try client.OptOutSetting().list(nil) or
  // try client.OptOutSetting().load(vm(("id", .string("..."))), nil).
  public func OptOutSetting(_ entopts: VMap? = nil) -> SmsapiEntityBase {
    return OptOutSettingEntity(self, entopts)
  }

  // Permission returns a Permission entity bound to this client.
  // Idiomatic usage: try client.Permission().list(nil) or
  // try client.Permission().load(vm(("id", .string("..."))), nil).
  public func Permission(_ entopts: VMap? = nil) -> SmsapiEntityBase {
    return PermissionEntity(self, entopts)
  }

  // Ping returns a Ping entity bound to this client.
  // Idiomatic usage: try client.Ping().list(nil) or
  // try client.Ping().load(vm(("id", .string("..."))), nil).
  public func Ping(_ entopts: VMap? = nil) -> SmsapiEntityBase {
    return PingEntity(self, entopts)
  }

  // Profile returns a Profile entity bound to this client.
  // Idiomatic usage: try client.Profile().list(nil) or
  // try client.Profile().load(vm(("id", .string("..."))), nil).
  public func Profile(_ entopts: VMap? = nil) -> SmsapiEntityBase {
    return ProfileEntity(self, entopts)
  }

  // Rcs returns a Rcs entity bound to this client.
  // Idiomatic usage: try client.Rcs().list(nil) or
  // try client.Rcs().load(vm(("id", .string("..."))), nil).
  public func Rcs(_ entopts: VMap? = nil) -> SmsapiEntityBase {
    return RcsEntity(self, entopts)
  }

  // Sendername returns a Sendername entity bound to this client.
  // Idiomatic usage: try client.Sendername().list(nil) or
  // try client.Sendername().load(vm(("id", .string("..."))), nil).
  public func Sendername(_ entopts: VMap? = nil) -> SmsapiEntityBase {
    return SendernameEntity(self, entopts)
  }

  // SendernameStatement returns a SendernameStatement entity bound to this client.
  // Idiomatic usage: try client.SendernameStatement().list(nil) or
  // try client.SendernameStatement().load(vm(("id", .string("..."))), nil).
  public func SendernameStatement(_ entopts: VMap? = nil) -> SmsapiEntityBase {
    return SendernameStatementEntity(self, entopts)
  }

  // SentRcsMessage returns a SentRcsMessage entity bound to this client.
  // Idiomatic usage: try client.SentRcsMessage().list(nil) or
  // try client.SentRcsMessage().load(vm(("id", .string("..."))), nil).
  public func SentRcsMessage(_ entopts: VMap? = nil) -> SmsapiEntityBase {
    return SentRcsMessageEntity(self, entopts)
  }

  // ShipmentCountryVolume returns a ShipmentCountryVolume entity bound to this client.
  // Idiomatic usage: try client.ShipmentCountryVolume().list(nil) or
  // try client.ShipmentCountryVolume().load(vm(("id", .string("..."))), nil).
  public func ShipmentCountryVolume(_ entopts: VMap? = nil) -> SmsapiEntityBase {
    return ShipmentCountryVolumeEntity(self, entopts)
  }

  // ShortUrl returns a ShortUrl entity bound to this client.
  // Idiomatic usage: try client.ShortUrl().list(nil) or
  // try client.ShortUrl().load(vm(("id", .string("..."))), nil).
  public func ShortUrl(_ entopts: VMap? = nil) -> SmsapiEntityBase {
    return ShortUrlEntity(self, entopts)
  }

  // Smsdo returns a Smsdo entity bound to this client.
  // Idiomatic usage: try client.Smsdo().list(nil) or
  // try client.Smsdo().load(vm(("id", .string("..."))), nil).
  public func Smsdo(_ entopts: VMap? = nil) -> SmsapiEntityBase {
    return SmsdoEntity(self, entopts)
  }

  // Smssendername returns a Smssendername entity bound to this client.
  // Idiomatic usage: try client.Smssendername().list(nil) or
  // try client.Smssendername().load(vm(("id", .string("..."))), nil).
  public func Smssendername(_ entopts: VMap? = nil) -> SmsapiEntityBase {
    return SmssendernameEntity(self, entopts)
  }

  // Smstemplate returns a Smstemplate entity bound to this client.
  // Idiomatic usage: try client.Smstemplate().list(nil) or
  // try client.Smstemplate().load(vm(("id", .string("..."))), nil).
  public func Smstemplate(_ entopts: VMap? = nil) -> SmsapiEntityBase {
    return SmstemplateEntity(self, entopts)
  }

  // Subuser returns a Subuser entity bound to this client.
  // Idiomatic usage: try client.Subuser().list(nil) or
  // try client.Subuser().load(vm(("id", .string("..."))), nil).
  public func Subuser(_ entopts: VMap? = nil) -> SmsapiEntityBase {
    return SubuserEntity(self, entopts)
  }

  // Template returns a Template entity bound to this client.
  // Idiomatic usage: try client.Template().list(nil) or
  // try client.Template().load(vm(("id", .string("..."))), nil).
  public func Template(_ entopts: VMap? = nil) -> SmsapiEntityBase {
    return TemplateEntity(self, entopts)
  }

  // UserRcsSenderCollection returns a UserRcsSenderCollection entity bound to this client.
  // Idiomatic usage: try client.UserRcsSenderCollection().list(nil) or
  // try client.UserRcsSenderCollection().load(vm(("id", .string("..."))), nil).
  public func UserRcsSenderCollection(_ entopts: VMap? = nil) -> SmsapiEntityBase {
    return UserRcsSenderCollectionEntity(self, entopts)
  }


  public static func testSDK(_ testoptsIn: SmsapiSdk.VMap?, _ sdkoptsIn: SmsapiSdk.VMap?) -> SmsapiSDK {
    let sdkopts = clone(.map(sdkoptsIn ?? SmsapiSdk.VMap())).asMap ?? SmsapiSdk.VMap()

    let testopts = clone(.map(testoptsIn ?? SmsapiSdk.VMap())).asMap ?? SmsapiSdk.VMap()
    testopts.entries["active"] = .bool(true)

    _ = setpath(.map(sdkopts), jtp("feature", "test"), .map(testopts))

    let sdk = SmsapiSDK(sdkopts)
    sdk.mode = "test"
    return sdk
  }
}

// The client holds the credential in its options. Its default prints name
// it and nothing more, and its mirror - which `dump` and a structured
// logger walk, private stored properties included - shows only the mode
// and the feature names.
extension SmsapiSDK: CustomStringConvertible, CustomDebugStringConvertible, CustomReflectable {
  public var description: Swift.String { "SmsapiSDK" }
  public var debugDescription: Swift.String { "SmsapiSDK(mode: " + mode + ")" }
  public var customMirror: Swift.Mirror {
    Swift.Mirror(self, children: ["mode": mode, "features": features.map { $0.getName() }])
  }
}
