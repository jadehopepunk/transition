class Pin < ActiveRecord::Base
  RESOURCE_TYPES = [:grow_food, :make_food, :sell_food, :gardening_instruction, :gardening_products]
  
  belongs_to :map_region
  
  validate :has_a_resource_type
  validates_presence_of :name, :map_region
  
  protected
  
    def has_a_resource_type
      if RESOURCE_TYPES.map {|key| send(key)}.select {|value| value}.empty?
        errors.add_to_base("You must select at least one of the checkboxes below")
      end
    end
  
end
