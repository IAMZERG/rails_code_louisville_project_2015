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

ActiveRecord::Schema.define(version: 20151021231427) do

  create_table "cards", force: true do |t|
    t.integer  "decklist_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cards", ["decklist_id"], name: "index_cards_on_decklist_id"

  create_table "decklist_cards", force: true do |t|
    t.integer  "decklist_id"
    t.integer  "card_id"
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "decklist_cards", ["card_id"], name: "index_decklist_cards_on_card_id"
  add_index "decklist_cards", ["decklist_id"], name: "index_decklist_cards_on_decklist_id"

  create_table "decklists", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
