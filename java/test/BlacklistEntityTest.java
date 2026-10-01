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
public class BlacklistEntityTest {

  @Test
  public void instance() {
    SmsapiSDK testsdk = SmsapiSDK.testSDK();
    SdkEntity ent = testsdk.blacklist(null);
    assertNotNull(ent, "expected non-null blacklist entity");
  }

  @Test
  public void basic() {
    RunnerSupport.EntityTestSetup setup = blacklistBasicSetup(null);
    // Per-op sdk-test-control.json skip — basic test exercises a flow
    // with multiple ops; skipping any op skips the whole flow.
    String mode = setup.live ? "live" : "unit";
    for (String op : new String[] { "create", "load", "remove" }) {
      String reason = RunnerSupport.skipReason("entityOp", "blacklist." + op, mode);
      Assumptions.assumeTrue(reason == null,
          reason == null || "".equals(reason)
              ? "skipped via sdk-test-control.json" : reason);
    }
    // The basic flow consumes synthetic IDs from the fixture. In live mode
    // without an *_ENTID env override, those IDs hit the live API and 4xx.
    Assumptions.assumeFalse(setup.syntheticOnly,
        "live entity test uses synthetic IDs from fixture — set SMSAPI_TEST_BLACKLIST_ENTID JSON to run live");
    SmsapiSDK client = setup.client;

    // CREATE
    SdkEntity blacklistRef01Ent = client.blacklist(null);
    Map<String, Object> blacklistRef01Data = Helpers.toMapAny(Struct.getprop(
        Struct.getpath(setup.data, "new.blacklist"), "blacklist_ref01"));

    Object blacklistRef01DataResult = blacklistRef01Ent.create(blacklistRef01Data, null);
    blacklistRef01Data = Helpers.toMapAny(blacklistRef01DataResult instanceof SdkEntity ? ((SdkEntity) blacklistRef01DataResult).data() : blacklistRef01DataResult);
    assertNotNull(blacklistRef01Data, "expected create result to be a map");
    assertNotNull(blacklistRef01Data.get("id"), "expected created entity to have an id");

    // LOAD
    Map<String, Object> blacklistRef01MatchDt0 = new LinkedHashMap<>();
    blacklistRef01MatchDt0.put("id", blacklistRef01Data.get("id"));
    Object blacklistRef01DataDt0Loaded = blacklistRef01Ent.load(blacklistRef01MatchDt0, null);
    Map<String, Object> blacklistRef01DataDt0LoadResult = Helpers.toMapAny(blacklistRef01DataDt0Loaded instanceof SdkEntity ? ((SdkEntity) blacklistRef01DataDt0Loaded).data() : blacklistRef01DataDt0Loaded);
    assertNotNull(blacklistRef01DataDt0LoadResult, "expected load result to be a map");
    assertEquals(blacklistRef01Data.get("id"), blacklistRef01DataDt0LoadResult.get("id"),
        "expected load result id to match");

    // REMOVE
    Map<String, Object> blacklistRef01MatchRm0 = new LinkedHashMap<>();
    blacklistRef01MatchRm0.put("id", blacklistRef01Data.get("id"));
    blacklistRef01Ent.remove(blacklistRef01MatchRm0, null);

  }

  static RunnerSupport.EntityTestSetup blacklistBasicSetup(Map<String, Object> extra) {
    RunnerSupport.loadEnvLocal();

    Map<String, Object> entityData;
    try {
      String entityDataSource = Files.readString(Path.of(
          "..", ".sdk", "test", "entity", "blacklist", "BlacklistTestData.json"));
      entityData = Helpers.toMapAny(Json.parse(entityDataSource));
    }
    catch (Exception e) {
      throw new AssertionError("failed to read blacklist test data: " + e.getMessage(), e);
    }

    Map<String, Object> options = new LinkedHashMap<>();
    options.put("entity", entityData.get("existing"));

    SmsapiSDK client = SmsapiSDK.testSDK(options, extra);

    // Generate idmap via transform, matching TS pattern.
    List<Object> idnames = new ArrayList<>();
    idnames.add("blacklist01");
    idnames.add("blacklist02");
    idnames.add("blacklist03");
    Object idmap = Struct.transform(idnames, Json.parse(
        "{\"`$PACK`\": [\"\", {"
        + "\"`$KEY`\": \"`$COPY`\","
        + "\"`$VAL`\": [\"`$FORMAT`\", \"upper\", \"`$COPY`\"]"
        + "}]}"));

    // Detect ENTID env override before envOverride consumes it. When live
    // mode is on without a real override, the basic test runs against
    // synthetic IDs from the fixture and 4xx's. Surface this so the test
    // can skip.
    String entidEnvRaw = RunnerSupport.getenv("SMSAPI_TEST_BLACKLIST_ENTID");
    boolean idmapOverridden = entidEnvRaw != null
        && entidEnvRaw.trim().startsWith("{");

    Map<String, Object> envm = new LinkedHashMap<>();
    envm.put("SMSAPI_TEST_BLACKLIST_ENTID", idmap);
    envm.put("SMSAPI_TEST_LIVE", "FALSE");
    envm.put("SMSAPI_TEST_EXPLAIN", "FALSE");
    envm.put("SMSAPI_APIKEY", "");
    Map<String, Object> env = RunnerSupport.envOverride(envm);

    Map<String, Object> idmapResolved = Helpers.toMapAny(env.get("SMSAPI_TEST_BLACKLIST_ENTID"));
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
