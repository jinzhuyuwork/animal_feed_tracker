class CreateFeeds < ActiveRecord::Migration[8.0]
  def change
    create_table :feeds do |t|
      t.string :name
      t.decimal :protein
      t.decimal :fat
      t.decimal :fiber
      t.text :vitamins
      t.text :minerals

      t.timestamps
    end
  end
end
