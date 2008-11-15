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
