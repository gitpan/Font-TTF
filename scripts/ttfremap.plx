use Font::TTF::Font;
require 'getopts.pl';

Getopts("c:");

unless (defined $opt_c && defined $ARGV[1])
{
    die <<'EOT';
    TTFRemap -c file <infile> <outfile>
Remaps the MS cmap of a font without removing any glyphs. Updates the OS/2
table according to first and last char of new cmap. The changes file consists
of lines of the form:

    uni_first, uni_last, uni_to

where uni_first is the first of a range of Unicodes in the source cmap
uni_last is the last of that range, and uni_to is where to map that range to
in the output cmap.
EOT
}

open(INFILE, "$opt_c") || die "Unable to open $opt_c for reading";

$f = Font::TTF::Font->open($ARGV[0]);
$f->{'cmap'}->read;
$f->{'OS/2'}->read;                     # we need to update this

$t = $f->{'cmap'}->find_ms || die "This font has no MS cmap table";

$o = $t->{'val'};                       # Get the segarr to copy from
$s = {}

while (<INFILE>)
{
    next unless (m/^[0-9A-Z]/oi);
    chomp;
    s/\s*[#;].*//oi;
    @work = split /,\s*/;
    next unless $#work == 2;

    @addr = ();
    foreach (@work)
    {
        m/^[0-9a-z]+/oi;
        push(@addr, hex($&));
    }

    map {$s->{$addr[2] + $_} = $o->{$addr[1] + $_}} (0 .. ($addr[1] - $addr[0] + 1));
}

close(INFILE);

# now we really cheat
$t->{'val'} = $s;                   # Remove old cmap and replace with new

$f->out($ARGV[1]);

