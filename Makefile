# This Makefile is for the Font::TTF extension to perl.
#
# It was generated automatically by MakeMaker version
# 6.17 (Revision: 1.133) from the contents of
# Makefile.PL. Don't edit this file, edit Makefile.PL instead.
#
#       ANY CHANGES MADE HERE WILL BE LOST!
#
#   MakeMaker ARGV: ()
#
#   MakeMaker Parameters:

#     ABSTRACT => q[TTF font support for Perl]
#     AUTHOR => q[martin_hosken@sil.org]
#     NAME => q[Font::TTF]
#     VERSION_FROM => q[lib/Font/TTF/Font.pm]
#     dist => { TO_UNIX=>q[perl -Mtounix -e "tounix(\"$(DISTVNAME)\")"] }

# --- MakeMaker post_initialize section:


# --- MakeMaker const_config section:

# These definitions are from config.sh (via /usr/lib/perl5/5.8.5/i586-linux-thread-multi/Config.pm)

# They may have been overridden via Makefile.PL or on the command line
AR = ar
CC = cc
CCCDLFLAGS = -fPIC
CCDLFLAGS = -Wl,-E -Wl,-rpath,/usr/lib/perl5/5.8.5/i586-linux-thread-multi/CORE
DLEXT = so
DLSRC = dl_dlopen.xs
LD = cc
LDDLFLAGS = -shared
LDFLAGS = 
LIBC = 
LIB_EXT = .a
OBJ_EXT = .o
OSNAME = linux
OSVERS = 2.6.8.1
RANLIB = :
SITELIBEXP = /usr/lib/perl5/site_perl/5.8.5
SITEARCHEXP = /usr/lib/perl5/site_perl/5.8.5/i586-linux-thread-multi
SO = so
EXE_EXT = 
FULL_AR = /usr/bin/ar
VENDORARCHEXP = /usr/lib/perl5/vendor_perl/5.8.5/i586-linux-thread-multi
VENDORLIBEXP = /usr/lib/perl5/vendor_perl/5.8.5


# --- MakeMaker constants section:
AR_STATIC_ARGS = cr
DIRFILESEP = /
NAME = Font::TTF
NAME_SYM = Font_TTF
VERSION = 0.35
VERSION_MACRO = VERSION
VERSION_SYM = 0_35
DEFINE_VERSION = -D$(VERSION_MACRO)=\"$(VERSION)\"
XS_VERSION = 0.35
XS_VERSION_MACRO = XS_VERSION
XS_DEFINE_VERSION = -D$(XS_VERSION_MACRO)=\"$(XS_VERSION)\"
INST_ARCHLIB = blib/arch
INST_SCRIPT = blib/script
INST_BIN = blib/bin
INST_LIB = blib/lib
INST_MAN1DIR = blib/man1
INST_MAN3DIR = blib/man3
MAN1EXT = 1
MAN3EXT = 3pm
INSTALLDIRS = site
DESTDIR = 
PREFIX = 
PERLPREFIX = /usr
SITEPREFIX = /usr
VENDORPREFIX = /usr
INSTALLPRIVLIB = $(PERLPREFIX)/lib/perl5/5.8.5
DESTINSTALLPRIVLIB = $(DESTDIR)$(INSTALLPRIVLIB)
INSTALLSITELIB = $(SITEPREFIX)/lib/perl5/site_perl/5.8.5
DESTINSTALLSITELIB = $(DESTDIR)$(INSTALLSITELIB)
INSTALLVENDORLIB = $(VENDORPREFIX)/lib/perl5/vendor_perl/5.8.5
DESTINSTALLVENDORLIB = $(DESTDIR)$(INSTALLVENDORLIB)
INSTALLARCHLIB = $(PERLPREFIX)/lib/perl5/5.8.5/i586-linux-thread-multi
DESTINSTALLARCHLIB = $(DESTDIR)$(INSTALLARCHLIB)
INSTALLSITEARCH = $(SITEPREFIX)/lib/perl5/site_perl/5.8.5/i586-linux-thread-multi
DESTINSTALLSITEARCH = $(DESTDIR)$(INSTALLSITEARCH)
INSTALLVENDORARCH = $(VENDORPREFIX)/lib/perl5/vendor_perl/5.8.5/i586-linux-thread-multi
DESTINSTALLVENDORARCH = $(DESTDIR)$(INSTALLVENDORARCH)
INSTALLBIN = $(PERLPREFIX)/bin
DESTINSTALLBIN = $(DESTDIR)$(INSTALLBIN)
INSTALLSITEBIN = $(SITEPREFIX)/bin
DESTINSTALLSITEBIN = $(DESTDIR)$(INSTALLSITEBIN)
INSTALLVENDORBIN = $(VENDORPREFIX)/bin
DESTINSTALLVENDORBIN = $(DESTDIR)$(INSTALLVENDORBIN)
INSTALLSCRIPT = $(PERLPREFIX)/bin
DESTINSTALLSCRIPT = $(DESTDIR)$(INSTALLSCRIPT)
INSTALLMAN1DIR = $(PERLPREFIX)/share/man/man1
DESTINSTALLMAN1DIR = $(DESTDIR)$(INSTALLMAN1DIR)
INSTALLSITEMAN1DIR = $(SITEPREFIX)/share/man/man1
DESTINSTALLSITEMAN1DIR = $(DESTDIR)$(INSTALLSITEMAN1DIR)
INSTALLVENDORMAN1DIR = $(VENDORPREFIX)/share/man/man1
DESTINSTALLVENDORMAN1DIR = $(DESTDIR)$(INSTALLVENDORMAN1DIR)
INSTALLMAN3DIR = $(PERLPREFIX)/share/man/man3
DESTINSTALLMAN3DIR = $(DESTDIR)$(INSTALLMAN3DIR)
INSTALLSITEMAN3DIR = $(SITEPREFIX)/share/man/man3
DESTINSTALLSITEMAN3DIR = $(DESTDIR)$(INSTALLSITEMAN3DIR)
INSTALLVENDORMAN3DIR = $(VENDORPREFIX)/share/man/man3
DESTINSTALLVENDORMAN3DIR = $(DESTDIR)$(INSTALLVENDORMAN3DIR)
PERL_LIB = /usr/lib/perl5/5.8.5
PERL_ARCHLIB = /usr/lib/perl5/5.8.5/i586-linux-thread-multi
LIBPERL_A = libperl.a
FIRST_MAKEFILE = Makefile
MAKEFILE_OLD = $(FIRST_MAKEFILE).old
MAKE_APERL_FILE = $(FIRST_MAKEFILE).aperl
PERLMAINCC = $(CC)
PERL_INC = /usr/lib/perl5/5.8.5/i586-linux-thread-multi/CORE
PERL = /usr/bin/perl
FULLPERL = /usr/bin/perl
ABSPERL = $(PERL)
PERLRUN = $(PERL)
FULLPERLRUN = $(FULLPERL)
ABSPERLRUN = $(ABSPERL)
PERLRUNINST = $(PERLRUN) "-I$(INST_ARCHLIB)" "-I$(INST_LIB)"
FULLPERLRUNINST = $(FULLPERLRUN) "-I$(INST_ARCHLIB)" "-I$(INST_LIB)"
ABSPERLRUNINST = $(ABSPERLRUN) "-I$(INST_ARCHLIB)" "-I$(INST_LIB)"
PERL_CORE = 0
PERM_RW = 644
PERM_RWX = 755

MAKEMAKER   = /usr/lib/perl5/5.8.5/ExtUtils/MakeMaker.pm
MM_VERSION  = 6.17
MM_REVISION = 1.133

# FULLEXT = Pathname for extension directory (eg Foo/Bar/Oracle).
# BASEEXT = Basename part of FULLEXT. May be just equal FULLEXT. (eg Oracle)
# PARENT_NAME = NAME without BASEEXT and no trailing :: (eg Foo::Bar)
# DLBASE  = Basename part of dynamic library. May be just equal BASEEXT.
FULLEXT = Font/TTF
BASEEXT = TTF
PARENT_NAME = Font
DLBASE = $(BASEEXT)
VERSION_FROM = lib/Font/TTF/Font.pm
OBJECT = 
LDFROM = $(OBJECT)
LINKTYPE = dynamic

