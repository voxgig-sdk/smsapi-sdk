
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


describe('UserRcsSenderCollectionEntity', async () => {

  // Per-test live pacing. Delay is read from sdk-test-control.json's
  // `test.live.delayMs`; only sleeps when SMSAPI_TEST_LIVE=TRUE.
  afterEach(liveDelay('SMSAPI_TEST_LIVE'))

  test('instance', async () => {
    const testsdk = SmsapiSDK.test()
    const ent = testsdk.UserRcsSenderCollection()
    assert(null != ent)
  })


  test('basic', async (t) => {

    
    const setup = basicSetup()
    if (setup.live) {
      return runLiveEntity(setup, {"active":true,"alias":{"field":{}},"fields":{"deliveredAt":{"a":true,"fo":"date-time","h":"Delivered At","n":"deliveredAt","r":false,"t":"`$STRING`","key$":"deliveredAt","index$":0},"expiredAt":{"a":true,"fo":"date-time","h":"Expired At","n":"expiredAt","r":false,"t":"`$STRING`","key$":"expiredAt","index$":1},"id":{"a":true,"fo":"oid","h":"Id","n":"id","r":false,"sh":"Object ID","t":"`$STRING`","key$":"id","index$":2},"interface":{"a":true,"h":"Interface","n":"interface","r":false,"sh":"Interface through which the message was sent (www, api, ...).","t":"`$STRING`","key$":"interface","index$":3},"messageType":{"a":true,"h":"Message Type","n":"messageType","r":false,"sh":"RCS message type (basic, single, ...).","t":"`$STRING`","key$":"messageType","index$":4},"readAt":{"a":true,"fo":"date-time","h":"Read At","n":"readAt","r":false,"t":"`$STRING`","key$":"readAt","index$":5},"recipient":{"a":true,"h":"Recipient","n":"recipient","r":false,"sh":"Recipient phone number (without +).","t":"`$STRING`","key$":"recipient","index$":6},"sender":{"a":true,"h":"Sender","n":"sender","r":false,"sh":"Sender name","t":"`$STRING`","key$":"sender","index$":7},"senderId":{"a":true,"h":"Sender Id","n":"senderId","r":false,"sh":"Sender id","t":"`$STRING`","key$":"senderId","index$":8},"sentAt":{"a":true,"fo":"date-time","h":"Sent At","n":"sentAt","r":false,"t":"`$STRING`","key$":"sentAt","index$":9}},"id":{"field":"id","name":"id"},"name":"user_rcs_sender_collection","op":{"list":{"input":"data","name":"list","points":[{"a":true,"co":{"id":"GET /rcs/senders","source":"openapi3","version":2},"g":{},"k":"http","m":"GET","o":"/rcs/senders","q":{},"r":{},"s":[{"lit":"rcs"},{"lit":"senders"}],"t":{"req":"`reqdata`","res":"`body.collection`"},"index$":0}],"key$":"list"}},"relations":{"ancestors":[]},"key$":"user_rcs_sender_collection","name__orig":"user_rcs_sender_collection","Name":"UserRcsSenderCollection","name_":"user_rcs_sender_collection","name-":"user-rcs-sender-collection","NAME":"USER_RCS_SENDER_COLLECTION","index$":27}, {"active":true,"entity":"user_rcs_sender_collection","key$":"BasicUserRcsSenderCollectionFlow","kind":"basic","name":"BasicUserRcsSenderCollectionFlow","param":{},"step":[{"a":true,"d":{},"i":{},"m":{},"o":"list","s":[],"v":[{"apply":"ItemExists","def":{"ref":"user_rcs_sender_collection_ref01"}}],"index$":0}]}, 'UserRcsSenderCollection', {"GET /rcs/senders":{"protocol":"http","parameters":[]}})
    }
    const client = setup.client
    const struct = setup.struct

    const isempty = struct.isempty
    const select = struct.select

    let user_rcs_sender_collection_ref01_data = Object.values(setup.data.existing.user_rcs_sender_collection)[0]

    // LIST
    const user_rcs_sender_collection_ref01_ent = client.UserRcsSenderCollection()
    const user_rcs_sender_collection_ref01_match = {}

    const user_rcs_sender_collection_ref01_list = (await user_rcs_sender_collection_ref01_ent.list(user_rcs_sender_collection_ref01_match)).map((e) => e.data())


  })
})



function basicSetup(extra) {
  // TODO: fix test def options
  const options = {} // null

  // TODO: needs test utility to resolve path
  const entityDataFile =
    Path.resolve(__dirname,
      '../../../../.sdk/test/entity/user_rcs_sender_collection/UserRcsSenderCollectionTestData.json')

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
    ['user_rcs_sender_collection01','user_rcs_sender_collection02','user_rcs_sender_collection03'],
    {
      '`$PACK`': ['', {
        '`$KEY`': '`$COPY`',
        '`$VAL`': ['`$FORMAT`', 'upper', '`$COPY`']
      }]
    })

  const env = envOverride({
    'SMSAPI_TEST_USER_RCS_SENDER_COLLECTION_ENTID': idmap,
    'SMSAPI_TEST_LIVE': 'FALSE',
    'SMSAPI_TEST_EXPLAIN': 'FALSE',
    'SMSAPI_APIKEY': '',
  })

  idmap = env['SMSAPI_TEST_USER_RCS_SENDER_COLLECTION_ENTID']

  const live = 'TRUE' === env.SMSAPI_TEST_LIVE
  const transport = createLiveTransport()
  if (live) {
    const rawIds = process.env['SMSAPI_TEST_USER_RCS_SENDER_COLLECTION_ENTID']
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
  
