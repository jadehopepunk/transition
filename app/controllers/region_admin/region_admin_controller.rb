class RegionAdmin::RegionAdminController < ApplicationController
  layout 'region_admin'
  include CrudControllerMethods
  before_filter :load_region
  before_filter :region_admin_required
  
  protected
  
    def region_admin_required
      if logged_in? && ((@region && RegionPrivilege.can_administer?(current_user, @region)) || is_admin?)
        return true
      else
        return access_denied
      end
    end
    
    def load_region
      @region = Region.find_by_param(params[:region_id]) unless @region
    end
  
end