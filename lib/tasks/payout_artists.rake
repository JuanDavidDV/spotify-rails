# desc "Payout artists for there streams"
# task payout_artists: :environment do
#  puts "Paying out artists now..."
#  Artist.where(stripe_status: "payouts_enabled").find_each do |artist|
#    streams_to_payout = artist.streams.where(payed_out: false)
#    if streams_to_payout.any?
      #     amount_to_payout = streams_to_payout.count * 50
      # puts "Amounts to payout: #{amount_to_payout}"
      # Add funds to Stripe account to make this logic works. This code was extracted from Stripe documentation!
      # Stripe::Transfer.create({
      #  amount: amount_to_payout,
      #  currency: "cad",
      #  destination: artist.stripe_account_id
      # })
#      streams_to_payout.update_all(payed_out: true)
#    end
#  end
# end
