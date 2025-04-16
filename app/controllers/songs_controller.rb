class SongsController < ApplicationController
  def index
    @songs = Song.all.order(created_at: :desc)
  end

  def audio_player
    @song = Song.find(params[:song_id])
    @song.streams.create(user: current_user)
  
  
    respond_to do |format|
      format.turbo_stream
    end
  end
end
