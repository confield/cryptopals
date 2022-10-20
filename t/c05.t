#!perl

use strict;
use warnings;

use Set1 qw(repeating_key_xor);
use Test::More tests => 1;

my $plaintext = "Burning 'em, if you ain't quick and nimble
I go crazy when I hear a cymbal";
my $enctext = repeating_key_xor(plaintext => $plaintext, key => "ICE");

cmp_ok($enctext, 'eq', '0b3637272a2b2e63622c2e69692a23693a2a3c6324202d623d63343c2a26226324272765272a282b2f20430a652e2c652a3124333a653e2b2027630c692b20283165286326302e27282f');
