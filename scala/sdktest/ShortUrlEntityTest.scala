// Generated basic-flow test for the short_url entity (model-driven;
// mirrors the java TestEntity generator). A dependency-free scala-cli test
// object driven by SdkEntityTestMain. Runs against the in-memory test
// transport seeded with the shipped ShortUrlTestData.json fixtures.

import java.util.{ArrayList, LinkedHashMap, List => JList, Map => JMap}

import voxgig.smsapisdk.core.{Helpers, SdkEntity, SmsapiSDK}
import voxgig.smsapisdk.utility.struct.Struct

object ShortUrlEntityTest {

  def run(rep: SdkTestReport): Unit = {
    rep.scope("short_url.instance") {
      val testsdk = SmsapiSDK.testSDK()
      val ent = testsdk.shortUrl(null)
      rep.check("short_url.instance", ent != null, "expected non-null short_url entity")
    }

    rep.scope("short_url.basic") {
      val entityData = Helpers.toMapAny(SdkTestSupport.readJson(
          "../.sdk/test/entity/short_url/ShortUrlTestData.json"))
      val options = new LinkedHashMap[String, Object]()
      options.put("entity", entityData.get("existing"))
      val client = SmsapiSDK.testSDK(options, null)

      val idmap = new LinkedHashMap[String, Object]()
      idmap.put("short_url01", "SHORT_URL01")
      idmap.put("short_url02", "SHORT_URL02")
      idmap.put("short_url03", "SHORT_URL03")
      val now = System.currentTimeMillis()

      // CREATE
      val shortUrlRef01Ent = client.shortUrl(null)
      var shortUrlRef01Data = Helpers.toMapAny(Struct.getprop(
          Struct.getpath(entityData, "new.short_url"), "short_url_ref01"))
      val shortUrlRef01DataResult = shortUrlRef01Ent.create(shortUrlRef01Data, null)
      shortUrlRef01Data = Helpers.toMapAny(shortUrlRef01DataResult match { case e: SdkEntity => e.data(); case o => o })
      rep.check("short_url.create.map", shortUrlRef01Data != null, "expected create result to be a map")
      rep.check("short_url.create.id", shortUrlRef01Data != null && shortUrlRef01Data.get("id") != null, "expected created entity to have an id")

      // LIST
      val shortUrlRef01Match = new LinkedHashMap[String, Object]()
      val shortUrlRef01ListResult = shortUrlRef01Ent.list(shortUrlRef01Match, null)
      rep.check("short_url.list.islist", shortUrlRef01ListResult.isInstanceOf[JList[?]], "expected list result to be an array, got " + shortUrlRef01ListResult)
      val shortUrlRef01List = shortUrlRef01ListResult.asInstanceOf[JList[Object]]
      val shortUrlRef01ListFound = Struct.select(
          SdkTestSupport.entityListToData(shortUrlRef01List), SdkTestSupport.om("id" -> shortUrlRef01Data.get("id")))
      rep.check("short_url.list.exists", !Struct.isempty(shortUrlRef01ListFound), "expected to find created entity in list")

      // UPDATE
      val shortUrlRef01DataUp0Up = new LinkedHashMap[String, Object]()
      shortUrlRef01DataUp0Up.put("id", shortUrlRef01Data.get("id"))
      val shortUrlRef01MarkdefUp0Name = "description"
      val shortUrlRef01MarkdefUp0Value = "Mark01-short_url_ref01_" + now
      shortUrlRef01DataUp0Up.put(shortUrlRef01MarkdefUp0Name, shortUrlRef01MarkdefUp0Value)
      val shortUrlRef01ResdataUp0Result = shortUrlRef01Ent.update(shortUrlRef01DataUp0Up, null)
      val shortUrlRef01ResdataUp0 = Helpers.toMapAny(shortUrlRef01ResdataUp0Result match { case e: SdkEntity => e.data(); case o => o })
      rep.check("short_url.update.map", shortUrlRef01ResdataUp0 != null, "expected update result to be a map")
      rep.eq("short_url.update.id", shortUrlRef01DataUp0Up.get("id"), shortUrlRef01ResdataUp0.get("id"))
      rep.eq("short_url.update.mark", shortUrlRef01MarkdefUp0Value, shortUrlRef01ResdataUp0.get(shortUrlRef01MarkdefUp0Name))

      // LOAD
      val shortUrlRef01MatchDt0 = new LinkedHashMap[String, Object]()
      shortUrlRef01MatchDt0.put("id", shortUrlRef01Data.get("id"))
      val shortUrlRef01DataDt0Loaded = shortUrlRef01Ent.load(shortUrlRef01MatchDt0, null)
      val shortUrlRef01DataDt0LoadResult = Helpers.toMapAny(shortUrlRef01DataDt0Loaded match { case e: SdkEntity => e.data(); case o => o })
      rep.check("short_url.load.map", shortUrlRef01DataDt0LoadResult != null, "expected load result to be a map")
      rep.eq("short_url.load.id", shortUrlRef01Data.get("id"), shortUrlRef01DataDt0LoadResult.get("id"))

      // REMOVE
      val shortUrlRef01MatchRm0 = new LinkedHashMap[String, Object]()
      shortUrlRef01MatchRm0.put("id", shortUrlRef01Data.get("id"))
      shortUrlRef01Ent.remove(shortUrlRef01MatchRm0, null)

      // LIST
      val shortUrlRef01MatchRt0 = new LinkedHashMap[String, Object]()
      val shortUrlRef01ListRt0Result = shortUrlRef01Ent.list(shortUrlRef01MatchRt0, null)
      rep.check("short_url.list.islist", shortUrlRef01ListRt0Result.isInstanceOf[JList[?]], "expected list result to be an array, got " + shortUrlRef01ListRt0Result)
      val shortUrlRef01ListRt0 = shortUrlRef01ListRt0Result.asInstanceOf[JList[Object]]
      val shortUrlRef01ListRt0NotFound = Struct.select(
          SdkTestSupport.entityListToData(shortUrlRef01ListRt0), SdkTestSupport.om("id" -> shortUrlRef01Data.get("id")))
      rep.check("short_url.list.notexists", Struct.isempty(shortUrlRef01ListRt0NotFound), "expected removed entity to not be in list")
    }
  }
}
