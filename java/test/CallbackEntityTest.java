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
public class CallbackEntityTest {

  @Test
  public void instance() {
    SmsapiSDK testsdk = SmsapiSDK.testSDK();
    SdkEntity ent = testsdk.callback(null);
    assertNotNull(ent, "expected non-null callback entity");
  }

  @Test
  public void basic() {
    RunnerSupport.EntityTestSetup setup = callbackBasicSetup(null);
    // Per-op sdk-test-control.json skip — basic test exercises a flow
    // with multiple ops; skipping any op skips the whole flow.
    String mode = setup.live ? "live" : "unit";
    for (String op : new String[] { "create", "list", "update", "load", "remove" }) {
      String reason = RunnerSupport.skipReason("entityOp", "callback." + op, mode);
      Assumptions.assumeTrue(reason == null,
          reason == null || "".equals(reason)
              ? "skipped via sdk-test-control.json" : reason);
    }
    // The basic flow consumes synthetic IDs from the fixture. In live mode
    // without an *_ENTID env override, those IDs hit the live API and 4xx.
    Assumptions.assumeFalse(setup.syntheticOnly,
        "live entity test uses synthetic IDs from fixture — set SMSAPI_TEST_CALLBACK_ENTID JSON to run live");
    SmsapiSDK client = setup.client;

    // CREATE
    SdkEntity callbackRef01Ent = client.callback(null);
    Map<String, Object> callbackRef01Data = Helpers.toMapAny(Struct.getprop(
        Struct.getpath(setup.data, "new.callback"), "callback_ref01"));

    Object callbackRef01DataResult = callbackRef01Ent.create(callbackRef01Data, null);
    callbackRef01Data = Helpers.toMapAny(callbackRef01DataResult instanceof SdkEntity ? ((SdkEntity) callbackRef01DataResult).data() : callbackRef01DataResult);
    assertNotNull(callbackRef01Data, "expected create result to be a map");
    assertNotNull(callbackRef01Data.get("id"), "expected created entity to have an id");

    // LIST
    Map<String, Object> callbackRef01Match = new LinkedHashMap<>();

    Object callbackRef01ListResult = callbackRef01Ent.list(callbackRef01Match, null);
    assertTrue(callbackRef01ListResult instanceof List,
        "expected list result to be an array, got " + callbackRef01ListResult);
    List<Object> callbackRef01List = (List<Object>) callbackRef01ListResult;

    List<Object> foundItem = Struct.select(
        RunnerSupport.entityListToData(callbackRef01List),
        Struct.jm("id", callbackRef01Data.get("id")));
    assertFalse(Struct.isempty(foundItem), "expected to find created entity in list");

    // UPDATE
    Map<String, Object> callbackRef01DataUp0Up = new LinkedHashMap<>();
    callbackRef01DataUp0Up.put("id", callbackRef01Data.get("id"));

    String callbackRef01MarkdefUp0Name = "receiver_type";
    String callbackRef01MarkdefUp0Value = "Mark01-callback_ref01_" + setup.now;
    callbackRef01DataUp0Up.put(callbackRef01MarkdefUp0Name, callbackRef01MarkdefUp0Value);

    Object callbackRef01ResdataUp0Result = callbackRef01Ent.update(callbackRef01DataUp0Up, null);
    Map<String, Object> callbackRef01ResdataUp0 = Helpers.toMapAny(callbackRef01ResdataUp0Result instanceof SdkEntity ? ((SdkEntity) callbackRef01ResdataUp0Result).data() : callbackRef01ResdataUp0Result);
    assertNotNull(callbackRef01ResdataUp0, "expected update result to be a map");
    assertEquals(callbackRef01DataUp0Up.get("id"), callbackRef01ResdataUp0.get("id"),
        "expected update result id to match");
    assertEquals(callbackRef01MarkdefUp0Value, callbackRef01ResdataUp0.get(callbackRef01MarkdefUp0Name),
        "expected " + callbackRef01MarkdefUp0Name + " to be updated");

    // LOAD
    Map<String, Object> callbackRef01MatchDt0 = new LinkedHashMap<>();
    callbackRef01MatchDt0.put("id", callbackRef01Data.get("id"));
    Object callbackRef01DataDt0Loaded = callbackRef01Ent.load(callbackRef01MatchDt0, null);
    Map<String, Object> callbackRef01DataDt0LoadResult = Helpers.toMapAny(callbackRef01DataDt0Loaded instanceof SdkEntity ? ((SdkEntity) callbackRef01DataDt0Loaded).data() : callbackRef01DataDt0Loaded);
    assertNotNull(callbackRef01DataDt0LoadResult, "expected load result to be a map");
    assertEquals(callbackRef01Data.get("id"), callbackRef01DataDt0LoadResult.get("id"),
        "expected load result id to match");

    // REMOVE
    Map<String, Object> callbackRef01MatchRm0 = new LinkedHashMap<>();
    callbackRef01MatchRm0.put("id", callbackRef01Data.get("id"));
    callbackRef01Ent.remove(callbackRef01MatchRm0, null);

    // LIST
    Map<String, Object> callbackRef01MatchRt0 = new LinkedHashMap<>();

    Object callbackRef01ListRt0Result = callbackRef01Ent.list(callbackRef01MatchRt0, null);
    assertTrue(callbackRef01ListRt0Result instanceof List,
        "expected list result to be an array, got " + callbackRef01ListRt0Result);
    List<Object> callbackRef01ListRt0 = (List<Object>) callbackRef01ListRt0Result;

    List<Object> notFoundItem = Struct.select(
        RunnerSupport.entityListToData(callbackRef01ListRt0),
        Struct.jm("id", callbackRef01Data.get("id")));
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

    RunnerSupport.EntityTestSetup setup = callbackBasicSetup(streamingActive);
    Assumptions.assumeFalse(setup.live,
        "stream test streams the seeded fixture data (unit mode only)");

    SdkEntity ent = setup.client.callback(null);
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
    RunnerSupport.EntityTestSetup setup2 = callbackBasicSetup(null);
    SdkEntity ent2 = setup2.client.callback(null);
    List<Object> streamed2 = ent2.stream("list", match, null)
        .collect(Collectors.toList());
    assertEquals(listed.size(), streamed2.size(),
        "expected fallback stream to yield the materialised items");
  }

