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

ActiveRecord::Schema.define(:version => 20130713071519) do

  create_table "developers", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "developers", ["email"], :name => "index_developers_on_email", :unique => true
  add_index "developers", ["reset_password_token"], :name => "index_developers_on_reset_password_token", :unique => true

  create_table "features", :force => true do |t|
    t.string   "name"
    t.integer  "project_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "features", ["project_id"], :name => "index_features_on_project_id"

  create_table "issues", :force => true do |t|
    t.integer  "feature_id"
    t.integer  "developer_id"
    t.integer  "tester_id"
    t.string   "number"
    t.string   "title"
    t.text     "self_summary"
    t.string   "testing_status"
    t.text     "testing_summary"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "project_id"
  end

  add_index "issues", ["developer_id"], :name => "index_issues_on_developer_id"
  add_index "issues", ["feature_id"], :name => "index_issues_on_feature_id"
  add_index "issues", ["project_id"], :name => "index_issues_on_project_id"
  add_index "issues", ["tester_id"], :name => "index_issues_on_tester_id"
  add_index "issues", ["testing_status"], :name => "index_issues_on_testing_status"

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "testers", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "testers", ["email"], :name => "index_testers_on_email", :unique => true
  add_index "testers", ["reset_password_token"], :name => "index_testers_on_reset_password_token", :unique => true

end
