

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


describe('SendernameEntity', async () => {

  // Per-test live pacing. Delay is read from sdk-test-control.json's
  // `test.live.delayMs`; only sleeps when SMSAPI_TEST_LIVE=TRUE.
  afterEach(liveDelay('SMSAPI_TEST_LIVE'))

  test('instance', async () => {
    const testsdk = SmsapiSDK.test()
    const ent = testsdk.Sendername()
    assert(null != ent)
  })


  test('basic', async (t) => {

    const live = 'TRUE' === process.env.SMSAPI_TEST_LIVE
    for (const op of ['create', 'list', 'load']) {
      if (!live && maybeSkipControl(t, 'entityOp', 'sendername.' + op, live)) return
    }

    
    const setup = basicSetup()
    if (setup.live) {
      return runLiveEntity(setup, {"active":true,"alias":{"field":{}},"fields":{"created_at":{"a":true,"fo":"date-time","h":"Created At","n":"created_at","r":false,"t":"`$STRING`","key$":"created_at","index$":0},"id":{"a":true,"h":"Id","n":"id","r":false,"t":"`$STRING`","key$":"id","index$":1},"is_default":{"a":true,"h":"Is Default","n":"is_default","r":false,"t":"`$BOOLEAN`","key$":"is_default","index$":2},"sender":{"a":true,"h":"Sender","n":"sender","r":false,"sh":"Sendername","t":"`$STRING`","key$":"sender","index$":3},"status":{"a":true,"h":"Status","n":"status","r":false,"t":"`$STRING`","key$":"status","index$":4}},"id":{"field":"id","name":"id"},"name":"sendername","op":{"create":{"input":"data","name":"create","points":[{"a":true,"co":{"id":"POST /sms/sendernames","source":"openapi3","version":2},"g":{},"k":"http","m":"POST","o":"/sms/sendernames","q":{},"r":{},"s":[{"lit":"sms"},{"lit":"sendernames"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":0}],"key$":"create"},"list":{"input":"data","name":"list","points":[{"a":true,"co":{"id":"GET /sms/sendernames","source":"openapi3","version":2},"g":{},"k":"http","m":"GET","o":"/sms/sendernames","q":{},"r":{},"s":[{"lit":"sms"},{"lit":"sendernames"}],"t":{"req":"`reqdata`","res":"`body.collection`"},"index$":0}],"key$":"list"},"load":{"input":"data","name":"load","points":[{"a":true,"co":{"id":"GET /sms/sendernames/{sender}","source":"openapi3","version":2},"g":{"params":[{"a":true,"k":"param","n":"id","or":"sender","r":true,"t":"`$STRING`","index$":0}]},"k":"http","m":"GET","o":"/sms/sendernames/{sender}","q":{"exist":["id"]},"r":{"param":{"sender":"id"}},"s":[{"lit":"sms"},{"lit":"sendernames"},{"var":"id"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":0}],"key$":"load"}},"relations":{"ancestors":[]},"key$":"sendername","name__orig":"sendername","Name":"Sendername","name_":"sendername","name-":"sendername","NAME":"SENDERNAME","index$":17}, {"active":true,"entity":"sendername","key$":"BasicSendernameFlow","kind":"basic","name":"BasicSendernameFlow","param":{},"step":[{"a":true,"d":{},"i":{"ref":"sendername_ref01"},"m":{},"o":"create","s":[],"v":[],"index$":0},{"a":true,"d":{},"i":{},"m":{},"o":"list","s":[],"v":[{"apply":"ItemExists","def":{"ref":"sendername_ref01"}}],"index$":1},{"a":true,"d":{},"i":{"ref":"sendername_ref01","srcdatavar":"sendername_ref01_data","suffix":"_dt0"},"m":{"id":"sendername01"},"o":"load","s":[],"v":[{"apply":"TextFieldMark","def":{"mark":"Mark01-sendername_ref01"}}],"index$":2}]}, 'Sendername', {"POST /sms/sendernames":{"protocol":"http","requestBody":{"required":true,"content":{"application/x-www-form-urlencoded":{"schema":{"type":"object","properties":{"sender":{"type":"string","pattern":"^[0-9]{8,16}|[\\w.\\-&@ %!+]{0,11}$","description":"Sendername","x-ref":"#/components/schemas/Sender"}},"required":["sender"],"x-ref":"#/components/schemas/CreateSendername"}}}},"parameters":[]},"GET /sms/sendernames":{"protocol":"http","parameters":[]},"GET /sms/sendernames/{sender}":{"protocol":"http","parameters":[{"name":"sender","in":"path","schema":{"type":"string","pattern":"^[0-9]{8,16}|[\\w.\\-&@ %!+]{0,11}$","description":"Sendername","x-ref":"#/components/schemas/Sender"},"required":true,"x-ref":"#/components/parameters/Sender","index$":0}]}})
    }
    const client = setup.client
    const struct = setup.struct

    const isempty = struct.isempty
    const select = struct.select


    // CREATE
    const sendername_ref01_ent = client.Sendername()
    let sendername_ref01_data = setup.data.new.sendername['sendername_ref01']

    sendername_ref01_data = (await sendername_ref01_ent.create(sendername_ref01_data)).data()
    assert(null != sendername_ref01_data.id)


    // LIST
    const sendername_ref01_match: any = {}

    const sendername_ref01_list = (await sendername_ref01_ent.list(sendername_ref01_match)).map((e: any) => e.data())

    assert(!isempty(select(sendername_ref01_list, { id: sendername_ref01_data.id })))


    // LOAD
    const sendername_ref01_match_dt0: any = {}
    sendername_ref01_match_dt0.id = sendername_ref01_data.id
    const sendername_ref01_data_dt0 = (await sendername_ref01_ent.load(sendername_ref01_match_dt0)).data()
    assert(sendername_ref01_data_dt0.id === sendername_ref01_data.id)


  })
})



function basicSetup(extra?: any) {
  // TODO: fix test def options
  const options: any = {} // null

  // TODO: needs test utility to resolve path
  const entityDataFile =
    Path.resolve(__dirname, 
      '../../../../.sdk/test/entity/sendername/SendernameTestData.json')

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
    ['sendername01','sendername02','sendername03'],
    {
      '`$PACK`': ['', {
        '`$KEY`': '`$COPY`',
        '`$VAL`': ['`$FORMAT`', 'upper', '`$COPY`']
      }]
    })

  const env = envOverride({
    'SMSAPI_TEST_SENDERNAME_ENTID': idmap,
    'SMSAPI_TEST_LIVE': 'FALSE',
    'SMSAPI_TEST_EXPLAIN': 'FALSE',
    'SMSAPI_APIKEY': '',
  })

  idmap = env['SMSAPI_TEST_SENDERNAME_ENTID']

  const live = 'TRUE' === env.SMSAPI_TEST_LIVE

  const transport = createLiveTransport()
  if (live) {
    const rawIds = process.env['SMSAPI_TEST_SENDERNAME_ENTID']
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
  
