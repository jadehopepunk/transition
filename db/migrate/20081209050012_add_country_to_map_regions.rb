class AddCountryToMapRegions < ActiveRecord::Migration
  def self.up
    add_column :regions, :country, :string
  end

  def self.down
    remove_column :regions, :country
  end
end
