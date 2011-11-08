package Jobeet;
use Ark;

use_model 'Jobeet::Models';
our $VERSION = '0.01';

use Data::Page::Navigation;

use_plugins qw{
    Session
    Session::State::Cookie
    Session::Store::Model
};

config 'View::MT' => {
    use_cache => 1,

    macro => {
        stash => sub {
            __PACKAGE__->context->stash;
        },
    },
};

config 'Plugin::Session' => {
    expires => '+30d',
};

config 'Plugin::Session::State::Cookie' => {
    cookie_name => 'jobeet_session',
};

config 'Plugin::Session::Store::Model' => {
    model => 'cache',
};

1;
__END__

=head1 NAME

Jobeet -

=head1 SYNOPSIS

use Jobeet;

=head1 DESCRIPTION

Jobeet is

=head1 AUTHOR

Songmu E<lt>y.songmu@gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
