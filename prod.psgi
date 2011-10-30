use lib 'lib';

use Plack::Builder;
use Jobeet;
use Jobeet::Models;

my $app = Jobeet->new;
$app->setup;

# preload models
my $models = Jobeet::Models->instance;
$models->load_all;

my $app = Jobeet->new;
builder {
    $app->handler;
};
