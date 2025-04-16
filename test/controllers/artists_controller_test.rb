require "test_helper"
require "ostruct"

class ArtistsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @artist = artists(:one)
    @artist.payouts_enabled!
    sign_in @artist
  end

  test "should show all artists song" do
    get artists_url
    assert_response :success
  end

  test "should get dashboard and retrieve balance if payouts are enabled" do

    # Save the original method
    original_method = Stripe::Balance.method(:retrieve)

    # Override it
    Stripe::Balance.define_singleton_method(:retrieve) do |*args|
      OpenStruct.new(available: [ OpenStruct.new(amount: 1000) ])
    end

    get authenticated_artist_root_path
    assert_response :success

  ensure
    # Restore the original method to avoid side effects
    Stripe::Balance.define_singleton_method(:retrieve, original_method)
  end
end
