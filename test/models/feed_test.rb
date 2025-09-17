require "test_helper"

class FeedTest < ActiveSupport::TestCase
  test "valid feed" do
    feed = feeds(:one)
    assert feed.valid?
  end
end
