#!perl

use strict;
use warnings;

use Set1 qw(fixed_xor);
use Test::More tests => 1;

my $str2 = "1c0111001f010100061a024b53535009181c";
my $str3 = "686974207468652062756c6c277320657965";
my $res = fixed_xor($str2,$str3);
like($res, qr/746865206b696420646f6e277420706c6179/);
