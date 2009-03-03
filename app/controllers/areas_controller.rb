class AreasController < ApplicationController
  before_filter :load_region
  before_filter :load_area, :only => [:show]
  
  def show
    respond_to do |format|
      format.html { render :template => 'regions/show.html.erb' }
      format.iframe { render :template => 'regions/show.iframe.erb' }
    end
  end
  
  protected 
  
    def load_region
      @region = Region.find_by_param(params[:region_id])
    end  

    def load_area
      @area = @region.areas.find_by_param(params[:id])
    end
  
    def title
      @area ? "Local food around #{@area.name}" : "Local food maps"
    end
  
end
