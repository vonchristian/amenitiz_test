class LineItem < ApplicationRecord
  monetize :unit_cost_cents, with_model_currency: :amount_currency
  monetize :total_cost_cents, with_model_currency: :amount_currency
  monetize :discount_cost_cents, with_model_currency: :amount_currency

  belongs_to :cart
  belongs_to :product
end
