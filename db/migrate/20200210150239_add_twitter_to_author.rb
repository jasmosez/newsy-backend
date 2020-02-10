class AddTwitterToAuthor < ActiveRecord::Migration[6.0]
  def change
    add_column :authors, :twitter, :string
  end
end
