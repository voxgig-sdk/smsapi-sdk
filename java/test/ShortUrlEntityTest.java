package voxgig.smsapisdk.sdktest;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertThrows;
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

import voxgig.smsapisdk.core.Config;
import voxgig.smsapisdk.core.Context;
import voxgig.smsapisdk.core.Helpers;
import voxgig.smsapisdk.core.SdkEntity;
import voxgig.smsapisdk.core.SdkError;
import voxgig.smsapisdk.core.SmsapiSDK;
import voxgig.smsapisdk.feature.BaseFeature;
import voxgig.smsapisdk.utility.Json;
import voxgig.smsapisdk.utility.struct.Struct;

@SuppressWarnings({"unchecked", "unused"})
public class ShortUrlEntityTest {

  // main.kit.test.live.strict is true (the default is true): a live
  // request that fails, or a live test missing an input it needs,
  // fails the test.
  // An account with no record for a test to read skips it either way.
  static final boolean LIVE_STRICT = true;

  @Test
  public void instance() {
    SmsapiSDK testsdk = SmsapiSDK.testSDK();
    SdkEntity ent = testsdk.shortUrl(null);
    assertNotNull(ent, "expected non-null short_url entity");
  }

  @Test
  public void basic() {
    RunnerSupport.EntityTestSetup setup = shortUrlBasicSetup(null);
    // Per-op sdk-test-control.json skip — basic test exercises a flow
    // with multiple ops; skipping any op skips the whole flow.
    String mode = setup.live ? "live" : "unit";
    for (String op : new String[] { "create", "list", "update", "load", "remove" }) {
      String reason = RunnerSupport.skipReason("entityOp", "short_url." + op, mode);
      Assumptions.assumeTrue(reason == null,
          reason == null || "".equals(reason)
              ? "skipped via sdk-test-control.json" : reason);
    }
    SmsapiSDK client = setup.client;

    // CREATE
    SdkEntity shortUrlRef01Ent = client.shortUrl(null);
    Map<String, Object> shortUrlRef01Data = Helpers.toMapAny(Struct.getprop(
        Struct.getpath(setup.data, "new.short_url"), "short_url_ref01"));

    Object shortUrlRef01DataResult = shortUrlRef01Ent.create(shortUrlRef01Data, null);
    shortUrlRef01Data = Helpers.toMapAny(shortUrlRef01DataResult instanceof SdkEntity ? ((SdkEntity) shortUrlRef01DataResult).data() : shortUrlRef01DataResult);
    assertNotNull(shortUrlRef01Data, "expected create result to be a map");
    assertNotNull(shortUrlRef01Data.get("id"), "expected created entity to have an id");

    // LIST
    Map<String, Object> shortUrlRef01Match = new LinkedHashMap<>();

    Object shortUrlRef01ListResult = shortUrlRef01Ent.list(shortUrlRef01Match, null);
    assertTrue(shortUrlRef01ListResult instanceof List,
        "expected list result to be an array, got " + shortUrlRef01ListResult);
    List<Object> shortUrlRef01List = (List<Object>) shortUrlRef01ListResult;

    List<Object> foundItem = Struct.select(
        RunnerSupport.entityListToData(shortUrlRef01List),
        Struct.jm("id", shortUrlRef01Data.get("id")));
    assertFalse(Struct.isempty(foundItem), "expected to find created entity in list");

    // UPDATE
    Map<String, Object> shortUrlRef01DataUp0Up = new LinkedHashMap<>();
    shortUrlRef01DataUp0Up.put("id", shortUrlRef01Data.get("id"));

    String shortUrlRef01MarkdefUp0Name = "description";
    String shortUrlRef01MarkdefUp0Value = "Mark01-short_url_ref01_" + setup.now;
    shortUrlRef01DataUp0Up.put(shortUrlRef01MarkdefUp0Name, shortUrlRef01MarkdefUp0Value);

    Object shortUrlRef01ResdataUp0Result = shortUrlRef01Ent.update(shortUrlRef01DataUp0Up, null);
    Map<String, Object> shortUrlRef01ResdataUp0 = Helpers.toMapAny(shortUrlRef01ResdataUp0Result instanceof SdkEntity ? ((SdkEntity) shortUrlRef01ResdataUp0Result).data() : shortUrlRef01ResdataUp0Result);
    assertNotNull(shortUrlRef01ResdataUp0, "expected update result to be a map");
    assertEquals(shortUrlRef01DataUp0Up.get("id"), shortUrlRef01ResdataUp0.get("id"),
        "expected update result id to match");
    assertEquals(shortUrlRef01MarkdefUp0Value, shortUrlRef01ResdataUp0.get(shortUrlRef01MarkdefUp0Name),
        "expected " + shortUrlRef01MarkdefUp0Name + " to be updated");

    // LOAD
    Map<String, Object> shortUrlRef01MatchDt0 = new LinkedHashMap<>();
    shortUrlRef01MatchDt0.put("id", shortUrlRef01Data.get("id"));
    Object shortUrlRef01DataDt0Loaded = shortUrlRef01Ent.load(shortUrlRef01MatchDt0, null);
    Map<String, Object> shortUrlRef01DataDt0LoadResult = Helpers.toMapAny(shortUrlRef01DataDt0Loaded instanceof SdkEntity ? ((SdkEntity) shortUrlRef01DataDt0Loaded).data() : shortUrlRef01DataDt0Loaded);
    assertNotNull(shortUrlRef01DataDt0LoadResult, "expected load result to be a map");
    assertEquals(shortUrlRef01Data.get("id"), shortUrlRef01DataDt0LoadResult.get("id"),
        "expected load result id to match");

    // REMOVE
    Map<String, Object> shortUrlRef01MatchRm0 = new LinkedHashMap<>();
    shortUrlRef01MatchRm0.put("id", shortUrlRef01Data.get("id"));
    shortUrlRef01Ent.remove(shortUrlRef01MatchRm0, null);

    // LIST
    Map<String, Object> shortUrlRef01MatchRt0 = new LinkedHashMap<>();

    Object shortUrlRef01ListRt0Result = shortUrlRef01Ent.list(shortUrlRef01MatchRt0, null);
    assertTrue(shortUrlRef01ListRt0Result instanceof List,
        "expected list result to be an array, got " + shortUrlRef01ListRt0Result);
    List<Object> shortUrlRef01ListRt0 = (List<Object>) shortUrlRef01ListRt0Result;

    List<Object> notFoundItem = Struct.select(
        RunnerSupport.entityListToData(shortUrlRef01ListRt0),
        Struct.jm("id", shortUrlRef01Data.get("id")));
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

    RunnerSupport.EntityTestSetup setup = shortUrlBasicSetup(streamingActive);
    Assumptions.assumeFalse(setup.live,
        "stream test streams the seeded fixture data (unit mode only)");

    SdkEntity ent = setup.client.shortUrl(null);
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
    RunnerSupport.EntityTestSetup setup2 = shortUrlBasicSetup(null);
    SdkEntity ent2 = setup2.client.shortUrl(null);
    List<Object> streamed2 = ent2.stream("list", match, null)
        .collect(Collectors.toList());
    assertEquals(listed.size(), streamed2.size(),
        "expected fallback stream to yield the materialised items");
  }

