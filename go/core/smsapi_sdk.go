package core

import (
	"encoding/json"
	"fmt"
	"strings"

	vs "github.com/voxgig-sdk/smsapi-sdk/go/utility/struct"
)

type SmsapiSDK struct {
	Mode     string
	options  map[string]any
	utility  *Utility
	Features []Feature
	rootctx  *Context
}

func NewSmsapiSDK(options map[string]any) *SmsapiSDK {
	sdk := &SmsapiSDK{
		Mode:     "live",
		Features: []Feature{},
	}

	sdk.utility = NewUtility()

	config := SharedConfig()

	sdk.rootctx = sdk.utility.MakeContext(map[string]any{
		"client":  sdk,
		"utility": sdk.utility,
		"config":  config,
		"options": options,
		"shared":  map[string]any{},
	}, nil)

	sdk.options = sdk.utility.MakeOptions(sdk.rootctx)

	if vs.GetPath(sdk.options, []any{"feature", "test", "active"}) == true {
		sdk.Mode = "test"
	}

	sdk.rootctx.Options = sdk.options

	// Add features in the resolved order (MakeOptions puts an explicit array
	// order first, else defaults to test-first). Ordering matters: the `test`
	// feature installs the base mock transport and the transport features
	// (retry/cache/netsim/proxy/ratelimit) wrap whatever is current, so `test`
	// must be added before them to sit at the base of the chain.
	featureOpts := ToMapAny(vs.GetProp(sdk.options, "feature"))
	if featureOpts != nil {
		if fo, ok := vs.GetPath(sdk.options, []any{"__derived__", "featureorder"}).([]any); ok {
			for _, n := range fo {
				fname, _ := n.(string)
				fopts := ToMapAny(featureOpts[fname])
				if fopts != nil {
					if active, ok := fopts["active"]; ok {
						if ab, ok := active.(bool); ok && ab {
							sdk.utility.FeatureAdd(sdk.rootctx, makeFeature(fname))
						}
					}
				}
			}
		}
	}

	// Add extension features.
	if extend := vs.GetProp(sdk.options, "extend"); extend != nil {
		if extList, ok := extend.([]any); ok {
			for _, f := range extList {
				if feat, ok := f.(Feature); ok {
					sdk.utility.FeatureAdd(sdk.rootctx, feat)
				}
			}
		}
	}

	// Initialize features.
	for _, f := range sdk.Features {
		sdk.utility.FeatureInit(sdk.rootctx, f)
	}

	sdk.utility.FeatureHook(sdk.rootctx, "PostConstruct")

	return sdk
}

// The client holds the credential in its options, so a print or a JSON dump
// carries the name alone. Value receivers: a dereferenced client prints the
// same way.
func (sdk SmsapiSDK) String() string {
	return "Smsapi " + vs.Jsonify(map[string]any{"name": "Smsapi"},
		map[string]any{"indent": 0})
}

func (sdk SmsapiSDK) GoString() string {
	return sdk.String()
}

func (sdk SmsapiSDK) MarshalJSON() ([]byte, error) {
	return json.Marshal(map[string]any{"name": "Smsapi"})
}

func (sdk *SmsapiSDK) OptionsMap() map[string]any {
	out := vs.Clone(sdk.options)
	if om, ok := out.(map[string]any); ok {
		return om
	}
	return map[string]any{}
}

func (sdk *SmsapiSDK) GetUtility() *Utility {
	return CopyUtility(sdk.utility)
}

func (sdk *SmsapiSDK) GetRootCtx() *Context {
	return sdk.rootctx
}

