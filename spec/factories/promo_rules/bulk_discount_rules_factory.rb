FactoryBot.define do
  factory :bulk_discount_rule, class: "PromoRules::BulkDiscountRule" do
    min_quantity { 1 }
    discount_price_cents { 1 }
    discount_price_currency { "USD" }
  end
end
