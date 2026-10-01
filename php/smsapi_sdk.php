<?php
declare(strict_types=1);

// Smsapi SDK

require_once __DIR__ . '/utility/struct/Struct.php';
require_once __DIR__ . '/core/UtilityType.php';
require_once __DIR__ . '/core/Spec.php';
require_once __DIR__ . '/core/Helpers.php';

// Load utility registration
require_once __DIR__ . '/utility/Register.php';

// Load config and features
require_once __DIR__ . '/config.php';
require_once __DIR__ . '/feature/BaseFeature.php';
require_once __DIR__ . '/features.php';

use Voxgig\Struct\Struct;

// Features record diagnostic state on the client as dynamic properties
// (_retry, _cache, _metrics, ...); allow them explicitly (PHP 8.2+
// deprecates implicit dynamic properties).
#[\AllowDynamicProperties]
class SmsapiSDK implements \JsonSerializable
{
    public string $mode;
    public array $features;
    public ?array $options;

    private $_utility;
    private $_rootctx;

    public function __construct(array $options = [])
    {
        $this->mode = "live";
        $this->features = [];
        $this->options = null;

        $utility = new SmsapiUtility();
        $this->_utility = $utility;

        $config = SmsapiConfig::shared_config();

        $this->_rootctx = ($utility->make_context)([
            "client" => $this,
            "utility" => $utility,
            "config" => $config,
            "options" => $options ?? [],
            "shared" => [],
        ], null);

        $this->options = ($utility->make_options)($this->_rootctx);

        if (Struct::getpath($this->options, "feature.test.active") === true) {
            $this->mode = "test";
        }

        $this->_rootctx->options = $this->options;

        // Feature INSTANCES supplied at construction (the station adopt
        // path) are read from the RAW construction options - extend is
        // consumed exactly once, here; make_options strips it from the
        // processed map so options_map() stays clean data.
        $extend_val = is_array($options["extend"] ?? null) ? $options["extend"] : [];

        // Add features in the resolved order (make_options puts an explicit
        // list order first, else defaults to test-first). Ordering matters: the
        // `test` feature installs the base mock transport and the transport
        // features (retry/cache/netsim/proxy/ratelimit) wrap whatever is
        // current, so `test` must be added before them to sit at the base.
        $feature_opts = SmsapiHelpers::to_map(Struct::getprop($this->options, "feature"));
        if ($feature_opts) {
            $featureorder = Struct::getpath($this->options, "__derived__.featureorder");
            if (is_array($featureorder)) {
                foreach ($featureorder as $fname) {
                    $fopts = SmsapiHelpers::to_map($feature_opts[$fname] ?? null);
                    if ($fopts && isset($fopts["active"]) && $fopts["active"] === true) {
                        // An active name with no generated feature class is
                        // legal when an extend-supplied instance carries that
                        // name (station's adopt path): the instance is added
                        // below, positioned by its own __after__ entry, so
                        // skip it here rather than add a BaseFeature stray
                        // that would silently shift feature positions.
                        if (!SmsapiFeatures::has_feature($fname)) {
                            foreach ($extend_val as $ef) {
                                if (is_object($ef) && method_exists($ef, 'get_name')
                                    && $fname === $ef->get_name()) {
                                    continue 2;
                                }
                            }
                        }
                        ($utility->feature_add)($this->_rootctx, SmsapiFeatures::make_feature($fname));
                    }
                }
            }
        }

        // Add extension features.
        foreach ($extend_val as $f) {
            if (is_object($f) && method_exists($f, 'get_name')) {
                ($utility->feature_add)($this->_rootctx, $f);
            }
        }

        // Initialize features.
        foreach ($this->features as $f) {
            ($utility->feature_init)($this->_rootctx, $f);
        }

        ($utility->feature_hook)($this->_rootctx, "PostConstruct");
    }

    public function options_map(): array
    {
        $out = Struct::clone($this->options);
        return is_array($out) ? $out : [];
    }

    // The options hold the credential, so the default print and json form
    // name the client and nothing more; options_map() is the way to read
    // them back.
    public function jsonSerialize(): array
    {
        return ['name' => 'Smsapi'];
    }

    public function __debugInfo(): array
    {
        return $this->jsonSerialize();
    }

    public function get_utility()
    {
        return SmsapiUtility::copy($this->_utility);
    }

