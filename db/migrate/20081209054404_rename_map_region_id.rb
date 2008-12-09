class RenameMapRegionId < ActiveRecord::Migration
  def self.up
    add_column :pins, :region_id, :integer
    execute "UPDATE pins SET region_id = map_region_id"
    remove_column :pins, :map_region_id
  end

  def self.down
    add_column :pins, :map_region_id, :integer
    execute "UPDATE pins SET map_region_id = region_id"
    remove_column :pins, :region_id
  end
end
