class AuthorSerializer < ActiveModel::Serializer
  attributes :id, :name, :image, :articles
end
