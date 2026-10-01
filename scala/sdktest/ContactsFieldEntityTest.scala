// Generated basic-flow test for the contacts_field entity (model-driven;
// mirrors the java TestEntity generator). A dependency-free scala-cli test
// object driven by SdkEntityTestMain. Runs against the in-memory test
// transport seeded with the shipped ContactsFieldTestData.json fixtures.

import java.util.{ArrayList, LinkedHashMap, List => JList, Map => JMap}

import voxgig.smsapisdk.core.{Helpers, SdkEntity, SmsapiSDK}
import voxgig.smsapisdk.utility.struct.Struct

object ContactsFieldEntityTest {

  def run(rep: SdkTestReport): Unit = {
    rep.scope("contacts_field.instance") {
      val testsdk = SmsapiSDK.testSDK()
      val ent = testsdk.contactsField(null)
      rep.check("contacts_field.instance", ent != null, "expected non-null contacts_field entity")
    }

    rep.scope("contacts_field.basic") {
      val entityData = Helpers.toMapAny(SdkTestSupport.readJson(
          "../.sdk/test/entity/contacts_field/ContactsFieldTestData.json"))
      val options = new LinkedHashMap[String, Object]()
      options.put("entity", entityData.get("existing"))
      val client = SmsapiSDK.testSDK(options, null)

      val idmap = new LinkedHashMap[String, Object]()
      idmap.put("contacts_field01", "CONTACTS_FIELD01")
      idmap.put("contacts_field02", "CONTACTS_FIELD02")
      idmap.put("contacts_field03", "CONTACTS_FIELD03")
      val now = System.currentTimeMillis()

      // CREATE
      val contactsFieldRef01Ent = client.contactsField(null)
      var contactsFieldRef01Data = Helpers.toMapAny(Struct.getprop(
          Struct.getpath(entityData, "new.contacts_field"), "contacts_field_ref01"))
      val contactsFieldRef01DataResult = contactsFieldRef01Ent.create(contactsFieldRef01Data, null)
      contactsFieldRef01Data = Helpers.toMapAny(contactsFieldRef01DataResult match { case e: SdkEntity => e.data(); case o => o })
      rep.check("contacts_field.create.map", contactsFieldRef01Data != null, "expected create result to be a map")
      rep.check("contacts_field.create.id", contactsFieldRef01Data != null && contactsFieldRef01Data.get("id") != null, "expected created entity to have an id")

      // LIST
      val contactsFieldRef01Match = new LinkedHashMap[String, Object]()
      val contactsFieldRef01ListResult = contactsFieldRef01Ent.list(contactsFieldRef01Match, null)
      rep.check("contacts_field.list.islist", contactsFieldRef01ListResult.isInstanceOf[JList[?]], "expected list result to be an array, got " + contactsFieldRef01ListResult)
      val contactsFieldRef01List = contactsFieldRef01ListResult.asInstanceOf[JList[Object]]
      val contactsFieldRef01ListFound = Struct.select(
          SdkTestSupport.entityListToData(contactsFieldRef01List), SdkTestSupport.om("id" -> contactsFieldRef01Data.get("id")))
      rep.check("contacts_field.list.exists", !Struct.isempty(contactsFieldRef01ListFound), "expected to find created entity in list")

      // UPDATE
      val contactsFieldRef01DataUp0Up = new LinkedHashMap[String, Object]()
      contactsFieldRef01DataUp0Up.put("id", contactsFieldRef01Data.get("id"))
      val contactsFieldRef01MarkdefUp0Name = "birthday_date"
      val contactsFieldRef01MarkdefUp0Value = "Mark01-contacts_field_ref01_" + now
      contactsFieldRef01DataUp0Up.put(contactsFieldRef01MarkdefUp0Name, contactsFieldRef01MarkdefUp0Value)
      val contactsFieldRef01ResdataUp0Result = contactsFieldRef01Ent.update(contactsFieldRef01DataUp0Up, null)
      val contactsFieldRef01ResdataUp0 = Helpers.toMapAny(contactsFieldRef01ResdataUp0Result match { case e: SdkEntity => e.data(); case o => o })
      rep.check("contacts_field.update.map", contactsFieldRef01ResdataUp0 != null, "expected update result to be a map")
      rep.eq("contacts_field.update.id", contactsFieldRef01DataUp0Up.get("id"), contactsFieldRef01ResdataUp0.get("id"))
      rep.eq("contacts_field.update.mark", contactsFieldRef01MarkdefUp0Value, contactsFieldRef01ResdataUp0.get(contactsFieldRef01MarkdefUp0Name))

      // REMOVE
      val contactsFieldRef01MatchRm0 = new LinkedHashMap[String, Object]()
      contactsFieldRef01MatchRm0.put("id", contactsFieldRef01Data.get("id"))
      contactsFieldRef01Ent.remove(contactsFieldRef01MatchRm0, null)

      // LIST
      val contactsFieldRef01MatchRt0 = new LinkedHashMap[String, Object]()
      val contactsFieldRef01ListRt0Result = contactsFieldRef01Ent.list(contactsFieldRef01MatchRt0, null)
      rep.check("contacts_field.list.islist", contactsFieldRef01ListRt0Result.isInstanceOf[JList[?]], "expected list result to be an array, got " + contactsFieldRef01ListRt0Result)
      val contactsFieldRef01ListRt0 = contactsFieldRef01ListRt0Result.asInstanceOf[JList[Object]]
      val contactsFieldRef01ListRt0NotFound = Struct.select(
          SdkTestSupport.entityListToData(contactsFieldRef01ListRt0), SdkTestSupport.om("id" -> contactsFieldRef01Data.get("id")))
      rep.check("contacts_field.list.notexists", Struct.isempty(contactsFieldRef01ListRt0NotFound), "expected removed entity to not be in list")
    }
  }
}
