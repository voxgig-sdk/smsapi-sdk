

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


describe('ShipmentCountryVolumeEntity', async () => {

  // Per-test live pacing. Delay is read from sdk-test-control.json's
  // `test.live.delayMs`; only sleeps when SMSAPI_TEST_LIVE=TRUE.
  afterEach(liveDelay('SMSAPI_TEST_LIVE'))

  test('instance', async () => {
    const testsdk = SmsapiSDK.test()
    const ent = testsdk.ShipmentCountryVolume()
    assert(null != ent)
  })


  test('basic', async (t) => {

    const live = 'TRUE' === process.env.SMSAPI_TEST_LIVE
    for (const op of ['list']) {
      if (!live && maybeSkipControl(t, 'entityOp', 'shipment_country_volume.' + op, live)) return
    }

    
    const setup = basicSetup()
    if (setup.live) {
      return runLiveEntity(setup, {"active":true,"alias":{"field":{}},"fields":{"country_code":{"a":true,"h":"Country Code","n":"country_code","r":false,"t":"`$STRING`","key$":"country_code","index$":0},"country_limit":{"a":true,"h":"Country Limit","n":"country_limit","r":false,"t":"`$INTEGER`","key$":"country_limit","index$":1},"country_name":{"a":true,"h":"Country Name","n":"country_name","r":false,"t":"`$STRING`","key$":"country_name","index$":2},"usage":{"a":true,"h":"Usage","n":"usage","r":false,"t":"`$INTEGER`","key$":"usage","index$":3}},"name":"shipment_country_volume","op":{"list":{"input":"data","name":"list","points":[{"a":true,"co":{"id":"GET /shipment/country_volumes","source":"openapi3","version":2},"g":{"header":[{"a":true,"ex":"application/json","k":"header","n":"accept","or":"Accept","r":false,"t":"`$STRING`","index$":0}],"query":[{"a":true,"k":"query","n":"month","or":"month","r":false,"t":"`$STRING`","index$":0},{"a":true,"k":"query","n":"year","or":"year","r":false,"t":"`$STRING`","index$":1}]},"k":"http","m":"GET","o":"/shipment/country_volumes","q":{"exist":["accept","month","year"]},"r":{},"s":[{"lit":"shipment"},{"lit":"country_volumes"}],"t":{"req":"`reqdata`","res":"`body.collection`"},"index$":0}],"key$":"list"}},"relations":{"ancestors":[]},"key$":"shipment_country_volume","name__orig":"shipment_country_volume","Name":"ShipmentCountryVolume","name_":"shipment_country_volume","name-":"shipment-country-volume","NAME":"SHIPMENT_COUNTRY_VOLUME","index$":20}, {"active":true,"entity":"shipment_country_volume","key$":"BasicShipmentCountryVolumeFlow","kind":"basic","name":"BasicShipmentCountryVolumeFlow","param":{},"step":[{"a":true,"d":{},"i":{},"m":{},"o":"list","s":[],"v":[{"apply":"ItemExists","def":{"ref":"shipment_country_volume_ref01"}}],"index$":0}]}, 'ShipmentCountryVolume', {"GET /shipment/country_volumes":{"protocol":"http","parameters":[{"in":"query","name":"year","schema":{"type":"string"},"description":"Used country volume year.","index$":0},{"in":"query","name":"month","schema":{"type":"string"},"description":"Used country volume month.","index$":1},{"name":"Accept","in":"header","required":false,"schema":{"type":"string","enum":["application/json","text/csv"],"default":"application/json"},"x-ref":"#/components/parameters/Accept-Header-Csv","index$":2}]}})
    }
    const client = setup.client
    const struct = setup.struct

    const isempty = struct.isempty
    const select = struct.select

    let shipment_country_volume_ref01_data = Object.values(setup.data.existing.shipment_country_volume)[0] as any

    // LIST
    const shipment_country_volume_ref01_ent = client.ShipmentCountryVolume()
    const shipment_country_volume_ref01_match: any = {}

    const shipment_country_volume_ref01_list = (await shipment_country_volume_ref01_ent.list(shipment_country_volume_ref01_match)).map((e: any) => e.data())


  })
})



function basicSetup(extra?: any) {
  // TODO: fix test def options
  const options: any = {} // null

  // TODO: needs test utility to resolve path
  const entityDataFile =
    Path.resolve(__dirname, 
      '../../../../.sdk/test/entity/shipment_country_volume/ShipmentCountryVolumeTestData.json')

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
    ['shipment_country_volume01','shipment_country_volume02','shipment_country_volume03'],
    {
      '`$PACK`': ['', {
        '`$KEY`': '`$COPY`',
        '`$VAL`': ['`$FORMAT`', 'upper', '`$COPY`']
      }]
    })

  const env = envOverride({
    'SMSAPI_TEST_SHIPMENT_COUNTRY_VOLUME_ENTID': idmap,
    'SMSAPI_TEST_LIVE': 'FALSE',
    'SMSAPI_TEST_EXPLAIN': 'FALSE',
    'SMSAPI_APIKEY': '',
  })

  idmap = env['SMSAPI_TEST_SHIPMENT_COUNTRY_VOLUME_ENTID']

  const live = 'TRUE' === env.SMSAPI_TEST_LIVE

  const transport = createLiveTransport()
  if (live) {
    const rawIds = process.env['SMSAPI_TEST_SHIPMENT_COUNTRY_VOLUME_ENTID']
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
  
