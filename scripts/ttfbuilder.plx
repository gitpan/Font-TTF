use Font::TTF::Font;
use Font::TTF::Glyf;
use Font::TTF::Glyph;
use Font::TTF::Hmtx;
use Font::TTF::Loca;
use Font::TTF::PSNames;
use XML::Parser::Expat;
use Pod::Usage;
use Getopt::Std;

$VERSION = 0.06;    # MJPH       7-MAR-2002     errors, base glyphs with no outlines, 
#                                                 properties & notes, symbol fonts, surrogates
# $VERSION = 0.05;    # MJPH      10-DEC-2001     improve error messages
# $VERSION = 0.04;    # MJPH      19-SEP-2001     documentation improvements add Pod::Usage
# $VERSION = 0.03;    # MJPH      18-SEP-2001     add ascent, descent, linegap attributes
# $VERSION = 0.02;    #   MJPH    12-SEP-2001     -x now optional, -a bug fixes
# $VERSION = 0.01;    #   MJPH    31-JUL-2001     Original

getopts('ac:d:hx:z:');

unless ((defined $ARGV[1] && defined $opt_c) || defined $opt_h)
{
    die <<"EOT";
    TTFBUILDER version $VERSION
    
    ttfbuilder [-a] [-h] -c config.xml [-x attach.xml] [-z out.xml] \\
        infile.ttf outfile.ttf
Builds outfile.ttf from infile.ttf according to config.xml. Also requires an
attachment point database (attach.xml) and can generate out.xml.

    -a          initialise output font with all the glyphs of the input font
                and append new glyphs to that
    -c file     Configuration file to use
    -d bits     Flag bits
                0: Don't Set dates in the font to now
                1: Don't Auto-create postscript names for component glyphs
                2: Don't Hack the copyright message (if none set)
                3: Mark target font as symbol font
    -h          Help
    -x file     Attachment database to read
    -z file     Attachment database to output
EOT
}

if ($opt_h)
{
    pod2usage( -verbose => 2);
    exit;
}

$if = Font::TTF::Font->open($ARGV[0]) || die "Can't read font $ARGV[0]";
$of = Font::TTF::Font->new();
foreach $t ('OS/2', 'cvt ', 'fpgm', 'gasp', 'head', 'hhea', 'maxp', 'name', 'prep', 'post')
{
    next unless defined $if->{$t};
    $if->{$t}->read;
    $of->{$t} = bless {%{$if->{$t}}}, ref $if->{$t};
    $of->{$t}{' PARENT'} = $of;
}

$c = $if->{'cmap'}->read->find_ms;
$ifissymbol = $if->{'cmap'}->ms_enc;
$ifissymbol = 1 if (defined $ifissymbol && $ifissymbol == 0);

$if->{'hmtx'}->read;
$fname = $if->{'name'}->find_name(4);

if (defined $opt_x)
{
    $xml = XML::Parser::Expat->new();
    $xml->setHandlers('Start' => sub {
        my ($xml, $tag, %attrs) = @_;

        if ($tag eq 'glyph')
        {
            $gid = $attrs{'GID'} || $c->{'val'}{hex($attrs{'UID'})}
                || $if->{'post'}{'STRINGS'}{$attrs{'PSName'}};
            if ($gid == 0 && ($attrs{'PSName'} || $attrs{'UID'}))
            { return $xml->xpcarp("No glyph called: $attrs{'PSName'}, Unicode: $attrs{'UID'} in $opt_x"); }
            $xml_dat[$gid]{'ps'} = $attrs{'PSName'};
            $xml_dat[$gid]{'UID'} = $attrs{'UID'};
        } elsif ($tag eq 'point')
        {
            $pname = $attrs{'type'};
        } elsif ($tag eq 'contour')
        {
            $xml_dat[$gid]{'points'}{$pname}{'cont'} = $attrs{'num'};
        } elsif ($tag eq 'location')
        {
            $xml_dat[$gid]{'points'}{$pname}{'loc'} = [$attrs{'x'}, $attrs{'y'}];
        } elsif ($tag eq 'font')
        {
            $fontname = $attrs{'name'};
            $fontupem = $attrs{'upem'};
        } elsif ($tag eq 'property')
        {
            $xml_dat[$gid]{'properties'}{$attrs{'name'}} = $attrs{'value'};
        } elsif ($tag eq 'note')
        {
            $currtext = '';
        }
    }, 'End' => sub {
        my ($xml, $tag) = @_;

        if ($tag eq 'point')
        { $xml->xpcarp("Attachment point must have location or contour in $opt_x")
            unless (defined $xml_dat[$gid]{'points'}{$pname}{'cont'}
                    || defined $xml_dat[$gid]{'points'}{$pname}{'loc'}); }
        elsif ($tag eq 'note')
        {
            $currtext =~ s/\s*(.*?)\s*$//o;
            $xml_dat[$gid]{'notes'} = $currtext;
            $currtext = '';
        }
    }, 'Char' => sub {
        my ($xml, $str) = @_;
        
        $currtext .= $str;
    });

    $xml->parsefile($opt_x) || die "Can't read $opt_x";
}

