#!/usr/bin/perl -w
#Orginal script from http://blog.schose.net/index.php/archives/135
#Modifief by Ola Sandstrom, OP5 to work with Zimbra 8

use strict;
use English;
use Getopt::Long;
#use File::stat;
sub print_help ();
sub print_usage ();
sub check_username ();

my ($opt_z, $opt_h, $opt_b, $opt_u);
my ($result, $message, @failed_services);

my $PROGNAME="check_zmstatus";

#default values
$opt_z='/opt/zimbra/bin/zmcontrol';
$opt_u='zimbra';


Getopt::Long::Configure('bundling');
GetOptions(
        "h"   => \$opt_h, "help"        => \$opt_h,
        "u=s" => \$opt_u, "username"        => \$opt_u,
        "b=s" => \$opt_z, "binary"        => \$opt_z);

if ($opt_h) {
        print_help();
        exit;
}

$opt_z = shift unless ($opt_z);

# Check that binary exists 
unless (-e $opt_z) {
        print "CRITICAL: ZMStatus not found - $opt_z\n";
        exit 2;
}

# open "zmcontrol status" command
open(ZMCONTROL, "sudo -u ".$opt_u." $opt_z status |") || die('zmcontrol not found');
my @zmcontent = <ZMCONTROL>;
close(ZMCONTROL);

my $i;
# parse every line exept the first
for ($i=1; $i<@zmcontent;$i++) {
        if  ($zmcontent[$i] =~ s/^\s+([a-zA-Z]+[\ ][a-zA-Z]+)[\s]+([a-zA-Z]+)//g) {
                if ($2 ne "Running") {
                        push @failed_services, $1;
                }
        }
}

# $i tells if services where checked
if (( @failed_services == 0 ) && ($i > 5)) {
        print "OK: every service is running fine\n";
        exit 0; # OK
} else {
        print "Critical: ";
        foreach my $service (@failed_services) {
                print $service . " ";
        }
        print "not running"; 
        exit 2; # Error
}        

sub print_usage () {
        print "Usage:\n";
        print "  $PROGNAME [-u username] [-b zmstatuspath]\n";
        print "  $PROGNAME [-h | --help]\n";
}

sub print_help () {
        print "Copyright (c) 2008 Andreas Roth\n\n";
        print_usage();
        print "\n";
        print "  <username>  username for zimbrauser - be aware of setting up sudo before (default: zimbra)\n";
        print "  <zmstatuspath>  Path where zmcontrol command is found (default: /opt/zimbra/bin/zmcontrol)\n";
        print "\n";
}