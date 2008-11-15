require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe MapRegionVertex do
  before(:each) do
    @valid_attributes = {
      :map_region => model_factory.map_region,
      :lat => 1.0,
      :long => 1.0
    }
  end

  it "should create a new instance given valid attributes" do
    MapRegionVertex.create!(@valid_attributes)
  end
end
