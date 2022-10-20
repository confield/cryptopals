package Set1;

use v5.22;
use strictures 2;
use MIME::Base64;
use base 'Exporter';
our @EXPORT_OK = qw (hex_to_base64);

sub hex_to_base64 {
    my ($hex_str) = @_;
    my $encoded =  encode_base64(pack('H*', $hex_str));
    return $encoded;
}

