// Generated basic-flow test for the rcs entity (model-driven;
// mirrors the java TestEntity generator). A dependency-free scala-cli test
// object driven by SdkEntityTestMain. Runs against the in-memory test
// transport seeded with the shipped RcsTestData.json fixtures.

import java.util.{ArrayList, LinkedHashMap, List => JList, Map => JMap}

import voxgig.smsapisdk.core.{Helpers, SdkEntity, SmsapiSDK}
import voxgig.smsapisdk.utility.struct.Struct

object RcsEntityTest {

  def run(rep: SdkTestReport): Unit = {
    rep.scope("rcs.instance") {
      val testsdk = SmsapiSDK.testSDK()
      val ent = testsdk.rcs(null)
      rep.check("rcs.instance", ent != null, "expected non-null rcs entity")
    }

    rep.scope("rcs.basic") {
      val entityData = Helpers.toMapAny(SdkTestSupport.readJson(
          "../.sdk/test/entity/rcs/RcsTestData.json"))
      val options = new LinkedHashMap[String, Object]()
      options.put("entity", entityData.get("existing"))
      val client = SmsapiSDK.testSDK(options, null)

      val idmap = new LinkedHashMap[String, Object]()
      idmap.put("rcs01", "RCS01")
      idmap.put("rcs02", "RCS02")
      idmap.put("rcs03", "RCS03")
      val now = System.currentTimeMillis()

      // LIST
      val rcsRef01Ent = client.rcs(null)
      val rcsRef01Match = new LinkedHashMap[String, Object]()
      val rcsRef01ListResult = rcsRef01Ent.list(rcsRef01Match, null)
      rep.check("rcs.list.islist", rcsRef01ListResult.isInstanceOf[JList[?]], "expected list result to be an array, got " + rcsRef01ListResult)
    }
  }
}
