require "test_helper"

class Api::V1::UsersFlowTest < ActionDispatch::IntegrationTest
  setup do
    # Generate a valid JWT for @user
    @user = users(:admin)
    @jwt, _payload = Warden::JWTAuth::UserEncoder.new.call(@user, :user, nil)

    @auth_headers = {
      "Authorization" => "Bearer #{@jwt}"
    }
  end

  test "should show user" do
    get api_v1_users_me_url, headers: auth_headers
    assert_response :success
    me = JSON.parse(response.body)
    assert_equal(me["email"], "tester1@test.com")
  end

  private

  # Helper for authorization headers
  def auth_headers
    @auth_headers || {}
  end
end
