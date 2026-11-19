require "test_helper"

class UserRegistrationTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  test "user can sign up with first_name, last_name and age" do
    get new_user_registration_path
    assert_response :success

    assert_difference("User.count", 1) do
      post user_registration_path, params: {
        user: {
          first_name: "Bob",
          last_name: "Builder",
          age: 35,
          email: "bob@example.com",
          password: "password123",
          password_confirmation: "password123"
        }
      }
    end

    assert_response :redirect
    follow_redirect!
    assert_response :success

    created_user = User.find_by(email: "bob@example.com")
    assert_not_nil created_user
    assert_equal "Bob", created_user.first_name
    assert_equal "Builder", created_user.last_name
    assert_equal 35, created_user.age
  end

  test "user can edit profile with first_name, last_name, and age" do
    user = users(:one)
    sign_in user

    get edit_user_registration_path
    assert_response :success

    patch user_registration_path, params: {
      user: {
        first_name: "Johnny",
        last_name: "Updated",
        age: 31,
        email: user.email,
        current_password: "password123"
      }
    }

    assert_response :redirect
    follow_redirect!
    assert_response :success

    user.reload
    assert_equal "Johnny", user.first_name
    assert_equal "Updated", user.last_name
    assert_equal 31, user.age
  end
end

