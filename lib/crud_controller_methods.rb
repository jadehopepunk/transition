module CrudControllerMethods
  def self.included(base)
    base.send :before_filter, :build_object, :only => [ :new, :create ]
    base.send :before_filter, :load_object, :only => [ :show, :edit, :update, :destroy ]
  end
  
  def index
    load_object_collection
  end
  
  def show
  end
  
  def create
    @success = @obj.save
    
    respond_to do |format|
      format.html do
        if @success
          flash[:notice] = "The #{cname.humanize.downcase} has been created."
          redirect_back_or_default redirect_url
        else
          render :action => 'new'
        end
      end
      format.js do
        load_object_collection        
      end
    end
  end

  def update
    if @obj.update_attributes(params[cname])
      flash[:notice] = "The #{cname.humanize.downcase} has been updated."
      redirect_back_or_default redirect_url
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @result = @obj.destroy
    respond_to do |wants|
      wants.html do
        if @result
          flash[:notice] = "The #{cname.humanize.downcase} has been deleted."
          redirect_back_or_default redirect_url
        else
          render :action => 'show'
        end
      end
      
      wants.js do
        render :update do |page|
          if @result
            page.remove "#{@cname}_#{@obj.id}"
          else
            page.alert "Errors deleting #{@obj.class.to_s.downcase}: #{@obj.errors.full_messages.to_sentence}"
          end
        end
      end
    end
  end
  
  protected
  
    def load_object_collection
      self.instance_variable_set('@' + self.controller_name, scoper.find(:all, object_collection_finder_params))
    end
    
    def object_collection_finder_params
      {:order => 'name'}
    end
  
    def cname
      @cname ||= controller_name.singularize
    end
    
    def set_object
      @obj ||= self.instance_variable_get('@' + cname)
    end
    
    def load_object
      @obj = self.instance_variable_set('@' + cname,  scoper.send(find_method, params[:id]))
    end
    
    def find_method
      scoper.respond_to?(:find_by_param) ? :find_by_param : :find
    end
    
    def build_object
      @obj = self.instance_variable_set('@' + cname,
        scoper.is_a?(Class) ? scoper.new(params[cname]) : scoper.build(params[cname]))
    end
    
    def scoper
      Object.const_get(cname.classify)
    end
    
    def redirect_url
      { :action => 'index' }
    end
    
end