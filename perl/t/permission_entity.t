#!perl
# Permission entity test

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
  my $ent = $testsdk->Permission(undef);
  ok(defined $ent, 'permission: create instance');
}

BASIC_FLOW: {
  my $setup = permission_basic_setup(undef);
  my $_live = $setup->{live} ? 1 : 0;
  # Per-op sdk-test-control.json skip.
  for my $_op (('create', 'load')) {
    my ($_should_skip, $_reason) = SmsapiTestRunner::is_control_skipped(
      'entityOp', "permission." . $_op, $_live ? 'live' : 'unit');
    if ($_should_skip) {
      note($_reason || 'skipped via sdk-test-control.json');
      pass('permission: basic flow skipped via sdk-test-control.json');
      last BASIC_FLOW;
    }
  }
  # The basic flow consumes synthetic IDs from the fixture. In live mode
  # without an *_ENTID env override, those IDs hit the live API and 4xx.
  if ($setup->{synthetic_only}) {
    note('live entity test uses synthetic IDs from fixture - set SMSAPI_TEST_PERMISSION_ENTID JSON to run live');
    pass('permission: basic flow skipped (synthetic IDs only)');
    last BASIC_FLOW;
  }
  my $client = $setup->{client};
  my %V;

  # CREATE
  $V{permission_ref01_ent} = $client->Permission(undef);
  $V{permission_ref01_data} = SmsapiHelpers::to_map(SmsapiHelpers::gp(
    SmsapiHelpers::gpath($setup->{data}, 'new.permission'), 'permission_ref01'));
  $V{permission_ref01_data}{'group_id'} = $setup->{idmap}{'group01'};

  $V{permission_ref01_data_result} = $V{permission_ref01_ent}->create($V{permission_ref01_data}, undef);
  $V{permission_ref01_data} = SmsapiHelpers::to_map(ref($V{permission_ref01_data_result}) && $V{permission_ref01_data_result}->can('data_get') ? $V{permission_ref01_data_result}->data_get : $V{permission_ref01_data_result});
  ok(defined $V{permission_ref01_data}, 'permission create: data');
  ok(defined $V{permission_ref01_data}{id}, 'permission create: id');

  # LOAD
  $V{permission_ref01_match_dt0} = {
    'id' => $V{permission_ref01_data}{id},
  };
  $V{permission_ref01_data_dt0_loaded} = $V{permission_ref01_ent}->load($V{permission_ref01_match_dt0}, undef);
  $V{permission_ref01_data_dt0_load_result} = SmsapiHelpers::to_map(ref($V{permission_ref01_data_dt0_loaded}) && $V{permission_ref01_data_dt0_loaded}->can('data_get') ? $V{permission_ref01_data_dt0_loaded}->data_get : $V{permission_ref01_data_dt0_loaded});
  ok(defined $V{permission_ref01_data_dt0_load_result}, 'permission load: data');
  is($V{permission_ref01_data_dt0_load_result}{id}, $V{permission_ref01_data}{id}, 'permission load: id');

}

sub permission_basic_setup {
  my ($extra) = @_;
  SmsapiTestRunner::load_env_local();

  my $entity_data_file = Cwd::abs_path(
    "$FindBin::Bin/../../.sdk/test/entity/permission/PermissionTestData.json");
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
    ['permission01', 'permission02', 'permission03', 'group01', 'group02', 'group03'],
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
  my $entid_env_raw = $ENV{'SMSAPI_TEST_PERMISSION_ENTID'};
  my $idmap_overridden = (defined $entid_env_raw && $entid_env_raw =~ /^\s*\{/) ? 1 : 0;

  my $env = SmsapiTestRunner::env_override({
    'SMSAPI_TEST_PERMISSION_ENTID' => $idmap,
    'SMSAPI_TEST_LIVE' => 'FALSE',
    'SMSAPI_TEST_EXPLAIN' => 'FALSE',
    'SMSAPI_APIKEY' => '',
  });

  my $idmap_resolved = SmsapiHelpers::to_map($env->{'SMSAPI_TEST_PERMISSION_ENTID'});
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
