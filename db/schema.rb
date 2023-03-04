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

ActiveRecord::Schema[7.0].define(version: 2023_03_04_032835) do
  create_table "code_breaker_codes", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "Color"
    t.bigint "code_breaker_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code_breaker_id"], name: "index_code_breaker_codes_on_code_breaker_id"
  end

  create_table "code_breaker_guess_colors", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "Color"
    t.bigint "code_breaker_guess_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code_breaker_guess_id"], name: "index_code_breaker_guess_colors_on_code_breaker_guess_id"
  end

  create_table "code_breaker_guess_keys", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "Key"
    t.bigint "code_breaker_guess_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code_breaker_guess_id"], name: "index_code_breaker_guess_keys_on_code_breaker_guess_id"
  end

  create_table "code_breaker_guesses", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "code_breaker_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code_breaker_id"], name: "index_code_breaker_guesses_on_code_breaker_id"
  end

  create_table "code_breakers", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "Status", default: 1
    t.integer "Columns"
    t.integer "Colors"
    t.integer "Score", default: 0
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_code_breakers_on_user_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "UserName", limit: 30, null: false
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["UserName"], name: "index_users_on_UserName", unique: true
  end

  add_foreign_key "code_breaker_codes", "code_breakers"
  add_foreign_key "code_breaker_guess_colors", "code_breaker_guesses"
  add_foreign_key "code_breaker_guess_keys", "code_breaker_guesses"
  add_foreign_key "code_breaker_guesses", "code_breakers"
  add_foreign_key "code_breakers", "users"
end
