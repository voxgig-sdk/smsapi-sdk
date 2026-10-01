# Smsapi SDK

use strict;
use warnings;

use File::Basename ();
use Cwd ();
use Scalar::Util ();

package SmsapiSDK;

our $VERSION = '0.0.1';

our $DIR;
BEGIN { $DIR = File::Basename::dirname(Cwd::abs_path(__FILE__)) }

require(Cwd::abs_path("$DIR/Voxgig/Struct.pm"));
require(Cwd::abs_path("$DIR/../core/helpers.pm"));
require(Cwd::abs_path("$DIR/../core/utility_type.pm"));
require(Cwd::abs_path("$DIR/../core/spec.pm"));
require(Cwd::abs_path("$DIR/../core/error.pm"));

# Load utility registration
require(Cwd::abs_path("$DIR/../utility/register.pm"));

# Load config and features
require(Cwd::abs_path("$DIR/../config.pm"));
require(Cwd::abs_path("$DIR/../feature/base_feature.pm"));
require(Cwd::abs_path("$DIR/../features.pm"));

sub new {
  my ($class, $options) = @_;
  $options = {} unless defined $options;

  my $self = bless {
    mode => 'live',
    features => [],
    options => undef,
  }, $class;

  my $utility = SmsapiUtility->new;
  $self->{_utility} = $utility;

  # The process-wide config (sdkgen rung L2): read-only on the request path,
  # so every client shares one rather than rebuilding it.
  my $config = SmsapiConfig::shared_config();

  $self->{_rootctx} = $utility->{make_context}->({
    'client' => $self,
    'utility' => $utility,
    'config' => $config,
    'options' => $options,
    'shared' => {},
  }, undef);

  $self->{options} = $utility->{make_options}->($self->{_rootctx});

  if (SmsapiHelpers::is_true(
    SmsapiHelpers::gpath($self->{options}, 'feature.test.active'))) {
    $self->{mode} = 'test';
  }

  $self->{_rootctx}{options} = $self->{options};

  # Add features in the resolved order (make_options records an explicit
  # array order, else defaults to test-first). Ordering matters: the `test`
  # feature installs the base mock transport and the transport features
  # (retry/cache/netsim/proxy/ratelimit) wrap whatever is current, so `test`
  # must be added before them to sit at the base of the wrapper chain.
  my $feature_opts = SmsapiHelpers::to_map(
    SmsapiHelpers::gp($self->{options}, 'feature')) || {};
  my $featureorder = SmsapiHelpers::gpath(
    $self->{options}, '__derived__.featureorder');
  $featureorder = [] unless Voxgig::Struct::islist($featureorder);
  for my $fname (@$featureorder) {
    my $fopts = SmsapiHelpers::to_map($feature_opts->{$fname});
    if ($fopts && SmsapiHelpers::is_true($fopts->{active})) {
      $utility->{feature_add}->($self->{_rootctx},
        SmsapiFeatures::make_feature($fname));
    }
  }

  # Add extension features.
  my $extend = SmsapiHelpers::gp($self->{options}, 'extend');
  if (Voxgig::Struct::islist($extend)) {
    for my $f (@$extend) {
      if (Scalar::Util::blessed($f) && $f->can('get_name')) {
        $utility->{feature_add}->($self->{_rootctx}, $f);
      }
    }
  }

  # Initialize features.
  for my $f (@{ $self->{features} }) {
    $utility->{feature_init}->($self->{_rootctx}, $f);
  }

  $utility->{feature_hook}->($self->{_rootctx}, 'PostConstruct');

  return $self;
}

sub options_map {
  my ($self) = @_;
  my $out = Voxgig::Struct::clone($self->{options});
  return Voxgig::Struct::ismap($out) ? $out : {};
}

sub get_utility {
  my ($self) = @_;
  return SmsapiUtility->copy($self->{_utility});
}

sub get_root_ctx {
  my ($self) = @_;
  return $self->{_rootctx};
}

# The options and the root context both hold the credential, so the
# client's printed form is its name alone; `options_map` is the documented
# way to read them back.
sub TO_JSON {
  return { 'name' => 'Smsapi' };
}

sub to_string {
  my ($self) = @_;
  return 'Smsapi ' . Voxgig::Struct::jsonify($self->TO_JSON);
}

