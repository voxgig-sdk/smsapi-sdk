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

func TestContactsgroupEntity(t *testing.T) {
	t.Run("instance", func(t *testing.T) {
		testsdk := sdk.TestSDK(nil, nil)
		ent := testsdk.Contactsgroup(nil)
		if ent == nil {
			t.Fatal("expected non-nil ContactsgroupEntity")
		}
	})

	// Feature #4: the entity Stream(action, ...) method runs the op pipeline and
	// returns a channel over result items. With the streaming feature active it
	// yields the feature's incremental output; otherwise it falls back to the
	// materialised list so Stream always yields.
	t.Run("stream", func(t *testing.T) {
		seed := map[string]any{
			"entity": map[string]any{
				"contactsgroup": map[string]any{
					"s1": map[string]any{"id": "s1"},
					"s2": map[string]any{"id": "s2"},
					"s3": map[string]any{"id": "s3"},
				},
			},
		}

		// Fallback: streaming inactive -> yields the materialised list items.
		base := sdk.TestSDK(seed, nil)
		var seen []any
		for item := range base.Contactsgroup(nil).Stream("list", nil, nil) {
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
			for item := range streamSdk.Contactsgroup(nil).Stream("list", nil, nil) {
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
		setup := contactsgroupBasicSetup(nil)
		// Per-op sdk-test-control.json skip — basic test exercises a flow
		// with multiple ops; skipping any op skips the whole flow.
		_mode := "unit"
		if setup.live {
			_mode = "live"
		}
		for _, _op := range []string{"create", "list", "update", "remove"} {
			if _shouldSkip, _reason := isControlSkipped("entityOp", "contactsgroup." + _op, _mode); _shouldSkip {
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
			t.Skip("live entity test uses synthetic IDs from fixture — set SMSAPI_TEST_CONTACTSGROUP_ENTID JSON to run live")
			return
		}
		client := setup.client

		// CREATE
		contactsgroupRef01Ent := client.Contactsgroup(nil)
		contactsgroupRef01Data := core.ToMapAny(vs.GetProp(
			vs.GetPath(setup.data, []any{"new", "contactsgroup"}), "contactsgroup_ref01"))
		contactsgroupRef01Data["group_id"] = setup.idmap["group01"]

		contactsgroupRef01DataResult, err := contactsgroupRef01Ent.Create(contactsgroupRef01Data, nil)
		if err != nil {
			t.Fatalf("create failed: %v", err)
		}
		contactsgroupRef01Data = core.ToMapAny(entityData(contactsgroupRef01DataResult))
		if contactsgroupRef01Data == nil {
			t.Fatal("expected create result to be a map")
		}
		if contactsgroupRef01Data["id"] == nil {
			t.Fatal("expected created entity to have an id")
		}

		// LIST
		contactsgroupRef01Match := map[string]any{
			"group_id": setup.idmap["group01"],
		}

		contactsgroupRef01ListResult, err := contactsgroupRef01Ent.List(contactsgroupRef01Match, nil)
		if err != nil {
			t.Fatalf("list failed: %v", err)
		}
		contactsgroupRef01List, contactsgroupRef01ListOk := contactsgroupRef01ListResult.([]any)
		if !contactsgroupRef01ListOk {
			t.Fatalf("expected list result to be an array, got %T", contactsgroupRef01ListResult)
		}

		foundItem := vs.Select(entityListToData(contactsgroupRef01List), map[string]any{"id": contactsgroupRef01Data["id"]})
		if vs.IsEmpty(foundItem) {
			t.Fatal("expected to find created entity in list")
		}

		// UPDATE
		contactsgroupRef01DataUp0Up := map[string]any{
			"id": contactsgroupRef01Data["id"],
		}

		contactsgroupRef01MarkdefUp0Name := "birthday_date"
		contactsgroupRef01MarkdefUp0Value := fmt.Sprintf("Mark01-contactsgroup_ref01_%d", setup.now)
		contactsgroupRef01DataUp0Up[contactsgroupRef01MarkdefUp0Name] = contactsgroupRef01MarkdefUp0Value

		contactsgroupRef01ResdataUp0Result, err := contactsgroupRef01Ent.Update(contactsgroupRef01DataUp0Up, nil)
		if err != nil {
			t.Fatalf("update failed: %v", err)
		}
		contactsgroupRef01ResdataUp0 := core.ToMapAny(entityData(contactsgroupRef01ResdataUp0Result))
		if contactsgroupRef01ResdataUp0 == nil {
			t.Fatal("expected update result to be a map")
		}
		if contactsgroupRef01ResdataUp0["id"] != contactsgroupRef01DataUp0Up["id"] {
			t.Fatal("expected update result id to match")
		}
		if contactsgroupRef01ResdataUp0[contactsgroupRef01MarkdefUp0Name] != contactsgroupRef01MarkdefUp0Value {
			t.Fatalf("expected %s to be updated, got %v", contactsgroupRef01MarkdefUp0Name, contactsgroupRef01ResdataUp0[contactsgroupRef01MarkdefUp0Name])
		}

		// REMOVE
		contactsgroupRef01MatchRm0 := map[string]any{
			"id": contactsgroupRef01Data["id"],
		}
		_, err = contactsgroupRef01Ent.Remove(contactsgroupRef01MatchRm0, nil)
		if err != nil {
			t.Fatalf("remove failed: %v", err)
		}

		// LIST
		contactsgroupRef01MatchRt0 := map[string]any{
			"group_id": setup.idmap["group01"],
		}

		contactsgroupRef01ListRt0Result, err := contactsgroupRef01Ent.List(contactsgroupRef01MatchRt0, nil)
		if err != nil {
			t.Fatalf("list failed: %v", err)
		}
		contactsgroupRef01ListRt0, contactsgroupRef01ListRt0Ok := contactsgroupRef01ListRt0Result.([]any)
		if !contactsgroupRef01ListRt0Ok {
			t.Fatalf("expected list result to be an array, got %T", contactsgroupRef01ListRt0Result)
		}

		notFoundItem := vs.Select(entityListToData(contactsgroupRef01ListRt0), map[string]any{"id": contactsgroupRef01Data["id"]})
		if !vs.IsEmpty(notFoundItem) {
			t.Fatal("expected removed entity to not be in list")
		}

	})
}

func contactsgroupBasicSetup(extra map[string]any) *entityTestSetup {
	loadEnvLocal()

	_, filename, _, _ := runtime.Caller(0)
	dir := filepath.Dir(filename)

	entityDataFile := filepath.Join(dir, "..", "..", ".sdk", "test", "entity", "contactsgroup", "ContactsgroupTestData.json")

	entityDataSource, err := os.ReadFile(entityDataFile)
	if err != nil {
		panic("failed to read contactsgroup test data: " + err.Error())
	}

	var entityData map[string]any
	if err := json.Unmarshal(entityDataSource, &entityData); err != nil {
		panic("failed to parse contactsgroup test data: " + err.Error())
	}

	options := map[string]any{}
	options["entity"] = entityData["existing"]

	client := sdk.TestSDK(options, extra)

	// Generate idmap via transform, matching TS pattern.
	idmap, _ := vs.Transform(
		[]any{"contactsgroup01", "contactsgroup02", "contactsgroup03", "group01", "group02", "group03", "permission01", "permission02", "permission03"},
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
	entidEnvRaw := os.Getenv("SMSAPI_TEST_CONTACTSGROUP_ENTID")
	idmapOverridden := entidEnvRaw != "" && strings.HasPrefix(strings.TrimSpace(entidEnvRaw), "{")

	env := envOverride(map[string]any{
		"SMSAPI_TEST_CONTACTSGROUP_ENTID": idmap,
		"SMSAPI_TEST_LIVE":      "FALSE",
		"SMSAPI_TEST_EXPLAIN":   "FALSE",
		"SMSAPI_APIKEY":         "",
	})

	idmapResolved := core.ToMapAny(env["SMSAPI_TEST_CONTACTSGROUP_ENTID"])
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
