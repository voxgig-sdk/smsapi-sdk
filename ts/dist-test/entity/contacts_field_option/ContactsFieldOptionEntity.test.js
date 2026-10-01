"use strict";
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    var desc = Object.getOwnPropertyDescriptor(m, k);
    if (!desc || ("get" in desc ? !m.__esModule : desc.writable || desc.configurable)) {
      desc = { enumerable: true, get: function() { return m[k]; } };
    }
    Object.defineProperty(o, k2, desc);
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || (function () {
    var ownKeys = function(o) {
        ownKeys = Object.getOwnPropertyNames || function (o) {
            var ar = [];
            for (var k in o) if (Object.prototype.hasOwnProperty.call(o, k)) ar[ar.length] = k;
            return ar;
        };
        return ownKeys(o);
    };
    return function (mod) {
        if (mod && mod.__esModule) return mod;
        var result = {};
        if (mod != null) for (var k = ownKeys(mod), i = 0; i < k.length; i++) if (k[i] !== "default") __createBinding(result, mod, k[i]);
        __setModuleDefault(result, mod);
        return result;
    };
})();
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const node_path_1 = __importDefault(require("node:path"));
const Fs = __importStar(require("node:fs"));
const node_test_1 = require("node:test");
const node_assert_1 = __importDefault(require("node:assert"));
const live_runner_1 = require("../../live-runner");
const live_entity_1 = require("../../live-entity");
const __1 = require("../../..");
const utility_1 = require("../../utility");
(0, utility_1.loadEnvLocal)(__dirname + '/../../../.env.local');
(0, node_test_1.describe)('ContactsFieldOptionEntity', async () => {
    // Per-test live pacing. Delay is read from sdk-test-control.json's
    // `test.live.delayMs`; only sleeps when SMSAPI_TEST_LIVE=TRUE.
    (0, node_test_1.afterEach)((0, utility_1.liveDelay)('SMSAPI_TEST_LIVE'));
    (0, node_test_1.test)('instance', async () => {
        const testsdk = __1.SmsapiSDK.test();
        const ent = testsdk.ContactsFieldOption();
        (0, node_assert_1.default)(null != ent);
    });
    (0, node_test_1.test)('basic', async (t) => {
        const live = 'TRUE' === process.env.SMSAPI_TEST_LIVE;
        for (const op of ['list']) {
            if (!live && (0, utility_1.maybeSkipControl)(t, 'entityOp', 'contacts_field_option.' + op, live))
                return;
        }
        const setup = basicSetup();
        if (setup.live) {
            return (0, live_entity_1.runLiveEntity)(setup, { "active": true, "alias": { "field": {} }, "fields": { "birthday_date": { "a": true, "fo": "date", "h": "Birthday Date", "n": "birthday_date", "r": false, "t": "`$STRING`", "key$": "birthday_date", "index$": 0 }, "city": { "a": true, "h": "City", "n": "city", "r": false, "t": "`$STRING`", "key$": "city", "index$": 1 }, "contact_expire_after": { "a": true, "h": "Contact Expire After", "n": "contact_expire_after", "r": true, "sh": "Contact expire after days", "t": "`$INTEGER`", "key$": "contact_expire_after", "index$": 2 }, "contacts_count": { "a": true, "h": "Contacts Count", "n": "contacts_count", "r": false, "t": "`$INTEGER`", "key$": "contacts_count", "index$": 3 }, "country": { "a": true, "h": "Country", "n": "country", "r": false, "t": "`$STRING`", "key$": "country", "index$": 4 }, "created_by": { "a": true, "h": "Created By", "n": "created_by", "r": true, "t": "`$STRING`", "key$": "created_by", "index$": 5 }, "date_created": { "a": true, "fo": "date-time", "h": "Date Created", "n": "date_created", "r": true, "t": "`$STRING`", "key$": "date_created", "index$": 6 }, "date_updated": { "a": true, "fo": "date-time", "h": "Date Updated", "n": "date_updated", "r": true, "t": "`$STRING`", "key$": "date_updated", "index$": 7 }, "description": { "a": true, "h": "Description", "n": "description", "r": false, "t": "`$STRING`", "key$": "description", "index$": 8 }, "email": { "a": true, "fo": "email", "h": "Email", "n": "email", "r": false, "t": "`$STRING`", "key$": "email", "index$": 9 }, "first_name": { "a": true, "h": "First Name", "n": "first_name", "r": false, "t": "`$STRING`", "key$": "first_name", "index$": 10 }, "gender": { "a": true, "h": "Gender", "n": "gender", "r": true, "t": "`$STRING`", "key$": "gender", "index$": 11 }, "group_id": { "a": true, "fo": "oid", "h": "Group Id", "n": "group_id", "r": false, "sh": "Object ID", "t": "`$STRING`", "key$": "group_id", "index$": 12 }, "groups": { "a": true, "h": "Groups", "n": "groups", "r": true, "t": "`$ARRAY`", "key$": "groups", "index$": 13 }, "id": { "a": true, "fo": "oid", "h": "Id", "n": "id", "r": true, "sh": "Object ID", "t": "`$STRING`", "key$": "id", "index$": 14 }, "idx": { "a": true, "h": "Idx", "n": "idx", "r": false, "sh": "User provided resource id", "t": "`$STRING`", "key$": "idx", "index$": 15 }, "last_name": { "a": true, "h": "Last Name", "n": "last_name", "r": false, "t": "`$STRING`", "key$": "last_name", "index$": 16 }, "name": { "a": true, "h": "Name", "n": "name", "r": false, "sh": "Group name", "t": "`$STRING`", "key$": "name", "index$": 17 }, "permissions": { "a": true, "h": "Permissions", "n": "permissions", "r": false, "t": "`$ARRAY`", "key$": "permissions", "index$": 18 }, "phone_number": { "a": true, "h": "Phone Number", "n": "phone_number", "r": false, "t": "`$STRING`", "key$": "phone_number", "index$": 19 }, "read": { "a": true, "h": "Read", "n": "read", "r": false, "sh": "Has read permission", "t": "`$BOOLEAN`", "key$": "read", "index$": 20 }, "send": { "a": true, "h": "Send", "n": "send", "r": false, "sh": "Has send permission", "t": "`$BOOLEAN`", "key$": "send", "index$": 21 }, "source": { "a": true, "h": "Source", "n": "source", "r": false, "t": "`$STRING`", "key$": "source", "index$": 22 }, "type": { "a": true, "h": "Type", "n": "type", "r": false, "t": "`$STRING`", "key$": "type", "index$": 23 }, "username": { "a": true, "h": "Username", "n": "username", "r": false, "t": "`$STRING`", "key$": "username", "index$": 24 }, "value": { "a": true, "h": "Value", "n": "value", "r": false, "t": "`$STRING`", "key$": "value", "index$": 25 }, "write": { "a": true, "h": "Write", "n": "write", "r": false, "sh": "Has write permission", "t": "`$BOOLEAN`", "key$": "write", "index$": 26 } }, "id": { "field": "id", "name": "id" }, "name": "contacts_field_option", "op": { "list": { "input": "data", "name": "list", "points": [{ "a": true, "co": { "id": "GET /contacts/fields/{fieldId}/options", "source": "openapi3", "version": 2 }, "g": { "params": [{ "a": true, "ex": "0f0f0f0f0f0f0f0f0f0f0f0f", "k": "param", "n": "field_id", "or": "fieldId", "r": true, "t": "`$STRING`", "index$": 0 }] }, "k": "http", "m": "GET", "o": "/contacts/fields/{fieldId}/options", "q": { "exist": ["field_id"] }, "r": { "param": { "fieldId": "field_id" } }, "s": [{ "lit": "contacts" }, { "lit": "fields" }, { "var": "field_id" }, { "lit": "options" }], "t": { "req": "`reqdata`", "res": "`body.collection`" }, "index$": 0 }], "key$": "list" } }, "relations": { "ancestors": [] }, "key$": "contacts_field_option", "name__orig": "contacts_field_option", "Name": "ContactsFieldOption", "name_": "contacts_field_option", "name-": "contacts-field-option", "NAME": "CONTACTS_FIELD_OPTION", "index$": 5 }, { "active": true, "entity": "contacts_field_option", "key$": "BasicContactsFieldOptionFlow", "kind": "basic", "name": "BasicContactsFieldOptionFlow", "param": {}, "step": [{ "a": true, "d": {}, "i": {}, "m": { "field_id": "field01" }, "o": "list", "s": [], "v": [{ "apply": "ItemExists", "def": { "ref": "contacts_field_option_ref01" } }], "index$": 0 }] }, 'ContactsFieldOption', { "GET /contacts/fields/{fieldId}/options": { "protocol": "http", "parameters": [{ "name": "fieldId", "schema": { "type": "string", "format": "oid", "pattern": "[0-9a-fA-F]{24}", "description": "Object ID", "example": "0f0f0f0f0f0f0f0f0f0f0f0f", "x-ref": "#/components/schemas/Id" }, "in": "path", "required": true, "description": "Field ID", "x-ref": "#/components/parameters/fieldId", "index$": 0 }] } });
        }
        const client = setup.client;
        const struct = setup.struct;
        const isempty = struct.isempty;
        const select = struct.select;
        let contacts_field_option_ref01_data = Object.values(setup.data.existing.contacts_field_option)[0];
        // LIST
        const contacts_field_option_ref01_ent = client.ContactsFieldOption();
        const contacts_field_option_ref01_match = {};
        contacts_field_option_ref01_match['field_id'] = setup.idmap['field01'];
        const contacts_field_option_ref01_list = (await contacts_field_option_ref01_ent.list(contacts_field_option_ref01_match)).map((e) => e.data());
    });
});
function basicSetup(extra) {
    // TODO: fix test def options
    const options = {}; // null
    // TODO: needs test utility to resolve path
    const entityDataFile = node_path_1.default.resolve(__dirname, '../../../../.sdk/test/entity/contacts_field_option/ContactsFieldOptionTestData.json');
    // TODO: file ready util needed?
    const entityDataSource = Fs.readFileSync(entityDataFile).toString('utf8');
    // TODO: need a xlang JSON parse utility in voxgig/struct with better error msgs
    const entityData = JSON.parse(entityDataSource);
    options.entity = entityData.existing;
    let client = __1.SmsapiSDK.test(options, extra);
    const struct = client.utility().struct;
    const merge = struct.merge;
    const transform = struct.transform;
    let idmap = transform(['contacts_field_option01', 'contacts_field_option02', 'contacts_field_option03', 'field01'], {
        '`$PACK`': ['', {
                '`$KEY`': '`$COPY`',
                '`$VAL`': ['`$FORMAT`', 'upper', '`$COPY`']
            }]
    });
    const env = (0, utility_1.envOverride)({
        'SMSAPI_TEST_CONTACTS_FIELD_OPTION_ENTID': idmap,
        'SMSAPI_TEST_LIVE': 'FALSE',
        'SMSAPI_TEST_EXPLAIN': 'FALSE',
        'SMSAPI_APIKEY': '',
    });
    idmap = env['SMSAPI_TEST_CONTACTS_FIELD_OPTION_ENTID'];
    const live = 'TRUE' === env.SMSAPI_TEST_LIVE;
    const transport = (0, live_runner_1.createLiveTransport)();
    if (live) {
        const rawIds = process.env['SMSAPI_TEST_CONTACTS_FIELD_OPTION_ENTID'];
        idmap = rawIds && rawIds.trim() ? JSON.parse(rawIds) : {};
        if (!idmap || Array.isArray(idmap) || typeof idmap !== 'object') {
            throw new Error('Live ENTID must be a JSON object');
        }
        client = new __1.SmsapiSDK(merge([
            // FIRST, so the generated fields below win: sdk-test-control.json's
            // test.client.options adds to the live client, it does not redirect it.
            (0, utility_1.liveClientOptions)(),
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
        ]));
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
    };
    return setup;
}
//# sourceMappingURL=ContactsFieldOptionEntity.test.js.map