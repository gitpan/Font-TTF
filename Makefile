# This Makefile is for the Font::TTF extension to perl.
#
# It was generated automatically by MakeMaker version
# 5.45 (Revision: 1.222) from the contents of
# Makefile.PL. Don't edit this file, edit Makefile.PL instead.
#
#	ANY CHANGES MADE HERE WILL BE LOST!
#
#   MakeMaker ARGV: ()
#
#   MakeMaker Parameters:

#	ABSTRACT => q[TTF font support for Perl]
#	AUTHOR => q[martin_hosken@sil.org]
#	EXE_FILES => [q[scripts/check_attach.plx], q[scripts/eurofix.plx], q[scripts/hackos2.plx], q[scripts/psfix.plx], q[scripts/ttfbuilder.plx], q[scripts/ttfname.plx], q[scripts/ttfremap.plx]]
#	NAME => q[Font::TTF]
#	VERSION_FROM => q[lib/Font/TTF/Font.pm]
#	dist => { TO_UNIX=>q[perl -Mtounix -e "tounix(\"$(DISTVNAME)\")"] }

# --- MakeMaker post_initialize section:


# --- MakeMaker const_config section:

# These definitions are from config.sh (via D:/Progs/Perl/lib/Config.pm)

# They may have been overridden via Makefile.PL or on the command line
AR = lib
CC = cl
CCCDLFLAGS =  
CCDLFLAGS =  
DLEXT = dll
DLSRC = dl_win32.xs
LD = link
LDDLFLAGS = -dll -nologo -nodefaultlib -release  -libpath:"D:\Progs\Perl\lib\CORE"  -machine:x86
LDFLAGS = -nologo -nodefaultlib -release  -libpath:"D:\Progs\Perl\lib\CORE"  -machine:x86
LIBC = msvcrt.lib
LIB_EXT = .lib
OBJ_EXT = .obj
OSNAME = MSWin32
OSVERS = 4.0
RANLIB = rem
SO = dll
EXE_EXT = .exe
FULL_AR = 


# --- MakeMaker constants section:
AR_STATIC_ARGS = cr
NAME = Font::TTF
DISTNAME = Font-TTF
NAME_SYM = Font_TTF
VERSION = 0.3
VERSION_SYM = 0_3
XS_VERSION = 0.3
INST_BIN = blib\bin
INST_EXE = blib\script
INST_LIB = blib\lib
INST_ARCHLIB = blib\arch
INST_SCRIPT = blib\script
PREFIX = D:\Progs\Perl
INSTALLDIRS = site
INSTALLPRIVLIB = $(PREFIX)\lib
INSTALLARCHLIB = $(PREFIX)\lib
INSTALLSITELIB = D:\Progs\Perl\site\lib
INSTALLSITEARCH = D:\Progs\Perl\site\lib
INSTALLBIN = $(PREFIX)\bin
INSTALLSCRIPT = $(PREFIX)\bin
PERL_LIB = D:\Progs\Perl\lib
PERL_ARCHLIB = D:\Progs\Perl\lib
SITELIBEXP = D:\Progs\Perl\site\lib
SITEARCHEXP = D:\Progs\Perl\site\lib
LIBPERL_A = libperl.lib
FIRST_MAKEFILE = Makefile
MAKE_APERL_FILE = Makefile.aperl
PERLMAINCC = $(CC)
PERL_INC = D:\Progs\Perl\lib\CORE
PERL = D:\Progs\Perl\bin\Perl.exe
FULLPERL = D:\Progs\Perl\bin\Perl.exe

VERSION_MACRO = VERSION
DEFINE_VERSION = -D$(VERSION_MACRO)=\"$(VERSION)\"
XS_VERSION_MACRO = XS_VERSION
XS_DEFINE_VERSION = -D$(XS_VERSION_MACRO)=\"$(XS_VERSION)\"

MAKEMAKER = 
MM_VERSION = 5.45

# FULLEXT = Pathname for extension directory (eg Foo/Bar/Oracle).
# BASEEXT = Basename part of FULLEXT. May be just equal FULLEXT. (eg Oracle)
# ROOTEXT = Directory part of FULLEXT with leading slash (eg /DBD)  !!! Deprecated from MM 5.32  !!!
# PARENT_NAME = NAME without BASEEXT and no trailing :: (eg Foo::Bar)
# DLBASE  = Basename part of dynamic library. May be just equal BASEEXT.
FULLEXT = Font\TTF
BASEEXT = TTF
PARENT_NAME = Font
DLBASE = $(BASEEXT)
VERSION_FROM = lib/Font/TTF/Font.pm
OBJECT = 
LDFROM = $(OBJECT)
LINKTYPE = dynamic

# Handy lists of source code files:
XS_FILES= 
C_FILES = 
O_FILES = 
H_FILES = 
HTMLLIBPODS    = 
HTMLSCRIPTPODS = 
MAN1PODS = 
MAN3PODS = 
HTMLEXT = html
INST_MAN1DIR = 
INSTALLMAN1DIR = 
MAN1EXT = 1
INST_MAN3DIR = 
INSTALLMAN3DIR = 
MAN3EXT = 3

# work around a famous dec-osf make(1) feature(?):
makemakerdflt: all

.SUFFIXES: .xs .c .C .cpp .cxx .cc $(OBJ_EXT)

# Nick wanted to get rid of .PRECIOUS. I don't remember why. I seem to recall, that
# some make implementations will delete the Makefile when we rebuild it. Because
# we call false(1) when we rebuild it. So make(1) is not completely wrong when it
# does so. Our milage may vary.
# .PRECIOUS: Makefile    # seems to be not necessary anymore

