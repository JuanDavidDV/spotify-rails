require "test_helper"

class ArtistTest < ActiveSupport::TestCase
  setup do
    @artist = artists(:one)
  end

  test "should be valid with fixtures data" do
    assert @artist.valid?
  end

  
end
