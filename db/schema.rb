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

ActiveRecord::Schema.define(version: 20171209114632) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "invoice_templates", force: :cascade do |t|
    t.string   "name"
    t.text     "template"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "invoices", force: :cascade do |t|
    t.decimal  "kurs_eur"
    t.decimal  "base_price"
    t.decimal  "unit_price_eur"
    t.decimal  "unit_price_rsd"
    t.decimal  "price_eur"
    t.decimal  "price_rsd"
    t.integer  "workdays"
    t.integer  "workdays_total"
    t.integer  "number"
    t.datetime "date"
    t.text     "template"
    t.integer  "invoice_template_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.index ["invoice_template_id"], name: "index_invoices_on_invoice_template_id", using: :btree
  end

end
