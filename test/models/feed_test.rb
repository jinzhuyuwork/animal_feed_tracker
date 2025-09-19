require "test_helper"

class FeedTest < ActiveSupport::TestCase
  test "valid feed" do
    feed = feeds(:one)
    assert feed.valid?
  end

  test "feed name is required" do
    feed = feeds(:one)
    feed.name = nil
    assert_equal(false, feed.valid?)
  end

  test "feed category is required" do
    feed = feeds(:one)
    feed.category = nil
    assert_equal(false, feed.valid?)
  end
end
