class CreateRatings < ActiveRecord::Migration[6.0]
  def change
    create_table :ratings do |t|
      t.belongs_to :author, null: false, foreign_key: true
      t.belongs_to :user, null: false, foreign_key: true
      t.float :integrity
      t.float :likeability

      t.timestamps
    end
  end
end
