-- Group entity test

local json = require("dkjson")
local vs = require("utility.struct.struct")
local sdk = require("smsapi_sdk")
local helpers = require("core.helpers")
local runner = require("test.runner")

local _test_dir = debug.getinfo(1, "S").source:match("^@(.+/)")  or "./"

describe("GroupEntity", function()
  it("should create instance", function()
    local testsdk = sdk.test(nil, nil)
    local ent = testsdk:Group(nil)
    assert.is_not_nil(ent)
  end)

  it("should run basic flow", function()
    local setup = group_basic_setup(nil)
    -- Per-op sdk-test-control.json skip.
    local _live = setup.live or false
    for _, _op in ipairs({"update", "load"}) do
      local _should_skip, _reason = runner.is_control_skipped("entityOp", "group." .. _op, _live and "live" or "unit")
      if _should_skip then
        pending(_reason or "skipped via sdk-test-control.json")
        return
      end
    end
    -- The basic flow consumes synthetic IDs from the fixture. In live mode
    -- without an *_ENTID env override, those IDs hit the live API and 4xx.
    if setup.synthetic_only then
      pending("live entity test uses synthetic IDs from fixture — set SMSAPI_TEST_GROUP_ENTID JSON to run live")
      return
    end
    local client = setup.client

    -- Bootstrap entity data from existing test data.
    local group_ref01_data_raw = vs.items(helpers.to_map(
      vs.getpath(setup.data, "existing.group")))
    local group_ref01_data = nil
    if #group_ref01_data_raw > 0 then
      group_ref01_data = helpers.to_map(group_ref01_data_raw[1][2])
    end

    -- UPDATE
    local group_ref01_ent = client:Group(nil)
    local group_ref01_data_up0_up = {
      id = group_ref01_data["id"],
    }

    local group_ref01_markdef_up0_name = "created_by"
    local group_ref01_markdef_up0_value = "Mark01-group_ref01_" .. tostring(setup.now)
    group_ref01_data_up0_up[group_ref01_markdef_up0_name] = group_ref01_markdef_up0_value

    local group_ref01_resdata_up0_result, err = group_ref01_ent:update(group_ref01_data_up0_up, nil)
    assert.is_nil(err)
    local group_ref01_resdata_up0 = helpers.to_map(type(group_ref01_resdata_up0_result) == 'table' and group_ref01_resdata_up0_result.data_get and group_ref01_resdata_up0_result:data_get() or group_ref01_resdata_up0_result)
    assert.is_not_nil(group_ref01_resdata_up0)
    assert.are.equal(group_ref01_resdata_up0["id"], group_ref01_data_up0_up["id"])
    assert.are.equal(group_ref01_resdata_up0[group_ref01_markdef_up0_name], group_ref01_markdef_up0_value)

    -- LOAD
    local group_ref01_match_dt0 = {
      id = group_ref01_data["id"],
    }
    local group_ref01_data_dt0_loaded, err = group_ref01_ent:load(group_ref01_match_dt0, nil)
    assert.is_nil(err)
    local group_ref01_data_dt0_load_result = helpers.to_map(type(group_ref01_data_dt0_loaded) == 'table' and group_ref01_data_dt0_loaded.data_get and group_ref01_data_dt0_loaded:data_get() or group_ref01_data_dt0_loaded)
    assert.is_not_nil(group_ref01_data_dt0_load_result)
    assert.are.equal(group_ref01_data_dt0_load_result["id"], group_ref01_data["id"])

  end)
end)

function group_basic_setup(extra)
  runner.load_env_local()

  local entity_data_file = _test_dir .. "../../.sdk/test/entity/group/GroupTestData.json"
  local f = io.open(entity_data_file, "r")
  if f == nil then
    error("failed to read group test data: " .. entity_data_file)
  end
  local entity_data_source = f:read("*a")
  f:close()

  local entity_data = json.decode(entity_data_source)

  local options = {}
  options["entity"] = entity_data["existing"]

  local client = sdk.test(options, extra)

  -- Generate idmap via transform.
  local idmap = vs.transform(
    { "group01", "group02", "group03" },
    {
      ["`$PACK`"] = { "", {
        ["`$KEY`"] = "`$COPY`",
        ["`$VAL`"] = { "`$FORMAT`", "upper", "`$COPY`" },
      }},
    }
  )

  -- Detect ENTID env override before envOverride consumes it. When live
  -- mode is on without a real override, the basic test runs against synthetic
  -- IDs from the fixture and 4xx's. Surface this so the test can skip.
  local entid_env_raw = os.getenv("SMSAPI_TEST_GROUP_ENTID")
  local idmap_overridden = entid_env_raw ~= nil and entid_env_raw:match("^%s*{") ~= nil

  local env = runner.env_override({
    ["SMSAPI_TEST_GROUP_ENTID"] = idmap,
    ["SMSAPI_TEST_LIVE"] = "FALSE",
    ["SMSAPI_TEST_EXPLAIN"] = "FALSE",
    ["SMSAPI_APIKEY"] = "",
  })

  local idmap_resolved = helpers.to_map(
    env["SMSAPI_TEST_GROUP_ENTID"])
  if idmap_resolved == nil then
    idmap_resolved = helpers.to_map(idmap)
  end

  if env["SMSAPI_TEST_LIVE"] == "TRUE" then
    local merged_opts = vs.merge({
      -- FIRST, so the generated fields below win: sdk-test-control.json's
      -- test.client.options adds to the live client, it does not redirect it.
      runner.live_client_options(),
      {
        apikey = env["SMSAPI_APIKEY"],
      },
      extra or {},
    })
    client = sdk.new(helpers.to_map(merged_opts))
  end

  local live = env["SMSAPI_TEST_LIVE"] == "TRUE"
  return {
    client = client,
    data = entity_data,
    idmap = idmap_resolved,
    env = env,
    explain = env["SMSAPI_TEST_EXPLAIN"] == "TRUE",
    live = live,
    synthetic_only = live and not idmap_overridden,
    now = os.time() * 1000,
  }
end
