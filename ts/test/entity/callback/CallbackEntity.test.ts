

import Path from 'node:path'
import * as Fs from 'node:fs'

import { test, describe, afterEach } from 'node:test'
import assert from 'node:assert'
import { createLiveTransport } from '../../live-runner'
import { runLiveEntity } from '../../live-entity'


import { SmsapiSDK, BaseFeature, stdutil } from '../../..'

import {
  envOverride,
  liveClientOptions,
  liveDelay,
  loadEnvLocal,
  makeCtrl,
  makeMatch,
  makeReqdata,
  makeStepData,
  makeValid,
  maybeSkipControl,
} from '../../utility'


loadEnvLocal(__dirname + '/../../../.env.local')


describe('CallbackEntity', async () => {

  // Per-test live pacing. Delay is read from sdk-test-control.json's
  // `test.live.delayMs`; only sleeps when SMSAPI_TEST_LIVE=TRUE.
  afterEach(liveDelay('SMSAPI_TEST_LIVE'))

  test('instance', async () => {
    const testsdk = SmsapiSDK.test()
    const ent = testsdk.Callback()
    assert(null != ent)
  })


  test('basic', async (t) => {

    const live = 'TRUE' === process.env.SMSAPI_TEST_LIVE
    for (const op of ['create', 'list', 'update', 'load', 'remove']) {
      if (!live && maybeSkipControl(t, 'entityOp', 'callback.' + op, live)) return
    }

    
    const setup = basicSetup()
    if (setup.live) {
      return runLiveEntity(setup, {"active":true,"alias":{"field":{}},"fields":{"active":{"a":true,"h":"Active","n":"active","r":false,"t":"`$BOOLEAN`","key$":"active","index$":0},"api_version":{"a":true,"h":"Api Version","n":"api_version","r":false,"sh":"Version of the callback output format.","t":"`$INTEGER`","key$":"api_version","index$":1},"id":{"a":true,"fo":"oid","h":"Id","n":"id","r":false,"sh":"Object ID","t":"`$STRING`","key$":"id","index$":2},"invalid":{"a":true,"h":"Invalid","n":"invalid","r":false,"t":"`$BOOLEAN`","key$":"invalid","index$":3},"receiver":{"a":true,"h":"Receiver","n":"receiver","r":false,"t":"`$OBJECT`","key$":"receiver","index$":4},"receiver_type":{"a":true,"h":"Receiver Type","n":"receiver_type","r":false,"t":"`$STRING`","key$":"receiver_type","index$":5},"type":{"a":true,"h":"Type","n":"type","r":false,"t":"`$STRING`","key$":"type","index$":6},"url":{"a":true,"fo":"url","h":"Url","n":"url","op":{"update":{"req":true,"type":"`$STRING`"}},"r":false,"sh":"WHATWG URL compliant","t":"`$STRING`","key$":"url","index$":7}},"id":{"field":"id","name":"id"},"name":"callback","op":{"create":{"input":"data","name":"create","points":[{"a":true,"co":{"id":"POST /callbacks","source":"openapi3","version":2},"g":{},"k":"http","m":"POST","o":"/callbacks","q":{},"r":{},"s":[{"lit":"callbacks"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":0}],"key$":"create"},"list":{"input":"data","name":"list","points":[{"a":true,"co":{"id":"GET /callbacks","source":"openapi3","version":2},"g":{},"k":"http","m":"GET","o":"/callbacks","q":{},"r":{},"s":[{"lit":"callbacks"}],"t":{"req":"`reqdata`","res":"`body.collection`"},"index$":0}],"key$":"list"},"load":{"input":"data","name":"load","points":[{"a":true,"co":{"id":"GET /callbacks/{id}","source":"openapi3","version":2},"g":{"params":[{"a":true,"ex":"0f0f0f0f0f0f0f0f0f0f0f0f","k":"param","n":"id","or":"id","r":true,"t":"`$STRING`","index$":0}]},"k":"http","m":"GET","o":"/callbacks/{id}","q":{"exist":["id"]},"r":{},"s":[{"lit":"callbacks"},{"var":"id"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":0},{"a":true,"co":{"id":"GET /callbacks/{id}/commands/test","source":"openapi3","version":2},"g":{"params":[{"a":true,"ex":"0f0f0f0f0f0f0f0f0f0f0f0f","k":"param","n":"id","or":"id","r":true,"t":"`$STRING`","index$":0}]},"k":"http","m":"GET","o":"/callbacks/{id}/commands/test","q":{"$action":"command_test","exist":["id"]},"r":{},"s":[{"lit":"callbacks"},{"var":"id"},{"lit":"commands"},{"lit":"test"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":1}],"key$":"load"},"remove":{"input":"data","name":"remove","points":[{"a":true,"co":{"id":"DELETE /callbacks/{id}","source":"openapi3","version":2},"g":{"params":[{"a":true,"ex":"0f0f0f0f0f0f0f0f0f0f0f0f","k":"param","n":"id","or":"id","r":true,"t":"`$STRING`","index$":0}]},"k":"http","m":"DELETE","o":"/callbacks/{id}","q":{"exist":["id"]},"r":{},"s":[{"lit":"callbacks"},{"var":"id"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":0}],"key$":"remove"},"update":{"input":"data","name":"update","points":[{"a":true,"co":{"id":"PUT /callbacks/{id}","source":"openapi3","version":2},"g":{"params":[{"a":true,"ex":"0f0f0f0f0f0f0f0f0f0f0f0f","k":"param","n":"id","or":"id","r":true,"t":"`$STRING`","index$":0}]},"k":"http","m":"PUT","o":"/callbacks/{id}","q":{"exist":["id"]},"r":{},"s":[{"lit":"callbacks"},{"var":"id"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":0},{"a":true,"co":{"id":"PUT /callbacks/{id}/commands/activate","source":"openapi3","version":2},"g":{"params":[{"a":true,"ex":"0f0f0f0f0f0f0f0f0f0f0f0f","k":"param","n":"id","or":"id","r":true,"t":"`$STRING`","index$":0}]},"k":"http","m":"PUT","o":"/callbacks/{id}/commands/activate","q":{"$action":"command_activate","exist":["id"]},"r":{},"s":[{"lit":"callbacks"},{"var":"id"},{"lit":"commands"},{"lit":"activate"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":1},{"a":true,"co":{"id":"PUT /callbacks/{id}/commands/deactivate","source":"openapi3","version":2},"g":{"params":[{"a":true,"ex":"0f0f0f0f0f0f0f0f0f0f0f0f","k":"param","n":"id","or":"id","r":true,"t":"`$STRING`","index$":0}]},"k":"http","m":"PUT","o":"/callbacks/{id}/commands/deactivate","q":{"$action":"command_deactivate","exist":["id"]},"r":{},"s":[{"lit":"callbacks"},{"var":"id"},{"lit":"commands"},{"lit":"deactivate"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":2}],"key$":"update"}},"relations":{"ancestors":[]},"key$":"callback","name__orig":"callback","Name":"Callback","name_":"callback","name-":"callback","NAME":"CALLBACK","index$":2}, {"active":true,"entity":"callback","key$":"BasicCallbackFlow","kind":"basic","name":"BasicCallbackFlow","param":{},"step":[{"a":true,"d":{},"i":{"ref":"callback_ref01"},"m":{},"o":"create","s":[],"v":[],"index$":0},{"a":true,"d":{},"i":{},"m":{},"o":"list","s":[],"v":[{"apply":"ItemExists","def":{"ref":"callback_ref01"}}],"index$":1},{"a":true,"d":{},"i":{"ref":"callback_ref01","srcdatavar":"callback_ref01_data","suffix":"_up0","textfield":"receiver_type"},"m":{},"o":"update","s":[{"apply":"TextFieldMark","def":{"mark":"Mark01-callback_ref01"}}],"v":[],"index$":2},{"a":true,"d":{},"i":{"ref":"callback_ref01","srcdatavar":"callback_ref01_data","suffix":"_dt0"},"m":{"id":"callback01"},"o":"load","s":[],"v":[{"apply":"TextFieldMark","def":{"mark":"Mark01-callback_ref01"}}],"index$":3},{"a":true,"d":{},"i":{"ref":"callback_ref01","suffix":"_rm0"},"m":{"id":"callback01"},"o":"remove","s":[],"v":[],"index$":4},{"a":true,"d":{},"i":{"suffix":"_rt0"},"m":{},"o":"list","s":[],"v":[{"apply":"ItemNotExists","def":{"ref":"callback_ref01"}}],"index$":5}]}, 'Callback', {"POST /callbacks":{"protocol":"http","requestBody":{"content":{"application/json":{"schema":{"oneOf":[{"allOf":[{"type":"object","required":["url","type"],"properties":{"url":{},"api_version":{},"type":{}},"discriminator":{"propertyName":"type","mapping":{}},"x-ref":"#/components/schemas/Callback"}],"type":"object","required":["receiver_type"],"properties":{"type":{"enum":["sms_mo","mms_mo"]},"receiver_type":{"type":"string","enum":["all","2way","number"]},"receiver_number":{"type":"string"}},"example":{"url":"https://smsapi.pl","type":"sms_mo","receiver_type":"number","receiver_number":"123123123"},"x-ref":"#/components/schemas/CallbackMo"},{"allOf":[{"type":"object","required":["url","type"],"properties":{"url":{},"api_version":{},"type":{}},"discriminator":{"propertyName":"type","mapping":{}},"x-ref":"#/components/schemas/Callback"}],"type":"object","properties":{"type":{"enum":["sms_dlr","mms_dlr","vms_dlr"]}},"example":{"url":"https://smsapi.pl","type":"sms_dlr"},"x-ref":"#/components/schemas/CallbackDlr"},{"allOf":[{"type":"object","required":["url","type"],"properties":{"url":{},"api_version":{},"type":{}},"discriminator":{"propertyName":"type","mapping":{}},"x-ref":"#/components/schemas/Callback"}],"type":"object","properties":{"type":{"enum":["hlr"]}},"example":{"url":"https://smsapi.pl","type":"hlr"},"x-ref":"#/components/schemas/CallbackHlr"},{"allOf":[{"type":"object","required":["url","type"],"properties":{"url":{},"api_version":{},"type":{}},"discriminator":{"propertyName":"type","mapping":{}},"x-ref":"#/components/schemas/Callback"}],"type":"object","properties":{"type":{"enum":["bulk"]}},"example":{"url":"https://smsapi.pl","type":"bulk"},"x-ref":"#/components/schemas/CallbackBulk"},{"allOf":[{"type":"object","required":["url","type"],"properties":{"url":{},"api_version":{},"type":{}},"discriminator":{"propertyName":"type","mapping":{}},"x-ref":"#/components/schemas/Callback"}],"type":"object","properties":{"type":{"enum":["short_url"]}},"example":{"url":"https://smsapi.pl","type":"short_url"},"x-ref":"#/components/schemas/CallbackShortUrl"}],"index$":1},"examples":{"create_callback_sms_mo_all":{"summary":"SMS receive report callback","value":{"type":"sms_mo","url":"http://example.com","receiver_type":"all"}},"create_callback_sms_mo_2way":{"summary":"SMS receive report callback with 2WAY","value":{"type":"sms_mo","url":"http://example.com","receiver_type":"2way"}},"create_callback_sms_mo_number":{"summary":"SMS receive report callback with receiver number","value":{"type":"sms_mo","url":"http://example.com","receiver_type":"number","receiver_number":"123123123"}},"create_callback_sms_dlr":{"summary":"SMS delivery report callback","value":{"type":"sms_dlr","url":"http://example.com"}}}}},"required":true,"x-ref":"#/components/requestBodies/CreateCallbackRequest"},"parameters":[]},"GET /callbacks":{"protocol":"http","parameters":[]},"GET /callbacks/{id}":{"protocol":"http","parameters":[{"name":"id","in":"path","required":true,"schema":{"type":"string","format":"oid","pattern":"[0-9a-fA-F]{24}","description":"Object ID","example":"0f0f0f0f0f0f0f0f0f0f0f0f","x-ref":"#/components/schemas/Id"},"x-ref":"#/components/parameters/Id","index$":0}]},"GET /callbacks/{id}/commands/test":{"protocol":"http","parameters":[{"name":"id","in":"path","required":true,"schema":{"type":"string","format":"oid","pattern":"[0-9a-fA-F]{24}","description":"Object ID","example":"0f0f0f0f0f0f0f0f0f0f0f0f","x-ref":"#/components/schemas/Id"},"x-ref":"#/components/parameters/Id","index$":0}]},"DELETE /callbacks/{id}":{"protocol":"http","parameters":[{"name":"id","in":"path","required":true,"schema":{"type":"string","format":"oid","pattern":"[0-9a-fA-F]{24}","description":"Object ID","example":"0f0f0f0f0f0f0f0f0f0f0f0f","x-ref":"#/components/schemas/Id"},"x-ref":"#/components/parameters/Id","index$":0}]},"PUT /callbacks/{id}":{"protocol":"http","requestBody":{"required":true,"content":{"application/json":{"schema":{"type":"object","required":["url"],"properties":{"url":{"type":"string","format":"url","description":"WHATWG URL compliant","example":"https://smsapi.pl","x-ref":"#/components/schemas/Url","key$":"url"},"api_version":{"type":"integer","description":"Version of the callback output format. Supported values depend on the callback type; when omitted on creation the default version of the given type is used.\n","example":1,"x-ref":"#/components/schemas/CallbackApiVersion","key$":"api_version"}},"x-ref":"#/components/schemas/UpdateCallback","index$":1}}}},"parameters":[{"name":"id","in":"path","required":true,"schema":{"type":"string","format":"oid","pattern":"[0-9a-fA-F]{24}","description":"Object ID","example":"0f0f0f0f0f0f0f0f0f0f0f0f","x-ref":"#/components/schemas/Id"},"x-ref":"#/components/parameters/Id","index$":0}]},"PUT /callbacks/{id}/commands/activate":{"protocol":"http","parameters":[{"name":"id","in":"path","required":true,"schema":{"type":"string","format":"oid","pattern":"[0-9a-fA-F]{24}","description":"Object ID","example":"0f0f0f0f0f0f0f0f0f0f0f0f","x-ref":"#/components/schemas/Id"},"x-ref":"#/components/parameters/Id","index$":0}]},"PUT /callbacks/{id}/commands/deactivate":{"protocol":"http","parameters":[{"name":"id","in":"path","required":true,"schema":{"type":"string","format":"oid","pattern":"[0-9a-fA-F]{24}","description":"Object ID","example":"0f0f0f0f0f0f0f0f0f0f0f0f","x-ref":"#/components/schemas/Id"},"x-ref":"#/components/parameters/Id","index$":0}]}})
    }
    const client = setup.client
    const struct = setup.struct

    const isempty = struct.isempty
    const select = struct.select


    // CREATE
    const callback_ref01_ent = client.Callback()
    let callback_ref01_data = setup.data.new.callback['callback_ref01']

    callback_ref01_data = (await callback_ref01_ent.create(callback_ref01_data)).data()
    assert(null != callback_ref01_data.id)


    // LIST
    const callback_ref01_match: any = {}

    const callback_ref01_list = (await callback_ref01_ent.list(callback_ref01_match)).map((e: any) => e.data())

    assert(!isempty(select(callback_ref01_list, { id: callback_ref01_data.id })))


    // UPDATE
    const callback_ref01_data_up0: any = {}
    callback_ref01_data_up0.id = callback_ref01_data.id

    const callback_ref01_markdef_up0 = { name: 'receiver_type', value: 'Mark01-callback_ref01_' + setup.now }
    ;(callback_ref01_data_up0 as any)[callback_ref01_markdef_up0.name] = callback_ref01_markdef_up0.value

    const callback_ref01_resdata_up0 = (await callback_ref01_ent.update(callback_ref01_data_up0)).data()
    assert(callback_ref01_resdata_up0.id === callback_ref01_data_up0.id)

    assert((callback_ref01_resdata_up0 as any)[callback_ref01_markdef_up0.name] === callback_ref01_markdef_up0.value)


    // LOAD
    const callback_ref01_match_dt0: any = {}
    callback_ref01_match_dt0.id = callback_ref01_data.id
    const callback_ref01_data_dt0 = (await callback_ref01_ent.load(callback_ref01_match_dt0)).data()
    assert(callback_ref01_data_dt0.id === callback_ref01_data.id)


    // REMOVE
    const callback_ref01_match_rm0: any = { id: callback_ref01_data.id }
    await callback_ref01_ent.remove(callback_ref01_match_rm0)
  

    // LIST
    const callback_ref01_match_rt0: any = {}

    const callback_ref01_list_rt0 = (await callback_ref01_ent.list(callback_ref01_match_rt0)).map((e: any) => e.data())

    assert(isempty(select(callback_ref01_list_rt0, { id: callback_ref01_data.id })))


  })
})



function basicSetup(extra?: any) {
  // TODO: fix test def options
  const options: any = {} // null

  // TODO: needs test utility to resolve path
  const entityDataFile =
    Path.resolve(__dirname, 
      '../../../../.sdk/test/entity/callback/CallbackTestData.json')

  // TODO: file ready util needed?
  const entityDataSource = Fs.readFileSync(entityDataFile).toString('utf8')

  // TODO: need a xlang JSON parse utility in voxgig/struct with better error msgs
  const entityData = JSON.parse(entityDataSource)

  options.entity = entityData.existing

  let client = SmsapiSDK.test(options, extra)
  const struct = client.utility().struct
  const merge = struct.merge
  const transform = struct.transform

  let idmap = transform(
    ['callback01','callback02','callback03'],
    {
      '`$PACK`': ['', {
        '`$KEY`': '`$COPY`',
        '`$VAL`': ['`$FORMAT`', 'upper', '`$COPY`']
      }]
    })

  const env = envOverride({
    'SMSAPI_TEST_CALLBACK_ENTID': idmap,
    'SMSAPI_TEST_LIVE': 'FALSE',
    'SMSAPI_TEST_EXPLAIN': 'FALSE',
    'SMSAPI_APIKEY': '',
  })

  idmap = env['SMSAPI_TEST_CALLBACK_ENTID']

  const live = 'TRUE' === env.SMSAPI_TEST_LIVE

  const transport = createLiveTransport()
  if (live) {
    const rawIds = process.env['SMSAPI_TEST_CALLBACK_ENTID']
    idmap = rawIds && rawIds.trim() ? JSON.parse(rawIds) : {}
    if (!idmap || Array.isArray(idmap) || typeof idmap !== 'object') {
      throw new Error('Live ENTID must be a JSON object')
    }
    client = new SmsapiSDK(merge([
      // FIRST, so the generated fields below win: sdk-test-control.json's
      // test.client.options adds to the live client, it does not redirect it.
      liveClientOptions(),
      {
        apikey: env.SMSAPI_APIKEY,
      },
      // 'extra || {}', not a bare 'extra': struct.merge returns UNDEFINED when the
      // last entry is undefined, and basicSetup is normally called with no
      // argument at all - so a bare 'extra' silently discarded the apikey
      // and server values above and handed the SDK undefined. Harmless
      // while there was nothing in that object; not harmless now.
      extra || {},
      { system: { fetch: transport.fetch } }
    ]))
  }

  const setup = {
    idmap,
    env,
    options,
    client,
    struct,
    data: entityData,
    explain: 'TRUE' === env.SMSAPI_TEST_EXPLAIN,
    live,
    transport,
    now: Date.now(),
  }

  return setup
}
  
