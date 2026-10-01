// Generated basic-flow test for the contactsgroup entity (model-driven;
// mirrors the java TestEntity generator). A dependency-free scala-cli test
// object driven by SdkEntityTestMain. Runs against the in-memory test
// transport seeded with the shipped ContactsgroupTestData.json fixtures.

import java.util.{ArrayList, LinkedHashMap, List => JList, Map => JMap}

import voxgig.smsapisdk.core.{Helpers, SdkEntity, SmsapiSDK}
import voxgig.smsapisdk.utility.struct.Struct

object ContactsgroupEntityTest {

  def run(rep: SdkTestReport): Unit = {
    rep.scope("contactsgroup.instance") {
      val testsdk = SmsapiSDK.testSDK()
      val ent = testsdk.contactsgroup(null)
      rep.check("contactsgroup.instance", ent != null, "expected non-null contactsgroup entity")
    }

    rep.scope("contactsgroup.basic") {
      val entityData = Helpers.toMapAny(SdkTestSupport.readJson(
          "../.sdk/test/entity/contactsgroup/ContactsgroupTestData.json"))
      val options = new LinkedHashMap[String, Object]()
      options.put("entity", entityData.get("existing"))
      val client = SmsapiSDK.testSDK(options, null)

      val idmap = new LinkedHashMap[String, Object]()
      idmap.put("contactsgroup01", "CONTACTSGROUP01")
      idmap.put("contactsgroup02", "CONTACTSGROUP02")
      idmap.put("contactsgroup03", "CONTACTSGROUP03")
      idmap.put("group01", "GROUP01")
      idmap.put("group02", "GROUP02")
      idmap.put("group03", "GROUP03")
      idmap.put("permission01", "PERMISSION01")
      idmap.put("permission02", "PERMISSION02")
      idmap.put("permission03", "PERMISSION03")
      val now = System.currentTimeMillis()

      // CREATE
      val contactsgroupRef01Ent = client.contactsgroup(null)
      var contactsgroupRef01Data = Helpers.toMapAny(Struct.getprop(
          Struct.getpath(entityData, "new.contactsgroup"), "contactsgroup_ref01"))
      contactsgroupRef01Data.put("group_id", idmap.get("group01"))
      val contactsgroupRef01DataResult = contactsgroupRef01Ent.create(contactsgroupRef01Data, null)
      contactsgroupRef01Data = Helpers.toMapAny(contactsgroupRef01DataResult match { case e: SdkEntity => e.data(); case o => o })
      rep.check("contactsgroup.create.map", contactsgroupRef01Data != null, "expected create result to be a map")
      rep.check("contactsgroup.create.id", contactsgroupRef01Data != null && contactsgroupRef01Data.get("id") != null, "expected created entity to have an id")

      // LIST
      val contactsgroupRef01Match = new LinkedHashMap[String, Object]()
      contactsgroupRef01Match.put("group_id", idmap.get("group01"))
      val contactsgroupRef01ListResult = contactsgroupRef01Ent.list(contactsgroupRef01Match, null)
      rep.check("contactsgroup.list.islist", contactsgroupRef01ListResult.isInstanceOf[JList[?]], "expected list result to be an array, got " + contactsgroupRef01ListResult)
      val contactsgroupRef01List = contactsgroupRef01ListResult.asInstanceOf[JList[Object]]
      val contactsgroupRef01ListFound = Struct.select(
          SdkTestSupport.entityListToData(contactsgroupRef01List), SdkTestSupport.om("id" -> contactsgroupRef01Data.get("id")))
      rep.check("contactsgroup.list.exists", !Struct.isempty(contactsgroupRef01ListFound), "expected to find created entity in list")

      // UPDATE
      val contactsgroupRef01DataUp0Up = new LinkedHashMap[String, Object]()
      contactsgroupRef01DataUp0Up.put("id", contactsgroupRef01Data.get("id"))
      val contactsgroupRef01MarkdefUp0Name = "birthday_date"
      val contactsgroupRef01MarkdefUp0Value = "Mark01-contactsgroup_ref01_" + now
      contactsgroupRef01DataUp0Up.put(contactsgroupRef01MarkdefUp0Name, contactsgroupRef01MarkdefUp0Value)
      val contactsgroupRef01ResdataUp0Result = contactsgroupRef01Ent.update(contactsgroupRef01DataUp0Up, null)
      val contactsgroupRef01ResdataUp0 = Helpers.toMapAny(contactsgroupRef01ResdataUp0Result match { case e: SdkEntity => e.data(); case o => o })
      rep.check("contactsgroup.update.map", contactsgroupRef01ResdataUp0 != null, "expected update result to be a map")
      rep.eq("contactsgroup.update.id", contactsgroupRef01DataUp0Up.get("id"), contactsgroupRef01ResdataUp0.get("id"))
      rep.eq("contactsgroup.update.mark", contactsgroupRef01MarkdefUp0Value, contactsgroupRef01ResdataUp0.get(contactsgroupRef01MarkdefUp0Name))

      // REMOVE
      val contactsgroupRef01MatchRm0 = new LinkedHashMap[String, Object]()
      contactsgroupRef01MatchRm0.put("id", contactsgroupRef01Data.get("id"))
      contactsgroupRef01Ent.remove(contactsgroupRef01MatchRm0, null)

      // LIST
      val contactsgroupRef01MatchRt0 = new LinkedHashMap[String, Object]()
      contactsgroupRef01MatchRt0.put("group_id", idmap.get("group01"))
      val contactsgroupRef01ListRt0Result = contactsgroupRef01Ent.list(contactsgroupRef01MatchRt0, null)
      rep.check("contactsgroup.list.islist", contactsgroupRef01ListRt0Result.isInstanceOf[JList[?]], "expected list result to be an array, got " + contactsgroupRef01ListRt0Result)
      val contactsgroupRef01ListRt0 = contactsgroupRef01ListRt0Result.asInstanceOf[JList[Object]]
      val contactsgroupRef01ListRt0NotFound = Struct.select(
          SdkTestSupport.entityListToData(contactsgroupRef01ListRt0), SdkTestSupport.om("id" -> contactsgroupRef01Data.get("id")))
      rep.check("contactsgroup.list.notexists", Struct.isempty(contactsgroupRef01ListRt0NotFound), "expected removed entity to not be in list")
    }
  }
}