    public function get_root_ctx()
    {
        return $this->_rootctx;
    }

    public function prepare(array $fetchargs = []): mixed
    {
        $utility = $this->_utility;
        $fetchargs = $fetchargs ?? [];

        $ctrl = SmsapiHelpers::to_map(Struct::getprop($fetchargs, "ctrl")) ?? [];

        $ctx = ($utility->make_context)([
            "opname" => "prepare",
            "ctrl" => $ctrl,
        ], $this->_rootctx);

        $opts = $this->options;
        $path = Struct::getprop($fetchargs, "path") ?? "";
        $path = is_string($path) ? $path : "";
        $method_val = Struct::getprop($fetchargs, "method") ?? "GET";
        $method_val = is_string($method_val) ? $method_val : "GET";
        $params = SmsapiHelpers::to_map(Struct::getprop($fetchargs, "params")) ?? [];
        $query = SmsapiHelpers::to_map(Struct::getprop($fetchargs, "query")) ?? [];
        $headers = ($utility->prepare_headers)($ctx);

        $base = Struct::getprop($opts, "base") ?? "";
        $base = is_string($base) ? $base : "";
        $prefix = Struct::getprop($opts, "prefix") ?? "";
        $prefix = is_string($prefix) ? $prefix : "";
        $suffix = Struct::getprop($opts, "suffix") ?? "";
        $suffix = is_string($suffix) ? $suffix : "";

        $ctx->spec = new SmsapiSpec([
            "base" => $base, "prefix" => $prefix, "suffix" => $suffix,
            "path" => $path, "method" => $method_val,
            "params" => $params, "query" => $query, "headers" => $headers,
            "body" => Struct::getprop($fetchargs, "body"),
            "step" => "start",
        ]);

        // Merge user-provided headers.
        $uh = Struct::getprop($fetchargs, "headers");
        if (is_array($uh)) {
            foreach ($uh as $k => $v) {
                $ctx->spec->headers[$k] = $v;
            }
        }

        [$_, $err] = ($utility->prepare_auth)($ctx);
        if ($err) {
            return ($utility->make_error)($ctx, $err);
        }

        [$fetchdef, $fd_err] = ($utility->make_fetch_def)($ctx);
        if ($fd_err) {
            return ($utility->make_error)($ctx, $fd_err);
        }
        return $fetchdef;
    }

    // Raw endpoint access is operator-controllable, like every entity op.
    // Blocking it means denying BOTH the 'direct' and 'graphql' tokens,
    // since either one reaches the same endpoint.
    public function direct(array $fetchargs = []): mixed
    {
        if (!$this->op_allowed("direct")) {
            return $this->op_denied("direct");
        }

        return $this->raw_request($fetchargs);
    }

    // Is this raw-access op permitted by the SDK's allow.op option?
    private function op_allowed(string $op): bool
    {
        $allow_op = Struct::getpath($this->options, "allow.op");
        return is_string($allow_op) && str_contains($allow_op, $op);
    }

    private function op_denied(string $op): array
    {
        $allow_op = Struct::getpath($this->options, "allow.op");
        return [
            "ok" => false,
            "err" => new SmsapiError($op . "_allow",
                "SmsapiSDK: " . $op . ": operation not allowed by" .
                " SDK option allow.op value: \"" . (string)$allow_op . "\""),
        ];
    }

