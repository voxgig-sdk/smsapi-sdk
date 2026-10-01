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

func TestCallbackEntity(t *testing.T) {
	t.Run("instance", func(t *testing.T) {
		testsdk := sdk.TestSDK(nil, nil)
		ent := testsdk.Callback(nil)
		if ent == nil {
			t.Fatal("expected non-nil CallbackEntity")
		}
	})

	// Feature #4: the entity Stream(action, ...) method runs the op pipeline and
	// returns a channel over result items. With the streaming feature active it
	// yields the feature's incremental output; otherwise it falls back to the
	// materialised list so Stream always yields.
	t.Run("stream", func(t *testing.T) {
		seed := map[string]any{
			"entity": map[string]any{
				"callback": map[string]any{
					"s1": map[string]any{"id": "s1"},
					"s2": map[string]any{"id": "s2"},
					"s3": map[string]any{"id": "s3"},
				},
			},
		}

		// Fallback: streaming inactive -> yields the materialised list items.
		base := sdk.TestSDK(seed, nil)
		var seen []any
		for item := range base.Callback(nil).Stream("list", nil, nil) {
			seen = append(seen, item)
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
			for item := range streamSdk.Callback(nil).Stream("list", nil, nil) {
				if sub, ok := item.([]any); ok {
					got = append(got, sub...)
				} else {
					got = append(got, item)
				}
			}
			if len(got) != 3 {
				t.Fatalf("expected 3 items via streaming feature, got %d", len(got))
			}
		}
	})

	t.Run("basic", func(t *testing.T) {
		setup := callbackBasicSetup(nil)
		// Per-op sdk-test-control.json skip — basic test exercises a flow
		// with multiple ops; skipping any op skips the whole flow.
		_mode := "unit"
		if setup.live {
			_mode = "live"
		}
		for _, _op := range []string{"create", "list", "update", "load", "remove"} {
			if _shouldSkip, _reason := isControlSkipped("entityOp", "callback." + _op, _mode); _shouldSkip {
				if _reason == "" {
					_reason = "skipped via sdk-test-control.json"
				}
				t.Skip(_reason)
				return
			}
		}
		// The basic flow consumes synthetic IDs from the fixture. In live mode
		// without an *_ENTID env override, those IDs hit the live API and 4xx.
		if setup.syntheticOnly {
			t.Skip("live entity test uses synthetic IDs from fixture — set SMSAPI_TEST_CALLBACK_ENTID JSON to run live")
			return
		}
		client := setup.client

		// CREATE
		callbackRef01Ent := client.Callback(nil)
		callbackRef01Data := core.ToMapAny(vs.GetProp(
			vs.GetPath(setup.data, []any{"new", "callback"}), "callback_ref01"))

		callbackRef01DataResult, err := callbackRef01Ent.Create(callbackRef01Data, nil)
		if err != nil {
			t.Fatalf("create failed: %v", err)
		}
		callbackRef01Data = core.ToMapAny(entityData(callbackRef01DataResult))
		if callbackRef01Data == nil {
			t.Fatal("expected create result to be a map")
		}
		if callbackRef01Data["id"] == nil {
			t.Fatal("expected created entity to have an id")
		}

		// LIST
		callbackRef01Match := map[string]any{}

		callbackRef01ListResult, err := callbackRef01Ent.List(callbackRef01Match, nil)
		if err != nil {
			t.Fatalf("list failed: %v", err)
		}
		callbackRef01List, callbackRef01ListOk := callbackRef01ListResult.([]any)
		if !callbackRef01ListOk {
			t.Fatalf("expected list result to be an array, got %T", callbackRef01ListResult)
		}

		foundItem := vs.Select(entityListToData(callbackRef01List), map[string]any{"id": callbackRef01Data["id"]})
		if vs.IsEmpty(foundItem) {
			t.Fatal("expected to find created entity in list")
		}

		// UPDATE
		callbackRef01DataUp0Up := map[string]any{
			"id": callbackRef01Data["id"],
		}

		callbackRef01MarkdefUp0Name := "receiver_type"
		callbackRef01MarkdefUp0Value := fmt.Sprintf("Mark01-callback_ref01_%d", setup.now)
		callbackRef01DataUp0Up[callbackRef01MarkdefUp0Name] = callbackRef01MarkdefUp0Value

		callbackRef01ResdataUp0Result, err := callbackRef01Ent.Update(callbackRef01DataUp0Up, nil)
		if err != nil {
			t.Fatalf("update failed: %v", err)
		}
		callbackRef01ResdataUp0 := core.ToMapAny(entityData(callbackRef01ResdataUp0Result))
		if callbackRef01ResdataUp0 == nil {
			t.Fatal("expected update result to be a map")
		}
		if callbackRef01ResdataUp0["id"] != callbackRef01DataUp0Up["id"] {
			t.Fatal("expected update result id to match")
		}
		if callbackRef01ResdataUp0[callbackRef01MarkdefUp0Name] != callbackRef01MarkdefUp0Value {
			t.Fatalf("expected %s to be updated, got %v", callbackRef01MarkdefUp0Name, callbackRef01ResdataUp0[callbackRef01MarkdefUp0Name])
		}

		// LOAD
		callbackRef01MatchDt0 := map[string]any{
			"id": callbackRef01Data["id"],
		}
		callbackRef01DataDt0Loaded, err := callbackRef01Ent.Load(callbackRef01MatchDt0, nil)
		if err != nil {
			t.Fatalf("load failed: %v", err)
		}
		callbackRef01DataDt0LoadResult := core.ToMapAny(entityData(callbackRef01DataDt0Loaded))
		if callbackRef01DataDt0LoadResult == nil {
			t.Fatal("expected load result to be a map")
		}
		if callbackRef01DataDt0LoadResult["id"] != callbackRef01Data["id"] {
			t.Fatal("expected load result id to match")
		}

		// REMOVE
		callbackRef01MatchRm0 := map[string]any{
			"id": callbackRef01Data["id"],
		}
		_, err = callbackRef01Ent.Remove(callbackRef01MatchRm0, nil)
		if err != nil {
			t.Fatalf("remove failed: %v", err)
		}

		// LIST
		callbackRef01MatchRt0 := map[string]any{}

		callbackRef01ListRt0Result, err := callbackRef01Ent.List(callbackRef01MatchRt0, nil)
		if err != nil {
			t.Fatalf("list failed: %v", err)
		}
		callbackRef01ListRt0, callbackRef01ListRt0Ok := callbackRef01ListRt0Result.([]any)
		if !callbackRef01ListRt0Ok {
			t.Fatalf("expected list result to be an array, got %T", callbackRef01ListRt0Result)
		}

		notFoundItem := vs.Select(entityListToData(callbackRef01ListRt0), map[string]any{"id": callbackRef01Data["id"]})
		if !vs.IsEmpty(notFoundItem) {
			t.Fatal("expected removed entity to not be in list")
		}

	})
}

