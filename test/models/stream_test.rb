require "test_helper"

class StreamTest < ActiveSupport::TestCase
  def setup
    @song = songs(:one)
    @user = users(:one)
  end
end
