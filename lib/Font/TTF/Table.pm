package Font::TTF::Table;

=head1 NAME

Font::TTF::Table - Superclass for tables and used for tables we don't have a class for

=head1 DESCRIPTION

Looks after the purely table aspects of a TTF table, such as whether the table
has been read before, locating the file pointer, etc. Also copies tables from
input to output.

=head1 INSTANCE VARIABLES

Instance variables start with a space

=over 4

=item read

Flag which indicates that the table has already been read from file.

=item dat

Allows the creation of unspecific tables. Data is simply output to any font
file being created.

=item INFILE

The read file handle

=item OFFSET

Location of the file in the input file

=item LENGTH

Length in the input directory

=item CSUM

Checksum read from the input file's directory

=item PARENT

The L<Font::TTF::Font> that table is part of

=back

=head1 METHODS

=cut

use strict;
use vars qw($VERSION);

$VERSION = 0.0001;

=head2 Font::TTF::Table->new(%parms)

Creates a new table or subclass. Table instance variables are passed in
at this point as an associative array.

=cut

sub new
{
    my ($class, %parms) = @_;
    my ($self) = {};
    my ($p);

    $class = ref($class) || $class;
    foreach $p (keys %parms)
    { $self->{" $p"} = $parms{$p}; }
    bless $self, $class;
}


=head2 $t->read

Reads the table from the input file. Acts as a superclass to all true tables.
This method marks the table as read and then just sets the input file pointer
but does not read any data. If the table has already been read, then returns
C<undef> else returns C<$self>

=cut.

sub read
{
    my ($self) = @_;

    return $self->read_dat if (ref($self) eq qq/__PACKAGE__/);
    return undef if $self->{' read'};
    $self->{' INFILE'}->seek($self->{' OFFSET'}, 0);
    $self->{' read'} = 1;
    $self;
}


=head2 $t->read_dat

Reads the table into the C<dat> instance variable for those tables which don't
know any better

=cut

sub read_dat
{
    my ($self) = @_;

# can't just $self->read here otherwise those tables which start their read sub with
# $self->read_dat are going to permanently loop
    return undef if ($self->{' read'});
    $self->{' read'} = 1;
    $self->{' INFILE'}->seek($self->{' OFFSET'}, 0);
    $self->{' INFILE'}->read($self->{' dat'}, $self->{' LENGTH'});
    $self;
}

=head2 $t->out($fh)

Writes out the table to the font file. If there is anything in the
C<data> instance variable then this is output, otherwise the data is copied
from the input file to the output

=cut

sub out
{
    my ($self, $fh) = @_;
    my ($dat, $i, $len, $count);

    if (defined $self->{' dat'})
    {
        $fh->print($self->{' dat'});
        return $self;
    }

    return undef unless defined $self->{' INFILE'};
    $self->{' INFILE'}->seek($self->{' OFFSET'}, 0);
    $len = $self->{' LENGTH'};
    while ($len > 0)
    {
        $count = ($len > 4096) ? 4096 : $len;
        $self->{' INFILE'}->read($dat, $count);
        $fh->print($dat);
        $len -= $count;
    }
    $self;
}


=head2 $t->update

Each table knows how to update itself. This consists of doing whatever work
is required to ensure that the memory version of the table is consistent
and that other parameters in other tables have been updated accordingly.
I.e. by the end of sending C<update> to all the tables, the memory version
of the font should be entirely consistent.

Some tables which do no work indicate to themselves the need to update
themselves by setting isDirty above 1. This method resets that accordingly.

=cut

sub update
{ $_[0]{' isDirty'} = 1 if $_[0]{' isDirty'} > 1; $_[0]; }


=head2 $t->empty

Clears a table of all data to the level of not having been read

=cut

sub empty
{
    my ($self) = @_;
    my (%keep);

    foreach (qw(INFILE LENGTH OFFSET CSUM PARENT))
    { $keep{" $_"} = 1; }

    map {delete $self->{$_} unless $keep{$_}} keys %$self;
    $self;
}

1;

=head1 BUGS

No known bugs

=head1 AUTHOR

Martin Hosken L<Martin_Hosken@sil.org>. See L<Font::TTF::Font> for copyright and
licensing.

=cut