# Handy lists of source code files:
XS_FILES = 
C_FILES  = 
O_FILES  = 
H_FILES  = 
MAN1PODS = 
MAN3PODS = lib/Font/TTF/AATKern.pm \
	lib/Font/TTF/Anchor.pm \
	lib/Font/TTF/Bsln.pm \
	lib/Font/TTF/Cmap.pm \
	lib/Font/TTF/Coverage.pm \
	lib/Font/TTF/Cvt_.pm \
	lib/Font/TTF/Delta.pm \
	lib/Font/TTF/Fdsc.pm \
	lib/Font/TTF/Feat.pm \
	lib/Font/TTF/Fmtx.pm \
	lib/Font/TTF/Font.pm \
	lib/Font/TTF/Fpgm.pm \
	lib/Font/TTF/GDEF.pm \
	lib/Font/TTF/GPOS.pm \
	lib/Font/TTF/GSUB.pm \
	lib/Font/TTF/Glyf.pm \
	lib/Font/TTF/Glyph.pm \
	lib/Font/TTF/Hdmx.pm \
	lib/Font/TTF/Head.pm \
	lib/Font/TTF/Hhea.pm \
	lib/Font/TTF/Hmtx.pm \
	lib/Font/TTF/Kern.pm \
	lib/Font/TTF/Kern/ClassArray.pm \
	lib/Font/TTF/Kern/CompactClassArray.pm \
	lib/Font/TTF/Kern/OrderedList.pm \
	lib/Font/TTF/Kern/StateTable.pm \
	lib/Font/TTF/Kern/Subtable.pm \
	lib/Font/TTF/LTSH.pm \
	lib/Font/TTF/Loca.pm \
	lib/Font/TTF/Manual.pod \
	lib/Font/TTF/Maxp.pm \
	lib/Font/TTF/Mort.pm \
	lib/Font/TTF/Mort/Chain.pm \
	lib/Font/TTF/Mort/Contextual.pm \
	lib/Font/TTF/Mort/Insertion.pm \
	lib/Font/TTF/Mort/Ligature.pm \
	lib/Font/TTF/Mort/Noncontextual.pm \
	lib/Font/TTF/Mort/Rearrangement.pm \
	lib/Font/TTF/Mort/Subtable.pm \
	lib/Font/TTF/Name.pm \
	lib/Font/TTF/OS_2.pm \
	lib/Font/TTF/OldCmap.pm \
	lib/Font/TTF/OldMort.pm \
	lib/Font/TTF/PCLT.pm \
	lib/Font/TTF/PSNames.pm \
	lib/Font/TTF/Post.pm \
	lib/Font/TTF/Prep.pm \
	lib/Font/TTF/Prop.pm \
	lib/Font/TTF/Segarr.pm \
	lib/Font/TTF/Table.pm \
	lib/Font/TTF/Ttc.pm \
	lib/Font/TTF/Ttopen.pm \
	lib/Font/TTF/Utils.pm \
	lib/Font/TTF/Vhea.pm \
	lib/Font/TTF/Vmtx.pm \
	lib/Font/TTF/XMLparse.pm

# Where is the Config information that we are using/depend on
CONFIGDEP = $(PERL_ARCHLIB)$(DIRFILESEP)Config.pm $(PERL_INC)$(DIRFILESEP)config.h

# Where to build things
INST_LIBDIR      = $(INST_LIB)/Font
INST_ARCHLIBDIR  = $(INST_ARCHLIB)/Font

INST_AUTODIR     = $(INST_LIB)/auto/$(FULLEXT)
INST_ARCHAUTODIR = $(INST_ARCHLIB)/auto/$(FULLEXT)

INST_STATIC      = 
INST_DYNAMIC     = 
INST_BOOT        = 

# Extra linker info
EXPORT_LIST        = 
PERL_ARCHIVE       = 
PERL_ARCHIVE_AFTER = 


TO_INST_PM = lib/Font/TTF/AATKern.pm \
	lib/Font/TTF/AATutils.pm \
	lib/Font/TTF/Anchor.pm \
	lib/Font/TTF/Bsln.pm \
	lib/Font/TTF/Changes \
	lib/Font/TTF/Cmap.pm \
	lib/Font/TTF/Coverage.pm \
	lib/Font/TTF/Cvt_.pm \
	lib/Font/TTF/Delta.pm \
	lib/Font/TTF/Fdsc.pm \
	lib/Font/TTF/Feat.pm \
	lib/Font/TTF/Fmtx.pm \
	lib/Font/TTF/Font.pm \
	lib/Font/TTF/Fpgm.pm \
	lib/Font/TTF/GDEF.pm \
	lib/Font/TTF/GPOS.pm \
	lib/Font/TTF/GSUB.pm \
	lib/Font/TTF/Glyf.pm \
	lib/Font/TTF/Glyph.pm \
	lib/Font/TTF/Hdmx.pm \
	lib/Font/TTF/Head.pm \
	lib/Font/TTF/Hhea.pm \
	lib/Font/TTF/Hmtx.pm \
	lib/Font/TTF/Kern.pm \
	lib/Font/TTF/Kern/ClassArray.pm \
	lib/Font/TTF/Kern/CompactClassArray.pm \
	lib/Font/TTF/Kern/OrderedList.pm \
	lib/Font/TTF/Kern/StateTable.pm \
	lib/Font/TTF/Kern/Subtable.pm \
	lib/Font/TTF/LTSH.pm \
	lib/Font/TTF/Loca.pm \
	lib/Font/TTF/Manual.pod \
	lib/Font/TTF/Maxp.pm \
	lib/Font/TTF/Mort.pm \
	lib/Font/TTF/Mort/Chain.pm \
	lib/Font/TTF/Mort/Contextual.pm \
	lib/Font/TTF/Mort/Insertion.pm \
	lib/Font/TTF/Mort/Ligature.pm \
	lib/Font/TTF/Mort/Noncontextual.pm \
	lib/Font/TTF/Mort/Rearrangement.pm \
	lib/Font/TTF/Mort/Subtable.pm \
	lib/Font/TTF/Name.pm \
	lib/Font/TTF/OS_2.pm \
	lib/Font/TTF/OldCmap.pm \
	lib/Font/TTF/OldMort.pm \
	lib/Font/TTF/PCLT.pm \
	lib/Font/TTF/PSNames.pm \
	lib/Font/TTF/Post.pm \
	lib/Font/TTF/Prep.pm \
	lib/Font/TTF/Prop.pm \
	lib/Font/TTF/Segarr.pm \
	lib/Font/TTF/Table.pm \
	lib/Font/TTF/Ttc.pm \
	lib/Font/TTF/Ttopen.pm \
	lib/Font/TTF/Useall.pm \
	lib/Font/TTF/Utils.pm \
	lib/Font/TTF/Vhea.pm \
	lib/Font/TTF/Vmtx.pm \
	lib/Font/TTF/Win32.pm \
	lib/Font/TTF/XMLparse.pm \
	lib/ttfmod.pl

