class AddStripeStatusToArtists < ActiveRecord::Migration[8.0]
  def change
    add_column :artists, :stripe_status, :integer
  end
end
