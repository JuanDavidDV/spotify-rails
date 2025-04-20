require "application_system_test_case"

class HomesTest < ApplicationSystemTestCase
  test "visit home page" do
    visit root_url
    assert_selector "h1", text: "Spotify Rails"
  end
end
