class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :name, :email_address, :password, :auth_token
      t.boolean :is_admin
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
