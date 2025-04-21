require "application_system_test_case"

class ArtistsTest < ApplicationSystemTestCase
  setup do
    @artist = artists(:one)
  end

  test "visiting the artist dashboard" do
    visit new_artist_session_path
    fill_in "Email", with: @artist.email
    fill_in "Password", with: "Password"
    click_on "Log in"

    assert_selector "h1", text: "Welcome to the Artist Dashboard"
  end

  test "should create artist" do
    visit new_artist_registration_url
  end

  test "should update Artist" do
    visit artist_url(@artist)
    click_on "Edit this artist", match: :first

    click_on "Update Artist"

    assert_text "Artist was successfully updated"
    click_on "Back"
  end

  test "should destroy Artist" do
    visit artist_url(@artist)
    click_on "Destroy this artist", match: :first

    assert_text "Artist was successfully destroyed"
  end
end
