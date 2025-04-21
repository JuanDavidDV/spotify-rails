require "application_system_test_case"

class SongsTest < ApplicationSystemTestCase
  setup do
    @artist = artists(:one)
    @song = songs(:one)
  end

  test "visiting the index" do
    visit songs_url
    assert_selector "[data-music-target='play']"
  end

  test "should edit a song title" do
    visit new_artist_session_url

    fill_in "Email", with: @artist.email
    fill_in "Password", with: "Password"
    click_on "Log in"

    click_on "View your songs"

    click_on "Show this song", match: :first
    assert_text "Title"
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
