// Generated basic-flow test for the smssendername entity (model-driven;
// mirrors the java TestEntity generator). A dependency-free scala-cli test
// object driven by SdkEntityTestMain. Runs against the in-memory test
// transport seeded with the shipped SmssendernameTestData.json fixtures.

import java.util.{ArrayList, LinkedHashMap, List => JList, Map => JMap}

import voxgig.smsapisdk.core.{Helpers, SdkEntity, SmsapiSDK}
import voxgig.smsapisdk.utility.struct.Struct

object SmssendernameEntityTest {

  def run(rep: SdkTestReport): Unit = {
    rep.scope("smssendername.instance") {
      val testsdk = SmsapiSDK.testSDK()
      val ent = testsdk.smssendername(null)
      rep.check("smssendername.instance", ent != null, "expected non-null smssendername entity")
    }

    rep.scope("smssendername.basic") {
      val entityData = Helpers.toMapAny(SdkTestSupport.readJson(
          "../.sdk/test/entity/smssendername/SmssendernameTestData.json"))
      val options = new LinkedHashMap[String, Object]()
      options.put("entity", entityData.get("existing"))
      val client = SmsapiSDK.testSDK(options, null)

      val idmap = new LinkedHashMap[String, Object]()
      idmap.put("smssendername01", "SMSSENDERNAME01")
      idmap.put("smssendername02", "SMSSENDERNAME02")
      idmap.put("smssendername03", "SMSSENDERNAME03")
      idmap.put("sendername01", "SENDERNAME01")
      idmap.put("sendername02", "SENDERNAME02")
      idmap.put("sendername03", "SENDERNAME03")
      val now = System.currentTimeMillis()

      // CREATE
      val smssendernameRef01Ent = client.smssendername(null)
      var smssendernameRef01Data = Helpers.toMapAny(Struct.getprop(
          Struct.getpath(entityData, "new.smssendername"), "smssendername_ref01"))
      smssendernameRef01Data.put("sendername_id", idmap.get("sendername01"))
      val smssendernameRef01DataResult = smssendernameRef01Ent.create(smssendernameRef01Data, null)
      smssendernameRef01Data = Helpers.toMapAny(smssendernameRef01DataResult match { case e: SdkEntity => e.data(); case o => o })
      rep.check("smssendername.create.map", smssendernameRef01Data != null, "expected create result to be a map")

    }
  }
}
