class AddBookToArticles < ActiveRecord::Migration[5.2]
  def change
    add_reference :articles, :book, foreign_key: true
  end
end
