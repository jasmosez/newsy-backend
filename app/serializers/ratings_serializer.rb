class RatingsSerializer < ActiveModel::Serializer
  attributes :id, :likeability, :integrity
end
