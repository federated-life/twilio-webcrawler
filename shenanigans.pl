#!/usr/bin/perl

use WWW::Mechanize;
use strict;
use warnings;


my $baseurl = "http://twilio.com";
open(STDERR, ">/dev/null");

my $mech = WWW::Mechanize->new();
$mech->timeout(30);
$mech->agent_alias( 'Windows IE 6'  );
$mech->get($baseurl);

my $content = $mech->content();
my $count = 0;

while ( $content =~ s/[Ss]henanigans// )
{
	$count++;
}

my @subdirs = ();
my @links = $mech->links();

foreach (@links)
{
	my $url = $_->url_abs();
	
	if ($url =~ /www\.twilio.com\//)
	{
		@subdirs = (@subdirs, $url);
	}
}

foreach (@subdirs)
{
	printf("crawling:\t%s\n", $_);
	$mech->get($_);
	$content = $mech->content();
	
	while ( $content =~ s/[Ss]henanigans// )
	{
		$count++;
	}
	
}

printf("$count instances of shenanigans.\n");
my $end = <>;
