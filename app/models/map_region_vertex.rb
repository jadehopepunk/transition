class MapRegionVertex < ActiveRecord::Base
  belongs_to :map_region
  validates_presence_of :map_region, :lat, :long
  validates_associated :map_region
end
