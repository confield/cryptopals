#!perl

use strict;
use warnings;

use Set1 qw(hex_to_base64);
use Test::More tests => 1;

my $string = "49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d";

my $encoded = hex_to_base64 ($string);
like($encoded, qr/SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t/);

