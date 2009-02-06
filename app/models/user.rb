# == Schema Info
# Schema version: 20090206022108
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
  attr_accessor :password_confirmation, :approving, :approve_token
  
  validates_presence_of :email_address
  validates_uniqueness_of :email_address
  validates_presence_of :password, :if => :approving
  validates_confirmation_of :password, :if => :approving
  
  has_many :pins, :dependent => :destroy
  has_many :region_privileges, :dependent => :destroy
  
  before_create :generate_auth_token
  
  def self.authenticate(email_address, password)
    User.find(:first, :conditions => {:emaiL_address => email_address, :password => password})
  end
  
  def default_pin
    pins.first
  end
  
  def approved?
    !!password
  end
  
  def approve(params)
    if params['approve_token'] == auth_token
      self.approving = true
      update_attributes(params)
    end
  end
  
  def is_region_admin?
    !region_privileges.empty?
  end
  
  protected
  
    def generate_auth_token
      timestamp = Time.now.utc.to_i.to_s
      plaintext = timestamp + email_address
      self.auth_token = Digest::MD5.hexdigest(plaintext).strip      
    end
end