.PHONY: all config static dynamic test linkext manifest

# Where is the Config information that we are using/depend on
CONFIGDEP = $(PERL_ARCHLIB)\Config.pm $(PERL_INC)\config.h

# Where to put things:
INST_LIBDIR      = $(INST_LIB)\Font
INST_ARCHLIBDIR  = $(INST_ARCHLIB)\Font

INST_AUTODIR     = $(INST_LIB)\auto\$(FULLEXT)
INST_ARCHAUTODIR = $(INST_ARCHLIB)\auto\$(FULLEXT)

INST_STATIC  =
INST_DYNAMIC =
INST_BOOT    =

EXPORT_LIST = TTF.def

PERL_ARCHIVE = $(PERL_INC)\perl56.lib

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
	lib/Font/TTF/Fmtx.pm.bak \
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

PM_TO_BLIB = lib/Font/TTF/Kern/ClassArray.pm \
	$(INST_LIB)\Font\TTF\Kern\ClassArray.pm \
	lib/Font/TTF/Anchor.pm \
	$(INST_LIB)\Font\TTF\Anchor.pm \
	lib/Font/TTF/Head.pm \
	$(INST_LIB)\Font\TTF\Head.pm \
	lib/Font/TTF/PCLT.pm \
	$(INST_LIB)\Font\TTF\PCLT.pm \
	lib/Font/TTF/Mort/Rearrangement.pm \
	$(INST_LIB)\Font\TTF\Mort\Rearrangement.pm \
	lib/Font/TTF/Vmtx.pm \
	$(INST_LIB)\Font\TTF\Vmtx.pm \
	lib/Font/TTF/Mort/Noncontextual.pm \
	$(INST_LIB)\Font\TTF\Mort\Noncontextual.pm \
	lib/Font/TTF/Mort/Chain.pm \
	$(INST_LIB)\Font\TTF\Mort\Chain.pm \
	lib/Font/TTF/Bsln.pm \
	$(INST_LIB)\Font\TTF\Bsln.pm \
	lib/Font/TTF/Post.pm \
	$(INST_LIB)\Font\TTF\Post.pm \
	lib/Font/TTF/Cvt_.pm \
	$(INST_LIB)\Font\TTF\Cvt_.pm \
	lib/Font/TTF/Maxp.pm \
	$(INST_LIB)\Font\TTF\Maxp.pm \
	lib/Font/TTF/OS_2.pm \
	$(INST_LIB)\Font\TTF\OS_2.pm \
	lib/Font/TTF/Ttc.pm \
	$(INST_LIB)\Font\TTF\Ttc.pm \
	lib/Font/TTF/Win32.pm \
	$(INST_LIB)\Font\TTF\Win32.pm \
	lib/Font/TTF/Fmtx.pm \
	$(INST_LIB)\Font\TTF\Fmtx.pm \
	lib/Font/TTF/Name.pm \
	$(INST_LIB)\Font\TTF\Name.pm \
	lib/Font/TTF/Fmtx.pm.bak \
	$(INST_LIB)\Font\TTF\Fmtx.pm.bak \
	lib/Font/TTF/Delta.pm \
	$(INST_LIB)\Font\TTF\Delta.pm \
	lib/Font/TTF/Kern/CompactClassArray.pm \
	$(INST_LIB)\Font\TTF\Kern\CompactClassArray.pm \
	lib/Font/TTF/Mort.pm \
	$(INST_LIB)\Font\TTF\Mort.pm \
	lib/Font/TTF/Utils.pm \
	$(INST_LIB)\Font\TTF\Utils.pm \
	lib/Font/TTF/Loca.pm \
	$(INST_LIB)\Font\TTF\Loca.pm \
	lib/Font/TTF/Fpgm.pm \
	$(INST_LIB)\Font\TTF\Fpgm.pm \
	lib/Font/TTF/Kern/Subtable.pm \
	$(INST_LIB)\Font\TTF\Kern\Subtable.pm \
	lib/Font/TTF/GPOS.pm \
	$(INST_LIB)\Font\TTF\GPOS.pm \
	lib/Font/TTF/OldMort.pm \
	$(INST_LIB)\Font\TTF\OldMort.pm \
	lib/Font/TTF/Vhea.pm \
	$(INST_LIB)\Font\TTF\Vhea.pm \
	lib/Font/TTF/Ttopen.pm \
	$(INST_LIB)\Font\TTF\Ttopen.pm \
	lib/Font/TTF/Manual.pod \
	$(INST_LIB)\Font\TTF\Manual.pod \
	lib/Font/TTF/Cmap.pm \
	$(INST_LIB)\Font\TTF\Cmap.pm \
	lib/Font/TTF/Prop.pm \
	$(INST_LIB)\Font\TTF\Prop.pm \
	lib/Font/TTF/LTSH.pm \
	$(INST_LIB)\Font\TTF\LTSH.pm \
	lib/Font/TTF/Mort/Subtable.pm \
	$(INST_LIB)\Font\TTF\Mort\Subtable.pm \
	lib/Font/TTF/Hmtx.pm \
	$(INST_LIB)\Font\TTF\Hmtx.pm \
	lib/Font/TTF/AATutils.pm \
	$(INST_LIB)\Font\TTF\AATutils.pm \
	lib/Font/TTF/Kern/OrderedList.pm \
	$(INST_LIB)\Font\TTF\Kern\OrderedList.pm \
	lib/Font/TTF/Kern/StateTable.pm \
	$(INST_LIB)\Font\TTF\Kern\StateTable.pm \
	lib/Font/TTF/XMLparse.pm \
	$(INST_LIB)\Font\TTF\XMLparse.pm \
	lib/Font/TTF/Fdsc.pm \
	$(INST_LIB)\Font\TTF\Fdsc.pm \
	lib/Font/TTF/OldCmap.pm \
	$(INST_LIB)\Font\TTF\OldCmap.pm \
	lib/Font/TTF/Table.pm \
	$(INST_LIB)\Font\TTF\Table.pm \
	lib/Font/TTF/Glyf.pm \
	$(INST_LIB)\Font\TTF\Glyf.pm \
	lib/Font/TTF/Mort/Ligature.pm \
	$(INST_LIB)\Font\TTF\Mort\Ligature.pm \
	lib/Font/TTF/GSUB.pm \
	$(INST_LIB)\Font\TTF\GSUB.pm \
	lib/Font/TTF/Coverage.pm \
	$(INST_LIB)\Font\TTF\Coverage.pm \
	lib/Font/TTF/Hdmx.pm \
	$(INST_LIB)\Font\TTF\Hdmx.pm \
	lib/Font/TTF/AATKern.pm \
	$(INST_LIB)\Font\TTF\AATKern.pm \
	lib/Font/TTF/Prep.pm \
	$(INST_LIB)\Font\TTF\Prep.pm \
	lib/Font/TTF/Mort/Insertion.pm \
	$(INST_LIB)\Font\TTF\Mort\Insertion.pm \
	lib/Font/TTF/Mort/Contextual.pm \
	$(INST_LIB)\Font\TTF\Mort\Contextual.pm \
	lib/Font/TTF/GDEF.pm \
	$(INST_LIB)\Font\TTF\GDEF.pm \
	lib/Font/TTF/PSNames.pm \
	$(INST_LIB)\Font\TTF\PSNames.pm \
	lib/Font/TTF/Font.pm \
	$(INST_LIB)\Font\TTF\Font.pm \
	lib/Font/TTF/Feat.pm \
	$(INST_LIB)\Font\TTF\Feat.pm \
	lib/ttfmod.pl \
	$(INST_LIB)\ttfmod.pl \
	lib/Font/TTF/Kern.pm \
	$(INST_LIB)\Font\TTF\Kern.pm \
	lib/Font/TTF/Glyph.pm \
	$(INST_LIB)\Font\TTF\Glyph.pm \
	lib/Font/TTF/Changes \
	$(INST_LIB)\Font\TTF\Changes \
	lib/Font/TTF/Useall.pm \
	$(INST_LIB)\Font\TTF\Useall.pm \
	lib/Font/TTF/Hhea.pm \
	$(INST_LIB)\Font\TTF\Hhea.pm \
	lib/Font/TTF/Segarr.pm \
	$(INST_LIB)\Font\TTF\Segarr.pm


