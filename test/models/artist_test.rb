require "test_helper"

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
    artist = Artist.new(email: "test@email.com", password: nil)
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
    artist = Artist.new(email: "test@email.com", password: "Password")
    assert_equal "awaiting_onboarding", artist.stripe_status
  end

  test "should define stripe_status enum correctly" do
    assert_equal({ "awaiting_onboarding" => 0, "payouts_enabled" => 1 }, Artist.stripe_statuses)
  end
end
