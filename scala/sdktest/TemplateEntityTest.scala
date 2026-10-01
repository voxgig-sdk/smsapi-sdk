// Generated basic-flow test for the template entity (model-driven;
// mirrors the java TestEntity generator). A dependency-free scala-cli test
// object driven by SdkEntityTestMain. Runs against the in-memory test
// transport seeded with the shipped TemplateTestData.json fixtures.

import java.util.{ArrayList, LinkedHashMap, List => JList, Map => JMap}

import voxgig.smsapisdk.core.{Helpers, SdkEntity, SmsapiSDK}
import voxgig.smsapisdk.utility.struct.Struct

object TemplateEntityTest {

  def run(rep: SdkTestReport): Unit = {
    rep.scope("template.instance") {
      val testsdk = SmsapiSDK.testSDK()
      val ent = testsdk.template(null)
      rep.check("template.instance", ent != null, "expected non-null template entity")
    }

    rep.scope("template.basic") {
      val entityData = Helpers.toMapAny(SdkTestSupport.readJson(
          "../.sdk/test/entity/template/TemplateTestData.json"))
      val options = new LinkedHashMap[String, Object]()
      options.put("entity", entityData.get("existing"))
      val client = SmsapiSDK.testSDK(options, null)

      val idmap = new LinkedHashMap[String, Object]()
      idmap.put("template01", "TEMPLATE01")
      idmap.put("template02", "TEMPLATE02")
      idmap.put("template03", "TEMPLATE03")
      val now = System.currentTimeMillis()

      // CREATE
      val templateRef01Ent = client.template(null)
      var templateRef01Data = Helpers.toMapAny(Struct.getprop(
          Struct.getpath(entityData, "new.template"), "template_ref01"))
      val templateRef01DataResult = templateRef01Ent.create(templateRef01Data, null)
      templateRef01Data = Helpers.toMapAny(templateRef01DataResult match { case e: SdkEntity => e.data(); case o => o })
      rep.check("template.create.map", templateRef01Data != null, "expected create result to be a map")
      rep.check("template.create.id", templateRef01Data != null && templateRef01Data.get("id") != null, "expected created entity to have an id")

      // LIST
      val templateRef01Match = new LinkedHashMap[String, Object]()
      val templateRef01ListResult = templateRef01Ent.list(templateRef01Match, null)
      rep.check("template.list.islist", templateRef01ListResult.isInstanceOf[JList[?]], "expected list result to be an array, got " + templateRef01ListResult)
      val templateRef01List = templateRef01ListResult.asInstanceOf[JList[Object]]
      val templateRef01ListFound = Struct.select(
          SdkTestSupport.entityListToData(templateRef01List), SdkTestSupport.om("id" -> templateRef01Data.get("id")))
      rep.check("template.list.exists", !Struct.isempty(templateRef01ListFound), "expected to find created entity in list")

      // UPDATE
      val templateRef01DataUp0Up = new LinkedHashMap[String, Object]()
      templateRef01DataUp0Up.put("id", templateRef01Data.get("id"))
      val templateRef01MarkdefUp0Name = "name"
      val templateRef01MarkdefUp0Value = "Mark01-template_ref01_" + now
      templateRef01DataUp0Up.put(templateRef01MarkdefUp0Name, templateRef01MarkdefUp0Value)
      val templateRef01ResdataUp0Result = templateRef01Ent.update(templateRef01DataUp0Up, null)
      val templateRef01ResdataUp0 = Helpers.toMapAny(templateRef01ResdataUp0Result match { case e: SdkEntity => e.data(); case o => o })
      rep.check("template.update.map", templateRef01ResdataUp0 != null, "expected update result to be a map")
      rep.eq("template.update.id", templateRef01DataUp0Up.get("id"), templateRef01ResdataUp0.get("id"))
      rep.eq("template.update.mark", templateRef01MarkdefUp0Value, templateRef01ResdataUp0.get(templateRef01MarkdefUp0Name))

      // LOAD
      val templateRef01MatchDt0 = new LinkedHashMap[String, Object]()
      templateRef01MatchDt0.put("id", templateRef01Data.get("id"))
      val templateRef01DataDt0Loaded = templateRef01Ent.load(templateRef01MatchDt0, null)
      val templateRef01DataDt0LoadResult = Helpers.toMapAny(templateRef01DataDt0Loaded match { case e: SdkEntity => e.data(); case o => o })
      rep.check("template.load.map", templateRef01DataDt0LoadResult != null, "expected load result to be a map")
      rep.eq("template.load.id", templateRef01Data.get("id"), templateRef01DataDt0LoadResult.get("id"))
    }
  }
}
