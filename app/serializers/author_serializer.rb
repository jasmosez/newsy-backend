class AuthorSerializer < ActiveModel::Serializer
  attributes :id, :name, :image, :article_count, :twitter, :average_likeabiity, :average_integrity, :total_ratings
end

class ShowAuthorSerializer < AuthorSerializer
  attributes :articles, :ratings
end