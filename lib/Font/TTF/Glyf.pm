package Font::TTF::Glyf;

=head1 NAME

Font::TTF::Glyf - The Glyf data table

=head1 DESCRIPTION

This is a stub table. The real data is held in the loca table. If you want to get a glyf
look it up in the loca table as C<$f->{'loca'}{'glyph'}[$num]>. It won't be here!

The difference between reading this table as opposed to the loca table is that
reading this table will cause updated glyphs to be written out rather than just
copying the glyph information from the input file. This causes font writing to be
slower. So read the glyf as opposed to the loca table if you want to change glyf
data. Read the loca table only if you are just wanting to read the glyf information.

This class is used when writing the glyphs though.

=head1 METHODS

=cut


use strict;
use vars qw(@ISA);
@ISA = qw(Font::TTF::Table);

=head2 $t->read

Reads the C<loca> table instead!

=cut

sub read
{
    my ($self) = @_;
    
    $self->{' PARENT'}{'loca'}->read;
    $self->{' read'} = 1;
    $self;
}


=head2 $t->out($fh)

Writes out all the glyphs in the parent's location table, calculating a new
output location for each one.

=cut

sub out
{
    my ($self, $fh) = @_;
    my ($i, $loca, $offset, $numGlyphs);

    return $self->SUPER::out($fh) unless $self->{' read'};

    $loca = $self->{' PARENT'}{'loca'}{'glyphs'};
    $numGlyphs = $self->{' PARENT'}{'maxp'}{'numGlyphs'};

    $offset = 0;
    for ($i = 0; $i < $numGlyphs; $i++)
    {
        next unless defined $loca->[$i];
        $loca->[$i]->update;
        $loca->[$i]{'OUTLOC'} = $offset;
        $loca->[$i]->out($fh);
        $offset += $loca->[$i]{'OUTLEN'};
    }
    $self;
}

1;

=head1 BUGS

None known

=head1 AUTHOR

Martin Hosken Martin_Hosken@sil.org. See L<Font::TTF::Font> for copyright and
licensing.

=cut

