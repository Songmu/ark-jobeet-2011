<!DOCTYPE html>
<html lang="en">
  <head>
    <title><? block title => sub { 'Jobeet - Your best job board' } ?></title>
    <link rel="shortcut icon" href="/favicon.ico" />
    <link rel="alternate" type="application/atom+xml" title="Latest Jobs"
        href="<?= $c->uri_for('/job/atom') ?>" />
    <? block javascripts => '' ?>
    <? block stylesheets => '' ?>
  </head>
  <body>
    <div id="container">
      <div id="header">
        <div class="content">
          <h1><a href="<?= $c->uri_for('/') ?>">
            <img src="/images/logo.jpg" alt="Jobeet Job Board" />
          </a></h1>
 
          <div id="sub_header">
            <div class="post">
              <h2>Ask for people</h2>
              <div>
                <a href="<?= $c->uri_for('/job/create') ?>">Post a Job</a>
              </div>
            </div>
 
            <div class="search">
              <h2>Ask for a job</h2>
              <form action="" method="get">
                <input type="text" name="keywords"
                  id="search_keywords" />
                <input type="submit" value="search" />
                <div class="help">
                  Enter some keywords (city, country, position, ...)
                </div>
              </form>
            </div>
          </div>
        </div>
      </div>
 
? my @history = @{ $c->session->get('job_history') || [] };
? if (@history) {
      <div id="job_history">
        Recent viewed jobs:
        <ul>
? my $i = 0;
? for my $job (@history) {
          <li>
            <?= $job->{position} ?> - <?= $job->{company} ?>
          </li>
? last if ++$i == 3;
? } # endfor $job
        </ul>
      </div>
? } # endif @history
 
      <div id="content">
        <div class="content">
? block content => '';
        </div>
      </div>
 
      <div id="footer">
        <div class="content">
          <span class="symfony">
            <img src="/images/jobeet-mini.png" />
            powered by <a href="http://opensource.kayac.com/projects/ark/">Ark</a>
          </span>
          <ul>
            <li><a href="">About Jobeet</a></li>
            <li class="feed">
              <a href="<?= $c->uri_for('/job/atom') ?>">Full feed</a>
            </li>
            <li><a href="">Jobeet API</a></li>
            <li class="last"><a href="">Affiliates</a></li>
          </ul>
        </div>
      </div>
    </div>
  </body>
</html>
