@rem = ('--*-Perl-*--
@echo off
if not exist %0 goto n1
perl %0 %1 %2 %3 %4 %5 %6 %7 %8 %9
goto endofperl
:n1
if not exist %0.bat goto n2
perl %0.bat %1 %2 %3 %4 %5 %6 %7 %8 %9
goto endofperl
:n2
perl -S %0.bat %1 %2 %3 %4 %5 %6 %7 %8 %9
goto endofperl
@rem ') if 0;

use Font::TTF::Font;
require 'getopts.pl';
Getopts('m:');

unless (defined $ARGV[1])
{
    die <<'EOT';
    EUROFIX [-m num] infile outfile
Edits a font to account for the change in codepage 1252 definition in Win98,
NT5 and all things new then. -m specifies that the Mac hack should also be done.

The following changes are made:
    glyph at U+0080 copied to U+20AC                Euro sign
    glyph at U+008E copied to U+017D                Z caron
    glyph at U+009E copied to U+017E                z caron

For the Mac table
    glyph at U+0080 (in MS table) copied to num    Euro sign
    (-m may be for 240 or 211 depending on Apple or MS)

Copies are only made if there is no glyph there already.    
EOT
}

$f = Font::TTF::Font->open($ARGV[0]);
$f->{'cmap'}->read;

copy_cmap($f, 0x0080, 0x20AC, $opt_m);
copy_cmap($f, 0x008E, 0x017D, 0);
copy_cmap($f, 0x009E, 0x017E, 0);

$f->out($ARGV[1]);



sub copy_cmap
{
    my ($f, $from, $to, $mac) = @_;
    my ($gnum, $i, $t);
    
    $gnum = $f->{'cmap'}->ms_lookup($from) || return undef;

    # Work through the tables hacking:
    for ($i = 0; $i < $f->{'cmap'}{'Num'}; $i++)
    {
        $t = $f->{'cmap'}{'Tables'}[$i];
        if ($mac && $t->{'Platform'} == 1 && $t->{'Encoding'} == 0)
        { $t->{'val'}->add_segment($mac, 0, $gnum); }                # Mac
        elsif (($t->{'Platform'} == 0 && $t->{'Encoding'} == 0)
                || ($t->{'Platform'} == 3 && $t->{'Encoding'} == 1))
        { $t->{'val'}->add_segment($to, 0, $gnum); }              # ISO or MS   
    }
    $f;
}


__END__
:endofperl
