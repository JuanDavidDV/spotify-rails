require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  setup do
    @user = users(:one)
  end

  test "should visit the songs page after sign in" do
    visit new_user_session_url
    fill_in "Email", with: @user.email
    fill_in "Password", with: "Password"
    click_on "Log in"

    assert_text "Signed in successfully."
  end

  test "should create a user" do
    visit new_user_session_url
    click_on "New here? Create an account now"

    fill_in "Email", with: "testuser@email.com"
    fill_in "Password", with: "Password"
    fill_in "Password confirmation", with: "Password"
    click_on "Sign up"

    assert_text "Welcome! You have signed up successfully."
  end
end
