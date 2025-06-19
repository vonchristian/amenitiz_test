FactoryBot.define do
  factory :percent_discount_rule, class: "PromoRules::PercentDiscountRule" do
    min_quantity { 1 }
    discount_percent { 9.99 }
  end
end
