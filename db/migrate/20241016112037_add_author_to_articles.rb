class AddAuthorToArticles < ActiveRecord::Migration[7.2]
  def change
    add_column :articles, :author, :string
  end
end
