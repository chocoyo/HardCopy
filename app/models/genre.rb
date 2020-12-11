class Genre < ApplicationRecord
  has_many :movies, dependent: :restrict_with_exception
  validates :title, presence: true, length: { minimum: 2 }
end
