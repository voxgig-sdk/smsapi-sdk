// Generated basic-flow test for the ping entity (model-driven;
// mirrors the java TestEntity generator). A dependency-free scala-cli test
// object driven by SdkEntityTestMain. Runs against the in-memory test
// transport seeded with the shipped PingTestData.json fixtures.

import java.util.{ArrayList, LinkedHashMap, List => JList, Map => JMap}

import voxgig.smsapisdk.core.{Helpers, SdkEntity, SmsapiSDK}
import voxgig.smsapisdk.utility.struct.Struct

object PingEntityTest {

  def run(rep: SdkTestReport): Unit = {
    rep.scope("ping.instance") {
      val testsdk = SmsapiSDK.testSDK()
      val ent = testsdk.ping(null)
      rep.check("ping.instance", ent != null, "expected non-null ping entity")
    }

    rep.scope("ping.basic") {
      val entityData = Helpers.toMapAny(SdkTestSupport.readJson(
          "../.sdk/test/entity/ping/PingTestData.json"))
      val options = new LinkedHashMap[String, Object]()
      options.put("entity", entityData.get("existing"))
      val client = SmsapiSDK.testSDK(options, null)

      val idmap = new LinkedHashMap[String, Object]()
      idmap.put("ping01", "PING01")
      idmap.put("ping02", "PING02")
      idmap.put("ping03", "PING03")
      val now = System.currentTimeMillis()

      // LIST
      val pingRef01Ent = client.ping(null)
      val pingRef01Match = new LinkedHashMap[String, Object]()
      val pingRef01ListResult = pingRef01Ent.list(pingRef01Match, null)
      rep.check("ping.list.islist", pingRef01ListResult.isInstanceOf[JList[?]], "expected list result to be an array, got " + pingRef01ListResult)
    }
  }
}
