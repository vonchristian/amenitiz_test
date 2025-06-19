class Cart < ApplicationRecord
  monetize :total_cost_cents, with_model_currency: :amount_currency

  has_many :line_items, dependent: :destroy
end
