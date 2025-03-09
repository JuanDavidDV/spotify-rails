class ArtistsController < ApplicationController
  def dashboard
    if current_artist.payouts_enabled?
      @balance ||= Stripe::Balance.retrieve(current_artist.stripe_account_id)
    end
  end
end
