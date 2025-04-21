require "application_system_test_case"

class SongsTest < ApplicationSystemTestCase
  setup do
    @artist = artists(:one)
    @song = songs(:one)
  end

  test "visiting the index" do
    visit songs_url
    assert_selector "[data-music-target='play']"  # This is the play SVG to play a song
  end


  test "should create a song" do
    visit new_artist_session_url
  
    fill_in "Email", with: @artist.email
    fill_in "Password", with: "Password"
    click_on "Log in"
  
    click_on "Post a song"
  
    fill_in "Title", with: "Song Test"
  
    image_path = File.expand_path("test/fixtures/files/images/lion.webp")
    audio_path = File.expand_path("test/fixtures/files/audios/tiger.mp3")
  
    attach_file "Image", image_path
    attach_file "Audio file", audio_path
  
    click_on "Create Song"
    assert_selector "h1", text: "Showing song"
  end

  test "should update a song" do
    visit new_artist_session_url

    fill_in "Email", with: @artist.email
    fill_in "Password", with: "Password"
    click_on "Log in"

    click_on "View your songs"
    click_on "Show this song", match: :first
    click_on "Edit this song"
    fill_in "Title", with: "New Test"

    image_path = File.expand_path("test/fixtures/files/images/universe.gif")
    audio_path = File.expand_path("test/fixtures/files/audios/universal.mp3")

    attach_file "Image", image_path
    attach_file "Audio file", audio_path

    click_on "Update Song"
    assert_selector "h1", text: "Showing song"
  end

  test "should update Song" do
    visit song_url(@song)
    click_on "Edit this song", match: :first

    fill_in "Artist", with: @song.artist_id
    fill_in "Title", with: @song.title
    click_on "Update Song"

    assert_text "Song was successfully updated"
    click_on "Back"
  end

  test "should destroy Song" do
    visit song_url(@song)
    click_on "Destroy this song", match: :first

    assert_text "Song was successfully destroyed"
  end
end
