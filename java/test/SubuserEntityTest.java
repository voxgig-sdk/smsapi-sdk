package voxgig.smsapisdk.sdktest;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.junit.jupiter.api.Assumptions;
import org.junit.jupiter.api.Test;

import voxgig.smsapisdk.core.Helpers;
import voxgig.smsapisdk.core.SdkEntity;
import voxgig.smsapisdk.core.SmsapiSDK;
import voxgig.smsapisdk.utility.Json;
import voxgig.smsapisdk.utility.struct.Struct;

@SuppressWarnings({"unchecked", "unused"})
public class SubuserEntityTest {

  @Test
  public void instance() {
    SmsapiSDK testsdk = SmsapiSDK.testSDK();
    SdkEntity ent = testsdk.subuser(null);
    assertNotNull(ent, "expected non-null subuser entity");
  }

  @Test
  public void basic() {
    RunnerSupport.EntityTestSetup setup = subuserBasicSetup(null);
    // Per-op sdk-test-control.json skip — basic test exercises a flow
    // with multiple ops; skipping any op skips the whole flow.
    String mode = setup.live ? "live" : "unit";
    for (String op : new String[] { "create", "list", "update", "load", "remove" }) {
      String reason = RunnerSupport.skipReason("entityOp", "subuser." + op, mode);
      Assumptions.assumeTrue(reason == null,
          reason == null || "".equals(reason)
              ? "skipped via sdk-test-control.json" : reason);
    }
    // The basic flow consumes synthetic IDs from the fixture. In live mode
    // without an *_ENTID env override, those IDs hit the live API and 4xx.
    Assumptions.assumeFalse(setup.syntheticOnly,
        "live entity test uses synthetic IDs from fixture — set SMSAPI_TEST_SUBUSER_ENTID JSON to run live");
    SmsapiSDK client = setup.client;

    // CREATE
    SdkEntity subuserRef01Ent = client.subuser(null);
    Map<String, Object> subuserRef01Data = Helpers.toMapAny(Struct.getprop(
        Struct.getpath(setup.data, "new.subuser"), "subuser_ref01"));

    Object subuserRef01DataResult = subuserRef01Ent.create(subuserRef01Data, null);
    subuserRef01Data = Helpers.toMapAny(subuserRef01DataResult instanceof SdkEntity ? ((SdkEntity) subuserRef01DataResult).data() : subuserRef01DataResult);
    assertNotNull(subuserRef01Data, "expected create result to be a map");
    assertNotNull(subuserRef01Data.get("id"), "expected created entity to have an id");

    // LIST
    Map<String, Object> subuserRef01Match = new LinkedHashMap<>();

    Object subuserRef01ListResult = subuserRef01Ent.list(subuserRef01Match, null);
    assertTrue(subuserRef01ListResult instanceof List,
        "expected list result to be an array, got " + subuserRef01ListResult);
    List<Object> subuserRef01List = (List<Object>) subuserRef01ListResult;

    List<Object> foundItem = Struct.select(
        RunnerSupport.entityListToData(subuserRef01List),
        Struct.jm("id", subuserRef01Data.get("id")));
    assertFalse(Struct.isempty(foundItem), "expected to find created entity in list");

    // UPDATE
    Map<String, Object> subuserRef01DataUp0Up = new LinkedHashMap<>();
    subuserRef01DataUp0Up.put("id", subuserRef01Data.get("id"));

    String subuserRef01MarkdefUp0Name = "description";
    String subuserRef01MarkdefUp0Value = "Mark01-subuser_ref01_" + setup.now;
    subuserRef01DataUp0Up.put(subuserRef01MarkdefUp0Name, subuserRef01MarkdefUp0Value);

    Object subuserRef01ResdataUp0Result = subuserRef01Ent.update(subuserRef01DataUp0Up, null);
    Map<String, Object> subuserRef01ResdataUp0 = Helpers.toMapAny(subuserRef01ResdataUp0Result instanceof SdkEntity ? ((SdkEntity) subuserRef01ResdataUp0Result).data() : subuserRef01ResdataUp0Result);
    assertNotNull(subuserRef01ResdataUp0, "expected update result to be a map");
    assertEquals(subuserRef01DataUp0Up.get("id"), subuserRef01ResdataUp0.get("id"),
        "expected update result id to match");
    assertEquals(subuserRef01MarkdefUp0Value, subuserRef01ResdataUp0.get(subuserRef01MarkdefUp0Name),
        "expected " + subuserRef01MarkdefUp0Name + " to be updated");

    // LOAD
    Map<String, Object> subuserRef01MatchDt0 = new LinkedHashMap<>();
    subuserRef01MatchDt0.put("id", subuserRef01Data.get("id"));
    Object subuserRef01DataDt0Loaded = subuserRef01Ent.load(subuserRef01MatchDt0, null);
    Map<String, Object> subuserRef01DataDt0LoadResult = Helpers.toMapAny(subuserRef01DataDt0Loaded instanceof SdkEntity ? ((SdkEntity) subuserRef01DataDt0Loaded).data() : subuserRef01DataDt0Loaded);
    assertNotNull(subuserRef01DataDt0LoadResult, "expected load result to be a map");
    assertEquals(subuserRef01Data.get("id"), subuserRef01DataDt0LoadResult.get("id"),
        "expected load result id to match");

    // REMOVE
    Map<String, Object> subuserRef01MatchRm0 = new LinkedHashMap<>();
    subuserRef01MatchRm0.put("id", subuserRef01Data.get("id"));
    subuserRef01Ent.remove(subuserRef01MatchRm0, null);

    // LIST
    Map<String, Object> subuserRef01MatchRt0 = new LinkedHashMap<>();

    Object subuserRef01ListRt0Result = subuserRef01Ent.list(subuserRef01MatchRt0, null);
    assertTrue(subuserRef01ListRt0Result instanceof List,
        "expected list result to be an array, got " + subuserRef01ListRt0Result);
    List<Object> subuserRef01ListRt0 = (List<Object>) subuserRef01ListRt0Result;

    List<Object> notFoundItem = Struct.select(
        RunnerSupport.entityListToData(subuserRef01ListRt0),
        Struct.jm("id", subuserRef01Data.get("id")));
    assertTrue(Struct.isempty(notFoundItem), "expected removed entity to not be in list");

  }

