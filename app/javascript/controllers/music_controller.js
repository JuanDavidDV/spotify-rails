import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="music"
export default class extends Controller {
  static targets = ["icon"];
  static values = { url: String };

  connect() {
    const audio = new Audio();
    audio.src = this.urlValue;
  }

  toggle(e) {
    e.preventDefault(); // Prevents reload
    this.iconTargets.forEach(target => target.classList.toggle("hidden"));
    audio.play();
  }
}