PM_TO_BLIB = lib/Font/TTF/Vmtx.pm \
	blib/lib/Font/TTF/Vmtx.pm \
	lib/Font/TTF/Hhea.pm \
	blib/lib/Font/TTF/Hhea.pm \
	lib/ttfmod.pl \
	blib/lib/ttfmod.pl \
	lib/Font/TTF/Kern/ClassArray.pm \
	blib/lib/Font/TTF/Kern/ClassArray.pm \
	lib/Font/TTF/Head.pm \
	blib/lib/Font/TTF/Head.pm \
	lib/Font/TTF/Fmtx.pm \
	blib/lib/Font/TTF/Fmtx.pm \
	lib/Font/TTF/AATKern.pm \
	blib/lib/Font/TTF/AATKern.pm \
	lib/Font/TTF/OldMort.pm \
	blib/lib/Font/TTF/OldMort.pm \
	lib/Font/TTF/Bsln.pm \
	blib/lib/Font/TTF/Bsln.pm \
	lib/Font/TTF/Manual.pod \
	blib/lib/Font/TTF/Manual.pod \
	lib/Font/TTF/Font.pm \
	blib/lib/Font/TTF/Font.pm \
	lib/Font/TTF/GDEF.pm \
	blib/lib/Font/TTF/GDEF.pm \
	lib/Font/TTF/Vhea.pm \
	blib/lib/Font/TTF/Vhea.pm \
	lib/Font/TTF/Fpgm.pm \
	blib/lib/Font/TTF/Fpgm.pm \
	lib/Font/TTF/GSUB.pm \
	blib/lib/Font/TTF/GSUB.pm \
	lib/Font/TTF/Mort/Contextual.pm \
	blib/lib/Font/TTF/Mort/Contextual.pm \
	lib/Font/TTF/OS_2.pm \
	blib/lib/Font/TTF/OS_2.pm \
	lib/Font/TTF/Useall.pm \
	blib/lib/Font/TTF/Useall.pm \
	lib/Font/TTF/Ttc.pm \
	blib/lib/Font/TTF/Ttc.pm \
	lib/Font/TTF/Feat.pm \
	blib/lib/Font/TTF/Feat.pm \
	lib/Font/TTF/Name.pm \
	blib/lib/Font/TTF/Name.pm \
	lib/Font/TTF/Kern.pm \
	blib/lib/Font/TTF/Kern.pm \
	lib/Font/TTF/Kern/StateTable.pm \
	blib/lib/Font/TTF/Kern/StateTable.pm \
	lib/Font/TTF/OldCmap.pm \
	blib/lib/Font/TTF/OldCmap.pm \
	lib/Font/TTF/Segarr.pm \
	blib/lib/Font/TTF/Segarr.pm \
	lib/Font/TTF/Changes \
	blib/lib/Font/TTF/Changes \
	lib/Font/TTF/Loca.pm \
	blib/lib/Font/TTF/Loca.pm \
	lib/Font/TTF/Mort/Insertion.pm \
	blib/lib/Font/TTF/Mort/Insertion.pm \
	lib/Font/TTF/Mort/Chain.pm \
	blib/lib/Font/TTF/Mort/Chain.pm \
	lib/Font/TTF/Mort/Rearrangement.pm \
	blib/lib/Font/TTF/Mort/Rearrangement.pm \
	lib/Font/TTF/Fdsc.pm \
	blib/lib/Font/TTF/Fdsc.pm \
	lib/Font/TTF/Cvt_.pm \
	blib/lib/Font/TTF/Cvt_.pm \
	lib/Font/TTF/XMLparse.pm \
	blib/lib/Font/TTF/XMLparse.pm \
	lib/Font/TTF/Maxp.pm \
	blib/lib/Font/TTF/Maxp.pm \
	lib/Font/TTF/AATutils.pm \
	blib/lib/Font/TTF/AATutils.pm \
	lib/Font/TTF/Prop.pm \
	blib/lib/Font/TTF/Prop.pm \
	lib/Font/TTF/Coverage.pm \
	blib/lib/Font/TTF/Coverage.pm \
	lib/Font/TTF/PCLT.pm \
	blib/lib/Font/TTF/PCLT.pm \
	lib/Font/TTF/Mort/Ligature.pm \
	blib/lib/Font/TTF/Mort/Ligature.pm \
	lib/Font/TTF/Win32.pm \
	blib/lib/Font/TTF/Win32.pm \
	lib/Font/TTF/Utils.pm \
	blib/lib/Font/TTF/Utils.pm \
	lib/Font/TTF/Ttopen.pm \
	blib/lib/Font/TTF/Ttopen.pm \
	lib/Font/TTF/Kern/Subtable.pm \
	blib/lib/Font/TTF/Kern/Subtable.pm \
	lib/Font/TTF/Hmtx.pm \
	blib/lib/Font/TTF/Hmtx.pm \
	lib/Font/TTF/Kern/OrderedList.pm \
	blib/lib/Font/TTF/Kern/OrderedList.pm \
	lib/Font/TTF/Glyph.pm \
	blib/lib/Font/TTF/Glyph.pm \
	lib/Font/TTF/Mort.pm \
	blib/lib/Font/TTF/Mort.pm \
	lib/Font/TTF/Prep.pm \
	blib/lib/Font/TTF/Prep.pm \
	lib/Font/TTF/Kern/CompactClassArray.pm \
	blib/lib/Font/TTF/Kern/CompactClassArray.pm \
	lib/Font/TTF/Hdmx.pm \
	blib/lib/Font/TTF/Hdmx.pm \
	lib/Font/TTF/Cmap.pm \
	blib/lib/Font/TTF/Cmap.pm \
	lib/Font/TTF/GPOS.pm \
	blib/lib/Font/TTF/GPOS.pm \
	lib/Font/TTF/PSNames.pm \
	blib/lib/Font/TTF/PSNames.pm \
	lib/Font/TTF/Mort/Noncontextual.pm \
	blib/lib/Font/TTF/Mort/Noncontextual.pm \
	lib/Font/TTF/Post.pm \
	blib/lib/Font/TTF/Post.pm \
	lib/Font/TTF/Anchor.pm \
	blib/lib/Font/TTF/Anchor.pm \
	lib/Font/TTF/Glyf.pm \
	blib/lib/Font/TTF/Glyf.pm \
	lib/Font/TTF/LTSH.pm \
	blib/lib/Font/TTF/LTSH.pm \
	lib/Font/TTF/Table.pm \
	blib/lib/Font/TTF/Table.pm \
	lib/Font/TTF/Delta.pm \
	blib/lib/Font/TTF/Delta.pm \
	lib/Font/TTF/Mort/Subtable.pm \
	blib/lib/Font/TTF/Mort/Subtable.pm


# --- MakeMaker platform_constants section:
MM_Unix_VERSION = 1.42
PERL_MALLOC_DEF = -DPERL_EXTMALLOC_DEF -Dmalloc=Perl_malloc -Dfree=Perl_mfree -Drealloc=Perl_realloc -Dcalloc=Perl_calloc


# --- MakeMaker tool_autosplit section:
# Usage: $(AUTOSPLITFILE) FileToSplit AutoDirToSplitInto
AUTOSPLITFILE = $(PERLRUN)  -e 'use AutoSplit;  autosplit($$ARGV[0], $$ARGV[1], 0, 1, 1)'



# --- MakeMaker tool_xsubpp section:


# --- MakeMaker tools_other section:
SHELL = /bin/sh
CHMOD = chmod
CP = cp
MV = mv
NOOP = $(SHELL) -c true
NOECHO = @
RM_F = rm -f
RM_RF = rm -rf
TEST_F = test -f
TOUCH = touch
UMASK_NULL = umask 0
DEV_NULL = > /dev/null 2>&1
MKPATH = $(PERLRUN) "-MExtUtils::Command" -e mkpath
EQUALIZE_TIMESTAMP = $(PERLRUN) "-MExtUtils::Command" -e eqtime
ECHO = echo
ECHO_N = echo -n
UNINST = 0
VERBINST = 0
MOD_INSTALL = $(PERLRUN) -MExtUtils::Install -e 'install({@ARGV}, '\''$(VERBINST)'\'', 0, '\''$(UNINST)'\'');'
DOC_INSTALL = $(PERLRUN) "-MExtUtils::Command::MM" -e perllocal_install
UNINSTALL = $(PERLRUN) "-MExtUtils::Command::MM" -e uninstall
WARN_IF_OLD_PACKLIST = $(PERLRUN) "-MExtUtils::Command::MM" -e warn_if_old_packlist


# --- MakeMaker makemakerdflt section:
makemakerdflt: all
	$(NOECHO) $(NOOP)


# --- MakeMaker dist section:
TAR = tar
TARFLAGS = cvf
ZIP = zip
ZIPFLAGS = -r
COMPRESS = gzip --best
SUFFIX = .gz
SHAR = shar
PREOP = $(NOECHO) $(NOOP)
POSTOP = $(NOECHO) $(NOOP)
TO_UNIX = perl -Mtounix -e "tounix(\"$(DISTVNAME)\")"
CI = ci -u
RCS_LABEL = rcs -Nv$(VERSION_SYM): -q
DIST_CP = best
DIST_DEFAULT = tardist
DISTNAME = Font-TTF
DISTVNAME = Font-TTF-0.35


# --- MakeMaker macro section:


# --- MakeMaker depend section:


# --- MakeMaker cflags section:


# --- MakeMaker const_loadlibs section:


# --- MakeMaker const_cccmd section:


# --- MakeMaker post_constants section:


# --- MakeMaker pasthru section:

PASTHRU = LIB="$(LIB)"\
	LIBPERL_A="$(LIBPERL_A)"\
	LINKTYPE="$(LINKTYPE)"\
	PREFIX="$(PREFIX)"\
	OPTIMIZE="$(OPTIMIZE)"\
	PASTHRU_DEFINE="$(PASTHRU_DEFINE)"\
	PASTHRU_INC="$(PASTHRU_INC)"


# --- MakeMaker special_targets section:
.SUFFIXES: .xs .c .C .cpp .i .s .cxx .cc $(OBJ_EXT)

.PHONY: all config static dynamic test linkext manifest



# --- MakeMaker c_o section:


# --- MakeMaker xs_c section:


# --- MakeMaker xs_o section:


# --- MakeMaker top_targets section:
all :: pure_all manifypods
	$(NOECHO) $(NOOP)


pure_all :: config pm_to_blib subdirs linkext
	$(NOECHO) $(NOOP)

subdirs :: $(MYEXTLIB)
	$(NOECHO) $(NOOP)

config :: $(FIRST_MAKEFILE) $(INST_LIBDIR)$(DIRFILESEP).exists
	$(NOECHO) $(NOOP)

