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

ActiveRecord::Schema.define(:version => 20121215154924) do

  create_table "administrators", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "development_result_pro_fields", :force => true do |t|
    t.integer  "pro_field_id"
    t.integer  "development_result_id"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  add_index "development_result_pro_fields", ["development_result_id"], :name => "development_result_pro_fields_development_result_id_fk"
  add_index "development_result_pro_fields", ["pro_field_id"], :name => "development_result_pro_fields_pro_field_id_fk"

  create_table "development_result_sub_fields", :force => true do |t|
    t.integer  "sub_field_id"
    t.integer  "development_result_id"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  add_index "development_result_sub_fields", ["development_result_id"], :name => "development_result_sub_fields_development_result_id_fk"
  add_index "development_result_sub_fields", ["sub_field_id"], :name => "development_result_sub_fields_sub_field_id_fk"

  create_table "development_results", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.integer  "sw_developer_id"
    t.integer  "state",           :default => 0
  end

  add_index "development_results", ["sw_developer_id"], :name => "development_results_sw_developer_id_fk"

  create_table "evaluation_requests", :force => true do |t|
    t.integer  "administrator_id"
    t.integer  "evaluator_id"
    t.integer  "development_result_id"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  add_index "evaluation_requests", ["administrator_id"], :name => "evaluation_requests_administrator_id_fk"
  add_index "evaluation_requests", ["development_result_id"], :name => "evaluation_requests_development_result_id_fk"
  add_index "evaluation_requests", ["evaluator_id"], :name => "evaluation_requests_evaluator_id_fk"

  create_table "evaluation_result_sub_fields", :force => true do |t|
    t.integer  "sub_field_id"
    t.integer  "evaluation_result_id"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  add_index "evaluation_result_sub_fields", ["evaluation_result_id"], :name => "evaluation_result_sub_fields_evaluation_result_id_fk"
  add_index "evaluation_result_sub_fields", ["sub_field_id"], :name => "evaluation_result_sub_fields_sub_field_id_fk"

  create_table "evaluation_results", :force => true do |t|
    t.integer  "development_result_id"
    t.integer  "evaluator_id"
    t.integer  "creativity"
    t.integer  "concentration"
    t.integer  "skill"
    t.integer  "will"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  add_index "evaluation_results", ["development_result_id"], :name => "evaluation_results_development_result_id_fk"
  add_index "evaluation_results", ["evaluator_id"], :name => "evaluation_results_evaluator_id_fk"

  create_table "evaluator_pro_fields", :force => true do |t|
    t.integer  "pro_field_id"
    t.integer  "evaluator_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "evaluator_pro_fields", ["evaluator_id"], :name => "evaluator_pro_fields_evaluator_id_fk"
  add_index "evaluator_pro_fields", ["pro_field_id"], :name => "evaluator_pro_fields_pro_field_id_fk"

  create_table "evaluators", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "gcm_devices", :force => true do |t|
    t.string   "registration_id",    :null => false
    t.datetime "last_registered_at"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "user_id"
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

  create_table "pre_chosen_developers", :force => true do |t|
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "sw_developer_id"
    t.integer  "service_id"
  end

  add_index "pre_chosen_developers", ["service_id"], :name => "pre_chosen_developers_service_id_fk"
  add_index "pre_chosen_developers", ["sw_developer_id"], :name => "pre_chosen_developers_sw_developer_id_fk"

  create_table "pro_fields", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "requestors", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "result_files", :force => true do |t|
    t.string   "path"
    t.integer  "development_result_id"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  add_index "result_files", ["development_result_id"], :name => "result_files_development_result_id_fk"

  create_table "service_pro_fields", :force => true do |t|
    t.integer  "pro_field_id"
    t.integer  "service_id"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.integer  "number_of_developers"
  end

  add_index "service_pro_fields", ["pro_field_id"], :name => "service_pro_fields_pro_field_id_fk"
  add_index "service_pro_fields", ["service_id"], :name => "service_pro_fields_service_id_fk"

  create_table "services", :force => true do |t|
    t.datetime "due_date"
    t.string   "service_file_path"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "requestor_id"
    t.integer  "administrator_id"
    t.integer  "team_id"
    t.string   "name"
    t.integer  "creativity"
    t.integer  "concentration"
    t.integer  "skill"
    t.integer  "will"
  end

  add_index "services", ["administrator_id"], :name => "services_administrator_id_fk"
  add_index "services", ["requestor_id"], :name => "services_requestor_id_fk"
  add_index "services", ["team_id"], :name => "services_team_id_fk"

  create_table "sub_fields", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "sw_developer_pro_fields", :force => true do |t|
    t.integer  "pro_field_id"
    t.integer  "sw_developer_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "sw_developer_pro_fields", ["pro_field_id"], :name => "sw_developer_pro_fields_pro_field_id_fk"
  add_index "sw_developer_pro_fields", ["sw_developer_id"], :name => "sw_developer_pro_fields_sw_developer_id_fk"

  create_table "sw_developers", :force => true do |t|
    t.integer  "developer_pay"
    t.string   "profile_file_path"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "administrator_id"
  end

  add_index "sw_developers", ["administrator_id"], :name => "sw_developers_administrator_id_fk"

  create_table "team_people", :force => true do |t|
    t.integer  "sw_developer_id"
    t.integer  "team_id"
    t.integer  "state"
    t.integer  "personal_pay"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.integer  "pro_field_id"
    t.integer  "change_counter",  :default => 3
  end

  add_index "team_people", ["sw_developer_id"], :name => "team_people_sw_developer_id_fk"
  add_index "team_people", ["team_id"], :name => "team_people_team_id_fk"

  create_table "teams", :force => true do |t|
    t.integer  "reader_sw_developer_id"
    t.integer  "service_id"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.string   "name"
  end

  add_index "teams", ["reader_sw_developer_id", "service_id"], :name => "index_teams_on_reader_sw_developer_id_and_service_id", :unique => true
  add_index "teams", ["service_id"], :name => "teams_service_id_fk"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "email"
    t.string   "phone"
    t.datetime "join_date"
    t.string   "roll"
    t.string   "login_id"
    t.string   "password"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.datetime "last_login"
  end

  add_index "users", ["login_id"], :name => "index_users_on_login_id", :unique => true

  add_foreign_key "administrators", "users", :name => "administrators_id_fk", :column => "id"

  add_foreign_key "development_result_pro_fields", "development_results", :name => "development_result_pro_fields_development_result_id_fk"
  add_foreign_key "development_result_pro_fields", "pro_fields", :name => "development_result_pro_fields_pro_field_id_fk"

  add_foreign_key "development_result_sub_fields", "development_results", :name => "development_result_sub_fields_development_result_id_fk"
  add_foreign_key "development_result_sub_fields", "sub_fields", :name => "development_result_sub_fields_sub_field_id_fk"

  add_foreign_key "development_results", "sw_developers", :name => "development_results_sw_developer_id_fk"

  add_foreign_key "evaluation_requests", "administrators", :name => "evaluation_requests_administrator_id_fk"
  add_foreign_key "evaluation_requests", "development_results", :name => "evaluation_requests_development_result_id_fk"
  add_foreign_key "evaluation_requests", "evaluators", :name => "evaluation_requests_evaluator_id_fk"

  add_foreign_key "evaluation_result_sub_fields", "evaluation_results", :name => "evaluation_result_sub_fields_evaluation_result_id_fk"
  add_foreign_key "evaluation_result_sub_fields", "sub_fields", :name => "evaluation_result_sub_fields_sub_field_id_fk"

  add_foreign_key "evaluation_results", "development_results", :name => "evaluation_results_development_result_id_fk"
  add_foreign_key "evaluation_results", "evaluators", :name => "evaluation_results_evaluator_id_fk"

  add_foreign_key "evaluator_pro_fields", "evaluators", :name => "evaluator_pro_fields_evaluator_id_fk"
  add_foreign_key "evaluator_pro_fields", "pro_fields", :name => "evaluator_pro_fields_pro_field_id_fk"

  add_foreign_key "evaluators", "users", :name => "evaluators_id_fk", :column => "id"

  add_foreign_key "pre_chosen_developers", "services", :name => "pre_chosen_developers_service_id_fk"
  add_foreign_key "pre_chosen_developers", "sw_developers", :name => "pre_chosen_developers_sw_developer_id_fk"

  add_foreign_key "requestors", "users", :name => "requestors_id_fk", :column => "id"

  add_foreign_key "result_files", "development_results", :name => "result_files_development_result_id_fk"

  add_foreign_key "service_pro_fields", "pro_fields", :name => "service_pro_fields_pro_field_id_fk"
  add_foreign_key "service_pro_fields", "services", :name => "service_pro_fields_service_id_fk"

  add_foreign_key "services", "administrators", :name => "services_administrator_id_fk"
  add_foreign_key "services", "requestors", :name => "services_requestor_id_fk"
  add_foreign_key "services", "teams", :name => "services_team_id_fk"

  add_foreign_key "sw_developer_pro_fields", "pro_fields", :name => "sw_developer_pro_fields_pro_field_id_fk"
  add_foreign_key "sw_developer_pro_fields", "sw_developers", :name => "sw_developer_pro_fields_sw_developer_id_fk"

  add_foreign_key "sw_developers", "administrators", :name => "sw_developers_administrator_id_fk"
  add_foreign_key "sw_developers", "users", :name => "sw_developers_id_fk", :column => "id"

  add_foreign_key "team_people", "sw_developers", :name => "team_people_sw_developer_id_fk"
  add_foreign_key "team_people", "teams", :name => "team_people_team_id_fk"

  add_foreign_key "teams", "services", :name => "teams_service_id_fk"
  add_foreign_key "teams", "sw_developers", :name => "teams_reader_sw_developer_id_fk", :column => "reader_sw_developer_id"

end
