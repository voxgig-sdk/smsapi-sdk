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
class ContactEntityTest {

  // main.kit.test.live.strict is true (the default is true): a live
  // request that fails, or a live test missing an input it needs,
  // fails the test.
  // An account with no record for a test to read skips it either way.
  private val LIVE_STRICT = true

  @Test
  fun instance() {
    val testsdk = SmsapiSDK.testSDK()
    val ent = testsdk.contact(null)
    assertNotNull(ent, "expected non-null contact entity")
  }

  @Test
  fun basic() {
    val setup = contactBasicSetup(null)
    // Per-op sdk-test-control.json skip.
    val mode = if (setup.live) "live" else "unit"
    for (op in arrayOf<String>("create", "list", "update", "load", "remove")) {
      val reason = RunnerSupport.skipReason("entityOp", "contact.$op", mode)
      Assumptions.assumeTrue(
        reason == null,
        if (reason == null || "" == reason) "skipped via sdk-test-control.json" else reason,
      )
    }
    if (setup.live) {
      for (liveKey in arrayOf<String>("group01")) {
        if (setup.syntheticOnly || setup.idmap?.get(liveKey) == null) {
          RunnerSupport.liveMiss(LIVE_STRICT, "Live entity test blocked: needs " + liveKey + " via SMSAPI_TEST_CONTACT_ENTID")
        }
      }
    }
    val client = setup.client

    // CREATE
    val contactRef01Ent = client.contact(null)
    var contactRef01Data: MutableMap<String, Any?> = (Helpers.toMapAny(Struct.getprop(
        Struct.getpath(setup.data, "new.contact"), "contact_ref01")) ?: linkedMapOf())
    contactRef01Data["group_id"] = setup.idmap!!["group01"]

    val contactRef01DataResult = contactRef01Ent.create(contactRef01Data, null)
    contactRef01Data = Helpers.toMapAny(if (contactRef01DataResult is SdkEntity) contactRef01DataResult.data() else contactRef01DataResult) ?: linkedMapOf()
    assertNotNull(contactRef01Data, "expected create result to be a map")
    assertNotNull(contactRef01Data["id"], "expected created entity to have an id")

    // LIST
    val contactRef01Match = linkedMapOf<String, Any?>()

    val contactRef01ListResult = contactRef01Ent.list(contactRef01Match, null)
    assertTrue(contactRef01ListResult is List<*>,
        "expected list result to be an array, got " + contactRef01ListResult)
    val contactRef01List = contactRef01ListResult as List<Any?>

    val foundItem = Struct.select(
        RunnerSupport.entityListToData(contactRef01List),
        Struct.jm("id", contactRef01Data["id"]))
    assertFalse(Struct.isempty(foundItem), "expected to find created entity in list")

    // UPDATE
    val contactRef01DataUp0Up = linkedMapOf<String, Any?>()
    contactRef01DataUp0Up["id"] = contactRef01Data["id"]

    val contactRef01MarkdefUp0Name = "birthday_date"
    val contactRef01MarkdefUp0Value = "Mark01-contact_ref01_" + setup.now
    contactRef01DataUp0Up[contactRef01MarkdefUp0Name] = contactRef01MarkdefUp0Value

    val contactRef01ResdataUp0Result = contactRef01Ent.update(contactRef01DataUp0Up, null)
    val contactRef01ResdataUp0 = Helpers.toMapAny(if (contactRef01ResdataUp0Result is SdkEntity) contactRef01ResdataUp0Result.data() else contactRef01ResdataUp0Result) ?: linkedMapOf()
    assertNotNull(contactRef01ResdataUp0, "expected update result to be a map")
    assertEquals(contactRef01DataUp0Up["id"], contactRef01ResdataUp0["id"],
        "expected update result id to match")
    assertEquals(contactRef01MarkdefUp0Value, contactRef01ResdataUp0[contactRef01MarkdefUp0Name],
        "expected " + contactRef01MarkdefUp0Name + " to be updated")

    // LOAD
    val contactRef01MatchDt0 = linkedMapOf<String, Any?>()
    contactRef01MatchDt0["id"] = contactRef01Data["id"]
    val contactRef01DataDt0Loaded = contactRef01Ent.load(contactRef01MatchDt0, null)
    val contactRef01DataDt0LoadResult = Helpers.toMapAny(if (contactRef01DataDt0Loaded is SdkEntity) contactRef01DataDt0Loaded.data() else contactRef01DataDt0Loaded) ?: linkedMapOf()
    assertNotNull(contactRef01DataDt0LoadResult, "expected load result to be a map")
    assertEquals(contactRef01Data["id"], contactRef01DataDt0LoadResult["id"],
        "expected load result id to match")

    // REMOVE
    val contactRef01MatchRm0 = linkedMapOf<String, Any?>()
    contactRef01MatchRm0["id"] = contactRef01Data["id"]
    contactRef01Ent.remove(contactRef01MatchRm0, null)

    // LIST
    val contactRef01MatchRt0 = linkedMapOf<String, Any?>()

    val contactRef01ListRt0Result = contactRef01Ent.list(contactRef01MatchRt0, null)
    assertTrue(contactRef01ListRt0Result is List<*>,
        "expected list result to be an array, got " + contactRef01ListRt0Result)
    val contactRef01ListRt0 = contactRef01ListRt0Result as List<Any?>

    val notFoundItem = Struct.select(
        RunnerSupport.entityListToData(contactRef01ListRt0),
        Struct.jm("id", contactRef01Data["id"]))
    assertTrue(Struct.isempty(notFoundItem), "expected removed entity to not be in list")

  }