config :: $(INST_ARCHAUTODIR)$(DIRFILESEP).exists
	$(NOECHO) $(NOOP)

config :: $(INST_AUTODIR)$(DIRFILESEP).exists
	$(NOECHO) $(NOOP)

$(INST_AUTODIR)/.exists :: /usr/lib/perl5/5.8.5/i586-linux-thread-multi/CORE/perl.h
	$(NOECHO) $(MKPATH) $(INST_AUTODIR)
	$(NOECHO) $(EQUALIZE_TIMESTAMP) /usr/lib/perl5/5.8.5/i586-linux-thread-multi/CORE/perl.h $(INST_AUTODIR)/.exists

	-$(NOECHO) $(CHMOD) $(PERM_RWX) $(INST_AUTODIR)

$(INST_LIBDIR)/.exists :: /usr/lib/perl5/5.8.5/i586-linux-thread-multi/CORE/perl.h
	$(NOECHO) $(MKPATH) $(INST_LIBDIR)
	$(NOECHO) $(EQUALIZE_TIMESTAMP) /usr/lib/perl5/5.8.5/i586-linux-thread-multi/CORE/perl.h $(INST_LIBDIR)/.exists

	-$(NOECHO) $(CHMOD) $(PERM_RWX) $(INST_LIBDIR)

$(INST_ARCHAUTODIR)/.exists :: /usr/lib/perl5/5.8.5/i586-linux-thread-multi/CORE/perl.h
	$(NOECHO) $(MKPATH) $(INST_ARCHAUTODIR)
	$(NOECHO) $(EQUALIZE_TIMESTAMP) /usr/lib/perl5/5.8.5/i586-linux-thread-multi/CORE/perl.h $(INST_ARCHAUTODIR)/.exists

	-$(NOECHO) $(CHMOD) $(PERM_RWX) $(INST_ARCHAUTODIR)

config :: $(INST_MAN3DIR)$(DIRFILESEP).exists
	$(NOECHO) $(NOOP)


$(INST_MAN3DIR)/.exists :: /usr/lib/perl5/5.8.5/i586-linux-thread-multi/CORE/perl.h
	$(NOECHO) $(MKPATH) $(INST_MAN3DIR)
	$(NOECHO) $(EQUALIZE_TIMESTAMP) /usr/lib/perl5/5.8.5/i586-linux-thread-multi/CORE/perl.h $(INST_MAN3DIR)/.exists

	-$(NOECHO) $(CHMOD) $(PERM_RWX) $(INST_MAN3DIR)

help:
	perldoc ExtUtils::MakeMaker


# --- MakeMaker linkext section:

linkext :: $(LINKTYPE)
	$(NOECHO) $(NOOP)


# --- MakeMaker dlsyms section:


# --- MakeMaker dynamic section:

dynamic :: $(FIRST_MAKEFILE) $(INST_DYNAMIC) $(INST_BOOT)
	$(NOECHO) $(NOOP)


# --- MakeMaker dynamic_bs section:

BOOTSTRAP =


# --- MakeMaker dynamic_lib section:


# --- MakeMaker static section:

## $(INST_PM) has been moved to the all: target.
## It remains here for awhile to allow for old usage: "make static"
static :: $(FIRST_MAKEFILE) $(INST_STATIC)
	$(NOECHO) $(NOOP)


# --- MakeMaker static_lib section:


# --- MakeMaker manifypods section:

POD2MAN_EXE = $(PERLRUN) "-MExtUtils::Command::MM" -e pod2man "--"
POD2MAN = $(POD2MAN_EXE)


