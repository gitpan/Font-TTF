package Font::TTF::Cmap;

=head1 NAME

Font::TTF::Cmap - Character map table

=head1 DESCRIPTION

Looks after the character map. The primary structure used for handling a cmap
is the L<Font::TTF::Segarr> which handles the segmented arrays of format 4 tables,
and in a simpler form for format 0 tables.

Due to the complexity of working with segmented arrays, most of the handling of
such arrays is via methods rather than via instance variables.

One important feature of a format 4 table is that it always contains a segment
with a final address of 0xFFFF. If you are creating a table from scratch this is
important (although L<Font::TTF::Segarr> can work quite happily without it).


=head1 INSTANCE VARIABLES

The instance variables listed here are not preceeded by a space due to their
emulating structural information in the font.

=over 4

=item Num

Number of subtables in this table

=item Tables

An array of subtables ([0..Num-1])

=back

Each subtables also has its own instance variables which are, again, not
preceeded by a space.

=over 4

=item Platform

The platform number for this subtable

=item Encoding

The encoding number for this subtable

=item Format

Gives the stored format of this subtable

=item Ver

Gives the version (or language) information for this subtable

=item val

A hash keyed by the codepoint value (not a string) storing the glyph id

=back

=head1 METHODS

=cut

use strict;
use vars qw(@ISA);
use Font::TTF::Table;
use Font::TTF::Utils;

@ISA = qw(Font::TTF::Table);


=head2 $t->read

Reads the cmap into memory. Format 4 subtables read the whole subtable and
fill in the segmented array accordingly.

Format 2 subtables are not read at all.

=cut

sub read
{
    my ($self) = @_;
    my ($dat, $i, $j, $k, $id, @ids, $s);
    my ($start, $end, $range, $delta, $form, $len, $num, $ver);
    my ($fh) = $self->{' INFILE'};

    $self->SUPER::read or return $self;
    $fh->read($dat, 4);
    $self->{'Num'} = unpack("x2n", $dat);
    $self->{'Tables'} = [];
    for ($i = 0; $i < $self->{'Num'}; $i++)
    {
        $s = {};
        $fh->read($dat, 8);
        ($s->{'Platform'}, $s->{'Encoding'}, $s->{'LOC'}) = (unpack("nnN", $dat));
        $s->{'LOC'} += $self->{' OFFSET'};
        push(@{$self->{'Tables'}}, $s);
    }
    for ($i = 0; $i < $self->{'Num'}; $i++)
    {
        $s = $self->{'Tables'}[$i];
        $fh->seek($s->{'LOC'}, 0);
        $fh->read($dat, 6);
        ($form, $len, $ver) = (unpack("n3", $dat));

        $s->{'Format'} = $form;
        $s->{'Ver'} = $ver;
        if ($form == 0)
        {
            my ($j) = 0;
            $fh->read($dat, 256);
            $s->{'val'} = {map {$j++, ($_ ? ($j, $_) : ())} unpack("C*", $dat)};
            $s->{'Start'} = 0;
            $s->{'Num'} = 256;
        } elsif ($form == 6)
        {
            my ($start, $ecount);
            
            $fh->read($dat, 4);
            ($start, $ecount) = unpack("n2", $dat);
            $fh->read($dat, $ecount << 1);
            $s->{'Start'} = $start;
            $s->{'Num'} = $ecount;
            $s->{'val'} = {map {$start++, ($_ ? ($start - 1, $_) : ())} unpack("n*", $dat)};
        } elsif ($form == 2)
        {
# no idea what to do here yet
        } elsif ($form == 4)
        {
            $fh->read($dat, 8);
            $num = unpack("n", $dat);
            $num >>= 1;
            $fh->read($dat, $len - 14);
            for ($j = 0; $j < $num; $j++)
            {
                $end = unpack("n", substr($dat, $j << 1, 2));
                $start = unpack("n", substr($dat, ($j << 1) + ($num << 1) + 2, 2));
                $delta = unpack("n", substr($dat, ($j << 1) + ($num << 2) + 2, 2));
                $delta -= 65536 if $delta > 32767;
                $range = unpack("n", substr($dat, ($j << 1) + $num * 6 + 2, 2));
                $s->{'Start'} = $start unless $j;
                for ($k = $start; $k <= $end; $k++)
                {
                    if ($range == 0)
                    { $id = $k + $delta; }
                    else
                    { $id = unpack("n", substr($dat, ($j << 1) + $num * 6 +
                                        2 + ($k - $start) * 2 + $range, 2)) + $delta; }
		            $id -= 65536 if $id >= 65536;
                    $s->{'val'}{$k} = $id if ($id);
                }
            }
            $s->{'Num'} = 0x10000;               # always ends here
        }
    }
    $self;
}


=head2 $t->ms_lookup($uni)

Given a Unicode value in the MS table (Platform 3, Encoding 1) locates that
table and looks up the appropriate glyph number from it.

=cut

sub ms_lookup
{
    my ($self, $uni) = @_;

    $self->find_ms || return undef unless (defined $self->{' mstable'});
    return $self->{' mstable'}{'val'}{$uni};
}


=head2 $t->find_ms

Finds the Microsoft Unicode table and sets the C<mstable> instance variable
to it if found. Returns the table it finds.

