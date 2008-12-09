class Admin::RegionsController <  Admin::AdminController
  before_filter :admin_required, :except => [:edit, :update, :show, :index]
  before_filter :login_required, :except => [:index]
  before_filter :load_region, :only => [:destroy, :edit, :update]
  before_filter :region_admin_required, :only => [:edit, :update, :update]
  
  def index
    if is_admin?
      @regions = Region.find(:all, :order => :name)
    else
      @regions = Region.find(:all, :order => :name, :conditions => ["id IN (SELECT region_id FROM region_privileges WHERE user_id = ?)", current_user])
    end
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