$if->{'loca'}->read;
$of->{'hmtx'} = Font::TTF::Hmtx->new(PARENT => $of, read => 1);

if ($opt_a)
{
    my ($p, $aglyph);
    
    $oc = {%{$if->{'cmap'}->find_ms->{'val'}}};
    for ($i = 0; $i < $if->{'maxp'}{'numGlyphs'}; $i++)
    {
        my ($g) = $if->{'loca'}{'glyphs'}[$i];
        my ($bbox);

        $aglyph = {
            'GID' => $i,
            'PSName' => $if->{'post'}{'VAL'}[$i]};

        if ($g)
        {
            $g->read;
            $bbox = 
            $aglyph->{'glyph_list'} = [{
                'glyph' => $g,
                'GID' => $i,
                'offset' => [0, 0]}];
            $aglyph->{'bbox'} = [$g->{'xMin'}, $g->{'yMin'}, $g->{'xMax'}, $g->{'yMax'}];
        }

        foreach $p (keys %{$xml_dat[$i]{'points'}})
        {
            my ($p1) = $xml_dat[$i]{'points'}{$p};
            $aglyph->{'points'}{$p}{'base'} = $aglyph;
            $aglyph->{'points'}{$p}{'loc'} = [@{$p1->{'loc'}}] if (defined $p1->{'loc'});
            $aglyph->{'points'}{$p}{'cont'} = $p1->{'cont'} if (defined $p1->{'cont'});     # deep copy - klunky
        }
        $aglyph->{'properties'} = {%{$xml_dat[$i]{'properties'}}} if defined $xml_dat[$i]{'properties'};
        $aglyph->{'notes'} = $xml_dat[$i]{'notes'} if defined $xml_dat[$i]{'notes'};
        $g->{'required'} = $i;
        push (@glyphs, $aglyph);
        $of->{'hmtx'}{'advance'}[$i] = $if->{'hmtx'}{'advance'}[$i];
    }
    $gcount = $i - 1;
} else {
    $oc = {};
    $gcount = 2;
}

