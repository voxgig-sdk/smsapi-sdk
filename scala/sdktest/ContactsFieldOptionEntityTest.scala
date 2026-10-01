// Generated basic-flow test for the contacts_field_option entity (model-driven;
// mirrors the java TestEntity generator). A dependency-free scala-cli test
// object driven by SdkEntityTestMain. Runs against the in-memory test
// transport seeded with the shipped ContactsFieldOptionTestData.json fixtures.

import java.util.{ArrayList, LinkedHashMap, List => JList, Map => JMap}

import voxgig.smsapisdk.core.{Helpers, SdkEntity, SmsapiSDK}
import voxgig.smsapisdk.utility.struct.Struct

object ContactsFieldOptionEntityTest {

  def run(rep: SdkTestReport): Unit = {
    rep.scope("contacts_field_option.instance") {
      val testsdk = SmsapiSDK.testSDK()
      val ent = testsdk.contactsFieldOption(null)
      rep.check("contacts_field_option.instance", ent != null, "expected non-null contacts_field_option entity")
    }

    rep.scope("contacts_field_option.basic") {
      val entityData = Helpers.toMapAny(SdkTestSupport.readJson(
          "../.sdk/test/entity/contacts_field_option/ContactsFieldOptionTestData.json"))
      val options = new LinkedHashMap[String, Object]()
      options.put("entity", entityData.get("existing"))
      val client = SmsapiSDK.testSDK(options, null)

      val idmap = new LinkedHashMap[String, Object]()
      idmap.put("contacts_field_option01", "CONTACTS_FIELD_OPTION01")
      idmap.put("contacts_field_option02", "CONTACTS_FIELD_OPTION02")
      idmap.put("contacts_field_option03", "CONTACTS_FIELD_OPTION03")
      idmap.put("field01", "FIELD01")
      val now = System.currentTimeMillis()

      // LIST
      val contactsFieldOptionRef01Ent = client.contactsFieldOption(null)
      val contactsFieldOptionRef01Match = new LinkedHashMap[String, Object]()
      contactsFieldOptionRef01Match.put("field_id", idmap.get("field01"))
      val contactsFieldOptionRef01ListResult = contactsFieldOptionRef01Ent.list(contactsFieldOptionRef01Match, null)
      rep.check("contacts_field_option.list.islist", contactsFieldOptionRef01ListResult.isInstanceOf[JList[?]], "expected list result to be an array, got " + contactsFieldOptionRef01ListResult)
    }
  }
}
