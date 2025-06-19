class Product < ApplicationRecord
  validates :name, presence: true
  validates :code, presence: true, uniqueness: true

  has_many :prices, dependent: :destroy
  has_many :promotions, dependent: :destroy
  has_one :active_price, -> { where(active: true) }, class_name: "Price"
  has_one :active_promotion, -> { where(active: true) }, class_name: "Promotion"
end