# The LIVE Sekreto instance: for arbitrary secrets and redaction.
#
#   $sdk->secrets->get('db.password')
#   $sdk->secrets->redactall($logline)
#
# Never a clone: sekreto holds provider state (caches, vault
# leases) that has to stay live to be worth anything.
sub secrets {
  my ($self) = @_;
  my $f = $self->{_secrets};
  return defined $f ? $f->sekreto : undef;
}

sub prepare {
  my ($self, $fetchargs) = @_;
  my $utility = $self->{_utility};
  $fetchargs = {} unless defined $fetchargs;

  my $ctrl = SmsapiHelpers::to_map(
    SmsapiHelpers::gp($fetchargs, 'ctrl')) || {};

  my $ctx = $utility->{make_context}->({
    'opname' => 'prepare',
    'ctrl' => $ctrl,
  }, $self->{_rootctx});

  my $opts = $self->{options};
  my $path = SmsapiHelpers::gp($fetchargs, 'path');
  $path = '' unless defined $path && !ref $path;
  my $method_val = SmsapiHelpers::gp($fetchargs, 'method');
  $method_val = 'GET' unless defined $method_val && !ref $method_val;
  my $params = SmsapiHelpers::to_map(
    SmsapiHelpers::gp($fetchargs, 'params')) || {};
  my $query = SmsapiHelpers::to_map(
    SmsapiHelpers::gp($fetchargs, 'query')) || {};
  my $headers = $utility->{prepare_headers}->($ctx);

  my $base = SmsapiHelpers::gp($opts, 'base');
  $base = '' unless defined $base && !ref $base;
  my $prefix = SmsapiHelpers::gp($opts, 'prefix');
  $prefix = '' unless defined $prefix && !ref $prefix;
  my $suffix = SmsapiHelpers::gp($opts, 'suffix');
  $suffix = '' unless defined $suffix && !ref $suffix;

  $ctx->{spec} = SmsapiSpec->new({
    'base' => $base, 'prefix' => $prefix, 'suffix' => $suffix,
    'path' => $path, 'method' => $method_val,
    'params' => $params, 'query' => $query, 'headers' => $headers,
    'body' => SmsapiHelpers::gp($fetchargs, 'body'),
    'step' => 'start',
  });

  # Merge user-provided headers.
  my $uh = SmsapiHelpers::gp($fetchargs, 'headers');
  if (Voxgig::Struct::ismap($uh)) {
    $ctx->{spec}{headers}{$_} = $uh->{$_} for keys %$uh;
  }

  my (undef, $err) = $utility->{prepare_auth}->($ctx);
  die $err if $err;

  # make_fetch_def returns a (fetchdef, err) tuple; destructure it and
  # return just the fetchdef hashref (dying on error) so callers -
  # including direct(), which indexes fetchdef->{url} - receive a hashref,
  # mirroring the ts/py/rb prepare().
  my ($fetchdef, $fd_err) = $utility->{make_fetch_def}->($ctx);
  die $fd_err if $fd_err;

  return $fetchdef;
}

# Raw endpoint access is operator-controllable, like every entity op.
# Blocking it means denying BOTH the 'direct' and 'graphql' tokens, since
# either one reaches the same endpoint.
sub direct {
  my ($self, $fetchargs) = @_;

  return $self->_op_denied('direct') unless $self->_op_allowed('direct');

  return $self->_raw_request($fetchargs);
}

# Is this raw-access op permitted by the SDK's allow.op option?
sub _op_allowed {
  my ($self, $op) = @_;
  my $allow = SmsapiHelpers::gpath($self->{options}, 'allow.op');
  return (defined $allow && !ref $allow && index($allow, $op) >= 0) ? 1 : 0;
}

sub _op_denied {
  my ($self, $op) = @_;
  my $allow = SmsapiHelpers::gpath($self->{options}, 'allow.op');
  $allow = '' unless defined $allow && !ref $allow;
  return {
    'ok' => 0,
    'err' => "SmsapiSDK: $op: operation not allowed by" .
      " SDK option allow.op value: \"$allow\"",
  };
}

