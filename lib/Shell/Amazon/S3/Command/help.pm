package Shell::Amazon::S3::Command::help;
use Moose;

extends 'Shell::Amazon::S3::Command';

override 'validate_tokens', sub {
    my ( $self, $tokens ) = @_;
    if ( @{$tokens} != 0 ) {
        return ( 0, "error: This command doesn't need arguments" );
    }
    return ( 1, "" );
};

override 'parse_tokens', sub {
    my ( $self, $tokens ) = @_;
    return $tokens;
};

sub execute {
    my ( $self, $args ) = @_;

    my $result = '';
    $result .= "bucket [bucketname]\n";
    $result .= "count [prefix]\n";
    $result .= "createbucket\n";
    $result .= "delete <id>\n";
    $result .= "deleteall [prefix]\n";
    $result .= "deletebucket\n";
    $result .= "exit\n";
    $result .= "get <id>\n";
    $result .= "getacl ['bucket'|'item'] <id>\n";
    $result .= "getfile <id> <file>\n";
    $result .= "gettorrent <id>\n";
    $result .= "head ['bucket'|'item'] <id>\n";
    $result .= "host [hostname]\n";
    $result .= "list [prefix] [max]\n";
    $result .= "listatom [prefix] [max]\n";
    $result .= "listrss [prefix] [max]\n";
    $result .= "listbuckets\n";
    $result .= "pass [password]\n";
    $result .= "put <id> <data>\n";
    $result .= "putfile <id> <file>\n";
    $result
        .= "putfilewacl <id> <file> ['private'|'public-read'|'public-read-write'|'authenticated-read']\n";
    $result .= "quit\n";
    $result
        .= "setacl ['bucket'|'item'] <id> ['private'|'public-read'|'public-read-write'|'authenticated-read']\n";
    $result .= "user [username]\n";

    return $result;
}

1;
