class CreateArticleAuthors < ActiveRecord::Migration[6.0]
  def change
    create_table :article_authors do |t|
      t.belongs_to :author, null: false, foreign_key: true
      t.belongs_to :article, null: false, foreign_key: true

      t.timestamps
    end
  end
end
