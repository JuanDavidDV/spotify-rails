require "test_helper"

class SongsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @artist = artists(:one)
    @song = songs(:one)
    @user = users(:one)

    # This attaches the audio file of the song
    @song.audio_file.attach(
      io: File.open(Rails.root.join("test/fixtures/files/audios/tiger.mp3")),
      filename: "tiger.mp3",
      content_type: "audio/mpeg"
    )

    # This attaches the image file of the song
    @song.image.attach(
      io: File.open(Rails.root.join("test/fixtures/files/images/lion.webp")),
      filename: "lion.webp",
      content_type: "image/webp"
    )
  end

  test "should get index that displays all the songs" do
    get songs_url
    assert_response :success
  end

  test "should show song details" do
    sign_in @artist

    get song_url(@song)
    assert_response :success
  end

  test "should be able to get a form to create a new song if an artist is signed in" do
    sign_in @artist
    get new_song_url
    assert_response :success
  end

  test "should edit the song" do
    sign_in @artist

    get edit_song_url(@song)
    assert_response :success
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
  end

  test "should update song" do
    sign_in @artist

    audio_file = fixture_file_upload("audios/tiger.mp3")
    image_file = fixture_file_upload("images/lion.webp")

    patch song_url(@song), params:
      {
        song: {
          artist_id: @song.artist_id,
          title: "New Name",
          audio_file: audio_file,
          image: image_file
        }
      }

    @song.reload
    assert_equal "New Name", @song.title
  end

  test "should destroy the song" do
    sign_in @artist

    assert_difference("Song.count", -1) do
      delete song_url(@song)
    end
  end

  test "audio_player creates a stream record" do
    sign_in @user

    assert_difference('Stream.count', 1) do
      post audio_player_path, params: { song_id: @song.id }, 
           headers: { "Accept" => "text/vnd.turbo-stream.html" }
    end
  end

  test "audio_player responds with turbo stream format" do
    sign_in @user
    post audio_player_path, params: { song_id: @song.id }, 
         headers: { "Accept" => "text/vnd.turbo-stream.html" }
    assert_equal "text/vnd.turbo-stream.html", response.media_type
  end
end
