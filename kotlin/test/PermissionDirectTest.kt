package voxgig.smsapisdk.sdktest

import java.util.function.BiFunction
import java.util.function.Supplier

import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.Assertions.assertNotNull
import org.junit.jupiter.api.Assertions.assertTrue
import org.junit.jupiter.api.Assumptions
import org.junit.jupiter.api.Test

import voxgig.smsapisdk.core.Helpers
import voxgig.smsapisdk.core.SmsapiSDK
import voxgig.smsapisdk.utility.Json

@Suppress("UNCHECKED_CAST", "UNUSED_VARIABLE")
class PermissionDirectTest {

  // main.kit.test.live.strict is true (the default is true): a live
  // request that fails, or a live test missing an input it needs,
  // fails the test.
  // An account with no record for a test to read skips it either way.
  private val LIVE_STRICT = true

  private fun liveOk(result: Map<String, Any?>): Boolean {
    val status = Helpers.toInt(result["status"])
    return result["err"] == null && result["ok"] == true && status in 200..299
  }

  @Test
  fun directLoadPermission() {
    val setup = directSetup(jm("id", "direct01"))
    val mode = if (setup.live) "live" else "unit"
    val reason = RunnerSupport.skipReason("direct", "direct-load-permission", mode)
    Assumptions.assumeTrue(
      reason == null,
      if (reason == null || "" == reason) "skipped via sdk-test-control.json" else reason,
    )
    val client = setup.client

    val params = linkedMapOf<String, Any?>()
    val query = linkedMapOf<String, Any?>()
    if (setup.live) {
      params["group_id"] = "0f0f0f0f0f0f0f0f0f0f0f0f"
      params["id"] = "example_username"
    } else {
      params["group_id"] = "direct01"
      params["id"] = "direct02"
    }

    val result = client.direct(jm(
        "path", "contacts/groups/{group_id}/permissions/{id}",
        "method", "GET",
        "params", params,
        "query", query))
    if (setup.live) {
      if (!liveOk(result)) {
        RunnerSupport.liveMiss(LIVE_STRICT, "Live load failed: " + RunnerSupport.liveDescribe(result))
      }
      if (result["data"] == null) {
        RunnerSupport.liveMiss(LIVE_STRICT, "Live load returned no data: " + RunnerSupport.liveDescribe(result))
      }
    } else {
      assertEquals(true, result["ok"], "expected ok to be true")
      assertEquals(200, Helpers.toInt(result["status"]), "expected status 200")
      assertNotNull(result["data"], "expected data to be non-null")
    }

    if (!setup.live) {
      val dataMap = Helpers.toMapAny(result["data"])
      if (dataMap != null) {
        assertEquals("direct01", dataMap["id"], "expected data.id to be direct01")
      }

      assertEquals(1, setup.calls.size, "expected 1 call")
      val call = setup.calls[0]
      val initMap = Helpers.toMapAny(call["init"])
      if (initMap != null) {
        assertEquals("GET", initMap["method"], "expected method GET")
      }
      val url = if (call["url"] is String) call["url"] as String else ""
      assertTrue(url.contains("direct01"),
          "expected url to contain direct01, got " + url)
      assertTrue(url.contains("direct02"),
          "expected url to contain direct02, got " + url)
    }
  }

  companion object {
    fun jm(vararg kv: Any?): MutableMap<String, Any?> {
      val out = linkedMapOf<String, Any?>()
      var i = 0
      while (i < kv.size - 1) {
        out[kv[i].toString()] = kv[i + 1]
        i += 2
      }
      return out
    }

    class DirectSetup {
      lateinit var client: SmsapiSDK
      var calls: MutableList<MutableMap<String, Any?>> = mutableListOf()
      var live: Boolean = false
      var idmap: MutableMap<String, Any?> = linkedMapOf()
    }

    fun directSetup(mockres: Any?): DirectSetup {
      RunnerSupport.loadEnvLocal()

      val calls = mutableListOf<MutableMap<String, Any?>>()

      val envm = linkedMapOf<String, Any?>()
      envm["SMSAPI_TEST_PERMISSION_ENTID"] = linkedMapOf<String, Any?>()
      envm["SMSAPI_TEST_LIVE"] = "FALSE"
      envm["SMSAPI_APIKEY"] = "NONE"
      val env = RunnerSupport.envOverride(envm)

      val live = "TRUE" == env["SMSAPI_TEST_LIVE"]

      val setup = DirectSetup()
      setup.calls = calls

      if (live) {
        val mergedOpts = linkedMapOf<String, Any?>()
        mergedOpts["apikey"] = env["SMSAPI_APIKEY"]
        setup.client = SmsapiSDK(mergedOpts)
        setup.live = true

        var idmap: MutableMap<String, Any?> = linkedMapOf()
        val entidRaw = env["SMSAPI_TEST_PERMISSION_ENTID"]
        if (entidRaw is String && entidRaw.startsWith("{")) {
          val parsed = Helpers.toMapAny(Json.parseOrNull(entidRaw))
          if (parsed != null) {
            idmap = parsed
          }
        } else if (entidRaw is MutableMap<*, *>) {
          idmap = entidRaw as MutableMap<String, Any?>
        }
        setup.idmap = idmap
        return setup
      }

      val mockdata: Any? = mockres ?: jm("id", "direct01")
      val mockFetch = BiFunction<String, MutableMap<String, Any?>, MutableMap<String, Any?>> { url, init ->
        calls.add(jm("url", url, "init", init))
        jm(
            "status", 200,
            "statusText", "OK",
            "headers", linkedMapOf<String, Any?>(),
            "json", Supplier<Any?> { mockdata })
      }

      setup.client = SmsapiSDK(jm(
          "base", "http://localhost:8080",
          "system", jm("fetch", mockFetch)))
      setup.live = false
      setup.idmap = linkedMapOf()
      return setup
    }
  }
}
