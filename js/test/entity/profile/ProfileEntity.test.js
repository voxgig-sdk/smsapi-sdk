
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


describe('ProfileEntity', async () => {

  // Per-test live pacing. Delay is read from sdk-test-control.json's
  // `test.live.delayMs`; only sleeps when SMSAPI_TEST_LIVE=TRUE.
  afterEach(liveDelay('SMSAPI_TEST_LIVE'))

  test('instance', async () => {
    const testsdk = SmsapiSDK.test()
    const ent = testsdk.Profile()
    assert(null != ent)
  })


  test('basic', async (t) => {

    
    const setup = basicSetup()
    if (setup.live) {
      return runLiveEntity(setup, {"active":true,"alias":{"field":{}},"fields":{"email":{"a":true,"h":"Email","n":"email","r":true,"t":"`$STRING`","key$":"email","index$":0},"name":{"a":true,"h":"Name","n":"name","r":true,"t":"`$STRING`","key$":"name","index$":1},"payment_type":{"a":true,"h":"Payment Type","n":"payment_type","r":true,"t":"`$STRING`","key$":"payment_type","index$":2},"phone_number":{"a":true,"h":"Phone Number","n":"phone_number","r":true,"t":"`$INTEGER`","union":{"branches":2,"count":1,"depth":0},"key$":"phone_number","index$":3},"points":{"a":true,"fo":"float","h":"Points","n":"points","r":false,"t":"`$NUMBER`","key$":"points","index$":4},"user_type":{"a":true,"h":"User Type","n":"user_type","r":true,"t":"`$STRING`","key$":"user_type","index$":5},"username":{"a":true,"h":"Username","n":"username","r":true,"t":"`$STRING`","key$":"username","index$":6}},"name":"profile","op":{"list":{"input":"data","name":"list","points":[{"a":true,"co":{"id":"GET /profile/prices","source":"openapi3","version":2},"g":{"query":[{"a":true,"ex":"eco","k":"query","n":"type","or":"type","r":false,"t":"`$STRING`","index$":0}]},"k":"http","m":"GET","o":"/profile/prices","q":{"$action":"price","exist":["type"]},"r":{},"s":[{"lit":"profile"},{"lit":"prices"}],"t":{"req":"`reqdata`","res":"`body.collection`"},"index$":0}],"key$":"list"},"load":{"input":"data","name":"load","points":[{"a":true,"co":{"id":"GET /profile","source":"openapi3","version":2},"g":{},"k":"http","m":"GET","o":"/profile","q":{},"r":{},"s":[{"lit":"profile"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":0}],"key$":"load"}},"relations":{"ancestors":[]},"key$":"profile","name__orig":"profile","Name":"Profile","name_":"profile","name-":"profile","NAME":"PROFILE","index$":15}, {"active":true,"entity":"profile","key$":"BasicProfileFlow","kind":"basic","name":"BasicProfileFlow","param":{},"step":[{"a":true,"d":{},"i":{},"m":{},"o":"list","s":[],"v":[{"apply":"ItemExists","def":{"ref":"profile_ref01"}}],"index$":0},{"a":true,"d":{},"i":{"ref":"profile_ref01","srcdatavar":"profile_ref01_data","suffix":"_dt0"},"m":{},"o":"load","s":[],"v":[{"apply":"TextFieldMark","def":{"mark":"Mark01-profile_ref01"}}],"index$":1}]}, 'Profile', {"GET /profile/prices":{"protocol":"http","parameters":[{"name":"type","in":"query","required":false,"schema":{"type":"string","enum":["pro","eco","sms","2way","vms","hlr","mms"],"example":"eco","x-ref":"#/components/schemas/ProfilePricingType"},"x-ref":"#/components/parameters/ProfilePricingType","index$":0}]},"GET /profile":{"protocol":"http","parameters":[]}})
    }
    const client = setup.client
    const struct = setup.struct

    const isempty = struct.isempty
    const select = struct.select

    let profile_ref01_data = Object.values(setup.data.existing.profile)[0]

    // LIST
    const profile_ref01_ent = client.Profile()
    const profile_ref01_match = {}

    const profile_ref01_list = (await profile_ref01_ent.list(profile_ref01_match)).map((e) => e.data())


    // LOAD
    const profile_ref01_match_dt0 = {}
    const profile_ref01_data_dt0 = (await profile_ref01_ent.load(profile_ref01_match_dt0)).data()
    assert(null != profile_ref01_data_dt0)


  })
})



function basicSetup(extra) {
  // TODO: fix test def options
  const options = {} // null

  // TODO: needs test utility to resolve path
  const entityDataFile =
    Path.resolve(__dirname,
      '../../../../.sdk/test/entity/profile/ProfileTestData.json')

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
    ['profile01','profile02','profile03'],
    {
      '`$PACK`': ['', {
        '`$KEY`': '`$COPY`',
        '`$VAL`': ['`$FORMAT`', 'upper', '`$COPY`']
      }]
    })

  const env = envOverride({
    'SMSAPI_TEST_PROFILE_ENTID': idmap,
    'SMSAPI_TEST_LIVE': 'FALSE',
    'SMSAPI_TEST_EXPLAIN': 'FALSE',
    'SMSAPI_APIKEY': '',
  })

  idmap = env['SMSAPI_TEST_PROFILE_ENTID']

  const live = 'TRUE' === env.SMSAPI_TEST_LIVE
  const transport = createLiveTransport()
  if (live) {
    const rawIds = process.env['SMSAPI_TEST_PROFILE_ENTID']
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
  
