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


ActiveRecord::Schema.define(:version => 20101117132512) do

  create_table "authorizations", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
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
  end

  create_table "channels", :force => true do |t|
    t.string   "name"
    t.string   "xml_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "intentions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "broadcast_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
      t.string   "name"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "nickname"
      t.string   "image"
      t.string   "oauth_token"
      t.string   "oauth_secret"
  end

  add_index "users", ["last_request_at"], :name => "index_users_on_last_request_at"
  add_index "users", ["login"], :name => "index_users_on_login"
  add_index "users", ["persistence_token"], :name => "index_users_on_persistence_token"

end
