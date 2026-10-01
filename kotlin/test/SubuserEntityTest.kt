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
class SubuserEntityTest {

  @Test
  fun instance() {
    val testsdk = SmsapiSDK.testSDK()
    val ent = testsdk.subuser(null)
    assertNotNull(ent, "expected non-null subuser entity")
  }

  @Test
  fun basic() {
    val setup = subuserBasicSetup(null)
    // Per-op sdk-test-control.json skip.
    val mode = if (setup.live) "live" else "unit"
    for (op in arrayOf<String>("create", "list", "update", "load", "remove")) {
      val reason = RunnerSupport.skipReason("entityOp", "subuser.$op", mode)
      Assumptions.assumeTrue(
        reason == null,
        if (reason == null || "" == reason) "skipped via sdk-test-control.json" else reason,
      )
    }
    Assumptions.assumeFalse(
      setup.syntheticOnly,
      "live entity test uses synthetic IDs from fixture — set SMSAPI_TEST_SUBUSER_ENTID JSON to run live",
    )
    val client = setup.client

    // CREATE
    val subuserRef01Ent = client.subuser(null)
    var subuserRef01Data: MutableMap<String, Any?> = (Helpers.toMapAny(Struct.getprop(
        Struct.getpath(setup.data, "new.subuser"), "subuser_ref01")) ?: linkedMapOf())

    val subuserRef01DataResult = subuserRef01Ent.create(subuserRef01Data, null)
    subuserRef01Data = Helpers.toMapAny(if (subuserRef01DataResult is SdkEntity) subuserRef01DataResult.data() else subuserRef01DataResult) ?: linkedMapOf()
    assertNotNull(subuserRef01Data, "expected create result to be a map")
    assertNotNull(subuserRef01Data["id"], "expected created entity to have an id")

    // LIST
    val subuserRef01Match = linkedMapOf<String, Any?>()

    val subuserRef01ListResult = subuserRef01Ent.list(subuserRef01Match, null)
    assertTrue(subuserRef01ListResult is List<*>,
        "expected list result to be an array, got " + subuserRef01ListResult)
    val subuserRef01List = subuserRef01ListResult as List<Any?>

    val foundItem = Struct.select(
        RunnerSupport.entityListToData(subuserRef01List),
        Struct.jm("id", subuserRef01Data["id"]))
    assertFalse(Struct.isempty(foundItem), "expected to find created entity in list")

    // UPDATE
    val subuserRef01DataUp0Up = linkedMapOf<String, Any?>()
    subuserRef01DataUp0Up["id"] = subuserRef01Data["id"]

    val subuserRef01MarkdefUp0Name = "description"
    val subuserRef01MarkdefUp0Value = "Mark01-subuser_ref01_" + setup.now
    subuserRef01DataUp0Up[subuserRef01MarkdefUp0Name] = subuserRef01MarkdefUp0Value

    val subuserRef01ResdataUp0Result = subuserRef01Ent.update(subuserRef01DataUp0Up, null)
    val subuserRef01ResdataUp0 = Helpers.toMapAny(if (subuserRef01ResdataUp0Result is SdkEntity) subuserRef01ResdataUp0Result.data() else subuserRef01ResdataUp0Result) ?: linkedMapOf()
    assertNotNull(subuserRef01ResdataUp0, "expected update result to be a map")
    assertEquals(subuserRef01DataUp0Up["id"], subuserRef01ResdataUp0["id"],
        "expected update result id to match")
    assertEquals(subuserRef01MarkdefUp0Value, subuserRef01ResdataUp0[subuserRef01MarkdefUp0Name],
        "expected " + subuserRef01MarkdefUp0Name + " to be updated")

    // LOAD
    val subuserRef01MatchDt0 = linkedMapOf<String, Any?>()
    subuserRef01MatchDt0["id"] = subuserRef01Data["id"]
    val subuserRef01DataDt0Loaded = subuserRef01Ent.load(subuserRef01MatchDt0, null)
    val subuserRef01DataDt0LoadResult = Helpers.toMapAny(if (subuserRef01DataDt0Loaded is SdkEntity) subuserRef01DataDt0Loaded.data() else subuserRef01DataDt0Loaded) ?: linkedMapOf()
    assertNotNull(subuserRef01DataDt0LoadResult, "expected load result to be a map")
    assertEquals(subuserRef01Data["id"], subuserRef01DataDt0LoadResult["id"],
        "expected load result id to match")

    // REMOVE
    val subuserRef01MatchRm0 = linkedMapOf<String, Any?>()
    subuserRef01MatchRm0["id"] = subuserRef01Data["id"]
    subuserRef01Ent.remove(subuserRef01MatchRm0, null)

    // LIST
    val subuserRef01MatchRt0 = linkedMapOf<String, Any?>()

    val subuserRef01ListRt0Result = subuserRef01Ent.list(subuserRef01MatchRt0, null)
    assertTrue(subuserRef01ListRt0Result is List<*>,
        "expected list result to be an array, got " + subuserRef01ListRt0Result)
    val subuserRef01ListRt0 = subuserRef01ListRt0Result as List<Any?>

    val notFoundItem = Struct.select(
        RunnerSupport.entityListToData(subuserRef01ListRt0),
        Struct.jm("id", subuserRef01Data["id"]))
    assertTrue(Struct.isempty(notFoundItem), "expected removed entity to not be in list")

  }

