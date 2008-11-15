class MapRegionVertex < ActiveRecord::Base
  belongs_to :map_region
  acts_as_list
  composed_of :latlong, :mapping => [%w(long long), %w(lat lat)], :class_name => Math::Latlong.name {|vertex| Math::Latlong.new(vertex.long, vertex.lat) }
  
  validates_presence_of :map_region, :lat, :long
  validates_associated :map_region
end
