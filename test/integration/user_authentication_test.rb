# test/integration/user_authentication_test.rb
require "test_helper"

class UserAuthenticationTest < ActionDispatch::IntegrationTest
  test "user can sign up and then log in" do
    # Sign up
    post user_registration_url, params: {
      user: {
        email: "flowuser@example.com",
        password: "password123",
        password_confirmation: "password123"
      }
    }, as: :json

    assert_response :created

    # Log in
    post user_session_url, params: {
      user: {
        email: "flowuser@example.com",
        password: "password123"
      }
    }, as: :json

    assert_response :success
    token = response.headers["Authorization"]
    assert token, "Expected a JWT token in Authorization header"

    # Use token in a protected route (example)
    get api_v1_animals_url, headers: { "Authorization" => token }, as: :json
    assert_response :success

    delete destroy_user_session_url,
           headers: { "Authorization" => @token }, as: :json

    assert_response :success
  end

  test "user should not be able to sign up with invalid email" do
    post user_registration_url, params: {
      user: {
        email: "invalid-email",
        password: "password123",
        password_confirmation: "password123"
      }
    }, as: :json

    assert_response :unprocessable_content
  end
end
