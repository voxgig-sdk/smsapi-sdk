// Generated basic-flow test for the mfa_code entity (model-driven;
// mirrors the java TestEntity generator). A dependency-free scala-cli test
// object driven by SdkEntityTestMain. Runs against the in-memory test
// transport seeded with the shipped MfaCodeTestData.json fixtures.

import java.util.{ArrayList, LinkedHashMap, List => JList, Map => JMap}

import voxgig.smsapisdk.core.{Helpers, SdkEntity, SmsapiSDK}
import voxgig.smsapisdk.utility.struct.Struct

object MfaCodeEntityTest {

  def run(rep: SdkTestReport): Unit = {
    rep.scope("mfa_code.instance") {
      val testsdk = SmsapiSDK.testSDK()
      val ent = testsdk.mfaCode(null)
      rep.check("mfa_code.instance", ent != null, "expected non-null mfa_code entity")
    }

    rep.scope("mfa_code.basic") {
      val entityData = Helpers.toMapAny(SdkTestSupport.readJson(
          "../.sdk/test/entity/mfa_code/MfaCodeTestData.json"))
      val options = new LinkedHashMap[String, Object]()
      options.put("entity", entityData.get("existing"))
      val client = SmsapiSDK.testSDK(options, null)

      val idmap = new LinkedHashMap[String, Object]()
      idmap.put("mfa_code01", "MFA_CODE01")
      idmap.put("mfa_code02", "MFA_CODE02")
      idmap.put("mfa_code03", "MFA_CODE03")
      val now = System.currentTimeMillis()

      // CREATE
      val mfaCodeRef01Ent = client.mfaCode(null)
      var mfaCodeRef01Data = Helpers.toMapAny(Struct.getprop(
          Struct.getpath(entityData, "new.mfa_code"), "mfa_code_ref01"))
      val mfaCodeRef01DataResult = mfaCodeRef01Ent.create(mfaCodeRef01Data, null)
      mfaCodeRef01Data = Helpers.toMapAny(mfaCodeRef01DataResult match { case e: SdkEntity => e.data(); case o => o })
      rep.check("mfa_code.create.map", mfaCodeRef01Data != null, "expected create result to be a map")
    }
  }
}
