package Shell::Amazon::S3;
use Term::ReadLine;
use Moose;
use namespace::clean -except => ['meta'];
use Shell::Amazon::S3::CommandDispatcher;
use Data::Dumper;

our $VERSION = '0.01';

with 'MooseX::Object::Pluggable';

has 'term' => (
    is       => 'rw',
    required => 1,
    default  => sub { Term::ReadLine->new('Amazon S3 shell') }
);

has 'prompt' => (
    is       => 'rw',
    required => 1,
    default  => sub {'psh3ll> '}
);

has 'out_fh' => (
    is       => 'rw',
    required => 1,
    lazy     => 1,
    default  => sub { shift->term->OUT || \*STDOUT; }
);

has 'dispatcher' => (
    is       => 'rw',
    required => 1,
    default  => sub { Shell::Amazon::S3::CommandDispatcher->new }
);

sub run {
    my ($self) = @_;
    while ( $self->run_once ) {

        # keep looping
    }
}

sub run_once {
    my ($self) = @_;
    my $line = $self->read;
    return unless defined($line);    # undefined value == EOF
    my @ret = $self->eval($line);
    eval { $self->print(@ret); };
    if ($@) {
        my $error = $@;
        eval { $self->print("Error printing! - $error\n"); };
    }
    return 1;
}

sub read {
    my ($self) = @_;
    return $self->term->readline( $self->prompt );
}

sub eval {
    my ( $self,    $line ) = @_;
    my ( $command, $args ) = $self->parse_input($line);
    return unless defined($command);
    my @ret = $self->execute( $command, $args );
    return @ret;
}

sub parse_input {
    my ( $self, $line ) = @_;
    my @tokens = split( /\s/, $line );
    return unless @tokens >= 1;
    my $command = shift @tokens;
    return ( $command, \@tokens );
}

sub execute {
    my ( $self, $command, $args ) = @_;
    my $result = eval { $self->dispatcher->dispatch( $command, $args ); };
    return $self->error_return( "Runtime error", $@ ) if $@;
    return $result;
}

sub error_return {
    my ( $self, $type, $error ) = @_;
    return "${type}: ${error}";
}

sub print {
    my ( $self, $result ) = @_;
    my $fh = $self->out_fh;
    no warnings 'uninitialized';
    print $fh "$result";
    print $fh "\n" if $self->term->ReadLine =~ /Gnu/;
}

1;

__END__

=head1 NAME

Shell::Amazon::S3 - Shell for Amazon S3

=head1 SYNOPSIS

  use Shell::Amazon::S3;

=head1 DESCRIPTION

Shell::Amazon::S3 is 

=head1 AUTHOR

dann E<lt>techmemo@gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
