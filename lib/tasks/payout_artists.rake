desc "Payout artists for there streams"
task payout_artists: :environment do
  puts "Paying out artists now"
  Artist.find_each do |artist|
    streams_for_day = artist.streams
  end
end
