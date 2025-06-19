# frozen_string_literal: true

module PromoRules
  class BulkDiscountRule < ApplicationRecord
    # This class represents a promotion that applies a discount price
    # when the quantity purchased meets or exceeds `min_quantity`.

    monetize :discount_price_cents, with_model_currency: :discount_price_currency

    def apply(promotion:, items:)
      items.map do |item|
        OpenStruct.new(
          line_item: item,
          price: set_price(item),
          quantity: item.quantity
        )
      end
    end

    private

    def set_price(item)
      eligible?(item) ? discount_price : item.unit_price
    end

    def eligible?(item)
      item.quantity >= min_quantity
    end
  end
end
