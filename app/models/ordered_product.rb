class OrderedProduct < ApplicationRecord
  belongs_to :order

  validates :quantity, presence: true, numericality: { only_integer: true }
  validates :price_of_item, presence: true
end
