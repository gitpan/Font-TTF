        Perl Module: Font::TTF

=head1 Introduction

Perl module for TrueType font hacking. Supports reading, processing and writing
of the following tables: LTSH, OS/2, PCLT, cmap, cvt, fpgm, glyf, hdmx, head,
hhea, hmtx, kern, loca, maxp, name, post, prep, vhea, vmtx and the reading and
writing of all other table types.

In short, you can do almost anything with a standard TrueType font with this
module. Be Brave!

Also included are the following example scripts:

eurofix         Fixes fonts created for Win95 so that they work in Win98 and NT4
                sp4.
ttfenc          Create .enc, .afm, .tfm and .map entry for a ttf file based on
                Unicode rather than postscript. Requires afm2tfm and ttf2afm.
zerohyph        Create a zero width hyphen in place of the normal hyphen
ttfremap        Allows creation of new MS cmap based on old one.

Any suggestions, improvements, additions, subclasses, etc. would be gratefully
received and probably included in a future release. Please send them to me.

=head1 SYNOPSIS

Here is the regression test (you provide your own font). Run it once and then
again on the output of the first run. There should be no differences between
the outputs of the two runs.

    use Font::TTF::Font;

    $f = Font::TTF::Font->open($ARGV[0]);

    # force a read of all the tables
    $f->tables_do(sub { $_[0]->read; });

    # force read of all glyphs (use read_dat to use lots of memory!)
    # $f->{'loca'}->glyphs_do(sub { $_[0]->read; });
    $f->{'loca'}->glyphs_do(sub { $_[0]->read_dat; });
    # NB. no need to $g->update since $_[0]->{'glyf'}->out will do it for us

    $f->out($ARGV[1]);
    $f->DESTROY;               # forces close of $in and maybe memory reclaim!

=head1 PERL4 Utilities

As an aside, the following Perl4 system and utilities have been slung in:

perlmod.pl      This is the Perl4 library for these programs

addpclt         Create a PCLT table for a font with lots of junk in it
Hackos2         Do all sorts of unspeakable things to the OS/2 table
MakeMono        Force a font to be mono-spaced
Ttfname         Rename a font (and set any other name strings)
TTFWIDTH        Find the centre of every glyph in a font and print report

=head1 Installation

To configure this module, cd to the directory that contains this README file
and type the following.

    perl Makefile.PL

Alternatively, if you plan to install Font::TTF somewhere other than
your system's perl library directory. You can type something like this:

    perl Makefile.PL PREFIX=/home/me/perl INSTALLDIRS=perl

Then to build you run make.

    make

If you have write access to the perl library directories, you may then
install by typing:

    make install

=head1 AUTHOR

Martin Hosken L<Martin_Hosken@sil.org>

Copyright Martin Hosken 1998 and following.

No warranty or expression of effectiveness for anything, least of all anyone's
safety, is implied in this software or documentation.

=head2 Licensing

The Perl TTF module is licensed under the Perl Artistic License.

