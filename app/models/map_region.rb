# == Schema Info
# Schema version: 20081209013142
#
# Table name: map_regions
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime

class MapRegion < ActiveRecord::Base
  has_many :vertices, :class_name => MapRegionVertex.name, :dependent => :destroy, :order => "position ASC", :extend => VertexCollection
  has_many :pins

  validates_presence_of :name
  has_permalink :name, :unique => true
  
  def to_param
    permalink
  end
  
  def self.find_by_param(param)
    result = MapRegion.find_by_permalink(param)
    raise ActiveRecord::RecordNotFound unless result
    result
  end
  
  
    
end
