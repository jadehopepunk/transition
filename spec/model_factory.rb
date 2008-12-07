module ModelFactoryMixin
  
  def model_factory
    ModelFactory.new
  end
  
  class ModelFactory
    @@next_integer = 0
    
    def map_region(options = {})
      create MapRegion, options, :name => "Waitakere"
    end
    
    def pin(options = {})
      create Pin, options, :name => "Craig's Vegie Garden",
        :grow_food => true,
        :map_region => map_region,
        :lat => 10.0,
        :long => 20.0,
        :street_address => '17 Kay Rd',
        :suburb => 'Swanson',
        :city => 'Waitakere',
        :country => 'New Zealand'      
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