manifypods : pure_all  \
	lib/Font/TTF/Vmtx.pm \
	lib/Font/TTF/Hhea.pm \
	lib/Font/TTF/Kern/ClassArray.pm \
	lib/Font/TTF/Head.pm \
	lib/Font/TTF/Fmtx.pm \
	lib/Font/TTF/AATKern.pm \
	lib/Font/TTF/OldMort.pm \
	lib/Font/TTF/Bsln.pm \
	lib/Font/TTF/Manual.pod \
	lib/Font/TTF/Font.pm \
	lib/Font/TTF/GDEF.pm \
	lib/Font/TTF/Vhea.pm \
	lib/Font/TTF/Fpgm.pm \
	lib/Font/TTF/GSUB.pm \
	lib/Font/TTF/Mort/Contextual.pm \
	lib/Font/TTF/OS_2.pm \
	lib/Font/TTF/Ttc.pm \
	lib/Font/TTF/Feat.pm \
	lib/Font/TTF/Name.pm \
	lib/Font/TTF/Kern.pm \
	lib/Font/TTF/Kern/StateTable.pm \
	lib/Font/TTF/OldCmap.pm \
	lib/Font/TTF/Segarr.pm \
	lib/Font/TTF/Loca.pm \
	lib/Font/TTF/Mort/Insertion.pm \
	lib/Font/TTF/Mort/Chain.pm \
	lib/Font/TTF/Mort/Rearrangement.pm \
	lib/Font/TTF/Fdsc.pm \
	lib/Font/TTF/Cvt_.pm \
	lib/Font/TTF/XMLparse.pm \
	lib/Font/TTF/Maxp.pm \
	lib/Font/TTF/Coverage.pm \
	lib/Font/TTF/PCLT.pm \
	lib/Font/TTF/Prop.pm \
	lib/Font/TTF/Mort/Ligature.pm \
	lib/Font/TTF/Utils.pm \
	lib/Font/TTF/Ttopen.pm \
	lib/Font/TTF/Kern/Subtable.pm \
	lib/Font/TTF/Hmtx.pm \
	lib/Font/TTF/Kern/OrderedList.pm \
	lib/Font/TTF/Glyph.pm \
	lib/Font/TTF/Mort.pm \
	lib/Font/TTF/Prep.pm \
	lib/Font/TTF/Kern/CompactClassArray.pm \
	lib/Font/TTF/Hdmx.pm \
	lib/Font/TTF/Cmap.pm \
	lib/Font/TTF/GPOS.pm \
	lib/Font/TTF/PSNames.pm \
	lib/Font/TTF/Mort/Noncontextual.pm \
	lib/Font/TTF/Post.pm \
	lib/Font/TTF/Anchor.pm \
	lib/Font/TTF/Glyf.pm \
	lib/Font/TTF/LTSH.pm \
	lib/Font/TTF/Table.pm \
	lib/Font/TTF/Delta.pm \
	lib/Font/TTF/Mort/Subtable.pm \
	lib/Font/TTF/Vmtx.pm \
	lib/Font/TTF/Hhea.pm \
	lib/Font/TTF/Kern/ClassArray.pm \
	lib/Font/TTF/Head.pm \
	lib/Font/TTF/Fmtx.pm \
	lib/Font/TTF/AATKern.pm \
	lib/Font/TTF/OldMort.pm \
	lib/Font/TTF/Bsln.pm \
	lib/Font/TTF/Manual.pod \
	lib/Font/TTF/Font.pm \
	lib/Font/TTF/GDEF.pm \
	lib/Font/TTF/Vhea.pm \
	lib/Font/TTF/Fpgm.pm \
	lib/Font/TTF/GSUB.pm \
	lib/Font/TTF/Mort/Contextual.pm \
	lib/Font/TTF/OS_2.pm \
	lib/Font/TTF/Ttc.pm \
	lib/Font/TTF/Feat.pm \
	lib/Font/TTF/Name.pm \
	lib/Font/TTF/Kern.pm \
	lib/Font/TTF/Kern/StateTable.pm \
	lib/Font/TTF/OldCmap.pm \
	lib/Font/TTF/Segarr.pm \
	lib/Font/TTF/Loca.pm \
	lib/Font/TTF/Mort/Insertion.pm \
	lib/Font/TTF/Mort/Chain.pm \
	lib/Font/TTF/Mort/Rearrangement.pm \
	lib/Font/TTF/Fdsc.pm \
	lib/Font/TTF/Cvt_.pm \
	lib/Font/TTF/XMLparse.pm \
	lib/Font/TTF/Maxp.pm \
	lib/Font/TTF/Coverage.pm \
	lib/Font/TTF/PCLT.pm \
	lib/Font/TTF/Prop.pm \
	lib/Font/TTF/Mort/Ligature.pm \
	lib/Font/TTF/Utils.pm \
	lib/Font/TTF/Ttopen.pm \
	lib/Font/TTF/Kern/Subtable.pm \
	lib/Font/TTF/Hmtx.pm \
	lib/Font/TTF/Kern/OrderedList.pm \
	lib/Font/TTF/Glyph.pm \
	lib/Font/TTF/Mort.pm \
	lib/Font/TTF/Prep.pm \
	lib/Font/TTF/Kern/CompactClassArray.pm \
	lib/Font/TTF/Hdmx.pm \
	lib/Font/TTF/Cmap.pm \
	lib/Font/TTF/GPOS.pm \
	lib/Font/TTF/PSNames.pm \
	lib/Font/TTF/Mort/Noncontextual.pm \
	lib/Font/TTF/Post.pm \
	lib/Font/TTF/Anchor.pm \
	lib/Font/TTF/Glyf.pm \
	lib/Font/TTF/LTSH.pm \
	lib/Font/TTF/Table.pm \
	lib/Font/TTF/Delta.pm \
	lib/Font/TTF/Mort/Subtable.pm
	$(NOECHO) $(POD2MAN) --section=3 --perm_rw=$(PERM_RW)\
	  lib/Font/TTF/Vmtx.pm $(INST_MAN3DIR)/Font::TTF::Vmtx.$(MAN3EXT) \
	  lib/Font/TTF/Hhea.pm $(INST_MAN3DIR)/Font::TTF::Hhea.$(MAN3EXT) \
	  lib/Font/TTF/Kern/ClassArray.pm $(INST_MAN3DIR)/Font::TTF::Kern::ClassArray.$(MAN3EXT) \
	  lib/Font/TTF/Head.pm $(INST_MAN3DIR)/Font::TTF::Head.$(MAN3EXT) \
	  lib/Font/TTF/Fmtx.pm $(INST_MAN3DIR)/Font::TTF::Fmtx.$(MAN3EXT) \
	  lib/Font/TTF/AATKern.pm $(INST_MAN3DIR)/Font::TTF::AATKern.$(MAN3EXT) \
	  lib/Font/TTF/OldMort.pm $(INST_MAN3DIR)/Font::TTF::OldMort.$(MAN3EXT) \
	  lib/Font/TTF/Bsln.pm $(INST_MAN3DIR)/Font::TTF::Bsln.$(MAN3EXT) \
	  lib/Font/TTF/Manual.pod $(INST_MAN3DIR)/Font::TTF::Manual.$(MAN3EXT) \
	  lib/Font/TTF/Font.pm $(INST_MAN3DIR)/Font::TTF::Font.$(MAN3EXT) \
	  lib/Font/TTF/GDEF.pm $(INST_MAN3DIR)/Font::TTF::GDEF.$(MAN3EXT) \
	  lib/Font/TTF/Vhea.pm $(INST_MAN3DIR)/Font::TTF::Vhea.$(MAN3EXT) \
	  lib/Font/TTF/Fpgm.pm $(INST_MAN3DIR)/Font::TTF::Fpgm.$(MAN3EXT) \
	  lib/Font/TTF/GSUB.pm $(INST_MAN3DIR)/Font::TTF::GSUB.$(MAN3EXT) \
	  lib/Font/TTF/Mort/Contextual.pm $(INST_MAN3DIR)/Font::TTF::Mort::Contextual.$(MAN3EXT) \
	  lib/Font/TTF/OS_2.pm $(INST_MAN3DIR)/Font::TTF::OS_2.$(MAN3EXT) \
	  lib/Font/TTF/Ttc.pm $(INST_MAN3DIR)/Font::TTF::Ttc.$(MAN3EXT) \
	  lib/Font/TTF/Feat.pm $(INST_MAN3DIR)/Font::TTF::Feat.$(MAN3EXT) \
	  lib/Font/TTF/Name.pm $(INST_MAN3DIR)/Font::TTF::Name.$(MAN3EXT) \
	  lib/Font/TTF/Kern.pm $(INST_MAN3DIR)/Font::TTF::Kern.$(MAN3EXT) \
	  lib/Font/TTF/Kern/StateTable.pm $(INST_MAN3DIR)/Font::TTF::Kern::StateTable.$(MAN3EXT) \
	  lib/Font/TTF/OldCmap.pm $(INST_MAN3DIR)/Font::TTF::OldCmap.$(MAN3EXT) \
	  lib/Font/TTF/Segarr.pm $(INST_MAN3DIR)/Font::TTF::Segarr.$(MAN3EXT) \
	  lib/Font/TTF/Loca.pm $(INST_MAN3DIR)/Font::TTF::Loca.$(MAN3EXT) \
	  lib/Font/TTF/Mort/Insertion.pm $(INST_MAN3DIR)/Font::TTF::Mort::Insertion.$(MAN3EXT) \
	  lib/Font/TTF/Mort/Chain.pm $(INST_MAN3DIR)/Font::TTF::Mort::Chain.$(MAN3EXT) \
	  lib/Font/TTF/Mort/Rearrangement.pm $(INST_MAN3DIR)/Font::TTF::Mort::Rearrangement.$(MAN3EXT) \
	  lib/Font/TTF/Fdsc.pm $(INST_MAN3DIR)/Font::TTF::Fdsc.$(MAN3EXT) \
	  lib/Font/TTF/Cvt_.pm $(INST_MAN3DIR)/Font::TTF::Cvt_.$(MAN3EXT) \
	  lib/Font/TTF/XMLparse.pm $(INST_MAN3DIR)/Font::TTF::XMLparse.$(MAN3EXT) \
	  lib/Font/TTF/Maxp.pm $(INST_MAN3DIR)/Font::TTF::Maxp.$(MAN3EXT) \
	  lib/Font/TTF/Coverage.pm $(INST_MAN3DIR)/Font::TTF::Coverage.$(MAN3EXT) \
	  lib/Font/TTF/PCLT.pm $(INST_MAN3DIR)/Font::TTF::PCLT.$(MAN3EXT) \
	  lib/Font/TTF/Prop.pm $(INST_MAN3DIR)/Font::TTF::Prop.$(MAN3EXT) \
	  lib/Font/TTF/Mort/Ligature.pm $(INST_MAN3DIR)/Font::TTF::Mort::Ligature.$(MAN3EXT) \
	  lib/Font/TTF/Utils.pm $(INST_MAN3DIR)/Font::TTF::Utils.$(MAN3EXT) \
	  lib/Font/TTF/Ttopen.pm $(INST_MAN3DIR)/Font::TTF::Ttopen.$(MAN3EXT) \
	  lib/Font/TTF/Kern/Subtable.pm $(INST_MAN3DIR)/Font::TTF::Kern::Subtable.$(MAN3EXT) \
	  lib/Font/TTF/Hmtx.pm $(INST_MAN3DIR)/Font::TTF::Hmtx.$(MAN3EXT) \
	  lib/Font/TTF/Kern/OrderedList.pm $(INST_MAN3DIR)/Font::TTF::Kern::OrderedList.$(MAN3EXT) \
	  lib/Font/TTF/Glyph.pm $(INST_MAN3DIR)/Font::TTF::Glyph.$(MAN3EXT) \
	  lib/Font/TTF/Mort.pm $(INST_MAN3DIR)/Font::TTF::Mort.$(MAN3EXT) \
	  lib/Font/TTF/Prep.pm $(INST_MAN3DIR)/Font::TTF::Prep.$(MAN3EXT) \
	  lib/Font/TTF/Kern/CompactClassArray.pm $(INST_MAN3DIR)/Font::TTF::Kern::CompactClassArray.$(MAN3EXT) \
	  lib/Font/TTF/Hdmx.pm $(INST_MAN3DIR)/Font::TTF::Hdmx.$(MAN3EXT) \
	  lib/Font/TTF/Cmap.pm $(INST_MAN3DIR)/Font::TTF::Cmap.$(MAN3EXT) \
	  lib/Font/TTF/GPOS.pm $(INST_MAN3DIR)/Font::TTF::GPOS.$(MAN3EXT) \
	  lib/Font/TTF/PSNames.pm $(INST_MAN3DIR)/Font::TTF::PSNames.$(MAN3EXT) \
	  lib/Font/TTF/Mort/Noncontextual.pm $(INST_MAN3DIR)/Font::TTF::Mort::Noncontextual.$(MAN3EXT) \
	  lib/Font/TTF/Post.pm $(INST_MAN3DIR)/Font::TTF::Post.$(MAN3EXT) \
	  lib/Font/TTF/Anchor.pm $(INST_MAN3DIR)/Font::TTF::Anchor.$(MAN3EXT) \
	  lib/Font/TTF/Glyf.pm $(INST_MAN3DIR)/Font::TTF::Glyf.$(MAN3EXT) \
	  lib/Font/TTF/LTSH.pm $(INST_MAN3DIR)/Font::TTF::LTSH.$(MAN3EXT) \
	  lib/Font/TTF/Table.pm $(INST_MAN3DIR)/Font::TTF::Table.$(MAN3EXT) \
	  lib/Font/TTF/Delta.pm $(INST_MAN3DIR)/Font::TTF::Delta.$(MAN3EXT) \
	  lib/Font/TTF/Mort/Subtable.pm $(INST_MAN3DIR)/Font::TTF::Mort::Subtable.$(MAN3EXT) 