# --- MakeMaker tool_autosplit section:

# Usage: $(AUTOSPLITFILE) FileToSplit AutoDirToSplitInto
AUTOSPLITFILE = $(PERL) "-I$(PERL_ARCHLIB)" "-I$(PERL_LIB)" -MAutoSplit  -e "autosplit($$ARGV[0], $$ARGV[1], 0, 1, 1);"


# --- MakeMaker tool_xsubpp section:


# --- MakeMaker tools_other section:

SHELL = cmd /x /c
CHMOD = $(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) -MExtUtils::Command -e chmod
CP = $(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) -MExtUtils::Command -e cp
LD = link
MV = $(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) -MExtUtils::Command -e mv
NOOP = rem
RM_F = $(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) -MExtUtils::Command -e rm_f
RM_RF = $(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) -MExtUtils::Command -e rm_rf
TEST_F = $(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) -MExtUtils::Command -e test_f
TOUCH = $(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) -MExtUtils::Command -e touch
UMASK_NULL = umask 0
DEV_NULL = > NUL

# The following is a portable way to say mkdir -p
# To see which directories are created, change the if 0 to if 1
MKPATH = $(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) -MExtUtils::Command -e mkpath

# This helps us to minimize the effect of the .exists files A yet
# better solution would be to have a stable file in the perl
# distribution with a timestamp of zero. But this solution doesn't
# need any changes to the core distribution and works with older perls
EQUALIZE_TIMESTAMP = $(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) -MExtUtils::Command -e eqtime

# Here we warn users that an old packlist file was found somewhere,
# and that they should call some uninstall routine
WARN_IF_OLD_PACKLIST = $(PERL) -lwe "exit unless -f $$ARGV[0];" \
-e "print 'WARNING: I have found an old package in';" \
-e "print '	', $$ARGV[0], '.';" \
-e "print 'Please make sure the two installations are not conflicting';"

UNINST=0
VERBINST=1

MOD_INSTALL = $(PERL) -I$(INST_LIB) -I$(PERL_LIB) -MExtUtils::Install \
-e "install({ @ARGV },'$(VERBINST)',0,'$(UNINST)');"

DOC_INSTALL = $(PERL) -e "$$\=\"\n\n\";" \
-e "print '=head2 ', scalar(localtime), ': C<', shift, '>', ' L<', $$arg=shift, '|', $$arg, '>';" \
-e "print '=over 4';" \
-e "while (defined($$key = shift) and defined($$val = shift)) { print '=item *';print 'C<', \"$$key: $$val\", '>'; }" \
-e "print '=back';"