  @Test
  fun stream() {
    val streamingActive = linkedMapOf<String, Any?>(
      "feature" to linkedMapOf<String, Any?>(
        "streaming" to linkedMapOf<String, Any?>("active" to true),
      ),
    )
    val setup = subuserBasicSetup(streamingActive)
    Assumptions.assumeFalse(
      setup.live,
      "stream test streams the seeded fixture data (unit mode only)",
    )

    val ent = setup.client.subuser(null)
    val match = linkedMapOf<String, Any?>()

    // Materialised list result for the same op.
    val listedResult = ent.list(match, null)
    val listed = (listedResult as? List<Any?>) ?: emptyList<Any?>()

    // stream("list") yields items via the streaming feature's iterator.
    val streamed = ent.stream("list", match, null).toList()
    assertTrue(streamed.size > 0, "expected stream to yield items")
    assertEquals(listed.size, streamed.size, "expected stream to match list count")

    // Fallback: with streaming inactive, stream still yields the materialised
    // items.
    val setup2 = subuserBasicSetup(null)
    val ent2 = setup2.client.subuser(null)
    val streamed2 = ent2.stream("list", match, null).toList()
    assertEquals(listed.size, streamed2.size, "expected fallback stream to match list")
  }

  companion object {
    fun subuserBasicSetup(extra: MutableMap<String, Any?>?): RunnerSupport.EntityTestSetup {
      RunnerSupport.loadEnvLocal()

      val entityData: MutableMap<String, Any?>
      try {
        val entityDataSource = Files.readString(Paths.get(
            "..", ".sdk", "test", "entity", "subuser", "SubuserTestData.json"))
        entityData = Helpers.toMapAny(Json.parse(entityDataSource)) ?: linkedMapOf()
      } catch (e: Exception) {
        throw AssertionError("failed to read subuser test data: " + e.message, e)
      }

      val options = linkedMapOf<String, Any?>()
      options["entity"] = entityData["existing"]

      var client = SmsapiSDK.testSDK(options, extra)

      // Generate idmap via transform, matching TS pattern.
      val idnames = mutableListOf<Any?>()
      idnames.add("subuser01")
      idnames.add("subuser02")
      idnames.add("subuser03")
      val idmap = Struct.transform(idnames, Json.parse(
          "{\"`\$PACK`\": [\"\", {" +
          "\"`\$KEY`\": \"`\$COPY`\"," +
          "\"`\$VAL`\": [\"`\$FORMAT`\", \"upper\", \"`\$COPY`\"]" +
          "}]}"))

      // Detect ENTID env override before envOverride consumes it.
      val entidEnvRaw = RunnerSupport.getenv("SMSAPI_TEST_SUBUSER_ENTID")
      val idmapOverridden = entidEnvRaw != null && entidEnvRaw.trim().startsWith("{")

      val envm = linkedMapOf<String, Any?>()
      envm["SMSAPI_TEST_SUBUSER_ENTID"] = idmap
      envm["SMSAPI_TEST_LIVE"] = "FALSE"
      envm["SMSAPI_TEST_EXPLAIN"] = "FALSE"
      envm["SMSAPI_APIKEY"] = "NONE"
      val env = RunnerSupport.envOverride(envm)

      var idmapResolved = Helpers.toMapAny(env["SMSAPI_TEST_SUBUSER_ENTID"])
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
