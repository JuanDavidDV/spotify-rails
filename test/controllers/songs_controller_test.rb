require "test_helper"

class SongsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @artist = artists(:one)
    @song = songs(:one)
  end

  test "should get index that displays all the songs" do
    get songs_url
    assert_response :success
  end

  test "should be able to get a form to create a new song if an artist is sign in" do
    sign_in @artist

    get new_song_url
    assert_response :success
  end

  test "should not be able to get a form to create a new song if an artist is not sign in" do
    get new_song_url
    assert_response :not_found
  end

  test "should create song" do
    sign_in @artist

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

  test "should show song details" do
    sign_in @artist

    get song_url(@song)
    assert_response :success
  end

  test "should edit the song" do
    sign_in @artist

    get edit_song_url(@song)
    assert_response :success
  end

  test "should update song" do
    sign_in @artist

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

  test "should destroy the song" do
    sign_in @artist

    assert_difference("Song.count", -1) do
      delete song_url(@song)
    end

    assert_redirected_to artist_songs_url
  end
end
