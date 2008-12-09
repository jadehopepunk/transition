class MapRegionsController < ApplicationController
  before_filter :load_map_region, :only => :show
  
  def show
  end
  
  protected
  
    def load_map_region
      @map_region = MapRegion.find_by_param(params[:id])
    end

    def title
      "Local food in #{@map_region.name}"
    end
  
end
