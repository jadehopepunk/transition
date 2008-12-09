class CreatePins < ActiveRecord::Migration
  def self.up
    create_table :pins do |t|
      t.boolean :grow_food, :make_food, :sell_food, :gardening_instruction, :gardening_products
      t.text :description
      t.string :group_type, :name, :street_address, :suburb, :city, :email_address, :country
      t.integer :region_id
      t.float :lat, :long
      
      t.timestamps
    end
  end

  def self.down
    drop_table :pins
  end
end
