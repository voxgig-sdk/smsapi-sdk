#!perl
# Contact entity test

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
  my $ent = $testsdk->Contact(undef);
  ok(defined $ent, 'contact: create instance');
}

BASIC_FLOW: {
  my $setup = contact_basic_setup(undef);
  my $_live = $setup->{live} ? 1 : 0;
  # Per-op sdk-test-control.json skip.
  for my $_op (('create', 'list', 'update', 'load', 'remove')) {
    my ($_should_skip, $_reason) = SmsapiTestRunner::is_control_skipped(
      'entityOp', "contact." . $_op, $_live ? 'live' : 'unit');
    if ($_should_skip) {
      note($_reason || 'skipped via sdk-test-control.json');
      pass('contact: basic flow skipped via sdk-test-control.json');
      last BASIC_FLOW;
    }
  }
  # The basic flow consumes synthetic IDs from the fixture. In live mode
  # without an *_ENTID env override, those IDs hit the live API and 4xx.
  if ($setup->{synthetic_only}) {
    note('live entity test uses synthetic IDs from fixture - set SMSAPI_TEST_CONTACT_ENTID JSON to run live');
    pass('contact: basic flow skipped (synthetic IDs only)');
    last BASIC_FLOW;
  }
  my $client = $setup->{client};
  my %V;

  # CREATE
  $V{contact_ref01_ent} = $client->Contact(undef);
  $V{contact_ref01_data} = SmsapiHelpers::to_map(SmsapiHelpers::gp(
    SmsapiHelpers::gpath($setup->{data}, 'new.contact'), 'contact_ref01'));
  $V{contact_ref01_data}{'group_id'} = $setup->{idmap}{'group01'};

  $V{contact_ref01_data_result} = $V{contact_ref01_ent}->create($V{contact_ref01_data}, undef);
  $V{contact_ref01_data} = SmsapiHelpers::to_map(ref($V{contact_ref01_data_result}) && $V{contact_ref01_data_result}->can('data_get') ? $V{contact_ref01_data_result}->data_get : $V{contact_ref01_data_result});
  ok(defined $V{contact_ref01_data}, 'contact create: data');
  ok(defined $V{contact_ref01_data}{id}, 'contact create: id');

  # LIST
  $V{contact_ref01_match} = {
    'contact_id' => $setup->{idmap}{'contact01'},
  };

  $V{contact_ref01_list_result} = $V{contact_ref01_ent}->list($V{contact_ref01_match}, undef);
  ok(Voxgig::Struct::islist($V{contact_ref01_list_result}), 'contact list: is array');

  $V{found_item} = Voxgig::Struct::select(
    SmsapiTestRunner::entity_list_to_data($V{contact_ref01_list_result}),
    { 'id' => $V{contact_ref01_data}{id} });
  ok(!Voxgig::Struct::isempty($V{found_item}), 'contact list: item exists');

  # UPDATE
  $V{contact_ref01_data_up0_up} = {
    'id' => $V{contact_ref01_data}{id},
  };

  $V{contact_ref01_markdef_up0_name} = 'birthday_date';
  $V{contact_ref01_markdef_up0_value} = 'Mark01-contact_ref01_' . $setup->{now};
  $V{contact_ref01_data_up0_up}{ $V{contact_ref01_markdef_up0_name} } = $V{contact_ref01_markdef_up0_value};

  $V{contact_ref01_resdata_up0_result} = $V{contact_ref01_ent}->update($V{contact_ref01_data_up0_up}, undef);
  $V{contact_ref01_resdata_up0} = SmsapiHelpers::to_map(ref($V{contact_ref01_resdata_up0_result}) && $V{contact_ref01_resdata_up0_result}->can('data_get') ? $V{contact_ref01_resdata_up0_result}->data_get : $V{contact_ref01_resdata_up0_result});
  ok(defined $V{contact_ref01_resdata_up0}, 'contact update: data');
  is($V{contact_ref01_resdata_up0}{id}, $V{contact_ref01_data_up0_up}{id}, 'contact update: id');
  is($V{contact_ref01_resdata_up0}{ $V{contact_ref01_markdef_up0_name} }, $V{contact_ref01_markdef_up0_value}, 'contact update: mark');

  # LOAD
  $V{contact_ref01_match_dt0} = {
    'id' => $V{contact_ref01_data}{id},
  };
  $V{contact_ref01_data_dt0_loaded} = $V{contact_ref01_ent}->load($V{contact_ref01_match_dt0}, undef);
  $V{contact_ref01_data_dt0_load_result} = SmsapiHelpers::to_map(ref($V{contact_ref01_data_dt0_loaded}) && $V{contact_ref01_data_dt0_loaded}->can('data_get') ? $V{contact_ref01_data_dt0_loaded}->data_get : $V{contact_ref01_data_dt0_loaded});
  ok(defined $V{contact_ref01_data_dt0_load_result}, 'contact load: data');
  is($V{contact_ref01_data_dt0_load_result}{id}, $V{contact_ref01_data}{id}, 'contact load: id');

  # REMOVE
  $V{contact_ref01_match_rm0} = {
    'id' => $V{contact_ref01_data}{id},
  };
  $V{contact_ref01_ent}->remove($V{contact_ref01_match_rm0}, undef);
  pass('contact remove: completed');

  # LIST
  $V{contact_ref01_match_rt0} = {
    'contact_id' => $setup->{idmap}{'contact01'},
  };

  $V{contact_ref01_list_rt0_result} = $V{contact_ref01_ent}->list($V{contact_ref01_match_rt0}, undef);
  ok(Voxgig::Struct::islist($V{contact_ref01_list_rt0_result}), 'contact list: is array');

  $V{not_found_item} = Voxgig::Struct::select(
    SmsapiTestRunner::entity_list_to_data($V{contact_ref01_list_rt0_result}),
    { 'id' => $V{contact_ref01_data}{id} });
  ok(Voxgig::Struct::isempty($V{not_found_item}), 'contact list: item not exists');

}

sub contact_basic_setup {
  my ($extra) = @_;
  SmsapiTestRunner::load_env_local();

  my $entity_data_file = Cwd::abs_path(
    "$FindBin::Bin/../../.sdk/test/entity/contact/ContactTestData.json");
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
    ['contact01', 'contact02', 'contact03', 'group01', 'group02', 'group03'],
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
  my $entid_env_raw = $ENV{'SMSAPI_TEST_CONTACT_ENTID'};
  my $idmap_overridden = (defined $entid_env_raw && $entid_env_raw =~ /^\s*\{/) ? 1 : 0;

  my $env = SmsapiTestRunner::env_override({
    'SMSAPI_TEST_CONTACT_ENTID' => $idmap,
    'SMSAPI_TEST_LIVE' => 'FALSE',
    'SMSAPI_TEST_EXPLAIN' => 'FALSE',
    'SMSAPI_APIKEY' => '',
  });

  my $idmap_resolved = SmsapiHelpers::to_map($env->{'SMSAPI_TEST_CONTACT_ENTID'});
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
