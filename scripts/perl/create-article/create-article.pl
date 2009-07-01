#! /usr/bin/env perl



use strict;
use warnings;

use Getopt::Long;
use Cwd;

my @directories = qw/content lib/;

my $directory = getcwd;
my $help;

GetOptions(
	'dir=s' => \$directory,
	'help!' => \$help
);

if (scalar (@ARGV) != 1 || $help) {
	
	die "usage: $0 [--dir=<directory>] [--help] <name>\n";
}

my $name = shift @ARGV;

if ($directory ne getcwd) {
	
	chdir $directory or die "could not change directory to $directory: $!\n";
}

mkdir $name or die "could not create directory $name: $!\n";
chdir $name or die "could not change to directory $name: $!\n";

for $directory (@directories) {
	
	mkdir $directory or die "could not create directory $directory: $!\n";
}

open LIB_SOURCE, ">lib/commands.tex";
print LIB_SOURCE<<EO_LIB
\% Use this file to define all commands used in the article.

EO_LIB
;

close LIB_SOURCE;

open TEX_SOURCE, ">$name";

print TEX_SOURCE<<EO_SOURCE
\\documentclass[12pt,twoside,a4paper]{article}

\\input{commands}

\\begin{document}
\\end{document}

EO_SOURCE
;

close LIB_SOURCE;
