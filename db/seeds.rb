# Creates artists
artists = [
  {
    stage_name: "Silvestre Dangon",
    email: "artist1@email.com",
    password: "Password12"
  },
  {
    stage_name: "Marc Anthony",
    email: "artist2@email.com",
    password: "Password"
  },
  {
    stage_name: "Aventura",
    email: "artist3@email.com",
    password: "Password"
  },
  {
    stage_name: "Joe Arroyo",
    email: "artist4@email.com",
    password: "Password"
  },
  {
    stage_name: "Fonseca",
    email: "artist5@email.com",
    password: "Password"
  }
]

artists.each do |artist|
  Artist.find_or_create_by!(email: artist[:email]) do |a|  # find_or_create_by! used to prevent duplicates when re-running seed file
    a.stage_name = artist[:stage_name]
    a.password = artist[:password]
  end
end

# Creates songs for the Artists
songs = {
  "Silvestre Dangon" => [
    { title: "Bubbles", image: "bubble.webp", audio: "bubble.mp3" },
    { title: "Lack of Energy", image: "rhythmic-dancing.jpg", audio: "rhythmic-dancing.mp3" },
    { title: "Respiro", image: "giphy.gif", audio: "giphy.mp3" }
  ],
  "Marc Anthony" => [
    { title: "El Baile", image: "feid.jpg", audio: "feid.mp3" },
    { title: "Motorizado", image: "moto.webp", audio: "motorizado.mp3" },
    { title: "Running", image: "running.jpg", audio: "running.mp3" },
    { title: "Lion", image: "lion.webp", audio: "lion.mp3" },
    { title: "Lights", image: "lights.jpg", audio: "lights.mp3" }
  ]
}

require "open-uri"

# Ensure the directory structure exists: db/seeds/files/
song_files = {
  "Silvestre Dangon" => { title: "Cásate Conmigo", image: "song1.jpg", audio: "song1.mp3" },
  "Marc Anthony" => { title: "Vivir Mi Vida", image: "song2.jpg", audio: "song2.mp3" },
  "Aventura" => { title: "Obsesión", image: "song3.jpg", audio: "song3.mp3" },
  "Joe Arroyo" => { title: "La Rebelión", image: "song4.jpg", audio: "song4.mp3" },
  "Fonseca" => { title: "Eres Mi Sueño", image: "song5.jpg", audio: "song5.mp3" }
}

artists.each do |artist_data|
  artist = Artist.find_by(email: artist_data[:email])
  next unless artist  # Skip if artist is not found

  song_data = song_files[artist.stage_name]
  next unless song_data  # Skip if no song data for artist

  song = artist.songs.create!(
    title: song_data[:title]
  )

  # Attach image and audio file (Make sure files exist in db/seeds/files/)
  image_path = Rails.root.join("db/seeds/files", song_data[:image])
  audio_path = Rails.root.join("db/seeds/files", song_data[:audio])

  if File.exist?(image_path) && File.exist?(audio_path)
    song.image.attach(io: File.open(image_path), filename: song_data[:image])
    song.audio_file.attach(io: File.open(audio_path), filename: song_data[:audio])
  else
    puts "Missing file(s) for #{song.title}"
  end
end
