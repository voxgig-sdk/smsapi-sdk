// Smsapi Ts SDK

import { AvailableEntity } from './entity/AvailableEntity'
import { BlacklistEntity } from './entity/BlacklistEntity'
import { CallbackEntity } from './entity/CallbackEntity'
import { ContactEntity } from './entity/ContactEntity'
import { ContactsFieldEntity } from './entity/ContactsFieldEntity'
import { ContactsFieldOptionEntity } from './entity/ContactsFieldOptionEntity'
import { ContactsgroupEntity } from './entity/ContactsgroupEntity'
import { ContactstrashEntity } from './entity/ContactstrashEntity'
import { FieldAvailableEntity } from './entity/FieldAvailableEntity'
import { GroupEntity } from './entity/GroupEntity'
import { MfaCodeEntity } from './entity/MfaCodeEntity'
import { OptOutEntity } from './entity/OptOutEntity'
import { OptOutSettingEntity } from './entity/OptOutSettingEntity'
import { PermissionEntity } from './entity/PermissionEntity'
import { PingEntity } from './entity/PingEntity'
import { ProfileEntity } from './entity/ProfileEntity'
import { RcsEntity } from './entity/RcsEntity'
import { SendernameEntity } from './entity/SendernameEntity'
import { SendernameStatementEntity } from './entity/SendernameStatementEntity'
import { SentRcsMessageEntity } from './entity/SentRcsMessageEntity'
import { ShipmentCountryVolumeEntity } from './entity/ShipmentCountryVolumeEntity'
import { ShortUrlEntity } from './entity/ShortUrlEntity'
import { SmsdoEntity } from './entity/SmsdoEntity'
import { SmssendernameEntity } from './entity/SmssendernameEntity'
import { SmstemplateEntity } from './entity/SmstemplateEntity'
import { SubuserEntity } from './entity/SubuserEntity'
import { TemplateEntity } from './entity/TemplateEntity'
import { UserRcsSenderCollectionEntity } from './entity/UserRcsSenderCollectionEntity'

export type * from './SmsapiTypes'


import { inspect } from 'node:util'

import type { Context, Feature } from './types'

import { config } from './Config'
import { SmsapiEntityBase } from './SmsapiEntityBase'
import { Utility } from './utility/Utility'


import { BaseFeature } from './feature/base/BaseFeature'
import * as sekreto from './feature/secrets/sekreto'



const stdutil = new Utility()


class SmsapiSDK {
  _mode: string = 'live'
  _options: any
  _utility = new Utility()
  _features: Feature[]
  _rootctx: Context
  _secrets?: any


  constructor(options?: any) {

    this._rootctx = this._utility.makeContext({
      client: this,
      utility: this._utility,
      config,
      options,
      shared: new WeakMap()
    })

    this._options = this._utility.makeOptions(this._rootctx)

    for (const key of ['_options', '_rootctx', '_features']) {
      Object.defineProperty(this, key, {
        value: (this as any)[key], enumerable: false, writable: true, configurable: true
      })
    }

    const struct = this._utility.struct
    const getpath = struct.getpath

    if (true === getpath(this._options.feature, 'test.active')) {
      this._mode = 'test'
    }

    this._rootctx.options = this._options

    this._features = []

    const featureAdd = this._utility.featureAdd
    const featureInit = this._utility.featureInit

    // Add features in the resolved order (makeOptions puts an explicit
    // array order first, else defaults to test-first). Ordering matters:
    // the `test` feature installs the base mock transport and the transport
    // features (retry/cache/netsim/proxy/ratelimit) wrap whatever is current,
    // so `test` must be added before them to sit at the base of the chain.
    const extend = this._options.extend || []

    const featureorder = getpath(this._options, '__derived__.featureorder') || []
    for (const fname of featureorder) {
      const fopts = this._options.feature[fname] || {}
      if (fopts.active) {
        // An active name with no generated class is legal when an
        // extend-supplied instance carries that name (station's adopt
        // path): the instance is added below, positioned by its own
        // __after__ entry, so skip it here rather than fail construction.
        if (!this._rootctx.config.hasFeature(fname) &&
          extend.some((f: any) => fname === f.name)) {
          continue
        }
        featureAdd(this._rootctx, this._rootctx.config.makeFeature(fname))
      }
    }

    for (let f of extend) {
      featureAdd(this._rootctx, f)
    }

    for (let f of this._features) {
      featureInit(this._rootctx, f)
    }

    const featureHook = this._utility.featureHook
    featureHook(this._rootctx, 'PostConstruct')
  }


