-- Smsapi SDK

local json = require("dkjson")
local vs = require("utility.struct.struct")
local Utility = require("core.utility_type")
local Spec = require("core.spec")
local helpers = require("core.helpers")

-- Load utility registration (populates Utility._registrar)
require("utility.register")

-- Typed-model annotations (LuaLS ---@class); empty at runtime.
require("smsapi_types")

-- Load features
local BaseFeature = require("feature.base_feature")
local features_factory = require("features")


local SmsapiSDK = {}

-- The options and the root context both hold the credential. They live in
-- a side table rather than in the client, so a dump or an encoder walking
-- the client's fields never reaches them; `sdk.options` still reads and
-- writes through the metamethods, and options_map() is the documented way
-- to read the credential back.
local HIDDEN = { options = true, _rootctx = true }
local SLOTS = setmetatable({}, { __mode = "k" })

SmsapiSDK.__index = function(self, key)
  local member = rawget(SmsapiSDK, key)
  if member ~= nil then
    return member
  end
  if HIDDEN[key] then
    local slots = SLOTS[self]
    return slots ~= nil and slots[key] or nil
  end
  return nil
end

SmsapiSDK.__newindex = function(self, key, val)
  if HIDDEN[key] then
    local slots = SLOTS[self]
    if slots == nil then
      slots = {}
      SLOTS[self] = slots
    end
    slots[key] = val
  else
    rawset(self, key, val)
  end
end

-- The client's own record: what a serialiser or clean's snapshot sees in
-- place of the client, so neither reaches the options through it.
function SmsapiSDK:to_record()
  return { sdk = "Smsapi", mode = self.mode }
end

SmsapiSDK.__tostring = function(self)
  return "SmsapiSDK mode=" .. tostring(self.mode)
end

SmsapiSDK.__tojson = function(self)
  return json.encode(self:to_record())
end


local function _make_feature(name)
  local factory = features_factory[name]
  if factory ~= nil then
    return factory()
  end
  return features_factory.base()
end

SmsapiSDK._make_feature = _make_feature


function SmsapiSDK.new(options)
  local self = setmetatable({}, SmsapiSDK)
  self.mode = "live"
  self.features = {}
  self.options = nil

  local utility = Utility.new()
  self._utility = utility

  local config = require("config_shared")()

  self._rootctx = utility.make_context({
    client = self,
    utility = utility,
    config = config,
    options = options or {},
    shared = {},
  }, nil)

  self.options = utility.make_options(self._rootctx)

  if vs.getpath(self.options, "feature.test.active") == true then
    self.mode = "test"
  end

  self._rootctx.options = self.options

  -- Add features in the resolved order (make_options puts an explicit list
  -- order first, else defaults to test-first). Ordering matters: the `test`
  -- feature installs the base mock transport and the transport features
  -- (retry/cache/netsim/proxy/ratelimit) wrap whatever is current, so `test`
  -- must be added before them to sit at the base of the chain.
  local feature_opts = helpers.to_map(vs.getprop(self.options, "feature"))
  if feature_opts ~= nil then
    local featureorder = vs.getpath(self.options, "__derived__.featureorder")
    if type(featureorder) == "table" then
      for _, fname in ipairs(featureorder) do
        local fopts = helpers.to_map(feature_opts[fname])
        if fopts ~= nil and fopts["active"] == true then
          utility.feature_add(self._rootctx, _make_feature(fname))
        end
      end
    end
  end

  -- Add extension features.
  local extend = vs.getprop(self.options, "extend")
  if type(extend) == "table" then
    for _, f in ipairs(extend) do
      if type(f) == "table" and type(f.get_name) == "function" then
        utility.feature_add(self._rootctx, f)
      end
    end
  end

  -- CONSUMED, not kept. `extend` holds feature INSTANCES, and every shipped
  -- feature's init stores `self.client = ctx.client` - so leaving the list
  -- in self.options makes the options map CYCLIC (client.options.extend[1]
  -- .client == client), and options_map()'s vs.clone, which has no cycle
  -- guard, blew the stack on the first prepare_auth of any client built with
  -- an extend feature. The instances live on self.features from here on,
  -- which is the only place anything reads them; the SAME table is
  -- self._rootctx.options, so the root context loses the key too.
  self.options["extend"] = nil

  -- Initialize features.
  for _, f in ipairs(self.features) do
    utility.feature_init(self._rootctx, f)
  end

  utility.feature_hook(self._rootctx, "PostConstruct")

    -- feature: audit
  -- feature: cache
  -- feature: clienttrack
  -- feature: cost
  -- feature: debug
  -- feature: idempotency
  -- feature: log
  -- feature: metrics
  -- feature: netsim
  -- feature: paging
  -- feature: proxy
  -- feature: ratelimit
  -- feature: rbac
  -- feature: retry
  -- feature: secrets
  -- feature: streaming
  -- feature: telemetry
  -- feature: test
  -- feature: timeout
  -- feature: validate


  return self
