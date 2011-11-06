package Jobeet::Controller::Category;
use Ark 'Controller';

use Jobeet::Models;

sub show :Path :Args(1) {
    my ($self, $c, $category_name) = @_;

    my $category = models('Schema::Category')->find({ slug => $category_name })
        or $c->detach('/default');

    $c->stash->{category} = $category;
}

1;
