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

class Area < ActiveRecord::Base
  has_permalink :name, :unique => true
  belongs_to :region
  
  validates_presence_of :region, :name, :permalink, :center_lat, :center_lon

  def to_param
    permalink
  end
  
  def self.find_by_param(param)
    result = Area.find_by_permalink(param)
    raise ActiveRecord::RecordNotFound unless result
    result
  end

end
