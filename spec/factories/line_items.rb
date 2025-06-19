FactoryBot.define do
  factory :line_item do
    cart { nil }
    product { nil }
    unit_cost_cents { 0 }
    total_cost_cents { 0 }
    discount_cost_cents { 0 }
    quantity { 1 }
    unit_cost_currency { "USD" }
    total_cost_currency { "USD" }
    discount_cost_currency { "USD" }
  end
end
