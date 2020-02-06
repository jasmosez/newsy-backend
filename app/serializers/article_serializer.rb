class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :urlToImage, :publishedAt

end
