module ModelFactoryMixin
  
  def model_factory
    ModelFactory.new
  end
  
  class ModelFactory
    @@next_integer = 0
    
    def map_region(options = {})
      create MapRegion, options, :name => "Waitakere"
    end
        
    protected
    
      def next_index(model)
        (model.maximum(:index) || 0) + 1
      end
      
      def create(klass, options, attributes = {})
        klass.create!(attributes.merge(options))
      end
      
      def next_integer
        @@next_integer += 1
      end
    
  end
  
end