func callbackBasicSetup(extra map[string]any) *entityTestSetup {
	loadEnvLocal()

	_, filename, _, _ := runtime.Caller(0)
	dir := filepath.Dir(filename)

	entityDataFile := filepath.Join(dir, "..", "..", ".sdk", "test", "entity", "callback", "CallbackTestData.json")

	entityDataSource, err := os.ReadFile(entityDataFile)
	if err != nil {
		panic("failed to read callback test data: " + err.Error())
	}

	var entityData map[string]any
	if err := json.Unmarshal(entityDataSource, &entityData); err != nil {
		panic("failed to parse callback test data: " + err.Error())
	}

	options := map[string]any{}
	options["entity"] = entityData["existing"]

	client := sdk.TestSDK(options, extra)

	// Generate idmap via transform, matching TS pattern.
	idmap, _ := vs.Transform(
		[]any{"callback01", "callback02", "callback03"},
		map[string]any{
			"`$PACK`": []any{"", map[string]any{
				"`$KEY`": "`$COPY`",
				"`$VAL`": []any{"`$FORMAT`", "upper", "`$COPY`"},
			}},
		},
	)

	// Detect ENTID env override before envOverride consumes it. When live
	// mode is on without a real override, the basic test runs against synthetic
	// IDs from the fixture and 4xx's. Surface this so the test can skip.
	entidEnvRaw := os.Getenv("SMSAPI_TEST_CALLBACK_ENTID")
	idmapOverridden := entidEnvRaw != "" && strings.HasPrefix(strings.TrimSpace(entidEnvRaw), "{")

	env := envOverride(map[string]any{
		"SMSAPI_TEST_CALLBACK_ENTID": idmap,
		"SMSAPI_TEST_LIVE":      "FALSE",
		"SMSAPI_TEST_EXPLAIN":   "FALSE",
		"SMSAPI_APIKEY":         "",
	})

	idmapResolved := core.ToMapAny(env["SMSAPI_TEST_CALLBACK_ENTID"])
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