# --- MakeMaker processPL section:


# --- MakeMaker installbin section:


# --- MakeMaker subdirs section:

# none

# --- MakeMaker clean_subdirs section:
clean_subdirs :
	$(NOECHO) $(NOOP)


# --- MakeMaker clean section:

# Delete temporary files but do not touch installed files. We don't delete
# the Makefile here so a later make realclean still has a makefile to use.

clean :: clean_subdirs
	-$(RM_RF) ./blib $(MAKE_APERL_FILE) $(INST_ARCHAUTODIR)/extralibs.all $(INST_ARCHAUTODIR)/extralibs.ld perlmain.c tmon.out mon.out so_locations pm_to_blib *$(OBJ_EXT) *$(LIB_EXT) perl.exe perl perl$(EXE_EXT) $(BOOTSTRAP) $(BASEEXT).bso $(BASEEXT).def lib$(BASEEXT).def $(BASEEXT).exp $(BASEEXT).x core core.*perl.*.? *perl.core core.[0-9] core.[0-9][0-9] core.[0-9][0-9][0-9] core.[0-9][0-9][0-9][0-9] core.[0-9][0-9][0-9][0-9][0-9]
	-$(MV) $(FIRST_MAKEFILE) $(MAKEFILE_OLD) $(DEV_NULL)


# --- MakeMaker realclean_subdirs section:
realclean_subdirs :
	$(NOECHO) $(NOOP)


# --- MakeMaker realclean section:

# Delete temporary files (via clean) and also delete installed files
realclean purge ::  clean realclean_subdirs
	$(RM_RF) $(INST_AUTODIR) $(INST_ARCHAUTODIR)
	$(RM_RF) $(DISTVNAME)
	$(RM_F)  blib/lib/Font/TTF/Fpgm.pm blib/lib/Font/TTF/Font.pm blib/lib/Font/TTF/Hdmx.pm blib/lib/Font/TTF/Head.pm blib/lib/Font/TTF/Bsln.pm blib/lib/Font/TTF/Vmtx.pm blib/lib/Font/TTF/Kern/ClassArray.pm
	$(RM_F) $(FIRST_MAKEFILE) blib/lib/Font/TTF/Glyf.pm blib/lib/Font/TTF/Prop.pm blib/lib/Font/TTF/AATKern.pm blib/lib/ttfmod.pl blib/lib/Font/TTF/Win32.pm blib/lib/Font/TTF/Fmtx.pm blib/lib/Font/TTF/GDEF.pm
	$(RM_F) blib/lib/Font/TTF/Maxp.pm blib/lib/Font/TTF/GSUB.pm blib/lib/Font/TTF/OldCmap.pm blib/lib/Font/TTF/Mort.pm blib/lib/Font/TTF/Ttc.pm blib/lib/Font/TTF/Kern/CompactClassArray.pm blib/lib/Font/TTF/Hmtx.pm
	$(RM_F) blib/lib/Font/TTF/Segarr.pm blib/lib/Font/TTF/OS_2.pm blib/lib/Font/TTF/Changes blib/lib/Font/TTF/Mort/Rearrangement.pm blib/lib/Font/TTF/Mort/Insertion.pm blib/lib/Font/TTF/Utils.pm
	$(RM_F) blib/lib/Font/TTF/Manual.pod blib/lib/Font/TTF/Kern.pm blib/lib/Font/TTF/Mort/Noncontextual.pm blib/lib/Font/TTF/Mort/Contextual.pm blib/lib/Font/TTF/Useall.pm blib/lib/Font/TTF/GPOS.pm $(MAKEFILE_OLD)
	$(RM_F) blib/lib/Font/TTF/Fdsc.pm blib/lib/Font/TTF/Coverage.pm blib/lib/Font/TTF/Vhea.pm blib/lib/Font/TTF/OldMort.pm blib/lib/Font/TTF/Table.pm blib/lib/Font/TTF/Feat.pm blib/lib/Font/TTF/Name.pm
	$(RM_F) blib/lib/Font/TTF/PCLT.pm blib/lib/Font/TTF/XMLparse.pm blib/lib/Font/TTF/LTSH.pm blib/lib/Font/TTF/AATutils.pm blib/lib/Font/TTF/Cvt_.pm blib/lib/Font/TTF/Kern/OrderedList.pm
	$(RM_F) blib/lib/Font/TTF/Delta.pm blib/lib/Font/TTF/PSNames.pm blib/lib/Font/TTF/Mort/Ligature.pm blib/lib/Font/TTF/Anchor.pm blib/lib/Font/TTF/Glyph.pm blib/lib/Font/TTF/Mort/Chain.pm
	$(RM_F) blib/lib/Font/TTF/Cmap.pm blib/lib/Font/TTF/Loca.pm blib/lib/Font/TTF/Post.pm blib/lib/Font/TTF/Prep.pm blib/lib/Font/TTF/Kern/StateTable.pm blib/lib/Font/TTF/Mort/Subtable.pm
	$(RM_F) blib/lib/Font/TTF/Ttopen.pm blib/lib/Font/TTF/Kern/Subtable.pm blib/lib/Font/TTF/Hhea.pm


# --- MakeMaker metafile section:
metafile :
	$(NOECHO) $(ECHO) '# http://module-build.sourceforge.net/META-spec.html' > META.yml
	$(NOECHO) $(ECHO) '#XXXXXXX This is a prototype!!!  It will change in the future!!! XXXXX#' >> META.yml
	$(NOECHO) $(ECHO) 'name:         Font-TTF' >> META.yml
	$(NOECHO) $(ECHO) 'version:      0.35' >> META.yml
	$(NOECHO) $(ECHO) 'version_from: lib/Font/TTF/Font.pm' >> META.yml
	$(NOECHO) $(ECHO) 'installdirs:  site' >> META.yml
	$(NOECHO) $(ECHO) 'requires:' >> META.yml
	$(NOECHO) $(ECHO) '' >> META.yml
	$(NOECHO) $(ECHO) 'distribution_type: module' >> META.yml
	$(NOECHO) $(ECHO) 'generated_by: ExtUtils::MakeMaker version 6.17' >> META.yml


# --- MakeMaker metafile_addtomanifest section:
metafile_addtomanifest:
	$(NOECHO) $(PERLRUN) -MExtUtils::Manifest=maniadd -e 'eval { maniadd({q{META.yml} => q{Module meta-data (added by MakeMaker)}}) } ' \
	-e '    or print "Could not add META.yml to MANIFEST: $${'\''@'\''}\n"'


# --- MakeMaker dist_basics section:
distclean :: realclean distcheck
	$(NOECHO) $(NOOP)

distcheck :
	$(PERLRUN) "-MExtUtils::Manifest=fullcheck" -e fullcheck

skipcheck :
	$(PERLRUN) "-MExtUtils::Manifest=skipcheck" -e skipcheck

manifest :
	$(PERLRUN) "-MExtUtils::Manifest=mkmanifest" -e mkmanifest

veryclean : realclean
	$(RM_F) *~ *.orig */*~ */*.orig



# --- MakeMaker dist_core section:

dist : $(DIST_DEFAULT) $(FIRST_MAKEFILE)
	$(NOECHO) $(PERLRUN) -l -e 'print '\''Warning: Makefile possibly out of date with $(VERSION_FROM)'\''' \
	-e '    if -e '\''$(VERSION_FROM)'\'' and -M '\''$(VERSION_FROM)'\'' < -M '\''$(FIRST_MAKEFILE)'\'';'

tardist : $(DISTVNAME).tar$(SUFFIX)
	$(NOECHO) $(NOOP)

uutardist : $(DISTVNAME).tar$(SUFFIX)
	uuencode $(DISTVNAME).tar$(SUFFIX) $(DISTVNAME).tar$(SUFFIX) > $(DISTVNAME).tar$(SUFFIX)_uu

$(DISTVNAME).tar$(SUFFIX) : distdir
	$(PREOP)
	$(TO_UNIX)
	$(TAR) $(TARFLAGS) $(DISTVNAME).tar $(DISTVNAME)
	$(RM_RF) $(DISTVNAME)
	$(COMPRESS) $(DISTVNAME).tar
	$(POSTOP)

zipdist : $(DISTVNAME).zip
	$(NOECHO) $(NOOP)

