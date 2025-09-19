class AddCategoryToFeeds < ActiveRecord::Migration[8.0]
  def change
    add_column :feeds, :category, :string, default: "feed"
  end
end
