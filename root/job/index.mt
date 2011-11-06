? extends 'common/base';

? block stylesheets => sub {
<link rel="stylesheet" type="text/css" href="<?= $c->uri_for('/css/main.css') ?>" />
<link rel="stylesheet" type="text/css" href="<?= $c->uri_for('/css/jobs.css') ?>" />
? }

? block content => sub {
<div id="jobs">
? for my $category ($c->stash->{categories}->all) {
    <div class="category_<?= lc $category->name ?>">
      <div class="category">
        <div class="feed">
          <a href="">Feed</a>
        </div>
        <h1>
          <a href="<?= $c->uri_for('/category', $category->slug) ?>">
            <?= $category->name ?>
          </a>
        </h1>
      </div>

      <table class="jobs">
? my $i = 0;
? my $max_rows = $c->config->{max_jobs_on_homepage};
? for my $job ($category->get_active_jobs({ rows => $max_rows })) {
          <tr class="<?= $i++ % 2 ? 'even' : 'odd' ?>">
            <td class="location">
              <?= $job->location ?>
            </td>
            <td class="position">
              <?= $job->position ?>
            </td>
            <td class="company">
              <?= $job->company ?>
            </td>
          </tr>
? } #endfor $job
      </table>

    ? my $count = $category->get_active_jobs->count;
    ? if ( (my $rest = $count - $max_rows) > 0 ) {
          <div class="more_jobs">
            and <a href="<?= $c->uri_for('/category', $category->slug) ?>"><?= $rest ?></a>
            more...
          </div>
    ? } # endif
    </div>
? } #endfor $category
</div>
? } #endblock content