=cut
sub find_ms
{
    my ($self) = @_;
    my ($i, $s, $alt);

    return $self->{' mstable'} if defined $self->{' mstable'};
    $self->read;
    for ($i = 0; $i < $self->{'Num'}; $i++)
    {
        $s = $self->{'Tables'}[$i];
        if ($s->{'Platform'} == 3)
        {
            $self->{' mstable'} = $s;
            last if ($s->{'Encoding'} == 1);
        } elsif ($s->{'Platform'} == 0 || ($s->{'Platform'} == 2 && $s->{'Encoding'} == 1))
        { $self->{' mstable'} = $s; }
    }
    $self->{' mstable'};
}


=head2 $t->out($fh)

Writes out a cmap table to a filehandle. If it has not been read, then
just copies from input file to output

=cut

sub out
{
    my ($self, $fh) = @_;
    my ($loc, $s, $i, $base_loc, $j, @keys);

    return $self->SUPER::out($fh) unless $self->{' read'};

    $base_loc = $fh->tell();
    $fh->print(pack("n2", 0, $self->{'Num'}));

    for ($i = 0; $i < $self->{'Num'}; $i++)
    { $fh->print(pack("nnN", $self->{'Tables'}[$i]{'Platform'}, $self->{'Tables'}[$i]{'Encoding'}, 0)); }
    
    for ($i = 0; $i < $self->{'Num'}; $i++)
    {
        $s = $self->{'Tables'}[$i];
        @keys = sort {$a <=> $b} keys %{$s->{'val'}};
        $s->{' outloc'} = $fh->tell();
        $fh->print(pack("n3", $s->{'Format'}, 0, $s->{'Ver'}));       # come back for length
        if ($s->{'Format'} == 0)
        {
            $fh->print(pack("C256", @{$s->{'val'}}{0 .. 255}));
        } elsif ($s->{'Format'} == 6)
        {
            $fh->print(pack("n2", $s->{'Start'}, $s->{'Num'}));
            $fh->print(pack("n*", @{$s->{'val'}}{$s->{'Start'} .. $s->{'Start'} + $s->{'Num'} - 1}));
        } elsif ($s->{'Format'} == 2)
        {
        } elsif ($s->{'Format'} == 4)
        {
            my ($num, $sRange, $eSel, $eShift, @starts, @ends, $doff);
            my (@deltas, $delta, @range, $flat, $k, $segs, $count, $newseg, $v);

            push(@keys, 0xFFFF) unless ($keys[-1] == 0xFFFF);
            $newseg = 1; $num = 0;
            for ($j = 0; $j <= $#keys; $j++)
            {
                $v = $s->{'val'}{$keys[$j]};
                if ($newseg)
                {
                    $delta = $v;
                    $doff = $j;
                    $flat = 1;
                    push(@starts, $keys[$j]);
                    $newseg = 0;
                }
                $delta = 0 if ($delta + $j - $doff != $v);
                $flat = 0 if ($v == 0);
                if ($j == $#keys || $keys[$j] + 1 != $keys[$j+1])
                {
                    push (@ends, $keys[$j]);
                    push (@deltas, $delta ? $delta - $keys[$doff] : 0);
                    push (@range, $flat);
                    $num++;
                    $newseg = 1;
                }
            }

            ($num, $sRange, $eSel, $eShift) = Font::TTF::Utils::TTF_bininfo($num, 2);
            $fh->print(pack("n4", $num * 2, $sRange, $eSel, $eShift));
            $fh->print(pack("n*", @ends));
            $fh->print(pack("n", 0));
            $fh->print(pack("n*", @starts));
            $fh->print(pack("n*", @deltas));

            $count = 0;
            for ($j = 0; $j < $num; $j++)
            {
                $delta = $deltas[$j];
                if ($delta != 0 && $range[$j] == 1)
                { $range[$j] = 0; }
                else
                {
                    $range[$j] = ($count + $num - $j) << 1;
                    $count += $ends[$j] - $starts[$j] + 1;
                }
            }

            $fh->print(pack("n*", @range));

            for ($j = 0; $j < $num; $j++)
            {
                next if ($range[$j] == 0);
                $fh->print(pack("n*", @{$s->{'val'}}{$starts[$j] .. $ends[$j]}));
            }
        }

        $loc = $fh->tell();
        $fh->seek($s->{' outloc'} + 2, 0);
        $fh->print(pack("n", $loc - $s->{' outloc'}));
        $fh->seek($base_loc + 8 + ($i << 3), 0);
        $fh->print(pack("N", $s->{' outloc'} - $base_loc));
        $fh->seek($loc, 0);
    }
    $self;
}


=head2 @map = $t->reverse([$num])

Returns a reverse map of the table of given number or the Microsoft
cmap. I.e. given a glyph gives the Unicode value for it.

=cut

sub reverse
{
    my ($self, $tnum) = @_;
    my ($table) = defined $tnum ? $self->{'Tables'}[$tnum] : $self->find_ms;
    my (@res, $code, $gid);

    while (($code, $gid) = each(%{$table->{'val'}}))
    { $res[$gid] = $code unless ($res[$gid] > 0 && $res[$gid] < $code); }
    @res;
}

1;

=head1 BUGS

=item *

No support for format 2 tables (MBCS)

=head1 AUTHOR

Martin Hosken E<Martin_Hosken@sil.org>. See L<Font::TTF::Font> for copyright and
licensing.

=cut

