

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


describe('SendernameStatementEntity', async () => {

  // Per-test live pacing. Delay is read from sdk-test-control.json's
  // `test.live.delayMs`; only sleeps when SMSAPI_TEST_LIVE=TRUE.
  afterEach(liveDelay('SMSAPI_TEST_LIVE'))

  test('instance', async () => {
    const testsdk = SmsapiSDK.test()
    const ent = testsdk.SendernameStatement()
    assert(null != ent)
  })


  test('basic', async (t) => {

    const live = 'TRUE' === process.env.SMSAPI_TEST_LIVE
    for (const op of ['list']) {
      if (!live && maybeSkipControl(t, 'entityOp', 'sendername_statement.' + op, live)) return
    }

    
    const setup = basicSetup()
    if (setup.live) {
      return runLiveEntity(setup, {"active":true,"alias":{"field":{}},"fields":{"content":{"a":true,"h":"Content","n":"content","r":false,"t":"`$STRING`","key$":"content","index$":0},"statements":{"a":true,"h":"Statements","n":"statements","r":false,"t":"`$ARRAY`","key$":"statements","index$":1},"title":{"a":true,"h":"Title","n":"title","r":false,"t":"`$STRING`","key$":"title","index$":2}},"name":"sendername_statement","op":{"list":{"input":"data","name":"list","points":[{"a":true,"co":{"id":"GET /sms/sendernames/statement","source":"openapi3","version":2},"g":{},"k":"http","m":"GET","o":"/sms/sendernames/statement","q":{},"r":{},"s":[{"lit":"sms"},{"lit":"sendernames"},{"lit":"statement"}],"t":{"req":"`reqdata`","res":"`body.sections`"},"index$":0}],"key$":"list"}},"relations":{"ancestors":[]},"key$":"sendername_statement","name__orig":"sendername_statement","Name":"SendernameStatement","name_":"sendername_statement","name-":"sendername-statement","NAME":"SENDERNAME_STATEMENT","index$":18}, {"active":true,"entity":"sendername_statement","key$":"BasicSendernameStatementFlow","kind":"basic","name":"BasicSendernameStatementFlow","param":{},"step":[{"a":true,"d":{},"i":{},"m":{},"o":"list","s":[],"v":[{"apply":"ItemExists","def":{"ref":"sendername_statement_ref01"}}],"index$":0}]}, 'SendernameStatement', {"GET /sms/sendernames/statement":{"protocol":"http","parameters":[]}})
    }
    const client = setup.client
    const struct = setup.struct

    const isempty = struct.isempty
    const select = struct.select

    let sendername_statement_ref01_data = Object.values(setup.data.existing.sendername_statement)[0] as any

    // LIST
    const sendername_statement_ref01_ent = client.SendernameStatement()
    const sendername_statement_ref01_match: any = {}

    const sendername_statement_ref01_list = (await sendername_statement_ref01_ent.list(sendername_statement_ref01_match)).map((e: any) => e.data())


  })
})



function basicSetup(extra?: any) {
  // TODO: fix test def options
  const options: any = {} // null

  // TODO: needs test utility to resolve path
  const entityDataFile =
    Path.resolve(__dirname, 
      '../../../../.sdk/test/entity/sendername_statement/SendernameStatementTestData.json')

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
    ['sendername_statement01','sendername_statement02','sendername_statement03'],
    {
      '`$PACK`': ['', {
        '`$KEY`': '`$COPY`',
        '`$VAL`': ['`$FORMAT`', 'upper', '`$COPY`']
      }]
    })

  const env = envOverride({
    'SMSAPI_TEST_SENDERNAME_STATEMENT_ENTID': idmap,
    'SMSAPI_TEST_LIVE': 'FALSE',
    'SMSAPI_TEST_EXPLAIN': 'FALSE',
    'SMSAPI_APIKEY': '',
  })

  idmap = env['SMSAPI_TEST_SENDERNAME_STATEMENT_ENTID']

  const live = 'TRUE' === env.SMSAPI_TEST_LIVE

  const transport = createLiveTransport()
  if (live) {
    const rawIds = process.env['SMSAPI_TEST_SENDERNAME_STATEMENT_ENTID']
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
  
