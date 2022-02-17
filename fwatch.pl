#! /usr/bin/env perl

use utf8;
use Encode;
use 5.18.0;
use Watchdog;

my $guard = Watchdog->new( filename => './file.txt' );
