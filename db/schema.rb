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

ActiveRecord::Schema.define(:version => 20081201070917) do

  create_table "map_region_vertices", :force => true do |t|
    t.integer  "map_region_id", :null => false
    t.integer  "position"
    t.float    "lat"
    t.float    "long"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "map_region_vertices", ["map_region_id"], :name => "map_region_id"

  create_table "map_regions", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
    t.integer  "map_region_id"
    t.float    "lat"
    t.float    "long"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pins", ["map_region_id"], :name => "map_region_id"

  add_foreign_key "map_region_vertices", ["map_region_id"], "map_regions", ["id"], :name => "map_region_vertices_ibfk_1"

  add_foreign_key "pins", ["map_region_id"], "map_regions", ["id"], :name => "pins_ibfk_1"

end
