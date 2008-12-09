class AddMapDetailsToMapRegion < ActiveRecord::Migration
  def self.up
    add_column :map_regions, :center_lat, :float
    add_column :map_regions, :center_lon, :float
    add_column :map_regions, :default_zoom, :integer
  end

  def self.down
    remove_column :map_regions, :center_lat
    remove_column :map_regions, :center_lon
    remove_column :map_regions, :default_zoom
  end
end
