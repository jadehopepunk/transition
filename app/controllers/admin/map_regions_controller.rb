class Admin::MapRegionsController <  Admin::AdminController
  before_filter :load_map_region, :only => [:destroy, :edit, :update]
  
  def index
    @map_regions = MapRegion.find(:all)
  end
  
  def new
    @map_region = MapRegion.new
  end
  
  def create
    @map_region = MapRegion.create(params[:map_region])
    if @map_region.new_record?
      render :action => :new
    else
      redirect_to :action => :index
    end
  end
  
  def edit
  end
  
  def update
    @map_region.update_attributes(params[:map_region])
    if !@map_region.valid?
      render :action => :edit
    else
      redirect_to :action => :index
    end    
  end
  
  def destroy
    @map_region.destroy
    redirect_to :action => :index
  end
  
  protected
  
    def load_map_region
      @map_region = MapRegion.find_by_param(params[:id])
    end
  
end
