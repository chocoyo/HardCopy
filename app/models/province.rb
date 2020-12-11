class Province < ApplicationRecord
  has_many :users, dependent: :restrict_with_exception

  validates :name, presence: true
  validates :PST, presence: true, numericality: { only_integer: true }
  validates :HST, presence: true, numericality: { only_integer: true }
end
