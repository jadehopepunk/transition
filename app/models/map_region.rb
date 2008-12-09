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
    
end
