heroku
------

the push kept dying in `rake assets:precompile` with "could not connect
to server". turns out precompile boots the app, the app wants a
database, and the database is not attached during the build. adding
rails_12factor and setting `config.assets.compile = false` sorted it
out, plus `config.serve_static_files` so puma will actually serve the
compiled files.

    heroku run rails db:migrate
    heroku run rails db:seed

heroku picks the ruby version out of the Gemfile, so bumping it there
is the whole deploy step. the slug build downloads the new ruby, which
makes that one push take a few minutes.

if the dyno 500s, `heroku logs --tail` and look for the
ActionView::Template::Error line, not the big stack after it.

spring
------

ran a migration, the console kept insisting the column did not exist.
it was spring holding a preloaded copy of the app from before the
migration. `bin/spring stop` (or `pkill -f spring`) and it picks the
new schema up. this is apparently well known and cost me an hour.

ruby 2.4
--------

the only thing that actually broke was a `Fixnum` check i had in the
import task: Fixnum and Bignum are both Integer now and referring to
either one prints a deprecation warning. rubocop flagged it too.
