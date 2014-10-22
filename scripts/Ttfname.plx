
#   Title:      TTFNAME.BAT
#   Author:     M. Hosken
#   Description: Change the family name of a font, thus changing full font
#                name.
#   Requirement: PERL 4 or PERL 5. TTFMOD.PL should come with this.
#
# 1.1   MJPH    20-MAR-1998     Add -l, -s

require 'ttfmod.pl';
require 'getopts.pl';
do Getopts("f:l:n:qs:t:");


if (!defined $ARGV[1] || !defined $opt_n)
    {
    die 'TTFNAME [-f "new_full_name"] -n "new_name" [-t num] [-q] <infile> <outfile>

v1.1.0, 20-Mar-1998  (c) Martin_Hosken@sil.org

    Renames the TTF with the given name and outputs the newly named font to
<outfile>.
        -f "name"   specifies new full name (optional) as opposed to the
                    default calculated form.
        -l lang     language number to use (default all langs)
        -n "name"   specifies new font family name (not optional)
        -q          disable signon message
        -s filename overrides -n and gets string from file. Useful for -t
        -t num      overrides the normal naming areas to change another
                    string -f becomes inactive.
';
    }

if (defined $opt_s)
{
    open(INFILE, "$opt_s") || die "Unable to open $opt_s";
    $opt_n = join('', <INFILE>);
    $opt_n =~ s/\n/ /oig;
}

print "TTFNAME v1.1: Freeware, (c) M. Hosken\n" if (!defined $opt_q);

$fns{"name"} = "do_name";
&ttfmod($ARGV[0], $ARGV[1], *fns);
# that's all folks!!

# called to process "name" table
sub do_name {
    local(*INFILE, *OUTFILE, $len) = @_;
    local($csum);

    # copy and checksum table header
    read(INFILE, $name_head, 6) || die "Unable to read name table header";
    ($name_num) = unpack("x2n", $name_head);
    print OUTFILE $name_head;
    $csum = unpack("%32N", $name_head);
        # not 4 byte boundary - grrr!
    $csum += unpack("%32N", substr($name_head, 4, 2) . "\0\0");
    if ($csum > 0xffffffff) { $csum -= 0xffffffff; $csum -= 1; }

    # read name directory and calculate string space
    $str_tot = 0;
    for ($i = 0; $i < $name_num; $i++)
        {
        read(INFILE, $name_dir, 12) || die "Unable to read name entry";
        $names[$i] = $name_dir;
        ($name_id, $str_len, $str_off) = unpack("x6n3", $name_dir);
        $str_tot = $str_off + $str_len if ($str_off + $str_len > $str_tot);
        $ids[$name_id] .= "$i:";
        }
    foreach (@ids)
        { chop; }                   # chop trailing ':' from index list
    read(INFILE, $str, $str_tot) || die "Unable to glob all name strings";
    # copy strings or hijack them to new string space
    $spos = 0;
    for ($i = 0; $i < $name_num; $i++)
        {
        ($id_p, $id_e, $id_l, $name_id, $str_len, $str_off)
                = unpack("n6", $names[$i]);
        if (!defined $opt_t && ($name_id == 1 || $name_id == 4)     # family or full name
                    && !(defined $opt_l && $opt_l == $id_l))
            {
            if ($name_id == 4 && !defined $opt_f)   # calculate full name?
                {
                subfamily:                      # find subfamily name
                foreach $id (split(':', $ids[2]))
                    {
                    ($iid_p, $iid_e, $iid_l, $iid_n, $ilen, $ioff)
                                = unpack("n6", $names[$id]);
                    if ($id_p == $iid_p && $id_e == $iid_e && $id_l == $iid_l)
                        {
                        $tstr = substr($str, $ioff, $ilen);
                        $temp = $tstr;
                        $temp =~ s/\0//ogi;
                        $tstr = "" if ($temp =~ m/^regular$/oi
                                || $temp =~ m/^normal$/oi
                                || $temp =~ m/^standard$/oi);
                        $tlen = length($tstr);
                        last subfamily;
                        }
                    }
                }
            else                    # nothing to add to family name
                {
                $tstr = "";
                $tlen = 0;
                }
            if ($id_p == 0 || $id_p == 3 || ($id_p == 2 && $id_e == 1))
                {                               # 16 bit character set
                if ($name_id == 4 && defined $opt_f)    # special full name?
                    {
                    $outstr .= "\0" . join("\0", split('', $opt_f));
                    $str_len = 2 * length($opt_f);
                    }
                else                            # make new 16 bit string
                    {
                    $outstr .= "\0" . join("\0",
                        split('', $opt_n . (($tstr eq "") ? "" : " "))) . $tstr;
                    $str_len = 2 * length($opt_n) + $tlen
                                + ($tstr eq "" ? 0 : 2);
                    }
                }                                       # else 8 bit
            elsif ($name_id == 4 && defined $opt_f)     # special full name?
                {
                $outstr .= $opt_f;
                $str_len = length($opt_f);
                }
            else                                        # hijack 8 bit name
                {
                $outstr .= $opt_n . ($tstr eq "" ? "" : " ") . $tstr;
                $str_len = length($opt_n) + $tlen + ($tstr eq "" ? 0 : 1);
                }
            }
        elsif (defined $opt_t && $opt_t == $name_id && !(defined $opt_l && $opt_l == $id_l))
            {
            if ($id_p == 0 || $id_p == 3 || ($id_p == 2 && $id_e == 1))
                {
                $outstr .= "\0" . join("\0", split('', $opt_n));
                $str_len = 2 * length($opt_n);
                }
            else
                {
                $outstr .= $opt_n;
                $str_len = length($opt_n);
                }
            }
        else                    # no hijacking, just copy from string space
            {
            $tstr = substr($str, $str_off, $str_len);
            $outstr .= $tstr;
            $str_len = length($tstr);
            }
        $str_off = $spos;       # this string offset
        $spos += $str_len;      # next string offset
        $outpre = pack("n", $id_p);     # handle 2 byte offset in checksums
        $outval = pack("n5", $id_e, $id_l, $name_id, $str_len, $str_off);
        print OUTFILE $outpre . $outval;    # output new directory entry
        $csum += unpack("%32N", "\0\0" . $outpre);      # checksum
        if ($csum > 0xffffffff) { $csum -= 0xffffffff; $csum -= 1; }
        $csum += unpack("%32N*", $outval . "\0\0");
        if ($csum > 0xffffffff) { $csum -= 0xffffffff; $csum -= 1; }
        }
    $outstr .= "\0" x (2, 1, 0, 3)[$spos & 3];      # pad string space
    $csum += unpack("%32N", "\0\0" . substr($outstr, 0, 2));    # checksum
    if ($csum > 0xffffffff) { $csum -= 0xffffffff; $csum -= 1; }
    $csum += unpack("%32N*", substr($outstr, 2));
    if ($csum > 0xffffffff) { $csum -= 0xffffffff; $csum -= 1; }
    print OUTFILE $outstr;                          # output string space

    ($spos + $name_num * 12 + 6, $csum);            # return length, checksum
    }

@REM=('
:end
@echo off
@REM ') if 0 ;
