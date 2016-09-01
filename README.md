bookshelf
=========

rails app for keeping track of the books i have read, am reading, and
mean to read. built for CS210 and then kept going because i wanted it.

setup
-----

    bundle install
    bin/rake db:schema:load db:seed
    bin/rails server

* ruby 2.2.4, rails 4.2.5
* sqlite in development and test, postgres in production
* rspec + factory_girl, `bundle exec rspec`
* deployed to heroku, see NOTES.md

what it does
------------

* add a book with title, author, isbn, pages
* mark it unread / reading / read, rate it 1-5, record the date finished
* filter by status, search title and author
