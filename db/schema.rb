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

ActiveRecord::Schema.define(:version => 20121010132639) do

  create_table "freeml_entries", :force => true do |t|
    t.integer  "freeml_id",       :null => false
    t.string   "freeml_user",     :null => false
    t.text     "freeml_body",     :null => false
    t.string   "freeml_title",    :null => false
    t.datetime "freeml_datetime", :null => false
    t.boolean  "freeml_readable", :null => false
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "freeml_entries", ["freeml_id"], :name => "index_freeml_entries_on_freeml_id", :unique => true

  create_table "materials", :force => true do |t|
    t.string   "subject_identifier",         :null => false
    t.integer  "user_id",                    :null => false
    t.integer  "material_type",              :null => false
    t.integer  "material_year",              :null => false
    t.integer  "material_number",            :null => false
    t.boolean  "material_with_answer"
    t.integer  "material_page",              :null => false
    t.string   "material_comments"
    t.string   "material_file_name",         :null => false
    t.string   "material_file_ext",          :null => false
    t.string   "material_file_content_type", :null => false
    t.integer  "material_download_count",    :null => false
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  add_index "materials", ["material_file_name"], :name => "index_materials_on_material_file_name", :unique => true

  create_table "subjects", :force => true do |t|
    t.string   "term_identifier",       :null => false
    t.string   "subject_identifier",    :null => false
    t.string   "subject_name",          :null => false
    t.string   "subject_staff",         :null => false
    t.string   "subject_lct_cd"
    t.text     "subject_syllabus_html", :null => false
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  add_index "subjects", ["subject_identifier"], :name => "index_subjects_on_subject_identifier", :unique => true
  add_index "subjects", ["subject_name"], :name => "index_subjects_on_subject_name", :unique => true
  add_index "subjects", ["term_identifier"], :name => "index_subjects_on_term_identifier"

  create_table "terms", :force => true do |t|
    t.string   "term_identifier",                 :null => false
    t.string   "term_name",                       :null => false
    t.binary   "term_timetable_img",              :null => false
    t.binary   "term_timetable_thumb",            :null => false
    t.string   "term_timetable_img_content_type", :null => false
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "terms", ["term_identifier"], :name => "index_terms_on_term_identifier", :unique => true
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

  create_table "vocabularies", :force => true do |t|
    t.string   "vocabulary_name"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "vocabularies", ["vocabulary_name"], :name => "index_vocabularies_on_vocabulary_name", :unique => true

  create_table "vocabulary_words", :force => true do |t|
    t.string   "word_en"
    t.string   "word_ja"
    t.integer  "vocabulary_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

end
