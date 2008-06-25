package Shell::Amazon::S3::Command;
use Moose;
use MooseX::ClassAttribute;
use Net::Amazon::S3;
use Shell::Amazon::S3::ConfigLoader;

class_has 'bucket_name_' => (
    is  => 'rw',
    isa => 'Str',
);

class_has 'api_' => (
    is       => 'rw',
    required => 1,
    default  => sub {
        my $config_loader = Shell::Amazon::S3::ConfigLoader->new;
        my $config        = $config_loader->load;
        my $api           = Net::Amazon::S3->new(
            {   aws_access_key_id     => $config->{aws_access_key_id},
                aws_secret_access_key => $config->{aws_secret_access_key},
            }
        );
        $api;

    }
);

# template method
sub do_execute {
    my ( $self, $tokens ) = @_;
    my ($is_success, $message) = $self->validate_tokens($tokens);
    return $message unless $is_success;

    my $args = $self->parse_tokens($tokens);
    $self->execute($args);
}

sub validate_tokens {
    my ( $self, $tokens ) = @_;
    die 'virtual method';
}

sub parse_tokens {
    my ( $self, $tokens ) = @_;
    die 'virtual method';
}

sub set_bucket_name {
    my ( $self, $bucket_name ) = @_;
    Shell::Amazon::S3::Command->bucket_name_($bucket_name);
}

sub get_bucket_name {
    Shell::Amazon::S3::Command->bucket_name_;
}

sub api {
    Shell::Amazon::S3::Command->api;
}

sub bucket {
    my ($self) = shift;
    my $bucket = __PACKAGE__->api_->bucket( $self->get_bucket_name );
    $bucket;
}

__PACKAGE__->meta->make_immutable;

1;
