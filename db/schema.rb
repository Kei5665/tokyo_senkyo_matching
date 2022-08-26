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

ActiveRecord::Schema[7.0].define(version: 2022_08_26_154000) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "areas", force: :cascade do |t|
    t.string "area_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "spelling", null: false
  end

  create_table "authentications", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "provider", null: false
    t.string "uid", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["provider", "uid"], name: "index_authentications_on_provider_and_uid"
  end

  create_table "emblems", force: :cascade do |t|
    t.integer "limit_num", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "parties", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "party_questions", force: :cascade do |t|
    t.bigint "questions_id", null: false
    t.bigint "parties_id", null: false
    t.integer "opinion", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parties_id"], name: "index_party_questions_on_parties_id"
    t.index ["questions_id"], name: "index_party_questions_on_questions_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title", null: false
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "date"
    t.string "place"
    t.string "url"
    t.string "time"
    t.string "address"
    t.string "price"
    t.bigint "area_id"
    t.boolean "availability", default: false
    t.decimal "latitude"
    t.decimal "longitude"
    t.date "start_date"
    t.date "finish_date"
    t.index ["area_id"], name: "index_posts_on_area_id"
  end

  create_table "questions", force: :cascade do |t|
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "quests", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "post_id"
    t.boolean "quest_cleared", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_quests_on_post_id"
    t.index ["user_id", "post_id"], name: "index_quests_on_user_id_and_post_id", unique: true
    t.index ["user_id"], name: "index_quests_on_user_id"
  end

  create_table "user_emblems", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "emblem_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["emblem_id"], name: "index_user_emblems_on_emblem_id"
    t.index ["user_id"], name: "index_user_emblems_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", default: "ユーザー", null: false
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "clear_num", default: 0, null: false
    t.string "assets_path", default: "/assets/yuusya1.png"
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "party_questions", "parties", column: "parties_id"
  add_foreign_key "party_questions", "questions", column: "questions_id"
  add_foreign_key "posts", "areas"
  add_foreign_key "quests", "posts"
  add_foreign_key "quests", "users"
  add_foreign_key "user_emblems", "emblems"
  add_foreign_key "user_emblems", "users"
end
