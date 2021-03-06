# This utility script interprets a plain-text file that typically is generated by
# cut&paste from the tables contained in the three reference pages of the OpenType Spec:
#	Script tags:	http://www.microsoft.com/typography/otspec/scripttags.htm
#	Langauge tags:	http://www.microsoft.com/typography/otspec/languagetags.htm
#	Feature tags:	http://www.microsoft.com/typography/otspec/featurelist.htm
# Alternatively, input can be VOLT's tags.txt
# Output (to stdout) is in perl syntax for the hash initialization, e.g.:
#	    "Arabic" => "arab",
#	    "Armenian" => "armn",
# This output can the be transferred to Tags.pm
#
# Bob Hallissy 2008-01-31

use strict;

my $which;
my %iso639list;

while (<>)
{
	s/\s+$//o;	# trim trailing whitespace (including line ending).
	if (/^\s*$/o)
	{
		print "\n"; # Just print empty lines
		next;
	}
	
	s/^\s+//o;	# trim leading whitespace

    if (/^"(SCRIPT|LANGUAGE|FEATURE)"\s*,\s*"([^"]+)"\s*,\s*"([^"]+)"/)
    {
        # VOLT's tags.txt
        my ($type, $name, $tag) = ($1, $2, $3);
        print "\n\n//$type\n\n" if $type != $which;
        $which = $type;
        print "    \"$name\" => \"$tag\",\n";
    }
	
	elsif (/^'(.{1,4})'\s+(.*)$/o)
	{
		# Special reverse formatting for feature names
		my ($name, $tag) = ($2, $1);
		$tag .= " " x (4 - length($tag));	# pad tag
		print "    \"$name\" => \"$tag\",\n";
	}
	
	elsif (/^'(.{1,4})-(.{1,4})'\s+(.*)$/o)
	{
		# Special reverse formatting for feature names like 'cv01-cv99'
		my ($name, $tag1, $tag2) = ($3, $1, $2);
		for my $tag ($tag1 .. $tag2)
		{
			$tag =~ /(\d+)$/;
			my $index = $1;
			$tag .= " " x (4 - length($tag));	# pad tag
			print "    \"$name $index\" => \"$tag\",\n";
		}
	}
	elsif (/^([^\t]*)\t([\w]{2,4})(?: +(\([^\t]*\)))?(?:\t(.*))?$/o)
	{
		# Script and language names
		my ($name, $tag, $extra, $iso639list) = ($1, $2, $3, $4);
		$name =~ s/\s*\(Standard\)\s*//oi;	# Remove "(Standard)" from French and German entries
		$name .= " $extra" if defined $extra;   # Dhivehi has "(deprecated)" after the "DHV " tag -- move it to name.
		$tag .= " " x (4 - length($tag)); 	# pad tag
		print "    \"$name\" => \"$tag\",\n";
		if (defined $iso639list)
		{
			$iso639list =~ s/,//g;
			$iso639list{$tag} = $iso639list # Save for later
		}
	}
	else
	{
		print "UNEXPECTED DATA: '$_'\n";
	}
}

print "\n";
foreach my $tag (sort keys(%iso639list))
{
	printf "    \"$tag\" => \"$iso639list{$tag}\",\n";
}

=head1 AUTHOR

Bob Hallissy L<http://scripts.sil.org/FontUtils>.

=head1 LICENSING

Copyright (c) 1998-2014, SIL International (http://www.sil.org)

This script is released under the terms of the Artistic License 2.0.
For details, see the full text of the license in the file LICENSE.

=cut 