    // Ungated request path shared by direct and graphql, each of which
    // checks its own allow.op token first. Private, rather than a flag on
    // fetchargs: a caller-supplied marker would let anyone opt straight back
    // out of the gate by passing it.
    private function raw_request(array $fetchargs = []): mixed
    {
        $utility = $this->_utility;

        // direct() is the raw-HTTP escape hatch: it never throws, it returns
        // an {ok, err, ...} dict. prepare() now raises on error, so catch it
        // and surface the failure through the dict instead.
        try {
            $fetchdef = $this->prepare($fetchargs);
        } catch (\Throwable $err) {
            return ["ok" => false, "err" => $err];
        }

        $fetchargs = $fetchargs ?? [];
        $ctrl = SmsapiHelpers::to_map(Struct::getprop($fetchargs, "ctrl")) ?? [];

        $ctx = ($utility->make_context)([
            "opname" => "direct",
            "ctrl" => $ctrl,
        ], $this->_rootctx);

        $url = $fetchdef["url"] ?? "";
        [$fetched, $fetch_err] = ($utility->fetcher)($ctx, $url, $fetchdef);

        if ($fetch_err) {
            return ["ok" => false, "err" => ($utility->clean)($ctx, $fetch_err)];
        }

        if ($fetched === null) {
            return [
                "ok" => false,
                "err" => $ctx->make_error("direct_no_response", "response: undefined"),
            ];
        }

        if (is_array($fetched)) {
            $status = SmsapiHelpers::to_int(Struct::getprop($fetched, "status"));
            $headers = Struct::getprop($fetched, "headers") ?? [];

            // No-body responses (204, 304) and explicit zero content-length
            // must skip JSON parsing — calling json() on an empty body errors.
            $content_length = is_array($headers) ? ($headers["content-length"] ?? null) : null;
            $no_body = $status === 204 || $status === 304 || (string)$content_length === "0";

            $json_data = null;
            if (!$no_body) {
                $jf = Struct::getprop($fetched, "json");
                if (is_callable($jf)) {
                    try {
                        $json_data = $jf();
                    } catch (\Throwable $e) {
                        // Non-JSON body — leave data null but keep status/ok.
                        $json_data = null;
                    }
                }
            }

            return [
                "ok" => $status >= 200 && $status < 300,
                "status" => $status,
                "headers" => Struct::getprop($fetched, "headers"),
                "data" => $json_data,
            ];
        }

        return [
            "ok" => false,
            "err" => $ctx->make_error("direct_invalid", "invalid response type"),
        ];
    }

    // Raw GraphQL access: the pressure valve that makes the generated
    // surface's deliberate omissions (per-call selection sets, typed filter
    // builders, batching, subscriptions) livable — the whole schema stays
    // reachable.
    //
    // Thin wrapper over the same prepare/fetch path direct uses, with the
    // one thing raw direct cannot do for GraphQL: a GraphQL failure rides
    // HTTP 200 as a top-level `errors` array, so status alone would report
    // a failed query as ok.
    //
    // NOTE: like direct, this bypasses the feature pipeline — no retry,
    // ratelimit or paging features apply.
    public function graphql(string $query, ?array $variables = null, ?array $ctrl = null): mixed
    {
        if (!$this->op_allowed("graphql")) {
            return $this->op_denied("graphql");
        }

        $res = $this->raw_request([
            "method" => "POST",
            "headers" => ["content-type" => "application/json"],
            "body" => ["query" => $query, "variables" => $variables ?? []],
            "ctrl" => $ctrl ?? [],
        ]);

        if (!is_array($res)) {
            return $res;
        }

        // Errors are read BEFORE any status check: a GraphQL parse or
        // validation failure comes back as HTTP 400 carrying the standard
        // { errors: [...] } body, and the raw path represents a non-2xx as
        // ok:false with no err — so returning early on status would discard
        // the server's own diagnostics, which are the only useful part of
        // that response.
        $errors = Struct::getpath($res, "data.errors");

        if (is_array($errors) && 0 < count($errors)) {
            $first = is_array($errors[0]) ? $errors[0] : [];
            $msg = $first["message"] ?? "";
            if (!is_string($msg) || "" === $msg) {
                $msg = "graphql error";
            }
            $res["ok"] = false;
            $res["err"] = new SmsapiError("graphql_error",
                "SmsapiSDK: graphql: " . $msg);
            $res["graphql"] = $errors;
        }

        return $res;
    }


    private $_available = null;

    // Canonical facade: $client->Available()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->available()
    // resolves here too.
    public function Available($data = null)
    {
        require_once __DIR__ . '/entity/available_entity.php';
        if ($data === null) {
            if ($this->_available === null) {
                $this->_available = new AvailableEntity($this, null);
            }
            return $this->_available;
        }
        return new AvailableEntity($this, $data);
    }


    private $_blacklist = null;

    // Canonical facade: $client->Blacklist()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->blacklist()
    // resolves here too.
    public function Blacklist($data = null)
    {
        require_once __DIR__ . '/entity/blacklist_entity.php';
        if ($data === null) {
            if ($this->_blacklist === null) {
                $this->_blacklist = new BlacklistEntity($this, null);
            }
            return $this->_blacklist;
        }
        return new BlacklistEntity($this, $data);
    }


