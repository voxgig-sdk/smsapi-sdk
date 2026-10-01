
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


describe('SmsdoEntity', async () => {

  // Per-test live pacing. Delay is read from sdk-test-control.json's
  // `test.live.delayMs`; only sleeps when SMSAPI_TEST_LIVE=TRUE.
  afterEach(liveDelay('SMSAPI_TEST_LIVE'))

  test('instance', async () => {
    const testsdk = SmsapiSDK.test()
    const ent = testsdk.Smsdo()
    assert(null != ent)
  })


  test('basic', async (t) => {

    
    const setup = basicSetup()
    if (setup.live) {
      return runLiveEntity(setup, {"active":true,"alias":{"field":{}},"fields":{"allow_duplicates":{"a":true,"h":"Allow Duplicates","n":"allow_duplicates","r":false,"sh":"When parameter allow_duplicates is set to \"1\" allows to send message to duplicated numbers in one request (useful i.e.","t":"`$INTEGER`","key$":"allow_duplicates","index$":0},"check_idx":{"a":true,"h":"Check Idx","n":"check_idx","r":false,"sh":"When parameter check_idx is set to „1” prevents from sending more than one message with the same idx in last 24h.","t":"`$ANY`","union":{"branches":3,"count":1,"depth":0},"key$":"check_idx","index$":1},"date":{"a":true,"h":"Date","n":"date","r":false,"sh":"Date in UNIX timestamp (&date=1287734110) or in ISO 8601 (&date=2012-05-10T08:40:27+00:00) when message will be sent (&date=1287734110).","t":"`$ANY`","union":{"branches":2,"count":1,"depth":0},"key$":"date","index$":2},"date_validate":{"a":true,"h":"Date Validate","n":"date_validate","r":false,"sh":"When parameter date_validate is set to \"1\" checks if date if given in proper format.","t":"`$INTEGER`","key$":"date_validate","index$":3},"details":{"a":true,"h":"Details","n":"details","r":false,"sh":"When details parameter is set to \"1\" more details in response will be displayed (message length and sms count).","t":"`$ANY`","union":{"branches":2,"count":1,"depth":0},"key$":"details","index$":4},"encoding":{"a":true,"h":"Encoding","n":"encoding","r":false,"sh":"This parameter describes the encoding of the message text.","t":"`$STRING`","key$":"encoding","index$":5},"expiration_date":{"a":true,"h":"Expiration Date","n":"expiration_date","r":false,"sh":"Message expiration date (in UNIX timestamp or in ISO 8601) is a date after which message won't be delivered if it wasn't delivered yet.","t":"`$ANY`","union":{"branches":2,"count":1,"depth":0},"key$":"expiration_date","index$":6},"fallback":{"a":true,"h":"Fallback","n":"fallback","r":false,"sh":"Enable fallback in case sms sending fails","t":"`$ARRAY`","key$":"fallback","index$":7},"fast":{"a":true,"h":"Fast","n":"fast","r":false,"sh":"Setting this parameter to „1” will result in sending message with the highest priority which ensures the quickest possible time of delivery.","t":"`$INTEGER`","key$":"fast","index$":8},"flash":{"a":true,"h":"Flash","n":"flash","r":false,"sh":"Sending a message in flash mode can be activated by setting this parameter to \"1\".","t":"`$INTEGER`","key$":"flash","index$":9},"format":{"a":true,"h":"Format","n":"format","r":false,"sh":"Parameter &format=json causes, that response is sending in JSON format.","t":"`$STRING`","key$":"format","index$":10},"from":{"a":true,"h":"From","n":"from","r":false,"sh":"Name of the sender.","t":"`$STRING`","key$":"from","index$":11},"group":{"a":true,"h":"Group","n":"group","r":false,"sh":"Name of the group from the contacts database to which message should be sent to.","t":"`$STRING`","key$":"group","index$":12},"idx":{"a":true,"h":"Idx","n":"idx","r":false,"sh":"Optional custom value sent with SMS and sent back in CALLBACK.","t":"`$STRING`","key$":"idx","index$":13},"max_parts":{"a":true,"h":"Max Parts","n":"max_parts","r":false,"sh":"Defines maximum message parts allowed, maximum value allowed is 6.","t":"`$INTEGER`","key$":"max_parts","index$":14},"message":{"a":true,"h":"Message","n":"message","r":false,"sh":"The message text.","t":"`$STRING`","key$":"message","index$":15},"normalize":{"a":true,"h":"Normalize","n":"normalize","r":false,"sh":"When parameter normalize is set to „1” special chars in message will be replaced with their equivalents (ê-e, ñ-n, ý-y ...).","t":"`$INTEGER`","key$":"normalize","index$":16},"notify_url":{"a":true,"h":"Notify Url","n":"notify_url","r":false,"sh":"Parameter allows to set CALLBACK URL for message from request.","t":"`$STRING`","key$":"notify_url","index$":17},"test":{"a":true,"h":"Test","n":"test","r":false,"sh":"When parameter test is set to \"1\" message won't be sent but response will be displayed, there is no charge for such test messages.","t":"`$ANY`","union":{"branches":3,"count":1,"depth":0},"key$":"test","index$":18},"time_restriction":{"a":true,"h":"Time Restriction","n":"time_restriction","r":false,"sh":"Sets the behavior when you try to ship in hours / dates that do not match the settings in your account.","t":"`$STRING`","key$":"time_restriction","index$":19},"to":{"a":true,"h":"To","n":"to","r":false,"sh":"Recipients' mobile phone numbers (i.e.","t":"`$STRING`","key$":"to","index$":20}},"name":"smsdo","op":{"create":{"input":"data","name":"create","points":[{"a":true,"co":{"id":"POST /sms.do","source":"openapi3","version":2},"g":{},"k":"http","m":"POST","o":"/sms.do","q":{},"r":{},"s":[{"lit":"sms.do"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":0}],"key$":"create"}},"relations":{"ancestors":[]},"key$":"smsdo","name__orig":"smsdo","Name":"Smsdo","name_":"smsdo","name-":"smsdo","NAME":"SMSDO","index$":22}, {"active":true,"entity":"smsdo","key$":"BasicSmsdoFlow","kind":"basic","name":"BasicSmsdoFlow","param":{},"step":[{"a":true,"d":{},"i":{"ref":"smsdo_ref01"},"m":{},"o":"create","s":[],"v":[],"index$":0}]}, 'Smsdo', {"POST /sms.do":{"protocol":"http","requestBody":{"content":{"application/x-www-form-urlencoded":{"schema":{"type":"object","properties":{"to":{"type":"string","description":"Recipients' mobile phone numbers (i.e. 44123456789,48512513514).","key$":"to"},"message":{"type":"string","description":"The message text. Content of one message is normally 160 characters per single SMS or 70 in case of using at least one special character (polish characters are considered to be special characters). The maximal message is set to 918 normal characters or 402 if special chars are used and it is being sent as one block of 6 messages joined together and charged as six messages Detailed information about special characters are given in documentation.","key$":"message"},"from":{"type":"string","description":"Name of the sender. As a default the sender name is set to \"Test\". Only verified names are being accepted (&from=active_name). Sender name may be set after logging into Customer Portal on Sendernames.","key$":"from"},"normalize":{"type":"integer","description":"When parameter normalize is set to „1” special chars in message will be replaced with their equivalents (ê-e, ñ-n, ý-y ...).","key$":"normalize"},"group":{"type":"string","description":"Name of the group from the contacts database to which message should be sent to.","key$":"group"},"encoding":{"type":"string","description":"This parameter describes the encoding of the message text. If another encoding is needed parameter encoding should have following value; for UTF-8 - it should be &encoding=utf-8, for iso-8859-2 (latin2) – it should be &encoding=iso-8859-2, for Windows-1250 – it should be &encoding=windows-1250.","key$":"encoding"},"flash":{"type":"integer","description":"Sending a message in flash mode can be activated by setting this parameter to \"1\". Flash SMS are automatically presented on the mobile screen and have to be manually saved to be stored in inbox.","key$":"flash"},"test":{"oneOf":[{"type":"integer"},{"type":"boolean"},{"type":"string"}],"description":"When parameter test is set to \"1\" message won't be sent but response will be displayed, there is no charge for such test messages.","key$":"test"},"details":{"oneOf":[{"type":"integer"},{"type":"boolean"}],"description":"When details parameter is set to \"1\" more details in response will be displayed (message length and sms count).","key$":"details"},"date":{"oneOf":[{"type":"integer"},{"type":"string"}],"description":"Date in UNIX timestamp (&date=1287734110) or in ISO 8601 (&date=2012-05-10T08:40:27+00:00) when message will be sent (&date=1287734110). Setting a past date will result in sending message instantly.","key$":"date"},"date_validate":{"type":"integer","description":"When parameter date_validate is set to \"1\" checks if date if given in proper format. Returns ERROR:54 if not.","key$":"date_validate"},"time_restriction":{"type":"string","description":"Sets the behavior when you try to ship in hours / dates that do not match the settings in your account. Available values are follow - act according to settings,ignore - ignore settings and nearest_available - schedule shipment in the nearest allowed time.","enum":["follow","ignore","nearest_available"],"key$":"time_restriction"},"allow_duplicates":{"type":"integer","description":"When parameter allow_duplicates is set to \"1\" allows to send message to duplicated numbers in one request (useful i.e. for parametrized message contents).","key$":"allow_duplicates"},"idx":{"type":"string","description":"Optional custom value sent with SMS and sent back in CALLBACK.","key$":"idx"},"check_idx":{"oneOf":[{"type":"integer"},{"type":"boolean"},{"type":"string"}],"description":"When parameter check_idx is set to „1” prevents from sending more than one message with the same idx in last 24h. When this parameter is set and message with the same idx was already sent error 53 is returned.","key$":"check_idx"},"max_parts":{"type":"integer","description":"Defines maximum message parts allowed, maximum value allowed is 6. ERROR:12 will be returned when the message has more parts than defined. Default value can be set in Customer Portal.","key$":"max_parts"},"fast":{"type":"integer","description":"Setting this parameter to „1” will result in sending message with the highest priority which ensures the quickest possible time of delivery. Fast messages costs 50% more than normal message. Attention! Mass and marketing messages must not be sent with fast parameter.","key$":"fast"},"notify_url":{"type":"string","description":"Parameter allows to set CALLBACK URL for message from request. This parameter may be used when there is no default CALLBACK URL for this user or when it should be different than default one (notify_url has higher priority than default callback).","key$":"notify_url"},"expiration_date":{"oneOf":[{"type":"integer"},{"type":"string"}],"description":"Message expiration date (in UNIX timestamp or in ISO 8601) is a date after which message won't be delivered if it wasn't delivered yet. The difference between date sent and expiration date shouldn't be less than 15 minutes and more than 72 hours (we recommend using minimum 1 hour and maximum 12 hours difference). Time will be set with tolerance +/- 5 minutes.","key$":"expiration_date"},"format":{"type":"string","description":"Parameter &format=json causes, that response is sending in JSON format.","enum":["json"],"key$":"format"},"fallback":{"type":"array","description":"Enable fallback in case sms sending fails","nullable":true,"items":{"allOf":[{"type":"object","properties":{},"x-ref":"#/components/schemas/FallbackDefinition"}]},"key$":"fallback"}},"x-ref":"#/components/schemas/LegacySmsToSend"}},"application/json":{"schema":{"type":"object","properties":{"to":{"type":"string","description":"Recipients' mobile phone numbers (i.e. 44123456789,48512513514).","key$":"to"},"message":{"type":"string","description":"The message text. Content of one message is normally 160 characters per single SMS or 70 in case of using at least one special character (polish characters are considered to be special characters). The maximal message is set to 918 normal characters or 402 if special chars are used and it is being sent as one block of 6 messages joined together and charged as six messages Detailed information about special characters are given in documentation.","key$":"message"},"from":{"type":"string","description":"Name of the sender. As a default the sender name is set to \"Test\". Only verified names are being accepted (&from=active_name). Sender name may be set after logging into Customer Portal on Sendernames.","key$":"from"},"normalize":{"type":"integer","description":"When parameter normalize is set to „1” special chars in message will be replaced with their equivalents (ê-e, ñ-n, ý-y ...).","key$":"normalize"},"group":{"type":"string","description":"Name of the group from the contacts database to which message should be sent to.","key$":"group"},"encoding":{"type":"string","description":"This parameter describes the encoding of the message text. If another encoding is needed parameter encoding should have following value; for UTF-8 - it should be &encoding=utf-8, for iso-8859-2 (latin2) – it should be &encoding=iso-8859-2, for Windows-1250 – it should be &encoding=windows-1250.","key$":"encoding"},"flash":{"type":"integer","description":"Sending a message in flash mode can be activated by setting this parameter to \"1\". Flash SMS are automatically presented on the mobile screen and have to be manually saved to be stored in inbox.","key$":"flash"},"test":{"oneOf":[{"type":"integer"},{"type":"boolean"},{"type":"string"}],"description":"When parameter test is set to \"1\" message won't be sent but response will be displayed, there is no charge for such test messages.","key$":"test"},"details":{"oneOf":[{"type":"integer"},{"type":"boolean"}],"description":"When details parameter is set to \"1\" more details in response will be displayed (message length and sms count).","key$":"details"},"date":{"oneOf":[{"type":"integer"},{"type":"string"}],"description":"Date in UNIX timestamp (&date=1287734110) or in ISO 8601 (&date=2012-05-10T08:40:27+00:00) when message will be sent (&date=1287734110). Setting a past date will result in sending message instantly.","key$":"date"},"date_validate":{"type":"integer","description":"When parameter date_validate is set to \"1\" checks if date if given in proper format. Returns ERROR:54 if not.","key$":"date_validate"},"time_restriction":{"type":"string","description":"Sets the behavior when you try to ship in hours / dates that do not match the settings in your account. Available values are follow - act according to settings,ignore - ignore settings and nearest_available - schedule shipment in the nearest allowed time.","enum":["follow","ignore","nearest_available"],"key$":"time_restriction"},"allow_duplicates":{"type":"integer","description":"When parameter allow_duplicates is set to \"1\" allows to send message to duplicated numbers in one request (useful i.e. for parametrized message contents).","key$":"allow_duplicates"},"idx":{"type":"string","description":"Optional custom value sent with SMS and sent back in CALLBACK.","key$":"idx"},"check_idx":{"oneOf":[{"type":"integer"},{"type":"boolean"},{"type":"string"}],"description":"When parameter check_idx is set to „1” prevents from sending more than one message with the same idx in last 24h. When this parameter is set and message with the same idx was already sent error 53 is returned.","key$":"check_idx"},"max_parts":{"type":"integer","description":"Defines maximum message parts allowed, maximum value allowed is 6. ERROR:12 will be returned when the message has more parts than defined. Default value can be set in Customer Portal.","key$":"max_parts"},"fast":{"type":"integer","description":"Setting this parameter to „1” will result in sending message with the highest priority which ensures the quickest possible time of delivery. Fast messages costs 50% more than normal message. Attention! Mass and marketing messages must not be sent with fast parameter.","key$":"fast"},"notify_url":{"type":"string","description":"Parameter allows to set CALLBACK URL for message from request. This parameter may be used when there is no default CALLBACK URL for this user or when it should be different than default one (notify_url has higher priority than default callback).","key$":"notify_url"},"expiration_date":{"oneOf":[{"type":"integer"},{"type":"string"}],"description":"Message expiration date (in UNIX timestamp or in ISO 8601) is a date after which message won't be delivered if it wasn't delivered yet. The difference between date sent and expiration date shouldn't be less than 15 minutes and more than 72 hours (we recommend using minimum 1 hour and maximum 12 hours difference). Time will be set with tolerance +/- 5 minutes.","key$":"expiration_date"},"format":{"type":"string","description":"Parameter &format=json causes, that response is sending in JSON format.","enum":["json"],"key$":"format"},"fallback":{"type":"array","description":"Enable fallback in case sms sending fails","nullable":true,"items":{"allOf":[{"type":"object","properties":{},"x-ref":"#/components/schemas/FallbackDefinition"}]},"key$":"fallback"}},"x-ref":"#/components/schemas/LegacySmsToSend","index$":1}}}},"parameters":[]}})
    }
    const client = setup.client
    const struct = setup.struct

    const isempty = struct.isempty
    const select = struct.select


    // CREATE
    const smsdo_ref01_ent = client.Smsdo()
    let smsdo_ref01_data = setup.data.new.smsdo['smsdo_ref01']

    smsdo_ref01_data = (await smsdo_ref01_ent.create(smsdo_ref01_data)).data()
    assert(null != smsdo_ref01_data)


  })
})



function basicSetup(extra) {
  // TODO: fix test def options
  const options = {} // null

  // TODO: needs test utility to resolve path
  const entityDataFile =
    Path.resolve(__dirname,
      '../../../../.sdk/test/entity/smsdo/SmsdoTestData.json')

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
    ['smsdo01','smsdo02','smsdo03'],
    {
      '`$PACK`': ['', {
        '`$KEY`': '`$COPY`',
        '`$VAL`': ['`$FORMAT`', 'upper', '`$COPY`']
      }]
    })

  const env = envOverride({
    'SMSAPI_TEST_SMSDO_ENTID': idmap,
    'SMSAPI_TEST_LIVE': 'FALSE',
    'SMSAPI_TEST_EXPLAIN': 'FALSE',
    'SMSAPI_APIKEY': '',
  })

  idmap = env['SMSAPI_TEST_SMSDO_ENTID']

  const live = 'TRUE' === env.SMSAPI_TEST_LIVE
  const transport = createLiveTransport()
  if (live) {
    const rawIds = process.env['SMSAPI_TEST_SMSDO_ENTID']
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
  
