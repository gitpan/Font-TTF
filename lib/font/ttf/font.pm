package Font::TTF::Font;

=head1 NAME

Font::TTF::Font - Memory representation of a font

=head1 SYNOPSIS

Here is the regression test (you provide your own font). Run it once and then
again on the output of the first run. There should be no differences between
the outputs of the two runs.

    $f = Font::TTF::Font->open($ARGV[0]);

    # force a read of all the tables
    $f->tables_do(sub { $_[0]->read; });

    # force read of all glyphs (use read_dat to use lots of memory!)
    # $f->{'loca'}->glyphs_do(sub { $_[0]->read; });
    $f->{'loca'}->glyphs_do(sub { $_[0]->read_dat; });
    # NB. no need to $g->update since $f->{'glyf'}->out will do it for us

    $f->out($ARGV[1]);
    $f->DESTROY;               # forces close of $in and maybe memory reclaim!

=head1 DESCRIPTION

A Truetype font consists of a header containing a directory of tables which
constitute the rest of the file. This class holds that header and directory and
also creates objects of the appropriate type for each table within the font.
Note that it does not read each table into memory, but creates a short reference
which can be read using the form:

    $f->{$tablename}->read;

Classes are included that support many of the different TrueType tables. For
those for which no special code exists, the table type C<table> is used, which
defaults to L<Font::TTF::Table>. The current tables which are supported are:

    table       Font::TTF::Table      - for unknown tables
    LTSH        Font::TTF::LTSH
    OS/2        Font::TTF::OS_2
    PCLT        Font::TTF::PCLT
    cmap        Font::TTF::Cmap
    cvt         Font::TTF::Cvt_
    fpgm        Font::TTF::Fpgm
    glyf        Font::TTF::Glyf       - see also Font::TTF::Glyph
    hdmx        Font::TTF::Hdmx
    head        Font::TTF::Head
    hhea        Font::TTF::Hhea
    hmtx        Font::TTF::Hmtx
    kern        Font::TTF::Kern
    loca        Font::TTF::Loca
    maxp        Font::TTF::Maxp
    name        Font::TTF::Name
    post        Font::TTF::Post
    prep        Font::TTF::Prep
    vhea        Font::TTF::Vhea
    vmtx        Font::TTF::Vmtx

=head1 INSTANCE VARIABLES

Instance variables begin with a space (and have lengths greater than the 4
characters which make up table names).

=over

=item nocsum

This is used during output to disable the creation of the file checksum in the
head table. For example, during DSIG table creation, this flag will be set to
ensure that the file checksum is left at zero.

=item fname (R)

Contains the filename of the font which this object was read from.

=item INFILE (P)

The file handle which reflects the source file for this font.

=item OFFSET (P)

Contains the offset from the beginning of the read file of this particular
font directory, thus providing support for TrueType Collections.

=back

=head1 METHODS

=cut

use strict;
use vars qw(%tables $VERSION);
use Symbol();

$VERSION = 0.03;    #   MJPH     9-MAR-1999     Move to Font::TTF for CPAN
# $VERSION = 0.02;  #   MJPH    12-FEB-1999     Add support for ' nocsum' for DSIGS
# $VERSION = 0.0001;

%tables = (
        'table' => 'Font::TTF::Table',
        'LTSH' => 'Font::TTF::LTSH',
        'OS/2' => 'Font::TTF::OS_2',
        'PCLT' => 'Font::TTF::PCLT',
        'cmap' => 'Font::TTF::Cmap',
        'cvt ' => 'Font::TTF::Cvt_',
        'fpgm' => 'Font::TTF::Fpgm',
        'glyf' => 'Font::TTF::Glyf',
        'hdmx' => 'Font::TTF::Hdmx',
        'head' => 'Font::TTF::Head',
        'hhea' => 'Font::TTF::Hhea',
        'hmtx' => 'Font::TTF::Hmtx',
        'kern' => 'Font::TTF::Kern',
        'loca' => 'Font::TTF::Loca',
        'maxp' => 'Font::TTF::Maxp',
        'name' => 'Font::TTF::Name',
        'post' => 'Font::TTF::Post',
        'prep' => 'Font::TTF::Prep',
        'vhea' => 'Font::TTF::Vhea',
        'vmtx' => 'Font::TTF::Vmtx',
          );


=head2 Font::TTF::Font->AddTable($tablename, $class)

Adds the given class to be used when representing the given table name. It also
'requires' the class for you.

=cut

sub AddTable
{
    my ($class, $table, $useclass);

    $tables{$table} = $useclass;
#    $useclass =~ s|::|/|oig;
#    require "$useclass.pm";
}


=head2 Font::TTF::Font->Init

