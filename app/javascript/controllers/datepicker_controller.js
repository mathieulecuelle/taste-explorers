import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr";

// Connects to data-controller="datepicker"
export default class extends Controller {
  static targets = ["dateRange", "startDate", "endDate"]

  connect() {
    // Assurez-vous que le champ est en readonly
    this.dateRangeTarget.setAttribute('readonly', true);

    this.flatpickr = flatpickr(this.dateRangeTarget, {
      mode: "range",
      minDate: "today",
      inline: true,
      dateFormat: "Y-m-d",

      onChange: (selectedDates) => {
        this.updateHiddenFields(selectedDates);
      }
    });
  }

  updateHiddenFields(selectedDates) {
    const startDate = selectedDates[0];
    const endDate = selectedDates[1];

    if (startDate) {
      this.startDateTarget.value = this.flatpickr.formatDate(startDate, "Y-m-d");
    }
    if (endDate) {
      this.endDateTarget.value = this.flatpickr.formatDate(endDate, "Y-m-d");
      // Retirer le focus pour éviter l’ouverture du clavier
      this.dateRangeTarget.blur();
    } else {
    }
  }

  disconnect() {
    if (this.flatpickr) {
      this.flatpickr.destroy();
    }
  }
}
