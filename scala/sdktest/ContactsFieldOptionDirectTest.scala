// Generated direct-call tests for the contacts_field_option entity (mirrors the java
// TestDirect generator). A dependency-free scala-cli test object driven by
// SdkEntityTestMain: an offline mock transport records each call and the
// asserts confirm path-param substitution and the response shape.

import java.util.{ArrayList, LinkedHashMap, List => JList, Map => JMap}
import java.util.function.{BiFunction, Supplier}

import voxgig.smsapisdk.core.{Helpers, SdkEntity, SmsapiSDK}

object ContactsFieldOptionDirectTest {

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
    rep.scope("direct-list-contacts_field_option") {
      val setup = directSetup(SdkTestSupport.jl(
          SdkTestSupport.om("id" -> "direct01"),
          SdkTestSupport.om("id" -> "direct02")))
      val client = setup.client

      val params = new LinkedHashMap[String, Object]()
      params.put("field_id", "direct01")
      val result = client.direct(SdkTestSupport.om(
          "path" -> "contacts/fields/{field_id}/options",
          "method" -> "GET",
          "params" -> params))

      rep.eq("direct-list-contacts_field_option.ok", java.lang.Boolean.TRUE, result.get("ok"))
      rep.eqI("direct-list-contacts_field_option.status", 200, Helpers.toInt(result.get("status")))
      rep.check("direct-list-contacts_field_option.islist", result.get("data").isInstanceOf[JList[?]], "expected data to be an array, got " + result.get("data"))
      val listData = result.get("data").asInstanceOf[JList[Object]]
      rep.eqI("direct-list-contacts_field_option.size", 2, listData.size())
      rep.eqI("direct-list-contacts_field_option.calls", 1, setup.calls.size())
      val url = setup.calls.get(0).get("url") match { case s: String => s; case _ => "" }
      rep.check("direct-list-contacts_field_option.url1", url.contains("direct01"), "expected url to contain direct01, got " + url)
    }

  }
}