$xml = XML::Parser::Expat->new();
$xml->setHandlers('Start' => sub {
    my ($xml, $tag, %attrs) = @_;
    my ($curbase) = $xml->{' curbase'};

    if ($tag eq 'glyph')
    {
        $curbase = {%attrs};
        $xml->{' curbase'} = $curbase;
        $curbase->{'GID'} = ++$gcount unless (defined $curbase->{'GID'});
        $gcount = $curglyph->{'GID'} if ($gcount < $curbase->{'GID'});
        $glyphs[$curbase->{'GID'}] = $curbase;
    }
    elsif ($tag eq 'base' || $tag eq 'attach')
    {
        my ($gid, $aglyph, $p);
        
        unless (($attrs{'PSName'} && ($gid = $if->{'post'}{'STRINGS'}{$attrs{'PSName'}}))
                || ($attrs{'UID'} && ($gid = $c->{'val'}{hex($attrs{'UID'})}))
                || ($gid = $attrs{'GID'}) || defined $attrs{'GID'})
        { $xml->xpcarp("Can't find glyph $attrs{PSName}/U+$attrs{UID} for $tag in $opt_c"); }

        $aglyph = {
            'gid' => $gid,
            'glyph' => $if->{'loca'}{'glyphs'}[$gid],
            'parent' => $curbase,
            'PSName' => $attrs{'PSName'},
            'UID' => $attrs{'UID'}
            };
        push (@{$curbase->{'glyphs'}}, $aglyph);        # build components tree
        
        foreach $p (keys %{$xml_dat[$gid]{'points'}})
        {
            my ($p1) = $xml_dat[$gid]{'points'}{$p};
            $aglyph->{'points'}{$p}{'base'} = $aglyph;
            $aglyph->{'points'}{$p}{'loc'} = [@{$p1->{'loc'}}] if (defined $p1->{'loc'});
            $aglyph->{'points'}{$p}{'cont'} = $p1->{'cont'} if (defined $p1->{'cont'});     # deep copy - klunky
        }
        $aglyph->{'properties'} = {%{$xml_dat[$i]{'properties'}}} if defined $xml_dat[$i]{'properties'};
        $aglyph->{'notes'} = $xml_dat[$i]{'notes'} if defined $xml_dat[$i]{'notes'};

        if ($tag eq 'attach')                            # position attachment
        {
            my ($atx, $aty, $withx, $withy, $pt);
            if (defined $attrs{'at'})
            {
                $pt = $xml_dat[$curbase->{'gid'}]{'points'}{$attrs{'at'}};
                if (!defined $pt)
                { $xml->xpcarp("Undefined attachment point $attrs{'at'} on glyph $xml_dat[$curbase->{'gid'}]{'ps'} in $opt_c"); }
                elsif (!defined $pt->{'loc'})
                {
                    if (defined $pt->{'cont'})
                    { 
                        $xml->xpcarp("glyph $xml_dat[$curbase->{'gid'}]{'ps'} has no outline in $opt_c") 
                            unless ($curbase->{'glyph'});
                        $pt->{'loc'} = lookup_pt($curbase->{'glyph'}, $pt->{'cont'}); 
                    }
                    else
                    { $xml->xpcarp("Unlocatable attachment point $attrs{'at'} on glyph $xml_dat[$curbase->{'gid'}]{'ps'} in $opt_c"); }
                }
                ($atx, $aty) = @{$pt->{'loc'}};
                delete $curbase->{'points'}{$attrs{'at'}};      # used it so delete it
            } else                                              # no attachment point, default centre the glyphs in x
            {
                $atx = $if->{'hmtx'}{'advance'}[$curbase->{'gid'}] / 2;
                $aty = 0;
            }

            if (defined $attrs{'with'})
            {
                $pt = $xml_dat[$aglyph->{'gid'}]{'points'}{$attrs{'with'}};
                if (!defined $pt)
                { $xml->xpcarp("Undefined attachment point $attrs{'with'} on glyph $xml_dat[$aglyph->{'gid'}]{'ps'} in $opt_c"); }
                elsif (!defined $pt->{'loc'})
                {
                    if (defined $pt->{'cont'})
                    { $pt->{'loc'} = lookup_pt($aglyph->{'glyph'}, $pt->{'cont'}); }
                    else
                    { $xml->xpcarp("Unlocatable attachment point $attrs{'at'} on glyph $xml_dat[$aglyph->{'gid'}]{'ps'} in $opt_c"); }
                }
                ($withx, $withy) = @{$pt->{'loc'}};
                delete $aglyph->{'points'}{$attrs{'with'}}     # delete if attaching to a real glyph
                        if (defined $curbase->{'glyph'} && $curbase->{'glyph'}{'numPoints'} != scalar @{$curbase->{'glyph'}{'endPoints'}});
            } else
            {
                $withx = $if->{'hmtx'}{'advance'}[$aglyph->{'gid'}] / 2;
                $withy = 0;
            }

            $aglyph->{'roffset'} = [$atx - $withx, $aty - $withy];
        }
        $xml->{' curbase'} = $aglyph;
    }
    elsif ($tag eq 'advance')
    {
        $curbase->{'adv'} = $attrs{'width'};
    }
    elsif ($tag eq 'shift')
    {
        $curbase->{'roffset'}[0] += $attrs{'x'};
        $curbase->{'roffset'}[1] += $attrs{'y'};
    }
    elsif ($tag eq 'string')
    {
        $cur_str = {%attrs};
        $currtext = '';
    }
    elsif ($tag eq 'font')
    {
        my ($s);
        
        $of->{'hhea'}{'Ascender'} = $attrs{'ascent'} if defined $attrs{'ascent'};
        $of->{'hhea'}{'Descender'} = $attrs{'descent'} if defined $attrs{'descent'};
        $of->{'hhea'}{'LineGap'} = $attrs{'linegap'} if defined $attrs{'linegap'};
        if ($s = $attrs{'cp'})
        {
            $s = '0' x (16 - length($s)) . $s;
            $of->{'OS/2'}{'ulCodePageRange1'} = hex(substr($s, 8));
            $of->{'OS/2'}{'ulCodePageRange2'} = hex(substr($s, 0, 8));
        }
        if ($s = $attrs{'coverage'})
        {
            $s = '0' x (32 - length($s)) . $s;
            $of->{'OS/2'}{'ulUnicodeRange1'} = hex(substr($s, 24));
            $of->{'OS/2'}{'ulUnicodeRange2'} = hex(substr($s, 16, 8));
            $of->{'OS/2'}{'ulUnicodeRange3'} = hex(substr($s, 8, 8));
            $of->{'OS/2'}{'ulUnicodeRange4'} = hex(substr($s, 0, 8));
        }
    }
    elsif ($tag eq 'property')
    {
        $curbase->{'properties'}{$attrs{'name'}} = $attrs{'value'};
    }
    elsif ($tag eq 'note')
    {
        $currtext = '';
    }
}, 'End' => sub {
    my ($xml, $tag) = @_;
    my ($curbase) = $xml->{' curbase'};

    if ($tag eq 'base' || $tag eq 'attach')
    {
        $curbase->{'adv'} = $if->{'hmtx'}{'advance'}[$curbase->{'gid'}]
            unless (defined $curbase->{'adv'});
        $xml->{' curbase'} = $curbase->{'parent'};
        $curbase = $xml->{' curbase'};
        if ($tag eq 'base' && scalar @{$curbase->{'glyphs'}} == 1)
        {
            my ($k);
            foreach $k (keys %{$curbase->{'glyphs'}[0]{'properties'}})
            {
                $curbase->{'properties'}{$k} = $curbase->{'glyphs'}[0]{'properties'}{$k} 
                        unless defined $curbase->{'properties'}{$k};
            }
            $curbase->{'notes'} = $curbase->{'glyphs'}[0]{'notes'} 
                    if (defined $curbase->{'glyphs'}[0]{'notes'} && !defined $curbase->{'notes'});
        }
    }
    elsif ($tag eq 'glyph')
    {
        my ($adv, $g, $xMin, $yMin, $xMax, $yMax, $p);

        foreach $g (@{$curbase->{'glyphs'}})
        {
            resolve_glyph($g, $adv);                    # get absolute position of glyph
            $adv = $g->{'offset'}[0] + $g->{'adv'};
            push (@{$curbase->{'glyph_list'}}, @{$g->{'glyph_list'}});  # compile full glyph list
            if (defined $g->{'bbox'})
            { ($xMin, $yMin, $xMax, $yMax) =
                findbox($xMin, $yMin, $xMax, $yMax, $g->{'bbox'}, $g->{'offset'}); }

            foreach $p (keys %{$g->{'points'}})                 # update points database
            {
                if (defined $curbase->{'points'}{$p})
                {
                    my ($p1) = $p;
                    while (defined $curbase->{'points'}{$p1})
                    { $p1++; }
                    $curbase->{'points'}{$p1} = $curbase->{'points'}{$p};       # both point to the same hash
                }
                $curbase->{'points'}{$p} = $g->{'points'}{$p};
            }
        }

        if (scalar @{$curbase->{'glyph_list'}} == 1)        # only one glyph?
        {
            my ($cg) = $curbase->{'glyph_list'}[0];

            if ($cg->{'offset'}[0] == 0 && $cg->{'offset'}[1] == 0)     # no move - then basis for other references
            { $cg->{'glyph'}{'required'} = $curbase->{'GID'}; }
            else
            { $cg->{'glyph'}{'required1'} = $curbase->{'GID'}; }         # moved - perhaps a basis
        }

        $of->{'hmtx'}{'advance'}[$curbase->{'GID'}] =                       # font update handles lsb
                defined ($curbase->{'adv'}) ? $curbase->{'adv'} : $adv;     # resolve advance width here
        undef $xml->{' curbase'};
    }
    elsif ($tag eq 'string')
    {
        $currtext =~ s/^\s*(.*?)\s*$/$1/o;
        $currtext =~ s/\s(?=\s)//og;
        $cur_str->{'text'} = $currtext;
        if ($cur_str->{'num'} eq 'name')
        {
            my ($style);
            
            $cur_str->{'num'} = 1;
            do_name($of, $cur_str);
            $style = $of->{'name'}->find_name(2);
            if ($style && $style ne 'Regular')
            { $cur_str->{'text'} .= " $style"; }
            $cur_str->{'num'} = 4;
            do_name($of, $cur_str);
        } else
        { do_name($of, $cur_str); }
        if ($cur_str->{'num'} == 0)
        { $done_cpyrt = 1; }
        undef $cur_str;
    }
    elsif ($tag eq 'note')
    {
        $currtext =~s/^\s*(.*?)\s*$/$1/o;
        $curbase->{'notes'} = $currtext;
    }
}, 'Char' => sub {
    my ($xml, $text) = @_;

    $currtext .= $text;
});

