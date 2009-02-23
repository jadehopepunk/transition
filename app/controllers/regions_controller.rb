class RegionsController < ApplicationController
  before_filter :load_region, :only => :show
  
  def show
  end
  
  def index
    @regions = Region.find(:all)
  end
  
  protected
  
    def load_region
      @region = Region.find_by_param(params[:id])
    end

    def title
      @region ? "Local food in #{@region.name}" : "Local food maps"
    end
  
end
