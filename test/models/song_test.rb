require "test_helper"

class SongTest < ActiveSupport::TestCase
  def setup
    @artist = artists(:one)
    @song = songs(:one)
  end

  test "should be invalid without a title" do
    @song.title = ""
    assert_not @song.valid?
    assert_includes @song.errors[:title], "can't be blank"
  end

  test "audio file should be present" do
    @song.audio_file = nil
    assert_not @song.valid?
  end
end
