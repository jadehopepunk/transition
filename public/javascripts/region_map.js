var RegionMap = Class.create({
  initialize: function(container_id, map_region, boundary_editing) {
    this.container_id  = container_id;
    this.map = null;
    this.boundary = null;
    this.boundary_markers = [];
    this.pin_markers = [];
    this.map_region = map_region;
    this.boundary_editing = boundary_editing;
  },

  load: function() {
    if (GBrowserIsCompatible()) {
      this.loaded = true;
      this.map = new GMap2(document.getElementById(this.container_id), {mapTypes: [G_NORMAL_MAP]});
      this.map.setCenter(new GLatLng(this.map_region.center_lat, this.map_region.center_lon), this.map_region.default_zoom);
			this.map.addControl(new GLargeMapControl());
			if (this.boundary_editing) {
  			this.enableBoundaryEditing();				  
			}
    }
  },
  
  displayPins: function(pins) {
    pins.each(function(pin) {
      point = new GLatLng(pin.lat, pin.long)

      var icon = new GIcon(G_DEFAULT_ICON);
      icon.image = "/pin_images/" + pin.to_param + '.png';

      var marker = new GMarker(point, {title: pin.name, icon: icon});
      this.map.addOverlay(marker);
      this.pin_markers.push(marker);
      marker.bindInfoWindowHtml(this.infoWindowHtml(pin));      
    }, this);
  },
  
  infoWindowHtml: function(pin) {
    return '<div class="info_window"><h1>' + pin.name + '</h1><p class="description">' + pin.description + '</p><div><a href="' + pin.url + '">More about us</a></div></div>'
  },
  
  setBoundary: function(map_region) {
    this.clearBoundary();
    
  	if (map_region.vertices.size() > 0) {
  		var points = this.boundaryPoints(map_region);
  	  this.boundary = new GPolygon(points, "#090", 2, 1, "#090", 0.4);
  	  this.map.addOverlay(this.boundary);
			if (this.boundary_editing) {
  	    this.addBoundaryMarkers(map_region.vertices, map_region.vertices[map_region.vertices.length - 1], map_region.vertices[0]);
  	  }
  	}
  },
  
  enableBoundaryEditing: function() {
    var url = '/admin/map_regions/' + this.map_region.id + '/map_region_vertices'
    this.enableClickHandler(url);
  },
  
  addBoundaryMarkers: function(vertices, insert_after, insert_before) {
    vertices.each(function(vertex) {
      var point = this.pointFromVertex(vertex);
      var colour = 'blue'
      if (vertex == insert_after || vertex == insert_before) {
        colour = 'red'
      }
      var icon = new GIcon(G_DEFAULT_ICON, "http://www.google.com/intl/en_us/mapfiles/ms/micons/" + colour + ".png");
      
      var marker = new GMarker(point, {title: vertex.position, icon:icon});
      this.map.addOverlay(marker);
      this.boundary_markers.push(marker);
    }, this);
  },
  
  boundaryPoints: function(map_region) {
	  var first_vertex = map_region.vertices[0];
		var points = map_region.vertices.collect(function(vertex) {
		  return this.pointFromVertex(vertex);
		}, this);
		points.push(this.pointFromVertex(first_vertex));
    return points;
  },
  
  pointFromVertex: function(vertex) {
    return new GLatLng(vertex.lat, vertex.long);
  },
  
  clearBoundary: function() {
    if (this.boundary) {
      this.map.removeOverlay(this.boundary);
      this.boundary = null;
    }
    this.boundary_markers.each(function(marker){
      this.map.removeOverlay(marker);
    }, this);
    this.boundary_markers = [];
  },
  
  enableClickHandler: function(url) {
		GEvent.addListener(this.map, 'click', function(overlay, latlng) {
		  if (latlng) {
  			new Ajax.Request(url, 
  				{
  					asynchronous:true, 
  					evalScripts:true, 
  					method:'post',
  					parameters: 'authenticity_token=' + encodeURIComponent(authenticityToken) +
  						'&latitude=' + encodeURIComponent(latlng.lat()) +
  						'&longitude=' + encodeURIComponent(latlng.lng())
  				});
		  }
		});
  }
});
