#!perl
# ContactsField entity test

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
  my $ent = $testsdk->ContactsField(undef);
  ok(defined $ent, 'contacts_field: create instance');
}

BASIC_FLOW: {
  my $setup = contacts_field_basic_setup(undef);
  my $_live = $setup->{live} ? 1 : 0;
  # Per-op sdk-test-control.json skip.
  for my $_op (('create', 'list', 'update', 'remove')) {
    my ($_should_skip, $_reason) = SmsapiTestRunner::is_control_skipped(
      'entityOp', "contacts_field." . $_op, $_live ? 'live' : 'unit');
    if ($_should_skip) {
      note($_reason || 'skipped via sdk-test-control.json');
      pass('contacts_field: basic flow skipped via sdk-test-control.json');
      last BASIC_FLOW;
    }
  }
  # The basic flow consumes synthetic IDs from the fixture. In live mode
  # without an *_ENTID env override, those IDs hit the live API and 4xx.
  if ($setup->{synthetic_only}) {
    note('live entity test uses synthetic IDs from fixture - set SMSAPI_TEST_CONTACTS_FIELD_ENTID JSON to run live');
    pass('contacts_field: basic flow skipped (synthetic IDs only)');
    last BASIC_FLOW;
  }
  my $client = $setup->{client};
  my %V;

  # CREATE
  $V{contacts_field_ref01_ent} = $client->ContactsField(undef);
  $V{contacts_field_ref01_data} = SmsapiHelpers::to_map(SmsapiHelpers::gp(
    SmsapiHelpers::gpath($setup->{data}, 'new.contacts_field'), 'contacts_field_ref01'));

  $V{contacts_field_ref01_data_result} = $V{contacts_field_ref01_ent}->create($V{contacts_field_ref01_data}, undef);
  $V{contacts_field_ref01_data} = SmsapiHelpers::to_map(ref($V{contacts_field_ref01_data_result}) && $V{contacts_field_ref01_data_result}->can('data_get') ? $V{contacts_field_ref01_data_result}->data_get : $V{contacts_field_ref01_data_result});
  ok(defined $V{contacts_field_ref01_data}, 'contacts_field create: data');
  ok(defined $V{contacts_field_ref01_data}{id}, 'contacts_field create: id');

  # LIST
  $V{contacts_field_ref01_match} = {};

  $V{contacts_field_ref01_list_result} = $V{contacts_field_ref01_ent}->list($V{contacts_field_ref01_match}, undef);
  ok(Voxgig::Struct::islist($V{contacts_field_ref01_list_result}), 'contacts_field list: is array');

  $V{found_item} = Voxgig::Struct::select(
    SmsapiTestRunner::entity_list_to_data($V{contacts_field_ref01_list_result}),
    { 'id' => $V{contacts_field_ref01_data}{id} });
  ok(!Voxgig::Struct::isempty($V{found_item}), 'contacts_field list: item exists');

  # UPDATE
  $V{contacts_field_ref01_data_up0_up} = {
    'id' => $V{contacts_field_ref01_data}{id},
  };

  $V{contacts_field_ref01_markdef_up0_name} = 'birthday_date';
  $V{contacts_field_ref01_markdef_up0_value} = 'Mark01-contacts_field_ref01_' . $setup->{now};
  $V{contacts_field_ref01_data_up0_up}{ $V{contacts_field_ref01_markdef_up0_name} } = $V{contacts_field_ref01_markdef_up0_value};

  $V{contacts_field_ref01_resdata_up0_result} = $V{contacts_field_ref01_ent}->update($V{contacts_field_ref01_data_up0_up}, undef);
  $V{contacts_field_ref01_resdata_up0} = SmsapiHelpers::to_map(ref($V{contacts_field_ref01_resdata_up0_result}) && $V{contacts_field_ref01_resdata_up0_result}->can('data_get') ? $V{contacts_field_ref01_resdata_up0_result}->data_get : $V{contacts_field_ref01_resdata_up0_result});
  ok(defined $V{contacts_field_ref01_resdata_up0}, 'contacts_field update: data');
  is($V{contacts_field_ref01_resdata_up0}{id}, $V{contacts_field_ref01_data_up0_up}{id}, 'contacts_field update: id');
  is($V{contacts_field_ref01_resdata_up0}{ $V{contacts_field_ref01_markdef_up0_name} }, $V{contacts_field_ref01_markdef_up0_value}, 'contacts_field update: mark');

  # REMOVE
  $V{contacts_field_ref01_match_rm0} = {
    'id' => $V{contacts_field_ref01_data}{id},
  };
  $V{contacts_field_ref01_ent}->remove($V{contacts_field_ref01_match_rm0}, undef);
  pass('contacts_field remove: completed');

  # LIST
  $V{contacts_field_ref01_match_rt0} = {};

  $V{contacts_field_ref01_list_rt0_result} = $V{contacts_field_ref01_ent}->list($V{contacts_field_ref01_match_rt0}, undef);
  ok(Voxgig::Struct::islist($V{contacts_field_ref01_list_rt0_result}), 'contacts_field list: is array');

  $V{not_found_item} = Voxgig::Struct::select(
    SmsapiTestRunner::entity_list_to_data($V{contacts_field_ref01_list_rt0_result}),
    { 'id' => $V{contacts_field_ref01_data}{id} });
  ok(Voxgig::Struct::isempty($V{not_found_item}), 'contacts_field list: item not exists');

}

sub contacts_field_basic_setup {
  my ($extra) = @_;
  SmsapiTestRunner::load_env_local();

  my $entity_data_file = Cwd::abs_path(
    "$FindBin::Bin/../../.sdk/test/entity/contacts_field/ContactsFieldTestData.json");
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
    ['contacts_field01', 'contacts_field02', 'contacts_field03'],
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
  my $entid_env_raw = $ENV{'SMSAPI_TEST_CONTACTS_FIELD_ENTID'};
  my $idmap_overridden = (defined $entid_env_raw && $entid_env_raw =~ /^\s*\{/) ? 1 : 0;

  my $env = SmsapiTestRunner::env_override({
    'SMSAPI_TEST_CONTACTS_FIELD_ENTID' => $idmap,
    'SMSAPI_TEST_LIVE' => 'FALSE',
    'SMSAPI_TEST_EXPLAIN' => 'FALSE',
    'SMSAPI_APIKEY' => '',
  });

  my $idmap_resolved = SmsapiHelpers::to_map($env->{'SMSAPI_TEST_CONTACTS_FIELD_ENTID'});
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
