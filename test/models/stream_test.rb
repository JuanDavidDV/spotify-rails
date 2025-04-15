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
end
