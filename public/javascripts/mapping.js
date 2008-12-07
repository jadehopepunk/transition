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
      this.map.setCenter(new GLatLng(-36.87, 174.58), 13);
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
      icon.image = "/pin_images/" + pin.code + '.png';

      var marker = new GMarker(point, {title: pin.name, icon: icon});
      this.map.addOverlay(marker);
      this.pin_markers.push(marker);
      marker.bindInfoWindowHtml(this.infoWindowHtml(pin));      
    }, this);
  },
  
  infoWindowHtml: function(pin) {
    return '<div class="info_window"><h1>' + pin.name + '</h1><p class="description">' + pin.description + '</p></div>'
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

var PointSelectionMap = Class.create({
  street_address: "",
  suburb: "",
  city: "",
  country: "",
  container_id: null,
  map: null,
  geocoder: null,
  marker: null,
  lat: null,
  lon: null,
  
  initialize: function(container_id) {
    this.container_id  = container_id;
  },

  load: function() {
    if (GBrowserIsCompatible()) {
      this.map = new GMap2(document.getElementById(this.container_id), {mapTypes: [G_NORMAL_MAP]});
      this.map.setCenter(new GLatLng(-36.92, 174.57), 11);
			this.map.addControl(new GLargeMapControl());
			this.geocoder = new GClientGeocoder();
    }
  },
  
  updateStreetAddress: function(value) {
    this.street_address = value;
    this.addressUpdated();
  },
  
  updateSuburb: function(value) {
    this.suburb = value;
    this.addressUpdated();
  },
  
  updateCity: function(value) {
    this.city = value;
    this.addressUpdated();
  },
  
  updateCountry: function(value) {
    this.country = value;
    this.addressUpdated();
  },
  
  updateAddress: function(value) {
    if (value) {
      this.street_address = value.street_address || '';
      this.suburb = value.suburb || '';
      this.city = value.city || '';
      this.country = value.country || '';
    }
    this.addressUpdated();
  },

  addressUpdated: function() {
    if (this.addressValid()) {
      var address = this.mappingAddress();
      var me = this;

      this.geocoder.getLatLng(
        address,
        function(point) { me.updateMarkerLocation(point, address); }
      );      
    }
  },
  
  updateMarkerLocation: function(point, address) {
    if (!point) {
      alert(address + " not found");
    } else {
      this.map.setCenter(point, 13);
      this.lat = point.lat();
      this.lon = point.lng();
      if (this.marker) {
        this.map.removeOverlay(this.marker);
        this.marker.setLatLng(point);
      } else {
        this.marker = new GMarker(point, {draggable: true});
      }
      this.map.addOverlay(this.marker);
      this.marker.openInfoWindowHtml(address);
    }    
  },
  
  addressValid: function() {
    return this.street_address != '';
  },
  
  mappingAddress: function() {
    return [this.street_address, this.suburb, this.city, this.country].join(' ');
  },
  
  writeLatLong: function(lat_id, long_id) {
    $(lat_id).value = this.lat;
    $(long_id).value = this.lon;
  },
    
  
});