end


function SmsapiSDK:options_map()
  local out = vs.clone(self.options)
  if type(out) == "table" then
    return out
  end
  return {}
end


function SmsapiSDK:get_utility()
  return Utility.copy(self._utility)
end


function SmsapiSDK:get_root_ctx()
  return self._rootctx
end


function SmsapiSDK:prepare(fetchargs)
  local utility = self._utility

  fetchargs = fetchargs or {}

  local ctrl = helpers.to_map(vs.getprop(fetchargs, "ctrl")) or {}

  local ctx = utility.make_context({
    opname = "prepare",
    ctrl = ctrl,
  }, self._rootctx)

  local options = self.options

  local path = vs.getprop(fetchargs, "path") or ""
  if type(path) ~= "string" then path = "" end

  local method = vs.getprop(fetchargs, "method") or "GET"
  if type(method) ~= "string" then method = "GET" end

  local params = helpers.to_map(vs.getprop(fetchargs, "params")) or {}
  local query = helpers.to_map(vs.getprop(fetchargs, "query")) or {}

  local headers = utility.prepare_headers(ctx)

  local base = vs.getprop(options, "base") or ""
  if type(base) ~= "string" then base = "" end
  local prefix = vs.getprop(options, "prefix") or ""
  if type(prefix) ~= "string" then prefix = "" end
  local suffix = vs.getprop(options, "suffix") or ""
  if type(suffix) ~= "string" then suffix = "" end

  ctx.spec = Spec.new({
    base = base,
    prefix = prefix,
    suffix = suffix,
    path = path,
    method = method,
    params = params,
    query = query,
    headers = headers,
    body = vs.getprop(fetchargs, "body"),
    step = "start",
  })

  -- Merge user-provided headers.
  local uh = vs.getprop(fetchargs, "headers")
  if type(uh) == "table" then
    for k, v in pairs(uh) do
      ctx.spec.headers[k] = v
    end
  end

  local _, err = utility.prepare_auth(ctx)
  if err ~= nil then
    return nil, err
  end

  return utility.make_fetch_def(ctx)
end


-- Raw endpoint access is operator-controllable, like every entity op.
-- Blocking it means denying BOTH the 'direct' and 'graphql' tokens, since
-- either one reaches the same endpoint.
function SmsapiSDK:direct(fetchargs)
  if not self:_op_allowed("direct") then
    return self:_op_denied("direct"), nil
  end

  return self:_raw_request(fetchargs)
end


-- Is this raw-access op permitted by the SDK's allow.op option?
function SmsapiSDK:_op_allowed(op)
  local allow = vs.getpath(self.options, "allow.op")
  return type(allow) == "string" and allow:find(op, 1, true) ~= nil
end


function SmsapiSDK:_op_denied(op)
  local allow = vs.getpath(self.options, "allow.op")
  if type(allow) ~= "string" then allow = "" end
  return {
    ok = false,
    err = "SmsapiSDK: " .. op .. ": operation not allowed by" ..
      " SDK option allow.op value: \"" .. allow .. "\"",
  }
