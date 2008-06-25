package Shell::Amazon::S3::ConfigLoader;
use Moose;

use YAML;
use File::HomeDir;
use Path::Class qw(file);
use ExtUtils::MakeMaker;

has conf => (
    is      => 'ro',
    default => sub { file( File::HomeDir->my_home, ".psh3ll" ) },
);

sub load {
    my $self = shift;
    my $config = eval { YAML::LoadFile( $self->conf ) } || {};
    $config->{aws_access_key_id}     ||= prompt("AWS access key:");
    $config->{aws_secret_access_key} ||= prompt("AWS secret access key:");
    return $config;
}

sub save {
    my ( $self, $conf ) = @_;
    YAML::DumpFile( $self->conf, $conf );
    chmod 600, $self->conf;
}

__PACKAGE__->meta->make_immutable;

1;
