// Generated basic-flow test for the sent_rcs_message entity (model-driven;
// mirrors the java TestEntity generator). A dependency-free scala-cli test
// object driven by SdkEntityTestMain. Runs against the in-memory test
// transport seeded with the shipped SentRcsMessageTestData.json fixtures.

import java.util.{ArrayList, LinkedHashMap, List => JList, Map => JMap}

import voxgig.smsapisdk.core.{Helpers, SdkEntity, SmsapiSDK}
import voxgig.smsapisdk.utility.struct.Struct

object SentRcsMessageEntityTest {

  def run(rep: SdkTestReport): Unit = {
    rep.scope("sent_rcs_message.instance") {
      val testsdk = SmsapiSDK.testSDK()
      val ent = testsdk.sentRcsMessage(null)
      rep.check("sent_rcs_message.instance", ent != null, "expected non-null sent_rcs_message entity")
    }

    rep.scope("sent_rcs_message.basic") {
      val entityData = Helpers.toMapAny(SdkTestSupport.readJson(
          "../.sdk/test/entity/sent_rcs_message/SentRcsMessageTestData.json"))
      val options = new LinkedHashMap[String, Object]()
      options.put("entity", entityData.get("existing"))
      val client = SmsapiSDK.testSDK(options, null)

      val idmap = new LinkedHashMap[String, Object]()
      idmap.put("sent_rcs_message01", "SENT_RCS_MESSAGE01")
      idmap.put("sent_rcs_message02", "SENT_RCS_MESSAGE02")
      idmap.put("sent_rcs_message03", "SENT_RCS_MESSAGE03")
      val now = System.currentTimeMillis()

      // CREATE
      val sentRcsMessageRef01Ent = client.sentRcsMessage(null)
      var sentRcsMessageRef01Data = Helpers.toMapAny(Struct.getprop(
          Struct.getpath(entityData, "new.sent_rcs_message"), "sent_rcs_message_ref01"))
      val sentRcsMessageRef01DataResult = sentRcsMessageRef01Ent.create(sentRcsMessageRef01Data, null)
      sentRcsMessageRef01Data = Helpers.toMapAny(sentRcsMessageRef01DataResult match { case e: SdkEntity => e.data(); case o => o })
      rep.check("sent_rcs_message.create.map", sentRcsMessageRef01Data != null, "expected create result to be a map")
    }
  }
}
