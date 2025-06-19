# frozen_string_literal: true

module PromoRules
  class PercentDiscountRule < ApplicationRecord
    # Applies a percentage discount to unit price when quantity meets min_quantity (if specified)
    # When min_quantity is not specified, it applies to all items

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
      eligible?(item) ? discounted_price(item.unit_price) : item.unit_price
    end

    def eligible?(item)
      return true unless min_quantity
      item.quantity >= min_quantity
    end

    def discounted_price(price)
      discount = discount_percent.to_d / 100
      price * (1 - discount)
    end
  end
end