    private $_callback = null;

    // Canonical facade: $client->Callback()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->callback()
    // resolves here too.
    public function Callback($data = null)
    {
        require_once __DIR__ . '/entity/callback_entity.php';
        if ($data === null) {
            if ($this->_callback === null) {
                $this->_callback = new CallbackEntity($this, null);
            }
            return $this->_callback;
        }
        return new CallbackEntity($this, $data);
    }


    private $_contact = null;

    // Canonical facade: $client->Contact()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->contact()
    // resolves here too.
    public function Contact($data = null)
    {
        require_once __DIR__ . '/entity/contact_entity.php';
        if ($data === null) {
            if ($this->_contact === null) {
                $this->_contact = new ContactEntity($this, null);
            }
            return $this->_contact;
        }
        return new ContactEntity($this, $data);
    }


    private $_contacts_field = null;

    // Canonical facade: $client->ContactsField()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->contacts_field()
    // resolves here too.
    public function ContactsField($data = null)
    {
        require_once __DIR__ . '/entity/contacts_field_entity.php';
        if ($data === null) {
            if ($this->_contacts_field === null) {
                $this->_contacts_field = new ContactsFieldEntity($this, null);
            }
            return $this->_contacts_field;
        }
        return new ContactsFieldEntity($this, $data);
    }


    private $_contacts_field_option = null;

    // Canonical facade: $client->ContactsFieldOption()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->contacts_field_option()
    // resolves here too.
    public function ContactsFieldOption($data = null)
    {
        require_once __DIR__ . '/entity/contacts_field_option_entity.php';
        if ($data === null) {
            if ($this->_contacts_field_option === null) {
                $this->_contacts_field_option = new ContactsFieldOptionEntity($this, null);
            }
            return $this->_contacts_field_option;
        }
        return new ContactsFieldOptionEntity($this, $data);
    }


    private $_contactsgroup = null;

    // Canonical facade: $client->Contactsgroup()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->contactsgroup()
    // resolves here too.
    public function Contactsgroup($data = null)
    {
        require_once __DIR__ . '/entity/contactsgroup_entity.php';
        if ($data === null) {
            if ($this->_contactsgroup === null) {
                $this->_contactsgroup = new ContactsgroupEntity($this, null);
            }
            return $this->_contactsgroup;
        }
        return new ContactsgroupEntity($this, $data);
    }


    private $_contactstrash = null;

    // Canonical facade: $client->Contactstrash()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->contactstrash()
    // resolves here too.
    public function Contactstrash($data = null)
    {
        require_once __DIR__ . '/entity/contactstrash_entity.php';
        if ($data === null) {
            if ($this->_contactstrash === null) {
                $this->_contactstrash = new ContactstrashEntity($this, null);
            }
            return $this->_contactstrash;
        }
        return new ContactstrashEntity($this, $data);
    }


    private $_field_available = null;

    // Canonical facade: $client->FieldAvailable()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->field_available()
    // resolves here too.
    public function FieldAvailable($data = null)
    {
        require_once __DIR__ . '/entity/field_available_entity.php';
        if ($data === null) {
            if ($this->_field_available === null) {
                $this->_field_available = new FieldAvailableEntity($this, null);
            }
            return $this->_field_available;
        }
        return new FieldAvailableEntity($this, $data);
    }


    private $_group = null;

    // Canonical facade: $client->Group()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->group()
    // resolves here too.
    public function Group($data = null)
    {
        require_once __DIR__ . '/entity/group_entity.php';
        if ($data === null) {
            if ($this->_group === null) {
                $this->_group = new GroupEntity($this, null);
            }
            return $this->_group;
        }
        return new GroupEntity($this, $data);
    }


    private $_mfa_code = null;

    // Canonical facade: $client->MfaCode()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->mfa_code()
    // resolves here too.
    public function MfaCode($data = null)
    {
        require_once __DIR__ . '/entity/mfa_code_entity.php';
        if ($data === null) {
            if ($this->_mfa_code === null) {
                $this->_mfa_code = new MfaCodeEntity($this, null);
            }
            return $this->_mfa_code;
        }
        return new MfaCodeEntity($this, $data);
    }


    private $_opt_out = null;

