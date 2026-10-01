// Generated basic-flow test for the smstemplate entity (model-driven;
// mirrors the java TestEntity generator). A dependency-free scala-cli test
// object driven by SdkEntityTestMain. Runs against the in-memory test
// transport seeded with the shipped SmstemplateTestData.json fixtures.

import java.util.{ArrayList, LinkedHashMap, List => JList, Map => JMap}

import voxgig.smsapisdk.core.{Helpers, SdkEntity, SmsapiSDK}
import voxgig.smsapisdk.utility.struct.Struct

object SmstemplateEntityTest {

  def run(rep: SdkTestReport): Unit = {
    rep.scope("smstemplate.instance") {
      val testsdk = SmsapiSDK.testSDK()
      val ent = testsdk.smstemplate(null)
      rep.check("smstemplate.instance", ent != null, "expected non-null smstemplate entity")
    }

    rep.scope("smstemplate.basic") {
      val entityData = Helpers.toMapAny(SdkTestSupport.readJson(
          "../.sdk/test/entity/smstemplate/SmstemplateTestData.json"))
      val options = new LinkedHashMap[String, Object]()
      options.put("entity", entityData.get("existing"))
      val client = SmsapiSDK.testSDK(options, null)

      val idmap = new LinkedHashMap[String, Object]()
      idmap.put("smstemplate01", "SMSTEMPLATE01")
      idmap.put("smstemplate02", "SMSTEMPLATE02")
      idmap.put("smstemplate03", "SMSTEMPLATE03")
      val now = System.currentTimeMillis()
    }
  }
}
