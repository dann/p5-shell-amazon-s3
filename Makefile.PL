use inc::Module::Install;
name 'Shell-Amazon-S3';
all_from 'lib/Shell/Amazon/S3.pm';

requires $_ for (qw/ /);

build_requires 'Test::More';
use_test_base;
auto_include;
WriteAll;