  static boolean hasFeature(String name) {
    Map<String, Object> fm = Helpers.toMapAny(Config.makeConfig().get("feature"));
    return fm != null && fm.get(name) != null;
  }

  public static final class FailHook extends BaseFeature {
    int unexpected = 0;

    FailHook() {
      super("failhook", "0.0.1", true);
    }

    @Override
    public void preSpec(Context ctx) {
      throw new RuntimeException("short_url hook failed");
    }

    @Override
    public void preUnexpected(Context ctx) {
      this.unexpected++;
    }
  }

  @Test
  public void streamError() {
    Map<String, Object> offline = Struct.jm("net", Struct.jm("offline", true));
    RuntimeException err = assertThrows(RuntimeException.class, () ->
        SmsapiSDK.testSDK(offline, null).shortUrl(null).stream("list", null, null)
            .collect(Collectors.toList()));
    assertTrue(err.getMessage().contains("offline"), err.getMessage());

    SmsapiSDK.testSDK(offline, null).shortUrl(null)
        .stream("list", null, Struct.jm("ctrl", Struct.jm("throw", false)))
        .collect(Collectors.toList());

    if (hasFeature("rbac")) {
      SmsapiSDK denied = SmsapiSDK.testSDK(null,
          Struct.jm("feature", Struct.jm("rbac", Struct.jm("active", true, "deny", true))));
      SdkError denyerr = assertThrows(SdkError.class, () ->
          denied.shortUrl(null).stream("list", null, null).collect(Collectors.toList()));
      assertEquals("rbac_denied", denyerr.code);
    }
  }

