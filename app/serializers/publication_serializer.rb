class PublicationSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :url, :category
end
