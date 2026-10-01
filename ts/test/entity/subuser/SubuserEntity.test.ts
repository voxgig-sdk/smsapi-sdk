

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


describe('SubuserEntity', async () => {

  // Per-test live pacing. Delay is read from sdk-test-control.json's
  // `test.live.delayMs`; only sleeps when SMSAPI_TEST_LIVE=TRUE.
  afterEach(liveDelay('SMSAPI_TEST_LIVE'))

  test('instance', async () => {
    const testsdk = SmsapiSDK.test()
    const ent = testsdk.Subuser()
    assert(null != ent)
  })


  test('basic', async (t) => {

    const live = 'TRUE' === process.env.SMSAPI_TEST_LIVE
    for (const op of ['create', 'list', 'update', 'load', 'remove']) {
      if (!live && maybeSkipControl(t, 'entityOp', 'subuser.' + op, live)) return
    }

    
    const setup = basicSetup()
    if (setup.live) {
      return runLiveEntity(setup, {"active":true,"alias":{"field":{}},"fields":{"active":{"a":true,"h":"Active","n":"active","r":false,"t":"`$BOOLEAN`","key$":"active","index$":0},"credentials":{"a":true,"h":"Credentials","n":"credentials","op":{"update":{"req":false,"type":"`$OBJECT`"}},"r":true,"t":"`$OBJECT`","key$":"credentials","index$":1},"description":{"a":true,"h":"Description","n":"description","r":false,"t":"`$STRING`","key$":"description","index$":2},"id":{"a":true,"fo":"oid","h":"Id","n":"id","r":false,"sh":"Object ID","t":"`$STRING`","key$":"id","index$":3},"points":{"a":true,"h":"Points","n":"points","r":false,"t":"`$OBJECT`","key$":"points","index$":4},"username":{"a":true,"h":"Username","n":"username","r":false,"t":"`$STRING`","key$":"username","index$":5}},"id":{"field":"id","name":"id"},"name":"subuser","op":{"create":{"input":"data","name":"create","points":[{"a":true,"co":{"id":"POST /subusers","source":"openapi3","version":2},"g":{},"k":"http","m":"POST","o":"/subusers","q":{},"r":{},"s":[{"lit":"subusers"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":0}],"key$":"create"},"list":{"input":"data","name":"list","points":[{"a":true,"co":{"id":"GET /subusers/{id}/shares/sendernames","source":"openapi3","version":2},"g":{"params":[{"a":true,"ex":"0f0f0f0f0f0f0f0f0f0f0f0f","k":"param","n":"id","or":"id","r":true,"t":"`$STRING`","index$":0}]},"k":"http","m":"GET","o":"/subusers/{id}/shares/sendernames","q":{"$action":"share_sendername","exist":["id"]},"r":{},"s":[{"lit":"subusers"},{"var":"id"},{"lit":"shares"},{"lit":"sendernames"}],"t":{"req":"`reqdata`","res":"`body.senders`"},"index$":0},{"a":true,"co":{"id":"GET /subusers/{id}/shares/templates","source":"openapi3","version":2},"g":{"params":[{"a":true,"ex":"0f0f0f0f0f0f0f0f0f0f0f0f","k":"param","n":"id","or":"id","r":true,"t":"`$STRING`","index$":0}]},"k":"http","m":"GET","o":"/subusers/{id}/shares/templates","q":{"$action":"share_template","exist":["id"]},"r":{},"s":[{"lit":"subusers"},{"var":"id"},{"lit":"shares"},{"lit":"templates"}],"t":{"req":"`reqdata`","res":"`body.templates`"},"index$":1},{"a":true,"co":{"id":"GET /subusers","source":"openapi3","version":2},"g":{"query":[{"a":true,"k":"query","n":"q","or":"q","r":false,"t":"`$STRING`","index$":0}]},"k":"http","m":"GET","o":"/subusers","q":{"exist":["q"]},"r":{},"s":[{"lit":"subusers"}],"t":{"req":"`reqdata`","res":"`body.collection`"},"index$":2}],"key$":"list"},"load":{"input":"data","name":"load","points":[{"a":true,"co":{"id":"GET /subusers/{id}","source":"openapi3","version":2},"g":{"params":[{"a":true,"ex":"0f0f0f0f0f0f0f0f0f0f0f0f","k":"param","n":"id","or":"id","r":true,"t":"`$STRING`","index$":0}]},"k":"http","m":"GET","o":"/subusers/{id}","q":{"exist":["id"]},"r":{},"s":[{"lit":"subusers"},{"var":"id"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":0}],"key$":"load"},"remove":{"input":"data","name":"remove","points":[{"a":true,"co":{"id":"DELETE /subusers/{id}","source":"openapi3","version":2},"g":{"params":[{"a":true,"ex":"0f0f0f0f0f0f0f0f0f0f0f0f","k":"param","n":"id","or":"id","r":true,"t":"`$STRING`","index$":0}]},"k":"http","m":"DELETE","o":"/subusers/{id}","q":{"exist":["id"]},"r":{},"s":[{"lit":"subusers"},{"var":"id"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":0}],"key$":"remove"},"update":{"input":"data","name":"update","points":[{"a":true,"co":{"id":"PUT /subusers/{id}","source":"openapi3","version":2},"g":{"params":[{"a":true,"ex":"0f0f0f0f0f0f0f0f0f0f0f0f","k":"param","n":"id","or":"id","r":true,"t":"`$STRING`","index$":0}]},"k":"http","m":"PUT","o":"/subusers/{id}","q":{"exist":["id"]},"r":{},"s":[{"lit":"subusers"},{"var":"id"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":0},{"a":true,"co":{"id":"PUT /subusers/{id}/shares/sendernames","source":"openapi3","version":2},"g":{"params":[{"a":true,"ex":"0f0f0f0f0f0f0f0f0f0f0f0f","k":"param","n":"id","or":"id","r":true,"t":"`$STRING`","index$":0}]},"k":"http","m":"PUT","o":"/subusers/{id}/shares/sendernames","q":{"$action":"share_sendername","exist":["id"]},"r":{},"s":[{"lit":"subusers"},{"var":"id"},{"lit":"shares"},{"lit":"sendernames"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":1},{"a":true,"co":{"id":"PUT /subusers/{id}/shares/templates","source":"openapi3","version":2},"g":{"params":[{"a":true,"ex":"0f0f0f0f0f0f0f0f0f0f0f0f","k":"param","n":"id","or":"id","r":true,"t":"`$STRING`","index$":0}]},"k":"http","m":"PUT","o":"/subusers/{id}/shares/templates","q":{"$action":"share_template","exist":["id"]},"r":{},"s":[{"lit":"subusers"},{"var":"id"},{"lit":"shares"},{"lit":"templates"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":2}],"key$":"update"}},"relations":{"ancestors":[]},"key$":"subuser","name__orig":"subuser","Name":"Subuser","name_":"subuser","name-":"subuser","NAME":"SUBUSER","index$":25}, {"active":true,"entity":"subuser","key$":"BasicSubuserFlow","kind":"basic","name":"BasicSubuserFlow","param":{},"step":[{"a":true,"d":{},"i":{"ref":"subuser_ref01"},"m":{},"o":"create","s":[],"v":[],"index$":0},{"a":true,"d":{},"i":{},"m":{},"o":"list","s":[],"v":[{"apply":"ItemExists","def":{"ref":"subuser_ref01"}}],"index$":1},{"a":true,"d":{},"i":{"ref":"subuser_ref01","srcdatavar":"subuser_ref01_data","suffix":"_up0","textfield":"description"},"m":{},"o":"update","s":[{"apply":"TextFieldMark","def":{"mark":"Mark01-subuser_ref01"}}],"v":[],"index$":2},{"a":true,"d":{},"i":{"ref":"subuser_ref01","srcdatavar":"subuser_ref01_data","suffix":"_dt0"},"m":{"id":"subuser01"},"o":"load","s":[],"v":[{"apply":"TextFieldMark","def":{"mark":"Mark01-subuser_ref01"}}],"index$":3},{"a":true,"d":{},"i":{"ref":"subuser_ref01","suffix":"_rm0"},"m":{"id":"subuser01"},"o":"remove","s":[],"v":[],"index$":4},{"a":true,"d":{},"i":{"suffix":"_rt0"},"m":{},"o":"list","s":[],"v":[{"apply":"ItemNotExists","def":{"ref":"subuser_ref01"}}],"index$":5}]}, 'Subuser', {"POST /subusers":{"protocol":"http","requestBody":{"required":true,"content":{"application/json":{"schema":{"type":"object","properties":{"credentials":{"type":"object","properties":{"username":{"type":"string","example":"example_username","x-ref":"#/components/schemas/Username"},"password":{"type":"string","example":"example_password","x-ref":"#/components/schemas/Password"},"api_password":{"type":"string","example":"example_password","x-ref":"#/components/schemas/Password"}},"required":["username","password"],"x-ref":"#/components/schemas/CreateSubuserCredentials","key$":"credentials"},"active":{"oneOf":[{"type":"boolean"},{"type":"integer"}],"key$":"active"},"description":{"type":"string","example":"Resource description","x-ref":"#/components/schemas/Description","key$":"description"},"points":{"type":"object","properties":{"from_account":{"format":"float","type":"number"},"per_month":{"format":"float","type":"number"}},"x-ref":"#/components/schemas/SubuserPoints","key$":"points"}},"x-ref":"#/components/schemas/CreateSubuser","index$":1}}}},"parameters":[]},"GET /subusers/{id}/shares/sendernames":{"protocol":"http","parameters":[{"name":"id","in":"path","required":true,"schema":{"type":"string","format":"oid","pattern":"[0-9a-fA-F]{24}","description":"Object ID","example":"0f0f0f0f0f0f0f0f0f0f0f0f","x-ref":"#/components/schemas/Id"},"x-ref":"#/components/parameters/Id","index$":0}]},"GET /subusers/{id}/shares/templates":{"protocol":"http","parameters":[{"name":"id","in":"path","required":true,"schema":{"type":"string","format":"oid","pattern":"[0-9a-fA-F]{24}","description":"Object ID","example":"0f0f0f0f0f0f0f0f0f0f0f0f","x-ref":"#/components/schemas/Id"},"x-ref":"#/components/parameters/Id","index$":0}]},"GET /subusers":{"protocol":"http","parameters":[{"name":"q","in":"query","schema":{"type":"string"},"required":false,"description":"Filter by username (like, case insensitive)","x-ref":"#/components/parameters/SubusersQuery","index$":0}]},"GET /subusers/{id}":{"protocol":"http","parameters":[{"name":"id","in":"path","required":true,"schema":{"type":"string","format":"oid","pattern":"[0-9a-fA-F]{24}","description":"Object ID","example":"0f0f0f0f0f0f0f0f0f0f0f0f","x-ref":"#/components/schemas/Id"},"x-ref":"#/components/parameters/Id","index$":0}]},"DELETE /subusers/{id}":{"protocol":"http","parameters":[{"name":"id","in":"path","required":true,"schema":{"type":"string","format":"oid","pattern":"[0-9a-fA-F]{24}","description":"Object ID","example":"0f0f0f0f0f0f0f0f0f0f0f0f","x-ref":"#/components/schemas/Id"},"x-ref":"#/components/parameters/Id","index$":0}]},"PUT /subusers/{id}":{"protocol":"http","requestBody":{"required":true,"content":{"application/json":{"schema":{"type":"object","properties":{"credentials":{"type":"object","properties":{"password":{"type":"string","example":"example_password","x-ref":"#/components/schemas/Password"},"api_password":{"type":"string","example":"example_password","x-ref":"#/components/schemas/Password"}},"x-ref":"#/components/schemas/UpdateSubuserCredentials","key$":"credentials"},"active":{"type":"boolean","key$":"active"},"description":{"type":"string","example":"Resource description","x-ref":"#/components/schemas/Description","key$":"description"},"points":{"type":"object","properties":{"from_account":{"format":"float","type":"number"},"per_month":{"format":"float","type":"number"}},"x-ref":"#/components/schemas/SubuserPoints","key$":"points"}},"x-ref":"#/components/schemas/UpdateSubuser","index$":1}}}},"parameters":[{"name":"id","in":"path","required":true,"schema":{"type":"string","format":"oid","pattern":"[0-9a-fA-F]{24}","description":"Object ID","example":"0f0f0f0f0f0f0f0f0f0f0f0f","x-ref":"#/components/schemas/Id"},"x-ref":"#/components/parameters/Id","index$":0}]},"PUT /subusers/{id}/shares/sendernames":{"protocol":"http","requestBody":{"required":true,"content":{"application/json":{"schema":{"type":"object","properties":{"access":{"enum":["all","none","selected"],"key$":"access","type":"string"},"senders":{"items":{"type":"string"},"key$":"senders","nullable":true,"type":"array"}},"required":["access"],"x-ref":"#/components/schemas/SubuserSendernamesAccess"}}}},"parameters":[{"name":"id","in":"path","required":true,"schema":{"type":"string","format":"oid","pattern":"[0-9a-fA-F]{24}","description":"Object ID","example":"0f0f0f0f0f0f0f0f0f0f0f0f","x-ref":"#/components/schemas/Id"},"x-ref":"#/components/parameters/Id","index$":0}]},"PUT /subusers/{id}/shares/templates":{"protocol":"http","requestBody":{"required":true,"content":{"application/json":{"schema":{"type":"object","properties":{"access":{"enum":["all","none","selected"],"key$":"access","type":"string"},"templates":{"items":{"type":"string"},"key$":"templates","nullable":true,"type":"array"}},"required":["access"],"x-ref":"#/components/schemas/SubuserTemplatesAccess"}}}},"parameters":[{"name":"id","in":"path","required":true,"schema":{"type":"string","format":"oid","pattern":"[0-9a-fA-F]{24}","description":"Object ID","example":"0f0f0f0f0f0f0f0f0f0f0f0f","x-ref":"#/components/schemas/Id"},"x-ref":"#/components/parameters/Id","index$":0}]}})
    }
    const client = setup.client
    const struct = setup.struct

    const isempty = struct.isempty
    const select = struct.select


    // CREATE
    const subuser_ref01_ent = client.Subuser()
    let subuser_ref01_data = setup.data.new.subuser['subuser_ref01']

    subuser_ref01_data = (await subuser_ref01_ent.create(subuser_ref01_data)).data()
    assert(null != subuser_ref01_data.id)


    // LIST
    const subuser_ref01_match: any = {}

    const subuser_ref01_list = (await subuser_ref01_ent.list(subuser_ref01_match)).map((e: any) => e.data())

    assert(!isempty(select(subuser_ref01_list, { id: subuser_ref01_data.id })))


    // UPDATE
    const subuser_ref01_data_up0: any = {}
    subuser_ref01_data_up0.id = subuser_ref01_data.id

    const subuser_ref01_markdef_up0 = { name: 'description', value: 'Mark01-subuser_ref01_' + setup.now }
    ;(subuser_ref01_data_up0 as any)[subuser_ref01_markdef_up0.name] = subuser_ref01_markdef_up0.value

    const subuser_ref01_resdata_up0 = (await subuser_ref01_ent.update(subuser_ref01_data_up0)).data()
    assert(subuser_ref01_resdata_up0.id === subuser_ref01_data_up0.id)

    assert((subuser_ref01_resdata_up0 as any)[subuser_ref01_markdef_up0.name] === subuser_ref01_markdef_up0.value)


    // LOAD
    const subuser_ref01_match_dt0: any = {}
    subuser_ref01_match_dt0.id = subuser_ref01_data.id
    const subuser_ref01_data_dt0 = (await subuser_ref01_ent.load(subuser_ref01_match_dt0)).data()
    assert(subuser_ref01_data_dt0.id === subuser_ref01_data.id)


    // REMOVE
    const subuser_ref01_match_rm0: any = { id: subuser_ref01_data.id }
    await subuser_ref01_ent.remove(subuser_ref01_match_rm0)
  

    // LIST
    const subuser_ref01_match_rt0: any = {}

    const subuser_ref01_list_rt0 = (await subuser_ref01_ent.list(subuser_ref01_match_rt0)).map((e: any) => e.data())

    assert(isempty(select(subuser_ref01_list_rt0, { id: subuser_ref01_data.id })))


  })
})



function basicSetup(extra?: any) {
  // TODO: fix test def options
  const options: any = {} // null

  // TODO: needs test utility to resolve path
  const entityDataFile =
    Path.resolve(__dirname, 
      '../../../../.sdk/test/entity/subuser/SubuserTestData.json')

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
    ['subuser01','subuser02','subuser03'],
    {
      '`$PACK`': ['', {
        '`$KEY`': '`$COPY`',
        '`$VAL`': ['`$FORMAT`', 'upper', '`$COPY`']
      }]
    })

  const env = envOverride({
    'SMSAPI_TEST_SUBUSER_ENTID': idmap,
    'SMSAPI_TEST_LIVE': 'FALSE',
    'SMSAPI_TEST_EXPLAIN': 'FALSE',
    'SMSAPI_APIKEY': '',
  })

  idmap = env['SMSAPI_TEST_SUBUSER_ENTID']

  const live = 'TRUE' === env.SMSAPI_TEST_LIVE

  const transport = createLiveTransport()
  if (live) {
    const rawIds = process.env['SMSAPI_TEST_SUBUSER_ENTID']
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
  
