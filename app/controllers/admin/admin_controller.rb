class Admin::AdminController < ApplicationController
  layout 'admin'
  
  protected
  
    def region_admin_required
      if logged_in? && ((@region && RegionPrivilege.can_administer?(current_user, @region)) || is_admin?)
        return true
      else
        return access_denied
      end
    end
    
  
end