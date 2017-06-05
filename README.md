bookshelf
=========

rails app for keeping track of the books i have read, am reading, and
mean to read. built for CS210 and then kept going because i wanted it.

![screenshot](doc/screenshot.png)

setup
-----

    bundle install
    bin/rails db:schema:load db:seed
    bin/rails server

* ruby 2.4.1, rails 5.0
* sqlite in development and test, postgres in production
* rspec + factory_girl + rubocop, both run on travis
* deployed to heroku, see NOTES.md and UPGRADE.md

what it does
------------

* add a book by hand, or type an ISBN and let Open Library fill it in
* unread / reading / read, a 1-5 rating, the date finished
* free text tags, click one to filter
* notes on a book, with a page number
* search title and author, sort by title, author or rating
* a reading goal for the year with a progress bar on the stats page
* import a goodreads csv export: `rails books:import FILE=export.csv`
* export: the csv link on the list, or `/books.json` for json

tests
-----

    bundle exec rspec
    bundle exec rubocop

things i would do differently
-----------------------------

* the books controller index does too much. the filtering should be one
  object that takes the params and hands back a scope.
* tag_list= creates tags that nothing ever cleans up, so the tags table
  has junk in it from typos.
* no tests on the views at all.
* the stats page counts everyone's books, not just mine. it was a
  single user app when i wrote that query and i never went back to it.
