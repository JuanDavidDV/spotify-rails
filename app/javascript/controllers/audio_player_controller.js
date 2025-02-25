import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="audio-player"
export default class extends Controller {
  static targets = ["currentTime", "duration", "range"];
  connect() {
    if (!window.audio) return 
    this.rangeTarget.value = 0;

    this.timeUpdateEventListener = window.audio.addEventListener("timeupdate", () => {
      this.rangeTarget.max = window.audio.duration;
      this.durationTarget.innerHTML = formatTime(window.audio.duration);
      this.currentTimeTarget.innerHTML = formatTime(window.audio.currentTime); 
    })
  }

  // When element gets removed from the page
  disconnect() { 
    window.audio.removeEventListener("timeupdate", this.timeUpdateEventListener);
  }
};

const formatTime = (currentTime) => {
  const minutes = "0" + Math.floor(currentTime / 60);
  const seconds = "0" + Math.floor(currentTime - minutes * 60);
  const duration = minutes.substr(-2) + ":" + seconds.substr(-2);
  return duration;
}
