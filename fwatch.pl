#! /usr/bin/env perl

use utf8;
use Encode;
use 5.18.0;
use Filescope;

my $spydog = Filescope->new( filename => 'file.txt' );

say 'Ctrl+C will stop.';

my $cache;
while (1) {
	my $content = $spydog->content;
	if ( $content ne $cache ) {
		say $content;
		$cache = $content;
	}
	sleep(1);
}
