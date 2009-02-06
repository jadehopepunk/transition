module AdminHelper
  
  def available_admin_controllers
    results = [:users, :regions]
  end

  def available_region_admin_controllers
    results = [:pins]
  end
    
end
