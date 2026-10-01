// Generated basic-flow test for the blacklist entity (model-driven;
// mirrors the java TestEntity generator). A dependency-free scala-cli test
// object driven by SdkEntityTestMain. Runs against the in-memory test
// transport seeded with the shipped BlacklistTestData.json fixtures.

import java.util.{ArrayList, LinkedHashMap, List => JList, Map => JMap}

import voxgig.smsapisdk.core.{Helpers, SdkEntity, SmsapiSDK}
import voxgig.smsapisdk.utility.struct.Struct

object BlacklistEntityTest {

  def run(rep: SdkTestReport): Unit = {
    rep.scope("blacklist.instance") {
      val testsdk = SmsapiSDK.testSDK()
      val ent = testsdk.blacklist(null)
      rep.check("blacklist.instance", ent != null, "expected non-null blacklist entity")
    }

    rep.scope("blacklist.basic") {
      val entityData = Helpers.toMapAny(SdkTestSupport.readJson(
          "../.sdk/test/entity/blacklist/BlacklistTestData.json"))
      val options = new LinkedHashMap[String, Object]()
      options.put("entity", entityData.get("existing"))
      val client = SmsapiSDK.testSDK(options, null)

      val idmap = new LinkedHashMap[String, Object]()
      idmap.put("blacklist01", "BLACKLIST01")
      idmap.put("blacklist02", "BLACKLIST02")
      idmap.put("blacklist03", "BLACKLIST03")
      val now = System.currentTimeMillis()

      // CREATE
      val blacklistRef01Ent = client.blacklist(null)
      var blacklistRef01Data = Helpers.toMapAny(Struct.getprop(
          Struct.getpath(entityData, "new.blacklist"), "blacklist_ref01"))
      val blacklistRef01DataResult = blacklistRef01Ent.create(blacklistRef01Data, null)
      blacklistRef01Data = Helpers.toMapAny(blacklistRef01DataResult match { case e: SdkEntity => e.data(); case o => o })
      rep.check("blacklist.create.map", blacklistRef01Data != null, "expected create result to be a map")
      rep.check("blacklist.create.id", blacklistRef01Data != null && blacklistRef01Data.get("id") != null, "expected created entity to have an id")

      // LOAD
      val blacklistRef01MatchDt0 = new LinkedHashMap[String, Object]()
      blacklistRef01MatchDt0.put("id", blacklistRef01Data.get("id"))
      val blacklistRef01DataDt0Loaded = blacklistRef01Ent.load(blacklistRef01MatchDt0, null)
      val blacklistRef01DataDt0LoadResult = Helpers.toMapAny(blacklistRef01DataDt0Loaded match { case e: SdkEntity => e.data(); case o => o })
      rep.check("blacklist.load.map", blacklistRef01DataDt0LoadResult != null, "expected load result to be a map")
      rep.eq("blacklist.load.id", blacklistRef01Data.get("id"), blacklistRef01DataDt0LoadResult.get("id"))

      // REMOVE
      val blacklistRef01MatchRm0 = new LinkedHashMap[String, Object]()
      blacklistRef01MatchRm0.put("id", blacklistRef01Data.get("id"))
      blacklistRef01Ent.remove(blacklistRef01MatchRm0, null)
    }
  }
}
