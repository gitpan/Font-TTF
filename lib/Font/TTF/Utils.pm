package Font::TTF::Utils;

=head1 NAME

Font::TTF::Utils - Utility functions to save fingers

=head1 DESCRIPTION

Lots of useful functions to save my fingers, especially for trivial tables

=head1 FUNCTIONS

The following functions are exported

=cut

use strict;
use vars qw(@ISA @EXPORT $VERSION);
require Exporter;

@ISA = qw(Exporter);
@EXPORT = qw(TTF_Init_Fields TTF_Read_Fields TTF_Out_Fields TTF_Pack
             TTF_Unpack TTF_word_utf8 TTF_utf8_word);
$VERSION = 0.0001;

=head2 ($val, $pos) = TTF_Init_Fields ($str, $pos)

Given a field description from the C<DATA> section, creates an absolute entry
in the fields associative array for the class

=cut

sub TTF_Init_Fields
{
    my ($str, $pos) = @_;
    my ($key, $val, $res, $len, $rel);

    $str =~ s/\r?\n$//o;   
    ($key, $val) = split(',\s*', $str);
    return (undef, undef, 0) unless (defined $key && $key ne "");
    if ($val =~ m/^(\+?)(\d*)(\D+)(\d*)/oi)
    {
        $rel = $1;
        if ($rel eq "+")
        { $pos += $2; }
        elsif ($2 ne "")
        { $pos = $2; }
        $val = $3;
        $len = $4;
    }
    $len = "" unless defined $len;
    $pos = 0 if !defined $pos || $pos eq "";
    $res = "$pos:$val:$len";
    if ($val eq "f" || $val =~ m/^[l]/oi)
    { $pos += 4 * ($len ne "" ? $len : 1); }
    elsif ($val eq "F" || $val =~ m/^[s]/oi)
    { $pos += 2 * ($len ne "" ? $len : 1); }
    else
    { $pos += 1 * ($len ne "" ? $len : 1); }

    ($key, $res, $pos);
}


=head2 TTF_Read_Fields($obj, $dat, $fields)

Given a block of data large enough to account for all the fields in a table,
processes the data block to convert to the values in the objects instance
variables by name based on the list in the C<DATA> block which has been run
through C<TTF_Init_Fields>

=cut

sub TTF_Read_Fields
{
    my ($self, $dat, $fields) = @_;
    my ($pos, $type, $res, $f, $arrlen, $arr, $frac);

    foreach $f (keys %{$fields})
    {
        ($pos, $type, $arrlen) = split(':', $fields->{$f});
        $pos = 0 if $pos eq "";
        if ($arrlen ne "")
        { $self->{$f} = [TTF_Unpack("$type$arrlen", substr($dat, $pos))]; }
        else
        { $self->{$f} = TTF_Unpack("$type", substr($dat, $pos)); }
    }
    $self;
}


=head2 TTF_Unpack($fmt, $dat)

A TrueType types equivalent of Perls C<unpack> function. Thus $fmt consists of
type followed by an optional number of elements to read including *. The type
may be one of:

    c       BYTE
    C       CHAR
    f       FIXED
    F       F2DOT14
    l       LONG
    L       ULONG
    s       SHORT
    S       USHORT

Note that C<FUNIT>, C<FWORD> and C<UFWORD> are not data types but units.

Returns array of scalar (first element) depending on context

=cut

