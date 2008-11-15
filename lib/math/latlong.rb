module Math
  class Latlong < Vector2d
  
    def lat
      y
    end
  
    def lat=(value)
      self.y = value
    end
  
    def long
      x
    end
  
    def long=(value)
      self.x = value
    end
    
  end
end