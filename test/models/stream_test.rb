require "test_helper"

class StreamTest < ActiveSupport::TestCase
  def setup
    @song = songs(:one)
    @user = users(:one)
  end

  test "should belong to a song" do
    assert_equal :belongs_to, Stream.reflect_on_association(:song).macro
  end

  test "should belong to a user" do
    assert_equal :belongs_to, Stream.reflect_on_association(:song).macro
  end

  test "should allow stream without a user" do
    stream = Stream.new(song: @song)
    assert stream.valid?
  end

  test "should be invalid without a song" do
    stream = Stream.new(user: @user)
    assert_not stream.valid?
    assert_includes stream.errors[:song], "must exist"
  end

  test "should increment song's stream_count using counter_cache" do
    original_count = @song.streams_count || 0

    Stream.create!(song: @song)
    @song.reload  # Reloads the song from the database to get the updated streams_count

    assert_equal original_count + 1, @song.streams_count
  end
end
