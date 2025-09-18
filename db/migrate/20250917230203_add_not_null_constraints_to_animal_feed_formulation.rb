class AddNotNullConstraintsToAnimalFeedFormulation < ActiveRecord::Migration[8.0]
  def change
    # Make animal name NOT NULL
    change_column_null :animals, :name, false

    # Make feed name NOT NULL
    change_column_null :feeds, :name, false

    # Make formulation quantity NOT NULL
    change_column_default :formulations, :quantity, 0
    change_column_null :formulations, :quantity, false
  end
end
