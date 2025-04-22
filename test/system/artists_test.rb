require "application_system_test_case"
class ArtistsTest < ApplicationSystemTestCase
  setup do
    @artist = artists(:one)
  end

  def log_in_artist
    visit new_artist_session_url
    fill_in "Email", with: @artist.email
    fill_in "Password", with: "Password"
    click_on "Log in"
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

  test "should not create artist if there is missing information" do
    visit new_artist_registration_url
    fill_in "Stage name", with: ""
    fill_in "Email", with: "testartist@email.com"
    fill_in "Password", with: "Password"
    fill_in "Password confirmation", with: "Password"

    click_on "Sign up"

    # Waits to allow loading the new artist dashboard
    using_wait_time(10) do
      assert_text "Stage name can't be blank"
    end
  end

  test "should not have the same stage names" do
    Artist.create!(
      stage_name: "Test Stage Name",
      email: "existing@email.com",
      password: "Password"
    )

    visit new_artist_registration_url
    fill_in "Stage name", with: "Test Stage Name"
    fill_in "Email", with: "testartist@email.com"
    fill_in "Password", with: "Password"
    fill_in "Password confirmation", with: "Password"

    click_on "Sign up"
    using_wait_time(10) do
      assert_text "Stage name has already been taken"
    end
  end

  test "should match Password and Password Confirmation before creating a user" do
    visit new_artist_registration_url
    fill_in "Stage name", with: "Test Stage Name"
    fill_in "Email", with: "testartist@email.com"
    fill_in "Password", with: "Password12"
    fill_in "Password confirmation", with: "Password"

    click_on "Sign up"

    assert_text "Password confirmation doesn't match Password"
  end

  test "should visit the artist dashboard after sign in" do
    log_in_artist

    assert_selector "h1", text: "Welcome to the Artist Dashboard"
  end

  test "should update Artist information" do
    log_in_artist

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

    log_in_artist

    click_on "Edit your account"
    accept_confirm do
      click_on "Cancel my account"
    end

    assert_text "Bye! Your account has been successfully cancelled. We hope to see you again soon."
  end

  test "should sign out Artist" do
    log_in_artist

    click_on "Sign out"
    assert_text "Signed out successfully."
  end
end