UNINSTALL =   $(PERL) -MExtUtils::Install \
-e "uninstall($$ARGV[0],1,1); print \"\nUninstall is deprecated. Please check the";" \
-e "print \" packlist above carefully.\n  There may be errors. Remove the\";" \
-e "print \" appropriate files manually.\n  Sorry for the inconveniences.\n\""


# --- MakeMaker dist section:

DISTVNAME = $(DISTNAME)-$(VERSION)
TAR  = tar
TARFLAGS = cvf
ZIP  = zip
ZIPFLAGS = -r
COMPRESS = gzip --best
SUFFIX = .gz
SHAR = shar
PREOP = @$(NOOP)
POSTOP = @$(NOOP)
TO_UNIX = perl -Mtounix -e "tounix(\"$(DISTVNAME)\")"
CI = ci -u
RCS_LABEL = rcs -Nv$(VERSION_SYM): -q
DIST_CP = best
DIST_DEFAULT = tardist


# --- MakeMaker macro section:


# --- MakeMaker depend section:


# --- MakeMaker cflags section:


# --- MakeMaker const_loadlibs section:


# --- MakeMaker const_cccmd section:


# --- MakeMaker post_constants section:


# --- MakeMaker pasthru section:
PASTHRU = -nologo

# --- MakeMaker c_o section:


# --- MakeMaker xs_c section:


# --- MakeMaker xs_o section:


# --- MakeMaker top_targets section:

#all ::	config $(INST_PM) subdirs linkext manifypods

all :: pure_all htmlifypods manifypods
	@$(NOOP)

pure_all :: config pm_to_blib subdirs linkext
	@$(NOOP)

subdirs :: $(MYEXTLIB)
	@$(NOOP)

config :: Makefile $(INST_LIBDIR)\.exists
	@$(NOOP)

config :: $(INST_ARCHAUTODIR)\.exists
	@$(NOOP)

config :: $(INST_AUTODIR)\.exists
	@$(NOOP)

$(INST_AUTODIR)\.exists :: D:\Progs\Perl\lib\CORE\perl.h
	@$(MKPATH) $(INST_AUTODIR)
	@$(EQUALIZE_TIMESTAMP) D:\Progs\Perl\lib\CORE\perl.h $(INST_AUTODIR)\.exists

	-@$(CHMOD) $(PERM_RWX) $(INST_AUTODIR)

$(INST_LIBDIR)\.exists :: D:\Progs\Perl\lib\CORE\perl.h
	@$(MKPATH) $(INST_LIBDIR)
	@$(EQUALIZE_TIMESTAMP) D:\Progs\Perl\lib\CORE\perl.h $(INST_LIBDIR)\.exists

	-@$(CHMOD) $(PERM_RWX) $(INST_LIBDIR)

$(INST_ARCHAUTODIR)\.exists :: D:\Progs\Perl\lib\CORE\perl.h
	@$(MKPATH) $(INST_ARCHAUTODIR)
	@$(EQUALIZE_TIMESTAMP) D:\Progs\Perl\lib\CORE\perl.h $(INST_ARCHAUTODIR)\.exists

	-@$(CHMOD) $(PERM_RWX) $(INST_ARCHAUTODIR)

help:
	perldoc ExtUtils::MakeMaker

Version_check:
	@$(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) \
		-MExtUtils::MakeMaker=Version_check \
		-e "Version_check('$(MM_VERSION)')"


# --- MakeMaker linkext section:

linkext :: $(LINKTYPE)
	@$(NOOP)


# --- MakeMaker dlsyms section:

TTF.def: Makefile.PL
	$(PERL) "-I$(PERL_ARCHLIB)" "-I$(PERL_LIB)" -MExtUtils::Mksymlists \
     -e "Mksymlists('NAME' => 'Font::TTF', 'DLBASE' => '$(BASEEXT)', 'DL_FUNCS' => {  }, 'FUNCLIST' => [], 'IMPORTS' => {  }, 'DL_VARS' => []);"


# --- MakeMaker dynamic section:

## $(INST_PM) has been moved to the all: target.
## It remains here for awhile to allow for old usage: "make dynamic"
#dynamic :: Makefile $(INST_DYNAMIC) $(INST_BOOT) $(INST_PM)
dynamic :: Makefile $(INST_DYNAMIC) $(INST_BOOT)
	@$(NOOP)


# --- MakeMaker dynamic_bs section:

BOOTSTRAP =


# --- MakeMaker dynamic_lib section:


# --- MakeMaker static section:

## $(INST_PM) has been moved to the all: target.
## It remains here for awhile to allow for old usage: "make static"
#static :: Makefile $(INST_STATIC) $(INST_PM)
static :: Makefile $(INST_STATIC)
	@$(NOOP)


# --- MakeMaker static_lib section:


# --- MakeMaker htmlifypods section:

htmlifypods : pure_all
	@$(NOOP)


# --- MakeMaker manifypods section:

manifypods :
	@$(NOOP)


# --- MakeMaker processPL section:


# --- MakeMaker installbin section:

$(INST_SCRIPT)\.exists :: D:\Progs\Perl\lib\CORE\perl.h
	@$(MKPATH) $(INST_SCRIPT)
	@$(EQUALIZE_TIMESTAMP) D:\Progs\Perl\lib\CORE\perl.h $(INST_SCRIPT)\.exists

	-@$(CHMOD) $(PERM_RWX) $(INST_SCRIPT)

EXE_FILES = scripts/check_attach.plx scripts/eurofix.plx scripts/hackos2.plx scripts/psfix.plx scripts/ttfbuilder.plx scripts/ttfname.plx scripts/ttfremap.plx

