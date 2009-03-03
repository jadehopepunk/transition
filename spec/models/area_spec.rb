# == Schema Info
# Schema version: 20090303034616
#
# Table name: areas
#
#  id            :integer(4)      not null, primary key
#  region_id     :integer(4)
#  center_lat    :float
#  center_lon    :float
#  default_zoom  :integer(4)
#  name          :string(255)
#  permalink     :string(255)
#  show_on_index :boolean(1)      default(TRUE)
#  created_at    :datetime
#  updated_at    :datetime

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Area do
  before(:each) do
    @valid_attributes = {
    }
  end

  it "should create a new instance given valid attributes" do
    Area.create!(@valid_attributes)
  end
end
