class StreamController < ApplicationController
  def create
    @song = Song.find(params[:song_id])
    @song.streams.create(user: current_user) # If current user is not signed in will show as nul, so it will work both ways with or without user signed in
  end
end
