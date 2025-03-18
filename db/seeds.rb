artists = [
  {
    stage_name: "Silvestre Dangon",
    email: "artist1@email.com",
    password: "Password12"
  }
]

artists.each do |artist|
  Artist.find_or_create_by(email: artist[:email]) do |a|  # find_or_create_by used to prevent duplicates when re-running seed file
    a.stage_name = artist[:stage_name],
    a.password = artist[:password]
  end
end