FIXIN = $(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) \
    -e "system qq[pl2bat.bat ].shift"

pure_all :: $(INST_SCRIPT)\check_attach.plx $(INST_SCRIPT)\ttfname.plx $(INST_SCRIPT)\ttfbuilder.plx $(INST_SCRIPT)\hackos2.plx $(INST_SCRIPT)\eurofix.plx $(INST_SCRIPT)\psfix.plx $(INST_SCRIPT)\ttfremap.plx
	@$(NOOP)

realclean ::
	$(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) -MExtUtils::Command -e rm_f $(INST_SCRIPT)\check_attach.plx $(INST_SCRIPT)\ttfname.plx $(INST_SCRIPT)\ttfbuilder.plx $(INST_SCRIPT)\hackos2.plx $(INST_SCRIPT)\eurofix.plx $(INST_SCRIPT)\psfix.plx $(INST_SCRIPT)\ttfremap.plx

$(INST_SCRIPT)\check_attach.plx: scripts/check_attach.plx Makefile $(INST_SCRIPT)\.exists
	@$(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) -MExtUtils::Command -e rm_f $(INST_SCRIPT)\check_attach.plx
	$(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) -MExtUtils::Command -e cp scripts/check_attach.plx $(INST_SCRIPT)\check_attach.plx
	$(FIXIN) $(INST_SCRIPT)\check_attach.plx
	-@$(CHMOD) $(PERM_RWX) $(INST_SCRIPT)\check_attach.plx

$(INST_SCRIPT)\ttfname.plx: scripts/ttfname.plx Makefile $(INST_SCRIPT)\.exists
	@$(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) -MExtUtils::Command -e rm_f $(INST_SCRIPT)\ttfname.plx
	$(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) -MExtUtils::Command -e cp scripts/ttfname.plx $(INST_SCRIPT)\ttfname.plx
	$(FIXIN) $(INST_SCRIPT)\ttfname.plx
	-@$(CHMOD) $(PERM_RWX) $(INST_SCRIPT)\ttfname.plx

$(INST_SCRIPT)\ttfbuilder.plx: scripts/ttfbuilder.plx Makefile $(INST_SCRIPT)\.exists
	@$(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) -MExtUtils::Command -e rm_f $(INST_SCRIPT)\ttfbuilder.plx
	$(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) -MExtUtils::Command -e cp scripts/ttfbuilder.plx $(INST_SCRIPT)\ttfbuilder.plx
	$(FIXIN) $(INST_SCRIPT)\ttfbuilder.plx
	-@$(CHMOD) $(PERM_RWX) $(INST_SCRIPT)\ttfbuilder.plx

$(INST_SCRIPT)\hackos2.plx: scripts/hackos2.plx Makefile $(INST_SCRIPT)\.exists
	@$(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) -MExtUtils::Command -e rm_f $(INST_SCRIPT)\hackos2.plx
	$(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) -MExtUtils::Command -e cp scripts/hackos2.plx $(INST_SCRIPT)\hackos2.plx
	$(FIXIN) $(INST_SCRIPT)\hackos2.plx
	-@$(CHMOD) $(PERM_RWX) $(INST_SCRIPT)\hackos2.plx

$(INST_SCRIPT)\eurofix.plx: scripts/eurofix.plx Makefile $(INST_SCRIPT)\.exists
	@$(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) -MExtUtils::Command -e rm_f $(INST_SCRIPT)\eurofix.plx
	$(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) -MExtUtils::Command -e cp scripts/eurofix.plx $(INST_SCRIPT)\eurofix.plx
	$(FIXIN) $(INST_SCRIPT)\eurofix.plx
	-@$(CHMOD) $(PERM_RWX) $(INST_SCRIPT)\eurofix.plx

$(INST_SCRIPT)\psfix.plx: scripts/psfix.plx Makefile $(INST_SCRIPT)\.exists
	@$(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) -MExtUtils::Command -e rm_f $(INST_SCRIPT)\psfix.plx
	$(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) -MExtUtils::Command -e cp scripts/psfix.plx $(INST_SCRIPT)\psfix.plx
	$(FIXIN) $(INST_SCRIPT)\psfix.plx
	-@$(CHMOD) $(PERM_RWX) $(INST_SCRIPT)\psfix.plx

$(INST_SCRIPT)\ttfremap.plx: scripts/ttfremap.plx Makefile $(INST_SCRIPT)\.exists
	@$(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) -MExtUtils::Command -e rm_f $(INST_SCRIPT)\ttfremap.plx
	$(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) -MExtUtils::Command -e cp scripts/ttfremap.plx $(INST_SCRIPT)\ttfremap.plx
	$(FIXIN) $(INST_SCRIPT)\ttfremap.plx
	-@$(CHMOD) $(PERM_RWX) $(INST_SCRIPT)\ttfremap.plx


# --- MakeMaker subdirs section:

# none

# --- MakeMaker clean section:

# Delete temporary files but do not touch installed files. We don't delete
# the Makefile here so a later make realclean still has a makefile to use.

clean ::
	-$(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) -MExtUtils::Command -e rm_rf ./blib $(MAKE_APERL_FILE) $(INST_ARCHAUTODIR)/extralibs.all perlmain.c mon.out core core.*perl.*.? *perl.core so_locations pm_to_blib *$(OBJ_EXT) *$(LIB_EXT) perl.exe $(BOOTSTRAP) $(BASEEXT).bso $(BASEEXT).def $(BASEEXT).exp
	-$(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) -MExtUtils::Command -e mv Makefile Makefile.old $(DEV_NULL)


