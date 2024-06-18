class User < ApplicationRecord
  include Recommendation

  validates :name, presence: true

  has_many :liked_movies, dependent: :destroy
  has_many :movies, through: :liked_movies
  set_association :movies

end
