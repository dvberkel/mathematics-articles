#! /usr/bin/env perl

use strict;
use warnings;

if (scalar (@ARGV) != 1) {
	
	die "usage: $0 <name>\n";
}

my $name = shift @ARGV;

print $name;
