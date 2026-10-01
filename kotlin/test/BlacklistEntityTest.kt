package voxgig.smsapisdk.sdktest

import java.nio.file.Files
import java.nio.file.Paths

import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.Assertions.assertFalse
import org.junit.jupiter.api.Assertions.assertNotNull
import org.junit.jupiter.api.Assertions.assertTrue
import org.junit.jupiter.api.Assumptions
import org.junit.jupiter.api.Test

import voxgig.smsapisdk.core.Helpers
import voxgig.smsapisdk.core.SdkEntity
import voxgig.smsapisdk.core.SmsapiSDK
import voxgig.smsapisdk.utility.Json
import voxgig.smsapisdk.utility.struct.Struct

@Suppress("UNCHECKED_CAST", "UNUSED_VARIABLE", "UNUSED_VALUE")
class BlacklistEntityTest {

  @Test
  fun instance() {
    val testsdk = SmsapiSDK.testSDK()
    val ent = testsdk.blacklist(null)
    assertNotNull(ent, "expected non-null blacklist entity")
  }

  @Test
  fun basic() {
    val setup = blacklistBasicSetup(null)
    // Per-op sdk-test-control.json skip.
    val mode = if (setup.live) "live" else "unit"
    for (op in arrayOf<String>("create", "load", "remove")) {
      val reason = RunnerSupport.skipReason("entityOp", "blacklist.$op", mode)
      Assumptions.assumeTrue(
        reason == null,
        if (reason == null || "" == reason) "skipped via sdk-test-control.json" else reason,
      )
    }
    Assumptions.assumeFalse(
      setup.syntheticOnly,
      "live entity test uses synthetic IDs from fixture — set SMSAPI_TEST_BLACKLIST_ENTID JSON to run live",
    )
    val client = setup.client

    // CREATE
    val blacklistRef01Ent = client.blacklist(null)
    var blacklistRef01Data: MutableMap<String, Any?> = (Helpers.toMapAny(Struct.getprop(
        Struct.getpath(setup.data, "new.blacklist"), "blacklist_ref01")) ?: linkedMapOf())

    val blacklistRef01DataResult = blacklistRef01Ent.create(blacklistRef01Data, null)
    blacklistRef01Data = Helpers.toMapAny(if (blacklistRef01DataResult is SdkEntity) blacklistRef01DataResult.data() else blacklistRef01DataResult) ?: linkedMapOf()
    assertNotNull(blacklistRef01Data, "expected create result to be a map")
    assertNotNull(blacklistRef01Data["id"], "expected created entity to have an id")

    // LOAD
    val blacklistRef01MatchDt0 = linkedMapOf<String, Any?>()
    blacklistRef01MatchDt0["id"] = blacklistRef01Data["id"]
    val blacklistRef01DataDt0Loaded = blacklistRef01Ent.load(blacklistRef01MatchDt0, null)
    val blacklistRef01DataDt0LoadResult = Helpers.toMapAny(if (blacklistRef01DataDt0Loaded is SdkEntity) blacklistRef01DataDt0Loaded.data() else blacklistRef01DataDt0Loaded) ?: linkedMapOf()
    assertNotNull(blacklistRef01DataDt0LoadResult, "expected load result to be a map")
    assertEquals(blacklistRef01Data["id"], blacklistRef01DataDt0LoadResult["id"],
        "expected load result id to match")

    // REMOVE
    val blacklistRef01MatchRm0 = linkedMapOf<String, Any?>()
    blacklistRef01MatchRm0["id"] = blacklistRef01Data["id"]
    blacklistRef01Ent.remove(blacklistRef01MatchRm0, null)

  }

  companion object {
    fun blacklistBasicSetup(extra: MutableMap<String, Any?>?): RunnerSupport.EntityTestSetup {
      RunnerSupport.loadEnvLocal()

      val entityData: MutableMap<String, Any?>
      try {
        val entityDataSource = Files.readString(Paths.get(
            "..", ".sdk", "test", "entity", "blacklist", "BlacklistTestData.json"))
        entityData = Helpers.toMapAny(Json.parse(entityDataSource)) ?: linkedMapOf()
      } catch (e: Exception) {
        throw AssertionError("failed to read blacklist test data: " + e.message, e)
      }

      val options = linkedMapOf<String, Any?>()
      options["entity"] = entityData["existing"]

      var client = SmsapiSDK.testSDK(options, extra)

      // Generate idmap via transform, matching TS pattern.
      val idnames = mutableListOf<Any?>()
      idnames.add("blacklist01")
      idnames.add("blacklist02")
      idnames.add("blacklist03")
      val idmap = Struct.transform(idnames, Json.parse(
          "{\"`\$PACK`\": [\"\", {" +
          "\"`\$KEY`\": \"`\$COPY`\"," +
          "\"`\$VAL`\": [\"`\$FORMAT`\", \"upper\", \"`\$COPY`\"]" +
          "}]}"))

      // Detect ENTID env override before envOverride consumes it.
      val entidEnvRaw = RunnerSupport.getenv("SMSAPI_TEST_BLACKLIST_ENTID")
      val idmapOverridden = entidEnvRaw != null && entidEnvRaw.trim().startsWith("{")

      val envm = linkedMapOf<String, Any?>()
      envm["SMSAPI_TEST_BLACKLIST_ENTID"] = idmap
      envm["SMSAPI_TEST_LIVE"] = "FALSE"
      envm["SMSAPI_TEST_EXPLAIN"] = "FALSE"
      envm["SMSAPI_APIKEY"] = "NONE"
      val env = RunnerSupport.envOverride(envm)

      var idmapResolved = Helpers.toMapAny(env["SMSAPI_TEST_BLACKLIST_ENTID"])
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
