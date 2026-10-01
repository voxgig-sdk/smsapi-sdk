// Generated basic-flow test for the opt_out entity (model-driven;
// mirrors the java TestEntity generator). A dependency-free scala-cli test
// object driven by SdkEntityTestMain. Runs against the in-memory test
// transport seeded with the shipped OptOutTestData.json fixtures.

import java.util.{ArrayList, LinkedHashMap, List => JList, Map => JMap}

import voxgig.smsapisdk.core.{Helpers, SdkEntity, SmsapiSDK}
import voxgig.smsapisdk.utility.struct.Struct

object OptOutEntityTest {

  def run(rep: SdkTestReport): Unit = {
    rep.scope("opt_out.instance") {
      val testsdk = SmsapiSDK.testSDK()
      val ent = testsdk.optOut(null)
      rep.check("opt_out.instance", ent != null, "expected non-null opt_out entity")
    }

    rep.scope("opt_out.basic") {
      val entityData = Helpers.toMapAny(SdkTestSupport.readJson(
          "../.sdk/test/entity/opt_out/OptOutTestData.json"))
      val options = new LinkedHashMap[String, Object]()
      options.put("entity", entityData.get("existing"))
      val client = SmsapiSDK.testSDK(options, null)

      val idmap = new LinkedHashMap[String, Object]()
      idmap.put("opt_out01", "OPT_OUT01")
      idmap.put("opt_out02", "OPT_OUT02")
      idmap.put("opt_out03", "OPT_OUT03")
      val now = System.currentTimeMillis()

      // LIST
      val optOutRef01Ent = client.optOut(null)
      val optOutRef01Match = new LinkedHashMap[String, Object]()
      val optOutRef01ListResult = optOutRef01Ent.list(optOutRef01Match, null)
      rep.check("opt_out.list.islist", optOutRef01ListResult.isInstanceOf[JList[?]], "expected list result to be an array, got " + optOutRef01ListResult)
    }
  }
}
