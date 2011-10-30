#!/usr/bin/env perl

use strict;
use warnings;

use FindBin::libs;
use Path::Class 'file';

use Getopt::Long;
use IO::Prompt qw/prompt/;

my ($help, $dry_run, $test_db, $drop_table);
GetOptions(
    'h|help'  => \$help,
    'dry-run' => \$dry_run,
    'test-db' => \$test_db,
    'drop-table' => \$drop_table,
) or usage();
exit usage() if $help;

use SQL::Translator;
use SQL::Translator::Diff;

#local $ENV{ DBIC_TRACE } = 1;

use Jobeet::Models qw/M/;

if ( $test_db ) {
    require Jobeet::Test;
    Jobeet::Test->import;
}
my $schema = M('Schema');

my $current_version = $schema->get_db_version;
my $schema_version  = $schema->schema_version;
my $dir             = $schema->upgrade_directory;

print "current_version: $current_version\n";
print "schema_version:  $schema_version\n";
print "dir:             $dir\n";

my $sqltargs = {
    add_drop_table          => 1,
    ignore_constraint_names => 1,
    ignore_index_names      => 1,
};

sub parse_sql {
    my ($file, $type) = @_;

    my $t = SQL::Translator->new($sqltargs);

    $t->parser($type)
        or die $t->error;

    my $out = $t->translate("$file")
        or die $t->error;

    my $schema = $t->schema;

    $schema->name( $file->basename )
        unless ( $schema->name );

    $schema;
}

no warnings 'redefine', 'once';
my $upgrade_file;
local *Jobeet::Schema::create_upgrade_path = sub {
    $upgrade_file = $_[1]->{upgrade_file};

    my $current_version = $schema->get_db_version;
    my $schema_version  = $schema->schema_version;
    my $database        = $schema->storage->sqlt_type;
    my $dir             = $schema->upgrade_directory;

    my $prev_file = $schema->ddl_filename($database, $current_version, $dir);
    my $next_file = $schema->ddl_filename($database, $schema_version, $dir);

    my $current_schema = eval { parse_sql file($prev_file), $database } or die $@;
    my $next_schema    = eval { parse_sql file($next_file), $database } or die $@;

    my $diff = SQL::Translator::Diff::schema_diff(
        $current_schema, $database,
        $next_schema, $database,
        $sqltargs,
    );

    if ($upgrade_file) {
        my $fh = file($upgrade_file)->openw or die $!;
        print $fh $diff;
        $fh->close;
    }
    else {
        print $diff;
    }
};

if ($dry_run) {
    $schema->create_upgrade_path;
    exit;
}

if ($drop_table) {
    exit unless prompt('drop table ok?[yn] ', '-y');
    $schema->deploy({add_drop_table => 1 });
    $schema->_set_db_version({version => $schema_version});
}
elsif (my $version = $schema->get_db_version) {
    $schema->upgrade;
    unlink $upgrade_file if $upgrade_file;
}
else {
    $schema->deploy;
}

sub usage {
    warn "see code\n";
}
