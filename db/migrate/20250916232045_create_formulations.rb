class CreateFormulations < ActiveRecord::Migration[8.0]
  def change
    create_table :formulations do |t|
      t.references :animal, null: false, foreign_key: true
      t.references :feed, null: false, foreign_key: true
      t.decimal :quantity

      t.timestamps
    end
  end
end
