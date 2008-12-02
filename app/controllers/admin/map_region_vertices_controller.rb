class Admin::MapRegionVerticesController < Admin::AdminController
  before_filter :load_map_region
  
  def index
  end
  
  def create
    # @inserting_after = @map_region.vertices.last
    # @vertex = @map_region.vertices.insert_between_closest(Math::Latlong.new(params[:longitude].to_f, params[:latitude].to_f))
    @vertex = @map_region.vertices.create(:long => params[:longitude].to_f, :lat => params[:latitude].to_f)
    @map_region.vertices(true)
    respond_to :js
  end
  
  def delete_all
    @map_region.vertices.clear
  end

  protected
  
    def load_map_region
      @map_region = MapRegion.find(params[:map_region_id])
    end

end
