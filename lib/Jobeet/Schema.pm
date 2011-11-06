package Jobeet::Schema;
use strict;
use warnings;
use base 'DBIx::Class::Schema';
use DateTime;

our $VERSION = '3';

__PACKAGE__->load_namespaces;

__PACKAGE__->load_components('Schema::Versioned');
__PACKAGE__->upgrade_directory('sql/');

my $TZ = DateTime::TimeZone->new(name => 'Asia/Tokyo');
sub TZ {$TZ}

sub now {
    return DateTime->now(time_zone => $TZ);
}

1;
