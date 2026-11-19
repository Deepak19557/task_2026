require "test_helper"

class HomesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "should get root when signed in" do
    sign_in users(:one)
    get root_url
    assert_response :success
  end

  test "should redirect to sign in when not signed in" do
    get root_url
    assert_redirected_to new_user_session_path
  end
end
