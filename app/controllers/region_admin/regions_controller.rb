class RegionAdmin::RegionsController < RegionAdmin::RegionAdminController
  
  protected
  
    def redirect_url
      { :action => 'show', :id => params[:id] }
    end
    
end