$xml->parsefile($opt_c) || die "Can't read $opt_c";

unless ($opt_a)     # only need this if not copying old font anyway.
{
    my (@names) = qw(.notdef null CR);
    # fill in first 3 special glyphs: .notdef null CR
    for ($i = 0; $i < 3; $i++)
    {
        my ($g, $bbox);
    
        next if defined $glyphs[$i];

        $g = $if->{'loca'}{'glyphs'}[$i];
        if ($g)
        {
            $g->read;
            $bbox = [$g->{'xMin'}, $g->{'yMin'}, $g->{'xMax'}, $g->{'yMax'}];

            $glyphs[$i] = {
                'GID' => $i,
                'glyph_list' => [{
                    'glyph' => $g,
                    'GID' => $i}],
                'bbox' => $bbox,
                'PSName' => $names[$i]};
        } else
        {
            $glyphs[$i] = {
                'GID' => $i,
                'PSName' => $names[$i]};
        }
        $of->{'hmtx'}{'advance'}[$i] = $if->{'hmtx'}{'advance'}[$i];
    }

    # resolve reference bases - use possible bases here
    for ($i = 0; $i < $if->{'maxp'}{'numGlyphs'}; $i++)
    {
        my ($g) = $if->{'loca'}{'glyphs'}[$i];
        my ($bbox);
    
        next unless ($g && $g->{'required'} == -1);
        $g->read;
        if (defined $g->{'required1'})
        {
            $g->{'required'} = $g->{'required1'};
            next;
        }
        $bbox = [$g->{'xMin'}, $g->{'yMin'}, $g->{'xMax'}, $g->{'yMax'}];

        push (@glyphs, {
            'GID' => ++$gcount,
            'glyph_list' => [{
                'glyph' => $g,
                'GID' => $i,
                'offset' => [0, 0]}],
            'bbox' => $bbox,
            ($opt_d & 2 ? () : ('PSName' => $if->{'post'}{'VAL'}[$i]))});
        $g->{'required'} = $gcount;
        $of->{'hmtx'}{'advance'}[$gcount] = $if->{'hmtx'}{'advance'}[$i];
    }
}


