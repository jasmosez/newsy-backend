class User < ApplicationRecord
  has_many :ratings
  has_many :authors, through: :ratings
end
