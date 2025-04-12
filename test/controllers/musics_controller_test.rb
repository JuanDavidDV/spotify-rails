require "test_helper"

class MusicControllerTest < ActionDispatch::IntegrationTest
  setup do
    @song = songs(:one)
    @user = users(:one)
  end

  test "should get show and list of songs" do
    get music_path
    assert_response :success
  end

  test "should create stream when audio_player is hit without user" do
    assert_difference("Stream.count", 1) do
      post audio_player_music_path, params: { song_id: @song.id }
    end
    assert_response :success
    assert_equal @song.id, Stream.last.song_id
    assert_nil Stream.last.user_id  # Nil if user is not logged in
  end
end
