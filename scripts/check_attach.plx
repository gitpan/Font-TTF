use Font::TTF::Font;
use XML::Parser::Expat;
use Getopt::Std;

getopts('z:');

$VERSION = 0.01;    #   MJPH    30-JUL-2001     Original

unless (defined $ARGV[1])
{
    die <<'EOT';
    check_attach [-z outfile.xml] infile.xml infile.ttf
Checks an attachment point database against a font, checking that any
contours are single point and any locations tie up with their corresponding
contour, or that there exists a single point contour at a given location.
This program can also generate missing information and write it to a new
attachment point database.

    -z file     Output file to generate
EOT
}

if (defined $opt_z)
{
    open('OUT', "> $opt_z") || die "Can't write $opt_z";
}

$f = Font::TTF::Font->open($ARGV[1]) || die "Can't open font $ARGV[1]";
foreach $t (qw(post cmap loca))
{ $f->{$t}->read; }

$c = $f->{'cmap'}->find_ms->{'val'} || die "Can't find Unicode table in font $ARGV[1]";

$xml = XML::Parser::Expat->new();
$xml->setHandlers('Start' => sub {
    my ($xml, $tag, %attrs) = @_;

    if ($tag eq 'glyph')
    {
        my ($ug, $pg, $ig, $glyph);
        $cur_glyph = {%attrs};
        undef $cur_pt;

        if (defined $opt_z)
        { print OUT "<glyph"; }
        
        if (defined $attrs{'UID'})
        {
            $ug = $c->{hex($attrs{'UID'})};
            error($xml, "No glyph associated with UID $attrs{'UID'}") unless $ug;
            $cur_glyph->{'gnum'} = $ug;
            print OUT " UID=\"$attrs{'UID'}\"" if (defined $opt_z);
        }
        if (defined $attrs{'PSName'})
        {
            $pg = $f->{'post'}{'STRINGS'}{$attrs{'PSName'}};
            error($xml, "No glyph associated with postscript name $attrs{'PSName'}") unless $pg;
            error($xml, "Postscript name: $attrs{'PSName'} resolves to different glyph to Unicode ID: $attrs{'UID'}")
                    if (defined $attrs{'UID'} && $pg != $ug);
            $cur_glyph->{'gnum'} ||= $pg;
            print OUT " PSName=\"$attrs{'PSName'}\"" if (defined $opt_z);
        }
        if (defined $attrs{'GID'})
        {
            $ig = $attrs{'GID'};
            error($xml, "Specified glyph id $attrs{'GID'} different to glyph of Unicode ID: $attrs{'UID'}")
                    if (defined $attrs{'UID'} && $ug != $ig);
            error($xml, "Specified glyph id $attrs{'GID'} different to glyph of postscript name $attrs{'PSName'}")
                    if (defined $attrs{'PSName'} && $pg != $ig);
            $cur_glyph->{'gnum'} ||= $ig;
            print OUT " GID=\"$attrs{'GID'}\"" if (defined $opt_z);
        }

        unless ($glyph = $f->{'loca'}{'glyphs'}[$cur_glyph->{'gnum'}])
        {
            error ($xml, "No glyph outline in font");
            return;
        }
        $cur_glyph->{'glyph'} = $glyph;
        $cur_glyph->{'glyph'}->read_dat;
        $cur_glyph->{'glyph'}->get_points;
        print OUT ">\n" if (defined $opt_z);
    } elsif ($tag eq 'point')
    {
        $cur_pt = {'name' => $attrs{'type'}};
    } elsif ($tag eq 'contour')
    {
        my ($cont) = $attrs{'num'};
        my ($g) = $cur_glyph->{'glyph'} || return;
        
        error($xml, "Specified contour of $cont different from calculated contour of $cur_pt->{'cont'}")
                if (defined $cur_pt->{'cont'} && $cur_pt->{'cont'} != $attrs{'num'});
             
        if (($cont == 0 && $g->{'endPoints'}[0] != 0)
            || ($cont > 0 && $g->{'endPoints'}[$cont-1] + 1 != $g->{'endPoints'}[$cont]))
        { error($xml, "Contour $cont not a single point path"); }
        else
        { $cur_pt->{'cont'} = $cont; }
        
        $cur_pt->{'x'} = $g->{'x'}[$g->{'endPoints'}[$cont]];
        $cur_pt->{'y'} = $g->{'y'}[$g->{'endPoints'}[$cont]];
    } elsif ($tag eq 'location')
    {
        my ($x) = $attrs{'x'};
        my ($y) = $attrs{'y'};
        my ($g) = $cur_glyph->{'glyph'} || return;
        my ($cont, $i);

        error($xml, "Specified location of ($x, $y) different from calculated location ($cur_pt->{'x'}, $cur_pt->{'y'})")
                if (defined $cur_pt->{'x'} && ($cur_pt->{'x'} != $x || $cur_pt->{'y'} != $y));
        for ($i = 0; $i < $g->{'numPoints'}; $i++)
        {
            if ($g->{'x'}[$i] == $x && $g->{'y'}[$i] == $y)
            {
                for ($cont = 0; $cont <= $#{$g->{'endPoints'}}; $cont++)
                {
                    last if ($g->{'endPoints'}[$cont] > $i);
                }
            }
        }
        if ($g->{'x'}[$i] != $x || $g->{'y'}[$i] != $y)
        { error($xml, "No glyph point at specified location ($x, $y)"); }
        if (($cont == 0 && $g->{'endPoints'}[0] != 0)
            || $g->{'endPoints'}[$cont-1] + 1 != $g->{'endPoints'}[$cont])
        { error($xml, "Calculated contour $cont not a single point path"); }
        else
        { $cur_pt->{'cont'} = $cont; }

        $cur_pt->{'x'} = $x unless defined $cur_pt->{'x'};
        $cur_pt->{'y'} = $y unless defined $cur_pt->{'y'};
    }
}, 'End' => sub {
    my ($xml, $tag) = @_;

    return unless (defined $opt_z);

    if ($tag eq 'point')
    {
        print OUT "    <point type=\"$cur_pt->{'name'}\">\n";
        print OUT "        <contour num=\"$cur_pt->{'cont'}\"/>\n" if defined $cur_pt->{'cont'};
        print OUT "        <location x=\"$cur_pt->{'x'}\" y=\"$cur_pt->{'y'}\"/>\n" if defined $cur_pt->{'x'};
        print OUT "    </point>\n";
        undef $cur_pt;
    } elsif ($tag eq 'glyph')
    { print OUT "</glyph>\n"; }
});

$xml->parsefile($ARGV[0]) || die "Failed to parse file $ARGV[0]";
close(OUT) if defined $opt_z;

sub error
{
    my ($xml, $str) = @_;

    if (defined $cur_glyph->{'UID'})
    { print "U+$cur_glyph->{'UID'}: "; }
    elsif (defined $cur_glyph->{'PSName'})
    { print "$cur_glyph->{'PSName'}: "; }
    elsif (defined $cur_glyph->{'GID'})
    { print "$cur_glyph->{'GID'}: "; }
    else
    { print "Undefined: "; }

    print $str;

    if (defined $cur_pt)
    { print " in point $cur_pt->{'name'}"; }

    print " at line " . $xml->current_line . ".\n";
}

