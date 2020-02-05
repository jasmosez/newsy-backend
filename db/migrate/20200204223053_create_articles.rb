class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.string :title
      t.belongs_to :publication, null: false, foreign_key: true
      t.string :description
      t.string :urlToImage
      t.string :publishedAt

      t.timestamps
    end
  end
end
