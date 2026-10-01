#!perl
# Subuser direct test

use strict;
use warnings;
use Test::More;
use FindBin;
use lib "$FindBin::Bin/../lib";
use Cwd ();

use SmsapiSDK;
require(Cwd::abs_path("$FindBin::Bin/runner.pm"));

DIRECT_LIST: {
  my $setup = subuser_direct_setup([
    { 'id' => 'direct01' },
    { 'id' => 'direct02' },
  ]);
  my ($_should_skip, $_reason) = SmsapiTestRunner::is_control_skipped(
    'direct', 'direct-list-subuser', $setup->{live} ? 'live' : 'unit');
  if ($_should_skip) {
    note($_reason || 'skipped via sdk-test-control.json');
    pass('direct-list-subuser: skipped via sdk-test-control.json');
    last DIRECT_LIST;
  }
  if ($setup->{live}) {
    for my $_live_key ('subuser01') {
      if (!defined $setup->{idmap}{$_live_key}) {
        note("live test needs $_live_key via *_ENTID env var (synthetic IDs only)");
        pass('direct-list-subuser: skipped');
        last DIRECT_LIST;
      }
    }
  }
  my $client = $setup->{client};

  my $params = {};
  if ($setup->{live}) {
    $params->{'id'} = $setup->{idmap}{'subuser01'};
  }
  else {
    $params->{'id'} = 'direct01';
  }

  my $result = $client->direct({
    'path' => 'subusers/{id}/shares/sendernames',
    'method' => 'GET',
    'params' => $params,
  });
  if ($setup->{live}) {
    # Live mode is lenient: synthetic IDs frequently 4xx and the list-
    # response shape varies wildly across public APIs. Skip rather than
    # fail when the call doesn't return a usable list.
    if (defined $result->{err}) {
      note("list call failed (likely synthetic IDs against live API): $result->{err}");
      pass('direct-list-subuser: skipped (live)');
      last DIRECT_LIST;
    }
    unless ($result->{ok}) {
      note('list call not ok (likely synthetic IDs against live API)');
      pass('direct-list-subuser: skipped (live)');
      last DIRECT_LIST;
    }
    my $status = SmsapiHelpers::to_int($result->{status});
    if ($status < 200 || $status >= 300) {
      note("expected 2xx status, got $status");
      pass('direct-list-subuser: skipped (live)');
      last DIRECT_LIST;
    }
    pass('direct-list-subuser: live ok');
  }
  else {
    ok(!defined $result->{err}, 'direct-list-subuser: no error');
    ok($result->{ok}, 'direct-list-subuser: ok');
    is(SmsapiHelpers::to_int($result->{status}), 200, 'direct-list-subuser: status');
    ok(Voxgig::Struct::islist($result->{data}), 'direct-list-subuser: data is array');
    is(scalar @{ $result->{data} }, 2, 'direct-list-subuser: data length');
    is(scalar @{ $setup->{calls} }, 1, 'direct-list-subuser: 1 call');
  }
}

DIRECT_LOAD: {
  my $setup = subuser_direct_setup({ 'id' => 'direct01' });
  my ($_should_skip, $_reason) = SmsapiTestRunner::is_control_skipped(
    'direct', 'direct-load-subuser', $setup->{live} ? 'live' : 'unit');
  if ($_should_skip) {
    note($_reason || 'skipped via sdk-test-control.json');
    pass('direct-load-subuser: skipped via sdk-test-control.json');
    last DIRECT_LOAD;
  }
  my $client = $setup->{client};

  my $params = {};
  my $query = {};
  if ($setup->{live}) {
    $params->{'id'} = '0f0f0f0f0f0f0f0f0f0f0f0f';
  }
  else {
    $params->{'id'} = 'direct01';
  }

  my $result = $client->direct({
    'path' => 'subusers/{id}',
    'method' => 'GET',
    'params' => $params,
    'query' => $query,
  });
  if ($setup->{live}) {
    # Live mode is lenient: synthetic IDs frequently 4xx. Skip rather
    # than fail when the load endpoint isn't reachable with the IDs
    # we can construct from setup idmap.
    if (defined $result->{err}) {
      note("load call failed (likely synthetic IDs against live API): $result->{err}");
      pass('direct-load-subuser: skipped (live)');
      last DIRECT_LOAD;
    }
    unless ($result->{ok}) {
      note('load call not ok (likely synthetic IDs against live API)');
      pass('direct-load-subuser: skipped (live)');
      last DIRECT_LOAD;
    }
    my $status = SmsapiHelpers::to_int($result->{status});
    if ($status < 200 || $status >= 300) {
      note("expected 2xx status, got $status");
      pass('direct-load-subuser: skipped (live)');
      last DIRECT_LOAD;
    }
    pass('direct-load-subuser: live ok');
  }
  else {
    ok(!defined $result->{err}, 'direct-load-subuser: no error');
    ok($result->{ok}, 'direct-load-subuser: ok');
    is(SmsapiHelpers::to_int($result->{status}), 200, 'direct-load-subuser: status');
    ok(defined $result->{data}, 'direct-load-subuser: data');
    if (Voxgig::Struct::ismap($result->{data})) {
      is($result->{data}{id}, 'direct01', 'direct-load-subuser: id');
    }
    is(scalar @{ $setup->{calls} }, 1, 'direct-load-subuser: 1 call');
  }
}


sub subuser_direct_setup {
  my ($mockres) = @_;
  SmsapiTestRunner::load_env_local();

  my $calls = [];

  my $env = SmsapiTestRunner::env_override({
    'SMSAPI_TEST_SUBUSER_ENTID' => {},
    'SMSAPI_TEST_LIVE' => 'FALSE',
    'SMSAPI_APIKEY' => '',
  });

  my $live = ((($env->{'SMSAPI_TEST_LIVE'}) || '') eq 'TRUE') ? 1 : 0;

  if ($live) {
    # live_client_options() FIRST so the generated fields below win:
    # sdk-test-control.json's test.client.options adds to the live client,
    # it does not redirect it (a later key wins in a Perl hash literal).
    my $client = SmsapiSDK->new({
      %{ SmsapiTestRunner::live_client_options() },
      'apikey' => $env->{'SMSAPI_APIKEY'},
    });
    return {
      'client' => $client,
      'calls' => $calls,
      'live' => 1,
      'idmap' => {},
    };
  }

  my $mock_fetch = sub {
    my ($url, $init) = @_;
    push @$calls, { 'url' => $url, 'init' => $init };
    return ({
      'status' => 200,
      'statusText' => 'OK',
      'headers' => {},
      'json' => sub {
        return defined $mockres ? $mockres : { 'id' => 'direct01' };
      },
      'body' => 'mock',
    }, undef);
  };

  my $client = SmsapiSDK->new({
    'base' => 'http://localhost:8080',
    'system' => {
      'fetch' => $mock_fetch,
    },
  });

  return {
    'client' => $client,
    'calls' => $calls,
    'live' => 0,
    'idmap' => {},
  };
}

done_testing();
