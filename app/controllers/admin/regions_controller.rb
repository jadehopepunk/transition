class Admin::RegionsController <  Admin::AdminController
  before_filter :load_region, :only => [:destroy, :edit, :update]
  
  def index
    @regions = Region.find(:all)
  end
  
  def new
    @region = Region.new
  end
  
  def create
    @region = Region.create(params[:region])
    if @region.new_record?
      render :action => :new
    else
      redirect_to :action => :index
    end
  end
  
  def edit
  end
  
  def update
    @region.update_attributes(params[:region])
    if !@region.valid?
      render :action => :edit
    else
      redirect_to :action => :index
    end    
  end
  
  def destroy
    @region.destroy
    redirect_to :action => :index
  end
  
  protected
  
    def load_region
      @region = Region.find_by_param(params[:id])
    end
  
end
