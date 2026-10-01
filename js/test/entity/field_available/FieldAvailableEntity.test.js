
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


describe('FieldAvailableEntity', async () => {

  // Per-test live pacing. Delay is read from sdk-test-control.json's
  // `test.live.delayMs`; only sleeps when SMSAPI_TEST_LIVE=TRUE.
  afterEach(liveDelay('SMSAPI_TEST_LIVE'))

  test('instance', async () => {
    const testsdk = SmsapiSDK.test()
    const ent = testsdk.FieldAvailable()
    assert(null != ent)
  })


  test('basic', async (t) => {

    
    const setup = basicSetup()
    if (setup.live) {
      return runLiveEntity(setup, {"active":true,"alias":{"field":{}},"fields":{"built_in":{"a":true,"h":"Built In","n":"built_in","r":false,"t":"`$BOOLEAN`","key$":"built_in","index$":0},"id":{"a":true,"fo":"oid","h":"Id","n":"id","r":false,"sh":"Object ID","t":"`$STRING`","key$":"id","index$":1},"name":{"a":true,"h":"Name","n":"name","r":false,"t":"`$STRING`","key$":"name","index$":2},"options":{"a":true,"h":"Options","n":"options","r":false,"t":"`$ARRAY`","key$":"options","index$":3},"type":{"a":true,"h":"Type","n":"type","r":false,"t":"`$STRING`","key$":"type","index$":4}},"id":{"field":"id","name":"id"},"name":"field_available","op":{"list":{"input":"data","name":"list","points":[{"a":true,"co":{"id":"GET /contacts/fields/available","source":"openapi3","version":2},"g":{},"k":"http","m":"GET","o":"/contacts/fields/available","q":{},"r":{},"s":[{"lit":"contacts"},{"lit":"fields"},{"lit":"available"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":0}],"key$":"list"}},"relations":{"ancestors":[]},"key$":"field_available","name__orig":"field_available","Name":"FieldAvailable","name_":"field_available","name-":"field-available","NAME":"FIELD_AVAILABLE","index$":8}, {"active":true,"entity":"field_available","key$":"BasicFieldAvailableFlow","kind":"basic","name":"BasicFieldAvailableFlow","param":{},"step":[{"a":true,"d":{},"i":{},"m":{},"o":"list","s":[],"v":[{"apply":"ItemExists","def":{"ref":"field_available_ref01"}}],"index$":0}]}, 'FieldAvailable', {"GET /contacts/fields/available":{"protocol":"http","parameters":[]}})
    }
    const client = setup.client
    const struct = setup.struct

    const isempty = struct.isempty
    const select = struct.select

    let field_available_ref01_data = Object.values(setup.data.existing.field_available)[0]

    // LIST
    const field_available_ref01_ent = client.FieldAvailable()
    const field_available_ref01_match = {}

    const field_available_ref01_list = (await field_available_ref01_ent.list(field_available_ref01_match)).map((e) => e.data())


  })
})



function basicSetup(extra) {
  // TODO: fix test def options
  const options = {} // null

  // TODO: needs test utility to resolve path
  const entityDataFile =
    Path.resolve(__dirname,
      '../../../../.sdk/test/entity/field_available/FieldAvailableTestData.json')

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
    ['field_available01','field_available02','field_available03'],
    {
      '`$PACK`': ['', {
        '`$KEY`': '`$COPY`',
        '`$VAL`': ['`$FORMAT`', 'upper', '`$COPY`']
      }]
    })

  const env = envOverride({
    'SMSAPI_TEST_FIELD_AVAILABLE_ENTID': idmap,
    'SMSAPI_TEST_LIVE': 'FALSE',
    'SMSAPI_TEST_EXPLAIN': 'FALSE',
    'SMSAPI_APIKEY': '',
  })

  idmap = env['SMSAPI_TEST_FIELD_AVAILABLE_ENTID']

  const live = 'TRUE' === env.SMSAPI_TEST_LIVE
  const transport = createLiveTransport()
  if (live) {
    const rawIds = process.env['SMSAPI_TEST_FIELD_AVAILABLE_ENTID']
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
  
