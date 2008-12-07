require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Pin do
  before(:each) do
    @valid_attributes = {
      :name => "Craig's Vegie Garden",
      :grow_food => true,
      :map_region => model_factory.map_region,
      :lat => 10.0,
      :long => 20.0,
      :street_address => '17 Kay Rd',
      :suburb => 'Swanson',
      :city => 'Waitakere',
      :country => 'New Zealand'
    }
  end

  it "should create a new instance given valid attributes" do
    Pin.create!(@valid_attributes)
  end
  
  it "should save code as next available number" do
    pin = model_factory.pin
    pin.code.should == 1

    pin2 = model_factory.pin
    pin2.code.should == 2
  end
  
  it "should save colour" do
    model_factory.pin(:grow_food => true).colour.should == :green
  end
  
end
