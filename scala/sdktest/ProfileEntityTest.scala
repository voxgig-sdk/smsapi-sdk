// Generated basic-flow test for the profile entity (model-driven;
// mirrors the java TestEntity generator). A dependency-free scala-cli test
// object driven by SdkEntityTestMain. Runs against the in-memory test
// transport seeded with the shipped ProfileTestData.json fixtures.

import java.util.{ArrayList, LinkedHashMap, List => JList, Map => JMap}

import voxgig.smsapisdk.core.{Helpers, SdkEntity, SmsapiSDK}
import voxgig.smsapisdk.utility.struct.Struct

object ProfileEntityTest {

  def run(rep: SdkTestReport): Unit = {
    rep.scope("profile.instance") {
      val testsdk = SmsapiSDK.testSDK()
      val ent = testsdk.profile(null)
      rep.check("profile.instance", ent != null, "expected non-null profile entity")
    }

    rep.scope("profile.basic") {
      val entityData = Helpers.toMapAny(SdkTestSupport.readJson(
          "../.sdk/test/entity/profile/ProfileTestData.json"))
      val options = new LinkedHashMap[String, Object]()
      options.put("entity", entityData.get("existing"))
      val client = SmsapiSDK.testSDK(options, null)

      val idmap = new LinkedHashMap[String, Object]()
      idmap.put("profile01", "PROFILE01")
      idmap.put("profile02", "PROFILE02")
      idmap.put("profile03", "PROFILE03")
      val now = System.currentTimeMillis()

      // LIST
      val profileRef01Ent = client.profile(null)
      val profileRef01Match = new LinkedHashMap[String, Object]()
      val profileRef01ListResult = profileRef01Ent.list(profileRef01Match, null)
      rep.check("profile.list.islist", profileRef01ListResult.isInstanceOf[JList[?]], "expected list result to be an array, got " + profileRef01ListResult)

      // LOAD
      val profileRef01MatchDt0 = new LinkedHashMap[String, Object]()
      val profileRef01DataDt0Loaded = profileRef01Ent.load(profileRef01MatchDt0, null)
      rep.check("profile.load.nonnull", profileRef01DataDt0Loaded != null, "expected load result to be non-null")
    }
  }
}
