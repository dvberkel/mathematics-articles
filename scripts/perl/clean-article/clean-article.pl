#! /usr/bin/env perl

# This scripts cleans an article of all the files generated by LaTeX.
# It can also generate an ignore file for svn.

use strict;
use warnings;

use Getopt::Long;
use Cwd;

# The extensions of the files to clean.
my @clean = qw/log aux dvi ps pdf/;

# Starting point of cleansing operation, defaults to the current working
# directory.
my $directory = getcwd;

# Flag to signal the usage of this script
my $help;

# The options for the script. The --help option shows the usage of this
# script. The --dir option sets the target directory. This is the
# directory which will hold the <name> directory.
GetOptions(
	'dir=s' => \$directory,
	'help!' => \$help
);

# List the usage of this script if the user provided the --help option.
if ($help) {
	
	die "usage: $0 [--dir=<directory>] [--help]\n";
}

cleandirectory($directory);

# Cleans directory recursively of all files in @clean.
sub cleandirectory {

	my $directory = shift @_;
	
	chdir $directory or die "Could not make $directory current directory: $!\n";	
	
	opendir DIR, '.' or die "Could not open $directory: $!\n";
	for my $file (readdir DIR) {
	
		# Skip current and parent directory.
		next if $file =~ m/^\.\.?$/;
	
		if (-d $file) {
		
			# Recurse in the directory.
			cleandirectory($file);
		} else {
		
			print "$file\n";
		}
	}
	closedir DIR;
}
