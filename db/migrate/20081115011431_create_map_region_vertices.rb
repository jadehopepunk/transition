class CreateMapRegionVertices < ActiveRecord::Migration
  def self.up
    create_table :region_vertices do |t|
      t.integer :region_id, :null => false
      t.integer :position
      t.float :lat, :long

      t.timestamps
    end
  end

  def self.down
    drop_table :region_vertices
  end
end
