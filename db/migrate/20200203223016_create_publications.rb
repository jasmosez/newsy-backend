class CreatePublications < ActiveRecord::Migration[6.0]
  def change
    create_table :publications do |t|
      t.string :apiId
      t.string :name
      t.string :description
      t.string :url
      t.string :category

      t.timestamps
    end
  end
end
