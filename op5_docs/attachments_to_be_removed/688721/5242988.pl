#!/usr/bin/perl
#
# check_file_exists.pl
#
# Checks if a file exists.
#
# Author: Hugo Hallqvist <hugo@op5.se>

use POSIX;
use lib "/opt/plugins";
use utils qw($TIMEOUT %ERRORS); # Import predefined status-codes and timeout variable

sub print_usage() {	
	print "Usage: check_file_exists -f <filename> [-t <timeout>]\n";
}

sub print_help() {
	print_usage();
	print "\n";
	print "Options:\n";
	print "-f|--filename (string)\n";
	print "  set the filename to check for existance\n";
	print "\n";
}

for($i = 0; $i < $#ARGV; $i++) {
	if($ARGV[$i] =~ /^-h|^--help/) { # Help argument
		print_help();
		exit($ERRORS{"OK"});
	}
	elsif($ARGV[$i] =~ /^-f|^--filename/) { # filename argument
		$i++;
		$filename = $ARGV[$i];
	}
    elsif($ARGV[$i] =~ /^-t|^--timeout/) { # timeout argument
		$i++;
		$TIMEOUT = $ARGV[$i];
	}
	else {	# Unknown argument, print help
		print_usage();
		exit($ERRORS{"UNKNOWN"});
	}
}

if (!defined($filename)) {
	# No filename was given.
	print_usage();
	exit($ERRORS{"UNKNOWN"});
}

# Timeout handler used
$SIG{'ALRM'} = sub {
	print "CRITICAL: Plugin timed out after $TIMEOUT seconds\n";
	exit($ERRORS{'CRITICAL'});
};

# Install timeout handler, so that the plugin does not hang indefinitely.
alarm($TIMEOUT);

if (-f $filename) {
	print "OK - Filename $filename exists.\n";
	exit($ERRORS{"OK"});
} else {
	print "CRITICAL - Filename $filename does not exist.\n";
	exit($ERRORS{"CRITICAL"});
}