$(DISTVNAME).zip : distdir
	$(PREOP)
	$(ZIP) $(ZIPFLAGS) $(DISTVNAME).zip $(DISTVNAME)
	$(RM_RF) $(DISTVNAME)
	$(POSTOP)

shdist : distdir
	$(PREOP)
	$(SHAR) $(DISTVNAME) > $(DISTVNAME).shar
	$(RM_RF) $(DISTVNAME)
	$(POSTOP)


# --- MakeMaker distdir section:
distdir : metafile metafile_addtomanifest
	$(RM_RF) $(DISTVNAME)
	$(PERLRUN) "-MExtUtils::Manifest=manicopy,maniread" \
		-e "manicopy(maniread(),'$(DISTVNAME)', '$(DIST_CP)');"



# --- MakeMaker dist_test section:

disttest : distdir
	cd $(DISTVNAME) && $(ABSPERLRUN) Makefile.PL
	cd $(DISTVNAME) && $(MAKE) $(PASTHRU)
	cd $(DISTVNAME) && $(MAKE) test $(PASTHRU)


# --- MakeMaker dist_ci section:

ci :
	$(PERLRUN) "-MExtUtils::Manifest=maniread" \
	  -e "@all = keys %{ maniread() };" \
	  -e "print(qq{Executing $(CI) @all\n}); system(qq{$(CI) @all});" \
	  -e "print(qq{Executing $(RCS_LABEL) ...\n}); system(qq{$(RCS_LABEL) @all});"


# --- MakeMaker install section:

install :: all pure_install doc_install

install_perl :: all pure_perl_install doc_perl_install

install_site :: all pure_site_install doc_site_install

install_vendor :: all pure_vendor_install doc_vendor_install

pure_install :: pure_$(INSTALLDIRS)_install

doc_install :: doc_$(INSTALLDIRS)_install

pure__install : pure_site_install
	$(NOECHO) $(ECHO) INSTALLDIRS not defined, defaulting to INSTALLDIRS=site

doc__install : doc_site_install
	$(NOECHO) $(ECHO) INSTALLDIRS not defined, defaulting to INSTALLDIRS=site

pure_perl_install ::
	$(NOECHO) $(MOD_INSTALL) \
		read $(PERL_ARCHLIB)/auto/$(FULLEXT)/.packlist \
		write $(DESTINSTALLARCHLIB)/auto/$(FULLEXT)/.packlist \
		$(INST_LIB) $(DESTINSTALLPRIVLIB) \
		$(INST_ARCHLIB) $(DESTINSTALLARCHLIB) \
		$(INST_BIN) $(DESTINSTALLBIN) \
		$(INST_SCRIPT) $(DESTINSTALLSCRIPT) \
		$(INST_MAN1DIR) $(DESTINSTALLMAN1DIR) \
		$(INST_MAN3DIR) $(DESTINSTALLMAN3DIR)
	$(NOECHO) $(WARN_IF_OLD_PACKLIST) \
		$(SITEARCHEXP)/auto/$(FULLEXT)


pure_site_install ::
	$(NOECHO) $(MOD_INSTALL) \
		read $(SITEARCHEXP)/auto/$(FULLEXT)/.packlist \
		write $(DESTINSTALLSITEARCH)/auto/$(FULLEXT)/.packlist \
		$(INST_LIB) $(DESTINSTALLSITELIB) \
		$(INST_ARCHLIB) $(DESTINSTALLSITEARCH) \
		$(INST_BIN) $(DESTINSTALLSITEBIN) \
		$(INST_SCRIPT) $(DESTINSTALLSCRIPT) \
		$(INST_MAN1DIR) $(DESTINSTALLSITEMAN1DIR) \
		$(INST_MAN3DIR) $(DESTINSTALLSITEMAN3DIR)
	$(NOECHO) $(WARN_IF_OLD_PACKLIST) \
		$(PERL_ARCHLIB)/auto/$(FULLEXT)

pure_vendor_install ::
	$(NOECHO) $(MOD_INSTALL) \
		read $(VENDORARCHEXP)/auto/$(FULLEXT)/.packlist \
		write $(DESTINSTALLVENDORARCH)/auto/$(FULLEXT)/.packlist \
		$(INST_LIB) $(DESTINSTALLVENDORLIB) \
		$(INST_ARCHLIB) $(DESTINSTALLVENDORARCH) \
		$(INST_BIN) $(DESTINSTALLVENDORBIN) \
		$(INST_SCRIPT) $(DESTINSTALLSCRIPT) \
		$(INST_MAN1DIR) $(DESTINSTALLVENDORMAN1DIR) \
		$(INST_MAN3DIR) $(DESTINSTALLVENDORMAN3DIR)

doc_perl_install ::
	$(NOECHO) $(ECHO) Appending installation info to $(DESTINSTALLARCHLIB)/perllocal.pod
	-$(NOECHO) $(MKPATH) $(DESTINSTALLARCHLIB)
	-$(NOECHO) $(DOC_INSTALL) \
		"Module" "$(NAME)" \
		"installed into" "$(INSTALLPRIVLIB)" \
		LINKTYPE "$(LINKTYPE)" \
		VERSION "$(VERSION)" \
		EXE_FILES "$(EXE_FILES)" \
		>> $(DESTINSTALLARCHLIB)/perllocal.pod

doc_site_install ::
	$(NOECHO) $(ECHO) Appending installation info to $(DESTINSTALLARCHLIB)/perllocal.pod
	-$(NOECHO) $(MKPATH) $(DESTINSTALLARCHLIB)
	-$(NOECHO) $(DOC_INSTALL) \
		"Module" "$(NAME)" \
		"installed into" "$(INSTALLSITELIB)" \
		LINKTYPE "$(LINKTYPE)" \
		VERSION "$(VERSION)" \
		EXE_FILES "$(EXE_FILES)" \
		>> $(DESTINSTALLARCHLIB)/perllocal.pod

doc_vendor_install ::
	$(NOECHO) $(ECHO) Appending installation info to $(DESTINSTALLARCHLIB)/perllocal.pod
	-$(NOECHO) $(MKPATH) $(DESTINSTALLARCHLIB)
	-$(NOECHO) $(DOC_INSTALL) \
		"Module" "$(NAME)" \
		"installed into" "$(INSTALLVENDORLIB)" \
		LINKTYPE "$(LINKTYPE)" \
		VERSION "$(VERSION)" \
		EXE_FILES "$(EXE_FILES)" \
		>> $(DESTINSTALLARCHLIB)/perllocal.pod


uninstall :: uninstall_from_$(INSTALLDIRS)dirs

uninstall_from_perldirs ::
	$(NOECHO) $(UNINSTALL) $(PERL_ARCHLIB)/auto/$(FULLEXT)/.packlist

uninstall_from_sitedirs ::
	$(NOECHO) $(UNINSTALL) $(SITEARCHEXP)/auto/$(FULLEXT)/.packlist

uninstall_from_vendordirs ::
	$(NOECHO) $(UNINSTALL) $(VENDORARCHEXP)/auto/$(FULLEXT)/.packlist


# --- MakeMaker force section:
# Phony target to force checking subdirectories.
FORCE:
	$(NOECHO) $(NOOP)


# --- MakeMaker perldepend section:


# --- MakeMaker makefile section:

# We take a very conservative approach here, but it's worth it.
# We move Makefile to Makefile.old here to avoid gnu make looping.
$(FIRST_MAKEFILE) : Makefile.PL $(CONFIGDEP)
	$(NOECHO) $(ECHO) "Makefile out-of-date with respect to $?"
	$(NOECHO) $(ECHO) "Cleaning current config before rebuilding Makefile..."
	$(NOECHO) $(RM_F) $(MAKEFILE_OLD)
	$(NOECHO) $(MV)   $(FIRST_MAKEFILE) $(MAKEFILE_OLD)
	-$(MAKE) -f $(MAKEFILE_OLD) clean $(DEV_NULL) || $(NOOP)
	$(PERLRUN) Makefile.PL 
	$(NOECHO) $(ECHO) "==> Your Makefile has been rebuilt. <=="
	$(NOECHO) $(ECHO) "==> Please rerun the make command.  <=="
	false



# --- MakeMaker staticmake section:

# --- MakeMaker makeaperl section ---
MAP_TARGET    = perl
FULLPERL      = /usr/bin/perl

$(MAP_TARGET) :: static $(MAKE_APERL_FILE)
	$(MAKE) -f $(MAKE_APERL_FILE) $@

