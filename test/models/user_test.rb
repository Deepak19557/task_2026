require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "user attributes first_name, last_name and age can be saved" do
    user = User.new(
      email: "testuser@example.com",
      password: "password123",
      password_confirmation: "password123",
      first_name: "Alice",
      last_name: "Wonderland",
      age: 28
    )
    assert user.save
    assert_equal "Alice", user.first_name
    assert_equal "Wonderland", user.last_name
    assert_equal 28, user.age
  end
end
