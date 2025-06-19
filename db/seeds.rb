# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


green_tea = Product.find_or_create_by!(name: 'Green Tea', code: 'GR1')
green_tea_price = Price.create!(product: green_tea, amount_cents: 311, amount_currency: 'GBP', active: true)
strawberry = Product.find_or_create_by!(name: 'Strawberry', code: 'SR1')
strawberry_price = Price.create!(product: strawberry, amount_cents: 500, amount_currency: 'GBP', active: true)
bulk_discount_strawberry = PromoRules::BulkDiscountRule.find_or_create_by!(min_quantity: 3, discount_price_cents: 450, discount_price_currency: 'GBP')
Promotion.find_or_create_by!(code: 'GR1_PROMO', name: 'Green Tea Promotion', rule_type: 'PromoRules::BuyOneGetOneRule', product: green_tea, active: true)
Promotion.find_or_create_by!(code: 'SR1_PROMO', name: 'Strawberry Promotion', rule: bulk_discount_strawberry, product: strawberry, active: true)
