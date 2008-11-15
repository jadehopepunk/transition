module Math
  class Vector2d
    attr_accessor :x, :y
    
    def initialize(new_x, new_y)
      self.x = new_x
      self.y = new_y
    end
  
    def distance_to(other_vector)
      vector_to(other_vector).length
    end
    
    def vector_to(other_vector)
      other_vector - self
    end
    
    def -(v)
      self.class.new(x - v.x, y - v.y)
    end
    
    def length
      Math.sqrt(x*x + y*y)
    end
  
      
  end
end