For those people who like making fonts without reading them. This subroutine
will require all the table code for the various table types for you. Not
needed if using Font::TTF::Font::read before using a table.

=cut

sub Init
{
    my ($class) = @_;
    my ($t);

    foreach $t (keys %tables)
    {
        $t =~ s|::|/|oig;
        require "$t.pm";
    }
}

=head2 Font::TTF::Font->new(%props)

Creates a new font object and initialises with the given properties. This is
primarily for use when a TTF is embedded somewhere. Notice that the properties
are automatically preceded by a space when inserted into the object. This is in
order that fields do not clash with tables.

=cut

sub new
{
    my ($class, %props) = @_;
    my ($self) = {};

    bless $self, $class;

    foreach (keys %props)
    { $self->{" $_"} = $props{$_}; }
    $self;
}


=head2 Font::TTF::Font->open($fname)

Reads the header and directory for the given font file and creates appropriate
objects for each table in the font.

=cut

sub open
{
    my ($class, $fname) = @_;

    my ($self) = {};
    my ($fh) = Symbol->gensym();

    open($fh, $fname) or return undef;
    binmode $fh;
    $self->{' INFILE'} = $fh;
    $self->{' fname'} = $fname;
    $self->{' OFFSET'} = 0;
    bless $self, $class;
    
    $self->read;
}

=head2 $f->read

Reads a Truetype font directory starting from the current location in the file.
This has been separated from the C<open> function to allow support for embedded
TTFs for example in TTCs. Also reads the C<head> and C<maxp> tables immediately.

=cut

sub read
{
    my ($self) = @_;
    my ($fh) = $self->{' INFILE'};
    my ($dat, $i, $ver, $dir_num, $type, $name, $check, $off, $len, $t);

    seek($fh, $self->{' OFFSET'}, 0);
    read($fh, $dat, 12);
    ($ver, $dir_num) = unpack("Nn", $dat);
    $ver == 1 << 16 or return undef;
    
    for ($i = 0; $i < $dir_num; $i++)
    {
        read($fh, $dat, 16) || die "Reading table entry";
        ($name, $check, $off, $len) = unpack("a4NNN", $dat);
        $self->{$name} = $self->{' PARENT'}->find($self, $name, $check, $off, $len) && next
                if (defined $self->{' PARENT'});
        $type = $tables{$name} || 'Font::TTF::Table';
        $t = $type;
        $t =~ s|::|/|oig;
        require "$t.pm";
        $self->{$name} = $type->new(PARENT  => $self,
                                    NAME    => $name,
                                    INFILE  => $fh,
                                    OFFSET  => $off,
                                    LENGTH  => $len,
                                    CSUM    => $check);
    }
    
    foreach $t ('head', 'maxp')
    { $self->{$t}->read if defined $self->{$t}; }

    $self;
}


=head2 $f->out($fname, @tablelist)

Writes a TTF file consisting of the tables in tablelist. Only those tables
which this font object has in its directory, will be output. Thus the
following code is applicable:

    $font->out($fname, keys %$font)

which will output all the tables in $font.

Returns $f on success and undef on failure, including warnings.

All output files must include the C<head> table.

=cut