sub TTF_Unpack
{
    my ($fmt, $dat) = @_;
    my ($res, $frac, $i, $arrlen, $type, @res);

    while ($fmt =~ s/^([cfls])(\d+|\*)?//oi)
    {
        $type = $1;
        $arrlen = $2;
        $arrlen = 1 if !defined $arrlen || $arrlen eq "";
        $arrlen = -1 if $arrlen eq "*";

        for ($i = 0; ($arrlen == -1 && $dat ne "") || $i < $arrlen; $i++)
        {
            if ($type eq "f")
            {
                ($res, $frac) = unpack("nn", $dat);
                substr($dat, 0, 4) = "";
                $res -= 65536 if $res > 32767;
                $res += $frac / 65536.;
            }
            elsif ($type eq "F")
            {
                $res = unpack("n", $dat);
                substr($dat, 0, 2) = "";
                $res -= 65536 if $res >= 32768;
                $frac = $res & 0x3fff;
                $res >>= 14;
#                $res -= 4 if $res > 1;
#                $frac -= 16384 if $frac > 8191;
                $res += $frac / 16384.;
            }
            elsif ($type =~ m/^[l]/oi)
            {
                $res = unpack("N", $dat);
                substr($dat, 0, 4) = "";
                $res -= (1 << 32) if ($type eq "l" && $res >= 1 << 31);
            }
            elsif ($type =~ m/^[s]/oi)
            {
                $res = unpack("n", $dat);
                substr($dat, 0, 2) = "";
                $res -= 65536 if ($type eq "s" && $res >= 32768);
            }
            elsif ($type eq "c")
            {
                $res = unpack("c", $dat);
                substr($dat, 0, 1) = "";
            }
            else
            {
                $res = unpack("C", $dat);
                substr($dat, 0, 1) = "";
            }
            push (@res, $res);
        }
    }
    return wantarray ? @res : $res[0];
}


=head2 $dat = TTF_Out_Fields($obj, $fields, $len)

Given the fields table from C<TTF_Init_Fields> writes out the instance variables from
the object to the filehandle in TTF binary form.

=cut

sub TTF_Out_Fields
{
    my ($obj, $fields, $len) = @_;
    my ($dat) = "\000" x $len;
    my ($f, $pos, $type, $res, $arr, $arrlen, $frac);
    
    foreach $f (keys %{$fields})
    {
        ($pos, $type, $arrlen) = split(':', $fields->{$f});
        if ($arrlen ne "")
        { $res = TTF_Pack("$type$arrlen", @{$obj->{$f}}); }
        else
        { $res = TTF_Pack("$type", $obj->{$f}); }
        substr($dat, $pos, length($res)) = $res;
    }
    $dat;
}


=head2 $dat = TTF_Pack($fmt, @data)

The TrueType equivalent to Perl's C<pack> function. See details of C<TTF_Unpack>
for how to work the $fmt string.

=cut

sub TTF_Pack
{
    my ($fmt, @obj) = @_;
    my ($type, $i, $arrlen, $dat, $res, $frac);

    while ($fmt =~ s/^([flsc])(\d+|\*)?//oi)
    {
        $type = $1;
        $arrlen = $2 || "";
        $arrlen = $#obj + 1 if $arrlen eq "*";
        $arrlen = 1 if $arrlen eq "";
    
        for ($i = 0; $i < $arrlen; $i++)
        {
            $res = shift(@obj);
            if ($type eq "f")
            {
                $frac = int(($res - int($res)) * 65536);
                $res = (int($res) << 16) + $frac;
                $dat .= pack("N", $res);
            }
            elsif ($type eq "F")
            {
                $frac = int(($res - int($res)) * 16384);
                $res = (int($res) << 14) + $frac;
                $dat .= pack("n", $res);
            }
            elsif ($type =~ m/^[l]/oi)
            {
                $res += 1 << 32 if $res < 0;
                $dat .= pack("N", $res);
            }
            elsif ($type =~ m/^[s]/oi)
            {
                $res += 1 << 16 if $res < 0;
                $dat .= pack("n", $res);
            }
            elsif ($type eq "c")
            { $dat .= pack("c", $res); }
            else
            { $dat .= pack("C", $res); }
        }
    }
    $dat;
}


=head2 ($num, $range, $select, $shift) = TTF_bininfo($num)

Calculates binary search information from a number of elements

=cut

sub TTF_bininfo
{
    my ($num, $block) = @_;
    my ($range, $select, $shift);

    $range = 1;
    for ($select = 0; $range <= $num; $select++)
    { $range *= 2; }
    $select--; $range /= 2;
    $range *= $block;

    $shift = $num * $block - $range;
    ($num, $range, $select, $shift);
}


=head2 TTF_word_utf8($str)

Returns the UTF8 form of the 16 bit string, assumed to be in big endian order,
including surrogate handling

=cut

sub TTF_word_utf8
{
    my ($str) = @_;
    my ($res, $i);
    my (@dat) = unpack("n*", $str);

    return pack("U*", @dat) if ($^V ge v5.6.0);
    for ($i = 0; $i <= $#dat; $i++)
    {
        my ($dat) = $dat[$i];
        if ($dat < 0x80)        # Thanks to Gisle Aas for some of his old code
        { $res .= chr($dat); }
        elsif ($dat < 0x800)
        { $res .= chr(0xC0 | ($dat >> 6)) . chr(0x80 | ($dat & 0x3F)); }
        elsif ($dat >= 0xD800 && $dat < 0xDC00)
        {
            my ($dat1) = $dat[++$i];
            my ($top) = (($dat & 0x3C0) >> 6) + 1;
            $res .= chr(0xF0 | ($top >> 2))
                  . chr(0x80 | (($top & 1) << 4) | (($dat & 0x3C) >> 2))
                  . chr(0x80 | (($dat & 0x3) << 4) | (($dat1 & 0x3C0) >> 6))
                  . chr(0x80 | ($dat1 & 0x3F));
        } else
        { $res .= chr(0xE0 | ($dat >> 12)) . chr(0x80 | (($dat >> 6) & 0x3F))
                . chr(0x80 | ($dat & 0x3F)); }
    }
    $res;
}


=head2 TTF_utf8_word($str)

Returns the 16-bit form in big endian order of the UTF 8 string, including
surrogate handling to Unicode.

=cut

sub TTF_utf8_word
{
    my ($str) = @_;
    my ($res);

    return pack("n*", unpack("U*", $str)) if ($^V ge v5.6.0);
    $str = "$str";              # copy $str
    while (length($str))        # Thanks to Gisle Aas for some of his old code
    {
        $str =~ s/^[\x80-\xBF]+//o;
        if ($str =~ s/^([\x00-\x7F]+)//o)
        { $res .= pack("n*", unpack("C*", $1)); }
        elsif ($str =~ s/^([\xC0-\xDF])([\x80-\xBF])//o)
        { $res .= pack("n", ((ord($1) & 0x1F) << 6) | (ord($2) & 0x3F)); }
        elsif ($str =~ s/^([\0xE0-\xEF])([\x80-\xBF])([\x80-\xBF])//o)
        { $res .= pack("n", ((ord($1) & 0x0F) << 12)
                          | ((ord($2) & 0x3F) << 6)
                          | (ord($3) & 0x3F)); }
        elsif ($str =~ s/^([\xF0-\xF7])([\x80-\xBF])([\x80-\xBF])([\x80-\xBF])//o)
        {
            my ($b1, $b2, $b3, $b4) = (ord($1), ord($2), ord($3), ord($4));
            $res .= pack("n", ((($b1 & 0x07) << 8) | (($b2 & 0x3F) << 2)
                            | (($b3 & 0x30) >> 4)) + 0xD600);  # account for offset
            $res .= pack("n", ((($b3 & 0x0F) << 6) | ($b4 & 0x3F)) + 0xDC00);
        }
        elsif ($str =~ s/^[\xF8-\xFF][\x80-\xBF]*//o)
        { }
    }
    $res;
}
            
1;

=head1 BUGS

No known bugs

=head1 AUTHOR

Martin Hosken Martin_Hosken@sil.org. See L<Font::TTF::Font> for copyright and
licensing.

=cut

