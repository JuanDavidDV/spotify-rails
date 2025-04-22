require "test_helper"

class MusicControllerTest < ActionDispatch::IntegrationTest
  setup do
    @song = songs(:one)
  end

  test "should create stream when audio_player is hit" do
    assert_difference("Stream.count", 1) do
      post audio_player_path, params: { song_id: @song.id }
    end
  end
end
