class AuthorSerializer < ActiveModel::Serializer
  attributes :id, :name, :image, :article_count
end

class ShowAuthorSerializer < ActiveModel::Serializer
  attributes :id, :name, :image, :articles
end