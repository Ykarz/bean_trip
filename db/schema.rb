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

ActiveRecord::Schema[7.2].define(version: 2026_01_19_162006) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bean_bookmarks", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "bean_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bean_id"], name: "index_bean_bookmarks_on_bean_id"
    t.index ["user_id", "bean_id"], name: "index_bean_bookmarks_on_user_id_and_bean_id", unique: true
    t.index ["user_id"], name: "index_bean_bookmarks_on_user_id"
  end

  create_table "beans", force: :cascade do |t|
    t.string "name", null: false
    t.string "area"
    t.string "farm"
    t.integer "roast_level", default: 0, null: false
    t.boolean "is_blended", default: false, null: false
    t.integer "bitterness"
    t.integer "sweetness"
    t.integer "acidity"
    t.integer "body"
    t.integer "aroma"
    t.string "image"
    t.text "comment", null: false
    t.bigint "user_id", null: false
    t.bigint "country_id", null: false
    t.bigint "store_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_beans_on_country_id"
    t.index ["store_id"], name: "index_beans_on_store_id"
    t.index ["user_id"], name: "index_beans_on_user_id"
  end

  create_table "countries", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "store_bookmarks", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "store_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["store_id"], name: "index_store_bookmarks_on_store_id"
    t.index ["user_id", "store_id"], name: "index_store_bookmarks_on_user_id_and_store_id", unique: true
    t.index ["user_id"], name: "index_store_bookmarks_on_user_id"
  end

  create_table "stores", force: :cascade do |t|
    t.string "place_id", null: false
    t.string "name", null: false
    t.string "post_code"
    t.string "address"
    t.string "phone_number"
    t.string "opening_hours"
    t.string "web_site_url"
    t.decimal "rating"
    t.string "image"
    t.decimal "latitude", precision: 10, scale: 7, null: false
    t.decimal "longitude", precision: 10, scale: 7, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name", null: false
    t.string "avatar"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "bean_bookmarks", "beans"
  add_foreign_key "bean_bookmarks", "users"
  add_foreign_key "beans", "countries"
  add_foreign_key "beans", "stores"
  add_foreign_key "beans", "users"
  add_foreign_key "store_bookmarks", "stores"
  add_foreign_key "store_bookmarks", "users"
end
