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

ActiveRecord::Schema.define(version: 2019_08_21_142051) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "beaches", force: :cascade do |t|
    t.string "name"
    t.string "city"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "longitude"
    t.float "latitude"
    t.string "surfline_name"
    t.string "surfline_id"
  end

  create_table "rides", force: :cascade do |t|
    t.date "date"
    t.string "time_slot"
    t.bigint "beach_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "wave_height"
    t.float "swell_period"
    t.float "wind_speed"
    t.float "wind_direction"
    t.float "wind_gust"
    t.float "longitude"
    t.float "latitude"
    t.float "swell_height"
    t.float "swell_direction"
    t.string "experience"
    t.float "scoring"
    t.index ["beach_id"], name: "index_rides_on_beach_id"
  end

  create_table "userrides", force: :cascade do |t|
    t.bigint "ride_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ride_id"], name: "index_userrides_on_ride_id"
    t.index ["user_id"], name: "index_userrides_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.integer "age"
    t.string "level"
    t.string "photo"
    t.string "group_or_solo"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "rides", "beaches"
  add_foreign_key "userrides", "rides"
  add_foreign_key "userrides", "users"
end
