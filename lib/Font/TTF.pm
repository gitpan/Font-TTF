package Font::TTF;

$VERSION = '0.42';    # MJPH    11-OCT-2007      Add Volt2ttf support
# $VERSION = '0.41';    # MJPH    27-MAR-2007      Remove warnings from font copy
#                                                  Bug fixes in Ttopen, GDEF
#                                                  Remove redundant head and maxp ->reads
# $VERSION = '0.40';    # MJPH    31-JUL-2006      Add EBDT, EBLC tables
# $VERSION = 0.39;

1;

=head1 NAME

Font::TTF - Perl module for TrueType Font hacking

=head1 DESCRIPTION

This module allows you to do almost anything to a TrueType/OpenType Font
including modify and inspect nearly all tables.

