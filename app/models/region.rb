# == Schema Info
# Schema version: 20090303034616
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

class Region < ActiveRecord::Base
  has_many :vertices, :class_name => RegionVertex.name, :dependent => :destroy, :order => "position ASC", :extend => VertexCollection, :foreign_key => :region_id
  has_many :pins
  has_many :region_privileges
  has_many :administrators, :through => :region_privileges, :class_name => 'User', :source => :user
  has_many :areas

  validates_presence_of :name, :center_lat, :center_lon, :default_zoom, :country
  has_permalink :name, :unique => true
  
  def to_param
    permalink
  end
  
  def self.find_by_param(param)
    result = Region.find_by_permalink(param)
    raise ActiveRecord::RecordNotFound unless result
    result
  end
  
  def has_city?
    !city.blank?
  end
  
  def has_country?
    !country.blank?
  end
  
  def build_area
    areas.build(:center_lat => center_lat, :center_lon => center_lon, :default_zoom => default_zoom)
  end
    
end