  options() {
    return this._utility.struct.clone(this._options)
  }


  utility() {
    return this._utility.struct.clone(this._utility)
  }

  
secrets() {
  return this._secrets && this._secrets.sekreto()
}



  async prepare(fetchargs?: any) {
    const utility = this._utility
    const struct = utility.struct
    const clone = struct.clone

    const {
      makeContext,
      makeFetchDef,
      prepareHeaders,
      prepareAuth,
    } = utility

    fetchargs = fetchargs || {}

    let ctx: Context = makeContext({
      opname: 'prepare',
      ctrl: fetchargs.ctrl || {},
    }, this._rootctx)

    const options = this._options

    const spec: any = {
      base: options.base,
      prefix: options.prefix,
      suffix: options.suffix,
      path: fetchargs.path || '',
      method: fetchargs.method || 'GET',
      params: fetchargs.params || {},
      query: fetchargs.query || {},
      headers: prepareHeaders(ctx),
      body: fetchargs.body,
      step: 'start',
    }

    ctx.spec = spec

    if (fetchargs.headers) {
      const uheaders = fetchargs.headers
      for (let key in uheaders) {
        spec.headers[key] = uheaders[key]
      }
    }

    
if (null != this._secrets) {
  try {
    await this._secrets.resolve()
  }
  catch (err: any) {
    return err instanceof Error ? err : new Error(String(err))
  }
}


    const authResult = prepareAuth(ctx)
    if (authResult instanceof Error) {
      return authResult
    }

    return makeFetchDef(ctx)
  }


  // Raw endpoint access is operator-controllable, like every entity op.
  // Blocking it means denying BOTH the 'direct' and 'graphql' tokens, since
  // either one reaches the same endpoint.
  async direct(fetchargs?: any) {
    if (!this._options.allow.op.includes('direct')) {
      return {
        ok: false,
        err: new Error('SmsapiSDK: direct: operation not allowed by' +
          ' SDK option allow.op value: "' + this._options.allow.op + '"'),
      }
    }

    return this._rawRequest(fetchargs)
  }


  // Ungated request path shared by direct() and graphql(), each of which
  // checks its own allow.op token first. Private, rather than a flag on
  // fetchargs: a caller-supplied marker would let anyone opt straight back
  // out of the gate by passing it.
  async _rawRequest(fetchargs?: any) {
    const utility = this._utility

    const fetcher = utility.fetcher
    const makeContext = utility.makeContext

    const fetchdef = await this.prepare(fetchargs)
    if (fetchdef instanceof Error) {
      return fetchdef
    }

    let ctx: Context = makeContext({
      opname: 'direct',
      ctrl: (fetchargs || {}).ctrl || {},
    }, this._rootctx)

    try {
      const fetched = await fetcher(ctx, fetchdef.url, fetchdef)

      if (null == fetched) {
        return { ok: false, err: ctx.error('direct_no_response', 'response: undefined') }
      }
      else if (fetched instanceof Error) {
        return { ok: false, err: utility.clean(ctx, fetched) }
      }

      const status = fetched.status

      // No body responses (204 No Content, 304 Not Modified) and explicit
      // zero content-length must skip JSON parsing — fetched.json() would
      // throw `Unexpected end of JSON input` on an empty body.
      const headers = fetched.headers
      const contentLength = headers && 'function' === typeof headers.get
        ? headers.get('content-length')
        : (headers || {})['content-length']
      const noBody = 204 === status || 304 === status || '0' === String(contentLength)

      let json: any = undefined
      if (!noBody) {
        try {
          json = 'function' === typeof fetched.json ? await fetched.json() : fetched.json
        }
        catch (parseErr) {
          // Body wasn't valid JSON — surface the raw response rather than
          // throwing. data stays undefined; callers can inspect status/headers.
          json = undefined
        }
      }

      return {
        ok: status >= 200 && status < 300,
        status,
        headers: fetched.headers,
        data: json,
      }
    }
    catch (err: any) {
      return { ok: false, err: utility.clean(ctx, err) }
    }
  }



