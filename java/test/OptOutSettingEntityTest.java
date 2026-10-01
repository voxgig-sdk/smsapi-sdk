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
public class OptOutSettingEntityTest {

  @Test
  public void instance() {
    SmsapiSDK testsdk = SmsapiSDK.testSDK();
    SdkEntity ent = testsdk.optOutSetting(null);
    assertNotNull(ent, "expected non-null opt_out_setting entity");
  }

  @Test
  public void basic() {
    RunnerSupport.EntityTestSetup setup = optOutSettingBasicSetup(null);
    // Per-op sdk-test-control.json skip — basic test exercises a flow
    // with multiple ops; skipping any op skips the whole flow.
    String mode = setup.live ? "live" : "unit";
    for (String op : new String[] { "update", "load" }) {
      String reason = RunnerSupport.skipReason("entityOp", "opt_out_setting." + op, mode);
      Assumptions.assumeTrue(reason == null,
          reason == null || "".equals(reason)
              ? "skipped via sdk-test-control.json" : reason);
    }
    // The basic flow consumes synthetic IDs from the fixture. In live mode
    // without an *_ENTID env override, those IDs hit the live API and 4xx.
    Assumptions.assumeFalse(setup.syntheticOnly,
        "live entity test uses synthetic IDs from fixture — set SMSAPI_TEST_OPT_OUT_SETTING_ENTID JSON to run live");
    SmsapiSDK client = setup.client;

    // Bootstrap entity data from existing test data (no create step in flow).
    List<List<Object>> optOutSettingRef01DataRaw = Struct.items(Helpers.toMapAny(
        Struct.getpath(setup.data, "existing.opt_out_setting")));
    Map<String, Object> optOutSettingRef01Data = optOutSettingRef01DataRaw.isEmpty()
        ? null : Helpers.toMapAny(optOutSettingRef01DataRaw.get(0).get(1));

    // UPDATE
    SdkEntity optOutSettingRef01Ent = client.optOutSetting(null);
    Map<String, Object> optOutSettingRef01DataUp0Up = new LinkedHashMap<>();

    String optOutSettingRef01MarkdefUp0Name = "brand";
    String optOutSettingRef01MarkdefUp0Value = "Mark01-opt_out_setting_ref01_" + setup.now;
    optOutSettingRef01DataUp0Up.put(optOutSettingRef01MarkdefUp0Name, optOutSettingRef01MarkdefUp0Value);

    Object optOutSettingRef01ResdataUp0Result = optOutSettingRef01Ent.update(optOutSettingRef01DataUp0Up, null);
    Map<String, Object> optOutSettingRef01ResdataUp0 = Helpers.toMapAny(optOutSettingRef01ResdataUp0Result instanceof SdkEntity ? ((SdkEntity) optOutSettingRef01ResdataUp0Result).data() : optOutSettingRef01ResdataUp0Result);
    assertNotNull(optOutSettingRef01ResdataUp0, "expected update result to be a map");
    assertEquals(optOutSettingRef01MarkdefUp0Value, optOutSettingRef01ResdataUp0.get(optOutSettingRef01MarkdefUp0Name),
        "expected " + optOutSettingRef01MarkdefUp0Name + " to be updated");

    // LOAD
    Map<String, Object> optOutSettingRef01MatchDt0 = new LinkedHashMap<>();
    Object optOutSettingRef01DataDt0Loaded = optOutSettingRef01Ent.load(optOutSettingRef01MatchDt0, null);
    assertNotNull(optOutSettingRef01DataDt0Loaded, "expected load result to be non-null");

  }

  static RunnerSupport.EntityTestSetup optOutSettingBasicSetup(Map<String, Object> extra) {
    RunnerSupport.loadEnvLocal();

    Map<String, Object> entityData;
    try {
      String entityDataSource = Files.readString(Path.of(
          "..", ".sdk", "test", "entity", "opt_out_setting", "OptOutSettingTestData.json"));
      entityData = Helpers.toMapAny(Json.parse(entityDataSource));
    }
    catch (Exception e) {
      throw new AssertionError("failed to read opt_out_setting test data: " + e.getMessage(), e);
    }

    Map<String, Object> options = new LinkedHashMap<>();
    options.put("entity", entityData.get("existing"));

    SmsapiSDK client = SmsapiSDK.testSDK(options, extra);

    // Generate idmap via transform, matching TS pattern.
    List<Object> idnames = new ArrayList<>();
    idnames.add("opt_out_setting01");
    idnames.add("opt_out_setting02");
    idnames.add("opt_out_setting03");
    Object idmap = Struct.transform(idnames, Json.parse(
        "{\"`$PACK`\": [\"\", {"
        + "\"`$KEY`\": \"`$COPY`\","
        + "\"`$VAL`\": [\"`$FORMAT`\", \"upper\", \"`$COPY`\"]"
        + "}]}"));

    // Detect ENTID env override before envOverride consumes it. When live
    // mode is on without a real override, the basic test runs against
    // synthetic IDs from the fixture and 4xx's. Surface this so the test
    // can skip.
    String entidEnvRaw = RunnerSupport.getenv("SMSAPI_TEST_OPT_OUT_SETTING_ENTID");
    boolean idmapOverridden = entidEnvRaw != null
        && entidEnvRaw.trim().startsWith("{");

    Map<String, Object> envm = new LinkedHashMap<>();
    envm.put("SMSAPI_TEST_OPT_OUT_SETTING_ENTID", idmap);
    envm.put("SMSAPI_TEST_LIVE", "FALSE");
    envm.put("SMSAPI_TEST_EXPLAIN", "FALSE");
    envm.put("SMSAPI_APIKEY", "");
    Map<String, Object> env = RunnerSupport.envOverride(envm);

    Map<String, Object> idmapResolved = Helpers.toMapAny(env.get("SMSAPI_TEST_OPT_OUT_SETTING_ENTID"));
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
