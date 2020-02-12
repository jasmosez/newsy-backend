class User < ApplicationRecord
  has_many :ratings
  has_many :authors, through: :ratings

  validates :username, uniqueness: true

  has_secure_password
end

