// Generated basic-flow test for the sendername_statement entity (model-driven;
// mirrors the java TestEntity generator). A dependency-free scala-cli test
// object driven by SdkEntityTestMain. Runs against the in-memory test
// transport seeded with the shipped SendernameStatementTestData.json fixtures.

import java.util.{ArrayList, LinkedHashMap, List => JList, Map => JMap}

import voxgig.smsapisdk.core.{Helpers, SdkEntity, SmsapiSDK}
import voxgig.smsapisdk.utility.struct.Struct

object SendernameStatementEntityTest {

  def run(rep: SdkTestReport): Unit = {
    rep.scope("sendername_statement.instance") {
      val testsdk = SmsapiSDK.testSDK()
      val ent = testsdk.sendernameStatement(null)
      rep.check("sendername_statement.instance", ent != null, "expected non-null sendername_statement entity")
    }

    rep.scope("sendername_statement.basic") {
      val entityData = Helpers.toMapAny(SdkTestSupport.readJson(
          "../.sdk/test/entity/sendername_statement/SendernameStatementTestData.json"))
      val options = new LinkedHashMap[String, Object]()
      options.put("entity", entityData.get("existing"))
      val client = SmsapiSDK.testSDK(options, null)

      val idmap = new LinkedHashMap[String, Object]()
      idmap.put("sendername_statement01", "SENDERNAME_STATEMENT01")
      idmap.put("sendername_statement02", "SENDERNAME_STATEMENT02")
      idmap.put("sendername_statement03", "SENDERNAME_STATEMENT03")
      val now = System.currentTimeMillis()

      // LIST
      val sendernameStatementRef01Ent = client.sendernameStatement(null)
      val sendernameStatementRef01Match = new LinkedHashMap[String, Object]()
      val sendernameStatementRef01ListResult = sendernameStatementRef01Ent.list(sendernameStatementRef01Match, null)
      rep.check("sendername_statement.list.islist", sendernameStatementRef01ListResult.isInstanceOf[JList[?]], "expected list result to be an array, got " + sendernameStatementRef01ListResult)
    }
  }
}
