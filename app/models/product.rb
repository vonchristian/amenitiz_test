class Product < ApplicationRecord
  validates :name, presence: true
  validates :code, presence: true, uniqueness: true

  has_many :prices, dependent: :destroy
end
