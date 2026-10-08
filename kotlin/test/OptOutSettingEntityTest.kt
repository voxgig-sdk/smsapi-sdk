package voxgig.smsapisdk.sdktest

import java.nio.file.Files
import java.nio.file.Paths

import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.Assertions.assertFalse
import org.junit.jupiter.api.Assertions.assertNotNull
import org.junit.jupiter.api.Assertions.assertThrows
import org.junit.jupiter.api.Assertions.assertTrue
import org.junit.jupiter.api.Assumptions
import org.junit.jupiter.api.Test

import voxgig.smsapisdk.core.Config
import voxgig.smsapisdk.core.Context
import voxgig.smsapisdk.core.Helpers
import voxgig.smsapisdk.core.SdkEntity
import voxgig.smsapisdk.core.SdkError
import voxgig.smsapisdk.core.SmsapiSDK
import voxgig.smsapisdk.feature.BaseFeature
import voxgig.smsapisdk.utility.Json
import voxgig.smsapisdk.utility.struct.Struct

@Suppress("UNCHECKED_CAST", "UNUSED_VARIABLE", "UNUSED_VALUE")
class OptOutSettingEntityTest {

  // main.kit.test.live.strict is true (the default is true): a live
  // request that fails, or a live test missing an input it needs,
  // fails the test.
  // An account with no record for a test to read skips it either way.
  private val LIVE_STRICT = true

  @Test
  fun instance() {
    val testsdk = SmsapiSDK.testSDK()
    val ent = testsdk.optOutSetting(null)
    assertNotNull(ent, "expected non-null opt_out_setting entity")
  }

  @Test
  fun basic() {
    val setup = optOutSettingBasicSetup(null)
    // Per-op sdk-test-control.json skip.
    val mode = if (setup.live) "live" else "unit"
    for (op in arrayOf<String>("update", "load")) {
      val reason = RunnerSupport.skipReason("entityOp", "opt_out_setting.$op", mode)
      Assumptions.assumeTrue(
        reason == null,
        if (reason == null || "" == reason) "skipped via sdk-test-control.json" else reason,
      )
    }
    val client = setup.client

    // Bootstrap entity data from existing test data (no create step in flow).
    val optOutSettingRef01DataRaw = Struct.items(Helpers.toMapAny(
        Struct.getpath(setup.data, "existing.opt_out_setting")))
    val optOutSettingRef01Data: MutableMap<String, Any?> = if (optOutSettingRef01DataRaw.isEmpty())
        linkedMapOf() else (Helpers.toMapAny(optOutSettingRef01DataRaw[0][1]) ?: linkedMapOf())

    // UPDATE
    val optOutSettingRef01Ent = client.optOutSetting(null)
    val optOutSettingRef01DataUp0Up = linkedMapOf<String, Any?>()

    val optOutSettingRef01MarkdefUp0Name = "brand"
    val optOutSettingRef01MarkdefUp0Value = "Mark01-opt_out_setting_ref01_" + setup.now
    optOutSettingRef01DataUp0Up[optOutSettingRef01MarkdefUp0Name] = optOutSettingRef01MarkdefUp0Value

    val optOutSettingRef01ResdataUp0Result = optOutSettingRef01Ent.update(optOutSettingRef01DataUp0Up, null)
    val optOutSettingRef01ResdataUp0 = Helpers.toMapAny(if (optOutSettingRef01ResdataUp0Result is SdkEntity) optOutSettingRef01ResdataUp0Result.data() else optOutSettingRef01ResdataUp0Result) ?: linkedMapOf()
    assertNotNull(optOutSettingRef01ResdataUp0, "expected update result to be a map")
    assertEquals(optOutSettingRef01MarkdefUp0Value, optOutSettingRef01ResdataUp0[optOutSettingRef01MarkdefUp0Name],
        "expected " + optOutSettingRef01MarkdefUp0Name + " to be updated")

    // LOAD
    val optOutSettingRef01MatchDt0 = linkedMapOf<String, Any?>()
    val optOutSettingRef01DataDt0Loaded = optOutSettingRef01Ent.load(optOutSettingRef01MatchDt0, null)
    assertNotNull(optOutSettingRef01DataDt0Loaded, "expected load result to be non-null")

  }

