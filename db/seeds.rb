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
  existing_artist = Artist.find_by(email: artist[:email])
  if existing_artist.nil?
    Artist.create!(artist)
  end
end