func (sdk *SmsapiSDK) Prepare(fetchargs map[string]any) (map[string]any, error) {
	utility := sdk.utility

	if fetchargs == nil {
		fetchargs = map[string]any{}
	}

	var ctrl map[string]any
	if c := vs.GetProp(fetchargs, "ctrl"); c != nil {
		if cm, ok := c.(map[string]any); ok {
			ctrl = cm
		}
	}
	if ctrl == nil {
		ctrl = map[string]any{}
	}

	ctx := utility.MakeContext(map[string]any{
		"opname": "prepare",
		"ctrl":   ctrl,
	}, sdk.rootctx)

	options := sdk.options

	path, _ := vs.GetProp(fetchargs, "path").(string)
	method, _ := vs.GetProp(fetchargs, "method").(string)
	if method == "" {
		method = "GET"
	}

	params := ToMapAny(vs.GetProp(fetchargs, "params"))
	if params == nil {
		params = map[string]any{}
	}
	query := ToMapAny(vs.GetProp(fetchargs, "query"))
	if query == nil {
		query = map[string]any{}
	}

	headers := utility.PrepareHeaders(ctx)

	base, _ := vs.GetProp(options, "base").(string)
	prefix, _ := vs.GetProp(options, "prefix").(string)
	suffix, _ := vs.GetProp(options, "suffix").(string)

	ctx.Spec = NewSpec(map[string]any{
		"base":    base,
		"prefix":  prefix,
		"suffix":  suffix,
		"path":    path,
		"method":  method,
		"params":  params,
		"query":   query,
		"headers": headers,
		"body":    vs.GetProp(fetchargs, "body"),
		"step":    "start",
	})

	// Merge user-provided headers.
	if uh := vs.GetProp(fetchargs, "headers"); uh != nil {
		if uhm, ok := uh.(map[string]any); ok {
			for k, v := range uhm {
				ctx.Spec.Headers[k] = v
			}
		}
	}

	_, err := utility.PrepareAuth(ctx)
	if err != nil {
		return nil, err
	}

	return utility.MakeFetchDef(ctx)
}

// Raw endpoint access is operator-controllable, like every entity op.
// Blocking it means denying BOTH the 'direct' and 'graphql' tokens, since
// either one reaches the same endpoint.
func (sdk *SmsapiSDK) Direct(fetchargs map[string]any) (map[string]any, error) {
	if !sdk.opAllowed("direct") {
		return sdk.opDenied("direct"), nil
	}

	return sdk.rawRequest(fetchargs)
}

// Is this raw-access op permitted by the SDK's allow.op option?
func (sdk *SmsapiSDK) opAllowed(op string) bool {
	allowOp, _ := vs.GetPath(sdk.options, []any{"allow", "op"}).(string)
	return strings.Contains(allowOp, op)
}

func (sdk *SmsapiSDK) opDenied(op string) map[string]any {
	allowOp, _ := vs.GetPath(sdk.options, []any{"allow", "op"}).(string)
	return map[string]any{
		"ok": false,
		"err": fmt.Errorf("SmsapiSDK: %s: operation not allowed by"+
			" SDK option allow.op value: \"%s\"", op, allowOp),
	}
}

// Ungated request path shared by Direct and Graphql, each of which checks
// its own allow.op token first. Unexported, rather than a flag on fetchargs:
// a caller-supplied marker would let anyone opt straight back out of the
// gate by passing it.
func (sdk *SmsapiSDK) rawRequest(fetchargs map[string]any) (map[string]any, error) {
	utility := sdk.utility

	fetchdef, err := sdk.Prepare(fetchargs)
	if err != nil {
		return map[string]any{"ok": false, "err": sdk.cleanErr(sdk.rootctx, err)}, nil
	}

	if fetchargs == nil {
		fetchargs = map[string]any{}
	}

	var ctrl map[string]any
	if c := vs.GetProp(fetchargs, "ctrl"); c != nil {
		if cm, ok := c.(map[string]any); ok {
			ctrl = cm
		}
	}
	if ctrl == nil {
		ctrl = map[string]any{}
	}

	ctx := utility.MakeContext(map[string]any{
		"opname": "direct",
		"ctrl":   ctrl,
	}, sdk.rootctx)

	url, _ := fetchdef["url"].(string)
	fetched, fetchErr := utility.Fetcher(ctx, url, fetchdef)

	if fetchErr != nil {
		return map[string]any{"ok": false, "err": sdk.cleanErr(ctx, fetchErr)}, nil
	}

	if fetched == nil {
		return map[string]any{
			"ok":  false,
			"err": ctx.MakeError("direct_no_response", "response: undefined"),
		}, nil
	}

	if fm, ok := fetched.(map[string]any); ok {
		status := ToInt(vs.GetProp(fm, "status"))
		headers := vs.GetProp(fm, "headers")

		// No-body responses (204, 304) and explicit zero content-length
		// must skip JSON parsing — calling json() on an empty body errors.
		var contentLength string
		if hm, ok := headers.(map[string]any); ok {
			if cl, ok := hm["content-length"]; ok {
				contentLength = fmt.Sprintf("%v", cl)
			}
		}
		noBody := status == 204 || status == 304 || contentLength == "0"

		var jsonData any
		if !noBody {
			if jf := vs.GetProp(fm, "json"); jf != nil {
				if f, ok := jf.(func() any); ok {
					jsonData = f()
				}
			}
		}

		return map[string]any{
			"ok":      status >= 200 && status < 300,
			"status":  status,
			"headers": headers,
			"data":    jsonData,
		}, nil
	}

	return map[string]any{"ok": false, "err": ctx.MakeError("direct_invalid", "invalid response type")}, nil
}

