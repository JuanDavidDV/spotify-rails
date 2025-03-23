# Creates artists
artists = [
  {
    stage_name: "Silvestre Dangon",
    email: "artist1@email.com",
    password: "Password12",
    songs: [
      { title: "Bubbles", image: "bubble.webp", audio: "bubble.mp3" },
      { title: "Lack of Energy", image: "rhythmic-dancing.jpg", audio: "rhythmic-dancing.mp3" },
      { title: "Respiro", image: "giphy.gif", audio: "giphy.mp3" }
    ]
  },
  {
    stage_name: "Marc Anthony",
    email: "artist2@email.com",
    password: "Password",
    songs: [
      { title: "El Baile", image: "feid.jpg", audio: "feid.mp3" },
      { title: "Motorizado", image: "moto.webp", audio: "motorizado.mp3" },
      { title: "Running", image: "running.jpg", audio: "running.mp3" },
      { title: "Lion", image: "lion.webp", audio: "lion.mp3" },
      { title: "Lights", image: "lights.jpg", audio: "lights.mp3" }
    ]
  },
  {
    stage_name: "Aventura",
    email: "artist3@email.com",
    password: "Password",
    songs: [
      { title: "Mountain", image: "mountain.jpg", audio: "mountain.mp3" },
      { title: "Tiger", image: "tiger.avif", audio: "tiger.mp3" },
      { title: "Under the Sea", image: "Under-the-sea.gif", audio: "Under-the-sea.mp3" },
      { title: "Club Penguin", image: "Club-Penguin.webp", audio: "Club-Penguin.mp3" },
      { title: "Station", image: "station.gif", audio: "station.mp3" },
      { title: "Lavoe", image: "lavoe.gif", audio: "lavoe.mp3" },
      { title: "Spiderman", image: "spiderman.avif", audio: "spiderman.mp3" }
    ]
  },
  {
    stage_name: "Joe Arroyo",
    email: "artist4@email.com",
    password: "Password",
    songs: [
      { title: "Universal", image: "universal.gif", audio: "universal.mp3" },
      { title: "camino", image: "camino.webp", audio: "camino.mp3" },
      { title: "AI", image: "AI.gif", audio: "AI.mp3" }
    ]
  },
  {
    stage_name: "Fonseca",
    email: "artist5@email.com",
    password: "Password",
    songs: [
      { title: "Forest Run", image: "forest.jpg", audio: "forest.mp3" }
    ]
  }
]

# Creates artists
artists.each do |artist_data|
  artist = Artist.find_or_create_by!(email: artist_data[:email]) do |a| # find_or_create_by! used to prevent duplicates when re-running seed file
    a.stage_name = artist_data[:stage_name]
    a.password = artist_data[:password]
  end

  # Creates songs for each artists
  artist_data[:songs].each do |songs_data|
    song = artist.songs.find_or_create_by!(title: songs_data[:title])

    image_path = Rails.root.join("app/assets/images/#{artist_data[:stage_name]}", songs_data[:image])
    puts image_path
    audio_path = Rails.root.join("app/assets/audio/#{artist_data[:stage_name]}", songs_data[:audio])
    puts audio_path

    if File.exist?(image_path) && File.exist?(audio_path)
      song.image.attach(io: File.open(image_path), filename: songs_data[:image])
      song.audio_file.attach(io: File.open(audio_path), filename: songs_data[:audio])
    else
      puts "Missing file(s) for #{song.title}"
    end
  end
end
