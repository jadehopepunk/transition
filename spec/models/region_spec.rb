# == Schema Info
# Schema version: 20090207010313
#
# Table name: regions
#
#  id           :integer(4)      not null, primary key
#  center_lat   :float
#  center_lon   :float
#  city         :string(255)
#  country      :string(255)
#  default_zoom :integer(4)
#  name         :string(255)
#  permalink    :string(255)
#  created_at   :datetime
#  updated_at   :datetime

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Region do
  it "should create a new instance given valid attributes" do
    model_factory.region
  end
end
