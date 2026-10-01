
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


describe('SentRcsMessageEntity', async () => {

  // Per-test live pacing. Delay is read from sdk-test-control.json's
  // `test.live.delayMs`; only sleeps when SMSAPI_TEST_LIVE=TRUE.
  afterEach(liveDelay('SMSAPI_TEST_LIVE'))

  test('instance', async () => {
    const testsdk = SmsapiSDK.test()
    const ent = testsdk.SentRcsMessage()
    assert(null != ent)
  })


  test('basic', async (t) => {

    
    const setup = basicSetup()
    if (setup.live) {
      return runLiveEntity(setup, {"active":true,"alias":{"field":{}},"fields":{"content":{"a":true,"h":"Content","n":"content","r":false,"sh":"RCS message content in RCS JSON format.","t":"`$OBJECT`","key$":"content","index$":0},"phone_number":{"a":true,"h":"Phone Number","n":"phone_number","r":true,"sh":"Recipient phone number (e.g.","t":"`$STRING`","key$":"phone_number","index$":1},"sender":{"a":true,"h":"Sender","n":"sender","r":true,"t":"`$ANY`","key$":"sender","index$":2},"text":{"a":true,"h":"Text","n":"text","r":false,"sh":"Plain text message content.","t":"`$STRING`","key$":"text","index$":3}},"name":"sent_rcs_message","op":{"create":{"input":"data","name":"create","points":[{"a":true,"co":{"id":"POST /rcs/messages","source":"openapi3","version":2},"g":{},"k":"http","m":"POST","o":"/rcs/messages","q":{},"r":{},"s":[{"lit":"rcs"},{"lit":"messages"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":0}],"key$":"create"}},"relations":{"ancestors":[]},"key$":"sent_rcs_message","name__orig":"sent_rcs_message","Name":"SentRcsMessage","name_":"sent_rcs_message","name-":"sent-rcs-message","NAME":"SENT_RCS_MESSAGE","index$":19}, {"active":true,"entity":"sent_rcs_message","key$":"BasicSentRcsMessageFlow","kind":"basic","name":"BasicSentRcsMessageFlow","param":{},"step":[{"a":true,"d":{},"i":{"ref":"sent_rcs_message_ref01"},"m":{},"o":"create","s":[],"v":[],"index$":0}]}, 'SentRcsMessage', {"POST /rcs/messages":{"protocol":"http","requestBody":{"required":true,"content":{"application/json":{"schema":{"type":"object","required":["phone_number","sender"],"properties":{"phone_number":{"type":"string","description":"Recipient phone number (e.g. 48123456789).","example":"48123456789","key$":"phone_number"},"sender":{"allOf":[{"type":"string","format":"oid","pattern":"[0-9a-fA-F]{24}","description":"Object ID","example":"0f0f0f0f0f0f0f0f0f0f0f0f","x-ref":"#/components/schemas/Id"},{"description":"RCS sender ID (object ID of the agent/sender the user has access to)."}],"key$":"sender"},"text":{"type":"string","maxLength":3072,"description":"Plain text message content. Will be converted to RCS format. Either text or content must be provided.","example":"Hello! This is a test RCS message.","key$":"text"},"content":{"type":"object","description":"RCS message content in RCS JSON format. Either text or content must be provided.","example":{"text":"Hello! This is a test RCS message."},"key$":"content"}},"x-ref":"#/components/schemas/SendRcsMessage","index$":1}},"application/x-www-form-urlencoded":{"schema":{"type":"object","required":["phone_number","sender"],"properties":{"phone_number":{"type":"string","description":"Recipient phone number (e.g. 48123456789).","example":"48123456789","key$":"phone_number"},"sender":{"allOf":[{"type":"string","format":"oid","pattern":"[0-9a-fA-F]{24}","description":"Object ID","example":"0f0f0f0f0f0f0f0f0f0f0f0f","x-ref":"#/components/schemas/Id"},{"description":"RCS sender ID (object ID of the agent/sender the user has access to)."}],"key$":"sender"},"text":{"type":"string","maxLength":3072,"description":"Plain text message content. Will be converted to RCS format. Either text or content must be provided.","example":"Hello! This is a test RCS message.","key$":"text"},"content":{"type":"object","description":"RCS message content in RCS JSON format. Either text or content must be provided.","example":{"text":"Hello! This is a test RCS message."},"key$":"content"}},"x-ref":"#/components/schemas/SendRcsMessage"}}}},"parameters":[]}})
    }
    const client = setup.client
    const struct = setup.struct

    const isempty = struct.isempty
    const select = struct.select


    // CREATE
    const sent_rcs_message_ref01_ent = client.SentRcsMessage()
    let sent_rcs_message_ref01_data = setup.data.new.sent_rcs_message['sent_rcs_message_ref01']

    sent_rcs_message_ref01_data = (await sent_rcs_message_ref01_ent.create(sent_rcs_message_ref01_data)).data()
    assert(null != sent_rcs_message_ref01_data)


  })
})



function basicSetup(extra) {
  // TODO: fix test def options
  const options = {} // null

  // TODO: needs test utility to resolve path
  const entityDataFile =
    Path.resolve(__dirname,
      '../../../../.sdk/test/entity/sent_rcs_message/SentRcsMessageTestData.json')

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
    ['sent_rcs_message01','sent_rcs_message02','sent_rcs_message03'],
    {
      '`$PACK`': ['', {
        '`$KEY`': '`$COPY`',
        '`$VAL`': ['`$FORMAT`', 'upper', '`$COPY`']
      }]
    })

  const env = envOverride({
    'SMSAPI_TEST_SENT_RCS_MESSAGE_ENTID': idmap,
    'SMSAPI_TEST_LIVE': 'FALSE',
    'SMSAPI_TEST_EXPLAIN': 'FALSE',
    'SMSAPI_APIKEY': '',
  })

  idmap = env['SMSAPI_TEST_SENT_RCS_MESSAGE_ENTID']

  const live = 'TRUE' === env.SMSAPI_TEST_LIVE
  const transport = createLiveTransport()
  if (live) {
    const rawIds = process.env['SMSAPI_TEST_SENT_RCS_MESSAGE_ENTID']
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
  
