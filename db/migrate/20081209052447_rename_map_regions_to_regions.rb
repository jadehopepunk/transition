class RenameMapRegionsToRegions < ActiveRecord::Migration
  def self.up
    rename_table :map_regions, :regions
  end

  def self.down
    rename_table :regions, :map_regions
  end
end
