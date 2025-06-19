FactoryBot.define do
  factory :price do
    association :product
    amount_cents { 1000 } # Default to $10.00
    amount_currency { "USD" }
    active { true }

    trait :inactive do
      active { false }
    end
  end
end
