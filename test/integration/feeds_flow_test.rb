require "test_helper"

class Api::V1::FeedsFlowTest < ActionDispatch::IntegrationTest
  setup do
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
        "id" => @feed1.id,
        "name" => "Corn Mix",
        "protein" => "9.99",
        "fat" => "9.99",
        "fiber" => "9.99",
        "vitamins" => "A, B",
        "minerals" => "Ca",
        "category" => "feed"
      },
      {
        "id" => @feed2.id,
        "name" => "Zinc Supplement",
        "protein" => nil,
        "fat" => nil,
        "fiber" => nil,
        "vitamins" => nil,
        "minerals" => "Zn",
        "category" => "mineral"
      }
    ]

    get api_v1_feeds_url, headers: auth_headers
    assert_response :success
    feeds = JSON.parse(response.body)
    assert_kind_of Array, feeds
    feeds.map { |a| a.delete_if { |key, value| key == "created_at" || key == "updated_at" } }
    assert_equal(feeds, expected)
  end

  test "should filter feeds by categoty" do
    expected = [
      {
        "id" => @feed2.id,
        "name" => "Zinc Supplement",
        "protein" => nil,
        "fat" => nil,
        "fiber" => nil,
        "vitamins" => nil,
        "minerals" => "Zn",
        "category" => "mineral"
      }
    ]

    get api_v1_feeds_url,
      params: { category: "mineral" },
      headers: auth_headers
    assert_response :success
    feeds = JSON.parse(response.body)
    assert_kind_of Array, feeds
    feeds.map { |a| a.delete_if { |key, value| key == "created_at" || key == "updated_at" } }
    assert_equal(feeds, expected)
  end

  test "should show feed" do
    expected = {
      "id" => @feed1.id,
      "name" => "Corn Mix",
      "protein" => "9.99",
      "fat" => "9.99",
      "fiber" => "9.99",
      "vitamins" => "A, B",
      "minerals" => "Ca",
      "category" => "feed"
    }
    get api_v1_feed_url(@feed1), headers: auth_headers
    assert_response :success
    feed = JSON.parse(response.body)
    feed.delete_if { |key, value| key == "created_at" || key == "updated_at" }
    assert_equal(feed, expected)
  end

  test "should create feed" do
    assert_difference("Feed.count") do
      post api_v1_feeds_url,
           params: { feed: { name: "New Feed", protein: 8.0, fat: 3.5, fiber: 5.0, vitamins: "A,D,E", minerals: "Ca" } },
           headers: auth_headers
    end
    assert_response :created
    json = JSON.parse(response.body)
    assert_equal "New Feed", json["name"]
  end

  test "should update feed" do
    patch api_v1_feed_url(@feed1),
          params: { feed: { name: "New Feed" } },
          headers: @auth_headers

    assert_response :success

    json = JSON.parse(response.body)
    assert_equal "New Feed", json["name"], "Feed name should be updated"

    @feed1.reload
    assert_equal "New Feed", @feed1.name
  end

  test "should return 404 if feed does not exist" do
    @feed1.destroy!
    get api_v1_feed_url(@feed1), headers: auth_headers
    assert_response :not_found
  end

  test "should not create feed with invalid data" do
    post api_v1_feeds_url,
           params: { feed: { name: nil, protein: 8.0, fat: 3.5, fiber: 5.0, vitamins: "A,D,E", minerals: "Ca" } },
           headers: auth_headers
    assert_response :unprocessable_content
  end

  test "should not update feed with invalid data" do
    patch api_v1_feed_url(@feed1),
          params: { feed: { name: nil, protein: 7.0 } },
          headers: auth_headers
    assert_response :unprocessable_content
  end

  test "non-admin user should not allow to create feed" do
    guest = users(:guest)
    jwt, _payload = Warden::JWTAuth::UserEncoder.new.call(guest, :user, nil)
    headers = {
      "Authorization" => "Bearer #{jwt}"
    }

    post api_v1_feeds_url,
      params: { feed: { name: "New Feed", protein: 8.0, fat: 3.5, fiber: 5.0, vitamins: "A,D,E", minerals: "Ca" } },
      headers: headers

    assert_response :forbidden
  end

  test "non-admin user should not allow to update feed" do
    guest = users(:guest)
    jwt, _payload = Warden::JWTAuth::UserEncoder.new.call(guest, :user, nil)
    headers = {
      "Authorization" => "Bearer #{jwt}"
    }

    patch api_v1_feed_url(@feed1),
          params: { feed: { name: "New Feed" } },
          headers: headers

    assert_response :forbidden
  end

  private

  # Helper for authorization headers
  def auth_headers
    @auth_headers || {}
  end
end
