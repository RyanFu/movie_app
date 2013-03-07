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

ActiveRecord::Schema.define(:version => 20130306120249) do

  create_table "areas", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "campaigns", :force => true do |t|
    t.string   "picture_out"
    t.string   "picture_in"
    t.string   "title"
    t.text     "description"
    t.datetime "time_active"
    t.text     "measure"
    t.string   "teach_pic"
    t.string   "award_condition"
    t.string   "award"
    t.string   "award_pic"
    t.text     "precaution"
    t.integer  "movie_id"
    t.string   "award_list"
    t.integer  "is_show"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "channel_times", :force => true do |t|
    t.integer  "channel_id"
    t.text     "time"
    t.string   "date"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "channels", :force => true do |t|
    t.string   "name"
    t.string   "crawl_link"
    t.integer  "channel_num"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "comments", :force => true do |t|
    t.integer  "record_id"
    t.integer  "user_id"
    t.text     "text"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "comments", ["record_id"], :name => "index_comments_on_record_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "gcm_devices", :force => true do |t|
    t.string   "registration_id",    :null => false
    t.datetime "last_registered_at"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "gcm_devices", ["registration_id"], :name => "index_gcm_devices_on_registration_id", :unique => true

  create_table "gcm_notifications", :force => true do |t|
    t.integer  "device_id",        :null => false
    t.string   "collapse_key"
    t.text     "data"
    t.boolean  "delay_while_idle"
    t.datetime "sent_at"
    t.integer  "time_to_live"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "gcm_notifications", ["device_id"], :name => "index_gcm_notifications_on_device_id"

  create_table "movie_box_office_ships", :force => true do |t|
    t.integer  "movie_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "movie_box_office_ships", ["movie_id"], :name => "index_movie_box_office_ships_on_movie_id"

  create_table "movie_theater_ships", :force => true do |t|
    t.integer  "movie_id"
    t.integer  "theater_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.text     "timetable"
    t.integer  "area_id"
    t.string   "hall_type"
    t.string   "hall_str"
  end

  add_index "movie_theater_ships", ["area_id"], :name => "index_movie_theater_ships_on_area_id"
  add_index "movie_theater_ships", ["movie_id"], :name => "index_movie_theater_ships_on_movie_id"
  add_index "movie_theater_ships", ["theater_id"], :name => "index_movie_theater_ships_on_theater_id"

  create_table "movies", :force => true do |t|
    t.string   "name"
    t.string   "name_en"
    t.text     "intro"
    t.string   "poster_url"
    t.date     "release_date"
    t.string   "running_time"
    t.string   "level_url"
    t.text     "actors"
    t.text     "directors"
    t.boolean  "is_first_round",   :default => false
    t.boolean  "is_second_round",  :default => false
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.boolean  "is_hot",           :default => false
    t.string   "youtube_video_id"
    t.boolean  "is_comming",       :default => false
    t.boolean  "is_this_week",     :default => false
    t.integer  "records_count",    :default => 0
    t.integer  "good_count",       :default => 0
    t.boolean  "is_ezding",        :default => false
  end

  add_index "movies", ["youtube_video_id"], :name => "index_movies_on_youtube_video_id"

  create_table "news", :force => true do |t|
    t.string   "title"
    t.string   "content"
    t.string   "link"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "picture_url"
    t.integer  "news_type"
    t.string   "thumbnail_url"
    t.string   "source"
  end

  create_table "ptt_data", :force => true do |t|
    t.string   "ptt_user_id"
    t.string   "title"
    t.string   "link"
    t.string   "content"
    t.integer  "score"
    t.integer  "movie_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "ptt_raws", :force => true do |t|
    t.string   "ptt_user_id"
    t.string   "title"
    t.string   "link"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "records", :force => true do |t|
    t.text     "comment"
    t.integer  "score"
    t.integer  "movie_id"
    t.integer  "user_id"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.integer  "comments_count", :default => 0
    t.integer  "love_count",     :default => 0
  end

  add_index "records", ["movie_id"], :name => "index_records_on_movie_id"
  add_index "records", ["user_id"], :name => "index_records_on_user_id"

  create_table "streams", :force => true do |t|
    t.integer  "record_id"
    t.integer  "comment_id"
    t.integer  "stream_type"
    t.integer  "user_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "stream_user_id"
    t.integer  "movie_id"
  end

  add_index "streams", ["comment_id"], :name => "index_streams_on_comment_id"
  add_index "streams", ["movie_id"], :name => "index_streams_on_movie_id"
  add_index "streams", ["record_id"], :name => "index_streams_on_record_id"
  add_index "streams", ["stream_user_id"], :name => "index_streams_on_stream_user_id"
  add_index "streams", ["user_id"], :name => "index_streams_on_user_id"

  create_table "theaters", :force => true do |t|
    t.string   "name"
    t.boolean  "is_second_round", :default => false
    t.string   "location"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.integer  "area_id"
    t.string   "buy_link"
    t.string   "phone"
    t.string   "link"
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

  create_table "user_love_record_ships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "record_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "user_love_record_ships", ["record_id"], :name => "index_user_love_record_ships_on_record_id"
  add_index "user_love_record_ships", ["user_id"], :name => "index_user_love_record_ships_on_user_id"

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
    t.integer  "device_id"
    t.string   "registration_id"
    t.integer  "records_count",          :default => 0
  end

  add_index "users", ["device_id"], :name => "index_users_on_device_id"
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
