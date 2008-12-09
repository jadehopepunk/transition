class RegionsController < ApplicationController
  before_filter :load_region, :only => :show
  
  def show
  end
  
  protected
  
    def load_region
      @region = Region.find_by_param(params[:id])
    end

    def title
      "Local food in #{@region.name}"
    end
  
end