$of->{'maxp'}{'numGlyphs'} = scalar @glyphs;
$of->{'post'}{'VAL'} = [];
$of->{'loca'} = Font::TTF::Loca->new(PARENT => $of, read => 1);
$of->{'glyf'} = Font::TTF::Glyf->new(PARENT => $of, read => 1);

if ($opt_z)
{
    my ($fname) = $of->{'name'}->find_name(4);
    open (OX, "> $opt_z") || die "Can't open $opt_z for writing";
    print OX "<?xml version='1.0' encoding='UTF-8'?>\n";
    print OX "<font name=\"$fname\" upem=\"$of->{'head'}{'unitsPerEm'}\">\n";
}

for ($i = 0; $i < $of->{'maxp'}{'numGlyphs'}; $i++)
{
    my ($g) = $glyphs[$i];
    my ($glyph, $uid, $pname);

    unless (defined $g)
    {
        $of->{'post'}{'VAL'}[$i] = '.notdef';
        next;
    }

    if ($g->{'UID'})
    {
        $uid = hex($g->{'UID'});
        $uidmax = $uid if ($uid > $uidmax);
        $oc->{$uid} = $i;
    } else
    { $uid = 0; }
    if ($g->{'BID'})
    { $bc->{hex($g->{'BID'})} = $i; }
    
    if ($g->{'PSName'})
    { $pname = $g->{'PSName'}; }
    else
    { $pname = Font::TTF::PSNames::lookup($uid); }
    $of->{'post'}{'VAL'}[$i] = $pname;

    next unless (scalar @{$g->{'glyph_list'}});

    $glyph = Font::TTF::Glyph->new(PARENT => $of, read => 2);
    $glyph->{'xMin'} = $g->{'bbox'}[0];
    $glyph->{'yMin'} = $g->{'bbox'}[1];
    $glyph->{'xMax'} = $g->{'bbox'}[2];
    $glyph->{'yMax'} = $g->{'bbox'}[3];
    if (scalar @{$g->{'glyph_list'}} == 1)
    {
        my ($cg) = $g->{'glyph_list'}[0];
        my ($gb) = $cg->{'glyph'};
        foreach (qw(numberOfContours xMin yMin xMax yMax), ' DAT')
        { $glyph->{$_} = $gb->{$_}; }
        $glyph->{' read'} = 1;
        if ($cg->{'offset'}[0] != 0 || $cg->{'offset'}[1] != 0)
        {
            $glyph->read_dat;
            if ($glyph->{'numberOfContours'} < 0)
            {
                my ($comp);

                foreach $comp (@{$glyph->{'comps'}})
                {
                    if ($flag & 2)
                    {
                        $comp->{'args'}[0] += $cg->{'offset'}[0];
                        $comp->{'args'}[1] += $cg->{'offset'}[1];
                    }
                }
            } else
            {
                my ($j);
                
                foreach $j (@{$glyph->{'x'}})
                { $j += $cg->{'offset'}[0]; }
                foreach $j (@{$glyph->{'y'}})
                { $j += $cg->{'offset'}[1]; }
            }
        }
        $of->{'hmtx'}{'lsb'}[$i] -= $cg->{'offset'}[0];
    } else
    {
        my ($gb);
        
        $glyph->{'numberOfContours'} = -1;
        foreach $gb (@{$g->{'glyph_list'}})
        {
            my ($co) = $glyphs[$gb->{'glyph'}{'required'}]{'glyph_list'}[0]{'offset'};
            
            push (@{$glyph->{'comps'}}, {
                'glyph' => $gb->{'glyph'}{'required'},
                'flag' => 2,
                'args' => [$gb->{'offset'}[0] - $co->[0], $gb->{'offset'}[1] - $co->[1]]});
        }
    }
    $of->{'loca'}{'glyphs'}[$i] = $glyph;

    next unless defined $opt_z;
    print OX "\n<glyph GID=\"$i\"";
    print OX " PSName=\"$pname\"" if ($pname ne '.notdef');
    printf OX " UID=\"%04X\"", $uid if ($uid != 0);
    print OX ">\n";
    foreach $glyph (@{$g->{'glyphs'}})
    {
        my ($p, $cg);
        
        if (scalar @{$g->{'glyph_list'}} > 1)
        {
            foreach $cg (@{$g->{'glyph_list'}})
            {
                my ($ag) = $glyphs[$if->{'loca'}{'glyphs'}[$cg->{'GID'}]{'required'}];
                my (@bbox) = ($ag->{'bbox'}[0] + $cg->{'offset'}[0],
                              $ag->{'bbox'}[1] + $cg->{'offset'}[1],
                              $ag->{'bbox'}[2] + $cg->{'offset'}[0],
                              $ag->{'bbox'}[3] + $cg->{'offset'}[1]);
                print OX "    <compound bbox=\"" . join(', ', @bbox) . "\"";
                if ($ag->{'UID'})
                { print OX " UID=\"$ag->{'UID'}\""; }
                elsif ($ag->{'PSName'})
                { print OX " PSName=\"$ag->{'PSName'}\""; }
                elsif ($ag->{'GID'})
                { print OX " GID=\"$ag->{'GID'}\""; }
                print OX "/>\n";
            }
        }
        foreach $p (keys %{$g->{'points'}})
        {
            my ($p1) = $g->{'points'}{$p};
            my ($pb) = $p1->{'base'};
            
            print OX "    <point type=\"$p\">\n";
            print OX "        <contour num=\"" .
                ($p1->{'cont'} + $pb->{'pathbase'}) .
                "\"/>\n" if (defined $p1->{'cont'});
            print OX "        <location x=\"" . ($p1->{'loc'}[0] + $pb->{'offset'}[0]) .
                "\" y=\"" . ($p1->{'loc'}[1] + $pb->{'offset'}[1]) .
                "\"/>\n" if ($p1->{'loc'});
            print OX "    </point>\n";
        }
    }
    print OX "</glyph>\n";
}

