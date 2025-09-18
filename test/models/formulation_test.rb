require "test_helper"

class FormulationTest < ActiveSupport::TestCase
  test "valid formulation" do
    formulation = formulations(:one)
    assert formulation.valid?
  end

  test "formulation quantity is required" do
    formulation = formulations(:one)
    formulation.quantity = nil
    assert_equal(false, formulation.valid?)
  end
end
