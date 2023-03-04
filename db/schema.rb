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

ActiveRecord::Schema[7.0].define(version: 2023_03_04_131547) do
  create_table "code_breaker_codes", charset: "utf8mb4", force: :cascade do |t|
    t.integer "Color"
    t.bigint "code_breaker_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code_breaker_id"], name: "index_code_breaker_codes_on_code_breaker_id"
  end

  create_table "code_breaker_guess_colors", charset: "utf8mb4", force: :cascade do |t|
    t.integer "Color"
    t.bigint "code_breaker_guess_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code_breaker_guess_id"], name: "index_code_breaker_guess_colors_on_code_breaker_guess_id"
  end

  create_table "code_breaker_guess_keys", charset: "utf8mb4", force: :cascade do |t|
    t.integer "Key"
    t.bigint "code_breaker_guess_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code_breaker_guess_id"], name: "index_code_breaker_guess_keys_on_code_breaker_guess_id"
  end

  create_table "code_breaker_guesses", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "code_breaker_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code_breaker_id"], name: "index_code_breaker_guesses_on_code_breaker_id"
  end

  create_table "code_breakers", charset: "utf8mb4", force: :cascade do |t|
    t.integer "Status", default: 1
    t.integer "Columns"
    t.integer "Colors"
    t.integer "Score", default: 0
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_code_breakers_on_user_id"
  end

  create_table "concentrations", charset: "utf8mb4", force: :cascade do |t|
    t.integer "Status", default: 1
    t.integer "Moves", default: 0
    t.integer "Matched", default: 0
    t.integer "Elapsed", default: 0
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_concentrations_on_user_id"
  end

  create_table "free_cells", charset: "utf8mb4", force: :cascade do |t|
    t.integer "Status", default: 1
    t.integer "Moves", default: 0
    t.integer "Elapsed", default: 0
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_free_cells_on_user_id"
  end

  create_table "guess_word_guess_ratings", charset: "utf8mb4", force: :cascade do |t|
    t.integer "Rating"
    t.bigint "guess_word_guess_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["guess_word_guess_id"], name: "index_guess_word_guess_ratings_on_guess_word_guess_id"
  end

  create_table "guess_word_guesses", charset: "utf8mb4", force: :cascade do |t|
    t.string "Guess", limit: 30
    t.bigint "guess_word_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["guess_word_id"], name: "index_guess_word_guesses_on_guess_word_id"
  end

  create_table "guess_words", charset: "utf8mb4", force: :cascade do |t|
    t.integer "Status", default: 1
    t.integer "Score", default: 0
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "word_id", null: false
    t.index ["user_id"], name: "index_guess_words_on_user_id"
    t.index ["word_id"], name: "index_guess_words_on_word_id"
  end

  create_table "hang_men", charset: "utf8mb4", force: :cascade do |t|
    t.string "Correct", default: ""
    t.string "Wrong", default: ""
    t.integer "Status", default: 1
    t.integer "Score", default: 0
    t.bigint "user_id"
    t.bigint "word_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_hang_men_on_user_id"
    t.index ["word_id"], name: "index_hang_men_on_word_id"
  end

  create_table "klondikes", charset: "utf8mb4", force: :cascade do |t|
    t.integer "Status"
    t.integer "Moves"
    t.integer "Elapsed"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_klondikes_on_user_id"
  end

  create_table "users", charset: "utf8mb4", force: :cascade do |t|
    t.string "UserName", limit: 30, null: false
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["UserName"], name: "index_users_on_UserName", unique: true
  end

  create_table "words", charset: "utf8mb4", force: :cascade do |t|
    t.string "Word", limit: 30
    t.integer "Length", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "code_breaker_codes", "code_breakers"
  add_foreign_key "code_breaker_guess_colors", "code_breaker_guesses"
  add_foreign_key "code_breaker_guess_keys", "code_breaker_guesses"
  add_foreign_key "code_breaker_guesses", "code_breakers"
  add_foreign_key "code_breakers", "users"
  add_foreign_key "concentrations", "users"
  add_foreign_key "free_cells", "users"
  add_foreign_key "guess_word_guess_ratings", "guess_word_guesses"
  add_foreign_key "guess_word_guesses", "guess_words"
  add_foreign_key "guess_words", "users"
  add_foreign_key "guess_words", "words"
  add_foreign_key "hang_men", "users"
  add_foreign_key "hang_men", "words"
  add_foreign_key "klondikes", "users"
end
