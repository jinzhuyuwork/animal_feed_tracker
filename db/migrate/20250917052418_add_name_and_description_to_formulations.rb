class AddNameAndDescriptionToFormulations < ActiveRecord::Migration[8.0]
  def change
    add_column :formulations, :name, :string, null: false, default: ""
    add_column :formulations, :description, :text
  end
end
