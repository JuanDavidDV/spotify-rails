desc "Payout artists for there streams"
task payout_artists: :environment do
  puts "Paying out artists now"
  Artist.find_each do |artist|
    streams_to_payout = artist.streams.where(payed_out: false)

    streams_to_payout.update_all(payed_out: true)
  end
end
