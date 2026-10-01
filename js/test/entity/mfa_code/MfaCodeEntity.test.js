
const envlocal = __dirname + '/../../../.env.local'
require('../../utility').loadEnvLocal(envlocal)

const Path = require('node:path')
const Fs = require('node:fs')

const { test, describe, afterEach } = require('node:test')
const assert = require('node:assert')
const { createLiveTransport } = require('../../live-runner')
const { runLiveEntity } = require('../../live-entity')


const { SmsapiSDK, BaseFeature, stdutil, config } = require('../../..')

const {
  envOverride,
  liveClientOptions,
  liveDelay,
  makeCtrl,
  makeMatch,
  makeReqdata,
  makeStepData,
  makeValid,
} = require('../../utility')


describe('MfaCodeEntity', async () => {

  // Per-test live pacing. Delay is read from sdk-test-control.json's
  // `test.live.delayMs`; only sleeps when SMSAPI_TEST_LIVE=TRUE.
  afterEach(liveDelay('SMSAPI_TEST_LIVE'))

  test('instance', async () => {
    const testsdk = SmsapiSDK.test()
    const ent = testsdk.MfaCode()
    assert(null != ent)
  })


  test('basic', async (t) => {

    
    const setup = basicSetup()
    if (setup.live) {
      return runLiveEntity(setup, {"active":true,"alias":{"field":{}},"fields":{"content":{"a":true,"h":"Content","n":"content","r":false,"sh":"Custom content that must contain placeholder [%code%]","t":"`$STRING`","key$":"content","index$":0},"fast":{"a":true,"h":"Fast","n":"fast","r":false,"t":"`$ANY`","union":{"branches":2,"count":1,"depth":0},"key$":"fast","index$":1},"from":{"a":true,"h":"From","n":"from","r":false,"sh":"Sendername","t":"`$STRING`","key$":"from","index$":2},"phone_number":{"a":true,"h":"Phone Number","n":"phone_number","r":true,"t":"`$STRING`","key$":"phone_number","index$":3}},"name":"mfa_code","op":{"create":{"input":"data","name":"create","points":[{"a":true,"co":{"id":"POST /mfa/codes","source":"openapi3","version":2},"g":{},"k":"http","m":"POST","o":"/mfa/codes","q":{},"r":{},"s":[{"lit":"mfa"},{"lit":"codes"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":0},{"a":true,"co":{"id":"POST /mfa/codes/verifications","source":"openapi3","version":2},"g":{},"k":"http","m":"POST","o":"/mfa/codes/verifications","q":{"$action":"verification"},"r":{},"s":[{"lit":"mfa"},{"lit":"codes"},{"lit":"verifications"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":1}],"key$":"create"}},"relations":{"ancestors":[]},"key$":"mfa_code","name__orig":"mfa_code","Name":"MfaCode","name_":"mfa_code","name-":"mfa-code","NAME":"MFA_CODE","index$":10}, {"active":true,"entity":"mfa_code","key$":"BasicMfaCodeFlow","kind":"basic","name":"BasicMfaCodeFlow","param":{},"step":[{"a":true,"d":{},"i":{"ref":"mfa_code_ref01"},"m":{},"o":"create","s":[],"v":[],"index$":0}]}, 'MfaCode', {"POST /mfa/codes":{"protocol":"http","requestBody":{"required":true,"content":{"application/json":{"schema":{"type":"object","required":["phone_number"],"properties":{"phone_number":{"type":"string","pattern":"[0-9]{8,16}","example":"48327201200","x-ref":"#/components/schemas/PhoneNumber","key$":"phone_number"},"from":{"type":"string","pattern":"^[0-9]{8,16}|[\\w.\\-&@ %!+]{0,11}$","description":"Sendername","x-ref":"#/components/schemas/Sender","key$":"from"},"content":{"type":"string","pattern":"^.*\\[\\%code\\%\\].*$","description":"Custom content that must contain placeholder [%code%]","x-ref":"#/components/schemas/CustomMessageContent","key$":"content"},"fast":{"anyOf":[{"type":"boolean"},{"type":"integer","enum":[0,1]}],"default":true,"key$":"fast"}},"x-ref":"#/components/schemas/CreateMFACode","index$":1}}}},"parameters":[]},"POST /mfa/codes/verifications":{"protocol":"http","requestBody":{"required":true,"content":{"application/x-www-form-urlencoded":{"schema":{"type":"object","required":["code","phone_number"],"properties":{"code":{"type":"string"},"phone_number":{"type":"string","pattern":"[0-9]{8,16}","example":"48327201200","x-ref":"#/components/schemas/PhoneNumber"}},"x-ref":"#/components/schemas/VerifyMFACode"}}}},"parameters":[]}})
    }
    const client = setup.client
    const struct = setup.struct

    const isempty = struct.isempty
    const select = struct.select


    // CREATE
    const mfa_code_ref01_ent = client.MfaCode()
    let mfa_code_ref01_data = setup.data.new.mfa_code['mfa_code_ref01']

    mfa_code_ref01_data = (await mfa_code_ref01_ent.create(mfa_code_ref01_data)).data()
    assert(null != mfa_code_ref01_data)


  })
})



function basicSetup(extra) {
  // TODO: fix test def options
  const options = {} // null

  // TODO: needs test utility to resolve path
  const entityDataFile =
    Path.resolve(__dirname,
      '../../../../.sdk/test/entity/mfa_code/MfaCodeTestData.json')

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
    ['mfa_code01','mfa_code02','mfa_code03'],
    {
      '`$PACK`': ['', {
        '`$KEY`': '`$COPY`',
        '`$VAL`': ['`$FORMAT`', 'upper', '`$COPY`']
      }]
    })

  const env = envOverride({
    'SMSAPI_TEST_MFA_CODE_ENTID': idmap,
    'SMSAPI_TEST_LIVE': 'FALSE',
    'SMSAPI_TEST_EXPLAIN': 'FALSE',
    'SMSAPI_APIKEY': '',
  })

  idmap = env['SMSAPI_TEST_MFA_CODE_ENTID']

  const live = 'TRUE' === env.SMSAPI_TEST_LIVE
  const transport = createLiveTransport()
  if (live) {
    const rawIds = process.env['SMSAPI_TEST_MFA_CODE_ENTID']
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
      // 'extra || {}', not a bare 'extra': struct.merge returns UNDEFINED when
      // the last entry is undefined, and basicSetup is normally called with no
      // argument at all - so a bare 'extra' silently discarded the apikey and
      // server values above and handed the SDK undefined.
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
  
