require "test_helper"

class ArtistTest < ActiveSupport::TestCase
  def setup
    @artist = artists(:one)
    @song = songs(:one)
  end

  test "title should be present" do
    @song.title = ""
    assert_not @song.valid?
  end
end
