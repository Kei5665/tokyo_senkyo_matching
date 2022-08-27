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

ActiveRecord::Schema[7.0].define(version: 2022_08_27_023820) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "opinions", force: :cascade do |t|
    t.string "category", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "parties", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "party_questions", force: :cascade do |t|
    t.bigint "question_id", null: false
    t.bigint "party_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "opinion_id"
    t.index ["opinion_id"], name: "index_party_questions_on_opinion_id"
    t.index ["party_id"], name: "index_party_questions_on_party_id"
    t.index ["question_id"], name: "index_party_questions_on_question_id"
  end

  create_table "questions", force: :cascade do |t|
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "party_questions", "opinions"
  add_foreign_key "party_questions", "parties"
  add_foreign_key "party_questions", "questions"
end