  private fun hasFeature(name: String): Boolean {
    val fm = Helpers.toMapAny(Config.sharedConfig()["feature"])
    return fm != null && fm[name] != null
  }

  @Test
  fun validate() {
    Assumptions.assumeTrue(hasFeature("validate"), "feature not present in this SDK: validate")
    val client = SmsapiSDK.testSDK(null, linkedMapOf<String, Any?>(
      "feature" to linkedMapOf<String, Any?>(
        "validate" to linkedMapOf<String, Any?>("active" to true))))
    val err = assertThrows(SdkError::class.java) {
      client.optOutSetting(null).load(linkedMapOf<String, Any?>("brand" to 1), null)
    }
    assertEquals("validate_failed", err.code)
  }

  companion object {
    fun optOutSettingBasicSetup(extra: MutableMap<String, Any?>?): RunnerSupport.EntityTestSetup {
      RunnerSupport.loadEnvLocal()

      val entityData: MutableMap<String, Any?>
      try {
        val entityDataSource = Files.readString(Paths.get(
            "..", ".sdk", "test", "entity", "opt_out_setting", "OptOutSettingTestData.json"))
        entityData = Helpers.toMapAny(Json.parse(entityDataSource)) ?: linkedMapOf()
      } catch (e: Exception) {
        throw AssertionError("failed to read opt_out_setting test data: " + e.message, e)
      }

      val options = linkedMapOf<String, Any?>()
      options["entity"] = entityData["existing"]

      var client = SmsapiSDK.testSDK(options, extra)

      // Generate idmap via transform, matching TS pattern.
      val idnames = mutableListOf<Any?>()
      idnames.add("opt_out_setting01")
      idnames.add("opt_out_setting02")
      idnames.add("opt_out_setting03")
      val idmap = Struct.transform(idnames, Json.parse(
          "{\"`\$PACK`\": [\"\", {" +
          "\"`\$KEY`\": \"`\$COPY`\"," +
          "\"`\$VAL`\": [\"`\$FORMAT`\", \"upper\", \"`\$COPY`\"]" +
          "}]}"))

      // Whether *_ENTID supplied the idmap, read before envOverride consumes it.
      val entidEnvRaw = RunnerSupport.getenv("SMSAPI_TEST_OPT_OUT_SETTING_ENTID")
      val idmapOverridden = entidEnvRaw != null && entidEnvRaw.trim().startsWith("{")

      val envm = linkedMapOf<String, Any?>()
      envm["SMSAPI_TEST_OPT_OUT_SETTING_ENTID"] = idmap
      envm["SMSAPI_TEST_LIVE"] = "FALSE"
      envm["SMSAPI_TEST_EXPLAIN"] = "FALSE"
      envm["SMSAPI_APIKEY"] = "NONE"
      val env = RunnerSupport.envOverride(envm)

      var idmapResolved = Helpers.toMapAny(env["SMSAPI_TEST_OPT_OUT_SETTING_ENTID"])
      if (idmapResolved == null) {
        idmapResolved = Helpers.toMapAny(idmap) ?: linkedMapOf()
      }

      val live = "TRUE" == env["SMSAPI_TEST_LIVE"]
      if (live) {
        val liveOpts = linkedMapOf<String, Any?>()
        liveOpts["apikey"] = env["SMSAPI_APIKEY"]
        val mergedOpts = Struct.merge(Struct.jt(liveOpts, extra))
        client = SmsapiSDK(Helpers.toMapAny(mergedOpts))
      }

      val setup = RunnerSupport.EntityTestSetup()
      setup.client = client
      setup.data = entityData
      setup.idmap = idmapResolved
      setup.env = env
      setup.explain = "TRUE" == env["SMSAPI_TEST_EXPLAIN"]
      setup.live = live
      setup.syntheticOnly = live && !idmapOverridden
      setup.now = System.currentTimeMillis()
      return setup
    }
  }
}
