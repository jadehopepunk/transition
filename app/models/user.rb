# == Schema Info
# Schema version: 20090207010313
#
# Table name: users
#
#  id              :integer(4)      not null, primary key
#  email_address   :string(255)
#  is_admin        :boolean(1)
#  name            :string(255)
#  password        :string(255)
#  validation_code :string(255)
#  created_at      :datetime
#  updated_at      :datetime

class User < ActiveRecord::Base
  attr_protected :is_admin, :auth_token 
  attr_accessor :password_confirmation, :approving, :approve_token
  
  validates_presence_of :email_address
  validates_uniqueness_of :email_address
  validates_presence_of :password, :if => :approving
  validates_confirmation_of :password, :if => :approving
  validate :matches_approval_token, :if => :approving
  
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
    self.approve_token = params['approve_token']
    self.approving = true
    update_attributes(params)
  end
  
  def is_region_admin?
    !region_privileges.empty?
  end
  
  protected
  
    def generate_auth_token
      raise "twice" unless self.validation_code.blank?
      timestamp = Time.now.utc.to_i.to_s
      plaintext = timestamp + email_address
      self.validation_code = Digest::MD5.hexdigest(plaintext).strip 
    end
    
    def matches_approval_token
      errors.add(:validation_code, "Validation code is incorrect, check the link in your email again, or contact #{AppConfig.admin_email} if it still doesn't work.") unless approve_token == validation_code
    end
end