end


-- Ungated request path shared by direct and graphql, each of which checks its
-- own allow.op token first. Private, rather than a flag on fetchargs: a
-- caller-supplied marker would let anyone opt straight back out of the gate
-- by passing it.
function SmsapiSDK:_raw_request(fetchargs)
  local utility = self._utility

  local fetchdef, err = self:prepare(fetchargs)
  if err ~= nil then
    return { ok = false, err = err }, nil
  end

  fetchargs = fetchargs or {}
  local ctrl = helpers.to_map(vs.getprop(fetchargs, "ctrl")) or {}

  local ctx = utility.make_context({
    opname = "direct",
    ctrl = ctrl,
  }, self._rootctx)

  local url = fetchdef["url"] or ""
  local fetched, fetch_err = utility.fetcher(ctx, url, fetchdef)

  if fetch_err ~= nil then
    return { ok = false, err = utility.clean(ctx, fetch_err) }, nil
  end

  if fetched == nil then
    return {
      ok = false,
      err = ctx:make_error("direct_no_response", "response: undefined"),
    }, nil
  end

  if type(fetched) == "table" then
    local status = helpers.to_int(vs.getprop(fetched, "status"))
    local headers = vs.getprop(fetched, "headers") or {}

    -- No-body responses (204, 304) and explicit zero content-length
    -- must skip JSON parsing — calling json() on an empty body errors.
    local content_length = nil
    if type(headers) == "table" then
      content_length = headers["content-length"]
    end
    local no_body = status == 204 or status == 304 or tostring(content_length) == "0"

    local json_data = nil
    if not no_body then
      local jf = vs.getprop(fetched, "json")
      if type(jf) == "function" then
        local ok, result = pcall(jf)
        if ok then
          json_data = result
        end
        -- Non-JSON body: json_data stays nil, status/headers preserved.
      end
    end

    return {
      ok = status >= 200 and status < 300,
      status = status,
      headers = headers,
      data = json_data,
    }, nil
  end

  return {
    ok = false,
    err = ctx:make_error("direct_invalid", "invalid response type"),
  }, nil
end


-- Raw GraphQL access: the pressure valve that makes the generated surface's
-- deliberate omissions (per-call selection sets, typed filter builders,
-- batching, subscriptions) livable — the whole schema stays reachable.
--
-- Thin wrapper over the same prepare/fetch path direct uses, with the one
-- thing raw direct cannot do for GraphQL: a GraphQL failure rides HTTP 200 as
-- a top-level `errors` array, so status alone would report a failed query as
-- ok.
--
-- NOTE: like direct, this bypasses the feature pipeline — no retry, ratelimit
-- or paging features apply.
function SmsapiSDK:graphql(query, variables, ctrl)
  if not self:_op_allowed("graphql") then
    return self:_op_denied("graphql"), nil
  end

  local res, err = self:_raw_request({
    method = "POST",
    headers = { ["content-type"] = "application/json" },
    body = {
      query = query,
      variables = type(variables) == "table" and variables or {},
    },
    ctrl = type(ctrl) == "table" and ctrl or {},
  })

  if err ~= nil or type(res) ~= "table" then
    return res, err
  end

  -- Errors are read BEFORE any status check: a GraphQL parse or validation
  -- failure comes back as HTTP 400 carrying the standard { errors = {...} }
  -- body, and the raw path represents a non-2xx as ok=false with no err — so
  -- returning early on status would discard the server's own diagnostics,
  -- which are the only useful part of that response.
  local errors = vs.getpath(res, "data.errors")

  if type(errors) == "table" and 0 < #errors then
    local msg = vs.getprop(errors[1], "message")
    if type(msg) ~= "string" or msg == "" then
      msg = "graphql error"
    end
    res.ok = false
    res.err = "SmsapiSDK: graphql: " .. msg
    res.graphql = errors
  end

  return res, nil
