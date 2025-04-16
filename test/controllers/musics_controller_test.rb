require "test_helper"

class MusicControllerTest < ActionDispatch::IntegrationTest
  setup do
    @song = songs(:one)
    @user = users(:one)
  end

  test "should get index" do
    get music_index_path
    assert_response :success
  end

  test "should create stream when audio_player is hit without user" do
    assert_difference("Stream.count", 1) do
      post audio_player_music_index_path, params: { song_id: @song.id }
    end
  end
end
