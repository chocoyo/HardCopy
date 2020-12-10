class Order < ApplicationRecord
  validates :total, presence: true
end
