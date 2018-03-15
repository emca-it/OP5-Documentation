#!/usr/bin/perl

$MSEND='/opt/plugins/custom/msend';
$COMMANDLINE='-n BMCIS02 -n @bmcis02:1828#mc -a OP5_EVENT -b ';

sub readconfig {
my($configfile)=@_;
open(CFG, "<$configfile");

foreach $cfg (<CFG>){
	chomp($cfg);
	$cfg=~s/#.*$//g;
	if(length($cfg)>1){
		($key, $value)=split(/=/, $cfg);
		if(length($value)>0){
			$config{$key}=$value;
		}
	}
}
	return %config;
}

%config=readconfig("monitor-bmc.conf");
$arg=pop(@ARGV);
$ARGS="$arg";
foreach $arg (@ARGV) {
	$ARGS="$arg;$ARGS";
}

#`echo "$MSEND" "$COMMANDLINE" "$ARGS" >> /tmp/msend.log`;
`$MSEND $COMMANDLINE \"$ARGS\" &`;
