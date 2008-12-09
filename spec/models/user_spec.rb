# == Schema Info
# Schema version: 20081209050145
#
# Table name: users
#
#  id            :integer(4)      not null, primary key
#  auth_token    :string(255)
#  email_address :string(255)
#  is_admin      :boolean(1)
#  name          :string(255)
#  password      :string(255)
#  created_at    :datetime
#  updated_at    :datetime

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
  it "should create a new instance given valid attributes" do
    model_factory.user
  end
end
