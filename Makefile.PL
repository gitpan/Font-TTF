use ExtUtils::MakeMaker;

@scripts = grep {-f } glob("scripts/*.*");

WriteMakefile (
        NAME => "Font::TTF",
        VERSION_FROM => "lib/Font/TTF/Font.pm",
        EXE_FILES => \@scripts,
        AUTHOR => "martin_hosken\@sil.org",
        ABSTRACT => "TTF font support for Perl",
        dist => { 'TO_UNIX' => 'perl -Mtounix -e "tounix(\"$(DISTVNAME)\")"' }
    );
    
