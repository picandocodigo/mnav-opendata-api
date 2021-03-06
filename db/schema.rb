# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120509174056) do

  create_table "artists", :force => true do |t|
    t.integer  "museum_id"
    t.string   "name"
    t.string   "display_name"
    t.integer  "birth"
    t.integer  "death"
    t.text     "biography"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "artworks_count"
  end

  create_table "artworks", :force => true do |t|
    t.integer  "museum_id"
    t.integer  "museum_artist_id"
    t.string   "title"
    t.string   "technique"
    t.decimal  "height"
    t.decimal  "width"
    t.decimal  "depth"
    t.integer  "artist_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "year"
    t.string   "image_url"
    t.string   "image_thumbnail_url"
  end

end
