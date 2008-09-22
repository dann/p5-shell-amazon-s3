use strict;
use warnings;
use Test::More tests => 1;    # last test to print

BEGIN { use_ok 'Shell::Amazon::S3' }

my $username = $ENV{S3_TEST_AWS_ACCESS_KEY_ID};
my $password = $ENV{S3_TEST_AWS_SECRET_ACCESS_KEY};
if ( $username && $password ) {
    plan tests => 3;
}
else {
    plan skip_all => "Set ENV:S3_TEST_USERNAME/PASSWORD/GROUP";
}

