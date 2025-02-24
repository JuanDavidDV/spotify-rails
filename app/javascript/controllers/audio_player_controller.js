import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="audio-player"
export default class extends Controller {
  static targets = ["currentTime", "duration", "range"];
  connect() {
    if (!window.audio) return 
    console.log(window.audio.duration);
    if (window.audio.duration) {
      console.log("has duration", window.audio.duration);
      this.rangeTarget.max = window.audio.duration;
      this.durationTarget.innerHTML = formatTime(window.audio.duration);
    }
    this.rangeTarget.value = 0;

    window.audio.addEventListener("timeupdate", () => {
      console.log("Time updated event", formatTime(window.audio.duration));
      this.currentTimeTarget.innerHTML = formatTime(window.audio.duration); 
    })
  }
};

const formatTime = (seconds) => {
  const minutes = Math.floor(seconds / 60);
  const second = (seconds % 60);
  return minutes + ":" + (second < 10 ? "0" + second : seconds);
}
