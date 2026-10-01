// Generated basic-flow test for the permission entity (model-driven;
// mirrors the java TestEntity generator). A dependency-free scala-cli test
// object driven by SdkEntityTestMain. Runs against the in-memory test
// transport seeded with the shipped PermissionTestData.json fixtures.

import java.util.{ArrayList, LinkedHashMap, List => JList, Map => JMap}

import voxgig.smsapisdk.core.{Helpers, SdkEntity, SmsapiSDK}
import voxgig.smsapisdk.utility.struct.Struct

object PermissionEntityTest {

  def run(rep: SdkTestReport): Unit = {
    rep.scope("permission.instance") {
      val testsdk = SmsapiSDK.testSDK()
      val ent = testsdk.permission(null)
      rep.check("permission.instance", ent != null, "expected non-null permission entity")
    }

    rep.scope("permission.basic") {
      val entityData = Helpers.toMapAny(SdkTestSupport.readJson(
          "../.sdk/test/entity/permission/PermissionTestData.json"))
      val options = new LinkedHashMap[String, Object]()
      options.put("entity", entityData.get("existing"))
      val client = SmsapiSDK.testSDK(options, null)

      val idmap = new LinkedHashMap[String, Object]()
      idmap.put("permission01", "PERMISSION01")
      idmap.put("permission02", "PERMISSION02")
      idmap.put("permission03", "PERMISSION03")
      idmap.put("group01", "GROUP01")
      idmap.put("group02", "GROUP02")
      idmap.put("group03", "GROUP03")
      val now = System.currentTimeMillis()

      // CREATE
      val permissionRef01Ent = client.permission(null)
      var permissionRef01Data = Helpers.toMapAny(Struct.getprop(
          Struct.getpath(entityData, "new.permission"), "permission_ref01"))
      permissionRef01Data.put("group_id", idmap.get("group01"))
      val permissionRef01DataResult = permissionRef01Ent.create(permissionRef01Data, null)
      permissionRef01Data = Helpers.toMapAny(permissionRef01DataResult match { case e: SdkEntity => e.data(); case o => o })
      rep.check("permission.create.map", permissionRef01Data != null, "expected create result to be a map")
      rep.check("permission.create.id", permissionRef01Data != null && permissionRef01Data.get("id") != null, "expected created entity to have an id")

      // LOAD
      val permissionRef01MatchDt0 = new LinkedHashMap[String, Object]()
      permissionRef01MatchDt0.put("id", permissionRef01Data.get("id"))
      val permissionRef01DataDt0Loaded = permissionRef01Ent.load(permissionRef01MatchDt0, null)
      val permissionRef01DataDt0LoadResult = Helpers.toMapAny(permissionRef01DataDt0Loaded match { case e: SdkEntity => e.data(); case o => o })
      rep.check("permission.load.map", permissionRef01DataDt0LoadResult != null, "expected load result to be a map")
      rep.eq("permission.load.id", permissionRef01Data.get("id"), permissionRef01DataDt0LoadResult.get("id"))
    }
  }
}
