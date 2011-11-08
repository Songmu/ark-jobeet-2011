package Jobeet::View::MT;
use Ark 'View::MT';

use Digest::SHA1 ();

has '+macro' => default => sub {
    return {
        sha1_hex => \&Digest::SHA1::sha1_hex,
    },
};

__PACKAGE__->meta->make_immutable;
