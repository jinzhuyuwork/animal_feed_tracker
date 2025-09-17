require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "valid admin user" do
    admin = users(:admin)
    assert admin.valid?
    assert admin.admin?
  end

  test "valid guest user" do
    guest = users(:guest)
    assert guest.valid?
    assert_equal(false, guest.admin?)
  end
end
