# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160507203755) do

  create_table "books", force: :cascade do |t|
    t.string    "title"
    t.string    "author"
    t.string    "isbn"
    t.integer   "pages"
    t.string    "status", default: "unread"
    t.integer   "rating"
    t.date      "finished_on"
    t.datetime  "created_at", null: false
    t.datetime  "updated_at", null: false
  end

end
