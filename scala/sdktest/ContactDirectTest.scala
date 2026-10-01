// Generated direct-call tests for the contact entity (mirrors the java
// TestDirect generator). A dependency-free scala-cli test object driven by
// SdkEntityTestMain: an offline mock transport records each call and the
// asserts confirm path-param substitution and the response shape.

import java.util.{ArrayList, LinkedHashMap, List => JList, Map => JMap}
import java.util.function.{BiFunction, Supplier}

import voxgig.smsapisdk.core.{Helpers, SdkEntity, SmsapiSDK}

object ContactDirectTest {

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
    rep.scope("direct-list-contact") {
      val setup = directSetup(SdkTestSupport.jl(
          SdkTestSupport.om("id" -> "direct01"),
          SdkTestSupport.om("id" -> "direct02")))
      val client = setup.client

      val params = new LinkedHashMap[String, Object]()
      val result = client.direct(SdkTestSupport.om(
          "path" -> "contacts",
          "method" -> "GET",
          "params" -> params))

      rep.eq("direct-list-contact.ok", java.lang.Boolean.TRUE, result.get("ok"))
      rep.eqI("direct-list-contact.status", 200, Helpers.toInt(result.get("status")))
      rep.check("direct-list-contact.islist", result.get("data").isInstanceOf[JList[?]], "expected data to be an array, got " + result.get("data"))
      val listData = result.get("data").asInstanceOf[JList[Object]]
      rep.eqI("direct-list-contact.size", 2, listData.size())
      rep.eqI("direct-list-contact.calls", 1, setup.calls.size())
    }

    rep.scope("direct-load-contact") {
      val setup = directSetup(SdkTestSupport.om("id" -> "direct01"))
      val client = setup.client

      val params = new LinkedHashMap[String, Object]()
      params.put("contact_id", "direct01")
      params.put("group_id", "direct02")
      val result = client.direct(SdkTestSupport.om(
          "path" -> "contacts/groups/{group_id}/members/{contact_id}",
          "method" -> "GET",
          "params" -> params))

      rep.eq("direct-load-contact.ok", java.lang.Boolean.TRUE, result.get("ok"))
      rep.eqI("direct-load-contact.status", 200, Helpers.toInt(result.get("status")))
      rep.check("direct-load-contact.data", result.get("data") != null, "expected data to be non-null")
      val dataMap = Helpers.toMapAny(result.get("data"))
      if (dataMap != null) rep.eq("direct-load-contact.dataId", "direct01", dataMap.get("id"))
      rep.eqI("direct-load-contact.calls", 1, setup.calls.size())
      val url = setup.calls.get(0).get("url") match { case s: String => s; case _ => "" }
      rep.check("direct-load-contact.url1", url.contains("direct01"), "expected url to contain direct01, got " + url)
      rep.check("direct-load-contact.url2", url.contains("direct02"), "expected url to contain direct02, got " + url)
    }
  }
}
