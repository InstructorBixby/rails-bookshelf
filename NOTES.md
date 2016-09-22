heroku
------

the push kept dying in `rake assets:precompile` with "could not connect
to server". turns out precompile boots the app, the app wants a
database, and the database is not attached during the build. adding
rails_12factor and setting `config.assets.compile = false` sorted it
out, plus `config.serve_static_files` so puma will actually serve the
compiled files.

    heroku run rake db:migrate
    heroku run rake db:seed

if the dyno 500s, `heroku logs --tail` and look for the
ActionView::Template::Error line, not the big stack after it.

spring
------

ran a migration, the console kept insisting the column did not exist.
it was spring holding a preloaded copy of the app from before the
migration. `bin/spring stop` (or `pkill -f spring`) and it picks the
new schema up. this is apparently well known and cost me an hour.
