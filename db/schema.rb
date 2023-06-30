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

ActiveRecord::Schema[7.0].define(version: 2023_06_30_094825) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "genres", id: false, force: :cascade do |t|
    t.integer "id", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["id"], name: "index_genres_on_id", unique: true
  end

  create_table "genres_movies", id: false, force: :cascade do |t|
    t.bigint "genre_id", null: false
    t.bigint "movie_id", null: false
    t.index ["genre_id"], name: "index_genres_movies_on_genre_id"
    t.index ["movie_id", "genre_id"], name: "index_genres_movies_on_movie_id_and_genre_id", unique: true
    t.index ["movie_id"], name: "index_genres_movies_on_movie_id"
  end

  create_table "movies", id: false, force: :cascade do |t|
    t.integer "id", null: false
    t.string "title", null: false
    t.float "vote_average"
    t.integer "vote_count"
    t.string "poster_path"
    t.string "original_title"
    t.text "overview"
    t.string "release_date"
    t.string "tagline"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "director"
    t.integer "runtime"
    t.index ["id"], name: "index_movies_on_id", unique: true
  end

  create_table "movies_watchlists", force: :cascade do |t|
    t.bigint "watchlist_id", null: false
    t.bigint "movie_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["movie_id", "watchlist_id"], name: "index_movies_watchlists_on_movie_id_and_watchlist_id", unique: true
    t.index ["movie_id"], name: "index_movies_watchlists_on_movie_id"
    t.index ["watchlist_id"], name: "index_movies_watchlists_on_watchlist_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "jti", null: false
    t.string "username"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["jti"], name: "index_users_on_jti", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "watchlists", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_watchlists_on_user_id", unique: true
  end

  add_foreign_key "genres_movies", "genres"
  add_foreign_key "genres_movies", "movies"
  add_foreign_key "movies_watchlists", "movies"
  add_foreign_key "movies_watchlists", "watchlists"
  add_foreign_key "watchlists", "users"
end
