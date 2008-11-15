class Admin::MapRegionVerticesController < Admin::AdminController
  before_filter :load_map_region
  
  def index
  end
  
  def create
    @vertex = @map_region.vertices.insert_between_closest(Math::Latlong.new(params[:longitude].to_f, params[:latitude].to_f))
  end

  protected
  
    def load_map_region
      @map_region = MapRegion.find(params[:map_region_id])
    end

end
