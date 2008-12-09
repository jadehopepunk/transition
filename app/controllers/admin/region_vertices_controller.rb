class Admin::RegionVerticesController < Admin::AdminController
  before_filter :load_region
  
  def index
  end
  
  def create
    # @inserting_after = @region.vertices.last
    # @vertex = @region.vertices.insert_between_closest(Math::Latlong.new(params[:longitude].to_f, params[:latitude].to_f))
    @vertex = @region.vertices.create(:long => params[:longitude].to_f, :lat => params[:latitude].to_f)
    @region.vertices(true)
    respond_to :js
  end
  
  def delete_all
    @region.vertices.clear
  end

  protected
  
    def load_region
      @region = Region.find(params[:region_id])
    end

end
