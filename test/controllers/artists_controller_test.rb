require "test_helper"
require "ostruct"

class ArtistsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @artist = artists(:one)
    sign_in @artist
  end

  test "should get dashboard and retrieve balance if payouts are enabled" do
    def @artist.payouts_enabled?
      true
    end

    # Save the original method
    original_method = Stripe::Balance.method(:retrieve)

    # Override it
    Stripe::Balance.define_singleton_method(:retrieve) do |*args|
      OpenStruct.new(available: [ OpenStruct.new(amount: 1000) ])
    end

    get authenticated_artist_root_path
    assert_response :success
    assert_select "h1", /Welcome to the Artist Dashboard/i

  ensure
    # Restore the original method to avoid side effects
    Stripe::Balance.define_singleton_method(:retrieve, original_method)
  end

  test "should get dashboard and NOT retrieve balance if payouts are disabled" do
    def @artist.payouts_enabled?
      false
    end
  
    # Set up a flag to track if Stripe::Balance.retrieve was called
    called = false
  
    # Save the original method
    original_method = Stripe::Balance.method(:retrieve)
  
    # Override the method to track calls
    Stripe::Balance.define_singleton_method(:retrieve) do |*args|
      called = true
      original_method.call(*args)
    end
  
    get dashboard_path
    assert_response :success
    assert_not called, "Expected Stripe::Balance.retrieve to not be called"
  
  ensure
    # Restore the original method after the test
    Stripe::Balance.define_singleton_method(:retrieve, original_method)
  end
end
