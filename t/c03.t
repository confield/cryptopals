#!perl

use strict;
use warnings;

use Set1 qw(break_single_byte_xor);
use Test::More tests => 1;

my $str1 = '1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736';
my $text1 = break_single_byte_xor(cyphertext => $str1);

like($text1,qr/Cooking MC's like a pound of bacon/);
