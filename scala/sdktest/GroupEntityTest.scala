// Generated basic-flow test for the group entity (model-driven;
// mirrors the java TestEntity generator). A dependency-free scala-cli test
// object driven by SdkEntityTestMain. Runs against the in-memory test
// transport seeded with the shipped GroupTestData.json fixtures.

import java.util.{ArrayList, LinkedHashMap, List => JList, Map => JMap}

import voxgig.smsapisdk.core.{Helpers, SdkEntity, SmsapiSDK}
import voxgig.smsapisdk.utility.struct.Struct

object GroupEntityTest {

  def run(rep: SdkTestReport): Unit = {
    rep.scope("group.instance") {
      val testsdk = SmsapiSDK.testSDK()
      val ent = testsdk.group(null)
      rep.check("group.instance", ent != null, "expected non-null group entity")
    }

    rep.scope("group.basic") {
      val entityData = Helpers.toMapAny(SdkTestSupport.readJson(
          "../.sdk/test/entity/group/GroupTestData.json"))
      val options = new LinkedHashMap[String, Object]()
      options.put("entity", entityData.get("existing"))
      val client = SmsapiSDK.testSDK(options, null)

      val idmap = new LinkedHashMap[String, Object]()
      idmap.put("group01", "GROUP01")
      idmap.put("group02", "GROUP02")
      idmap.put("group03", "GROUP03")
      val now = System.currentTimeMillis()
      val groupRef01DataRaw = Struct.items(Helpers.toMapAny(
          Struct.getpath(entityData, "existing.group")))
      val groupRef01Data = Helpers.toMapAny(groupRef01DataRaw.get(0).get(1))

      // UPDATE
      val groupRef01Ent = client.group(null)
      val groupRef01DataUp0Up = new LinkedHashMap[String, Object]()
      groupRef01DataUp0Up.put("id", groupRef01Data.get("id"))
      val groupRef01MarkdefUp0Name = "created_by"
      val groupRef01MarkdefUp0Value = "Mark01-group_ref01_" + now
      groupRef01DataUp0Up.put(groupRef01MarkdefUp0Name, groupRef01MarkdefUp0Value)
      val groupRef01ResdataUp0Result = groupRef01Ent.update(groupRef01DataUp0Up, null)
      val groupRef01ResdataUp0 = Helpers.toMapAny(groupRef01ResdataUp0Result match { case e: SdkEntity => e.data(); case o => o })
      rep.check("group.update.map", groupRef01ResdataUp0 != null, "expected update result to be a map")
      rep.eq("group.update.id", groupRef01DataUp0Up.get("id"), groupRef01ResdataUp0.get("id"))
      rep.eq("group.update.mark", groupRef01MarkdefUp0Value, groupRef01ResdataUp0.get(groupRef01MarkdefUp0Name))

      // LOAD
      val groupRef01MatchDt0 = new LinkedHashMap[String, Object]()
      groupRef01MatchDt0.put("id", groupRef01Data.get("id"))
      val groupRef01DataDt0Loaded = groupRef01Ent.load(groupRef01MatchDt0, null)
      val groupRef01DataDt0LoadResult = Helpers.toMapAny(groupRef01DataDt0Loaded match { case e: SdkEntity => e.data(); case o => o })
      rep.check("group.load.map", groupRef01DataDt0LoadResult != null, "expected load result to be a map")
      rep.eq("group.load.id", groupRef01Data.get("id"), groupRef01DataDt0LoadResult.get("id"))
    }
  }
}