  static RunnerSupport.EntityTestSetup callbackBasicSetup(Map<String, Object> extra) {
    RunnerSupport.loadEnvLocal();

    Map<String, Object> entityData;
    try {
      String entityDataSource = Files.readString(Path.of(
          "..", ".sdk", "test", "entity", "callback", "CallbackTestData.json"));
      entityData = Helpers.toMapAny(Json.parse(entityDataSource));
    }
    catch (Exception e) {
      throw new AssertionError("failed to read callback test data: " + e.getMessage(), e);
    }

    Map<String, Object> options = new LinkedHashMap<>();
    options.put("entity", entityData.get("existing"));

    SmsapiSDK client = SmsapiSDK.testSDK(options, extra);

    // Generate idmap via transform, matching TS pattern.
    List<Object> idnames = new ArrayList<>();
    idnames.add("callback01");
    idnames.add("callback02");
    idnames.add("callback03");
    Object idmap = Struct.transform(idnames, Json.parse(
        "{\"`$PACK`\": [\"\", {"
        + "\"`$KEY`\": \"`$COPY`\","
        + "\"`$VAL`\": [\"`$FORMAT`\", \"upper\", \"`$COPY`\"]"
        + "}]}"));

    // Detect ENTID env override before envOverride consumes it. When live
    // mode is on without a real override, the basic test runs against
    // synthetic IDs from the fixture and 4xx's. Surface this so the test
    // can skip.
    String entidEnvRaw = RunnerSupport.getenv("SMSAPI_TEST_CALLBACK_ENTID");
    boolean idmapOverridden = entidEnvRaw != null
        && entidEnvRaw.trim().startsWith("{");

    Map<String, Object> envm = new LinkedHashMap<>();
    envm.put("SMSAPI_TEST_CALLBACK_ENTID", idmap);
    envm.put("SMSAPI_TEST_LIVE", "FALSE");
    envm.put("SMSAPI_TEST_EXPLAIN", "FALSE");
    envm.put("SMSAPI_APIKEY", "");
    Map<String, Object> env = RunnerSupport.envOverride(envm);

    Map<String, Object> idmapResolved = Helpers.toMapAny(env.get("SMSAPI_TEST_CALLBACK_ENTID"));
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
