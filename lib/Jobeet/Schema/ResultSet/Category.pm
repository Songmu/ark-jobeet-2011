package Jobeet::Schema::ResultSet::Category;
use strict;
use warnings;
use utf8;
use parent 'DBIx::Class::ResultSet';

use Jobeet::Models;

sub get_with_jobs {
    my $self = shift;

    $self->search(
        { 'jobs.expires_at' => { '>=', models('Schema')->now } },
        { join => 'jobs', group_by => 'me.name' },
    );
}

1;