    // Canonical facade: $client->OptOut()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->opt_out()
    // resolves here too.
    public function OptOut($data = null)
    {
        require_once __DIR__ . '/entity/opt_out_entity.php';
        if ($data === null) {
            if ($this->_opt_out === null) {
                $this->_opt_out = new OptOutEntity($this, null);
            }
            return $this->_opt_out;
        }
        return new OptOutEntity($this, $data);
    }


    private $_opt_out_setting = null;

    // Canonical facade: $client->OptOutSetting()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->opt_out_setting()
    // resolves here too.
    public function OptOutSetting($data = null)
    {
        require_once __DIR__ . '/entity/opt_out_setting_entity.php';
        if ($data === null) {
            if ($this->_opt_out_setting === null) {
                $this->_opt_out_setting = new OptOutSettingEntity($this, null);
            }
            return $this->_opt_out_setting;
        }
        return new OptOutSettingEntity($this, $data);
    }


    private $_permission = null;

    // Canonical facade: $client->Permission()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->permission()
    // resolves here too.
    public function Permission($data = null)
    {
        require_once __DIR__ . '/entity/permission_entity.php';
        if ($data === null) {
            if ($this->_permission === null) {
                $this->_permission = new PermissionEntity($this, null);
            }
            return $this->_permission;
        }
        return new PermissionEntity($this, $data);
    }


    private $_ping = null;

    // Canonical facade: $client->Ping()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->ping()
    // resolves here too.
    public function Ping($data = null)
    {
        require_once __DIR__ . '/entity/ping_entity.php';
        if ($data === null) {
            if ($this->_ping === null) {
                $this->_ping = new PingEntity($this, null);
            }
            return $this->_ping;
        }
        return new PingEntity($this, $data);
    }


    private $_profile = null;

    // Canonical facade: $client->Profile()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->profile()
    // resolves here too.
    public function Profile($data = null)
    {
        require_once __DIR__ . '/entity/profile_entity.php';
        if ($data === null) {
            if ($this->_profile === null) {
                $this->_profile = new ProfileEntity($this, null);
            }
            return $this->_profile;
        }
        return new ProfileEntity($this, $data);
    }


    private $_rcs = null;

    // Canonical facade: $client->Rcs()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->rcs()
    // resolves here too.
    public function Rcs($data = null)
    {
        require_once __DIR__ . '/entity/rcs_entity.php';
        if ($data === null) {
            if ($this->_rcs === null) {
                $this->_rcs = new RcsEntity($this, null);
            }
            return $this->_rcs;
        }
        return new RcsEntity($this, $data);
    }


    private $_sendername = null;

    // Canonical facade: $client->Sendername()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->sendername()
    // resolves here too.
    public function Sendername($data = null)
    {
        require_once __DIR__ . '/entity/sendername_entity.php';
        if ($data === null) {
            if ($this->_sendername === null) {
                $this->_sendername = new SendernameEntity($this, null);
            }
            return $this->_sendername;
        }
        return new SendernameEntity($this, $data);
    }


    private $_sendername_statement = null;

    // Canonical facade: $client->SendernameStatement()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->sendername_statement()
    // resolves here too.
    public function SendernameStatement($data = null)
    {
        require_once __DIR__ . '/entity/sendername_statement_entity.php';
        if ($data === null) {
            if ($this->_sendername_statement === null) {
                $this->_sendername_statement = new SendernameStatementEntity($this, null);
            }
            return $this->_sendername_statement;
        }
        return new SendernameStatementEntity($this, $data);
    }


    private $_sent_rcs_message = null;

    // Canonical facade: $client->SentRcsMessage()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->sent_rcs_message()
    // resolves here too.
    public function SentRcsMessage($data = null)
    {
        require_once __DIR__ . '/entity/sent_rcs_message_entity.php';
        if ($data === null) {
            if ($this->_sent_rcs_message === null) {
                $this->_sent_rcs_message = new SentRcsMessageEntity($this, null);
            }
            return $this->_sent_rcs_message;
        }
        return new SentRcsMessageEntity($this, $data);
    }


    private $_shipment_country_volume = null;

