package Shell::Amazon::S3::Command::quit;
use Moose;

extends 'Shell::Amazon::S3::Command';

sub parse_tokens {
    my ($self, $token) = @_;
    return $token;
}

sub execute {
    my ($self, $args) = @_;
    return 'EXIT';
}

1;