sub out
{
    my ($self, $fname, @tlist) = @_;
    my ($fh) = Symbol->gensym();
    my ($dat, $numTables, $sRange, $eSel);
    my (%dir, $k, $mloc, $count);
    my ($csum, $lsum, $msum, $loc, $oldloc, $len, $shift);

    open($fh, "+>$fname") || return warn "Unable to open $fname";
    binmode $fh;
    $self->{' oname'} = $fname;
    $self->{' outfile'} = $fh;

    if ($self->{' wantsig'})
    {
        $self->{' tempDSIG'} = $self->{'DSIG'};
        $self->{'DSIG'} = undef;
    }
    @tlist = keys %$self unless ($#tlist >= 0);
    @tlist = sort grep(length($_) == 4 && defined $self->{$_}, @tlist);

    ($numTables, $sRange, $eSel, $shift) = Font::TTF::Utils::TTF_bininfo($#tlist + 1, 16);
    $dat = pack("Nnnnn", 1 << 16, $numTables, $sRange, $eSel, $shift);
    print $fh $dat;
    $msum = unpack("%32N*", $dat);

# reserve place holders for each directory entry
    foreach $k (@tlist)
    {
        $dir{$k} = pack("A4NNN", $k, 0, 0, 0);
        print $fh $dir{$k};
    }

    $loc = tell($fh);
    if ($loc & 3)
    {
        print $fh substr("\000" x 4, $loc & 3);
        $loc += 4 - ($loc & 3);
    }

    foreach $k (@tlist)
    {
        $oldloc = $loc;
        $self->{$k}->out($fh);
        $loc = tell($fh);
        $len = $loc - $oldloc;
        if ($loc & 3)
        {
            print $fh substr("\000" x 4, $loc & 3);
            $loc += 4 - ($loc & 3);
        }
        seek($fh, $oldloc, 0);
        $csum = 0; $mloc = $loc;
        while ($mloc > $oldloc)
        {
            $count = ($mloc - $oldloc > 4096) ? 4096 : $mloc - $oldloc;
            read ($fh, $dat, $count);
            $csum += unpack("%32N*", $dat);
# this line ensures $csum stays within 32 bit bounds, clipping as necessary
            if ($csum > 0xffffffff) { $csum -= 0xffffffff; $csum--; }
            $mloc -= $count;
        }
        $dir{$k} = pack("A4NNN", $k, $csum, $oldloc, $len);
        $msum += $csum + unpack("%32N*", $dir{$k});
        if ($msum > 0xffffffff) { $msum -= 0xffffffff; $msum--; }
        seek($fh, $loc, 0);
    }

    unless ($self->{' nocsum'})             # assuming we want a file checksum
    {
# Now we need to sort out the head table's checksum
        if (!defined $dir{'head'})
        {                                   # you have to have a head table
            close($fh);
            return warn "No 'head' table to output in $fname";
        }
        ($csum, $loc, $len) = unpack("x4NNN", $dir{'head'});
        seek($fh, $loc + 8, 0);
        read($fh, $dat, 4);
        $lsum = unpack("N", $dat);
        if ($lsum != 0)
        {
            $csum -= $lsum;
            if ($csum < 0) { $csum += 0xffffffff; $csum++; }
            $msum -= $lsum * 2;                     # twice (in head and in csum)
            while ($msum < 0) { $msum += 0xffffffff; $msum++; }
        }
        $lsum = 0xB1B0AFBA - $msum;
        seek($fh, $loc + 8, 0);
        print $fh pack("N", $lsum);
        $dir{'head'} = pack("A4NNN", 'head', $csum, $loc, $len);
    }

# Now we can output the directory again
    seek($fh, 12, 0);
    foreach $k (@tlist)
    { print $fh $dir{$k}; }

    close($fh);
    $self;
}


=head2 $f->update

Sends update to all the tables in the font and then resets all the isDirty
flags on each table. The data structure in now consistent as a font (we hope).

=cut

sub update
{
    my ($self) = @_;
    
    $self->tables_do(sub { $_[0]->update; });
    $self->tables_do(sub { $_[0]->{' isDirty'} = 0; });

    $self;
}


=head2 $f->tables_do(&func)

Calls &func for each table in the font. Calls the table in alphabetical sort
order as per the order in the directory:

    &func($table, $name);

=cut

sub tables_do
{
    my ($self, $func) = @_;
    my ($t);

    foreach $t (sort grep {length($_) == 4} keys %$self)
    { &$func($self->{$t}, $t); }
    $self;
}


=head2 $f->DESTROY

Closes the file for this font, if this is not an embedded font

=cut

sub DESTROY
{
    my ($self) = @_;
    return $self if defined $self->{' PARENT'};         # part of a TTC
    close ($self->{' INFILE'});
    $self = {};                 # this should DESTROY them, breaking the link on us
    return undef;
}

1;

=head1 BUGS

Bugs abound aplenty I am sure. There is a lot of code here and plenty of scope.
The parts of the code which haven't been implemented yet are:

=over 4

=item Font::TTF::Post

Version 4 format types are not supported yet.

=item Font::TTF::Cmap

Format type 2 (MBCS) has not been implemented yet and therefore may cause
somewhat spurious results for this table type.

=item Font::TTF::Kern

Only type 0 & type 2 tables are supported (type 1 & type 3 yet to come).

=item Font::TTF::TTC

The current Font::TTF::Font::out method does not support the writing of TrueType
Collections.

=back

In addition there are weaknesses or features of this module library

=over 4

=item *

There is very little (or no) error reporting. This means that if you have
garbled data or garbled data structures, then you are liable to generate duff
fonts.

=item *

The exposing of the internal data structures everywhere means that doing
radical re-structuring is almost impossible. But it stop the code from becoming
ridiculously large.

=back

Apart from these, I try to keep the code in a state of "no known bugs", which
given the amount of testing this code has had, is not a guarantee of high
quality, yet.

For more details see the appropriate class files.

=head1 AUTHOR

Martin Hosken L<Martin_Hosken@sil.org>

Copyright Martin Hosken 1998.

No warranty or expression of effectiveness, least of all regarding anyone's
safety, is implied in this software or documentation.

=head2 Licensing

The Perl TTF module is licensed under the Perl Artistic License.

