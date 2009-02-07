class UsersController < ApplicationController
  before_filter :load_user
  
  def approve
    @user.approve_token = params[:approve_token]
    render :layout => 'minimal'
  end
  
  def update_password    
    if @user.approve(params[:user])
      self.current_user = @user
      redirect_to '/'
    else
      render :action => 'approve', :layout => 'minimal'
    end
  end
  
  protected
  
    def load_user
      @user = User.find(params[:id])
    end
  
end
