? my @jobs = $c->stash->{jobs}->all;
? if (@jobs) {
?= include('job/_partial_jobs', @jobs );
? } else {
No results.
? }
