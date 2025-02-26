import { Controller } from "@hotwired/stimulus";
import { post } from "@rails/request.js";

// Connects to data-controller="music"
export default class extends Controller {
  static targets = ["play", "pause"];
  static values = { url: String, audioPlayerUrl: String };

  connect() {
    if (!window.audio) {
      window.audio = new Audio();
    }
  };

  toggle(e) {
    e.preventDefault(); // Prevents reload
    if (window.audio.src != this.urlValue) {
      // Switching song and initializing new song
      window.audio.pause();
      window.audio.currentTime = 0;
      window.audio.src = this.urlValue; // Sets audio to clicked audio
      this.updateAudioPlayer();
    }

    window.dispatchEvent(new CustomEvent("audio-player-switched", { // Makes items update
      detail: {
        audio_src: this.urlValue,
      },
    }))

    this.playTarget.classList.toggle("hidden");
    this.pauseTarget.classList.toggle("hidden");
    
    if (!window.audio.paused) {
      window.audio.pause();
    } else {
      window.audio.play();
    }
  };

  async updateAudioPlayer() {
    await post(this.audioPlayerUrlValue, {
      responseKind: "turbo-stream"
    })
  };

  audioSwitched(e) {
    const newUrl = e.detail.audio_src;
    if (newUrl != this.urlValue) {
      if (this.playTarget.classList.contains("hidden")) {
        this.playTarget.classList.remove("hidden");
        this.pauseTarget.classList.add("hidden");
      }
    }
  }
};
