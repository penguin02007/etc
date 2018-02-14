#! /usr/bin/env perl
use v5.014;
use Net::SSH::Perl;

for my $ip ( 137..138 ) {
    my $ssh = Net::SSH::Perl->new("172.20.230.137");
    $ssh->login("root", "calvin");
    my $idrac_cmd = "racadm racdump";
    my($stdout, $stderr, $exit) = $ssh->cmd("$idrac_cmd");
    while ($stdout =~ m/MAC|Ethernet/) {
        say $_;
    }
}