end



-- Idiomatic facade: client:Available():list() / client:Available():load({ id = ... })
-- Entity access is capitalised (PascalCase) for parity with the other SDKs.
function SmsapiSDK:Available(data)
  local EntityMod = require("entity.available_entity")
  if data == nil then
    if self._available == nil then
      self._available = EntityMod.new(self, nil)
    end
    return self._available
  end
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:Blacklist():list() / client:Blacklist():load({ id = ... })
-- Entity access is capitalised (PascalCase) for parity with the other SDKs.
function SmsapiSDK:Blacklist(data)
  local EntityMod = require("entity.blacklist_entity")
  if data == nil then
    if self._blacklist == nil then
      self._blacklist = EntityMod.new(self, nil)
    end
    return self._blacklist
  end
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:Callback():list() / client:Callback():load({ id = ... })
-- Entity access is capitalised (PascalCase) for parity with the other SDKs.
function SmsapiSDK:Callback(data)
  local EntityMod = require("entity.callback_entity")
  if data == nil then
    if self._callback == nil then
      self._callback = EntityMod.new(self, nil)
    end
    return self._callback
  end
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:Contact():list() / client:Contact():load({ id = ... })
-- Entity access is capitalised (PascalCase) for parity with the other SDKs.
function SmsapiSDK:Contact(data)
  local EntityMod = require("entity.contact_entity")
  if data == nil then
    if self._contact == nil then
      self._contact = EntityMod.new(self, nil)
    end
    return self._contact
  end
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:ContactsField():list() / client:ContactsField():load({ id = ... })
-- Entity access is capitalised (PascalCase) for parity with the other SDKs.
function SmsapiSDK:ContactsField(data)
  local EntityMod = require("entity.contacts_field_entity")
  if data == nil then
    if self._contacts_field == nil then
      self._contacts_field = EntityMod.new(self, nil)
    end
    return self._contacts_field
  end
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:ContactsFieldOption():list() / client:ContactsFieldOption():load({ id = ... })
-- Entity access is capitalised (PascalCase) for parity with the other SDKs.
function SmsapiSDK:ContactsFieldOption(data)
  local EntityMod = require("entity.contacts_field_option_entity")
  if data == nil then
    if self._contacts_field_option == nil then
      self._contacts_field_option = EntityMod.new(self, nil)
    end
    return self._contacts_field_option
  end
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:Contactsgroup():list() / client:Contactsgroup():load({ id = ... })
-- Entity access is capitalised (PascalCase) for parity with the other SDKs.
function SmsapiSDK:Contactsgroup(data)
  local EntityMod = require("entity.contactsgroup_entity")
  if data == nil then
    if self._contactsgroup == nil then
      self._contactsgroup = EntityMod.new(self, nil)
    end
    return self._contactsgroup
  end
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:Contactstrash():list() / client:Contactstrash():load({ id = ... })
-- Entity access is capitalised (PascalCase) for parity with the other SDKs.
function SmsapiSDK:Contactstrash(data)
  local EntityMod = require("entity.contactstrash_entity")
  if data == nil then
    if self._contactstrash == nil then
      self._contactstrash = EntityMod.new(self, nil)
    end
    return self._contactstrash
  end
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:FieldAvailable():list() / client:FieldAvailable():load({ id = ... })
-- Entity access is capitalised (PascalCase) for parity with the other SDKs.
function SmsapiSDK:FieldAvailable(data)
  local EntityMod = require("entity.field_available_entity")
  if data == nil then
    if self._field_available == nil then
      self._field_available = EntityMod.new(self, nil)
    end
    return self._field_available
  end
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:Group():list() / client:Group():load({ id = ... })
-- Entity access is capitalised (PascalCase) for parity with the other SDKs.
function SmsapiSDK:Group(data)
  local EntityMod = require("entity.group_entity")
  if data == nil then
    if self._group == nil then
      self._group = EntityMod.new(self, nil)
    end
    return self._group
  end
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:MfaCode():list() / client:MfaCode():load({ id = ... })
-- Entity access is capitalised (PascalCase) for parity with the other SDKs.
function SmsapiSDK:MfaCode(data)
  local EntityMod = require("entity.mfa_code_entity")
  if data == nil then
    if self._mfa_code == nil then
      self._mfa_code = EntityMod.new(self, nil)
    end
    return self._mfa_code
  end
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:OptOut():list() / client:OptOut():load({ id = ... })
-- Entity access is capitalised (PascalCase) for parity with the other SDKs.
function SmsapiSDK:OptOut(data)
  local EntityMod = require("entity.opt_out_entity")
  if data == nil then
    if self._opt_out == nil then
      self._opt_out = EntityMod.new(self, nil)
    end
    return self._opt_out
  end
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:OptOutSetting():list() / client:OptOutSetting():load({ id = ... })
-- Entity access is capitalised (PascalCase) for parity with the other SDKs.
function SmsapiSDK:OptOutSetting(data)
  local EntityMod = require("entity.opt_out_setting_entity")
  if data == nil then
    if self._opt_out_setting == nil then
      self._opt_out_setting = EntityMod.new(self, nil)
    end
    return self._opt_out_setting
  end
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:Permission():list() / client:Permission():load({ id = ... })
-- Entity access is capitalised (PascalCase) for parity with the other SDKs.
function SmsapiSDK:Permission(data)
  local EntityMod = require("entity.permission_entity")
  if data == nil then
    if self._permission == nil then
      self._permission = EntityMod.new(self, nil)
    end
    return self._permission
  end
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:Ping():list() / client:Ping():load({ id = ... })
-- Entity access is capitalised (PascalCase) for parity with the other SDKs.
function SmsapiSDK:Ping(data)
  local EntityMod = require("entity.ping_entity")
  if data == nil then
    if self._ping == nil then
      self._ping = EntityMod.new(self, nil)
    end
    return self._ping
  end
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:Profile():list() / client:Profile():load({ id = ... })
-- Entity access is capitalised (PascalCase) for parity with the other SDKs.
function SmsapiSDK:Profile(data)
  local EntityMod = require("entity.profile_entity")
  if data == nil then
    if self._profile == nil then
      self._profile = EntityMod.new(self, nil)
    end
    return self._profile
  end
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:Rcs():list() / client:Rcs():load({ id = ... })
-- Entity access is capitalised (PascalCase) for parity with the other SDKs.
function SmsapiSDK:Rcs(data)
  local EntityMod = require("entity.rcs_entity")
  if data == nil then
    if self._rcs == nil then
      self._rcs = EntityMod.new(self, nil)
    end
    return self._rcs
  end
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:Sendername():list() / client:Sendername():load({ id = ... })
-- Entity access is capitalised (PascalCase) for parity with the other SDKs.
function SmsapiSDK:Sendername(data)
  local EntityMod = require("entity.sendername_entity")
  if data == nil then
    if self._sendername == nil then
      self._sendername = EntityMod.new(self, nil)
    end
    return self._sendername
  end
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:SendernameStatement():list() / client:SendernameStatement():load({ id = ... })
-- Entity access is capitalised (PascalCase) for parity with the other SDKs.
function SmsapiSDK:SendernameStatement(data)
  local EntityMod = require("entity.sendername_statement_entity")
  if data == nil then
    if self._sendername_statement == nil then
      self._sendername_statement = EntityMod.new(self, nil)
    end
    return self._sendername_statement
  end
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:SentRcsMessage():list() / client:SentRcsMessage():load({ id = ... })
-- Entity access is capitalised (PascalCase) for parity with the other SDKs.
function SmsapiSDK:SentRcsMessage(data)
  local EntityMod = require("entity.sent_rcs_message_entity")
  if data == nil then
    if self._sent_rcs_message == nil then
      self._sent_rcs_message = EntityMod.new(self, nil)
    end
    return self._sent_rcs_message
  end
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:ShipmentCountryVolume():list() / client:ShipmentCountryVolume():load({ id = ... })
-- Entity access is capitalised (PascalCase) for parity with the other SDKs.
function SmsapiSDK:ShipmentCountryVolume(data)
  local EntityMod = require("entity.shipment_country_volume_entity")
  if data == nil then
    if self._shipment_country_volume == nil then
      self._shipment_country_volume = EntityMod.new(self, nil)
    end
    return self._shipment_country_volume
  end
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:ShortUrl():list() / client:ShortUrl():load({ id = ... })
-- Entity access is capitalised (PascalCase) for parity with the other SDKs.
function SmsapiSDK:ShortUrl(data)
  local EntityMod = require("entity.short_url_entity")
  if data == nil then
    if self._short_url == nil then
      self._short_url = EntityMod.new(self, nil)
    end
    return self._short_url
  end
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:Smsdo():list() / client:Smsdo():load({ id = ... })
-- Entity access is capitalised (PascalCase) for parity with the other SDKs.
function SmsapiSDK:Smsdo(data)
  local EntityMod = require("entity.smsdo_entity")
  if data == nil then
    if self._smsdo == nil then
      self._smsdo = EntityMod.new(self, nil)
    end
    return self._smsdo
  end
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:Smssendername():list() / client:Smssendername():load({ id = ... })
-- Entity access is capitalised (PascalCase) for parity with the other SDKs.
function SmsapiSDK:Smssendername(data)
  local EntityMod = require("entity.smssendername_entity")
  if data == nil then
    if self._smssendername == nil then
      self._smssendername = EntityMod.new(self, nil)
    end
    return self._smssendername
  end
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:Smstemplate():list() / client:Smstemplate():load({ id = ... })
-- Entity access is capitalised (PascalCase) for parity with the other SDKs.
function SmsapiSDK:Smstemplate(data)
  local EntityMod = require("entity.smstemplate_entity")
  if data == nil then
    if self._smstemplate == nil then
      self._smstemplate = EntityMod.new(self, nil)
    end
    return self._smstemplate
  end
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:Subuser():list() / client:Subuser():load({ id = ... })
-- Entity access is capitalised (PascalCase) for parity with the other SDKs.
function SmsapiSDK:Subuser(data)
  local EntityMod = require("entity.subuser_entity")
  if data == nil then
    if self._subuser == nil then
      self._subuser = EntityMod.new(self, nil)
    end
    return self._subuser
  end
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:Template():list() / client:Template():load({ id = ... })
-- Entity access is capitalised (PascalCase) for parity with the other SDKs.
function SmsapiSDK:Template(data)
  local EntityMod = require("entity.template_entity")
  if data == nil then
    if self._template == nil then
      self._template = EntityMod.new(self, nil)
    end
    return self._template
  end
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:UserRcsSenderCollection():list() / client:UserRcsSenderCollection():load({ id = ... })
-- Entity access is capitalised (PascalCase) for parity with the other SDKs.
function SmsapiSDK:UserRcsSenderCollection(data)
  local EntityMod = require("entity.user_rcs_sender_collection_entity")
  if data == nil then
    if self._user_rcs_sender_collection == nil then
      self._user_rcs_sender_collection = EntityMod.new(self, nil)
    end
    return self._user_rcs_sender_collection
  end
  return EntityMod.new(self, data)
end




function SmsapiSDK.test(testopts, sdkopts)
  sdkopts = sdkopts or {}
  sdkopts = vs.clone(sdkopts)
  if type(sdkopts) ~= "table" then
    sdkopts = {}
  end

  testopts = testopts or {}
  testopts = vs.clone(testopts)
  if type(testopts) ~= "table" then
    testopts = {}
  end
  testopts["active"] = true

  vs.setpath(sdkopts, "feature.test", testopts)

  local sdk = SmsapiSDK.new(sdkopts)
  sdk.mode = "test"

  return sdk
end


return SmsapiSDK
