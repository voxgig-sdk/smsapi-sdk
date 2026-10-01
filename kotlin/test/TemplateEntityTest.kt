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
class TemplateEntityTest {

  @Test
  fun instance() {
    val testsdk = SmsapiSDK.testSDK()
    val ent = testsdk.template(null)
    assertNotNull(ent, "expected non-null template entity")
  }

  @Test
  fun basic() {
    val setup = templateBasicSetup(null)
    // Per-op sdk-test-control.json skip.
    val mode = if (setup.live) "live" else "unit"
    for (op in arrayOf<String>("create", "list", "update", "load")) {
      val reason = RunnerSupport.skipReason("entityOp", "template.$op", mode)
      Assumptions.assumeTrue(
        reason == null,
        if (reason == null || "" == reason) "skipped via sdk-test-control.json" else reason,
      )
    }
    Assumptions.assumeFalse(
      setup.syntheticOnly,
      "live entity test uses synthetic IDs from fixture — set SMSAPI_TEST_TEMPLATE_ENTID JSON to run live",
    )
    val client = setup.client

    // CREATE
    val templateRef01Ent = client.template(null)
    var templateRef01Data: MutableMap<String, Any?> = (Helpers.toMapAny(Struct.getprop(
        Struct.getpath(setup.data, "new.template"), "template_ref01")) ?: linkedMapOf())

    val templateRef01DataResult = templateRef01Ent.create(templateRef01Data, null)
    templateRef01Data = Helpers.toMapAny(if (templateRef01DataResult is SdkEntity) templateRef01DataResult.data() else templateRef01DataResult) ?: linkedMapOf()
    assertNotNull(templateRef01Data, "expected create result to be a map")
    assertNotNull(templateRef01Data["id"], "expected created entity to have an id")

    // LIST
    val templateRef01Match = linkedMapOf<String, Any?>()

    val templateRef01ListResult = templateRef01Ent.list(templateRef01Match, null)
    assertTrue(templateRef01ListResult is List<*>,
        "expected list result to be an array, got " + templateRef01ListResult)
    val templateRef01List = templateRef01ListResult as List<Any?>

    val foundItem = Struct.select(
        RunnerSupport.entityListToData(templateRef01List),
        Struct.jm("id", templateRef01Data["id"]))
    assertFalse(Struct.isempty(foundItem), "expected to find created entity in list")

    // UPDATE
    val templateRef01DataUp0Up = linkedMapOf<String, Any?>()
    templateRef01DataUp0Up["id"] = templateRef01Data["id"]

    val templateRef01MarkdefUp0Name = "name"
    val templateRef01MarkdefUp0Value = "Mark01-template_ref01_" + setup.now
    templateRef01DataUp0Up[templateRef01MarkdefUp0Name] = templateRef01MarkdefUp0Value

    val templateRef01ResdataUp0Result = templateRef01Ent.update(templateRef01DataUp0Up, null)
    val templateRef01ResdataUp0 = Helpers.toMapAny(if (templateRef01ResdataUp0Result is SdkEntity) templateRef01ResdataUp0Result.data() else templateRef01ResdataUp0Result) ?: linkedMapOf()
    assertNotNull(templateRef01ResdataUp0, "expected update result to be a map")
    assertEquals(templateRef01DataUp0Up["id"], templateRef01ResdataUp0["id"],
        "expected update result id to match")
    assertEquals(templateRef01MarkdefUp0Value, templateRef01ResdataUp0[templateRef01MarkdefUp0Name],
        "expected " + templateRef01MarkdefUp0Name + " to be updated")

    // LOAD
    val templateRef01MatchDt0 = linkedMapOf<String, Any?>()
    templateRef01MatchDt0["id"] = templateRef01Data["id"]
    val templateRef01DataDt0Loaded = templateRef01Ent.load(templateRef01MatchDt0, null)
    val templateRef01DataDt0LoadResult = Helpers.toMapAny(if (templateRef01DataDt0Loaded is SdkEntity) templateRef01DataDt0Loaded.data() else templateRef01DataDt0Loaded) ?: linkedMapOf()
    assertNotNull(templateRef01DataDt0LoadResult, "expected load result to be a map")
    assertEquals(templateRef01Data["id"], templateRef01DataDt0LoadResult["id"],
        "expected load result id to match")

  }

  @Test
  fun stream() {
    val streamingActive = linkedMapOf<String, Any?>(
      "feature" to linkedMapOf<String, Any?>(
        "streaming" to linkedMapOf<String, Any?>("active" to true),
      ),
    )
    val setup = templateBasicSetup(streamingActive)
    Assumptions.assumeFalse(
      setup.live,
      "stream test streams the seeded fixture data (unit mode only)",
    )

    val ent = setup.client.template(null)
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
    val setup2 = templateBasicSetup(null)
    val ent2 = setup2.client.template(null)
    val streamed2 = ent2.stream("list", match, null).toList()
    assertEquals(listed.size, streamed2.size, "expected fallback stream to match list")
  }

  companion object {
    fun templateBasicSetup(extra: MutableMap<String, Any?>?): RunnerSupport.EntityTestSetup {
      RunnerSupport.loadEnvLocal()

      val entityData: MutableMap<String, Any?>
      try {
        val entityDataSource = Files.readString(Paths.get(
            "..", ".sdk", "test", "entity", "template", "TemplateTestData.json"))
        entityData = Helpers.toMapAny(Json.parse(entityDataSource)) ?: linkedMapOf()
      } catch (e: Exception) {
        throw AssertionError("failed to read template test data: " + e.message, e)
      }

      val options = linkedMapOf<String, Any?>()
      options["entity"] = entityData["existing"]

      var client = SmsapiSDK.testSDK(options, extra)

      // Generate idmap via transform, matching TS pattern.
      val idnames = mutableListOf<Any?>()
      idnames.add("template01")
      idnames.add("template02")
      idnames.add("template03")
      val idmap = Struct.transform(idnames, Json.parse(
          "{\"`\$PACK`\": [\"\", {" +
          "\"`\$KEY`\": \"`\$COPY`\"," +
          "\"`\$VAL`\": [\"`\$FORMAT`\", \"upper\", \"`\$COPY`\"]" +
          "}]}"))

      // Detect ENTID env override before envOverride consumes it.
      val entidEnvRaw = RunnerSupport.getenv("SMSAPI_TEST_TEMPLATE_ENTID")
      val idmapOverridden = entidEnvRaw != null && entidEnvRaw.trim().startsWith("{")

      val envm = linkedMapOf<String, Any?>()
      envm["SMSAPI_TEST_TEMPLATE_ENTID"] = idmap
      envm["SMSAPI_TEST_LIVE"] = "FALSE"
      envm["SMSAPI_TEST_EXPLAIN"] = "FALSE"
      envm["SMSAPI_APIKEY"] = "NONE"
      val env = RunnerSupport.envOverride(envm)

      var idmapResolved = Helpers.toMapAny(env["SMSAPI_TEST_TEMPLATE_ENTID"])
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
