require "test_helper"

class Api::V1::FormulationsFlowTest < ActionDispatch::IntegrationTest
  setup do
    @formulation1 = formulations(:one)
    @formulation2 = formulations(:two)
    @animal1 = animals(:one)
    @animal2 = animals(:two)
    @feed1 = feeds(:one)
    @feed2 = feeds(:two)
    # Generate a valid JWT for @user
    @user = users(:admin)
    @jwt, _payload = Warden::JWTAuth::UserEncoder.new.call(@user, :user, nil)

    @auth_headers = {
      "Authorization" => "Bearer #{@jwt}"
    }
  end

  test "should get index" do
    expected = [
      {
        "id" => @formulation1.id,
        "animal_id" => @animal1.id,
        "feed_id" => @feed1.id,
        "quantity" => "2.5",
        "name" => "High Protein",
        "description" => "This is a high protein formulation"
      },
      {
        "id" => @formulation2.id,
        "animal_id" => @animal2.id,
        "feed_id" => @feed2.id,
        "quantity" => "0.1",
        "name" => "Zinc Supplement",
        "description" => "Add Zinc Supplement for healthy skin"
      }
    ]

    get api_v1_formulations_url, headers: auth_headers
    assert_response :success
    formulations = JSON.parse(response.body)
    assert_kind_of Array, formulations
    formulations.map { |a| a.delete_if { |key, value| key == "created_at" || key == "updated_at" } }
    assert_equal(formulations, expected)
  end

  test "should show formulation" do
    expected = {
      "id" => @formulation1.id,
      "animal_id" => @animal1.id,
      "feed_id" => @feed1.id,
      "quantity" => "2.5",
      "name" => "High Protein",
      "description" => "This is a high protein formulation"
    }
    get api_v1_formulation_url(@formulation1), headers: auth_headers
    assert_response :success
    formulation = JSON.parse(response.body)
    formulation.delete_if { |key, value| key == "created_at" || key == "updated_at" }
    assert_equal(formulation, expected)
  end

  test "should create formulation" do
    assert_difference("Formulation.count") do
      post api_v1_formulations_url,
           params: { formulation: { name: "New Formula", description: "A new formula with high protein", animal_id: @animal1.id, feed_id: @feed2.id, quantity: 4.0 } },
           headers: auth_headers
    end
    assert_response :created
    json = JSON.parse(response.body)
    assert_equal "New Formula", json["name"]
    assert_equal "A new formula with high protein", json["description"]
    assert_equal "4.0", json["quantity"]
  end

  test "should update formulation" do
    patch api_v1_formulation_url(@formulation1),
          params: { formulation: { name: "New Formula" } },
          headers: @auth_headers

    assert_response :success

    json = JSON.parse(response.body)
    assert_equal "New Formula", json["name"], "Formulation name should be updated"

    @formulation1.reload
    assert_equal "New Formula", @formulation1.name
  end

  test "should return 404 if formulation does not exist" do
    @formulation1.destroy!
    get api_v1_formulation_url(@formulation1), headers: auth_headers
    assert_response :not_found
  end

  test "should not create formulation with invalid data" do
    post api_v1_formulations_url,
           params: { formulation: { quantity: nil } },
           headers: auth_headers
    assert_response :unprocessable_content
  end

  test "should not update formulation with invalid data" do
    patch api_v1_formulation_url(@formulation1),
          params: { formulation: { quantity: nil } },
          headers: @auth_headers
    assert_response :unprocessable_content
  end

  test "non-admin user should not allow to create formulation" do
    guest = users(:guest)
    jwt, _payload = Warden::JWTAuth::UserEncoder.new.call(guest, :user, nil)
    headers = {
      "Authorization" => "Bearer #{jwt}"
    }

    post api_v1_formulations_url,
      params: { formulation: { name: "New Formula", description: "A new formula with high protein", animal_id: @animal1.id, feed_id: @feed2.id, quantity: 4.0 } },
      headers: headers

    assert_response :forbidden
  end

  test "non-admin user should not allow to update formulation" do
    guest = users(:guest)
    jwt, _payload = Warden::JWTAuth::UserEncoder.new.call(guest, :user, nil)
    headers = {
      "Authorization" => "Bearer #{jwt}"
    }

    patch api_v1_formulation_url(@formulation1),
          params: { formulation: { quantity: 3.0 } },
          headers: headers

    assert_response :forbidden
  end

  private

  # Helper for authorization headers
  def auth_headers
    @auth_headers || {}
  end
end
