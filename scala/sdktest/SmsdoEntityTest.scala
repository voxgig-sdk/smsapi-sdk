// Generated basic-flow test for the smsdo entity (model-driven;
// mirrors the java TestEntity generator). A dependency-free scala-cli test
// object driven by SdkEntityTestMain. Runs against the in-memory test
// transport seeded with the shipped SmsdoTestData.json fixtures.

import java.util.{ArrayList, LinkedHashMap, List => JList, Map => JMap}

import voxgig.smsapisdk.core.{Helpers, SdkEntity, SmsapiSDK}
import voxgig.smsapisdk.utility.struct.Struct

object SmsdoEntityTest {

  def run(rep: SdkTestReport): Unit = {
    rep.scope("smsdo.instance") {
      val testsdk = SmsapiSDK.testSDK()
      val ent = testsdk.smsdo(null)
      rep.check("smsdo.instance", ent != null, "expected non-null smsdo entity")
    }

    rep.scope("smsdo.basic") {
      val entityData = Helpers.toMapAny(SdkTestSupport.readJson(
          "../.sdk/test/entity/smsdo/SmsdoTestData.json"))
      val options = new LinkedHashMap[String, Object]()
      options.put("entity", entityData.get("existing"))
      val client = SmsapiSDK.testSDK(options, null)

      val idmap = new LinkedHashMap[String, Object]()
      idmap.put("smsdo01", "SMSDO01")
      idmap.put("smsdo02", "SMSDO02")
      idmap.put("smsdo03", "SMSDO03")
      val now = System.currentTimeMillis()

      // CREATE
      val smsdoRef01Ent = client.smsdo(null)
      var smsdoRef01Data = Helpers.toMapAny(Struct.getprop(
          Struct.getpath(entityData, "new.smsdo"), "smsdo_ref01"))
      val smsdoRef01DataResult = smsdoRef01Ent.create(smsdoRef01Data, null)
      smsdoRef01Data = Helpers.toMapAny(smsdoRef01DataResult match { case e: SdkEntity => e.data(); case o => o })
      rep.check("smsdo.create.map", smsdoRef01Data != null, "expected create result to be a map")
    }
  }
}
