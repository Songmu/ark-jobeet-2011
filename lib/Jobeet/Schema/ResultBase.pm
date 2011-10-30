package Jobeet::Schema::ResultBase;
use strict;
use warnings;

use DateTime;

use base 'DBIx::Class';

__PACKAGE__->load_components(qw/InflateColumn::DateTime Core/);

sub insert {
    my $self = shift;

    my $now = Jobeet::Schema->now;
    $self->created_at( $now ) if $self->can('created_at');
    $self->updated_at( $now ) if $self->can('updated_at');

    $self->next::method(@_);
}

sub update {
    my $self = shift;

    if ($self->can('updated_at')) {
        $self->updated_at( Jobeet::Schema->now );
    }

    $self->next::method(@_);
}
1;
