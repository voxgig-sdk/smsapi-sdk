// Generated basic-flow test for the opt_out_setting entity (model-driven;
// mirrors the java TestEntity generator). A dependency-free scala-cli test
// object driven by SdkEntityTestMain. Runs against the in-memory test
// transport seeded with the shipped OptOutSettingTestData.json fixtures.

import java.util.{ArrayList, LinkedHashMap, List => JList, Map => JMap}

import voxgig.smsapisdk.core.{Helpers, SdkEntity, SmsapiSDK}
import voxgig.smsapisdk.utility.struct.Struct

object OptOutSettingEntityTest {

  def run(rep: SdkTestReport): Unit = {
    rep.scope("opt_out_setting.instance") {
      val testsdk = SmsapiSDK.testSDK()
      val ent = testsdk.optOutSetting(null)
      rep.check("opt_out_setting.instance", ent != null, "expected non-null opt_out_setting entity")
    }

    rep.scope("opt_out_setting.basic") {
      val entityData = Helpers.toMapAny(SdkTestSupport.readJson(
          "../.sdk/test/entity/opt_out_setting/OptOutSettingTestData.json"))
      val options = new LinkedHashMap[String, Object]()
      options.put("entity", entityData.get("existing"))
      val client = SmsapiSDK.testSDK(options, null)

      val idmap = new LinkedHashMap[String, Object]()
      idmap.put("opt_out_setting01", "OPT_OUT_SETTING01")
      idmap.put("opt_out_setting02", "OPT_OUT_SETTING02")
      idmap.put("opt_out_setting03", "OPT_OUT_SETTING03")
      val now = System.currentTimeMillis()

      // UPDATE
      val optOutSettingRef01Ent = client.optOutSetting(null)
      val optOutSettingRef01DataUp0Up = new LinkedHashMap[String, Object]()
      val optOutSettingRef01MarkdefUp0Name = "brand"
      val optOutSettingRef01MarkdefUp0Value = "Mark01-opt_out_setting_ref01_" + now
      optOutSettingRef01DataUp0Up.put(optOutSettingRef01MarkdefUp0Name, optOutSettingRef01MarkdefUp0Value)
      val optOutSettingRef01ResdataUp0Result = optOutSettingRef01Ent.update(optOutSettingRef01DataUp0Up, null)
      val optOutSettingRef01ResdataUp0 = Helpers.toMapAny(optOutSettingRef01ResdataUp0Result match { case e: SdkEntity => e.data(); case o => o })
      rep.check("opt_out_setting.update.map", optOutSettingRef01ResdataUp0 != null, "expected update result to be a map")
      rep.eq("opt_out_setting.update.mark", optOutSettingRef01MarkdefUp0Value, optOutSettingRef01ResdataUp0.get(optOutSettingRef01MarkdefUp0Name))

      // LOAD
      val optOutSettingRef01MatchDt0 = new LinkedHashMap[String, Object]()
      val optOutSettingRef01DataDt0Loaded = optOutSettingRef01Ent.load(optOutSettingRef01MatchDt0, null)
      rep.check("opt_out_setting.load.nonnull", optOutSettingRef01DataDt0Loaded != null, "expected load result to be non-null")
    }
  }
}
