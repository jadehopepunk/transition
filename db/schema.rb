# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090207010313) do

  create_table "pin_emails", :force => true do |t|
    t.integer  "pin_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pin_emails", ["pin_id"], :name => "pin_id"
  add_index "pin_emails", ["user_id"], :name => "user_id"

  create_table "pin_versions", :force => true do |t|
    t.integer  "pin_id"
    t.integer  "version"
    t.boolean  "grow_food"
    t.boolean  "make_food"
    t.boolean  "sell_food"
    t.boolean  "gardening_instruction"
    t.boolean  "gardening_products"
    t.text     "description"
    t.string   "group_type"
    t.string   "name"
    t.string   "street_address"
    t.string   "suburb"
    t.string   "city"
    t.string   "email_address"
    t.string   "country"
    t.integer  "region_id"
    t.float    "lat"
    t.float    "long"
    t.datetime "updated_at"
    t.string   "colour"
    t.integer  "code"
    t.integer  "user_id"
  end

  add_index "pin_versions", ["pin_id"], :name => "index_pin_versions_on_pin_id"

  create_table "pins", :force => true do |t|
    t.boolean  "grow_food"
    t.boolean  "make_food"
    t.boolean  "sell_food"
    t.boolean  "gardening_instruction"
    t.boolean  "gardening_products"
    t.text     "description"
    t.string   "group_type"
    t.string   "name"
    t.string   "street_address"
    t.string   "suburb"
    t.string   "city"
    t.string   "email_address"
    t.string   "country"
    t.integer  "region_id"
    t.float    "lat"
    t.float    "long"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "colour"
    t.integer  "code"
    t.integer  "user_id"
    t.integer  "version"
    t.boolean  "added_by_admin",        :default => false
  end

  add_index "pins", ["region_id"], :name => "region_id"
  add_index "pins", ["user_id"], :name => "user_id"

  create_table "region_privileges", :force => true do |t|
    t.integer  "region_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "region_privileges", ["region_id"], :name => "region_id"
  add_index "region_privileges", ["user_id"], :name => "user_id"

  create_table "region_vertices", :force => true do |t|
    t.integer  "region_id",  :null => false
    t.integer  "position"
    t.float    "lat"
    t.float    "long"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "region_vertices", ["region_id"], :name => "region_id"

  create_table "regions", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "permalink"
    t.float    "center_lat"
    t.float    "center_lon"
    t.integer  "default_zoom"
    t.string   "country"
    t.string   "city"
  end

  add_index "regions", ["permalink"], :name => "index_regions_on_permalink"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email_address"
    t.string   "password"
    t.string   "validation_code"
    t.boolean  "is_admin"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_foreign_key "pin_emails", ["pin_id"], "pins", ["id"], :name => "pin_emails_ibfk_1"
  add_foreign_key "pin_emails", ["user_id"], "users", ["id"], :name => "pin_emails_ibfk_2"

  add_foreign_key "pin_versions", ["pin_id"], "pins", ["id"], :name => "pin_versions_ibfk_1"

  add_foreign_key "pins", ["region_id"], "regions", ["id"], :name => "pins_ibfk_1"
  add_foreign_key "pins", ["user_id"], "users", ["id"], :name => "pins_ibfk_2"

  add_foreign_key "region_privileges", ["region_id"], "regions", ["id"], :name => "region_privileges_ibfk_1"
  add_foreign_key "region_privileges", ["user_id"], "users", ["id"], :name => "region_privileges_ibfk_2"

  add_foreign_key "region_vertices", ["region_id"], "regions", ["id"], :name => "region_vertices_ibfk_1"

end
