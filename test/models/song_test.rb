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
      content_type: "image/jpeg"
    )
  end

  test "should be invalid without a title" do
    @song.title = ""
    assert_not @song.valid?
    assert_includes @song.errors[:title], "can't be blank"
  end

  test "should be invalid without an audio file" do
    @song.audio_file.detach     # Removes audio file
    assert_not @song.valid?
    assert_includes @song.errors[:audio_file], "can't be blank"
  end

  test "should be invalid without an image file" do
    @song.image.detach          # Removes image file
    assert_not @song.valid?
    assert_includes @song.errors[:image], "can't be blank"
  end
end
