package Watchdog;

use Time::HiRes;
use Fcntl qw(:flock :seek);

use Data::Dumper;

sub new {
	my $class = shift;
	my $init = { @_ };
	die "Need Filename to watch" unless $init->{'filename'};

	my $self = bless( $init, $class);

	die "Cannot read $init->{'filename'}" unless -f( $init->{'filename'}) && -r( $init->{'filename'});

	open( $self->{'fh'}, "< $init->{'filename'}") || die "Cannot open $init->{'filename'}";

	$self->content;
	return $self;
}
#############
sub size {	#	Optional functionality
#############
	my $self = shift;
	$self->content;
	return $self->{'size'};
}
#############
sub content {
#############
	my $self = shift;
	my $stat = [stat( $self->{'fh'})];
	if ( $self->{'mtime'} != $stat->[9] ) {
		$self->{'mtime'} = $stat->[9];
		$self->{'size'} = $stat->[7];
		$self->{'blksize'} = $stat->[10];
		seek( $self->{'fh'}, 0, SEEK_SET);
		sysread( $self->{'fh'}, $self->{'content'}, $self->{'blksize'});
	}
	return $self->{'content'};
}
#############
sub close {
#############
	my $self = shift;
	return $self->DESTROY;
}
#############
sub DESTROY {
#############
	my $self = shift;
	close( $self->{'fh'});
	return undef $self;
}

1;
