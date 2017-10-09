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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20171009180127) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clubs", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_clubs_on_user_id"
  end

  create_table "race_results", id: :serial, force: :cascade do |t|
    t.integer "racer_id"
    t.integer "race_id"
    t.integer "status"
    t.text "lap_times", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "points"
    t.integer "signal_strength"
    t.index ["race_id"], name: "index_race_results_on_race_id"
    t.index ["racer_id"], name: "index_race_results_on_racer_id"
  end

  create_table "racers", id: :serial, force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.integer "year_of_birth"
    t.integer "gender"
    t.string "email"
    t.string "phone_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "club_id"
    t.integer "category"
    t.string "address"
    t.string "zip_code"
    t.string "town"
    t.integer "day_of_birth"
    t.integer "month_of_birth"
    t.string "uci_id"
    t.index ["club_id"], name: "index_racers_on_club_id"
    t.index ["user_id"], name: "index_racers_on_user_id"
  end

  create_table "races", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "date"
    t.integer "laps"
    t.integer "easy_laps"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "started_at"
    t.datetime "ended_at"
    t.string "description_url"
    t.string "picture_url"
  end

  create_table "start_numbers", id: :serial, force: :cascade do |t|
    t.integer "value"
    t.string "tag_id"
    t.integer "signal_strength"
    t.integer "racer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["racer_id"], name: "index_start_numbers_on_racer_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "clubs", "users"
  add_foreign_key "race_results", "racers"
  add_foreign_key "race_results", "races"
  add_foreign_key "racers", "clubs"
  add_foreign_key "racers", "users"
  add_foreign_key "start_numbers", "racers"
end
