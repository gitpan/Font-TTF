package Font::TTF::Glyph;

=head1 NAME

Font::TTF::Glyph - Holds a single glyph's information

=head1 DESCRIPTION

This is a single glyph description as held in a TT font. On creation only its
header is read. Thus you can get the bounding box of each glyph without having
to read all the other information.

=head1 INSTANCE VARIABLES

In addition to the named variables in a glyph header (C<xMin> etc.), there are
also all capital instance variables for holding working information, mostly
from the location table.

The standard attributes each glyph has are:

 numberOfContours
 xMin
 yMin
 xMax
 yMax

There are also other, derived, instance variables for each glyph which are read
when the whole glyph is read (via C<read_dat>):

=over 4

=item instLen

Number of bytes in the hinting instructions (Warning this variable is deprecated,
use C<length($g->{'hints'})> instead).

=item hints

The string containing the hinting code for the glyph

=back

In addition there are other attribute like instance variables for simple glyphs:

=over 4

For each contour there is:

=over 4

=item endPoints

An array of endpoints for each contour in the glyph. There are
C<numberOfContours> contours in a glyph. The number of points in a glyph is
equal to the highest endpoint of a contour.

=back

There are also a number of arrays indexed by point number

=over 4

=item flags

The flags associated with reading this point. The flags for a point are
recalculated for a point when it is C<update>d. Thus the flags are not very
useful. The only important bit is bit 0 which indicates whether the point is
an 'on' curve point, or an 'off' curve point.

=item x

The absolute x co-ordinate of the point.

=item y

The absolute y co-ordinate of the point

=back

=back

For composite glyphs there are other variables

=over 4

=item metric

This holds the component number (not its glyph number) of the component from
which the metrics for this glyph should be taken.

=item comps

This is an array of hashes for each component. Each hash has a number of
elements:

=over 4

=item glyph

The glyph number of the glyph which comprises this component of the composite.

=item args

An array of two arguments which may be an x, y co-ordinate or two attachment
points (one on the base glyph the other on the component). See flags for details.

=item flag

The flag for this component

=item scale

A 4 number array for component scaling. This allows stretching, rotating, etc.
Note that scaling applies to placement co-ordinates (rather than attachment points)
before locating rather than after.

=back

=item numPoints

This is a generated value which contains the number of components read in for this
compound glyph.

=back

The private instance variables are:

=over 4

=item INFILE (P)

The input file form which to read any information

=item LOC (P)

Location relative to the start of the glyf table in the read file

=item BASE (P)

The location of the glyf table in the read file

=item LEN (P)

This is the number of bytes required by the glyph. It should be kept up to date
by calling the C<update> method whenever any of the glyph content changes.

=item OUTLOC (P)

Location relative to the start of the glyf table. This variable is only active
whilst the output process is going on. It is used to inform the location table
where the glyph's location is, since the glyf table is output before the loca
table due to alphabetical ordering.

=item OUTLEN (P)

This indicates the length of the glyph data when it is output. This more
accurately reflects the internal memory form than the C<LEN> variable which
only reflects the read file length. The C<OUTLEN> variable is only set after
calling C<out> or C<out_dat>.

=back

=head1 METHODS

=cut

use strict;
use vars qw(%fields);
use Font::TTF::Utils;

sub init
{
    my ($k, $v, $c);
    while (<Font::TTF::Glyph::DATA>)
    {
        ($k, $v, $c) = TTF_Init_Fields($_, $c);
        next unless $k ne "";
        $fields{$k} = $v;
    }
}


=head1 Font::TTF::Glyph->new(%parms)

Creates a new glyph setting various instance variables

=cut

sub new
{
    my ($class, %parms) = @_;
    my ($self) = {};
    my ($p);

    bless $self, $class;
    foreach $p (keys %parms)
    { $self->{"$p"} = $parms{$p}; }
    init unless defined $fields{'xMin'};
    $self;
}


=head2 $g->read

Reads the header component of the glyph (bounding box, etc.) and also the
glyph content, but into a data field rather than breaking it down into
its constituent structures. Use L<read_dat> for this.

=cut