if ($opt_z)
{
    print OX "\n</font>\n";
    close(OX);
}

$of->{'cmap'} = Font::TTF::Cmap->new(PARENT => $of, read => 1);

$format = $uidmax > 0xFFFF ? 12 : 4;
push (@{$of->{'cmap'}{'Tables'}}, {
    'Platform' => 0,
    'Encoding' => 0,
    'Format' => $format,
    'Ver' => 0,
    'val' => $oc});
if ($bc)
{
    push (@{$of->{'cmap'}{'Tables'}}, {
        'Platform' => 1,
        'Encoding' => 0,
        'Format' => 0,
        'Ver' => 0,
        'val' => $bc});
}

push (@{$of->{'cmap'}{'Tables'}}, {
    'Platform' => 3,
    'Encoding' => ($uidmax > 0xFFFF ? 10 : ($opt_d & 8 ? 0 : 1)),
    'Format' => $format,
    'Ver' => 0,
    'val' => $oc});
    
if ($uidmax > 0xFFFF)       # also include a BMP cmap
{
    my ($k);
    
    foreach $k (keys %{$oc})
    {
        $bmpc{$k} = $oc->{$k} if ($k <= 0xFFFF);
    }
    push (@{$of->{'cmap'}{'Tables'}}, {
        'Platform' => 3,
        'Encoding' => ($opt_d & 8 ? 0 : 1),
        'Format' => $4,
        'Ver' => 0,
        'val' => $bmpc});
}

$of->{'cmap'}{'Num'} = scalar @{$of->{'cmap'}{'Tables'}};

unless ($done_cpyrt || ($opt_d & 4))
{
    my ($text) = $of->{'name'}->find_name(0);
    $text .= " Derived from $fname by ttfbuilder v$VERSION";
    do_name($of, {'num' => 0, 'text' => $text});
}

if ($ifissymbol ^ ($opt_d & 8 ? 1 : 0))
{
    my ($n, $s);
    
    foreach $n (@{$of->{'name'}{'strings'}})
    {
        if (defined ($s = $n->[3][!$ifissymbol]))
        {
            undef $n->[3][!$ifissymbol];
            $n->[3][$ifissymbol] = $s;
        }
    }
}

unless ($opt_d & 1)
{
    $of->{'head'}->setdate(time(), 1);  # set creation date
    $of->{'head'}->setdate(time(), 0);  # set modified date
}
$of->tables_do(sub {$_[0]->dirty});
$of->update;
# $of->{'head'}{'flags'} &= ~2;
$of->out($ARGV[1]) || die "Can't write to $ARGV[1]";

sub resolve_glyph
{
    my ($g, $orgx, $orgy, $pathcount) = @_;
    my ($glyph, $xMin, $yMin, $xMax, $yMax, $c, $p, $adv);

    $g->{'pathbase'} = $pathcount;
    $g->{'offset'} = [$g->{'roffset'}[0] + $orgx,
                      $g->{'roffset'}[1] + $orgy];
    $adv = (defined $g->{'adv'} ? $g->{'adv'} : $if->{'hmtx'}{'advance'}[$g->{'gid'}])
            + $g->{'offset'}[0];
    
    if ($glyph = $g->{'glyph'})
    {
        $glyph->read->get_points;
        $pathcount += scalar @{$glyph->{'endPoints'}};

        push (@{$g->{'glyph_list'}}, pos_glyphs($g->{'gid'}, $glyph, @{$g->{'offset'}}));

        $xMin = $glyph->{'xMin'};
        $yMin = $glyph->{'yMin'};
        $xMax = $glyph->{'xMax'};
        $yMax = $glyph->{'yMax'};
    }
    foreach $c (@{$g->{'glyphs'}})
    {
        $pathcount = resolve_glyph($c, @{$g->{'offset'}}, $pathcount);
        $adv = $c->{'adv'} if ($c->{'adv'} > $adv);
        ($xMin, $yMin, $xMax, $yMax) = findbox($xMin, $yMin, $xMax, $yMax, $c->{'bbox'}, $c->{'offset'});
        push (@{$g->{'glyph_list'}}, @{$c->{'glyph_list'}});
    }
    $g->{'bbox'} = [$xMin, $yMin, $xMax, $yMax];
    $g->{'adv'} = $adv;
    return $pathcount;
}

