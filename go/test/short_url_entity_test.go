package sdktest

import (
	"encoding/json"
	"fmt"
	"os"
	"path/filepath"
	"runtime"
	"strings"
	"testing"
	"time"

	sdk "github.com/voxgig-sdk/smsapi-sdk/go"
	"github.com/voxgig-sdk/smsapi-sdk/go/core"

	vs "github.com/voxgig-sdk/smsapi-sdk/go/utility/struct"
)

// main.kit.test.live.strict is true (the default is true): a live
// request that fails, or a live test missing an input it needs,
// fails the test.
// An account with no record for a test to read skips it either way.
const short_urlEntityLiveStrict = true


type short_urlFailHook struct {
	sdk.BaseFeature
	unexpected int
}

func (f *short_urlFailHook) PreSpec(ctx *sdk.Context) {
	panic("short_url hook failed")
}

func (f *short_urlFailHook) PreUnexpected(ctx *sdk.Context) {
	f.unexpected++
}

func TestShortUrlEntity(t *testing.T) {
	t.Run("instance", func(t *testing.T) {
		testsdk := sdk.TestSDK(nil, nil)
		ent := testsdk.ShortUrl(nil)
		if ent == nil {
			t.Fatal("expected non-nil ShortUrlEntity")
		}
	})

	// Feature #4: the entity Stream(action, ...) method runs the op pipeline and
	// returns a channel over result items. With the streaming feature active it
	// yields the feature's incremental output; otherwise it falls back to the
	// materialised list so Stream always yields.
	t.Run("stream", func(t *testing.T) {
		seed := map[string]any{
			"entity": map[string]any{
				"short_url": map[string]any{
					"s1": map[string]any{"id": "s1"},
					"s2": map[string]any{"id": "s2"},
					"s3": map[string]any{"id": "s3"},
				},
			},
		}

		// Fallback: streaming inactive -> yields the materialised list items.
		base := sdk.TestSDK(seed, nil)
		var seen []any
		for si := range base.ShortUrl(nil).Stream("list", nil, nil) {
			if si.Err != nil {
				t.Fatalf("stream failed: %v", si.Err)
			}
			seen = append(seen, si.Item)
		}
		if len(seen) != 3 {
			t.Fatalf("expected 3 streamed items, got %d", len(seen))
		}

		// Inbound: streaming active -> yields each item from the feature iterator.
		hasStreaming := false
		if fm, ok := core.SharedConfig()["feature"].(map[string]any); ok {
			_, hasStreaming = fm["streaming"]
		}
		if hasStreaming {
			streamSdk := sdk.TestSDK(seed, map[string]any{
				"feature": map[string]any{"streaming": map[string]any{"active": true}},
			})
			var got []any
			for si := range streamSdk.ShortUrl(nil).Stream("list", nil, nil) {
				if si.Err != nil {
					t.Fatalf("stream failed: %v", si.Err)
				}
				if sub, ok := si.Item.([]any); ok {
					got = append(got, sub...)
				} else {
					got = append(got, si.Item)
				}
			}
			if len(got) != 3 {
				t.Fatalf("expected 3 items via streaming feature, got %d", len(got))
			}
		}
	})

	t.Run("stream-error", func(t *testing.T) {
		offline := map[string]any{"net": map[string]any{"offline": true}}
		var streamerr error
		for si := range sdk.TestSDK(offline, nil).ShortUrl(nil).Stream("list", nil, nil) {
			if si.Err != nil {
				streamerr = si.Err
			}
		}
		if nil == streamerr || !strings.Contains(streamerr.Error(), "offline") {
			t.Fatalf("expected the transport failure as a stream value, got %v", streamerr)
		}

		quiet := map[string]any{"ctrl": map[string]any{"throw": false}}
		for si := range sdk.TestSDK(offline, nil).ShortUrl(nil).Stream("list", nil, quiet) {
			if si.Err != nil {
				t.Fatalf("throw false: expected no error value, got %v", si.Err)
			}
		}

		if fhHasFeature("rbac") {
			denied := sdk.TestSDK(nil, map[string]any{
				"feature": map[string]any{"rbac": map[string]any{"active": true, "deny": true}},
			})
			var denyerr error
			for si := range denied.ShortUrl(nil).Stream("list", nil, nil) {
				if si.Err != nil {
					denyerr = si.Err
				}
			}
			if sdkerr, ok := denyerr.(*core.SmsapiError); !ok || "rbac_denied" != sdkerr.Code {
				t.Fatalf("expected the rbac denial as a stream value, got %v", denyerr)
			}
		}
	})

	t.Run("stream-ctrl", func(t *testing.T) {
		explain := map[string]any{}
		ctrl := map[string]any{"explain": explain}
		for range sdk.TestSDK(nil, nil).ShortUrl(nil).Stream("list", nil, map[string]any{"ctrl": ctrl}) {
		}
		if _, has := ctrl["stream"]; has || 1 != len(ctrl) {
			t.Fatalf("the stream changed the caller's ctrl")
		}
		if 0 == len(explain) {
			t.Fatalf("the caller's explain record was not filled")
		}
	})

	t.Run("unexpected", func(t *testing.T) {
		hook := &short_urlFailHook{
			BaseFeature: sdk.BaseFeature{Version: "0.0.1", Name: "failhook", Active: true}}
		client := sdk.TestSDK(nil, map[string]any{"extend": []any{hook}})

		_, err := client.ShortUrl(nil).List(nil, nil)
		if nil == err || !strings.Contains(err.Error(), "hook failed") {
			t.Fatalf("expected the hook's failure, got %v", err)
		}
		if 0 == hook.unexpected {
			t.Fatalf("PreUnexpected did not fire")
		}

		fired := hook.unexpected
		if _, err := client.ShortUrl(nil).List(nil, map[string]any{"throw": false}); nil != err {
			t.Fatalf("throw false: expected no error, got %v", err)
		}
		if fired == hook.unexpected {
			t.Fatalf("throw false: PreUnexpected did not fire")
		}
	})

	t.Run("validate", func(t *testing.T) {
		if !fhHasFeature("validate") {
			t.Skip("feature not present in this SDK: validate")
		}
		client := sdk.TestSDK(nil, map[string]any{
			"feature": map[string]any{"validate": map[string]any{"active": true}},
		})
		_, err := client.ShortUrl(nil).List(map[string]any{"description": 1}, nil)
		if sdkerr, ok := err.(*core.SmsapiError); !ok || "validate_failed" != sdkerr.Code {
			t.Fatalf("expected validate_failed, got %v", err)
		}
	})

	t.Run("basic", func(tt *testing.T) {
		var t testing.TB = tt
		setup := short_urlBasicSetup(nil)
		// Per-op sdk-test-control.json skip — basic test exercises a flow
		// with multiple ops; skipping any op skips the whole flow.
		_mode := "unit"
		if setup.live {
			_mode = "live"
		}
		for _, _op := range []string{"create", "list", "update", "load", "remove"} {
			if _shouldSkip, _reason := isControlSkipped("entityOp", "short_url." + _op, _mode); _shouldSkip {
				if _reason == "" {
					_reason = "skipped via sdk-test-control.json"
				}
				t.Skip(_reason)
				return
			}
		}
		client := setup.client

		// CREATE
		shortUrlRef01Ent := client.ShortUrl(nil)
		shortUrlRef01Data := core.ToMapAny(vs.GetProp(
			vs.GetPath(setup.data, []any{"new", "short_url"}), "short_url_ref01"))

		shortUrlRef01DataResult, err := shortUrlRef01Ent.Create(shortUrlRef01Data, nil)
		if err != nil {
			t.Fatalf("create failed: %v", err)
		}
		shortUrlRef01Data = core.ToMapAny(entityData(shortUrlRef01DataResult))
		if shortUrlRef01Data == nil {
			t.Fatal("expected create result to be a map")
		}
		if shortUrlRef01Data["id"] == nil {
			t.Fatal("expected created entity to have an id")
		}

		// LIST
		shortUrlRef01Match := map[string]any{}

		shortUrlRef01ListResult, err := shortUrlRef01Ent.List(shortUrlRef01Match, nil)
		if err != nil {
			t.Fatalf("list failed: %v", err)
		}
		shortUrlRef01List, shortUrlRef01ListOk := shortUrlRef01ListResult.([]any)
		if !shortUrlRef01ListOk {
			t.Fatalf("expected list result to be an array, got %T", shortUrlRef01ListResult)
		}

		foundItem := vs.Select(entityListToData(shortUrlRef01List), map[string]any{"id": shortUrlRef01Data["id"]})
		if vs.IsEmpty(foundItem) {
			t.Fatal("expected to find created entity in list")
		}

		// UPDATE
		shortUrlRef01DataUp0Up := map[string]any{
			"id": shortUrlRef01Data["id"],
		}

		shortUrlRef01MarkdefUp0Name := "description"
		shortUrlRef01MarkdefUp0Value := fmt.Sprintf("Mark01-short_url_ref01_%d", setup.now)
		shortUrlRef01DataUp0Up[shortUrlRef01MarkdefUp0Name] = shortUrlRef01MarkdefUp0Value

		shortUrlRef01ResdataUp0Result, err := shortUrlRef01Ent.Update(shortUrlRef01DataUp0Up, nil)
		if err != nil {
			t.Fatalf("update failed: %v", err)
		}
		shortUrlRef01ResdataUp0 := core.ToMapAny(entityData(shortUrlRef01ResdataUp0Result))
		if shortUrlRef01ResdataUp0 == nil {
			t.Fatal("expected update result to be a map")
		}
		if shortUrlRef01ResdataUp0["id"] != shortUrlRef01DataUp0Up["id"] {
			t.Fatal("expected update result id to match")
		}
		if shortUrlRef01ResdataUp0[shortUrlRef01MarkdefUp0Name] != shortUrlRef01MarkdefUp0Value {
			t.Fatalf("expected %s to be updated, got %v", shortUrlRef01MarkdefUp0Name, shortUrlRef01ResdataUp0[shortUrlRef01MarkdefUp0Name])
		}

		// LOAD
		shortUrlRef01MatchDt0 := map[string]any{
			"id": shortUrlRef01Data["id"],
		}
		shortUrlRef01DataDt0Loaded, err := shortUrlRef01Ent.Load(shortUrlRef01MatchDt0, nil)
		if err != nil {
			t.Fatalf("load failed: %v", err)
		}
		shortUrlRef01DataDt0LoadResult := core.ToMapAny(entityData(shortUrlRef01DataDt0Loaded))
		if shortUrlRef01DataDt0LoadResult == nil {
			t.Fatal("expected load result to be a map")
		}
		if shortUrlRef01DataDt0LoadResult["id"] != shortUrlRef01Data["id"] {
			t.Fatal("expected load result id to match")
		}

		// REMOVE
		shortUrlRef01MatchRm0 := map[string]any{
			"id": shortUrlRef01Data["id"],
		}
		_, err = shortUrlRef01Ent.Remove(shortUrlRef01MatchRm0, nil)
		if err != nil {
			t.Fatalf("remove failed: %v", err)
		}

		// LIST
		shortUrlRef01MatchRt0 := map[string]any{}

		shortUrlRef01ListRt0Result, err := shortUrlRef01Ent.List(shortUrlRef01MatchRt0, nil)
		if err != nil {
			t.Fatalf("list failed: %v", err)
		}
		shortUrlRef01ListRt0, shortUrlRef01ListRt0Ok := shortUrlRef01ListRt0Result.([]any)
		if !shortUrlRef01ListRt0Ok {
			t.Fatalf("expected list result to be an array, got %T", shortUrlRef01ListRt0Result)
		}

		notFoundItem := vs.Select(entityListToData(shortUrlRef01ListRt0), map[string]any{"id": shortUrlRef01Data["id"]})
		if !vs.IsEmpty(notFoundItem) {
			t.Fatal("expected removed entity to not be in list")
		}

	})
}

