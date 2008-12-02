require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Pin do
  before(:each) do
    @valid_attributes = {
      :name => "Craig's Vegie Garden",
      :grow_food => true,
      :map_region => model_factory.map_region,
      :lat => 10.0,
      :long => 20.0
    }
  end

  it "should create a new instance given valid attributes" do
    Pin.create!(@valid_attributes)
  end
end
