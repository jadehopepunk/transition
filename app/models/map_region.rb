class MapRegion < ActiveRecord::Base
  has_many :map_region_vertices, :dependent => :destroy
  validates_presence_of :name
end
