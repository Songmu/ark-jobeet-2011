my $home = Jobeet::Models->get('home');

return {
    default_view    => 'MT',
    active_days     => 30,
    database => [
        'dbi:SQLite:' . $home->file('database.db'), '', '',
         {
             sqlite_unicode => 1,
         },
    ],
};
