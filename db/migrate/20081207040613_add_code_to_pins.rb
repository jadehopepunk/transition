class AddCodeToPins < ActiveRecord::Migration
  def self.up
    add_column :pins, :colour, :string
    add_column :pins, :code, :integer
  end

  def self.down
    remove_column :pins, :colour
    remove_column :pins, :code
  end
end
