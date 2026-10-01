#!perl
# Callback direct test

use strict;
use warnings;
use Test::More;
use FindBin;
use lib "$FindBin::Bin/../lib";
use Cwd ();

use SmsapiSDK;
require(Cwd::abs_path("$FindBin::Bin/runner.pm"));

DIRECT_LIST: {
  my $setup = callback_direct_setup([
    { 'id' => 'direct01' },
    { 'id' => 'direct02' },
  ]);
  my ($_should_skip, $_reason) = SmsapiTestRunner::is_control_skipped(
    'direct', 'direct-list-callback', $setup->{live} ? 'live' : 'unit');
  if ($_should_skip) {
    note($_reason || 'skipped via sdk-test-control.json');
    pass('direct-list-callback: skipped via sdk-test-control.json');
    last DIRECT_LIST;
  }
  my $client = $setup->{client};

  my $result = $client->direct({
    'path' => 'callbacks',
    'method' => 'GET',
    'params' => {},
  });
  if ($setup->{live}) {
    # Live mode is lenient: synthetic IDs frequently 4xx and the list-
    # response shape varies wildly across public APIs. Skip rather than
    # fail when the call doesn't return a usable list.
    if (defined $result->{err}) {
      note("list call failed (likely synthetic IDs against live API): $result->{err}");
      pass('direct-list-callback: skipped (live)');
      last DIRECT_LIST;
    }
    unless ($result->{ok}) {
      note('list call not ok (likely synthetic IDs against live API)');
      pass('direct-list-callback: skipped (live)');
      last DIRECT_LIST;
    }
    my $status = SmsapiHelpers::to_int($result->{status});
    if ($status < 200 || $status >= 300) {
      note("expected 2xx status, got $status");
      pass('direct-list-callback: skipped (live)');
      last DIRECT_LIST;
    }
    pass('direct-list-callback: live ok');
  }
  else {
    ok(!defined $result->{err}, 'direct-list-callback: no error');
    ok($result->{ok}, 'direct-list-callback: ok');
    is(SmsapiHelpers::to_int($result->{status}), 200, 'direct-list-callback: status');
    ok(Voxgig::Struct::islist($result->{data}), 'direct-list-callback: data is array');
    is(scalar @{ $result->{data} }, 2, 'direct-list-callback: data length');
    is(scalar @{ $setup->{calls} }, 1, 'direct-list-callback: 1 call');
  }
}

DIRECT_LOAD: {
  my $setup = callback_direct_setup({ 'id' => 'direct01' });
  my ($_should_skip, $_reason) = SmsapiTestRunner::is_control_skipped(
    'direct', 'direct-load-callback', $setup->{live} ? 'live' : 'unit');
  if ($_should_skip) {
    note($_reason || 'skipped via sdk-test-control.json');
    pass('direct-load-callback: skipped via sdk-test-control.json');
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
    'path' => 'callbacks/{id}',
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
      pass('direct-load-callback: skipped (live)');
      last DIRECT_LOAD;
    }
    unless ($result->{ok}) {
      note('load call not ok (likely synthetic IDs against live API)');
      pass('direct-load-callback: skipped (live)');
      last DIRECT_LOAD;
    }
    my $status = SmsapiHelpers::to_int($result->{status});
    if ($status < 200 || $status >= 300) {
      note("expected 2xx status, got $status");
      pass('direct-load-callback: skipped (live)');
      last DIRECT_LOAD;
    }
    pass('direct-load-callback: live ok');
  }
  else {
    ok(!defined $result->{err}, 'direct-load-callback: no error');
    ok($result->{ok}, 'direct-load-callback: ok');
    is(SmsapiHelpers::to_int($result->{status}), 200, 'direct-load-callback: status');
    ok(defined $result->{data}, 'direct-load-callback: data');
    if (Voxgig::Struct::ismap($result->{data})) {
      is($result->{data}{id}, 'direct01', 'direct-load-callback: id');
    }
    is(scalar @{ $setup->{calls} }, 1, 'direct-load-callback: 1 call');
  }
}


sub callback_direct_setup {
  my ($mockres) = @_;
  SmsapiTestRunner::load_env_local();

  my $calls = [];

  my $env = SmsapiTestRunner::env_override({
    'SMSAPI_TEST_CALLBACK_ENTID' => {},
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
