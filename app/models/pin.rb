class Pin < ActiveRecord::Base
  RESOURCE_TYPES = [:grow_food, :make_food, :sell_food, :gardening_instruction, :gardening_products]
  COLOURS = [:green, :yellow, :blue, :red, :purple]
  
  belongs_to :map_region
  
  validate :has_a_resource_type
  validates_presence_of :name, :map_region, :street_address, :suburb, :city, :country
  validates_presence_of :lat, :long, :colour, :code
  validates_inclusion_of :colour, :in => COLOURS.map(&:to_s)
  validates_uniqueness_of :code, :scope => [:map_region_id, :colour]
  
  before_validation_on_create :assign_colour
  
  def self.find_by_param(param)
    unless param.blank?
      colour, code = param.split('-')
      result = find(:first, :conditions => {:colour => colour, :code => code})
    end
    raise ActiveRecord::RecordNotFound unless result
    result
  end
  
  def address
    {:street_address => street_address, :suburb => suburb, :city => city, :country => country}
  end
  
  def to_json(options = {})
    super(:methods => [:to_param, :url])
  end
  
  def to_param
    "#{colour}-#{code}"
  end
  
  def url
    "/pins/#{to_param}"
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
    
    def assign_code
      self.code = next_available_code if !self.code && self.colour
    end
    
    def assign_colour
      self.colour = COLOURS[RESOURCE_TYPES.index(first_resource_type)].to_s
      assign_code
    end
    
    def next_available_code
      values = Pin.connection.select_values("SELECT code FROM pins WHERE code IS NOT NULL AND colour = '#{colour}' ORDER BY code ASC").map(&:to_i)
      max = values.last || 0
      ((1..max + 1).to_a - values).first || 1
    end
  
end
