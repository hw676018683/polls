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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160307080332) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "choices", force: :cascade do |t|
    t.string   "title"
    t.integer  "limit",       default: 0
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "question_id"
    t.integer  "user_ids",    default: [],              array: true
  end

  add_index "choices", ["question_id"], name: "index_choices_on_question_id", using: :btree

  create_table "entities", force: :cascade do |t|
    t.integer  "question_id"
    t.integer  "vote_id"
    t.integer  "choice_id"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "entities", ["choice_id"], name: "index_entities_on_choice_id", using: :btree
  add_index "entities", ["question_id"], name: "index_entities_on_question_id", using: :btree
  add_index "entities", ["vote_id"], name: "index_entities_on_vote_id", using: :btree

  create_table "polls", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "user_id"
    t.datetime "started_at"
    t.datetime "ended_at"
  end

  add_index "polls", ["user_id"], name: "index_polls_on_user_id", using: :btree

  create_table "questions", force: :cascade do |t|
    t.string   "title"
    t.boolean  "multiple",   default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "poll_id"
  end

  add_index "questions", ["poll_id"], name: "index_questions_on_poll_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "uid"
    t.string   "name"
    t.string   "nickname"
    t.string   "phone"
    t.string   "headimgurl"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "votes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "poll_id"
    t.integer  "result",     default: [],              array: true
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "votes", ["poll_id"], name: "index_votes_on_poll_id", using: :btree
  add_index "votes", ["user_id"], name: "index_votes_on_user_id", using: :btree

  add_foreign_key "choices", "questions"
  add_foreign_key "polls", "users"
  add_foreign_key "questions", "polls"
end
