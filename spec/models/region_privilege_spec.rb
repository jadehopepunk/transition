# == Schema Info
# Schema version: 20090207010313
#
# Table name: region_privileges
#
#  id         :integer(4)      not null, primary key
#  region_id  :integer(4)
#  user_id    :integer(4)
#  created_at :datetime
#  updated_at :datetime

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe RegionPrivilege do
  before(:each) do
    @valid_attributes = {
      :region => model_factory.region,
      :user => model_factory.user
    }
  end

  it "should create a new instance given valid attributes" do
    RegionPrivilege.create!(@valid_attributes)
  end
end
