#! /usr/bin/env perl

# This script creates an skeleton latex article. It creates the following
# file structure.
#   <name>
#     |
#     <name>.tex
#     +- content
#     +- lib
#         |
#         commands.tex
#
# Where <name> is an argument on the commandline.

use strict;
use warnings;

use Getopt::Long;
use Cwd;

# The directories which will created under the <name> directory.
my @directories = qw/content lib/;

my $directory = getcwd;
my $help;

# The options for the script. The --help option shows the usage of this
# script. The --dir option sets the target directory. This is the
# directory which will hold the <name> directory.
GetOptions(
	'dir=s' => \$directory,
	'help!' => \$help
);

# List the usage of this script if the number of arguments is not correct
# or if the user provided the --help option.
if (scalar (@ARGV) != 1 || $help) {
	
	die "usage: $0 [--dir=<directory>] [--help] <name>\n";
}

# Receive the argument of the commandline.
my $name = shift @ARGV;

# Make the working directory the target directory.
if ($directory ne getcwd) {
	
	chdir $directory or die "could not change directory to $directory: $!\n";
}

# Create the <name> directory.
createdirectory($name);
chdir $name or die "could not change to directory $name: $!\n";

# Create the directories.
for $directory (@directories) {
	
	createdirectory($directory);	
}

# Create the abstract file content
my $abstractcontent = <<EO_ABSTRACT 
\\begin{abstract}
	In this article the authors...
\\end{abstract}
EO_ABSTRACT
;
createdocument('content/abstract.tex', $abstractcontent);

# Create the commands file content.
my $libcontent = <<EO_LIB
\% Use this file to define all commands used in the article.

EO_LIB
;
createdocument('lib/commands.tex', $libcontent);

# Create the main file content.
my $maincontent =<<EO_MAIN
\\documentclass[12pt,twoside,a4paper]{article}

\\input{lib/commands}

\\begin{document}
	\\input{content/abstract}
\\end{document}

EO_MAIN
;
createdocument("$name.tex", $maincontent);

# Creates a directory named $directory in the current working directory
# unless one of the following conditions occurs.
#   The directory already exists.
#   Their exists a file with the same name
#
# The later condition is seen as an error.
sub createdirectory {
	
	my $directory = shift @_;
	
	if (! -e $directory) {
		
		# $directory does not exist.
		mkdir $directory or die "could not create directory $directory: $!\n";
	} elsif (! -d $directory) {
		
		# $directory exists but is not an directory. 
		die "$directory exists and is not a directory.\n";
	}
}

# Creates a document with name $name and $content as content.
# It only creates this document if a file with said name does not exists.
sub createdocument {
	
	my $name = shift @_;
	my $content = shift @_;

	# Create the tex file if it does not exist.
	if (! -e $name) {

		open LIB_SOURCE, ">$name";
		print LIB_SOURCE $content;
		close LIB_SOURCE;
	} else {
		
		print "skipping creation of $name, it already exists\n";
	}	
}
