// Generated basic-flow test for the sendername entity (model-driven;
// mirrors the java TestEntity generator). A dependency-free scala-cli test
// object driven by SdkEntityTestMain. Runs against the in-memory test
// transport seeded with the shipped SendernameTestData.json fixtures.

import java.util.{ArrayList, LinkedHashMap, List => JList, Map => JMap}

import voxgig.smsapisdk.core.{Helpers, SdkEntity, SmsapiSDK}
import voxgig.smsapisdk.utility.struct.Struct

object SendernameEntityTest {

  def run(rep: SdkTestReport): Unit = {
    rep.scope("sendername.instance") {
      val testsdk = SmsapiSDK.testSDK()
      val ent = testsdk.sendername(null)
      rep.check("sendername.instance", ent != null, "expected non-null sendername entity")
    }

    rep.scope("sendername.basic") {
      val entityData = Helpers.toMapAny(SdkTestSupport.readJson(
          "../.sdk/test/entity/sendername/SendernameTestData.json"))
      val options = new LinkedHashMap[String, Object]()
      options.put("entity", entityData.get("existing"))
      val client = SmsapiSDK.testSDK(options, null)

      val idmap = new LinkedHashMap[String, Object]()
      idmap.put("sendername01", "SENDERNAME01")
      idmap.put("sendername02", "SENDERNAME02")
      idmap.put("sendername03", "SENDERNAME03")
      val now = System.currentTimeMillis()

      // CREATE
      val sendernameRef01Ent = client.sendername(null)
      var sendernameRef01Data = Helpers.toMapAny(Struct.getprop(
          Struct.getpath(entityData, "new.sendername"), "sendername_ref01"))
      val sendernameRef01DataResult = sendernameRef01Ent.create(sendernameRef01Data, null)
      sendernameRef01Data = Helpers.toMapAny(sendernameRef01DataResult match { case e: SdkEntity => e.data(); case o => o })
      rep.check("sendername.create.map", sendernameRef01Data != null, "expected create result to be a map")
      rep.check("sendername.create.id", sendernameRef01Data != null && sendernameRef01Data.get("id") != null, "expected created entity to have an id")

      // LIST
      val sendernameRef01Match = new LinkedHashMap[String, Object]()
      val sendernameRef01ListResult = sendernameRef01Ent.list(sendernameRef01Match, null)
      rep.check("sendername.list.islist", sendernameRef01ListResult.isInstanceOf[JList[?]], "expected list result to be an array, got " + sendernameRef01ListResult)
      val sendernameRef01List = sendernameRef01ListResult.asInstanceOf[JList[Object]]
      val sendernameRef01ListFound = Struct.select(
          SdkTestSupport.entityListToData(sendernameRef01List), SdkTestSupport.om("id" -> sendernameRef01Data.get("id")))
      rep.check("sendername.list.exists", !Struct.isempty(sendernameRef01ListFound), "expected to find created entity in list")

      // LOAD
      val sendernameRef01MatchDt0 = new LinkedHashMap[String, Object]()
      sendernameRef01MatchDt0.put("id", sendernameRef01Data.get("id"))
      val sendernameRef01DataDt0Loaded = sendernameRef01Ent.load(sendernameRef01MatchDt0, null)
      val sendernameRef01DataDt0LoadResult = Helpers.toMapAny(sendernameRef01DataDt0Loaded match { case e: SdkEntity => e.data(); case o => o })
      rep.check("sendername.load.map", sendernameRef01DataDt0LoadResult != null, "expected load result to be a map")
      rep.eq("sendername.load.id", sendernameRef01Data.get("id"), sendernameRef01DataDt0LoadResult.get("id"))
    }
  }
}
