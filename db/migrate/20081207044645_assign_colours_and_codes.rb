class AssignColoursAndCodes < ActiveRecord::Migration
  def self.up
    for pin in Pin.find(:all)
      pin.send(:assign_colour)
      pin.save!
    end
  end

  def self.down
    execute "UPDATE pins SET colour = NULL, code = NULL"
  end
end
