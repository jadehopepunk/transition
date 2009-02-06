# == Schema Info
# Schema version: 20090206022108
#
# Table name: pins
#
#  id                    :integer(4)      not null, primary key
#  region_id             :integer(4)
#  user_id               :integer(4)
#  added_by_admin        :boolean(1)
#  city                  :string(255)
#  code                  :integer(4)
#  colour                :string(255)
#  country               :string(255)
#  description           :text
#  email_address         :string(255)
#  gardening_instruction :boolean(1)
#  gardening_products    :boolean(1)
#  group_type            :string(255)
#  grow_food             :boolean(1)
#  lat                   :float
#  long                  :float
#  make_food             :boolean(1)
#  name                  :string(255)
#  sell_food             :boolean(1)
#  street_address        :string(255)
#  suburb                :string(255)
#  version               :integer(4)
#  created_at            :datetime
#  updated_at            :datetime

class Pin < ActiveRecord::Base
  RESOURCE_TYPES = [:grow_food, :make_food, :sell_food, :gardening_instruction, :gardening_products]
  COLOURS = [:green, :yellow, :blue, :red, :purple]
  
  acts_as_versioned
  self.non_versioned_columns << 'added_by_admin'
  
  belongs_to :region
  belongs_to :user
  
  validate :has_a_resource_type
  validates_presence_of :name, :region, :street_address, :suburb, :city, :country
  validates_presence_of :lat, :long, :colour, :code
  validates_inclusion_of :colour, :in => COLOURS.map(&:to_s)
  validates_uniqueness_of :code, :scope => [:region_id, :colour]
  
  before_validation_on_create :assign_colour
  before_save :set_user_from_email
  after_create :send_pin_email
  
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
  
  def resource_types
    RESOURCE_TYPES.select {|key| send(key)}
  end
  
  def human_readable_resource_types
    resource_types.map do |resource_type|
      humanize_resource_type(resource_type)
    end
  end
  
  def can_be_edited_by?(current_user)
    user && current_user == user
  end

  protected
  
    def humanize_resource_type(resource_type)
      result = resource_type.to_s
      result = "provide_#{result}" if result.starts_with?('gardening')
      result.humanize      
    end
  
    def first_resource_type
      for type in RESOURCE_TYPES
        return type if send(type)
      end
      nil
    end
  
    def has_a_resource_type
      if resource_types.empty?
        errors.add_to_base("You must select at least one of the checkboxes below")
      end
    end
    
    def assign_code
      self.code = next_available_code if !self.code && self.colour
    end
    
    def assign_colour      
      self.colour = COLOURS[RESOURCE_TYPES.index(first_resource_type)].to_s if first_resource_type
      assign_code
    end
    
    def next_available_code
      values = Pin.connection.select_values("SELECT code FROM pins WHERE code IS NOT NULL AND colour = '#{colour}' ORDER BY code ASC").map(&:to_i)
      max = values.last || 0
      ((1..max + 1).to_a - values).first || 1
    end
    
    def set_user_from_email
      if email_address && !user
        self.user = User.find_by_email_address(email_address) || User.create(:email_address => email_address, :name => name)
      end
    end
    
    def send_pin_email
      PinEmail.pin_created(self)
    end
  
end
