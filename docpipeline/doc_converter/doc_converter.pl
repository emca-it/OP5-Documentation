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
use Cwd;
use Time::Piece;
use File::Spec;

# Internal variables
my $isdir = 0;

# Argument variables
my $doclist = '';
my $dir_source = '';
my $dir_output = '';

# Option variables
my $type_input = "markdown";
my $type_output = "pdf";
my $client= "op5";

# Internal variables
my $date = localtime->strftime( "%Y%m%d" );

# ---- Subroutines Start ----

# Checking path.
sub check_path {
    my ( $path, $create ) = @_;
    my $isdir = 0;
    my $doesexist = 0;

    if ( !File::Spec->file_name_is_absolute( $path ) ){
        $path = Cwd::abs_path( $path );
    }

    if ( -e $path && -f $path ) {
        $doesexist = 1;
        print "$path exists and is a file.\n";
        print "Now check for access.\n";
    } elsif ( -e $path && -d $path ) {
        $doesexist = 1;
        $isdir = 1;
        print "$path exists and is a directory.\n";
        print "Now check for access.\n";
    } else {
        print "$path does not exist.\n";
    }

    return $path, $doesexist, $isdir;
}
# ----  Subroutines End  ----

GetOptions (
	"input-type|i=s" => \$type_input,
	"output-type|o=s" => \$type_output,
    "client|c=s" => \$client
);

if (@ARGV != 3) {
    die "$0 take 3 arguments.\nUSAGE: $0 <doclistfile> <sourcedir> <outputdir>\n";
}

($doclist, $dir_source, $dir_output) = @ARGV;

print "$doclist\n";
print "$dir_source\n";
print "$dir_output\n";
print "$type_input\n";
print "$type_output\n";
print "$client\n";

( $doclist, $isdir ) = check_path( $doclist, 0 );
( $dir_source, $isdir ) = check_path( $dir_source, 0 );
( $dir_output, $isdir ) = check_path( $dir_output, 1 );


