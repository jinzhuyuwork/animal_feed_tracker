require "test_helper"

class AnimalTest < ActiveSupport::TestCase
  test "valid animal" do
    animal = animals(:one)
    assert animal.valid?
  end
end
