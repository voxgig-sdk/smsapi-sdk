// Generated basic-flow test for the contact entity (model-driven;
// mirrors the java TestEntity generator). A dependency-free scala-cli test
// object driven by SdkEntityTestMain. Runs against the in-memory test
// transport seeded with the shipped ContactTestData.json fixtures.

import java.util.{ArrayList, LinkedHashMap, List => JList, Map => JMap}

import voxgig.smsapisdk.core.{Helpers, SdkEntity, SmsapiSDK}
import voxgig.smsapisdk.utility.struct.Struct

object ContactEntityTest {

  def run(rep: SdkTestReport): Unit = {
    rep.scope("contact.instance") {
      val testsdk = SmsapiSDK.testSDK()
      val ent = testsdk.contact(null)
      rep.check("contact.instance", ent != null, "expected non-null contact entity")
    }

    rep.scope("contact.basic") {
      val entityData = Helpers.toMapAny(SdkTestSupport.readJson(
          "../.sdk/test/entity/contact/ContactTestData.json"))
      val options = new LinkedHashMap[String, Object]()
      options.put("entity", entityData.get("existing"))
      val client = SmsapiSDK.testSDK(options, null)

      val idmap = new LinkedHashMap[String, Object]()
      idmap.put("contact01", "CONTACT01")
      idmap.put("contact02", "CONTACT02")
      idmap.put("contact03", "CONTACT03")
      idmap.put("group01", "GROUP01")
      idmap.put("group02", "GROUP02")
      idmap.put("group03", "GROUP03")
      val now = System.currentTimeMillis()

      // CREATE
      val contactRef01Ent = client.contact(null)
      var contactRef01Data = Helpers.toMapAny(Struct.getprop(
          Struct.getpath(entityData, "new.contact"), "contact_ref01"))
      contactRef01Data.put("group_id", idmap.get("group01"))
      val contactRef01DataResult = contactRef01Ent.create(contactRef01Data, null)
      contactRef01Data = Helpers.toMapAny(contactRef01DataResult match { case e: SdkEntity => e.data(); case o => o })
      rep.check("contact.create.map", contactRef01Data != null, "expected create result to be a map")
      rep.check("contact.create.id", contactRef01Data != null && contactRef01Data.get("id") != null, "expected created entity to have an id")

      // LIST
      val contactRef01Match = new LinkedHashMap[String, Object]()
      contactRef01Match.put("contact_id", idmap.get("contact01"))
      val contactRef01ListResult = contactRef01Ent.list(contactRef01Match, null)
      rep.check("contact.list.islist", contactRef01ListResult.isInstanceOf[JList[?]], "expected list result to be an array, got " + contactRef01ListResult)
      val contactRef01List = contactRef01ListResult.asInstanceOf[JList[Object]]
      val contactRef01ListFound = Struct.select(
          SdkTestSupport.entityListToData(contactRef01List), SdkTestSupport.om("id" -> contactRef01Data.get("id")))
      rep.check("contact.list.exists", !Struct.isempty(contactRef01ListFound), "expected to find created entity in list")

      // UPDATE
      val contactRef01DataUp0Up = new LinkedHashMap[String, Object]()
      contactRef01DataUp0Up.put("id", contactRef01Data.get("id"))
      val contactRef01MarkdefUp0Name = "birthday_date"
      val contactRef01MarkdefUp0Value = "Mark01-contact_ref01_" + now
      contactRef01DataUp0Up.put(contactRef01MarkdefUp0Name, contactRef01MarkdefUp0Value)
      val contactRef01ResdataUp0Result = contactRef01Ent.update(contactRef01DataUp0Up, null)
      val contactRef01ResdataUp0 = Helpers.toMapAny(contactRef01ResdataUp0Result match { case e: SdkEntity => e.data(); case o => o })
      rep.check("contact.update.map", contactRef01ResdataUp0 != null, "expected update result to be a map")
      rep.eq("contact.update.id", contactRef01DataUp0Up.get("id"), contactRef01ResdataUp0.get("id"))
      rep.eq("contact.update.mark", contactRef01MarkdefUp0Value, contactRef01ResdataUp0.get(contactRef01MarkdefUp0Name))

      // LOAD
      val contactRef01MatchDt0 = new LinkedHashMap[String, Object]()
      contactRef01MatchDt0.put("id", contactRef01Data.get("id"))
      val contactRef01DataDt0Loaded = contactRef01Ent.load(contactRef01MatchDt0, null)
      val contactRef01DataDt0LoadResult = Helpers.toMapAny(contactRef01DataDt0Loaded match { case e: SdkEntity => e.data(); case o => o })
      rep.check("contact.load.map", contactRef01DataDt0LoadResult != null, "expected load result to be a map")
      rep.eq("contact.load.id", contactRef01Data.get("id"), contactRef01DataDt0LoadResult.get("id"))

      // REMOVE
      val contactRef01MatchRm0 = new LinkedHashMap[String, Object]()
      contactRef01MatchRm0.put("id", contactRef01Data.get("id"))
      contactRef01Ent.remove(contactRef01MatchRm0, null)

      // LIST
      val contactRef01MatchRt0 = new LinkedHashMap[String, Object]()
      contactRef01MatchRt0.put("contact_id", idmap.get("contact01"))
      val contactRef01ListRt0Result = contactRef01Ent.list(contactRef01MatchRt0, null)
      rep.check("contact.list.islist", contactRef01ListRt0Result.isInstanceOf[JList[?]], "expected list result to be an array, got " + contactRef01ListRt0Result)
      val contactRef01ListRt0 = contactRef01ListRt0Result.asInstanceOf[JList[Object]]
      val contactRef01ListRt0NotFound = Struct.select(
          SdkTestSupport.entityListToData(contactRef01ListRt0), SdkTestSupport.om("id" -> contactRef01Data.get("id")))
      rep.check("contact.list.notexists", Struct.isempty(contactRef01ListRt0NotFound), "expected removed entity to not be in list")
    }
  }
}