# --- MakeMaker realclean section:

# Delete temporary files (via clean) and also delete installed files
realclean purge ::  clean
	$(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) -MExtUtils::Command -e rm_rf $(INST_AUTODIR) $(INST_ARCHAUTODIR)
	$(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) -MExtUtils::Command -e rm_f  $(INST_LIB)\Font\TTF\Kern\ClassArray.pm $(INST_LIB)\Font\TTF\Anchor.pm
	$(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) -MExtUtils::Command -e rm_f $(INST_LIB)\Font\TTF\Head.pm $(INST_LIB)\Font\TTF\PCLT.pm
	$(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) -MExtUtils::Command -e rm_f $(INST_LIB)\Font\TTF\Mort\Rearrangement.pm $(INST_LIB)\Font\TTF\Vmtx.pm
	$(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) -MExtUtils::Command -e rm_f $(INST_LIB)\Font\TTF\Mort\Noncontextual.pm $(INST_LIB)\Font\TTF\Mort\Chain.pm
	$(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) -MExtUtils::Command -e rm_f $(INST_LIB)\Font\TTF\Bsln.pm $(INST_LIB)\Font\TTF\Post.pm
	$(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) -MExtUtils::Command -e rm_f $(INST_LIB)\Font\TTF\Cvt_.pm $(INST_LIB)\Font\TTF\Maxp.pm
	$(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) -MExtUtils::Command -e rm_f $(INST_LIB)\Font\TTF\OS_2.pm $(INST_LIB)\Font\TTF\Ttc.pm
	$(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) -MExtUtils::Command -e rm_f $(INST_LIB)\Font\TTF\Win32.pm $(INST_LIB)\Font\TTF\Fmtx.pm
	$(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) -MExtUtils::Command -e rm_f $(INST_LIB)\Font\TTF\Name.pm $(INST_LIB)\Font\TTF\Fmtx.pm.bak
	$(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) -MExtUtils::Command -e rm_f $(INST_LIB)\Font\TTF\Delta.pm $(INST_LIB)\Font\TTF\Kern\CompactClassArray.pm
	$(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) -MExtUtils::Command -e rm_f $(INST_LIB)\Font\TTF\Mort.pm $(INST_LIB)\Font\TTF\Utils.pm
	$(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) -MExtUtils::Command -e rm_f $(INST_LIB)\Font\TTF\Loca.pm $(INST_LIB)\Font\TTF\Fpgm.pm
	$(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) -MExtUtils::Command -e rm_f $(INST_LIB)\Font\TTF\Kern\Subtable.pm $(INST_LIB)\Font\TTF\GPOS.pm
	$(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) -MExtUtils::Command -e rm_f $(INST_LIB)\Font\TTF\OldMort.pm $(INST_LIB)\Font\TTF\Vhea.pm
	$(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) -MExtUtils::Command -e rm_f $(INST_LIB)\Font\TTF\Ttopen.pm $(INST_LIB)\Font\TTF\Manual.pod
	$(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) -MExtUtils::Command -e rm_f $(INST_LIB)\Font\TTF\Cmap.pm $(INST_LIB)\Font\TTF\Prop.pm
	$(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) -MExtUtils::Command -e rm_f $(INST_LIB)\Font\TTF\LTSH.pm $(INST_LIB)\Font\TTF\Mort\Subtable.pm
	$(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) -MExtUtils::Command -e rm_f $(INST_LIB)\Font\TTF\Hmtx.pm $(INST_LIB)\Font\TTF\AATutils.pm
	$(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) -MExtUtils::Command -e rm_f $(INST_LIB)\Font\TTF\Kern\OrderedList.pm $(INST_LIB)\Font\TTF\Kern\StateTable.pm
	$(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) -MExtUtils::Command -e rm_f $(INST_LIB)\Font\TTF\XMLparse.pm $(INST_LIB)\Font\TTF\Fdsc.pm
	$(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) -MExtUtils::Command -e rm_f $(INST_LIB)\Font\TTF\OldCmap.pm $(INST_LIB)\Font\TTF\Table.pm
	$(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) -MExtUtils::Command -e rm_f $(INST_LIB)\Font\TTF\Glyf.pm $(INST_LIB)\Font\TTF\Mort\Ligature.pm
	$(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) -MExtUtils::Command -e rm_f $(INST_LIB)\Font\TTF\GSUB.pm $(INST_LIB)\Font\TTF\Coverage.pm
	$(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) -MExtUtils::Command -e rm_f $(INST_LIB)\Font\TTF\Hdmx.pm $(INST_LIB)\Font\TTF\AATKern.pm
	$(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) -MExtUtils::Command -e rm_f $(INST_LIB)\Font\TTF\Prep.pm $(INST_LIB)\Font\TTF\Mort\Insertion.pm
	$(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) -MExtUtils::Command -e rm_f $(INST_LIB)\Font\TTF\Mort\Contextual.pm $(INST_LIB)\Font\TTF\GDEF.pm
	$(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) -MExtUtils::Command -e rm_f $(INST_LIB)\Font\TTF\PSNames.pm $(INST_LIB)\Font\TTF\Font.pm
	$(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) -MExtUtils::Command -e rm_f $(INST_LIB)\Font\TTF\Feat.pm $(INST_LIB)\ttfmod.pl $(INST_LIB)\Font\TTF\Kern.pm
	$(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) -MExtUtils::Command -e rm_f $(INST_LIB)\Font\TTF\Glyph.pm $(INST_LIB)\Font\TTF\Changes
	$(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) -MExtUtils::Command -e rm_f $(INST_LIB)\Font\TTF\Useall.pm $(INST_LIB)\Font\TTF\Hhea.pm
	$(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) -MExtUtils::Command -e rm_f $(INST_LIB)\Font\TTF\Segarr.pm
	$(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) -MExtUtils::Command -e rm_rf Makefile Makefile.old


