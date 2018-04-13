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
my $type_output = "docx";
my $delimiter_file = ".";
my $delimiter_name = "-";

# Internal variables
my $date = localtime->strftime("%Y%m%d");

GetOptions (
	"file-delimiter=s" => \$delimiter_file,
	"name-delimiter=s" => \$delimiter_name,
);

foreach my $argument (@ARGV) {
	print "$argument\n";
}

