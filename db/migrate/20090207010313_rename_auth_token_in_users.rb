class RenameAuthTokenInUsers < ActiveRecord::Migration
  def self.up
    rename_column :users, :auth_token, :validation_code
  end

  def self.down
    rename_column :users, :validation_code, :auth_token
  end
end
