#! perl
#   Title:          HACKOS2.BAT
#   Author:         M. Hosken
#   Description:
# 1.001 MJPH    05-AUG-1997     Fix &makestr() to work properly
# 1.002 MJPH    06-AUG-1997     Add -d & -q support
# 1.1   MJPH    22-MAR-1998     Add -f support
# 1.2   MJPH    11-JUN-1999     Add -t support
# 1.3   MJPH     9-AUG-1999     Fix -d glob
# 1.4   MJPH    17-FEB-2000     Fix typo for type 1 tables
# 1.5   MJPH    19-SEP-2000     Add -n, -x
# 1.6   MJPH    10-NOV-2000     Add -v

require 'ttfmod.pl';
require 'getopts.pl';
do Getopts("c:d:f:n:p:qt:u:v:x:");

$[ = 0;
if ((defined $opt_d && !defined $ARGV[0]) || (!defined $opt_d && !defined $ARGV[1]))
    {
    die 'HACKOS2 [-c hex] [-d directory] [-f fsSelection] [-p hex] [-q]
        [-t num] [-u hex] <infile> <outfile>

v1.6.0, 10-NOV-2000  (c) martin_hosken@sil.org

Hacks the OS/2 table of a ttf file copying from infile to outfile.
    -c      change codepage information (a 64 bit hex number)
    -d      specifies output directory for processing multiple files. In which
            case <outfile> is not used and <infile> may be a list including
            wildcards.
    -f      fsSelection value (16 bit hex) (e.g. 4240 for Thai fonts)
    -n      sets usFirstCharIndex given a hex value
    -p      change panose info
                (10 bytes of hex in reverse order: 0A090807060504030201)
    -q      Quiet mode (do not list names as they are processed)
    -t      Sets fsType (embedding) information (decimal)
    -u      change unicode info (a 128 bit hex number)
    -v      sets vendor tag to the first 4 chars of the string
    -x      sets usLastCharIndex given a hex value

For example, to convert a Win3.1 ANSI font to Win95 use the following:
    hackos2 -c01 -u03 old.ttf new.ttf
or for a Symbol font use:
    hackos2 -c80000000 -u0 old.ttf new.ttf
Or to revert:
    hackos2 -cnone other.ttf new.ttf
';
    }

$old = select(STDERR); $| = 1; select($old);

if ($opt_c =~ m/^none/oi)
    {
    undef $opt_c;
    $revert = 1;
    }
else
    { $revert = 0; }

$fns{"OS/2"} = "hackos2";

if (defined $opt_d)
    {
    foreach $a (@ARGV)
        {
        foreach $f (glob($a))
            {
            print STDERR "$f -> $opt_d/$f\n" unless (defined $opt_q);
            &ttfmod($f, "$opt_d/$f", *fns);
            }
        }
    }
else
    {
    &ttfmod($ARGV[0], $ARGV[1], *fns);
    }

sub hackos2
    {
    local(*INFILE, *OUTFILE, $len) = @_;
    local($csum);

    read(INFILE, $dat, 78);
    $ver = unpack("n", substr($dat, 0, 2));
    if ($revert)
        {
        if ($ver == 1)
            {
            substr($dat, 0, 2) = pack("n", 0);
            $len = 78;
            }
        }
    else
        {
        if ($ver == 1)
            {
            read(INFILE, $dat1, 8);
            $dat .= $dat1;
            }
        elsif (defined $opt_c)
            {
            substr($dat, 0, 2) = pack("n", 1);
            $dat .= pack("x8", 0);
            $len = 86;
            }
        }
    if (defined $opt_c)
        { substr($dat, 78, 8) = &makestr($opt_c, 8, 4); }
#                pack("NN", unpack("LL", &makestr($opt_c, 8))); }
    if (defined $opt_p)
        { substr($dat, 32, 10) = &makestr($opt_p, 10, 1); }
    if (defined $opt_u)
        { substr($dat, 42, 16) = &makestr($opt_u, 16, 4); }
#                pack("NNNN", unpack("LLLL", &makestr($opt_u, 16))); }
    if (defined $opt_f)
        { substr($dat, 62, 2) = &makestr($opt_f, 2, 2); }
    if (defined $opt_t)
        { substr($dat, 8, 2) = pack("n", $opt_t); }
    if (defined $opt_n)
        { substr($dat, 64, 2) = &makestr($opt_n, 2, 2); }
    if (defined $opt_x)
        { substr($dat, 66, 2) = &makestr($opt_x, 2, 2); }
    if (defined $opt_v)
        { substr($dat, 58, 4) = pack("A4", $opt_v); }
    $csum = unpack("%32N", $dat);
    print OUTFILE $dat;
    ($len, $csum);
    }

# &makestr($string, $number_of_bytes, $granule)
#   converts $string as a big hex number into a packed string no longer than
#   $number_of_bytes long. The string is then swapped on the $granule byte
#   boundary so that the least significant bundle comes first. This is unless
#   $granule is 0 or -ve.
#
#   returns its string in Network order.

sub makestr
    {
    local($str, $len, $group) = @_;
    local($res, $have, $temp);

    $have = length($str);
    if ($have % 2)
        {
        $str = "0" . $str;
        $have++;
        }
    $have >>= 1;
    $have = $len if ($have > $len);
    $res = "\000" x ($len - $have);
    for ($i = 0; $i < $have; $i++)
        { $res .= pack("C", hex(substr($str, $i << 1, 2))); }
    if ($group > 0)
        {
        $temp = "";
        for ($i = 0; $i < $len / $group; $i++)
            {
            $temp = substr($res, $i * $group, $group) . $temp;
            }
        $res = $temp;
        }
    ($res);
    }


