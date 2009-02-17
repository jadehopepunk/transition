var PointSelectionMap = Class.create({
  street_address: "",
  suburb: "",
  city: "",
  country: "",
  container_id: null,
  map: null,
  geocoder: null,
  marker: null,
  
  initialize: function(container_id, region) {
    this.container_id  = container_id;
    this.region = region;
  },

  load: function() {
    if (GBrowserIsCompatible()) {
      this.map = new GMap2(document.getElementById(this.container_id), {mapTypes: [G_NORMAL_MAP]});
      this.map.setCenter(new GLatLng(this.region.center_lat, this.region.center_lon), this.region.default_zoom);
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
    if (this.marker) {
      point = this.marker.getLatLng();
      $(lat_id).value = point.lat();
      $(long_id).value = point.lng();      
    }
  }
    
  
});