# Ungated request path shared by direct and graphql, each of which checks its
# own allow.op token first. Private, rather than a flag on fetchargs: a
# caller-supplied marker would let anyone opt straight back out of the gate
# by passing it.
sub _raw_request {
  my ($self, $fetchargs) = @_;
  my $utility = $self->{_utility};

  # direct() is the raw-HTTP escape hatch: it always returns a result hash
  # ({ ok => ..., ... }) and never dies. prepare() dies on error, so trap
  # that and surface it in the hash.
  my $fetchdef = eval { $self->prepare($fetchargs) };
  if (my $prep_err = $@) {
    return { 'ok' => 0, 'err' => $prep_err };
  }

  $fetchargs = {} unless defined $fetchargs;
  my $ctrl = SmsapiHelpers::to_map(
    SmsapiHelpers::gp($fetchargs, 'ctrl')) || {};

  my $ctx = $utility->{make_context}->({
    'opname' => 'direct',
    'ctrl' => $ctrl,
  }, $self->{_rootctx});

  my $url = defined $fetchdef->{url} ? $fetchdef->{url} : '';
  my ($fetched, $fetch_err) = $utility->{fetcher}->($ctx, $url, $fetchdef);

  return { 'ok' => 0, 'err' => $utility->{clean}->($ctx, $fetch_err) } if $fetch_err;

  if (!defined $fetched) {
    return {
      'ok' => 0,
      'err' => $ctx->make_error('direct_no_response', 'response: undefined'),
    };
  }

  if (Voxgig::Struct::ismap($fetched)) {
    my $status = SmsapiHelpers::to_int(
      SmsapiHelpers::gp($fetched, 'status'));
    my $headers = SmsapiHelpers::gp($fetched, 'headers') || {};

    # No-body responses (204, 304) and explicit zero content-length must
    # skip JSON parsing - calling json() on an empty body errors.
    my $content_length = Voxgig::Struct::ismap($headers)
      ? $headers->{'content-length'} : undef;
    my $no_body = (204 == $status || 304 == $status
      || (defined $content_length && '0' eq "$content_length")) ? 1 : 0;

    my $json_data;
    unless ($no_body) {
      my $jf = SmsapiHelpers::gp($fetched, 'json');
      if (ref $jf eq 'CODE') {
        # Non-JSON body - leave data undef, keep status/headers.
        $json_data = eval { $jf->() };
      }
    }

    return {
      'ok' => ($status >= 200 && $status < 300) ? 1 : 0,
      'status' => $status,
      'headers' => $headers,
      'data' => $json_data,
    };
  }

  return {
    'ok' => 0,
    'err' => $ctx->make_error('direct_invalid', 'invalid response type'),
  };
}

# Raw GraphQL access: the pressure valve that makes the generated surface's
# deliberate omissions (per-call selection sets, typed filter builders,
# batching, subscriptions) livable — the whole schema stays reachable.
#
# Thin wrapper over the same prepare/fetch path direct uses, with the one
# thing raw direct cannot do for GraphQL: a GraphQL failure rides HTTP 200 as
# a top-level `errors` array, so status alone would report a failed query as
# ok.
#
# NOTE: like direct, this bypasses the feature pipeline — no retry, ratelimit
# or paging features apply.
sub graphql {
  my ($self, $query, $variables, $ctrl) = @_;

  return $self->_op_denied('graphql') unless $self->_op_allowed('graphql');

  my $res = $self->_raw_request({
    'method' => 'POST',
    'headers' => { 'content-type' => 'application/json' },
    'body' => {
      'query' => defined $query ? $query : '',
      'variables' => (ref $variables eq 'HASH') ? $variables : {},
    },
    'ctrl' => (ref $ctrl eq 'HASH') ? $ctrl : {},
  });

  return $res unless ref $res eq 'HASH';

  # Errors are read BEFORE any status check: a GraphQL parse or validation
  # failure comes back as HTTP 400 carrying the standard { errors: [...] }
  # body, and the raw path represents a non-2xx as ok:0 with no err — so
  # returning early on status would discard the server's own diagnostics,
  # which are the only useful part of that response.
  my $errors = SmsapiHelpers::gpath($res, 'data.errors');

  if (ref $errors eq 'ARRAY' && 0 < scalar @$errors) {
    my $first = $errors->[0];
    my $msg = (ref $first eq 'HASH') ? $first->{'message'} : undef;
    $msg = 'graphql error' unless defined $msg && $msg ne '';
    $res->{'ok'} = 0;
    $res->{'err'} = "SmsapiSDK: graphql: $msg";
    $res->{'graphql'} = $errors;
  }

  return $res;
}


