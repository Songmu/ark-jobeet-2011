? my $category = $c->stash->{category};

? extends 'common/jobs_base';

? block stylesheets => sub {
<link rel="stylesheet" type="text/css" href="<?= $c->uri_for('/css/main.css') ?>" />
<link rel="stylesheet" type="text/css" href="<?= $c->uri_for('/css/jobs.css') ?>" />
? }

? block title => sub { sprintf 'Jobs in the %s category', $category->name };

? block content => sub {
<div class="category">
  <div class="feed">
    <a href="">Feed</a>
  </div>
  <h1><?= $category->name ?></h1>
</div>

?= include('job/_partial_jobs', $category->get_active_jobs);

? } # endblock content
