use ExtUtils::MakeMaker;

@scripts = glob("scripts/*.*");

WriteMakefile (
        NAME => "Font::TTF",
        VERSION_FROM => "lib/Font/TTF/Font.pm",
        EXE_FILES => \@scripts
    );
    