# --- MakeMaker dist_basics section:

distclean :: realclean distcheck

distcheck :
	$(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) -MExtUtils::Manifest=fullcheck \
		-e fullcheck

skipcheck :
	$(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) -MExtUtils::Manifest=skipcheck \
		-e skipcheck

manifest :
	$(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) -MExtUtils::Manifest=mkmanifest \
		-e mkmanifest

veryclean : realclean
	$(RM_F) *~ *.orig */*~ */*.orig


# --- MakeMaker dist_core section:

dist : $(DIST_DEFAULT)
	@$(PERL) -le "print \"Warning: Makefile possibly out of date with $$vf\" if " \
	    -e "-e ($$vf=\"$(VERSION_FROM)\") and -M $$vf < -M \"Makefile\";"

tardist : $(DISTVNAME).tar$(SUFFIX)

zipdist : $(DISTVNAME).zip

$(DISTVNAME).tar$(SUFFIX) : distdir
	$(PREOP)
	$(TO_UNIX)
	$(TAR) $(TARFLAGS) $(DISTVNAME).tar $(DISTVNAME)
	$(RM_RF) $(DISTVNAME)
	$(COMPRESS) $(DISTVNAME).tar
	$(POSTOP)

$(DISTVNAME).zip : distdir
	$(PREOP)
	$(ZIP) $(ZIPFLAGS) $(DISTVNAME).zip $(DISTVNAME)
	$(RM_RF) $(DISTVNAME)
	$(POSTOP)

uutardist : $(DISTVNAME).tar$(SUFFIX)
	uuencode $(DISTVNAME).tar$(SUFFIX) \
		$(DISTVNAME).tar$(SUFFIX) > \
		$(DISTVNAME).tar$(SUFFIX)_uu

shdist : distdir
	$(PREOP)
	$(SHAR) $(DISTVNAME) > $(DISTVNAME).shar
	$(RM_RF) $(DISTVNAME)
	$(POSTOP)


# --- MakeMaker dist_dir section:

distdir :
	$(RM_RF) $(DISTVNAME)
	$(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) -MExtUtils::Manifest=manicopy,maniread \
		-e "manicopy(maniread(),'$(DISTVNAME)', '$(DIST_CP)');"


# --- MakeMaker dist_test section:

disttest : distdir
	cd $(DISTVNAME) && $(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) Makefile.PL
	cd $(DISTVNAME) && $(MAKE)
	cd $(DISTVNAME) && $(MAKE) test


# --- MakeMaker dist_ci section:

ci :
	$(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) -MExtUtils::Manifest=maniread \
		-e "@all = keys %{ maniread() };" \
		-e "print(\"Executing $(CI) @all\n\"); system(\"$(CI) @all\");" \
		-e "print(\"Executing $(RCS_LABEL) ...\n\"); system(\"$(RCS_LABEL) @all\");"


# --- MakeMaker install section:

install :: all pure_install doc_install

install_perl :: all pure_perl_install doc_perl_install

install_site :: all pure_site_install doc_site_install

install_ :: install_site
	@echo INSTALLDIRS not defined, defaulting to INSTALLDIRS=site

pure_install :: pure_$(INSTALLDIRS)_install

doc_install :: doc_$(INSTALLDIRS)_install
	@echo Appending installation info to $(INSTALLARCHLIB)/perllocal.pod

pure__install : pure_site_install
	@echo INSTALLDIRS not defined, defaulting to INSTALLDIRS=site

doc__install : doc_site_install
	@echo INSTALLDIRS not defined, defaulting to INSTALLDIRS=site

pure_perl_install ::
	@$(MOD_INSTALL) \
		read $(PERL_ARCHLIB)\auto\$(FULLEXT)\.packlist \
		write $(INSTALLARCHLIB)\auto\$(FULLEXT)\.packlist \
		$(INST_LIB) $(INSTALLPRIVLIB) \
		$(INST_ARCHLIB) $(INSTALLARCHLIB) \
		$(INST_BIN) $(INSTALLBIN) \
		$(INST_SCRIPT) $(INSTALLSCRIPT) \
		$(INST_HTMLLIBDIR) $(INSTALLHTMLPRIVLIBDIR) \
		$(INST_HTMLSCRIPTDIR) $(INSTALLHTMLSCRIPTDIR) \
		$(INST_MAN1DIR) $(INSTALLMAN1DIR) \
		$(INST_MAN3DIR) $(INSTALLMAN3DIR)
	@$(WARN_IF_OLD_PACKLIST) \
		$(SITEARCHEXP)\auto\$(FULLEXT)


