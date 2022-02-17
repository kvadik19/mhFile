#! /usr/bin/env perl

use utf8;
use Encode;
use 5.18.0;
use Watchdog;

my $guard = Watchdog->new( filename => 'file.txt' );	# '/var/www/atk/log/drive.log'

while (1) {
	my $content = $guard->content;
	say $content;
	sleep(1);
}
