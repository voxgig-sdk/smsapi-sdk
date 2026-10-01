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
class PermissionEntityTest {

  @Test
  fun instance() {
    val testsdk = SmsapiSDK.testSDK()
    val ent = testsdk.permission(null)
    assertNotNull(ent, "expected non-null permission entity")
  }

  @Test
  fun basic() {
    val setup = permissionBasicSetup(null)
    // Per-op sdk-test-control.json skip.
    val mode = if (setup.live) "live" else "unit"
    for (op in arrayOf<String>("create", "load")) {
      val reason = RunnerSupport.skipReason("entityOp", "permission.$op", mode)
      Assumptions.assumeTrue(
        reason == null,
        if (reason == null || "" == reason) "skipped via sdk-test-control.json" else reason,
      )
    }
    Assumptions.assumeFalse(
      setup.syntheticOnly,
      "live entity test uses synthetic IDs from fixture — set SMSAPI_TEST_PERMISSION_ENTID JSON to run live",
    )
    val client = setup.client

    // CREATE
    val permissionRef01Ent = client.permission(null)
    var permissionRef01Data: MutableMap<String, Any?> = (Helpers.toMapAny(Struct.getprop(
        Struct.getpath(setup.data, "new.permission"), "permission_ref01")) ?: linkedMapOf())
    permissionRef01Data["group_id"] = setup.idmap!!["group01"]

    val permissionRef01DataResult = permissionRef01Ent.create(permissionRef01Data, null)
    permissionRef01Data = Helpers.toMapAny(if (permissionRef01DataResult is SdkEntity) permissionRef01DataResult.data() else permissionRef01DataResult) ?: linkedMapOf()
    assertNotNull(permissionRef01Data, "expected create result to be a map")
    assertNotNull(permissionRef01Data["id"], "expected created entity to have an id")

    // LOAD
    val permissionRef01MatchDt0 = linkedMapOf<String, Any?>()
    permissionRef01MatchDt0["id"] = permissionRef01Data["id"]
    val permissionRef01DataDt0Loaded = permissionRef01Ent.load(permissionRef01MatchDt0, null)
    val permissionRef01DataDt0LoadResult = Helpers.toMapAny(if (permissionRef01DataDt0Loaded is SdkEntity) permissionRef01DataDt0Loaded.data() else permissionRef01DataDt0Loaded) ?: linkedMapOf()
    assertNotNull(permissionRef01DataDt0LoadResult, "expected load result to be a map")
    assertEquals(permissionRef01Data["id"], permissionRef01DataDt0LoadResult["id"],
        "expected load result id to match")

  }

  companion object {
    fun permissionBasicSetup(extra: MutableMap<String, Any?>?): RunnerSupport.EntityTestSetup {
      RunnerSupport.loadEnvLocal()

      val entityData: MutableMap<String, Any?>
      try {
        val entityDataSource = Files.readString(Paths.get(
            "..", ".sdk", "test", "entity", "permission", "PermissionTestData.json"))
        entityData = Helpers.toMapAny(Json.parse(entityDataSource)) ?: linkedMapOf()
      } catch (e: Exception) {
        throw AssertionError("failed to read permission test data: " + e.message, e)
      }

      val options = linkedMapOf<String, Any?>()
      options["entity"] = entityData["existing"]

      var client = SmsapiSDK.testSDK(options, extra)

      // Generate idmap via transform, matching TS pattern.
      val idnames = mutableListOf<Any?>()
      idnames.add("permission01")
      idnames.add("permission02")
      idnames.add("permission03")
      idnames.add("group01")
      idnames.add("group02")
      idnames.add("group03")
      val idmap = Struct.transform(idnames, Json.parse(
          "{\"`\$PACK`\": [\"\", {" +
          "\"`\$KEY`\": \"`\$COPY`\"," +
          "\"`\$VAL`\": [\"`\$FORMAT`\", \"upper\", \"`\$COPY`\"]" +
          "}]}"))

      // Detect ENTID env override before envOverride consumes it.
      val entidEnvRaw = RunnerSupport.getenv("SMSAPI_TEST_PERMISSION_ENTID")
      val idmapOverridden = entidEnvRaw != null && entidEnvRaw.trim().startsWith("{")

      val envm = linkedMapOf<String, Any?>()
      envm["SMSAPI_TEST_PERMISSION_ENTID"] = idmap
      envm["SMSAPI_TEST_LIVE"] = "FALSE"
      envm["SMSAPI_TEST_EXPLAIN"] = "FALSE"
      envm["SMSAPI_APIKEY"] = "NONE"
      val env = RunnerSupport.envOverride(envm)

      var idmapResolved = Helpers.toMapAny(env["SMSAPI_TEST_PERMISSION_ENTID"])
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
