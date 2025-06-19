FactoryBot.define do
  factory :cart do
    total_cost_cents { 0 }
    total_cost_currency { "USD" }
  end
end
