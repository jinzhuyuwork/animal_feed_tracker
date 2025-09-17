require "test_helper"

class JwtDenylistTest < ActiveSupport::TestCase
  test "valid JwtDenylist" do
    denylist = jwt_denylists(:one)
    assert denylist.valid?
  end
end
