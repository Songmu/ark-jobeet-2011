package Jobeet;
use Ark;

use_model 'Jobeet::Models';
our $VERSION = '0.01';

config 'View::MT' => {
    use_cache => 1,

    macro => {
        stash => sub {
            __PACKAGE__->context->stash;
        },
    },
};

config 'Plugin::Session::Store::Model' => {
    model => 'session',
};

config 'Plugin::PageCache' => {
    model => 'cache',
};

config 'Plugin::Session' => {
    expires => '+30d',
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
