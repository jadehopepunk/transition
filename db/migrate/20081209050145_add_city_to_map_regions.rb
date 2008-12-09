class AddCityToMapRegions < ActiveRecord::Migration
  def self.up
    add_column :map_regions, :city, :string
  end

  def self.down
    remove_column :map_regions, :city
  end
end
