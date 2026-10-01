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
(0, node_test_1.describe)('ShipmentCountryVolumeEntity', async () => {
    // Per-test live pacing. Delay is read from sdk-test-control.json's
    // `test.live.delayMs`; only sleeps when SMSAPI_TEST_LIVE=TRUE.
    (0, node_test_1.afterEach)((0, utility_1.liveDelay)('SMSAPI_TEST_LIVE'));
    (0, node_test_1.test)('instance', async () => {
        const testsdk = __1.SmsapiSDK.test();
        const ent = testsdk.ShipmentCountryVolume();
        (0, node_assert_1.default)(null != ent);
    });
    (0, node_test_1.test)('basic', async (t) => {
        const live = 'TRUE' === process.env.SMSAPI_TEST_LIVE;
        for (const op of ['list']) {
            if (!live && (0, utility_1.maybeSkipControl)(t, 'entityOp', 'shipment_country_volume.' + op, live))
                return;
        }
        const setup = basicSetup();
        if (setup.live) {
            return (0, live_entity_1.runLiveEntity)(setup, { "active": true, "alias": { "field": {} }, "fields": { "country_code": { "a": true, "h": "Country Code", "n": "country_code", "r": false, "t": "`$STRING`", "key$": "country_code", "index$": 0 }, "country_limit": { "a": true, "h": "Country Limit", "n": "country_limit", "r": false, "t": "`$INTEGER`", "key$": "country_limit", "index$": 1 }, "country_name": { "a": true, "h": "Country Name", "n": "country_name", "r": false, "t": "`$STRING`", "key$": "country_name", "index$": 2 }, "usage": { "a": true, "h": "Usage", "n": "usage", "r": false, "t": "`$INTEGER`", "key$": "usage", "index$": 3 } }, "name": "shipment_country_volume", "op": { "list": { "input": "data", "name": "list", "points": [{ "a": true, "co": { "id": "GET /shipment/country_volumes", "source": "openapi3", "version": 2 }, "g": { "header": [{ "a": true, "ex": "application/json", "k": "header", "n": "accept", "or": "Accept", "r": false, "t": "`$STRING`", "index$": 0 }], "query": [{ "a": true, "k": "query", "n": "month", "or": "month", "r": false, "t": "`$STRING`", "index$": 0 }, { "a": true, "k": "query", "n": "year", "or": "year", "r": false, "t": "`$STRING`", "index$": 1 }] }, "k": "http", "m": "GET", "o": "/shipment/country_volumes", "q": { "exist": ["accept", "month", "year"] }, "r": {}, "s": [{ "lit": "shipment" }, { "lit": "country_volumes" }], "t": { "req": "`reqdata`", "res": "`body.collection`" }, "index$": 0 }], "key$": "list" } }, "relations": { "ancestors": [] }, "key$": "shipment_country_volume", "name__orig": "shipment_country_volume", "Name": "ShipmentCountryVolume", "name_": "shipment_country_volume", "name-": "shipment-country-volume", "NAME": "SHIPMENT_COUNTRY_VOLUME", "index$": 20 }, { "active": true, "entity": "shipment_country_volume", "key$": "BasicShipmentCountryVolumeFlow", "kind": "basic", "name": "BasicShipmentCountryVolumeFlow", "param": {}, "step": [{ "a": true, "d": {}, "i": {}, "m": {}, "o": "list", "s": [], "v": [{ "apply": "ItemExists", "def": { "ref": "shipment_country_volume_ref01" } }], "index$": 0 }] }, 'ShipmentCountryVolume', { "GET /shipment/country_volumes": { "protocol": "http", "parameters": [{ "in": "query", "name": "year", "schema": { "type": "string" }, "description": "Used country volume year.", "index$": 0 }, { "in": "query", "name": "month", "schema": { "type": "string" }, "description": "Used country volume month.", "index$": 1 }, { "name": "Accept", "in": "header", "required": false, "schema": { "type": "string", "enum": ["application/json", "text/csv"], "default": "application/json" }, "x-ref": "#/components/parameters/Accept-Header-Csv", "index$": 2 }] } });
        }
        const client = setup.client;
        const struct = setup.struct;
        const isempty = struct.isempty;
        const select = struct.select;
        let shipment_country_volume_ref01_data = Object.values(setup.data.existing.shipment_country_volume)[0];
        // LIST
        const shipment_country_volume_ref01_ent = client.ShipmentCountryVolume();
        const shipment_country_volume_ref01_match = {};
        const shipment_country_volume_ref01_list = (await shipment_country_volume_ref01_ent.list(shipment_country_volume_ref01_match)).map((e) => e.data());
    });
});
function basicSetup(extra) {
    // TODO: fix test def options
    const options = {}; // null
    // TODO: needs test utility to resolve path
    const entityDataFile = node_path_1.default.resolve(__dirname, '../../../../.sdk/test/entity/shipment_country_volume/ShipmentCountryVolumeTestData.json');
    // TODO: file ready util needed?
    const entityDataSource = Fs.readFileSync(entityDataFile).toString('utf8');
    // TODO: need a xlang JSON parse utility in voxgig/struct with better error msgs
    const entityData = JSON.parse(entityDataSource);
    options.entity = entityData.existing;
    let client = __1.SmsapiSDK.test(options, extra);
    const struct = client.utility().struct;
    const merge = struct.merge;
    const transform = struct.transform;
    let idmap = transform(['shipment_country_volume01', 'shipment_country_volume02', 'shipment_country_volume03'], {
        '`$PACK`': ['', {
                '`$KEY`': '`$COPY`',
                '`$VAL`': ['`$FORMAT`', 'upper', '`$COPY`']
            }]
    });
    const env = (0, utility_1.envOverride)({
        'SMSAPI_TEST_SHIPMENT_COUNTRY_VOLUME_ENTID': idmap,
        'SMSAPI_TEST_LIVE': 'FALSE',
        'SMSAPI_TEST_EXPLAIN': 'FALSE',
        'SMSAPI_APIKEY': '',
    });
    idmap = env['SMSAPI_TEST_SHIPMENT_COUNTRY_VOLUME_ENTID'];
    const live = 'TRUE' === env.SMSAPI_TEST_LIVE;
    const transport = (0, live_runner_1.createLiveTransport)();
    if (live) {
        const rawIds = process.env['SMSAPI_TEST_SHIPMENT_COUNTRY_VOLUME_ENTID'];
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
//# sourceMappingURL=ShipmentCountryVolumeEntity.test.js.map