# Canonical facade: $client->Available->list / ->load({ 'id' => ... })
sub Available {
  my ($self, $data) = @_;
  require(Cwd::abs_path("$DIR/../entity/available_entity.pm"));
  return AvailableEntity->new($self, $data);
}


# Canonical facade: $client->Blacklist->list / ->load({ 'id' => ... })
sub Blacklist {
  my ($self, $data) = @_;
  require(Cwd::abs_path("$DIR/../entity/blacklist_entity.pm"));
  return BlacklistEntity->new($self, $data);
}


# Canonical facade: $client->Callback->list / ->load({ 'id' => ... })
sub Callback {
  my ($self, $data) = @_;
  require(Cwd::abs_path("$DIR/../entity/callback_entity.pm"));
  return CallbackEntity->new($self, $data);
}


# Canonical facade: $client->Contact->list / ->load({ 'id' => ... })
sub Contact {
  my ($self, $data) = @_;
  require(Cwd::abs_path("$DIR/../entity/contact_entity.pm"));
  return ContactEntity->new($self, $data);
}


# Canonical facade: $client->ContactsField->list / ->load({ 'id' => ... })
sub ContactsField {
  my ($self, $data) = @_;
  require(Cwd::abs_path("$DIR/../entity/contacts_field_entity.pm"));
  return ContactsFieldEntity->new($self, $data);
}


# Canonical facade: $client->ContactsFieldOption->list / ->load({ 'id' => ... })
sub ContactsFieldOption {
  my ($self, $data) = @_;
  require(Cwd::abs_path("$DIR/../entity/contacts_field_option_entity.pm"));
  return ContactsFieldOptionEntity->new($self, $data);
}


# Canonical facade: $client->Contactsgroup->list / ->load({ 'id' => ... })
sub Contactsgroup {
  my ($self, $data) = @_;
  require(Cwd::abs_path("$DIR/../entity/contactsgroup_entity.pm"));
  return ContactsgroupEntity->new($self, $data);
}


# Canonical facade: $client->Contactstrash->list / ->load({ 'id' => ... })
sub Contactstrash {
  my ($self, $data) = @_;
  require(Cwd::abs_path("$DIR/../entity/contactstrash_entity.pm"));
  return ContactstrashEntity->new($self, $data);
}


# Canonical facade: $client->FieldAvailable->list / ->load({ 'id' => ... })
sub FieldAvailable {
  my ($self, $data) = @_;
  require(Cwd::abs_path("$DIR/../entity/field_available_entity.pm"));
  return FieldAvailableEntity->new($self, $data);
}


# Canonical facade: $client->Group->list / ->load({ 'id' => ... })
sub Group {
  my ($self, $data) = @_;
  require(Cwd::abs_path("$DIR/../entity/group_entity.pm"));
  return GroupEntity->new($self, $data);
}


# Canonical facade: $client->MfaCode->list / ->load({ 'id' => ... })
sub MfaCode {
  my ($self, $data) = @_;
  require(Cwd::abs_path("$DIR/../entity/mfa_code_entity.pm"));
  return MfaCodeEntity->new($self, $data);
}


# Canonical facade: $client->OptOut->list / ->load({ 'id' => ... })
sub OptOut {
  my ($self, $data) = @_;
  require(Cwd::abs_path("$DIR/../entity/opt_out_entity.pm"));
  return OptOutEntity->new($self, $data);
}


# Canonical facade: $client->OptOutSetting->list / ->load({ 'id' => ... })
sub OptOutSetting {
  my ($self, $data) = @_;
  require(Cwd::abs_path("$DIR/../entity/opt_out_setting_entity.pm"));
  return OptOutSettingEntity->new($self, $data);
}


# Canonical facade: $client->Permission->list / ->load({ 'id' => ... })
sub Permission {
  my ($self, $data) = @_;
  require(Cwd::abs_path("$DIR/../entity/permission_entity.pm"));
  return PermissionEntity->new($self, $data);
}


# Canonical facade: $client->Ping->list / ->load({ 'id' => ... })
sub Ping {
  my ($self, $data) = @_;
  require(Cwd::abs_path("$DIR/../entity/ping_entity.pm"));
  return PingEntity->new($self, $data);
}


# Canonical facade: $client->Profile->list / ->load({ 'id' => ... })
sub Profile {
  my ($self, $data) = @_;
  require(Cwd::abs_path("$DIR/../entity/profile_entity.pm"));
  return ProfileEntity->new($self, $data);
}


