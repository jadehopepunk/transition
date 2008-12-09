# == Schema Info
# Schema version: 20081209041038
#
# Table name: pins
#
#  id                    :integer(4)      not null, primary key
#  map_region_id         :integer(4)
#  user_id               :integer(4)
#  city                  :string(255)
#  code                  :integer(4)
#  colour                :string(255)
#  country               :string(255)
#  description           :text
#  email_address         :string(255)
#  gardening_instruction :boolean(1)
#  gardening_products    :boolean(1)
#  group_type            :string(255)
#  grow_food             :boolean(1)
#  lat                   :float
#  long                  :float
#  make_food             :boolean(1)
#  name                  :string(255)
#  sell_food             :boolean(1)
#  street_address        :string(255)
#  suburb                :string(255)
#  created_at            :datetime
#  updated_at            :datetime

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Pin do
  it "should create a new instance given valid attributes" do
    pin = model_factory.pin
  end
  
  it "should save code as next available number" do
    pin = model_factory.pin
    pin.code.should == 1

    pin2 = model_factory.pin
    pin2.code.should == 2
  end
  
  it "should save colour" do
    model_factory.pin(:grow_food => true).colour.should == 'green'
  end
  
  it "should create a user if email address is specified" do
    pin = model_factory.pin(:email_address => "newaddress@somedomain.com")
    
    pin.reload
    pin.user.should_not be_nil
    pin.user.email_address.should == "newaddress@somedomain.com"
  end

  it "should load existing user if existing email address is specified" do
    user = model_factory.user(:email_address => "craig@craigambrose.com")
    pin = model_factory.pin(:email_address => "craig@craigambrose.com")
    
    pin.reload
    pin.user.should == user
  end
    
end