pure_site_install ::
	@$(MOD_INSTALL) \
		read $(SITEARCHEXP)\auto\$(FULLEXT)\.packlist \
		write $(INSTALLSITEARCH)\auto\$(FULLEXT)\.packlist \
		$(INST_LIB) $(INSTALLSITELIB) \
		$(INST_ARCHLIB) $(INSTALLSITEARCH) \
		$(INST_BIN) $(INSTALLBIN) \
		$(INST_SCRIPT) $(INSTALLSCRIPT) \
		$(INST_HTMLLIBDIR) $(INSTALLHTMLSITELIBDIR) \
		$(INST_HTMLSCRIPTDIR) $(INSTALLHTMLSCRIPTDIR) \
		$(INST_MAN1DIR) $(INSTALLMAN1DIR) \
		$(INST_MAN3DIR) $(INSTALLMAN3DIR)
	@$(WARN_IF_OLD_PACKLIST) \
		$(PERL_ARCHLIB)\auto\$(FULLEXT)

doc_perl_install ::
	-@$(MKPATH) $(INSTALLARCHLIB)
	-@$(DOC_INSTALL) \
		"Module" "$(NAME)" \
		"installed into" "$(INSTALLPRIVLIB)" \
		LINKTYPE "$(LINKTYPE)" \
		VERSION "$(VERSION)" \
		EXE_FILES "$(EXE_FILES)" \
		>> $(INSTALLARCHLIB)\perllocal.pod

doc_site_install ::
	-@$(MKPATH) $(INSTALLARCHLIB)
	-@$(DOC_INSTALL) \
		"Module" "$(NAME)" \
		"installed into" "$(INSTALLSITELIB)" \
		LINKTYPE "$(LINKTYPE)" \
		VERSION "$(VERSION)" \
		EXE_FILES "$(EXE_FILES)" \
		>> $(INSTALLARCHLIB)\perllocal.pod


uninstall :: uninstall_from_$(INSTALLDIRS)dirs

uninstall_from_perldirs ::
	@$(UNINSTALL) $(PERL_ARCHLIB)\auto\$(FULLEXT)\.packlist

uninstall_from_sitedirs ::
	@$(UNINSTALL) $(SITEARCHEXP)\auto\$(FULLEXT)\.packlist


# --- MakeMaker force section:
# Phony target to force checking subdirectories.
FORCE:
	@$(NOOP)


# --- MakeMaker perldepend section:


# --- MakeMaker makefile section:

# We take a very conservative approach here, but it\'s worth it.
# We move Makefile to Makefile.old here to avoid gnu make looping.
Makefile : Makefile.PL $(CONFIGDEP)
	@echo "Makefile out-of-date with respect to $?"
	@echo "Cleaning current config before rebuilding Makefile..."
	-@$(RM_F) Makefile.old
	-@$(MV) Makefile Makefile.old
	-$(MAKE) -f Makefile.old clean $(DEV_NULL) || $(NOOP)
	$(PERL) "-I$(PERL_ARCHLIB)" "-I$(PERL_LIB)" Makefile.PL 
	@echo "==> Your Makefile has been rebuilt. <=="
	@echo "==> Please rerun the make command.  <=="
	false

# To change behavior to :: would be nice, but would break Tk b9.02
# so you find such a warning below the dist target.
#Makefile :: $(VERSION_FROM)
#	@echo "Warning: Makefile possibly out of date with $(VERSION_FROM)"


# --- MakeMaker staticmake section:

# --- MakeMaker makeaperl section ---
MAP_TARGET    = perl
FULLPERL      = D:\Progs\Perl\bin\Perl.exe

$(MAP_TARGET) :: static $(MAKE_APERL_FILE)
	$(MAKE) -f $(MAKE_APERL_FILE) $@

$(MAKE_APERL_FILE) : $(FIRST_MAKEFILE)
	@echo Writing \"$(MAKE_APERL_FILE)\" for this $(MAP_TARGET)
	@$(PERL) -I$(INST_ARCHLIB) -I$(INST_LIB) -I$(PERL_ARCHLIB) -I$(PERL_LIB) \
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
	@echo 'No tests defined for $(NAME) extension.'

test_dynamic :: pure_all

testdb_dynamic :: pure_all
	$(FULLPERL) $(TESTDB_SW) -I$(INST_ARCHLIB) -I$(INST_LIB) -I$(PERL_ARCHLIB) -I$(PERL_LIB) $(TEST_FILE)

test_ : test_dynamic

test_static :: test_dynamic
testdb_static :: testdb_dynamic


# --- MakeMaker ppd section:
# Creates a PPD (Perl Package Description) for a binary distribution.
ppd:
	@$(PERL) -e "print qq{<SOFTPKG NAME=\"Font-TTF\" VERSION=\"0,3,0,0\">\n}. qq{\t<TITLE>Font-TTF</TITLE>\n}. qq{\t<ABSTRACT>TTF font support for Perl</ABSTRACT>\n}. qq{\t<AUTHOR>martin_hosken\@sil.org</AUTHOR>\n}. qq{\t<IMPLEMENTATION>\n}. qq{\t\t<OS NAME=\"$(OSNAME)\" />\n}. qq{\t\t<ARCHITECTURE NAME=\"MSWin32-x86-multi-thread\" />\n}. qq{\t\t<CODEBASE HREF=\"\" />\n}. qq{\t</IMPLEMENTATION>\n}. qq{</SOFTPKG>\n}" > Font-TTF.ppd

# --- MakeMaker pm_to_blib section:

pm_to_blib: $(TO_INST_PM)
	@$(PERL) "-I$(INST_ARCHLINE)" "-I$(INST_LIB)" \
	"-I$(PERL_ARCHLIB)" "-I$(PERL_LIB)" -MExtUtils::Install \
	-e "pm_to_blib({ qw[$(PM_TO_BLIB)] }, '$(INST_LIB)\auto')
	@$(TOUCH) $@



# --- MakeMaker selfdocument section:


# --- MakeMaker postamble section:


# End.