  async graphql(query: string, variables?: any, ctrl?: any) {
    const options = this._options

    if (!options.allow.op.includes('graphql')) {
      return {
        ok: false,
        err: new Error('SmsapiSDK: graphql: operation not allowed by' +
          ' SDK option allow.op value: "' + options.allow.op + '"'),
      }
    }

    const res: any = await this._rawRequest({
      method: 'POST',
      headers: { 'content-type': 'application/json' },
      body: { query, variables: variables || {} },
      ctrl,
    })

    if (res instanceof Error) {
      return res
    }

    // Errors are read BEFORE any status check: a GraphQL parse or validation
    // failure comes back as HTTP 400 carrying the standard { errors: [...] }
    // body, and the raw path represents a non-2xx as { ok: false } with no
    // err — so returning early on status would discard the server's own
    // diagnostics, which are the only useful part of that response.
    const errors = null == res.data ? undefined : res.data.errors

    if (null != errors && Array.isArray(errors) && 0 < errors.length) {
      const first = errors[0] || {}
      const err: any = new Error('SmsapiSDK: graphql: ' +
        (first.message || 'graphql error'))
      err.graphql = errors
      return { ok: false, status: res.status, headers: res.headers, err, data: res.data }
    }

    return res
  }



  // Entity access: `client.Available().list()` / `client.Available().load({ id })`.
  // The argument is the entity OPTIONS object (passed to the entity
  // constructor as entopts), not initial entity data.
  Available(entopts?: Record<string, any>) {
    const self = this
    return new AvailableEntity(self, entopts)
  }


  // Entity access: `client.Blacklist().list()` / `client.Blacklist().load({ id })`.
  // The argument is the entity OPTIONS object (passed to the entity
  // constructor as entopts), not initial entity data.
  Blacklist(entopts?: Record<string, any>) {
    const self = this
    return new BlacklistEntity(self, entopts)
  }


  // Entity access: `client.Callback().list()` / `client.Callback().load({ id })`.
  // The argument is the entity OPTIONS object (passed to the entity
  // constructor as entopts), not initial entity data.
  Callback(entopts?: Record<string, any>) {
    const self = this
    return new CallbackEntity(self, entopts)
  }


  // Entity access: `client.Contact().list()` / `client.Contact().load({ id })`.
  // The argument is the entity OPTIONS object (passed to the entity
  // constructor as entopts), not initial entity data.
  Contact(entopts?: Record<string, any>) {
    const self = this
    return new ContactEntity(self, entopts)
  }


  // Entity access: `client.ContactsField().list()` / `client.ContactsField().load({ id })`.
  // The argument is the entity OPTIONS object (passed to the entity
  // constructor as entopts), not initial entity data.
  ContactsField(entopts?: Record<string, any>) {
    const self = this
    return new ContactsFieldEntity(self, entopts)
  }


  // Entity access: `client.ContactsFieldOption().list()` / `client.ContactsFieldOption().load({ id })`.
  // The argument is the entity OPTIONS object (passed to the entity
  // constructor as entopts), not initial entity data.
  ContactsFieldOption(entopts?: Record<string, any>) {
    const self = this
    return new ContactsFieldOptionEntity(self, entopts)
  }


  // Entity access: `client.Contactsgroup().list()` / `client.Contactsgroup().load({ id })`.
  // The argument is the entity OPTIONS object (passed to the entity
  // constructor as entopts), not initial entity data.
  Contactsgroup(entopts?: Record<string, any>) {
    const self = this
    return new ContactsgroupEntity(self, entopts)
  }


