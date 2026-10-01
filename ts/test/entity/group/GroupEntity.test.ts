

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


describe('GroupEntity', async () => {

  // Per-test live pacing. Delay is read from sdk-test-control.json's
  // `test.live.delayMs`; only sleeps when SMSAPI_TEST_LIVE=TRUE.
  afterEach(liveDelay('SMSAPI_TEST_LIVE'))

  test('instance', async () => {
    const testsdk = SmsapiSDK.test()
    const ent = testsdk.Group()
    assert(null != ent)
  })


  test('basic', async (t) => {

    const live = 'TRUE' === process.env.SMSAPI_TEST_LIVE
    for (const op of ['update', 'load']) {
      if (!live && maybeSkipControl(t, 'entityOp', 'group.' + op, live)) return
    }

    
    const setup = basicSetup()
    if (setup.live) {
      return runLiveEntity(setup, {"active":true,"alias":{"field":{}},"fields":{"contact_expire_after":{"a":true,"h":"Contact Expire After","n":"contact_expire_after","r":true,"sh":"Contact expire after days","t":"`$INTEGER`","key$":"contact_expire_after","index$":0},"contacts_count":{"a":true,"h":"Contacts Count","n":"contacts_count","r":true,"t":"`$INTEGER`","key$":"contacts_count","index$":1},"created_by":{"a":true,"h":"Created By","n":"created_by","r":true,"t":"`$STRING`","key$":"created_by","index$":2},"date_created":{"a":true,"fo":"date-time","h":"Date Created","n":"date_created","r":true,"t":"`$STRING`","key$":"date_created","index$":3},"date_updated":{"a":true,"fo":"date-time","h":"Date Updated","n":"date_updated","r":true,"t":"`$STRING`","key$":"date_updated","index$":4},"description":{"a":true,"h":"Description","n":"description","r":true,"t":"`$STRING`","key$":"description","index$":5},"id":{"a":true,"fo":"oid","h":"Id","n":"id","r":true,"sh":"Object ID","t":"`$STRING`","key$":"id","index$":6},"idx":{"a":true,"h":"Idx","n":"idx","r":false,"sh":"User provided resource id","t":"`$STRING`","key$":"idx","index$":7},"name":{"a":true,"h":"Name","n":"name","r":true,"sh":"Group name","t":"`$STRING`","key$":"name","index$":8},"permissions":{"a":true,"h":"Permissions","n":"permissions","r":false,"t":"`$ARRAY`","key$":"permissions","index$":9}},"id":{"field":"id","name":"id"},"name":"group","op":{"load":{"input":"data","name":"load","points":[{"a":true,"co":{"id":"GET /contacts/groups/{groupId}","source":"openapi3","version":2},"g":{"params":[{"a":true,"ex":"0f0f0f0f0f0f0f0f0f0f0f0f","k":"param","n":"id","or":"groupId","r":true,"t":"`$STRING`","index$":0}]},"k":"http","m":"GET","o":"/contacts/groups/{groupId}","q":{"exist":["id"]},"r":{"param":{"groupId":"id"}},"s":[{"lit":"contacts"},{"lit":"groups"},{"var":"id"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":0}],"key$":"load"},"update":{"input":"data","name":"update","points":[{"a":true,"co":{"id":"PUT /contacts/groups/{groupId}","source":"openapi3","version":2},"g":{"params":[{"a":true,"ex":"0f0f0f0f0f0f0f0f0f0f0f0f","k":"param","n":"id","or":"groupId","r":true,"t":"`$STRING`","index$":0}]},"k":"http","m":"PUT","o":"/contacts/groups/{groupId}","q":{"exist":["id"]},"r":{"param":{"groupId":"id"}},"s":[{"lit":"contacts"},{"lit":"groups"},{"var":"id"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":0}],"key$":"update"}},"relations":{"ancestors":[]},"key$":"group","name__orig":"group","Name":"Group","name_":"group","name-":"group","NAME":"GROUP","index$":9}, {"active":true,"entity":"group","key$":"BasicGroupFlow","kind":"basic","name":"BasicGroupFlow","param":{},"step":[{"a":true,"d":{},"i":{"ref":"group_ref01","srcdatavar":"group_ref01_data","suffix":"_up0","textfield":"created_by"},"m":{},"o":"update","s":[{"apply":"TextFieldMark","def":{"mark":"Mark01-group_ref01"}}],"v":[],"index$":0},{"a":true,"d":{},"i":{"ref":"group_ref01","srcdatavar":"group_ref01_data","suffix":"_dt0"},"m":{"id":"group01"},"o":"load","s":[],"v":[{"apply":"TextFieldMark","def":{"mark":"Mark01-group_ref01"}}],"index$":1}]}, 'Group', {"GET /contacts/groups/{groupId}":{"protocol":"http","parameters":[{"name":"groupId","schema":{"type":"string","format":"oid","pattern":"[0-9a-fA-F]{24}","description":"Object ID","example":"0f0f0f0f0f0f0f0f0f0f0f0f","x-ref":"#/components/schemas/Id"},"in":"path","required":true,"description":"Group ID","x-ref":"#/components/parameters/groupId","index$":0}]},"PUT /contacts/groups/{groupId}":{"protocol":"http","requestBody":{"required":true,"content":{"application/x-www-form-urlencoded":{"schema":{"required":["name"],"properties":{"name":{"type":"string","example":"Example Group","description":"Group name","x-ref":"#/components/schemas/GroupName"},"description":{"type":"string","example":"Resource description","x-ref":"#/components/schemas/Description"},"idx":{"type":"string","example":"example-user-provided-id-123","description":"User provided resource id","x-ref":"#/components/schemas/ContactsIdx"},"contact_expire_after":{"type":"integer","description":"Contact expire after days","x-ref":"#/components/schemas/ContactExpireAfter"}},"x-ref":"#/components/schemas/EditGroup"}}}},"parameters":[{"name":"groupId","schema":{"type":"string","format":"oid","pattern":"[0-9a-fA-F]{24}","description":"Object ID","example":"0f0f0f0f0f0f0f0f0f0f0f0f","x-ref":"#/components/schemas/Id"},"in":"path","required":true,"description":"Group ID","x-ref":"#/components/parameters/groupId","index$":0}]}})
    }
    const client = setup.client
    const struct = setup.struct

    const isempty = struct.isempty
    const select = struct.select

    let group_ref01_data = Object.values(setup.data.existing.group)[0] as any

    // UPDATE
    const group_ref01_ent = client.Group()
    const group_ref01_data_up0: any = {}
    group_ref01_data_up0.id = group_ref01_data.id

    const group_ref01_markdef_up0 = { name: 'created_by', value: 'Mark01-group_ref01_' + setup.now }
    ;(group_ref01_data_up0 as any)[group_ref01_markdef_up0.name] = group_ref01_markdef_up0.value

    const group_ref01_resdata_up0 = (await group_ref01_ent.update(group_ref01_data_up0)).data()
    assert(group_ref01_resdata_up0.id === group_ref01_data_up0.id)

    assert((group_ref01_resdata_up0 as any)[group_ref01_markdef_up0.name] === group_ref01_markdef_up0.value)


    // LOAD
    const group_ref01_match_dt0: any = {}
    group_ref01_match_dt0.id = group_ref01_data.id
    const group_ref01_data_dt0 = (await group_ref01_ent.load(group_ref01_match_dt0)).data()
    assert(group_ref01_data_dt0.id === group_ref01_data.id)


  })
})



function basicSetup(extra?: any) {
  // TODO: fix test def options
  const options: any = {} // null

  // TODO: needs test utility to resolve path
  const entityDataFile =
    Path.resolve(__dirname, 
      '../../../../.sdk/test/entity/group/GroupTestData.json')

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
    ['group01','group02','group03'],
    {
      '`$PACK`': ['', {
        '`$KEY`': '`$COPY`',
        '`$VAL`': ['`$FORMAT`', 'upper', '`$COPY`']
      }]
    })

  const env = envOverride({
    'SMSAPI_TEST_GROUP_ENTID': idmap,
    'SMSAPI_TEST_LIVE': 'FALSE',
    'SMSAPI_TEST_EXPLAIN': 'FALSE',
    'SMSAPI_APIKEY': '',
  })

  idmap = env['SMSAPI_TEST_GROUP_ENTID']

  const live = 'TRUE' === env.SMSAPI_TEST_LIVE

  const transport = createLiveTransport()
  if (live) {
    const rawIds = process.env['SMSAPI_TEST_GROUP_ENTID']
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
  
