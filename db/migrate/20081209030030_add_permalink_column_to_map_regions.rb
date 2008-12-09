class AddPermalinkColumnToMapRegions < ActiveRecord::Migration
  def self.up
    add_column :regions, :permalink, :string
    add_index :regions, :permalink
  end

  def self.down
    remove_index :regions, :permalink
    remove_column :regions, :permalink
  end
end
