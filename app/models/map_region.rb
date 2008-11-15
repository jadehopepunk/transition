class MapRegion < ActiveRecord::Base
  has_many :vertices, :class_name => MapRegionVertex.name, :dependent => :destroy, :order => "position ASC" do
    def insert_between_closest(latlong)
      vertex = build(:latlong => latlong)
      vertex.insert_at(closest_vertex_position(latlong) + 1)
      vertex
    end
    
    protected
    
      def closest_vertex_position(latlong)
        vertex = closest_vertex(latlong)
        vertex ? vertex.position : 0
      end
      
      def closest_vertex(latlong)
        vertices_by_distance(latlong).first
      end
      
      def vertices_by_distance(latlong)
        results = {}
        each do |vertex|
          results[vertex] = latlong.distance_to(vertex.latlong) if vertex.position
        end
        sorted_results = results.sort {|a,b| a[1] <=> b[1]}
        sorted_results.map(&:first)
      end      
    
  end
    
  validates_presence_of :name
    
end
