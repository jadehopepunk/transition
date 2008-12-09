module AdminHelper
  
  def available_admin_controllers
    results = []
    results << :users if is_admin?
    results << :regions
    results
  end
    
end
