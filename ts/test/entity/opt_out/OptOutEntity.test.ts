

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


describe('OptOutEntity', async () => {

  // Per-test live pacing. Delay is read from sdk-test-control.json's
  // `test.live.delayMs`; only sleeps when SMSAPI_TEST_LIVE=TRUE.
  afterEach(liveDelay('SMSAPI_TEST_LIVE'))

  test('instance', async () => {
    const testsdk = SmsapiSDK.test()
    const ent = testsdk.OptOut()
    assert(null != ent)
  })


  test('basic', async (t) => {

    const live = 'TRUE' === process.env.SMSAPI_TEST_LIVE
    for (const op of ['list']) {
      if (!live && maybeSkipControl(t, 'entityOp', 'opt_out.' + op, live)) return
    }

    
    const setup = basicSetup()
    if (setup.live) {
      return runLiveEntity(setup, {"active":true,"alias":{"field":{}},"fields":{"date":{"a":true,"fo":"date-time","h":"Date","n":"date","r":false,"t":"`$STRING`","key$":"date","index$":0},"id":{"a":true,"h":"Id","n":"id","r":false,"t":"`$STRING`","key$":"id","index$":1},"links":{"a":true,"h":"Links","n":"links","r":false,"t":"`$ARRAY`","key$":"links","index$":2},"phoneNumber":{"a":true,"h":"Phone Number","n":"phoneNumber","r":false,"t":"`$INTEGER`","key$":"phoneNumber","index$":3}},"id":{"field":"id","name":"id"},"name":"opt_out","op":{"list":{"input":"data","name":"list","points":[{"a":true,"co":{"id":"GET /opt_outs","source":"openapi3","version":2},"g":{"header":[{"a":true,"ex":"application/json","k":"header","n":"accept","or":"Accept","r":false,"t":"`$STRING`","index$":0},{"a":true,"ex":false,"k":"header","n":"x_async","or":"x-async","r":false,"t":"`$BOOLEAN`","index$":1}],"query":[{"a":true,"ex":5,"k":"query","n":"limit","or":"limit","r":false,"t":"`$INTEGER`","index$":0},{"a":true,"ex":0,"k":"query","n":"offset","or":"offset","r":false,"t":"`$INTEGER`","index$":1},{"a":true,"k":"query","n":"phone_number","or":"phone_number","r":false,"t":"`$STRING`","index$":2}]},"k":"http","m":"GET","o":"/opt_outs","q":{"exist":["accept","limit","offset","phone_number","x_async"]},"r":{},"s":[{"lit":"opt_outs"}],"t":{"req":"`reqdata`","res":"`body.collection`"},"index$":0}],"key$":"list"},"remove":{"input":"data","name":"remove","points":[{"a":true,"co":{"id":"DELETE /opt_outs/{optOutId}","source":"openapi3","version":2},"g":{"params":[{"a":true,"k":"param","n":"id","or":"optOutId","r":true,"t":"`$STRING`","index$":0}]},"k":"http","m":"DELETE","o":"/opt_outs/{optOutId}","q":{"exist":["id"]},"r":{"param":{"optOutId":"id"}},"s":[{"lit":"opt_outs"},{"var":"id"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":0}],"key$":"remove"}},"relations":{"ancestors":[]},"key$":"opt_out","name__orig":"opt_out","Name":"OptOut","name_":"opt_out","name-":"opt-out","NAME":"OPT_OUT","index$":11}, {"active":true,"entity":"opt_out","key$":"BasicOptOutFlow","kind":"basic","name":"BasicOptOutFlow","param":{},"step":[{"a":true,"d":{},"i":{},"m":{},"o":"list","s":[],"v":[{"apply":"ItemExists","def":{"ref":"opt_out_ref01"}}],"index$":0}]}, 'OptOut', {"GET /opt_outs":{"protocol":"http","parameters":[{"name":"phone_number","in":"query","schema":{"type":"string"},"required":false,"description":"phone number","x-ref":"#/components/parameters/queryPhoneNumber","index$":0},{"name":"offset","in":"query","required":false,"schema":{"type":"integer","default":0},"x-ref":"#/components/parameters/offset","index$":1},{"name":"limit","in":"query","required":false,"schema":{"type":"integer","default":5},"x-ref":"#/components/parameters/limit","index$":2},{"name":"x-async","description":"To generate CSV in background add also Content-Type: text/csv","schema":{"type":"boolean","default":false},"in":"header","required":false,"x-ref":"#/components/parameters/Async-Csv","index$":3},{"name":"Accept","in":"header","required":false,"schema":{"type":"string","enum":["application/json","text/csv"],"default":"application/json"},"x-ref":"#/components/parameters/Accept-Header-Csv","index$":4}]},"DELETE /opt_outs/{optOutId}":{"protocol":"http","parameters":[{"name":"optOutId","in":"path","schema":{"type":"string"},"required":true,"description":"Opt-Out id","x-ref":"#/components/parameters/optOutId","index$":0}]}})
    }
    const client = setup.client
    const struct = setup.struct

    const isempty = struct.isempty
    const select = struct.select

    let opt_out_ref01_data = Object.values(setup.data.existing.opt_out)[0] as any

    // LIST
    const opt_out_ref01_ent = client.OptOut()
    const opt_out_ref01_match: any = {}

    const opt_out_ref01_list = (await opt_out_ref01_ent.list(opt_out_ref01_match)).map((e: any) => e.data())


  })
})



function basicSetup(extra?: any) {
  // TODO: fix test def options
  const options: any = {} // null

  // TODO: needs test utility to resolve path
  const entityDataFile =
    Path.resolve(__dirname, 
      '../../../../.sdk/test/entity/opt_out/OptOutTestData.json')

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
    ['opt_out01','opt_out02','opt_out03'],
    {
      '`$PACK`': ['', {
        '`$KEY`': '`$COPY`',
        '`$VAL`': ['`$FORMAT`', 'upper', '`$COPY`']
      }]
    })

  const env = envOverride({
    'SMSAPI_TEST_OPT_OUT_ENTID': idmap,
    'SMSAPI_TEST_LIVE': 'FALSE',
    'SMSAPI_TEST_EXPLAIN': 'FALSE',
    'SMSAPI_APIKEY': '',
  })

  idmap = env['SMSAPI_TEST_OPT_OUT_ENTID']

  const live = 'TRUE' === env.SMSAPI_TEST_LIVE

  const transport = createLiveTransport()
  if (live) {
    const rawIds = process.env['SMSAPI_TEST_OPT_OUT_ENTID']
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
  
