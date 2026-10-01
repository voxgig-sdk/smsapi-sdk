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
(0, node_test_1.describe)('SendernameEntity', async () => {
    // Per-test live pacing. Delay is read from sdk-test-control.json's
    // `test.live.delayMs`; only sleeps when SMSAPI_TEST_LIVE=TRUE.
    (0, node_test_1.afterEach)((0, utility_1.liveDelay)('SMSAPI_TEST_LIVE'));
    (0, node_test_1.test)('instance', async () => {
        const testsdk = __1.SmsapiSDK.test();
        const ent = testsdk.Sendername();
        (0, node_assert_1.default)(null != ent);
    });
    (0, node_test_1.test)('basic', async (t) => {
        const live = 'TRUE' === process.env.SMSAPI_TEST_LIVE;
        for (const op of ['create', 'list', 'load']) {
            if (!live && (0, utility_1.maybeSkipControl)(t, 'entityOp', 'sendername.' + op, live))
                return;
        }
        const setup = basicSetup();
        if (setup.live) {
            return (0, live_entity_1.runLiveEntity)(setup, { "active": true, "alias": { "field": {} }, "fields": { "created_at": { "a": true, "fo": "date-time", "h": "Created At", "n": "created_at", "r": false, "t": "`$STRING`", "key$": "created_at", "index$": 0 }, "id": { "a": true, "h": "Id", "n": "id", "r": false, "t": "`$STRING`", "key$": "id", "index$": 1 }, "is_default": { "a": true, "h": "Is Default", "n": "is_default", "r": false, "t": "`$BOOLEAN`", "key$": "is_default", "index$": 2 }, "sender": { "a": true, "h": "Sender", "n": "sender", "r": false, "sh": "Sendername", "t": "`$STRING`", "key$": "sender", "index$": 3 }, "status": { "a": true, "h": "Status", "n": "status", "r": false, "t": "`$STRING`", "key$": "status", "index$": 4 } }, "id": { "field": "id", "name": "id" }, "name": "sendername", "op": { "create": { "input": "data", "name": "create", "points": [{ "a": true, "co": { "id": "POST /sms/sendernames", "source": "openapi3", "version": 2 }, "g": {}, "k": "http", "m": "POST", "o": "/sms/sendernames", "q": {}, "r": {}, "s": [{ "lit": "sms" }, { "lit": "sendernames" }], "t": { "req": "`reqdata`", "res": "`body`" }, "index$": 0 }], "key$": "create" }, "list": { "input": "data", "name": "list", "points": [{ "a": true, "co": { "id": "GET /sms/sendernames", "source": "openapi3", "version": 2 }, "g": {}, "k": "http", "m": "GET", "o": "/sms/sendernames", "q": {}, "r": {}, "s": [{ "lit": "sms" }, { "lit": "sendernames" }], "t": { "req": "`reqdata`", "res": "`body.collection`" }, "index$": 0 }], "key$": "list" }, "load": { "input": "data", "name": "load", "points": [{ "a": true, "co": { "id": "GET /sms/sendernames/{sender}", "source": "openapi3", "version": 2 }, "g": { "params": [{ "a": true, "k": "param", "n": "id", "or": "sender", "r": true, "t": "`$STRING`", "index$": 0 }] }, "k": "http", "m": "GET", "o": "/sms/sendernames/{sender}", "q": { "exist": ["id"] }, "r": { "param": { "sender": "id" } }, "s": [{ "lit": "sms" }, { "lit": "sendernames" }, { "var": "id" }], "t": { "req": "`reqdata`", "res": "`body`" }, "index$": 0 }], "key$": "load" } }, "relations": { "ancestors": [] }, "key$": "sendername", "name__orig": "sendername", "Name": "Sendername", "name_": "sendername", "name-": "sendername", "NAME": "SENDERNAME", "index$": 17 }, { "active": true, "entity": "sendername", "key$": "BasicSendernameFlow", "kind": "basic", "name": "BasicSendernameFlow", "param": {}, "step": [{ "a": true, "d": {}, "i": { "ref": "sendername_ref01" }, "m": {}, "o": "create", "s": [], "v": [], "index$": 0 }, { "a": true, "d": {}, "i": {}, "m": {}, "o": "list", "s": [], "v": [{ "apply": "ItemExists", "def": { "ref": "sendername_ref01" } }], "index$": 1 }, { "a": true, "d": {}, "i": { "ref": "sendername_ref01", "srcdatavar": "sendername_ref01_data", "suffix": "_dt0" }, "m": { "id": "sendername01" }, "o": "load", "s": [], "v": [{ "apply": "TextFieldMark", "def": { "mark": "Mark01-sendername_ref01" } }], "index$": 2 }] }, 'Sendername', { "POST /sms/sendernames": { "protocol": "http", "requestBody": { "required": true, "content": { "application/x-www-form-urlencoded": { "schema": { "type": "object", "properties": { "sender": { "type": "string", "pattern": "^[0-9]{8,16}|[\\w.\\-&@ %!+]{0,11}$", "description": "Sendername", "x-ref": "#/components/schemas/Sender" } }, "required": ["sender"], "x-ref": "#/components/schemas/CreateSendername" } } } }, "parameters": [] }, "GET /sms/sendernames": { "protocol": "http", "parameters": [] }, "GET /sms/sendernames/{sender}": { "protocol": "http", "parameters": [{ "name": "sender", "in": "path", "schema": { "type": "string", "pattern": "^[0-9]{8,16}|[\\w.\\-&@ %!+]{0,11}$", "description": "Sendername", "x-ref": "#/components/schemas/Sender" }, "required": true, "x-ref": "#/components/parameters/Sender", "index$": 0 }] } });
        }
        const client = setup.client;
        const struct = setup.struct;
        const isempty = struct.isempty;
        const select = struct.select;
        // CREATE
        const sendername_ref01_ent = client.Sendername();
        let sendername_ref01_data = setup.data.new.sendername['sendername_ref01'];
        sendername_ref01_data = (await sendername_ref01_ent.create(sendername_ref01_data)).data();
        (0, node_assert_1.default)(null != sendername_ref01_data.id);
        // LIST
        const sendername_ref01_match = {};
        const sendername_ref01_list = (await sendername_ref01_ent.list(sendername_ref01_match)).map((e) => e.data());
        (0, node_assert_1.default)(!isempty(select(sendername_ref01_list, { id: sendername_ref01_data.id })));
        // LOAD
        const sendername_ref01_match_dt0 = {};
        sendername_ref01_match_dt0.id = sendername_ref01_data.id;
        const sendername_ref01_data_dt0 = (await sendername_ref01_ent.load(sendername_ref01_match_dt0)).data();
        (0, node_assert_1.default)(sendername_ref01_data_dt0.id === sendername_ref01_data.id);
    });
});
function basicSetup(extra) {
    // TODO: fix test def options
    const options = {}; // null
    // TODO: needs test utility to resolve path
    const entityDataFile = node_path_1.default.resolve(__dirname, '../../../../.sdk/test/entity/sendername/SendernameTestData.json');
    // TODO: file ready util needed?
    const entityDataSource = Fs.readFileSync(entityDataFile).toString('utf8');
    // TODO: need a xlang JSON parse utility in voxgig/struct with better error msgs
    const entityData = JSON.parse(entityDataSource);
    options.entity = entityData.existing;
    let client = __1.SmsapiSDK.test(options, extra);
    const struct = client.utility().struct;
    const merge = struct.merge;
    const transform = struct.transform;
    let idmap = transform(['sendername01', 'sendername02', 'sendername03'], {
        '`$PACK`': ['', {
                '`$KEY`': '`$COPY`',
                '`$VAL`': ['`$FORMAT`', 'upper', '`$COPY`']
            }]
    });
    const env = (0, utility_1.envOverride)({
        'SMSAPI_TEST_SENDERNAME_ENTID': idmap,
        'SMSAPI_TEST_LIVE': 'FALSE',
        'SMSAPI_TEST_EXPLAIN': 'FALSE',
        'SMSAPI_APIKEY': '',
    });
    idmap = env['SMSAPI_TEST_SENDERNAME_ENTID'];
    const live = 'TRUE' === env.SMSAPI_TEST_LIVE;
    const transport = (0, live_runner_1.createLiveTransport)();
    if (live) {
        const rawIds = process.env['SMSAPI_TEST_SENDERNAME_ENTID'];
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
//# sourceMappingURL=SendernameEntity.test.js.map