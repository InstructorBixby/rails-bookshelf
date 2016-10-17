rails 5
-------

`rails app:update` and then going through the diffs one at a time. what
it touched:

* every migration class needs the version in brackets now, so
  `ActiveRecord::Migration` became `ActiveRecord::Migration[4.2]`. if
  you leave it off you get a StandardError telling you to pick one.
* models inherit from ApplicationRecord instead of ActiveRecord::Base.
  ApplicationRecord is a new file in app/models.
* new_framework_defaults.rb is where the behaviour changes live so you
  can switch them on one at a time instead of all at once.
* webrick is out, puma is the default server. the Procfile needed
  changing too.
* the schema dump format changed: indexes are inside the create_table
  block now and the column alignment is gone, so schema.rb looks like a
  huge diff even though nothing about the database changed.
* sdoc is not in the default Gemfile any more so i dropped it.
