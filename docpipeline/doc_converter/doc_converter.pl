#!/usr/bin/env perl
#===============================================================================
#
#         FILE: doc_converter.pl
#
#        USAGE: ./doc_converter.pl
#
#  DESCRIPTION:
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: YOUR NAME (),
# ORGANIZATION:
#      VERSION: 1.0
#      CREATED: 03/19/2018 10:00:21
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use utf8;
use 5.010;

use Getopt::Long;
use Time::Piece;

# Argument variables
my $client = '';
my $dir_source = '';
my $dir_output = '';

# Option variables
my $type_input = "markdown";
my $type_output = "pdf";
my $config = "default.cfg";

# Internal variables
my $date = localtime->strftime("%Y%m%d");

if (@ARGV < 3) {
    die "Not enough arguments.\n";
} elsif (@ARGV > 3) {
    die "Too many arguments.\n";
}

GetOptions (
	"input-type=s" => \$type_input,
	"output-type=s" => \$type_output,
    "config-file=s" => \$config
);

($client, $dir_source, $dir_output) = @ARGV;

print "$client\n";
print "$dir_source\n";
print "$dir_output\n";
print "$type_input\n";
print "$type_output\n";
print "$config\n";

