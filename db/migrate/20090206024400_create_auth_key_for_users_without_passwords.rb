class CreateAuthKeyForUsersWithoutPasswords < ActiveRecord::Migration
  def self.up
    for user in User.find(:all, :conditions => {:password => nil})
      user.send(:generate_auth_token)
      user.save
    end
  end

  def self.down
  end
end
