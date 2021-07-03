# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_07_02_014009) do

  create_table "calendar_events", force: :cascade do |t|
    t.string "summary", null: false
    t.datetime "started_at", null: false
    t.datetime "ended_at", null: false
    t.integer "calendar_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["calendar_id"], name: "index_calendar_events_on_calendar_id"
  end

  create_table "calendar_histories", force: :cascade do |t|
    t.integer "status", default: 0
    t.string "log", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "calendar_id", null: false
    t.index ["calendar_id"], name: "index_calendar_histories_on_calendar_id"
  end

  create_table "calendars", force: :cascade do |t|
    t.string "display_as", null: false
    t.string "url"
    t.integer "status", default: 0
    t.string "content"
    t.string "color", null: false
    t.datetime "last_updated_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id", null: false
    t.index ["user_id", "url"], name: "index_calendars_on_user_id_and_url", unique: true
    t.index ["user_id"], name: "index_calendars_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "shorthand"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
