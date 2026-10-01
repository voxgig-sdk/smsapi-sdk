// Generated basic-flow test for the subuser entity (model-driven;
// mirrors the java TestEntity generator). A dependency-free scala-cli test
// object driven by SdkEntityTestMain. Runs against the in-memory test
// transport seeded with the shipped SubuserTestData.json fixtures.

import java.util.{ArrayList, LinkedHashMap, List => JList, Map => JMap}

import voxgig.smsapisdk.core.{Helpers, SdkEntity, SmsapiSDK}
import voxgig.smsapisdk.utility.struct.Struct

object SubuserEntityTest {

  def run(rep: SdkTestReport): Unit = {
    rep.scope("subuser.instance") {
      val testsdk = SmsapiSDK.testSDK()
      val ent = testsdk.subuser(null)
      rep.check("subuser.instance", ent != null, "expected non-null subuser entity")
    }

    rep.scope("subuser.basic") {
      val entityData = Helpers.toMapAny(SdkTestSupport.readJson(
          "../.sdk/test/entity/subuser/SubuserTestData.json"))
      val options = new LinkedHashMap[String, Object]()
      options.put("entity", entityData.get("existing"))
      val client = SmsapiSDK.testSDK(options, null)

      val idmap = new LinkedHashMap[String, Object]()
      idmap.put("subuser01", "SUBUSER01")
      idmap.put("subuser02", "SUBUSER02")
      idmap.put("subuser03", "SUBUSER03")
      val now = System.currentTimeMillis()

      // CREATE
      val subuserRef01Ent = client.subuser(null)
      var subuserRef01Data = Helpers.toMapAny(Struct.getprop(
          Struct.getpath(entityData, "new.subuser"), "subuser_ref01"))
      val subuserRef01DataResult = subuserRef01Ent.create(subuserRef01Data, null)
      subuserRef01Data = Helpers.toMapAny(subuserRef01DataResult match { case e: SdkEntity => e.data(); case o => o })
      rep.check("subuser.create.map", subuserRef01Data != null, "expected create result to be a map")
      rep.check("subuser.create.id", subuserRef01Data != null && subuserRef01Data.get("id") != null, "expected created entity to have an id")

      // LIST
      val subuserRef01Match = new LinkedHashMap[String, Object]()
      val subuserRef01ListResult = subuserRef01Ent.list(subuserRef01Match, null)
      rep.check("subuser.list.islist", subuserRef01ListResult.isInstanceOf[JList[?]], "expected list result to be an array, got " + subuserRef01ListResult)
      val subuserRef01List = subuserRef01ListResult.asInstanceOf[JList[Object]]
      val subuserRef01ListFound = Struct.select(
          SdkTestSupport.entityListToData(subuserRef01List), SdkTestSupport.om("id" -> subuserRef01Data.get("id")))
      rep.check("subuser.list.exists", !Struct.isempty(subuserRef01ListFound), "expected to find created entity in list")

      // UPDATE
      val subuserRef01DataUp0Up = new LinkedHashMap[String, Object]()
      subuserRef01DataUp0Up.put("id", subuserRef01Data.get("id"))
      val subuserRef01MarkdefUp0Name = "description"
      val subuserRef01MarkdefUp0Value = "Mark01-subuser_ref01_" + now
      subuserRef01DataUp0Up.put(subuserRef01MarkdefUp0Name, subuserRef01MarkdefUp0Value)
      val subuserRef01ResdataUp0Result = subuserRef01Ent.update(subuserRef01DataUp0Up, null)
      val subuserRef01ResdataUp0 = Helpers.toMapAny(subuserRef01ResdataUp0Result match { case e: SdkEntity => e.data(); case o => o })
      rep.check("subuser.update.map", subuserRef01ResdataUp0 != null, "expected update result to be a map")
      rep.eq("subuser.update.id", subuserRef01DataUp0Up.get("id"), subuserRef01ResdataUp0.get("id"))
      rep.eq("subuser.update.mark", subuserRef01MarkdefUp0Value, subuserRef01ResdataUp0.get(subuserRef01MarkdefUp0Name))

      // LOAD
      val subuserRef01MatchDt0 = new LinkedHashMap[String, Object]()
      subuserRef01MatchDt0.put("id", subuserRef01Data.get("id"))
      val subuserRef01DataDt0Loaded = subuserRef01Ent.load(subuserRef01MatchDt0, null)
      val subuserRef01DataDt0LoadResult = Helpers.toMapAny(subuserRef01DataDt0Loaded match { case e: SdkEntity => e.data(); case o => o })
      rep.check("subuser.load.map", subuserRef01DataDt0LoadResult != null, "expected load result to be a map")
      rep.eq("subuser.load.id", subuserRef01Data.get("id"), subuserRef01DataDt0LoadResult.get("id"))

      // REMOVE
      val subuserRef01MatchRm0 = new LinkedHashMap[String, Object]()
      subuserRef01MatchRm0.put("id", subuserRef01Data.get("id"))
      subuserRef01Ent.remove(subuserRef01MatchRm0, null)

      // LIST
      val subuserRef01MatchRt0 = new LinkedHashMap[String, Object]()
      val subuserRef01ListRt0Result = subuserRef01Ent.list(subuserRef01MatchRt0, null)
      rep.check("subuser.list.islist", subuserRef01ListRt0Result.isInstanceOf[JList[?]], "expected list result to be an array, got " + subuserRef01ListRt0Result)
      val subuserRef01ListRt0 = subuserRef01ListRt0Result.asInstanceOf[JList[Object]]
      val subuserRef01ListRt0NotFound = Struct.select(
          SdkTestSupport.entityListToData(subuserRef01ListRt0), SdkTestSupport.om("id" -> subuserRef01Data.get("id")))
      rep.check("subuser.list.notexists", Struct.isempty(subuserRef01ListRt0NotFound), "expected removed entity to not be in list")
    }
  }
}
