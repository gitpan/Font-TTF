package tounix;

use File::Find;
use Exporter;

@ISA = qw(Exporter);
@EXPORT = qw(tounix);

sub tounix
{
    my ($dir) = @_;

    find(sub {
        my ($f) = $_;
        
        return unless (-T && !m/\.pdf$/oi);

        open(OUTFILE, ">temp_perl_1.out") || die "Can't open temp file";
        binmode OUTFILE;
        open(INFILE, "$f") || die "Can't open $f";
        while(<INFILE>)
        { print OUTFILE; }
        close(OUTFILE);
        close(INFILE);
        unlink $f;
        rename "temp_perl_1.out", $f;
    }, $dir);
}

