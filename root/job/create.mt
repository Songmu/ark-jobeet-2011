? extends 'common/jobs_base';

? block content => sub {

<h1>New Job</h1>

<form method="post">
<?= $c->stash->{form}->render ?>
<input type="submit" value="Preview your job" />
</form>

? } # endblock content
