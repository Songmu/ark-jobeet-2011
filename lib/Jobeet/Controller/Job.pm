package Jobeet::Controller::Job;
use Ark 'Controller';

use Jobeet::Models;

with 'Ark::ActionClass::Form';

sub index :Path {
    my ($self, $c) = @_;

    $c->stash->{categories} = models('Schema::Category')->get_with_jobs;
}

# /job/{job_id} （詳細）
sub show :Path :Args(1) {
    my ($self, $c, $job_id) = @_;
}

# /job/create （新規作成）
sub create :Local :Form('Jobeet::Form::Job') {
    my ($self, $c) = @_;

    $c->stash->{form} = $self->form;
}

sub job :Chained('/') :PathPart :CaptureArgs(1) {
    my ($self, $c, $job_id) = @_;
    $c->stash->{job_id} = $job_id;
}

# /job/{job_id}/edit （編集）
sub edit :Chained('job') :PathPart :Args(0) {
    my ($self, $c) = @_;
}

# /job/{job_id}/delete （削除）
sub delete :Chained('job') :PathPart :Args(0) {
    my ($self, $c) = @_;
}

1;
