class Pin < ActiveRecord::Base
  RESOURCE_TYPES = [:grow_food, :make_food, :sell_food, :gardening_instruction, :gardening_products]
  COLOURS = [:green, :yellow, :blue, :red, :purple]
  
  belongs_to :map_region
  
  validate :has_a_resource_type
  validates_presence_of :name, :map_region, :street_address, :suburb, :city, :country
  validates_presence_of :lat, :long
  
  def address
    {:street_address => street_address, :suburb => suburb, :city => city, :country => country}
  end
  
  def colour
    COLOURS[RESOURCE_TYPES.index(first_resource_type)]
  end
  
  def to_json(options = {})
    super(:methods => :code)
  end
  
  def code
    "#{colour}-#{id}"
  end
  
  protected
  
    def first_resource_type
      for type in RESOURCE_TYPES
        return type if send(type)
      end
      nil
    end
  
    def has_a_resource_type
      if RESOURCE_TYPES.map {|key| send(key)}.select {|value| value}.empty?
        errors.add_to_base("You must select at least one of the checkboxes below")
      end
    end
  
end
