require "application_system_test_case"

class SongsTest < ApplicationSystemTestCase
  setup do
    @artist = artists(:one)
    @song = songs(:one)
  end

  def log_in_artist
    visit new_artist_session_url
    fill_in "Email", with: @artist.email
    fill_in "Password", with: "Password"
    click_on "Log in"
  end

  test "visiting the index" do
    visit songs_url
    assert_selector "[data-music-target='play']"  # This is the play SVG to play a song
  end

  test "should create a song" do
    log_in_artist

    click_on "Post a song"

    fill_in "Title", with: "Song Test"

    image_path = File.expand_path("test/fixtures/files/images/lion.webp")
    audio_path = File.expand_path("test/fixtures/files/audios/tiger.mp3")

    attach_file "Image", image_path
    attach_file "Audio file", audio_path

    click_on "Create Song"
    assert_selector "h1", text: "Showing song"
  end

  test "should not create a song when title is missing" do
    log_in_artist

    click_on "Post a song"

    fill_in "Title", with: ""
    image_path = File.expand_path("test/fixtures/files/images/lion.webp")
    audio_path = File.expand_path("test/fixtures/files/audios/tiger.mp3")

    attach_file "Image", image_path
    attach_file "Audio file", audio_path

    click_on "Create Song"
    assert_text "Title can't be blank"
  end

  test "should not create a song when image file is missing" do
    log_in_artist

    click_on "Post a song"

    fill_in "Title", with: "Test"
    audio_path = File.expand_path("test/fixtures/files/audios/tiger.mp3")

    attach_file "Audio file", audio_path

    click_on "Create Song"
    assert_text "Image can't be blank"
  end

  test "should not create a song when audio file is missing" do
    log_in_artist

    click_on "Post a song"

    fill_in "Title", with: "Song Test"

    image_path = File.expand_path("test/fixtures/files/images/lion.webp")

    attach_file "Image", image_path

    click_on "Create Song"
    assert_text "Audio file can't be blank"
  end

  test "should update a song" do
    log_in_artist

    click_on "View your songs"
    click_on "Show this song", match: :first
    click_on "Edit this song"
    fill_in "Title", with: "New Test"

    image_path = File.expand_path("test/fixtures/files/images/universe.gif")
    audio_path = File.expand_path("test/fixtures/files/audios/universal.mp3")

    attach_file "Image", image_path
    attach_file "Audio file", audio_path

    click_on "Update Song"
    assert_selector "p", text: "New Test"
  end

  test "should destroy a song" do
    log_in_artist

    click_on "View your songs"
    click_on "Show this song", match: :first
    click_on "Destroy this song"
    assert_selector "h1", text: "Songs"
  end
end