// A raw request returns its error rather than passing it through MakeError.
func (sdk *SmsapiSDK) cleanErr(ctx *Context, err error) error {
	if cleaned, ok := sdk.utility.Clean(ctx, err).(error); ok {
		return cleaned
	}
	return err
}

func (sdk *SmsapiSDK) Graphql(
	query string, variables map[string]any, ctrl map[string]any,
) (map[string]any, error) {
	if !sdk.opAllowed("graphql") {
		return sdk.opDenied("graphql"), nil
	}

	if variables == nil {
		variables = map[string]any{}
	}
	if ctrl == nil {
		ctrl = map[string]any{}
	}

	res, err := sdk.rawRequest(map[string]any{
		"method":  "POST",
		"headers": map[string]any{"content-type": "application/json"},
		"body":    map[string]any{"query": query, "variables": variables},
		"ctrl":    ctrl,
	})

	if err != nil {
		return res, err
	}

	// Errors are read BEFORE any status check: a GraphQL parse or validation
	// failure comes back as HTTP 400 carrying the standard { errors: [...] }
	// body, and the raw path represents a non-2xx as ok:false with no err —
	// so returning early on status would discard the server's own
	// diagnostics, which are the only useful part of that response.
	errors, _ := vs.GetPath(res, []any{"data", "errors"}).([]any)

	if 0 < len(errors) {
		msg, _ := vs.GetProp(errors[0], "message").(string)
		if msg == "" {
			msg = "graphql error"
		}
		res["ok"] = false
		res["err"] = fmt.Errorf("SmsapiSDK: graphql: %s", msg)
		res["graphql"] = errors
	}

	return res, nil
}


// Available returns a Available entity bound to this client.
// Idiomatic usage: client.Available(nil).List(nil, nil) or
// client.Available(nil).Load(map[string]any{"id": ...}, nil).
func (sdk *SmsapiSDK) Available(data map[string]any) SmsapiEntity {
	return NewAvailableEntityFunc(sdk, data)
}


// Blacklist returns a Blacklist entity bound to this client.
// Idiomatic usage: client.Blacklist(nil).List(nil, nil) or
// client.Blacklist(nil).Load(map[string]any{"id": ...}, nil).
func (sdk *SmsapiSDK) Blacklist(data map[string]any) SmsapiEntity {
	return NewBlacklistEntityFunc(sdk, data)
}


// Callback returns a Callback entity bound to this client.
// Idiomatic usage: client.Callback(nil).List(nil, nil) or
// client.Callback(nil).Load(map[string]any{"id": ...}, nil).
func (sdk *SmsapiSDK) Callback(data map[string]any) SmsapiEntity {
	return NewCallbackEntityFunc(sdk, data)
}


// Contact returns a Contact entity bound to this client.
// Idiomatic usage: client.Contact(nil).List(nil, nil) or
// client.Contact(nil).Load(map[string]any{"id": ...}, nil).
func (sdk *SmsapiSDK) Contact(data map[string]any) SmsapiEntity {
	return NewContactEntityFunc(sdk, data)
}


// ContactsField returns a ContactsField entity bound to this client.
// Idiomatic usage: client.ContactsField(nil).List(nil, nil) or
// client.ContactsField(nil).Load(map[string]any{"id": ...}, nil).
func (sdk *SmsapiSDK) ContactsField(data map[string]any) SmsapiEntity {
	return NewContactsFieldEntityFunc(sdk, data)
}


// ContactsFieldOption returns a ContactsFieldOption entity bound to this client.
// Idiomatic usage: client.ContactsFieldOption(nil).List(nil, nil) or
// client.ContactsFieldOption(nil).Load(map[string]any{"id": ...}, nil).
func (sdk *SmsapiSDK) ContactsFieldOption(data map[string]any) SmsapiEntity {
	return NewContactsFieldOptionEntityFunc(sdk, data)
}


