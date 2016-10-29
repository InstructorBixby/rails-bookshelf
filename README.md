bookshelf
=========

rails app for keeping track of the books i have read, am reading, and
mean to read. built for CS210 and then kept going because i wanted it.

setup
-----

    bundle install
    bin/rails db:schema:load db:seed
    bin/rails server

* ruby 2.3.1, rails 5.0
* sqlite in development and test, postgres in production
* rspec + factory_girl, `bundle exec rspec`
* deployed to heroku, see NOTES.md and UPGRADE.md

what it does
------------

* add a book with title, author, isbn, pages
* mark it unread / reading / read, rate it 1-5, record the date finished
* filter by status, search title and author
* log in, books belong to whoever added them

`rake` still works for the db tasks but `rails` is the one the guides
use now, so i am using that.
