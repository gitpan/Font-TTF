package Font::TTF::Glyf;

=head1 NAME

Font::TTF::Glyf - The Glyf data table

=head1 DESCRIPTION

This is a stub table. The real data is held in the loca table. If you want to get a glyf
look it up in the loca table as C<$f->{'loca'}{'glyph'}[$num]>. It won't be here!

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
    $numGlyphs = $self->{' PARENT'}{'maxp'}->read->{'numGlyphs'};

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

Martin Hosken L<Martin_Hosken@sil.org>. See L<Font::TTF::Font> for copyright and
licensing.

=cut

