#!/usr/bin/env perl

use strict;
use warnings;
use FindBin::libs;
use Path::Class qw/file/;

use Jobeet::Models qw/M/;
use Getopt::Long;
use Pod::Usage;

=DESCRIPTION

Schema/ 以下を見てSQLを吐き出すスクリプト

=head1 SYNOPSIS

    script/create_ddl.pl -p 1 --replace-version

     Options:
       -help            brief help message
       preversion       create DDL for diff from $preversion to current_version (optional)
       replace-version  replace $VERSION in MyApp::Schema (optional)

=cut

my ($preversion, $help, $replace_version);
GetOptions(
    'h|help'          => \$help,
    'p|preversion=i'  => \$preversion,
    'replace-version' => \$replace_version,
) or die pod2usage;
pod2usage(1) if $help;

my $schema = M('Schema');

my $current_version = $schema->schema_version;
my $next_version    = $current_version + 1;
$preversion       ||= $current_version;

warn "current  version: $current_version\n";
warn "db       version: ".$schema->get_db_version ."\n";
warn "ddl from version: ".$preversion ."\n";
warn "      to version: ".$next_version ."\n";

$schema->create_ddl_dir(
    [qw/MySQL SQLite/],
    $next_version,
    "$FindBin::Bin/../../sql/",
    $preversion,
    +{
        parser      => 'SQL::Translator::Parser::DBIx::Class',
        parser_args => {
            quote_field_names => 1,
        },
    }
);

if ( $replace_version ) {
    # replace version
    my $f = file( $INC{'Jobeet/Schema.pm'} );
    my $content = $f->slurp;
    $content =~ s/(\$VERSION\s*=\s*(['"]?))(.+?)\2/$1$next_version$2/
        or die "Failed to replace version.";

    my $fh = $f->openw or die $!;
    print $fh $content;
    $fh->close;
}
