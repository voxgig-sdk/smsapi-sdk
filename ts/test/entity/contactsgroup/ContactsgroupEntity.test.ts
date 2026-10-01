

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


describe('ContactsgroupEntity', async () => {

  // Per-test live pacing. Delay is read from sdk-test-control.json's
  // `test.live.delayMs`; only sleeps when SMSAPI_TEST_LIVE=TRUE.
  afterEach(liveDelay('SMSAPI_TEST_LIVE'))

  test('instance', async () => {
    const testsdk = SmsapiSDK.test()
    const ent = testsdk.Contactsgroup()
    assert(null != ent)
  })


  test('basic', async (t) => {

    const live = 'TRUE' === process.env.SMSAPI_TEST_LIVE
    for (const op of ['create', 'list', 'update', 'remove']) {
      if (!live && maybeSkipControl(t, 'entityOp', 'contactsgroup.' + op, live)) return
    }

    
    const setup = basicSetup()
    if (setup.live) {
      return runLiveEntity(setup, {"active":true,"alias":{"field":{}},"fields":{"birthday_date":{"a":true,"fo":"date","h":"Birthday Date","n":"birthday_date","r":false,"t":"`$STRING`","key$":"birthday_date","index$":0},"city":{"a":true,"h":"City","n":"city","r":false,"t":"`$STRING`","key$":"city","index$":1},"contact_expire_after":{"a":true,"h":"Contact Expire After","n":"contact_expire_after","r":true,"sh":"Contact expire after days","t":"`$INTEGER`","key$":"contact_expire_after","index$":2},"contacts_count":{"a":true,"h":"Contacts Count","n":"contacts_count","r":false,"t":"`$INTEGER`","key$":"contacts_count","index$":3},"country":{"a":true,"h":"Country","n":"country","r":false,"t":"`$STRING`","key$":"country","index$":4},"created_by":{"a":true,"h":"Created By","n":"created_by","r":true,"t":"`$STRING`","key$":"created_by","index$":5},"date_created":{"a":true,"fo":"date-time","h":"Date Created","n":"date_created","r":true,"t":"`$STRING`","key$":"date_created","index$":6},"date_updated":{"a":true,"fo":"date-time","h":"Date Updated","n":"date_updated","r":true,"t":"`$STRING`","key$":"date_updated","index$":7},"description":{"a":true,"h":"Description","n":"description","r":false,"t":"`$STRING`","key$":"description","index$":8},"email":{"a":true,"fo":"email","h":"Email","n":"email","r":false,"t":"`$STRING`","key$":"email","index$":9},"first_name":{"a":true,"h":"First Name","n":"first_name","r":false,"t":"`$STRING`","key$":"first_name","index$":10},"gender":{"a":true,"h":"Gender","n":"gender","r":true,"t":"`$STRING`","key$":"gender","index$":11},"group_id":{"a":true,"fo":"oid","h":"Group Id","n":"group_id","op":{"list":{"req":false,"type":"`$STRING`"}},"r":true,"sh":"Object ID","t":"`$STRING`","key$":"group_id","index$":12},"groups":{"a":true,"h":"Groups","n":"groups","r":true,"t":"`$ARRAY`","key$":"groups","index$":13},"id":{"a":true,"fo":"oid","h":"Id","n":"id","r":true,"sh":"Object ID","t":"`$STRING`","key$":"id","index$":14},"idx":{"a":true,"h":"Idx","n":"idx","r":false,"sh":"User provided resource id","t":"`$STRING`","key$":"idx","index$":15},"last_name":{"a":true,"h":"Last Name","n":"last_name","r":false,"t":"`$STRING`","key$":"last_name","index$":16},"name":{"a":true,"h":"Name","n":"name","r":false,"sh":"Group name","t":"`$STRING`","key$":"name","index$":17},"permissions":{"a":true,"h":"Permissions","n":"permissions","r":false,"t":"`$ARRAY`","key$":"permissions","index$":18},"phone_number":{"a":true,"h":"Phone Number","n":"phone_number","r":false,"t":"`$STRING`","key$":"phone_number","index$":19},"read":{"a":true,"h":"Read","n":"read","op":{"list":{"req":false,"type":"`$BOOLEAN`"}},"r":true,"sh":"Has read permission","t":"`$BOOLEAN`","key$":"read","index$":20},"send":{"a":true,"h":"Send","n":"send","op":{"list":{"req":false,"type":"`$BOOLEAN`"}},"r":true,"sh":"Has send permission","t":"`$BOOLEAN`","key$":"send","index$":21},"source":{"a":true,"h":"Source","n":"source","r":false,"t":"`$STRING`","key$":"source","index$":22},"type":{"a":true,"h":"Type","n":"type","r":false,"t":"`$STRING`","key$":"type","index$":23},"username":{"a":true,"h":"Username","n":"username","op":{"list":{"req":false,"type":"`$STRING`"}},"r":true,"t":"`$STRING`","key$":"username","index$":24},"value":{"a":true,"h":"Value","n":"value","r":false,"t":"`$STRING`","key$":"value","index$":25},"write":{"a":true,"h":"Write","n":"write","op":{"list":{"req":false,"type":"`$BOOLEAN`"}},"r":true,"sh":"Has write permission","t":"`$BOOLEAN`","key$":"write","index$":26}},"id":{"field":"id","name":"id"},"name":"contactsgroup","op":{"create":{"input":"data","name":"create","points":[{"a":true,"co":{"id":"POST /contacts/groups/{groupId}/members","source":"openapi3","version":2},"g":{"params":[{"a":true,"ex":"0f0f0f0f0f0f0f0f0f0f0f0f","k":"param","n":"group_id","or":"groupId","r":true,"t":"`$STRING`","index$":0}]},"k":"http","m":"POST","o":"/contacts/groups/{groupId}/members","q":{"exist":["group_id"]},"r":{"param":{"groupId":"group_id"}},"s":[{"lit":"contacts"},{"lit":"groups"},{"var":"group_id"},{"lit":"members"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":0},{"a":true,"co":{"id":"POST /contacts/groups","source":"openapi3","version":2},"g":{},"k":"http","m":"POST","o":"/contacts/groups","q":{},"r":{},"s":[{"lit":"contacts"},{"lit":"groups"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":0}],"key$":"create"},"list":{"input":"data","name":"list","points":[{"a":true,"co":{"id":"GET /contacts/groups","source":"openapi3","version":2},"g":{"query":[{"a":true,"ex":"{\"name\" : \"group name\"}","k":"query","n":"name","or":"name","r":false,"t":"`$OBJECT`","index$":0},{"a":true,"k":"query","n":"with","or":"with","r":false,"t":"`$ARRAY`","index$":1}]},"k":"http","m":"GET","o":"/contacts/groups","q":{"exist":["name","with"]},"r":{},"s":[{"lit":"contacts"},{"lit":"groups"}],"t":{"req":"`reqdata`","res":"`body.collection`"},"index$":0},{"a":true,"co":{"id":"GET /contacts/groups/{groupId}/permissions","source":"openapi3","version":2},"g":{"params":[{"a":true,"ex":"0f0f0f0f0f0f0f0f0f0f0f0f","k":"param","n":"group_id","or":"groupId","r":true,"t":"`$STRING`","index$":0}]},"k":"http","m":"GET","o":"/contacts/groups/{groupId}/permissions","q":{"exist":["group_id"]},"r":{"param":{"groupId":"group_id"}},"s":[{"lit":"contacts"},{"lit":"groups"},{"var":"group_id"},{"lit":"permissions"}],"t":{"req":"`reqdata`","res":"`body.collection`"},"index$":1}],"key$":"list"},"remove":{"input":"data","name":"remove","points":[{"a":true,"co":{"id":"DELETE /contacts/groups/{groupId}/members/{contactId}","source":"openapi3","version":2},"g":{"params":[{"a":true,"ex":"0f0f0f0f0f0f0f0f0f0f0f0f","k":"param","n":"contact_id","or":"contactId","r":true,"t":"`$STRING`","index$":0},{"a":true,"ex":"0f0f0f0f0f0f0f0f0f0f0f0f","k":"param","n":"group_id","or":"groupId","r":true,"t":"`$STRING`","index$":1}]},"k":"http","m":"DELETE","o":"/contacts/groups/{groupId}/members/{contactId}","q":{"exist":["contact_id","group_id"]},"r":{"param":{"contactId":"contact_id","groupId":"group_id"}},"s":[{"lit":"contacts"},{"lit":"groups"},{"var":"group_id"},{"lit":"members"},{"var":"contact_id"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":0},{"a":true,"co":{"id":"DELETE /contacts/groups/{groupId}/permissions/{username}","source":"openapi3","version":2},"g":{"params":[{"a":true,"ex":"0f0f0f0f0f0f0f0f0f0f0f0f","k":"param","n":"group_id","or":"groupId","r":true,"t":"`$STRING`","index$":0},{"a":true,"k":"param","n":"username","or":"username","r":true,"t":"`$STRING`","index$":1}],"query":[{"a":true,"ex":"example_username","k":"query","n":"username","or":"username","r":true,"t":"`$STRING`","index$":0}]},"k":"http","m":"DELETE","o":"/contacts/groups/{groupId}/permissions/{username}","q":{"exist":["group_id","username"]},"r":{"param":{"groupId":"group_id"}},"s":[{"lit":"contacts"},{"lit":"groups"},{"var":"group_id"},{"lit":"permissions"},{"var":"username"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":1},{"a":true,"co":{"id":"DELETE /contacts/groups/{groupId}","source":"openapi3","version":2},"g":{"params":[{"a":true,"ex":"0f0f0f0f0f0f0f0f0f0f0f0f","k":"param","n":"group_id","or":"groupId","r":true,"t":"`$STRING`","index$":0}]},"k":"http","m":"DELETE","o":"/contacts/groups/{groupId}","q":{"exist":["group_id"]},"r":{"param":{"groupId":"group_id"}},"s":[{"lit":"contacts"},{"lit":"groups"},{"var":"group_id"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":0},{"a":true,"co":{"id":"DELETE /contacts/groups/{groupId}/members","source":"openapi3","version":2},"g":{"params":[{"a":true,"ex":"0f0f0f0f0f0f0f0f0f0f0f0f","k":"param","n":"group_id","or":"groupId","r":true,"t":"`$STRING`","index$":0}]},"k":"http","m":"DELETE","o":"/contacts/groups/{groupId}/members","q":{"exist":["group_id"]},"r":{"param":{"groupId":"group_id"}},"s":[{"lit":"contacts"},{"lit":"groups"},{"var":"group_id"},{"lit":"members"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":3},{"a":true,"co":{"id":"DELETE /contacts/groups","source":"openapi3","version":2},"g":{},"k":"http","m":"DELETE","o":"/contacts/groups","q":{},"r":{},"s":[{"lit":"contacts"},{"lit":"groups"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":4}],"key$":"remove"},"update":{"input":"data","name":"update","points":[{"a":true,"co":{"id":"PUT /contacts/groups/{groupId}/permissions/{username}","source":"openapi3","version":2},"g":{"params":[{"a":true,"ex":"0f0f0f0f0f0f0f0f0f0f0f0f","k":"param","n":"group_id","or":"groupId","r":true,"t":"`$STRING`","index$":0},{"a":true,"k":"param","n":"username","or":"username","r":true,"t":"`$STRING`","index$":1}],"query":[{"a":true,"ex":"example_username","k":"query","n":"username","or":"username","r":true,"t":"`$STRING`","index$":0}]},"k":"http","m":"PUT","o":"/contacts/groups/{groupId}/permissions/{username}","q":{"exist":["group_id","username"]},"r":{"param":{"groupId":"group_id"}},"s":[{"lit":"contacts"},{"lit":"groups"},{"var":"group_id"},{"lit":"permissions"},{"var":"username"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":0},{"a":true,"co":{"id":"PUT /contacts/groups/{groupId}/members","source":"openapi3","version":2},"g":{"params":[{"a":true,"ex":"0f0f0f0f0f0f0f0f0f0f0f0f","k":"param","n":"group_id","or":"groupId","r":true,"t":"`$STRING`","index$":0}]},"k":"http","m":"PUT","o":"/contacts/groups/{groupId}/members","q":{"exist":["group_id"]},"r":{"param":{"groupId":"group_id"}},"s":[{"lit":"contacts"},{"lit":"groups"},{"var":"group_id"},{"lit":"members"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":1}],"key$":"update"}},"relations":{"ancestors":[["$.main.kit.entity.group"],["$.main.kit.entity.group"],["$.main.kit.entity.group","$.main.kit.entity.permission"]]},"key$":"contactsgroup","name__orig":"contactsgroup","Name":"Contactsgroup","name_":"contactsgroup","name-":"contactsgroup","NAME":"CONTACTSGROUP","index$":6}, {"active":true,"entity":"contactsgroup","key$":"BasicContactsgroupFlow","kind":"basic","name":"BasicContactsgroupFlow","param":{},"step":[{"a":true,"d":{},"i":{"ref":"contactsgroup_ref01"},"m":{"group_id":"group01"},"o":"create","s":[],"v":[],"index$":0},{"a":true,"d":{},"i":{},"m":{"group_id":"group01"},"o":"list","s":[],"v":[{"apply":"ItemExists","def":{"ref":"contactsgroup_ref01"}}],"index$":1},{"a":true,"d":{},"i":{"ref":"contactsgroup_ref01","srcdatavar":"contactsgroup_ref01_data","suffix":"_up0","textfield":"birthday_date"},"m":{},"o":"update","s":[{"apply":"TextFieldMark","def":{"mark":"Mark01-contactsgroup_ref01"}}],"v":[],"index$":2},{"a":true,"d":{},"i":{"ref":"contactsgroup_ref01","suffix":"_rm0"},"m":{},"o":"remove","s":[],"v":[],"index$":3},{"a":true,"d":{},"i":{"suffix":"_rt0"},"m":{"group_id":"group01"},"o":"list","s":[],"v":[{"apply":"ItemNotExists","def":{"ref":"contactsgroup_ref01"}}],"index$":4}]}, 'Contactsgroup', {"POST /contacts/groups/{groupId}/members":{"protocol":"http","requestBody":{"required":true,"content":{"application/x-www-form-urlencoded":{"schema":{"properties":{"q":{"type":"string","description":"Search text on standart fields"},"phone_number":{"type":"array","items":{"type":"string","pattern":"[0-9]{8,16}","x-ref":"#/components/schemas/ContactsPhoneNumber"},"description":"Search by phone_number"},"email":{"type":"array","items":{"type":"string","format":"email","example":"john.doe@example.com","x-ref":"#/components/schemas/EmailAddress"},"description":"Search by email"},"first_name":{"type":"array","items":{"type":"string","example":"John","x-ref":"#/components/schemas/ContactsFirstName"},"description":"Search by first name"},"last_name":{"type":"array","items":{"type":"string","example":"Doe","x-ref":"#/components/schemas/LastName"},"description":"Search by last name"},"group_id":{"type":"array","items":{"type":"string","format":"oid","pattern":"[0-9a-fA-F]{24}","description":"Object ID","example":"0f0f0f0f0f0f0f0f0f0f0f0f","x-ref":"#/components/schemas/Id"},"description":"Search by group"},"gender":{"type":"string","enum":["undefined","male","female"],"description":"Search by gender","x-ref":"#/components/schemas/Gender"},"birthday_date":{"type":"array","items":{"type":"string","format":"date","example":"2017-07-21","x-ref":"#/components/schemas/Date"},"description":"Search by birthday date"}},"x-ref":"#/components/schemas/AddContactToGroupByQuery"}}}},"parameters":[{"name":"groupId","schema":{"type":"string","format":"oid","pattern":"[0-9a-fA-F]{24}","description":"Object ID","example":"0f0f0f0f0f0f0f0f0f0f0f0f","x-ref":"#/components/schemas/Id"},"in":"path","required":true,"description":"Group ID","x-ref":"#/components/parameters/groupId","index$":0}]},"POST /contacts/groups":{"protocol":"http","requestBody":{"required":true,"content":{"application/x-www-form-urlencoded":{"schema":{"required":["name"],"properties":{"name":{"type":"string","example":"Example Group","description":"Group name","x-ref":"#/components/schemas/GroupName"},"description":{"type":"string","example":"Resource description","x-ref":"#/components/schemas/Description"},"idx":{"type":"string","example":"example-user-provided-id-123","description":"User provided resource id","x-ref":"#/components/schemas/ContactsIdx"},"contact_expire_after":{"type":"integer","description":"Contact expire after days","x-ref":"#/components/schemas/ContactExpireAfter"}},"x-ref":"#/components/schemas/CreateGroup"}}}},"parameters":[]},"GET /contacts/groups":{"protocol":"http","parameters":[{"name":"with","schema":{"type":"array","items":{"type":"string","enum":["contacts_count","permission_send","no_group","phone_number"]}},"in":"query","required":false,"description":"Search/expose extra parameters","index$":0},{"name":"name","schema":{"type":"object"},"in":"query","required":false,"description":"Search by group name(s)","examples":{"group_name_like":{"value":"{\"name\" : \"group name\"}"},"group_name_equals":{"value":"{\"name\" : \"eq(group name)\"}"},"group_name_equals_case_insensitive":{"value":"{\"name\" : \"eqi(group name)\"}"},"group_names_like":{"value":"{\"name\" : [\"group 1 name\", \"group 2 name\"]}"},"group_names_equals":{"value":"{\"name\" : [\"eq(group 1 name)\", \"eq(group 2 name)\"]}"},"group_names_equals_case_insensitive":{"value":"{\"name\" : [\"eqi(group 1 name)\", \"eqi(group 2 name)\"]}"}},"index$":1}]},"GET /contacts/groups/{groupId}/permissions":{"protocol":"http","parameters":[{"name":"groupId","schema":{"type":"string","format":"oid","pattern":"[0-9a-fA-F]{24}","description":"Object ID","example":"0f0f0f0f0f0f0f0f0f0f0f0f","x-ref":"#/components/schemas/Id"},"in":"path","required":true,"description":"Group ID","x-ref":"#/components/parameters/groupId","index$":0}]},"DELETE /contacts/groups/{groupId}/members/{contactId}":{"protocol":"http","parameters":[{"name":"groupId","schema":{"type":"string","format":"oid","pattern":"[0-9a-fA-F]{24}","description":"Object ID","example":"0f0f0f0f0f0f0f0f0f0f0f0f","x-ref":"#/components/schemas/Id"},"in":"path","required":true,"description":"Group ID","x-ref":"#/components/parameters/groupId","index$":0},{"name":"contactId","schema":{"type":"string","format":"oid","pattern":"[0-9a-fA-F]{24}","description":"Object ID","example":"0f0f0f0f0f0f0f0f0f0f0f0f","x-ref":"#/components/schemas/Id"},"in":"path","required":true,"description":"Contact ID","x-ref":"#/components/parameters/contactId","index$":1}]},"DELETE /contacts/groups/{groupId}/permissions/{username}":{"protocol":"http","parameters":[{"name":"groupId","schema":{"type":"string","format":"oid","pattern":"[0-9a-fA-F]{24}","description":"Object ID","example":"0f0f0f0f0f0f0f0f0f0f0f0f","x-ref":"#/components/schemas/Id"},"in":"path","required":true,"description":"Group ID","x-ref":"#/components/parameters/groupId","index$":0},{"name":"username","schema":{"type":"string","example":"example_username","x-ref":"#/components/schemas/Username"},"required":true,"description":"Username","x-ref":"#/components/parameters/username","index$":1}]},"DELETE /contacts/groups/{groupId}":{"protocol":"http","requestBody":{"required":true,"content":{"application/x-www-form-urlencoded":{"schema":{"properties":{"delete_contacts":{"type":"boolean","description":"Delete contacts assigned to this group"}},"x-ref":"#/components/schemas/DeleteGroup"}}}},"parameters":[{"name":"groupId","schema":{"type":"string","format":"oid","pattern":"[0-9a-fA-F]{24}","description":"Object ID","example":"0f0f0f0f0f0f0f0f0f0f0f0f","x-ref":"#/components/schemas/Id"},"in":"path","required":true,"description":"Group ID","x-ref":"#/components/parameters/groupId","index$":0}]},"DELETE /contacts/groups/{groupId}/members":{"protocol":"http","requestBody":{"required":true,"content":{"application/x-www-form-urlencoded":{"schema":{"properties":{"q":{"type":"string","description":"Search text on standart fields"},"phone_number":{"type":"array","items":{"type":"string","pattern":"[0-9]{8,16}","x-ref":"#/components/schemas/ContactsPhoneNumber"},"description":"Search by phone_number"},"email":{"type":"array","items":{"type":"string","format":"email","example":"john.doe@example.com","x-ref":"#/components/schemas/EmailAddress"},"description":"Search by email"},"first_name":{"type":"array","items":{"type":"string","example":"John","x-ref":"#/components/schemas/ContactsFirstName"},"description":"Search by first name"},"last_name":{"type":"array","items":{"type":"string","example":"Doe","x-ref":"#/components/schemas/LastName"},"description":"Search by last name"},"group_id":{"type":"array","items":{"type":"string","format":"oid","pattern":"[0-9a-fA-F]{24}","description":"Object ID","example":"0f0f0f0f0f0f0f0f0f0f0f0f","x-ref":"#/components/schemas/Id"},"description":"Search by group"},"gender":{"type":"string","enum":["undefined","male","female"],"description":"Search by gender","x-ref":"#/components/schemas/Gender"},"birthday_date":{"type":"array","items":{"type":"string","format":"date","example":"2017-07-21","x-ref":"#/components/schemas/Date"},"description":"Search by birthday date"}},"x-ref":"#/components/schemas/UnpinContactFromGroupByQuery"}}}},"parameters":[{"name":"groupId","schema":{"type":"string","format":"oid","pattern":"[0-9a-fA-F]{24}","description":"Object ID","example":"0f0f0f0f0f0f0f0f0f0f0f0f","x-ref":"#/components/schemas/Id"},"in":"path","required":true,"description":"Group ID","x-ref":"#/components/parameters/groupId","index$":0}]},"DELETE /contacts/groups":{"protocol":"http","parameters":[]},"PUT /contacts/groups/{groupId}/permissions/{username}":{"protocol":"http","requestBody":{"required":true,"content":{"application/x-www-form-urlencoded":{"schema":{"properties":{"read":{"type":"boolean","default":false,"example":false,"description":"Has read permission","x-ref":"#/components/schemas/ReadPermission"},"write":{"type":"boolean","default":false,"example":false,"description":"Has write permission","x-ref":"#/components/schemas/WritePermission"},"send":{"type":"boolean","default":false,"example":false,"description":"Has send permission","x-ref":"#/components/schemas/SendPermission"}},"x-ref":"#/components/schemas/UpdateGroupPermission"}}}},"parameters":[{"name":"groupId","schema":{"type":"string","format":"oid","pattern":"[0-9a-fA-F]{24}","description":"Object ID","example":"0f0f0f0f0f0f0f0f0f0f0f0f","x-ref":"#/components/schemas/Id"},"in":"path","required":true,"description":"Group ID","x-ref":"#/components/parameters/groupId","index$":0},{"name":"username","schema":{"type":"string","example":"example_username","x-ref":"#/components/schemas/Username"},"required":true,"description":"Username","x-ref":"#/components/parameters/username","index$":1}]},"PUT /contacts/groups/{groupId}/members":{"protocol":"http","requestBody":{"required":true,"content":{"application/x-www-form-urlencoded":{"schema":{"properties":{"q":{"type":"string","description":"Search text on standart fields"},"phone_number":{"type":"array","items":{"type":"string","pattern":"[0-9]{8,16}","x-ref":"#/components/schemas/ContactsPhoneNumber"},"description":"Search by phone_number"},"email":{"type":"array","items":{"type":"string","format":"email","example":"john.doe@example.com","x-ref":"#/components/schemas/EmailAddress"},"description":"Search by email"},"first_name":{"type":"array","items":{"type":"string","example":"John","x-ref":"#/components/schemas/ContactsFirstName"},"description":"Search by first name"},"last_name":{"type":"array","items":{"type":"string","example":"Doe","x-ref":"#/components/schemas/LastName"},"description":"Search by last name"},"group_id":{"type":"array","items":{"type":"string","format":"oid","pattern":"[0-9a-fA-F]{24}","description":"Object ID","example":"0f0f0f0f0f0f0f0f0f0f0f0f","x-ref":"#/components/schemas/Id"},"description":"Search by group"},"gender":{"type":"string","enum":["undefined","male","female"],"description":"Search by gender","x-ref":"#/components/schemas/Gender"},"birthday_date":{"type":"array","items":{"type":"string","format":"date","example":"2017-07-21","x-ref":"#/components/schemas/Date"},"description":"Search by birthday date"}},"x-ref":"#/components/schemas/MoveContactToGroupByQuery"}}}},"parameters":[{"name":"groupId","schema":{"type":"string","format":"oid","pattern":"[0-9a-fA-F]{24}","description":"Object ID","example":"0f0f0f0f0f0f0f0f0f0f0f0f","x-ref":"#/components/schemas/Id"},"in":"path","required":true,"description":"Group ID","x-ref":"#/components/parameters/groupId","index$":0}]}})
    }
    const client = setup.client
    const struct = setup.struct

    const isempty = struct.isempty
    const select = struct.select


    // CREATE
    const contactsgroup_ref01_ent = client.Contactsgroup()
    let contactsgroup_ref01_data = setup.data.new.contactsgroup['contactsgroup_ref01']
    contactsgroup_ref01_data['group_id'] = setup.idmap['group01']

    contactsgroup_ref01_data = (await contactsgroup_ref01_ent.create(contactsgroup_ref01_data)).data()
    assert(null != contactsgroup_ref01_data.id)


    // LIST
    const contactsgroup_ref01_match: any = {}
    contactsgroup_ref01_match['group_id'] = setup.idmap['group01']

    const contactsgroup_ref01_list = (await contactsgroup_ref01_ent.list(contactsgroup_ref01_match)).map((e: any) => e.data())

    assert(!isempty(select(contactsgroup_ref01_list, { id: contactsgroup_ref01_data.id })))


    // UPDATE
    const contactsgroup_ref01_data_up0: any = {}
    contactsgroup_ref01_data_up0.id = contactsgroup_ref01_data.id

    const contactsgroup_ref01_markdef_up0 = { name: 'birthday_date', value: 'Mark01-contactsgroup_ref01_' + setup.now }
    ;(contactsgroup_ref01_data_up0 as any)[contactsgroup_ref01_markdef_up0.name] = contactsgroup_ref01_markdef_up0.value

    const contactsgroup_ref01_resdata_up0 = (await contactsgroup_ref01_ent.update(contactsgroup_ref01_data_up0)).data()
    assert(contactsgroup_ref01_resdata_up0.id === contactsgroup_ref01_data_up0.id)

    assert((contactsgroup_ref01_resdata_up0 as any)[contactsgroup_ref01_markdef_up0.name] === contactsgroup_ref01_markdef_up0.value)


    // REMOVE
    const contactsgroup_ref01_match_rm0: any = { id: contactsgroup_ref01_data.id }
    await contactsgroup_ref01_ent.remove(contactsgroup_ref01_match_rm0)
  

    // LIST
    const contactsgroup_ref01_match_rt0: any = {}
    contactsgroup_ref01_match_rt0['group_id'] = setup.idmap['group01']

    const contactsgroup_ref01_list_rt0 = (await contactsgroup_ref01_ent.list(contactsgroup_ref01_match_rt0)).map((e: any) => e.data())

    assert(isempty(select(contactsgroup_ref01_list_rt0, { id: contactsgroup_ref01_data.id })))


  })
})



function basicSetup(extra?: any) {
  // TODO: fix test def options
  const options: any = {} // null

  // TODO: needs test utility to resolve path
  const entityDataFile =
    Path.resolve(__dirname, 
      '../../../../.sdk/test/entity/contactsgroup/ContactsgroupTestData.json')

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
    ['contactsgroup01','contactsgroup02','contactsgroup03','group01','group02','group03','permission01','permission02','permission03'],
    {
      '`$PACK`': ['', {
        '`$KEY`': '`$COPY`',
        '`$VAL`': ['`$FORMAT`', 'upper', '`$COPY`']
      }]
    })

  const env = envOverride({
    'SMSAPI_TEST_CONTACTSGROUP_ENTID': idmap,
    'SMSAPI_TEST_LIVE': 'FALSE',
    'SMSAPI_TEST_EXPLAIN': 'FALSE',
    'SMSAPI_APIKEY': '',
  })

  idmap = env['SMSAPI_TEST_CONTACTSGROUP_ENTID']

  const live = 'TRUE' === env.SMSAPI_TEST_LIVE

  const transport = createLiveTransport()
  if (live) {
    const rawIds = process.env['SMSAPI_TEST_CONTACTSGROUP_ENTID']
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
  
