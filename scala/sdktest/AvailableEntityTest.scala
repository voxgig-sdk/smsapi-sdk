// Generated basic-flow test for the available entity (model-driven;
// mirrors the java TestEntity generator). A dependency-free scala-cli test
// object driven by SdkEntityTestMain. Runs against the in-memory test
// transport seeded with the shipped AvailableTestData.json fixtures.

import java.util.{ArrayList, LinkedHashMap, List => JList, Map => JMap}

import voxgig.smsapisdk.core.{Helpers, SdkEntity, SmsapiSDK}
import voxgig.smsapisdk.utility.struct.Struct

object AvailableEntityTest {

  def run(rep: SdkTestReport): Unit = {
    rep.scope("available.instance") {
      val testsdk = SmsapiSDK.testSDK()
      val ent = testsdk.available(null)
      rep.check("available.instance", ent != null, "expected non-null available entity")
    }

    rep.scope("available.basic") {
      val entityData = Helpers.toMapAny(SdkTestSupport.readJson(
          "../.sdk/test/entity/available/AvailableTestData.json"))
      val options = new LinkedHashMap[String, Object]()
      options.put("entity", entityData.get("existing"))
      val client = SmsapiSDK.testSDK(options, null)

      val idmap = new LinkedHashMap[String, Object]()
      idmap.put("available01", "AVAILABLE01")
      idmap.put("available02", "AVAILABLE02")
      idmap.put("available03", "AVAILABLE03")
      val now = System.currentTimeMillis()

      // LIST
      val availableRef01Ent = client.available(null)
      val availableRef01Match = new LinkedHashMap[String, Object]()
      val availableRef01ListResult = availableRef01Ent.list(availableRef01Match, null)
      rep.check("available.list.islist", availableRef01ListResult.isInstanceOf[JList[?]], "expected list result to be an array, got " + availableRef01ListResult)
    }
  }
}
