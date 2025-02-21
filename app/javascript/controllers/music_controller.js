import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="music"
export default class extends Controller {
  static targets = ["icon"];
  static values = { url: String };

  connect() {
    if (!window.audio) {
      window.audio = new Audio();
    }
  }

  toggle(e) {
    if (window.audio.src != this.urlValue) {
      window.audio.pause();
      window.audio.currentTime = 0;
      window.audio.src = this.urlValue; // Sets audio to clicked audio
    }
    e.preventDefault(); // Prevents reload
    this.iconTargets.forEach(target => target.classList.toggle("hidden"));
    if (!this.audio.paused) {
      this.audio.pause();
    } else {
      this.audio.play();
    }
  }
}
