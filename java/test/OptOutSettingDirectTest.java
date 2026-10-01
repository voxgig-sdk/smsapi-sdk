package voxgig.smsapisdk.sdktest;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.function.BiFunction;
import java.util.function.Supplier;

import org.junit.jupiter.api.Assumptions;
import org.junit.jupiter.api.Test;

import voxgig.smsapisdk.core.Helpers;
import voxgig.smsapisdk.core.SmsapiSDK;
import voxgig.smsapisdk.utility.Json;

@SuppressWarnings({"unchecked", "unused"})
public class OptOutSettingDirectTest {

  static Map<String, Object> jm(Object... kv) {
    Map<String, Object> out = new LinkedHashMap<>();
    for (int i = 0; i < kv.length - 1; i += 2) {
      out.put(String.valueOf(kv[i]), kv[i + 1]);
    }
    return out;
  }

  @Test
  public void directLoadOptOutSetting() {
    DirectSetup setup = directSetup(jm("id", "direct01"));
    String mode = setup.live ? "live" : "unit";
    String reason = RunnerSupport.skipReason("direct", "direct-load-opt_out_setting", mode);
    Assumptions.assumeTrue(reason == null,
        reason == null || "".equals(reason)
            ? "skipped via sdk-test-control.json" : reason);
    SmsapiSDK client = setup.client;


    Map<String, Object> result = client.direct(jm(
        "path", "opt_outs/settings",
        "method", "GET",
        "params", new LinkedHashMap<>()));
    if (setup.live) {
      // Live mode is lenient: synthetic IDs frequently 4xx. Skip rather
      // than fail when the load endpoint isn't reachable with the IDs we
      // can construct from setup.idmap.
      Assumptions.assumeTrue(Boolean.TRUE.equals(result.get("ok")),
          "load call not ok (likely synthetic IDs against live API): " + result);
      int status = Helpers.toInt(result.get("status"));
      Assumptions.assumeTrue(status >= 200 && status < 300,
          "expected 2xx status, got " + result.get("status"));
    }
    else {
      assertEquals(true, result.get("ok"), "expected ok to be true");
      assertEquals(200, Helpers.toInt(result.get("status")), "expected status 200");
      assertNotNull(result.get("data"), "expected data to be non-null");
    }

    if (!setup.live) {
      Map<String, Object> dataMap = Helpers.toMapAny(result.get("data"));
      if (dataMap != null) {
        assertEquals("direct01", dataMap.get("id"), "expected data.id to be direct01");
      }

      assertEquals(1, setup.calls.size(), "expected 1 call");
      Map<String, Object> call = setup.calls.get(0);
      Map<String, Object> initMap = Helpers.toMapAny(call.get("init"));
      if (initMap != null) {
        assertEquals("GET", initMap.get("method"), "expected method GET");
      }
      String url = call.get("url") instanceof String ? (String) call.get("url") : "";
    }
  }

  static class DirectSetup {
    SmsapiSDK client;
    List<Map<String, Object>> calls;
    boolean live;
    Map<String, Object> idmap;
  }

  static DirectSetup directSetup(Object mockres) {
    RunnerSupport.loadEnvLocal();

    final List<Map<String, Object>> calls = new ArrayList<>();

    Map<String, Object> envm = new LinkedHashMap<>();
    envm.put("SMSAPI_TEST_OPT_OUT_SETTING_ENTID", new LinkedHashMap<>());
    envm.put("SMSAPI_TEST_LIVE", "FALSE");
    envm.put("SMSAPI_APIKEY", "");
    Map<String, Object> env = RunnerSupport.envOverride(envm);

    boolean live = "TRUE".equals(env.get("SMSAPI_TEST_LIVE"));

    DirectSetup setup = new DirectSetup();
    setup.calls = calls;

    if (live) {
      // sdk-test-control.json's test.client.options seeds the live
      // client; the generated fields below overwrite anything they name.
      Map<String, Object> mergedOpts =
          new LinkedHashMap<>(RunnerSupport.liveClientOptions());
      mergedOpts.put("apikey", env.get("SMSAPI_APIKEY"));
      setup.client = new SmsapiSDK(mergedOpts);
      setup.live = true;

      Map<String, Object> idmap = new LinkedHashMap<>();
      Object entidRaw = env.get("SMSAPI_TEST_OPT_OUT_SETTING_ENTID");
      if (entidRaw instanceof String && ((String) entidRaw).startsWith("{")) {
        Map<String, Object> parsed = Helpers.toMapAny(Json.parseOrNull((String) entidRaw));
        if (parsed != null) {
          idmap = parsed;
        }
      }
      else if (entidRaw instanceof Map) {
        idmap = (Map<String, Object>) entidRaw;
      }
      setup.idmap = idmap;
      return setup;
    }

    final Object mockdata = mockres != null ? mockres : jm("id", "direct01");
    BiFunction<String, Map<String, Object>, Map<String, Object>> mockFetch =
        (url, init) -> {
          calls.add(jm("url", url, "init", init));
          return jm(
              "status", 200,
              "statusText", "OK",
              "headers", new LinkedHashMap<>(),
              "json", (Supplier<Object>) () -> mockdata);
        };

    setup.client = new SmsapiSDK(jm(
        "base", "http://localhost:8080",
        "system", jm("fetch", mockFetch)));
    setup.live = false;
    setup.idmap = new LinkedHashMap<>();
    return setup;
  }
}
