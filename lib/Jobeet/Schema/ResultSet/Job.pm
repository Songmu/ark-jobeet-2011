package Jobeet::Schema::ResultSet::Job;
use strict;
use warnings;
use utf8;
use parent 'DBIx::Class::ResultSet';

use Jobeet::Models;

sub create_from_form {
    my ($self, $form) = @_;

    my $txn_guard = $self->result_source->schema->txn_scope_guard;

    my $category_id = delete $form->params->{category};
    my $category = models('Schema::Category')->find({ slug => $category_id })
        or die 'no such category_id: ', $category_id;

    my $job = $self->create({
        category_id => $category_id,
        %{ $form->params },
    });

    $txn_guard->commit;

    $job;
}

1;
