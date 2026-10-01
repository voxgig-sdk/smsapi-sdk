// Generated basic-flow test for the callback entity (model-driven;
// mirrors the java TestEntity generator). A dependency-free scala-cli test
// object driven by SdkEntityTestMain. Runs against the in-memory test
// transport seeded with the shipped CallbackTestData.json fixtures.

import java.util.{ArrayList, LinkedHashMap, List => JList, Map => JMap}

import voxgig.smsapisdk.core.{Helpers, SdkEntity, SmsapiSDK}
import voxgig.smsapisdk.utility.struct.Struct

object CallbackEntityTest {

  def run(rep: SdkTestReport): Unit = {
    rep.scope("callback.instance") {
      val testsdk = SmsapiSDK.testSDK()
      val ent = testsdk.callback(null)
      rep.check("callback.instance", ent != null, "expected non-null callback entity")
    }

    rep.scope("callback.basic") {
      val entityData = Helpers.toMapAny(SdkTestSupport.readJson(
          "../.sdk/test/entity/callback/CallbackTestData.json"))
      val options = new LinkedHashMap[String, Object]()
      options.put("entity", entityData.get("existing"))
      val client = SmsapiSDK.testSDK(options, null)

      val idmap = new LinkedHashMap[String, Object]()
      idmap.put("callback01", "CALLBACK01")
      idmap.put("callback02", "CALLBACK02")
      idmap.put("callback03", "CALLBACK03")
      val now = System.currentTimeMillis()

      // CREATE
      val callbackRef01Ent = client.callback(null)
      var callbackRef01Data = Helpers.toMapAny(Struct.getprop(
          Struct.getpath(entityData, "new.callback"), "callback_ref01"))
      val callbackRef01DataResult = callbackRef01Ent.create(callbackRef01Data, null)
      callbackRef01Data = Helpers.toMapAny(callbackRef01DataResult match { case e: SdkEntity => e.data(); case o => o })
      rep.check("callback.create.map", callbackRef01Data != null, "expected create result to be a map")
      rep.check("callback.create.id", callbackRef01Data != null && callbackRef01Data.get("id") != null, "expected created entity to have an id")

      // LIST
      val callbackRef01Match = new LinkedHashMap[String, Object]()
      val callbackRef01ListResult = callbackRef01Ent.list(callbackRef01Match, null)
      rep.check("callback.list.islist", callbackRef01ListResult.isInstanceOf[JList[?]], "expected list result to be an array, got " + callbackRef01ListResult)
      val callbackRef01List = callbackRef01ListResult.asInstanceOf[JList[Object]]
      val callbackRef01ListFound = Struct.select(
          SdkTestSupport.entityListToData(callbackRef01List), SdkTestSupport.om("id" -> callbackRef01Data.get("id")))
      rep.check("callback.list.exists", !Struct.isempty(callbackRef01ListFound), "expected to find created entity in list")

      // UPDATE
      val callbackRef01DataUp0Up = new LinkedHashMap[String, Object]()
      callbackRef01DataUp0Up.put("id", callbackRef01Data.get("id"))
      val callbackRef01MarkdefUp0Name = "receiver_type"
      val callbackRef01MarkdefUp0Value = "Mark01-callback_ref01_" + now
      callbackRef01DataUp0Up.put(callbackRef01MarkdefUp0Name, callbackRef01MarkdefUp0Value)
      val callbackRef01ResdataUp0Result = callbackRef01Ent.update(callbackRef01DataUp0Up, null)
      val callbackRef01ResdataUp0 = Helpers.toMapAny(callbackRef01ResdataUp0Result match { case e: SdkEntity => e.data(); case o => o })
      rep.check("callback.update.map", callbackRef01ResdataUp0 != null, "expected update result to be a map")
      rep.eq("callback.update.id", callbackRef01DataUp0Up.get("id"), callbackRef01ResdataUp0.get("id"))
      rep.eq("callback.update.mark", callbackRef01MarkdefUp0Value, callbackRef01ResdataUp0.get(callbackRef01MarkdefUp0Name))

      // LOAD
      val callbackRef01MatchDt0 = new LinkedHashMap[String, Object]()
      callbackRef01MatchDt0.put("id", callbackRef01Data.get("id"))
      val callbackRef01DataDt0Loaded = callbackRef01Ent.load(callbackRef01MatchDt0, null)
      val callbackRef01DataDt0LoadResult = Helpers.toMapAny(callbackRef01DataDt0Loaded match { case e: SdkEntity => e.data(); case o => o })
      rep.check("callback.load.map", callbackRef01DataDt0LoadResult != null, "expected load result to be a map")
      rep.eq("callback.load.id", callbackRef01Data.get("id"), callbackRef01DataDt0LoadResult.get("id"))

      // REMOVE
      val callbackRef01MatchRm0 = new LinkedHashMap[String, Object]()
      callbackRef01MatchRm0.put("id", callbackRef01Data.get("id"))
      callbackRef01Ent.remove(callbackRef01MatchRm0, null)

      // LIST
      val callbackRef01MatchRt0 = new LinkedHashMap[String, Object]()
      val callbackRef01ListRt0Result = callbackRef01Ent.list(callbackRef01MatchRt0, null)
      rep.check("callback.list.islist", callbackRef01ListRt0Result.isInstanceOf[JList[?]], "expected list result to be an array, got " + callbackRef01ListRt0Result)
      val callbackRef01ListRt0 = callbackRef01ListRt0Result.asInstanceOf[JList[Object]]
      val callbackRef01ListRt0NotFound = Struct.select(
          SdkTestSupport.entityListToData(callbackRef01ListRt0), SdkTestSupport.om("id" -> callbackRef01Data.get("id")))
      rep.check("callback.list.notexists", Struct.isempty(callbackRef01ListRt0NotFound), "expected removed entity to not be in list")
    }
  }
}
