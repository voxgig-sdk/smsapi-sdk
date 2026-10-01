
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


describe('OptOutSettingEntity', async () => {

  // Per-test live pacing. Delay is read from sdk-test-control.json's
  // `test.live.delayMs`; only sleeps when SMSAPI_TEST_LIVE=TRUE.
  afterEach(liveDelay('SMSAPI_TEST_LIVE'))

  test('instance', async () => {
    const testsdk = SmsapiSDK.test()
    const ent = testsdk.OptOutSetting()
    assert(null != ent)
  })


  test('basic', async (t) => {

    
    const setup = basicSetup()
    if (setup.live) {
      return runLiveEntity(setup, {"active":true,"alias":{"field":{}},"fields":{"brand":{"a":true,"h":"Brand","n":"brand","r":false,"t":"`$STRING`","key$":"brand","index$":0}},"name":"opt_out_setting","op":{"load":{"input":"data","name":"load","points":[{"a":true,"co":{"id":"GET /opt_outs/settings","source":"openapi3","version":2},"g":{},"k":"http","m":"GET","o":"/opt_outs/settings","q":{},"r":{},"s":[{"lit":"opt_outs"},{"lit":"settings"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":0}],"key$":"load"},"update":{"input":"data","name":"update","points":[{"a":true,"co":{"id":"PUT /opt_outs/settings","source":"openapi3","version":2},"g":{},"k":"http","m":"PUT","o":"/opt_outs/settings","q":{},"r":{},"s":[{"lit":"opt_outs"},{"lit":"settings"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":0}],"key$":"update"}},"relations":{"ancestors":[]},"key$":"opt_out_setting","name__orig":"opt_out_setting","Name":"OptOutSetting","name_":"opt_out_setting","name-":"opt-out-setting","NAME":"OPT_OUT_SETTING","index$":12}, {"active":true,"entity":"opt_out_setting","key$":"BasicOptOutSettingFlow","kind":"basic","name":"BasicOptOutSettingFlow","param":{},"step":[{"a":true,"d":{},"i":{"ref":"opt_out_setting_ref01","srcdatavar":"opt_out_setting_ref01_data","suffix":"_up0","textfield":"brand"},"m":{},"o":"update","s":[{"apply":"TextFieldMark","def":{"mark":"Mark01-opt_out_setting_ref01"}}],"v":[],"index$":0},{"a":true,"d":{},"i":{"ref":"opt_out_setting_ref01","srcdatavar":"opt_out_setting_ref01_data","suffix":"_dt0"},"m":{},"o":"load","s":[],"v":[{"apply":"TextFieldMark","def":{"mark":"Mark01-opt_out_setting_ref01"}}],"index$":1}]}, 'OptOutSetting', {"GET /opt_outs/settings":{"protocol":"http","parameters":[]},"PUT /opt_outs/settings":{"protocol":"http","requestBody":{"content":{"application/json":{"schema":{"type":"object","properties":{"brand":{"key$":"brand","maxLength":255,"minLength":0,"type":"string"}},"x-ref":"#/components/schemas/OptOutSettings","index$":1}}},"x-ref":"#/components/requestBodies/UpdateOptOutSettings"},"parameters":[]}})
    }
    const client = setup.client
    const struct = setup.struct

    const isempty = struct.isempty
    const select = struct.select

    let opt_out_setting_ref01_data = Object.values(setup.data.existing.opt_out_setting)[0]

    // UPDATE
    const opt_out_setting_ref01_ent = client.OptOutSetting()
    const opt_out_setting_ref01_data_up0 = {}

    const opt_out_setting_ref01_markdef_up0 = { name: 'brand', value: 'Mark01-opt_out_setting_ref01_' + setup.now }
    opt_out_setting_ref01_data_up0 [opt_out_setting_ref01_markdef_up0.name] = opt_out_setting_ref01_markdef_up0.value

    const opt_out_setting_ref01_resdata_up0 = (await opt_out_setting_ref01_ent.update(opt_out_setting_ref01_data_up0)).data()
    assert(null != opt_out_setting_ref01_resdata_up0)

    assert(opt_out_setting_ref01_resdata_up0[opt_out_setting_ref01_markdef_up0.name] === opt_out_setting_ref01_markdef_up0.value)


    // LOAD
    const opt_out_setting_ref01_match_dt0 = {}
    const opt_out_setting_ref01_data_dt0 = (await opt_out_setting_ref01_ent.load(opt_out_setting_ref01_match_dt0)).data()
    assert(null != opt_out_setting_ref01_data_dt0)


  })
})



function basicSetup(extra) {
  // TODO: fix test def options
  const options = {} // null

  // TODO: needs test utility to resolve path
  const entityDataFile =
    Path.resolve(__dirname,
      '../../../../.sdk/test/entity/opt_out_setting/OptOutSettingTestData.json')

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
    ['opt_out_setting01','opt_out_setting02','opt_out_setting03'],
    {
      '`$PACK`': ['', {
        '`$KEY`': '`$COPY`',
        '`$VAL`': ['`$FORMAT`', 'upper', '`$COPY`']
      }]
    })

  const env = envOverride({
    'SMSAPI_TEST_OPT_OUT_SETTING_ENTID': idmap,
    'SMSAPI_TEST_LIVE': 'FALSE',
    'SMSAPI_TEST_EXPLAIN': 'FALSE',
    'SMSAPI_APIKEY': '',
  })

  idmap = env['SMSAPI_TEST_OPT_OUT_SETTING_ENTID']

  const live = 'TRUE' === env.SMSAPI_TEST_LIVE
  const transport = createLiveTransport()
  if (live) {
    const rawIds = process.env['SMSAPI_TEST_OPT_OUT_SETTING_ENTID']
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
  
