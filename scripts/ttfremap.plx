use Font::TTF::Font;
require 'getopts.pl';

Getopts("c:rs");

unless (defined $opt_c && defined $ARGV[1])
{
    die <<'EOT';
    TTFRemap -c file [-r] [-s] <infile> <outfile>
Remaps the MS cmap of a font without removing any glyphs. Updates the OS/2
table according to first and last char of new cmap. The changes file consists
of lines of the form:

    uni_first, uni_last, uni_to

where uni_first is the first of a range of Unicodes in the source cmap
uni_last is the last of that range, and uni_to is where to map that range to
in the output cmap.

    -r      Replace (copy the old cmap before mapping)
    -s      Convert to symbol encoding
EOT
}

open(INFILE, "$opt_c") || die "Unable to open $opt_c for reading";

$f = Font::TTF::Font->open($ARGV[0]);
$v = $f->{'OS/2'}->read;                     # we need to update this
$o = $f->{'cmap'}->read->find_ms->{'val'} || die "This font has no MS cmap table";

if ($opt_r) 
{ 
	$s = {%{$o}};
	$cmin = $v->{'usFirstCharIndex'};
	$cmax = $v->{'usLastCharIndex'};
} 
else 
{ 
	$s = {};
	$cmin = 0xFFFF;
	$cmax = 0;
}
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

    map {$s->{$addr[2] + $_} = $o->{$addr[0] + $_}} (0 .. ($addr[1] - $addr[0]));
    $cmin = $addr[2] if $cmin > $addr[2];
    $cmax = ($addr[2] + $addr[1] - $addr[0]) if ($cmax < ($addr[2] + $addr[1] - $addr[0]));
}

close(INFILE);

foreach $c (@{$f->{'cmap'}{'Tables'}})
{
    $c->{'val'} = $s if ($c->{'Platform'} == 0 || $c->{'Platform'} == 3
        || ($c->{'Platform'} == 2 && $c->{'Encoding'} == 1));
    $c->{'Encoding'} = 0 if ($c->{'Platform'} == 3 && $opt_s);
    $has_surr = 1 if ($c->{'Platform'} == 3 && $c->{'Encoding'} == 10);
}

if ($opt_s)
{
    my ($n, $n1);
    
    $n = $f->{'name'}->read;
    foreach $n1 (@{$n->{'strings'}})
    {
        if (defined $n1->[3][1])
        {
            $n1->[3][0] = $n1->[3][1];
            undef $n1->[3][1];
        }
    }
    $v->{'ulUnicodeRange1'} = 0;
    $v->{'ulUnicodeRange2'} = 0;
    $v->{'ulUnicodeRange3'} = 0;
    $v->{'ulUnicodeRange4'} = 0;
    $v->{'ulCodePageRange1'} = 0x80000000;
    $v->{'ulCodePageRange2'} = 0;
}
elsif ($cmax > 0xFFFF && !$has_surr)
{
    push (@{$f->{'cmap'}{'Tables'}}, {
        'Platform' => 3,
        'Encoding' => 10,
        'Ver' => 0,
        'Format' => 12,
        'val' => $s});
}
        

$v->{'usFirstCharIndex'} = $cmin > 0xFFFF ? 0xFFFF : $cmin;
$v->{'usLastCharIndex'} = $cmax > 0xFFFF ? 0xFFFF : $cmax;

$f->out($ARGV[1]);


