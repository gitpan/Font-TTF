
# This line could cause ferment in the ranks

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

# Hmm what about 1,0 ISO tables as well?
$t = $f->{'cmap'}->find_ms || die "This font has no MS cmap table";

$o = $t->{'val'};                       # Get the segarr to copy from
$s = Font::TTF::Segarr->new;

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

    $s->add_segment($addr[2], 0, $o->at($addr[0], $addr[1] - $addr[0] + 1));
}

close(INFILE);

# now we really cheat
$s->add_segment(0xffff, 0, 0);      # Make sure that there is a value for 0xffff to keep MS happy
$t->{'val'} = $s;                   # Remove old cmap and replace with new
$f->{'cmap'}{' isDirty'} = 1;

$f->{'OS/2'}->update;               # new first and last for OS/2

$f->out($ARGV[1]);

__END__
:endofperl
