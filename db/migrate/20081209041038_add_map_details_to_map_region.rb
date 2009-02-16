class AddMapDetailsToMapRegion < ActiveRecord::Migration
  def self.up
    add_column :regions, :center_lat, :float
    add_column :regions, :center_lon, :float
    add_column :regions, :default_zoom, :integer
  end

  def self.down
    remove_column :regions, :center_lat
    remove_column :regions, :center_lon
    remove_column :regions, :default_zoom
  end
end
