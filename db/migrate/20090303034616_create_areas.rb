class CreateAreas < ActiveRecord::Migration
  def self.up
    create_table :areas do |t|
      t.string :name, :permalink
      t.float :center_lat, :center_lon
      t.integer :default_zoom, :region_id
      t.boolean :show_on_index, :default => true

      t.timestamps
    end
  end

  def self.down
    drop_table :areas
  end
end
