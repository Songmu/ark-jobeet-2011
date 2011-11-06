package Jobeet::Controller::Category;
use Ark 'Controller';

use Jobeet::Models;

sub index :Path :Args(0) {
    my ($self, $c, $category_name) = @_;
}

1;
