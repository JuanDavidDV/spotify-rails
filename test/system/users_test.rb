require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  setup do
    @user = users(:one)
  end

  def log_in_user
    visit new_user_session_url
    fill_in "Email", with: @user.email
    fill_in "Password", with: "Password"
    click_on "Log in"
  end

  test "should create a user" do
    visit new_user_registration_url

    fill_in "Email", with: "testuser@email.com"
    fill_in "Password", with: "Password"
    fill_in "Password confirmation", with: "Password"
    click_on "Sign up"

    assert_text "Welcome! You have signed up successfully."
  end

  test "should visit the songs page after sign in" do
    log_in_user
    assert_text "Signed in successfully."
  end

  test "should update user information" do
    log_in_user

    find("a[data-action='dropdown#toggle']").click
    click_on "Settings"

    fill_in "Email", with: "newtestuser@email.com"
    fill_in "Current password", with: "Password"
    click_on "Update"
    assert_text "Your account has been updated successfully."
  end
end
