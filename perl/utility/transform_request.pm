# Smsapi SDK utility: transform_request

use strict;
use warnings;

use File::Basename ();
use Cwd ();

my $__dir;
BEGIN { $__dir = File::Basename::dirname(Cwd::abs_path(__FILE__)) }
require(Cwd::abs_path("$__dir/../lib/Voxgig/Struct.pm"));
require(Cwd::abs_path("$__dir/../core/helpers.pm"));

package SmsapiUtilities;

our %REGISTRY;

# `$action` selects the point (see make_point); it is never an API field, so
# the body is a copy without it. The caller's hash is left untouched.
my $omit = sub {
  my ($reqdata, @names) = @_;
  return $reqdata unless 'HASH' eq ref $reqdata && grep { exists $reqdata->{$_} } @names;
  my %body = %$reqdata;
  delete @body{@names};
  return \%body;
};

my $strip_action = sub { $omit->($_[0], '$action') };

# A header argument travels as a header, which prepare_headers sends, so the
# body is built from the request data without it.
my $header_arg_names = sub {
  my ($point) = @_;
  my $hl = $point ? SmsapiHelpers::gpath($point, 'args.header') : undef;
  return () unless Voxgig::Struct::islist($hl);
  return grep { defined $_ && !ref $_ && '' ne $_ } map { SmsapiHelpers::gp($_, 'name') } @$hl;
};

$REGISTRY{transform_request} = sub {
  my ($ctx) = @_;
  my $spec = $ctx->{spec};
  my $point = $ctx->{point};
  $spec->{step} = 'reqform' if $spec;
  my $data = $omit->($ctx->{reqdata}, $header_arg_names->($point));
  my $transform = SmsapiHelpers::to_map(SmsapiHelpers::gp($point, 'transform'));
  return $strip_action->($data) unless $transform;
  my $reqform = SmsapiHelpers::gp($transform, 'req');
  return $strip_action->($data) unless SmsapiHelpers::rb_truthy($reqform);
  return $strip_action->(Voxgig::Struct::transform({ 'reqdata' => $data }, $reqform));
};

1;