  @Test
  public void stream() {
    Map<String, Object> streamingActive = new LinkedHashMap<>();
    Map<String, Object> streamingOpts = new LinkedHashMap<>();
    streamingOpts.put("active", true);
    Map<String, Object> featureOpts = new LinkedHashMap<>();
    featureOpts.put("streaming", streamingOpts);
    streamingActive.put("feature", featureOpts);

    RunnerSupport.EntityTestSetup setup = subuserBasicSetup(streamingActive);
    Assumptions.assumeFalse(setup.live,
        "stream test streams the seeded fixture data (unit mode only)");

    SdkEntity ent = setup.client.subuser(null);
    Map<String, Object> match = new LinkedHashMap<>();

    // Materialised list result for the same op.
    Object listedResult = ent.list(match, null);
    List<Object> listed = listedResult instanceof List
        ? (List<Object>) listedResult : new ArrayList<>();

    // stream("list") yields items via the streaming feature's iterator.
    List<Object> streamed = ent.stream("list", match, null)
        .collect(Collectors.toList());
    assertTrue(streamed.size() > 0, "expected stream to yield items");
    assertEquals(listed.size(), streamed.size(),
        "expected stream to yield the same item count as list");

    // Fallback: with streaming inactive, stream still yields the
    // materialised items.
    RunnerSupport.EntityTestSetup setup2 = subuserBasicSetup(null);
    SdkEntity ent2 = setup2.client.subuser(null);
    List<Object> streamed2 = ent2.stream("list", match, null)
        .collect(Collectors.toList());
    assertEquals(listed.size(), streamed2.size(),
        "expected fallback stream to yield the materialised items");
  }

