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
(0, node_test_1.describe)('PermissionEntity', async () => {
    // Per-test live pacing. Delay is read from sdk-test-control.json's
    // `test.live.delayMs`; only sleeps when SMSAPI_TEST_LIVE=TRUE.
    (0, node_test_1.afterEach)((0, utility_1.liveDelay)('SMSAPI_TEST_LIVE'));
    (0, node_test_1.test)('instance', async () => {
        const testsdk = __1.SmsapiSDK.test();
        const ent = testsdk.Permission();
        (0, node_assert_1.default)(null != ent);
    });
    (0, node_test_1.test)('basic', async (t) => {
        const live = 'TRUE' === process.env.SMSAPI_TEST_LIVE;
        for (const op of ['create', 'load']) {
            if (!live && (0, utility_1.maybeSkipControl)(t, 'entityOp', 'permission.' + op, live))
                return;
        }
        const setup = basicSetup();
        if (setup.live) {
            return (0, live_entity_1.runLiveEntity)(setup, { "active": true, "alias": { "field": {} }, "fields": { "group_id": { "a": true, "fo": "oid", "h": "Group Id", "n": "group_id", "r": true, "sh": "Object ID", "t": "`$STRING`", "key$": "group_id", "index$": 0 }, "id": { "a": true, "h": "Id", "n": "id", "r": false, "t": "`$STRING`", "key$": "id", "index$": 1 }, "read": { "a": true, "h": "Read", "n": "read", "r": true, "sh": "Has read permission", "t": "`$BOOLEAN`", "key$": "read", "index$": 2 }, "send": { "a": true, "h": "Send", "n": "send", "r": true, "sh": "Has send permission", "t": "`$BOOLEAN`", "key$": "send", "index$": 3 }, "username": { "a": true, "h": "Username", "n": "username", "r": true, "t": "`$STRING`", "key$": "username", "index$": 4 }, "write": { "a": true, "h": "Write", "n": "write", "r": true, "sh": "Has write permission", "t": "`$BOOLEAN`", "key$": "write", "index$": 5 } }, "id": { "field": "id", "name": "id" }, "name": "permission", "op": { "create": { "input": "data", "name": "create", "points": [{ "a": true, "co": { "id": "POST /contacts/groups/{groupId}/permissions", "source": "openapi3", "version": 2 }, "g": { "params": [{ "a": true, "ex": "0f0f0f0f0f0f0f0f0f0f0f0f", "k": "param", "n": "group_id", "or": "groupId", "r": true, "t": "`$STRING`", "index$": 0 }] }, "k": "http", "m": "POST", "o": "/contacts/groups/{groupId}/permissions", "q": { "exist": ["group_id"] }, "r": { "param": { "groupId": "group_id" } }, "s": [{ "lit": "contacts" }, { "lit": "groups" }, { "var": "group_id" }, { "lit": "permissions" }], "t": { "req": "`reqdata`", "res": "`body`" }, "index$": 0 }], "key$": "create" }, "load": { "input": "data", "name": "load", "points": [{ "a": true, "co": { "id": "GET /contacts/groups/{groupId}/permissions/{username}", "source": "openapi3", "version": 2 }, "g": { "params": [{ "a": true, "ex": "0f0f0f0f0f0f0f0f0f0f0f0f", "k": "param", "n": "group_id", "or": "groupId", "r": true, "t": "`$STRING`", "index$": 0 }, { "a": true, "k": "param", "n": "id", "or": "username", "r": true, "t": "`$STRING`", "index$": 1 }], "query": [{ "a": true, "ex": "example_username", "k": "query", "n": "username", "or": "username", "r": true, "t": "`$STRING`", "index$": 0 }] }, "k": "http", "m": "GET", "o": "/contacts/groups/{groupId}/permissions/{username}", "q": { "exist": ["group_id", "id", "username"] }, "r": { "param": { "groupId": "group_id", "username": "id" } }, "s": [{ "lit": "contacts" }, { "lit": "groups" }, { "var": "group_id" }, { "lit": "permissions" }, { "var": "id" }], "t": { "req": "`reqdata`", "res": "`body`" }, "index$": 0 }], "key$": "load" } }, "relations": { "ancestors": [["$.main.kit.entity.group"]] }, "key$": "permission", "name__orig": "permission", "Name": "Permission", "name_": "permission", "name-": "permission", "NAME": "PERMISSION", "index$": 13 }, { "active": true, "entity": "permission", "key$": "BasicPermissionFlow", "kind": "basic", "name": "BasicPermissionFlow", "param": {}, "step": [{ "a": true, "d": {}, "i": { "ref": "permission_ref01" }, "m": { "group_id": "group01" }, "o": "create", "s": [], "v": [], "index$": 0 }, { "a": true, "d": {}, "i": { "ref": "permission_ref01", "srcdatavar": "permission_ref01_data", "suffix": "_dt0" }, "m": { "group_id": "group01", "id": "permission01" }, "o": "load", "s": [], "v": [{ "apply": "TextFieldMark", "def": { "mark": "Mark01-permission_ref01" } }], "index$": 1 }] }, 'Permission', { "POST /contacts/groups/{groupId}/permissions": { "protocol": "http", "requestBody": { "required": true, "content": { "application/x-www-form-urlencoded": { "schema": { "required": ["username"], "properties": { "username": { "type": "string", "example": "example_username", "x-ref": "#/components/schemas/Username" }, "read": { "type": "boolean", "default": false, "example": false, "description": "Has read permission", "x-ref": "#/components/schemas/ReadPermission" }, "write": { "type": "boolean", "default": false, "example": false, "description": "Has write permission", "x-ref": "#/components/schemas/WritePermission" }, "send": { "type": "boolean", "default": false, "example": false, "description": "Has send permission", "x-ref": "#/components/schemas/SendPermission" } }, "x-ref": "#/components/schemas/CreateGroupPermission" } } } }, "parameters": [{ "name": "groupId", "schema": { "type": "string", "format": "oid", "pattern": "[0-9a-fA-F]{24}", "description": "Object ID", "example": "0f0f0f0f0f0f0f0f0f0f0f0f", "x-ref": "#/components/schemas/Id" }, "in": "path", "required": true, "description": "Group ID", "x-ref": "#/components/parameters/groupId", "index$": 0 }] }, "GET /contacts/groups/{groupId}/permissions/{username}": { "protocol": "http", "parameters": [{ "name": "groupId", "schema": { "type": "string", "format": "oid", "pattern": "[0-9a-fA-F]{24}", "description": "Object ID", "example": "0f0f0f0f0f0f0f0f0f0f0f0f", "x-ref": "#/components/schemas/Id" }, "in": "path", "required": true, "description": "Group ID", "x-ref": "#/components/parameters/groupId", "index$": 0 }, { "name": "username", "schema": { "type": "string", "example": "example_username", "x-ref": "#/components/schemas/Username" }, "required": true, "description": "Username", "x-ref": "#/components/parameters/username", "index$": 1 }] } });
        }
        const client = setup.client;
        const struct = setup.struct;
        const isempty = struct.isempty;
        const select = struct.select;
        // CREATE
        const permission_ref01_ent = client.Permission();
        let permission_ref01_data = setup.data.new.permission['permission_ref01'];
        permission_ref01_data['group_id'] = setup.idmap['group01'];
        permission_ref01_data = (await permission_ref01_ent.create(permission_ref01_data)).data();
        (0, node_assert_1.default)(null != permission_ref01_data.id);
        // LOAD
        const permission_ref01_match_dt0 = {};
        permission_ref01_match_dt0.id = permission_ref01_data.id;
        const permission_ref01_data_dt0 = (await permission_ref01_ent.load(permission_ref01_match_dt0)).data();
        (0, node_assert_1.default)(permission_ref01_data_dt0.id === permission_ref01_data.id);
    });
});
function basicSetup(extra) {
    // TODO: fix test def options
    const options = {}; // null
    // TODO: needs test utility to resolve path
    const entityDataFile = node_path_1.default.resolve(__dirname, '../../../../.sdk/test/entity/permission/PermissionTestData.json');
    // TODO: file ready util needed?
    const entityDataSource = Fs.readFileSync(entityDataFile).toString('utf8');
    // TODO: need a xlang JSON parse utility in voxgig/struct with better error msgs
    const entityData = JSON.parse(entityDataSource);
    options.entity = entityData.existing;
    let client = __1.SmsapiSDK.test(options, extra);
    const struct = client.utility().struct;
    const merge = struct.merge;
    const transform = struct.transform;
    let idmap = transform(['permission01', 'permission02', 'permission03', 'group01', 'group02', 'group03'], {
        '`$PACK`': ['', {
                '`$KEY`': '`$COPY`',
                '`$VAL`': ['`$FORMAT`', 'upper', '`$COPY`']
            }]
    });
    const env = (0, utility_1.envOverride)({
        'SMSAPI_TEST_PERMISSION_ENTID': idmap,
        'SMSAPI_TEST_LIVE': 'FALSE',
        'SMSAPI_TEST_EXPLAIN': 'FALSE',
        'SMSAPI_APIKEY': '',
    });
    idmap = env['SMSAPI_TEST_PERMISSION_ENTID'];
    const live = 'TRUE' === env.SMSAPI_TEST_LIVE;
    const transport = (0, live_runner_1.createLiveTransport)();
    if (live) {
        const rawIds = process.env['SMSAPI_TEST_PERMISSION_ENTID'];
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
//# sourceMappingURL=PermissionEntity.test.js.map