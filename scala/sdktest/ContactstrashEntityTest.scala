// Generated basic-flow test for the contactstrash entity (model-driven;
// mirrors the java TestEntity generator). A dependency-free scala-cli test
// object driven by SdkEntityTestMain. Runs against the in-memory test
// transport seeded with the shipped ContactstrashTestData.json fixtures.

import java.util.{ArrayList, LinkedHashMap, List => JList, Map => JMap}

import voxgig.smsapisdk.core.{Helpers, SdkEntity, SmsapiSDK}
import voxgig.smsapisdk.utility.struct.Struct

object ContactstrashEntityTest {

  def run(rep: SdkTestReport): Unit = {
    rep.scope("contactstrash.instance") {
      val testsdk = SmsapiSDK.testSDK()
      val ent = testsdk.contactstrash(null)
      rep.check("contactstrash.instance", ent != null, "expected non-null contactstrash entity")
    }

    rep.scope("contactstrash.basic") {
      val entityData = Helpers.toMapAny(SdkTestSupport.readJson(
          "../.sdk/test/entity/contactstrash/ContactstrashTestData.json"))
      val options = new LinkedHashMap[String, Object]()
      options.put("entity", entityData.get("existing"))
      val client = SmsapiSDK.testSDK(options, null)

      val idmap = new LinkedHashMap[String, Object]()
      idmap.put("contactstrash01", "CONTACTSTRASH01")
      idmap.put("contactstrash02", "CONTACTSTRASH02")
      idmap.put("contactstrash03", "CONTACTSTRASH03")
      val now = System.currentTimeMillis()

      // UPDATE
      val contactstrashRef01Ent = client.contactstrash(null)
      val contactstrashRef01DataUp0Up = new LinkedHashMap[String, Object]()
      val contactstrashRef01ResdataUp0Result = contactstrashRef01Ent.update(contactstrashRef01DataUp0Up, null)
      val contactstrashRef01ResdataUp0 = Helpers.toMapAny(contactstrashRef01ResdataUp0Result match { case e: SdkEntity => e.data(); case o => o })
      rep.check("contactstrash.update.map", contactstrashRef01ResdataUp0 != null, "expected update result to be a map")
    }
  }
}
