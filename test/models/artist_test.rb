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

  test "should be invalid without a password" do
    artist = Artist.new(email: "test@email.com", password: nil)
    assert_not artist.valid?
    assert_includes artist.errors[:password], "can't be blank"
  end

  test "should have many songs" do
    assert_equal :has_many, Artist.reflect_on_association(:songs).macro # macro returns the type of association defined, in this case "has_many"
  end
end
