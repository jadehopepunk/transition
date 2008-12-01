module VertexCollection
  def insert_between_closest(latlong)
    new_position = closest_vertex_position(latlong) + 1
    vertex = create(:latlong => latlong)
    vertex.insert_at(new_position)
    vertex
  end

  def closest_vertex_position(latlong)
    vertex = vertex_before(latlong)
    vertex ? vertex.position : 0
  end
      
  protected
  
    def vertex_before(latlong)
      closest = closest_vertex(latlong)
      if closest
        should_go_before?(latlong, closest) ? closest.higher_item : closest
      end
    end
    
    def should_go_before?(latlong, other_vertex)
      before = other_vertex.higher_item
      after = other_vertex.lower_item
      closest_sibling = closest_of(latlong, [before, after].compact)
      closest_sibling && closest_sibling == before
    end
    
    def closest_of(latlong, vertices)
      vertices_by_distance(latlong, vertices).first
    end
  
    def closest_vertex(latlong)
      vertices_by_distance(latlong, self).first
    end
    
    def vertices_by_distance(latlong, vertices)
      results = {}
      vertices.each do |vertex|
        results[vertex] = latlong.distance_to(vertex.latlong) if vertex.position
      end
      sorted_results = results.sort {|a,b| a[1] <=> b[1]}
      sorted_results.map(&:first)
    end
end