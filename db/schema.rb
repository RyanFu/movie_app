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

ActiveRecord::Schema.define(:version => 20120814144221) do

  create_table "areas", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "movie_theater_ships", :force => true do |t|
    t.integer  "movie_id"
    t.integer  "theater_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "movie_theater_ships", ["movie_id"], :name => "index_movie_theater_ships_on_movie_id"
  add_index "movie_theater_ships", ["theater_id"], :name => "index_movie_theater_ships_on_theater_id"

  create_table "movies", :force => true do |t|
    t.string   "name"
    t.string   "name_en"
    t.text     "intro"
    t.string   "poster_url"
    t.string   "release_date"
    t.string   "running_time"
    t.string   "level_url"
    t.string   "actors"
    t.string   "directors"
    t.boolean  "is_first_round",  :default => false
    t.boolean  "is_second_round", :default => false
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.boolean  "is_hot",          :default => false
  end

  create_table "records", :force => true do |t|
    t.string   "comment"
    t.integer  "score"
    t.integer  "movie_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "records", ["movie_id"], :name => "index_records_on_movie_id"
  add_index "records", ["user_id"], :name => "index_records_on_user_id"

  create_table "theaters", :force => true do |t|
    t.string   "name"
    t.boolean  "is_second_round", :default => false
    t.string   "location"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.integer  "area_id"
  end

  add_index "theaters", ["area_id"], :name => "index_theaters_on_area_id"

  create_table "user_friend_ships", :force => true do |t|
    t.integer  "direct_friend_id"
    t.integer  "inverse_friend_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "user_friend_ships", ["direct_friend_id"], :name => "index_user_friend_ships_on_direct_friend_id"
  add_index "user_friend_ships", ["inverse_friend_id"], :name => "index_user_friend_ships_on_inverse_friend_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "fb_id",                  :default => "", :null => false
    t.string   "name"
    t.string   "sex"
    t.string   "birthday"
    t.string   "fb_token"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
