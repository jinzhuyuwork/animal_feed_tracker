require "test_helper"

class AnimalTest < ActiveSupport::TestCase
  test "valid animal" do
    animal = animals(:one)
    assert animal.valid?
  end

  test "animal name is required" do
    animal = animals(:one)
    animal.name = nil
    assert_equal(false, animal.valid?)
  end
end
