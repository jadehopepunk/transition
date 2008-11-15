class CreateMapRegions < ActiveRecord::Migration
  def self.up
    create_table :map_regions do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :map_regions
  end
end
