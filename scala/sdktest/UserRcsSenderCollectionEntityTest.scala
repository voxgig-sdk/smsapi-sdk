// Generated basic-flow test for the user_rcs_sender_collection entity (model-driven;
// mirrors the java TestEntity generator). A dependency-free scala-cli test
// object driven by SdkEntityTestMain. Runs against the in-memory test
// transport seeded with the shipped UserRcsSenderCollectionTestData.json fixtures.

import java.util.{ArrayList, LinkedHashMap, List => JList, Map => JMap}

import voxgig.smsapisdk.core.{Helpers, SdkEntity, SmsapiSDK}
import voxgig.smsapisdk.utility.struct.Struct

object UserRcsSenderCollectionEntityTest {

  def run(rep: SdkTestReport): Unit = {
    rep.scope("user_rcs_sender_collection.instance") {
      val testsdk = SmsapiSDK.testSDK()
      val ent = testsdk.userRcsSenderCollection(null)
      rep.check("user_rcs_sender_collection.instance", ent != null, "expected non-null user_rcs_sender_collection entity")
    }

    rep.scope("user_rcs_sender_collection.basic") {
      val entityData = Helpers.toMapAny(SdkTestSupport.readJson(
          "../.sdk/test/entity/user_rcs_sender_collection/UserRcsSenderCollectionTestData.json"))
      val options = new LinkedHashMap[String, Object]()
      options.put("entity", entityData.get("existing"))
      val client = SmsapiSDK.testSDK(options, null)

      val idmap = new LinkedHashMap[String, Object]()
      idmap.put("user_rcs_sender_collection01", "USER_RCS_SENDER_COLLECTION01")
      idmap.put("user_rcs_sender_collection02", "USER_RCS_SENDER_COLLECTION02")
      idmap.put("user_rcs_sender_collection03", "USER_RCS_SENDER_COLLECTION03")
      val now = System.currentTimeMillis()

      // LIST
      val userRcsSenderCollectionRef01Ent = client.userRcsSenderCollection(null)
      val userRcsSenderCollectionRef01Match = new LinkedHashMap[String, Object]()
      val userRcsSenderCollectionRef01ListResult = userRcsSenderCollectionRef01Ent.list(userRcsSenderCollectionRef01Match, null)
      rep.check("user_rcs_sender_collection.list.islist", userRcsSenderCollectionRef01ListResult.isInstanceOf[JList[?]], "expected list result to be an array, got " + userRcsSenderCollectionRef01ListResult)
    }
  }
}
