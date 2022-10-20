package Set1;

use v5.22;
use strictures 2;
use Carp;
use MIME::Base64;
use base 'Exporter';
our @EXPORT_OK = qw (hex_to_base64 fixed_xor break_single_byte_xor repeating_key_xor);

open  DIC, 'common_words.txt';
my %dic;
while (<DIC>) {chomp;$dic{$_} = 1}

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

sub break_single_byte_xor {
    return unless @_;

    my %args = @_;
    my @res;
    push @res,get_plain_text($args{cyphertext}) if $args{cyphertext};
    if ($args{filename}) {
	open my $fh, $args{filename} or die;
	my $p_text;
	while (<$fh>) {
	    chomp;
	    $p_text = get_plain_text($_);
	    push @res,$p_text if $p_text;
	}

    }
    @res = sort {split(/ /, $b) cmp split(/ /, $a)} @res;

    return $res[0];
}

sub score {
    my ($plain_text) = @_;
    my $plain_text_score = 0;
    my  @words = split / /, $plain_text;
    for (@words) {$plain_text_score +=  $dic{$_} if $dic{$_}}
    return $plain_text_score;

}

sub get_plain_text {
    my ($str1) = @_;
    my ($cdec_text, $cdec_text_score,$text);
    my $text_score = 0;
    for (0 .. 128) {
	$cdec_text = pack('H*',fixed_xor($str1,sprintf('%02x',$_)x int((length($str1)/2))));
	$cdec_text_score = score($cdec_text);
	if ($cdec_text_score > $text_score) {
	    $text_score = $cdec_text_score;
	    $text = $cdec_text;

	}

    }
    return $text;
}

sub repeating_key_xor {
    my %args = @_;
    croak ' repeating_key_xor Needs two arguments: plaintext and key'
	unless (defined ($args{plaintext}) and defined $args{key});
    my @key = split(//, $args{key});
    my $key_len = scalar(@key);
    my @plaintext =  split(//,$args{plaintext});
    my $res = '';
    for my $i ( 0 .. @plaintext - 1) {
	$res = $res .  sprintf '%02x',ord($plaintext[$i]) ^ ord( $key[$i % $key_len]);


    }
    return $res;

}

1;
