? my $job = $c->stash->{job};

? extends 'common/base';

? block stylesheets => sub {
<link rel="stylesheet" type="text/css" href="<?= $c->uri_for('/css/main.css') ?>" />
<link rel="stylesheet" type="text/css" href="<?= $c->uri_for('/css/job.css') ?>" />
? }

? block content => sub {

<div id="job">
  <h1><?= $job->company ?></h1>
  <h2><?= $job->location ?></h2>
  <h3>
    <?= $job->category ?>    <small> - <?= $job->type ?></small>
  </h3>

  <div class="description">
    <?= $job->description ?>
  </div>

  <h4>How to apply?</h4>

  <p class="how_to_apply"><?= $job->how_to_apply ?></p>

  <div class="meta">
    <small>posted on <?= $job->created_at->ymd ?></small>
  </div>
</div>

? } # endblock content