$(MAKE_APERL_FILE) : $(FIRST_MAKEFILE)
	$(NOECHO) $(ECHO) Writing \"$(MAKE_APERL_FILE)\" for this $(MAP_TARGET)
	$(NOECHO) $(PERLRUNINST) \
		Makefile.PL DIR= \
		MAKEFILE=$(MAKE_APERL_FILE) LINKTYPE=static \
		MAKEAPERL=1 NORECURS=1 CCCDLFLAGS=


# --- MakeMaker test section:

TEST_VERBOSE=0
TEST_TYPE=test_$(LINKTYPE)
TEST_FILE = test.pl
TEST_FILES = 
TESTDB_SW = -d

testdb :: testdb_$(LINKTYPE)

test :: $(TEST_TYPE)
	$(NOECHO) $(ECHO) 'No tests defined for $(NAME) extension.'

test_dynamic :: pure_all

testdb_dynamic :: pure_all
	PERL_DL_NONLAZY=1 $(FULLPERLRUN) $(TESTDB_SW) "-I$(INST_LIB)" "-I$(INST_ARCHLIB)" $(TEST_FILE)

test_ : test_dynamic

test_static :: test_dynamic
testdb_static :: testdb_dynamic


# --- MakeMaker ppd section:
# Creates a PPD (Perl Package Description) for a binary distribution.
ppd:
	$(NOECHO) $(ECHO) '<SOFTPKG NAME="$(DISTNAME)" VERSION="0,35,0,0">' > $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '    <TITLE>$(DISTNAME)</TITLE>' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '    <ABSTRACT>TTF font support for Perl</ABSTRACT>' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '    <AUTHOR>martin_hosken@sil.org</AUTHOR>' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '    <IMPLEMENTATION>' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <OS NAME="$(OSNAME)" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <ARCHITECTURE NAME="i586-linux-thread-multi" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <CODEBASE HREF="" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '    </IMPLEMENTATION>' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '</SOFTPKG>' >> $(DISTNAME).ppd


# --- MakeMaker pm_to_blib section:

pm_to_blib: $(TO_INST_PM)
	$(NOECHO) $(PERLRUN) -MExtUtils::Install -e 'pm_to_blib({@ARGV}, '\''$(INST_LIB)/auto'\'', '\''$(PM_FILTER)'\'')'\
	  lib/Font/TTF/Vmtx.pm blib/lib/Font/TTF/Vmtx.pm \
	  lib/Font/TTF/Hhea.pm blib/lib/Font/TTF/Hhea.pm \
	  lib/ttfmod.pl blib/lib/ttfmod.pl \
	  lib/Font/TTF/Kern/ClassArray.pm blib/lib/Font/TTF/Kern/ClassArray.pm \
	  lib/Font/TTF/Head.pm blib/lib/Font/TTF/Head.pm \
	  lib/Font/TTF/Fmtx.pm blib/lib/Font/TTF/Fmtx.pm \
	  lib/Font/TTF/AATKern.pm blib/lib/Font/TTF/AATKern.pm \
	  lib/Font/TTF/OldMort.pm blib/lib/Font/TTF/OldMort.pm \
	  lib/Font/TTF/Bsln.pm blib/lib/Font/TTF/Bsln.pm \
	  lib/Font/TTF/Manual.pod blib/lib/Font/TTF/Manual.pod \
	  lib/Font/TTF/Font.pm blib/lib/Font/TTF/Font.pm \
	  lib/Font/TTF/GDEF.pm blib/lib/Font/TTF/GDEF.pm \
	  lib/Font/TTF/Vhea.pm blib/lib/Font/TTF/Vhea.pm \
	  lib/Font/TTF/Fpgm.pm blib/lib/Font/TTF/Fpgm.pm \
	  lib/Font/TTF/GSUB.pm blib/lib/Font/TTF/GSUB.pm \
	  lib/Font/TTF/Mort/Contextual.pm blib/lib/Font/TTF/Mort/Contextual.pm \
	  lib/Font/TTF/OS_2.pm blib/lib/Font/TTF/OS_2.pm \
	  lib/Font/TTF/Useall.pm blib/lib/Font/TTF/Useall.pm \
	  lib/Font/TTF/Ttc.pm blib/lib/Font/TTF/Ttc.pm \
	  lib/Font/TTF/Feat.pm blib/lib/Font/TTF/Feat.pm \
	  lib/Font/TTF/Name.pm blib/lib/Font/TTF/Name.pm \
	  lib/Font/TTF/Kern.pm blib/lib/Font/TTF/Kern.pm \
	  lib/Font/TTF/Kern/StateTable.pm blib/lib/Font/TTF/Kern/StateTable.pm \
	  lib/Font/TTF/OldCmap.pm blib/lib/Font/TTF/OldCmap.pm \
	  lib/Font/TTF/Segarr.pm blib/lib/Font/TTF/Segarr.pm \
	  lib/Font/TTF/Changes blib/lib/Font/TTF/Changes \
	  lib/Font/TTF/Loca.pm blib/lib/Font/TTF/Loca.pm \
	  lib/Font/TTF/Mort/Insertion.pm blib/lib/Font/TTF/Mort/Insertion.pm \
	  lib/Font/TTF/Mort/Chain.pm blib/lib/Font/TTF/Mort/Chain.pm \
	  lib/Font/TTF/Mort/Rearrangement.pm blib/lib/Font/TTF/Mort/Rearrangement.pm \
	  lib/Font/TTF/Fdsc.pm blib/lib/Font/TTF/Fdsc.pm \
	  lib/Font/TTF/Cvt_.pm blib/lib/Font/TTF/Cvt_.pm \
	  lib/Font/TTF/XMLparse.pm blib/lib/Font/TTF/XMLparse.pm \
	  lib/Font/TTF/Maxp.pm blib/lib/Font/TTF/Maxp.pm \
	  lib/Font/TTF/AATutils.pm blib/lib/Font/TTF/AATutils.pm \
	  lib/Font/TTF/Prop.pm blib/lib/Font/TTF/Prop.pm \
	  lib/Font/TTF/Coverage.pm blib/lib/Font/TTF/Coverage.pm \
	  lib/Font/TTF/PCLT.pm blib/lib/Font/TTF/PCLT.pm \
	  lib/Font/TTF/Mort/Ligature.pm blib/lib/Font/TTF/Mort/Ligature.pm \
	  lib/Font/TTF/Win32.pm blib/lib/Font/TTF/Win32.pm \
	  lib/Font/TTF/Utils.pm blib/lib/Font/TTF/Utils.pm \
	  lib/Font/TTF/Ttopen.pm blib/lib/Font/TTF/Ttopen.pm \
	  lib/Font/TTF/Kern/Subtable.pm blib/lib/Font/TTF/Kern/Subtable.pm \
	  lib/Font/TTF/Hmtx.pm blib/lib/Font/TTF/Hmtx.pm \
	  lib/Font/TTF/Kern/OrderedList.pm blib/lib/Font/TTF/Kern/OrderedList.pm \
	  lib/Font/TTF/Glyph.pm blib/lib/Font/TTF/Glyph.pm \
	  lib/Font/TTF/Mort.pm blib/lib/Font/TTF/Mort.pm \
	  lib/Font/TTF/Prep.pm blib/lib/Font/TTF/Prep.pm \
	  lib/Font/TTF/Kern/CompactClassArray.pm blib/lib/Font/TTF/Kern/CompactClassArray.pm \
	  lib/Font/TTF/Hdmx.pm blib/lib/Font/TTF/Hdmx.pm \
	  lib/Font/TTF/Cmap.pm blib/lib/Font/TTF/Cmap.pm \
	  lib/Font/TTF/GPOS.pm blib/lib/Font/TTF/GPOS.pm \
	  lib/Font/TTF/PSNames.pm blib/lib/Font/TTF/PSNames.pm \
	  lib/Font/TTF/Mort/Noncontextual.pm blib/lib/Font/TTF/Mort/Noncontextual.pm \
	  lib/Font/TTF/Post.pm blib/lib/Font/TTF/Post.pm \
	  lib/Font/TTF/Anchor.pm blib/lib/Font/TTF/Anchor.pm \
	  lib/Font/TTF/Glyf.pm blib/lib/Font/TTF/Glyf.pm \
	  lib/Font/TTF/LTSH.pm blib/lib/Font/TTF/LTSH.pm \
	  lib/Font/TTF/Table.pm blib/lib/Font/TTF/Table.pm \
	  lib/Font/TTF/Delta.pm blib/lib/Font/TTF/Delta.pm \
	  lib/Font/TTF/Mort/Subtable.pm blib/lib/Font/TTF/Mort/Subtable.pm 
	$(NOECHO) $(TOUCH) $@

# --- MakeMaker selfdocument section:


# --- MakeMaker postamble section:


# End.
