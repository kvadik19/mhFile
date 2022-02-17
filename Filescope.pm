package Filescope;

# FileIO test exercise by mac-t@yandex.ru
# Used 4 chars tab size

use Time::HiRes;
use Fcntl qw(:seek);

sub new {
	my $class = shift;
	my $init = { @_ };

	die "Need Filename to watch" unless $init->{'filename'};
	die "Cannot read $init->{'filename'}" unless -f( $init->{'filename'}) && -r( $init->{'filename'});
	open( my $fh, "< $init->{'filename'}") || die "Cannot open $init->{'filename'}";

	my $self = bless( $init, $class);
	$self->{'fh'} = $fh;

	return $self;
}
#############
sub size {	#	Optional functionality
#############
	my $self = shift;
	$self->content;		# Update, if outdated
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
		seek( $self->{'fh'}, 0, SEEK_SET);
		sysread( $self->{'fh'}, $self->{'content'}, $self->{'size'});
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
