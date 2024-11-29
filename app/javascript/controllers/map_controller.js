import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl' // Don't forget this!

export default class extends Controller {
  static values = {
    apiKey: String,
    marker: Object
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10"
    })
    this.map.addControl(new mapboxgl.NavigationControl())
    this.#addMarkerToMap()
    this.#fitMapToMarker()
    this.map.scrollZoom.disable();
  }

  #addMarkerToMap() {
    const marker = this.markerValue;
    new mapboxgl.Marker()
      .setLngLat([marker.lng, marker.lat])
      .addTo(this.map);
  }

  #fitMapToMarker() {
    const marker = this.markerValue;
    const bounds = new mapboxgl.LngLatBounds();
    bounds.extend([marker.lng, marker.lat]);
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 });
  }
}
