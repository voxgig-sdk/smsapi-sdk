#!perl
# OptOutSetting entity test

use strict;
use warnings;
use Test::More;
use FindBin;
use lib "$FindBin::Bin/../lib";
use Cwd ();

use SmsapiSDK;
require(Cwd::abs_path("$FindBin::Bin/runner.pm"));

{
  my $testsdk = SmsapiSDK->test(undef, undef);
  my $ent = $testsdk->OptOutSetting(undef);
  ok(defined $ent, 'opt_out_setting: create instance');
}

BASIC_FLOW: {
  my $setup = opt_out_setting_basic_setup(undef);
  my $_live = $setup->{live} ? 1 : 0;
  # Per-op sdk-test-control.json skip.
  for my $_op (('update', 'load')) {
    my ($_should_skip, $_reason) = SmsapiTestRunner::is_control_skipped(
      'entityOp', "opt_out_setting." . $_op, $_live ? 'live' : 'unit');
    if ($_should_skip) {
      note($_reason || 'skipped via sdk-test-control.json');
      pass('opt_out_setting: basic flow skipped via sdk-test-control.json');
      last BASIC_FLOW;
    }
  }
  # The basic flow consumes synthetic IDs from the fixture. In live mode
  # without an *_ENTID env override, those IDs hit the live API and 4xx.
  if ($setup->{synthetic_only}) {
    note('live entity test uses synthetic IDs from fixture - set SMSAPI_TEST_OPT_OUT_SETTING_ENTID JSON to run live');
    pass('opt_out_setting: basic flow skipped (synthetic IDs only)');
    last BASIC_FLOW;
  }
  my $client = $setup->{client};
  my %V;

  # Bootstrap entity data from existing test data.
  $V{opt_out_setting_ref01_data_raw} = Voxgig::Struct::items(SmsapiHelpers::to_map(
    SmsapiHelpers::gpath($setup->{data}, 'existing.opt_out_setting')));
  $V{opt_out_setting_ref01_data} = undef;
  if (@{ $V{opt_out_setting_ref01_data_raw} || [] }) {
    $V{opt_out_setting_ref01_data} = SmsapiHelpers::to_map($V{opt_out_setting_ref01_data_raw}[0][1]);
  }

  # UPDATE
  $V{opt_out_setting_ref01_ent} = $client->OptOutSetting(undef);
  $V{opt_out_setting_ref01_data_up0_up} = {
  };

  $V{opt_out_setting_ref01_markdef_up0_name} = 'brand';
  $V{opt_out_setting_ref01_markdef_up0_value} = 'Mark01-opt_out_setting_ref01_' . $setup->{now};
  $V{opt_out_setting_ref01_data_up0_up}{ $V{opt_out_setting_ref01_markdef_up0_name} } = $V{opt_out_setting_ref01_markdef_up0_value};

  $V{opt_out_setting_ref01_resdata_up0_result} = $V{opt_out_setting_ref01_ent}->update($V{opt_out_setting_ref01_data_up0_up}, undef);
  $V{opt_out_setting_ref01_resdata_up0} = SmsapiHelpers::to_map(ref($V{opt_out_setting_ref01_resdata_up0_result}) && $V{opt_out_setting_ref01_resdata_up0_result}->can('data_get') ? $V{opt_out_setting_ref01_resdata_up0_result}->data_get : $V{opt_out_setting_ref01_resdata_up0_result});
  ok(defined $V{opt_out_setting_ref01_resdata_up0}, 'opt_out_setting update: data');
  is($V{opt_out_setting_ref01_resdata_up0}{ $V{opt_out_setting_ref01_markdef_up0_name} }, $V{opt_out_setting_ref01_markdef_up0_value}, 'opt_out_setting update: mark');

  # LOAD
  $V{opt_out_setting_ref01_match_dt0} = {};
  $V{opt_out_setting_ref01_data_dt0_loaded} = $V{opt_out_setting_ref01_ent}->load($V{opt_out_setting_ref01_match_dt0}, undef);
  ok(defined $V{opt_out_setting_ref01_data_dt0_loaded}, 'opt_out_setting load: data');

}

sub opt_out_setting_basic_setup {
  my ($extra) = @_;
  SmsapiTestRunner::load_env_local();

  my $entity_data_file = Cwd::abs_path(
    "$FindBin::Bin/../../.sdk/test/entity/opt_out_setting/OptOutSettingTestData.json");
  my $entity_data = do {
    open my $fh, '<:raw', $entity_data_file or die "Cannot open $entity_data_file: $!";
    local $/;
    Voxgig::Struct::parse_json(<$fh>);
  };

  my $options = {};
  $options->{entity} = $entity_data->{existing};

  my $client = SmsapiSDK->test($options, $extra);

  # Generate idmap via transform.
  my $idmap = Voxgig::Struct::transform(
    ['opt_out_setting01', 'opt_out_setting02', 'opt_out_setting03'],
    {
      '`$PACK`' => ['', {
        '`$KEY`' => '`$COPY`',
        '`$VAL`' => ['`$FORMAT`', 'upper', '`$COPY`'],
      }],
    }
  );

  # Detect ENTID env override before env_override consumes it. When live
  # mode is on without a real override, the basic test runs against
  # synthetic IDs from the fixture and 4xx's. Surface this so the test can
  # skip.
  my $entid_env_raw = $ENV{'SMSAPI_TEST_OPT_OUT_SETTING_ENTID'};
  my $idmap_overridden = (defined $entid_env_raw && $entid_env_raw =~ /^\s*\{/) ? 1 : 0;

  my $env = SmsapiTestRunner::env_override({
    'SMSAPI_TEST_OPT_OUT_SETTING_ENTID' => $idmap,
    'SMSAPI_TEST_LIVE' => 'FALSE',
    'SMSAPI_TEST_EXPLAIN' => 'FALSE',
    'SMSAPI_APIKEY' => '',
  });

  my $idmap_resolved = SmsapiHelpers::to_map($env->{'SMSAPI_TEST_OPT_OUT_SETTING_ENTID'});
  if (!defined $idmap_resolved) {
    $idmap_resolved = SmsapiHelpers::to_map($idmap);
  }

  if ((($env->{'SMSAPI_TEST_LIVE'}) || '') eq 'TRUE') {
    my $merged_opts = Voxgig::Struct::merge([
      # FIRST, so the generated fields below win: sdk-test-control.json's
      # test.client.options adds to the live client, it does not redirect it.
      SmsapiTestRunner::live_client_options(),
      {
        'apikey' => $env->{'SMSAPI_APIKEY'},
      },
      (Voxgig::Struct::ismap($extra) ? $extra : {}),
    ]);
    $client = SmsapiSDK->new(SmsapiHelpers::to_map($merged_opts));
  }

  my $live = ((($env->{'SMSAPI_TEST_LIVE'}) || '') eq 'TRUE') ? 1 : 0;
  return {
    'client' => $client,
    'data' => $entity_data,
    'idmap' => $idmap_resolved,
    'env' => $env,
    'explain' => ((($env->{'SMSAPI_TEST_EXPLAIN'}) || '') eq 'TRUE') ? 1 : 0,
    'live' => $live,
    'synthetic_only' => ($live && !$idmap_overridden) ? 1 : 0,
    'now' => SmsapiHelpers::now_ms(),
  };
}

done_testing();
