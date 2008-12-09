# == Schema Info
# Schema version: 20081209013142
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

class User < ActiveRecord::Base
  attr_protected :is_admin  
  validates_presence_of :email_address
  has_many :pins, :dependent => :destroy
end