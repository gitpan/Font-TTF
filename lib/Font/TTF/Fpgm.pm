package Font::TTF::Fpgm;

=head1 NAME

Font::TTF::Fpgm - Font program in a TrueType font. Called when a font is loaded

=head1 DESCRIPTION

This is a minimal class adding nothing beyond a table, but is a repository
for fpgm type information for those processes brave enough to address hinting.

=cut

use strict;
use vars qw(@ISA $VERSION);

@ISA = qw(Font::TTF::Table);

$VERSION = 0.0001;

=head2 $t->read

Reading this table is simply a process of reading all the data into the RAM
copy. Nothing more is done with it.

=cut

sub read
{ $_[0]->read_dat; }

1;

=head1 BUGS

None known

=head1 AUTHOR

Martin Hosken L<Martin_Hosken@sil.org>. See L<Font::TTF::Font> for copyright and
licensing.

=cut

