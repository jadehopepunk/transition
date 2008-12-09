class PinsController < ApplicationController
  before_filter :load_region, :only => [:new]
  before_filter :load_pin, :only => [:show]
  
  def new
    @pin = Pin.new(:region => find_region)
    @pin.country = @pin.region.country if @pin.region
  end
  
  def create
    @pin = Pin.create(params[:pin])
    if @pin.new_record?
      render :action => :new
    else
      redirect_to '/'
    end
  end
  
  def show
  end
  
  protected
  
    def title
      "Resources for Resiliance"
    end
    
    def load_region
      @region = @pin.region if @pin
      @region = find_region
    end
    
    def find_region
      Region.find_by_param(params[:region_id]) if params[:region_id]
    end
    
    def load_pin
      @pin = Pin.find_by_param(params[:id])
    end
  
end
