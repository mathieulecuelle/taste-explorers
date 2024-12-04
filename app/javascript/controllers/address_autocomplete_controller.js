import { Controller } from "@hotwired/stimulus"
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder"

export default class extends Controller {
  static values = { apiKey: String }
  static targets = ["address"]

  connect() {
    this.geocoder = new MapboxGeocoder({
      accessToken: this.apiKeyValue,
      types: "country,region,place,postcode,locality,neighborhood,address",
      placeholder: "Entrez votre adresse ici"
    })
    this.geocoder.addTo(this.element)
    this.geocoder.on("result", event => this.#setInputValue(event))
    this.geocoder.on("clear", () => this.#clearInputValue())

    this.#addTargetIcon();
  }

  disconnect() {
    this.geocoder.onRemove()
  }

  #setInputValue(event) {
    this.addressTarget.value = event.result["place_name"]
  }

  #clearInputValue() {
    this.addressTarget.value = ""
  }

  #handleTargetClick() {
    this.#getCurrentPosition();
  }

  #getCurrentPosition() {
    const options = {
      enableHighAccuracy: true,
      timeout: 5000,
      maximumAge: 0,
    };

    navigator.geolocation.getCurrentPosition(
      this.#handleSuccess.bind(this),
      this.#handleError.bind(this),
      options
    );
  }

  #handleSuccess(pos) {
    const { latitude, longitude } = pos.coords;
    this.#reverseGeocode(latitude, longitude);
  }

  #handleError(err) {
    console.warn(`ERROR(${err.code}): ${err.message}`);
    this.#updateGeocoderInput("Localisation non disponible");
  }

  #updateGeocoderInput(value) {
    const geocoderInput = this.element.querySelector('.mapboxgl-ctrl-geocoder--input');
    if (geocoderInput) {
      geocoderInput.value = value;
    }
  }

  #reverseGeocode(latitude, longitude) {
    const url = `https://api.mapbox.com/geocoding/v5/mapbox.places/${longitude},${latitude}.json?access_token=${this.apiKeyValue}`;

    fetch(url)
      .then(response => response.json())
      .then(data => {
        if (data.features && data.features.length > 0) {
          const address = data.features[0].place_name;
          this.#updateGeocoderInput(address);
          this.addressTarget.value = address;
        } else {
          this.#updateGeocoderInput("Adresse non trouvée");
        }
      })
      .catch(error => {
        console.error("Erreur lors du géocodage inverse:", error);
        this.#updateGeocoderInput("Erreur de géocodage");
      });
  }

  #addTargetIcon() {
    const geocoderInput = this.element.querySelector('.mapboxgl-ctrl-geocoder--input');
    if (geocoderInput) {
      const targetIcon = document.createElement('i');
      targetIcon.classList.add('fa-solid', 'fa-location-crosshairs', 'geocoder-target-icon');
      targetIcon.style.cursor = 'pointer';
      targetIcon.style.position = 'absolute';
      targetIcon.style.right = '30px';
      targetIcon.style.top = '50%';
      targetIcon.style.transform = 'translateY(-50%)';
      geocoderInput.parentNode.appendChild(targetIcon);

      targetIcon.addEventListener('click', this.#handleTargetClick.bind(this));
    }
}

}
