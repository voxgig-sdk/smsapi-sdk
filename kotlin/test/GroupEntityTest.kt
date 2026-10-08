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
class GroupEntityTest {

  // main.kit.test.live.strict is true (the default is true): a live
  // request that fails, or a live test missing an input it needs,
  // fails the test.
  // An account with no record for a test to read skips it either way.
  private val LIVE_STRICT = true

  @Test
  fun instance() {
    val testsdk = SmsapiSDK.testSDK()
    val ent = testsdk.group(null)
    assertNotNull(ent, "expected non-null group entity")
  }

  @Test
  fun basic() {
    val setup = groupBasicSetup(null)
    // Per-op sdk-test-control.json skip.
    val mode = if (setup.live) "live" else "unit"
    for (op in arrayOf<String>("update", "load")) {
      val reason = RunnerSupport.skipReason("entityOp", "group.$op", mode)
      Assumptions.assumeTrue(
        reason == null,
        if (reason == null || "" == reason) "skipped via sdk-test-control.json" else reason,
      )
    }
    if (setup.live) {
      RunnerSupport.liveMiss(LIVE_STRICT, "Live entity test blocked: " + "the flow updates a group record it did not create")
    }
    val client = setup.client

    // Bootstrap entity data from existing test data (no create step in flow).
    val groupRef01DataRaw = Struct.items(Helpers.toMapAny(
        Struct.getpath(setup.data, "existing.group")))
    val groupRef01Data: MutableMap<String, Any?> = if (groupRef01DataRaw.isEmpty())
        linkedMapOf() else (Helpers.toMapAny(groupRef01DataRaw[0][1]) ?: linkedMapOf())

    // UPDATE
    val groupRef01Ent = client.group(null)
    val groupRef01DataUp0Up = linkedMapOf<String, Any?>()
    groupRef01DataUp0Up["id"] = groupRef01Data["id"]

    val groupRef01MarkdefUp0Name = "created_by"
    val groupRef01MarkdefUp0Value = "Mark01-group_ref01_" + setup.now
    groupRef01DataUp0Up[groupRef01MarkdefUp0Name] = groupRef01MarkdefUp0Value

    val groupRef01ResdataUp0Result = groupRef01Ent.update(groupRef01DataUp0Up, null)
    val groupRef01ResdataUp0 = Helpers.toMapAny(if (groupRef01ResdataUp0Result is SdkEntity) groupRef01ResdataUp0Result.data() else groupRef01ResdataUp0Result) ?: linkedMapOf()
    assertNotNull(groupRef01ResdataUp0, "expected update result to be a map")
    assertEquals(groupRef01DataUp0Up["id"], groupRef01ResdataUp0["id"],
        "expected update result id to match")
    assertEquals(groupRef01MarkdefUp0Value, groupRef01ResdataUp0[groupRef01MarkdefUp0Name],
        "expected " + groupRef01MarkdefUp0Name + " to be updated")

    // LOAD
    val groupRef01MatchDt0 = linkedMapOf<String, Any?>()
    groupRef01MatchDt0["id"] = groupRef01Data["id"]
    val groupRef01DataDt0Loaded = groupRef01Ent.load(groupRef01MatchDt0, null)
    val groupRef01DataDt0LoadResult = Helpers.toMapAny(if (groupRef01DataDt0Loaded is SdkEntity) groupRef01DataDt0Loaded.data() else groupRef01DataDt0Loaded) ?: linkedMapOf()
    assertNotNull(groupRef01DataDt0LoadResult, "expected load result to be a map")
    assertEquals(groupRef01Data["id"], groupRef01DataDt0LoadResult["id"],
        "expected load result id to match")

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
      client.group(null).load(linkedMapOf<String, Any?>("id" to 1), null)
    }
    assertEquals("validate_failed", err.code)
  }

  companion object {
    fun groupBasicSetup(extra: MutableMap<String, Any?>?): RunnerSupport.EntityTestSetup {
      RunnerSupport.loadEnvLocal()

      val entityData: MutableMap<String, Any?>
      try {
        val entityDataSource = Files.readString(Paths.get(
            "..", ".sdk", "test", "entity", "group", "GroupTestData.json"))
        entityData = Helpers.toMapAny(Json.parse(entityDataSource)) ?: linkedMapOf()
      } catch (e: Exception) {
        throw AssertionError("failed to read group test data: " + e.message, e)
      }

      val options = linkedMapOf<String, Any?>()
      options["entity"] = entityData["existing"]

      var client = SmsapiSDK.testSDK(options, extra)

      // Generate idmap via transform, matching TS pattern.
      val idnames = mutableListOf<Any?>()
      idnames.add("group01")
      idnames.add("group02")
      idnames.add("group03")
      val idmap = Struct.transform(idnames, Json.parse(
          "{\"`\$PACK`\": [\"\", {" +
          "\"`\$KEY`\": \"`\$COPY`\"," +
          "\"`\$VAL`\": [\"`\$FORMAT`\", \"upper\", \"`\$COPY`\"]" +
          "}]}"))

      // Whether *_ENTID supplied the idmap, read before envOverride consumes it.
      val entidEnvRaw = RunnerSupport.getenv("SMSAPI_TEST_GROUP_ENTID")
      val idmapOverridden = entidEnvRaw != null && entidEnvRaw.trim().startsWith("{")

      val envm = linkedMapOf<String, Any?>()
      envm["SMSAPI_TEST_GROUP_ENTID"] = idmap
      envm["SMSAPI_TEST_LIVE"] = "FALSE"
      envm["SMSAPI_TEST_EXPLAIN"] = "FALSE"
      envm["SMSAPI_APIKEY"] = "NONE"
      val env = RunnerSupport.envOverride(envm)

      var idmapResolved = Helpers.toMapAny(env["SMSAPI_TEST_GROUP_ENTID"])
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
