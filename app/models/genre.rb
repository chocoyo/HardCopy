class Genre < ApplicationRecord
  has_many :movies
  validates :title, presence: true, length: { minimum: 2 }
end
