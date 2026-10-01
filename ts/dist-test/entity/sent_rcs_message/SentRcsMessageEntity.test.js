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
(0, node_test_1.describe)('SentRcsMessageEntity', async () => {
    // Per-test live pacing. Delay is read from sdk-test-control.json's
    // `test.live.delayMs`; only sleeps when SMSAPI_TEST_LIVE=TRUE.
    (0, node_test_1.afterEach)((0, utility_1.liveDelay)('SMSAPI_TEST_LIVE'));
    (0, node_test_1.test)('instance', async () => {
        const testsdk = __1.SmsapiSDK.test();
        const ent = testsdk.SentRcsMessage();
        (0, node_assert_1.default)(null != ent);
    });
    (0, node_test_1.test)('basic', async (t) => {
        const live = 'TRUE' === process.env.SMSAPI_TEST_LIVE;
        for (const op of ['create']) {
            if (!live && (0, utility_1.maybeSkipControl)(t, 'entityOp', 'sent_rcs_message.' + op, live))
                return;
        }
        const setup = basicSetup();
        if (setup.live) {
            return (0, live_entity_1.runLiveEntity)(setup, { "active": true, "alias": { "field": {} }, "fields": { "content": { "a": true, "h": "Content", "n": "content", "r": false, "sh": "RCS message content in RCS JSON format.", "t": "`$OBJECT`", "key$": "content", "index$": 0 }, "phone_number": { "a": true, "h": "Phone Number", "n": "phone_number", "r": true, "sh": "Recipient phone number (e.g.", "t": "`$STRING`", "key$": "phone_number", "index$": 1 }, "sender": { "a": true, "h": "Sender", "n": "sender", "r": true, "t": "`$ANY`", "key$": "sender", "index$": 2 }, "text": { "a": true, "h": "Text", "n": "text", "r": false, "sh": "Plain text message content.", "t": "`$STRING`", "key$": "text", "index$": 3 } }, "name": "sent_rcs_message", "op": { "create": { "input": "data", "name": "create", "points": [{ "a": true, "co": { "id": "POST /rcs/messages", "source": "openapi3", "version": 2 }, "g": {}, "k": "http", "m": "POST", "o": "/rcs/messages", "q": {}, "r": {}, "s": [{ "lit": "rcs" }, { "lit": "messages" }], "t": { "req": "`reqdata`", "res": "`body`" }, "index$": 0 }], "key$": "create" } }, "relations": { "ancestors": [] }, "key$": "sent_rcs_message", "name__orig": "sent_rcs_message", "Name": "SentRcsMessage", "name_": "sent_rcs_message", "name-": "sent-rcs-message", "NAME": "SENT_RCS_MESSAGE", "index$": 19 }, { "active": true, "entity": "sent_rcs_message", "key$": "BasicSentRcsMessageFlow", "kind": "basic", "name": "BasicSentRcsMessageFlow", "param": {}, "step": [{ "a": true, "d": {}, "i": { "ref": "sent_rcs_message_ref01" }, "m": {}, "o": "create", "s": [], "v": [], "index$": 0 }] }, 'SentRcsMessage', { "POST /rcs/messages": { "protocol": "http", "requestBody": { "required": true, "content": { "application/json": { "schema": { "type": "object", "required": ["phone_number", "sender"], "properties": { "phone_number": { "type": "string", "description": "Recipient phone number (e.g. 48123456789).", "example": "48123456789", "key$": "phone_number" }, "sender": { "allOf": [{ "type": "string", "format": "oid", "pattern": "[0-9a-fA-F]{24}", "description": "Object ID", "example": "0f0f0f0f0f0f0f0f0f0f0f0f", "x-ref": "#/components/schemas/Id" }, { "description": "RCS sender ID (object ID of the agent/sender the user has access to)." }], "key$": "sender" }, "text": { "type": "string", "maxLength": 3072, "description": "Plain text message content. Will be converted to RCS format. Either text or content must be provided.", "example": "Hello! This is a test RCS message.", "key$": "text" }, "content": { "type": "object", "description": "RCS message content in RCS JSON format. Either text or content must be provided.", "example": { "text": "Hello! This is a test RCS message." }, "key$": "content" } }, "x-ref": "#/components/schemas/SendRcsMessage", "index$": 1 } }, "application/x-www-form-urlencoded": { "schema": { "type": "object", "required": ["phone_number", "sender"], "properties": { "phone_number": { "type": "string", "description": "Recipient phone number (e.g. 48123456789).", "example": "48123456789", "key$": "phone_number" }, "sender": { "allOf": [{ "type": "string", "format": "oid", "pattern": "[0-9a-fA-F]{24}", "description": "Object ID", "example": "0f0f0f0f0f0f0f0f0f0f0f0f", "x-ref": "#/components/schemas/Id" }, { "description": "RCS sender ID (object ID of the agent/sender the user has access to)." }], "key$": "sender" }, "text": { "type": "string", "maxLength": 3072, "description": "Plain text message content. Will be converted to RCS format. Either text or content must be provided.", "example": "Hello! This is a test RCS message.", "key$": "text" }, "content": { "type": "object", "description": "RCS message content in RCS JSON format. Either text or content must be provided.", "example": { "text": "Hello! This is a test RCS message." }, "key$": "content" } }, "x-ref": "#/components/schemas/SendRcsMessage" } } } }, "parameters": [] } });
        }
        const client = setup.client;
        const struct = setup.struct;
        const isempty = struct.isempty;
        const select = struct.select;
        // CREATE
        const sent_rcs_message_ref01_ent = client.SentRcsMessage();
        let sent_rcs_message_ref01_data = setup.data.new.sent_rcs_message['sent_rcs_message_ref01'];
        sent_rcs_message_ref01_data = (await sent_rcs_message_ref01_ent.create(sent_rcs_message_ref01_data)).data();
        (0, node_assert_1.default)(null != sent_rcs_message_ref01_data);
    });
});
function basicSetup(extra) {
    // TODO: fix test def options
    const options = {}; // null
    // TODO: needs test utility to resolve path
    const entityDataFile = node_path_1.default.resolve(__dirname, '../../../../.sdk/test/entity/sent_rcs_message/SentRcsMessageTestData.json');
    // TODO: file ready util needed?
    const entityDataSource = Fs.readFileSync(entityDataFile).toString('utf8');
    // TODO: need a xlang JSON parse utility in voxgig/struct with better error msgs
    const entityData = JSON.parse(entityDataSource);
    options.entity = entityData.existing;
    let client = __1.SmsapiSDK.test(options, extra);
    const struct = client.utility().struct;
    const merge = struct.merge;
    const transform = struct.transform;
    let idmap = transform(['sent_rcs_message01', 'sent_rcs_message02', 'sent_rcs_message03'], {
        '`$PACK`': ['', {
                '`$KEY`': '`$COPY`',
                '`$VAL`': ['`$FORMAT`', 'upper', '`$COPY`']
            }]
    });
    const env = (0, utility_1.envOverride)({
        'SMSAPI_TEST_SENT_RCS_MESSAGE_ENTID': idmap,
        'SMSAPI_TEST_LIVE': 'FALSE',
        'SMSAPI_TEST_EXPLAIN': 'FALSE',
        'SMSAPI_APIKEY': '',
    });
    idmap = env['SMSAPI_TEST_SENT_RCS_MESSAGE_ENTID'];
    const live = 'TRUE' === env.SMSAPI_TEST_LIVE;
    const transport = (0, live_runner_1.createLiveTransport)();
    if (live) {
        const rawIds = process.env['SMSAPI_TEST_SENT_RCS_MESSAGE_ENTID'];
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
//# sourceMappingURL=SentRcsMessageEntity.test.js.map