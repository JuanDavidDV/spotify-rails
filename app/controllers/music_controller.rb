class MusicController < ApplicationController
  def show
    @songs = Song.all.order(created_at: :desc)
  end

  def audio_player
    @song = Song.find(params[:song_id])
  end
end