  static RunnerSupport.EntityTestSetup subuserBasicSetup(Map<String, Object> extra) {
    RunnerSupport.loadEnvLocal();

    Map<String, Object> entityData;
    try {
      String entityDataSource = Files.readString(Path.of(
          "..", ".sdk", "test", "entity", "subuser", "SubuserTestData.json"));
      entityData = Helpers.toMapAny(Json.parse(entityDataSource));
    }
    catch (Exception e) {
      throw new AssertionError("failed to read subuser test data: " + e.getMessage(), e);
    }

    Map<String, Object> options = new LinkedHashMap<>();
    options.put("entity", entityData.get("existing"));

    SmsapiSDK client = SmsapiSDK.testSDK(options, extra);

    // Generate idmap via transform, matching TS pattern.
    List<Object> idnames = new ArrayList<>();
    idnames.add("subuser01");
    idnames.add("subuser02");
    idnames.add("subuser03");
    Object idmap = Struct.transform(idnames, Json.parse(
        "{\"`$PACK`\": [\"\", {"
        + "\"`$KEY`\": \"`$COPY`\","
        + "\"`$VAL`\": [\"`$FORMAT`\", \"upper\", \"`$COPY`\"]"
        + "}]}"));

    // Detect ENTID env override before envOverride consumes it. When live
    // mode is on without a real override, the basic test runs against
    // synthetic IDs from the fixture and 4xx's. Surface this so the test
    // can skip.
    String entidEnvRaw = RunnerSupport.getenv("SMSAPI_TEST_SUBUSER_ENTID");
    boolean idmapOverridden = entidEnvRaw != null
        && entidEnvRaw.trim().startsWith("{");

    Map<String, Object> envm = new LinkedHashMap<>();
    envm.put("SMSAPI_TEST_SUBUSER_ENTID", idmap);
    envm.put("SMSAPI_TEST_LIVE", "FALSE");
    envm.put("SMSAPI_TEST_EXPLAIN", "FALSE");
    envm.put("SMSAPI_APIKEY", "");
    Map<String, Object> env = RunnerSupport.envOverride(envm);

    Map<String, Object> idmapResolved = Helpers.toMapAny(env.get("SMSAPI_TEST_SUBUSER_ENTID"));
    if (idmapResolved == null) {
      idmapResolved = Helpers.toMapAny(idmap);
    }

    boolean live = "TRUE".equals(env.get("SMSAPI_TEST_LIVE"));
    if (live) {
      // sdk-test-control.json's test.client.options seeds the live
      // client; the generated fields below overwrite anything they name.
      Map<String, Object> liveOpts =
          new LinkedHashMap<>(RunnerSupport.liveClientOptions());
      liveOpts.put("apikey", env.get("SMSAPI_APIKEY"));
      // An empty map, not a null one: merge answers null when its last
      // entry is null, and basicSetup is normally called with no extras -
      // so a bare null silently discarded the apikey and server values
      // above.
      Map<String, Object> extraOpts =
          extra == null ? new LinkedHashMap<>() : extra;
      Object mergedOpts = Struct.merge(Struct.jt(liveOpts, extraOpts));
      client = new SmsapiSDK(Helpers.toMapAny(mergedOpts));
    }

    RunnerSupport.EntityTestSetup setup = new RunnerSupport.EntityTestSetup();
    setup.client = client;
    setup.data = entityData;
    setup.idmap = idmapResolved;
    setup.env = env;
    setup.explain = "TRUE".equals(env.get("SMSAPI_TEST_EXPLAIN"));
    setup.live = live;
    setup.syntheticOnly = live && !idmapOverridden;
    setup.now = System.currentTimeMillis();
    return setup;
  }
}
