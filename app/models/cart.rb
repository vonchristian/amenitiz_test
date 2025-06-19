class Cart < ApplicationRecord
  monetize :total_cost_cents_cents, with_model_currency: :amount_currency
end
