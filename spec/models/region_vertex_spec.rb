# == Schema Info
# Schema version: 20081209054404
#
# Table name: region_vertices
#
#  id            :integer(4)      not null, primary key
#  map_region_id :integer(4)      not null
#  lat           :float
#  long          :float
#  position      :integer(4)
#  created_at    :datetime
#  updated_at    :datetime

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe RegionVertex do
  before(:each) do
    @valid_attributes = {
      :region => model_factory.region,
      :lat => 1.0,
      :long => 1.0
    }
  end

  it "should create a new instance given valid attributes" do
    RegionVertex.create!(@valid_attributes)
  end
end