sub pos_glyphs
{
    my ($gid, $glyph, $orgx, $orgy) = @_;

    if ($glyph->{'numberOfContours'} < 0)
    {
        my (@res);
        $glyph->read_dat;
        foreach $comp (@{$glyph->{'comps'}})
        {
            push (@res, pos_glyphs($comp->{'glyph'},
                    $if->{'loca'}{'glyphs'}[$comp->{'glyph'}],
                    $comp->{'args'}[0] + $orgx,
                    $comp->{'args'}[1] + $orgy));
        }
        return @res;
    } elsif (scalar @{$glyph->{'endPoints'}} == $glyph->{'numPoints'})
    {
        return ();
    } else
    {
        $glyph->{'required'} = -1 unless (defined $glyph->{'required'} &&
                $glyph->{'required'} >= 0);
        return ({
            'GID' => $gid,
            'offset' => [$orgx, $orgy],
            'glyph' => $glyph});
    }
}


sub lookup_pt
{
    my ($glyph, $cont) = @_;
    $glyph->get_points;
    return [$glyph->{'x'}[$glyph->{'endPoints'}[$cont]],
            $glyph->{'y'}[$glyph->{'endPoints'}[$cont]]];
}

sub findbox
{
    my ($xMin, $yMin, $xMax, $yMax, $others, $org) = @_;
    my ($o);
    
    $o = $others->[0] + $org->[0];
    $xMin = $o if (!defined $xMin || $o < $xMin);
    $o = $others->[1] + $org->[1];
    $yMin = $o if (!defined $yMin || $o < $yMin);
    $o = $others->[2] + $org->[0];
    $xMax = $o if ($o > $xMax);
    $o = $others->[3] + $org->[1];
    $yMax = $o if ($o > $yMax);
    ($xMin, $yMin, $xMax, $yMax);
}
    
