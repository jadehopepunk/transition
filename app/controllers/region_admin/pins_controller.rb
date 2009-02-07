class RegionAdmin::PinsController < RegionAdmin::RegionAdminController
  before_filter :load_pin, :only => [:edit, :update, :destroy]
  
  def index
    @pins = @region.pins
  end
  
  def edit
  end
  
  def update
    @pin.update_attributes(params[:pin])

    if @pin.valid?
      redirect_to :action => :index
    else
      render :action => :edit
    end
  end
  
  def destroy
    @pin.destroy
    redirect_to :action => :index
  end
  
  def new
    @pin = Pin.new(:region => @region)
    @pin.country = @pin.region.country if @pin.region
  end
  
  def create
    @pin = Pin.new(params[:pin])
    @pin.added_by_admin = true
    if @pin.save
      redirect_to :action => :index
    else
      render :action => :new
    end
  end
  
  protected
  
    def load_pin
      @pin = Pin.find_by_param(params[:id])
    end
  
end
