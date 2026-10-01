// Generated direct-call tests for the opt_out_setting entity (mirrors the java
// TestDirect generator). A dependency-free scala-cli test object driven by
// SdkEntityTestMain: an offline mock transport records each call and the
// asserts confirm path-param substitution and the response shape.

import java.util.{ArrayList, LinkedHashMap, List => JList, Map => JMap}
import java.util.function.{BiFunction, Supplier}

import voxgig.smsapisdk.core.{Helpers, SdkEntity, SmsapiSDK}

object OptOutSettingDirectTest {

  private class DirectSetup(val client: SmsapiSDK, val calls: JList[JMap[String, Object]])

  private def directSetup(mockres: Object): DirectSetup = {
    val calls = new ArrayList[JMap[String, Object]]()
    val mockdata: Object = if (mockres != null) mockres else SdkTestSupport.om("id" -> "direct01")
    val mockFetch: BiFunction[String, JMap[String, Object], Object] =
      (url, init) => {
        calls.add(SdkTestSupport.om("url" -> url, "init" -> init))
        val js: Supplier[Object] = () => mockdata
        SdkTestSupport.om(
          "status" -> SdkTestSupport.I(200),
          "statusText" -> "OK",
          "headers" -> new LinkedHashMap[String, Object](),
          "json" -> js)
      }
    val client = new SmsapiSDK(SdkTestSupport.om(
      "base" -> "http://localhost:8080",
      "system" -> SdkTestSupport.om("fetch" -> mockFetch)))
    new DirectSetup(client, calls)
  }

  def run(rep: SdkTestReport): Unit = {
    rep.scope("direct-load-opt_out_setting") {
      val setup = directSetup(SdkTestSupport.om("id" -> "direct01"))
      val client = setup.client

      val params = new LinkedHashMap[String, Object]()
      val result = client.direct(SdkTestSupport.om(
          "path" -> "opt_outs/settings",
          "method" -> "GET",
          "params" -> params))

      rep.eq("direct-load-opt_out_setting.ok", java.lang.Boolean.TRUE, result.get("ok"))
      rep.eqI("direct-load-opt_out_setting.status", 200, Helpers.toInt(result.get("status")))
      rep.check("direct-load-opt_out_setting.data", result.get("data") != null, "expected data to be non-null")
      val dataMap = Helpers.toMapAny(result.get("data"))
      if (dataMap != null) rep.eq("direct-load-opt_out_setting.dataId", "direct01", dataMap.get("id"))
      rep.eqI("direct-load-opt_out_setting.calls", 1, setup.calls.size())
    }
  }
}
