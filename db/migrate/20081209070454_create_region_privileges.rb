class CreateRegionPrivileges < ActiveRecord::Migration
  def self.up
    create_table :region_privileges do |t|
      t.integer :region_id, :user_id
      
      t.timestamps
    end
  end

  def self.down
    drop_table :region_privileges
  end
end
