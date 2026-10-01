

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


describe('BlacklistEntity', async () => {

  // Per-test live pacing. Delay is read from sdk-test-control.json's
  // `test.live.delayMs`; only sleeps when SMSAPI_TEST_LIVE=TRUE.
  afterEach(liveDelay('SMSAPI_TEST_LIVE'))

  test('instance', async () => {
    const testsdk = SmsapiSDK.test()
    const ent = testsdk.Blacklist()
    assert(null != ent)
  })


  test('basic', async (t) => {

    const live = 'TRUE' === process.env.SMSAPI_TEST_LIVE
    for (const op of ['create', 'load', 'remove']) {
      if (!live && maybeSkipControl(t, 'entityOp', 'blacklist.' + op, live)) return
    }

    
    const setup = basicSetup()
    if (setup.live) {
      return runLiveEntity(setup, {"active":true,"alias":{"field":{}},"fields":{"id":{"a":true,"h":"Id","n":"id","r":false,"t":"`$STRING`","key$":"id","index$":0}},"id":{"field":"id","name":"id"},"name":"blacklist","op":{"create":{"input":"data","name":"create","points":[{"a":true,"co":{"id":"POST /blacklist/phone_numbers","source":"openapi3","version":2},"g":{},"k":"http","m":"POST","o":"/blacklist/phone_numbers","q":{"$action":"phone_number"},"r":{},"s":[{"lit":"blacklist"},{"lit":"phone_numbers"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":0},{"a":true,"co":{"id":"POST /blacklist/phone_numbers/imports","source":"openapi3","version":2},"g":{},"k":"http","m":"POST","o":"/blacklist/phone_numbers/imports","q":{},"r":{},"s":[{"lit":"blacklist"},{"lit":"phone_numbers"},{"lit":"imports"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":1}],"key$":"create"},"load":{"input":"data","name":"load","points":[{"a":true,"co":{"id":"GET /blacklist/phone_numbers","source":"openapi3","version":2},"g":{"header":[{"a":true,"ex":"application/json","k":"header","n":"accept","or":"Accept","r":false,"t":"`$STRING`","index$":0},{"a":true,"ex":false,"k":"header","n":"x_async","or":"x-async","r":false,"t":"`$BOOLEAN`","index$":1}],"query":[{"a":true,"ex":5,"k":"query","n":"limit","or":"limit","r":false,"t":"`$INTEGER`","index$":0},{"a":true,"ex":0,"k":"query","n":"offset","or":"offset","r":false,"t":"`$INTEGER`","index$":1},{"a":true,"ex":0,"k":"query","n":"q","or":"q","r":false,"t":"`$INTEGER`","index$":2}]},"k":"http","m":"GET","o":"/blacklist/phone_numbers","q":{"$action":"phone_number","exist":["accept","limit","offset","q","x_async"]},"r":{},"s":[{"lit":"blacklist"},{"lit":"phone_numbers"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":0}],"key$":"load"},"remove":{"input":"data","name":"remove","points":[{"a":true,"co":{"id":"DELETE /blacklist/phone_numbers/{id}","source":"openapi3","version":2},"g":{"params":[{"a":true,"ex":"0f0f0f0f0f0f0f0f0f0f0f0f","k":"param","n":"id","or":"id","r":true,"t":"`$STRING`","index$":0}]},"k":"http","m":"DELETE","o":"/blacklist/phone_numbers/{id}","q":{"exist":["id"]},"r":{},"s":[{"lit":"blacklist"},{"lit":"phone_numbers"},{"var":"id"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":0},{"a":true,"co":{"id":"DELETE /blacklist/phone_numbers","source":"openapi3","version":2},"g":{"query":[{"a":true,"k":"query","n":"phone_number","or":"phone_number","r":false,"t":"`$STRING`","index$":0}]},"k":"http","m":"DELETE","o":"/blacklist/phone_numbers","q":{"$action":"phone_number","exist":["phone_number"]},"r":{},"s":[{"lit":"blacklist"},{"lit":"phone_numbers"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":1}],"key$":"remove"}},"relations":{"ancestors":[]},"key$":"blacklist","name__orig":"blacklist","Name":"Blacklist","name_":"blacklist","name-":"blacklist","NAME":"BLACKLIST","index$":1}, {"active":true,"entity":"blacklist","key$":"BasicBlacklistFlow","kind":"basic","name":"BasicBlacklistFlow","param":{},"step":[{"a":true,"d":{},"i":{"ref":"blacklist_ref01"},"m":{},"o":"create","s":[],"v":[],"index$":0},{"a":true,"d":{},"i":{"ref":"blacklist_ref01","srcdatavar":"blacklist_ref01_data","suffix":"_dt0"},"m":{},"o":"load","s":[],"v":[{"apply":"TextFieldMark","def":{"mark":"Mark01-blacklist_ref01"}}],"index$":1},{"a":true,"d":{},"i":{"ref":"blacklist_ref01","suffix":"_rm0"},"m":{},"o":"remove","s":[],"v":[],"index$":2}]}, 'Blacklist', {"POST /blacklist/phone_numbers":{"protocol":"http","requestBody":{"required":true,"description":"Blacklist phone number","content":{"application/json":{"schema":{"type":"object","properties":{"phone_number":{"type":"string","pattern":"[0-9]{8,16}","example":"48327201200","x-ref":"#/components/schemas/PhoneNumber"},"expire_at":{"type":"string","format":"date","example":"2017-07-21","nullable":true,"x-ref":"#/components/schemas/DateNullable"}},"x-ref":"#/components/schemas/CreateBlacklistPhoneNumber"}},"application/x-www-form-urlencoded":{"schema":{"type":"object","properties":{"phone_number":{"type":"string","pattern":"[0-9]{8,16}","example":"48327201200","x-ref":"#/components/schemas/PhoneNumber"},"expire_at":{"type":"string","format":"date","example":"2017-07-21","nullable":true,"x-ref":"#/components/schemas/DateNullable"}},"x-ref":"#/components/schemas/CreateBlacklistPhoneNumber"}}}},"parameters":[]},"POST /blacklist/phone_numbers/imports":{"protocol":"http","requestBody":{"required":true,"description":"Blacklist import","content":{"multipart/form-data":{"schema":{"type":"object","properties":{"import":{"type":"string"}}}},"text/csv":{"schema":{"type":"string"}}}},"parameters":[]},"GET /blacklist/phone_numbers":{"protocol":"http","parameters":[{"name":"q","in":"query","required":false,"schema":{"type":"integer","default":0},"description":"query","x-ref":"#/components/parameters/q","index$":0},{"name":"offset","in":"query","required":false,"schema":{"type":"integer","default":0},"x-ref":"#/components/parameters/offset","index$":1},{"name":"limit","in":"query","required":false,"schema":{"type":"integer","default":5},"x-ref":"#/components/parameters/limit","index$":2},{"name":"x-async","description":"To generate CSV in background add also Content-Type: text/csv","schema":{"type":"boolean","default":false},"in":"header","required":false,"x-ref":"#/components/parameters/Async-Csv","index$":3},{"name":"Accept","in":"header","required":false,"schema":{"type":"string","enum":["application/json","text/csv"],"default":"application/json"},"x-ref":"#/components/parameters/Accept-Header-Csv","index$":4}]},"DELETE /blacklist/phone_numbers/{id}":{"protocol":"http","parameters":[{"name":"id","in":"path","required":true,"schema":{"type":"string","format":"oid","pattern":"[0-9a-fA-F]{24}","description":"Object ID","example":"0f0f0f0f0f0f0f0f0f0f0f0f","x-ref":"#/components/schemas/Id"},"x-ref":"#/components/parameters/Id","index$":0}]},"DELETE /blacklist/phone_numbers":{"protocol":"http","parameters":[{"name":"phone_number","in":"query","schema":{"type":"string"},"required":false,"description":"phone number","x-ref":"#/components/parameters/queryPhoneNumber","index$":0}]}})
    }
    const client = setup.client
    const struct = setup.struct

    const isempty = struct.isempty
    const select = struct.select


    // CREATE
    const blacklist_ref01_ent = client.Blacklist()
    let blacklist_ref01_data = setup.data.new.blacklist['blacklist_ref01']

    blacklist_ref01_data = (await blacklist_ref01_ent.create(blacklist_ref01_data)).data()
    assert(null != blacklist_ref01_data.id)


    // LOAD
    const blacklist_ref01_match_dt0: any = {}
    blacklist_ref01_match_dt0.id = blacklist_ref01_data.id
    const blacklist_ref01_data_dt0 = (await blacklist_ref01_ent.load(blacklist_ref01_match_dt0)).data()
    assert(blacklist_ref01_data_dt0.id === blacklist_ref01_data.id)


    // REMOVE
    const blacklist_ref01_match_rm0: any = { id: blacklist_ref01_data.id }
    await blacklist_ref01_ent.remove(blacklist_ref01_match_rm0)
  

  })
})



function basicSetup(extra?: any) {
  // TODO: fix test def options
  const options: any = {} // null

  // TODO: needs test utility to resolve path
  const entityDataFile =
    Path.resolve(__dirname, 
      '../../../../.sdk/test/entity/blacklist/BlacklistTestData.json')

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
    ['blacklist01','blacklist02','blacklist03'],
    {
      '`$PACK`': ['', {
        '`$KEY`': '`$COPY`',
        '`$VAL`': ['`$FORMAT`', 'upper', '`$COPY`']
      }]
    })

  const env = envOverride({
    'SMSAPI_TEST_BLACKLIST_ENTID': idmap,
    'SMSAPI_TEST_LIVE': 'FALSE',
    'SMSAPI_TEST_EXPLAIN': 'FALSE',
    'SMSAPI_APIKEY': '',
  })

  idmap = env['SMSAPI_TEST_BLACKLIST_ENTID']

  const live = 'TRUE' === env.SMSAPI_TEST_LIVE

  const transport = createLiveTransport()
  if (live) {
    const rawIds = process.env['SMSAPI_TEST_BLACKLIST_ENTID']
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
  