  @Test
  fun stream() {
    val streamingActive = linkedMapOf<String, Any?>(
      "feature" to linkedMapOf<String, Any?>(
        "streaming" to linkedMapOf<String, Any?>("active" to true),
      ),
    )
    val setup = contactBasicSetup(streamingActive)
    Assumptions.assumeFalse(
      setup.live,
      "stream test streams the seeded fixture data (unit mode only)",
    )

    val ent = setup.client.contact(null)
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
    val setup2 = contactBasicSetup(null)
    val ent2 = setup2.client.contact(null)
    val streamed2 = ent2.stream("list", match, null).toList()
    assertEquals(listed.size, streamed2.size, "expected fallback stream to match list")
  }

  private fun hasFeature(name: String): Boolean {
    val fm = Helpers.toMapAny(Config.sharedConfig()["feature"])
    return fm != null && fm[name] != null
  }

  class FailHook : BaseFeature("failhook", "0.0.1", true) {
    var unexpected = 0
    override fun preSpec(ctx: Context) { throw RuntimeException("contact hook failed") }
    override fun preUnexpected(ctx: Context) { unexpected++ }
  }

  @Test
  fun streamError() {
    val offline = linkedMapOf<String, Any?>("net" to linkedMapOf<String, Any?>("offline" to true))
    val err = assertThrows(RuntimeException::class.java) {
      SmsapiSDK.testSDK(offline, null).contact(null).stream("list", null, null).toList()
    }
    assertTrue(err.message.orEmpty().contains("offline"), err.message)

    SmsapiSDK.testSDK(offline, null).contact(null).stream("list", null,
      linkedMapOf<String, Any?>("ctrl" to linkedMapOf<String, Any?>("throw" to false))).toList()

    if (hasFeature("rbac")) {
      val denied = SmsapiSDK.testSDK(null, linkedMapOf<String, Any?>(
        "feature" to linkedMapOf<String, Any?>(
          "rbac" to linkedMapOf<String, Any?>("active" to true, "deny" to true))))
      val denyerr = assertThrows(SdkError::class.java) {
        denied.contact(null).stream("list", null, null).toList()
      }
      assertEquals("rbac_denied", denyerr.code)
    }
  }

