require "test_helper"
require "ostruct"

class ArtistTest < ActiveSupport::TestCase
  setup do
    @artist = artists(:one)
  end

  test "should be valid with fixtures data" do
    assert @artist.valid?
  end

  test "should be invalid without a stage name" do
    @artist.stage_name = ""
    assert_not @artist.valid?
    assert_includes @artist.errors[:stage_name], "can't be blank"
  end

  test "should be valid with a stage name" do
    @artist.stage_name = "Test"
    assert @artist.valid?
  end

  test "should call create_stripe_account after create" do
    Stripe::Account.define_singleton_method(:create) do
      OpenStruct.new(id: "acct_9999")
    end

    artist = Artist.create!(email: "stripe@example.com", password: "Password123", stage_name: "Test")
    assert_equal "acct_9999", artist.stripe_account_id
  end
end
