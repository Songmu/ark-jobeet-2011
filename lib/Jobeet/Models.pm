package Jobeet::Models;
use strict;
use warnings;
use Ark::Models '-base';

use Module::Find;

register Schema => sub {
    my $self = shift;

    my $conf = $self->get('conf')->{database}
        or die 'require database config';

    $self->ensure_class_loaded('Jobeet::Schema');
    Jobeet::Schema->connect(@$conf);
};

my @modules = Module::Find::findallmod('Jobeet::Schema::Result');
for my $module (@modules) {
    $module =~ s/Jobeet::Schema::Result:://;
    register "Schema::${module}" => sub {
        shift->get('Schema')->resultset($module);
    };
}

register cache => sub {
    my $self = shift;

    my $conf = $self->get('conf')->{cache}
        or die 'require cache config';

    $self->ensure_class_loaded('Cache::FastMmap');
    Cache::FastMmap->new(%$conf);
};

1;
