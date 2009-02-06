class CreateVersionsTableForPins < ActiveRecord::Migration
  def self.up
    Pin.create_versioned_table
  end

  def self.down
    Pin.drop_versioned_table
  end
end
