#! /usr/bin/perl
use strict;
use warnings;
use Getopt::Long;
use LWP::UserAgent;

my $domain; # domain provided to the command line arg
my $sleep = 1;

GetOptions("domain=s"   => \$domain,
	   "sleep=i"    => \$sleep)
or die ("Error in command line arguments\n");

my $filename = './vectors.txt'; # TODO: make this modifiable

open( FH, '<', $filename) or die $!;

my $ua = LWP::UserAgent->new(ssl_opts => { verify_hostname => 0 });
my $response;
my @success_vectors;
while ( <FH> ) {
    $response = $ua->post($domain . $_);
    if ($response->is_success) {
        print "success with vector: " . $_;
    }
    else { print "Tried and failed with vector: " . $_; }
    sleep($sleep);
}
close (FH);

