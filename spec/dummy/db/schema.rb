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

ActiveRecord::Schema.define(version: 20140609222606) do

  create_table "companies", force: true do |t|
    t.string   "name"
    t.integer  "dns_record_id"
    t.boolean  "active",        default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "companies", ["dns_record_id"], name: "index_companies_on_dns_record_id", using: :btree

  create_table "mango_handcart_dns_records", force: true do |t|
    t.string   "name"
    t.string   "subdomain"
    t.string   "domain"
    t.integer  "tld_size"
    t.boolean  "active",     default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mango_handcart_ip_addresses", force: true do |t|
    t.string   "address"
    t.string   "subnet_mask"
    t.integer  "handcart_id"
    t.boolean  "blacklisted", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "mango_handcart_ip_addresses", ["handcart_id"], name: "index_mango_handcart_ip_addresses_on_handcart_id", using: :btree

end
