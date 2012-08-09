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

ActiveRecord::Schema.define(:version => 20120809021547) do

  create_table "terms", :force => true do |t|
    t.string   "term_name",          :null => false
    t.binary   "term_timetable_img", :null => false
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "terms", ["term_name"], :name => "index_terms_on_term_name", :unique => true

  create_table "users", :force => true do |t|
    t.string   "user_family_name",                                     :null => false
    t.string   "user_given_name",                                      :null => false
    t.string   "user_handle_name",                                     :null => false
    t.date     "user_birthday",                                        :null => false
    t.string   "user_email",                                           :null => false
    t.string   "user_email_sub"
    t.boolean  "user_is_admin",                     :default => false, :null => false
    t.integer  "user_status",                       :default => 1,     :null => false
    t.string   "user_auth_token",                                      :null => false
    t.string   "user_secret_token"
    t.datetime "user_secret_token_expiration_time"
    t.string   "password_digest",                                      :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at",                                           :null => false
  end

  add_index "users", ["user_auth_token"], :name => "index_users_on_user_auth_token", :unique => true
  add_index "users", ["user_email"], :name => "index_users_on_user_email", :unique => true
  add_index "users", ["user_email_sub"], :name => "index_users_on_user_email_sub", :unique => true

end