sub do_name
{
    my ($f, $inf) = @_;
    my ($base) = $f->{'name'}{'strings'}[$inf->{'num'}];
    my ($pid, $eid, $lid);

    for ($pid = 0; $pid <= $#{$base}; $pid++)
    {
        next if (defined $inf->{'pid'} && $pid != $inf->{'pid'});
        next unless $base->[$pid];
        for ($eid = 0; $eid <= $#{$base->[$pid]}; $eid++)
        {
            next if (defined $inf->{'eid'} && $eid != $inf->{'eid'});
            next unless $base->[$pid][$eid];
            next unless $f->{'name'}->is_utf8($pid, $eid);
            foreach $lid (keys %{$base->[$pid][$eid]})
            {
                next if (defined $inf->{'lid'} && $lid != $inf->{'lid'});
                $base->[$pid][$eid]{$lid} = $inf->{'text'};
            }
        }
    }
}

__END__

=head1 TITLE

ttfbuilder - assemble a font from another font

=head1 DESCRIPTION

ttfbuilder is a font subsetting program gone wild. It's aim is to allow a user to
describe a new font in terms of the glyph pallette of a source font. Thus the new
font may include ligatures of glyphs in the source font, or positional movements
or whatever.

The main features of ttfbuilder are

=over 4

=item *

Ability to create glyphs that are not in any cmap and to reference such glyphs via
postscript name, glyph id or Unicode cmap entry. Also the ability to create non-BMP
Unicode entries and create surrogate based cmaps. In addition, symbol fonts are
supported.

=item *

Ability to work with an attachment points database. Thus ligatures are assembled
by describing which attachment points should coincide, rather than having to give
absolute locations in terms of shifting.

=item *

Ability to change the name of the font and change strings in the name table. And
set OS/2 coverage bits.

=back

ttfbuilder is controlled via a description file which describes the glyphs in the
new font, in terms of glyphs in the source font. This description file is an XML
file with the following key elements:

=over 4

=item glyph

This describes a glyph and the attributes allow setting of the postscript name and
Unicode id for the glyph. The glyph element has children which describe what goes
into the glyph.

=item base

A base character is a reference to a glyph in the source font (via Unicode id,
postscript name, glyph id) which is used in building the parent glyph. If there is
more than one base glyph in a glyph, then the base glyphs are concatenated in
sequence according to their advance widths, creating a single glyph. If a glyph only
contains a single base glyph with no attachments, and the base glyph has not been
shifted in any way, then the resulting font will include the glyph directly rather
than by reference.

=item attach

A base glyph may have attachments, which may have their own attachments in their
turn. An attachment is a reference to a glyph in the source font and also the name
of an attachment point on the attachment and one on its parent which are used to
position the attachment so that the attachment points coincide.

The C<attach> element takes two parameters describing the attachment point on the base
(C<at>) and the attachment point on the diacritic (C<with>). If these are missing, then
the glyphs are aligned centrally in the x direction and with no adjustment vertically.

=item advance

It is possible to override the default value of the advance width for any glyph. Thus
the advance element may occur is a child of either glyph, base or attach and it sets
the value of the advance width for its parent to the value given in the width
attribute. The default value of the advance width for a glyph is the widest advance
width taken from each of the child glyphs (including attachments) in their position
within the glyph. Thus if an attachment is positioned far enough to the right, it
may well cause the advance width of the glyph to increase beyond that of the base
glyph the attachment is on.

=item shift

It is also possible to shift glyphs, at least base and attach glyphs. Shifting
occurs after attachment (for obvious reasons).

=item string

In the names section of the description file it is possible to specify strings which
cause changes to the name section of the font. The string element takes a num
attribute which specifies which string to change. It is also possible to specify
which platform, encoding and or language id the change should be made to.

There is one special value for the num attribute, which is C<name>. This causes
the name of the font (string id 1) and also the full font name (string id 4) to be
assembled from the font name and style (string id 2).

=back

The DTD for the configuration file is:

    <!ELEMENT font (names?, glyphs)>
    <!ATTLIST font
        ascent CDATA #IMPLIED
        descent CDATA #IMPLIED
        linegap CDATA #IMPLIED>

    <!ELEMENT names (string)+>

    <!ELEMENT string EMPTY>
    <!ATTLIST string
        num CDATA #REQUIRED
        pid CDATA #IMPLIED
        eid CDATA #IMPLIED
        lid CDATA #IMPLIED>

    <!ELEMENT glyphs (glyph)+>

    <!ELEMENT glyph (property* | note | (advance | base)+)>
    <!ATTLIST glyph
        PSNAme CDATA #IMPLIED
        UID    CDATA #IMPLIED
        GID    CDATA #IMPLIED>

    <!ELEMENT base (advance | attach | shift)*>
    <!ATTLIST base
        PSName CDATA #IMPLIED
        UID    CDATA #IMPLIED
        GID    CDATA #IMPLIED>

    <!ELEMENT attach (advance | shift)*>
    <!ATTLIST attach
        PSName CDATA #IMPLIED
        UID    CDATA #IMPLIED
        GID    CDATA #IMPLIED
        with   CDATA #IMPLIED
        at     CDATA #IMPLIED>

    <!ELEMENT advance EMPTY>
    <!ATTLIST advance
        width  CDATA #REQUIRED>

    <!ELEMENT shift EMPTY>
    <!ATTLIST shift
        x      CDATA #IMPLIED
        y      CDATA #IMPLIED>

    <!ELEMENT property EMPTY>
    <!ATTLIST property
        name    CDATA #REQUIRED
        value   CDATA #REQUIRED>
        
    <!ELEMENT note (#PCDATA)>

From this small language, quite a lot can be done.

=head1 Attachment Points

One of the most powerful mechanisms for relating glyphs is that of attachment points.
This concept is concerned with attaching diacritics to a base character and the
attachment is achieved by specifying an attachment point on the base character
and one on the diacritic. The attachment points are usually designed as single point
paths in the glyph and their location or path number are held in a separate database.
When the attaching of the diacritic to the base character occurs, then the diacritic
is positioned so that the two attachment points coincide.

ttfbuilder works with attachment point databases represented in XML.

The DTD for an attachment point database is:

    <!ELEMENT font (glyph)*>
    <!ATTLIST font
        name    CDATA #IMPLIED
        upem    CDATA #IMPLIED

    <!ELEMENT glyph (property* | (point | compound)* | note)>
    <!ATTLIST glyph
        PSName  CDATA #IMPLIED
        UID     CDATA #IMPLIED
        GID     CDATA #IMPLIED>

    <!ELEMENT point (location | contour)+>
    <!ATTLIST point
        type    CDATA #REQUIRED>

    <!ELEMENT location EMPTY>
    <!ATTLIST location
        x       CDATA #REQUIRED
        y       CDATA #REQUIRED>

    <!ELEMENT contour EMPTY>
    <!ATTLIST contour
        num     CDATA #REQUIRED>

    <!ELEMENT compound EMPTY>
    <!ATTLIST compound
        bbox    CDATA #REQUIRED
        PSName  CDATA #IMPLIED
        UID     CDATA #IMPLIED
        GID     CDATA #IMPLIED>
        
    <!ELEMENT property EMPTY>
    <!ATTLIST property
        name    CDATA #REQUIRED
        value   CDATA #REQUIRED>
        
    <!ELEMENT note (#PCDATA)>

A C<font> contains C<glyphs> which have attachment C<points>. Each point has a name
and either a contour (path number from 0) or a location of an attachment point (real
or virtual) in terms of C<x> and C<y> co-ordinates in em units.

A C<glyph> may also be a compound glyph in which case the boxes
representing the location of the components of the C<compound> are
listed. Each component lists a bounding box describing the location of
the component in relation to the main glyph. This is a 4 element string,
separated by comma and optional whitespace. Each element is a co-ordinate in em
units. The sequence of values is: C<xMin>, C<yMin>, C<xMax>, C<yMax>. The compound
also indicates which glyph this component refers to.

Each glyph may also contain properties. A property is a name value pair. There may only
be one property with any particular name attribute.

A glyph may have textual notes associated with it.

=head1 Usage

ttfbuilder needs a configuration file, an attachment point database and a source font.
It also needs to know where to store the resulting font and can take a further
file to write a new attachment point database to, which represents the attachment
point database for the generated font.

=cut