  @Test
  fun streamCtrl() {
    val explain = linkedMapOf<String, Any?>()
    val ctrl = linkedMapOf<String, Any?>("explain" to explain)
    SmsapiSDK.testSDK().contact(null).stream("list", null,
      linkedMapOf<String, Any?>("ctrl" to ctrl)).toList()
    assertEquals(listOf("explain"), ctrl.keys.toList())
    assertTrue(explain === ctrl["explain"] && explain.isNotEmpty())
  }

  @Test
  fun unexpected() {
    val hook = FailHook()
    val client = SmsapiSDK(linkedMapOf<String, Any?>(
      "feature" to linkedMapOf<String, Any?>("test" to linkedMapOf<String, Any?>("active" to true)),
      "extend" to mutableListOf<Any?>(hook)))

    val err = assertThrows(RuntimeException::class.java) {
      client.contact(null).list(null, null)
    }
    assertTrue(err.message.orEmpty().contains("hook failed"), err.message)
    assertTrue(0 < hook.unexpected)

    val fired = hook.unexpected
    client.contact(null).list(null, linkedMapOf<String, Any?>("throw" to false))
    assertTrue(fired < hook.unexpected)
  }

  @Test
  fun validate() {
    Assumptions.assumeTrue(hasFeature("validate"), "feature not present in this SDK: validate")
    val client = SmsapiSDK.testSDK(null, linkedMapOf<String, Any?>(
      "feature" to linkedMapOf<String, Any?>(
        "validate" to linkedMapOf<String, Any?>("active" to true))))
    val err = assertThrows(SdkError::class.java) {
      client.contact(null).list(linkedMapOf<String, Any?>("gender" to 1), null)
    }
    assertEquals("validate_failed", err.code)
  }

  companion object {
    fun contactBasicSetup(extra: MutableMap<String, Any?>?): RunnerSupport.EntityTestSetup {
      RunnerSupport.loadEnvLocal()

      val entityData: MutableMap<String, Any?>
      try {
        val entityDataSource = Files.readString(Paths.get(
            "..", ".sdk", "test", "entity", "contact", "ContactTestData.json"))
        entityData = Helpers.toMapAny(Json.parse(entityDataSource)) ?: linkedMapOf()
      } catch (e: Exception) {
        throw AssertionError("failed to read contact test data: " + e.message, e)
      }

      val options = linkedMapOf<String, Any?>()
      options["entity"] = entityData["existing"]

      var client = SmsapiSDK.testSDK(options, extra)

      // Generate idmap via transform, matching TS pattern.
      val idnames = mutableListOf<Any?>()
      idnames.add("contact01")
      idnames.add("contact02")
      idnames.add("contact03")
      idnames.add("group01")
      idnames.add("group02")
      idnames.add("group03")
      val idmap = Struct.transform(idnames, Json.parse(
          "{\"`\$PACK`\": [\"\", {" +
          "\"`\$KEY`\": \"`\$COPY`\"," +
          "\"`\$VAL`\": [\"`\$FORMAT`\", \"upper\", \"`\$COPY`\"]" +
          "}]}"))

      // Whether *_ENTID supplied the idmap, read before envOverride consumes it.
      val entidEnvRaw = RunnerSupport.getenv("SMSAPI_TEST_CONTACT_ENTID")
      val idmapOverridden = entidEnvRaw != null && entidEnvRaw.trim().startsWith("{")

      val envm = linkedMapOf<String, Any?>()
      envm["SMSAPI_TEST_CONTACT_ENTID"] = idmap
      envm["SMSAPI_TEST_LIVE"] = "FALSE"
      envm["SMSAPI_TEST_EXPLAIN"] = "FALSE"
      envm["SMSAPI_APIKEY"] = "NONE"
      val env = RunnerSupport.envOverride(envm)

      var idmapResolved = Helpers.toMapAny(env["SMSAPI_TEST_CONTACT_ENTID"])
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