sub read
{
    my ($self) = @_;
    my ($fh) = $self->{'INFILE'};
    my ($dat);

    return $self if $self->{' read'};
    $self->{' read'} = 1;
    $fh->seek($self->{'LOC'} + $self->{'BASE'}, 0);
    $fh->read($self->{'DAT'}, $self->{'LEN'});
    TTF_Read_Fields($self, $self->{'DAT'}, \%fields);
    $self;
}


=head2 $g->read_dat

Reads the contents of the glyph (components and curves, etc.) from the memory
store C<DAT> into structures within the object. Then, to indicate where the
master form of the data is, it deletes the C<DAT> instance variable.

=cut

sub read_dat
{
    my ($self) = @_;
    my ($dat, $num, $max, $i, $flag, $len, $val, $val1, $fp);

    return $self if $self->{' read'} > 1;
    $self->read unless $self->{' read'};
    $dat = $self->{'DAT'};
    $fp = 10;
    $num = $self->{'numberOfContours'};
    if ($num > 0)
    {
        $self->{'endPoints'} = [unpack("n*", substr($dat, $fp, $num << 1))];
        $fp += $num << 1;
        foreach (@{$self->{'endPoints'}})
        { $max = $_ if $_ > $max; }
        $max++;
        $self->{'numPoints'} = $max;
        $self->{'instLen'} = unpack("n", substr($dat, $fp));
        $self->{'hints'} = substr($dat, $fp + 2, $self->{'instLen'});
        $fp += 2 + $self->{'instLen'};
# read the flags array
        for ($i = 0; $i < $max; $i++)                   
        {
            $flag = unpack("C", substr($dat, $fp++));
            $self->{'flags'}[$i] = $flag;
            if ($flag & 8)
            {
                $len = unpack("C", substr($dat, $fp++));
                while ($len-- > 0)
                {
                    $i++;
                    $self->{'flags'}[$i] = $flag;
                }
            }
        }
#read the x array
        for ($i = 0; $i < $max; $i++)
        {
            $flag = $self->{'flags'}[$i];
            if ($flag & 2)
            {
                $val = unpack("C", substr($dat, $fp++));
                $val = -$val unless ($flag & 16);
            } elsif ($flag & 16)
            { $val = 0; }
            else
            {
                $val = TTF_Unpack("s", substr($dat, $fp));
                $fp += 2;
            }
            $self->{'x'}[$i] = $i == 0 ? $val : $self->{'x'}[$i - 1] + $val;
        }
#read the y array
        for ($i = 0; $i < $max; $i++)
        {
            $flag = $self->{'flags'}[$i];
            if ($flag & 4)
            {
                $val = unpack("C", substr($dat, $fp++));
                $val = -$val unless ($flag & 32);
            } elsif ($flag & 32)
            { $val = 0; }
            else
            {
                $val = TTF_Unpack("s", substr($dat, $fp));
                $fp += 2;
            }
            $self->{'y'}[$i] = $i == 0 ? $val : $self->{'y'}[$i - 1] + $val;
        }
    }
    
# compound glyph
    elsif ($num < 0)
    {
        $flag = 1 << 5;             # cheat to get the loop going
        for ($i = 0; $flag & 32; $i++)
        {
            ($flag, $self->{'comps'}[$i]{'glyph'}) = unpack("n2", substr($dat, $fp));
            $fp += 4;
            $self->{'comps'}[$i]{'flag'} = $flag;
            if ($flag & 1)              # ARGS1_AND_2_ARE_WORDS
            {
                $self->{'comps'}[$i]{'args'} = [TTF_Unpack("s2", substr($dat, $fp))];
                $fp += 4;
            } else
            {
                $self->{'comps'}[$i]{'args'} = [unpack("c2", substr($dat, $fp))];
                $fp += 2;
            }
            
            if ($flag & 8)
            {
                $val = TTF_Unpack("F", substr($dat, $fp));
                $fp += 2;
                $self->{'comps'}[$i]{'scale'} = [$val, 0, 0, $val];
            } elsif ($flag & 64)
            {
                ($val, $val1) = TTF_Unpack("F2", substr($dat, $fp));
                $fp += 4;
                $self->{'comps'}[$i]{'scale'} = [$val, 0, 0, $val1];
            } elsif ($flag & 128)
            {
                $self->{'comps'}[$i]{'scale'} = [TTF_Unpack("F4", substr($dat, $fp))];
                $fp += 8;
            }
            $self->{'metric'} = $i if ($flag & 512);
        }
        $self->{'numPoints'} = $i;
        if ($flag & 256)            # HAVE_INSTRUCTIONS
        {
            $self->{'instLen'} = unpack("n", substr($dat, $fp));
            $self->{'hints'} = substr($dat, $fp + 2, $self->{'instLen'});
            $fp += 2 + $self->{'instLen'};
        }
    }
    return undef if ($fp > length($dat));
    $self->{' read'} = 2;
    $self;
}


