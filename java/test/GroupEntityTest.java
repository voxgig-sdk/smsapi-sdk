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
public class GroupEntityTest {

  @Test
  public void instance() {
    SmsapiSDK testsdk = SmsapiSDK.testSDK();
    SdkEntity ent = testsdk.group(null);
    assertNotNull(ent, "expected non-null group entity");
  }

  @Test
  public void basic() {
    RunnerSupport.EntityTestSetup setup = groupBasicSetup(null);
    // Per-op sdk-test-control.json skip — basic test exercises a flow
    // with multiple ops; skipping any op skips the whole flow.
    String mode = setup.live ? "live" : "unit";
    for (String op : new String[] { "update", "load" }) {
      String reason = RunnerSupport.skipReason("entityOp", "group." + op, mode);
      Assumptions.assumeTrue(reason == null,
          reason == null || "".equals(reason)
              ? "skipped via sdk-test-control.json" : reason);
    }
    // The basic flow consumes synthetic IDs from the fixture. In live mode
    // without an *_ENTID env override, those IDs hit the live API and 4xx.
    Assumptions.assumeFalse(setup.syntheticOnly,
        "live entity test uses synthetic IDs from fixture — set SMSAPI_TEST_GROUP_ENTID JSON to run live");
    SmsapiSDK client = setup.client;

    // Bootstrap entity data from existing test data (no create step in flow).
    List<List<Object>> groupRef01DataRaw = Struct.items(Helpers.toMapAny(
        Struct.getpath(setup.data, "existing.group")));
    Map<String, Object> groupRef01Data = groupRef01DataRaw.isEmpty()
        ? null : Helpers.toMapAny(groupRef01DataRaw.get(0).get(1));

    // UPDATE
    SdkEntity groupRef01Ent = client.group(null);
    Map<String, Object> groupRef01DataUp0Up = new LinkedHashMap<>();
    groupRef01DataUp0Up.put("id", groupRef01Data.get("id"));

    String groupRef01MarkdefUp0Name = "created_by";
    String groupRef01MarkdefUp0Value = "Mark01-group_ref01_" + setup.now;
    groupRef01DataUp0Up.put(groupRef01MarkdefUp0Name, groupRef01MarkdefUp0Value);

    Object groupRef01ResdataUp0Result = groupRef01Ent.update(groupRef01DataUp0Up, null);
    Map<String, Object> groupRef01ResdataUp0 = Helpers.toMapAny(groupRef01ResdataUp0Result instanceof SdkEntity ? ((SdkEntity) groupRef01ResdataUp0Result).data() : groupRef01ResdataUp0Result);
    assertNotNull(groupRef01ResdataUp0, "expected update result to be a map");
    assertEquals(groupRef01DataUp0Up.get("id"), groupRef01ResdataUp0.get("id"),
        "expected update result id to match");
    assertEquals(groupRef01MarkdefUp0Value, groupRef01ResdataUp0.get(groupRef01MarkdefUp0Name),
        "expected " + groupRef01MarkdefUp0Name + " to be updated");

    // LOAD
    Map<String, Object> groupRef01MatchDt0 = new LinkedHashMap<>();
    groupRef01MatchDt0.put("id", groupRef01Data.get("id"));
    Object groupRef01DataDt0Loaded = groupRef01Ent.load(groupRef01MatchDt0, null);
    Map<String, Object> groupRef01DataDt0LoadResult = Helpers.toMapAny(groupRef01DataDt0Loaded instanceof SdkEntity ? ((SdkEntity) groupRef01DataDt0Loaded).data() : groupRef01DataDt0Loaded);
    assertNotNull(groupRef01DataDt0LoadResult, "expected load result to be a map");
    assertEquals(groupRef01Data.get("id"), groupRef01DataDt0LoadResult.get("id"),
        "expected load result id to match");

  }

  static RunnerSupport.EntityTestSetup groupBasicSetup(Map<String, Object> extra) {
    RunnerSupport.loadEnvLocal();

    Map<String, Object> entityData;
    try {
      String entityDataSource = Files.readString(Path.of(
          "..", ".sdk", "test", "entity", "group", "GroupTestData.json"));
      entityData = Helpers.toMapAny(Json.parse(entityDataSource));
    }
    catch (Exception e) {
      throw new AssertionError("failed to read group test data: " + e.getMessage(), e);
    }

    Map<String, Object> options = new LinkedHashMap<>();
    options.put("entity", entityData.get("existing"));

    SmsapiSDK client = SmsapiSDK.testSDK(options, extra);

    // Generate idmap via transform, matching TS pattern.
    List<Object> idnames = new ArrayList<>();
    idnames.add("group01");
    idnames.add("group02");
    idnames.add("group03");
    Object idmap = Struct.transform(idnames, Json.parse(
        "{\"`$PACK`\": [\"\", {"
        + "\"`$KEY`\": \"`$COPY`\","
        + "\"`$VAL`\": [\"`$FORMAT`\", \"upper\", \"`$COPY`\"]"
        + "}]}"));

    // Detect ENTID env override before envOverride consumes it. When live
    // mode is on without a real override, the basic test runs against
    // synthetic IDs from the fixture and 4xx's. Surface this so the test
    // can skip.
    String entidEnvRaw = RunnerSupport.getenv("SMSAPI_TEST_GROUP_ENTID");
    boolean idmapOverridden = entidEnvRaw != null
        && entidEnvRaw.trim().startsWith("{");

    Map<String, Object> envm = new LinkedHashMap<>();
    envm.put("SMSAPI_TEST_GROUP_ENTID", idmap);
    envm.put("SMSAPI_TEST_LIVE", "FALSE");
    envm.put("SMSAPI_TEST_EXPLAIN", "FALSE");
    envm.put("SMSAPI_APIKEY", "");
    Map<String, Object> env = RunnerSupport.envOverride(envm);

    Map<String, Object> idmapResolved = Helpers.toMapAny(env.get("SMSAPI_TEST_GROUP_ENTID"));
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
