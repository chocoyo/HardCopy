class Movie < ApplicationRecord
  belongs_to :genre
  has_one_attached :image

  validates :title, presence: true
  validates :price, presence: true
end
