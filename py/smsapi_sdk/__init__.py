# Smsapi SDK

from smsapi_sdk.utility.voxgig_struct import voxgig_struct as vs
from smsapi_sdk.core.utility_type import SmsapiUtility
from smsapi_sdk.core.spec import SmsapiSpec
from smsapi_sdk.core import helpers

# Load utility registration (populates Utility._registrar)
from smsapi_sdk.utility import register

# Load features
from smsapi_sdk.feature.base_feature import SmsapiBaseFeature
from smsapi_sdk.features import _has_feature, _make_feature


class SmsapiSDK:
    # The options hold the credential. A slot keeps them reachable as
    # `client.options` and out of `vars(client)` and every attribute dump;
    # the dict entry keeps the instance open for everything else.
    __slots__ = ("_options", "__dict__")

    def __init__(self, options=None):
        self.mode = "live"
        self.features = []
        self._options = None

        utility = SmsapiUtility()
        self._utility = utility

        from smsapi_sdk.config import shared_config
        config = shared_config()

        self._rootctx = utility.make_context({
            "client": self,
            "utility": utility,
            "config": config,
            "options": options if options is not None else {},
            "shared": {},
        }, None)

        self.options = utility.make_options(self._rootctx)

        if vs.getpath(self.options, "feature.test.active") is True:
            self.mode = "test"

        self._rootctx.options = self.options

        # Add features in the resolved order (make_options puts an explicit
        # list order first, else defaults to test-first). Ordering matters: the
        # `test` feature installs the base mock transport and the transport
        # features (retry/cache/netsim/proxy/ratelimit) wrap whatever is
        # current, so `test` must be added before them to sit at the base.
        # Extension feature INSTANCES come from the RAW construction
        # options - extend is consumed exactly once, here. make_options
        # strips the key before cloning (vs.clone flattens arbitrary
        # objects), so self.options never carries the instances.
        feature_opts = helpers.to_map(vs.getprop(self.options, "feature"))
        extend = options.get("extend") if isinstance(options, dict) else None
        if not isinstance(extend, list):
            extend = []
        if feature_opts is not None:
            featureorder = vs.getpath(self.options, "__derived__.featureorder")
            if isinstance(featureorder, list):
                for fname in featureorder:
                    fopts = helpers.to_map(feature_opts.get(fname))
                    if fopts is not None and fopts.get("active") is True:
                        # An active name with no generated feature class is
                        # legal when an extend-supplied instance carries that
                        # name (station's adopt path): the instance is added
                        # below, positioned by its own __after__ entry, so
                        # skip it here rather than add a BaseFeature stray
                        # that would silently shift feature positions.
                        if not _has_feature(fname) and any(
                            fname == (f.get("name") if isinstance(f, dict)
                                      else getattr(f, "name", None))
                            for f in extend
                        ):
                            continue
                        utility.feature_add(self._rootctx, _make_feature(fname))

        # Add extension features.
        for f in extend:
            if isinstance(f, dict) or (hasattr(f, "get_name") and callable(f.get_name)):
                utility.feature_add(self._rootctx, f)

        # Initialize features.
        for f in self.features:
            utility.feature_init(self._rootctx, f)

        utility.feature_hook(self._rootctx, "PostConstruct")

        # #BuildFeatures

    @property
    def options(self):
        return self._options

    @options.setter
    def options(self, value):
        self._options = value

    def __repr__(self):
        return "SmsapiSDK(mode=" + repr(self.mode) + ")"

    def options_map(self):
        out = vs.clone(self.options)
        if isinstance(out, dict):
            return out
        return {}

    def get_utility(self):
        return SmsapiUtility.copy(self._utility)

    def get_root_ctx(self):
        return self._rootctx

    def secrets(self):
        _s = getattr(self, "_secrets", None)
        return None if _s is None else _s.sekreto()

    def prepare(self, fetchargs=None):
        utility = self._utility

        if fetchargs is None:
            fetchargs = {}

        ctrl = helpers.to_map(vs.getprop(fetchargs, "ctrl"))
        if ctrl is None:
            ctrl = {}

        ctx = utility.make_context({
            "opname": "prepare",
            "ctrl": ctrl,
        }, self._rootctx)

        if getattr(self, "_secrets", None) is not None:
            self._secrets.resolve()

        options = self.options

        path = vs.getprop(fetchargs, "path") or ""
        if not isinstance(path, str):
            path = ""

        method = vs.getprop(fetchargs, "method") or "GET"
        if not isinstance(method, str):
            method = "GET"

        params = helpers.to_map(vs.getprop(fetchargs, "params"))
        if params is None:
            params = {}
        query = helpers.to_map(vs.getprop(fetchargs, "query"))
        if query is None:
            query = {}

        headers = utility.prepare_headers(ctx)

        base = vs.getprop(options, "base") or ""
        if not isinstance(base, str):
            base = ""
        prefix = vs.getprop(options, "prefix") or ""
        if not isinstance(prefix, str):
            prefix = ""
        suffix = vs.getprop(options, "suffix") or ""
        if not isinstance(suffix, str):
            suffix = ""

        ctx.spec = SmsapiSpec({
            "base": base,
            "prefix": prefix,
            "suffix": suffix,
            "path": path,
            "method": method,
            "params": params,
            "query": query,
            "headers": headers,
            "body": vs.getprop(fetchargs, "body"),
            "step": "start",
        })

        # Merge user-provided headers.
        uh = vs.getprop(fetchargs, "headers")
        if isinstance(uh, dict):
            for k, v in uh.items():
                ctx.spec.headers[k] = v

        _, err = utility.prepare_auth(ctx)
        if err is not None:
            raise err

        fetchdef, err = utility.make_fetch_def(ctx)
        if err is not None:
            raise err

        return fetchdef

    # Raw endpoint access is operator-controllable, like every entity op.
    # Blocking it means denying BOTH the 'direct' and 'graphql' tokens, since
    # either one reaches the same endpoint.
    def direct(self, fetchargs=None):
        if not self._op_allowed("direct"):
            return self._op_denied("direct")

        return self._raw_request(fetchargs)

    # Is this raw-access op permitted by the SDK's allow.op option?
    def _op_allowed(self, op):
        allow_op = vs.getpath(self.options, "allow.op")
        return isinstance(allow_op, str) and op in allow_op

    def _op_denied(self, op):
        allow_op = vs.getpath(self.options, "allow.op")
        return {
            "ok": False,
            "err": Exception(
                "SmsapiSDK: " + op + ": operation not allowed by"
                ' SDK option allow.op value: "' + str(allow_op) + '"'),
        }

    # Ungated request path shared by direct and graphql, each of which checks
    # its own allow.op token first. Private, rather than a flag on fetchargs:
    # a caller-supplied marker would let anyone opt straight back out of the
    # gate by passing it.
    def _raw_request(self, fetchargs=None):
        utility = self._utility

        try:
            fetchdef = self.prepare(fetchargs)
        except Exception as err:
            # direct() is the raw-HTTP escape hatch: it never raises, it
            # returns a result object callers branch on via result["ok"].
            # That error never passes through make_error, so it is cleaned.
            return {"ok": False, "err": utility.clean(self._rootctx, err)}

        if fetchargs is None:
            fetchargs = {}
        ctrl = helpers.to_map(vs.getprop(fetchargs, "ctrl"))
        if ctrl is None:
            ctrl = {}

        ctx = utility.make_context({
            "opname": "direct",
            "ctrl": ctrl,
        }, self._rootctx)

        url = fetchdef.get("url", "")
        fetched, fetch_err = utility.fetcher(ctx, url, fetchdef)

        if fetch_err is not None:
            return {"ok": False, "err": utility.clean(ctx, fetch_err)}

        if fetched is None:
            return {
                "ok": False,
                "err": ctx.make_error("direct_no_response", "response: undefined"),
            }

        if isinstance(fetched, dict):
            status = helpers.to_int(vs.getprop(fetched, "status"))
            headers = vs.getprop(fetched, "headers") or {}

            # No-body responses (204, 304) and explicit zero content-length
            # must skip JSON parsing — calling json() on an empty body raises.
            content_length = None
            if isinstance(headers, dict):
                content_length = headers.get("content-length")
            no_body = status in (204, 304) or str(content_length) == "0"

            json_data = None
            if not no_body:
                jf = vs.getprop(fetched, "json")
                if callable(jf):
                    try:
                        json_data = jf()
                    except Exception:
                        # Non-JSON body (e.g. text/plain, text/html). Surface
                        # status + headers but leave data as None.
                        json_data = None

            return {
                "ok": status >= 200 and status < 300,
                "status": status,
                "headers": headers,
                "data": json_data,
            }

        return {
            "ok": False,
            "err": ctx.make_error("direct_invalid", "invalid response type"),
        }

    # Raw GraphQL access: the pressure valve that makes the generated
    # surface's deliberate omissions (per-call selection sets, typed filter
    # builders, batching, subscriptions) livable — the whole schema stays
    # reachable.
    #
    # Thin wrapper over the same prepare/fetch path direct uses, with the one
    # thing raw direct cannot do for GraphQL: a GraphQL failure rides HTTP 200
    # as a top-level `errors` array, so status alone would report a failed
    # query as ok.
    #
    # NOTE: like direct, this bypasses the feature pipeline — no retry,
    # ratelimit or paging features apply.
    def graphql(self, query, variables=None, ctrl=None):
        if not self._op_allowed("graphql"):
            return self._op_denied("graphql")

        res = self._raw_request({
            "method": "POST",
            "headers": {"content-type": "application/json"},
            "body": {"query": query, "variables": variables or {}},
            "ctrl": ctrl or {},
        })

        # Errors are read BEFORE any status check: a GraphQL parse or
        # validation failure comes back as HTTP 400 carrying the standard
        # { errors: [...] } body, and the raw path represents a non-2xx as
        # ok:False with no err — so returning early on status would discard
        # the server's own diagnostics, which are the only useful part of
        # that response.
        errors = vs.getpath(res, "data.errors")

        if isinstance(errors, list) and 0 < len(errors):
            first = errors[0] if isinstance(errors[0], dict) else {}
            msg = first.get("message") or "graphql error"
            res["ok"] = False
            res["err"] = Exception("SmsapiSDK: graphql: " + str(msg))
            res["graphql"] = errors

        return res


    def Available(self, data=None) -> "AvailableEntity":
        """Entity factory: client.Available().list() / client.Available().load({"id": ...})."""
        from smsapi_sdk.entity.available_entity import AvailableEntity
        return AvailableEntity(self, data)


    def Blacklist(self, data=None) -> "BlacklistEntity":
        """Entity factory: client.Blacklist().list() / client.Blacklist().load({"id": ...})."""
        from smsapi_sdk.entity.blacklist_entity import BlacklistEntity
        return BlacklistEntity(self, data)


    def Callback(self, data=None) -> "CallbackEntity":
        """Entity factory: client.Callback().list() / client.Callback().load({"id": ...})."""
        from smsapi_sdk.entity.callback_entity import CallbackEntity
        return CallbackEntity(self, data)


    def Contact(self, data=None) -> "ContactEntity":
        """Entity factory: client.Contact().list() / client.Contact().load({"id": ...})."""
        from smsapi_sdk.entity.contact_entity import ContactEntity
        return ContactEntity(self, data)


    def ContactsField(self, data=None) -> "ContactsFieldEntity":
        """Entity factory: client.ContactsField().list() / client.ContactsField().load({"id": ...})."""
        from smsapi_sdk.entity.contacts_field_entity import ContactsFieldEntity
        return ContactsFieldEntity(self, data)


    def ContactsFieldOption(self, data=None) -> "ContactsFieldOptionEntity":
        """Entity factory: client.ContactsFieldOption().list() / client.ContactsFieldOption().load({"id": ...})."""
        from smsapi_sdk.entity.contacts_field_option_entity import ContactsFieldOptionEntity
        return ContactsFieldOptionEntity(self, data)


    def Contactsgroup(self, data=None) -> "ContactsgroupEntity":
        """Entity factory: client.Contactsgroup().list() / client.Contactsgroup().load({"id": ...})."""
        from smsapi_sdk.entity.contactsgroup_entity import ContactsgroupEntity
        return ContactsgroupEntity(self, data)


    def Contactstrash(self, data=None) -> "ContactstrashEntity":
        """Entity factory: client.Contactstrash().list() / client.Contactstrash().load({"id": ...})."""
        from smsapi_sdk.entity.contactstrash_entity import ContactstrashEntity
        return ContactstrashEntity(self, data)


    def FieldAvailable(self, data=None) -> "FieldAvailableEntity":
        """Entity factory: client.FieldAvailable().list() / client.FieldAvailable().load({"id": ...})."""
        from smsapi_sdk.entity.field_available_entity import FieldAvailableEntity
        return FieldAvailableEntity(self, data)


    def Group(self, data=None) -> "GroupEntity":
        """Entity factory: client.Group().list() / client.Group().load({"id": ...})."""
        from smsapi_sdk.entity.group_entity import GroupEntity
        return GroupEntity(self, data)


    def MfaCode(self, data=None) -> "MfaCodeEntity":
        """Entity factory: client.MfaCode().list() / client.MfaCode().load({"id": ...})."""
        from smsapi_sdk.entity.mfa_code_entity import MfaCodeEntity
        return MfaCodeEntity(self, data)


    def OptOut(self, data=None) -> "OptOutEntity":
        """Entity factory: client.OptOut().list() / client.OptOut().load({"id": ...})."""
        from smsapi_sdk.entity.opt_out_entity import OptOutEntity
        return OptOutEntity(self, data)


    def OptOutSetting(self, data=None) -> "OptOutSettingEntity":
        """Entity factory: client.OptOutSetting().list() / client.OptOutSetting().load({"id": ...})."""
        from smsapi_sdk.entity.opt_out_setting_entity import OptOutSettingEntity
        return OptOutSettingEntity(self, data)


    def Permission(self, data=None) -> "PermissionEntity":
        """Entity factory: client.Permission().list() / client.Permission().load({"id": ...})."""
        from smsapi_sdk.entity.permission_entity import PermissionEntity
        return PermissionEntity(self, data)


    def Ping(self, data=None) -> "PingEntity":
        """Entity factory: client.Ping().list() / client.Ping().load({"id": ...})."""
        from smsapi_sdk.entity.ping_entity import PingEntity
        return PingEntity(self, data)


    def Profile(self, data=None) -> "ProfileEntity":
        """Entity factory: client.Profile().list() / client.Profile().load({"id": ...})."""
        from smsapi_sdk.entity.profile_entity import ProfileEntity
        return ProfileEntity(self, data)


    def Rcs(self, data=None) -> "RcsEntity":
        """Entity factory: client.Rcs().list() / client.Rcs().load({"id": ...})."""
        from smsapi_sdk.entity.rcs_entity import RcsEntity
        return RcsEntity(self, data)


    def Sendername(self, data=None) -> "SendernameEntity":
        """Entity factory: client.Sendername().list() / client.Sendername().load({"id": ...})."""
        from smsapi_sdk.entity.sendername_entity import SendernameEntity
        return SendernameEntity(self, data)


    def SendernameStatement(self, data=None) -> "SendernameStatementEntity":
        """Entity factory: client.SendernameStatement().list() / client.SendernameStatement().load({"id": ...})."""
        from smsapi_sdk.entity.sendername_statement_entity import SendernameStatementEntity
        return SendernameStatementEntity(self, data)


    def SentRcsMessage(self, data=None) -> "SentRcsMessageEntity":
        """Entity factory: client.SentRcsMessage().list() / client.SentRcsMessage().load({"id": ...})."""
        from smsapi_sdk.entity.sent_rcs_message_entity import SentRcsMessageEntity
        return SentRcsMessageEntity(self, data)


    def ShipmentCountryVolume(self, data=None) -> "ShipmentCountryVolumeEntity":
        """Entity factory: client.ShipmentCountryVolume().list() / client.ShipmentCountryVolume().load({"id": ...})."""
        from smsapi_sdk.entity.shipment_country_volume_entity import ShipmentCountryVolumeEntity
        return ShipmentCountryVolumeEntity(self, data)


    def ShortUrl(self, data=None) -> "ShortUrlEntity":
        """Entity factory: client.ShortUrl().list() / client.ShortUrl().load({"id": ...})."""
        from smsapi_sdk.entity.short_url_entity import ShortUrlEntity
        return ShortUrlEntity(self, data)


    def Smsdo(self, data=None) -> "SmsdoEntity":
        """Entity factory: client.Smsdo().list() / client.Smsdo().load({"id": ...})."""
        from smsapi_sdk.entity.smsdo_entity import SmsdoEntity
        return SmsdoEntity(self, data)


    def Smssendername(self, data=None) -> "SmssendernameEntity":
        """Entity factory: client.Smssendername().list() / client.Smssendername().load({"id": ...})."""
        from smsapi_sdk.entity.smssendername_entity import SmssendernameEntity
        return SmssendernameEntity(self, data)


    def Smstemplate(self, data=None) -> "SmstemplateEntity":
        """Entity factory: client.Smstemplate().list() / client.Smstemplate().load({"id": ...})."""
        from smsapi_sdk.entity.smstemplate_entity import SmstemplateEntity
        return SmstemplateEntity(self, data)


    def Subuser(self, data=None) -> "SubuserEntity":
        """Entity factory: client.Subuser().list() / client.Subuser().load({"id": ...})."""
        from smsapi_sdk.entity.subuser_entity import SubuserEntity
        return SubuserEntity(self, data)


    def Template(self, data=None) -> "TemplateEntity":
        """Entity factory: client.Template().list() / client.Template().load({"id": ...})."""
        from smsapi_sdk.entity.template_entity import TemplateEntity
        return TemplateEntity(self, data)


    def UserRcsSenderCollection(self, data=None) -> "UserRcsSenderCollectionEntity":
        """Entity factory: client.UserRcsSenderCollection().list() / client.UserRcsSenderCollection().load({"id": ...})."""
        from smsapi_sdk.entity.user_rcs_sender_collection_entity import UserRcsSenderCollectionEntity
        return UserRcsSenderCollectionEntity(self, data)



    @classmethod
    def test(cls, testopts=None, sdkopts=None) -> "SmsapiSDK":
        if sdkopts is None:
            sdkopts = {}
        sdkopts = vs.clone(sdkopts)
        if not isinstance(sdkopts, dict):
            sdkopts = {}

        if testopts is None:
            testopts = {}
        testopts = vs.clone(testopts)
        if not isinstance(testopts, dict):
            testopts = {}
        testopts["active"] = True

        vs.setpath(sdkopts, "feature.test", testopts)

        sdk = cls(sdkopts)
        sdk.mode = "test"

        return sdk


