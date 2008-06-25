use inc::Module::Install;
name 'Shell-Amazon-S3';
all_from 'lib/Shell/Amazon/S3.pm';

requires $_
    for (
    qw/
    File::HomeDir
    File::Slurp
    FindBin::libs
    Module::Find
    Moose
    Moose::Role
    MooseX::ClassAttribute
    Net::Amazon::S3
    Path::Class
    Perl6::Say
    Scalar::Util
    Term::ANSIColor
    Term::ReadLine
    YAML
    namespace::clean
    MooseX::ClassAttribute
    /
    );

build_requires 'Test::More';
use_test_base;
auto_include;
WriteAll;
