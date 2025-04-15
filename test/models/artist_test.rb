require "test_helper"
require "ostruct"

class ArtistTest < ActiveSupport::TestCase
  setup do
    @artist = artists(:one)
  end

  test "should be valid with fixtures data" do
    assert @artist.valid?
  end

  test "should be invalid without an email" do
    @artist.email = ""
    assert_not @artist.valid?
    assert_includes @artist.errors[:email], "can't be blank"
  end

  test "should be invalid without an stage name" do
    @artist.stage_name = ""
    assert_not @artist.valid?
    assert_includes @artist.errors[:stage_name], "can't be blank"
  end

  test "should be invalid without a password" do
    artist = Artist.new(email: "test@email.com", password: nil, stage_name: "Test")
    assert_not artist.valid?
    assert_includes artist.errors[:password], "can't be blank"
  end

  test "should have many songs" do
    assert_equal :has_many, Artist.reflect_on_association(:songs).macro # macro returns the type of association defined, in this case "has_many"
  end

  test "should have many streams through songs" do
    streams_association = Artist.reflect_on_association(:streams)
    assert_equal :has_many, streams_association.macro
    assert_equal :songs, streams_association.options[:through]
  end

  test "should default stripe status to awaiting_onboarding to new Artists" do
    artist = Artist.new(email: "test@email.com", password: "Password", stage_name: "Test")
    assert_equal "awaiting_onboarding", artist.stripe_status
  end

  test "should define stripe_status enum correctly" do
    assert_equal({ "awaiting_onboarding" => 0, "payouts_enabled" => 1 }, Artist.stripe_statuses)
  end

  test "should call create_stripe_account after create" do
    original_method = Stripe::Account.method(:create)

    Stripe::Account.define_singleton_method(:create) do
      OpenStruct.new(id: "acct_9999")
    end

    artist = Artist.create!(email: "stripe@example.com", password: "Password123", stage_name: "Test")
    assert_equal "acct_9999", artist.stripe_account_id
  ensure
    Stripe::Account.define_singleton_method(:create, original_method)
  end
end
