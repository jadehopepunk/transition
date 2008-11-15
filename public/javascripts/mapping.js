var RegionMap = Class.create({
  initialize: function(container_id) {
    this.container_id  = container_id;
    this.map = null;
    this.boundary = null;
  },

  load: function() {
    if (GBrowserIsCompatible()) {
      this.map = new GMap2(document.getElementById("map"));
      this.map.setCenter(new GLatLng(-36.85, 174.64), 11);
			this.map.addControl(new GLargeMapControl());
    }
  },
  
  setBoundary: function(map_region) {
    this.clearBoundary();
    
  	if (map_region.vertices.size() > 0) {
  		var points = this.boundaryPoints(map_region);
  	  this.boundary = new GPolygon(points, "#33CC33", 5, 1, "#33CC33", 0.3);
  	  this.map.addOverlay(this.boundary);
  	}
  },
  
  boundaryPoints: function(map_region) {
	  var first_vertex = map_region.vertices[0];
		var points = map_region.vertices.collect(function(vertex) {
			return new GLatLng(vertex.lat, vertex.long);
		});
		points.push(new GLatLng(first_vertex.lat, first_vertex.long));
    return points;
  },
  
  clearBoundary: function() {
    if (this.boundary) {
      this.map.removeOverlay(this.boundary);
      this.boundary = null;
    }
  },
  
  enableClickHandler: function(url, authenticity_token) {
		GEvent.addListener(this.map, 'click', function(overlay, latlng) {
			new Ajax.Request(url, 
				{
					asynchronous:true, 
					evalScripts:true, 
					method:'post',
					parameters: 'authenticity_token=' + encodeURIComponent(authenticity_token) +
						'&latitude=' + encodeURIComponent(latlng.lat()) +
						'&longitude=' + encodeURIComponent(latlng.lng())
				});
		});				
    
  }

});

