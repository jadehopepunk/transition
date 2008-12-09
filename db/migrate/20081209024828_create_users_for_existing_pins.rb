class CreateUsersForExistingPins < ActiveRecord::Migration
  def self.up
    for pin in Pin.find(:all)
      pin.save!
    end
  end

  def self.down
  end
end
