? extends 'common/jobs_base';

? block content => sub {

<div id="jobs">
?= include('job/_partial_jobs', $c->stash->{jobs}->all );
</div>

? } # endblock content

