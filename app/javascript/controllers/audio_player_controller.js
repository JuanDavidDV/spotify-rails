import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="audio-player"
export default class extends Controller {
  static targets = ["currentTime", "duration", "range", "play", "pause"];
  connect() {
    if (!window.audio) return 
    this.updatePlayButton();
    this.rangeTarget.value = 0;

    this.timeUpdateEventListener = window.audio.addEventListener("timeupdate", () => {
      this.rangeTarget.max = window.audio.duration;
      this.durationTarget.innerHTML = formatTime(window.audio.duration);
      this.currentTimeTarget.innerHTML = formatTime(window.audio.currentTime); 
    })
  };

  toggle(e) {
    e.preventDefault();
    if(window.audio.paused) {
      window.audio.play();
    } else {
      window.audio.pause();
    }

    window.dispatchEvent(new CustomEvent("audio-player-switched", {
      detail: {
        audio_src: this.urlValue,
      }
    }))

    this.updatePlayButton();
  };

  updatePlayButton() {
    if (window.audio.paused) {
      if (!this.pauseTarget.classList.contains("hidden")) {
        this.pauseTarget.classList.add("hidden");
      }
      this.playTarget.classList.remove("hidden");
    } else {
      if (!this.playTarget.classList.contains("hidden")) {
        this.playTarget.classList.add("hidden");
      }
      this.pauseTarget.classList.remove("hidden");
    }
  };

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
};