=head2 $g->out($fh)

Writes the glyph data to outfile

=cut

sub out
{
    my ($self, $fh) = @_;

    $self->read unless $self->{' read'};
    $self->update if $self->{' isDirty'};
    $fh->print($self->{'DAT'});
    $self->{'OUTLEN'} = length($self->{'DAT'});
    $self;
}


=head2 $g->update

Generates a C<$self->{'DAT'}> from the internal structures, if the data has
been read into structures in the first place. If you are building a glyph
from scratch you will need to set the instance variable C<' read'> to 2 (or
something > 1) for the update to work.

=cut

sub update
{
    my ($self) = @_;
    my ($dat, $loc, $len, $flag, $x, $y, $i, $comp, $num);

    return $self unless $self->{' read'} > 1;
    $self->{'DAT'} = TTF_Out_Fields($self, \%fields, 10);
    $num = $self->{'numberOfContours'};
    if ($num > 0)
    {
        $self->{'DAT'} .= pack("n*", @{$self->{'endPoints'}});
        $len = $self->{'instLen'};
        $self->{'DAT'} .= pack("n", $len);
        $self->{'DAT'} .= pack("a" . $len, substr($self->{'hints'}, 0, $len));
        for ($i = 0; $i < $self->{'numPoints'}; $i++)
        {
            $flag = $self->{'flags'}[$i] & 1;
            if ($i == 0)
            {
                $x = $self->{'x'}[$i];
                $y = $self->{'y'}[$i];
            } else
            {
                $x = $self->{'x'}[$i] - $self->{'x'}[$i - 1];
                $y = $self->{'y'}[$i] - $self->{'y'}[$i - 1];
            }
            $flag |= 16 if ($x == 0);
            $flag |= 32 if ($y == 0);
            if (($flag & 16) == 0 && $x < 256 && $x > -256)
            {
                $flag |= 2;
                $flag |= 16 if ($x >= 0);
            }
            if (($flag & 32) == 0 && $y < 256 && $y > -256)
            {
                $flag |= 4;
                $flag |= 32 if ($y >= 0);
            }
            $self->{'DAT'} .= pack("C", $flag);                    # sorry no repeats
            $self->{'flags'}[$i] = $flag;
        }
        for ($i = 0; $i < $self->{'numPoints'}; $i++)
        {
            $flag = $self->{'flags'}[$i];
            $x = $self->{'x'}[$i] - (($i == 0) ? 0 : $self->{'x'}[$i - 1]);
            if (($flag & 18) == 0)
            { $self->{'DAT'} .= TTF_Pack("s", $x); }
            elsif (($flag & 18) == 18)
            { $self->{'DAT'} .= pack("C", $x); }
            elsif (($flag & 18) == 2)
            { $self->{'DAT'} .= pack("C", -$x); }
        }
        for ($i = 0; $i < $self->{'numPoints'}; $i++)
        {
            $flag = $self->{'flags'}[$i];
            $y = $self->{'y'}[$i] - (($i == 0) ? 0 : $self->{'y'}[$i - 1]);
            if (($flag & 36) == 0)
            { $self->{'DAT'} .= TTF_Pack("s", $y); }
            elsif (($flag & 36) == 36)
            { $self->{'DAT'} .= pack("C", $y); }
            elsif (($flag & 36) == 4)
            { $self->{'DAT'} .= pack("C", -$y); }
        }
    }

    elsif ($num < 0)
    {
        for ($i = 0; $i <= $#{$self->{'comps'}}; $i++)
        {
            $comp = $self->{'comps'}[$i];
            $flag = $comp->{'flag'} & 7174;        # bits 2,4,10,11,12
            $flag |= 1 unless ($comp->{'args'}[0] > -129 && $comp->{'args'}[0] < 128
                    && $comp->{'args'}[1] > -129 && $comp->{'args'}[1] < 128);
            if ($comp->{'scale'}[1] == 0 && $comp->{'scale'}[2] == 0)
            {
                if ($comp->{'scale'}[0] == $comp->{'scale'}[3])
                { $flag |= 8 unless ($comp->{'scale'}[0] == 0); }
                else
                { $flag |= 64; }
            } else
            { $flag |= 128; }
            
            $flag |= 512 if (defined $self->{'metric'} && $self->{'metric'} == $i);
            if ($i == $#{$self->{'comps'}})
            { $flag |= 256 if ($self->{'instLen'} > 0); }
            else
            { $flag |= 32; }
            
            $self->{'DAT'} .= pack("n", $flag);
            $self->{'DAT'} .= pack("n", $comp->{'glyph'});
            $comp->{'flag'} = $flag;

            if ($flag & 1)
            { $self->{'DAT'} .= TTF_Pack("s2", @{$comp->{'args'}}); }
            else
            { $self->{'DAT'} .= pack("CC", @{$comp->{'args'}}); }

            if ($flag & 8)
            { $self->{'DAT'} .= TTF_Pack("F", $comp->{'scale'}[0]); }
            elsif ($flag & 64)
            { $self->{'DAT'} .= TTF_Pack("F2", $comp->{'scale'}[0], $comp->{'scale'}[3]); }
            elsif ($flag & 128)
            { $self->{'DAT'} .= TTF_Pack("F4", @{$comp->{'scale'}}); }
        }
        if ($self->{'instLen'} > 0)
        {
            $len = $self->{'instLen'};
            $self->{'DAT'} .= pack("n", $len);
            $self->{'DAT'} .= pack("a" . $len, substr($self->{'hints'}, 0, $len));
        }
    }
    $self->{'DAT'} .= "\000" if (length($self->{'DAT'}) & 1);
    $self->{'OUTLEN'} = length($self->{'DAT'});
# we leave numPoints and instLen since maxp stats use this
    $self;
}


=head2 $g->maxInfo($parent)

Returns lots of information about a glyph so that the C<maxp> table can update
itself. $parent is an attempt for glyphs to not have to know their ownership.
It is the array in which the glyph and all its components may be found.

=cut

sub maxInfo
{
    my ($self, $parent) = @_;
    my (@res, $i, @n);

    $self->read_dat;            # make sure we've read some data
    $res[4] = length($self->{'hints'}) if defined $self->{'hints'};
    if ($self->{'numberOfContours'} > 0)
    {
        $res[0] = $self->{'numPoints'};
        $res[1] = $self->{'numberOfContours'};
        $res[6] = 1;
    } elsif ($self->{'numberOfContours'} < 0)
    {
        $res[6] = 1;
        for ($i = 0; $i <= $#{$self->{'comps'}}; $i++)
        {
            @n = $parent->[$self->{'comps'}[$i]{'glyph'}]->maxInfo;
            $res[2] += $n[2] == 0 ? $n[0] : $n[2];
            $res[3] += $n[3] == 0 ? $n[1] : $n[3];
            $res[5]++;
            $res[6] = $n[6] + 1 if ($n[6] >= $res[6]);
        }
    }
    @res;
}

1;

=head1 BUGS

=item *

The instance variables used here are somewhat clunky and inconsistent with
the other tables.

=item *

Is a glyph not knowing its owning object a good or bad thing? Currently it
doesn't know.

=item *

C<update> doesn't re-calculate the bounding box or C<numberOfContours>.

=head1 AUTHOR

Martin Hosken L<Martin_Hosken@sil.org>. See L<Font::TTF::Font> for copyright and
licensing.

=cut

__DATA__
numberOfContours, s
xMin, s
yMin, s
xMax, s
yMax, s

