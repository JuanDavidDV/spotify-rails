require "application_system_test_case"

class HomesTest < ApplicationSystemTestCase
  test "home page is visible" do
    visit root_url
    assert_selector "h1", text: "Spotify Rails"
  end
end