func short_urlBasicSetup(extra map[string]any) *entityTestSetup {
	loadEnvLocal()

	_, filename, _, _ := runtime.Caller(0)
	dir := filepath.Dir(filename)

	entityDataFile := filepath.Join(dir, "..", "..", ".sdk", "test", "entity", "short_url", "ShortUrlTestData.json")

	entityDataSource, err := os.ReadFile(entityDataFile)
	if err != nil {
		panic("failed to read short_url test data: " + err.Error())
	}

	var entityData map[string]any
	if err := json.Unmarshal(entityDataSource, &entityData); err != nil {
		panic("failed to parse short_url test data: " + err.Error())
	}

	options := map[string]any{}
	options["entity"] = entityData["existing"]

	client := sdk.TestSDK(options, extra)

	// Generate idmap via transform, matching TS pattern.
	idmap, _ := vs.Transform(
		[]any{"short_url01", "short_url02", "short_url03"},
		map[string]any{
			"`$PACK`": []any{"", map[string]any{
				"`$KEY`": "`$COPY`",
				"`$VAL`": []any{"`$FORMAT`", "upper", "`$COPY`"},
			}},
		},
	)

	// Whether *_ENTID supplied the idmap, read before envOverride consumes it:
	// without it, the ids a live flow binds are the fixture's synthetic ones.
	entidEnvRaw := os.Getenv("SMSAPI_TEST_SHORT_URL_ENTID")
	idmapOverridden := entidEnvRaw != "" && strings.HasPrefix(strings.TrimSpace(entidEnvRaw), "{")

	env := envOverride(map[string]any{
		"SMSAPI_TEST_SHORT_URL_ENTID": idmap,
		"SMSAPI_TEST_LIVE":      "FALSE",
		"SMSAPI_TEST_EXPLAIN":   "FALSE",
		"SMSAPI_APIKEY":         "",
	})

	idmapResolved := core.ToMapAny(env["SMSAPI_TEST_SHORT_URL_ENTID"])
	if idmapResolved == nil {
		idmapResolved = core.ToMapAny(idmap)
	}

	if env["SMSAPI_TEST_LIVE"] == "TRUE" {
		// An empty map, not a nil one: Merge returns nil when its last entry
		// is nil, and BasicSetup is normally called with no extras - so a
		// bare nil silently discarded the apikey and server values below.
		extraOpts := extra
		if extraOpts == nil {
			extraOpts = map[string]any{}
		}

		mergedOpts := vs.Merge([]any{
			// liveClientOptions() FIRST, so the generated fields below win:
			// sdk-test-control.json's test.client.options adds to the live
			// client, it does not redirect it.
			liveClientOptions(),
			map[string]any{
				"apikey": env["SMSAPI_APIKEY"],
			},
			extraOpts,
		})
		client = sdk.NewSmsapiSDK(core.ToMapAny(mergedOpts))
	}

	live := env["SMSAPI_TEST_LIVE"] == "TRUE"
	return &entityTestSetup{
		client:        client,
		data:          entityData,
		idmap:         idmapResolved,
		env:           env,
		explain:       env["SMSAPI_TEST_EXPLAIN"] == "TRUE",
		live:          live,
		syntheticOnly: live && !idmapOverridden,
		now:           time.Now().UnixMilli(),
	}
}