    // Canonical facade: $client->ShipmentCountryVolume()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->shipment_country_volume()
    // resolves here too.
    public function ShipmentCountryVolume($data = null)
    {
        require_once __DIR__ . '/entity/shipment_country_volume_entity.php';
        if ($data === null) {
            if ($this->_shipment_country_volume === null) {
                $this->_shipment_country_volume = new ShipmentCountryVolumeEntity($this, null);
            }
            return $this->_shipment_country_volume;
        }
        return new ShipmentCountryVolumeEntity($this, $data);
    }


    private $_short_url = null;

    // Canonical facade: $client->ShortUrl()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->short_url()
    // resolves here too.
    public function ShortUrl($data = null)
    {
        require_once __DIR__ . '/entity/short_url_entity.php';
        if ($data === null) {
            if ($this->_short_url === null) {
                $this->_short_url = new ShortUrlEntity($this, null);
            }
            return $this->_short_url;
        }
        return new ShortUrlEntity($this, $data);
    }


    private $_smsdo = null;

    // Canonical facade: $client->Smsdo()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->smsdo()
    // resolves here too.
    public function Smsdo($data = null)
    {
        require_once __DIR__ . '/entity/smsdo_entity.php';
        if ($data === null) {
            if ($this->_smsdo === null) {
                $this->_smsdo = new SmsdoEntity($this, null);
            }
            return $this->_smsdo;
        }
        return new SmsdoEntity($this, $data);
    }


    private $_smssendername = null;

    // Canonical facade: $client->Smssendername()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->smssendername()
    // resolves here too.
    public function Smssendername($data = null)
    {
        require_once __DIR__ . '/entity/smssendername_entity.php';
        if ($data === null) {
            if ($this->_smssendername === null) {
                $this->_smssendername = new SmssendernameEntity($this, null);
            }
            return $this->_smssendername;
        }
        return new SmssendernameEntity($this, $data);
    }


    private $_smstemplate = null;

    // Canonical facade: $client->Smstemplate()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->smstemplate()
    // resolves here too.
    public function Smstemplate($data = null)
    {
        require_once __DIR__ . '/entity/smstemplate_entity.php';
        if ($data === null) {
            if ($this->_smstemplate === null) {
                $this->_smstemplate = new SmstemplateEntity($this, null);
            }
            return $this->_smstemplate;
        }
        return new SmstemplateEntity($this, $data);
    }


    private $_subuser = null;

    // Canonical facade: $client->Subuser()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->subuser()
    // resolves here too.
    public function Subuser($data = null)
    {
        require_once __DIR__ . '/entity/subuser_entity.php';
        if ($data === null) {
            if ($this->_subuser === null) {
                $this->_subuser = new SubuserEntity($this, null);
            }
            return $this->_subuser;
        }
        return new SubuserEntity($this, $data);
    }


    private $_template = null;

    // Canonical facade: $client->Template()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->template()
    // resolves here too.
    public function Template($data = null)
    {
        require_once __DIR__ . '/entity/template_entity.php';
        if ($data === null) {
            if ($this->_template === null) {
                $this->_template = new TemplateEntity($this, null);
            }
            return $this->_template;
        }
        return new TemplateEntity($this, $data);
    }


    private $_user_rcs_sender_collection = null;

    // Canonical facade: $client->UserRcsSenderCollection()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->user_rcs_sender_collection()
    // resolves here too.
    public function UserRcsSenderCollection($data = null)
    {
        require_once __DIR__ . '/entity/user_rcs_sender_collection_entity.php';
        if ($data === null) {
            if ($this->_user_rcs_sender_collection === null) {
                $this->_user_rcs_sender_collection = new UserRcsSenderCollectionEntity($this, null);
            }
            return $this->_user_rcs_sender_collection;
        }
        return new UserRcsSenderCollectionEntity($this, $data);
    }



    public static function test(?array $testopts = null, ?array $sdkopts = null): self
    {
        $sdkopts = $sdkopts ?? [];
        $sdkopts = Struct::clone($sdkopts);
        $sdkopts = is_array($sdkopts) ? $sdkopts : [];

        $testopts = $testopts ?? [];
        $testopts = Struct::clone($testopts);
        $testopts = is_array($testopts) ? $testopts : [];
        $testopts["active"] = true;

        if (!isset($sdkopts["feature"])) {
            $sdkopts["feature"] = [];
        }
        $sdkopts["feature"]["test"] = $testopts;

        $sdk = new SmsapiSDK($sdkopts);
        $sdk->mode = "test";
        return $sdk;
    }
}
