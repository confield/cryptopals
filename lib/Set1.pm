package Set1;

use v5.22;
use strictures 2;
use MIME::Base64;
use base 'Exporter';
our @EXPORT_OK = qw (hex_to_base64 fixed_xor);

sub hex_to_base64 {
    my ($hex_str) = @_;
    my $encoded =  encode_base64(pack('H*', $hex_str));
    return $encoded;
}

sub fixed_xor {
    my ($str1,$str2) = @_;

    my @hex_str1 = split(//, pack('H*', $str1));
    my @hex_str2 = split(//, pack('H*', $str2));
    my $buf_len = scalar (@hex_str1)  < scalar (@hex_str2)
	? scalar(@hex_str1)
	: scalar(@hex_str2);

    my $res = '';
    $res = $res . sprintf '%x', ord($hex_str1[$_]) ^ ord($hex_str2[$_]) for 0 .. $buf_len - 1;

    return $res;

}
