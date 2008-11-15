class CreateMapRegionVertices < ActiveRecord::Migration
  def self.up
    create_table :map_region_vertices do |t|
      t.integer :map_region_id, :null => false
      t.integer :postion
      t.decimal :lat, :long

      t.timestamps
    end
  end

  def self.down
    drop_table :map_region_vertices
  end
end
