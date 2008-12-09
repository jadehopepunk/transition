class AddUserIdToPins < ActiveRecord::Migration
  def self.up
    add_column :pins, :user_id, :integer
  end

  def self.down
    remove_column :pins, :user_id
  end
end