  @Test
  public void streamCtrl() {
    Map<String, Object> explain = new LinkedHashMap<>();
    Map<String, Object> ctrl = new LinkedHashMap<>();
    ctrl.put("explain", explain);
    SmsapiSDK.testSDK().shortUrl(null).stream("list", null, Struct.jm("ctrl", ctrl))
        .collect(Collectors.toList());
    assertEquals(List.of("explain"), new ArrayList<>(ctrl.keySet()));
    assertTrue(explain == ctrl.get("explain") && !explain.isEmpty());
  }

  @Test
  public void unexpected() {
    FailHook hook = new FailHook();
    SmsapiSDK client = new SmsapiSDK(Struct.jm(
        "feature", Struct.jm("test", Struct.jm("active", true)),
        "extend", Struct.jt(hook)));

    RuntimeException err = assertThrows(RuntimeException.class, () ->
        client.shortUrl(null).list(null, null));
    assertTrue(err.getMessage().contains("hook failed"), err.getMessage());
    assertTrue(0 < hook.unexpected);

    int fired = hook.unexpected;
    client.shortUrl(null).list(null, Struct.jm("throw", false));
    assertTrue(fired < hook.unexpected);
  }

  @Test
  public void validate() {
    Assumptions.assumeTrue(hasFeature("validate"), "feature not present in this SDK: validate");
    SmsapiSDK client = SmsapiSDK.testSDK(null,
        Struct.jm("feature", Struct.jm("validate", Struct.jm("active", true))));
    SdkError err = assertThrows(SdkError.class, () ->
        client.shortUrl(null).list(Struct.jm("description", 1), null));
    assertEquals("validate_failed", err.code);
  }

  static RunnerSupport.EntityTestSetup shortUrlBasicSetup(Map<String, Object> extra) {
    RunnerSupport.loadEnvLocal();

    Map<String, Object> entityData;
    try {
      String entityDataSource = Files.readString(Path.of(
          "..", ".sdk", "test", "entity", "short_url", "ShortUrlTestData.json"));
      entityData = Helpers.toMapAny(Json.parse(entityDataSource));
    }
    catch (Exception e) {
      throw new AssertionError("failed to read short_url test data: " + e.getMessage(), e);
    }

    Map<String, Object> options = new LinkedHashMap<>();
    options.put("entity", entityData.get("existing"));

    SmsapiSDK client = SmsapiSDK.testSDK(options, extra);

    // Generate idmap via transform, matching TS pattern.
    List<Object> idnames = new ArrayList<>();
    idnames.add("short_url01");
    idnames.add("short_url02");
    idnames.add("short_url03");
    Object idmap = Struct.transform(idnames, Json.parse(
        "{\"`$PACK`\": [\"\", {"
        + "\"`$KEY`\": \"`$COPY`\","
        + "\"`$VAL`\": [\"`$FORMAT`\", \"upper\", \"`$COPY`\"]"
        + "}]}"));

    // Whether *_ENTID supplied the idmap, read before envOverride consumes
    // it: without it, the ids a live flow binds are the fixture's synthetic ones.
    String entidEnvRaw = RunnerSupport.getenv("SMSAPI_TEST_SHORT_URL_ENTID");
    boolean idmapOverridden = entidEnvRaw != null
        && entidEnvRaw.trim().startsWith("{");

    Map<String, Object> envm = new LinkedHashMap<>();
    envm.put("SMSAPI_TEST_SHORT_URL_ENTID", idmap);
    envm.put("SMSAPI_TEST_LIVE", "FALSE");
    envm.put("SMSAPI_TEST_EXPLAIN", "FALSE");
    envm.put("SMSAPI_APIKEY", "");
    Map<String, Object> env = RunnerSupport.envOverride(envm);

    Map<String, Object> idmapResolved = Helpers.toMapAny(env.get("SMSAPI_TEST_SHORT_URL_ENTID"));
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