# Canonical facade: $client->Rcs->list / ->load({ 'id' => ... })
sub Rcs {
  my ($self, $data) = @_;
  require(Cwd::abs_path("$DIR/../entity/rcs_entity.pm"));
  return RcsEntity->new($self, $data);
}


# Canonical facade: $client->Sendername->list / ->load({ 'id' => ... })
sub Sendername {
  my ($self, $data) = @_;
  require(Cwd::abs_path("$DIR/../entity/sendername_entity.pm"));
  return SendernameEntity->new($self, $data);
}


# Canonical facade: $client->SendernameStatement->list / ->load({ 'id' => ... })
sub SendernameStatement {
  my ($self, $data) = @_;
  require(Cwd::abs_path("$DIR/../entity/sendername_statement_entity.pm"));
  return SendernameStatementEntity->new($self, $data);
}


# Canonical facade: $client->SentRcsMessage->list / ->load({ 'id' => ... })
sub SentRcsMessage {
  my ($self, $data) = @_;
  require(Cwd::abs_path("$DIR/../entity/sent_rcs_message_entity.pm"));
  return SentRcsMessageEntity->new($self, $data);
}


# Canonical facade: $client->ShipmentCountryVolume->list / ->load({ 'id' => ... })
sub ShipmentCountryVolume {
  my ($self, $data) = @_;
  require(Cwd::abs_path("$DIR/../entity/shipment_country_volume_entity.pm"));
  return ShipmentCountryVolumeEntity->new($self, $data);
}


# Canonical facade: $client->ShortUrl->list / ->load({ 'id' => ... })
sub ShortUrl {
  my ($self, $data) = @_;
  require(Cwd::abs_path("$DIR/../entity/short_url_entity.pm"));
  return ShortUrlEntity->new($self, $data);
}


# Canonical facade: $client->Smsdo->list / ->load({ 'id' => ... })
sub Smsdo {
  my ($self, $data) = @_;
  require(Cwd::abs_path("$DIR/../entity/smsdo_entity.pm"));
  return SmsdoEntity->new($self, $data);
}


# Canonical facade: $client->Smssendername->list / ->load({ 'id' => ... })
sub Smssendername {
  my ($self, $data) = @_;
  require(Cwd::abs_path("$DIR/../entity/smssendername_entity.pm"));
  return SmssendernameEntity->new($self, $data);
}


# Canonical facade: $client->Smstemplate->list / ->load({ 'id' => ... })
sub Smstemplate {
  my ($self, $data) = @_;
  require(Cwd::abs_path("$DIR/../entity/smstemplate_entity.pm"));
  return SmstemplateEntity->new($self, $data);
}


# Canonical facade: $client->Subuser->list / ->load({ 'id' => ... })
sub Subuser {
  my ($self, $data) = @_;
  require(Cwd::abs_path("$DIR/../entity/subuser_entity.pm"));
  return SubuserEntity->new($self, $data);
}


# Canonical facade: $client->Template->list / ->load({ 'id' => ... })
sub Template {
  my ($self, $data) = @_;
  require(Cwd::abs_path("$DIR/../entity/template_entity.pm"));
  return TemplateEntity->new($self, $data);
}


# Canonical facade: $client->UserRcsSenderCollection->list / ->load({ 'id' => ... })
sub UserRcsSenderCollection {
  my ($self, $data) = @_;
  require(Cwd::abs_path("$DIR/../entity/user_rcs_sender_collection_entity.pm"));
  return UserRcsSenderCollectionEntity->new($self, $data);
}



sub test {
  my ($class, $testopts, $sdkopts) = @_;
  $sdkopts = {} unless defined $sdkopts;
  $sdkopts = Voxgig::Struct::clone($sdkopts);
  $sdkopts = {} unless Voxgig::Struct::ismap($sdkopts);

  $testopts = {} unless defined $testopts;
  $testopts = Voxgig::Struct::clone($testopts);
  $testopts = {} unless Voxgig::Struct::ismap($testopts);
  $testopts->{active} = Voxgig::Struct::JTRUE();

  Voxgig::Struct::setpath($sdkopts, 'feature.test', $testopts);

  my $sdk = $class->new($sdkopts);
  $sdk->{mode} = 'test';
  return $sdk;
}

1;
