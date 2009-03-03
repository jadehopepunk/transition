class RegionAdmin::AreasController < RegionAdmin::RegionAdminController
  
  def new
    @area = @region.build_area
  end
  
  def create
    @area.region = @region
    super
  end
    
end
