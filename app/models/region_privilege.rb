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

class RegionPrivilege < ActiveRecord::Base
  belongs_to :region
  belongs_to :user
  
  validates_presence_of :region, :user
  validates_uniqueness_of :user_id, :scope => :region_id
  
  def self.can_administer?(user, region)
    RegionPrivilege.find(:first, :conditions => {:user_id => user.id, :region_id => region.id})
  end
  
end