  // Entity access: `client.Contactstrash().list()` / `client.Contactstrash().load({ id })`.
  // The argument is the entity OPTIONS object (passed to the entity
  // constructor as entopts), not initial entity data.
  Contactstrash(entopts?: Record<string, any>) {
    const self = this
    return new ContactstrashEntity(self, entopts)
  }


  // Entity access: `client.FieldAvailable().list()` / `client.FieldAvailable().load({ id })`.
  // The argument is the entity OPTIONS object (passed to the entity
  // constructor as entopts), not initial entity data.
  FieldAvailable(entopts?: Record<string, any>) {
    const self = this
    return new FieldAvailableEntity(self, entopts)
  }


  // Entity access: `client.Group().list()` / `client.Group().load({ id })`.
  // The argument is the entity OPTIONS object (passed to the entity
  // constructor as entopts), not initial entity data.
  Group(entopts?: Record<string, any>) {
    const self = this
    return new GroupEntity(self, entopts)
  }


  // Entity access: `client.MfaCode().list()` / `client.MfaCode().load({ id })`.
  // The argument is the entity OPTIONS object (passed to the entity
  // constructor as entopts), not initial entity data.
  MfaCode(entopts?: Record<string, any>) {
    const self = this
    return new MfaCodeEntity(self, entopts)
  }


  // Entity access: `client.OptOut().list()` / `client.OptOut().load({ id })`.
  // The argument is the entity OPTIONS object (passed to the entity
  // constructor as entopts), not initial entity data.
  OptOut(entopts?: Record<string, any>) {
    const self = this
    return new OptOutEntity(self, entopts)
  }


  // Entity access: `client.OptOutSetting().list()` / `client.OptOutSetting().load({ id })`.
  // The argument is the entity OPTIONS object (passed to the entity
  // constructor as entopts), not initial entity data.
  OptOutSetting(entopts?: Record<string, any>) {
    const self = this
    return new OptOutSettingEntity(self, entopts)
  }


  // Entity access: `client.Permission().list()` / `client.Permission().load({ id })`.
  // The argument is the entity OPTIONS object (passed to the entity
  // constructor as entopts), not initial entity data.
  Permission(entopts?: Record<string, any>) {
    const self = this
    return new PermissionEntity(self, entopts)
  }


  // Entity access: `client.Ping().list()` / `client.Ping().load({ id })`.
  // The argument is the entity OPTIONS object (passed to the entity
  // constructor as entopts), not initial entity data.
  Ping(entopts?: Record<string, any>) {
    const self = this
    return new PingEntity(self, entopts)
  }


  // Entity access: `client.Profile().list()` / `client.Profile().load({ id })`.
  // The argument is the entity OPTIONS object (passed to the entity
  // constructor as entopts), not initial entity data.
  Profile(entopts?: Record<string, any>) {
    const self = this
    return new ProfileEntity(self, entopts)
  }


  // Entity access: `client.Rcs().list()` / `client.Rcs().load({ id })`.
  // The argument is the entity OPTIONS object (passed to the entity
  // constructor as entopts), not initial entity data.
  Rcs(entopts?: Record<string, any>) {
    const self = this
    return new RcsEntity(self, entopts)
  }


  // Entity access: `client.Sendername().list()` / `client.Sendername().load({ id })`.
  // The argument is the entity OPTIONS object (passed to the entity
  // constructor as entopts), not initial entity data.
  Sendername(entopts?: Record<string, any>) {
    const self = this
    return new SendernameEntity(self, entopts)
  }


  // Entity access: `client.SendernameStatement().list()` / `client.SendernameStatement().load({ id })`.
  // The argument is the entity OPTIONS object (passed to the entity
  // constructor as entopts), not initial entity data.
  SendernameStatement(entopts?: Record<string, any>) {
    const self = this
    return new SendernameStatementEntity(self, entopts)
  }


