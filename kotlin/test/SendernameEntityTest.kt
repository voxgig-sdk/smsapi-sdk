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
class SendernameEntityTest {

  @Test
  fun instance() {
    val testsdk = SmsapiSDK.testSDK()
    val ent = testsdk.sendername(null)
    assertNotNull(ent, "expected non-null sendername entity")
  }

  @Test
  fun basic() {
    val setup = sendernameBasicSetup(null)
    // Per-op sdk-test-control.json skip.
    val mode = if (setup.live) "live" else "unit"
    for (op in arrayOf<String>("create", "list", "load")) {
      val reason = RunnerSupport.skipReason("entityOp", "sendername.$op", mode)
      Assumptions.assumeTrue(
        reason == null,
        if (reason == null || "" == reason) "skipped via sdk-test-control.json" else reason,
      )
    }
    Assumptions.assumeFalse(
      setup.syntheticOnly,
      "live entity test uses synthetic IDs from fixture — set SMSAPI_TEST_SENDERNAME_ENTID JSON to run live",
    )
    val client = setup.client

    // CREATE
    val sendernameRef01Ent = client.sendername(null)
    var sendernameRef01Data: MutableMap<String, Any?> = (Helpers.toMapAny(Struct.getprop(
        Struct.getpath(setup.data, "new.sendername"), "sendername_ref01")) ?: linkedMapOf())

    val sendernameRef01DataResult = sendernameRef01Ent.create(sendernameRef01Data, null)
    sendernameRef01Data = Helpers.toMapAny(if (sendernameRef01DataResult is SdkEntity) sendernameRef01DataResult.data() else sendernameRef01DataResult) ?: linkedMapOf()
    assertNotNull(sendernameRef01Data, "expected create result to be a map")
    assertNotNull(sendernameRef01Data["id"], "expected created entity to have an id")

    // LIST
    val sendernameRef01Match = linkedMapOf<String, Any?>()

    val sendernameRef01ListResult = sendernameRef01Ent.list(sendernameRef01Match, null)
    assertTrue(sendernameRef01ListResult is List<*>,
        "expected list result to be an array, got " + sendernameRef01ListResult)
    val sendernameRef01List = sendernameRef01ListResult as List<Any?>

    val foundItem = Struct.select(
        RunnerSupport.entityListToData(sendernameRef01List),
        Struct.jm("id", sendernameRef01Data["id"]))
    assertFalse(Struct.isempty(foundItem), "expected to find created entity in list")

    // LOAD
    val sendernameRef01MatchDt0 = linkedMapOf<String, Any?>()
    sendernameRef01MatchDt0["id"] = sendernameRef01Data["id"]
    val sendernameRef01DataDt0Loaded = sendernameRef01Ent.load(sendernameRef01MatchDt0, null)
    val sendernameRef01DataDt0LoadResult = Helpers.toMapAny(if (sendernameRef01DataDt0Loaded is SdkEntity) sendernameRef01DataDt0Loaded.data() else sendernameRef01DataDt0Loaded) ?: linkedMapOf()
    assertNotNull(sendernameRef01DataDt0LoadResult, "expected load result to be a map")
    assertEquals(sendernameRef01Data["id"], sendernameRef01DataDt0LoadResult["id"],
        "expected load result id to match")

  }

  @Test
  fun stream() {
    val streamingActive = linkedMapOf<String, Any?>(
      "feature" to linkedMapOf<String, Any?>(
        "streaming" to linkedMapOf<String, Any?>("active" to true),
      ),
    )
    val setup = sendernameBasicSetup(streamingActive)
    Assumptions.assumeFalse(
      setup.live,
      "stream test streams the seeded fixture data (unit mode only)",
    )

    val ent = setup.client.sendername(null)
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
    val setup2 = sendernameBasicSetup(null)
    val ent2 = setup2.client.sendername(null)
    val streamed2 = ent2.stream("list", match, null).toList()
    assertEquals(listed.size, streamed2.size, "expected fallback stream to match list")
  }

  companion object {
    fun sendernameBasicSetup(extra: MutableMap<String, Any?>?): RunnerSupport.EntityTestSetup {
      RunnerSupport.loadEnvLocal()

      val entityData: MutableMap<String, Any?>
      try {
        val entityDataSource = Files.readString(Paths.get(
            "..", ".sdk", "test", "entity", "sendername", "SendernameTestData.json"))
        entityData = Helpers.toMapAny(Json.parse(entityDataSource)) ?: linkedMapOf()
      } catch (e: Exception) {
        throw AssertionError("failed to read sendername test data: " + e.message, e)
      }

      val options = linkedMapOf<String, Any?>()
      options["entity"] = entityData["existing"]

      var client = SmsapiSDK.testSDK(options, extra)

      // Generate idmap via transform, matching TS pattern.
      val idnames = mutableListOf<Any?>()
      idnames.add("sendername01")
      idnames.add("sendername02")
      idnames.add("sendername03")
      val idmap = Struct.transform(idnames, Json.parse(
          "{\"`\$PACK`\": [\"\", {" +
          "\"`\$KEY`\": \"`\$COPY`\"," +
          "\"`\$VAL`\": [\"`\$FORMAT`\", \"upper\", \"`\$COPY`\"]" +
          "}]}"))

      // Detect ENTID env override before envOverride consumes it.
      val entidEnvRaw = RunnerSupport.getenv("SMSAPI_TEST_SENDERNAME_ENTID")
      val idmapOverridden = entidEnvRaw != null && entidEnvRaw.trim().startsWith("{")

      val envm = linkedMapOf<String, Any?>()
      envm["SMSAPI_TEST_SENDERNAME_ENTID"] = idmap
      envm["SMSAPI_TEST_LIVE"] = "FALSE"
      envm["SMSAPI_TEST_EXPLAIN"] = "FALSE"
      envm["SMSAPI_APIKEY"] = "NONE"
      val env = RunnerSupport.envOverride(envm)

      var idmapResolved = Helpers.toMapAny(env["SMSAPI_TEST_SENDERNAME_ENTID"])
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
