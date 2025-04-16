require "application_system_test_case"

class HomesTest < ApplicationSystemTestCase

  test "home page is visible" do
    visit root_url
    assert_selector "h1", text: "Spotify Rails"
  end

  test "should create home" do
    visit homes_url
    click_on "New home"

    click_on "Create Home"

    assert_text "Home was successfully created"
    click_on "Back"
  end

  test "should update Home" do
    visit home_url(@home)
    click_on "Edit this home", match: :first

    click_on "Update Home"

    assert_text "Home was successfully updated"
    click_on "Back"
  end

  test "should destroy Home" do
    visit home_url(@home)
    click_on "Destroy this home", match: :first

    assert_text "Home was successfully destroyed"
  end
end
