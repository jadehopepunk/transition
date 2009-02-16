class AddCityToMapRegions < ActiveRecord::Migration
  def self.up
    add_column :regions, :city, :string
  end

  def self.down
    remove_column :regions, :city
  end
end
