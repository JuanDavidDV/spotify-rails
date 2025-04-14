require "test_helper"

class ArtistsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @artist = artists(:one)
    sign_in @artist
  end

  test "should get dashboard and retreive balance if payouts are enabled" do
    @artist.stubs(:payouts_enabled?).return(true) # Stubs comes from Mocha gem
    Stripe::Balance.stubs(:retrieve).returns({ "available" => [ { "amount" => 1000 } ] })

    get dashboard_path
    assert_response :success
    assert_select "h1", /Welcome to the Artist Dashboard/i
  end

  test "should get new" do
    get new_artist_url
    assert_response :success
  end

  test "should create artist" do
    assert_difference("Artist.count") do
      post artists_url, params: { artist: {} }
    end

    assert_redirected_to artist_url(Artist.last)
  end

  test "should show artist" do
    get artist_url(@artist)
    assert_response :success
  end

  test "should get edit" do
    get edit_artist_url(@artist)
    assert_response :success
  end

  test "should update artist" do
    patch artist_url(@artist), params: { artist: {} }
    assert_redirected_to artist_url(@artist)
  end

  test "should destroy artist" do
    assert_difference("Artist.count", -1) do
      delete artist_url(@artist)
    end

    assert_redirected_to artists_url
  end
end
