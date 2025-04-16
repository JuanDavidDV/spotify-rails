class ArtistsController < ApplicationController
  before_action :authenticate_artist! # In order to go to any controller actions you must be sign in authenticated

  # GET /songs or /songs.json
  def index
    @songs = current_artist.songs.all
  end

  def dashboard
    if current_artist.payouts_enabled?
      @balance = Stripe::Balance.retrieve(current_artist.stripe_account_id)
    end
  end
end
