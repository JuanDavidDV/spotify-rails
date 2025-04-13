class MusicController < ApplicationController
  def show
    @songs = Song.all.order(created_at: :desc)
  end

  def audio_player
    @song = Song.find(params[:song_id])
    @song.streams.create(user: current_user) # If current user is not signed in will show as nul, so it will work both ways with or without user signed in
    head :ok # This is for testing purposes
  end
end
