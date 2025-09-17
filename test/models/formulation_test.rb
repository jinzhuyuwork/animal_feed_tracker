require "test_helper"

class FormulationTest < ActiveSupport::TestCase
  test "valid formulation" do
    formulation = formulations(:one)
    assert formulation.valid?
  end
end
