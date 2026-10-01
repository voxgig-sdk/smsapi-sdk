

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


describe('ShortUrlEntity', async () => {

  // Per-test live pacing. Delay is read from sdk-test-control.json's
  // `test.live.delayMs`; only sleeps when SMSAPI_TEST_LIVE=TRUE.
  afterEach(liveDelay('SMSAPI_TEST_LIVE'))

  test('instance', async () => {
    const testsdk = SmsapiSDK.test()
    const ent = testsdk.ShortUrl()
    assert(null != ent)
  })


  test('basic', async (t) => {

    const live = 'TRUE' === process.env.SMSAPI_TEST_LIVE
    for (const op of ['create', 'list', 'update', 'load', 'remove']) {
      if (!live && maybeSkipControl(t, 'entityOp', 'short_url.' + op, live)) return
    }

    
    const setup = basicSetup()
    if (setup.live) {
      return runLiveEntity(setup, {"active":true,"alias":{"field":{}},"fields":{"description":{"a":true,"h":"Description","n":"description","r":false,"t":"`$STRING`","key$":"description","index$":0},"expire":{"a":true,"fo":"date-time","h":"Expire","n":"expire","r":false,"t":"`$STRING`","key$":"expire","index$":1},"filename":{"a":true,"h":"Filename","n":"filename","r":false,"t":"`$STRING`","key$":"filename","index$":2},"hits":{"a":true,"h":"Hits","n":"hits","r":false,"t":"`$INTEGER`","key$":"hits","index$":3},"hits_unique":{"a":true,"h":"Hits Unique","n":"hits_unique","r":false,"t":"`$INTEGER`","key$":"hits_unique","index$":4},"id":{"a":true,"h":"Id","n":"id","r":false,"t":"`$STRING`","key$":"id","index$":5},"name":{"a":true,"h":"Name","n":"name","r":false,"t":"`$STRING`","key$":"name","index$":6},"short_url":{"a":true,"fo":"url","h":"Short Url","n":"short_url","r":false,"sh":"WHATWG URL compliant","t":"`$STRING`","key$":"short_url","index$":7},"type":{"a":true,"h":"Type","n":"type","r":false,"t":"`$STRING`","key$":"type","index$":8},"url":{"a":true,"fo":"url","h":"Url","n":"url","r":false,"sh":"WHATWG URL compliant","t":"`$STRING`","key$":"url","index$":9}},"id":{"field":"id","name":"id"},"name":"short_url","op":{"create":{"input":"data","name":"create","points":[{"a":true,"co":{"id":"POST /short_url/links","source":"openapi3","version":2},"g":{},"k":"http","m":"POST","o":"/short_url/links","q":{"$action":"link"},"r":{},"s":[{"lit":"short_url"},{"lit":"links"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":0}],"key$":"create"},"list":{"input":"data","name":"list","points":[{"a":true,"co":{"id":"GET /short_url/links","source":"openapi3","version":2},"g":{},"k":"http","m":"GET","o":"/short_url/links","q":{"$action":"link"},"r":{},"s":[{"lit":"short_url"},{"lit":"links"}],"t":{"req":"`reqdata`","res":"`body.collection`"},"index$":0}],"key$":"list"},"load":{"input":"data","name":"load","points":[{"a":true,"co":{"id":"GET /short_url/links/{id}","source":"openapi3","version":2},"g":{"params":[{"a":true,"ex":"123","k":"param","n":"id","or":"id","r":true,"t":"`$STRING`","index$":0}]},"k":"http","m":"GET","o":"/short_url/links/{id}","q":{"exist":["id"]},"r":{},"s":[{"lit":"short_url"},{"lit":"links"},{"var":"id"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":0}],"key$":"load"},"remove":{"input":"data","name":"remove","points":[{"a":true,"co":{"id":"DELETE /short_url/links/{id}","source":"openapi3","version":2},"g":{"params":[{"a":true,"ex":"123","k":"param","n":"id","or":"id","r":true,"t":"`$STRING`","index$":0}]},"k":"http","m":"DELETE","o":"/short_url/links/{id}","q":{"exist":["id"]},"r":{},"s":[{"lit":"short_url"},{"lit":"links"},{"var":"id"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":0}],"key$":"remove"},"update":{"input":"data","name":"update","points":[{"a":true,"co":{"id":"PUT /short_url/links/{id}","source":"openapi3","version":2},"g":{"params":[{"a":true,"ex":"123","k":"param","n":"id","or":"id","r":true,"t":"`$STRING`","index$":0}]},"k":"http","m":"PUT","o":"/short_url/links/{id}","q":{"exist":["id"]},"r":{},"s":[{"lit":"short_url"},{"lit":"links"},{"var":"id"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":0}],"key$":"update"}},"relations":{"ancestors":[]},"key$":"short_url","name__orig":"short_url","Name":"ShortUrl","name_":"short_url","name-":"short-url","NAME":"SHORT_URL","index$":21}, {"active":true,"entity":"short_url","key$":"BasicShortUrlFlow","kind":"basic","name":"BasicShortUrlFlow","param":{},"step":[{"a":true,"d":{},"i":{"ref":"short_url_ref01"},"m":{},"o":"create","s":[],"v":[],"index$":0},{"a":true,"d":{},"i":{},"m":{},"o":"list","s":[],"v":[{"apply":"ItemExists","def":{"ref":"short_url_ref01"}}],"index$":1},{"a":true,"d":{},"i":{"ref":"short_url_ref01","srcdatavar":"short_url_ref01_data","suffix":"_up0","textfield":"description"},"m":{},"o":"update","s":[{"apply":"TextFieldMark","def":{"mark":"Mark01-short_url_ref01"}}],"v":[],"index$":2},{"a":true,"d":{},"i":{"ref":"short_url_ref01","srcdatavar":"short_url_ref01_data","suffix":"_dt0"},"m":{"id":"short_url01"},"o":"load","s":[],"v":[{"apply":"TextFieldMark","def":{"mark":"Mark01-short_url_ref01"}}],"index$":3},{"a":true,"d":{},"i":{"ref":"short_url_ref01","suffix":"_rm0"},"m":{"id":"short_url01"},"o":"remove","s":[],"v":[],"index$":4},{"a":true,"d":{},"i":{"suffix":"_rt0"},"m":{},"o":"list","s":[],"v":[{"apply":"ItemNotExists","def":{"ref":"short_url_ref01"}}],"index$":5}]}, 'ShortUrl', {"POST /short_url/links":{"protocol":"http","requestBody":{"required":true,"content":{"application/json":{"schema":{"oneOf":[{"allOf":[{"properties":{"name":{},"expire_time":{},"expire_unit":{},"description":{}},"x-ref":"#/components/schemas/CreateCommonShortURL"}],"properties":{"url":{"type":"string","format":"url","description":"WHATWG URL compliant","example":"https://smsapi.pl","x-ref":"#/components/schemas/Url"}},"required":["url"],"x-ref":"#/components/schemas/CreateShortURL"},{"allOf":[{"properties":{"name":{},"expire_time":{},"expire_unit":{},"description":{}},"x-ref":"#/components/schemas/CreateCommonShortURL"}],"properties":{"file":{"type":"file"}},"required":["file"],"x-ref":"#/components/schemas/CreateRichMediaShortURL"}]},"examples":{"create_short_url":{"summary":"Create short url","value":{"url":"http://example.com"}},"create_named_short_url":{"summary":"Create named short url","value":{"url":"http://example.com","name":"Url name"}},"create_short_url_with_description":{"summary":"Create descriptive short url","value":{"url":"http://example.com","description":"My page"}},"create_rich_media_url":{"summary":"Create rich media short url","value":{"file":"file"}},"create_short_url_with_expiration":{"summary":"Create short url that expires in a week","value":{"url":"http://example.com","expire_time":7,"expire_unit":"days"}}}},"application/x-www-form-urlencoded":{"schema":{"oneOf":[{"allOf":[{"properties":{"name":{},"expire_time":{},"expire_unit":{},"description":{}},"x-ref":"#/components/schemas/CreateCommonShortURL"}],"properties":{"url":{"type":"string","format":"url","description":"WHATWG URL compliant","example":"https://smsapi.pl","x-ref":"#/components/schemas/Url"}},"required":["url"],"x-ref":"#/components/schemas/CreateShortURL"},{"allOf":[{"properties":{"name":{},"expire_time":{},"expire_unit":{},"description":{}},"x-ref":"#/components/schemas/CreateCommonShortURL"}],"properties":{"file":{"type":"file"}},"required":["file"],"x-ref":"#/components/schemas/CreateRichMediaShortURL"}]},"examples":{"create_short_url":{"summary":"Create short url","value":"url=http://example.com"},"create_named_short_url":{"summary":"Create named short url","value":"url=http://example.com&name=Url name"},"create_short_url_with_description":{"summary":"Create descriptive short url","value":"url=http://example.com&description=My page"},"create_rich_media_url":{"summary":"Create rich media short url","value":"file=file"},"create_short_url_with_expiration":{"summary":"Create short url that expires in a week","value":"url=http://example.com&expire_time=7&expire_unit=days"}}}}},"parameters":[]},"GET /short_url/links":{"protocol":"http","parameters":[]},"GET /short_url/links/{id}":{"protocol":"http","parameters":[{"name":"id","in":"path","schema":{"type":"string","pattern":"^\\d+$","example":"123","x-ref":"#/components/schemas/ShortUrlId"},"required":true,"description":"Short URL ID","x-ref":"#/components/parameters/shortUrlId","index$":0}]},"DELETE /short_url/links/{id}":{"protocol":"http","parameters":[{"name":"id","in":"path","schema":{"type":"string","pattern":"^\\d+$","example":"123","x-ref":"#/components/schemas/ShortUrlId"},"required":true,"description":"Short URL ID","x-ref":"#/components/parameters/shortUrlId","index$":0}]},"PUT /short_url/links/{id}":{"protocol":"http","requestBody":{"required":true,"content":{"application/x-www-form-urlencoded":{"schema":{"type":"object","properties":{"url":{"type":"string","format":"url","description":"WHATWG URL compliant","example":"https://smsapi.pl","x-ref":"#/components/schemas/Url"},"name":{"type":"string"},"description":{"type":"string"}},"x-ref":"#/components/schemas/UpdateShortURL"}}}},"parameters":[{"name":"id","in":"path","schema":{"type":"string","pattern":"^\\d+$","example":"123","x-ref":"#/components/schemas/ShortUrlId"},"required":true,"description":"Short URL ID","x-ref":"#/components/parameters/shortUrlId","index$":0}]}})
    }
    const client = setup.client
    const struct = setup.struct

    const isempty = struct.isempty
    const select = struct.select


    // CREATE
    const short_url_ref01_ent = client.ShortUrl()
    let short_url_ref01_data = setup.data.new.short_url['short_url_ref01']

    short_url_ref01_data = (await short_url_ref01_ent.create(short_url_ref01_data)).data()
    assert(null != short_url_ref01_data.id)


    // LIST
    const short_url_ref01_match: any = {}

    const short_url_ref01_list = (await short_url_ref01_ent.list(short_url_ref01_match)).map((e: any) => e.data())

    assert(!isempty(select(short_url_ref01_list, { id: short_url_ref01_data.id })))


    // UPDATE
    const short_url_ref01_data_up0: any = {}
    short_url_ref01_data_up0.id = short_url_ref01_data.id

    const short_url_ref01_markdef_up0 = { name: 'description', value: 'Mark01-short_url_ref01_' + setup.now }
    ;(short_url_ref01_data_up0 as any)[short_url_ref01_markdef_up0.name] = short_url_ref01_markdef_up0.value

    const short_url_ref01_resdata_up0 = (await short_url_ref01_ent.update(short_url_ref01_data_up0)).data()
    assert(short_url_ref01_resdata_up0.id === short_url_ref01_data_up0.id)

    assert((short_url_ref01_resdata_up0 as any)[short_url_ref01_markdef_up0.name] === short_url_ref01_markdef_up0.value)


    // LOAD
    const short_url_ref01_match_dt0: any = {}
    short_url_ref01_match_dt0.id = short_url_ref01_data.id
    const short_url_ref01_data_dt0 = (await short_url_ref01_ent.load(short_url_ref01_match_dt0)).data()
    assert(short_url_ref01_data_dt0.id === short_url_ref01_data.id)


    // REMOVE
    const short_url_ref01_match_rm0: any = { id: short_url_ref01_data.id }
    await short_url_ref01_ent.remove(short_url_ref01_match_rm0)
  

    // LIST
    const short_url_ref01_match_rt0: any = {}

    const short_url_ref01_list_rt0 = (await short_url_ref01_ent.list(short_url_ref01_match_rt0)).map((e: any) => e.data())

    assert(isempty(select(short_url_ref01_list_rt0, { id: short_url_ref01_data.id })))


  })
})



function basicSetup(extra?: any) {
  // TODO: fix test def options
  const options: any = {} // null

  // TODO: needs test utility to resolve path
  const entityDataFile =
    Path.resolve(__dirname, 
      '../../../../.sdk/test/entity/short_url/ShortUrlTestData.json')

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
    ['short_url01','short_url02','short_url03'],
    {
      '`$PACK`': ['', {
        '`$KEY`': '`$COPY`',
        '`$VAL`': ['`$FORMAT`', 'upper', '`$COPY`']
      }]
    })

  const env = envOverride({
    'SMSAPI_TEST_SHORT_URL_ENTID': idmap,
    'SMSAPI_TEST_LIVE': 'FALSE',
    'SMSAPI_TEST_EXPLAIN': 'FALSE',
    'SMSAPI_APIKEY': '',
  })

  idmap = env['SMSAPI_TEST_SHORT_URL_ENTID']

  const live = 'TRUE' === env.SMSAPI_TEST_LIVE

  const transport = createLiveTransport()
  if (live) {
    const rawIds = process.env['SMSAPI_TEST_SHORT_URL_ENTID']
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
  
