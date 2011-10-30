#!/usr/bin/env perl
use strict;
use warnings;
use utf8;
use FindBin::libs;
use autodie;
use Jobeet::Models;

use Text::MicroTemplate::DataSectionEx;
use String::CamelCase qw/decamelize/;
use Getopt::Long;
use Pod::Usage;

=head1 SYNOPSIS

    script/dev/ark.pl controller Controller::Name
    script/dev/ark.pl schema TableName
    script/dev/ark.pl script batch/name

    Options:
       -help    brief help message

=cut

my $help;
GetOptions('h|help' => \$help);
pod2usage(1) if $help;

my ($type, $name) = @ARGV;
pod2usage(1) if !$name;

my $config = +{
    controller  => {
        dirs  => [qw/lib Jobeet Controller/],
    },
    schema      => {
        dirs => [qw/lib Jobeet Schema Result/],
    },
    script  => {
        dirs  => [qw/script/],
        ext     => 'pl',
    },
}->{$type};

die "no definition for $type" unless $config;

my @dirs = @{$config->{dirs}};
my $ext = $config->{ext} || 'pm';


my $decamelized = decamelize($name);
$decamelized =~ s!::!/!g;

my $params = +{
    name        => $name,
    decamelized => $decamelized,
};

my $template = Text::MicroTemplate::DataSectionEx->new(
    template_args => $params,
)->render_mt($type);

my @file_dirs = split m!(?:(?:::)|/)!, $name;
my $file = pop @file_dirs;
$file .= ".$ext";
push @dirs, @file_dirs;

my $dir = models('home')->subdir(@dirs);
$dir->mkpath unless -d $dir;
$dir->file($file)->openw->write($template);

__DATA__

@@ controller.mt
package Jobeet::Controller::<?= $name ?>;
use Ark 'Controller';

use Jobeet::Models;
has '+namespace' => default => '<?= $decamelized ?>';

sub auto :Private {
    1;
}

sub index :Path :Args(0) {
    my ($self, $c) = @_;
}

1;

@@ schema.mt
package Jobeet::Schema::Result::<?= $name ?>;

use strict;
use warnings;
use utf8;
use base qw/Jobeet::Schema::ResultBase/;

use Jobeet::Models;

__PACKAGE__->table('<?= $decamelized ?>');
__PACKAGE__->add_columns(
    id => {
        data_type   => 'INTEGER',
        is_nullable => 0,
        extra => {
            unsigned => 1,
        },
    },
);

sub sqlt_deploy_hook {
    my ($self, $sqlt_table) = @_;
    # $sqlt_table->add_index( fields => [qw//]);
    $self->next::method($sqlt_table);
}

__PACKAGE__->set_primary_key('id');

1;

@@ script.mt
#!/usr/bin/env perl
use strict;
use warnings;
use FindBin::libs;

use Jobeet::Models;
use Getopt::Long;
use Pod::Usage;

local $| = 1;

=head1 DESCRIPTION


=head1 SYNOPSIS

    script/<?= $name ?>.pl

    Options:
       -help            brief help message

=cut

my $help;
GetOptions(
    'h|help'          => \$help,
) or die pod2usage;
pod2usage(1) if $help;

1;
