require "test_helper"

class SongsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @artist = artists(:one)
    sign_in @artist
    @song = songs(:one)
  end

  test "should get index if signed in" do
    get songs_url
    assert_response :success
  end

  test "should not get index if signed out" do
    sign_out @artist

    get songs_url
    assert_response :not_found
  end

  test "should get new" do
    get new_song_url
    assert_response :success
  end

  test "should create song" do
    audio_file = fixture_file_upload("audios/tiger.mp3")
    image_file = fixture_file_upload("images/lion.webp")

    assert_difference("Song.count", 1) do
      post songs_url, params:
        { song: { artist_id: @song.artist_id,
          title: @song.title,
          audio_file: audio_file,
          image: image_file
        }
      }
    end

    assert_redirected_to song_url(Song.last)
  end

  test "should show song" do
    get song_url(@song)
    assert_response :success
  end

  test "should get edit" do
    get edit_song_url(@song)
    assert_response :success
  end

  test "should update song" do
    audio_file = fixture_file_upload("audios/tiger.mp3")
    image_file = fixture_file_upload("images/lion.webp")

    patch song_url(@song), params:
      { song: { artist_id: @song.artist_id,
        title: @song.title,
        audio_file: audio_file,
        image: image_file
        }
      }

    assert_redirected_to song_url(@song)
  end

  test "should destroy song" do
    assert_difference("Song.count", -1) do
      delete song_url(@song)
    end

    assert_redirected_to songs_url
  end
end
