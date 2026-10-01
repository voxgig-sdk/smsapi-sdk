# Smsapi SDK utility: prepare_headers

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

$REGISTRY{prepare_headers} = sub {
  my ($ctx) = @_;
  my $options = $ctx->{client}->options_map;
  my $headers = SmsapiHelpers::gp($options, 'headers');
  my $out = SmsapiHelpers::rb_truthy($headers) ? Voxgig::Struct::clone($headers) : {};
  $out = {} unless Voxgig::Struct::ismap($out);
  # A header parameter travels as a header, under the name the definition
  # gives it, and only from this call's own arguments. It replaces a default
  # of the same name, whatever its case.
  my $hl = $ctx->{point} ? SmsapiHelpers::gpath($ctx->{point}, 'args.header') : undef;
  if (Voxgig::Struct::islist($hl)) {
    for my $hd (@$hl) {
      my $name = SmsapiHelpers::gp($hd, 'name');
      next unless defined $name && !ref $name && '' ne $name;
      my $orig = SmsapiHelpers::gp($hd, 'orig');
      $orig = $name unless defined $orig && !ref $orig && '' ne $orig;
      my $val = SmsapiHelpers::gp($ctx->{reqmatch} || {}, $name);
      $val = SmsapiHelpers::gp($ctx->{reqdata} || {}, $name) unless defined $val;
      next unless defined $val;
      my $wire = lc $orig;
      delete $out->{$_} for grep { lc $_ eq $wire } keys %$out;
      $out->{$wire} = Voxgig::Struct::stringify($val);
    }
  }
  return $out;
};

1;
