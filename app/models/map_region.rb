class MapRegion < ActiveRecord::Base
  has_many :vertices, :class_name => MapRegionVertex.name, :dependent => :destroy, :order => "position ASC", :extend => VertexCollection
  has_many :pins

  validates_presence_of :name
    
end
