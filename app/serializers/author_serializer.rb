class AuthorSerializer < ActiveModel::Serializer
  attributes :id, :name, :image, :article_count
end

class ShowAuthorSerializer < AuthorSerializer
  attributes :articles
end