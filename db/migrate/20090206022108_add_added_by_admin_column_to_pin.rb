class AddAddedByAdminColumnToPin < ActiveRecord::Migration
  def self.up
    add_column :pins, :added_by_admin, :boolean, :default => false
  end

  def self.down
    remove_column :pins, :added_by_admin
  end
end
