class AddPermalinkColumnToMapRegions < ActiveRecord::Migration
  def self.up
    add_column :map_regions, :permalink, :string
    add_index :map_regions, :permalink
  end

  def self.down
    remove_index :map_regions, :permalink
    remove_column :map_regions, :permalink
  end
end
