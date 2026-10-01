# OptOutSetting entity test

require "minitest/autorun"
require "json"
require_relative "../Smsapi_sdk"
require_relative "runner"

class OptOutSettingEntityTest < Minitest::Test
  def test_create_instance
    testsdk = SmsapiSDK.test(nil, nil)
    ent = testsdk.OptOutSetting(nil)
    assert !ent.nil?
  end

  def test_basic_flow
    setup = opt_out_setting_basic_setup(nil)
    # Per-op sdk-test-control.json skip.
    _live = setup[:live] || false
    ["update", "load"].each do |_op|
      _should_skip, _reason = Runner.is_control_skipped("entityOp", "opt_out_setting." + _op, _live ? "live" : "unit")
      if _should_skip
        skip(_reason || "skipped via sdk-test-control.json")
        return
      end
    end
    # The basic flow consumes synthetic IDs from the fixture. In live mode
    # without an *_ENTID env override, those IDs hit the live API and 4xx.
    if setup[:synthetic_only]
      skip "live entity test uses synthetic IDs from fixture — set SMSAPI_TEST_OPT_OUT_SETTING_ENTID JSON to run live"
      return
    end
    client = setup[:client]

    # Bootstrap entity data from existing test data.
    opt_out_setting_ref01_data_raw = Vs.items(Helpers.to_map(
      Vs.getpath(setup[:data], "existing.opt_out_setting")))
    opt_out_setting_ref01_data = nil
    if opt_out_setting_ref01_data_raw.length > 0
      opt_out_setting_ref01_data = Helpers.to_map(opt_out_setting_ref01_data_raw[0][1])
    end

    # UPDATE
    opt_out_setting_ref01_ent = client.OptOutSetting(nil)
    opt_out_setting_ref01_data_up0_up = {
    }

    opt_out_setting_ref01_markdef_up0_name = "brand"
    opt_out_setting_ref01_markdef_up0_value = "Mark01-opt_out_setting_ref01_#{setup[:now]}"
    opt_out_setting_ref01_data_up0_up[opt_out_setting_ref01_markdef_up0_name] = opt_out_setting_ref01_markdef_up0_value

    opt_out_setting_ref01_resdata_up0_result = opt_out_setting_ref01_ent.update(opt_out_setting_ref01_data_up0_up, nil)
    opt_out_setting_ref01_resdata_up0 = Helpers.to_map(opt_out_setting_ref01_resdata_up0_result.respond_to?(:data_get) ? opt_out_setting_ref01_resdata_up0_result.data_get : opt_out_setting_ref01_resdata_up0_result)
    assert !opt_out_setting_ref01_resdata_up0.nil?
    assert_equal opt_out_setting_ref01_resdata_up0[opt_out_setting_ref01_markdef_up0_name], opt_out_setting_ref01_markdef_up0_value

    # LOAD
    opt_out_setting_ref01_match_dt0 = {}
    opt_out_setting_ref01_data_dt0_loaded = opt_out_setting_ref01_ent.load(opt_out_setting_ref01_match_dt0, nil)
    assert !opt_out_setting_ref01_data_dt0_loaded.nil?

  end
end

def opt_out_setting_basic_setup(extra)
  Runner.load_env_local

  entity_data_file = File.join(__dir__, "..", "..", ".sdk", "test", "entity", "opt_out_setting", "OptOutSettingTestData.json")
  entity_data_source = File.read(entity_data_file)
  entity_data = JSON.parse(entity_data_source)

  options = {}
  options["entity"] = entity_data["existing"]

  client = SmsapiSDK.test(options, extra)

  # Generate idmap via transform.
  idmap = Vs.transform(
    ["opt_out_setting01", "opt_out_setting02", "opt_out_setting03"],
    {
      "`$PACK`" => ["", {
        "`$KEY`" => "`$COPY`",
        "`$VAL`" => ["`$FORMAT`", "upper", "`$COPY`"],
      }],
    }
  )

  # Detect ENTID env override before envOverride consumes it. When live
  # mode is on without a real override, the basic test runs against synthetic
  # IDs from the fixture and 4xx's. Surface this so the test can skip.
  entid_env_raw = ENV["SMSAPI_TEST_OPT_OUT_SETTING_ENTID"]
  idmap_overridden = !entid_env_raw.nil? && entid_env_raw.strip.start_with?("{")

  env = Runner.env_override({
    "SMSAPI_TEST_OPT_OUT_SETTING_ENTID" => idmap,
    "SMSAPI_TEST_LIVE" => "FALSE",
    "SMSAPI_TEST_EXPLAIN" => "FALSE",
    "SMSAPI_APIKEY" => "",
  })

  idmap_resolved = Helpers.to_map(
    env["SMSAPI_TEST_OPT_OUT_SETTING_ENTID"])
  if idmap_resolved.nil?
    idmap_resolved = Helpers.to_map(idmap)
  end

  if env["SMSAPI_TEST_LIVE"] == "TRUE"
    merged_opts = Vs.merge([
      # FIRST, so the generated fields below win: sdk-test-control.json's
      # test.client.options adds to the live client, it does not redirect it.
      Runner.live_client_options,
      {
        "apikey" => env["SMSAPI_APIKEY"],
      },
      extra || {},
    ])
    client = SmsapiSDK.new(Helpers.to_map(merged_opts))
  end

  live = env["SMSAPI_TEST_LIVE"] == "TRUE"
  {
    client: client,
    data: entity_data,
    idmap: idmap_resolved,
    env: env,
    explain: env["SMSAPI_TEST_EXPLAIN"] == "TRUE",
    live: live,
    synthetic_only: live && !idmap_overridden,
    now: (Time.now.to_f * 1000).to_i,
  }
end
