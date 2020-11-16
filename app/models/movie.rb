class Movie < ApplicationRecord
  has_one :genres
  has_one_attached :image
end
