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
class ContactsFieldEntityTest {

  // main.kit.test.live.strict is true (the default is true): a live
  // request that fails, or a live test missing an input it needs,
  // fails the test.
  // An account with no record for a test to read skips it either way.
  private val LIVE_STRICT = true

  @Test
  fun instance() {
    val testsdk = SmsapiSDK.testSDK()
    val ent = testsdk.contactsField(null)
    assertNotNull(ent, "expected non-null contacts_field entity")
  }

  @Test
  fun basic() {
    val setup = contactsFieldBasicSetup(null)
    // Per-op sdk-test-control.json skip.
    val mode = if (setup.live) "live" else "unit"
    for (op in arrayOf<String>("create", "list", "update", "remove")) {
      val reason = RunnerSupport.skipReason("entityOp", "contacts_field.$op", mode)
      Assumptions.assumeTrue(
        reason == null,
        if (reason == null || "" == reason) "skipped via sdk-test-control.json" else reason,
      )
    }
    val client = setup.client

    // CREATE
    val contactsFieldRef01Ent = client.contactsField(null)
    var contactsFieldRef01Data: MutableMap<String, Any?> = (Helpers.toMapAny(Struct.getprop(
        Struct.getpath(setup.data, "new.contacts_field"), "contacts_field_ref01")) ?: linkedMapOf())

    val contactsFieldRef01DataResult = contactsFieldRef01Ent.create(contactsFieldRef01Data, null)
    contactsFieldRef01Data = Helpers.toMapAny(if (contactsFieldRef01DataResult is SdkEntity) contactsFieldRef01DataResult.data() else contactsFieldRef01DataResult) ?: linkedMapOf()
    assertNotNull(contactsFieldRef01Data, "expected create result to be a map")
    assertNotNull(contactsFieldRef01Data["id"], "expected created entity to have an id")

    // LIST
    val contactsFieldRef01Match = linkedMapOf<String, Any?>()

    val contactsFieldRef01ListResult = contactsFieldRef01Ent.list(contactsFieldRef01Match, null)
    assertTrue(contactsFieldRef01ListResult is List<*>,
        "expected list result to be an array, got " + contactsFieldRef01ListResult)
    val contactsFieldRef01List = contactsFieldRef01ListResult as List<Any?>

    val foundItem = Struct.select(
        RunnerSupport.entityListToData(contactsFieldRef01List),
        Struct.jm("id", contactsFieldRef01Data["id"]))
    assertFalse(Struct.isempty(foundItem), "expected to find created entity in list")

    // UPDATE
    val contactsFieldRef01DataUp0Up = linkedMapOf<String, Any?>()
    contactsFieldRef01DataUp0Up["id"] = contactsFieldRef01Data["id"]

    val contactsFieldRef01MarkdefUp0Name = "name"
    val contactsFieldRef01MarkdefUp0Value = "Mark01-contacts_field_ref01_" + setup.now
    contactsFieldRef01DataUp0Up[contactsFieldRef01MarkdefUp0Name] = contactsFieldRef01MarkdefUp0Value

    val contactsFieldRef01ResdataUp0Result = contactsFieldRef01Ent.update(contactsFieldRef01DataUp0Up, null)
    val contactsFieldRef01ResdataUp0 = Helpers.toMapAny(if (contactsFieldRef01ResdataUp0Result is SdkEntity) contactsFieldRef01ResdataUp0Result.data() else contactsFieldRef01ResdataUp0Result) ?: linkedMapOf()
    assertNotNull(contactsFieldRef01ResdataUp0, "expected update result to be a map")
    assertEquals(contactsFieldRef01DataUp0Up["id"], contactsFieldRef01ResdataUp0["id"],
        "expected update result id to match")
    assertEquals(contactsFieldRef01MarkdefUp0Value, contactsFieldRef01ResdataUp0[contactsFieldRef01MarkdefUp0Name],
        "expected " + contactsFieldRef01MarkdefUp0Name + " to be updated")

    // REMOVE
    val contactsFieldRef01MatchRm0 = linkedMapOf<String, Any?>()
    contactsFieldRef01MatchRm0["id"] = contactsFieldRef01Data["id"]
    contactsFieldRef01Ent.remove(contactsFieldRef01MatchRm0, null)

    // LIST
    val contactsFieldRef01MatchRt0 = linkedMapOf<String, Any?>()

    val contactsFieldRef01ListRt0Result = contactsFieldRef01Ent.list(contactsFieldRef01MatchRt0, null)
    assertTrue(contactsFieldRef01ListRt0Result is List<*>,
        "expected list result to be an array, got " + contactsFieldRef01ListRt0Result)
    val contactsFieldRef01ListRt0 = contactsFieldRef01ListRt0Result as List<Any?>

    val notFoundItem = Struct.select(
        RunnerSupport.entityListToData(contactsFieldRef01ListRt0),
        Struct.jm("id", contactsFieldRef01Data["id"]))
    assertTrue(Struct.isempty(notFoundItem), "expected removed entity to not be in list")

  }

