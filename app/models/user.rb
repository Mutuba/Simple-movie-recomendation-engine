class User < ApplicationRecord
  include Recommendation

  validates :name, presence: true
  has_many :articles, dependent: :destroy
  has_many :liked_movies, dependent: :destroy
  has_many :movies, through: :liked_movies
  set_association :movies

  enum status: {
    draft: 0,
    submitted: 1,
    rejected: 3,
    accepted: 4,
    canceled: 5,
    published: 6
  }

end
