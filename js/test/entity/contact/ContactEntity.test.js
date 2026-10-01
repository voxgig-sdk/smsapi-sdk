
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


describe('ContactEntity', async () => {

  // Per-test live pacing. Delay is read from sdk-test-control.json's
  // `test.live.delayMs`; only sleeps when SMSAPI_TEST_LIVE=TRUE.
  afterEach(liveDelay('SMSAPI_TEST_LIVE'))

  test('instance', async () => {
    const testsdk = SmsapiSDK.test()
    const ent = testsdk.Contact()
    assert(null != ent)
  })


  test('basic', async (t) => {

    
    const setup = basicSetup()
    if (setup.live) {
      return runLiveEntity(setup, {"active":true,"alias":{"field":{}},"fields":{"birthday_date":{"a":true,"fo":"date","h":"Birthday Date","n":"birthday_date","r":false,"t":"`$STRING`","key$":"birthday_date","index$":0},"city":{"a":true,"h":"City","n":"city","r":false,"t":"`$STRING`","key$":"city","index$":1},"collection":{"a":true,"h":"Collection","n":"collection","op":{"update":{"req":false,"type":"`$ARRAY`"}},"r":true,"t":"`$ARRAY`","key$":"collection","index$":2},"contact_expire_after":{"a":true,"h":"Contact Expire After","n":"contact_expire_after","r":true,"sh":"Contact expire after days","t":"`$INTEGER`","key$":"contact_expire_after","index$":3},"contacts_count":{"a":true,"h":"Contacts Count","n":"contacts_count","op":{"list":{"req":false,"type":"`$INTEGER`"}},"r":true,"t":"`$INTEGER`","key$":"contacts_count","index$":4},"country":{"a":true,"h":"Country","n":"country","r":false,"t":"`$STRING`","key$":"country","index$":5},"created_by":{"a":true,"h":"Created By","n":"created_by","r":true,"t":"`$STRING`","key$":"created_by","index$":6},"date_created":{"a":true,"fo":"date-time","h":"Date Created","n":"date_created","r":true,"t":"`$STRING`","key$":"date_created","index$":7},"date_updated":{"a":true,"fo":"date-time","h":"Date Updated","n":"date_updated","r":true,"t":"`$STRING`","key$":"date_updated","index$":8},"description":{"a":true,"h":"Description","n":"description","op":{"load":{"req":true,"type":"`$STRING`"}},"r":false,"t":"`$STRING`","key$":"description","index$":9},"email":{"a":true,"fo":"email","h":"Email","n":"email","r":false,"t":"`$STRING`","key$":"email","index$":10},"first_name":{"a":true,"h":"First Name","n":"first_name","r":false,"t":"`$STRING`","key$":"first_name","index$":11},"gender":{"a":true,"h":"Gender","n":"gender","r":true,"t":"`$STRING`","key$":"gender","index$":12},"group_id":{"a":true,"fo":"oid","h":"Group Id","n":"group_id","r":false,"sh":"Object ID","t":"`$STRING`","key$":"group_id","index$":13},"groups":{"a":true,"h":"Groups","n":"groups","r":true,"t":"`$ARRAY`","key$":"groups","index$":14},"id":{"a":true,"fo":"oid","h":"Id","n":"id","r":true,"sh":"Object ID","t":"`$STRING`","key$":"id","index$":15},"idx":{"a":true,"h":"Idx","n":"idx","r":false,"sh":"User provided resource id","t":"`$STRING`","key$":"idx","index$":16},"last_name":{"a":true,"h":"Last Name","n":"last_name","r":false,"t":"`$STRING`","key$":"last_name","index$":17},"name":{"a":true,"h":"Name","n":"name","op":{"list":{"req":false,"type":"`$STRING`"}},"r":true,"sh":"Group name","t":"`$STRING`","key$":"name","index$":18},"permissions":{"a":true,"h":"Permissions","n":"permissions","r":false,"t":"`$ARRAY`","key$":"permissions","index$":19},"phone_number":{"a":true,"h":"Phone Number","n":"phone_number","r":false,"t":"`$STRING`","key$":"phone_number","index$":20},"read":{"a":true,"h":"Read","n":"read","r":false,"sh":"Has read permission","t":"`$BOOLEAN`","key$":"read","index$":21},"send":{"a":true,"h":"Send","n":"send","r":false,"sh":"Has send permission","t":"`$BOOLEAN`","key$":"send","index$":22},"size":{"a":true,"h":"Size","n":"size","r":true,"t":"`$INTEGER`","key$":"size","index$":23},"source":{"a":true,"h":"Source","n":"source","r":false,"t":"`$STRING`","key$":"source","index$":24},"type":{"a":true,"h":"Type","n":"type","r":false,"t":"`$STRING`","key$":"type","index$":25},"username":{"a":true,"h":"Username","n":"username","r":false,"t":"`$STRING`","key$":"username","index$":26},"value":{"a":true,"h":"Value","n":"value","r":false,"t":"`$STRING`","key$":"value","index$":27},"write":{"a":true,"h":"Write","n":"write","r":false,"sh":"Has write permission","t":"`$BOOLEAN`","key$":"write","index$":28}},"id":{"field":"id","name":"id"},"name":"contact","op":{"create":{"input":"data","name":"create","points":[{"a":true,"co":{"id":"POST /contacts/{contactId}/groups","source":"openapi3","version":2},"g":{"params":[{"a":true,"ex":"0f0f0f0f0f0f0f0f0f0f0f0f","k":"param","n":"id","or":"contactId","r":true,"t":"`$STRING`","index$":0}]},"k":"http","m":"POST","o":"/contacts/{contactId}/groups","q":{"$action":"group","exist":["id"]},"r":{"param":{"contactId":"id"}},"s":[{"lit":"contacts"},{"var":"id"},{"lit":"groups"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":0},{"a":true,"co":{"id":"POST /contacts","source":"openapi3","version":2},"g":{},"k":"http","m":"POST","o":"/contacts","q":{},"r":{},"s":[{"lit":"contacts"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":1}],"key$":"create"},"list":{"input":"data","name":"list","points":[{"a":true,"co":{"id":"GET /contacts","source":"openapi3","version":2},"g":{"query":[{"a":true,"ex":"2022-06-24","k":"query","n":"birthday_date","or":"birthday_date","r":false,"t":"`$ARRAY`","index$":0},{"a":true,"k":"query","n":"email","or":"email","r":false,"t":"`$ARRAY`","index$":1},{"a":true,"k":"query","n":"first_name","or":"first_name","r":false,"t":"`$ARRAY`","index$":2},{"a":true,"k":"query","n":"gender","or":"gender","r":false,"t":"`$STRING`","index$":3},{"a":true,"k":"query","n":"group_id","or":"group_id","r":false,"t":"`$ARRAY`","index$":4},{"a":true,"k":"query","n":"last_name","or":"last_name","r":false,"t":"`$ARRAY`","index$":5},{"a":true,"ex":5,"k":"query","n":"limit","or":"limit","r":false,"t":"`$INTEGER`","index$":6},{"a":true,"ex":0,"k":"query","n":"offset","or":"offset","r":false,"t":"`$INTEGER`","index$":7},{"a":true,"k":"query","n":"order_by","or":"order_by","r":false,"t":"`$STRING`","index$":8},{"a":true,"k":"query","n":"phone_number","or":"phone_number","r":false,"t":"`$ARRAY`","index$":9},{"a":true,"k":"query","n":"q","or":"q","r":false,"t":"`$STRING`","index$":10}]},"k":"http","m":"GET","o":"/contacts","q":{"exist":["birthday_date","email","first_name","gender","group_id","last_name","limit","offset","order_by","phone_number","q"]},"r":{},"s":[{"lit":"contacts"}],"t":{"req":"`reqdata`","res":"`body.collection`"},"index$":0},{"a":true,"co":{"id":"GET /contacts/{contactId}/groups","source":"openapi3","version":2},"g":{"params":[{"a":true,"ex":"0f0f0f0f0f0f0f0f0f0f0f0f","k":"param","n":"id","or":"contactId","r":true,"t":"`$STRING`","index$":0}]},"k":"http","m":"GET","o":"/contacts/{contactId}/groups","q":{"$action":"group","exist":["id"]},"r":{"param":{"contactId":"id"}},"s":[{"lit":"contacts"},{"var":"id"},{"lit":"groups"}],"t":{"req":"`reqdata`","res":"`body.collection`"},"index$":1}],"key$":"list"},"load":{"input":"data","name":"load","points":[{"a":true,"co":{"id":"GET /contacts/groups/{groupId}/members/{contactId}","source":"openapi3","version":2},"g":{"params":[{"a":true,"ex":"0f0f0f0f0f0f0f0f0f0f0f0f","k":"param","n":"contact_id","or":"contactId","r":true,"t":"`$STRING`","index$":0},{"a":true,"ex":"0f0f0f0f0f0f0f0f0f0f0f0f","k":"param","n":"group_id","or":"groupId","r":true,"t":"`$STRING`","index$":1}]},"k":"http","m":"GET","o":"/contacts/groups/{groupId}/members/{contactId}","q":{"exist":["contact_id","group_id"]},"r":{"param":{"contactId":"contact_id","groupId":"group_id"}},"s":[{"lit":"contacts"},{"lit":"groups"},{"var":"group_id"},{"lit":"members"},{"var":"contact_id"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":0},{"a":true,"co":{"id":"GET /contacts/{contactId}/groups/{groupId}","source":"openapi3","version":2},"g":{"params":[{"a":true,"ex":"0f0f0f0f0f0f0f0f0f0f0f0f","k":"param","n":"group_id","or":"groupId","r":true,"t":"`$STRING`","index$":0},{"a":true,"ex":"0f0f0f0f0f0f0f0f0f0f0f0f","k":"param","n":"id","or":"contactId","r":true,"t":"`$STRING`","index$":1}]},"k":"http","m":"GET","o":"/contacts/{contactId}/groups/{groupId}","q":{"exist":["group_id","id"]},"r":{"param":{"contactId":"id","groupId":"group_id"}},"s":[{"lit":"contacts"},{"var":"id"},{"lit":"groups"},{"var":"group_id"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":1},{"a":true,"co":{"id":"GET /contacts/{contactId}","source":"openapi3","version":2},"g":{"params":[{"a":true,"ex":"0f0f0f0f0f0f0f0f0f0f0f0f","k":"param","n":"id","or":"contactId","r":true,"t":"`$STRING`","index$":0}]},"k":"http","m":"GET","o":"/contacts/{contactId}","q":{"exist":["id"]},"r":{"param":{"contactId":"id"}},"s":[{"lit":"contacts"},{"var":"id"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":0}],"key$":"load"},"remove":{"input":"data","name":"remove","points":[{"a":true,"co":{"id":"DELETE /contacts/{contactId}/groups/{groupId}","source":"openapi3","version":2},"g":{"params":[{"a":true,"ex":"0f0f0f0f0f0f0f0f0f0f0f0f","k":"param","n":"group_id","or":"groupId","r":true,"t":"`$STRING`","index$":0},{"a":true,"ex":"0f0f0f0f0f0f0f0f0f0f0f0f","k":"param","n":"id","or":"contactId","r":true,"t":"`$STRING`","index$":1}]},"k":"http","m":"DELETE","o":"/contacts/{contactId}/groups/{groupId}","q":{"exist":["group_id","id"]},"r":{"param":{"contactId":"id","groupId":"group_id"}},"s":[{"lit":"contacts"},{"var":"id"},{"lit":"groups"},{"var":"group_id"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":0},{"a":true,"co":{"id":"DELETE /contacts/{contactId}","source":"openapi3","version":2},"g":{"params":[{"a":true,"ex":"0f0f0f0f0f0f0f0f0f0f0f0f","k":"param","n":"id","or":"contactId","r":true,"t":"`$STRING`","index$":0}]},"k":"http","m":"DELETE","o":"/contacts/{contactId}","q":{"exist":["id"]},"r":{"param":{"contactId":"id"}},"s":[{"lit":"contacts"},{"var":"id"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":0},{"a":true,"co":{"id":"DELETE /contacts","source":"openapi3","version":2},"g":{},"k":"http","m":"DELETE","o":"/contacts","q":{},"r":{},"s":[{"lit":"contacts"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":2}],"key$":"remove"},"update":{"input":"data","name":"update","points":[{"a":true,"co":{"id":"PUT /contacts/groups/{groupId}/members/{contactId}","source":"openapi3","version":2},"g":{"params":[{"a":true,"ex":"0f0f0f0f0f0f0f0f0f0f0f0f","k":"param","n":"contact_id","or":"contactId","r":true,"t":"`$STRING`","index$":0},{"a":true,"ex":"0f0f0f0f0f0f0f0f0f0f0f0f","k":"param","n":"group_id","or":"groupId","r":true,"t":"`$STRING`","index$":1}]},"k":"http","m":"PUT","o":"/contacts/groups/{groupId}/members/{contactId}","q":{"exist":["contact_id","group_id"]},"r":{"param":{"contactId":"contact_id","groupId":"group_id"}},"s":[{"lit":"contacts"},{"lit":"groups"},{"var":"group_id"},{"lit":"members"},{"var":"contact_id"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":0},{"a":true,"co":{"id":"PUT /contacts/{contactId}/groups/{groupId}","source":"openapi3","version":2},"g":{"params":[{"a":true,"ex":"0f0f0f0f0f0f0f0f0f0f0f0f","k":"param","n":"group_id","or":"groupId","r":true,"t":"`$STRING`","index$":0},{"a":true,"ex":"0f0f0f0f0f0f0f0f0f0f0f0f","k":"param","n":"id","or":"contactId","r":true,"t":"`$STRING`","index$":1}]},"k":"http","m":"PUT","o":"/contacts/{contactId}/groups/{groupId}","q":{"exist":["group_id","id"]},"r":{"param":{"contactId":"id","groupId":"group_id"}},"s":[{"lit":"contacts"},{"var":"id"},{"lit":"groups"},{"var":"group_id"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":1},{"a":true,"co":{"id":"PUT /contacts/{contactId}","source":"openapi3","version":2},"g":{"params":[{"a":true,"ex":"0f0f0f0f0f0f0f0f0f0f0f0f","k":"param","n":"id","or":"contactId","r":true,"t":"`$STRING`","index$":0}]},"k":"http","m":"PUT","o":"/contacts/{contactId}","q":{"exist":["id"]},"r":{"param":{"contactId":"id"}},"s":[{"lit":"contacts"},{"var":"id"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":0}],"key$":"update"}},"relations":{"ancestors":[["$.main.kit.entity.group"],["$.main.kit.entity.group"]]},"key$":"contact","name__orig":"contact","Name":"Contact","name_":"contact","name-":"contact","NAME":"CONTACT","index$":3}, {"active":true,"entity":"contact","key$":"BasicContactFlow","kind":"basic","name":"BasicContactFlow","param":{},"step":[{"a":true,"d":{},"i":{"ref":"contact_ref01"},"m":{"group_id":"group01"},"o":"create","s":[],"v":[],"index$":0},{"a":true,"d":{},"i":{},"m":{"contact_id":"contact01"},"o":"list","s":[],"v":[{"apply":"ItemExists","def":{"ref":"contact_ref01"}}],"index$":1},{"a":true,"d":{},"i":{"ref":"contact_ref01","srcdatavar":"contact_ref01_data","suffix":"_up0","textfield":"birthday_date"},"m":{},"o":"update","s":[{"apply":"TextFieldMark","def":{"mark":"Mark01-contact_ref01"}}],"v":[],"index$":2},{"a":true,"d":{},"i":{"ref":"contact_ref01","srcdatavar":"contact_ref01_data","suffix":"_dt0"},"m":{"id":"contact01"},"o":"load","s":[],"v":[{"apply":"TextFieldMark","def":{"mark":"Mark01-contact_ref01"}}],"index$":3},{"a":true,"d":{},"i":{"ref":"contact_ref01","suffix":"_rm0"},"m":{},"o":"remove","s":[],"v":[],"index$":4},{"a":true,"d":{},"i":{"suffix":"_rt0"},"m":{"contact_id":"contact01"},"o":"list","s":[],"v":[{"apply":"ItemNotExists","def":{"ref":"contact_ref01"}}],"index$":5}]}, 'Contact', {"POST /contacts/{contactId}/groups":{"protocol":"http","requestBody":{"required":false,"content":{"application/x-www-form-urlencoded":{"schema":{"type":"object","additionalProperties":{"type":"string","format":"oid","pattern":"[0-9a-fA-F]{24}","description":"Group id","example":"0f0f0f0f0f0f0f0f0f0f0f0f","x-ref":"#/components/schemas/Id"},"example":{"1":"0f0f0f0f0f0f0f0f0f0f0f0f","2":"0f0f0f0f0f0f0f0f0f0f0f0f"}},"examples":{"assign_contact_to_groups":{"summary":"Assign contact to many groups at once"}}}}},"parameters":[{"name":"contactId","schema":{"type":"string","format":"oid","pattern":"[0-9a-fA-F]{24}","description":"Object ID","example":"0f0f0f0f0f0f0f0f0f0f0f0f","x-ref":"#/components/schemas/Id"},"in":"path","required":true,"description":"Contact ID","x-ref":"#/components/parameters/contactId","index$":0}]},"POST /contacts":{"protocol":"http","requestBody":{"required":true,"content":{"application/x-www-form-urlencoded":{"schema":{"required":["phone_number","email"],"properties":{"phone_number":{"type":"string","pattern":"[0-9]{8,16}","x-ref":"#/components/schemas/ContactsPhoneNumber"},"email":{"type":"string","format":"email","example":"john.doe@example.com","x-ref":"#/components/schemas/EmailAddress"},"first_name":{"type":"string","example":"John","x-ref":"#/components/schemas/ContactsFirstName"},"last_name":{"type":"string","example":"Doe","x-ref":"#/components/schemas/LastName"},"gender":{"type":"string","enum":["undefined","male","female"],"x-ref":"#/components/schemas/Gender"},"birthday_date":{"type":"string","format":"date","example":"2017-07-21","x-ref":"#/components/schemas/Date"},"description":{"type":"string","example":"Resource description","x-ref":"#/components/schemas/Description"},"city":{"type":"string","example":"Example City","x-ref":"#/components/schemas/City"},"country":{"type":"string","example":"Example Country","x-ref":"#/components/schemas/ContactsCountry"},"source":{"type":"string","example":"Example Source","x-ref":"#/components/schemas/Source"},"idx":{"type":"string","example":"example-user-provided-id-123","description":"User provided resource id","x-ref":"#/components/schemas/ContactsIdx"},"undelivered_messages":{"type":"string","format":"integer"},"device":{"type":"string"},"browser":{"type":"string"},"operating_system":{"type":"string"}},"x-ref":"#/components/schemas/CreateContact"}}}},"parameters":[]},"GET /contacts":{"protocol":"http","parameters":[{"name":"q","schema":{"type":"string"},"in":"query","required":false,"description":"Search text on standard fields (first name, last name, phone number, email, city)","index$":0},{"name":"offset","in":"query","required":false,"schema":{"type":"integer","default":0},"x-ref":"#/components/parameters/offset","index$":1},{"name":"limit","in":"query","required":false,"schema":{"type":"integer","default":5},"x-ref":"#/components/parameters/limit","index$":2},{"name":"order_by","schema":{"type":"string","enum":["first_name","last_name","date_updated","date_created"]},"in":"query","required":false,"index$":3},{"name":"phone_number","schema":{"type":"array","items":{"type":"string","pattern":"[0-9]{8,16}","x-ref":"#/components/schemas/ContactsPhoneNumber"}},"in":"query","required":false,"description":"Search by phone number(s)","x-ref":"#/components/parameters/phoneNumberQuery","index$":4},{"name":"email","schema":{"type":"array","items":{"type":"string","format":"email","example":"john.doe@example.com","x-ref":"#/components/schemas/EmailAddress"}},"in":"query","required":false,"description":"Search by email address(es)","x-ref":"#/components/parameters/emailAddressQuery","index$":5},{"name":"first_name","schema":{"type":"array","items":{"type":"string","example":"John","x-ref":"#/components/schemas/ContactsFirstName"}},"in":"query","required":false,"description":"Search by first name(s)","x-ref":"#/components/parameters/firstNameQuery","index$":6},{"name":"last_name","schema":{"type":"array","items":{"type":"string","example":"Doe","x-ref":"#/components/schemas/LastName"}},"in":"query","required":false,"description":"Search by last name(s)","x-ref":"#/components/parameters/lastNameQuery","index$":7},{"name":"group_id","schema":{"type":"array","items":{"type":"string"}},"in":"query","required":false,"description":"Search by group","index$":8},{"name":"gender","schema":{"type":"string","enum":["undefined","male","female"]},"in":"query","required":false,"description":"Search by gender","index$":9},{"name":"birthday_date","schema":{"type":"array","items":{"type":"string","format":"date","example":"2017-07-21","x-ref":"#/components/schemas/Date"}},"in":"query","required":false,"description":"Search by birthday date","examples":{"birthday_date_equals":{"value":"2022-06-24"},"birthday_date_less_than":{"value":"lt(2022-06-24)"},"birthday_date_less_than_or_equal":{"value":"lte(2022-06-24)"},"birthday_date_greater_than":{"value":"gt(2022-06-24)"},"birthday_date_greater_than_or_equal":{"value":"gte(2022-06-24)"},"birthday_date_between":{"value":"between(2022-06-24, 2022-06-25)"}},"index$":10}]},"GET /contacts/{contactId}/groups":{"protocol":"http","parameters":[{"name":"contactId","schema":{"type":"string","format":"oid","pattern":"[0-9a-fA-F]{24}","description":"Object ID","example":"0f0f0f0f0f0f0f0f0f0f0f0f","x-ref":"#/components/schemas/Id"},"in":"path","required":true,"description":"Contact ID","x-ref":"#/components/parameters/contactId","index$":0}]},"GET /contacts/groups/{groupId}/members/{contactId}":{"protocol":"http","parameters":[{"name":"groupId","schema":{"type":"string","format":"oid","pattern":"[0-9a-fA-F]{24}","description":"Object ID","example":"0f0f0f0f0f0f0f0f0f0f0f0f","x-ref":"#/components/schemas/Id"},"in":"path","required":true,"description":"Group ID","x-ref":"#/components/parameters/groupId","index$":0},{"name":"contactId","schema":{"type":"string","format":"oid","pattern":"[0-9a-fA-F]{24}","description":"Object ID","example":"0f0f0f0f0f0f0f0f0f0f0f0f","x-ref":"#/components/schemas/Id"},"in":"path","required":true,"description":"Contact ID","x-ref":"#/components/parameters/contactId","index$":1}]},"GET /contacts/{contactId}/groups/{groupId}":{"protocol":"http","parameters":[{"name":"contactId","schema":{"type":"string","format":"oid","pattern":"[0-9a-fA-F]{24}","description":"Object ID","example":"0f0f0f0f0f0f0f0f0f0f0f0f","x-ref":"#/components/schemas/Id"},"in":"path","required":true,"description":"Contact ID","x-ref":"#/components/parameters/contactId","index$":0},{"name":"groupId","schema":{"type":"string","format":"oid","pattern":"[0-9a-fA-F]{24}","description":"Object ID","example":"0f0f0f0f0f0f0f0f0f0f0f0f","x-ref":"#/components/schemas/Id"},"in":"path","required":true,"description":"Group ID","x-ref":"#/components/parameters/groupId","index$":1}]},"GET /contacts/{contactId}":{"protocol":"http","parameters":[{"name":"contactId","schema":{"type":"string","format":"oid","pattern":"[0-9a-fA-F]{24}","description":"Object ID","example":"0f0f0f0f0f0f0f0f0f0f0f0f","x-ref":"#/components/schemas/Id"},"in":"path","required":true,"description":"Contact ID","x-ref":"#/components/parameters/contactId","index$":0}]},"DELETE /contacts/{contactId}/groups/{groupId}":{"protocol":"http","parameters":[{"name":"contactId","schema":{"type":"string","format":"oid","pattern":"[0-9a-fA-F]{24}","description":"Object ID","example":"0f0f0f0f0f0f0f0f0f0f0f0f","x-ref":"#/components/schemas/Id"},"in":"path","required":true,"description":"Contact ID","x-ref":"#/components/parameters/contactId","index$":0},{"name":"groupId","schema":{"type":"string","format":"oid","pattern":"[0-9a-fA-F]{24}","description":"Object ID","example":"0f0f0f0f0f0f0f0f0f0f0f0f","x-ref":"#/components/schemas/Id"},"in":"path","required":true,"description":"Group ID","x-ref":"#/components/parameters/groupId","index$":1}]},"DELETE /contacts/{contactId}":{"protocol":"http","parameters":[{"name":"contactId","schema":{"type":"string","format":"oid","pattern":"[0-9a-fA-F]{24}","description":"Object ID","example":"0f0f0f0f0f0f0f0f0f0f0f0f","x-ref":"#/components/schemas/Id"},"in":"path","required":true,"description":"Contact ID","x-ref":"#/components/parameters/contactId","index$":0}]},"DELETE /contacts":{"protocol":"http","parameters":[]},"PUT /contacts/groups/{groupId}/members/{contactId}":{"protocol":"http","parameters":[{"name":"groupId","schema":{"type":"string","format":"oid","pattern":"[0-9a-fA-F]{24}","description":"Object ID","example":"0f0f0f0f0f0f0f0f0f0f0f0f","x-ref":"#/components/schemas/Id"},"in":"path","required":true,"description":"Group ID","x-ref":"#/components/parameters/groupId","index$":0},{"name":"contactId","schema":{"type":"string","format":"oid","pattern":"[0-9a-fA-F]{24}","description":"Object ID","example":"0f0f0f0f0f0f0f0f0f0f0f0f","x-ref":"#/components/schemas/Id"},"in":"path","required":true,"description":"Contact ID","x-ref":"#/components/parameters/contactId","index$":1}]},"PUT /contacts/{contactId}/groups/{groupId}":{"protocol":"http","parameters":[{"name":"contactId","schema":{"type":"string","format":"oid","pattern":"[0-9a-fA-F]{24}","description":"Object ID","example":"0f0f0f0f0f0f0f0f0f0f0f0f","x-ref":"#/components/schemas/Id"},"in":"path","required":true,"description":"Contact ID","x-ref":"#/components/parameters/contactId","index$":0},{"name":"groupId","schema":{"type":"string","format":"oid","pattern":"[0-9a-fA-F]{24}","description":"Object ID","example":"0f0f0f0f0f0f0f0f0f0f0f0f","x-ref":"#/components/schemas/Id"},"in":"path","required":true,"description":"Group ID","x-ref":"#/components/parameters/groupId","index$":1}]},"PUT /contacts/{contactId}":{"protocol":"http","requestBody":{"required":true,"content":{"application/x-www-form-urlencoded":{"schema":{"properties":{"phone_number":{"type":"string","pattern":"[0-9]{8,16}","x-ref":"#/components/schemas/ContactsPhoneNumber"},"email":{"type":"string","format":"email","example":"john.doe@example.com","x-ref":"#/components/schemas/EmailAddress"},"first_name":{"type":"string","example":"John","x-ref":"#/components/schemas/ContactsFirstName"},"last_name":{"type":"string","example":"Doe","x-ref":"#/components/schemas/LastName"},"gender":{"type":"string","enum":["undefined","male","female"],"x-ref":"#/components/schemas/Gender"},"birthday_date":{"type":"string","format":"date","example":"2017-07-21","x-ref":"#/components/schemas/Date"},"description":{"type":"string","example":"Resource description","x-ref":"#/components/schemas/Description"},"city":{"type":"string","example":"Example City","x-ref":"#/components/schemas/City"},"source":{"type":"string","example":"Example Source","x-ref":"#/components/schemas/Source"}},"x-ref":"#/components/schemas/UpdateContact"}}}},"parameters":[{"name":"contactId","schema":{"type":"string","format":"oid","pattern":"[0-9a-fA-F]{24}","description":"Object ID","example":"0f0f0f0f0f0f0f0f0f0f0f0f","x-ref":"#/components/schemas/Id"},"in":"path","required":true,"description":"Contact ID","x-ref":"#/components/parameters/contactId","index$":0}]}})
    }
    const client = setup.client
    const struct = setup.struct

    const isempty = struct.isempty
    const select = struct.select


    // CREATE
    const contact_ref01_ent = client.Contact()
    let contact_ref01_data = setup.data.new.contact['contact_ref01']
    contact_ref01_data['group_id'] = setup.idmap['group01']

    contact_ref01_data = (await contact_ref01_ent.create(contact_ref01_data)).data()
    assert(null != contact_ref01_data.id)


    // LIST
    const contact_ref01_match = {}
    contact_ref01_match['contact_id'] = setup.idmap['contact01']

    const contact_ref01_list = (await contact_ref01_ent.list(contact_ref01_match)).map((e) => e.data())

    assert(!isempty(select(contact_ref01_list, { id: contact_ref01_data.id })))


    // UPDATE
    const contact_ref01_data_up0 = {}
    contact_ref01_data_up0.id = contact_ref01_data.id

    const contact_ref01_markdef_up0 = { name: 'birthday_date', value: 'Mark01-contact_ref01_' + setup.now }
    contact_ref01_data_up0 [contact_ref01_markdef_up0.name] = contact_ref01_markdef_up0.value

    const contact_ref01_resdata_up0 = (await contact_ref01_ent.update(contact_ref01_data_up0)).data()
    assert(contact_ref01_resdata_up0.id === contact_ref01_data_up0.id)

    assert(contact_ref01_resdata_up0[contact_ref01_markdef_up0.name] === contact_ref01_markdef_up0.value)


    // LOAD
    const contact_ref01_match_dt0 = {}
    contact_ref01_match_dt0.id = contact_ref01_data.id
    const contact_ref01_data_dt0 = (await contact_ref01_ent.load(contact_ref01_match_dt0)).data()
    assert(contact_ref01_data_dt0.id === contact_ref01_data.id)


    // REMOVE
    const contact_ref01_match_rm0 = {}
    contact_ref01_match_rm0.id = contact_ref01_data.id
    await contact_ref01_ent.remove(contact_ref01_match_rm0)
  

    // LIST
    const contact_ref01_match_rt0 = {}
    contact_ref01_match_rt0['contact_id'] = setup.idmap['contact01']

    const contact_ref01_list_rt0 = (await contact_ref01_ent.list(contact_ref01_match_rt0)).map((e) => e.data())

    assert(isempty(select(contact_ref01_list_rt0, { id: contact_ref01_data.id })))


  })
})



function basicSetup(extra) {
  // TODO: fix test def options
  const options = {} // null

  // TODO: needs test utility to resolve path
  const entityDataFile =
    Path.resolve(__dirname,
      '../../../../.sdk/test/entity/contact/ContactTestData.json')

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
    ['contact01','contact02','contact03','group01','group02','group03'],
    {
      '`$PACK`': ['', {
        '`$KEY`': '`$COPY`',
        '`$VAL`': ['`$FORMAT`', 'upper', '`$COPY`']
      }]
    })

  const env = envOverride({
    'SMSAPI_TEST_CONTACT_ENTID': idmap,
    'SMSAPI_TEST_LIVE': 'FALSE',
    'SMSAPI_TEST_EXPLAIN': 'FALSE',
    'SMSAPI_APIKEY': '',
  })

  idmap = env['SMSAPI_TEST_CONTACT_ENTID']

  const live = 'TRUE' === env.SMSAPI_TEST_LIVE
  const transport = createLiveTransport()
  if (live) {
    const rawIds = process.env['SMSAPI_TEST_CONTACT_ENTID']
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
  
