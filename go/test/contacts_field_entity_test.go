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

func TestContactsFieldEntity(t *testing.T) {
	t.Run("instance", func(t *testing.T) {
		testsdk := sdk.TestSDK(nil, nil)
		ent := testsdk.ContactsField(nil)
		if ent == nil {
			t.Fatal("expected non-nil ContactsFieldEntity")
		}
	})

	// Feature #4: the entity Stream(action, ...) method runs the op pipeline and
	// returns a channel over result items. With the streaming feature active it
	// yields the feature's incremental output; otherwise it falls back to the
	// materialised list so Stream always yields.
	t.Run("stream", func(t *testing.T) {
		seed := map[string]any{
			"entity": map[string]any{
				"contacts_field": map[string]any{
					"s1": map[string]any{"id": "s1"},
					"s2": map[string]any{"id": "s2"},
					"s3": map[string]any{"id": "s3"},
				},
			},
		}

		// Fallback: streaming inactive -> yields the materialised list items.
		base := sdk.TestSDK(seed, nil)
		var seen []any
		for item := range base.ContactsField(nil).Stream("list", nil, nil) {
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
			for item := range streamSdk.ContactsField(nil).Stream("list", nil, nil) {
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
		setup := contacts_fieldBasicSetup(nil)
		// Per-op sdk-test-control.json skip — basic test exercises a flow
		// with multiple ops; skipping any op skips the whole flow.
		_mode := "unit"
		if setup.live {
			_mode = "live"
		}
		for _, _op := range []string{"create", "list", "update", "remove"} {
			if _shouldSkip, _reason := isControlSkipped("entityOp", "contacts_field." + _op, _mode); _shouldSkip {
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
			t.Skip("live entity test uses synthetic IDs from fixture — set SMSAPI_TEST_CONTACTS_FIELD_ENTID JSON to run live")
			return
		}
		client := setup.client

		// CREATE
		contactsFieldRef01Ent := client.ContactsField(nil)
		contactsFieldRef01Data := core.ToMapAny(vs.GetProp(
			vs.GetPath(setup.data, []any{"new", "contacts_field"}), "contacts_field_ref01"))

		contactsFieldRef01DataResult, err := contactsFieldRef01Ent.Create(contactsFieldRef01Data, nil)
		if err != nil {
			t.Fatalf("create failed: %v", err)
		}
		contactsFieldRef01Data = core.ToMapAny(entityData(contactsFieldRef01DataResult))
		if contactsFieldRef01Data == nil {
			t.Fatal("expected create result to be a map")
		}
		if contactsFieldRef01Data["id"] == nil {
			t.Fatal("expected created entity to have an id")
		}

		// LIST
		contactsFieldRef01Match := map[string]any{}

		contactsFieldRef01ListResult, err := contactsFieldRef01Ent.List(contactsFieldRef01Match, nil)
		if err != nil {
			t.Fatalf("list failed: %v", err)
		}
		contactsFieldRef01List, contactsFieldRef01ListOk := contactsFieldRef01ListResult.([]any)
		if !contactsFieldRef01ListOk {
			t.Fatalf("expected list result to be an array, got %T", contactsFieldRef01ListResult)
		}

		foundItem := vs.Select(entityListToData(contactsFieldRef01List), map[string]any{"id": contactsFieldRef01Data["id"]})
		if vs.IsEmpty(foundItem) {
			t.Fatal("expected to find created entity in list")
		}

		// UPDATE
		contactsFieldRef01DataUp0Up := map[string]any{
			"id": contactsFieldRef01Data["id"],
		}

		contactsFieldRef01MarkdefUp0Name := "birthday_date"
		contactsFieldRef01MarkdefUp0Value := fmt.Sprintf("Mark01-contacts_field_ref01_%d", setup.now)
		contactsFieldRef01DataUp0Up[contactsFieldRef01MarkdefUp0Name] = contactsFieldRef01MarkdefUp0Value

		contactsFieldRef01ResdataUp0Result, err := contactsFieldRef01Ent.Update(contactsFieldRef01DataUp0Up, nil)
		if err != nil {
			t.Fatalf("update failed: %v", err)
		}
		contactsFieldRef01ResdataUp0 := core.ToMapAny(entityData(contactsFieldRef01ResdataUp0Result))
		if contactsFieldRef01ResdataUp0 == nil {
			t.Fatal("expected update result to be a map")
		}
		if contactsFieldRef01ResdataUp0["id"] != contactsFieldRef01DataUp0Up["id"] {
			t.Fatal("expected update result id to match")
		}
		if contactsFieldRef01ResdataUp0[contactsFieldRef01MarkdefUp0Name] != contactsFieldRef01MarkdefUp0Value {
			t.Fatalf("expected %s to be updated, got %v", contactsFieldRef01MarkdefUp0Name, contactsFieldRef01ResdataUp0[contactsFieldRef01MarkdefUp0Name])
		}

		// REMOVE
		contactsFieldRef01MatchRm0 := map[string]any{
			"id": contactsFieldRef01Data["id"],
		}
		_, err = contactsFieldRef01Ent.Remove(contactsFieldRef01MatchRm0, nil)
		if err != nil {
			t.Fatalf("remove failed: %v", err)
		}

		// LIST
		contactsFieldRef01MatchRt0 := map[string]any{}

		contactsFieldRef01ListRt0Result, err := contactsFieldRef01Ent.List(contactsFieldRef01MatchRt0, nil)
		if err != nil {
			t.Fatalf("list failed: %v", err)
		}
		contactsFieldRef01ListRt0, contactsFieldRef01ListRt0Ok := contactsFieldRef01ListRt0Result.([]any)
		if !contactsFieldRef01ListRt0Ok {
			t.Fatalf("expected list result to be an array, got %T", contactsFieldRef01ListRt0Result)
		}

		notFoundItem := vs.Select(entityListToData(contactsFieldRef01ListRt0), map[string]any{"id": contactsFieldRef01Data["id"]})
		if !vs.IsEmpty(notFoundItem) {
			t.Fatal("expected removed entity to not be in list")
		}

	})
}

func contacts_fieldBasicSetup(extra map[string]any) *entityTestSetup {
	loadEnvLocal()

	_, filename, _, _ := runtime.Caller(0)
	dir := filepath.Dir(filename)

	entityDataFile := filepath.Join(dir, "..", "..", ".sdk", "test", "entity", "contacts_field", "ContactsFieldTestData.json")

	entityDataSource, err := os.ReadFile(entityDataFile)
	if err != nil {
		panic("failed to read contacts_field test data: " + err.Error())
	}

	var entityData map[string]any
	if err := json.Unmarshal(entityDataSource, &entityData); err != nil {
		panic("failed to parse contacts_field test data: " + err.Error())
	}

	options := map[string]any{}
	options["entity"] = entityData["existing"]

	client := sdk.TestSDK(options, extra)

	// Generate idmap via transform, matching TS pattern.
	idmap, _ := vs.Transform(
		[]any{"contacts_field01", "contacts_field02", "contacts_field03"},
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
	entidEnvRaw := os.Getenv("SMSAPI_TEST_CONTACTS_FIELD_ENTID")
	idmapOverridden := entidEnvRaw != "" && strings.HasPrefix(strings.TrimSpace(entidEnvRaw), "{")

	env := envOverride(map[string]any{
		"SMSAPI_TEST_CONTACTS_FIELD_ENTID": idmap,
		"SMSAPI_TEST_LIVE":      "FALSE",
		"SMSAPI_TEST_EXPLAIN":   "FALSE",
		"SMSAPI_APIKEY":         "",
	})

	idmapResolved := core.ToMapAny(env["SMSAPI_TEST_CONTACTS_FIELD_ENTID"])
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
