import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="audio-player"
export default class extends Controller {
  static targets = ["currentTime", "duration", "range"];
  connect() {
    console.log("The audio playing is:", window.audio)
  }
}
