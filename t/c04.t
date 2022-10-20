#!perl

use strict;
use warnings;

use Set1 qw(break_single_byte_xor);
use Test::More tests => 1;

my $file = '4.txt';

my $text = break_single_byte_xor(filename => $file);

like($text,qr/Now that the party is jumping/);
