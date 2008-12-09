class Admin::UsersController < Admin::AdminController
  before_filter :admin_required
  before_filter :load_user, :only => [:edit, :update, :destroy]
  
  def index
    @users = User.find(:all, :order => "created_at ASC")
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.create(params[:user])
    @user.is_admin = params[:user][:is_admin]
    if @user.new_record?
      render :action => :new
    else
      redirect_to_index
    end
  end
  
  def edit
  end
  
  def update
    @user.update_attributes(params[:user])
    if !@user.valid?
      render :action => :edit
    else
      redirect_to_index
    end
  end
  
  def destroy
    @user.destroy
    redirect_to_index
  end
  
  protected
  
    def load_user
      @user = User.find(params[:id])
    end
    
    def redirect_to_index
      redirect_to admin_users_path
    end
  
end