// Contactsgroup returns a Contactsgroup entity bound to this client.
// Idiomatic usage: client.Contactsgroup(nil).List(nil, nil) or
// client.Contactsgroup(nil).Load(map[string]any{"id": ...}, nil).
func (sdk *SmsapiSDK) Contactsgroup(data map[string]any) SmsapiEntity {
	return NewContactsgroupEntityFunc(sdk, data)
}


// Contactstrash returns a Contactstrash entity bound to this client.
// Idiomatic usage: client.Contactstrash(nil).List(nil, nil) or
// client.Contactstrash(nil).Load(map[string]any{"id": ...}, nil).
func (sdk *SmsapiSDK) Contactstrash(data map[string]any) SmsapiEntity {
	return NewContactstrashEntityFunc(sdk, data)
}


// FieldAvailable returns a FieldAvailable entity bound to this client.
// Idiomatic usage: client.FieldAvailable(nil).List(nil, nil) or
// client.FieldAvailable(nil).Load(map[string]any{"id": ...}, nil).
func (sdk *SmsapiSDK) FieldAvailable(data map[string]any) SmsapiEntity {
	return NewFieldAvailableEntityFunc(sdk, data)
}


// Group returns a Group entity bound to this client.
// Idiomatic usage: client.Group(nil).List(nil, nil) or
// client.Group(nil).Load(map[string]any{"id": ...}, nil).
func (sdk *SmsapiSDK) Group(data map[string]any) SmsapiEntity {
	return NewGroupEntityFunc(sdk, data)
}


// MfaCode returns a MfaCode entity bound to this client.
// Idiomatic usage: client.MfaCode(nil).List(nil, nil) or
// client.MfaCode(nil).Load(map[string]any{"id": ...}, nil).
func (sdk *SmsapiSDK) MfaCode(data map[string]any) SmsapiEntity {
	return NewMfaCodeEntityFunc(sdk, data)
}


// OptOut returns a OptOut entity bound to this client.
// Idiomatic usage: client.OptOut(nil).List(nil, nil) or
// client.OptOut(nil).Load(map[string]any{"id": ...}, nil).
func (sdk *SmsapiSDK) OptOut(data map[string]any) SmsapiEntity {
	return NewOptOutEntityFunc(sdk, data)
}


// OptOutSetting returns a OptOutSetting entity bound to this client.
// Idiomatic usage: client.OptOutSetting(nil).List(nil, nil) or
// client.OptOutSetting(nil).Load(map[string]any{"id": ...}, nil).
func (sdk *SmsapiSDK) OptOutSetting(data map[string]any) SmsapiEntity {
	return NewOptOutSettingEntityFunc(sdk, data)
}


// Permission returns a Permission entity bound to this client.
// Idiomatic usage: client.Permission(nil).List(nil, nil) or
// client.Permission(nil).Load(map[string]any{"id": ...}, nil).
func (sdk *SmsapiSDK) Permission(data map[string]any) SmsapiEntity {
	return NewPermissionEntityFunc(sdk, data)
}


// Ping returns a Ping entity bound to this client.
// Idiomatic usage: client.Ping(nil).List(nil, nil) or
// client.Ping(nil).Load(map[string]any{"id": ...}, nil).
func (sdk *SmsapiSDK) Ping(data map[string]any) SmsapiEntity {
	return NewPingEntityFunc(sdk, data)
}


// Profile returns a Profile entity bound to this client.
// Idiomatic usage: client.Profile(nil).List(nil, nil) or
// client.Profile(nil).Load(map[string]any{"id": ...}, nil).
func (sdk *SmsapiSDK) Profile(data map[string]any) SmsapiEntity {
	return NewProfileEntityFunc(sdk, data)
}


// Rcs returns a Rcs entity bound to this client.
// Idiomatic usage: client.Rcs(nil).List(nil, nil) or
// client.Rcs(nil).Load(map[string]any{"id": ...}, nil).
func (sdk *SmsapiSDK) Rcs(data map[string]any) SmsapiEntity {
	return NewRcsEntityFunc(sdk, data)
}


// Sendername returns a Sendername entity bound to this client.
// Idiomatic usage: client.Sendername(nil).List(nil, nil) or
// client.Sendername(nil).Load(map[string]any{"id": ...}, nil).
func (sdk *SmsapiSDK) Sendername(data map[string]any) SmsapiEntity {
	return NewSendernameEntityFunc(sdk, data)
}


