// Generated basic-flow test for the shipment_country_volume entity (model-driven;
// mirrors the java TestEntity generator). A dependency-free scala-cli test
// object driven by SdkEntityTestMain. Runs against the in-memory test
// transport seeded with the shipped ShipmentCountryVolumeTestData.json fixtures.

import java.util.{ArrayList, LinkedHashMap, List => JList, Map => JMap}

import voxgig.smsapisdk.core.{Helpers, SdkEntity, SmsapiSDK}
import voxgig.smsapisdk.utility.struct.Struct

object ShipmentCountryVolumeEntityTest {

  def run(rep: SdkTestReport): Unit = {
    rep.scope("shipment_country_volume.instance") {
      val testsdk = SmsapiSDK.testSDK()
      val ent = testsdk.shipmentCountryVolume(null)
      rep.check("shipment_country_volume.instance", ent != null, "expected non-null shipment_country_volume entity")
    }

    rep.scope("shipment_country_volume.basic") {
      val entityData = Helpers.toMapAny(SdkTestSupport.readJson(
          "../.sdk/test/entity/shipment_country_volume/ShipmentCountryVolumeTestData.json"))
      val options = new LinkedHashMap[String, Object]()
      options.put("entity", entityData.get("existing"))
      val client = SmsapiSDK.testSDK(options, null)

      val idmap = new LinkedHashMap[String, Object]()
      idmap.put("shipment_country_volume01", "SHIPMENT_COUNTRY_VOLUME01")
      idmap.put("shipment_country_volume02", "SHIPMENT_COUNTRY_VOLUME02")
      idmap.put("shipment_country_volume03", "SHIPMENT_COUNTRY_VOLUME03")
      val now = System.currentTimeMillis()

      // LIST
      val shipmentCountryVolumeRef01Ent = client.shipmentCountryVolume(null)
      val shipmentCountryVolumeRef01Match = new LinkedHashMap[String, Object]()
      val shipmentCountryVolumeRef01ListResult = shipmentCountryVolumeRef01Ent.list(shipmentCountryVolumeRef01Match, null)
      rep.check("shipment_country_volume.list.islist", shipmentCountryVolumeRef01ListResult.isInstanceOf[JList[?]], "expected list result to be an array, got " + shipmentCountryVolumeRef01ListResult)
    }
  }
}
