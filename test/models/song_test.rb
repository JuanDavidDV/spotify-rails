require "test_helper"
class SongTest < ActiveSupport::TestCase
  def setup
    @artist = artists(:one)
    @song = songs(:one)

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

  test "should be invalid without a title" do
    @song.title = ""
    assert_not @song.valid?
  end

  test "should be invalid without an artist" do
    @song.artist = nil
    assert_not @song.valid?
  end

  test "should be invalid without an audio file" do
    @song.audio_file.detach     # Removes audio file
    assert_not @song.valid?
  end

  test "should be invalid without an image file" do
    @song.image.detach          # Removes image file
    assert_not @song.valid?
  end

  test "should destroy associated streams when song is destroyed" do
    @song.streams.create!
    assert_difference("Stream.count", -3) do
      @song.destroy
    end
  end
end
