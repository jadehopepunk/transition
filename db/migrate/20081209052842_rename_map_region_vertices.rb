class RenameMapRegionVertices < ActiveRecord::Migration
  def self.up
    rename_table :map_region_vertices, :region_vertices
  end

  def self.down
    rename_table :region_vertices, :map_region_vertices
  end
end
