class PinsController < ApplicationController
  before_filter :load_map_region
  
  def new
    @pin = Pin.new(:map_region_id => params[:map_region_id])
  end
  
  def create
    @pin = Pin.create(params[:pin])
    if @pin.new_record?
      render :action => :new
    else
      redirect_to pin_path(@pin)
    end
  end
  
  protected
  
    def title
      "Resources for Resiliance"
    end
    
    def load_map_region
      @map_region = @pin.map_region if @pin
      @map_region = MapRegion.find(params[:map_region_id]) if params[:map_region_id]
    end  
  
end
