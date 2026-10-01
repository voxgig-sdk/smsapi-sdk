// Generated basic-flow test for the field_available entity (model-driven;
// mirrors the java TestEntity generator). A dependency-free scala-cli test
// object driven by SdkEntityTestMain. Runs against the in-memory test
// transport seeded with the shipped FieldAvailableTestData.json fixtures.

import java.util.{ArrayList, LinkedHashMap, List => JList, Map => JMap}

import voxgig.smsapisdk.core.{Helpers, SdkEntity, SmsapiSDK}
import voxgig.smsapisdk.utility.struct.Struct

object FieldAvailableEntityTest {

  def run(rep: SdkTestReport): Unit = {
    rep.scope("field_available.instance") {
      val testsdk = SmsapiSDK.testSDK()
      val ent = testsdk.fieldAvailable(null)
      rep.check("field_available.instance", ent != null, "expected non-null field_available entity")
    }

    rep.scope("field_available.basic") {
      val entityData = Helpers.toMapAny(SdkTestSupport.readJson(
          "../.sdk/test/entity/field_available/FieldAvailableTestData.json"))
      val options = new LinkedHashMap[String, Object]()
      options.put("entity", entityData.get("existing"))
      val client = SmsapiSDK.testSDK(options, null)

      val idmap = new LinkedHashMap[String, Object]()
      idmap.put("field_available01", "FIELD_AVAILABLE01")
      idmap.put("field_available02", "FIELD_AVAILABLE02")
      idmap.put("field_available03", "FIELD_AVAILABLE03")
      val now = System.currentTimeMillis()

      // LIST
      val fieldAvailableRef01Ent = client.fieldAvailable(null)
      val fieldAvailableRef01Match = new LinkedHashMap[String, Object]()
      val fieldAvailableRef01ListResult = fieldAvailableRef01Ent.list(fieldAvailableRef01Match, null)
      rep.check("field_available.list.islist", fieldAvailableRef01ListResult.isInstanceOf[JList[?]], "expected list result to be an array, got " + fieldAvailableRef01ListResult)
    }
  }
}
