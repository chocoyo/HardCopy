class Gst < ApplicationRecord
  validates :rate, presence: true, numericality: true
end
