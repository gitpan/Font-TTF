package Font::TTF::Prep;

=head1 NAME

Font::TTF::Prep - Preparation hinting program. Called when ppem changes

=head1 DESCRIPTION

This is a minimal class adding nothing beyond a table, but is a repository
for prep type information for those processes brave enough to address hinting.

=cut

use strict;
use vars qw(@ISA $VERSION);

@ISA = qw(Font::TTF::Table);

$VERSION = 0.0001;


=head2 $t->read

Reads the data using C<read_dat>.

=cut

sub read
{ $_[0]->read_dat; }


=head1 BUGS

None known

=head1 AUTHOR

Martin Hosken L<Martin_Hosken@sil.org>. See L<Font::TTF::Font> for copyright and
licensing.

=cut

