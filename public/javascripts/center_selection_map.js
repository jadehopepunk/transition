var CenterSelectionMap = Class.create({
  container_id: null,
  lat_field_id: null,
  lon_field_id: null,
  zoom_field_id: null,
  map: null,
  
  initialize: function(container_id, lat_field_id, lon_field_id, zoom_field_id) {
    this.container_id  = container_id;
    this.lat_field_id = lat_field_id;
    this.lon_field_id = lon_field_id;
    this.zoom_field_id = zoom_field_id;
  },

  load: function() {
    if (GBrowserIsCompatible()) {
      this.map = new GMap2(document.getElementById(this.container_id), {mapTypes: [G_NORMAL_MAP]});
      this.setCenterFromFields();
		  this.map.addControl(new GLargeMapControl());
		  GEvent.bind(this.map, 'move', this, this.onMapChanged);
		  GEvent.bind(this.map, 'moveend', this, this.onMapChanged);
		  GEvent.bind(this.map, 'zoomend', this, this.onMapChanged);
    }
  },
  
  setCenterFromFields: function() {
    var lat = parseFloat($(this.lat_field_id).value) || -36.9;
    var lon = parseFloat($(this.lon_field_id).value) || 174.5;
    var zoom = parseInt($(this.zoom_field_id).value) || 1;
    this.map.setCenter(new GLatLng(lat, lon), zoom);    
  },
  
  onMapChanged: function () {
    var center = this.map.getCenter();
    $(this.lat_field_id).value = center.lat();
    $(this.lon_field_id).value = center.lng();
    $(this.zoom_field_id).value = this.map.getZoom();
  }
    
});