require "test_helper"
require "ostruct"

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
  end

  test "should be valid with fixtures data" do
    assert @user.valid?
  end

  test "should be invalid without an email" do
    @user.email = ""
    assert_not @user.valid?
    assert_includes @user.errors[:email], "can't be blank"
  end

  test "should be invalid without a password" do
    user = User.new(email: "test@email.com", password: nil)
    assert_not user.valid?
    assert_includes user.errors[:password], "can't be blank"
  end

  test "should have many streams" do
    assert_equal :has_many, User.reflect_on_association(:streams).macro
  end
end
