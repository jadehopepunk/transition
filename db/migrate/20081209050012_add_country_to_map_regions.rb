class AddCountryToMapRegions < ActiveRecord::Migration
  def self.up
    add_column :map_regions, :country, :string
  end

  def self.down
    remove_column :map_regions, :country
  end
end