  @Test
  fun stream() {
    val streamingActive = linkedMapOf<String, Any?>(
      "feature" to linkedMapOf<String, Any?>(
        "streaming" to linkedMapOf<String, Any?>("active" to true),
      ),
    )
    val setup = contactsFieldBasicSetup(streamingActive)
    Assumptions.assumeFalse(
      setup.live,
      "stream test streams the seeded fixture data (unit mode only)",
    )

    val ent = setup.client.contactsField(null)
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
    val setup2 = contactsFieldBasicSetup(null)
    val ent2 = setup2.client.contactsField(null)
    val streamed2 = ent2.stream("list", match, null).toList()
    assertEquals(listed.size, streamed2.size, "expected fallback stream to match list")
  }

  private fun hasFeature(name: String): Boolean {
    val fm = Helpers.toMapAny(Config.sharedConfig()["feature"])
    return fm != null && fm[name] != null
  }

  class FailHook : BaseFeature("failhook", "0.0.1", true) {
    var unexpected = 0
    override fun preSpec(ctx: Context) { throw RuntimeException("contacts_field hook failed") }
    override fun preUnexpected(ctx: Context) { unexpected++ }
  }

  @Test
  fun streamError() {
    val offline = linkedMapOf<String, Any?>("net" to linkedMapOf<String, Any?>("offline" to true))
    val err = assertThrows(RuntimeException::class.java) {
      SmsapiSDK.testSDK(offline, null).contactsField(null).stream("list", null, null).toList()
    }
    assertTrue(err.message.orEmpty().contains("offline"), err.message)

    SmsapiSDK.testSDK(offline, null).contactsField(null).stream("list", null,
      linkedMapOf<String, Any?>("ctrl" to linkedMapOf<String, Any?>("throw" to false))).toList()

    if (hasFeature("rbac")) {
      val denied = SmsapiSDK.testSDK(null, linkedMapOf<String, Any?>(
        "feature" to linkedMapOf<String, Any?>(
          "rbac" to linkedMapOf<String, Any?>("active" to true, "deny" to true))))
      val denyerr = assertThrows(SdkError::class.java) {
        denied.contactsField(null).stream("list", null, null).toList()
      }
      assertEquals("rbac_denied", denyerr.code)
    }
  }

  @Test
  fun streamCtrl() {
    val explain = linkedMapOf<String, Any?>()
    val ctrl = linkedMapOf<String, Any?>("explain" to explain)
    SmsapiSDK.testSDK().contactsField(null).stream("list", null,
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
      client.contactsField(null).list(null, null)
    }
    assertTrue(err.message.orEmpty().contains("hook failed"), err.message)
    assertTrue(0 < hook.unexpected)

    val fired = hook.unexpected
    client.contactsField(null).list(null, linkedMapOf<String, Any?>("throw" to false))
    assertTrue(fired < hook.unexpected)
  }

  @Test
  fun validate() {
    Assumptions.assumeTrue(hasFeature("validate"), "feature not present in this SDK: validate")
    val client = SmsapiSDK.testSDK(null, linkedMapOf<String, Any?>(
      "feature" to linkedMapOf<String, Any?>(
        "validate" to linkedMapOf<String, Any?>("active" to true))))
    val err = assertThrows(SdkError::class.java) {
      client.contactsField(null).list(linkedMapOf<String, Any?>("id" to 1), null)
    }
    assertEquals("validate_failed", err.code)
  }

  companion object {
    fun contactsFieldBasicSetup(extra: MutableMap<String, Any?>?): RunnerSupport.EntityTestSetup {
      RunnerSupport.loadEnvLocal()

      val entityData: MutableMap<String, Any?>
      try {
        val entityDataSource = Files.readString(Paths.get(
            "..", ".sdk", "test", "entity", "contacts_field", "ContactsFieldTestData.json"))
        entityData = Helpers.toMapAny(Json.parse(entityDataSource)) ?: linkedMapOf()
      } catch (e: Exception) {
        throw AssertionError("failed to read contacts_field test data: " + e.message, e)
      }

      val options = linkedMapOf<String, Any?>()
      options["entity"] = entityData["existing"]

      var client = SmsapiSDK.testSDK(options, extra)

      // Generate idmap via transform, matching TS pattern.
      val idnames = mutableListOf<Any?>()
      idnames.add("contacts_field01")
      idnames.add("contacts_field02")
      idnames.add("contacts_field03")
      val idmap = Struct.transform(idnames, Json.parse(
          "{\"`\$PACK`\": [\"\", {" +
          "\"`\$KEY`\": \"`\$COPY`\"," +
          "\"`\$VAL`\": [\"`\$FORMAT`\", \"upper\", \"`\$COPY`\"]" +
          "}]}"))

      // Whether *_ENTID supplied the idmap, read before envOverride consumes it.
      val entidEnvRaw = RunnerSupport.getenv("SMSAPI_TEST_CONTACTS_FIELD_ENTID")
      val idmapOverridden = entidEnvRaw != null && entidEnvRaw.trim().startsWith("{")

      val envm = linkedMapOf<String, Any?>()
      envm["SMSAPI_TEST_CONTACTS_FIELD_ENTID"] = idmap
      envm["SMSAPI_TEST_LIVE"] = "FALSE"
      envm["SMSAPI_TEST_EXPLAIN"] = "FALSE"
      envm["SMSAPI_APIKEY"] = "NONE"
      val env = RunnerSupport.envOverride(envm)

      var idmapResolved = Helpers.toMapAny(env["SMSAPI_TEST_CONTACTS_FIELD_ENTID"])
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
