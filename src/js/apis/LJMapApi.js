import CustomMarker from './CustomMarker';

export default class LJMapApi {
  constructor () {
    this.map = null;
    this.mapReady = false;
    this.opts = null;
    this.markers = [];
    this.defaultLatLng = {
      lat: 43.0686606,
      lng: 141.3485666
    }
  }
  getPos (callback) {
    navigator.geolocation.getCurrentPosition((position) => {
      let latLng = {
        lat: position.coords.latitude,
        lng: position.coords.longitude
      };
      callback (latLng);
    }, (err) => {
      callback (null);
      console.warn(err);
    });
  }

  getDist ({lat,lng}) {
    const center = this.getCenter();
    const distance = google.maps.geometry.spherical.computeDistanceBetween(
      new google.maps.LatLng(lat,lng),
      new google.maps.LatLng(center.lat, center.lng),
    );
    return distance;
  }

  createMap (elemid, {lat,lng}, callback) {
    this.map = new google.maps.Map(document.getElementById(elemid));
    this.opts = {
      zoom: 17,
      gestureHandling: 'greedy',
      center: new google.maps.LatLng(lat, lng),
      disableDefaultUI: true,
      disableDoubleClickZoom: true,
      mapTypeId: google.maps.MapTypeId.ROADMAP,
      mapTypeControlOptions: {
        mapTypeIds: [google.maps.MapTypeId.ROADMAP, 'LJMap']
      }
    };
    this.map.setOptions(this.opts);

    this.map.addListener('projection_changed', () => {
      this.mapReady = true;
      callback();
    });
  }

  getCenter () {
    let latLng = {
      lat: this.map.getCenter().lat(),
      lng: this.map.getCenter().lng()
    }
    return latLng;
  }

  moveLocation (latLng) {
    this.map.setCenter(new google.maps.LatLng(latLng.lat,latLng.lng));
  }

  moveCurrentLocation (callback) {
    this.getPos((latLng) => {
      if (latLng != null) {
        this.map.setCenter(new google.maps.LatLng(latLng.lat,latLng.lng));
      }
      if(callback){
        callback();
      }
    });
  }

  addMarker (className, location, userData) {
    if(!location){location = this.getCenter()}
    // google map overlay
    const overlay = new google.maps.OverlayView();
    overlay.setMap(this.map);
    overlay.draw = function () {
      if (!this.ready) {
        this.ready = true;
        google.maps.event.trigger(this, 'ready');
      }
    };
    const marker = new CustomMarker({
      location: new google.maps.LatLng(location.lat, location.lng),
    },className);
    marker.setMap(this.map);
    marker.userData = userData;
    this.markers.push(marker);
    return marker;

  }

  clearMarkers () {
    this.markers.forEach(m=>{
      m.remove();
    });
    this.markers.length = 0;
  }



}
