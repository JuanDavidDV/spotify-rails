class SongsController < ApplicationController
  before_action :set_song, only: %i[ show edit update destroy ]

  def index
    @songs = Song.all.order(created_at: :desc)
  end

  # GET /songs/1 or /songs/1.json
  def show
  end

  def new
    @song = Song.new
  end

  # GET /songs/1/edit
  def edit
  end

  # POST /songs or /songs.json
  def create
    @song = current_artist.songs.new(song_params)

    respond_to do |format|
      if @song.save
        format.html { redirect_to @song, notice: "Song was successfully created." }
        format.json { render :show, status: :created, location: @song }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /songs/1 or /songs/1.json
  def update
    respond_to do |format|
      if @song.update(song_params)
        format.html { redirect_to @song, notice: "Song was successfully updated." }
        format.json { render :show, status: :ok, location: @song }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /songs/1 or /songs/1.json
  def destroy
    @song.destroy!

    respond_to do |format|
      format.html { redirect_to artist_songs_path, status: :see_other, notice: "Song was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def audio_player
    @song = Song.find(params[:song_id])
    @song.streams.create(user: current_user)

    respond_to do |format|
      format.turbo_stream
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_song
    @song = current_artist.songs.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def song_params
    params.expect(song: [ :title, :image, :audio_file, :artist_id ])
  end
end
