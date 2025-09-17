require "test_helper"

class AnimalsFlowTest < ActionDispatch::IntegrationTest
  setup do
    @animal1 = animals(:one)
    @animal2 = animals(:two)
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
        "id" => @animal1.id,
        "name" => "Doggy",
        "species" => "Dog",
        "age" => 1,
        "weight" => "19.99"
      },
      {
        "id" => @animal2.id,
        "name" => "Kitty",
        "species" => "Cat",
        "age" => 2,
        "weight" => "9.99"
      }
    ]

    get api_v1_animals_url, headers: auth_headers
    assert_response :success
    animals = JSON.parse(response.body)
    assert_kind_of Array, animals
    animals.map { |a| a.delete_if { |key, value| key == "created_at" || key == "updated_at" } }
    assert_equal(animals, expected)
  end

  test "should show animal" do
    expected = {
        "id" => @animal1.id,
        "name" => "Doggy",
        "species" => "Dog",
        "age" => 1,
        "weight" => "19.99"
      }
    get api_v1_animal_url(@animal1), headers: auth_headers
    assert_response :success
    animal = JSON.parse(response.body)
    animal.delete_if { |key, value| key == "created_at" || key == "updated_at" }
    assert_equal(animal, expected)
  end

  test "should get animals with feeds" do
    feed1 = feeds(:one)
    feed2 = feeds(:two)

    expected = [
      {
        "id" => @animal1.id,
        "name" => "Doggy",
        "species" => "Dog",
        "age" => 1,
        "weight" => "19.99",
        "formulations" => [
          {
            "name" => "High Protein",
            "description" => "This is a high protein formulation",
            "quantity" => "2.5",
            "feed" => {
              "id" => feed1.id,
              "name" => "Corn Mix",
              "protein" => "9.99",
              "fiber" => "9.99",
              "fat" => "9.99"
            }
          }
        ]
      },
      {
        "id" => @animal2.id,
        "name" => "Kitty",
        "species" => "Cat",
        "age" => 2,
        "weight" => "9.99",
        "formulations" => [
          {
            "name" => "High Fiber",
            "description" => "This is a high fiber formulation",
            "quantity" => "3.5",
            "feed" => {
            "id" => feed2.id,
              "name" => "Hay",
              "protein" => "9.99",
              "fiber" => "9.99",
              "fat" => "9.99"
            }
          }
        ]
      }
    ]

    get api_v1_animals_with_feeds_url, headers: auth_headers
    assert_response :success
    animals_with_feeds = JSON.parse(response.body)
    assert_kind_of Array, animals_with_feeds
    assert_equal animals_with_feeds, expected
  end

  test "should create animal" do
    assert_difference("Animal.count") do
      post api_v1_animals_url,
           params: { animal: { name: "New Animal", species: "Goat" } },
           headers: auth_headers
    end
    assert_response :created
    json = JSON.parse(response.body)
    assert_equal "New Animal", json["name"]
  end

  test "should update animal" do
    patch api_v1_animal_url(@animal1),
          params: { animal: { name: "New Doggy" } },
          headers: @auth_headers

    assert_response :success

    json = JSON.parse(response.body)
    assert_equal "New Doggy", json["name"], "Animal name should be updated"

    @animal1.reload
    assert_equal "New Doggy", @animal1.name
  end

  private

  # Helper for authorization headers
  def auth_headers
    @auth_headers || {}
  end
end
