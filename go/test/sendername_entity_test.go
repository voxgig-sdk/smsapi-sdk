package sdktest

import (
	"encoding/json"
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

func TestSendernameEntity(t *testing.T) {
	t.Run("instance", func(t *testing.T) {
		testsdk := sdk.TestSDK(nil, nil)
		ent := testsdk.Sendername(nil)
		if ent == nil {
			t.Fatal("expected non-nil SendernameEntity")
		}
	})

	// Feature #4: the entity Stream(action, ...) method runs the op pipeline and
	// returns a channel over result items. With the streaming feature active it
	// yields the feature's incremental output; otherwise it falls back to the
	// materialised list so Stream always yields.
	t.Run("stream", func(t *testing.T) {
		seed := map[string]any{
			"entity": map[string]any{
				"sendername": map[string]any{
					"s1": map[string]any{"id": "s1"},
					"s2": map[string]any{"id": "s2"},
					"s3": map[string]any{"id": "s3"},
				},
			},
		}

		// Fallback: streaming inactive -> yields the materialised list items.
		base := sdk.TestSDK(seed, nil)
		var seen []any
		for item := range base.Sendername(nil).Stream("list", nil, nil) {
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
			for item := range streamSdk.Sendername(nil).Stream("list", nil, nil) {
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
		setup := sendernameBasicSetup(nil)
		// Per-op sdk-test-control.json skip — basic test exercises a flow
		// with multiple ops; skipping any op skips the whole flow.
		_mode := "unit"
		if setup.live {
			_mode = "live"
		}
		for _, _op := range []string{"create", "list", "load"} {
			if _shouldSkip, _reason := isControlSkipped("entityOp", "sendername." + _op, _mode); _shouldSkip {
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
			t.Skip("live entity test uses synthetic IDs from fixture — set SMSAPI_TEST_SENDERNAME_ENTID JSON to run live")
			return
		}
		client := setup.client

		// CREATE
		sendernameRef01Ent := client.Sendername(nil)
		sendernameRef01Data := core.ToMapAny(vs.GetProp(
			vs.GetPath(setup.data, []any{"new", "sendername"}), "sendername_ref01"))

		sendernameRef01DataResult, err := sendernameRef01Ent.Create(sendernameRef01Data, nil)
		if err != nil {
			t.Fatalf("create failed: %v", err)
		}
		sendernameRef01Data = core.ToMapAny(entityData(sendernameRef01DataResult))
		if sendernameRef01Data == nil {
			t.Fatal("expected create result to be a map")
		}
		if sendernameRef01Data["id"] == nil {
			t.Fatal("expected created entity to have an id")
		}

		// LIST
		sendernameRef01Match := map[string]any{}

		sendernameRef01ListResult, err := sendernameRef01Ent.List(sendernameRef01Match, nil)
		if err != nil {
			t.Fatalf("list failed: %v", err)
		}
		sendernameRef01List, sendernameRef01ListOk := sendernameRef01ListResult.([]any)
		if !sendernameRef01ListOk {
			t.Fatalf("expected list result to be an array, got %T", sendernameRef01ListResult)
		}

		foundItem := vs.Select(entityListToData(sendernameRef01List), map[string]any{"id": sendernameRef01Data["id"]})
		if vs.IsEmpty(foundItem) {
			t.Fatal("expected to find created entity in list")
		}

		// LOAD
		sendernameRef01MatchDt0 := map[string]any{
			"id": sendernameRef01Data["id"],
		}
		sendernameRef01DataDt0Loaded, err := sendernameRef01Ent.Load(sendernameRef01MatchDt0, nil)
		if err != nil {
			t.Fatalf("load failed: %v", err)
		}
		sendernameRef01DataDt0LoadResult := core.ToMapAny(entityData(sendernameRef01DataDt0Loaded))
		if sendernameRef01DataDt0LoadResult == nil {
			t.Fatal("expected load result to be a map")
		}
		if sendernameRef01DataDt0LoadResult["id"] != sendernameRef01Data["id"] {
			t.Fatal("expected load result id to match")
		}

	})
}

func sendernameBasicSetup(extra map[string]any) *entityTestSetup {
	loadEnvLocal()

	_, filename, _, _ := runtime.Caller(0)
	dir := filepath.Dir(filename)

	entityDataFile := filepath.Join(dir, "..", "..", ".sdk", "test", "entity", "sendername", "SendernameTestData.json")

	entityDataSource, err := os.ReadFile(entityDataFile)
	if err != nil {
		panic("failed to read sendername test data: " + err.Error())
	}

	var entityData map[string]any
	if err := json.Unmarshal(entityDataSource, &entityData); err != nil {
		panic("failed to parse sendername test data: " + err.Error())
	}

	options := map[string]any{}
	options["entity"] = entityData["existing"]

	client := sdk.TestSDK(options, extra)

	// Generate idmap via transform, matching TS pattern.
	idmap, _ := vs.Transform(
		[]any{"sendername01", "sendername02", "sendername03"},
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
	entidEnvRaw := os.Getenv("SMSAPI_TEST_SENDERNAME_ENTID")
	idmapOverridden := entidEnvRaw != "" && strings.HasPrefix(strings.TrimSpace(entidEnvRaw), "{")

	env := envOverride(map[string]any{
		"SMSAPI_TEST_SENDERNAME_ENTID": idmap,
		"SMSAPI_TEST_LIVE":      "FALSE",
		"SMSAPI_TEST_EXPLAIN":   "FALSE",
		"SMSAPI_APIKEY":         "",
	})

	idmapResolved := core.ToMapAny(env["SMSAPI_TEST_SENDERNAME_ENTID"])
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
