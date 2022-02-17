package Fwatch;

use POE;
use Fcntl qw(:flock :seek);

sub new {
	my $class = shift;
	my $init = { @_ };
	die "Need Filename to watch" unless $init->{'filename'};

	my $self = bless( $init, $class);

	die "Cannot read" unless -f( $init->{'filename'}) && -r( $init->{'filename'});
	
	$self->{'fh'} = open( "< $init->{'filename'}");
	return $self;
}

sub DESTROY {
	my $self = shift;
	close( $self->{'fh'});
	return undef $self;
}

1;