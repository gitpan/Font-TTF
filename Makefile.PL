use ExtUtils::MakeMaker;

@scripts = grep {-f } glob("scripts/*.*");
@theselibs = grep {-f } glob("lib/Font/TTF/*");

WriteMakefile (
        NAME => "Font::TTF",
        VERSION_FROM => "lib/Font/TTF/Font.pm",
        EXE_FILES => \@scripts,
        HTMLLIBPODS => {map {my $t = $_; $t=~s/\..*?$/.html/o; $t='blib/Html/'.$t; $_ => $t;} @theselibs},
#        HTMLSCRIPTPODS => {map {my $t=$_; $t=~s/\..*?$/.html/o; $t='blib/Html/'.$t; $_ => $t;} @scripts},
        AUTHOR => "martin_hosken\@sil.org",
        ABSTRACT => "TTF font support for Perl",
        dist => { 'TO_UNIX' => 'perl -Mtounix -e "tounix(\"$(DISTVNAME)\")"' }
    );
    
