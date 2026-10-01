

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


describe('SmssendernameEntity', async () => {

  // Per-test live pacing. Delay is read from sdk-test-control.json's
  // `test.live.delayMs`; only sleeps when SMSAPI_TEST_LIVE=TRUE.
  afterEach(liveDelay('SMSAPI_TEST_LIVE'))

  test('instance', async () => {
    const testsdk = SmsapiSDK.test()
    const ent = testsdk.Smssendername()
    assert(null != ent)
  })


  test('basic', async (t) => {

    const live = 'TRUE' === process.env.SMSAPI_TEST_LIVE
    for (const op of ['create', 'remove']) {
      if (!live && maybeSkipControl(t, 'entityOp', 'smssendername.' + op, live)) return
    }

    
    const setup = basicSetup()
    if (setup.live) {
      return runLiveEntity(setup, {"active":true,"alias":{"field":{}},"fields":{},"name":"smssendername","op":{"create":{"input":"data","name":"create","points":[{"a":true,"co":{"id":"POST /sms/sendernames/{sender}/commands/make_default","source":"openapi3","version":2},"g":{"params":[{"a":true,"k":"param","n":"sendername_id","or":"sender","r":true,"t":"`$STRING`","index$":0}]},"k":"http","m":"POST","o":"/sms/sendernames/{sender}/commands/make_default","q":{"exist":["sendername_id"]},"r":{"param":{"sender":"sendername_id"}},"s":[{"lit":"sms"},{"lit":"sendernames"},{"var":"sendername_id"},{"lit":"commands"},{"lit":"make_default"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":0}],"key$":"create"},"remove":{"input":"data","name":"remove","points":[{"a":true,"co":{"id":"DELETE /sms/sendernames/{sender}","source":"openapi3","version":2},"g":{"params":[{"a":true,"k":"param","n":"sender","or":"sender","r":true,"t":"`$STRING`","index$":0}]},"k":"http","m":"DELETE","o":"/sms/sendernames/{sender}","q":{"exist":["sender"]},"r":{},"s":[{"lit":"sms"},{"lit":"sendernames"},{"var":"sender"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":0}],"key$":"remove"}},"relations":{"ancestors":[["$.main.kit.entity.sendername"]]},"key$":"smssendername","name__orig":"smssendername","Name":"Smssendername","name_":"smssendername","name-":"smssendername","NAME":"SMSSENDERNAME","index$":23}, {"active":true,"entity":"smssendername","key$":"BasicSmssendernameFlow","kind":"basic","name":"BasicSmssendernameFlow","param":{},"step":[{"a":true,"d":{},"i":{"ref":"smssendername_ref01"},"m":{"sendername_id":"sendername01"},"o":"create","s":[],"v":[],"index$":0},{"a":true,"d":{},"i":{"ref":"smssendername_ref01","suffix":"_rm0"},"m":{"id":"smssendername01"},"o":"remove","s":[],"v":[],"index$":1}]}, 'Smssendername', {"POST /sms/sendernames/{sender}/commands/make_default":{"protocol":"http","parameters":[{"name":"sender","in":"path","schema":{"type":"string","pattern":"^[0-9]{8,16}|[\\w.\\-&@ %!+]{0,11}$","description":"Sendername","x-ref":"#/components/schemas/Sender"},"required":true,"x-ref":"#/components/parameters/Sender","index$":0}]},"DELETE /sms/sendernames/{sender}":{"protocol":"http","parameters":[{"name":"sender","in":"path","schema":{"type":"string","pattern":"^[0-9]{8,16}|[\\w.\\-&@ %!+]{0,11}$","description":"Sendername","x-ref":"#/components/schemas/Sender"},"required":true,"x-ref":"#/components/parameters/Sender","index$":0}]}})
    }
    const client = setup.client
    const struct = setup.struct

    const isempty = struct.isempty
    const select = struct.select


    // CREATE
    const smssendername_ref01_ent = client.Smssendername()
    let smssendername_ref01_data = setup.data.new.smssendername['smssendername_ref01']
    smssendername_ref01_data['sendername_id'] = setup.idmap['sendername01']

    smssendername_ref01_data = (await smssendername_ref01_ent.create(smssendername_ref01_data)).data()
    assert(null != smssendername_ref01_data)



  })
})



function basicSetup(extra?: any) {
  // TODO: fix test def options
  const options: any = {} // null

  // TODO: needs test utility to resolve path
  const entityDataFile =
    Path.resolve(__dirname, 
      '../../../../.sdk/test/entity/smssendername/SmssendernameTestData.json')

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
    ['smssendername01','smssendername02','smssendername03','sendername01','sendername02','sendername03'],
    {
      '`$PACK`': ['', {
        '`$KEY`': '`$COPY`',
        '`$VAL`': ['`$FORMAT`', 'upper', '`$COPY`']
      }]
    })

  const env = envOverride({
    'SMSAPI_TEST_SMSSENDERNAME_ENTID': idmap,
    'SMSAPI_TEST_LIVE': 'FALSE',
    'SMSAPI_TEST_EXPLAIN': 'FALSE',
    'SMSAPI_APIKEY': '',
  })

  idmap = env['SMSAPI_TEST_SMSSENDERNAME_ENTID']

  const live = 'TRUE' === env.SMSAPI_TEST_LIVE

  const transport = createLiveTransport()
  if (live) {
    const rawIds = process.env['SMSAPI_TEST_SMSSENDERNAME_ENTID']
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
  
