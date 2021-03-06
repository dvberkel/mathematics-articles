#! /usr/bin/env perl

# This scripts cleans an directory recursively of all the files generated
# by LaTeX unless a .keep-generated file is present in the directory.

use strict;
use warnings;

use Getopt::Long;
use Cwd;

# The extensions of the files to clean.
my @clean = qw/aux bbl blg dvi glo idx ilg ind lof log lot nav out pdf ps snm toc/;

# Starting point of cleansing operation, defaults to the current working
# directory.
my $directory = getcwd;

# Flag to signal the usage of this script
my $help;

# Flag to signal to keep the bbl file
my $bbl;

# The options for the script. The --help option shows the usage of this
# script. The --dir option sets the target directory. This is the
# directory which will hold the <name> directory.
# The --bbl options keeps the bbl file.
GetOptions(
	'dir=s' => \$directory,
	'help!' => \$help,
	'bbl!'  => \$bbl
);

# List the usage of this script if the user provided the --help option.
if ($help) {

	die "usage: $0 [--dir=<directory>] [--help] [--bbl]\n";
}

# Remove the bbl element from the @clean
if ($bbl) {
	pop(@clean);
}

# Create regex from the clean file.
my $pattern = '^.*\.(?:' . (join '|', @clean) . ')$';
my $regex = qr/$pattern/;

cleandirectory($directory);

# Cleans directory recursively of all files in @clean.
sub cleandirectory {

	local *DIR;

	my $directory = shift @_;

	# Go into the directory
	chdir $directory or die "Could not make $directory current directory: $!\n";

	# If the directory contains a .keep-generated file skip it.
	if (-e '.keep-generated') {

		return "skipping";
	}

	# Inspect all files
	opendir DIR, '.' or die "Could not open $directory: $!\n";
	for my $file (readdir DIR) {

		# Skip current and parent directory.
		next if $file =~ m/^\.\.?$/;

		if (-d $file) {

			# Recurse in the directory
			cleandirectory($file);
			chdir '..';
		} else {

			# If extension is found in @clean remove file
			if ($file =~ /$regex/) {

				unlink $file;
			}
		}
	}
	closedir DIR;
}