from typing import TYPE_CHECKING

if TYPE_CHECKING:
    from smsapi_sdk.entity.available_entity import AvailableEntity
    from smsapi_sdk.entity.blacklist_entity import BlacklistEntity
    from smsapi_sdk.entity.callback_entity import CallbackEntity
    from smsapi_sdk.entity.contact_entity import ContactEntity
    from smsapi_sdk.entity.contacts_field_entity import ContactsFieldEntity
    from smsapi_sdk.entity.contacts_field_option_entity import ContactsFieldOptionEntity
    from smsapi_sdk.entity.contactsgroup_entity import ContactsgroupEntity
    from smsapi_sdk.entity.contactstrash_entity import ContactstrashEntity
    from smsapi_sdk.entity.field_available_entity import FieldAvailableEntity
    from smsapi_sdk.entity.group_entity import GroupEntity
    from smsapi_sdk.entity.mfa_code_entity import MfaCodeEntity
    from smsapi_sdk.entity.opt_out_entity import OptOutEntity
    from smsapi_sdk.entity.opt_out_setting_entity import OptOutSettingEntity
    from smsapi_sdk.entity.permission_entity import PermissionEntity
    from smsapi_sdk.entity.ping_entity import PingEntity
    from smsapi_sdk.entity.profile_entity import ProfileEntity
    from smsapi_sdk.entity.rcs_entity import RcsEntity
    from smsapi_sdk.entity.sendername_entity import SendernameEntity
    from smsapi_sdk.entity.sendername_statement_entity import SendernameStatementEntity
    from smsapi_sdk.entity.sent_rcs_message_entity import SentRcsMessageEntity
    from smsapi_sdk.entity.shipment_country_volume_entity import ShipmentCountryVolumeEntity
    from smsapi_sdk.entity.short_url_entity import ShortUrlEntity
    from smsapi_sdk.entity.smsdo_entity import SmsdoEntity
    from smsapi_sdk.entity.smssendername_entity import SmssendernameEntity
    from smsapi_sdk.entity.smstemplate_entity import SmstemplateEntity
    from smsapi_sdk.entity.subuser_entity import SubuserEntity
    from smsapi_sdk.entity.template_entity import TemplateEntity
    from smsapi_sdk.entity.user_rcs_sender_collection_entity import UserRcsSenderCollectionEntity
