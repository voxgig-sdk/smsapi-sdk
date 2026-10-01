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

func TestGroupEntity(t *testing.T) {
	t.Run("instance", func(t *testing.T) {
		testsdk := sdk.TestSDK(nil, nil)
		ent := testsdk.Group(nil)
		if ent == nil {
			t.Fatal("expected non-nil GroupEntity")
		}
	})

	t.Run("basic", func(t *testing.T) {
		setup := groupBasicSetup(nil)
		// Per-op sdk-test-control.json skip — basic test exercises a flow
		// with multiple ops; skipping any op skips the whole flow.
		_mode := "unit"
		if setup.live {
			_mode = "live"
		}
		for _, _op := range []string{"update", "load"} {
			if _shouldSkip, _reason := isControlSkipped("entityOp", "group." + _op, _mode); _shouldSkip {
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
			t.Skip("live entity test uses synthetic IDs from fixture — set SMSAPI_TEST_GROUP_ENTID JSON to run live")
			return
		}
		client := setup.client

		// Bootstrap entity data from existing test data (no create step in flow).
		groupRef01DataRaw := vs.Items(core.ToMapAny(vs.GetPath(setup.data, "existing.group")))
		var groupRef01Data map[string]any
		if len(groupRef01DataRaw) > 0 {
			groupRef01Data = core.ToMapAny(groupRef01DataRaw[0][1])
		}
		// Discard guards against Go's unused-var check when the flow's steps
		// happen not to consume the bootstrap data (e.g. list-only flows).
		_ = groupRef01Data

		// UPDATE
		groupRef01Ent := client.Group(nil)
		groupRef01DataUp0Up := map[string]any{
			"id": groupRef01Data["id"],
		}

		groupRef01MarkdefUp0Name := "created_by"
		groupRef01MarkdefUp0Value := fmt.Sprintf("Mark01-group_ref01_%d", setup.now)
		groupRef01DataUp0Up[groupRef01MarkdefUp0Name] = groupRef01MarkdefUp0Value

		groupRef01ResdataUp0Result, err := groupRef01Ent.Update(groupRef01DataUp0Up, nil)
		if err != nil {
			t.Fatalf("update failed: %v", err)
		}
		groupRef01ResdataUp0 := core.ToMapAny(entityData(groupRef01ResdataUp0Result))
		if groupRef01ResdataUp0 == nil {
			t.Fatal("expected update result to be a map")
		}
		if groupRef01ResdataUp0["id"] != groupRef01DataUp0Up["id"] {
			t.Fatal("expected update result id to match")
		}
		if groupRef01ResdataUp0[groupRef01MarkdefUp0Name] != groupRef01MarkdefUp0Value {
			t.Fatalf("expected %s to be updated, got %v", groupRef01MarkdefUp0Name, groupRef01ResdataUp0[groupRef01MarkdefUp0Name])
		}

		// LOAD
		groupRef01MatchDt0 := map[string]any{
			"id": groupRef01Data["id"],
		}
		groupRef01DataDt0Loaded, err := groupRef01Ent.Load(groupRef01MatchDt0, nil)
		if err != nil {
			t.Fatalf("load failed: %v", err)
		}
		groupRef01DataDt0LoadResult := core.ToMapAny(entityData(groupRef01DataDt0Loaded))
		if groupRef01DataDt0LoadResult == nil {
			t.Fatal("expected load result to be a map")
		}
		if groupRef01DataDt0LoadResult["id"] != groupRef01Data["id"] {
			t.Fatal("expected load result id to match")
		}

	})
}

func groupBasicSetup(extra map[string]any) *entityTestSetup {
	loadEnvLocal()

	_, filename, _, _ := runtime.Caller(0)
	dir := filepath.Dir(filename)

	entityDataFile := filepath.Join(dir, "..", "..", ".sdk", "test", "entity", "group", "GroupTestData.json")

	entityDataSource, err := os.ReadFile(entityDataFile)
	if err != nil {
		panic("failed to read group test data: " + err.Error())
	}

	var entityData map[string]any
	if err := json.Unmarshal(entityDataSource, &entityData); err != nil {
		panic("failed to parse group test data: " + err.Error())
	}

	options := map[string]any{}
	options["entity"] = entityData["existing"]

	client := sdk.TestSDK(options, extra)

	// Generate idmap via transform, matching TS pattern.
	idmap, _ := vs.Transform(
		[]any{"group01", "group02", "group03"},
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
	entidEnvRaw := os.Getenv("SMSAPI_TEST_GROUP_ENTID")
	idmapOverridden := entidEnvRaw != "" && strings.HasPrefix(strings.TrimSpace(entidEnvRaw), "{")

	env := envOverride(map[string]any{
		"SMSAPI_TEST_GROUP_ENTID": idmap,
		"SMSAPI_TEST_LIVE":      "FALSE",
		"SMSAPI_TEST_EXPLAIN":   "FALSE",
		"SMSAPI_APIKEY":         "",
	})

	idmapResolved := core.ToMapAny(env["SMSAPI_TEST_GROUP_ENTID"])
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
