"use strict";
// Smsapi Ts SDK
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    var desc = Object.getOwnPropertyDescriptor(m, k);
    if (!desc || ("get" in desc ? !m.__esModule : desc.writable || desc.configurable)) {
      desc = { enumerable: true, get: function() { return m[k]; } };
    }
    Object.defineProperty(o, k2, desc);
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || (function () {
    var ownKeys = function(o) {
        ownKeys = Object.getOwnPropertyNames || function (o) {
            var ar = [];
            for (var k in o) if (Object.prototype.hasOwnProperty.call(o, k)) ar[ar.length] = k;
            return ar;
        };
        return ownKeys(o);
    };
    return function (mod) {
        if (mod && mod.__esModule) return mod;
        var result = {};
        if (mod != null) for (var k = ownKeys(mod), i = 0; i < k.length; i++) if (k[i] !== "default") __createBinding(result, mod, k[i]);
        __setModuleDefault(result, mod);
        return result;
    };
})();
Object.defineProperty(exports, "__esModule", { value: true });
exports.SDK = exports.SmsapiSDK = exports.SmsapiEntityBase = exports.BaseFeature = exports.sekreto = exports.config = exports.stdutil = void 0;
const AvailableEntity_1 = require("./entity/AvailableEntity");
const BlacklistEntity_1 = require("./entity/BlacklistEntity");
const CallbackEntity_1 = require("./entity/CallbackEntity");
const ContactEntity_1 = require("./entity/ContactEntity");
const ContactsFieldEntity_1 = require("./entity/ContactsFieldEntity");
const ContactsFieldOptionEntity_1 = require("./entity/ContactsFieldOptionEntity");
const ContactsgroupEntity_1 = require("./entity/ContactsgroupEntity");
const ContactstrashEntity_1 = require("./entity/ContactstrashEntity");
const FieldAvailableEntity_1 = require("./entity/FieldAvailableEntity");
const GroupEntity_1 = require("./entity/GroupEntity");
const MfaCodeEntity_1 = require("./entity/MfaCodeEntity");
const OptOutEntity_1 = require("./entity/OptOutEntity");
const OptOutSettingEntity_1 = require("./entity/OptOutSettingEntity");
const PermissionEntity_1 = require("./entity/PermissionEntity");
const PingEntity_1 = require("./entity/PingEntity");
const ProfileEntity_1 = require("./entity/ProfileEntity");
const RcsEntity_1 = require("./entity/RcsEntity");
const SendernameEntity_1 = require("./entity/SendernameEntity");
const SendernameStatementEntity_1 = require("./entity/SendernameStatementEntity");
const SentRcsMessageEntity_1 = require("./entity/SentRcsMessageEntity");
const ShipmentCountryVolumeEntity_1 = require("./entity/ShipmentCountryVolumeEntity");
const ShortUrlEntity_1 = require("./entity/ShortUrlEntity");
const SmsdoEntity_1 = require("./entity/SmsdoEntity");
const SmssendernameEntity_1 = require("./entity/SmssendernameEntity");
const SmstemplateEntity_1 = require("./entity/SmstemplateEntity");
const SubuserEntity_1 = require("./entity/SubuserEntity");
const TemplateEntity_1 = require("./entity/TemplateEntity");
const UserRcsSenderCollectionEntity_1 = require("./entity/UserRcsSenderCollectionEntity");
const node_util_1 = require("node:util");
const Config_1 = require("./Config");
Object.defineProperty(exports, "config", { enumerable: true, get: function () { return Config_1.config; } });
const SmsapiEntityBase_1 = require("./SmsapiEntityBase");
Object.defineProperty(exports, "SmsapiEntityBase", { enumerable: true, get: function () { return SmsapiEntityBase_1.SmsapiEntityBase; } });
const Utility_1 = require("./utility/Utility");
const BaseFeature_1 = require("./feature/base/BaseFeature");
Object.defineProperty(exports, "BaseFeature", { enumerable: true, get: function () { return BaseFeature_1.BaseFeature; } });
const sekreto = __importStar(require("./feature/secrets/sekreto"));
exports.sekreto = sekreto;
const stdutil = new Utility_1.Utility();
exports.stdutil = stdutil;
class SmsapiSDK {
    _mode = 'live';
    _options;
    _utility = new Utility_1.Utility();
    _features;
    _rootctx;
    _secrets;
    constructor(options) {
        this._rootctx = this._utility.makeContext({
            client: this,
            utility: this._utility,
            config: Config_1.config,
            options,
            shared: new WeakMap()
        });
        this._options = this._utility.makeOptions(this._rootctx);
        for (const key of ['_options', '_rootctx', '_features']) {
            Object.defineProperty(this, key, {
                value: this[key], enumerable: false, writable: true, configurable: true
            });
        }
        const struct = this._utility.struct;
        const getpath = struct.getpath;
        if (true === getpath(this._options.feature, 'test.active')) {
            this._mode = 'test';
        }
        this._rootctx.options = this._options;
        this._features = [];
        const featureAdd = this._utility.featureAdd;
        const featureInit = this._utility.featureInit;
        // Add features in the resolved order (makeOptions puts an explicit
        // array order first, else defaults to test-first). Ordering matters:
        // the `test` feature installs the base mock transport and the transport
        // features (retry/cache/netsim/proxy/ratelimit) wrap whatever is current,
        // so `test` must be added before them to sit at the base of the chain.
        const extend = this._options.extend || [];
        const featureorder = getpath(this._options, '__derived__.featureorder') || [];
        for (const fname of featureorder) {
            const fopts = this._options.feature[fname] || {};
            if (fopts.active) {
                // An active name with no generated class is legal when an
                // extend-supplied instance carries that name (station's adopt
                // path): the instance is added below, positioned by its own
                // __after__ entry, so skip it here rather than fail construction.
                if (!this._rootctx.config.hasFeature(fname) &&
                    extend.some((f) => fname === f.name)) {
                    continue;
                }
                featureAdd(this._rootctx, this._rootctx.config.makeFeature(fname));
            }
        }
        for (let f of extend) {
            featureAdd(this._rootctx, f);
        }
        for (let f of this._features) {
            featureInit(this._rootctx, f);
        }
        const featureHook = this._utility.featureHook;
        featureHook(this._rootctx, 'PostConstruct');
    }
    options() {
        return this._utility.struct.clone(this._options);
    }
    utility() {
        return this._utility.struct.clone(this._utility);
    }
    secrets() {
        return this._secrets && this._secrets.sekreto();
    }
    async prepare(fetchargs) {
        const utility = this._utility;
        const struct = utility.struct;
        const clone = struct.clone;
        const { makeContext, makeFetchDef, prepareHeaders, prepareAuth, } = utility;
        fetchargs = fetchargs || {};
        let ctx = makeContext({
            opname: 'prepare',
            ctrl: fetchargs.ctrl || {},
        }, this._rootctx);
        const options = this._options;
        const spec = {
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
        };
        ctx.spec = spec;
        if (fetchargs.headers) {
            const uheaders = fetchargs.headers;
            for (let key in uheaders) {
                spec.headers[key] = uheaders[key];
            }
        }
        if (null != this._secrets) {
            try {
                await this._secrets.resolve();
            }
            catch (err) {
                return err instanceof Error ? err : new Error(String(err));
            }
        }
        const authResult = prepareAuth(ctx);
        if (authResult instanceof Error) {
            return authResult;
        }
        return makeFetchDef(ctx);
    }
    // Raw endpoint access is operator-controllable, like every entity op.
    // Blocking it means denying BOTH the 'direct' and 'graphql' tokens, since
    // either one reaches the same endpoint.
    async direct(fetchargs) {
        if (!this._options.allow.op.includes('direct')) {
            return {
                ok: false,
                err: new Error('SmsapiSDK: direct: operation not allowed by' +
                    ' SDK option allow.op value: "' + this._options.allow.op + '"'),
            };
        }
        return this._rawRequest(fetchargs);
    }
    // Ungated request path shared by direct() and graphql(), each of which
    // checks its own allow.op token first. Private, rather than a flag on
    // fetchargs: a caller-supplied marker would let anyone opt straight back
    // out of the gate by passing it.
    async _rawRequest(fetchargs) {
        const utility = this._utility;
        const fetcher = utility.fetcher;
        const makeContext = utility.makeContext;
        const fetchdef = await this.prepare(fetchargs);
        if (fetchdef instanceof Error) {
            return fetchdef;
        }
        let ctx = makeContext({
            opname: 'direct',
            ctrl: (fetchargs || {}).ctrl || {},
        }, this._rootctx);
        try {
            const fetched = await fetcher(ctx, fetchdef.url, fetchdef);
            if (null == fetched) {
                return { ok: false, err: ctx.error('direct_no_response', 'response: undefined') };
            }
            else if (fetched instanceof Error) {
                return { ok: false, err: utility.clean(ctx, fetched) };
            }
            const status = fetched.status;
            // No body responses (204 No Content, 304 Not Modified) and explicit
            // zero content-length must skip JSON parsing — fetched.json() would
            // throw `Unexpected end of JSON input` on an empty body.
            const headers = fetched.headers;
            const contentLength = headers && 'function' === typeof headers.get
                ? headers.get('content-length')
                : (headers || {})['content-length'];
            const noBody = 204 === status || 304 === status || '0' === String(contentLength);
            let json = undefined;
            if (!noBody) {
                try {
                    json = 'function' === typeof fetched.json ? await fetched.json() : fetched.json;
                }
                catch (parseErr) {
                    // Body wasn't valid JSON — surface the raw response rather than
                    // throwing. data stays undefined; callers can inspect status/headers.
                    json = undefined;
                }
            }
            return {
                ok: status >= 200 && status < 300,
                status,
                headers: fetched.headers,
                data: json,
            };
        }
        catch (err) {
            return { ok: false, err: utility.clean(ctx, err) };
        }
    }
    async graphql(query, variables, ctrl) {
        const options = this._options;
        if (!options.allow.op.includes('graphql')) {
            return {
                ok: false,
                err: new Error('SmsapiSDK: graphql: operation not allowed by' +
                    ' SDK option allow.op value: "' + options.allow.op + '"'),
            };
        }
        const res = await this._rawRequest({
            method: 'POST',
            headers: { 'content-type': 'application/json' },
            body: { query, variables: variables || {} },
            ctrl,
        });
        if (res instanceof Error) {
            return res;
        }
        // Errors are read BEFORE any status check: a GraphQL parse or validation
        // failure comes back as HTTP 400 carrying the standard { errors: [...] }
        // body, and the raw path represents a non-2xx as { ok: false } with no
        // err — so returning early on status would discard the server's own
        // diagnostics, which are the only useful part of that response.
        const errors = null == res.data ? undefined : res.data.errors;
        if (null != errors && Array.isArray(errors) && 0 < errors.length) {
            const first = errors[0] || {};
            const err = new Error('SmsapiSDK: graphql: ' +
                (first.message || 'graphql error'));
            err.graphql = errors;
            return { ok: false, status: res.status, headers: res.headers, err, data: res.data };
        }
        return res;
    }
    // Entity access: `client.Available().list()` / `client.Available().load({ id })`.
    // The argument is the entity OPTIONS object (passed to the entity
    // constructor as entopts), not initial entity data.
    Available(entopts) {
        const self = this;
        return new AvailableEntity_1.AvailableEntity(self, entopts);
    }
    // Entity access: `client.Blacklist().list()` / `client.Blacklist().load({ id })`.
    // The argument is the entity OPTIONS object (passed to the entity
    // constructor as entopts), not initial entity data.
    Blacklist(entopts) {
        const self = this;
        return new BlacklistEntity_1.BlacklistEntity(self, entopts);
    }
    // Entity access: `client.Callback().list()` / `client.Callback().load({ id })`.
    // The argument is the entity OPTIONS object (passed to the entity
    // constructor as entopts), not initial entity data.
    Callback(entopts) {
        const self = this;
        return new CallbackEntity_1.CallbackEntity(self, entopts);
    }
    // Entity access: `client.Contact().list()` / `client.Contact().load({ id })`.
    // The argument is the entity OPTIONS object (passed to the entity
    // constructor as entopts), not initial entity data.
    Contact(entopts) {
        const self = this;
        return new ContactEntity_1.ContactEntity(self, entopts);
    }
    // Entity access: `client.ContactsField().list()` / `client.ContactsField().load({ id })`.
    // The argument is the entity OPTIONS object (passed to the entity
    // constructor as entopts), not initial entity data.
    ContactsField(entopts) {
        const self = this;
        return new ContactsFieldEntity_1.ContactsFieldEntity(self, entopts);
    }
    // Entity access: `client.ContactsFieldOption().list()` / `client.ContactsFieldOption().load({ id })`.
    // The argument is the entity OPTIONS object (passed to the entity
    // constructor as entopts), not initial entity data.
    ContactsFieldOption(entopts) {
        const self = this;
        return new ContactsFieldOptionEntity_1.ContactsFieldOptionEntity(self, entopts);
    }
    // Entity access: `client.Contactsgroup().list()` / `client.Contactsgroup().load({ id })`.
    // The argument is the entity OPTIONS object (passed to the entity
    // constructor as entopts), not initial entity data.
    Contactsgroup(entopts) {
        const self = this;
        return new ContactsgroupEntity_1.ContactsgroupEntity(self, entopts);
    }
    // Entity access: `client.Contactstrash().list()` / `client.Contactstrash().load({ id })`.
    // The argument is the entity OPTIONS object (passed to the entity
    // constructor as entopts), not initial entity data.
    Contactstrash(entopts) {
        const self = this;
        return new ContactstrashEntity_1.ContactstrashEntity(self, entopts);
    }
    // Entity access: `client.FieldAvailable().list()` / `client.FieldAvailable().load({ id })`.
    // The argument is the entity OPTIONS object (passed to the entity
    // constructor as entopts), not initial entity data.
    FieldAvailable(entopts) {
        const self = this;
        return new FieldAvailableEntity_1.FieldAvailableEntity(self, entopts);
    }
    // Entity access: `client.Group().list()` / `client.Group().load({ id })`.
    // The argument is the entity OPTIONS object (passed to the entity
    // constructor as entopts), not initial entity data.
    Group(entopts) {
        const self = this;
        return new GroupEntity_1.GroupEntity(self, entopts);
    }
    // Entity access: `client.MfaCode().list()` / `client.MfaCode().load({ id })`.
    // The argument is the entity OPTIONS object (passed to the entity
    // constructor as entopts), not initial entity data.
    MfaCode(entopts) {
        const self = this;
        return new MfaCodeEntity_1.MfaCodeEntity(self, entopts);
    }
    // Entity access: `client.OptOut().list()` / `client.OptOut().load({ id })`.
    // The argument is the entity OPTIONS object (passed to the entity
    // constructor as entopts), not initial entity data.
    OptOut(entopts) {
        const self = this;
        return new OptOutEntity_1.OptOutEntity(self, entopts);
    }
    // Entity access: `client.OptOutSetting().list()` / `client.OptOutSetting().load({ id })`.
    // The argument is the entity OPTIONS object (passed to the entity
    // constructor as entopts), not initial entity data.
    OptOutSetting(entopts) {
        const self = this;
        return new OptOutSettingEntity_1.OptOutSettingEntity(self, entopts);
    }
    // Entity access: `client.Permission().list()` / `client.Permission().load({ id })`.
    // The argument is the entity OPTIONS object (passed to the entity
    // constructor as entopts), not initial entity data.
    Permission(entopts) {
        const self = this;
        return new PermissionEntity_1.PermissionEntity(self, entopts);
    }
    // Entity access: `client.Ping().list()` / `client.Ping().load({ id })`.
    // The argument is the entity OPTIONS object (passed to the entity
    // constructor as entopts), not initial entity data.
    Ping(entopts) {
        const self = this;
        return new PingEntity_1.PingEntity(self, entopts);
    }
    // Entity access: `client.Profile().list()` / `client.Profile().load({ id })`.
    // The argument is the entity OPTIONS object (passed to the entity
    // constructor as entopts), not initial entity data.
    Profile(entopts) {
        const self = this;
        return new ProfileEntity_1.ProfileEntity(self, entopts);
    }
    // Entity access: `client.Rcs().list()` / `client.Rcs().load({ id })`.
    // The argument is the entity OPTIONS object (passed to the entity
    // constructor as entopts), not initial entity data.
    Rcs(entopts) {
        const self = this;
        return new RcsEntity_1.RcsEntity(self, entopts);
    }
    // Entity access: `client.Sendername().list()` / `client.Sendername().load({ id })`.
    // The argument is the entity OPTIONS object (passed to the entity
    // constructor as entopts), not initial entity data.
    Sendername(entopts) {
        const self = this;
        return new SendernameEntity_1.SendernameEntity(self, entopts);
    }
    // Entity access: `client.SendernameStatement().list()` / `client.SendernameStatement().load({ id })`.
    // The argument is the entity OPTIONS object (passed to the entity
    // constructor as entopts), not initial entity data.
    SendernameStatement(entopts) {
        const self = this;
        return new SendernameStatementEntity_1.SendernameStatementEntity(self, entopts);
    }
    // Entity access: `client.SentRcsMessage().list()` / `client.SentRcsMessage().load({ id })`.
    // The argument is the entity OPTIONS object (passed to the entity
    // constructor as entopts), not initial entity data.
    SentRcsMessage(entopts) {
        const self = this;
        return new SentRcsMessageEntity_1.SentRcsMessageEntity(self, entopts);
    }
    // Entity access: `client.ShipmentCountryVolume().list()` / `client.ShipmentCountryVolume().load({ id })`.
    // The argument is the entity OPTIONS object (passed to the entity
    // constructor as entopts), not initial entity data.
    ShipmentCountryVolume(entopts) {
        const self = this;
        return new ShipmentCountryVolumeEntity_1.ShipmentCountryVolumeEntity(self, entopts);
    }
    // Entity access: `client.ShortUrl().list()` / `client.ShortUrl().load({ id })`.
    // The argument is the entity OPTIONS object (passed to the entity
    // constructor as entopts), not initial entity data.
    ShortUrl(entopts) {
        const self = this;
        return new ShortUrlEntity_1.ShortUrlEntity(self, entopts);
    }
    // Entity access: `client.Smsdo().list()` / `client.Smsdo().load({ id })`.
    // The argument is the entity OPTIONS object (passed to the entity
    // constructor as entopts), not initial entity data.
    Smsdo(entopts) {
        const self = this;
        return new SmsdoEntity_1.SmsdoEntity(self, entopts);
    }
    // Entity access: `client.Smssendername().list()` / `client.Smssendername().load({ id })`.
    // The argument is the entity OPTIONS object (passed to the entity
    // constructor as entopts), not initial entity data.
    Smssendername(entopts) {
        const self = this;
        return new SmssendernameEntity_1.SmssendernameEntity(self, entopts);
    }
    // Entity access: `client.Smstemplate().list()` / `client.Smstemplate().load({ id })`.
    // The argument is the entity OPTIONS object (passed to the entity
    // constructor as entopts), not initial entity data.
    Smstemplate(entopts) {
        const self = this;
        return new SmstemplateEntity_1.SmstemplateEntity(self, entopts);
    }
    // Entity access: `client.Subuser().list()` / `client.Subuser().load({ id })`.
    // The argument is the entity OPTIONS object (passed to the entity
    // constructor as entopts), not initial entity data.
    Subuser(entopts) {
        const self = this;
        return new SubuserEntity_1.SubuserEntity(self, entopts);
    }
    // Entity access: `client.Template().list()` / `client.Template().load({ id })`.
    // The argument is the entity OPTIONS object (passed to the entity
    // constructor as entopts), not initial entity data.
    Template(entopts) {
        const self = this;
        return new TemplateEntity_1.TemplateEntity(self, entopts);
    }
    // Entity access: `client.UserRcsSenderCollection().list()` / `client.UserRcsSenderCollection().load({ id })`.
    // The argument is the entity OPTIONS object (passed to the entity
    // constructor as entopts), not initial entity data.
    UserRcsSenderCollection(entopts) {
        const self = this;
        return new UserRcsSenderCollectionEntity_1.UserRcsSenderCollectionEntity(self, entopts);
    }
    static test(testoptsarg, sdkoptsarg) {
        const struct = stdutil.struct;
        const setpath = struct.setpath;
        const getdef = struct.getdef;
        const clone = struct.clone;
        const setprop = struct.setprop;
        const sdkopts = getdef(clone(sdkoptsarg), {});
        const testopts = getdef(clone(testoptsarg), {});
        setprop(testopts, 'active', true);
        setpath(sdkopts, 'feature.test', testopts);
        const testsdk = new SmsapiSDK(sdkopts);
        testsdk._mode = 'test';
        return testsdk;
    }
    tester(testopts, sdkopts) {
        return SmsapiSDK.test(testopts, sdkopts);
    }
    toJSON() {
        return { name: 'Smsapi' };
    }
    toString() {
        return 'Smsapi ' + this._utility.struct.jsonify(this.toJSON());
    }
    [node_util_1.inspect.custom]() {
        return this.toString();
    }
}
exports.SmsapiSDK = SmsapiSDK;
const SDK = SmsapiSDK;
exports.SDK = SDK;
//# sourceMappingURL=SmsapiSDK.js.map