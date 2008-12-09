# == Schema Info
# Schema version: 20081209013142
#
# Table name: map_regions
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe MapRegion do
  before(:each) do
    @valid_attributes = {
      :name => "Waitakere"
    }
  end

  it "should create a new instance given valid attributes" do
    MapRegion.create!(@valid_attributes)
  end
end
