require "application_system_test_case"

class ArtistsTest < ApplicationSystemTestCase
  setup do
    @artist = artists(:one)
  end

  test "should visit the artist dashboard" do
    visit new_artist_session_url
    fill_in "Email", with: @artist.email
    fill_in "Password", with: "Password"
    click_on "Log in"

    assert_selector "h1", text: "Welcome to the Artist Dashboard"
  end

  test "should create artist" do
    visit new_artist_registration_url
    fill_in "Stage name", with: "Test Artist"
    fill_in "Email", with: "testartist@email.com"
    fill_in "Password", with: "Password"
    fill_in "Password confirmation", with: "Password"

    click_on "Sign up"

    # Waits to allow loading the new artist dashboard
    using_wait_time(10) do
      assert_selector "h1", text: "Welcome to the Artist Dashboard"
    end
  end

  test "should update Artist information" do
    visit new_artist_session_url
    fill_in "Email", with: @artist.email
    fill_in "Password", with: "Password"
    click_on "Log in"

    click_on "Edit your account"

    fill_in "Stage name", with: "Test Artist"
    fill_in "Email", with: "testartist@email.com"
    fill_in "Password", with: "Test Password"
    fill_in "Password confirmation", with: "Test Password"
    fill_in "Current password", with: "Password"
    click_on "Update"

    assert_text "Your account has been updated successfully."
  end

  test "should destroy Artist" do
    @artist.songs.destroy_all

    visit new_artist_session_url
    fill_in "Email", with: @artist.email
    fill_in "Password", with: "Password"
    click_on "Log in"

    click_on "Edit your account"
    accept_confirm do
      click_on "Cancel my account"
    end

    assert_text "Bye! Your account has been successfully cancelled. We hope to see you again soon."
  end
end
