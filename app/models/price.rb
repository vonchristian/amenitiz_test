class Price < ApplicationRecord
  belongs_to :product

  validates :amount_cents, presence: true
  validates :amount_currency, presence: true

  monetize :amount_cents, with_model_currency: :amount_currency
end
