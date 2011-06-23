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

ActiveRecord::Schema.define(:version => 20110623100914) do

  create_table "authorizations", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "screen_name"
    t.string   "avatar"
    t.string   "oauth_token"
    t.string   "oauth_secret"
  end

  create_table "broadcasts", :force => true do |t|
    t.datetime "start"
    t.datetime "end"
    t.string   "link"
    t.string   "synopsis"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_repeat"
    t.integer  "duration"
    t.string   "title"
    t.integer  "channel_id"
    t.integer  "intentions_count"
    t.string   "subtitle"
    t.boolean  "is_film",            :default => false, :null => false
    t.string   "image_url"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.boolean  "significant"
  end

  create_table "channels", :force => true do |t|
    t.string   "name"
    t.string   "xml_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friendships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "intentions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "broadcast_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "comment"
    t.boolean  "tweet",        :default => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "intentions_count"
    t.string   "username"
    t.string   "email"
    t.boolean  "admin"
  end

end
