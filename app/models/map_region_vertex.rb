# == Schema Info
# Schema version: 20081209013142
#
# Table name: map_region_vertices
#
#  id            :integer(4)      not null, primary key
#  map_region_id :integer(4)      not null
#  lat           :float
#  long          :float
#  position      :integer(4)
#  created_at    :datetime
#  updated_at    :datetime

class MapRegionVertex < ActiveRecord::Base
  belongs_to :map_region
  acts_as_list :scope => :map_region_id
  composed_of :latlong, :mapping => [%w(long long), %w(lat lat)], :class_name => Math::Latlong.name {|vertex| Math::Latlong.new(vertex.long, vertex.lat) }
  
  validates_presence_of :map_region, :lat, :long
  validates_associated :map_region
end