// SendernameStatement returns a SendernameStatement entity bound to this client.
// Idiomatic usage: client.SendernameStatement(nil).List(nil, nil) or
// client.SendernameStatement(nil).Load(map[string]any{"id": ...}, nil).
func (sdk *SmsapiSDK) SendernameStatement(data map[string]any) SmsapiEntity {
	return NewSendernameStatementEntityFunc(sdk, data)
}


// SentRcsMessage returns a SentRcsMessage entity bound to this client.
// Idiomatic usage: client.SentRcsMessage(nil).List(nil, nil) or
// client.SentRcsMessage(nil).Load(map[string]any{"id": ...}, nil).
func (sdk *SmsapiSDK) SentRcsMessage(data map[string]any) SmsapiEntity {
	return NewSentRcsMessageEntityFunc(sdk, data)
}


// ShipmentCountryVolume returns a ShipmentCountryVolume entity bound to this client.
// Idiomatic usage: client.ShipmentCountryVolume(nil).List(nil, nil) or
// client.ShipmentCountryVolume(nil).Load(map[string]any{"id": ...}, nil).
func (sdk *SmsapiSDK) ShipmentCountryVolume(data map[string]any) SmsapiEntity {
	return NewShipmentCountryVolumeEntityFunc(sdk, data)
}


// ShortUrl returns a ShortUrl entity bound to this client.
// Idiomatic usage: client.ShortUrl(nil).List(nil, nil) or
// client.ShortUrl(nil).Load(map[string]any{"id": ...}, nil).
func (sdk *SmsapiSDK) ShortUrl(data map[string]any) SmsapiEntity {
	return NewShortUrlEntityFunc(sdk, data)
}


// Smsdo returns a Smsdo entity bound to this client.
// Idiomatic usage: client.Smsdo(nil).List(nil, nil) or
// client.Smsdo(nil).Load(map[string]any{"id": ...}, nil).
func (sdk *SmsapiSDK) Smsdo(data map[string]any) SmsapiEntity {
	return NewSmsdoEntityFunc(sdk, data)
}


// Smssendername returns a Smssendername entity bound to this client.
// Idiomatic usage: client.Smssendername(nil).List(nil, nil) or
// client.Smssendername(nil).Load(map[string]any{"id": ...}, nil).
func (sdk *SmsapiSDK) Smssendername(data map[string]any) SmsapiEntity {
	return NewSmssendernameEntityFunc(sdk, data)
}


// Smstemplate returns a Smstemplate entity bound to this client.
// Idiomatic usage: client.Smstemplate(nil).List(nil, nil) or
// client.Smstemplate(nil).Load(map[string]any{"id": ...}, nil).
func (sdk *SmsapiSDK) Smstemplate(data map[string]any) SmsapiEntity {
	return NewSmstemplateEntityFunc(sdk, data)
}


// Subuser returns a Subuser entity bound to this client.
// Idiomatic usage: client.Subuser(nil).List(nil, nil) or
// client.Subuser(nil).Load(map[string]any{"id": ...}, nil).
func (sdk *SmsapiSDK) Subuser(data map[string]any) SmsapiEntity {
	return NewSubuserEntityFunc(sdk, data)
}


// Template returns a Template entity bound to this client.
// Idiomatic usage: client.Template(nil).List(nil, nil) or
// client.Template(nil).Load(map[string]any{"id": ...}, nil).
func (sdk *SmsapiSDK) Template(data map[string]any) SmsapiEntity {
	return NewTemplateEntityFunc(sdk, data)
}


// UserRcsSenderCollection returns a UserRcsSenderCollection entity bound to this client.
// Idiomatic usage: client.UserRcsSenderCollection(nil).List(nil, nil) or
// client.UserRcsSenderCollection(nil).Load(map[string]any{"id": ...}, nil).
func (sdk *SmsapiSDK) UserRcsSenderCollection(data map[string]any) SmsapiEntity {
	return NewUserRcsSenderCollectionEntityFunc(sdk, data)
}



func TestSDK(testopts map[string]any, sdkopts map[string]any) *SmsapiSDK {
	if sdkopts == nil {
		sdkopts = map[string]any{}
	}
	sdkopts = vs.Clone(sdkopts).(map[string]any)

	if testopts == nil {
		testopts = map[string]any{}
	}
	testopts = vs.Clone(testopts).(map[string]any)
	testopts["active"] = true

	vs.SetPath(sdkopts, []any{"feature", "test"}, testopts)

	sdk := NewSmsapiSDK(sdkopts)
	sdk.Mode = "test"

	return sdk
}
