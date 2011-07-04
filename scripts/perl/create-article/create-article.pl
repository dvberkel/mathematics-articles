#! /usr/bin/env perl

# This script creates an skeleton latex article. It creates the following
# file structure.
#   <name>
#     |
#     <name>.tex
#     |
#     README
#     |
#     +- content
#     |   |
#     |   abstract.tex
#     |   |
#     |   title.tex
#     |
#     +- lib
#     |   |
#     |   environment.tex
#     |   |
#     |   commands.tex
#     |
#     +- image
#         |
#         .keep-generated
#
# Where <name> is an argument on the commandline.

use strict;
use warnings;

use Getopt::Long;
use Cwd;

# The directories which will created under the <name> directory.
my @directories = qw/content lib image/;

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

# This has will hold all the snippets to fill the files with.
my %snippets;

# Title snippet
$snippets{'content/title.tex'} = <<EO_TITLE
\% Fill the specific credential of this article.
\\title{This is the Title of This Article}
\\author{The author}
EO_TITLE
;

# Abstract snippet
$snippets{'content/abstract.tex'} = <<EO_ABSTRACT
\\begin{abstract}
	In this article the authors...
\\end{abstract}
EO_ABSTRACT
;

# Environment snippet
$snippets{'lib/environment.tex'} = <<EO_ENVIRONMENT
%-- Units construction ---------------------------------------------------------

\\usepackage{ifthen}

\\newcounter{unit}
\\setcounter{unit}{0}
\\renewcommand{\\theunit}{\\arabic{unit}}
\\newcommand{\\unitlabelstyle}{\\bfseries}
\\newcommand{\\unitreferencestyle}{}
\\newcommand{\\unitname}{???}
\\newcommand{\\unitlabel}[1]{#1}
\\newcommand{\\unitclose}{}
\\newcommand{\\increaseunitcounter}[1][y]{%
	\\ifthenelse{\\equal{#1}{n}}{}{\\refstepcounter{unit}}%
	\\renewcommand{\\unitlabel}[1]{%
		\\mbox{%
			{\\unitlabelstyle\\unitname\\ifthenelse{\\equal{#1}{n}}{}{\\ \\theunit}}%
			\\ifthenelse{\\equal{##1}{}}{}{\\unitreferencestyle\\ (##1)}%
		}%
	}%
}%
\\newcommand{\\newunit}[5][y]{%
	\\newenvironment{#2}[1][]{%
		\\increaseunitcounter[#1]%
		\\renewcommand{\\unitname}{#3}%
		\\renewcommand{\\unitclose}{#4}%
		\\begin{list}{}{%
			\\renewcommand{\\makelabel}{\\unitlabel}%
		}\\item[##1]#5%
	}{%
		\\hspace*{\\fill}\\unitclose%
		\\end{list}%
		\\renewcommand{\\unitname}{???}%
		\\renewcommand{\\unitlabel}[1]{#1}%
		\\renewcommand{\\unitclose}{}%
	}%
}

\\newcommand{\\notationname}{Notation}      \\newcommand{\\notationend}{\\ensuremath{\\bowtie}}       \\newcommand{\\notationstyle}{}
\\newcommand{\\definitionname}{Definition}  \\newcommand{\\definitionend}{\\ensuremath{\\circ}}       \\newcommand{\\definitionstyle}{}
\\newcommand{\\remarkname}{Remark}          \\newcommand{\\remarkend}{\\ensuremath{\\triangleleft}}   \\newcommand{\\remarkstyle}{}
\\newcommand{\\examplename}{Example}        \\newcommand{\\exampleend}{\\ensuremath{\\triangleright}} \\newcommand{\\examplestyle}{}
\\newcommand{\\conjecturename}{Conjecture}  \\newcommand{\\conjectureend}{\\ensuremath{\\diamond}}    \\newcommand{\\conjecturestyle}{\\itshape}
\\newcommand{\\lemmaname}{Lemma}            \\newcommand{\\lemmaend}{\\ensuremath{\\diamond}}         \\newcommand{\\lemmastyle}{\\itshape}
\\newcommand{\\theoremname}{Theorem}        \\newcommand{\\theoremend}{\\ensuremath{\\diamond}}       \\newcommand{\\theoremstyle}{\\itshape}
\\newcommand{\\propositionname}{Proposition}\\newcommand{\\propositionend}{\\ensuremath{\\diamond}}   \\newcommand{\\propositionstyle}{\\itshape}
\\newcommand{\\corollaryname}{Corollary}    \\newcommand{\\corollaryend}{\\ensuremath{\\diamond}}     \\newcommand{\\corollarystyle}{\\itshape}
\\newcommand{\\proofname}{Proof}            \\newcommand{\\proofend}{\\ensuremath{\\square}}          \\newcommand{\\proofstyle}{}

\\newunit[n]{notation}{\\notationname}{\\notationend}{\\notationstyle}
\\newunit[n]{definition}{\\definitionname}{\\definitionend}{\\definitionstyle}
\\newunit[n]{remark}{\\remarkname}{\\remarkend}{\\remarkstyle}
\\newunit{example}{\\examplename}{\\exampleend}{\\examplestyle}
\\newunit{conjecture}{\\conjecturename}{\\conjectureend}{\\conjecturestyle}
\\newunit{lemma}{\\lemmaname}{\\lemmaend}{\\lemmastyle}
\\newunit{theorem}{\\theoremname}{\\theoremend}{\\theoremstyle}
\\newunit{proposition}{\\propositionname}{\\propositionend}{\\propositionstyle}
\\newunit{corollary}{\\corollaryname}{\\corollaryend}{\\corollarystyle}
\\newunit[n]{proof}{\\proofname}{\\proofend}{\\proofstyle}

EO_ENVIRONMENT
;


# Commands snippet
$snippets{'lib/commands.tex'} = <<EO_LIB
\% Use this file to define all commands used in the article.

EO_LIB
;

# keep generated snippet
$snippets{'image/.keep-generated'} = <<EO_KEEP
# This file prohibits the removal of LaTeX generated files by
# clean-article.pl
EO_KEEP
;

# Executable README snippet
$snippets{'README'} = <<EO_README
#! /usr/bin/env bash

# This README file instructs how to build $name.
#
# The following instructions build $name. It can be run with the following
# command:
# 	bash README

name=$name

for dir in @directories
do
	if [ -f \$dir/README ]
	then
		cd \$dir
		bash README
		cd ..
	fi
done

latex \$name
latex \$name
dvips \$name.dvi -o \$name.ps
EO_README
;

# Main snippet
$snippets{"$name.tex"} = <<EO_MAIN
\\documentclass[12pt,twoside,a4paper]{article}

\\input{lib/commands}
\\input{content/title}

\\begin{document}
	\\maketitle
	\\input{content/abstract}
\\end{document}

EO_MAIN
;

# Create all the fills with the snippets.
createfiles(\%snippets);

# Make the README file executable
chmod 0754, "README";

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

# Given a hash reference of filenames to content snippets, this method
# will create all the filenames with the corresponding snippets.
sub createfiles {
	
	my $hashref = shift @_;
	my %table = %$hashref;

	for my $filename (keys %table) {
		
		createdocument($filename, $table{$filename});	
	}
}