  // Entity access: `client.SentRcsMessage().list()` / `client.SentRcsMessage().load({ id })`.
  // The argument is the entity OPTIONS object (passed to the entity
  // constructor as entopts), not initial entity data.
  SentRcsMessage(entopts?: Record<string, any>) {
    const self = this
    return new SentRcsMessageEntity(self, entopts)
  }


  // Entity access: `client.ShipmentCountryVolume().list()` / `client.ShipmentCountryVolume().load({ id })`.
  // The argument is the entity OPTIONS object (passed to the entity
  // constructor as entopts), not initial entity data.
  ShipmentCountryVolume(entopts?: Record<string, any>) {
    const self = this
    return new ShipmentCountryVolumeEntity(self, entopts)
  }


  // Entity access: `client.ShortUrl().list()` / `client.ShortUrl().load({ id })`.
  // The argument is the entity OPTIONS object (passed to the entity
  // constructor as entopts), not initial entity data.
  ShortUrl(entopts?: Record<string, any>) {
    const self = this
    return new ShortUrlEntity(self, entopts)
  }


  // Entity access: `client.Smsdo().list()` / `client.Smsdo().load({ id })`.
  // The argument is the entity OPTIONS object (passed to the entity
  // constructor as entopts), not initial entity data.
  Smsdo(entopts?: Record<string, any>) {
    const self = this
    return new SmsdoEntity(self, entopts)
  }


  // Entity access: `client.Smssendername().list()` / `client.Smssendername().load({ id })`.
  // The argument is the entity OPTIONS object (passed to the entity
  // constructor as entopts), not initial entity data.
  Smssendername(entopts?: Record<string, any>) {
    const self = this
    return new SmssendernameEntity(self, entopts)
  }


  // Entity access: `client.Smstemplate().list()` / `client.Smstemplate().load({ id })`.
  // The argument is the entity OPTIONS object (passed to the entity
  // constructor as entopts), not initial entity data.
  Smstemplate(entopts?: Record<string, any>) {
    const self = this
    return new SmstemplateEntity(self, entopts)
  }


  // Entity access: `client.Subuser().list()` / `client.Subuser().load({ id })`.
  // The argument is the entity OPTIONS object (passed to the entity
  // constructor as entopts), not initial entity data.
  Subuser(entopts?: Record<string, any>) {
    const self = this
    return new SubuserEntity(self, entopts)
  }


  // Entity access: `client.Template().list()` / `client.Template().load({ id })`.
  // The argument is the entity OPTIONS object (passed to the entity
  // constructor as entopts), not initial entity data.
  Template(entopts?: Record<string, any>) {
    const self = this
    return new TemplateEntity(self, entopts)
  }


  // Entity access: `client.UserRcsSenderCollection().list()` / `client.UserRcsSenderCollection().load({ id })`.
  // The argument is the entity OPTIONS object (passed to the entity
  // constructor as entopts), not initial entity data.
  UserRcsSenderCollection(entopts?: Record<string, any>) {
    const self = this
    return new UserRcsSenderCollectionEntity(self, entopts)
  }




  static test(testoptsarg?: any, sdkoptsarg?: any) {
    const struct = stdutil.struct
    const setpath = struct.setpath
    const getdef = struct.getdef
    const clone = struct.clone
    const setprop = struct.setprop

    const sdkopts = getdef(clone(sdkoptsarg), {})
    const testopts = getdef(clone(testoptsarg), {})
    setprop(testopts, 'active', true)
    setpath(sdkopts, 'feature.test', testopts)

    const testsdk = new SmsapiSDK(sdkopts)
    testsdk._mode = 'test'

    return testsdk
  }


  tester(testopts?: any, sdkopts?: any) {
    return SmsapiSDK.test(testopts, sdkopts)
  }


  toJSON() {
    return { name: 'Smsapi' }
  }

  toString() {
    return 'Smsapi ' + this._utility.struct.jsonify(this.toJSON())
  }

  [inspect.custom]() {
    return this.toString()
  }

}




const SDK = SmsapiSDK


export {
  stdutil,
  config,
  sekreto,


  BaseFeature,
  SmsapiEntityBase,

  SmsapiSDK,
  SDK,
}


