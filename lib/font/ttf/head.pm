package Font::TTF::Head;

=head1 NAME

Font::TTF::Head - The head table for a TTF Font

=head1 DESCRIPTION

This is a very basic table with just instance variables as described in the
TTF documentation, using the same names. One of the most commonly used is
C<unitsPerEm>.

=head1 INSTANCE VARIABLES

The C<head> table has no internal instance variables beyond those common to all
tables and those specified in the standard:

    version
    fontRevision
    checkSumAdjustment
    magicNumber
    flags
    unitsPerEm
    created
    modified
    xMin
    yMin
    xMax
    yMax
    macStyle
    lowestRecPPEM
    fontDirectionHint
    indexToLocFormat
    glyphDataFormat

The two dates are held as an array of two unsigned longs (32-bits)

=head1 METHODS

=cut

use strict;
use vars qw(@ISA %fields);

require Font::TTF::Table;
use Font::TTF::Utils;

@ISA = qw(Font::TTF::Table);

sub init
{
    my ($k, $v, $c);
    while (<Font::TTF::Head::DATA>)
    {
        ($k, $v, $c) = TTF_Init_Fields($_, $c);
        next unless $k ne "";
        $fields{$k} = $v;
    }
}


=head2 $t->read

Reads the table into memory thanks to some utility functions

=cut

sub read
{
    my ($self) = @_;
    my ($dat);

    $self->SUPER::read || return $self;

    init unless defined $fields{'Ascender'};
    read($self->{' INFILE'}, $dat, 54);

    TTF_Read_Fields($self, $dat, \%fields);
    $self;
}


=head2 $t->out($fh)

Writes the table to a file either from memory or by copying. If in memory
(which is usually) the checkSumAdjustment field is set to 0 as per the default
if the file checksum is not to be considered.

=cut

sub out
{
    my ($self, $fh) = @_;

    return $self->SUPER::out($fh) unless $self->{' read'};      # this is never true
    $self->{'checkSumAdjustment'} = 0;
    print $fh TTF_Out_Fields($self, \%fields, 54);
    $self;
}

=head2 $t->update

Updates the head table based on the glyph data and the hmtx table

=cut

sub update
{
    my ($self) = @_;
    my ($num, $i, $loc, $hmtx);
    my ($xMin, $yMin, $xMax, $yMax, $lsbx);

    $num = $self->{' PARENT'}{'maxp'}{'numGlyphs'};
    return undef unless (defined $self->{' PARENT'}{'hmtx'} && defined $self->{' PARENT'}{'loca'});
    $hmtx = $self->{' PARENT'}{'hmtx'}->read;
    return undef unless ($self->{' PARENT'}{'loca'}{' isDirty'} || $hmtx->{' isDirty'});
    
    $self->{' PARENT'}{'loca'}->update;
    $hmtx->update;
    $lsbx = 1;
    for ($i = 0; $i < $num; $i++)
    {
        $loc = $self->{' PARENT'}{'loca'}{'glyphs'}[$i];
        next unless defined $loc;
        $loc->read;
        $xMin = $loc->{'xMin'} if ($loc->{'xMin'} < $xMin || $i == 0);
        $yMin = $loc->{'yMin'} if ($loc->{'yMin'} < $yMin || $i == 0);
        $xMax = $loc->{'xMax'} if ($loc->{'xMax'} > $xMax);
        $yMax = $loc->{'yMax'} if ($loc->{'yMax'} > $yMax);
        $lsbx &= ($loc->{'xMin'} == $hmtx->{'lsb'}[$i]);
    }
    $self->{'xMin'} = $xMin;
    $self->{'yMin'} = $yMin;
    $self->{'xMax'} = $xMax;
    $self->{'yMax'} = $yMax;
    if ($lsbx)
    { $self->{'flags'} |= 2; }
    else
    { $self->{'flags'} &= ~2; }
    $self->{' isDirty'} = 1;            # tell everyone else we've changed (I assume)
    $self;
}

1;


=head1 BUGS

None known

=head1 AUTHOR

Martin Hosken L<Martin_Hosken@sil.org>. See L<Font::TTF::Font> for copyright and
licensing.

=cut


__DATA__
version, f
fontRevision, f
checkSumAdjustment, L
magicNumber, L
flags, S
unitsPerEm, S
created, L2
modified, L2
xMin, s
yMin, s
xMax, s
yMax, s
macStyle, S
lowestRecPPEM, S
fontDirectionHint, s
indexToLocFormat, s
glyphDataFormat, s

