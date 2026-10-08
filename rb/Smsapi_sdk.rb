# Smsapi SDK

require_relative 'utility/struct/voxgig_struct'
require_relative 'core/utility_type'
require_relative 'core/spec'
require_relative 'core/helpers'

# Load utility registration
require_relative 'utility/register'

# Load config and features
require_relative 'config'
require_relative 'feature/base_feature'
require_relative 'features'

# Load typed models (Struct value objects).
require_relative 'Smsapi_types'


class SmsapiSDK
  attr_accessor :mode, :features, :options

  def initialize(options = {})
    @mode = "live"
    @features = []
    @options = nil

    utility = SmsapiUtility.new
    @_utility = utility

    config = SmsapiConfig.shared_config

    @_rootctx = utility.make_context.call({
      "client" => self,
      "utility" => utility,
      "config" => config,
      "options" => options || {},
      "shared" => {},
    }, nil)

    @options = utility.make_options.call(@_rootctx)

    if VoxgigStruct.getpath(@options, "feature.test.active") == true
      @mode = "test"
    end

    @_rootctx.options = @options

    # Add features in the resolved order (make_options puts an explicit array
    # order first, else defaults to test-first). Ordering matters: the `test`
    # feature installs the base mock transport and the transport features
    # (retry/cache/netsim/proxy/ratelimit) wrap whatever is current, so `test`
    # must be added before them to sit at the base of the chain.
    feature_opts = SmsapiHelpers.to_map(VoxgigStruct.getprop(@options, "feature"))
    if feature_opts
      featureorder = VoxgigStruct.getpath(@options, "__derived__.featureorder")
      if featureorder.is_a?(Array)
        featureorder.each do |fname|
          fopts = SmsapiHelpers.to_map(feature_opts[fname])
          if fopts && fopts["active"] == true
            utility.feature_add.call(@_rootctx, SmsapiFeatures.make_feature(fname))
          end
        end
      end
    end

    # Add extension features.
    extend_val = VoxgigStruct.getprop(@options, "extend")
    if extend_val.is_a?(Array)
      extend_val.each do |f|
        if f.respond_to?(:get_name)
          utility.feature_add.call(@_rootctx, f)
        end
      end
    end

    # Initialize features.
    @features.each do |f|
      utility.feature_init.call(@_rootctx, f)
    end

    utility.feature_hook.call(@_rootctx, "PostConstruct")
  end

  def options_map
    out = VoxgigStruct.clone(@options)
    out.is_a?(Hash) ? out : {}
  end

  def get_utility
    SmsapiUtility.copy(@_utility)
  end

  def get_root_ctx
    @_rootctx
  end

  # The options and the root context both hold the credential, so the
  # client's printed form is its name alone; `options_map` is the
  # documented way to read them back.
  def to_s
    "Smsapi " + VoxgigStruct.jsonify({ "name" => "Smsapi" })
  end

  def inspect
    to_s
  end

  def prepare(fetchargs = {})
    utility = @_utility
    fetchargs ||= {}

    ctrl = SmsapiHelpers.to_map(VoxgigStruct.getprop(fetchargs, "ctrl")) || {}

    ctx = utility.make_context.call({
      "opname" => "prepare",
      "ctrl" => ctrl,
    }, @_rootctx)

    opts = @options
    path = VoxgigStruct.getprop(fetchargs, "path") || ""
    path = "" unless path.is_a?(String)
    method_val = VoxgigStruct.getprop(fetchargs, "method") || "GET"
    method_val = "GET" unless method_val.is_a?(String) && "" != method_val
    method_val = method_val.upcase
    allow_method = VoxgigStruct.getpath(opts, "allow.method")
    unless SmsapiUtilities.allowed(allow_method, method_val)
      raise ctx.make_error("spec_method_allow",
        "Method \"#{method_val}\" not allowed by SDK option allow.method value: \"#{allow_method}\"")
    end
    params = SmsapiHelpers.to_map(VoxgigStruct.getprop(fetchargs, "params")) || {}
    query = SmsapiHelpers.to_map(VoxgigStruct.getprop(fetchargs, "query")) || {}
    headers = utility.prepare_headers.call(ctx)

    base = VoxgigStruct.getprop(opts, "base") || ""
    base = "" unless base.is_a?(String)
    prefix = VoxgigStruct.getprop(opts, "prefix") || ""
    prefix = "" unless prefix.is_a?(String)
    suffix = VoxgigStruct.getprop(opts, "suffix") || ""
    suffix = "" unless suffix.is_a?(String)

    ctx.spec = SmsapiSpec.new({
      "base" => base, "prefix" => prefix, "suffix" => suffix,
      "path" => path, "method" => method_val,
      "params" => params, "query" => query, "headers" => headers,
      "body" => VoxgigStruct.getprop(fetchargs, "body"),
      "step" => "start",
    })

    # Merge user-provided headers.
    uh = VoxgigStruct.getprop(fetchargs, "headers")
    if uh.is_a?(Hash)
      uh.each { |k, v| ctx.spec.headers[k] = v }
    end

    _, err = utility.prepare_auth.call(ctx)
    raise err if err

    # make_fetch_def returns a (fetchdef, err) tuple; destructure it and
    # return just the fetchdef Hash (raising on error) so callers — including
    # direct(), which indexes fetchdef["url"] — receive a Hash, mirroring the
    # ts/py prepare().
    fetchdef, fd_err = utility.make_fetch_def.call(ctx)
    raise fd_err if fd_err

    fetchdef
  end

  # Raw endpoint access is operator-controllable, like every entity op.
  # Blocking it means denying BOTH the 'direct' and 'graphql' tokens, since
  # either one reaches the same endpoint.
  def direct(fetchargs = {})
    return op_denied("direct") unless op_allowed?("direct")

    raw_request(fetchargs)
  end

  # Is this raw-access op permitted by the SDK's allow.op option?
  def op_allowed?(op)
    SmsapiUtilities.allowed(VoxgigStruct.getpath(@options, "allow.op"), op)
  end

  def op_denied(op)
    allow_op = VoxgigStruct.getpath(@options, "allow.op")
    {
      "ok" => false,
      "err" => SmsapiError.new(
        "#{op}_allow",
        "SmsapiSDK: #{op}: operation not allowed by" \
        " SDK option allow.op value: \"#{allow_op}\""),
    }
  end

  # Ungated request path shared by direct and graphql, each of which checks
  # its own allow.op token first. Separate, rather than a flag on fetchargs:
  # a caller-supplied marker would let anyone opt straight back out of the
  # gate by passing it.
  def raw_request(fetchargs = {})
    utility = @_utility

    # direct() is the raw-HTTP escape hatch: it always returns a result hash
    # ({ "ok" => ..., ... }) and never raises. prepare() raises on error, so
    # trap that and surface it in the hash.
    begin
      fetchdef = prepare(fetchargs)
    rescue SmsapiError => err
      return { "ok" => false, "err" => err }
    end

    fetchargs ||= {}
    ctrl = SmsapiHelpers.to_map(VoxgigStruct.getprop(fetchargs, "ctrl")) || {}

    ctx = utility.make_context.call({
      "opname" => "direct",
      "ctrl" => ctrl,
    }, @_rootctx)

    url = fetchdef["url"] || ""
    fetched, fetch_err = utility.fetcher.call(ctx, url, fetchdef)

    return { "ok" => false, "err" => utility.clean.call(ctx, fetch_err) } if fetch_err

    if fetched.nil?
      return {
        "ok" => false,
        "err" => ctx.make_error("direct_no_response", "response: undefined"),
      }
    end

    if fetched.is_a?(Hash)
      status = SmsapiHelpers.to_int(VoxgigStruct.getprop(fetched, "status"))
      headers = VoxgigStruct.getprop(fetched, "headers") || {}

      # No-body responses (204, 304) and explicit zero content-length must
      # skip JSON parsing — calling json() on an empty body errors.
      content_length = headers.is_a?(Hash) ? headers["content-length"] : nil
      no_body = status == 204 || status == 304 || content_length.to_s == "0"

      json_data = nil
      body_err = nil
      unless no_body
        jf = VoxgigStruct.getprop(fetched, "json")
        if jf.is_a?(Proc)
          begin
            json_data = jf.call
          rescue StandardError
            # Non-JSON body — leave data nil, keep status/headers.
            json_data = nil
          end
        end
        if true == VoxgigStruct.getprop(fetched, "unreadable")
          failed = status >= 200 && status < 300 ? nil : ctx.make_error("request_status",
            "request: #{status}: #{VoxgigStruct.getprop(fetched, 'statusText')}")
          body_err = SmsapiUtilities::UnreadableBody.call(ctx, status, headers,
            VoxgigStruct.getprop(fetched, "body"), fetchdef["headers"], failed)
        end
      end

      out = {
        "ok" => body_err.nil? && status >= 200 && status < 300,
        "status" => status,
        "headers" => headers,
        "data" => json_data,
      }
      out["err"] = utility.clean.call(ctx, body_err) unless body_err.nil?
      return out
    end

    return {
      "ok" => false,
      "err" => ctx.make_error("direct_invalid", "invalid response type"),
    }
  end

  # Raw GraphQL access: the pressure valve that makes the generated surface's
  # deliberate omissions (per-call selection sets, typed filter builders,
  # batching, subscriptions) livable — the whole schema stays reachable.
  #
  # Thin wrapper over the same prepare/fetch path direct uses, with the one
  # thing raw direct cannot do for GraphQL: a GraphQL failure rides HTTP 200
  # as a top-level `errors` array, so status alone would report a failed
  # query as ok.
  #
  # NOTE: like direct, this bypasses the feature pipeline — no retry,
  # ratelimit or paging features apply.
  def graphql(query, variables = nil, ctrl = nil)
    return op_denied("graphql") unless op_allowed?("graphql")

    res = raw_request({
      "method" => "POST",
      "headers" => { "content-type" => "application/json" },
      "body" => { "query" => query, "variables" => variables || {} },
      "ctrl" => ctrl || {},
    })

    # Errors are read BEFORE any status check: a GraphQL parse or validation
    # failure comes back as HTTP 400 carrying the standard { errors: [...] }
    # body, and the raw path represents a non-2xx as ok:false with no err —
    # so returning early on status would discard the server's own
    # diagnostics, which are the only useful part of that response.
    errors = VoxgigStruct.getpath(res, "data.errors")

    if errors.is_a?(Array) && !errors.empty?
      first = errors[0].is_a?(Hash) ? errors[0] : {}
      msg = first["message"]
      msg = "graphql error" if msg.nil? || msg.to_s.empty?
      res["ok"] = false
      res["err"] = SmsapiError.new(
        "graphql_error", "SmsapiSDK: graphql: #{msg}")
      res["graphql"] = errors
    end

    res
  end


  # Canonical facade: client.Available.list / client.Available.load({ "id" => ... })
  def Available(data = nil)
    require_relative 'entity/available_entity'
    AvailableEntity.new(self, data)
  end


  # Canonical facade: client.Blacklist.list / client.Blacklist.load({ "id" => ... })
  def Blacklist(data = nil)
    require_relative 'entity/blacklist_entity'
    BlacklistEntity.new(self, data)
  end


  # Canonical facade: client.Callback.list / client.Callback.load({ "id" => ... })
  def Callback(data = nil)
    require_relative 'entity/callback_entity'
    CallbackEntity.new(self, data)
  end


  # Canonical facade: client.Contact.list / client.Contact.load({ "id" => ... })
  def Contact(data = nil)
    require_relative 'entity/contact_entity'
    ContactEntity.new(self, data)
  end


  # Canonical facade: client.ContactsField.list / client.ContactsField.load({ "id" => ... })
  def ContactsField(data = nil)
    require_relative 'entity/contacts_field_entity'
    ContactsFieldEntity.new(self, data)
  end


  # Canonical facade: client.ContactsFieldOption.list / client.ContactsFieldOption.load({ "id" => ... })
  def ContactsFieldOption(data = nil)
    require_relative 'entity/contacts_field_option_entity'
    ContactsFieldOptionEntity.new(self, data)
  end


  # Canonical facade: client.Contactsgroup.list / client.Contactsgroup.load({ "id" => ... })
  def Contactsgroup(data = nil)
    require_relative 'entity/contactsgroup_entity'
    ContactsgroupEntity.new(self, data)
  end


  # Canonical facade: client.Contactstrash.list / client.Contactstrash.load({ "id" => ... })
  def Contactstrash(data = nil)
    require_relative 'entity/contactstrash_entity'
    ContactstrashEntity.new(self, data)
  end


  # Canonical facade: client.FieldAvailable.list / client.FieldAvailable.load({ "id" => ... })
  def FieldAvailable(data = nil)
    require_relative 'entity/field_available_entity'
    FieldAvailableEntity.new(self, data)
  end


  # Canonical facade: client.Group.list / client.Group.load({ "id" => ... })
  def Group(data = nil)
    require_relative 'entity/group_entity'
    GroupEntity.new(self, data)
  end


  # Canonical facade: client.MfaCode.list / client.MfaCode.load({ "id" => ... })
  def MfaCode(data = nil)
    require_relative 'entity/mfa_code_entity'
    MfaCodeEntity.new(self, data)
  end


  # Canonical facade: client.OptOut.list / client.OptOut.load({ "id" => ... })
  def OptOut(data = nil)
    require_relative 'entity/opt_out_entity'
    OptOutEntity.new(self, data)
  end


  # Canonical facade: client.OptOutSetting.list / client.OptOutSetting.load({ "id" => ... })
  def OptOutSetting(data = nil)
    require_relative 'entity/opt_out_setting_entity'
    OptOutSettingEntity.new(self, data)
  end


  # Canonical facade: client.Permission.list / client.Permission.load({ "id" => ... })
  def Permission(data = nil)
    require_relative 'entity/permission_entity'
    PermissionEntity.new(self, data)
  end


  # Canonical facade: client.Ping.list / client.Ping.load({ "id" => ... })
  def Ping(data = nil)
    require_relative 'entity/ping_entity'
    PingEntity.new(self, data)
  end


  # Canonical facade: client.Profile.list / client.Profile.load({ "id" => ... })
  def Profile(data = nil)
    require_relative 'entity/profile_entity'
    ProfileEntity.new(self, data)
  end


  # Canonical facade: client.Rcs.list / client.Rcs.load({ "id" => ... })
  def Rcs(data = nil)
    require_relative 'entity/rcs_entity'
    RcsEntity.new(self, data)
  end


  # Canonical facade: client.Sendername.list / client.Sendername.load({ "id" => ... })
  def Sendername(data = nil)
    require_relative 'entity/sendername_entity'
    SendernameEntity.new(self, data)
  end


  # Canonical facade: client.SendernameStatement.list / client.SendernameStatement.load({ "id" => ... })
  def SendernameStatement(data = nil)
    require_relative 'entity/sendername_statement_entity'
    SendernameStatementEntity.new(self, data)
  end


  # Canonical facade: client.SentRcsMessage.list / client.SentRcsMessage.load({ "id" => ... })
  def SentRcsMessage(data = nil)
    require_relative 'entity/sent_rcs_message_entity'
    SentRcsMessageEntity.new(self, data)
  end


  # Canonical facade: client.ShipmentCountryVolume.list / client.ShipmentCountryVolume.load({ "id" => ... })
  def ShipmentCountryVolume(data = nil)
    require_relative 'entity/shipment_country_volume_entity'
    ShipmentCountryVolumeEntity.new(self, data)
  end


  # Canonical facade: client.ShortUrl.list / client.ShortUrl.load({ "id" => ... })
  def ShortUrl(data = nil)
    require_relative 'entity/short_url_entity'
    ShortUrlEntity.new(self, data)
  end


  # Canonical facade: client.Smsdo.list / client.Smsdo.load({ "id" => ... })
  def Smsdo(data = nil)
    require_relative 'entity/smsdo_entity'
    SmsdoEntity.new(self, data)
  end


  # Canonical facade: client.Smssendername.list / client.Smssendername.load({ "id" => ... })
  def Smssendername(data = nil)
    require_relative 'entity/smssendername_entity'
    SmssendernameEntity.new(self, data)
  end


  # Canonical facade: client.Smstemplate.list / client.Smstemplate.load({ "id" => ... })
  def Smstemplate(data = nil)
    require_relative 'entity/smstemplate_entity'
    SmstemplateEntity.new(self, data)
  end


  # Canonical facade: client.Subuser.list / client.Subuser.load({ "id" => ... })
  def Subuser(data = nil)
    require_relative 'entity/subuser_entity'
    SubuserEntity.new(self, data)
  end


  # Canonical facade: client.Template.list / client.Template.load({ "id" => ... })
  def Template(data = nil)
    require_relative 'entity/template_entity'
    TemplateEntity.new(self, data)
  end


  # Canonical facade: client.UserRcsSenderCollection.list / client.UserRcsSenderCollection.load({ "id" => ... })
  def UserRcsSenderCollection(data = nil)
    require_relative 'entity/user_rcs_sender_collection_entity'
    UserRcsSenderCollectionEntity.new(self, data)
  end



  def self.test(testopts = nil, sdkopts = nil)
    sdkopts = sdkopts || {}
    sdkopts = VoxgigStruct.clone(sdkopts)
    sdkopts = {} unless sdkopts.is_a?(Hash)

    testopts = testopts || {}
    testopts = VoxgigStruct.clone(testopts)
    testopts = {} unless testopts.is_a?(Hash)
    testopts["active"] = true

    VoxgigStruct.setpath(sdkopts, "feature.test", testopts)

    sdk = SmsapiSDK.new(sdkopts)
    sdk.mode = "test"
    sdk
  end
end
