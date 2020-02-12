class RatingsSerializer < ActiveModel::Serializer
  attributes :id, :likeability, :integrity, :author_id, :user_id
end
