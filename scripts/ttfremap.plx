use Font::TTF::Font;
require 'getopts.pl';

Getopts("c:rsu");

unless (defined $opt_c && defined $ARGV[1] && !(defined $opt_s && defined $opt_u) )
{
    die <<'EOT';
    TTFRemap -c file [-r] [-s | -u] <infile> <outfile>
Remaps the MS cmap of a font without removing any glyphs. Updates the OS/2
table according to first and last char of new cmap. The changes file consists
of lines of any of the following forms:

    uni_first, uni_to
    uni_first, uni_last, uni_to
    g, gid_first, uni_to
    g, gid_first, gid_last, uni_to
    
where uni_first (gid_first) is the first of a range of Unicodes (glyph IDs) 
in the source font, uni_last (gid_last) is the last of that range (if not
specified, default is same as uni_first (gid_last)), and uni_to 
is the start of the sequential set of Unicodes that will be altered in the 
output cmap so they map to the specified range. NOTE: Unicode values
should be in hex, glyph IDs are decimal.

    -r      Replace (copy the old cmap before mapping)
    -s      Convert to symbol encoding
    -u      Convert to UGL encoding
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
	$cmin = 0x1FFFFFF;
	$cmax = 0;
}
while (<INFILE>)
{
    next unless (m/^[0-9A-Z]/oi);       # this is klunky and needs to go
    chomp;
    s/\s*[#;].*//o;
    @work = split /,\s*/;

    $UseGID = lc($work[0] eq 'g');
    shift @work if $UseGID;
 
    next if $#work < 1 or $#work > 2;
    
    @work[1,2] = @work[0,1] if $#work < 2;	# if uni_last/g_last is missing, make it same as uni_first/g_first

    $first = ($UseGID ? $work[0] : hex($work[0]));
    $last  = ($UseGID ? $work[1] : hex($work[1]));
    $to = hex($work[2]);

    map {$s->{$to + $_} = ($UseGID ? ($first + $_) : $o->{$first + $_})} (0 .. ($last - $first));

    $cmin = $to if $cmin > $to;
    $cmax = ($to + $last - $first) if ($cmax < ($to + $last - $first));
}

close(INFILE);

foreach $c (@{$f->{'cmap'}{'Tables'}})
{
    $c->{'val'} = $s if ($c->{'Platform'} == 0 || $c->{'Platform'} == 3
        || ($c->{'Platform'} == 2 && $c->{'Encoding'} == 1));
    if ($c->{'Platform'} == 3)
    {
        $c->{'Encoding'} = 0 if $opt_s;
        $c->{'Encoding'} = 1 if $opt_u;
        $has_surr = 1 if $c->{'Encoding'} == 10;
    }
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

if ($opt_u)
{
    my ($n, $n1);
    
    $n = $f->{'name'}->read;
    foreach $n1 (@{$n->{'strings'}})
    {
        if (defined $n1->[3][0])
        {
            $n1->[3][1] = $n1->[3][0];
            undef $n1->[3][0];
        }
    }
    $v->{'ulUnicodeRange1'} = 0x00000003;
    $v->{'ulUnicodeRange2'} = 0;
    $v->{'ulUnicodeRange3'} = 0;
    $v->{'ulUnicodeRange4'} = 0;
    $v->{'ulCodePageRange1'} = 0x00000001;
    $v->{'ulCodePageRange2'} = 0;
}

if ($cmax > 0xFFFF)
{
    push (@{$f->{'cmap'}{'Tables'}}, {
        'Platform' => 3,
        'Encoding' => 10,
        'Ver' => 0,
        'Format' => 12,
        'val' => $s}) unless ($has_surr);

    my $has_uni_table;
    foreach $c (@{$f->{'cmap'}{'Tables'}})
    {
        if ($c->{'Platform'} == 0 && $c->{'Encoding'} == 0) 
        {
            $c->{'Format'} = 12;
            $has_uni_table = 1;
        }
    }
    push (@{$f->{'cmap'}{'Tables'}}, {
        'Platform' => 0,
        'Encoding' => 0,
        'Ver' => 0,
        'Format' => 12,
        'val' => $s}) unless ($has_uni_table);
}
        

$v->{'usFirstCharIndex'} = $cmin > 0xFFFF ? 0xFFFF : $cmin;
$v->{'usLastCharIndex'} = $cmax > 0xFFFF ? 0xFFFF : $cmax;

$f->out($ARGV[1]);


